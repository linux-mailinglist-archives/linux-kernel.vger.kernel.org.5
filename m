Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B837974C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjIGPk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjIGPgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:36:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B282123;
        Thu,  7 Sep 2023 08:35:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45D511F86C;
        Thu,  7 Sep 2023 07:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694070639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbVdXW/jNFCFxdW+0x/LfhB7YMcuH/QmkF6mZXOuaLE=;
        b=3AkW0YDdz/+le3pX62tW9FtHTG97hy9+xiaxNkWWz4qd/7IKfwRUqLtZprB3fdgW9GDEDY
        LFrgg0Ur4ZlsksnUNEJSaKDkYlfsXc5aiAFCaFJyN9VMpHwJHaZbazm8EnzYx2tb3XR+im
        I1yAN+SQOBtwGyrpofbtRLJlgDUO2lU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694070639;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbVdXW/jNFCFxdW+0x/LfhB7YMcuH/QmkF6mZXOuaLE=;
        b=vWb+l5pOCouADD9LzFATDdCF4CBnb8ZVlVUDrX4mn6q2mcJltWbN3YfD6sYkyMILlMzFBp
        ADdgkcIN+z9Pz/AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 118381358B;
        Thu,  7 Sep 2023 07:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RUqJA293+WRdBgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Sep 2023 07:10:39 +0000
Message-ID: <737d399d-c83a-3e66-ceb7-4ae7ba4acfb4@suse.cz>
Date:   Thu, 7 Sep 2023 09:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/2] rcu: Dump vmalloc memory info safely
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        rcu@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        stable@vger.kernel.org, linux-mm@kvack.org
References: <20230904180806.1002832-1-joel@joelfernandes.org>
 <20230904180806.1002832-2-joel@joelfernandes.org>
 <9e329429-73a5-4926-af4f-edcf9e547101@lucifer.local>
 <20230905114841.GB3881391@google.com>
 <CAA5enKafgfqNE0DWg7tcd-iNGeE0Aud5VcmmWzdguK9Psq0uhQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAA5enKafgfqNE0DWg7tcd-iNGeE0Aud5VcmmWzdguK9Psq0uhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 21:18, Lorenzo Stoakes wrote:
