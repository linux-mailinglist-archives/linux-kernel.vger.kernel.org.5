Return-Path: <linux-kernel+bounces-75205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DA485E4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BD6284EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B97583CD7;
	Wed, 21 Feb 2024 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xLEbcmth";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xQf2fTtB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287A7FBD5;
	Wed, 21 Feb 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537079; cv=none; b=K87cQMLJhIUzZ9fgY3NF9FbkylUVfYbPdTWPGxY8pxCaZ7pBT/EJUASLEUXAOfp3D3jAc92Ic3WuZIufBv1tdVkFq2SuCw88bGkQSPbe2mYG9M3STFLheX+F5RCDaDajJW/6XYm174q1ASUMsxLLdqh6t1krzs80dEgWm17Hs3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537079; c=relaxed/simple;
	bh=RSJEdvZKXkX3yGEIkS9DaCnaNb3HO5rM3mqCc71lxT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eeI7Wqgn8ZwpQ6CCdsOo+v7m1gXmE6Os3P1cxe04Xsu95O88qGmChvB55xf+CPCBVXM9FyzhUOEeiKo9+cr0fkQQGIfMWIiDMzslSYdX5Utjp3Ou+gkAsAjV4E84qRBTZBmwVooEL5H7W5j88sK0gAGqIguyBTqWByaoRtZY9FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xLEbcmth; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xQf2fTtB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708537076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rNP/pSU4Q89ArPZAYOkavXsZq7rBfQprq8vBcMveDTI=;
	b=xLEbcmthFRfBygzZ69VL2DG/D0gBYdP2sN2Lgb8itqPYkU2o1cKTqlQ9JHvN9mWqw1vFEf
	5FkMFYZDTJoe/BqGdmY+A/NaVuf49L514Y+kGdUneY5FIX7EdlE+mxfgfQL6NcEvHMEyVP
	2HB9Gn75wHE39/Iwnc1QGEr5A1Kfae8HlwjYAnOAaDb+b+VUsA/OW74yWiGP70IqnV1ZHv
	a+N6AfJAhsWBDCo/gUomai03e6H9G5Reh2aU0g6h/C72VAEZ8mi23zSDyTBOlbqj2aieJc
	aD845IESs2nX6iPzvlHCMqUdWfI4i7/NQsWtjRWTJMeXzGaj00flY4bLm/gQVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708537076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rNP/pSU4Q89ArPZAYOkavXsZq7rBfQprq8vBcMveDTI=;
	b=xQf2fTtB4GWLnzNERvE/GFUF0GEltMGR9pYEU1fe90JMgmi5FmXkeB6Xdj5dZJ0u1y5IjA
	4I/r2JPMR/kcPXAg==
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>, Jack Zhu
 <jack.zhu@starfivetech.com>, Changhuang Liang
 <changhuang.liang@starfivetech.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] irqchip: Add StarFive external interrupt controller
In-Reply-To: <20240221022647.5297-3-changhuang.liang@starfivetech.com>
References: <20240221022647.5297-1-changhuang.liang@starfivetech.com>
 <20240221022647.5297-3-changhuang.liang@starfivetech.com>
Date: Wed, 21 Feb 2024 18:37:56 +0100
Message-ID: <87ttm1g1l7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 18:26, Changhuang Liang wrote:
> +static void starfive_intc_unmask(struct irq_data *d)
> +{
> +	struct starfive_irq_chip *irqc = irq_data_get_irq_chip_data(d);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&irqc->lock, flags);

This does not need the _irqsave() variant as this is guaranteed to be
called with interrupts disabled from the core code.

> +	starfive_intc_bit_clear(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq));
> +	raw_spin_unlock_irqrestore(&irqc->lock, flags);
> +}

> +	chained_irq_enter(chip, desc);
> +
> +	value = ioread32(irqc->base + STARFIVE_INTC_SRC0_INT);
> +	while (value) {
> +		hwirq = ffs(value) - 1;
> +
> +		generic_handle_domain_irq(irqc->domain, hwirq);
> +
> +		starfive_intc_bit_set(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq));
> +		starfive_intc_bit_clear(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq));
> +
> +		clear_bit(hwirq, &value);

As this is a local variable you really don't want to have the atomic
variant for clearing the bit. __clear_bit() is your friend.

Other than those nitpicks this looks good.

Thanks,

        tglx

