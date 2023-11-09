Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B267E747B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjKIWmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjKIWmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:42:43 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C97422E;
        Thu,  9 Nov 2023 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699569755;
 bh=9D+oEQSTWhWnU6UndmIOjXvEnXHuT6xplme631Iu7g0=;
 b=Ig8kUrKXOKdLSZU8fKvDPhy0XsJYu1zoA9e8zQawtGTXzVLku5Hkh8WRx0wVSPipptVTqdUlR
 P4VNYejWExU+noa7L9W8JLin+drrsvZbl46LxgG0OJKJzDW6zg7D+B1cRUCG2eUkUFOMFJ8vdia
 PD1tWpswtZ9kYADq3zi/cUOe2M0u6cshfKo8Jp9ZgNXYleelsxXLuuSWmnxLV85LHu6piUonaqd
 8uOOQ5Tb4l9CoAnd9kWdq77QNak9vZKJKQaUD5eZqqhfKMeiSY/drpDdkUQFaixCKSZ1G/h/9lD
 pAyI88ig7/NUAovWGLLRrErSERjdzFH6c8NrQBnCP8zg==
Message-ID: <ff5f5d65-10b6-4d8b-8d80-69acc92f3920@kwiboo.se>
Date:   Thu, 9 Nov 2023 23:42:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] media: v4l2-common: Add helpers to calculate
 bytesperline and sizeimage
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231105165521.3592037-1-jonas@kwiboo.se>
 <20231105165521.3592037-2-jonas@kwiboo.se>
 <02c819bbbaa34342be39cfaed707ddf9a33a9087.camel@collabora.com>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <02c819bbbaa34342be39cfaed707ddf9a33a9087.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 654d605bd8155d71a27da9f4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-08 03:45, Nicolas Dufresne wrote:
> Le dimanche 05 novembre 2023 à 16:55 +0000, Jonas Karlman a écrit :
>> Add helper functions to calculate plane bytesperline and sizeimage,
>> these new helpers consider bpp div, block width and height when
>> calculating plane bytesperline and sizeimage.
> 
> Is this only refactoring to reduce duplicated code ? I haven't seen
> what is new in there yet, maybe the commit message could clarify.

Yes, this is just some refactoring and is not really required.

Cannot remember exactly why I though this was needed back in v1/v2. I
probably had an issue with wrong bytesperline/sizeimage due to the
fractal bytes per pixel nature of the NV15/NV20 pixel formats. Hacked
the calculation and forgot to update in one of the 3 places they get
calculated, then decided to refactor after that failed.

Will update commit message to clarify that this is only refactoring and
has no real impact for this series in v5.

Regards,
Jonas

