Return-Path: <linux-kernel+bounces-67132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FA88566C4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41461C214C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76379132C3C;
	Thu, 15 Feb 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACCFDxP4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KXqXpqo8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F4132491;
	Thu, 15 Feb 2024 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009267; cv=none; b=qxWhZeTvt1LXAuroB0iVz4poaA8PqlF7o9AX6etxgMfpoliwpCI9fih5AqQe3/XFBgwMHF56V6xRB6kRIQect4Of8MpMejh+MNkoP6Rexy0npwyjA2RKzRhY+en1SHiLxytKmoNfg/8/eCxIxx2o2cj2FfDDSfcKyYFcOU/T0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009267; c=relaxed/simple;
	bh=MtMq9tcbpWwfTdQNJk1rzVu9HeI1V4yx38+kxXa5HNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CpWJOoS8m8MlFbNfzEdIU70zaXRc4ceqALUygtP7BgLJpfPlXN3S+de1RiYYis8kLsxUmhsCgmPNybO9/4Sfii9p6u2Jxao0oNy46Usj8wyUY/V8qF3AzE1F32gJCnNJfvTB4qv3LwG629wDTuDbQ4zgytTDwzZM3nW2NRBLj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ACCFDxP4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KXqXpqo8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708009264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jurcXevAzLq5b3XNHkngyd9aG7HXv/ajp+hOIdurHE=;
	b=ACCFDxP4M6h+kPZxC8n5YjerDJytE7XIB0xzvUQXXsvsgxPRymDCIwAOCzBTMwjF/tAC6G
	5DClIsEIgMg8ovLCONa+WB3EEhNaR0do2/BXAHLP/kwTJWohwek+I2LO/AhhBv4naEVE0e
	aHQgbFkMm4aV/a+ICweO1zbPNB9N6AaJDpzcUIWsYMFaaN5tq4TzG4KtRQiOI3ZH5zRyML
	a3IJasqR/LwhLRPH+XRe6Jqq5lcpAy4rh9jyXmQL4Rc0PsGK3z88opG/4JIKCQLL2Mssf8
	aa1w9c8EObkVpg4klvWcgi5NpujCCu6uXwJBtrkci69IOAL7y7ahvCT+XVT0PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708009264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jurcXevAzLq5b3XNHkngyd9aG7HXv/ajp+hOIdurHE=;
	b=KXqXpqo8rLP9B7h0qdTcwSs6/WBr1zOrw9q92FTDKvwl3twYREKP5rQvKTif3BtifKxCaI
	TvV5B162CoS6pGDQ==
To: Marc Zyngier <maz@kernel.org>, Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Atish Patra <atishp@atishpatra.org>, Andrew Jones
 <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, Saravana
 Kannan <saravanak@google.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 04/25] genirq/irqdomain: Add DOMAIN_BUS_DEVICE_IMS
In-Reply-To: <86o7ci3puk.wl-maz@kernel.org>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-5-apatel@ventanamicro.com>
 <86o7ci3puk.wl-maz@kernel.org>
Date: Thu, 15 Feb 2024 16:01:03 +0100
Message-ID: <87h6i9epqo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 15 2024 at 11:54, Marc Zyngier wrote:
> On Sat, 27 Jan 2024 16:17:32 +0000,
> Anup Patel <apatel@ventanamicro.com> wrote:
>>  	DOMAIN_BUS_PCI_DEVICE_IMS,
>> +	DOMAIN_BUS_DEVICE_IMS,
>
> Only a personal taste, but since we keep calling it "device MSI",
> which it really is, I find it slightly odd to name the token
> "DEVICE_IMS".
>
> From what I understand, IMS is PCIe specific. Platform (and by
> extension device) MSI extends far beyond PCIe. So here, DEVICE_MSI
> would make a lot more sense and avoid confusion.

That's true, but I chose it intentionally because Interrupt Message
Store (IMS) is a (PCI) device specific way to store the message contrary
to PCI/MSI[-X] which has standardized storage.

So my thought was that this exactly reflects what the platform device
requires: device specific message store, aka DMS or DSMS :)

> But hey, I don't have much skin in this game, and I can probably
> mentally rotate the acronym...

I have no strong opinion about it though.

Thanks,

        tglx

