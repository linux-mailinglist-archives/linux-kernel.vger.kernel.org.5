Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942387943BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbjIFTTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244181AbjIFTS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:18:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596621BDD;
        Wed,  6 Sep 2023 12:18:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26f7f71b9a7so137847a91.0;
        Wed, 06 Sep 2023 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694027927; x=1694632727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ld+kZKXpmR6Fg6T3EwuKq7UToW9GAZ6Oid2qQccKGn4=;
        b=c9R4j171TidhoiDVUvDUWBbKiHfN4FIk4JTmjXLYVfe2L2D8brDHi1E78AarTJiv9I
         2tcZ0YhH7Jrgp8XQpfqty31F2FvxPYx/uKNchf30fUJTIA50oE3CbzaHf2THA5qZPIhr
         mst5vRx20GD5reF6xvzwyvHGk8wKQdRAO9Of3hLNS7LMXjjWAU9wW0laEcKD0WSsGVnF
         5Pulywlbz9bHsI85dKmwMQjgNrqjiMyAlyka/DYp0lsGDCM/pfjETGmMR3knDtBkxKT8
         V1BsTDYYlBfLM+dRig2fgn3NwNkW7A/4inBE6JHeXlCRXJdpyuFPrDejbWcclO9S0mTY
         ueSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694027927; x=1694632727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ld+kZKXpmR6Fg6T3EwuKq7UToW9GAZ6Oid2qQccKGn4=;
        b=MUkXK5apMjcIecHlJNSsyugdvbEg6uO8Qnp8STvo4I4+a/dZCYW8ftjdGi3PWFSbvw
         pjXc51lUu8D20kD0ZMBvKocRBpigiGVgkqnJc52U5KSqv8Okbp9NfELp+aiDzHNJ7Ket
         B1f1IUyRXTTAqVlrRdyuZjXdoxMFpk3/uvXDY1J7iwQGk7ONIgKUD54kQavvL88IZYUN
         tpzCNcF2OeNOjhI06Tx5ca70OWZuXeIovNuNDnqqLzFO3jWCYIV01izT056sSRXMfyy9
         f+l7cGgWxaaIGqaQMJ2JFqLj2mZPscgdxzqCSPGBUInfdYzhdevFVcETclre3fWLEj2Z
         oplw==
X-Gm-Message-State: AOJu0YxrlExSFIAPZ2q8PJ4weXExrWUuU//+jAhrwqkvzhBhghgErCof
        M9B+7/H7YFVX3pDKbFQ93VBxsTGfl5XN2Oh2dgs=
X-Google-Smtp-Source: AGHT+IFCSbdVUxgWJzLrxfSRiUW/eGGPUL3k2TslBDvsE7l8uuX8RUCbiQ6bvVk/sJCtoLIKnw8hmybmgwnySCP/7jY=
X-Received: by 2002:a17:90a:be16:b0:268:29cf:3231 with SMTP id
 a22-20020a17090abe1600b0026829cf3231mr15346826pjs.3.1694027926627; Wed, 06
 Sep 2023 12:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230904180806.1002832-1-joel@joelfernandes.org>
 <20230904180806.1002832-2-joel@joelfernandes.org> <9e329429-73a5-4926-af4f-edcf9e547101@lucifer.local>
 <20230905114841.GB3881391@google.com>
