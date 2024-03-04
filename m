Return-Path: <linux-kernel+bounces-91075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F687093E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED57C1F2186A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0133D6214E;
	Mon,  4 Mar 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6VbNKzw"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E9262140
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576022; cv=none; b=agZHIpIovu+tlhPz3kohVQtt5kzzmOYoSqqpFndPm5jATniuazE/2FhfsHCiWfehYF+S9h7cvAvq6hMqt6dfzubBXzf5t7Hw0oka1Dy/rTUPF+Y64oqnzr30tLGlPxyXEqD1+2VJPcZChXgEr5EsfoVejH2QxGslVgWus3y+YuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576022; c=relaxed/simple;
	bh=3F/A0H6R/22hcoodKfGiPkYHlGjl2g7ELSfDnPaMILg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doaXG3D5WM3ChD7++ZkGBSdrXSB2W/8MX+ApC/uSypatEjS1nh8dnBjx2Y3mCdosNQt/uKS5sAYGEbwnpEBNHjKfUrLP0/h/aLpsG542uW8l6iVrZN3VMJi21pbpGyHcbqG0vs7nZO8wkHzMfhdn+PvO0QbL8JfdAV3uFkjuaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C6VbNKzw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-608959cfcbfso52655967b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709576019; x=1710180819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EjE93o2p/BNRD6duwy1hrbCPE/L1Bz04gG2eWZQ12G8=;
        b=C6VbNKzwYJbVuZSVY7TLXAIrytGs1eabWh7HV4vXAnAgP/RR3SUqGH0IfSD41TaIv+
         vNx0zQxjNmrbhNVt5rA1Q3369dudOklkb0a9WsyHPsVFffCAf/BZgvJNARlKGIfh822H
         u/zHI2zn+SMFjLwRCT9wo4o7it+Vrmj1BgpjoMa9DUgOed59YSBq4gnB3zqR+CDrXie4
         +D2vGWcElDv0k41V7q1Jn4LfGgui3AklIy2U/Ca4rRcRg5IB4xoxO7HIOMW0qjIKq/Qe
         jQSTep3OZ/gb8Og7zgNP8gMzDkQcrSc6AEMKF/XcuAEtsz1xQDyfI0aIdFX1JlnDcSOD
         tzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709576019; x=1710180819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjE93o2p/BNRD6duwy1hrbCPE/L1Bz04gG2eWZQ12G8=;
        b=dlraO8aloEox/1MbiVgAB/oHjRu31GJsjpsQVhy1AMVvMPQI3pKhFXWW8YsNLx59uL
         10++4N0cWmG8ROQKJjrHXwVlweowYQ+MkR5nuOkV5hyo8Z0c/d+mFrliWC6MR3sEJSHt
         q9NHki0bLjUvx9ogukfhri/U9fvKEIFGmXOZ3FSxOEVJ441XNnz/px8BHuO02JE+XX5A
         cd9xIsmb2k4jH8mJQCfrMySUhwwJDN4NjCgu79Qms2wCalYc6/R4ZUToYpJ0zqmcJ+CT
         EmpCGn9QP+gZ6SkEuY8AbFBOxlwcrC+eK+VNw1X9DyrgOVXvdqfCnaae4t4Wr30iJzQA
         u28Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxp3dmg+5lKrIn/f7WesbYHvOvn+N5lrn1bnRNOloX3QmN1LnyeTL+uZfR97U7HpWoqceoyL5W+Eiqu6ddoGE2b+nn2v3nwoPuFQNB
X-Gm-Message-State: AOJu0YwZ/PhhJaSR/VYMqLAhRg8bkUu7d/+MnB7hqk6dnSEMgLCCjXTJ
	WfwhdeHP8JWvRa0AmVqNGnBnic4/KgtIiVMo/ats4kxNFwihpwEbZgWWJF80473UeVpaJoorYEk
	6g+hq5LWmQL8bbioTAywKTVEamSMXcZkaJTJrkw==
X-Google-Smtp-Source: AGHT+IHEsG0xIbxTLt0nqR9d2jAuFPIONsiU/QGgPiLY+SElLJU2fbWTW9Q10bJjRdOjSCCR3L+cVAZZv/zuB053MDw=
X-Received: by 2002:a0d:d491:0:b0:609:8132:79b3 with SMTP id
 w139-20020a0dd491000000b00609813279b3mr10243342ywd.10.1709576019520; Mon, 04
 Mar 2024 10:13:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304175152.1199270-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240304175152.1199270-1-andriy.shevchenko@linux.intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 4 Mar 2024 20:13:28 +0200
Message-ID: <CAA8EJpqAzWdntbmg-NyQcbLHtUoh-m=g_u=ZWiMimubsWW22sQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drm/msm/hdmi: Replace of_gpio.h by proper one
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 19:51, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/hdmi/hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> index c8ebd75176bb..24abcb7254cc 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -5,8 +5,8 @@
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
>
> +#include <linux/gpio/consumer.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>
> --
> 2.43.0.rc1.1.gbec44491f096
>


-- 
With best wishes
Dmitry

