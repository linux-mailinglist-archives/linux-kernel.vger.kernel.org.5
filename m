Return-Path: <linux-kernel+bounces-72780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C385B8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E83F1C20A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8E460ECC;
	Tue, 20 Feb 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WUT0Kd4b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rIuXTH/Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B965FEF9;
	Tue, 20 Feb 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423790; cv=none; b=GJZR5wj2PKQmgLodFQ3R5cwcg9ak3VDb/i3IzKfaUfNJxTL8oziOCRBY4Y5oykQe0BA3/qp8nI4hEL6lftAYSTgg6lU7yuuvqj1AG9Yqko31xBCnaXXWK3wSOCUG6Jahg3gcoCPWsqL2fCz5SDJ9zBeJUCwejg6+oqSjcl9dMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423790; c=relaxed/simple;
	bh=SKDBLf19ZwBjB9Kg6QLdB6aoS3B96CLloFbgW0h61Bc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fc13q70wj5T17AhIu60d8Upz1DNZClnjE+jk8ihVlGHcHmYs7hu2fV44D+Z62v2NZWdjz8MtV3FTZiNDYFzJ638eGW3TjhLzW6mkAkI0QgckzBz5CIWM/9W3+n08N+x/5WombtKkLYQ8+qW/hNK/JQ5MzT5v4gRWxS2oRE7LRCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WUT0Kd4b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rIuXTH/Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708423787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhBSXu8UlJHcF5aUEqeIcG7LmDKhw95uTgaS8fEGB8k=;
	b=WUT0Kd4brEuI8t9EDd+lbh3h6YT1uDRxkmUIBMWc5pQ91+6vl2Zby12PIn9L8diIrPPWVl
	U5wQEbjWeOh4ARIC878VRZRAhd2PR+1tXvrlKRfTupb0hLo5X/35iYqV6A2U2tzVisfGVG
	jSGT5RdjODsGj3HFAZMOG+YFo8ax2cFMy7eIzyWgI0eAtF6XcU9HVdADNF4E/Y6jJYHdg5
	9yONABFFtC48hsP2HeiVVQptfB+96DIO0A5tQqlbeB64Bob/NHc9COElSARQDP1iwAvm3x
	W9bgt3efrUGVjBqIr+y/MroKQNyA3RBv1HFi0Leb2uZuF8Qts7ZKhBne2wJQlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708423787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhBSXu8UlJHcF5aUEqeIcG7LmDKhw95uTgaS8fEGB8k=;
	b=rIuXTH/YrKRubdPDWMPYcEOauyFagFe9PjZjHHwCY3oI/7gg2yfcjHdXKVAlJQtmzAySY3
	ZpdYN5yKrT80+sDg==
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
Subject: Re: [PATCH v13 01/13] irqchip/sifive-plic: Convert PLIC driver into
 a platform driver
In-Reply-To: <20240220060718.823229-2-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-2-apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 11:09:47 +0100
Message-ID: <87il2jih04.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 11:37, Anup Patel wrote:
> The PLIC driver does not require very early initialization so let
> us convert it into a platform driver.

s/let us convert/convert/

Please us passive voice and imperative mood all over the changelogs. No
we/us, let....

> As part of the conversion, the PLIC probing undergoes the following
> changes:
> 1. Use dev_info(), dev_err() and dev_warn() instead of pr_info(),
>    pr_err() and pr_warn()
> 2. Use devm_xyz() APIs wherever applicable
> 3. PLIC is now probed after CPUs are brought-up so we have to
>    setup cpuhp state after context handler of all online CPUs
>    are initialized otherwise we see crash on multi-socket systems

This patch is really doing too many things at once, which makes it hard
to review. Can you split this into digestable pieces please?

>  		if (unlikely(err))
> -			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
> +			dev_warn_ratelimited(handler->priv->dev,
> +					"can't find mapping for hwirq %lu\n",
>  					hwirq);

Nit. Please use brackets around the condition. See:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules

for reasoning.

Thanks,

        tglx

