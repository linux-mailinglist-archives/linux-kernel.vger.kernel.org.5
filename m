Return-Path: <linux-kernel+bounces-69280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA1A85868D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD021C213ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830E61384AC;
	Fri, 16 Feb 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4IOyeAYE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Da4zfJRF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291E1E520;
	Fri, 16 Feb 2024 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114484; cv=none; b=bNL9GY+one8htTPiRlz6mrmPLi098rrt/S5Rs+UCnBhj1hE+9fjqLfqthM425yzfjU/F5wiCrkJE9/r/8CLB4FzRCqe1LKDLfC/gy8rjYSszM2gZhSK0WmtbQDhLm10smbUoz9bWE61p4EemwbljWnBWkivfTry2wO3DIh/SOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114484; c=relaxed/simple;
	bh=rz9O3Ft4Sq9iNKhwmyORbUt4YE+nVvYLvIYmshWX/0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQ36AeecPWeE0+QpfU8KEC+8BT0m2wmO6fV/fjW7rh2bu5WeIsXeP+OlPbCfGyrE8cyjdH8THTVrDpWyLtrBMIiPp94XNPSaRP5EdZsk3zctzakxOHQI0bGI8fQ+BK77BtTaq1I8boYssyo/v4XeGZUQDhJYIDwLAJGXYaKq/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4IOyeAYE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Da4zfJRF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708114481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7j9WqHfayRaIIREmzZW0nKi8Bnarz7ICJN+nBCweXc=;
	b=4IOyeAYEjUjHckRrd1S3aY4uvbscEQQWp3tmFMOm42bvd2WU30njrgMiIwPVpiO/QL2XrY
	Eo/+d1WwQBI9/cf+/ZHlOY0PAb5MnbCkf1RHtPZpiPvsL+/Gb+9uGeQh2f0V1XPvZ3D9xB
	YNywcoeXeE2mkpdfYOzELxJhVKyDzsqSRKt0l4+rOEWtIQqpWyrI3hjb4x8cj82hSrVDQO
	y+XKMUzsc/EtPRi2YgU/4B4Dr0yNHNzd3L2oAqYSTZl7nEr4t0KnsihOTi2Blagu4tAIBp
	Sa0K+tMysEGj9ASvDgGdpG7TAc+bANkrkIkHUbU8ap/WhbuYf/WvQt5c/Pk+jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708114481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7j9WqHfayRaIIREmzZW0nKi8Bnarz7ICJN+nBCweXc=;
	b=Da4zfJRFHUQE+UmdbrPWJ8vlFxBbtg2C2O6aQ74Anm52kZ3pnZVLFYmT+jfpjjwcMLR+94
	2RuTbIsMTmkjVYBQ==
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
Subject: Re: [PATCH v12 20/25] irqchip/riscv-imsic: Add device MSI domain
 support for PCI devices
In-Reply-To: <20240127161753.114685-21-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-21-apatel@ventanamicro.com>
Date: Fri, 16 Feb 2024 21:14:40 +0100
Message-ID: <87bk8gcgjz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jan 27 2024 at 21:47, Anup Patel wrote:
> +#ifdef CONFIG_RISCV_IMSIC_PCI
> +
> +static void imsic_pci_mask_irq(struct irq_data *d)
> +{
> +	pci_msi_mask_irq(d);
> +	irq_chip_mask_parent(d);
> +}
> +
> +static void imsic_pci_unmask_irq(struct irq_data *d)
> +{
> +	pci_msi_unmask_irq(d);
> +	irq_chip_unmask_parent(d);

That's asymmetric vs. mask().  

Thanks,

        tglx

