Return-Path: <linux-kernel+bounces-77933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E379860CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0C4B253D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA4922EF6;
	Fri, 23 Feb 2024 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cfpLw9z8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gonh+AQT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FCE18046;
	Fri, 23 Feb 2024 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676923; cv=none; b=gh0yqaBOHr79F3j72jiYNR35RTbkEomVPrlyeDmpPqgqtZFtZCiMaW+g04AZGb8mUUw+1BI4/4u391VJ66VmMT+MyEYV0/tKlxpXmLNl0I7sQ6RXyA+4Cwg/oTXGGNL+71NC0qvkoEMUkNnvEKKYMBGVx3yHKB9LcSJg59Ypjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676923; c=relaxed/simple;
	bh=/FoVpwZNUTB0nZFTFHl2GxvKh6vIcm+/R1kfqy+g4sI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QTWXJkL8lUcLK2vE5Ut5q5sUYwMOMojLtcx/HDvq2zLje6hwjcNMuzejTuegqag33GGXaqHHy+BMuKZH+4qN6ZaoBOUO3TyjR8DYPI2bs0unYfZ2w+nOPwrc0iq2bkFqgH+7iCpoexxHui/8d/NNTfeB0jA4CuoYsjWZsAbMWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cfpLw9z8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gonh+AQT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708676920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BwouyOLbHz0eSzCdVQ2ZEsHOl10HJAxDGKDUKAL7Owk=;
	b=cfpLw9z8ATpZPiDKbtK60qO0kt54LwXCDHCurRp/6YD+12HSf3uBMKcklWFSACBsIAxbZM
	Gzfu7GBoQALfc6TLvIv0sA1guMwPM1uuqE9ljEfvOCL+t/mFIJS9LoqM+Nrund9/hzgi5j
	NfmMx2yL3j+NnrOvGGiCU+bV3Gnd3EHGyZzoLj/W2+x1kPFVT4TMMVCQHyWgYLQAMm/Xvn
	zimTWHdPfiHFuIegAswCFXw2TyvjkBhZz4FP3RrLqN9Lkjxp+jNtZV+vSS3HJ2R8h2Imie
	ueoCgOrGxcBKRnuUhqh8vbbkwa1uwYJDjPGCjLVbTu9Pwq29j3kFH55YWqmSTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708676920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BwouyOLbHz0eSzCdVQ2ZEsHOl10HJAxDGKDUKAL7Owk=;
	b=Gonh+AQTnZOB2EGMkKzwClO38MRD1hddXVrDFhRCeIADXpMKUQUubjPqRKqdqGquOcIx80
	7n/i+HaywMLdrGAw==
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Atish
 Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan
 <saravanak@google.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Anup Patel
 <apatel@ventanamicro.com>
Subject: Re: [PATCH v14 11/18] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <20240222094006.1030709-12-apatel@ventanamicro.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-12-apatel@ventanamicro.com>
Date: Fri, 23 Feb 2024 09:28:39 +0100
Message-ID: <87a5nreg94.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 22 2024 at 15:09, Anup Patel wrote:
> +	/*
> +	 * Setup cpuhp state (must be done after setting imsic_parent_irq)
> +	 *
> +	 * Don't disable per-CPU IMSIC file when CPU goes offline
> +	 * because this affects IPI and the masking/unmasking of
> +	 * virtual IPIs is done via generic IPI-Mux
> +	 */
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "irqchip/riscv/imsic:starting",
> +			  imsic_starting_cpu, imsic_dying_cpu);

This is not really correct. IPIs should be working right away when a CPU
comes online and on the unplug side until it really goes offline.

So this wants to be in the starting range, i.e. between CPUHP_AP_OFFLINE
and CPUHP_AP_ONLINE. No?

Thanks,

        tglx

