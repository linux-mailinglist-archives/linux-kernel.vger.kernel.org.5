Return-Path: <linux-kernel+bounces-39069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2552A83CA80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABFD1C25400
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45081133983;
	Thu, 25 Jan 2024 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PYoziZdM"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61630133426
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205866; cv=none; b=fkn3pj3nYN77vxUazVNRUoYW69pSLtxHCM+qLTuPRk6Jyv1c4AVuBTVpcdZf6BjbQ8s4AKp/kaq3crnKqedWE19IQ6TL8Amqf5r4jzcZj+XMonF0L0qzEqq8g2LfmlQycwy2nSf6OxNV0XB50+ZJ+/Almf0fwPOM7n/YojePxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205866; c=relaxed/simple;
	bh=jNa8Tk4jMsQxNpLS5wzZjgSt9rxUGQ9AVXYhYCuvYYc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJ6DxxYqdh8j0d8vDPbMyOYLE/G3Zfv7pnHCF6oInbjYK64v7S9ewhp1CHui0zTfBfO2HwUGwDDT9iZz847z0xIrT7D/8NjDfrBfZ1CMRQMtBLTrKNw2nG907ze/DgVIrdIihKNcSMdYIM4yydKkwRQuZWsGQtgZhc4OTih9q58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PYoziZdM; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1AD583F278
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706205856;
	bh=ayub+31DU82NBlOvVCPDnf32wdKHrULJJXVRXXuuL9c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=PYoziZdM51JoXq0hr52HJCcRvUJmo6e5IOCNgetRKw8xU/bOlLtuz5JK+RbYJHF8P
	 Gbn8XOlDNnkhjbLQNUe4FROrj/gCP+lv+3ZKLfv6qhN1Oslg83UkfLkft6yNwvXCX6
	 QF4/n7jZ0z6hp1iNY5tE4DBq84BPSmVcFzEhe3pqvvtqYH7AM+vA91v8PZPnY6dtF5
	 Vt90NZO6jvSin4y5d1v15akjIYijRiHhS68LWEXmkzQJb9rnUz55/SbfRE2AlueIDV
	 8VqrvUUXL/ajQtOFjIg7RkGvRl57Ffk7fbGdJHPG3ns5hbo13Gj1MZCWMruWK6TDuK
	 O4S/TmmGmihqQ==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42a3e4e9155so75344991cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706205855; x=1706810655;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayub+31DU82NBlOvVCPDnf32wdKHrULJJXVRXXuuL9c=;
        b=v9pDgt1voEgcVnluvn1OgPDvBWnzbikr39MNRdFZPK4UZ1mg+VbStRgOycOTVUkXde
         dF7ujZrZicOcRailRJOH9mXlqV21QN+BQCM83Dvh6SkHgPG/eq4wZnj+pQrQhQT0xzSP
         DfyihYS19mqcDQdcJOCIcuN/vrshv2GhlqbruKHchhQp+noQ5hoAe2bJi6ZVA3oa+Vmu
         jU6wd0Wu0TWTqA3YCq3cF4QYpV43hbLw6FhJOSTMSolv6SQt/p/0nWBoBwVc1IEPly9u
         hVkd5aDsbonZiS2u2ImfBgO6FslL7GGDiCR6quoUddR5+QHqg03a/ktu0/yJaBg6nkHR
         muyg==
X-Gm-Message-State: AOJu0YzC99kia/RT+xvoWV34B2tQGfQWl6Xm1zlB8v/uw8/iVKkAYVzh
	CCNhQyWl6C7lMGtbzG0os5P9fa5OIb2wRbwEeHpCfJHTWbQGJ5ihJmVJTF7NH+vwFUj3szLzvJo
	s4VwFEKKgziyx8Qmje8XhVgeMhCQf275oeJ+vKcvPdI1ComKXCwxK1waw1nbfpjlmXF3iZ3jYHO
	HCueyPesn2fHBnzdrLg1UZsaCnTE8YjxyAV2NZm77EtigABgly2Oq1
X-Received: by 2002:a05:622a:1a9a:b0:42a:39ef:e699 with SMTP id s26-20020a05622a1a9a00b0042a39efe699mr40100qtc.96.1706205855075;
        Thu, 25 Jan 2024 10:04:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg5qDGICDhkaPcE9L5WU3IS+FgRzGS9fLfcnH+CV2bsry9F4JkTFoWocsmx3aGbnJrWIYBpfdW4XfPKSyrFSA=
X-Received: by 2002:a05:622a:1a9a:b0:42a:39ef:e699 with SMTP id
 s26-20020a05622a1a9a00b0042a39efe699mr40078qtc.96.1706205854721; Thu, 25 Jan
 2024 10:04:14 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Jan 2024 10:04:14 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
References: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 25 Jan 2024 10:04:14 -0800
Message-ID: <CAJM55Z8aeQs+KOHo-5dxHE+kDSp5DMaNcw3MukzS_K0HGj92Og@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dts: sophgo: add watchdog dt node for CV1800
To: AnnanLiu <annan.liu.xdu@outlook.com>, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

AnnanLiu wrote:
> Add the watchdog device tree node to cv1800 SoC.
>
> Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
> ---
> This patch depends on the clk driver and reset driver.
> Clk driver link:
> https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com/
> Reset driver link:
> https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/
>
> Changes since v1:
> - Change the name of the watchdog from watchdog0 to watchdog.
> - Change the status of watchdog.
> v1 link:
> https://lore.kernel.org/all/DM6PR20MB23160B8499CC2BFDAE6FCACDAB9EA@DM6PR20MB2316.namprd20.prod.outlook.com/
>
>
>  arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |  4 ++++
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi          | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> index 3af9e34b3bc7..75469161bfff 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> @@ -36,3 +36,7 @@ &osc {
>  &uart0 {
>  	status = "okay";
>  };
> +
> +&watchdog {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index aec6401a467b..03ca32cd37b6 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2024 Annan Liu <annan.liu.xdu@outlook.com>
>   */
>
>  #include <dt-bindings/interrupt-controller/irq.h>
> @@ -103,6 +104,21 @@ uart4: serial@41c0000 {
>  			status = "disabled";
>  		};
>
> +		watchdog: watchdog@3010000{
> +			compatible = "snps,dw-wdt";
> +			reg = <0x3010000 0x100>;
> +			interrupts = <58 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pclk>;
> +			resets = <&rst RST_WDT>;
> +			status = "disabled";
> +		};

Before this patch the nodes seems to be ordered by their address. This
patch breaks that.

> +
> +		pclk: pclk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <25000000>;
> +		};
> +
>  		plic: interrupt-controller@70000000 {
>  			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
>  			reg = <0x70000000 0x4000000>;
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

