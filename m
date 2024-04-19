Return-Path: <linux-kernel+bounces-151798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1078AB3FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D64E285E58
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07987137C37;
	Fri, 19 Apr 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpJ0e1ui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25313775C;
	Fri, 19 Apr 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545899; cv=none; b=qXxa+dMJd/UrjgEvYrJDY8GpxOXo6o7MUjEcqLMZja5hKRbkkvjVLk7saO6N6NSDeEPIkeqG5h4f+Ceeq4n7zz6yYc4w6jUSbrR1lgXFtm+9SVkN9JPFMUepUUxT3YuyvnYjVPUosCHsADj+9XtJQptFu03W+9iBC//HGHbuS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545899; c=relaxed/simple;
	bh=fY83VWfSR+QZWsluWoCGu1XQqdbdOrpZq6vnbqfPttE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCuP7nQLtnJ2cnC84D48R6HvwArwt/nDXBvT9aCXwA8/43aVyUiEwL5FU/Hkzq92mZ39zi0xLDpQNU1OWC1KLbG299dOYbcqcgEljiF/FITDnQbpknvqngB+cVmfJbfKP15DTWxDm7Z6BItMmIUJLTa6bzhjbS2wZaetuCdu3fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpJ0e1ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE430C072AA;
	Fri, 19 Apr 2024 16:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713545898;
	bh=fY83VWfSR+QZWsluWoCGu1XQqdbdOrpZq6vnbqfPttE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpJ0e1uitz/zirsN92RbRzCEyXBo/Sp+jhhHLhOhV65B4G+SHDf9/nub1A1xCHEb6
	 wmxY7JqARYjd/T+800sl1l4b7c4Y4VxUwIjDB8bogUJKKC6SoQSFfENoWdVkGPW5C3
	 LxPniduOqhzKLZ1tQoM/jfl86SklOQ2uJD0VPqrsFhsP2j6bezrqzOE81U2LNZt6EL
	 geKn0NxgW56ElmeUibatHBPpi1WzGd00eTaHwJ6y9zmvK29R0rY7NImLmdCQTpumvW
	 KBzhB8y28ryyn93ds5LCMGlzm0+1EEaHt1DnJ8JftKnQ3cKJ7XfeZF18ajyGekdNnS
	 0cQbqLo53DHTQ==
Date: Fri, 19 Apr 2024 17:58:09 +0100
From: Will Deacon <will@kernel.org>
To: Hector Martin <marcan@marcan.st>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Zayd Qumsieh <zayd_qumsieh@apple.com>,
	Justin Lu <ih_justin@apple.com>,
	Ryan Houdek <Houdek.Ryan@fex-emu.org>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>,
	Dawei Li <dawei.li@shingroup.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florent Revest <revest@chromium.org>,
	David Hildenbrand <david@redhat.com>,
	Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>,
	Zev Weiss <zev@bewilderbeest.net>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
Message-ID: <20240419165809.GA4020@willie-the-truck>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
 <20240411132853.GA26481@willie-the-truck>
 <28ab55b3-e699-4487-b332-f1f20a6b22a1@marcan.st>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ab55b3-e699-4487-b332-f1f20a6b22a1@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Apr 11, 2024 at 11:19:13PM +0900, Hector Martin wrote:
> On 2024/04/11 22:28, Will Deacon wrote:
> >   * Some binaries in a distribution exhibit instability which goes away
> >     in TSO mode, so a taskset-like program is used to run them with TSO
> >     enabled.
> 
> Since the flag is cleared on execve, this third one isn't generally
> possible as far as I know.

Ah ok, I'd missed that. Thanks.

> > In all these cases, we end up with native arm64 applications that will
> > either fail to load or will crash in subtle ways on CPUs without the TSO
> > feature. Assuming that the application cannot be fixed, a better
> > approach would be to recompile using stronger instructions (e.g.
> > LDAR/STLR) so that at least the resulting binary is portable. Now, it's
> > true that some existing CPUs are TSO by design (this is a perfectly
> > valid implementation of the arm64 memory model), but I think there's a
> > big difference between quietly providing more ordering guarantees than
> > software may be relying on and providing a mechanism to discover,
> > request and ultimately rely upon the stronger behaviour.
> 
> The problem is "just" using stronger instructions is much more
> expensive, as emulators have demonstrated. If TSO didn't serve a
> practical purpose I wouldn't be submitting this, but it does. This is
> basically non-negotiable for x86 emulation; if this is rejected
> upstream, it will forever live as a downstream patch used by the entire
> gaming-on-Mac-Linux ecosystem (and this is an ecosystem we are very
> explicitly targeting, given our efforts with microVMs for 4K page size
> support and the upcoming Vulkan drivers).

These microVMs sound quite interesting. What exactly are they? Are you
running them under KVM?

Ignoring the mechanism for the time being, would it solve your problem
if you were able to run specific microVMs in TSO mode, or do you *really*
need the VM to have finer-grained control than that? If the whole VM is
running in TSO mode, then my concerns largely disappear, as that's
indistinguishable from running on a hardware implementation that happens
to be TSO.

> That said, I have a pragmatic proposal here. The "fixed TSO" part of the
> implementation should be harmless, since those CPUs would correctly run
> poorly-written applications anyway so the API is moot. That leaves Apple
> Silicon. Our native kernels are and likely always will be 16K page size,
> due to a bunch of pain around 16K-only IOMMUs (4K kernels do boot
> natively but with very broken functionality including no GPU
> acceleration) plus performance differences that favor 16K. How about we
> gate the TSO functionality to only be supported on 4K kernel builds?
> This would make them only work in 4K VMs on Asahi Linux. We are very
> explicitly discouraging people from trying to use the microVMs to work
> around page size problems (which they can already do, another
> fragmentation problem, anyway); any application which requires the 4K VM
> to run that isn't an emulator is already clearly broken and advertising
> that fact openly. So, adding TSO to this should be only a marginal risk
> of further fragmentation, and it wouldn't allow apps to "sneakily" "just
> work" on Apple machines by abusing TSO.

I appreciate that you're trying to be constructive here, but I don't think
we should tie this to the page size. It's an artifical limitation and I
don't think it really addresses the underlying concerns that I have.

Will