In-Reply-To: <20230905114841.GB3881391@google.com>
From:   Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Wed, 6 Sep 2023 20:18:35 +0100
Message-ID: <CAA5enKafgfqNE0DWg7tcd-iNGeE0Aud5VcmmWzdguK9Psq0uhQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rcu: Dump vmalloc memory info safely
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        rcu@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        stable@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sept 2023 at 12:48, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Sep 05, 2023 at 08:00:44AM +0100, Lorenzo Stoakes wrote:
> > On Mon, Sep 04, 2023 at 06:08:05PM +0000, Joel Fernandes (Google) wrote:
> > > From: Zqiang <qiang.zhang1211@gmail.com>
> > >
> > > Currently, for double invoke call_rcu(), will dump rcu_head objects
> > > memory info, if the objects is not allocated from the slab allocator,
> > > the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> > > need to be held, since the call_rcu() can be invoked in interrupt context,
> > > therefore, there is a possibility of spinlock deadlock scenarios.
> > >
> > > And in Preempt-RT kernel, the rcutorture test also trigger the following
> > > lockdep warning:
> > >
> > > BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> > > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
> > > preempt_count: 1, expected: 0
> > > RCU nest depth: 1, expected: 1
> > > 3 locks held by swapper/0/1:
> > >  #0: ffffffffb534ee80 (fullstop_mutex){+.+.}-{4:4}, at: torture_init_begin+0x24/0xa0
> > >  #1: ffffffffb5307940 (rcu_read_lock){....}-{1:3}, at: rcu_torture_init+0x1ec7/0x2370
> > >  #2: ffffffffb536af40 (vmap_area_lock){+.+.}-{3:3}, at: find_vmap_area+0x1f/0x70
> > > irq event stamp: 565512
> > > hardirqs last  enabled at (565511): [<ffffffffb379b138>] __call_rcu_common+0x218/0x940
> > > hardirqs last disabled at (565512): [<ffffffffb5804262>] rcu_torture_init+0x20b2/0x2370
> > > softirqs last  enabled at (399112): [<ffffffffb36b2586>] __local_bh_enable_ip+0x126/0x170
> > > softirqs last disabled at (399106): [<ffffffffb43fef59>] inet_register_protosw+0x9/0x1d0
> > > Preemption disabled at:
> > > [<ffffffffb58040c3>] rcu_torture_init+0x1f13/0x2370
> > > CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-rc4-rt2-yocto-preempt-rt+ #15
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x68/0xb0
> > >  dump_stack+0x14/0x20
> > >  __might_resched+0x1aa/0x280
> > >  ? __pfx_rcu_torture_err_cb+0x10/0x10
> > >  rt_spin_lock+0x53/0x130
> > >  ? find_vmap_area+0x1f/0x70
> > >  find_vmap_area+0x1f/0x70
> > >  vmalloc_dump_obj+0x20/0x60
> > >  mem_dump_obj+0x22/0x90
> > >  __call_rcu_common+0x5bf/0x940
> > >  ? debug_smp_processor_id+0x1b/0x30
> > >  call_rcu_hurry+0x14/0x20
> > >  rcu_torture_init+0x1f82/0x2370
> > >  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> > >  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> > >  ? __pfx_rcu_torture_init+0x10/0x10
> > >  do_one_initcall+0x6c/0x300
> > >  ? debug_smp_processor_id+0x1b/0x30
> > >  kernel_init_freeable+0x2b9/0x540
> > >  ? __pfx_kernel_init+0x10/0x10
> > >  kernel_init+0x1f/0x150
> > >  ret_from_fork+0x40/0x50
> > >  ? __pfx_kernel_init+0x10/0x10
> > >  ret_from_fork_asm+0x1b/0x30
> > >  </TASK>
> > >
> > > The previous patch fixes this by using the deadlock-safe best-effort
> > > version of find_vm_area. However, in case of failure print the fact that
> > > the pointer was a vmalloc pointer so that we print at least something.
> > >
> > > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: rcu@vger.kernel.org
> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  mm/util.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/util.c b/mm/util.c
> > > index dd12b9531ac4..406634f26918 100644
> > > --- a/mm/util.c
> > > +++ b/mm/util.c
> > > @@ -1071,7 +1071,9 @@ void mem_dump_obj(void *object)
> > >     if (vmalloc_dump_obj(object))
> > >             return;
> > >
> > > -   if (virt_addr_valid(object))
> > > +   if (is_vmalloc_addr(object))
> > > +           type = "vmalloc memory";
> > > +   else if (virt_addr_valid(object))
> > >             type = "non-slab/vmalloc memory";
> >
> > I think you should update this to say non-slab/non-vmalloc memory (as much
> > as that description sucks!) as this phrasing in the past meant to say
> > 'non-slab or vmalloc memory' (already confusing phrasing) so better to be
> > clear.
>
> True, though the issue you mentioned it is in existing code, a respin of this
> patch could update it to say non-vmalloc. Good point, thanks for reviewing!

No it's not, you're changing the meaning, because you changed the code
that determines the output...

This has been merged now despite my outstanding comments (!) so I
guess I'll have to send a follow up patch to address this.

>
>  - Joel
>



--
Lorenzo Stoakes
https://ljs.io
