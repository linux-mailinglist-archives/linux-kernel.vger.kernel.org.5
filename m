Return-Path: <linux-kernel+bounces-166505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F728B9B94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB031F22581
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE184D03;
	Thu,  2 May 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnvSCM5r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4CC8F3;
	Thu,  2 May 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656318; cv=none; b=hEIf5/2TvTcDZ72ipMDphWkvfaE0x1jDeLDnWJbsfEfFA1espxP+UPd/p4aQErCB66LGGYmdoHIE74L9Ls/j1ZtPXmm1Rye5xCXs6a+c15oskPymKzBFXdkuGOyS4Pz2hrxW7w3FihQQ7XZngKY3VzdX8qZQ0aSEYDoK4BtVkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656318; c=relaxed/simple;
	bh=VHGDRaEUyUAYEKWtMh0zoRqWCqssfCu3JEMu5EWUUak=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPlz2b8y8tLz3dF6SckptGr6BzdKgfCHlZ8II2smPXZuB9qtNuo+joSTUwdsC/8R+R3ZGSnwAls+oHuxzYV/cPCUJPgPY2p5XQeCmZx9+aaI9Iw7vh+OVu8DjqZnBS5OVEBu9JDiJ7ZepBXM/G06E8y4PUDD0DoYaTJxDlL3m80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnvSCM5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A926C113CC;
	Thu,  2 May 2024 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714656318;
	bh=VHGDRaEUyUAYEKWtMh0zoRqWCqssfCu3JEMu5EWUUak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LnvSCM5rZcc5DCMiNUN51DnrFBNFgZQLzh7cL9LK8dqkytPnEpCubvjmywMZZMscE
	 EQVry4op6mSahi8OIUw7JsSXkkWjzvOMbK+jYiNvn8MSDFz92By3q+YF22Wcv56OIY
	 5XGbB4OZy7UWahllCBEG1A8JcbqIyIT7+HJb2oGiCAbKxVNkQQU3bbQw6FjEN5XAPR
	 3MnMNjPqi/cVxA/N5Wg06+6D44PKume0NEvtEb6R8GSb0ejHJb3I6+tYnt9i7BlMpk
	 ZSontZCfqflBoxTCzCRpYki03X49kBlvZswxqTJhRzMTbndkcU/yv6aof9bHDddoaX
	 306aFAIfhpYUQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1s2WR1-00A0qE-L2;
	Thu, 02 May 2024 14:25:15 +0100
Date: Thu, 02 May 2024 14:25:14 +0100
Message-ID: <867cgcqrb9.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Zayd Qumsieh <zayd_qumsieh@apple.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
    Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Justin Lu <ih_justin@apple.com>,
	Ryan Houdek <Houdek.Ryan@fex-emu.org>,
	Mark Brown <broonie@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Baoquan He <bhe@redhat.com>,
	Joel Granados <j.granados@samsung.com>,
	Dawei Li <dawei.li@shingroup.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florent Revest <revest@chromium.org>,
	David Hildenbrand <david@redhat.com>,
	Stefan Roesch <shr@devkernel.io>,
	Andy Chiu <andy.chiu@sifive.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Helge Deller <deller@gmx.de>,
	Zev Weiss <zev@bewilderbeest.net>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
In-Reply-To: <20240502001035.41083-1-zayd_qumsieh@apple.com>
References: <87zftoqn7u.wl-maz@kernel.org>
	<20240502001035.41083-1-zayd_qumsieh@apple.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: zayd_qumsieh@apple.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, ih_justin@apple.com, Houdek.Ryan@fex-emu.org, broonie@kernel.org, ardb@kernel.org, mjguzik@gmail.com, anshuman.khandual@arm.com, oliver.upton@linux.dev, miguel.luis@oracle.com, joey.gouly@arm.com, cpaasch@apple.com, keescook@chromium.org, samitolvanen@google.com, bhe@redhat.com, j.granados@samsung.com, dawei.li@shingroup.cn, akpm@linux-foundation.org, revest@chromium.org, david@redhat.com, shr@devkernel.io, andy.chiu@sifive.com, josh@joshtriplett.org, oleg@redhat.com, deller@gmx.de, zev@bewilderbeest.net, omosnace@redhat.com, ojeda@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

