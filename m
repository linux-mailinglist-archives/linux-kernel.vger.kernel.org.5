Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668D4783047
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjHUSdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHUSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:33:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E2B33D01
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vu2sn8uiKNBiL4iK4hRUUcDFbAOWrQuXONejz0HgL1U=; b=ZhGcng4lc98Mb2e5bxCEjqTnSQ
        NJWcQKzVq40aIFGRYmpexG7JV8fbVxItxsdjUKsnVCKNraNUpW2cwpFwMJ4eHawj/+yPRrWMtTDEe
        dB8lMBtgmrp5JJ5uXkiuAMu+j1xdgBWmRfnh6G+vubq760m0MJbUas19z3OfTuSKpe1gsPC8NzQWk
        PveB3erh+Vhnk3zxQ7DwgSyWRBBaX9l94gmJA6DL2ra+QgIoQthwPLRmK8lxC3eWIbSbAxzK/RveA
        VdvTBJliQ06Y/lri1W4z2+fi+9DfSgSA11XMV87/wKMS1C21Hy22i0J7gvwRM/OD51kBEJlK++RQL
        8MoymHuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY9iD-00Blax-GK; Mon, 21 Aug 2023 18:33:13 +0000
Date:   Mon, 21 Aug 2023 19:33:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, wangkefeng.wang@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: memory-failure: use rcu lock instead of
 tasklist_lock when collect_procs()
Message-ID: <ZOOt6S+I9ywyNQjP@casper.infradead.org>
References: <20230821091312.2034844-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821091312.2034844-1-tongtiangen@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 05:13:12PM +0800, Tong Tiangen wrote:
> We found a softlock issue in our test, analyzed the logs, and found that
> the relevant CPU call trace as follows:
> 
> CPU0:
>   _do_fork
>     -> copy_process()
>       -> write_lock_irq(&tasklist_lock)  //Disable irq,waiting for
>       					 //tasklist_lock
> 
> CPU1:
>   wp_page_copy()
>     ->pte_offset_map_lock()
>       -> spin_lock(&page->ptl);        //Hold page->ptl
>     -> ptep_clear_flush()
>       -> flush_tlb_others() ...
>         -> smp_call_function_many()
>           -> arch_send_call_function_ipi_mask()
>             -> csd_lock_wait()         //Waiting for other CPUs respond
> 	                               //IPI
> 
> CPU2:
>   collect_procs_anon()
>     -> read_lock(&tasklist_lock)       //Hold tasklist_lock
>       ->for_each_process(tsk)
>         -> page_mapped_in_vma()
>           -> page_vma_mapped_walk()
> 	    -> map_pte()
>               ->spin_lock(&page->ptl)  //Waiting for page->ptl
> 
> We can see that CPU1 waiting for CPU0 respond IPI，CPU0 waiting for CPU2
> unlock tasklist_lock, CPU2 waiting for CPU1 unlock page->ptl. As a result,
> softlockup is triggered.
> 
> For collect_procs_anon(), we will not modify the tasklist, but only perform
> read traversal. Therefore, we can use rcu lock instead of spin lock
> tasklist_lock, from this, we can break the softlock chain above.

The only thing that's giving me pause is that there's no discussion
about why this is safe.  "We're not modifying it" isn't really enough
to justify going from read_lock() to rcu_read_lock().  When you take a
normal read_lock(), writers are not permitted and so you see an atomic
snapshot of the list.  With rcu_read_lock() you can see inconsistencies.
For example, if new tasks can be added to the tasklist, they may not
be seen by an iteration.  Is this OK?  Tasks may be removed from the
tasklist after they have been seen by the iteration.  Is this OK?

As I understand the list RCU code, it guarantees that all tasks which
were on the list before rcu_read_lock() and remain on the list after
rcu_read_unlock() will be seen by a list iteration, while tasks which
are added or removed during that time may or may not be seen.
