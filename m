Return-Path: <linux-kernel+bounces-68886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7EA858165
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04F21C21359
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42D12F5B0;
	Fri, 16 Feb 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0qn3js0c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3jG1bRA0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F612F596;
	Fri, 16 Feb 2024 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097607; cv=none; b=sKRS49fz8Sg04SqlMnaTqjmHJ12gTR0VRP5XufUOor8VW0Zu7NWwzZ9i6y2CBUTOd9ewMSipfGzZvGANlN0fvqdF0cAyPaooTb8BGzASy7o2RewOPHCG9S+i6F5OuheWPTq7Uz2HiRhy8sI7IY2J202EmJ9ZnLDf8BNK6yB50fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097607; c=relaxed/simple;
	bh=IfUjVldnRfukpDdNPkqhhIymbBOg+T1J2z8t9u0YAfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fNh3YCfiF6qGyAE1L0Z0doI95syv2PAuFVo2RXCJM4bDD2R52l40wbIbx1/CqA4mehs+Yz+Nht4DclvX4N/qZKwFhnfNtk9hHK/N8cOtEsTyITRmuatzWFAyOzJVtldxBLndfZh+2UbrhFAfMeRyyOyVwlCF1TEd0mEDaLDwL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0qn3js0c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3jG1bRA0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708097604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2MaYtjttL6XKBNL0rdPOP7iP2+uK1fvBkLYnfKG/rM=;
	b=0qn3js0c+PxthhaToXev+IfwlGXqyVL+/2Ng4/kF4L9yOBlfcYjF+3J31ouudWdpim0mF5
	M8TXP40JWWfQ2WGZa33Y4cjVM7s0SrwYwb36dSY/TPAmMYmOxT68r636xK6dsXZ03e/XKw
	zOxzOcS1+VHVDBUCUdYuOd9kfYPYJD9mDUEAiZRMf/sjwafmglDv9w+oIFXecCsOfoNc9d
	oOkwKpj+GCfn4UBe5QxTB82YtjygcYejyBhnu+4BMvbVxnqtlUjeg5Smq2Oi1/+lKQA2ja
	kC9OocVn1stvdgl//7mcSNjQkeUqMgpZTrhUFZVdMSjHmuzOge4tL6VvmJhIDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708097604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2MaYtjttL6XKBNL0rdPOP7iP2+uK1fvBkLYnfKG/rM=;
	b=3jG1bRA09z9Yz6hS8ZMKbnr4SudqqedyjpDGks+fqNkrunvpm9xBTYCTBJHfPWjIbNOvQH
	/Tndz8JCl0Y1q4BA==
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
Subject: Re: [PATCH v12 14/25] irqchip/sifive-plic: Convert PLIC driver into
 a platform driver
In-Reply-To: <20240127161753.114685-15-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-15-apatel@ventanamicro.com>
Date: Fri, 16 Feb 2024 16:33:23 +0100
Message-ID: <87jzn4ctks.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jan 27 2024 at 21:47, Anup Patel wrote:
> +	priv->irqdomain = irq_domain_create_linear(dev->fwnode, nr_irqs + 1,
> +						   &plic_irqdomain_ops, priv);
> +	if (WARN_ON(!priv->irqdomain))
> +		return -ENOMEM;

While some of the stuff is cleaned up by devm, the error handling in
this code looks pretty fragile as it leaves initialized contexts,
hardware state, chained handlers etc. around.

The question is whether the system can actually boot or work at all if
any of this fails.

> +
>  	/*
>  	 * We can have multiple PLIC instances so setup cpuhp state
> -	 * and register syscore operations only when context handler
> -	 * for current/boot CPU is present.
> +	 * and register syscore operations only after context handlers
> +	 * of all online CPUs are initialized.
>  	 */
> -	handler = this_cpu_ptr(&plic_handlers);
> -	if (handler->present && !plic_cpuhp_setup_done) {
> +	cpuhp_setup = true;
> +	for_each_online_cpu(cpu) {
> +		handler = per_cpu_ptr(&plic_handlers, cpu);
> +		if (!handler->present) {
> +			cpuhp_setup = false;
> +			break;
> +		}
> +	}
> +	if (cpuhp_setup) {
>  		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>  				  "irqchip/sifive/plic:starting",
>  				  plic_starting_cpu, plic_dying_cpu);
>  		register_syscore_ops(&plic_irq_syscore_ops);
> -		plic_cpuhp_setup_done = true;

I don't think that removing the setup protection is correct.

Assume you have maxcpus=N on the kernel command line, then the above
for_each_online_cpu() loop would result in cpuhp_setup == true when the
instances for the not onlined CPUs are set up, no?

Thanks,

        tglx

