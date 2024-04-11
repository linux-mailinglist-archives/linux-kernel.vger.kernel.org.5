Return-Path: <linux-kernel+bounces-140506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8798A158A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C8D285780
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B914EC5A;
	Thu, 11 Apr 2024 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKoSzUBS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360714D432;
	Thu, 11 Apr 2024 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842144; cv=none; b=bf6RsdA8sSUx4ADsfPzEHnhWHfJUrml+3xdQGdT0a9jkv5bCYD48ObUhoukAefF+DLpoaueUJAOgTCuhHHYDM/KwmrReV8qRQ4aS70sDIhth1DZcVo9RJiEe6ySwdre/K0Y4MQzhRcuz2WGww/md12BB8k2kphlp6tD6MWJMZdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842144; c=relaxed/simple;
	bh=gUdPGNpqUc9YmdjxtvqHwxuSQo6lbsOe/wMJ91M4o0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJkm3g2Os+vZ3BMaGz4CXZSo4RRVmXXj9EB2rUm90bPvMEAmk2Q2AIM2E4Dpmvk1AJkKLBjuAchpO1k4CiUpFmdgsx4hKg4JejtdS4A43k5kK921Cw3Z8JDLfxaQZk9iDODh+VKrlQj5GgrJ1swoRh73S2CcLh+waK1Nqoxqovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKoSzUBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB70C2BBFC;
	Thu, 11 Apr 2024 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712841795;
	bh=gUdPGNpqUc9YmdjxtvqHwxuSQo6lbsOe/wMJ91M4o0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKoSzUBSJR3KbMhdCG1CHI6hpF0gXlRuAvgMgnJu3Btuu7SakSzaUvgpYTcIqkIEc
	 jgmJGBdpkyTo0lA+qAr0005WzjFF+rKzBEeaWW2AJ1BxyLdtuuDmzyM+CHRqXSfxEs
	 H6rZNWX8bJ7fmqEkP4X4qFKPD24zqJfBSDiSWnTE+jSaqUrzTf5mGMl/ZZg4s1fYdp
	 ucoWdQToXGS8Xvysk5dNy3OEIQzLISY9ijErrqIZQ6csx46lZ6JO76X+mukuZXZdQH
	 LCzebE+5MA3IfDrazx2LsqtBN2CHGRafShYpWzoI7CTN5Xsx+GrJsNV0g5/lUIAOxk
	 gLYmU8Zrcw2Gw==
Date: Thu, 11 Apr 2024 14:28:54 +0100
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
Message-ID: <20240411132853.GA26481@willie-the-truck>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-tso-v1-0-754f11abfbff@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Hector,

On Thu, Apr 11, 2024 at 09:51:19AM +0900, Hector Martin wrote:
> x86 CPUs implement a stricter memory modern than ARM64 (TSO). For this
> reason, x86 emulation on baseline ARM64 systems requires very expensive
> memory model emulation. Having hardware that supports this natively is
> therefore very attractive. Such hardware, in fact, exists. This series
> adds support for userspace to identify when TSO is available and
> toggle it on, if supported.

I'm probably going to make myself hugely unpopular here, but I have a
strong objection to this patch series as it stands. I firmly believe
that providing a prctl() to query and toggle the memory model to/from
TSO is going to lead to subtle fragmentation of arm64 Linux userspace.

It's not difficult to envisage this TSO switch being abused for native
arm64 applications:

  * A program no longer crashes when TSO is enabled, so the developer
    just toggles TSO to meet a deadline.

  * Some legacy x86 sources are being ported to arm64 but concurrency
    is hard so the developer just enables TSO to (mostly) avoid thinking
    about it.

  * Some binaries in a distribution exhibit instability which goes away
    in TSO mode, so a taskset-like program is used to run them with TSO
    enabled.

In all these cases, we end up with native arm64 applications that will
either fail to load or will crash in subtle ways on CPUs without the TSO
feature. Assuming that the application cannot be fixed, a better
approach would be to recompile using stronger instructions (e.g.
LDAR/STLR) so that at least the resulting binary is portable. Now, it's
true that some existing CPUs are TSO by design (this is a perfectly
valid implementation of the arm64 memory model), but I think there's a
big difference between quietly providing more ordering guarantees than
software may be relying on and providing a mechanism to discover,
request and ultimately rely upon the stronger behaviour.

An alternative option is to go down the SPARC RMO route and just enable
TSO statically (although presumably in the firmware) for Apple silicon.
I'm assuming that has a performance impact for native code?

Will

P.S. I briefly pondered the idea of the kernel toggling the bit in the
ELF loader when e.g. it sees an x86 machine type but I suspect that
doesn't really help with existing emulators and you'd still need a way
to tell the emulator whether or not it was enabled.

