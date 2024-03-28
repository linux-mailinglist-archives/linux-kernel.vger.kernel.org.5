Return-Path: <linux-kernel+bounces-122371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BEF88F5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5063B1F2B0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BBD2E651;
	Thu, 28 Mar 2024 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uqn+XqvP"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679517984;
	Thu, 28 Mar 2024 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711595828; cv=none; b=KtHVV4ARQ39qDC1VhHjzhKdf+ySEdO+fjRNt+YUaJPaWMlDtz5RMrncGsR1pg24a7avbMpUFtKLBRdTwkmPIwWIv9wdzekynhq6fMPupElCmm/ycQsP9B4I0jxH+6nKX71NtHd7jW2VJJYmFO0pz0FgZCNaxKz10Cya/vmjzA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711595828; c=relaxed/simple;
	bh=WZU75sEIJ9I4luZXGeKzBikSpTAyJfvx+j8qch27+Ug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=q0lM79XrCF+Auni3nesZvu1WzcA38Xa3Ff5/4o3Hivm9cfNZYb4I/UBnjiL0K+O6zJnPT3zvE4xNXPPynD/GdZn7ktXsDdhX5wTrqhbcaPktm30WFdjuurvg3zXYicC1yJtSlFdNCvKucUMFdA9vAnBwpZXJrYNPOUC96NmK00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uqn+XqvP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dddbe47ac1so10764605ad.1;
        Wed, 27 Mar 2024 20:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711595826; x=1712200626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIic1Gjzm4RHTASBVGxTr3rcD5mx/7GlOl+VtL8tSQM=;
        b=Uqn+XqvPoTnuzRYy4vtuzA/63C+Hi1+z4PbLCiUEXdkuYnBrD1MGw9KdeOS1WnXKae
         xSxDoZ1d+oATBsTTfnQScbv2CpU3bQN/g54HANSDDXMzWLodr67CGvRpbjMpc208J2BC
         FPk59/tSfd3GCANyVdXqTeDTl+mXvU6e1QcKgRTP+AMTRWwdWlMlh4gSun2DhOSCkGeO
         XCQdfczEriX/jibvlAde7ibFOglc/uJY38Cu9K81zGdvC+SISc5Br+nuJs9imIx/eV3+
         Wo+PF2ivg20JTb9F2CKtOEIDEkyApi4WQWM5MIMN4ZF7DaXA3nBIpOhODhvbEG0B1HzX
         kNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711595826; x=1712200626;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIic1Gjzm4RHTASBVGxTr3rcD5mx/7GlOl+VtL8tSQM=;
        b=N6lGYJdGAQ0+cAHghOGSzRsfYQ9lt3pCdAf+K5M88uM/HykUia8FMybUsylQtaO86k
         FH01trbZnxuZ0nSaX3JXvLnSQESgytwNmQc/0ETSkd5kaqlQxEhABjP0ww3oPVeZyIPB
         o37i+wnbaTjVSvENlo7DiTD0bDfsj/K5qLKgpdk9jGz4Wc79w37gelARgp9IIIg6SNhO
         gwSkzxbxff+qSpeuzddM1kWj29xhoFsQpkqalElAhJmgfOhI5AaPe7p9HMx+8Ttz7ffD
         7rHNKsb3QaUCmHFlwmc1f0YF/oS5HNfctpPBSH6Cuw5G7ibwSAkUkO7XneuMIcACUg6w
         bZqw==
X-Forwarded-Encrypted: i=1; AJvYcCVLKM8edGyBEVwLqklNAYJal/qKmK8hnADXe0XQSQesoauT+rVFjTVWjjI/C1LV2v7+zv/H+n1kFNDSbjwn5TnvCwmH8wY+/qTPS0TOI9QC+r4Vo17wpqKWyFbtUqHo+4Ae2fXrMlnY7wI/Z26GjuCxqbQcbixLtacfMDUUgUTOU358ZIkhve6h
X-Gm-Message-State: AOJu0YwBwuM+0eAp/9UadjhpVgbNXzDKeuZqnlr0/pPmYF9XumGXem/W
	rBi+MU2a4HDFIkMoBp4UORFLPs1QEC9D3NVruMccAl7Yr6pnMuIS
