Return-Path: <linux-kernel+bounces-156690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F88B06D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285D5288423
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604EB15921A;
	Wed, 24 Apr 2024 10:03:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C38157498;
	Wed, 24 Apr 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953030; cv=none; b=IonG3TSPk7tUnda3Xysq8P6+siOkNsHxb8YC7sEB11vpA5aIh3uSZfNgEL0CEoJtAg1tm/9MTxDCQh8uQ1m3a7eG6lDab/8iPxyUHtgwO0GMPeZVcQs24pVlaI/NS3l3oIxnEOpfrYH6cY2SeReJRNI0KHTFfKR13RCB7nhRwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953030; c=relaxed/simple;
	bh=of8KehQGF7cDuMBIGs5ksgB82Umnq66JY9p3LR+p260=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTPoLRBc5EsRfJWj8AOooj46iYjyyqQ6iK04aZY9d+DCWxFwpV7qfoxqg6siWaOzXONEHxq+YZg4odQYky14EjkRD6+pT+0CiXAhhPa6apaVcHrJbd+Y6FhfwYhsWGf+xyFv5oWDMnXXhgDsdnGxW5iFw631n613Yiyx0KFGPX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26846C113CE;
	Wed, 24 Apr 2024 10:03:45 +0000 (UTC)
Message-ID: <25a33db9-3bc1-4d90-83d4-0bdbea9bc5d8@xs4all.nl>
Date: Wed, 24 Apr 2024 12:03:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: v4l2-ctrls: Add average qp control
Content-Language: en-US, nl
To: Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 ming.qian@oss.nxp.com, imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240329092352.2648837-1-ming.qian@nxp.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240329092352.2648837-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 10:23, Ming Qian wrote:
> Add a control V4L2_CID_MPEG_VIDEO_AVERAGE_QP to report the average qp
> value of current encoded frame.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 4 ++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 5 +++++
>  include/uapi/linux/v4l2-controls.h                        | 2 ++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 2a165ae063fb..cef20b3f54ca 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -1653,6 +1653,10 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
>      Quantization parameter for a P frame for FWHT. Valid range: from 1
>      to 31.
>  
> +``V4L2_CID_MPEG_VIDEO_AVERAGE_QP (integer)``
> +    This read-only control returns the average qp value of the currently
> +    encoded frame. Applicable to the H264 and HEVC encoders.

qp -> QP

Why is this applicable to H264/HEVC only? I think it is fine for any codec.

This needs to document that the value applies to the last dequeued buffer
(VIDIOC_DQBUF).

> +
>  .. raw:: latex
>  
>      \normalsize
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 8696eb1cdd61..88e86e4e539d 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -972,6 +972,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES:		return "Use LTR Frames";
>  	case V4L2_CID_FWHT_I_FRAME_QP:				return "FWHT I-Frame QP Value";
>  	case V4L2_CID_FWHT_P_FRAME_QP:				return "FWHT P-Frame QP Value";
> +	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:			return "Average QP value";

value -> Value

Also move it up two lines so that it follows V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES
rather than FWHT controls.

>  
>  	/* VPX controls */
>  	case V4L2_CID_MPEG_VIDEO_VPX_NUM_PARTITIONS:		return "VPX Number of Partitions";
> @@ -1507,6 +1508,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  		*max = 0xffffffffffffLL;
>  		*step = 1;
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:
> +		*type = V4L2_CTRL_TYPE_INTEGER;
> +		*flags |= V4L2_CTRL_FLAG_VOLATILE | V4L2_CTRL_FLAG_READ_ONLY;

Drop the volatile flag, this isn't a volatile value.

> +		break;
>  	case V4L2_CID_PIXEL_RATE:
>  		*type = V4L2_CTRL_TYPE_INTEGER64;
>  		*flags |= V4L2_CTRL_FLAG_READ_ONLY;
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 99c3f5e99da7..974fd254e573 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -898,6 +898,8 @@ enum v4l2_mpeg_video_av1_level {
>  	V4L2_MPEG_VIDEO_AV1_LEVEL_7_3 = 23
>  };
>  
> +#define V4L2_CID_MPEG_VIDEO_AVERAGE_QP  (V4L2_CID_CODEC_BASE + 657)
> +
>  /*  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2 */
>  #define V4L2_CID_CODEC_CX2341X_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1000)
>  #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE		(V4L2_CID_CODEC_CX2341X_BASE+0)

Regards,

	Hans

