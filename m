Return-Path: <linux-kernel+bounces-137152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F91F89DDA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5453F283FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D0132810;
	Tue,  9 Apr 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erWrqUYz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821A136665
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674913; cv=none; b=n4UdHZKqYir9G29uD6wNkNDf6imYZ5u9PaBR6MWEgQI0VLzt4MHvsUWqQ8KdMFGw/MKJ3koikDDmUnxJu3K1cWBYW7285p68wYdegIIWWyHg+ZEtXWOx+NkzQ9SuJj6dqjKvCEDAIje+rrXpGJOBcIxuxPIg6qsJ7BrFgFwPvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674913; c=relaxed/simple;
	bh=Q8oZYTQPe7yxE75cZ/ybR1+HKZVuPqvv9xAWvwwsZDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2BK2jfY65vl8d4Ajaby0KDo8hW1zy3zmYCaE/J24wVhrx6Khn0TNa8Cmw6bv7dMGIxRIS4tAqteZ54FgrL4MWepFFTyBoU0uDnLJmJ2k8exiy9z3320MXN2vQLgyPWECFh5x4EcwIHkHSmNkM4pScGpb+2+4KcRypqvNqPsJXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erWrqUYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718E1C433F1;
	Tue,  9 Apr 2024 15:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712674913;
	bh=Q8oZYTQPe7yxE75cZ/ybR1+HKZVuPqvv9xAWvwwsZDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=erWrqUYzXjcyXobCYeBKxEdKina/eHfaim+ZDs8jUfJxvJlqmpfhE9nQFd1Hi06PD
	 4LwfSGj13rk3Nonpjy0yDfG/0ZHHApJWdrRUWMW4nSHpFY2OATH35My72p0Z92ahft
	 Ri3tMKkglNVrYNT5tHClAE5AEcGufqrW8J/emc3DHShYmx0TiZClXL5jBpxZAXbJDe
	 AsVW9wp7d5njcqSJdx+k1EFO9BD7kkvGZRfp4gM9Rl1tQ2O3lsXjQJefcc8dfWf2AF
	 DcP+94uGbC4IUJqI02PG+e9+lyievw6BXNcVR4r0odJXYMxyyH/XHdaNL3OzQUvJZC
	 I5cnz43Rg1K3g==
Date: Tue, 9 Apr 2024 22:48:28 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clocksource/drivers/timer-clint: Add option to
 use CSR instead of mtime
Message-ID: <ZhVVPB0qD4pBna51@xhacker>
References: <20240406112159.1634-1-jszhang@kernel.org>
 <20240406112159.1634-3-jszhang@kernel.org>
 <20240409-krypton-employed-b2e0e1b46ddf@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409-krypton-employed-b2e0e1b46ddf@spud>

On Tue, Apr 09, 2024 at 03:26:18PM +0100, Conor Dooley wrote:
> On Sat, Apr 06, 2024 at 07:21:58PM +0800, Jisheng Zhang wrote:
> > As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer: add a
> > quirk for lacking mtime register") of opensbi:
> > 
> > "T-Head developers surely have a different understanding of time CSR and
> > CLINT's mtime register with SiFive ones, that they did not implement
> > the mtime register at all -- as shown in openC906 source code, their
> > time CSR value is just exposed at the top of their processor IP block
> > and expects an external continous counter, which makes it not
> > overrideable, and thus mtime register is not implemented, even not for
> > reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
> > extended CSR, these systems still rely on the mtimecmp registers to
> > generate timer interrupts. This makes it necessary to implement T-Head
> > C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
> > reading mtime register and falls back to default code that reads time
> > CSR."
> > 
> > To use the clint in RISCV-M NOMMU env on Milkv Duo little core, we
> > need to fall back to read time CSR instead of mtime register. Add the
> > option for this purpose.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 34faa0320ece..7bbdbf2f96a8 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -650,6 +650,15 @@ config CLINT_TIMER
> >  	  This option enables the CLINT timer for RISC-V systems.  The CLINT
> >  	  driver is usually used for NoMMU RISC-V systems.
> >  
> > +config CLINT_USE_CSR_INSTEADOF_MTIME
> > +	bool "Use TIME CSR instead of the mtime register"
> > +	depends on CLINT_TIMER
> > +	help
> > +	  Use TIME CSR instead of mtime register. Enable this option if
> > +	  prefer TIME CSR over MTIME register, or if the implementation
> > +	  doesn't implement the mtime register in CLINT, so fall back on
> > +	  TIME CSR.
> 
> This, as a Kconfig option, seems a bit strange to me. We know at runtime
> if we are on a T-Head device without the mtime register and should be
> able decide to use the CSR implementation dynamically in that case,
> right?

Dynamically decision can be done in clocksource/clockevnt:
I can patch clint_clocksource.read to point to different clint_rdtime()
implementation.

But clint timer is also used in NOMMU RISCV-M's get_cycles(), this
can't be dynamically chosen w/o an ugly "if (is_c900)"
check, and I'm not sure whether this check in get_cycles() will
introduce non-trival overhead or not. Or use code patching technology
here?

Or introduce a function pointer such as unsigned long (*rdtime)(void)
for RISCV_M_MODE, then point it to different implementation?

Any suggestion is welcome.
Thanks

