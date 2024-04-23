Return-Path: <linux-kernel+bounces-155148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B50E8AE5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535F4285EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A355480038;
	Tue, 23 Apr 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U5g9dHm4"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A496E576
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874726; cv=none; b=AxCtTxz+nBx3qulD6jQhqhBqpDOLAFKlMYEB+nxJSdWvNLg8hBuSYKKmXxK0apGP6YveRRPy+l+8v8UtDGp4fRQQVasWkYFMwD8MHWhDuBOO+a9ZG6OmSbtxJyKkIo8Xp9CICzUryLUC0M3o0cZEvTCL/Zj3NDUOcnCF/9OJN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874726; c=relaxed/simple;
	bh=NabbVF+SCVrT/r9KyGCzPz2WqiIbBsdruSFMeu+luAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZniWQAeFvKGJkFZhClVfO4W9uSQGetsBBX8s273qq4KcN/1AtfnFGB/20lWgPoVFKklZt3z/+1mCqETs4QuIfln30ZwgcTe4GnXS6RtMAwZQccinE1q0grkeYhUFBEBx7h6AOTjU6z6JJKmk4jmk6S3OO8Z9CMJPpCjXTzdJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=U5g9dHm4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 581F7E4;
	Tue, 23 Apr 2024 14:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713874672;
	bh=NabbVF+SCVrT/r9KyGCzPz2WqiIbBsdruSFMeu+luAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U5g9dHm4VC2Vf9sRn6cU8bQywz5RhkmesRw6QVBrYBltci2lWtvtfhG8Pwh8tfoy3
	 dJEeEQQTV/Le2upY5XlGJkRCz13zVdXap+xoqX2ZSHEk+Fl2Cc4Y3eI6P9ZfrnOe7F
	 RUMhwdAueF9taINnrkzJ/gNyBaxkQb1whVqOa9yo=
Message-ID: <c108019b-866f-4e20-a069-5774d6ff032e@ideasonboard.com>
Date: Tue, 23 Apr 2024 15:18:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] drm: zynqmp_dp: Don't delay work
To: Sean Anderson <sean.anderson@linux.dev>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>
References: <20240422184553.3573009-1-sean.anderson@linux.dev>
 <20240422184553.3573009-7-sean.anderson@linux.dev>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240422184553.3573009-7-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/04/2024 21:45, Sean Anderson wrote:
> We always call scheduled_delayed_work with no delay, so just use a
> non-delayed work_struct instead.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> 
> Changes in v3:
> - New
> 
>   drivers/gpu/drm/xlnx/zynqmp_dp.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index f1834c8e3c02..59fed00a8f89 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -297,7 +297,7 @@ struct zynqmp_dp_config {
>   struct zynqmp_dp {
>   	struct drm_dp_aux aux;
>   	struct drm_bridge bridge;
> -	struct delayed_work hpd_work;
> +	struct work_struct hpd_work;
>   
>   	struct drm_bridge *next_bridge;
>   	struct device *dev;
> @@ -1467,7 +1467,7 @@ static void zynqmp_dp_bridge_atomic_disable(struct drm_bridge *bridge,
>   	struct zynqmp_dp *dp = bridge_to_dp(bridge);
>   
>   	dp->enabled = false;
> -	cancel_delayed_work(&dp->hpd_work);
> +	cancel_work(&dp->hpd_work);
>   	zynqmp_dp_write(dp, ZYNQMP_DP_MAIN_STREAM_ENABLE, 0);
>   	drm_dp_dpcd_writeb(&dp->aux, DP_SET_POWER, DP_SET_POWER_D3);
>   	zynqmp_dp_write(dp, ZYNQMP_DP_TX_PHY_POWER_DOWN,
> @@ -1603,8 +1603,7 @@ void zynqmp_dp_disable_vblank(struct zynqmp_dp *dp)
>   
>   static void zynqmp_dp_hpd_work_func(struct work_struct *work)
>   {
> -	struct zynqmp_dp *dp = container_of(work, struct zynqmp_dp,
> -					    hpd_work.work);
> +	struct zynqmp_dp *dp = container_of(work, struct zynqmp_dp, hpd_work);
>   	enum drm_connector_status status;
>   
>   	status = zynqmp_dp_bridge_detect(&dp->bridge);
> @@ -1633,7 +1632,7 @@ static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
>   		zynqmp_dpsub_drm_handle_vblank(dp->dpsub);
>   
>   	if (status & ZYNQMP_DP_INT_HPD_EVENT)
> -		schedule_delayed_work(&dp->hpd_work, 0);
> +		schedule_work(&dp->hpd_work);
>   
>   	if (status & ZYNQMP_DP_INT_HPD_IRQ) {
>   		int ret;
> @@ -1675,7 +1674,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
>   	dp->dpsub = dpsub;
>   	dp->status = connector_status_disconnected;
>   
> -	INIT_DELAYED_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
> +	INIT_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
>   
>   	/* Acquire all resources (IOMEM, IRQ and PHYs). */
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dp");
> @@ -1775,7 +1774,7 @@ void zynqmp_dp_remove(struct zynqmp_dpsub *dpsub)
>   	zynqmp_dp_write(dp, ZYNQMP_DP_INT_DS, ZYNQMP_DP_INT_ALL);
>   	disable_irq(dp->irq);
>   
> -	cancel_delayed_work_sync(&dp->hpd_work);
> +	cancel_work_sync(&dp->hpd_work);
>   
>   	zynqmp_dp_write(dp, ZYNQMP_DP_TRANSMITTER_ENABLE, 0);
>   	zynqmp_dp_write(dp, ZYNQMP_DP_INT_DS, 0xffffffff);


