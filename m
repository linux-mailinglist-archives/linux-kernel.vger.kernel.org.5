Return-Path: <linux-kernel+bounces-84876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB8286ACF1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2482D1F282F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B649312FB06;
	Wed, 28 Feb 2024 11:25:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463512A149;
	Wed, 28 Feb 2024 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119549; cv=none; b=fZV4rcx7V1oH2skxa5e6Y9h0nY712pNHXOIHsRPZZSSaYsdcKQBsumzS4fWg/ZW7zEay3+V3FoqYBYcNdEriVF4pH8I9RDfcLFN6Hxcbhv08ucAljhcH3LOX7pJ/wo/UJ8ctXxx68aoI38UyP47n7sRm6ywfrXt3YcuHTao5LM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119549; c=relaxed/simple;
	bh=ohmwuBlhDPHH8tIibEhU/oAcbkZug7YwDw0TwsvqP6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJopxshdDUA0JaWEho6PMGnPHrFlUgMgE58Re8HdxX0iY/Z9pUBqtVZ++AcG3uulGuS8pUlEq+z78bp++znkciyZetJ2YZQSbJzp810RXdcO1TGJQZTOssQGhRG2yOKmOSQ8XKIgkkZNS366mqFTw5paWMnU97zWER5YJ59kNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6AEC433F1;
	Wed, 28 Feb 2024 11:25:44 +0000 (UTC)
Message-ID: <ce262cda-84ba-4d8f-a916-76488c94066d@xs4all.nl>
Date: Wed, 28 Feb 2024 12:25:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] media: v4l2-subdev: Add a pad variant of
 .query_dv_timings()
Content-Language: en-US, nl
To: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>, airlied@gmail.com,
 akpm@linux-foundation.org, conor+dt@kernel.org, daniel@ffwll.ch,
 dinguyen@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 maarten.lankhorst@linux.intel.com, mchehab@kernel.org, mripard@kernel.org,
 robh+dt@kernel.org, tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 chromeos-krk-upstreaming@google.com, ribalda@chromium.org
References: <20240221160215.484151-1-panikiel@google.com>
 <20240221160215.484151-2-panikiel@google.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240221160215.484151-2-panikiel@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paweł,

On 21/02/2024 17:02, Paweł Anikiel wrote:
> Currently, .query_dv_timings() is defined as a video callback without
> a pad argument. This is a problem if the subdevice can have different
> dv timings for each pad (e.g. a DisplayPort receiver with multiple
> virtual channels).
> 
> To solve this, add a pad variant of this callback which includes
> the pad number as an argument.

So now we have two query_dv_timings ops: one for video ops, and one
for pad ops. That's not very maintainable. I would suggest switching
all current users of the video op over to the pad op.

Regards,

	Hans

> 
> Signed-off-by: Paweł Anikiel <panikiel@google.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 11 +++++++++++
>  include/media/v4l2-subdev.h           |  5 +++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 4c6198c48dd6..11f865dd19b4 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -389,6 +389,16 @@ static int call_enum_dv_timings(struct v4l2_subdev *sd,
>  	       sd->ops->pad->enum_dv_timings(sd, dvt);
>  }
>  
> +static int call_query_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
> +				 struct v4l2_dv_timings *timings)
> +{
> +	if (!timings)
> +		return -EINVAL;
> +
> +	return check_pad(sd, pad) ? :
> +	       sd->ops->pad->query_dv_timings(sd, pad, timings);
> +}
> +
>  static int call_get_mbus_config(struct v4l2_subdev *sd, unsigned int pad,
>  				struct v4l2_mbus_config *config)
>  {
> @@ -489,6 +499,7 @@ static const struct v4l2_subdev_pad_ops v4l2_subdev_call_pad_wrappers = {
>  	.set_edid		= call_set_edid,
>  	.dv_timings_cap		= call_dv_timings_cap,
>  	.enum_dv_timings	= call_enum_dv_timings,
> +	.query_dv_timings	= call_query_dv_timings,
>  	.get_frame_desc		= call_get_frame_desc,
>  	.get_mbus_config	= call_get_mbus_config,
>  };
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index a9e6b8146279..dc8963fa5a06 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -797,6 +797,9 @@ struct v4l2_subdev_state {
>   * @enum_dv_timings: callback for VIDIOC_SUBDEV_ENUM_DV_TIMINGS() ioctl handler
>   *		     code.
>   *
> + * @query_dv_timings: same as query_dv_timings() from v4l2_subdev_video_ops,
> + *		      but with additional pad argument.
> + *
>   * @link_validate: used by the media controller code to check if the links
>   *		   that belongs to a pipeline can be used for stream.
>   *
> @@ -868,6 +871,8 @@ struct v4l2_subdev_pad_ops {
>  			      struct v4l2_dv_timings_cap *cap);
>  	int (*enum_dv_timings)(struct v4l2_subdev *sd,
>  			       struct v4l2_enum_dv_timings *timings);
> +	int (*query_dv_timings)(struct v4l2_subdev *sd, unsigned int pad,
> +				struct v4l2_dv_timings *timings);
>  #ifdef CONFIG_MEDIA_CONTROLLER
>  	int (*link_validate)(struct v4l2_subdev *sd, struct media_link *link,
>  			     struct v4l2_subdev_format *source_fmt,


