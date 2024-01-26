Return-Path: <linux-kernel+bounces-40055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D080083D97A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1551F24382
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D7175B4;
	Fri, 26 Jan 2024 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2DOHFRO"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432DA17584
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269059; cv=none; b=nvDQj/r97uV+BcPPl+cxOHwFUBX2Ux/E/tbD5hwCDviW8QnUz/b6wwDRqwZ7JWLBaCvtw2FQlkE8FARHJXTUsJ/ahE/xSBN3oFtzELKwaZwy3EJlUsbX5BQFRe8jpHoCSHecHh6+cUxJ+Vfq/HIKBYeE4NbSv8nGCDNGuHx/qm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269059; c=relaxed/simple;
	bh=aVtryNgCeI9llkL9nErhikWbqjYRuoSjAg5NeEwQLjM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YK6Nc1gL08lqadKOfDXQoZpuqb0O4GumpesAcN+uvkYac16AV0qK+Whwfr6Jj20+aRR3QsZnNVusKpnRmjob3gh1aPRUcKTKC0GrP+01cqNDSp38GQccIVGDKri3ZRyjbY4egZVO+pKsSs7anKWB5UoOiMFLqrzYxkTZvsUYFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r2DOHFRO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so86292666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706269056; x=1706873856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyfE4aHWGmupocj2MXVZCjO5uTyD3plTwI5NbWoJyRI=;
        b=r2DOHFROPuJAfDfRysrYaNgHgE/xqLmLhoXwDcUHaQDRnp1ZZ/JSDKP/1tArAH0Bi+
         zNXQNvAnRxq+vB/n7i0wTthgNWinkFBDA5YSXeslXlX0oDeeQJGOYE8tQhqNHxnVLcWu
         QRWigzosloeIy/0BnEH5SuNhH4QHyoW70TQ0bFJI4Jr8f6ihD5IRLxfb7OnVWCnsAsxN
         cX+ubE23Ou5TH0ZRKEZbaXVh3HA1Wacz2SWTYS7tzCjQYCTd35WM6zxEGyKn9SIVrRvc
         gKMfgMAEwSn/3jsBSkRLiTxu9wKOlEDQrr6CO/EPJaxCr0jVgjI5RX3MAdfDERNqMJI8
         KE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706269056; x=1706873856;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyfE4aHWGmupocj2MXVZCjO5uTyD3plTwI5NbWoJyRI=;
        b=aTNohbAfCf+E8rOnPj7vogCBpmG0an1ctymaRULOg12w+jOAVND4skxSenC7egmKxa
         3uxvIFRJ8gVPuJZF3QxhZY6JovsC+be3b8ueYvXHe2mf1/slp5W4sxI8nmzZq7y137K8
         YGOVHiQiwShb/2U8ooVVFHgDkLri8rQlJRxXtlJ3xcXPM+lI2TkBMYw+Hu421RxpqoYY
         m6d5AL2E4b079rKHSc5eaJmQAF2s0MJz2nsOHMOQAa9U19RSmsHReNCtCKzhU4JJCtfM
         FXlwc88ig7SxZrrsmQp9EufKGnjMXXoohLkz7oWHcPh/tB+Sz7zhNO5xVz8+m4j2Y65S
         OwGg==
X-Gm-Message-State: AOJu0YycKPuvjMs18Bo4Hi6rN89RnAo09DJd1k3j9+NqfQQzUcvBQtKB
	woOWmLGfOT9kzqx8R1++RyiH+z8MZwzWGYaQHR1M7NyaiCo1M/B7JeaBwilk5um4X1Nfxtj6Bm5
	6
X-Google-Smtp-Source: AGHT+IE5JL0AWt0MwbO/5tTi7/PLqwNL3x9FZCwpvME4CHdNTEo/fI4XwYPgYtF7z78zX/MliMr66Q==
X-Received: by 2002:a17:906:c45:b0:a31:6a55:7d71 with SMTP id t5-20020a1709060c4500b00a316a557d71mr1378211ejf.71.1706269056409;
        Fri, 26 Jan 2024 03:37:36 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id cw6-20020a170907160600b00a2d5e914392sm534735ejd.110.2024.01.26.03.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 03:37:36 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: linux-arm-kernel@lists.infradead.org, 
 David Lechner <david@lechnology.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Rob Herring <robh+dt@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20211017195105.3498643-1-david@lechnology.com>
References: <20211017195105.3498643-1-david@lechnology.com>
Subject: Re: [RESEND PATCH] ARM: dts: da850: add MMD SDIO interrupts
Message-Id: <170626905516.53425.15339364766871978744.b4-ty@linaro.org>
Date: Fri, 26 Jan 2024 12:37:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sun, 17 Oct 2021 14:51:05 -0500, David Lechner wrote:
> This adds the MMC SDIO interrupts to the MMC nodes in the device tree
> for TI DA850/AM18XX/OMAP-L138.
> 
> The missing interrupts were causing the following error message to be
> printed:
> 
>     davinci_mmc 1c40000.mmc: IRQ index 1 not found
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: da850: add MMD SDIO interrupts
      https://git.kernel.org/krzk/linux-dt/c/8af75ce86f7d55124e41b499aa43f50748138bec

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


