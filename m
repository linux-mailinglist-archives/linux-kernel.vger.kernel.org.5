Return-Path: <linux-kernel+bounces-100859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C08CC879E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E29B22489
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920DD143C74;
	Tue, 12 Mar 2024 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y11sc2Qx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01C143753;
	Tue, 12 Mar 2024 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281687; cv=none; b=joNKMGOPMO06nOarFKHC+wsU6yblbh3oKjqjj74vLnCHI5tHYceN/L53DmsK/COq8blLwfFmY8tfpNYXvrTDxQDgyyfdPeEUcZQ+n2rsRqoDzo8KPEkd6GxcAsaCx5Gefpx9wLHUjzg7O74qMSmYvG3kUodgUGCu0oKWSBG9NJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281687; c=relaxed/simple;
	bh=4aUjgMILvjcV11Jnjg3n3Tf0x1z42XftzUW2VxACbeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q97vhgFkBv4R0dkXhXTeL2fPkwfqZdZQaJY6b84/ISKZfupmrpGUU92b98dr6DAv0IP6WgjznuGypcBazdq+rUzYkI8HjqqsPF1/Ez4OKhT4Tl6Nnc8D3lwNG9iE1TiGVQzkLaw8W3D+pcpg37bmwXeCWvxLWxDlmAel2SA9cK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y11sc2Qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C44C433F1;
	Tue, 12 Mar 2024 22:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710281687;
	bh=4aUjgMILvjcV11Jnjg3n3Tf0x1z42XftzUW2VxACbeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y11sc2Qxg4CC2tN7G5D3/b0N7NwRD+M/+MxAgC6/Ksh0pen1bLwvSBO4m+hLBh4sX
	 ma8dAOg/x8ZdmaMPxmb+a2b9Naxgm8vjIOIsfPZyg4PjRZHcw5GP62WnTksV+Q3IBQ
	 /WEQxfktpaDsy6fZ6uhc9KS+dyOVkoENt5w/sayVRbxdzu1nuzXC5V0k6aguddmi8A
	 SUAo81OefwyMb/S8T9FokV9DioatMsgFl3AH2WmpAoEvU7VNRSQX4I1hGHw+4PLncJ
	 o1PTrxU4uQKIpStN219soS6oeHusBmWMsuCc3gEPPb8LptMitjNGhY5K1be8SXsvED
	 7m/Oziz1P5ZgQ==
Date: Tue, 12 Mar 2024 22:14:40 +0000
From: Will Deacon <will@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Stefan Wiehler <stefan.wiehler@nokia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
Message-ID: <20240312221440.GA29419@willie-the-truck>
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
 <66fdce3a-c7f6-4ef4-ab56-7c9ece0b00e2@nokia.com>
 <ZewycILled+mZhwe@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZewycILled+mZhwe@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Russell,

On Sat, Mar 09, 2024 at 09:57:04AM +0000, Russell King (Oracle) wrote:
> On Sat, Mar 09, 2024 at 08:45:35AM +0100, Stefan Wiehler wrote:
> > diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
> > index 4204ffa2d104..4fc2c559f1b6 100644
> > --- a/arch/arm/mm/context.c
> > +++ b/arch/arm/mm/context.c
> > @@ -254,7 +254,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
> >             && atomic64_xchg(&per_cpu(active_asids, cpu), asid))
> >                 goto switch_mm_fastpath;
> > 
> > -       raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> > +       local_irq_save(flags);
> > +       arch_spin_lock(&cpu_asid_lock.raw_lock);
> >         /* Check that our ASID belongs to the current generation. */
> >         asid = atomic64_read(&mm->context.id);
> >         if ((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS) {
> > @@ -269,7 +270,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
> > 
> >         atomic64_set(&per_cpu(active_asids, cpu), asid);
> >         cpumask_set_cpu(cpu, mm_cpumask(mm));
> > -       raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> > +       arch_spin_unlock(&cpu_asid_lock.raw_lock);
> > +       local_irq_restore(flags);
> > 
> >  switch_mm_fastpath:
> >         cpu_switch_mm(mm->pgd, mm);
> > 
> > @Russell, what do you think?
> 
> I think this is Will Deacon's code, so we ought to hear from Will...

Thanks for adding me in.

Using arch_spin_lock() really feels like a bodge to me. This code isn't
run only on the hot-unplug path, but rather this is part of switch_mm()
and we really should be able to have lockdep work properly there for
the usual case.

Now, do we actually need to worry about the ASID when switching to the
init_mm? I'd have thought that would be confined to global (kernel)
mappings, so I wonder whether we could avoid this slow path code
altogether like we do on arm64 in __switch_mm(). But I must confess that
I don't recall the details of the pre-LPAE MMU configuration...

Will

