Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B68797FA4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbjIHA0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbjIHA0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:26:33 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3531BD7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 17:26:27 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7926b7f8636so39497139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 17:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694132787; x=1694737587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVZN5vN8bRfWt9fXaRaMQ7INcbyUKWi7temjOgZW5Mk=;
        b=YLWL35y1Yh5HcyyrloFoTSDk57dkqiXMEmYi+VQY7J+NUFwoj+P7N/yEmM7Avamvtq
         O2ONTZjiTmLwiHbPPX2T0e3jU0D0Q2oluhHh8vW6Dtfb/MUxg2OVv7qiJS2JXLdGKJzu
         9sIIul9sQthqwN5PXDVGLT/wazBQ+DqwbcEJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694132787; x=1694737587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVZN5vN8bRfWt9fXaRaMQ7INcbyUKWi7temjOgZW5Mk=;
        b=w66LK+uKxzAR9H59FXgBD9sG++ejs0U6ep7iZVsH3IF+ByF3GB7OOFZkAXd02lX8I5
         nyDKI9+IjX2Zei4qQm+Fr6dsmFfR1vRnkZWKV9TKna2F6rLEUb14LXqf9a3qcHLn0+mw
         cTZpDorqcLhBdQ8aII2ZBY89p5NIOzSjsDKoQjRvkdlTZEnjiMgqYKpaIAC41DRXUQD0
         NObYKIiq9VnMmFc7+0asYScMdYLfEwmNOcaDFH8dAMG2Somn25TMZylLWqL3roO2f4VJ
         KWPguOsYXOS/XPZkYl8xTYzC1zAB9ahj3rVGx1mlI6zed8PiotQqPoat31ZjwJ+gkiIs
         yYJg==
X-Gm-Message-State: AOJu0YzBHI9oywAvGOKLDPTN0F8E4pPn+dnEEqg+Qn3Fszj1WZjeHjfn
        yzDsDe5RcNPp+Pm+khK/I5nphQ==
X-Google-Smtp-Source: AGHT+IFRVFtwWrfcVc0Z7SXHe2h5aZvauo+UgAqJm05OoRDsjuegTeHmvw/xRiZ8zZNk0DTKgvpQMw==
X-Received: by 2002:a5d:8048:0:b0:783:498c:9cf0 with SMTP id b8-20020a5d8048000000b00783498c9cf0mr1256406ior.4.1694132787021;
        Thu, 07 Sep 2023 17:26:27 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id x5-20020a6bda05000000b0076373f90e46sm168208iob.33.2023.09.07.17.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 17:26:26 -0700 (PDT)
Date:   Fri, 8 Sep 2023 00:26:26 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        rcu@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        stable@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] rcu: Dump vmalloc memory info safely
Message-ID: <20230908002626.GB4088026@google.com>
References: <20230904180806.1002832-1-joel@joelfernandes.org>
 <20230904180806.1002832-2-joel@joelfernandes.org>
 <9e329429-73a5-4926-af4f-edcf9e547101@lucifer.local>
 <20230905114841.GB3881391@google.com>
 <CAA5enKafgfqNE0DWg7tcd-iNGeE0Aud5VcmmWzdguK9Psq0uhQ@mail.gmail.com>
 <737d399d-c83a-3e66-ceb7-4ae7ba4acfb4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <737d399d-c83a-3e66-ceb7-4ae7ba4acfb4@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 09:10:38AM +0200, Vlastimil Babka wrote:
