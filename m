Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C460B7820FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 02:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjHUA4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 20:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjHUA4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 20:56:23 -0400
Received: from out-52.mta0.migadu.com (out-52.mta0.migadu.com [IPv6:2001:41d0:1004:224b::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85FC99
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 17:56:20 -0700 (PDT)
Date:   Mon, 21 Aug 2023 09:56:10 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692579378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0dAVu3NI7reNwaR7YvBo1ybvgUdUrttQdk/1fRPvXg=;
        b=u19KFZOsaVDxLUbw9dZ3nIkZjskzOhrluzU4yfjIaAHEc6gzaJeXvkfPWqHDReQS3/mtX5
        bfdy6Mo9nCaxf+qYMElspVgWCMlsuhCbD/JKo5fFvy7uKA6H3CKaJrKdzWu0b/AnaSqfNm
        9r6eCflkz0POvXvgfIP89KTkSvX55yo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [RFC PATCH -next] mm: fix softlockup by replacing tasklist_lock
 with RCU in for_each_process()
Message-ID: <20230821005610.GA2251898@ik1-406-35019.vs.sakura.ne.jp>
References: <20230815130154.1100779-1-tongtiangen@huawei.com>
 <20230817053630.GA461822@ik1-406-35019.vs.sakura.ne.jp>
 <4b91e2c7-cd54-d5e9-472e-6ece369b0651@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b91e2c7-cd54-d5e9-472e-6ece369b0651@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 05:26:34PM +0800, Tong Tiangen wrote:
> 
> 
> 在 2023/8/17 13:36, Naoya Horiguchi 写道:
> > On Tue, Aug 15, 2023 at 09:01:54PM +0800, Tong Tiangen wrote:
> > > We found a softlock issue in our test, analyzed the logs, and found that
> > > the relevant CPU call trace as follows:
> > > 
> > > CPU0:
> > >    _do_fork
> > >      -> copy_process()
> > >        -> write_lock_irq(&tasklist_lock)  //Disable irq,waiting for
> > >        					 //tasklist_lock
> > > 
> > > CPU1:
> > >    wp_page_copy()
> > >      ->pte_offset_map_lock()
> > >        -> spin_lock(&page->ptl);        //Hold page->ptl
> > >      -> ptep_clear_flush()
> > >        -> flush_tlb_others() ...
> > >          -> smp_call_function_many()
> > >            -> arch_send_call_function_ipi_mask()
> > >              -> csd_lock_wait()         //Waiting for other CPUs respond
> > > 	                               //IPI
> > > 
> > > CPU2:
> > >    collect_procs_anon()
> > >      -> read_lock(&tasklist_lock)       //Hold tasklist_lock
> > >        ->for_each_process(tsk)
> > >          -> page_mapped_in_vma()
> > >            -> page_vma_mapped_walk()
> > > 	    -> map_pte()
> > >                ->spin_lock(&page->ptl)  //Waiting for page->ptl
> > > 
> > > We can see that CPU1 waiting for CPU0 respond IPI，CPU0 waiting for CPU2
> > > unlock tasklist_lock, CPU2 waiting for CPU1 unlock page->ptl. As a result,
> > > softlockup is triggered.
> > > 
> > > For collect_procs_anon(), we will not modify the tasklist, but only perform
> > > read traversal. Therefore, we can use rcu lock instead of spin lock
> > > tasklist_lock, from this, we can break the softlock chain above.
> > > 
> > > The same logic can also be applied to:
> > >   - collect_procs_file()
> > >   - collect_procs_fsdax()
> > >   - collect_procs_ksm()
> > >   - find_early_kill_thread()
> > > 
> > > Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> > 
> > Hello Tiangen, thank you for finding the issue.
> > mm/filemap.c mentions tasklist_lock in the comment about locking order,
> > 
> >    * ->i_mmap_rwsem
> >    *   ->tasklist_lock            (memory_failure, collect_procs_ao)
> > 
> > so you can update this together?
> > Otherwise looks good to me.
> > 
> > Thanks,
> > Naoya Horiguchi
> 
> Thank you for your reply. Since tasklist_lock is no longer used in
> collect_procs_xxx(), Should I delete these two comments in mm/filemap.c?

Yes, I think you should.

- Naoya Horiguchi
