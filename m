Return-Path: <linux-kernel+bounces-63303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB3852D70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F331C22BED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B622F19;
	Tue, 13 Feb 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SE49GUQb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hwPVCOob"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053722630;
	Tue, 13 Feb 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818697; cv=none; b=VpgUMJipLQwGZZAGw4ndt5vj1YWen2Bvz+FU7vGi9FeErChDR6iUXlstenSWlE00WngTaCgNr9OsWx9Ux5xAWGZsnQQNCE/XjGlprTJXMpi+48sOPgUjTEbAqQfCH3ed9wm6f+RkigQWBYPFQ+CsfcAx4rnWgYv+lvsZVcavj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818697; c=relaxed/simple;
	bh=6TSHYiFO7t6qPOK5xs2M2DE46SDMBFbNXGbksGWwjH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dgHEQnQJv/aFFTd0s77ljy0GfqqTQ7AqCwgfOCjMbgAq4P8IrmX3WUs59NDI2ZxZqfXn/IAhXpUB2pY9FKed9THvbIGOdBULMhNcW2QewEWUVMgK0G7YpHdxeHdl9dBA9SjNIwuuSnWHryCFYWCd9+X2/B7DwG76cqwRznWYERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SE49GUQb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hwPVCOob; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707818693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1HrfL+SrlW2XWR5pU7cGgxYMFs+Qr2zZ76ZBVxutfE=;
	b=SE49GUQbwTclIrg8Ek0Z3VpThQD1o9FAH8SAfIXoKnzTV3UsTWw9PR3oootZv4e+BrIiEw
	mdQccGiNG42+Pm2ePTR4i97kp8932eaGmbf9YEyCPmZhmlW6DTxYRik/XdRPpaf/1d9Rj+
	iw237txMkf2vF9jD/1ZLzDd0rm8LrsgK/C2xIiSWgoOKHIUVHZ9nngnvzOVUFKnc6moxK7
	BpEj8jkWpHHDobcUxfUsyG+G/u9okIlxlJR4RBySpQ43POtEj6N7+cSAuQiP7GiM5XpWMC
	zt2UBKcuYOqCl9/NGww8Fi+s6sVfQA4TLjGzQeVeq9V65GziT/r7Yaga1vZYqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707818693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1HrfL+SrlW2XWR5pU7cGgxYMFs+Qr2zZ76ZBVxutfE=;
	b=hwPVCOobELnpGmo9aIjJ/oKtSoM7jE5zNUcYVknaR65ECFvfFEULvht2Ghlz1V5bazoRzP
	gBUt4M68cX7NwTDg==
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
Cc: Randolph <randolph@andestech.com>, Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v8 02/10] irqchip/riscv-intc: Allow large non-standard
 interrupt number
In-Reply-To: <20240129092553.2058043-3-peterlin@andestech.com>
References: <20240129092553.2058043-1-peterlin@andestech.com>
 <20240129092553.2058043-3-peterlin@andestech.com>
Date: Tue, 13 Feb 2024 11:04:53 +0100
Message-ID: <877cj8issa.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 29 2024 at 17:25, Yu Chien Peter Lin wrote:
>  static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
>  {
>  	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
>  
> -	if (unlikely(cause >= BITS_PER_LONG))
> -		panic("unexpected interrupt cause");
> -
> -	generic_handle_domain_irq(intc_domain, cause);
> +	if (generic_handle_domain_irq(intc_domain, cause))
> +		pr_warn_ratelimited("Failed to handle interrupt (cause: %ld)\n",
> +				    cause);

Either let the cause stick out or you need brackets. See:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules

>  }
>  
>  /*
> @@ -93,6 +95,14 @@ static int riscv_intc_domain_alloc(struct irq_domain *domain,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Only allow hwirq for which we have corresponding standard or
> +	 * custom interrupt enable register.
> +	 */
> +	if ((riscv_intc_nr_irqs <= hwirq && hwirq < riscv_intc_custom_base) ||
> +	    (riscv_intc_custom_base + riscv_intc_custom_nr_irqs) <= hwirq)
> +		return -EINVAL;

Duh. This mix of ordering required to read this 3 times. What's wrong
with writing this consistently:

	if ((hwirq >= riscv_intc_nr_irqs && hwirq < riscv_intc_custom_base) ||
	    (hwirq >= iscv_intc_custom_base + riscv_intc_custom_nr_irqs)
		return -EINVAL;

Hmm?

> -	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> +	pr_info("%d local interrupts mapped\n", riscv_intc_nr_irqs);
> +	if (riscv_intc_custom_nr_irqs)
> +		pr_info("%d custom local interrupts mapped\n",
> +			riscv_intc_custom_nr_irqs);

See bracket rules.
  
>  	return 0;
>  }
> @@ -166,6 +178,10 @@ static int __init riscv_intc_init(struct device_node *node,
>  		return 0;
>  	}
>  
> +	riscv_intc_nr_irqs = BITS_PER_LONG;
> +	riscv_intc_custom_base = riscv_intc_nr_irqs;

Why don't you initialize the static variables with constants right away?

> +	riscv_intc_custom_nr_irqs = 0;

It's already 0, no?

>  	return riscv_intc_init_common(of_node_to_fwnode(node));
>  }

Thanks,

        tglx

