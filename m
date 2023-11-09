Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841EF7E715E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbjKISZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344938AbjKISZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:25:23 -0500
X-Greylist: delayed 2405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Nov 2023 10:25:20 PST
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E2F30CF;
        Thu,  9 Nov 2023 10:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699554306;
 bh=REf0fnXMpg4PsdF4s5vHOGAS2ALbXsSawZYVFeBAIWw=;
 b=L3yHgEoPHvb+UC0Twvtp1BFX0wjRRyeb8nc1F5cMGHdA0rNNC2yMqn6ZrcMCeaxcxjs6bIqJn
 2cElCDXxeMVfIT4OlKBwiOoR2Du9rHm0Qa1sOEaGzwXQgNGYnzFIg+P2HoU0E4X7Mu9zWdtF3ol
 KH2RWDCvCgF9NT1Teqx3TemnbusP3aDwXJd3hUx4HzjKPHdlcb0I0qUl4F3MDWGnjM6coqmYfo3
 eYVKNRPWLMak0YrfosPdPNjmZThcLkTsRcgAYtGbcihZNPpx/qILcbVUT0eegjzu/s5uwUg+43A
 Z4bUUd0PflfQVZd0WQr0MY2EP6fSMQTMHTdOMgzhLGEA==
Message-ID: <cf43fbef-ba37-4ca5-a45c-36d657b11141@kwiboo.se>
Date:   Thu, 9 Nov 2023 19:25:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] media: rkvdec: h264: Support High 10 and 4:2:2
 profiles
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231105165521.3592037-1-jonas@kwiboo.se>
 <20231105165521.3592037-12-jonas@kwiboo.se>
 <cef435872095e95e132eb9902040fa5af22c685f.camel@collabora.com>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <cef435872095e95e132eb9902040fa5af22c685f.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 654d2401b32fff32884ed570
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-08 03:20, Nicolas Dufresne wrote:
> Le dimanche 05 novembre 2023 à 16:55 +0000, Jonas Karlman a écrit :
>> Add support and enable decoding of H264 High 10 and 4:2:2 profiles.
>>
>> Decoded CAPTURE buffer width is aligned to 64 pixels to accommodate HW
>> requirement of 10-bit format buffers, fixes decoding of:
>>
>> - Hi422FR13_SONY_A
>> - Hi422FR14_SONY_A
>> - Hi422FR15_SONY_A
>> - Hi422FR6_SONY_A
>> - Hi422FR7_SONY_A
>> - Hi422FR8_SONY_A
>> - Hi422FR9_SONY_A
>> - Hi422FREXT18_SONY_A
>>
>> The get_image_fmt() ops is implemented to select an image format
>> required for the provided SPS control.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v4:
>> - Change to use get_image_fmt() ops
>>
>> v3:
>> - Add get_fmt_opaque ops, the expected pixelformat is used as opaque
>> - Add new valid_fmt ops that validate pixelformat matches opaque
>> - Update H264_PROFILE control max value
>>
>>  drivers/staging/media/rkvdec/rkvdec-h264.c | 37 ++++++++++++++++------
>>  drivers/staging/media/rkvdec/rkvdec.c      | 33 +++++++++++++++----
>>  drivers/staging/media/rkvdec/rkvdec.h      |  3 ++
>>  3 files changed, 57 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
>> index 815d5359ddd5..baac6d012ddd 100644
>> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
>> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
>> @@ -1027,24 +1027,42 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec_ctx *ctx,
>>  	return 0;
>>  }
>>  
>> +static enum rkvdec_image_fmt rkvdec_h264_get_image_fmt(struct rkvdec_ctx *ctx,
>> +						       struct v4l2_ctrl *ctrl)
>> +{
>> +	const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
>> +
>> +	if (ctrl->id != V4L2_CID_STATELESS_H264_SPS)
>> +		return RKVDEC_IMG_FMT_ANY;
>> +
>> +	if (sps->bit_depth_luma_minus8 == 0) {
>> +		if (sps->chroma_format_idc == 2)
>> +			return RKVDEC_IMG_FMT_422_8BIT;
>> +		else
>> +			return RKVDEC_IMG_FMT_420_8BIT;
>> +	} else if (sps->bit_depth_luma_minus8 == 2) {
>> +		if (sps->chroma_format_idc == 2)
>> +			return RKVDEC_IMG_FMT_422_10BIT;
>> +		else
>> +			return RKVDEC_IMG_FMT_420_10BIT;
>> +	}
>> +
>> +	return RKVDEC_IMG_FMT_ANY;
>> +}
>> +
>>  static int rkvdec_h264_validate_sps(struct rkvdec_ctx *ctx,
>>  				    const struct v4l2_ctrl_h264_sps *sps)
>>  {
>>  	unsigned int width, height;
>>  
>> -	/*
>> -	 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
>> -	 * but it's currently broken in the driver.
>> -	 * Reject them for now, until it's fixed.
>> -	 */
>> -	if (sps->chroma_format_idc > 1)
>> -		/* Only 4:0:0 and 4:2:0 are supported */
>> +	if (sps->chroma_format_idc > 2)
>> +		/* Only 4:0:0, 4:2:0 and 4:2:2 are supported */
>>  		return -EINVAL;
>>  	if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
>>  		/* Luma and chroma bit depth mismatch */
>>  		return -EINVAL;
>> -	if (sps->bit_depth_luma_minus8 != 0)
>> -		/* Only 8-bit is supported */
>> +	if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
>> +		/* Only 8-bit and 10-bit is supported */
>>  		return -EINVAL;
>>  
>>  	width = (sps->pic_width_in_mbs_minus1 + 1) * 16;
>> @@ -1175,4 +1193,5 @@ const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops = {
>>  	.stop = rkvdec_h264_stop,
>>  	.run = rkvdec_h264_run,
>>  	.try_ctrl = rkvdec_h264_try_ctrl,
>> +	.get_image_fmt = rkvdec_h264_get_image_fmt,
>>  };
>> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
>> index 225aa1f0ac48..eb59605ccf28 100644
>> --- a/drivers/staging/media/rkvdec/rkvdec.c
>> +++ b/drivers/staging/media/rkvdec/rkvdec.c
>> @@ -73,7 +73,7 @@ static void rkvdec_fill_decoded_pixfmt(struct rkvdec_ctx *ctx,
>>  				       struct v4l2_pix_format_mplane *pix_mp)
>>  {
>>  	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
>> -			    pix_mp->width, pix_mp->height);
>> +			    ALIGN(pix_mp->width, 64), pix_mp->height);
> 
> If you align regardless if its 8/10bit (which I don't really mind, it
> does not cost much and helps if you have a Mali GPU), please do in 
> rkvdec_coded_fmts[].frmsize.step_width.
> 
> Otherwise you'll endup creating a config per bit depth, and probably
> won't need any of the rk format stuff, since you could just update the
> config, and enumerate from there. I don't mind your method though, but
> lets not hardcode alignment where it shouldn't be.

