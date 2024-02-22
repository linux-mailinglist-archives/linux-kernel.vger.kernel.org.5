Return-Path: <linux-kernel+bounces-77373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A5D860484
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2971F22FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED6273F0C;
	Thu, 22 Feb 2024 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMxFcXbY"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A966E5E3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636353; cv=none; b=JG/TO8xfQh2brcmafO/Pq8X2t3V1YknKaep0VpuStVJ+5W/Ygb8dvdph0XSM+4VkbXRgwpS+IUU9m8BnTRaR0NrF1ijAtX6Hz25k7rb1ym7H7Bn4v2rB2q00/R6t7yRqikg+qCOD9XNKupSeYC76m6LTKSw4JDcNkYJhLke5K+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636353; c=relaxed/simple;
	bh=lTdUa42NwYjJJpKBleL4FHR9ezbFYLTvE/pbZhVextI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHXFqTSHbbsgUVX2RegmWCXO4kWiummsTEtgFAP8nqpLLSk8h82M6lqLYRGlCrchIUpfwy4TNVUdEdgcpWmo1naivybBufNb8b54+JKXJUni1iScH9s95+XbhpOZVl6DnJPHIapWdyui4uN3LPT2lDGS3LV1X0EqvY3mcsMa+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMxFcXbY; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso167400276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708636350; x=1709241150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fenjTlVOLcRdKZFsqaTFAV94+jNqh66pMdN4WeCK6m8=;
        b=qMxFcXbYiHN5obuw2sfrNhLiCCc6Vl50BSuLwGxNyd2AjOMoUGOeTGvwSXTOvXwfsV
         10X16X9OWDGu1hEsDmGo1pvLN6Ah7X7yyoM/r9LmbsetnpdbYHoKQrsBE8MRVWXZ3Skc
         Dh0yd6MhHe7wnoc3LhHb/J+GbVTOOaDsn57C+SVc4zD2eX3HrssMyAYnrKt+Zs2tDyRp
         9Z4RlDVUiIRrvsUyLrdXyDW+8d4lpzOEuDettsmn6Mc95ud1/LFoZoS+lYsBQQTgQYeG
         u5qc8Y/cdO6Ps/2ewDvx5KjByPnD/EpcaUEMcHCm4X727xDSjSJY/mCQgaZ725UHBhjX
         /pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636350; x=1709241150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fenjTlVOLcRdKZFsqaTFAV94+jNqh66pMdN4WeCK6m8=;
        b=GpRTKdjLnUqI3dakN9br4ojY/Osnpu8T/ZG/VLppQaO6wTb0ZX+qXkNLFEw3XejHWz
         YI37DKmmQeHXiQeO4DEMqgdoj909sZIum7R75tj8/h2qHpdR7ZdJAyiZOQwio7u2yLRL
         bUM6wifTlqdMTZDD0S/bWxQL8AZZSAhgwTUwsKBlB6Q61SSRTNMKuwxU8lW/GCEV8Vlg
         fpiAwoxgW1SJo1kByC+gReuHoyntckrR57QwTw8CXSkS/syMPQKHEtNYqds0UzXh4V9R
         DwVDwh1Yf/yJxrB6f5eVYeQdpHGVtuS2to8Q28WvkVmVkfq8Frpp4mbeciIGkIHOg3Sw
         IBQg==
X-Forwarded-Encrypted: i=1; AJvYcCVy/o0X9d+5qQzeAtPKvAmj5ID78mmYSb9CjzyiMNo2WfiEWgwKTOtxXsAvo/m4F1mx0gWrDwJsqYJxeejgqvQepzgwQpvjxDs+IDO5
X-Gm-Message-State: AOJu0YxOFqwMuUszmo0ShUpyFJamUqamuoT7MzfEF9TfaTxeFbQ7UcwE
	VMDE/T4m6a7lzIX4n6ul7J5FUfKawAa0kh8RYJEV3RZO46KYbhzl2CzTIyF2MvBa4xFFIcK8rRU
	CcWNLs6hbJLwo4rdxCqBryRx3DnwhjWAKqFeaBA==
X-Google-Smtp-Source: AGHT+IFh2TAl89Hutu4vqCYOc5+0AJ9qQayg9ScjNq2n3H/zD5V2O2sGDJBBs2zipfHmjaQpRtAUdHsgH00u4T387Jo=
X-Received: by 2002:a25:2747:0:b0:dcd:3338:a3c5 with SMTP id
 n68-20020a252747000000b00dcd3338a3c5mr382880ybn.33.1708636349969; Thu, 22 Feb
 2024 13:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217150228.5788-1-johan+linaro@kernel.org> <20240217150228.5788-7-johan+linaro@kernel.org>
In-Reply-To: <20240217150228.5788-7-johan+linaro@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 23:12:18 +0200
Message-ID: <CAA8EJppPg7b-DsPJ4W=2G-_rRq+xTux9kJ3oJhD2ws+FoJvkKQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] phy: qcom-qmp-combo: fix type-c switch registration
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, stable@vger.kernel.org, 
	Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 17:03, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Due to a long-standing issue in driver core, drivers may not probe defer
> after having registered child devices to avoid triggering a probe
> deferral loop (see fbc35b45f9f6 ("Add documentation on meaning of
> -EPROBE_DEFER")).
>
> Move registration of the typec switch to after looking up clocks and
> other resources.
>
> Note that PHY creation can in theory also trigger a probe deferral when
> a 'phy' supply is used. This does not seem to affect the QMP PHY driver
> but the PHY subsystem should be reworked to address this (i.e. by
> separating initialisation and registration of the PHY).
>
> Fixes: 2851117f8f42 ("phy: qcom-qmp-combo: Introduce orientation switching")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Note to myself (or to anybody else, who has spare hands), we should
probably implement the same changes for phy-qcom-qmp-usbc.c

>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index e19d6a084f10..17c4ad7553a5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -3562,10 +3562,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       ret = qmp_combo_typec_switch_register(qmp);
> -       if (ret)
> -               return ret;
> -
>         /* Check for legacy binding with child nodes. */
>         usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
>         if (usb_np) {
> @@ -3585,6 +3581,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_node_put;
>
> +       ret = qmp_combo_typec_switch_register(qmp);
> +       if (ret)
> +               goto err_node_put;
> +
>         ret = drm_aux_bridge_register(dev);
>         if (ret)
>                 goto err_node_put;
> --
> 2.43.0
>


-- 
With best wishes
Dmitry

