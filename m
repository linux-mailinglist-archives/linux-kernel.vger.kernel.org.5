Return-Path: <linux-kernel+bounces-143143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995ED8A34F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C1E284AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCD214F112;
	Fri, 12 Apr 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ETehQO6c"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB7614EC59;
	Fri, 12 Apr 2024 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943524; cv=none; b=Mkh9/ITMT91PWvTJhe1rJHMBzYhgzeL1suwEECDwK1iN9aN6v8Psgeq6qbbq5RVKLnQ29VCGbT7+BUgOFFdJtq0RGQ8EM86CFY/tWeKm3o8n4g4qN9tc+kDeig8Ri8rdr6zrTx79aSc6dMeBKhhIF0+LU+3GMzz3pOhcXGik3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943524; c=relaxed/simple;
	bh=QL/k9KysqpWiF5jdUnnA3DWcn48s72GXDQkPQ9+tk8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAoRnmJOxUlE5dsbPP4dcFRVxpsNF2SI2yNmJ1qDns1vu/mfOFTCmnNQsh6el9/rg+Huuob2aW+NJTVOfemwAbB+uTj1Y57P15xf3Eoh4+UQHEY0BBuwsVX8jft+cFOgjuUvhImI/4F+RzdjwigL5ftnme2u+p1QbUXBaupr3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ETehQO6c; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-65-73-nat.elisa-mobile.fi [85.76.65.73])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E64058E1;
	Fri, 12 Apr 2024 19:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712943477;
	bh=QL/k9KysqpWiF5jdUnnA3DWcn48s72GXDQkPQ9+tk8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETehQO6cary4myGgwMZM6kxgEDVKd5J3TRlkofdUupAVgrAtGuZZo8MIjt5DIHwII
	 uHk1fwr8VrkZWMFBLkF1S0yvN8hYSjKPiCLDxfg6mQxAvWbzaayiMs4UI8s6tKcttU
	 /nbbSe6qBlGik9mrIosjgJXZnkwo6PhvUm3TIDrE=
Date: Fri, 12 Apr 2024 20:38:30 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] media: subdev: Use v4l2_subdev_has_op() in
 v4l2_subdev_enable/disable_streams()
Message-ID: <20240412173830.GE31122@pendragon.ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-2-e5e7a5da7420@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410-enable-streams-impro-v3-2-e5e7a5da7420@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Wed, Apr 10, 2024 at 03:35:49PM +0300, Tomi Valkeinen wrote:
> Use v4l2_subdev_has_op() in v4l2_subdev_enable/disable_streams().

Commit messages should explain the reaon for a change. With that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 13957543d153..4a531c2b16c4 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2133,7 +2133,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  		return 0;
>  
>  	/* Fallback on .s_stream() if .enable_streams() isn't available. */
> -	if (!sd->ops->pad || !sd->ops->pad->enable_streams)
> +	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
>  		return v4l2_subdev_enable_streams_fallback(sd, pad,
>  							   streams_mask);
>  
> @@ -2250,7 +2250,7 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  		return 0;
>  
>  	/* Fallback on .s_stream() if .disable_streams() isn't available. */
> -	if (!sd->ops->pad || !sd->ops->pad->disable_streams)
> +	if (!v4l2_subdev_has_op(sd, pad, disable_streams))
>  		return v4l2_subdev_disable_streams_fallback(sd, pad,
>  							    streams_mask);
>  
> 

-- 
Regards,

Laurent Pinchart

