Return-Path: <linux-kernel+bounces-131478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDBE898863
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570C028F815
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32C8664B;
	Thu,  4 Apr 2024 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VhVeIhLu"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C20B83A07;
	Thu,  4 Apr 2024 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235637; cv=none; b=j2KpyKBtkIHtawNBfW5mIHyR3aO+jmpJr+UUA/+WWexzF4Xq7bRHTzABqrbwtSR1CrdQSW4OARD6Xf2QLxTIW87H5ivT16yM2yFiv+CzwcGX/ZVrlX9oyEzb7Uy7GVxEtxO6VspzeEMbnUQqoTqXpvc+5B7xQ7CkUgjbZ3/s0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235637; c=relaxed/simple;
	bh=FIKEWYk5qVyb6MFcCcB7Ld4kq8WkA50kchpgcd7X3Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpOGPBS2m2CeziGbmySFbOnzv2QdBaviaAvkOV+eOAVKjx+Ql3x7ypcogdttjEjWRIfIDuNJv3IPIGjcG+gfTu7NpU33bT0tLAVpKcZ5FjMF1oRxDLC0x3WQVI+IU+cQX88Ly7U7p+bS6pqf0KWyjOa0ZOIrS8TxCX6NqvOxf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VhVeIhLu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 01B7912D;
	Thu,  4 Apr 2024 14:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712235596;
	bh=FIKEWYk5qVyb6MFcCcB7Ld4kq8WkA50kchpgcd7X3Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VhVeIhLuGxkwFBKk1TVap7G/4Tv849PjsnhKDmv6Gurso8nN9Kx/WtQVPwaf5ScTz
	 Vvs/iH/S5j9q79VPrGj3VgpFrodBkuUUFl5IifajwrhJLOK3T/vwcEQTVXA1Pgo7ld
	 p742aKgK5D3wtENG5RzSR4mGgzUcdb8NYM0Kupfc=
Date: Thu, 4 Apr 2024 16:00:22 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] media: subdev: Fix use of sd->enabled_streams in
 call_s_stream()
Message-ID: <20240404130022.GQ23803@pendragon.ideasonboard.com>
References: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
 <20240404-enable-streams-impro-v1-2-1017a35bbe07@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404-enable-streams-impro-v1-2-1017a35bbe07@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Thu, Apr 04, 2024 at 01:50:01PM +0300, Tomi Valkeinen wrote:
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
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 8 ++------
>  include/media/v4l2-subdev.h           | 2 ++
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index b90b5185e87f..3b3310bce5d4 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -404,12 +404,8 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>  	 * The .s_stream() operation must never be called to start or stop an
>  	 * already started or stopped subdev. Catch offenders but don't return
>  	 * an error yet to avoid regressions.
> -	 *
> -	 * As .s_stream() is mutually exclusive with the .enable_streams() and
> -	 * .disable_streams() operation, we can use the enabled_streams field
> -	 * to store the subdev streaming state.
>  	 */
> -	if (WARN_ON(!!sd->enabled_streams == !!enable))
> +	if (WARN_ON(!!sd->streaming_enabled == !!enable))
>  		return 0;
>  
>  #if IS_REACHABLE(CONFIG_LEDS_CLASS)
> @@ -429,7 +425,7 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>  	}
>  
>  	if (!ret)
> -		sd->enabled_streams = enable ? BIT(0) : 0;
> +		sd->streaming_enabled = !!enable;
>  
>  	return ret;
>  }
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index a9e6b8146279..8bd1e3c96d2b 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -1043,6 +1043,7 @@ struct v4l2_subdev_platform_data {
>   *		     v4l2_subdev_enable_streams() and
>   *		     v4l2_subdev_disable_streams() helper functions for fallback
>   *		     cases.
> + * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.

Could you extend this to indicate this field can't be used by anything
else than call_s_stream() ?

I'm also getting a bit concerned about having multiple fields with
similar purposes. Another option would be to call the .s_stream()
operation directly from the fallback handlers, instead of going through
call_s_stream(). That may be considered as a bit of a hack though.

>   *
>   * Each instance of a subdev driver should create this struct, either
>   * stand-alone or embedded in a larger struct.
> @@ -1091,6 +1092,7 @@ struct v4l2_subdev {
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

