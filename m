Return-Path: <linux-kernel+bounces-46914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B97A1844650
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25441C248F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1E512DD98;
	Wed, 31 Jan 2024 17:39:13 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD67EF1B;
	Wed, 31 Jan 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722752; cv=none; b=oYWkR3GWW5eHW8XBBlkw3d78MJkA+E9xkNLFfKqurwyk0i+6Hh007O8lTBkLjk5sdlUjBo0nBwgkpnHBFIhqDPO+1Q1qT/DApKR2bbLWgfQnHmA6IqTIoF+SNwKcNTwgHJSPJOmaNSvZ73cHVrPR7x6u74l/kumLJu8di315PqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722752; c=relaxed/simple;
	bh=OFT2TTaNZFqkCFZHSRumoIucbTcCxvOYc+uwdG7w6iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXCqwqy03XygWOsAMOkpedm6L2ORAUo/+6SnjvD+o8NuOFgNxNY+X7vNepyaT6nN2Fe2MCfZL9lzCCrTHC4ZcGx4TdrQMpWJRVRAzYos5ZwOywLFD+x340wlX1wB/wPr2m1GZIKPCTNeDACqLFoUEneTnqrbMWvcfZ7AP8Y7UQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 40VHcwJh013476;
	Wed, 31 Jan 2024 18:38:58 +0100
Date: Wed, 31 Jan 2024 18:38:58 +0100
From: Willy Tarreau <w@1wt.eu>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] lib: add CPU MHz benchmark test
Message-ID: <ZbqFsroYDjSoYEps@1wt.eu>
References: <a2396ae072d6f9e009b5de558efe166b844a1397.1706718625.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2396ae072d6f9e009b5de558efe166b844a1397.1706718625.git.geert+renesas@glider.be>

Hi Geert,

On Wed, Jan 31, 2024 at 05:46:48PM +0100, Geert Uytterhoeven wrote:
> When working on SoC bring-up, (a full) userspace may not be available,
> making it hard to benchmark the CPU performance of the system under
> development.  Still, one may want to have a rough idea of the (relative)
> performance of one or more CPU cores, especially when working on e.g.
> the clock driver that controls the CPU core clock(s).
> 
> Hence add the CPU MHz benchmark test[1], which estimates the clock
> frequency of the CPU core it is running on, and make it available as a
> Linux kernel test module.
> 
> When built-in, this benchmark can be run without any userspace present.

That's a great idea, I never thought about turning it into a module!

> Parallel runs (run on multiple CPU cores) are supported, just kick the
> "run" file multiple times.

Hmmm does it mean it will run on the CPU that writes this "run" ?
Because this could allow one to start tests using e.g.:

    taskset -c $CPU tee /sys/.../run <<< y

But we could also wonder if it wouldn't be easier to either send "y"
to /sys/.../cpu0/run or may just send the CPU number to "run" instead
of "y". In my experience with this tool, you most always want to easily
control the CPU number because SoCs these days are not symmetrical at
all.

> This has been tested on the folowing CPU cores:
>   - ARM: Cortex A7, A9, and A15,
>   - ARM64: Cortex A53, A55, A57, and A76,
>   - m68k: MC68040,
>   - MIPS: TX4927,
>   - RISC-V: AndesTech AX45, Kendryte K210, SiFive U54 and U74, VexRiscV.
>   - SuperH: SH7751R.
> The reported figures are usually within 1-2% of the actual CPU clock
> rate.

Nice!

> Known issues:
>   - The reported value is off on the following systems:
>       - RBTX4927: 120 MHz (should be 200 MHz, userspace mhz is OK)
> 	  user: count=76500 us50=19990 us250=96885 diff=76895 cpu_MHz=198.973
> 	  kernel:     43663      19943       93024                    119
> 	  msleep(1000) does sleep 1s, and ktime_get() advances accordingly
>       - RZ/Five: 1971 MHz (should be 1000 MHz, userspace mhz not tested)
> 	  kernel:    679625      20001       88962                   1971
> 	  msleep(1000) does sleep 1s, and ktime_get() advances accordingly
>       - VexRiscV: 12 MHz (should be 64 MHz, userspace mhz not tested)
>     I assume this is due to different optimization flags.
>     I haven't compared the generated code yet.

That's strange. I only ever managed to get off results at -O0, but at
-O1/-Og/-Os/-O2/-O3/-Ofast I've always got consistent results on all
the machines I've tested. Especially seeing results higher than the
real value is troubling. One possibility would be that one some archs
there's not enough registers and the compiler needs to use a variable
in the stack, but that could only explain the lower perf, not the higher
one. But indeed, it could be interesting to have a look at the code to
understand why it's doing that. If we figure that there's an inherent
limitation on some rare archs, in the worst case we could place a
warning there.

>   - On fast systems with a large clock granularity (e.g. ARAnyM running
>     Linux/m68k), the measured durations for the short and long loops may
>     be identical, causing division-by-zero exceptions.
>     The same happens with the userspace version, cfr.
>     https://github.com/wtarreau/mhz/issues/5.

I've responded there and we definitely need to address this, thanks!

Another point is that it would be nice if there was a way to present
the result in a form that a script can retrieve from the directory,
maybe the last measurement or something like this. I know that scripts
are commonly used to check for a machine's correct behavior, and I try
to encourage users to verify that it's working well, so anything we can
do that makes it easier to use would be welcome.

But overall, I like it! You've got my ack.

Hmmm I don't know if this is intended, the SPDX tag says MIT but the
MODULE_LICENSE at the top says MIT/GPL. I can't say I care that much but
I preferred to report it in case it's an accident ;-)

Thanks!
Willy

