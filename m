Return-Path: <linux-kernel+bounces-77414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF988604ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3FC28112B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B012D217;
	Thu, 22 Feb 2024 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mHY/ep6f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6v3VMHzF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039673F3E;
	Thu, 22 Feb 2024 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637811; cv=none; b=XStuyTDT+FZ99zp+DzuY1dacxzRXbapdJs/2vys1b2FJaEKmS8KFDC8vppwZH6xc5AUlKfLwfApgwgxUSjlLV9iKnKD6L4Jy0NH0Ri8nA2OKtuaRTMpj+acQ8qYjrDZHQqrXVL/s0UtEQAZrjxjY9UfgoBIDiwTnp71lM5ckJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637811; c=relaxed/simple;
	bh=7Y6kSVXo2Eky32ArH5WC+Ufp3s4jShIcENQr6DbnLLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XdYQe86oc6IWPivbUMy3stJkMBlQ3QIlhQbUq0Gi6FH1svcpy8anme6Cxg9JBqv4JG0eaGoEkbKzdKDTlyYwLpINMhOgqVgH9XpsSM3SXFs8Er6/MXE4I6XBLoZhdLuT0ShcwwTVj2GsDaRtHU5n0oaV1GJYWo7M7K+Z990l2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mHY/ep6f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6v3VMHzF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708637808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ysPo6JrAY4nGWCiZuUlITPDn7XnJnDVfKZs7jRkBAW4=;
	b=mHY/ep6f/6+Zhj4+fZRHJ34d2lfiHP1EuInqjDkWFDCaiz/e8s95zPGbT8M0Ad++Dzyjmb
	oVY+D2yqHO9WQbM0zwWCA5C3UGCs+gQ3z590Ucxghlf4Dlr41VPiQF9YgQYZMLeUawEiAa
	Rnc0moqmMGO4SebkjihxwYdCTGbaE8vxFP+Vadvxo7Yltc9LG8tDTKxbNnV9fYjvOpOKXA
	IVzZemMDik58mgm0f4adOVww1qNlUCp6hVusO9YpY3wPgYHU/R6LCbNdfHNpPLOSKZiLCu
	6a7wcJJnpMSyhcj5Qeg9peFN2J/35vITOcTokZCnmz0jPiz2SksBNd0ahFfwWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708637808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ysPo6JrAY4nGWCiZuUlITPDn7XnJnDVfKZs7jRkBAW4=;
	b=6v3VMHzFcbvBoIrwVbn04/STMyA/qaJsgeXvHkOW1vMOCTZyQDFr2zoK8GtfRgUV7KtM1v
	sGwpCMRcO4QbnbAQ==
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
In-Reply-To: <20240222083946.3977135-4-peterlin@andestech.com>
References: <20240222083946.3977135-1-peterlin@andestech.com>
 <20240222083946.3977135-4-peterlin@andestech.com>
Date: Thu, 22 Feb 2024 22:36:47 +0100
Message-ID: <87o7c8dvv4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 22 2024 at 16:39, Yu Chien Peter Lin wrote:
> Add support for the Andes hart-level interrupt controller. This
> controller provides interrupt mask/unmask functions to access the
> custom register (SLIE) where the non-standard S-mode local interrupt
> enable bits are located. The base of custom interrupt number is set
> to 256.
>
> To share the riscv_intc_domain_map() with the generic RISC-V INTC and
> ACPI, add a chip parameter to riscv_intc_init_common(), so it can be
> passed to the irq_domain_set_info() as a private data.
>
> Andes hart-level interrupt controller requires the "andestech,cpu-intc"
> compatible string to be present in interrupt-controller of cpu node to
> enable the use of custom local interrupt source.
> e.g.,
>
>   cpu0: cpu@0 {
>       compatible = "andestech,ax45mp", "riscv";
>       ...
>       cpu0-intc: interrupt-controller {
>           #interrupt-cells = <0x01>;
>           compatible = "andestech,cpu-intc", "riscv,cpu-intc";
>           interrupt-controller;
>       };
>   };
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Randolph <randolph@andestech.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Palmer, feel free to take this through the riscv tree. I have no other
changes pending against that driver.

Thanks,

        tglx

