Return-Path: <linux-kernel+bounces-97096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B287656F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32C71F247F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E190381C7;
	Fri,  8 Mar 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kLUHAbXN"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EFA374E9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904917; cv=none; b=PJyAwsozCmMdX4G946L3ptit8mN02FiLK4y/mb77Qq4zRSCJ1IDVOGiYLn+yNpsuoFBm/Nhm7f6A9uJ2t2DIqa+k5x3hInsGW5TuMG+cS/vEDN5boiOcGZEuFjpGq7pZgYeTpnMMVRGfXK/J2XMLqlaOyyOEPKDH7AtRJ/ckNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904917; c=relaxed/simple;
	bh=l60pAB2x58G03355kGifkeDRz6n4tbmTBdawv9Ulpu8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vclb7GezWAe81n0XL2qhh3GkqA1Cusm1gTERoQIH+eMSF9DDnUbv6XG3Ae3rmulX2Cfchs9GhMKrK+QqzB2QWD1LDaobYJX4r2hTXGmFRGgTKP6cmBPNJmJZU5W/5Xgg9E5xrxQLcJGXnPNurYQskj4HI9Gruk7G337edREbywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kLUHAbXN; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1636448A98
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709904905;
	bh=KfFTaYyXhA0LmPtbUGAWhlL1dAhtAs2GiC0vdA6Ii4k=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=kLUHAbXN64Ht8OarTKJRlpyeyeN3irXaS7O6tB3bYSO6kAhDP0DRhAdcknG/Kg8j+
	 nn9KP6bBus4XPJyceGyq8l4Er+Zv/WfkZ2fuISzD5ATzl40roWHlSV7TdXoyHSuoag
	 x2NH2T3euLHJKCgON/kpUpCpHR5BWIJJYkom3+tc2vGG5X22U9SEVfvTm+BHf7pKhW
	 rYfVjCfemIYD951ykuzQ5c4PuVGSg+8FUm0if191N+QyMogYi+iV0SVMyHDWo/s8/B
	 x48WuuR1/y8Bt4O/S4fQSn/ROuzK8QqvRYWZwIvnjx3hyxsiqReETMPRDUnjovjUHC
	 I6LFY+uL3cKKA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-42ef6a1b6b6so8629851cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 05:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709904904; x=1710509704;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfFTaYyXhA0LmPtbUGAWhlL1dAhtAs2GiC0vdA6Ii4k=;
        b=BqtaYyrvkE5sIO/F2hspUp+3Qc03tNBUitCIxSs+mLAY13HyDePT0emrMDDpZJ8fld
         CoDe+1sqWovW7AqaIg5/FftFy2DeufdX4CijmJSYGq96MXenhjt3TSYxto3VKvku+DQ2
         OVAWaOwLkjd79CkSi1uzME/90UZoBCpNFj/9SuZaT+SL2FITrPswGwsN9Ngmk46LMJkG
         KIizcg0yaV6rJnQt/+8D90F5018qjDxVWCg+RAHRNlX0lpJikhsrvvksC9+6BKAsDwei
         rdK52+JGecdev9sPeaFcBLuQrtd/7DjVv9qxkrpproVgwdhIpkZ07vHwJqHLazNZPNto
         e1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSilQvJ+mWd1TYbJFfbCG1Ln7ru8nq7I4hcpDJZqzlluEWZlYPC7KxQQoN3eoPtPBgh2S6vVm34bbUGB1ReyI3bAIf06IubAvr4rO6
X-Gm-Message-State: AOJu0YxPf5AnQSEubfKAH1IRiCV2C7td2XmYrb4oCVh/9sbe4s6HzG+g
	69BAW4DMW+zYi+CRxu0Vte2RFnj30ruKnl8rih1ZZ7/HuFs/RbsLmliWKkwa+9LvzbMr0/DjJUn
	x4Q2rnm5b3KSl0D/0cOoAwK9FXUyncTYI7G2kUaHLC5F3elX+EeqvlUM1ql9IPhv+VFdL4PBkGe
	eZl0deMc2gtY1A1kfe6fArM8cwaty2XJJaPOuWc3sKU04Q2v2Mj+Li
X-Received: by 2002:ac8:5792:0:b0:42e:d641:b17c with SMTP id v18-20020ac85792000000b0042ed641b17cmr12663726qta.62.1709904903808;
        Fri, 08 Mar 2024 05:35:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFWPweaTc5T39BhG+37jBadbuOfJ1uLHa+LrhI0fCpfgsFaZBrzlrJv3P3sJsRMiH/4i9DBQ2T5AYcKlGfOrs=
X-Received: by 2002:ac8:5792:0:b0:42e:d641:b17c with SMTP id
 v18-20020ac85792000000b0042ed641b17cmr12663713qta.62.1709904903530; Fri, 08
 Mar 2024 05:35:03 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Mar 2024 05:35:03 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240308-docile-pretense-b44c3a84d8b2@wendy>
References: <20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com>
 <20240307-disable_misaligned_probe_config-v8-4-55d696cb398b@rivosinc.com>
 <CAJM55Z9SYA=QMg0Wg-e0Q8nOTP6qSKkc+kxHMGOmmmWrEcVf7w@mail.gmail.com> <20240308-docile-pretense-b44c3a84d8b2@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 8 Mar 2024 05:35:03 -0800
