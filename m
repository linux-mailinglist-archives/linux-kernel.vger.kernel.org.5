Return-Path: <linux-kernel+bounces-152254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFF78ABB6B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFA21C206A2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA9A29CF0;
	Sat, 20 Apr 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSjH8xfY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CE205E3A;
	Sat, 20 Apr 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713613051; cv=none; b=n6ZOBDaCtVBhTCqX7pPGggTJxIlzOnF5heXXO+o0OygBtl5dnfSNgfk7rnr0iaOS6m6ii0ixgOmIw0d8VyG0XdoCP9tpCm+6WAYVO+DyO96IGWp+xKN08GV3TpxfPeMuh3HlgGQLWIM6RFwACvdn3IONM4XQGxu39+Ozx8QgHco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713613051; c=relaxed/simple;
	bh=mcbXPArX3W5bs/P2RSabEjC9+JVFSfDDDGwpIZwpHfE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgdwT6e3ncfY9gSGTVmLwM5yAqdB5NkBU7bI2ITaozHIOwnigiQT9Y3LCl0K/ibq5omXFUAjmqQ+fEpVbfOswbzf55UfdBZ6dVyO6dm+SHksWe66v/5WH9cr6P0P1gfgIdoOXqo4eZKYkFXf3LagtlcFTGQphK2aYKe6WI8oUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSjH8xfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132DDC072AA;
	Sat, 20 Apr 2024 11:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713613051;
	bh=mcbXPArX3W5bs/P2RSabEjC9+JVFSfDDDGwpIZwpHfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZSjH8xfYL22lL0GdIKPSujIBpaCXmJdaf0KXyz8w4arA+m2zXxzM4Dlhjj8wwjt4y
	 7oFP3FCxgC33lyaasVfnskXH13U4srvxM44Nng94e76byoJgy0I2r0JxZEE1CcIL3h
	 Lf7s1UtlktES/aJ00wtJZssO3x2hJzpzR6HBJxNqUl29naxWdAvndtnKnuuPaMMUPk
	 FvrZbOpidXJ/or8dzgpzVC4xAxDHLpKkkpDT/DwRx83hHlW9VM/ZIZhbY7vvCnohw4
	 uOvZskWAv+qGxnK8kfPtSED6TQ/ht5W8Pq29ZmLW1bLnYn3aAttOuiU2kc1ZdVYgks
	 8DQfrWIKfMzYA==
Received: from 82-132-232-8.dab.02.net ([82.132.232.8] helo=wait-a-minute.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1ry928-006LLL-2X;
	Sat, 20 Apr 2024 12:37:28 +0100
Date: Sat, 20 Apr 2024 12:37:25 +0100
Message-ID: <87zftoqn7u.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Hector Martin <marcan@marcan.st>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Zayd Qumsieh <zayd_qumsieh@apple.com>,
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
In-Reply-To: <20240419165809.GA4020@willie-the-truck>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
	<20240411132853.GA26481@willie-the-truck>
	<28ab55b3-e699-4487-b332-f1f20a6b22a1@marcan.st>
	<20240419165809.GA4020@willie-the-truck>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 82.132.232.8
X-SA-Exim-Rcpt-To: will@kernel.org, marcan@marcan.st, catalin.marinas@arm.com, mark.rutland@arm.com, zayd_qumsieh@apple.com, ih_justin@apple.com, Houdek.Ryan@fex-emu.org, broonie@kernel.org, ardb@kernel.org, mjguzik@gmail.com, anshuman.khandual@arm.com, oliver.upton@linux.dev, miguel.luis@oracle.com, joey.gouly@arm.com, cpaasch@apple.com, keescook@chromium.org, samitolvanen@google.com, bhe@redhat.com, j.granados@samsung.com, dawei.li@shingroup.cn, akpm@linux-foundation.org, revest@chromium.org, david@redhat.com, shr@devkernel.io, andy.chiu@sifive.com, josh@joshtriplett.org, oleg@redhat.com, deller@gmx.de, zev@bewilderbeest.net, omosnace@redhat.com, ojeda@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 19 Apr 2024 17:58:09 +0100,
Will Deacon <will@kernel.org> wrote:
> 
> On Thu, Apr 11, 2024 at 11:19:13PM +0900, Hector Martin wrote:
> > On 2024/04/11 22:28, Will Deacon wrote:
> > >   * Some binaries in a distribution exhibit instability which goes away
> > >     in TSO mode, so a taskset-like program is used to run them with TSO
> > >     enabled.
> > 
> > Since the flag is cleared on execve, this third one isn't generally
> > possible as far as I know.
> 
> Ah ok, I'd missed that. Thanks.
> 
> > > In all these cases, we end up with native arm64 applications that will
> > > either fail to load or will crash in subtle ways on CPUs without the TSO
> > > feature. Assuming that the application cannot be fixed, a better
> > > approach would be to recompile using stronger instructions (e.g.
> > > LDAR/STLR) so that at least the resulting binary is portable. Now, it's
> > > true that some existing CPUs are TSO by design (this is a perfectly
> > > valid implementation of the arm64 memory model), but I think there's a
> > > big difference between quietly providing more ordering guarantees than
> > > software may be relying on and providing a mechanism to discover,
> > > request and ultimately rely upon the stronger behaviour.
> > 
> > The problem is "just" using stronger instructions is much more
> > expensive, as emulators have demonstrated. If TSO didn't serve a
> > practical purpose I wouldn't be submitting this, but it does. This is
> > basically non-negotiable for x86 emulation; if this is rejected
> > upstream, it will forever live as a downstream patch used by the entire
> > gaming-on-Mac-Linux ecosystem (and this is an ecosystem we are very
> > explicitly targeting, given our efforts with microVMs for 4K page size
> > support and the upcoming Vulkan drivers).
> 
> These microVMs sound quite interesting. What exactly are they? Are you
> running them under KVM?
> 
> Ignoring the mechanism for the time being, would it solve your problem
> if you were able to run specific microVMs in TSO mode, or do you *really*
> need the VM to have finer-grained control than that? If the whole VM is
> running in TSO mode, then my concerns largely disappear, as that's
> indistinguishable from running on a hardware implementation that happens
> to be TSO.

Since KVM has been mentioned a few times, I'll give my take on this.

Since day 1, it was a conscious decision for KVM/arm64 to emulate the
architecture, and only that -- this is complicated enough. Meaning
that no implementation-defined features should be explicitly exposed
to the guest. So I have no plan to expose any such feature for
userspace to configure TSO or anything else of the sort.

However, that doesn't preclude VMs from running in TSO mode if the HW
is configured as such at boot time. From what I have understood, this
is a per translation regime setting (EL1 and EL2 have separate knobs).

So it should be possible to set ACTLR_EL1.TSO=1 from firmware (using
the non-architected ACTLR_EL12 accessor), and let things work without
touching anything else (KVM doesn't context switch this register and
traps accesses to it). This would keep KVM out of the loop, the host
side would be unaffected, and only VMs would pay the overhead of TSO.

I appreciate that this is not the ideal situation, and very much an
all-or-nothing approach. But that's what we can reasonably manage from
an upstream perspective given the variability of the arm64 ecosystem.

	M.

-- 
Without deviation from the norm, progress is not possible.

