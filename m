Return-Path: <linux-kernel+bounces-73640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA26B85C562
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259151C218D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37B14AD09;
	Tue, 20 Feb 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aYQmsEOw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0bZpy8Uc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72E14A4E1;
	Tue, 20 Feb 2024 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459431; cv=none; b=oiQo835m5sE9QPTnsurhpjH8zGPYbHeEBf1ip8OfW/N0DkLcnXwg5Rfp4nv+0DfBwLywGlEbnuGUsmDn/x0M28/hRsg5AXO/F40c4l7NWCLsssnLPQ4zqltVfn6utRvCzrQ/dJYE3fFKeYhz9TKcOtUtItZ3v77PjJaw1YS4m5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459431; c=relaxed/simple;
	bh=RGYI1C/SB4NfKZcUVQLWJNCPAbpYUuYgeLGtJ3F3BJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vx9kLN0KSA+DXsFFWF2hgyfWnDXDydrUqSxxC8OmVy5Zm5mU6sw9c1IH9iZYc2OW/HKoCwfGq3Jy1aKs++3teANjJcMpdqlfrEg+Eu37u2xtViO4UI9uejuK7q06fA+EpRWRCrOFvvCnp9gBAWwASX1zK13Qju/Nkz+MUOM5NEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aYQmsEOw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0bZpy8Uc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708459424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJRsPsyZ6zDS1QWFQN2wLBFM6mS+0QImDjTMgSPiL7I=;
	b=aYQmsEOwQopLCUpYpAQuDyrIpn/ZjclA2riggfw0WWir8TT6NmiPQZJzpeC9YRHKgp0rWt
	k9TQyzVThpxVBDmox2nnESsknS5oTRd4VzFt0IU9vtyq1EJQHNR2c8XYNJ501UxxiXHAvM
	kXdsE5fN2sy9MVO94uyCUiwX4v8h1pq6bevWl8yrwk+XqoCaj9mBmXHCJGdlZPtLIuvqLX
	3q+Zma5P0XbwLUpcToklgoNTEsCISC+ORpEWQc1gQ0abV9ucGF0qXfXXUnwwqsBvpXZvEQ
	4wLIzGkKNOg+Vur2e3RHi5rEfoxeWqrJBnwmSEj0b/eNkGMG09MxRmsKO7Z1XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708459424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJRsPsyZ6zDS1QWFQN2wLBFM6mS+0QImDjTMgSPiL7I=;
	b=0bZpy8Ucv4te6DfmhFa1QQKyXrhJJterh1+UZ0hC/H+1QXta7TTSsn4wIZdFftqnZDB7KQ
	v4NtqSu0q+WZZFDw==
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Marc Zyngier
 <maz@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Atish Patra
 <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>, Anup
 Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v13 08/13] irqchip/riscv-imsic: Add device MSI domain
 support for PCI devices
In-Reply-To: <CAK9=C2UgYpVtjFZ4NLzOCP6f3LQ=Fx7kPMywwQyFiNMcKmPyLw@mail.gmail.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-9-apatel@ventanamicro.com> <8734tni7h3.ffs@tglx>
 <CAK9=C2UgYpVtjFZ4NLzOCP6f3LQ=Fx7kPMywwQyFiNMcKmPyLw@mail.gmail.com>
Date: Tue, 20 Feb 2024 21:03:43 +0100
Message-ID: <87jzmyhpi8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20 2024 at 22:51, Anup Patel wrote:

> On Tue, Feb 20, 2024 at 7:05=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> On Tue, Feb 20 2024 at 11:37, Anup Patel wrote:
>> >  static bool imsic_init_dev_msi_info(struct device *dev,
>> >                                   struct irq_domain *domain,
>> >                                   struct irq_domain *real_parent,
>> > @@ -218,6 +241,7 @@ static bool imsic_init_dev_msi_info(struct device =
*dev,
>> >
>> >       /* MSI parent domain specific settings */
>> >       switch (real_parent->bus_token) {
>> > +     case DOMAIN_BUS_PCI_MSI:
>>
>>         case DOMAIN_BUS_PCI_DEVICE_MSIX:
>>
>> ?
>
> Actually, the DOMAIN_BUS_PCI_MSI is not needed because
> the real parent domain is always the IMSIC base irq_domain
> so DOMAIN_BUS_NEXUS is sufficient.

Indeed. Obviously I can't read.

> Better to just drop DOMAIN_BUS_PCI_MSI from this switch case ?

Yes. I actually would be a bug if that ends up as the real parent
domain.

Thanks,

       tglx

