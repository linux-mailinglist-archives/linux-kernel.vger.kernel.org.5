Return-Path: <linux-kernel+bounces-72794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F074A85B8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8CAB27FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC4761663;
	Tue, 20 Feb 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eAWJWjfK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XpElhKti"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93F60ED1;
	Tue, 20 Feb 2024 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423998; cv=none; b=JJCT2rWC7zs5xK/1d+Gth1lwZF4+M0lrQXmMEXu/o0LMqwC2dWvoNCeJML9/SopPBV8wY4B3VhX/I28Yqrx/NWg3+KFxjaj28W3la7hYQpSBCpPkgBK+3lTyyubynQOiWvsl0zBWJzewEaltYn6Bdgeqr74kcxo0VQFzRiAAfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423998; c=relaxed/simple;
	bh=eFteOFDW9aBHiRsmlnd708pp8tDpwfmJX6DQQ/B5Rjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F3oAOLYssC0VELjbJT/9KuGxi6XMytDUeLF87ledlifAD/7bNIYzjgUrvFcRgLaz43QGG5GbjI1kCqjVw12y38Nc18QacUMFa2dp8+Ncx5/JEScmVs2dIAfKaiQiy8s0mc6AyBmgq5AMw/dL9UPn858NuEUMSB37imLfsgUjirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eAWJWjfK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XpElhKti; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708423995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laFAJ1WS6uZx5Qx1npB6qVhditvot1Fb8n/CdM0NjF4=;
	b=eAWJWjfKj4Exj6mD+gG2026KDyKmNgCS41grYSnkAmb/YGmADaQqe1sbZzj9EPkor5NABF
	6MCSMSIHheBZ+KhYWYGxtmYpPKRp+N2TfzZPLbErwhLv6KOgA6HgJ/s6RwYLbjsKIi2/S5
	KubpQ3XgYqGjz1UlNyfT+1fgppS39GjKWlVtCltywAjEVsHg6HTwmymO0ZuS/ObLld6+6y
	mqNnHZLFpBtmVkxz8FLhyIMrgJQqk2w48iq1AQRJDpO6xfy/+qoPwxZ/HEqZCPzY55rBtU
	zIF1k080ccayut4VH1p7dX8ozpYZb8MbGw2Yz5UA7we0K6os8uTEwcaEmXp4Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708423995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laFAJ1WS6uZx5Qx1npB6qVhditvot1Fb8n/CdM0NjF4=;
	b=XpElhKtiuPPyaiRk/K/PQKgz6xwbFQgSyRq4YzUC7dfsJ907Gb168BrwzkPW5XhDZeDvGe
	zQc4ZOGV40T8BXAg==
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
Subject: Re: [PATCH v13 03/13] irqchip/riscv-intc: Add support for RISC-V AIA
In-Reply-To: <20240220060718.823229-4-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-4-apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 11:13:14 +0100
Message-ID: <87cysrigud.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 11:37, Anup Patel wrote:

> The RISC-V advanced interrupt architecture (AIA) extends the per-HART
> local interrupts in following ways:
> 1. Minimum 64 local interrupts for both RV32 and RV64
> 2. Ability to process multiple pending local interrupts in same
>    interrupt handler
> 3. Priority configuration for each local interrupts
> 4. Special CSRs to configure/access the per-HART MSI controller
>
> We add support for #1 and #2 described above in the RISC-V intc
> driver.

S/We add/Add/

> +static asmlinkage void riscv_intc_aia_irq(struct pt_regs *regs)
> +{
> +	unsigned long topi;
> +
> +	while ((topi = csr_read(CSR_TOPI)))
> +		generic_handle_domain_irq(intc_domain,
> +					  topi >> TOPI_IID_SHIFT);

Please let it stick out. You got 100 characters. All over the place.

Thanks,

        tglx