Message-ID: <CAJM55Z8EX5D0HZ1xKTkaQEL1RF46DrBynUoTSMP5q8kmDGY_=w@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] riscv: Set unaligned access speed at compile time
To: Conor Dooley <conor.dooley@microchip.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, 
	Evan Green <evan@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	linux-riscv@lists.infradead.org, Charles Lohr <lohr85@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Conor Dooley wrote:
> On Fri, Mar 08, 2024 at 01:52:24AM -0800, Emil Renner Berthing wrote:
> > Charlie Jenkins wrote:
>
> > >  config RISCV_MISALIGNED
> > > -	bool "Support misaligned load/store traps for kernel and userspace"
> > > +	bool
> > >  	select SYSCTL_ARCH_UNALIGN_ALLOW
> > > -	default y
> > >  	help
> > > -	  Say Y here if you want the kernel to embed support for misaligned
> > > -	  load/store for both kernel and userspace. When disable, misaligned
> > > -	  accesses will generate SIGBUS in userspace and panic in kernel.
> > > +	  Embed support for misaligned load/store for both kernel and userspace.
> > > +	  When disabled, misaligned accesses will generate SIGBUS in userspace
> > > +	  and panic in the kernel.
> >
> > Hmm.. this is *may* generate SIGBUS in userspace and panic the kernel. The CPU
> > could support unaligned access natively or there might be a handler in M-mode,
> > right?
>
> Correct. The last sentence could become "When disabled, and there is no
> support in hardware or firmware, unsigned accesses will...". That said,
> this option is no longer user visible, so we could really simplify the
> hell out of this option to just mention that it controls building the
> in-kernel emulator.
>
> > > +choice
> > > +	prompt "Unaligned Accesses Support"
> > > +	default RISCV_PROBE_UNALIGNED_ACCESS
> > > +	help
> > > +	  This determines the level of support for unaligned accesses. This
> > > +	  information is used by the kernel to perform optimizations. It is also
> > > +	  exposed to user space via the hwprobe syscall. The hardware will be
> > > +	  probed at boot by default.
> > > +
> > > +config RISCV_PROBE_UNALIGNED_ACCESS
> > > +	bool "Probe for hardware unaligned access support"
> > > +	select RISCV_MISALIGNED
> > > +	help
> > > +	  During boot, the kernel will run a series of tests to determine the
> > > +	  speed of unaligned accesses. This probing will dynamically determine
> > > +	  the speed of unaligned accesses on the underlying system. If unaligned
> > > +	  memory accesses trap into the kernel as they are not supported by the
> > > +	  system, the kernel will emulate the unaligned accesses to preserve the
> > > +	  UABI.
> > > +
> > > +config RISCV_EMULATED_UNALIGNED_ACCESS
> > > +	bool "Emulate unaligned access where system support is missing"
> > > +	select RISCV_MISALIGNED
> > > +	help
> > > +	  If unaligned memory accesses trap into the kernel as they are not
> > > +	  supported by the system, the kernel will emulate the unaligned
> > > +	  accesses to preserve the UABI. When the underlying system does support
> > > +	  unaligned accesses, the unaligned accesses are assumed to be slow.
> >
> > It's still not quite clear to me when you'd want to choose this over probing
> > above. Assuming the probe measures correctly this can only result in a kernel
> > that behaves the same or slower than with the option above, right?
>
> Aye, mostly the same - some people don't want the boot-time overhead
> of actually running the profiling code, so this option is for them.
> Maybe that's not such a big deal anymore with the improvements to do it
> in parallel, but given how bad performance on some of the systems is
> when firmware does the emulation, it is definitely still noticeable.
> I know we definitely have customers that care about their boot time very
> strongly, so I can imagine they'd be turning this off.

Ah, that makes sense. So maybe a help text more along the lines of "Disable
probing and optimizations for CPUs with fast unaligned memory access" would be
a better description of this choice?

> > > +
> > > +config RISCV_SLOW_UNALIGNED_ACCESS
> > > +	bool "Assume the system supports slow unaligned memory accesses"
> > > +	depends on NONPORTABLE
> > > +	help
> > > +	  Assume that the system supports slow unaligned memory accesses. The
> > > +	  kernel and userspace programs may not be able to run at all on systems
> > > +	  that do not support unaligned memory accesses.
> >
> > Again you're just explicitly saying no to the optimizations the kernel might do
> > if it detects fast unaligned access, only here you'll also crash if they're not
> > handled by the CPU or M-mode. Why would you want that?
> >
> > I'm probably missing something, but the only reason I can think of is if you
> > want build a really small kernel and save the few bytes for the handler and
> > probing code.
>
> Aye, just to allow you to disable the in-kernel emulator. That's
> currently a choice that is presented to people, so this option preserves
> that. IMO this is by far the least useful option and is locked behind
> NONPORTABLE anyway. Maybe we could delete it, and if someone really wants
> it, it would not be all that much of a hassle to add back in the future?

Yeah, if noone really needs this less config options is better, but I don't
feel strongly about this option either way.

/Emil

