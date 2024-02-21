Return-Path: <linux-kernel+bounces-75668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D385ED28
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D701C22C59
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0C812BE92;
	Wed, 21 Feb 2024 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHWBp9rd"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6718EC5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558740; cv=none; b=UPNDG5jlpVgaYtK5jzsigNJF29xTlU7Pma3wDGlky9WGsZjSQfZcERMQbox4QUQ0WegCnTXrBtORdcQ9pEmWoqeuHYPCms6CGmLDKxXAormYK0eBuKGjW5jQJeujty+U9ZppFmdaIGw1s/hbr9b0175gcXvPX8LCQBnBtmgSiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558740; c=relaxed/simple;
	bh=zwQaUfTd5VGQ23NzTxo29zCF6MbG+EiG7CQ+klarN7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E31ixNumPn3jFk9BqYCXrzuLeyDGO8BjMJxQe3lC5el2HSyayhnltLQEawDIWjZX2X5Ss+/5Y2IvkIgWQO2ywdPqPZVTAJHTdoYNfa0Zk5s5WZ4eKDwAQF87ZPkeasSCj6R4aGtoQ8xGo3bkA96NkmofrYiluRUizwz3eCPyXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GHWBp9rd; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60495209415so71080097b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708558737; x=1709163537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/dnZ6qXwhjaIXNXWlJKsv9Hd+U+Uq/9NkmI5u+eHav8=;
        b=GHWBp9rdKNBLa9ItaUOjcsoQABVCL8u0XsemikGmqzKl1ZJtcac4+4OQs4HTZHNrie
         /FHnkZVV5Z8y9Eee6s16au2tUW4qaaPY7z51g64PU95wU9fjM8g7dGsxcWDqZF03QjLb
         ohLCtAMzwvPquEC+C2UyEqvcdUGdO2blu+SeJ6WcyBiW0LuWLtLRwSE1Pn0OvaR0oqvx
         YBLWcTXYMG9fWR3undOueHHMq+A9sjorLqCWPGtYz8Jc2NEdXO2hPy+C/WWPGofk8Lah
         Zss431F6P0VP1RE6H7WerMLZmmQyOdr8ABPEBiGTeOeLilD6KW+kvO9ZuPL6F+oeMwoo
         wU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558737; x=1709163537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dnZ6qXwhjaIXNXWlJKsv9Hd+U+Uq/9NkmI5u+eHav8=;
        b=DQGSfpnQFvTfu4e6Wk2j8fFVVbKs6FwctKVLF3Wup7gJRG3Kn4pJQaRhy6aoSemy3v
         q+hIG+78Hzmm2KVae+MebZqyGUeCpu0fOJuHs3HZDc3oE5lm0DsMPQQ+qVrsaJGyGUCb
         LhqQsA39ixSAfgYdUzyBW21XzChrEGFwyx1kkOfmWdRxgEnTWQn2YgOfRy/6o0fKjuhc
         VVIm4N16x47/1Oj3RrRb1uSwfhuxv8w0u8E/n6ru8GLlYI2xMPE3/sXkjKa85xrkWvUL
         y81OsknmNfFLAB8X2+wiaq5PCAz2wDJDqdoRj6hOh/5o/7fHpxMQBQQ4WO3MY+x57Y/m
         u77w==
X-Forwarded-Encrypted: i=1; AJvYcCXcaY2RuEEo1N0LQBj7lzBv2WWDW9tNQN0zN1uwn/7G4BnqDn9pOHEIj+hRp1OJsRkr4NMDDyjk6cN09uxxW4Qaj7gKE+OAvzGuV9Kp
X-Gm-Message-State: AOJu0Yx7d/UDsZBlAtWfJtrepdBxtmmEb2xRZZqU2HCLf0BCM+2GSZMJ
	3uxlk5DjbgmPyCbTtsrTRBg0Xl6/WchlqXWPbjlQk2T0hZEQb1RNbZ8WUIm4mrsZJ20DuDgqKaQ
	hF9T0JHQ8roahiwPhuFUy720+gi4jJC01xnUulw==
X-Google-Smtp-Source: AGHT+IE0tGrX7UsWdp8xy5caWpOZ9THC0fnnletXSK4P9Z3hp437QPqk/DB8NiySph7r7h/gOnZ8DNQ5BKCpKPKAobA=
X-Received: by 2002:a81:7184:0:b0:604:230a:a823 with SMTP id
 m126-20020a817184000000b00604230aa823mr19674257ywc.50.1708558736962; Wed, 21
 Feb 2024 15:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com> <20240221-rb3gen2-dp-connector-v1-1-dc0964ef7d96@quicinc.com>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-1-dc0964ef7d96@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 01:38:45 +0200
Message-ID: <CAA8EJprXXjvanBU_HGv7X_dS3nyZ867AsvKj5+S3pnWcpsk1ug@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/msm/dp: Add DP support to combo instance in SC7280
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> When upstreamed the SC7280 DP controllers where described as one being
> DP and one eDP, but they can infact both be DP or eDP.
>
> Extend the list of DP controllers to cover both instances, and rely on
> the newly introduced mechanism for selecting which mode they should
> operate in.
>
> Move qcom,sc7280-edp to a dedicated list, to ensure existing DeviceTree
> will continue to select eDP.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 7b8c695d521a..1792ba9f7259 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -129,7 +129,12 @@ static const struct msm_dp_desc sc7180_dp_descs[] = {
>  };
>
>  static const struct msm_dp_desc sc7280_dp_descs[] = {
> -       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
> +       { .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_en = true },
> +       { .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .wide_bus_en = true },

I think we need to keep .connector_type here, don't we?

> +       {}
> +};
> +
> +static const struct msm_dp_desc sc7280_edp_descs[] = {
>         { .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
>         {}
>  };
> @@ -182,7 +187,7 @@ static const struct msm_dp_desc x1e80100_dp_descs[] = {
>  static const struct of_device_id dp_dt_match[] = {
>         { .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
>         { .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
> -       { .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_descs },
> +       { .compatible = "qcom,sc7280-edp", .data = &sc7280_edp_descs },
>         { .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_descs },
>         { .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_descs },
>         { .compatible = "qcom,sc8280xp-dp", .data = &sc8280xp_dp_descs },
>
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

