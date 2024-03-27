Return-Path: <linux-kernel+bounces-122197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8E188F35A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412CE1F2A051
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C215445B;
	Wed, 27 Mar 2024 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF1BuN86"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960301552F3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711583226; cv=none; b=hEkJo6miSyPIqk2P5Zeh2fAqqlYCxgNMCMxH3a4JbyabpwO5fLWHM0bjlFuQl/XtgDMDVsVn5oM8jNOQW9w3+ANOm1aU5gBdevoh0rRIRJmUKMRrt2zdUbiOUAb5mNcnz3uKIxbVZh1oPIlE4rxTRz+V7EiuzPt+kOiJ5waxYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711583226; c=relaxed/simple;
	bh=jU+OV0dHSp1ZxKpRZ0+i6PqAFqCMuCo98JSSgv9BlMI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pjy4EGkON29qt6GVeajfb6rg7jjWyOSbLX1SrpIRDyNKm9jNIOJre232N4zu91MXK5Lob3ZwBXdnrKJZO1VGKUQO5baMh/muXsiPo/TQIaH9MjSIUf7HLDw74eYFUoftLMR0pjqBPfarIGatawy2A5uVHRoDW90AmkJbtoA+loY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF1BuN86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D56C43390;
	Wed, 27 Mar 2024 23:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711583226;
	bh=jU+OV0dHSp1ZxKpRZ0+i6PqAFqCMuCo98JSSgv9BlMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nF1BuN86XRvETf583AaXG//SATz82Qzf/cHIuYpOmGfynFdKtEuR+Zz+YneJNd8Z4
	 5IZiWb4aL+j0ZcO6Ao2CIiu5GhhOqQJtzPvklBET5mDqLCXfl4X2YDV4mpgWpx0Xgp
	 tWH1D17IbCE+6GK337XlgmomgGFP1PMF3T+lhJGgKYn46VIgiy08QpEzYm3eHwWoHn
	 wCzeRA2Z4NzWc9e51DuITbo5/9I1Qe9uWP1fzLs8WFTT1I7P7qrz8i3ZTLEjK3aedn
	 BEamMPmfnHI95BOgPyGHqilMKetiuXC4axOuNr23jZcd2TDtwUNDRMISGNMdxNV6zP
	 QQxKjNkz9hfrg==
Date: Thu, 28 Mar 2024 08:47:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Mark Rutland" <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
 <agordeev@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
 <aou@eecs.berkeley.edu>, <bp@alien8.de>, <catalin.marinas@arm.com>,
 <dave.hansen@linux.intel.com>, <davem@davemloft.net>, <gor@linux.ibm.com>,
 <hca@linux.ibm.com>, <jcalvinowens@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>,
 <mpe@ellerman.id.au>, <naveen.n.rao@linux.ibm.com>, <palmer@dabbelt.com>,
 <paul.walmsley@sifive.com>, <tglx@linutronix.de>, <will@kernel.org>
Subject: Re: [PATCH 4/4] kprobes: Remove core dependency on modules
Message-Id: <20240328084701.84aacecba30e83a9ce08a6d8@kernel.org>
In-Reply-To: <D04PYD185FIK.WABP6RZDCC06@kernel.org>
References: <20240326163624.3253157-1-mark.rutland@arm.com>
	<20240326163624.3253157-5-mark.rutland@arm.com>
	<D03UMKC71414.2D6NN1BIWD5TZ@kernel.org>
	<ZgMICo-dZJgVklc4@FVFF77S0Q05N.cambridge.arm.com>
	<20240327090155.873f1ed32700dbdb75f8eada@kernel.org>
	<D04PYD185FIK.WABP6RZDCC06@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 19:46:50 +0200
"Jarkko Sakkinen" <jarkko@kernel.org> wrote:

> On Wed Mar 27, 2024 at 2:01 AM EET, Masami Hiramatsu (Google) wrote:
> > On Tue, 26 Mar 2024 17:38:18 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > > On Tue, Mar 26, 2024 at 07:13:51PM +0200, Jarkko Sakkinen wrote:
> > > > On Tue Mar 26, 2024 at 6:36 PM EET, Mark Rutland wrote:
> > > 
> > > > > +#ifdef CONFIG_MODULES
> > > > >  	/* Check if 'p' is probing a module. */
> > > > >  	*probed_mod = __module_text_address((unsigned long) p->addr);
> > > > >  	if (*probed_mod) {
> > > > > @@ -1605,6 +1606,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
> > > > >  			ret = -ENOENT;
> > > > >  		}
> > > > >  	}
> > > > > +#endif
> > > > 
> > > > This can be scoped a bit more (see v7 of my patch set).
> > > 
> > > > > +#ifdef CONFIG_MODULES
> > > > >  static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> > > > >  {
> > > > >  	char *p;
> > > > > @@ -129,6 +130,9 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> > > > >  
> > > > >  	return ret;
> > > > >  }
> > > > > +#else
> > > > > +#define trace_kprobe_module_exist(tk) false /* aka a module never exists */
> > > > > +#endif /* CONFIG_MODULES */
> > > > >  
> > > > >  static bool trace_kprobe_is_busy(struct dyn_event *ev)
> > > > >  {
> > > > > @@ -670,6 +674,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > +#ifdef CONFIG_MODULES
> > > > >  /* Module notifier call back, checking event on the module */
> > > > >  static int trace_kprobe_module_callback(struct notifier_block *nb,
> > > > >  				       unsigned long val, void *data)
> > > > > @@ -699,6 +704,9 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
> > > > >  
> > > > >  	return NOTIFY_DONE;
> > > > >  }
> > > > > +#else
> > > > > +#define trace_kprobe_module_callback (NULL)
> > > > > +#endif /* CONFIG_MODULES */
> > > > 
> > > > The last two CONFIG_MODULES sections could be combined. This was also in
> > > > v7.
> > > 
> > > > Other than lgtm.
> > > 
> > > Great! I've folded your v7 changes in, and pushed that out to:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kprobes/without-modules
> > > 
> > > I'll hold off sending that out to the list until other folk have had a chance
> > > to comment.
> >
> > Yeah, the updated one looks good to me too.
> >
> > Thanks!
> 
> As for RISC-V:
> 
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org> # arch/riscv

Thank you for testing!

> 
> I'm fine with adding to all patches because it would be hard
> to place tested-by to any specific patch (e.g. if this was a
> syscall I would give tested-by just for that patch).

Except for the 1st patch because that is for arm64, right? :)

> 
> Just adding disclaimer because depending on subsystem people
> are more or less strict with this tag :-)
> 
> BR, Jarkko

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

