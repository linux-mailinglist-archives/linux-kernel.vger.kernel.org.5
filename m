Return-Path: <linux-kernel+bounces-73079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4486085BD42
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B700C2845A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4219F6A33D;
	Tue, 20 Feb 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aVVHgztb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5gi5BJKH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1DC6A03B;
	Tue, 20 Feb 2024 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436140; cv=none; b=EaDBMMTdBK/zNSWghN6CaFL3hOFr/uFfz7Gu4c8Vpqmpz94yfSDNI1+2WrS3ofFSTjOhfWJ/P4jfDG+k9uE3JXzabumYw/ZjyWucnaLsmM1Sr9aQR55jDf5By/DUBKd57Jd2S2sji9HbVngvj6tYv14gHL09vNBEbxqJk03C0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436140; c=relaxed/simple;
	bh=abTPl2u526Jg1CsFRDvVGDsu86nkuIcHywwC1yofwjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hN47zeA827Gr13XOFdB0nELZWkQAa03CDv5eo5ZrKtScsbAUoGr6IB5vq5Jezd+RWNFPASHAw4Mz67Q65sO/HWbs6efVX58CNaxry2pixxkjEpubhX4y98rT23AdhwSPB91isUnbbapNNJAIo7HTLD/Vv6dH9Q4pWq9rhFj1SjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aVVHgztb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5gi5BJKH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708436137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxDrWUoqTF4UCOljm+/CQR8VV7wFryZe0gkav5P0KMk=;
	b=aVVHgztb0p2AuL7Y//VQvDZYfGZpXQN5XWAcU8UBDLmGuuETChzmXxLmq5h5ScgwFHze7S
	Qrbsh+puub63PQj4UbpCR45FNa6xbU4Htl+DfH8tEgeaP7w7kXFOMM+RfLgQ6e4+PNFGaB
	Q3KaF1ce77yqiwkNitCdX/QZSHpUOhWKeeGFnpV/K1p+kEB2Jz+P8N0ni980o9883Wp7bm
	qWzLleftZ7h+m920QAYEEuWBD3wTd2m8qpRTNrrVe7whar0/kLfTzf68DS+lRE7j0+hf3o
	uTpC+D08M49/FMfib/WWMXMz73OUCnDvjoQQlyJnygpS7/Pehj0sYTqxx7Rrew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708436137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LxDrWUoqTF4UCOljm+/CQR8VV7wFryZe0gkav5P0KMk=;
	b=5gi5BJKHwq+Hpu0n4anP6RYba/28i4acUk2Iqiwo1Rx6puv3PfE5WN6+88/uq/aFjix3jx
	geSB/GUV9HTRSGAQ==
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
Subject: Re: [PATCH v13 08/13] irqchip/riscv-imsic: Add device MSI domain
 support for PCI devices
In-Reply-To: <20240220060718.823229-9-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-9-apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 14:35:36 +0100
Message-ID: <8734tni7h3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 11:37, Anup Patel wrote:
>  static bool imsic_init_dev_msi_info(struct device *dev,
>  				    struct irq_domain *domain,
>  				    struct irq_domain *real_parent,
> @@ -218,6 +241,7 @@ static bool imsic_init_dev_msi_info(struct device *dev,
>  
>  	/* MSI parent domain specific settings */
>  	switch (real_parent->bus_token) {
> +	case DOMAIN_BUS_PCI_MSI:

	case DOMAIN_BUS_PCI_DEVICE_MSIX:

?

Thanks,

        tglx