[adding Will back to the thread]

On Thu, 02 May 2024 01:10:35 +0100,
Zayd Qumsieh <zayd_qumsieh@apple.com> wrote:
> 
> > On Fri, 19 Apr 2024 17:58:09 +0100,
> > Will Deacon <will@kernel.org> wrote:
> > > 
> > > On Thu, Apr 11, 2024 at 11:19:13PM +0900, Hector Martin wrote:
> > > > On 2024/04/11 22:28, Will Deacon wrote:
> > > > >   * Some binaries in a distribution exhibit instability which goes away
> > > > >     in TSO mode, so a taskset-like program is used to run them with TSO
> > > > >     enabled.
> > > > 
> > > > Since the flag is cleared on execve, this third one isn't generally
> > > > possible as far as I know.
> > > 
> > > Ah ok, I'd missed that. Thanks.
> > > 
> > > > > In all these cases, we end up with native arm64 applications that will
> > > > > either fail to load or will crash in subtle ways on CPUs without the TSO
> > > > > feature. Assuming that the application cannot be fixed, a better
> > > > > approach would be to recompile using stronger instructions (e.g.
> > > > > LDAR/STLR) so that at least the resulting binary is portable. Now, it's
> > > > > true that some existing CPUs are TSO by design (this is a perfectly
> > > > > valid implementation of the arm64 memory model), but I think there's a
> > > > > big difference between quietly providing more ordering guarantees than
> > > > > software may be relying on and providing a mechanism to discover,
> > > > > request and ultimately rely upon the stronger behaviour.
> > > > 
> > > > The problem is "just" using stronger instructions is much more
> > > > expensive, as emulators have demonstrated. If TSO didn't serve a
> > > > practical purpose I wouldn't be submitting this, but it does. This is
> > > > basically non-negotiable for x86 emulation; if this is rejected
> > > > upstream, it will forever live as a downstream patch used by the entire
> > > > gaming-on-Mac-Linux ecosystem (and this is an ecosystem we are very
> > > > explicitly targeting, given our efforts with microVMs for 4K page size
> > > > support and the upcoming Vulkan drivers).
> > > 
> > > These microVMs sound quite interesting. What exactly are they? Are you
> > > running them under KVM?
> > > 
> > > Ignoring the mechanism for the time being, would it solve your problem
> > > if you were able to run specific microVMs in TSO mode, or do you *really*
> > > need the VM to have finer-grained control than that? If the whole VM is
> > > running in TSO mode, then my concerns largely disappear, as that's
> > > indistinguishable from running on a hardware implementation that happens
> > > to be TSO.
> >
> > Since KVM has been mentioned a few times, I'll give my take on this.
> >
> > Since day 1, it was a conscious decision for KVM/arm64 to emulate the
> > architecture, and only that -- this is complicated enough. Meaning
> > that no implementation-defined features should be explicitly exposed
> > to the guest. So I have no plan to expose any such feature for
> > userspace to configure TSO or anything else of the sort.
> 
> Agreed. We do not intend for TSO mode to be used extensively for EL1, the
> intention is for TSO mode to be reserved for userspace applications that
> request it.

But that's the same thing for a hypervisor.

For usersoace in a VM to make use of any feature, it must be exposed
to the VM as a whole by the host VMM (QEMU, kvmtool, whatever). Which
means having a new userspace ABI, specific to KVM, exposing a feature
for which there is no spec whatsoever. Even worse, you cannot discover
whether the instruction you must use to context switch the ACTLR_EL1
register is implemented. Isn't that great?

And I'm not even talking about the joys of migrating such a VM,
because we have no clue what this bit means on other implementations.
For all we know it causes another CPU to catch fire (or go PDP-endian,
which is basically the same).

Which is why my proposal is for this bit to be set statically for
*all* VMs, and leave the kernel (and KVM) out of the picture
altogether. At least that is something we can reason about (although
someone would need to start thinking of how this particular TSO
implementation composes with the relaxed memory ordering used outside
of the VM and show that they actually lead to correct results for
something such as virtio, for example).

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

