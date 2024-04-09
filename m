Return-Path: <linux-kernel+bounces-137025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3293889DB47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F5FB234BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2701327E1;
	Tue,  9 Apr 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnN3ews6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD1132471;
	Tue,  9 Apr 2024 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670566; cv=none; b=Bi9tQuoe+ZmFhpy7G+tRb44SaEqStPgqNflwaZB4VsR6vb07WYBEBZHYZVcTWxUAAvw8xrxE1xOptLt1GhBdFPr6Y+42L9gHHlLrvKm0L5eFpOyQCx81OvtcWqTGNYi8GwBfngsk7K9vPZ9+7/n4KpkOStPwsXY3EkPPE/6w9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670566; c=relaxed/simple;
	bh=p0eug8O3p1S0YU40BLzEUAlTDogSyrE4TDh9AEvpxrg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HhS3JgDh6PiXEpKmj0gJul8b3stW/sEdVZBy4RX3k5WRzD3mXfY8OGFSg/EGCpObhPBxs9vgkLTFi1VOAaOjE3THC1RccMUXh7iOELRJAswCG1ly3n975+5Ut0vADCdgg9yohSePqcxqUaYvCvUD41y6cAhsBqPjghREauG2xeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnN3ews6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC51C433F1;
	Tue,  9 Apr 2024 13:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712670565;
	bh=p0eug8O3p1S0YU40BLzEUAlTDogSyrE4TDh9AEvpxrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tnN3ews6LnbbJvub/lKu+IkiR8RZ0kr2r0pcqUZOLbxq8kwIQYeAUtQY2juejCu5p
	 2Ub702cpcJWK/AvEoiDiYbbbFVUcB8lL2KdP6F1AVAArg4U1Kj+QwmgG69KeCU3oBA
	 A48FItNez7V4HHPDOV09Zzzw+Wpp/FKn4A3ANAP6TkKUhRIU+C6LEHMRyK+vFEXdm8
	 ZmhwXMwBOwR4ioC4iHclKPKrZXrmZf0WiysHWeFTo3Pt6w2nP0WMKhOk+JvFpMBa3a
	 ArsbIQbF49TsV+BQw48xCPO4P8ZFDJ6VXmvpoRt4mgQGeKHYGzYnQZPm7Tf2ao0hKh
	 429Mtaoet9mPQ==
Date: Tue, 9 Apr 2024 22:49:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
 <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kprobes: Avoid possible warn in
 __arm_kprobe_ftrace()
Message-Id: <20240409224922.5f192e8ace5f7a90937bfa69@kernel.org>
In-Reply-To: <a8cf7252-4d67-fb8c-6c3e-77f7a1c66dee@huawei.com>
References: <20240407035904.2556645-1-zhengyejian1@huawei.com>
	<20240408083403.3302274-1-zhengyejian1@huawei.com>
	<20240408214102.be792c5cefd5ab757ef32a14@kernel.org>
	<a8cf7252-4d67-fb8c-6c3e-77f7a1c66dee@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 14:20:45 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> On 2024/4/8 20:41, Masami Hiramatsu (Google) wrote:
