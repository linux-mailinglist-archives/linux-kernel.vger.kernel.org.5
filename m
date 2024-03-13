Return-Path: <linux-kernel+bounces-102342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7B987B13E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB128B2F7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB816CDDC;
	Wed, 13 Mar 2024 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DanZVOf+"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1D60877;
	Wed, 13 Mar 2024 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353869; cv=none; b=T/S81gDU80s33Ed+IiTExC7jr01PI73hF7G9VB6T6AbCFszSVslmBfzUm5GLecjyKRiz+2ysqcZlZhAbBWcW0RdF8X1C7R3f2YzQFBjupu1oqF6bIHAKeC2Xbqf9WnQq3VBcvT2ujjemMt16fwmBImXTUm+5GquVnY1VygEcqQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353869; c=relaxed/simple;
	bh=SyVMnZvS/ZnHg0qyb832r9jYPgwDvt2Fg5Z/R12KPYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POhERabFimGMZylOxxjDrgZ4pvs80SjueB5/CoHNqnaIMUhFF449Ii1iitjvkXH89hPc+WRVnhMsJdzooPErOYdWiPQr5Jw/NcGJrPMkF6WbWyDz/qez/gJWL50P5rJLw2F5lA7wBEeDRj6doupkeLNjr5N5DMNmm2o69cvUqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DanZVOf+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e94c12f33so43102f8f.3;
        Wed, 13 Mar 2024 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710353866; x=1710958666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxB79hpmOYEV/Wa5xEjs3BbB8JPGXY5M54cM2DcOGjk=;
        b=DanZVOf+j3V4oBl3usOH/HLXylzxsRgldm0cK2Ynj7Te71j6NFxOF27deeAntMu+Nh
         8yO5VnNLrNLKXAD4jShxHHXDhayWmd4zXNgMb4GBPs9xZN/y/vU14nskmsIiBTYWbg58
         inVRXWY+lgyzycUVt6TLfQfg/ob65WwY/RPleJJms42VXJl2xFZgH4LGU40uycdnMFY/
         imoZ/4VGtZI+JGmtpVJPKAIweSbApg/yoN0lA+VK1MOSEqqMjOD+k5dRvfFGebNQj6g0
         3laoraQy85nSrUJlKBcQoY6CFH8QwpnrxXKdKDVtEISAk9TJqvswYM1eQOSSIuWcl39Z
         WODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710353866; x=1710958666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxB79hpmOYEV/Wa5xEjs3BbB8JPGXY5M54cM2DcOGjk=;
        b=F6IQu+e0hN82AV1zN0ntavaNPnxPT/6KYYaanZm9nQY9bC0LFKb2FMk0yd/QJo8+K5
         3h2whb6+MoOQ/nPflqC8hPtz3wH092qITfFYCXK9uoInbLT7tfpAY6heEZVR5/XSCYSq
         ov+6ubIbVmLkhx8e9Fsot5FJ5RIKfiGm/x75NnDi6YrFWwlZdIpsdmK0BeyT+ga4uirK
         nyWeN458LdK/lkKLanMMgqFIwJDD5V2xTGqNMqS4wxr3bZ4Vw8KaTqd/DeY9sxDmnJjL
         15nYcF7V3Gqxhoui1BILOPkl0PU/xl4PiKk9/cnGH/W1JcDX8e7R7Y8sdRlOErt2J/DA
         OT6g==
X-Forwarded-Encrypted: i=1; AJvYcCXaQlIwUqkeaGNY932ja8F7jRnu515OBujl7+BdQuKVw0JnUYsycEWBRyVVFQVeRe1nPjJ7QLLlwj4+vQzCUY0gp8yFu3t3mgAojbGa0Qiud7pWV0G7ynKCth5/HJzbAr+eNOgzctF3SkvD3l8Yta86djQ4KJOsTO9oLkPi5KeGoQ==
X-Gm-Message-State: AOJu0YwvGWFdUcnl/j/o2An7D9vStQ2yS0zHSlp8X+p8LF9Rl1TEnNO4
	IfCyhP8UOEY6SuKAAaoQne9hDi2E/V46GlekNAmDCG5N6VMDSWZq
