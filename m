Return-Path: <linux-kernel+bounces-138357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C411A89F018
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619E21F23235
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854615921B;
	Wed, 10 Apr 2024 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVOhSl2x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D4154C00
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745818; cv=none; b=oSkgqcQ0gbNJyF876trCuq8Zm83suU6FVaYa7KYn7oJvsRlt7fdjxRq5nlBNeCCaLVwMbP+OVofdSOgQpJIm/46X6ffR7gwr3+MoVd/2OEAUIQmUTrqpZAGFim/n2er+x2SRrX8f/5zBVsru8vo4WdyJwRfkW0iv8HNdPSI1EtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745818; c=relaxed/simple;
	bh=F2uId5jnhTOHuSWdCNV89q9EehcaDMvEPq2uWVgwVAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpJQmsyuzeJw+DVuBFtfq7MBpQXinOSVPKSpk3m2eMOzgkvXa6wXMZqvXIKO53BqfRLAoyaBxrgT9fQBBypHioY4btLPAN7oVW9kjeTjvvzdzjBKMzZML7piYhsiIxRmImTPrfNwToTqiAbD/SMC+N6EY+YG7AexMsFd/1dn3f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVOhSl2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD9CC433C7;
	Wed, 10 Apr 2024 10:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712745818;
	bh=F2uId5jnhTOHuSWdCNV89q9EehcaDMvEPq2uWVgwVAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVOhSl2xqE/Euo0SyKzBTJJicqtADWb3WcxStLD8a3Q2j9UD8vw16QQepslDJQgzB
	 eY3sAlAL19W+yWptx+ThleiwIq79mVtO7allc9YetRZ4uuco7juVIFEGp63HtIqb22
	 fO87/EE5kjyW4WxI905mRDk06uTb8U4e9sYkFt0nAuBEVUdqAArB/VLpAkOXp105ZB
	 2v4nTxrUMGgf/7O9YthaTIYyrVc2CMlTXy5dpRQ59wMqbZ+h9WusNUzxw+WF5FhhRL
	 A0dDJiLbCLXgEeEtWcMTENsMRPHBSWQdB1hrgG3KBKx9ZsPjTiKmNsRDAAS7vbe8yW
	 7/kIvEND+BhMQ==
Date: Wed, 10 Apr 2024 18:30:13 +0800
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
Message-ID: <ZhZqNbbUyPhVzekO@xhacker>
References: <20240406112159.1634-1-jszhang@kernel.org>
 <20240406112159.1634-3-jszhang@kernel.org>
 <20240409-krypton-employed-b2e0e1b46ddf@spud>
 <ZhVVPB0qD4pBna51@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhVVPB0qD4pBna51@xhacker>

On Tue, Apr 09, 2024 at 10:48:33PM +0800, Jisheng Zhang wrote:
> On Tue, Apr 09, 2024 at 03:26:18PM +0100, Conor Dooley wrote:
> > On Sat, Apr 06, 2024 at 07:21:58PM +0800, Jisheng Zhang wrote:
> > > As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer: add a
> > > quirk for lacking mtime register") of opensbi:
> > > 
> > > "T-Head developers surely have a different understanding of time CSR and
> > > CLINT's mtime register with SiFive ones, that they did not implement
> > > the mtime register at all -- as shown in openC906 source code, their
> > > time CSR value is just exposed at the top of their processor IP block
> > > and expects an external continous counter, which makes it not
> > > overrideable, and thus mtime register is not implemented, even not for
> > > reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
> > > extended CSR, these systems still rely on the mtimecmp registers to
> > > generate timer interrupts. This makes it necessary to implement T-Head
> > > C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
> > > reading mtime register and falls back to default code that reads time
> > > CSR."
> > > 
> > > To use the clint in RISCV-M NOMMU env on Milkv Duo little core, we
> > > need to fall back to read time CSR instead of mtime register. Add the
> > > option for this purpose.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > 
> > > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > > index 34faa0320ece..7bbdbf2f96a8 100644
> > > --- a/drivers/clocksource/Kconfig
> > > +++ b/drivers/clocksource/Kconfig
> > > @@ -650,6 +650,15 @@ config CLINT_TIMER
> > >  	  This option enables the CLINT timer for RISC-V systems.  The CLINT
> > >  	  driver is usually used for NoMMU RISC-V systems.
> > >  
> > > +config CLINT_USE_CSR_INSTEADOF_MTIME
> > > +	bool "Use TIME CSR instead of the mtime register"
> > > +	depends on CLINT_TIMER
> > > +	help
> > > +	  Use TIME CSR instead of mtime register. Enable this option if
> > > +	  prefer TIME CSR over MTIME register, or if the implementation
> > > +	  doesn't implement the mtime register in CLINT, so fall back on
> > > +	  TIME CSR.
> > 
> > This, as a Kconfig option, seems a bit strange to me. We know at runtime
> > if we are on a T-Head device without the mtime register and should be
> > able decide to use the CSR implementation dynamically in that case,
> > right?
> 
> Dynamically decision can be done in clocksource/clockevnt:
> I can patch clint_clocksource.read to point to different clint_rdtime()
> implementation.
> 
> But clint timer is also used in NOMMU RISCV-M's get_cycles(), this
> can't be dynamically chosen w/o an ugly "if (is_c900)"
> check, and I'm not sure whether this check in get_cycles() will
> introduce non-trival overhead or not. Or use code patching technology
> here?

Hi,

After some tests, I think will go with code patching path, I.E use
static_branch in get_cycles(). New version is under cooking.

Thanks
> 
> Or introduce a function pointer such as unsigned long (*rdtime)(void)
> for RISCV_M_MODE, then point it to different implementation?
> 
> Any suggestion is welcome.
> Thanks

