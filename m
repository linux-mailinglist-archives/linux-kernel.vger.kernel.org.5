Return-Path: <linux-kernel+bounces-151699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED4B8AB23F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837FD1C220B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F112FF8C;
	Fri, 19 Apr 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ig6lesCY"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7677F13;
	Fri, 19 Apr 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541608; cv=none; b=KO1oGOiv9z5VFu9ZY8PZUwm+0Zlc8lxU/AMeV0WBfx/V22I734otMPLHImdpyPEJCnLIvu7TObUnqGh729JJVf6yT3b+a5o7w5ISbV4glEldSiiFho7iS/AMdgLZJEM8P9UzEQ/1w6loaeNQ7QAMvBc2P1Y4ga8RI9I50ukVRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541608; c=relaxed/simple;
	bh=A0BUFxeytXQMep6U2UOlSHmp6ld8ezo+U3K4EkVGWTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moVXZO10tMc8kPsoQVqjiaC3XBL9f+yy+Lmj0UPE7wVmDpyI8SDPkucyKBPDvTgt25K8ZPrA/BCGMySktK2XH2oK0WwOJ5kC7RbmnBj+hbcpNpeHzAwIp268y9Nq8S0XyQYK6yBHw0mDRSgBrXiCL+WS6KJAtvJiY6AKqPidIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ig6lesCY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D5E7C63B;
	Fri, 19 Apr 2024 17:45:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713541556;
	bh=A0BUFxeytXQMep6U2UOlSHmp6ld8ezo+U3K4EkVGWTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ig6lesCY9/vs+3Ry9WxjvU/pKIvUBuR/pGEn4o9A/6DnsMnrdb1N5EYIO2I6LdbK8
	 E8nD0AAfdhyxFCHTXJ9yK1/gqaiX4L9oVhOgmAjLeiQiY2kPAtmWvKu1V1qBjFXzk5
	 1278BuoxSRGa7Vdvq1mrDHo/GwVDDqcptUybBw+Q=
Date: Fri, 19 Apr 2024 18:46:37 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/10] media: subdev: Support non-routing subdevs in
 v4l2_subdev_s_stream_helper()
Message-ID: <20240419154637.GC6414@pendragon.ideasonboard.com>
References: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
 <20240416-enable-streams-impro-v5-10-bd5fcea49388@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240416-enable-streams-impro-v5-10-bd5fcea49388@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Tue, Apr 16, 2024 at 04:55:13PM +0300, Tomi Valkeinen wrote:
> At the moment v4l2_subdev_s_stream_helper() only works for subdevices
> that support routing. As enable/disable_streams now also works for
> subdevices without routing, improve v4l2_subdev_s_stream_helper() to do
> the same.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 10406acfb9d0..64f52376ca7b 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2360,15 +2360,24 @@ int v4l2_subdev_s_stream_helper(struct v4l2_subdev *sd, int enable)
>  	if (WARN_ON(pad_index == -1))
>  		return -EINVAL;
>  
> -	/*
> -	 * As there's a single source pad, just collect all the source streams.
> -	 */
> -	state = v4l2_subdev_lock_and_get_active_state(sd);
> +	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
> +		/*
> +		 * As there's a single source pad, just collect all the source
> +		 * streams.
> +		 */
> +		state = v4l2_subdev_lock_and_get_active_state(sd);
>  
> -	for_each_active_route(&state->routing, route)
> -		source_mask |= BIT_ULL(route->source_stream);
> +		for_each_active_route(&state->routing, route)
> +			source_mask |= BIT_ULL(route->source_stream);
>  
> -	v4l2_subdev_unlock_state(state);
> +		v4l2_subdev_unlock_state(state);
> +	} else {
> +		/*
> +		 * For non-streams subdevices, there's a single implicit stream
> +		 * per pad.
> +		 */
> +		source_mask = BIT_ULL(0);
> +	}
>  
>  	if (enable)
>  		return v4l2_subdev_enable_streams(sd, pad_index, source_mask);

-- 
Regards,

Laurent Pinchart

