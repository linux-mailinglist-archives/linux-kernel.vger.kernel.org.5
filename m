Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67F37822AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjHUEOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjHUEOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:14:44 -0400
Received: from out-45.mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DBCF1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:14:20 -0700 (PDT)
Date:   Mon, 21 Aug 2023 13:13:25 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692591214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4PR/ic+ISnCtHElzBiwMiRGltFX1jSGQK0mIwvAZVY=;
        b=VBvLZ64sQgXGZBx4/D+xkYwspeP4dT2AZpremOyyV5UIP5gfu7zOt/RTwKRTXErQWzxEVk
        GELdgKhK4n9Q22Hcgr1vR2b5EMO1hT0MyHwClbotj0aK3jb3/fjYxAUIQLNB8CpCCQjJqP
        cL3+nocPhHedYyvNluNXE+94LGl8ON4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, wangkefeng.wang@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory-failure: use rcu lock instead of
 tasklist_lock when collect_procs()
Message-ID: <20230821041325.GA2341515@ik1-406-35019.vs.sakura.ne.jp>
References: <20230821022534.1381092-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821022534.1381092-1-tongtiangen@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:25:34AM +0800, Tong Tiangen wrote:
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
> 
> The same logic can also be applied to:
>  - collect_procs_file()
>  - collect_procs_fsdax()
>  - collect_procs_ksm()
>  - find_early_kill_thread()
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> ---
> Changes since RFC[1]:
>  - 1. According to Naoya's suggestion, modify the tasklist_lock in the
>       comment about locking order in mm/filemap.c.
>  - 2. According to Kefeng's suggestion, optimize the implementation of
>       find_early_kill_thread() without functional changes.
>  - 3. Modify the title description.
> 
> [1] https://lore.kernel.org/lkml/20230815130154.1100779-1-tongtiangen@huawei.com/
