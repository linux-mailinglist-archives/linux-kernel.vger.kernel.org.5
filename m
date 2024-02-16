Return-Path: <linux-kernel+bounces-69287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CE08586A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9491C1C20FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F583139573;
	Fri, 16 Feb 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YNtWCZN+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QdVOnBs3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5CB12FF60;
	Fri, 16 Feb 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114937; cv=none; b=fdFZ99MKkc3QjERHWlLb9MIQFJSmy/A8txiGVgduQnwvp2nor64uHmNN+mV3+HXMzSZjdvbOJ552ZtoHe5N1DTbKMRJLUAIrQnwNWDlPUMD93G5bMKCGYtT/lTw/CKJ82+A2vmAmsTfmmVqx7Nkzs14BbV5py386iGBTuvf2QXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114937; c=relaxed/simple;
	bh=nypb2KZnPJWR1XM7XwoJ16qmP0FPMeXO2miQqYZ+euc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NOkRVgMjejxNga2bXFF+kBKZlxfpv5bSsOodeaiPAaAh6ITcGPmce8pR4NcuOqooq2ti3MkGTYtglCqnCIYhPVobvoShjmHQtdvYacfCjby/0ROeDdI3gIm9GfcDFyB+iQmPSOD3DQLCIXbXh8WARoQo3a31NSjbzFraAMYlsbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YNtWCZN+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QdVOnBs3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708114934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=le97KJdlsGBLqsiJ8aQfiKStXYCU6YwRihA6kx6vD50=;
	b=YNtWCZN+oyza7Psrnp+o015RwbGOpg7nwPBmGlhWYhJoroMvc1j1yPwMbdlPkFxbZ099DY
	cStpTLOPTTibGQZ6dRsFGbknNWj8VO1bsaW0+eIPgqMroaaMzbPCD9kzTrmYNUuMFWb7Rj
	ujCSgGzYaticow53nctzXgJ7gXOWC7OHA853+v+EVBm0Dfhgy8aJUr2OraiKqXEDadV/3w
	6oHgKU9uZR+LgRSztvgBVrr5BHhCt3HKME+aXGG9fOPGB7PbQ3OGIwarKrqfLDj1DRPg+y
	ibA8yxPAnWLA+2R6lNb0h0dxwF1h8gILaiyDbknkPS3KZEXgJ990PuKUR4aPzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708114934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=le97KJdlsGBLqsiJ8aQfiKStXYCU6YwRihA6kx6vD50=;
	b=QdVOnBs3rHq1ra9e49kCrw2tSi/Be1PmqZXRATLKXzAosslD2EHYAtI+BnLejPsm8NkGNU
	OKEsdip73eiy+dBQ==
To: Anup Patel <anup@brainfault.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Marc Zyngier
 <maz@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Atish Patra
 <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 14/25] irqchip/sifive-plic: Convert PLIC driver into
 a platform driver
In-Reply-To: <CAAhSdy2aeyJBcMVre12jGwU52oP9Z=1emB-bcYxygdR3QhP+6w@mail.gmail.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-15-apatel@ventanamicro.com> <87jzn4ctks.ffs@tglx>
 <CAAhSdy2aeyJBcMVre12jGwU52oP9Z=1emB-bcYxygdR3QhP+6w@mail.gmail.com>
Date: Fri, 16 Feb 2024 21:22:13 +0100
Message-ID: <878r3kcg7e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16 2024 at 22:41, Anup Patel wrote:
> On Fri, Feb 16, 2024 at 9:03=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> I don't think that removing the setup protection is correct.
>>
>> Assume you have maxcpus=3DN on the kernel command line, then the above
>> for_each_online_cpu() loop would result in cpuhp_setup =3D=3D true when =
the
>> instances for the not onlined CPUs are set up, no?
>
> A platform can have multiple PLIC instances where each PLIC
> instance targets a subset of HARTs (or CPUs).
>
> Previously (before this patch), we were probing PLIC very early so on
> a platform with multiple PLIC instances, we need to ensure that cpuhp
> setup is done only after PLIC context associated with boot CPU is
> initialized hence the plic_cpuhp_setup_done check.
>
> This patch converts PLIC driver into a platform driver so now PLIC
> instances are probed after all available CPUs are brought-up. In this
> case, the cpuhp setup must be done only after PLIC context of all
> available CPUs are initialized otherwise some of the CPUs crash
> in plic_starting_cpu() due to lack of PLIC context initialization.

You're missing the point.

Assume you have 8 CPUs and 2 PLIC instances one for CPU0-3 and one for
CPU4-7.

Add "maxcpus=3D4" on the kernel command line, then only the first 4 CPUs
are brought up.

So at probe time cpu_online_mask has bit 0,1,2,3 set.

When the first PLIC it probed the loop which checks the context for each
online CPU will not clear cpuhp_setup and the hotplug state is installed.

Now the second PLIC is probed (the one for the offline CPUs 4-7) and the
loop will again not clear cpuhp_setup and it tries to install the state
again, no?

Thanks,

        tglx

