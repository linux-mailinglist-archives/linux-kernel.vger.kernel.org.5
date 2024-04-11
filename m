Return-Path: <linux-kernel+bounces-139773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE8F8A0786
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C86F285617
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5778813C80C;
	Thu, 11 Apr 2024 05:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="p4pegSC5"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF15B27702;
	Thu, 11 Apr 2024 05:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812604; cv=none; b=TfX+0y1TOeC0hp2eAY4FA7O/q6n6d9g0Tlbp9dyQdhiqcZIUDxQqRVBA3s8uMxdO4YiEJXiIompDE8x6gR156nBsHSuD0uZmFGFYr3QXEljAhTfD8Z1I4QNF/bsx/TNp0/7b+E49EAP7/NVxSRtkHzYFyxKUZ+SLBkgEfEMAExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812604; c=relaxed/simple;
	bh=ijLlkfEOixlQrBb4bdG6kkTwGrC0yh3+ME1KUOt1vj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1Yk069fJTJX0qjDiwuW5u/PyfP8n3TUX9SxLOgWjsH3TtejmtXnWvdJmXYAvhgK8WYF0F90FATui2Ox005x3fFnmYozcEUQX62J3b9cCRSupSavohL0QyGdmgDqjA5bq2uQ6fkfvfWwsUaxDGeVTsa/ak+Mkk0YJhOPF5jQj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=p4pegSC5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.108] (unknown [103.86.18.224])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6CB07E1;
	Thu, 11 Apr 2024 07:15:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712812558;
	bh=ijLlkfEOixlQrBb4bdG6kkTwGrC0yh3+ME1KUOt1vj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p4pegSC56pJULx/a8E8LMIJUc3iQrlti8xQQnHrZTV2LeRzwVkxr8XulFT+Us5X5U
	 iYpUHrV4vjS1gHyK/Sd9QQtpa548O8r4vi52QExCO+qL7YtCI3WBANJyYm65t+0NXG
	 tWqY+/2Sai8aZXnnCF0uMisGu4n8jOFN9PO5AiVw=
Message-ID: <a808c81c-2006-410e-ba8c-74c5405acbdf@ideasonboard.com>
Date: Thu, 11 Apr 2024 10:46:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] media: subdev: Fix use of sd->enabled_streams in
 call_s_stream()
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-4-e5e7a5da7420@ideasonboard.com>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240410-enable-streams-impro-v3-4-e5e7a5da7420@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomi,

Thank you for the patch

On 10/04/24 6:05 pm, Tomi Valkeinen wrote:
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

Just a suggestion, as this is only used in call_s_stream(), maybe naming 
this field 's_stream_enabled' ?

Rest looks good to me,

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>   drivers/media/v4l2-core/v4l2-subdev.c | 8 ++------
>   include/media/v4l2-subdev.h           | 3 +++
>   2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 606a909cd778..6cd353d83dfc 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -421,12 +421,8 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>   	 * The .s_stream() operation must never be called to start or stop an
>   	 * already started or stopped subdev. Catch offenders but don't return
>   	 * an error yet to avoid regressions.
> -	 *
> -	 * As .s_stream() is mutually exclusive with the .enable_streams() and
> -	 * .disable_streams() operation, we can use the enabled_streams field
> -	 * to store the subdev streaming state.
>   	 */
> -	if (WARN_ON(!!sd->enabled_streams == !!enable))
> +	if (WARN_ON(sd->streaming_enabled == !!enable))
>   		return 0;
>   
>   	ret = sd->ops->video->s_stream(sd, enable);
> @@ -437,7 +433,7 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>   	}
>   
>   	if (!ret) {
> -		sd->enabled_streams = enable ? BIT(0) : 0;
> +		sd->streaming_enabled = enable;
>   
>   		if (enable)
>   			v4l2_subdev_enable_privacy_led(sd);
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index a9e6b8146279..f55d03e0acc1 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -1043,6 +1043,8 @@ struct v4l2_subdev_platform_data {
>    *		     v4l2_subdev_enable_streams() and
>    *		     v4l2_subdev_disable_streams() helper functions for fallback
>    *		     cases.
> + * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.
> + *                     This is only for call_s_stream() internal use.
>    *
>    * Each instance of a subdev driver should create this struct, either
>    * stand-alone or embedded in a larger struct.
> @@ -1091,6 +1093,7 @@ struct v4l2_subdev {
>   	 */
>   	struct v4l2_subdev_state *active_state;
>   	u64 enabled_streams;
> +	bool streaming_enabled;
>   };
>   
>   
>


