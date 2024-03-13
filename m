Return-Path: <linux-kernel+bounces-100965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1682187A02B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A971F22810
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29753B67D;
	Wed, 13 Mar 2024 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1nFluVL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7BB654;
	Wed, 13 Mar 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710289971; cv=none; b=ejUzj4OtcHo0vJ4szZ60kHiZZCAPuskwzSBxPzkCSdTPOXXy0XJ4dUZZP7aQE/OljhjVI8nMzO3Yrl7MubBNnpx5xteOSA8HvOadhdye8YKlZxpzw6RgtgI56pQ8+tDTnWEkg+EyuRSCK9ulM3lrCNlQTS4zAuRA8DPqAJ5kdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710289971; c=relaxed/simple;
	bh=kYD2EpLgbT4sPCWd/jlC/Lu5P5Sa6jt2PmeMn6R10fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa9+MwotbZhbV0Hy8oV7fTWF1Ma/WSB3xEoEi792e0myq5hAbXlw8NJcWRp/KcfuGTjfwQLapVwUviDFMRZDdMDCLalJ3/sqyMa87Nq1FoHd611F4v8dBmHg4BlDGplg54/MdtCC1mgo27YQfZNtIgUW0T3IswK0c9oU7rKBtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1nFluVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1FFC433F1;
	Wed, 13 Mar 2024 00:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710289970;
	bh=kYD2EpLgbT4sPCWd/jlC/Lu5P5Sa6jt2PmeMn6R10fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1nFluVLxRu/u5a/qGTLoH5nSjbx2dz43KNXq480rVe6fo4AnMhZLRY2rrC7moBkh
	 eM8TEawAxTq85gYZ3LSakhqBM1htUlT7ndZfPKzN+Jc01S1n26191w79G9xlNtpPfU
	 h0shHYo+wXzMGO9a1kT+t/qn0lndJ03yuDmk0P8wW4rAc5Jjf8HgjnZ+fP8sAf/pxc
	 7tSln8gbmdkWVQMuuKNn1A2XI7hGHI8aSsxnyTbWV4NeLUbceyyVfgCbgIP0+umhdR
	 nyi2nUdmG0hxmz7EbUinnCzGpb5w8uHqoUKn7shlTpf9RCNQdxybicI/KTMFg/CTNW
	 IrowB/k6isRvw==
Date: Wed, 13 Mar 2024 00:32:44 +0000
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
Message-ID: <20240313003244.GA29568@willie-the-truck>
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
 <66fdce3a-c7f6-4ef4-ab56-7c9ece0b00e2@nokia.com>
 <ZewycILled+mZhwe@shell.armlinux.org.uk>
 <20240312221440.GA29419@willie-the-truck>
 <ZfDZolTDQa76hhaS@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfDZolTDQa76hhaS@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 12, 2024 at 10:39:30PM +0000, Russell King (Oracle) wrote:
> On Tue, Mar 12, 2024 at 10:14:40PM +0000, Will Deacon wrote:
> > On Sat, Mar 09, 2024 at 09:57:04AM +0000, Russell King (Oracle) wrote:
> > > On Sat, Mar 09, 2024 at 08:45:35AM +0100, Stefan Wiehler wrote:
> > > > diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
> > > > index 4204ffa2d104..4fc2c559f1b6 100644
> > > > --- a/arch/arm/mm/context.c
> > > > +++ b/arch/arm/mm/context.c
> > > > @@ -254,7 +254,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
> > > >             && atomic64_xchg(&per_cpu(active_asids, cpu), asid))
> > > >                 goto switch_mm_fastpath;
> > > > 
> > > > -       raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> > > > +       local_irq_save(flags);
> > > > +       arch_spin_lock(&cpu_asid_lock.raw_lock);
> > > >         /* Check that our ASID belongs to the current generation. */
> > > >         asid = atomic64_read(&mm->context.id);
> > > >         if ((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS) {
> > > > @@ -269,7 +270,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
> > > > 
> > > >         atomic64_set(&per_cpu(active_asids, cpu), asid);
> > > >         cpumask_set_cpu(cpu, mm_cpumask(mm));
> > > > -       raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> > > > +       arch_spin_unlock(&cpu_asid_lock.raw_lock);
> > > > +       local_irq_restore(flags);
> > > > 
> > > >  switch_mm_fastpath:
> > > >         cpu_switch_mm(mm->pgd, mm);
> > > > 
> > > > @Russell, what do you think?
> > > 
> > > I think this is Will Deacon's code, so we ought to hear from Will...
> > 
> > Thanks for adding me in.
> > 
> > Using arch_spin_lock() really feels like a bodge to me. This code isn't
> > run only on the hot-unplug path, but rather this is part of switch_mm()
> > and we really should be able to have lockdep work properly there for
> > the usual case.
> > 
> > Now, do we actually need to worry about the ASID when switching to the
> > init_mm? I'd have thought that would be confined to global (kernel)
> > mappings, so I wonder whether we could avoid this slow path code
> > altogether like we do on arm64 in __switch_mm(). But I must confess that
> > I don't recall the details of the pre-LPAE MMU configuration...
> 
> As the init_mm shouldn't have any userspace mappings, isn't the ASID
> entirely redundant? Couldn't check_and_switch_context() just simply
> do the vmalloc seq check, set the reserved ASID, and then head to
> switch_mm_fastpath to call the mm switch code?

Right, that's what I was thinking too, but I have some distant memories
of the module space causing potential issues in some configurations. Does
that ring a bell with you?

Will

