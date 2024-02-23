Return-Path: <linux-kernel+bounces-77971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09E860D88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2B81F2769C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593422616;
	Fri, 23 Feb 2024 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ee4b7daX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ha8i2Rq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7F1B26E;
	Fri, 23 Feb 2024 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679208; cv=none; b=hJDZtnpBITW6eUxs8DRTUGnzEJiZmCNbQrGJR/ioNLMnd0zmTEvr0uQ/BRtKHScCmdFf2ig2fM/H/l3kgL7/QCwCzZgDeXMU4qIWsN/z3eJzF/2lllwqAlAgbzHj9sYBBS0Qc2BAzwKIcG1J1rXxujliUrdEiaJVhrobexcAPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679208; c=relaxed/simple;
	bh=Dtxf5IRHfwQSaHxpcYXPqB9KEFKDcDvvm3ijqoxjNko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2DjSlAsg7ZvyvP+t5tb6s2HBSqfbWo2EXR/e3ud9Eh6G42ZWDsZEjrUMbEY39D0DGOsrISPqgdhzBnQJuURJvDfw0a1uG2iVln5QgFFTKUahRxzWJyUV0e3j4cZfU17gSMSf+6aGoXv6hwzGZegQtduMOGURmQQT8WyXvtplwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ee4b7daX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7ha8i2Rq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708679204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Wf50sMB7P17099HKyOgeF0+Md1dpE2WNC2PraYzo5E=;
	b=ee4b7daXsqpkzj6vKmrWIdzYGHDrctEvl72qqapmJw5l+m5h9+rQnszLKqgtbz67CkyKaR
	WiMvXNIZsrslicsWhHvb0IPfX70yMh0lNgbISA9r7cigPedZh6slKTWBHi4halEN+oOBPK
	uv6XMbitjMAdDya3tn7TMg8uPVLSwUvMhHUebFmzrdwdWJr7ba7KPWOK1fIKyV2TYSvZah
	bEOw1gXqncVBmMR/J+bbL5+HvI7JHCvQEP37562Lo2ih3FWVAjs1BDt83/UKs1/3UZ5PLB
	GJvuHh/dLG/ug1oz4/+RcnyxFVo7XizOq4Kd5qWMP/H2sLDgP0fXV398sL6wTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708679204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Wf50sMB7P17099HKyOgeF0+Md1dpE2WNC2PraYzo5E=;
	b=7ha8i2Rqp856wi8VCmskiECtA8C/RuvjDd5/eucA2Ii/vV3XWHmq5b2SmysDpGNCorrVUH
	079KsBv1vbaQ/pDg==
To: Yu Chien Peter Lin <peterlin@andestech.com>, acme@kernel.org,
 adrian.hunter@intel.com, ajones@ventanamicro.com,
 alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
 anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
 conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
 devicetree@vger.kernel.org, evan@rivosinc.com, geert+renesas@glider.be,
 guoren@kernel.org, heiko@sntech.de, irogers@google.com,
 jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com,
 mark.rutland@arm.com, mingo@redhat.com, n.shubin@yadro.com,
 namhyung@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 peterlin@andestech.com, peterz@infradead.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
 robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
 tim609@andestech.com, uwu@icenowy.me, wens@csie.org, will@kernel.org,
 inochiama@outlook.com, unicorn_wang@outlook.com, wefu@redhat.com
Cc: Randolph <randolph@andestech.com>
Subject: Re: [PATCH v9 03/10] irqchip/riscv-intc: Introduce Andes hart-level
 interrupt controller
In-Reply-To: <874jdzef1j.ffs@tglx>
References: <20240222083946.3977135-1-peterlin@andestech.com>
 <20240222083946.3977135-4-peterlin@andestech.com> <87o7c8dvv4.ffs@tglx>
 <877civefa5.ffs@tglx> <874jdzef1j.ffs@tglx>
Date: Fri, 23 Feb 2024 10:06:44 +0100
Message-ID: <871q93eehn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 23 2024 at 09:54, Thomas Gleixner wrote:
> On Fri, Feb 23 2024 at 09:49, Thomas Gleixner wrote:
>> On Thu, Feb 22 2024 at 22:36, Thomas Gleixner wrote:
>>> Palmer, feel free to take this through the riscv tree. I have no other
>>> changes pending against that driver.
>>
>> Aargh. Spoken too early. This conflicts with Anups AIA series.
>>
>>   https://lore.kernel.org/all/20240222094006.1030709-1-apatel@ventanamicro.com
>>
>> So I rather take the pile through my tree and deal with the conflicts
>> localy than inflicting it on next.
>
>> Palmer?
>
> Nah. I just apply the two intc patches localy and give you a tag to pull
> from so we carry both the same commits. Then I can deal with the
> conflicts on my side trivially.

Here you go:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-for-riscv-02-23-24

Contains:

  f4cc33e78ba8 ("irqchip/riscv-intc: Introduce Andes hart-level interrupt controller")
  96303bcb401c ("irqchip/riscv-intc: Allow large non-standard interrupt number")

on top of v6.8-rc1

Thanks,

        tglx

