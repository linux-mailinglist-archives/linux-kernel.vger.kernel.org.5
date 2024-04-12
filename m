Return-Path: <linux-kernel+bounces-143158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6278A3528
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC8A288BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC16D14EC4F;
	Fri, 12 Apr 2024 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jyHtylCh"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466BE14B065;
	Fri, 12 Apr 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944398; cv=none; b=ZtOxyudwpbKkY57whGUtma5Xh5VC4paqMylil8TGjmUYZIeS32XPdClHfJO5g3sKE3eK1EjYqNFJmXWD9c9RcUGiuWPVpktXkiAzUrnBGrOWQ0BfJ3Ocpvk585lBaUjpFrMgo8V7sz/zZMAieVHltLA876mH3/g8nfBVAXQAK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944398; c=relaxed/simple;
	bh=wE5NIEBehWdUwdjrBKHEVKJ5SPkro633TXFCK8Mz+AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvhV0xM3VnaUEmPlTPBhqDXySDoLr1PutN//yKl858uTkc89qlPSFV92/qmMZoVa6nk+5liPXMTesD5rYzecrATZsP8dYvCTFobhcYkY/AdtZL4ZfMCbTpZfIjkLUOZZphVWG96c88yKR055Sbr3smtFWJwDYgjwHZPSaV5yMFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jyHtylCh; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-65-73-nat.elisa-mobile.fi [85.76.65.73])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA6898E1;
	Fri, 12 Apr 2024 19:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712944351;
	bh=wE5NIEBehWdUwdjrBKHEVKJ5SPkro633TXFCK8Mz+AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyHtylChPQVS0vgvDTCUXeA2C1+csbvtQoiAY7e0VGHznNLY6l94Ald4zATI0Qg5T
	 k1Uujzct5IJbia0yLmcFmE4V/tnlBHqiyfEir2iKnIz8FGDUg12Ek3Pv3EvR3EssIG
	 tuAjkJkx5sThkNYZ4KtT3xbKAuNeaJd1W79SZvSg=
Date: Fri, 12 Apr 2024 20:53:05 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] media: subdev: Fix use of sd->enabled_streams in
 call_s_stream()
Message-ID: <20240412175305.GG31122@pendragon.ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-4-e5e7a5da7420@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410-enable-streams-impro-v3-4-e5e7a5da7420@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Wed, Apr 10, 2024 at 03:35:51PM +0300, Tomi Valkeinen wrote:
> call_s_stream() uses sd->enabled_streams to track whether streaming has
> already been enabled. However,
> v4l2_subdev_enable/disable_streams_fallback(), which was the original
> user of this field, already uses it, and
> v4l2_subdev_enable/disable_streams_fallback() will call call_s_stream().
> 
> This leads to a conflict as both functions set the field. Afaics, both
> functions set the field to the same value, so it won't cause a runtime
> bug, but it's still wrong and if we, e.g., change how
> v4l2_subdev_enable/disable_streams_fallback() operates we might easily
> cause bugs.
> 
> Fix this by adding a new field, 'streaming_enabled', for
> call_s_stream().
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 8 ++------
>  include/media/v4l2-subdev.h           | 3 +++
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 606a909cd778..6cd353d83dfc 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -421,12 +421,8 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>  	 * The .s_stream() operation must never be called to start or stop an
>  	 * already started or stopped subdev. Catch offenders but don't return
>  	 * an error yet to avoid regressions.
> -	 *
> -	 * As .s_stream() is mutually exclusive with the .enable_streams() and
> -	 * .disable_streams() operation, we can use the enabled_streams field
> -	 * to store the subdev streaming state.
>  	 */
> -	if (WARN_ON(!!sd->enabled_streams == !!enable))
> +	if (WARN_ON(sd->streaming_enabled == !!enable))
>  		return 0;
>  
>  	ret = sd->ops->video->s_stream(sd, enable);
> @@ -437,7 +433,7 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>  	}
>  
>  	if (!ret) {
> -		sd->enabled_streams = enable ? BIT(0) : 0;
> +		sd->streaming_enabled = enable;
>  
>  		if (enable)
>  			v4l2_subdev_enable_privacy_led(sd);
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index a9e6b8146279..f55d03e0acc1 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -1043,6 +1043,8 @@ struct v4l2_subdev_platform_data {
>   *		     v4l2_subdev_enable_streams() and
>   *		     v4l2_subdev_disable_streams() helper functions for fallback
>   *		     cases.
> + * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.
> + *                     This is only for call_s_stream() internal use.
>   *
>   * Each instance of a subdev driver should create this struct, either
>   * stand-alone or embedded in a larger struct.
> @@ -1091,6 +1093,7 @@ struct v4l2_subdev {
>  	 */
>  	struct v4l2_subdev_state *active_state;
>  	u64 enabled_streams;
> +	bool streaming_enabled;
>  };
>  
>  

-- 
Regards,

Laurent Pinchart