> 
> regards,
> Nicolas
> 
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v4:
>> - No change
>>
>> v3:
>> - Consider bpp_div in calculation
>>
>>  drivers/media/v4l2-core/v4l2-common.c | 78 +++++++++++++--------------
>>  1 file changed, 39 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
>> index 3a4b15a98e02..834b426da8b1 100644
>> --- a/drivers/media/v4l2-core/v4l2-common.c
>> +++ b/drivers/media/v4l2-core/v4l2-common.c
>> @@ -350,6 +350,34 @@ static inline unsigned int v4l2_format_block_height(const struct v4l2_format_inf
>>  	return info->block_h[plane];
>>  }
>>  
>> +static inline unsigned int v4l2_format_plane_width(const struct v4l2_format_info *info, int plane,
>> +						   unsigned int width)
>> +{
>> +	unsigned int hdiv = plane ? info->hdiv : 1;
>> +	unsigned int aligned_width =
>> +		ALIGN(width, v4l2_format_block_width(info, plane));
>> +
>> +	return DIV_ROUND_UP(aligned_width, hdiv) *
>> +	       info->bpp[plane] / info->bpp_div[plane];
>> +}
>> +
>> +static inline unsigned int v4l2_format_plane_height(const struct v4l2_format_info *info, int plane,
>> +						    unsigned int height)
>> +{
>> +	unsigned int vdiv = plane ? info->vdiv : 1;
>> +	unsigned int aligned_height =
>> +		ALIGN(height, v4l2_format_block_height(info, plane));
>> +
>> +	return DIV_ROUND_UP(aligned_height, vdiv);
>> +}
>> +
>> +static inline unsigned int v4l2_format_plane_size(const struct v4l2_format_info *info, int plane,
>> +						  unsigned int width, unsigned int height)
>> +{
>> +	return v4l2_format_plane_width(info, plane, width) *
>> +	       v4l2_format_plane_height(info, plane, height);
>> +}
>> +
>>  void v4l2_apply_frmsize_constraints(u32 *width, u32 *height,
>>  				    const struct v4l2_frmsize_stepwise *frmsize)
>>  {
>> @@ -385,37 +413,19 @@ int v4l2_fill_pixfmt_mp(struct v4l2_pix_format_mplane *pixfmt,
>>  
>>  	if (info->mem_planes == 1) {
>>  		plane = &pixfmt->plane_fmt[0];
>> -		plane->bytesperline = ALIGN(width, v4l2_format_block_width(info, 0)) * info->bpp[0] / info->bpp_div[0];
>> +		plane->bytesperline = v4l2_format_plane_width(info, 0, width);
>>  		plane->sizeimage = 0;
>>  
>> -		for (i = 0; i < info->comp_planes; i++) {
>> -			unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
>> -			unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
>> -			unsigned int aligned_width;
>> -			unsigned int aligned_height;
>> -
>> -			aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
>> -			aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
>> -
>> -			plane->sizeimage += info->bpp[i] *
>> -				DIV_ROUND_UP(aligned_width, hdiv) *
>> -				DIV_ROUND_UP(aligned_height, vdiv) / info->bpp_div[i];
>> -		}
>> +		for (i = 0; i < info->comp_planes; i++)
>> +			plane->sizeimage +=
>> +				v4l2_format_plane_size(info, i, width, height);
>>  	} else {
>>  		for (i = 0; i < info->comp_planes; i++) {
>> -			unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
>> -			unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
>> -			unsigned int aligned_width;
>> -			unsigned int aligned_height;
>> -
>> -			aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
>> -			aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
>> -
>>  			plane = &pixfmt->plane_fmt[i];
>>  			plane->bytesperline =
>> -				info->bpp[i] * DIV_ROUND_UP(aligned_width, hdiv) / info->bpp_div[i];
>> -			plane->sizeimage =
>> -				plane->bytesperline * DIV_ROUND_UP(aligned_height, vdiv);
>> +				v4l2_format_plane_width(info, i, width);
>> +			plane->sizeimage = plane->bytesperline *
>> +				v4l2_format_plane_height(info, i, height);
>>  		}
>>  	}
>>  	return 0;
>> @@ -439,22 +449,12 @@ int v4l2_fill_pixfmt(struct v4l2_pix_format *pixfmt, u32 pixelformat,
>>  	pixfmt->width = width;
>>  	pixfmt->height = height;
>>  	pixfmt->pixelformat = pixelformat;
>> -	pixfmt->bytesperline = ALIGN(width, v4l2_format_block_width(info, 0)) * info->bpp[0] / info->bpp_div[0];
>> +	pixfmt->bytesperline = v4l2_format_plane_width(info, 0, width);
>>  	pixfmt->sizeimage = 0;
>>  
>> -	for (i = 0; i < info->comp_planes; i++) {
>> -		unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
>> -		unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
>> -		unsigned int aligned_width;
>> -		unsigned int aligned_height;
>> -
>> -		aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
>> -		aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
>> -
>> -		pixfmt->sizeimage += info->bpp[i] *
>> -			DIV_ROUND_UP(aligned_width, hdiv) *
>> -			DIV_ROUND_UP(aligned_height, vdiv) / info->bpp_div[i];
>> -	}
>> +	for (i = 0; i < info->comp_planes; i++)
>> +		pixfmt->sizeimage +=
>> +			v4l2_format_plane_size(info, i, width, height);
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(v4l2_fill_pixfmt);
> 

