Return-Path: <linux-kernel+bounces-75796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B01885EF15
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEFE2837EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85754156E4;
	Thu, 22 Feb 2024 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX/SRZ5m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D8125B4;
	Thu, 22 Feb 2024 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708568284; cv=none; b=b5IcGVDD4UqVjc1MrX9LK+bb3tpU4O9/7IcGiUNz6v8pwjeNlM3ZMNngUE3RrfOOZ/l9Qgj3JWGtV2oplRPKUAIveb7GWGGh0KY1xfNvr8s7MGESQnCA1o49azgIPWAwRR7LP9hDCqOWl+ed1FxrJtgnTozNLf7TXlcUS49u1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708568284; c=relaxed/simple;
	bh=ICoVeLCRrWPtB38dc/cDRlSdBAtyS8pTSuWsOxGh700=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdAVuJwjkmIl0b+UD8KxyviscDjNbATP0SjoSVy73r3rctRII4v6q2yTGpVW9pW/evU2a9O08MjzXnwl7B2lZeCR73uQAF6qwTd56PrvCGQqzWiCkVlL46pLmobqxt5TrD9dWoZPZIGFqLo9s1eEjHHukv0LEDd6gf0T7kNPswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX/SRZ5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F90C433F1;
	Thu, 22 Feb 2024 02:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708568284;
	bh=ICoVeLCRrWPtB38dc/cDRlSdBAtyS8pTSuWsOxGh700=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qX/SRZ5mwTln4kpwSxVzd5cPB+bUGAKJqxhO83U0vFgjbBKcSNgOX5WPCqdpSNaSx
	 YUB0Yu0dKLUbNkTBttzx0KkMaHlUpnG3d7VEIOyRo4dAlR1QnDnx5dazuLCRF+Mcw+
	 +CNXpQk8sVuyLGcz9GkkRh8yN3rWuAO/cJTmU7PI0OAg3l6P7iLpn/tsTNo+Z0M5H3
	 mDxP/Fr60aa21K0MwRnIdrUyW/wa1Cxem+nqrpchfZ6l5ojfnLCa0gXONfbQchD07g
	 oyeQdxZejyjzX7TSoNwvdql1FN/kKXp3EE6RwXZ4FhOeRvFeXCvYVFicmMBqp2GATY
	 ZUPosQ0UhRV3g==
Date: Wed, 21 Feb 2024 20:18:00 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	Rob Clark <robdclark@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH 4/6] soc: qcom: pmic_glink: Fix boot when QRTR=m
Message-ID: <zakgvxtn53vos36f64wujtkvy5f2na73flojifg5gzs7va65n2@fj6bjleqng7h>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <20240217150228.5788-5-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217150228.5788-5-johan+linaro@kernel.org>

On Sat, Feb 17, 2024 at 04:02:26PM +0100, Johan Hovold wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> We need to bail out before adding/removing devices if we are going to
> -EPROBE_DEFER. Otherwise boot can get stuck in a probe deferral loop due
> to a long-standing issue in driver core (see fbc35b45f9f6 ("Add
> documentation on meaning of -EPROBE_DEFER")).
> 
> Deregistering the altmode child device can potentially also trigger bugs
> in the DRM bridge implementation, which does not expect bridges to go
> away.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Link: https://lore.kernel.org/r/20231213210644.8702-1-robdclark@gmail.com
> [ johan: rebase on 6.8-rc4, amend commit message and mention DRM ]
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/pmic_glink.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index f4bfd24386f1..f913e9bd57ed 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -265,10 +265,17 @@ static int pmic_glink_probe(struct platform_device *pdev)
>  
>  	pg->client_mask = *match_data;
>  
> +	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
> +	if (IS_ERR(pg->pdr)) {
> +		ret = dev_err_probe(&pdev->dev, PTR_ERR(pg->pdr),
> +				    "failed to initialize pdr\n");
> +		return ret;
> +	}
> +
>  	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
>  		ret = pmic_glink_add_aux_device(pg, &pg->ucsi_aux, "ucsi");
>  		if (ret)
> -			return ret;
> +			goto out_release_pdr_handle;
>  	}
>  	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
>  		ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
> @@ -281,17 +288,11 @@ static int pmic_glink_probe(struct platform_device *pdev)
>  			goto out_release_altmode_aux;
>  	}
>  
> -	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
> -	if (IS_ERR(pg->pdr)) {
> -		ret = dev_err_probe(&pdev->dev, PTR_ERR(pg->pdr), "failed to initialize pdr\n");
> -		goto out_release_aux_devices;
> -	}
> -
>  	service = pdr_add_lookup(pg->pdr, "tms/servreg", "msm/adsp/charger_pd");
>  	if (IS_ERR(service)) {
>  		ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
>  				    "failed adding pdr lookup for charger_pd\n");
> -		goto out_release_pdr_handle;
> +		goto out_release_aux_devices;
>  	}
>  
>  	mutex_lock(&__pmic_glink_lock);
> @@ -300,8 +301,6 @@ static int pmic_glink_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -out_release_pdr_handle:
> -	pdr_handle_release(pg->pdr);
>  out_release_aux_devices:
>  	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
>  		pmic_glink_del_aux_device(pg, &pg->ps_aux);
> @@ -311,6 +310,8 @@ static int pmic_glink_probe(struct platform_device *pdev)
>  out_release_ucsi_aux:
>  	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
>  		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
> +out_release_pdr_handle:
> +	pdr_handle_release(pg->pdr);
>  
>  	return ret;
>  }
> -- 
> 2.43.0
> 