> On Tue, 5 Sept 2023 at 12:48, Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>> On Tue, Sep 05, 2023 at 08:00:44AM +0100, Lorenzo Stoakes wrote:
>> > On Mon, Sep 04, 2023 at 06:08:05PM +0000, Joel Fernandes (Google) wrote:
>> > > From: Zqiang <qiang.zhang1211@gmail.com>
>> > >
>> > > Currently, for double invoke call_rcu(), will dump rcu_head objects
>> > > memory info, if the objects is not allocated from the slab allocator,
>> > > the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
>> > > need to be held, since the call_rcu() can be invoked in interrupt context,
>> > > therefore, there is a possibility of spinlock deadlock scenarios.
>> > >
>> > > And in Preempt-RT kernel, the rcutorture test also trigger the following
>> > > lockdep warning:
>> > >
>> > > BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> > > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
>> > > preempt_count: 1, expected: 0
>> > > RCU nest depth: 1, expected: 1
>> > > 3 locks held by swapper/0/1:
>> > >  #0: ffffffffb534ee80 (fullstop_mutex){+.+.}-{4:4}, at: torture_init_begin+0x24/0xa0
>> > >  #1: ffffffffb5307940 (rcu_read_lock){....}-{1:3}, at: rcu_torture_init+0x1ec7/0x2370
>> > >  #2: ffffffffb536af40 (vmap_area_lock){+.+.}-{3:3}, at: find_vmap_area+0x1f/0x70
>> > > irq event stamp: 565512
>> > > hardirqs last  enabled at (565511): [<ffffffffb379b138>] __call_rcu_common+0x218/0x940
>> > > hardirqs last disabled at (565512): [<ffffffffb5804262>] rcu_torture_init+0x20b2/0x2370
>> > > softirqs last  enabled at (399112): [<ffffffffb36b2586>] __local_bh_enable_ip+0x126/0x170
>> > > softirqs last disabled at (399106): [<ffffffffb43fef59>] inet_register_protosw+0x9/0x1d0
>> > > Preemption disabled at:
>> > > [<ffffffffb58040c3>] rcu_torture_init+0x1f13/0x2370
>> > > CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-rc4-rt2-yocto-preempt-rt+ #15
>> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>> > > Call Trace:
>> > >  <TASK>
>> > >  dump_stack_lvl+0x68/0xb0
>> > >  dump_stack+0x14/0x20
>> > >  __might_resched+0x1aa/0x280
>> > >  ? __pfx_rcu_torture_err_cb+0x10/0x10
>> > >  rt_spin_lock+0x53/0x130
>> > >  ? find_vmap_area+0x1f/0x70
>> > >  find_vmap_area+0x1f/0x70
>> > >  vmalloc_dump_obj+0x20/0x60
>> > >  mem_dump_obj+0x22/0x90
>> > >  __call_rcu_common+0x5bf/0x940
>> > >  ? debug_smp_processor_id+0x1b/0x30
>> > >  call_rcu_hurry+0x14/0x20
>> > >  rcu_torture_init+0x1f82/0x2370
>> > >  ? __pfx_rcu_torture_leak_cb+0x10/0x10
>> > >  ? __pfx_rcu_torture_leak_cb+0x10/0x10
>> > >  ? __pfx_rcu_torture_init+0x10/0x10
>> > >  do_one_initcall+0x6c/0x300
>> > >  ? debug_smp_processor_id+0x1b/0x30
>> > >  kernel_init_freeable+0x2b9/0x540
>> > >  ? __pfx_kernel_init+0x10/0x10
>> > >  kernel_init+0x1f/0x150
>> > >  ret_from_fork+0x40/0x50
>> > >  ? __pfx_kernel_init+0x10/0x10
>> > >  ret_from_fork_asm+0x1b/0x30
>> > >  </TASK>
>> > >
>> > > The previous patch fixes this by using the deadlock-safe best-effort
>> > > version of find_vm_area. However, in case of failure print the fact that
>> > > the pointer was a vmalloc pointer so that we print at least something.
>> > >
>> > > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
>> > > Cc: Paul E. McKenney <paulmck@kernel.org>
>> > > Cc: rcu@vger.kernel.org
>> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> > > Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
>> > > Cc: stable@vger.kernel.org
>> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> > > ---
>> > >  mm/util.c | 4 +++-
>> > >  1 file changed, 3 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/mm/util.c b/mm/util.c
>> > > index dd12b9531ac4..406634f26918 100644
>> > > --- a/mm/util.c
>> > > +++ b/mm/util.c
>> > > @@ -1071,7 +1071,9 @@ void mem_dump_obj(void *object)
>> > >     if (vmalloc_dump_obj(object))
>> > >             return;
>> > >
>> > > -   if (virt_addr_valid(object))
>> > > +   if (is_vmalloc_addr(object))
>> > > +           type = "vmalloc memory";
>> > > +   else if (virt_addr_valid(object))
>> > >             type = "non-slab/vmalloc memory";
>> >
>> > I think you should update this to say non-slab/non-vmalloc memory (as much
>> > as that description sucks!) as this phrasing in the past meant to say
>> > 'non-slab or vmalloc memory' (already confusing phrasing) so better to be
>> > clear.
>>
>> True, though the issue you mentioned it is in existing code, a respin of this
>> patch could update it to say non-vmalloc. Good point, thanks for reviewing!
> 
> No it's not, you're changing the meaning, because you changed the code
> that determines the output...

I think it has always meant (but clearly it's not unambiguously worded) "not
slab && not vmalloc", that is before and after this patch. Only in case
patch 1 is applied and patch 2 not, can the output be wrong in that a
vmalloc pointer will (in case of trylock fail) be classified as "not slab &&
not vmalloc", but seems fine to me after patch 2.

I guess if we wanted, we could also rewrite it to be more like the kmem
check in the beginning of mem_dump_obj(), so there would be:

if (is_vmalloc_addr(...)) {
    vmalloc_dump_obj(...);
    return;
}

where vmalloc_dump_obj() itself would print at least "vmalloc memory" with
no further details in case of trylock failure.

that assumes is_vmalloc_addr() is guaranteed to be true for all addresses
that __find_vmap_area resolves, otherwise it could miss something compared
to current code. Is it guaranteed?

> This has been merged now despite my outstanding comments (!) so I
> guess I'll have to send a follow up patch to address this.
> 
>>
>>  - Joel
>>
> 
> 
> 
> --
> Lorenzo Stoakes
> https://ljs.io

