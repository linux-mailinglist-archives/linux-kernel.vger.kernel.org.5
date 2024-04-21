Return-Path: <linux-kernel+bounces-152611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8348AC122
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718A3B20BF5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8164205A;
	Sun, 21 Apr 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFpOl9nC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630653DB9A;
	Sun, 21 Apr 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713729449; cv=none; b=Zx1wcMn9+pOkSBRVDyqupvdoiQfAHC3FbO1+fIV/kelKM7ArYVXvSkQj0uBQ8ar7c41f4yoQVxBu43mQmJ8lACfNca4NCFKyPsbYRxuUqLnngs/J1bUSmJFR4zBR9wUl1Ok9Ysjcn8nhDoWAG26FwPHck4gg6Xg9qlBPZ2fqiP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713729449; c=relaxed/simple;
	bh=efXD1Qv/kAEdBkbZzyouDJ1rmUvO0imo3+ybv0v75PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoqRzWrTb0lLwMcEBJEElbUuzW4I1GdYAbuL+fPEPiPnE5VZhtLfdImkUKuOQKANFBoKx2pEI6Ciy9Q6hpSA23F3/cN/xd5JIb+OUU2warRgvGa63y8BHnD8/u4D+DuTf2MZHMUVkBuIr275jh/ZJN6rMnJiARlTtNog4YuPIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFpOl9nC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a4f291f9dso1886695e9.2;
        Sun, 21 Apr 2024 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713729446; x=1714334246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWdX/Fk775nBpYl4rDPq0H/p5QVPSKIZBRRPn4D/xoc=;
        b=XFpOl9nCC89PO0/AqtvCu/99I7rhoH43hCbDG1iFArmJBAjl/sjFXBUzEnBJ6V71jr
         JK0oIsg/Dejrw7QS43aj72mKHpUaX+0wVBFXaC6ZMslAi6qPXLhkGj+R7LjoYAvXEuX7
         iyoGoykFkTcFIg6ETqJaz9TyHTKOEeeYgiA2YrfWMJKL3PCeCIfw2k4VaSkE+868nuxk
         tmq7RC9XEAQaOP9a/ws3mdStFeDkfq3xK2/vH7t4YMJs1l3SwhZYYEK8x47UY9zkcw+l
         RGgR02FxtUKQoaav0q9/aR5VIIajsqJMe0cQ/93TNRUWv9fg9JVA57WfRNNG2E14GnBF
         n8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713729446; x=1714334246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWdX/Fk775nBpYl4rDPq0H/p5QVPSKIZBRRPn4D/xoc=;
        b=CicGzoFlKO1rOp8EW/lshO+Fc+bi9mx2GONELpOtvQdoQ/949gp+eOsKE+rRKH+Hf4
         aYI7wOhtRPMSBAx26MC0RFSRk/R+Gt8CczAYJzxSsgyqbLL6I2j6p2eIDNVEPDeTQo29
         D/mSbbEVPWCufSbXFTL2LCJpBmn4fOxJ+tg8NqdzgXtybnZrhSxykAXOuY6f18HhDQJr
         UoF/JN3xlkgUJSePxdTJa7s68g9iu+snk0r+ccjyHlMUK8T4mlkAY9UeBjIOqttYQ6XZ
         VC/on40+wvmRYaGEageaHSKcv27fxCaqlAnEiUzzdrTwXyJ/5tEQYrnsK5phaT9IEat5
         I0jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrLOXpZTLW5uvObk60NLYs97Lpf5mm/e1KWHQgnCUxmXUg9P+jKmvhkEXShicTdAHf7LamRFDjre+7y2jAjqPbMlTGY53bA4oP5d/Hb9KlVptkrQ2SVMvAM8EMPdjROh+mtav2Nb49
X-Gm-Message-State: AOJu0Yz7cjxJHtlFk3qILX98xxfDvm/aniJHVvM4CfC2yb/0WPSq0lM4
	QqqzOY75GfXFtu4no73kTY95BMsKAfpGHRMIUYMisC8QlHvQdTPY
X-Google-Smtp-Source: AGHT+IE/u/1wW4JDdI97bb6vvTW1FRs57v0KjrCXVMCAkW2tNn2qGf7AQtcRuQ9M7lKhchv08tZE2Q==
X-Received: by 2002:a05:600c:4686:b0:418:201f:f991 with SMTP id p6-20020a05600c468600b00418201ff991mr4181483wmo.40.1713729445408;
        Sun, 21 Apr 2024 12:57:25 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c190a00b00418a9961c47sm14260154wmq.47.2024.04.21.12.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 12:57:25 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: a.zummo@towertech.it, Alois Fertl <a.fertl@t-online.de>
