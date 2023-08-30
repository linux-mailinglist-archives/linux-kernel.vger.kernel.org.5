Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378FD78DE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbjH3TBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbjH3MIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:08:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC7F1B0;
        Wed, 30 Aug 2023 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NbJWoCOx2Ft9OMUClG80nlQLFeZZUsdNl4uLp0OM5Og=; b=ZjtW3pIgr7xhXH5l8qea/OAzAu
        XBG7uMdCv4+47puQN+F1oPJh+WjiVusDa5RJRYUjlh9BAhzqF4iC0DqjQrhrrAKH5p2R0DGOxTq+E
        hjrwQzZYlgtQ/Eq1eVo7R9nykn34zitpgxU9/fA8t/XIaz2lOEr5CBEu2htNZ3YCneU65eF/UBYVG
        MWo1H1gwvi+bNpaF3czbOvQ238xDmloZiI3ladTsgt0VcXsUfbHnqa7hsYhljPEmDGmqCa9CMZHi8
        oTdZCdCj/LwKeivjqfPZK7SUbLu6FLEHL1xVhlU0rCUIXliUWttXKxZNuSrI83W6+Bm2yDJzpqIZY
        PB8jRBKg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbJzv-00Ced0-EY; Wed, 30 Aug 2023 12:08:35 +0000
Date:   Wed, 30 Aug 2023 13:08:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] rcu: Dump vmalloc memory info safely
Message-ID: <ZO8xQ+7BQpA/u+Cg@casper.infradead.org>
References: <20230830110402.386898-1-joel@joelfernandes.org>
 <20230830110402.386898-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830110402.386898-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:04:00AM +0000, Joel Fernandes (Google) wrote:
> From: Zqiang <qiang.zhang1211@gmail.com>
> 
> Currently, for double invoke call_rcu(), will dump rcu_head objects
> memory info, if the objects is not allocated from the slab allocator,
> the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> need to be held, since the call_rcu() can be invoked in interrupt context,
> therefore, there is a possibility of spinlock deadlock scenarios.
> 
> And in Preempt-RT kernel, the rcutorture test also trigger the following
> lockdep warning:
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
> preempt_count: 1, expected: 0
> RCU nest depth: 1, expected: 1
> 3 locks held by swapper/0/1:
>  #0: ffffffffb534ee80 (fullstop_mutex){+.+.}-{4:4}, at: torture_init_begin+0x24/0xa0
>  #1: ffffffffb5307940 (rcu_read_lock){....}-{1:3}, at: rcu_torture_init+0x1ec7/0x2370
>  #2: ffffffffb536af40 (vmap_area_lock){+.+.}-{3:3}, at: find_vmap_area+0x1f/0x70
> irq event stamp: 565512
> hardirqs last  enabled at (565511): [<ffffffffb379b138>] __call_rcu_common+0x218/0x940
> hardirqs last disabled at (565512): [<ffffffffb5804262>] rcu_torture_init+0x20b2/0x2370
> softirqs last  enabled at (399112): [<ffffffffb36b2586>] __local_bh_enable_ip+0x126/0x170
> softirqs last disabled at (399106): [<ffffffffb43fef59>] inet_register_protosw+0x9/0x1d0
> Preemption disabled at:
> [<ffffffffb58040c3>] rcu_torture_init+0x1f13/0x2370
> CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-rc4-rt2-yocto-preempt-rt+ #15
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x68/0xb0
>  dump_stack+0x14/0x20
>  __might_resched+0x1aa/0x280
>  ? __pfx_rcu_torture_err_cb+0x10/0x10
>  rt_spin_lock+0x53/0x130
>  ? find_vmap_area+0x1f/0x70
>  find_vmap_area+0x1f/0x70
>  vmalloc_dump_obj+0x20/0x60
>  mem_dump_obj+0x22/0x90
>  __call_rcu_common+0x5bf/0x940
>  ? debug_smp_processor_id+0x1b/0x30
>  call_rcu_hurry+0x14/0x20
>  rcu_torture_init+0x1f82/0x2370
>  ? __pfx_rcu_torture_leak_cb+0x10/0x10
>  ? __pfx_rcu_torture_leak_cb+0x10/0x10
>  ? __pfx_rcu_torture_init+0x10/0x10
>  do_one_initcall+0x6c/0x300
>  ? debug_smp_processor_id+0x1b/0x30
>  kernel_init_freeable+0x2b9/0x540
>  ? __pfx_kernel_init+0x10/0x10
>  kernel_init+0x1f/0x150
>  ret_from_fork+0x40/0x50
>  ? __pfx_kernel_init+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> 
> The previous patch fixes this by using the deadlock-safe best-effort
> version of find_vm_area. However, in case of failure print the fact that
> the pointer was a vmalloc pointer so that we print at least something.
> 
> Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: rcu@vger.kernel.org
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
