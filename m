Return-Path: <linux-kernel+bounces-75798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E51B85EF21
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF931C22146
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9914F75;
	Thu, 22 Feb 2024 02:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2q7x03B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75D10A19;
	Thu, 22 Feb 2024 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708568588; cv=none; b=SmOi0kYQoKhmoGiKMnkDCJYr0GVkTsgxAV7obMzYPTINtvACVuUgavb5KWU+ZQVdkG1dV1ZNezmvBXxsa9qabqhrHYabM9XqwtBpONaepCu1/CUSg43cfM36Wd3MUGUFJzW9/EKgx5f2E7JBsPIvFiNdoB3FDTyp4d9NdEdh6xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708568588; c=relaxed/simple;
	bh=MMlkjmsJsicEDs7i5WxUmhs8W/iz3PM4L1aTQKsYqS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BD8JOhBuy4E64zudO4vrbBjwzyU9ouoX0aFuyqDlVouMUZis/TZemX/7772ol4gmwvU/VX9ydzGvYqA8dY4OM/2nsLslmkwSGXVMiyeYvuzFUaNgON+6QcUXPrZzAh10tyzHs3myoIOfXzZB3PggkqpjHNuoeDA5cn4IzxJVdzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2q7x03B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C481DC433C7;
	Thu, 22 Feb 2024 02:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708568587;
	bh=MMlkjmsJsicEDs7i5WxUmhs8W/iz3PM4L1aTQKsYqS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2q7x03BsCLrEV+dAiEnodN6qvtQf8spHVxVTLO7VN2AznIQ7r0uW+vkoD+o0npAA
	 vve9abeOEDefbhv27dw+nVSB+Gz2M2c1QAy78CDkf6gRh+YpnvxYTb61AKFYdSwYhy
	 dgzQPjHMwmBREv8OE/+dcm0+nFwcKqxjH5w1W33PcH8pwcGJEJf3JeCBweF09scS+L
	 yGa57tso+nIIgKFb7AyKPZFM/z6hICesMczCh6qFE8QjMwEA6WX+ATklittaMdmyem
	 D3bHL21fCNo/e4779NOodc6DctIUc9pjMXmBLuDhjQTC62dkPV0nnk12nu2yHntbg4
	 SspNPWE022PBQ==
Date: Wed, 21 Feb 2024 20:23:03 -0600
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
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, stable@vger.kernel.org, 
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 6/6] phy: qcom-qmp-combo: fix type-c switch registration
Message-ID: <7emxapsbkv5evnuhpr4uanr5fhnqaxy6thow4y3zlfwvnzbpdk@ioyynlfubfsr>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <20240217150228.5788-7-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217150228.5788-7-johan+linaro@kernel.org>

On Sat, Feb 17, 2024 at 04:02:28PM +0100, Johan Hovold wrote:
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

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index e19d6a084f10..17c4ad7553a5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -3562,10 +3562,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = qmp_combo_typec_switch_register(qmp);
> -	if (ret)
> -		return ret;
> -
>  	/* Check for legacy binding with child nodes. */
>  	usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
>  	if (usb_np) {
> @@ -3585,6 +3581,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_node_put;
>  
> +	ret = qmp_combo_typec_switch_register(qmp);
> +	if (ret)
> +		goto err_node_put;
> +
>  	ret = drm_aux_bridge_register(dev);
>  	if (ret)
>  		goto err_node_put;
> -- 
> 2.43.0
> 

