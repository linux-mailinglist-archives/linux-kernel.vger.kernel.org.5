Return-Path: <linux-kernel+bounces-48267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E884595A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753011C2406A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC85F48F;
	Thu,  1 Feb 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UD9a8fj3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3A5F468;
	Thu,  1 Feb 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795559; cv=none; b=VfkF/UqZ3LwfMZId8gMG/L0ibGL0RqkZPciGpANzlK+UqdTt3pApf6oCyhCe6rUkVrJKP64aABJTCz5PTOzrPvvbUrs3UhZZmlkbfjamBm0EhDKQc0tUN+XiBqh4J4Qlr34PXFdHPYkCkjZzqFR/LCrRaG7uuqY2cwIevrrxpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795559; c=relaxed/simple;
	bh=ebmTHicMZOC5G/O7XY0VPUZ32gErFhOhfjjwyQcH3aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaoiZ5/GGBhM4NmpS6jpRxSOD6UphIBRSxQ9i5LWdRcx270iDKh9Ct1HSQ5+ukcFdAdnpR2pop6SoOIzT857ht5vZ3rIeGPMyNANksA/BbRhYv8ml7teKNMr1/DpujdLy0AxTWiqMppVLiVlEe+457pf+X5eR+v4MFRE8Yvrf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UD9a8fj3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [94.107.229.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 79909613C;
	Thu,  1 Feb 2024 14:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706795474;
	bh=ebmTHicMZOC5G/O7XY0VPUZ32gErFhOhfjjwyQcH3aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UD9a8fj3OvrZ5BeNaUdR2+AZQXSSCY7pfmfYLmE55moZqqNph9JgP8Gmn+b0M2Ngw
	 emvh68QZD96AbHtCoqkYXrFjP94ELxMj/vXZuyHumLBdyPSbJns7bqsME9R3cgPzvq
	 9ZHRS3U/4WrGrwVr+jip+mS55c08kjBzRdFJ5haI=
Date: Thu, 1 Feb 2024 15:52:32 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
	aford173@gmail.com,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 04/11] media: rkisp1: Support devices lacking dual crop
Message-ID: <20240201135232.GB5344@pendragon.ideasonboard.com>
References: <20240111114831.656736-1-paul.elder@ideasonboard.com>
 <20240111114831.656736-5-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240111114831.656736-5-paul.elder@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Thu, Jan 11, 2024 at 08:48:24PM +0900, Paul Elder wrote:
> Some versions of the ISP supported by the rkisp1 driver, such as the ISP
> in the i.MX8MP, lack the dual crop registers and don't support cropping
> at the resizer input. They instead rely on cropping in the Image
> Stabilization module, at the output of the ISP, to modify the resizer
> input size and implement digital zoom.
> 
> Support those ISP versions by addind a dual crop feature flag, and

s/addind/adding/

> mapping the resizer input crop rectangle to either the resizer dual crop
> module or the image stabilization module.

The implementation doesn't match the commit message. You only disable
dual-crop here, you don't handle the image stabilization module. I'm
fine with that, I think adding IS support belongs to a separate patch,
but what this patch is missing is disabling the ability to set a crop
rectangle on the resizer input when dual-crop is not supported.

> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-common.h  | 2 ++
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c     | 6 ++++--
>  drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c | 6 ++++--
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index f7c251f79aa9..219d4a2547aa 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -112,6 +112,7 @@ enum rkisp1_isp_pad {
>   * @RKISP1_FEATURE_MIPI_CSI2: The ISP has an internal MIPI CSI-2 receiver
>   * @RKISP1_FEATURE_MAIN_STRIDE: The ISP supports configurable stride on the main path
>   * @RKISP1_FEATURE_SELF_PATH: The ISP has a self path
> + * @RKISP1_FEATURE_DUAL_CROP: The ISP has the dual crop block at the resizer input
>   *
>   * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
>   * the driver to implement support for features present in some ISP versions
> @@ -121,6 +122,7 @@ enum rkisp1_feature {
>  	RKISP1_FEATURE_MIPI_CSI2 = BIT(0),
>  	RKISP1_FEATURE_MAIN_STRIDE = BIT(1),
>  	RKISP1_FEATURE_SELF_PATH = BIT(2),
> +	RKISP1_FEATURE_DUAL_CROP = BIT(3),
>  };
>  
>  #define rkisp1_has_feature(rkisp1, feature) \
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index f48a21985b18..2e40c376cab5 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -507,7 +507,8 @@ static const struct rkisp1_info px30_isp_info = {
>  	.isr_size = ARRAY_SIZE(px30_isp_isrs),
>  	.isp_ver = RKISP1_V12,
>  	.features = RKISP1_FEATURE_MIPI_CSI2
> -		  | RKISP1_FEATURE_SELF_PATH,
> +		  | RKISP1_FEATURE_SELF_PATH
> +		  | RKISP1_FEATURE_DUAL_CROP,
>  };
>  
>  static const char * const rk3399_isp_clks[] = {
> @@ -527,7 +528,8 @@ static const struct rkisp1_info rk3399_isp_info = {
>  	.isr_size = ARRAY_SIZE(rk3399_isp_isrs),
>  	.isp_ver = RKISP1_V10,
>  	.features = RKISP1_FEATURE_MIPI_CSI2
> -		  | RKISP1_FEATURE_SELF_PATH,
> +		  | RKISP1_FEATURE_SELF_PATH
> +		  | RKISP1_FEATURE_DUAL_CROP,
>  };
>  
>  static const struct of_device_id rkisp1_of_match[] = {
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> index dd77a31e6014..de2eb2c97cc4 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
> @@ -635,7 +635,8 @@ static int rkisp1_rsz_s_stream(struct v4l2_subdev *sd, int enable)
>  	struct v4l2_subdev_state *sd_state;
>  
>  	if (!enable) {
> -		rkisp1_dcrop_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
> +		if (rkisp1_has_feature(rkisp1, DUAL_CROP))
> +			rkisp1_dcrop_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
>  		rkisp1_rsz_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
>  		return 0;
>  	}
> @@ -646,7 +647,8 @@ static int rkisp1_rsz_s_stream(struct v4l2_subdev *sd, int enable)
>  	sd_state = v4l2_subdev_lock_and_get_active_state(sd);
>  
>  	rkisp1_rsz_config(rsz, sd_state, when);
> -	rkisp1_dcrop_config(rsz, sd_state);
> +	if (rkisp1_has_feature(rkisp1, DUAL_CROP))
> +		rkisp1_dcrop_config(rsz, sd_state);
>  
>  	v4l2_subdev_unlock_state(sd_state);
>  

-- 
Regards,

Laurent Pinchart

