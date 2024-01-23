Return-Path: <linux-kernel+bounces-34582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDB58381B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E95D28905F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB9C679EC;
	Tue, 23 Jan 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nElGEYIT"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9778679E5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972826; cv=none; b=HYLK9ZPwUm54s1ShNwAdHYvKYa9BBV7s65+HOGHexK55EYLmm4xrl6H2sq22wCSKcLKXflcIWBnZ5faFG3hePwey25sodBVPSnAUW5BqrN7pgNFYrcEhqUUfGL1D/Vx97Haj35lGKewdx5DZawI1sZbD3N80iUnxuqKQWYNFUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972826; c=relaxed/simple;
	bh=Xa8ntlXCZZ2MZ8nDZWEk0iLWlpDlzYMH/xMfar8ssuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8atdlXXwQtlsoAnyheWhVzcYgfRDqMf7SASt9HYE4nBLTCzovncBIrb3LakXYieD1CWi4zMAhN73EUINCeMZguFFEYweHoG/jpOvOLXoWW+pCsQHSOqABZp1Q/j+QFKWHu907jBVEFLBoAOmnqGgDyo0TZ9Iuxdrh5yGQzSI6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nElGEYIT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A104BE4;
	Tue, 23 Jan 2024 02:19:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705972749;
	bh=Xa8ntlXCZZ2MZ8nDZWEk0iLWlpDlzYMH/xMfar8ssuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nElGEYIT2vat6NGNNA3fzYqaKcaZa3WXJzG+l418uuQdMIpR4a4C6r34gW6iVUfyj
	 kO6CJl7yxac9WH5+5ZvRZXroYTFIwUWmckmog1oj3Gv1D+UUF1nvCAt6l0MowjFYL5
	 gLAmDywztT8hWN+AGi5TeHubphtPas1mMhzlDynU=
Date: Tue, 23 Jan 2024 03:20:26 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: David Airlie <airlied@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [PATCH 5/5] drm-bridge: display-connector: Switch to use fwnode
 API
Message-ID: <20240123012026.GC22880@pendragon.ideasonboard.com>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-6-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122163220.110788-6-sui.jingfeng@linux.dev>

On Tue, Jan 23, 2024 at 12:32:20AM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> Because API has wider coverage, it can be used on non-DT systems as well.
> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/bridge/display-connector.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index eb7e194e7735..2c3e54a458e8 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -243,8 +243,8 @@ static int display_connector_probe(struct platform_device *pdev)
>  	case DRM_MODE_CONNECTOR_DVII: {
>  		bool analog, digital;
>  
> -		analog = of_property_read_bool(pdev->dev.of_node, "analog");
> -		digital = of_property_read_bool(pdev->dev.of_node, "digital");
> +		analog = fwnode_property_present(pdev->dev.fwnode, "analog");
> +		digital = fwnode_property_present(pdev->dev.fwnode, "digital");
>  		if (analog && !digital) {
>  			conn->bridge.type = DRM_MODE_CONNECTOR_DVIA;
>  		} else if (!analog && digital) {
> @@ -261,8 +261,8 @@ static int display_connector_probe(struct platform_device *pdev)
>  	case DRM_MODE_CONNECTOR_HDMIA: {
>  		const char *hdmi_type;
>  
> -		ret = of_property_read_string(pdev->dev.of_node, "type",
> -					      &hdmi_type);
> +		ret = fwnode_property_read_string(pdev->dev.fwnode, "type",
> +						  &hdmi_type);
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "HDMI connector with no type\n");
>  			return -EINVAL;
> @@ -292,7 +292,7 @@ static int display_connector_probe(struct platform_device *pdev)
>  	conn->bridge.interlace_allowed = true;
>  
>  	/* Get the optional connector label. */
> -	of_property_read_string(pdev->dev.of_node, "label", &label);
> +	fwnode_property_read_string(pdev->dev.fwnode, "label", &label);
>  
>  	/*
>  	 * Get the HPD GPIO for DVI, HDMI and DP connectors. If the GPIO can provide
> @@ -330,12 +330,13 @@ static int display_connector_probe(struct platform_device *pdev)
>  	if (type == DRM_MODE_CONNECTOR_DVII ||
>  	    type == DRM_MODE_CONNECTOR_HDMIA ||
>  	    type == DRM_MODE_CONNECTOR_VGA) {
> -		struct device_node *phandle;
> +		struct fwnode_handle *fwnode;
>  
> -		phandle = of_parse_phandle(pdev->dev.of_node, "ddc-i2c-bus", 0);
> -		if (phandle) {
> -			conn->bridge.ddc = of_get_i2c_adapter_by_node(phandle);
> -			of_node_put(phandle);
> +		fwnode = fwnode_find_reference(pdev->dev.fwnode, "ddc-i2c-bus", 0);
> +		if (!IS_ERR_OR_NULL(fwnode)) {
> +			dev_info(&pdev->dev, "has I2C bus property\n");

This looks like a debugging leftover.

> +			conn->bridge.ddc = i2c_get_adapter_by_fwnode(fwnode);
> +			fwnode_handle_put(fwnode);
>  			if (!conn->bridge.ddc)
>  				return -EPROBE_DEFER;
>  		} else {
> @@ -380,6 +381,7 @@ static int display_connector_probe(struct platform_device *pdev)
>  
>  	conn->bridge.funcs = &display_connector_bridge_funcs;
>  	conn->bridge.of_node = pdev->dev.of_node;
> +	conn->bridge.fwnode = pdev->dev.fwnode;

This goes in the right direction. Let's address the other drivers and
drop the OF-based calls in the same series :-)

>  
>  	if (conn->bridge.ddc)
>  		conn->bridge.ops |= DRM_BRIDGE_OP_EDID

-- 
Regards,

Laurent Pinchart

