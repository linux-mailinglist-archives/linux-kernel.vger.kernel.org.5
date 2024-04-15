Return-Path: <linux-kernel+bounces-145553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68658A57C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3367A1F22BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31CE8174F;
	Mon, 15 Apr 2024 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="WGAOoYrP"
Received: from mail-108-mta44.mxroute.com (mail-108-mta44.mxroute.com [136.175.108.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9971E4B2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198672; cv=none; b=K/1X+U20Qfl0bvJti9Sbs35kqI3tXAxJ9L07QDUKDnn+Q+C1FYy9sRjagZqYzUl5E4+3xb2PwPtwwlRZvjQvTJTKWDswFj38Yyga7Au5XKWWfbDCLCyOT02nkNFnoU132kUHi9+RjqM8iR5G7d4tQTTy/ZBpLDywKZ/1e78EurY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198672; c=relaxed/simple;
	bh=hECP6aSG5NyyHc09a/D8NbQZI5fHlXRYAsk0oB3jcak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cp8i5PLGHmyyj6aUY+HCMBUJW+LB3+sPvl5XNJgud5Oc3xFNyI6HlBUTojh6GVQkhUfUAG4bKpAxtXTfKd1iUH78TeOp0pS/erltWXLh/toe2Bps9zRqYPpwWsRVX03WkbaQutwWc//KeTba947bNPb7Dmmo+EN/3tzOD7712eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=WGAOoYrP; arc=none smtp.client-ip=136.175.108.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta44.mxroute.com (ZoneMTA) with ESMTPSA id 18ee29461060003bea.012
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 15 Apr 2024 16:25:58 +0000
X-Zone-Loop: 8a3335c4bb1ab2d6327c0b9729090ead1064b028757f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EeroMja+ZItjTmUV/LiM4Dif6wjYVEF3i+Px4jMWoko=; b=WGAOoYrPSrZIZpOzwO9/8m6IsT
	jFgda5cI2L8O63zRp+jF5ly1Oc6cCuoPEQ+ZTMGLEPL6dkPyMjVHYXTd6V1Rx5uUn+xzx5BRk+n9a
	qoCA2na8ZKWhNFdkwh1iaJZemj14U4uCi81jqisYPw+Orb5XcN26pwZRb4d7wWw0+I28Q1j3kS8Mq
	S3mG52BRYTAyJQTWRo/rL2xmG1Ht6ie/3NYA07ZmK0m8ryEHvf0QAN5EOoZYS/Q6EE5jPuDq5EuYS
	keRLp+VbKClX5vc6eLRe8O65EKbdYTiAaGZgvFnEXLEm1JkgzHmHwH7S3yh55ZGPOdhnwvg/N5QUq
	LPokbfSA==;
Message-ID: <e4d0d1a2-117e-4106-9674-f78165060e8e@luigi311.com>
Date: Mon, 15 Apr 2024 10:25:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/25] media: i2c: imx258: Add support for reset gpio
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 sakari.ailus@linux.intel.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pavel@ucw.cz, phone-devel@vger.kernel.org,
 Ondrej Jirman <megous@megous.com>
References: <20240414203503.18402-1-git@luigi311.com>
 <20240414203503.18402-24-git@luigi311.com>
 <Zh1PGuTjFlttNnLX@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Language: en-US
From: Luis Garcia <git@luigi311.com>
In-Reply-To: <Zh1PGuTjFlttNnLX@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: git@luigi311.com

On 4/15/24 10:00, Tommaso Merciai wrote:
> Hi Luis,
> 
> On Sun, Apr 14, 2024 at 02:35:01PM -0600, git@luigi311.com wrote:
>> From: Luis Garcia <git@luigi311.com>
>>
>> It was documented in DT, but not implemented.
> 
> Good catch :-)
> 
>>
>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>> Signed-off-by: Luis Garcia <git@luigi311.com>
>> ---
>>  drivers/media/i2c/imx258.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>> index f0bd72f241e4..5de71cb7c1ae 100644
>> --- a/drivers/media/i2c/imx258.c
>> +++ b/drivers/media/i2c/imx258.c
>> @@ -699,6 +699,7 @@ struct imx258 {
>>  	unsigned int csi2_flags;
>>  
>>  	struct gpio_desc *powerdown_gpio;
>> +	struct gpio_desc *reset_gpio;
>>  
>>  	/*
>>  	 * Mutex for serialized access:
>> @@ -1250,7 +1251,11 @@ static int imx258_power_on(struct device *dev)
>>  		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>>  	}
>>  
>> -	return ret;
>> +	gpiod_set_value_cansleep(imx258->reset_gpio, 0);
>> +
> 
> I think you can remove this new line here.
> 

Done

>> +	usleep_range(400, 500);
>> +
>> +	return 0;
>>  }
>>  
>>  static int imx258_power_off(struct device *dev)
>> @@ -1260,6 +1265,7 @@ static int imx258_power_off(struct device *dev)
>>  
>>  	clk_disable_unprepare(imx258->clk);
>>  
>> +	gpiod_set_value_cansleep(imx258->reset_gpio, 1);
>>  	gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
>>  
>>  	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>> @@ -1573,6 +1579,12 @@ static int imx258_probe(struct i2c_client *client)
>>  	if (IS_ERR(imx258->powerdown_gpio))
>>  		return PTR_ERR(imx258->powerdown_gpio);
>>  
>> +	/* request optional reset pin */
>> +	imx258->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
>> +						     GPIOD_OUT_HIGH);
>> +	if (IS_ERR(imx258->reset_gpio))
>> +		return PTR_ERR(imx258->reset_gpio);
>> +
>>  	/* Initialize subdev */
>>  	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
>>  
> 
> Looks good to me.
> Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>
>

Thanks!
 
>> -- 
>> 2.44.0
>>
>>