X-Google-Smtp-Source: AGHT+IGKbeIwigUlBRsdMhJK7OomlBsIup1DbJY8unvtALG2eksaRqlMkijulA70G2ebsv8fF6clmw==
X-Received: by 2002:a5d:644d:0:b0:33e:7896:a9d7 with SMTP id d13-20020a5d644d000000b0033e7896a9d7mr2108713wrw.67.1710353865784;
        Wed, 13 Mar 2024 11:17:45 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ch9-20020a5d5d09000000b0033eab3520a9sm4381264wrb.43.2024.03.13.11.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:17:45 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Frank Oltmanns <frank@oltmanns.dev>, stable@vger.kernel.org
Subject:
 Re: [PATCH v4 1/5] clk: sunxi-ng: common: Support minimum and maximum rate
Date: Wed, 13 Mar 2024 19:17:43 +0100
Message-ID: <3210009.5fSG56mABF@jernej-laptop>
In-Reply-To: <20240310-pinephone-pll-fixes-v4-1-46fc80c83637@oltmanns.dev>
References:
 <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
 <20240310-pinephone-pll-fixes-v4-1-46fc80c83637@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 10. marec 2024 ob 14:21:11 CET je Frank Oltmanns napisal(a):
> The Allwinner SoC's typically have an upper and lower limit for their
> clocks' rates. Up until now, support for that has been implemented
> separately for each clock type.
> 
> Implement that functionality in the sunxi-ng's common part making use of
> the CCF rate liming capabilities, so that it is available for all clock
> types.
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> Cc: stable@vger.kernel.org

This looks pretty nice now.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu_common.c | 19 +++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_common.h |  3 +++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
> index 8babce55302f..ac0091b4ce24 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.c
> +++ b/drivers/clk/sunxi-ng/ccu_common.c
> @@ -44,6 +44,16 @@ bool ccu_is_better_rate(struct ccu_common *common,
>  			unsigned long current_rate,
>  			unsigned long best_rate)
>  {
> +	unsigned long min_rate, max_rate;
> +
> +	clk_hw_get_rate_range(&common->hw, &min_rate, &max_rate);
> +
> +	if (current_rate > max_rate)
> +		return false;
> +
> +	if (current_rate < min_rate)
> +		return false;
> +
>  	if (common->features & CCU_FEATURE_CLOSEST_RATE)
>  		return abs(current_rate - target_rate) < abs(best_rate - target_rate);
>  
> @@ -122,6 +132,7 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, struct device *dev,
>  
>  	for (i = 0; i < desc->hw_clks->num ; i++) {
>  		struct clk_hw *hw = desc->hw_clks->hws[i];
> +		struct ccu_common *common = hw_to_ccu_common(hw);
>  		const char *name;
>  
>  		if (!hw)
> @@ -136,6 +147,14 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, struct device *dev,
>  			pr_err("Couldn't register clock %d - %s\n", i, name);
>  			goto err_clk_unreg;
>  		}
> +
> +		if (common->max_rate)
> +			clk_hw_set_rate_range(hw, common->min_rate,
> +					      common->max_rate);
> +		else
> +			WARN(common->min_rate,
> +			     "No max_rate, ignoring min_rate of clock %d - %s\n",
> +			     i, name);
>  	}
>  
>  	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
> diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
> index 942a72c09437..329734f8cf42 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.h
> +++ b/drivers/clk/sunxi-ng/ccu_common.h
> @@ -31,6 +31,9 @@ struct ccu_common {
>  	u16		lock_reg;
>  	u32		prediv;
>  
> +	unsigned long	min_rate;
> +	unsigned long	max_rate;
> +
>  	unsigned long	features;
>  	spinlock_t	*lock;
>  	struct clk_hw	hw;
> 
> 