Agree, will change to use step_width/min_width = 64 in v5, not sure why
I changed from using step_width in v2 to begin with:

"
Changes in v2:
- Only align decoded buffer instead of using frmsize step_width
"

https://lore.kernel.org/linux-media/20200706215430.22859-12-jonas@kwiboo.se/

> 
>>  	pix_mp->plane_fmt[0].sizeimage += 128 *
>>  		DIV_ROUND_UP(pix_mp->width, 16) *
>>  		DIV_ROUND_UP(pix_mp->height, 16);
>> @@ -193,7 +193,7 @@ static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
>>  	{
>>  		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_PROFILE,
>>  		.cfg.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> 
> Do we want to keep this small lie ? Baseline is not supported as we
> don't support FMO and ASO. That being said, in framework like
> GStreamer, we try to decode anyway, cause we know we don't have a
> software fallback anyway.

Found a note to change this to H264_PROFILE_CONSTRAINED_BASELINE from
the old v2 series. Will include such change in v5.

https://patchwork.linuxtv.org/project/linux-media/patch/20200706215430.22859-13-jonas@kwiboo.se/#119406

> 
>> -		.cfg.max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
>> +		.cfg.max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422,
> 
> Should include V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10_INTRA and
> V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422_INTRA too ....
> 
>>  		.cfg.menu_skip_mask =
>>  			BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
> 
> Which requires substracting
> V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE too.

Will update in v5, thanks.

Regards,
Jonas

> 
>>  		.cfg.def = V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
>> @@ -210,11 +210,23 @@ static const struct rkvdec_ctrls rkvdec_h264_ctrls = {
>>  	.num_ctrls = ARRAY_SIZE(rkvdec_h264_ctrl_descs),
>>  };
>>  
>> -static const struct rkvdec_decoded_fmt_desc rkvdec_h264_vp9_decoded_fmts[] = {
>> +static const struct rkvdec_decoded_fmt_desc rkvdec_h264_decoded_fmts[] = {
>>  	{
>>  		.fourcc = V4L2_PIX_FMT_NV12,
>>  		.image_fmt = RKVDEC_IMG_FMT_420_8BIT,
>>  	},
>> +	{
>> +		.fourcc = V4L2_PIX_FMT_NV15,
>> +		.image_fmt = RKVDEC_IMG_FMT_420_10BIT,
>> +	},
>> +	{
>> +		.fourcc = V4L2_PIX_FMT_NV16,
>> +		.image_fmt = RKVDEC_IMG_FMT_422_8BIT,
>> +	},
>> +	{
>> +		.fourcc = V4L2_PIX_FMT_NV20,
>> +		.image_fmt = RKVDEC_IMG_FMT_422_10BIT,
>> +	},
>>  };
>>  
>>  static const struct rkvdec_ctrl_desc rkvdec_vp9_ctrl_descs[] = {
>> @@ -237,6 +249,13 @@ static const struct rkvdec_ctrls rkvdec_vp9_ctrls = {
>>  	.num_ctrls = ARRAY_SIZE(rkvdec_vp9_ctrl_descs),
>>  };
>>  
>> +static const struct rkvdec_decoded_fmt_desc rkvdec_vp9_decoded_fmts[] = {
>> +	{
>> +		.fourcc = V4L2_PIX_FMT_NV12,
>> +		.image_fmt = RKVDEC_IMG_FMT_420_8BIT,
>> +	},
>> +};
>> +
>>  static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
>>  	{
>>  		.fourcc = V4L2_PIX_FMT_H264_SLICE,
>> @@ -250,8 +269,8 @@ static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
>>  		},
>>  		.ctrls = &rkvdec_h264_ctrls,
>>  		.ops = &rkvdec_h264_fmt_ops,
>> -		.num_decoded_fmts = ARRAY_SIZE(rkvdec_h264_vp9_decoded_fmts),
>> -		.decoded_fmts = rkvdec_h264_vp9_decoded_fmts,
>> +		.num_decoded_fmts = ARRAY_SIZE(rkvdec_h264_decoded_fmts),
>> +		.decoded_fmts = rkvdec_h264_decoded_fmts,
>>  		.subsystem_flags = VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF,
>>  	},
>>  	{
>> @@ -266,8 +285,8 @@ static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
>>  		},
>>  		.ctrls = &rkvdec_vp9_ctrls,
>>  		.ops = &rkvdec_vp9_fmt_ops,
>> -		.num_decoded_fmts = ARRAY_SIZE(rkvdec_h264_vp9_decoded_fmts),
>> -		.decoded_fmts = rkvdec_h264_vp9_decoded_fmts,
>> +		.num_decoded_fmts = ARRAY_SIZE(rkvdec_vp9_decoded_fmts),
>> +		.decoded_fmts = rkvdec_vp9_decoded_fmts,
>>  	}
>>  };
>>  
>> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
>> index e466a2753ccf..9a9f4fced7a1 100644
>> --- a/drivers/staging/media/rkvdec/rkvdec.h
>> +++ b/drivers/staging/media/rkvdec/rkvdec.h
>> @@ -80,6 +80,9 @@ struct rkvdec_coded_fmt_ops {
>>  enum rkvdec_image_fmt {
>>  	RKVDEC_IMG_FMT_ANY = 0,
>>  	RKVDEC_IMG_FMT_420_8BIT,
>> +	RKVDEC_IMG_FMT_420_10BIT,
>> +	RKVDEC_IMG_FMT_422_8BIT,
>> +	RKVDEC_IMG_FMT_422_10BIT,
>>  };
>>  
>>  struct rkvdec_decoded_fmt_desc {
> 