> On 9/6/23 21:18, Lorenzo Stoakes wrote:
> > On Tue, 5 Sept 2023 at 12:48, Joel Fernandes <joel@joelfernandes.org> wrote:
> >>
> >> On Tue, Sep 05, 2023 at 08:00:44AM +0100, Lorenzo Stoakes wrote:
> >> > On Mon, Sep 04, 2023 at 06:08:05PM +0000, Joel Fernandes (Google) wrote:
> >> > > From: Zqiang <qiang.zhang1211@gmail.com>
> >> > >
> >> > > Currently, for double invoke call_rcu(), will dump rcu_head objects
> >> > > memory info, if the objects is not allocated from the slab allocator,
> >> > > the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> >> > > need to be held, since the call_rcu() can be invoked in interrupt context,
> >> > > therefore, there is a possibility of spinlock deadlock scenarios.
> >> > >
> >> > > And in Preempt-RT kernel, the rcutorture test also trigger the following
> >> > > lockdep warning:
> >> > >
> >> > > BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> >> > > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
> >> > > preempt_count: 1, expected: 0
> >> > > RCU nest depth: 1, expected: 1
> >> > > 3 locks held by swapper/0/1:
> >> > >  #0: ffffffffb534ee80 (fullstop_mutex){+.+.}-{4:4}, at: torture_init_begin+0x24/0xa0
> >> > >  #1: ffffffffb5307940 (rcu_read_lock){....}-{1:3}, at: rcu_torture_init+0x1ec7/0x2370
> >> > >  #2: ffffffffb536af40 (vmap_area_lock){+.+.}-{3:3}, at: find_vmap_area+0x1f/0x70
> >> > > irq event stamp: 565512
> >> > > hardirqs last  enabled at (565511): [<ffffffffb379b138>] __call_rcu_common+0x218/0x940
> >> > > hardirqs last disabled at (565512): [<ffffffffb5804262>] rcu_torture_init+0x20b2/0x2370
> >> > > softirqs last  enabled at (399112): [<ffffffffb36b2586>] __local_bh_enable_ip+0x126/0x170
> >> > > softirqs last disabled at (399106): [<ffffffffb43fef59>] inet_register_protosw+0x9/0x1d0
> >> > > Preemption disabled at:
> >> > > [<ffffffffb58040c3>] rcu_torture_init+0x1f13/0x2370
> >> > > CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-rc4-rt2-yocto-preempt-rt+ #15
> >> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> >> > > Call Trace:
> >> > >  <TASK>
> >> > >  dump_stack_lvl+0x68/0xb0
> >> > >  dump_stack+0x14/0x20
> >> > >  __might_resched+0x1aa/0x280
> >> > >  ? __pfx_rcu_torture_err_cb+0x10/0x10
> >> > >  rt_spin_lock+0x53/0x130
> >> > >  ? find_vmap_area+0x1f/0x70
> >> > >  find_vmap_area+0x1f/0x70
> >> > >  vmalloc_dump_obj+0x20/0x60
> >> > >  mem_dump_obj+0x22/0x90
> >> > >  __call_rcu_common+0x5bf/0x940
> >> > >  ? debug_smp_processor_id+0x1b/0x30
> >> > >  call_rcu_hurry+0x14/0x20
> >> > >  rcu_torture_init+0x1f82/0x2370
> >> > >  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> >> > >  ? __pfx_rcu_torture_leak_cb+0x10/0x10
> >> > >  ? __pfx_rcu_torture_init+0x10/0x10
> >> > >  do_one_initcall+0x6c/0x300
> >> > >  ? debug_smp_processor_id+0x1b/0x30
> >> > >  kernel_init_freeable+0x2b9/0x540
> >> > >  ? __pfx_kernel_init+0x10/0x10
> >> > >  kernel_init+0x1f/0x150
> >> > >  ret_from_fork+0x40/0x50
> >> > >  ? __pfx_kernel_init+0x10/0x10
> >> > >  ret_from_fork_asm+0x1b/0x30
> >> > >  </TASK>
> >> > >
> >> > > The previous patch fixes this by using the deadlock-safe best-effort
> >> > > version of find_vm_area. However, in case of failure print the fact that
> >> > > the pointer was a vmalloc pointer so that we print at least something.
> >> > >
> >> > > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> >> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> >> > > Cc: rcu@vger.kernel.org
> >> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> > > Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
> >> > > Cc: stable@vger.kernel.org
> >> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> >> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> > > ---
> >> > >  mm/util.c | 4 +++-
> >> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >> > >
> >> > > diff --git a/mm/util.c b/mm/util.c
> >> > > index dd12b9531ac4..406634f26918 100644
> >> > > --- a/mm/util.c
> >> > > +++ b/mm/util.c
> >> > > @@ -1071,7 +1071,9 @@ void mem_dump_obj(void *object)
> >> > >     if (vmalloc_dump_obj(object))
> >> > >             return;
> >> > >
> >> > > -   if (virt_addr_valid(object))
> >> > > +   if (is_vmalloc_addr(object))
> >> > > +           type = "vmalloc memory";
> >> > > +   else if (virt_addr_valid(object))
> >> > >             type = "non-slab/vmalloc memory";
> >> >
> >> > I think you should update this to say non-slab/non-vmalloc memory (as much
> >> > as that description sucks!) as this phrasing in the past meant to say
> >> > 'non-slab or vmalloc memory' (already confusing phrasing) so better to be
> >> > clear.
> >>
> >> True, though the issue you mentioned it is in existing code, a respin of this
> >> patch could update it to say non-vmalloc. Good point, thanks for reviewing!
> > 
> > No it's not, you're changing the meaning, because you changed the code
> > that determines the output...
> 
> I think it has always meant (but clearly it's not unambiguously worded) "not
> slab && not vmalloc", that is before and after this patch. Only in case
> patch 1 is applied and patch 2 not, can the output be wrong in that a
> vmalloc pointer will (in case of trylock fail) be classified as "not slab &&
> not vmalloc", but seems fine to me after patch 2.
> 
> I guess if we wanted, we could also rewrite it to be more like the kmem
> check in the beginning of mem_dump_obj(), so there would be:
> 
> if (is_vmalloc_addr(...)) {
>     vmalloc_dump_obj(...);
>     return;
> }
> 
> where vmalloc_dump_obj() itself would print at least "vmalloc memory" with
> no further details in case of trylock failure.
> 
> that assumes is_vmalloc_addr() is guaranteed to be true for all addresses
> that __find_vmap_area resolves, otherwise it could miss something compared
> to current code. Is it guaranteed?

It is guaranteed based on my reading of the code. But maybe it may aid
additional vmalloc-internals debugging if for some reason the address of the
object stored in the vmalloc data structures is out of bound for some reason
and the lookup actually succeded. That's just a hypothetical situation though
and I don't think that that can actually happen.

thanks,

 - Joel

