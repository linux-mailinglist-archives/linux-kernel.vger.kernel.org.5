Return-Path: <linux-kernel+bounces-145579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F388A580D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFC51F22A86
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19C8248C;
	Mon, 15 Apr 2024 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="MJM/iE2b"
Received: from mail-108-mta168.mxroute.com (mail-108-mta168.mxroute.com [136.175.108.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B082481
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199437; cv=none; b=M1ha2PXlouTOz0qijc/E5r/ObedjZX8yGi2jLP+iSdgauLHvb3oY3Wloh6FQPTQwBIuE7CKvPvopUHLkJfg5UC3bG4SCt/byNbgR4eoVMiPae5bLz/+NUCnxTl0QtDONtLcEpYcqVrwxBTAU7WbYIa7rkXDynZyJL3jqzYb+h/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199437; c=relaxed/simple;
	bh=EAgrrowhuxfvuA4IEIS00xQ8mSwdDWuzf1QzmetlHQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txGbeo5joprXXRsM2/gLnnpheS2JgPOx1O43hMan65MCzPG94oDjhhP06KEidwPXSUDLvvzYOb6P0jPj40Zmgaumi1kZgQYL3VBwYtXLZ4KJDAAWbIH3533U9fe9bHBLYoMLqtiyNzREmLaFhYR+Ne0jEsFp0w23Zi6jCQ9Qg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=MJM/iE2b; arc=none smtp.client-ip=136.175.108.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta168.mxroute.com (ZoneMTA) with ESMTPSA id 18ee2a01b680003bea.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 15 Apr 2024 16:38:47 +0000
X-Zone-Loop: a8b78ff32d7f98a19771cb4fe3488f7870545b8345f1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UFJA6wHd6u5mXxnVb4m3GJPfiP5KjVZafLGU70HOark=; b=MJM/iE2blIwK8MorvyDIPebWQp
	MXLRU6rrAKDgt19O4GS2lsOQPxCc+XvhhRAzSqZlhoU21/sRm2qKmAwNdi+LWsG/JnLt5bjCrK2XC
	NCiSNpozQsjHtbnhwjhyOvmRr42A9G2ECEw8/sqWIB+oF6MgR/lWehNdK5I8mxpbHBdjmvGQJNBvl
	d3jiFHZV6LXkAnOosmm+C+vdNOVMY85qRZC/CLP2jb28PFbdC9Q88OfbK8Sg3T02nGQYv4hANbQN4
	cKCfBnRaBzjDOMQvLM43E3Qw5u/JT8/GenhrM8IxXYq71j9NPNg6nlOqbBxAYH7wuNzDwqRURMWBk
	KLYFMTkg==;
Message-ID: <59255bbe-8d26-4fe5-bd17-97dda92e1553@luigi311.com>
Date: Mon, 15 Apr 2024 10:38:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/25] media: i2c: imx258: Make image geometry meet
 sensor requirements
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com,
 mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, sakari.ailus@linux.intel.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pavel@ucw.cz, phone-devel@vger.kernel.org
References: <20240414203503.18402-1-git@luigi311.com>
 <20240414203503.18402-3-git@luigi311.com> <6041186.lOV4Wx5bFT@steina-w>
Content-Language: en-US
From: Luis Garcia <git@luigi311.com>
In-Reply-To: <6041186.lOV4Wx5bFT@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: git@luigi311.com

On 4/15/24 00:25, Alexander Stein wrote:
> Hi,
> 
> Am Sonntag, 14. April 2024, 22:34:40 CEST schrieb git@luigi311.com:
>> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>
>> The output image is defined as being 4208x3118 pixels in size.
>> Y_ADD_STA register was set to 0, and Y_ADD_END to 3118, giving
>> 3119 lines total.
>>
>> The datasheet lists a requirement for Y_ADD_STA to be a multiple
>> of a power of 2 depending on binning/scaling mode (2 for full pixel,
>> 4 for x2-bin/scale, 8 for (x2-bin)+(x2-subsample) or x4-bin, or 16
>> for (x4-bin)+(x2-subsample)).
>> (Y_ADD_END – Y_ADD_STA + 1) also has to be a similar power of 2.
>>
>> The current configuration for the full res modes breaks that second
>> requirement, and we can't increase Y_ADD_STA to 1 to retain exactly
>> the same field of view as that then breaks the first requirement.
>> For the binned modes, they are worse off as 3118 is not a multiple of
>> 4.
>>
>> Increase the main mode to 4208x3120 so that it is the same FOV as the
>> binned modes, with Y_ADD_STA at 0.
>> Fix Y_ADD_STA and Y_ADD_END for the binned modes so that they meet the
>> sensor requirements.
>>
>> This does change the Bayer order as the default configuration is for
>> H&V flips to be enabled, so readout is from Y_STA_END to Y_ADD_STA,
>> and this patch has changed Y_STA_END.
>>
>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>> Signed-off-by: Luis Garcia <git@luigi311.com>
>> Reviewed-by: Pavel Machek <pavel@ucw.cz>
>> ---
>>  drivers/media/i2c/imx258.c | 26 +++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>> index 2dbafd21dd70..4a7048d834c6 100644
>> --- a/drivers/media/i2c/imx258.c
>> +++ b/drivers/media/i2c/imx258.c
>> [snip]
>> @@ -707,7 +707,7 @@ static int imx258_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
>>  	/* Initialize try_fmt */
>>  	try_fmt->width = supported_modes[0].width;
>>  	try_fmt->height = supported_modes[0].height;
>> -	try_fmt->code = MEDIA_BUS_FMT_SGRBG10_1X10;
>> +	try_fmt->code = MEDIA_BUS_FMT_SBGGR10_1X10;
> 
> Does someone have access to the data sheet? I am wondering how the
> arrangement of the pixel array is shown. I've the following (identical)
> array for these sensors:
> * imx290/imx327
> * imx219
> * imx415
> 
> G B G B
> R G R G
> G B G B
> R G R G
>


I assume this is what you are looking for
https://photos.luigi311.com/share/Imk6odsR_44VYsRvfmRwBVoG1TMnXtI61PP4sjssbmKAcNEYuVPRa9W-vIU7rpa-Ask

 
> Yet each driver configures a different bus format:
> 
> * imx290.c: MEDIA_BUS_FMT_SRGGB10_1X10
> * imx415.c: MEDIA_BUS_FMT_SGBRG10_1X10
> * imx219.c: MEDIA_BUS_FMT_SRGGB10_1X10 (no flip)
> 
> imx219 actually defines all 4 10 Bit Bayer patterns and the comment
> indicates this depends on how v or h flip is configured.
> Reading the commit message apparently the same is true for this driver.
>> Still this is confusing as I would have expected flipping to be disabled by
> default, expecting the same Bayer pattern order for all drivers. Can someone
> shed some light?
> 
> Best regards,
> Alexander
> 

Flipping defaults are changed around looks like based on use cases. Patch 20
is what actually brings in flipping and brings in the 4 definitions like you
are expecting

+	/* 10-bit modes. */
+	MEDIA_BUS_FMT_SRGGB10_1X10,
+	MEDIA_BUS_FMT_SGRBG10_1X10,
+	MEDIA_BUS_FMT_SGBRG10_1X10,
+	MEDIA_BUS_FMT_SBGGR10_1X10



