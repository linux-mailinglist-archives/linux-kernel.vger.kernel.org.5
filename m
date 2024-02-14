Return-Path: <linux-kernel+bounces-65900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F759855381
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5293E1C254A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0337313DB9D;
	Wed, 14 Feb 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r/cRE8vr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34shzqUR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C045013B7B7;
	Wed, 14 Feb 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940493; cv=none; b=Sc6fOcRKzxfAI2VeQx8RGzcQwrZVhBWY2lUpBgeAnpN/28C0m6ogoDTLBIJ5xa2ASSbV3fLtfTn7LvELnzu3I+DwKkhOF65lz4D0/yKphLoJbeng75kckOUQgD11pDuMyQuMco/MAOOd9ZXLGPGay03rWQTVF2wjxp5FKHbs34U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940493; c=relaxed/simple;
	bh=UuK4CfUxnpN+YoMpPb5ivcSGFUdTmLOtR2MvQPudNKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0xoBF5aq29xJKeuCXw/hFdNe3tW/M0ooIJe1ki7qFwiKCg3ahtmKElNvigwlUAQV+nhsCKzgBS82DiHx3kqCBIufB/e0dxSCHgA0twls6L+4sWsvdgGYCY3pEXTiFJ2lzgJ2S45iguTSfyHH00UjA2M0XWDBAIL49uL3Y9zLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r/cRE8vr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34shzqUR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707940489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pWgmODdyCFjoF/eUm+zQH2zAYiBj+QLBm/2cR/9KvCo=;
	b=r/cRE8vrZLjTq0BX5t9BwA1GKKTu+o751ptz3qrRwruArb3JNTUTIwvL9jVqH+NojBdkID
	rZhdmfFo2s2E7HoO75KRCihFE0yCxFnQ8AXfSpMdDppoKLBpKdNLNZdnBPzR15KgT+j3ao
	0EHOjuW6o809tMVRJrYmwa/A5rcs/ijfCmrN5eYPetI1ovjWXY9EMYIiGtlm7JJ7Kc6wc+
	zY9K+Q7cE7juVAN8gJ+wK/vTtCkaL7tk0vlE/hamvVHiYcEV6rRVsS+g2FdnKyem2GZmtg
	oXnGMzQKY2iDfhvxbd1a054m/kKAByqRpsvBix0C3Y3feeWpTjBQj5uxnUErKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707940489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pWgmODdyCFjoF/eUm+zQH2zAYiBj+QLBm/2cR/9KvCo=;
	b=34shzqURn6yB6YU8XvcxFo+0c6MBj+bXOPv6t32JWTIQyXQM2Kt3gMDa4/8MXvH+YNCLSM
	4Fy9kbVaPiuWTsBw==
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Marc Zyngier <maz@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Atish Patra <atishp@atishpatra.org>, Andrew
 Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Saravana Kannan <saravanak@google.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>, "Ahmed S.
 Darwish" <darwi@linutronix.de>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
In-Reply-To: <CAK9=C2Vwtj2gZg-P73yLMxu0rPXQ3YrRRuxq6HcpHMXgs-jHaw@mail.gmail.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <CAK9=C2Vwtj2gZg-P73yLMxu0rPXQ3YrRRuxq6HcpHMXgs-jHaw@mail.gmail.com>
Date: Wed, 14 Feb 2024 20:54:49 +0100
Message-ID: <87bk8ig6t2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anup!

On Sat, Jan 27 2024 at 21:50, Anup Patel wrote:
>> Changes since v11:
>>  - Rebased on Linux-6.8-rc1
>>  - Included kernel/irq related patches from "genirq, irqchip: Convert ARM
>>    MSI handling to per device MSI domains" series by Thomas.
>>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, PATCH19,
>>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
>>     https://lore.kernel.org/linux-arm-kernel/20221121135653.208611233@linutronix.de/)
>>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mechanism.
>>  - Updated IMSIC driver to support per-device MSI domains for PCI and
>>    platform devices.
>
> I have rebased and included 13 patches (which add per-device MSI domain
> infrastructure) from your series [1]. In this series, the IMSIC driver
> implements the msi_parent_ops and APLIC driver implements wired-to-msi
> bridge using your new infrastructure.
>
> The remaining 27 patches of your series [1] requires testing on ARM
> platforms which I don't have. I suggest these remaining patches to
> go as separate series.

Of course. Darwi (in Cc) is going to work on the ARM parts when he
returns from vacation. I'm going to apply the infrastructure patches
(1-13) in the next days so they are out of the way for you and Darwi,
unless someone has any objections.

Thanks for picking this up and driving it forward!

        tglx