Cc: alexandre.belloni@bootlin.com, wens@csie.org, samuel@sholland.org,
 linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, a.fertl@t-online.de
Subject: Re: [PATCH v2 1/1] drivers/rtc: rtc-sun6i: AutoCal Internal OSC Clock
Date: Sun, 21 Apr 2024 21:57:24 +0200
Message-ID: <6035510.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20240421183633.117326-1-a.fertl@t-online.de>
References: <20240421183633.117326-1-a.fertl@t-online.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 21. april 2024 ob 20:36:33 GMT +2 je Alois Fertl napisal(a):
> I have a M98-8K PLUS Magcubic TV-Box based on the Allwinner H618 SOC.
> On board is a Sp6330 wifi/bt module that requires a 32kHz clock to
> operate correctly. Without this change the clock from the SOC is
> ~29kHz and BT module does not start up. The patch enables the Internal
> OSC Clock Auto Calibration of the H616/H618 which than provides the
> necessary 32kHz and the BT module initializes successfully.
> Add a flag and set it for H6 AND H616. The H618 is the same as H616
> regarding rtc.
> 
> v1->v2
> - add flag and activate for H6 AND H616

Please move changelog below --- line.

> 
> Signed-off-by: Alois Fertl <a.fertl@t-online.de>
> ---
>  drivers/rtc/rtc-sun6i.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index e0b85a0d5645..5d0c917b2099 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -42,6 +42,11 @@
>  
>  #define SUN6I_LOSC_CLK_PRESCAL			0x0008
>  
> +#define SUN6I_LOSC_CLK_AUTO_CAL			0x000c
> +#define SUN6I_LOSC_CLK_AUTO_CAL_16MS		BIT(2)
> +#define SUN6I_LOSC_CLK_AUTO_CAL_EANABLE		BIT(1)

EANABLE -> ENABLE

> +#define SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL		BIT(0)
> +
>  /* RTC */
>  #define SUN6I_RTC_YMD				0x0010
>  #define SUN6I_RTC_HMS				0x0014
> @@ -126,7 +131,6 @@
>   *     registers (R40, H6)
>   *   - SYS power domain controls (R40)
>   *   - DCXO controls (H6)
> - *   - RC oscillator calibration (H6)
>   *
>   * These functions are not covered by this driver.
>   */
> @@ -138,6 +142,7 @@ struct sun6i_rtc_clk_data {
>  	unsigned int has_losc_en : 1;
>  	unsigned int has_auto_swt : 1;
>  	unsigned int no_ext_losc : 1;
> +	unsigned int has_auto_cal : 1;
>  };
>  
>  #define RTC_LINEAR_DAY	BIT(0)
> @@ -268,6 +273,13 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
>  	}
>  	writel(reg, rtc->base + SUN6I_LOSC_CTRL);
>  
> +	if (rtc->data->has_auto_cal) {
> +		/* Enable internal OSC clock auto calibration */
> +		reg = (SUN6I_LOSC_CLK_AUTO_CAL_16MS | SUN6I_LOSC_CLK_AUTO_CAL_EANABLE |
> +				SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL);

Remove parenthesis and fix indentation. Since macro names are pretty long,
maybe put one per line.

Is this safe to be done even on the boards with external 32k crystal?

Best regards,
Jernej

> +		writel(reg, rtc->base + SUN6I_LOSC_CLK_AUTO_CAL);
> +	}
> +
>  	/* Yes, I know, this is ugly. */
>  	sun6i_rtc = rtc;
>  
> @@ -380,6 +392,7 @@ static const struct sun6i_rtc_clk_data sun50i_h6_rtc_data = {
>  	.has_out_clk = 1,
>  	.has_losc_en = 1,
>  	.has_auto_swt = 1,
> +	.has_auto_cal = 1,
>  };
>  
>  static void __init sun50i_h6_rtc_clk_init(struct device_node *node)
> @@ -395,6 +408,7 @@ static const struct sun6i_rtc_clk_data sun50i_h616_rtc_data = {
>  	.has_prescaler = 1,
>  	.has_out_clk = 1,
>  	.no_ext_losc = 1,
> +	.has_auto_cal = 1,
>  };
>  
>  static void __init sun50i_h616_rtc_clk_init(struct device_node *node)
> 