> > Hi Zheng,
> > 
> > On Mon, 8 Apr 2024 16:34:03 +0800
> > Zheng Yejian <zhengyejian1@huawei.com> wrote:
> > 
> >> There is once warn in __arm_kprobe_ftrace() on:
> >>
> >>   ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
> >>   if (WARN_ONCE(..., "Failed to arm kprobe-ftrace at %pS (error %d)\n", ...)
> >>     return ret;
> >>
> >> This warning is generated because 'p->addr' is detected to be not a valid
> >> ftrace location in ftrace_set_filter_ip(). The ftrace address check is done
> >> by check_ftrace_location() at the beginning of check_kprobe_address_safe().
> >> At that point, ftrace_location(addr) == addr should return true if the
> >> module is loaded. Then the module is searched twice:
> >>    1. in is_module_text_address(), we find that 'p->addr' is in a module;
> >>    2. in __module_text_address(), we find the module;
> >>
> >> If the module has just been unloaded before the second search, then
> >> '*probed_mod' is NULL and we would not go to get the module refcount,
> >> then the return value of check_kprobe_address_safe() would be 0, but
> >> actually we need to return -EINVAL.
> > 
> > OK, so you found a race window in check_kprobe_address_safe().
> > 
> > It does something like below.
> > 
> > check_kprobe_address_safe() {
> > 	...
> > 
> > 	/* Timing [A] */
> > 
> > 	if (!(core_kernel_text(p->addr) ||
> > 		is_module_text_address(p->addr)) ||
> > 		...(other reserved address check)) {
> > 		return -EINVAL;
> > 	}
> > 
> > 	/* Timing [B] */
> > 
> > 	*probed_mod = __module_text_address(p->addr):
> > 	if (*probe_mod) {
> > 		if (!try_module_get(*probed_mod)) {
> > 			return -ENOENT;
> > 		}
> > 		...	
> > 	}
> > }
> > 
> > So, if p->addr is in a module which is alive at the timing [A], but
> > unloaded at timing [B], 'p->addr' is passed the
> > 'is_module_text_address(p->addr)' check, but *probed_mod becomes NULL.
> > Thus the corresponding module is not referenced and kprobe_arm(p) will
> > access a wrong address (use after free).
> > This happens either kprobe on ftrace is enabled or not.
> 
> Yes, This is the problem. And for this case, check_kprobe_address_safe() 
> still return 0, and then going on to arm kprobe may cause problems. So
> we should make check_kprobe_address_safe() return -EINVAL when refcount
> of the module is not got.

Yes,

> 
> > 
> > To fix this problem, we should move the mutex_lock(kprobe_mutex) before
> > check_kprobe_address_safe() because kprobe_module_callback() also lock it
> > so it can stop module unloading.
> > 
> > Can you ensure this will fix your problem?
> 
> It seems not, the warning in __arm_kprobe_ftrace() still occurs. I
> contrived following simple test:
> 
>      #!/bin/bash
>      sysctl -w kernel.panic_on_warn=1
>      while [ True ]; do
>          insmod mod.ko    # contain function 'foo'
>          rmmod mod.ko
>      done &
>      while [ True ]; do
>          insmod kprobe.ko  # register kprobe on function 'foo'
>          rmmod kprobe.ko
>      done &
> 
> I think holding kprobe_mutex cannot make sure we get the refcount of the
> module.

Aah, yes, it cannot, because the kallsyms in a module will be removed
after module->state becomes MODULE_STATE_UNFORMED. Before UNFORMED,
the state is MODULE_STATE_GOING and the kprobe_module_callback() is
called at that point. Thus, the following scenario happens.

             CPU1 					CPU2

mod->state = MODULE_STATE_GOING
kprobe_module_callback() {
	mutex_lock(&kprobe_mutex)
		loop on kprobe_table 
		to disable kprobe in the module.
	mutex_unlock(&kprobe_mutex)
}
						register_kprobe(p) {
							mutex_lock(&kprobe_mutex)
							check_kprobe_address_safe(p->addr) {
								[A'']
								is_module_text_address() return true
								until mod->state == UNFORMED.
mod->state = MODULE_STATE_UNFORMED
								[B'']
								__module_text_address() returns NULL.
							}
							p is on the kprobe_table.
							mutex_unlock(&kprobe_mutex)

So, as your fix, if we save the module at [A''] and use it at [B''],
the mod is NOT able to get because mod->state != MODULE_STATE_LIVE.


> 
> > I think your patch is just optimizing but not fixing the fundamental
> > problem, which is we don't have an atomic search symbol and get module
> 
> Sorry, this patch is a little confusing, but it is not just optimizing :)
> 
> As shown below, after my patch, if p->addr is in a module which is alive
> at the timing [A'] but unloaded at timing [B'], then *probed_mod must
> not be NULL. Then after timing [B'], it will go to try_module_get() and
> expected to fail and return -ENOENT. So this is the different.
> 
>      check_kprobe_address_safe() {
>          ...
>          *probed_mod = NULL;
>          if (!core_kernel_text((unsigned long) p->addr)) {
> 
>              /* Timing [A'] */
> 
>              *probed_mod = __module_text_address((unsigned long) p->addr);
>              if (!(*probed_mod)) {
>                  return -EINVAL;
>              }
>          }
>          ...
> 
>          /* Timing [B'] */
> 
>          if (*probed_mod) {
>              if (!try_module_get(*probed_mod)) {
>                  return -ENOENT;
>              }
>              ...
>          }

OK, I got it. Hmm, but this is a bit long story to explain, the
root cause is the delay of module unloading process. So more
precisely, we can explain it as below.

----
When unloading a module, its state is changing MODULE_STATE_LIVE -> 
 MODULE_STATE_GOING -> MODULE_STATE_UNFORMED. Each change will take
a time. `is_module_text_address()` and `__module_text_address()`
works with MODULE_STATE_LIVE and MODULE_STATE_GOING.
If we use `is_module_text_address()` and `__module_text_address()`
separately, there is a chance that the first one is succeeded but the
next one is failed because module->state becomes MODULE_STATE_UNFORMED
between those operations.

In `check_kprobe_address_safe()`, if the second `__module_text_address()`
is failed, that is ignored because it expected a kernel_text address.
But it may have failed simply because module->state has been changed
to MODULE_STATE_UNFORMED. In this case, arm_kprobe() will try to modify
non-exist module text address (use-after-free).

To fix this problem, we should not use separated `is_module_text_address()`
and `__module_text_address()`, but use only `__module_text_address()` once
and do `try_module_get(module)` which is only available with
MODULE_STATE_LIVE.
----

Would it be good for you too? The code itself looks good to me now :-)

Thank you!

> 
> > API. In that case, we should stop a whole module unloading system until
> > registering a new kprobe on a module. (After registering the kprobe,
> > the callback can mark it gone and disarm_kprobe does not work anymore.)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 9d9095e81792..94eaefd1bc51 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1633,11 +1633,11 @@ int register_kprobe(struct kprobe *p)
> >   	p->nmissed = 0;
> >   	INIT_LIST_HEAD(&p->list);
> >   
> > +	mutex_lock(&kprobe_mutex);
> > +
> >   	ret = check_kprobe_address_safe(p, &probed_mod);
> >   	if (ret)
> > -		return ret;
> > -
> > -	mutex_lock(&kprobe_mutex);
> > +		goto out;
> >   
> >   	if (on_func_entry)
> >   		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
> > 
> > ----
> > 
> > Thank you,
> > 
> >>
> >> To fix it, originally we can simply check 'p->addr' is out of text again,
> >> like below. But that would check twice respectively in kernel text and
> >> module text, so finally I reduce them to be once.
> >>
> >>    if (!(core_kernel_text((unsigned long) p->addr) ||
> >>        is_module_text_address((unsigned long) p->addr)) || ...) {
> >> 	ret = -EINVAL;
> >> 	goto out;
> >>    }
> >>    ...
> >>    *probed_mod = __module_text_address((unsigned long) p->addr);
> >>    if (*probed_mod) {
> >> 	...
> >>    } else if (!core_kernel_text((unsigned long) p->addr)) { // check again!
> >> 	ret = -EINVAL;
> >> 	goto out;
> >>    }
> >>
> >> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> >> ---
> >>   kernel/kprobes.c | 18 ++++++++++++------
> >>   1 file changed, 12 insertions(+), 6 deletions(-)
> >>
> >> v2:
> >>   - Update commit messages and comments as suggested by Masami.
> >>     Link: https://lore.kernel.org/all/20240408115038.b0c85767bf1f249eccc32fff@kernel.org/
> >>
> >> v1:
> >>   - Link: https://lore.kernel.org/all/20240407035904.2556645-1-zhengyejian1@huawei.com/
> >>
> >> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> >> index 9d9095e81792..65adc815fc6e 100644
> >> --- a/kernel/kprobes.c
> >> +++ b/kernel/kprobes.c
> >> @@ -1567,10 +1567,17 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >>   	jump_label_lock();
> >>   	preempt_disable();
> >>   
> >> -	/* Ensure it is not in reserved area nor out of text */
> >> -	if (!(core_kernel_text((unsigned long) p->addr) ||
> >> -	    is_module_text_address((unsigned long) p->addr)) ||
> >> -	    in_gate_area_no_mm((unsigned long) p->addr) ||
> >> +	/* Ensure the address is in a text area, and find a module if exists. */
> >> +	*probed_mod = NULL;
> >> +	if (!core_kernel_text((unsigned long) p->addr)) {
> >> +		*probed_mod = __module_text_address((unsigned long) p->addr);
> >> +		if (!(*probed_mod)) {
> >> +			ret = -EINVAL;
> >> +			goto out;
> >> +		}
> >> +	}
> >> +	/* Ensure it is not in reserved area. */
> >> +	if (in_gate_area_no_mm((unsigned long) p->addr) ||
> >>   	    within_kprobe_blacklist((unsigned long) p->addr) ||
> >>   	    jump_label_text_reserved(p->addr, p->addr) ||
> >>   	    static_call_text_reserved(p->addr, p->addr) ||
> >> @@ -1580,8 +1587,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >>   		goto out;
> >>   	}
> >>   
> >> -	/* Check if 'p' is probing a module. */
> >> -	*probed_mod = __module_text_address((unsigned long) p->addr);
> >> +	/* Get module refcount and reject __init functions for loaded modules. */
> >>   	if (*probed_mod) {
> >>   		/*
> >>   		 * We must hold a refcount of the probed module while updating
> >> -- 
> >> 2.25.1
> >>
> >
> --
> Thanks
> Zheng Yejian
> > 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

