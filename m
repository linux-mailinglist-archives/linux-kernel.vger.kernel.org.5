Return-Path: <linux-kernel+bounces-42967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEAE840964
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB461C22341
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C852153519;
	Mon, 29 Jan 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhpoJEei"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66B1534E7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541099; cv=none; b=AgVqD2Xxl2EE6TsEdRydhGg8xXEwFtnrcwkpqGvUNSXjY9t96Ja3XokDAFSMGsIOHMKIvmwpI/c9LF8pZwRyl/NC9N9yE6CJnUjxIibB2D5SZbmmpkQH8EqOejts0BhuhUBlMZhs98asDgDoMUV4gV7lEvwzVh1x2T8RQ24Cufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541099; c=relaxed/simple;
	bh=9nsjKbF44TZVOpRRhZM1tTFEG6Q2yx+wTpzjkefq/BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTdcGIrKXP2G5HPVP9fkFJAuh1QtBRgg/qCDyDTzj7yBa3oxSeOD0wU/vz6TUYbHf4VhzFBOufG5aohB9+90ma+j1NCeNEshZb/TB52E9mLJ6jZMOoLvoSY5oEubGjLd50LkSw98e2kr2FVQrTeuukrgbdOjKn7wBCJUpHiEiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dhpoJEei; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso3594500276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706541096; x=1707145896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bzxGAI3uTZ4t8Yu0tkeNdDJhjt+ClUZzfi+ZIweVgvk=;
        b=dhpoJEei9DOtTEllCvaH9j38QWx9poPJhpgV3TvC4Zo1D9/0neIzuRd5+f2iLicbIM
         kY/9E03vPdupbEMBcb8mntVTRBiBKjsDn+Uu75nBb0M5COTaY41oz/Ukji+H4KoDLTOd
         XXTV0yk/sJ8g6BLSykSS59rcTYVYdprtvowfEm/tB9rWCObEBATxoCLWv0FvxKRWvsdn
         yu4OPz/ZASPt/Es601yFVsnBR/FWOgeJJIyOrQ5joMzGs6SruNMatFMDs5wQeOlWABu4
         8lKVBTVNDG3X334w+KV3Nnpfw9MS1O8LbMW7gy/rvS2EmwDpXTMltbbEQ4unEXH4Ljqr
         K7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541096; x=1707145896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzxGAI3uTZ4t8Yu0tkeNdDJhjt+ClUZzfi+ZIweVgvk=;
        b=d1ZvnPOw7eZznVi3mOAq6Y+TsjU1CufzbTfYuaI4PwkDOMUvzWKvMjxSnW1vbqXEAt
         eCcczzFfKATsdzsZalR+octVh/4PXBxPMOy35e6VxKlrbr0N6+qkCxzeGdk18LeXHLew
         Q60be8av2OAFJnnoWdxScnv28zSaJyGuajY1BoJoZaGg2BMMcIhLP36VyiW9BN7gBqI5
         yJztJjfY0iw4NuqFMiVODX/PiglOt2cpJOTU2HqDbyTSSwqm2jAXb9odG7iK8K2IwH/y
         w+nGDiIDeOFgn5Csuv7vgzTyb9yQEtpX78+wN+7TIdvmjrQ3/KNM/lTFkm90nEAHBX9N
         FeTQ==
X-Gm-Message-State: AOJu0YwaVQC2/p0yxXiKqnDRH30Ei4lM40rAEEAjrZQrE0nxxb2XyHu6
	oAshMkzSRKQLpPldnHECMx2o2Hj20vf8C06bNpxgSUCvKP4p7S7ozYALSX/bZpeK2NdJPhtpF5C
	gCZ3ktzDdwgezLP91WMViyDfC8j/qhq8g9qN4UQ==
X-Google-Smtp-Source: AGHT+IGTMQ/BAh4UMgioJdLPcXsz/GX4p8hJbTGo1lQCHr2AEV10T3HvflCpK8wmeYx9XsAaaWkgqAghpN7LLUDOvks=
X-Received: by 2002:a05:6902:2808:b0:dbd:ac60:bcd4 with SMTP id
 ed8-20020a056902280800b00dbdac60bcd4mr4890852ybb.75.1706541096178; Mon, 29
 Jan 2024 07:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129-x1e80100-display-v1-0-0d9eb8254df0@linaro.org> <20240129-x1e80100-display-v1-3-0d9eb8254df0@linaro.org>
In-Reply-To: <20240129-x1e80100-display-v1-3-0d9eb8254df0@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Jan 2024 17:11:25 +0200
Message-ID: <CAA8EJponbo2vvuj2ftCQuxtrZp0w7JQqJ_ADF80Wd2y1V74BzA@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/msm: mdss: Add X1E80100 support
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 15:19, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add support for MDSS on X1E80100.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 455b2e3a0cdd..eddf7fdbb60a 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -564,6 +564,15 @@ static const struct msm_mdss_data sdm670_data = {
>         .highest_bank_bit = 1,
>  };
>
> +static const struct msm_mdss_data x1e80100_data = {
> +       .ubwc_enc_version = UBWC_4_0,
> +       .ubwc_dec_version = UBWC_4_3,
> +       .ubwc_swizzle = 6,
> +       .ubwc_static = 1,
> +       .highest_bank_bit = 2,
> +       .macrotile_mode = 1,

Missing .reg_bus_bw, LGTM otherwise

> +};
> +
>  static const struct msm_mdss_data sdm845_data = {
>         .ubwc_enc_version = UBWC_2_0,
>         .ubwc_dec_version = UBWC_2_0,
> @@ -655,6 +664,7 @@ static const struct of_device_id mdss_dt_match[] = {
>         { .compatible = "qcom,sm8450-mdss", .data = &sm8350_data },
>         { .compatible = "qcom,sm8550-mdss", .data = &sm8550_data },
>         { .compatible = "qcom,sm8650-mdss", .data = &sm8550_data},
> +       { .compatible = "qcom,x1e80100-mdss", .data = &x1e80100_data},
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, mdss_dt_match);
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

