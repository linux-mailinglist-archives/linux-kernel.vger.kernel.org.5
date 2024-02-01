Return-Path: <linux-kernel+bounces-48948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5689984637C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0DB28ECD0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E6C41757;
	Thu,  1 Feb 2024 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUCJFliT"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F0C3FB37
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826829; cv=none; b=UeFcxyCKlmyyR8BTLSFayMx5ydppuWS8rDRXemXny6Cs64afExhUQKa03fm64qYjnZKgHiC5Gy6zE9+0JmT7FirtLEiJJcV6pRWG6DKfl8l1mSxeof+vnvW9kMpOhrY7/2Dj1yvdi3q7nuLZtamSaiEIRIFoLObfN2YJSioU7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826829; c=relaxed/simple;
	bh=KPsuTJp7C2O14rQ/OpkjWMA8klxdzcOuKfmwo10erDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYSOoXrpUSaTqCpJaJPrtdQCM2Y3FAlQQRd2coBU2sTUe4Bnhb/ggZwIx+uA7789jdTu+uxzjLVUmdaHfMeGEDA54ucE5Gil9OPnGXEvF2D0r7FgEFMYqjvb7jDtKJ1sJHjYGiiXXa5Png5JOC7LiFBYHCYGa/UIpxOe1GNdJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kUCJFliT; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6041779e75eso15952027b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706826825; x=1707431625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dIIwz+3axs9ofDIOeEvHfTKblaO7IqF1Ngm8UvpUX1Q=;
        b=kUCJFliTr8A6aqTvxw2EKSSABBqpD6stsBEFeqB6syyt1ZGB0ZwNFRMnt3kUP4a6nV
         NYVTE6DdXwPRdKqHC3RsBUETqP+rzPIQISYS9fCtKv3X3wOLAHXb3dqL1Gsqm0KZocQ8
         FXoHf4x6l21jwKfeaftujwUAUYTLfNtdtuBztMrIEEePI0XsGtQiFUtq1tNfJHR/+kz2
         x5tmURGLp2HOcR/3K9Uo75zFjrM5fFY8TLOAKjG44l/gZSPPvgRukPH2HTz/SLmxbjPj
         8vPa9Z6eku2U83Y+Fu4OCzNAZ5X/q5FqyEcUnMoBpX14xsVPVwx/8H086kWLxg2VzYtK
         p4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826825; x=1707431625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIIwz+3axs9ofDIOeEvHfTKblaO7IqF1Ngm8UvpUX1Q=;
        b=IlBEd1U1bIK8hpY8OLaGaKt6W8q6i/LQ3XEcTpVSqI167G3nXPwu7Z/KL7EmAINt8q
         EMOCXvphJozUI/QwD9pTt/guOoLnKldDFB91WU7RESpIc3zehxPMHfY1NsccfDrHLvyV
         8/PLaxoe367/7tXBHmUKu0N5zstjfx6IVUKE7qo2Zm8MsnBIq2Swl2OLPvC/X+16kLqg
         drAHW9Qe2Z0ETKuX4gwzkS5T1m5T2+uCJoAe6zEbbNbIQKM2mX3ZUjb9reBH+2jZ0Lsd
         qwU/pOT4Sydld4/NBnjeAO9bANIN0a4ElsGoSHuh8geAvb1WbR4CrUOoJGRrEIgXOKEE
         a2wA==
X-Gm-Message-State: AOJu0Yzd9mFbLuSybS+oZhXkyIIrDu6qTr7DkRfbIed0Z7qDnO8NNWSW
	kwHTCA8gA4PEjqjB69HGLagBKW2AD9jvMdbEY6qR47zcXJW/4yKM/vRcL0ZfJ1g81ukxY5oNamU
	mRHtIBh7WidOuigR9EKvq81tr5RB/YHNFrDQnqQ==
X-Google-Smtp-Source: AGHT+IF7BDmJIAD3GWfaR3LtCEEoe0JI/tVQDjPpj6nt/WoSO5SWJoDA8NTnrqWTr5/sudeieo2dIjRJcvM54TnT/YE=
X-Received: by 2002:a81:488d:0:b0:5ff:b104:cc74 with SMTP id
 v135-20020a81488d000000b005ffb104cc74mr640319ywa.2.1706826825581; Thu, 01 Feb
 2024 14:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106223951.387067-1-aford173@gmail.com> <20240106223951.387067-2-aford173@gmail.com>
In-Reply-To: <20240106223951.387067-2-aford173@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Feb 2024 23:33:09 +0100
Message-ID: <CAPDyKFpx_Xo6Y5yGfuMiV8w3kR2hL6f8t31pKC=91-wEperqjA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock
 to hdmimix domain
To: Adam Ford <aford173@gmail.com>
Cc: linux-pm@vger.kernel.org, Sandor Yu <Sandor.yu@nxp.com>, 
	Jacky Bai <ping.bai@nxp.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jan 2024 at 23:40, Adam Ford <aford173@gmail.com> wrote:
>
> According to i.MX8MP RM and HDMI ADD, the fdcc clock is part of
> hdmi rx verification IP that should not enable for HDMI TX.
> But actually if the clock is disabled before HDMI/LCDIF probe,
> LCDIF will not get pixel clock from HDMI PHY and print the error
> logs:
>
> [CRTC:39:crtc-2] vblank wait timed out
> WARNING: CPU: 2 PID: 9 at drivers/gpu/drm/drm_atomic_helper.c:1634 drm_atomic_helper_wait_for_vblanks.part.0+0x23c/0x260
>
> Add fdcc clock to LCDIF and HDMI TX power domains to fix the issue.
>
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Just to let you know, this looks good to me and it seems like the NXP
people like this too. What I am waiting for is an ack on the DT patch,
then I am ready to queue this up.

Kind regards
Uffe

> ---
> The original work was from Sandor on the NXP Down-stream kernel
>
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> index e3203eb6a022..a56f7f92d091 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -55,7 +55,7 @@ struct imx8mp_blk_ctrl_domain_data {
>         const char *gpc_name;
>  };
>
> -#define DOMAIN_MAX_CLKS 2
> +#define DOMAIN_MAX_CLKS 3
>  #define DOMAIN_MAX_PATHS 3
>
>  struct imx8mp_blk_ctrl_domain {
> @@ -457,8 +457,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
>         },
>         [IMX8MP_HDMIBLK_PD_LCDIF] = {
>                 .name = "hdmiblk-lcdif",
> -               .clk_names = (const char *[]){ "axi", "apb" },
> -               .num_clks = 2,
> +               .clk_names = (const char *[]){ "axi", "apb", "fdcc" },
> +               .num_clks = 3,
>                 .gpc_name = "lcdif",
>                 .path_names = (const char *[]){"lcdif-hdmi"},
>                 .num_paths = 1,
> @@ -483,8 +483,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
>         },
>         [IMX8MP_HDMIBLK_PD_HDMI_TX] = {
>                 .name = "hdmiblk-hdmi-tx",
> -               .clk_names = (const char *[]){ "apb", "ref_266m" },
> -               .num_clks = 2,
> +               .clk_names = (const char *[]){ "apb", "ref_266m", "fdcc" },
> +               .num_clks = 3,
>                 .gpc_name = "hdmi-tx",
>         },
>         [IMX8MP_HDMIBLK_PD_HDMI_TX_PHY] = {
> --
> 2.43.0
>