X-Google-Smtp-Source: AGHT+IHPDlU0Hkncg5/5xwbzTu/Vk2SkkvwQsfse7RZqRzoporjOd6tmpv21FcCQ1w5TOTD1jZJJHQ==
X-Received: by 2002:a17:903:446:b0:1e0:cea:257e with SMTP id iw6-20020a170903044600b001e00cea257emr1359031plb.2.1711595825766;
        Wed, 27 Mar 2024 20:17:05 -0700 (PDT)
Received: from ?IPV6:2001:b400:e355:7eb0:17c6:c47d:d4ee:f9e8? (2001-b400-e355-7eb0-17c6-c47d-d4ee-f9e8.emome-ip6.hinet.net. [2001:b400:e355:7eb0:17c6:c47d:d4ee:f9e8])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b001e20b3ccdc2sm303861pli.285.2024.03.27.20.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 20:17:05 -0700 (PDT)
Message-ID: <9dca6a69-5fa2-4184-8e18-f5fa1c17f3c3@gmail.com>
Date: Thu, 28 Mar 2024 11:17:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] drivers: watchdog: ast2500 and ast2600 support
 bootstatus
From: PeterYin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240328013303.3609385-1-peteryin.openbmc@gmail.com>
 <20240328013303.3609385-5-peteryin.openbmc@gmail.com>
Content-Language: en-US
In-Reply-To: <20240328013303.3609385-5-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Peter Yin 於 3/28/24 09:33 寫道:
> Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600
> 
> Regarding the AST2600 specification, the WDTn Timeout Status Register
> (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> on ast2500 if the boot was from the second boot source.
> It does not indicate that the most recent reset was triggered by
> the watchdog. The code should just be changed to set WDIOF_CARDRESET
> if bit 0 of the status register is set.
> 
> Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
> ast2500 SCU3C when bit1 is set.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>   drivers/watchdog/aspeed_wdt.c | 34 ++++++++++++++++++++++++++++++----
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..c3c8098c035d 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -11,10 +11,12 @@
>   #include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/kstrtox.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_irq.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/watchdog.h>
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -82,6 +84,13 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>   #define WDT_RESET_MASK1		0x1c
>   #define WDT_RESET_MASK2		0x20
>   
> +/*
> + * Ast2600 SCU74 bit1 is External reset flag
> + * Ast2500 SCU3C bit1 is External reset flag
> + */
> +#define AST2500_SYSTEM_RESET_EVENT	0x3C
> +#define AST2600_SYSTEM_RESET_EVENT	0x74
> +#define   EXTERN_RESET_FLAG		BIT(1)
>   /*
>    * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
>    * enabled), specifically:
> @@ -330,6 +339,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	if (IS_ERR(wdt->base))
>   		return PTR_ERR(wdt->base);
>   
> +	struct regmap *scu_base = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							     "aspeed,scu");
> +	if (IS_ERR(scu_base))
> +		return PTR_ERR(scu_base);
> +
>   	wdt->wdd.info = &aspeed_wdt_info;
>   
>   	if (wdt->cfg->irq_mask) {
> @@ -459,14 +473,26 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	}
>   
>   	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> -	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
> +	if (status & WDT_TIMEOUT_STATUS_EVENT)
>   		wdt->wdd.bootstatus = WDIOF_CARDRESET;
>   
> -		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
> -		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
> -			wdt->wdd.groups = bswitch_groups;
> +	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
> +		ret = regmap_read(scu_base,
> +				  AST2600_SYSTEM_RESET_EVENT,
> +				  &status);
> +	} else {
> +		ret = regmap_read(scu_base,
> +				  AST2500_SYSTEM_RESET_EVENT,
> +				  &status);
> +		wdt->wdd.groups = bswitch_groups;
>   	}
>   
> +	/*
> +	 * Reset cause by Extern Reset
> +	 */
> +	if (status & EXTERN_RESET_FLAG && !ret)
> +		wdt->wdd.bootstatus |= WDIOF_EXTERN1;
> +
>   	dev_set_drvdata(dev, wdt);
>   
>   	return devm_watchdog_register_device(dev, &wdt->wdd);
Please ignore this version, as I lost the definition for 
WDT_TIMEOUT_STATUS_EVENT.


Thanks.

