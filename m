Return-Path: <linux-kernel+bounces-130520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A505989795F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61887289597
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1CF155394;
	Wed,  3 Apr 2024 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="wfCLRkKP"
Received: from mail-108-mta94.mxroute.com (mail-108-mta94.mxroute.com [136.175.108.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58E155388
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174041; cv=none; b=lvFyjtePE7MksEHhDWfpZzfdDN/AFxM+iK+L9JsVtc99fM42680O/XOndCwATE0NmGgD+YFarwyAKXAOW9qvxzvx/X0BRvzV3IzS6GEa++3a61PrdE1G4zWEsJTUNphLYmYFhVNeGaNKFL39Ia/QsuDKINKE+OinRY77lKYrYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174041; c=relaxed/simple;
	bh=Kjy6x/NXd4JfxF0RWGjqpeR43/pbqZZRFhcY/LUk/Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ewta3eJxa23mPDgM+Sr+p9ykzZx3GG3tDcDtqxRKvn1KfbEIVN9YLxvbsvkKqdptQvIMj2T5Bxrte6GXiXNjktFlhtpax7XbT3BkTQ9HyXKzAjoMpmIvNC0GCqZEk6OL8Ms2Wf3hXdRzbLOA6p5iR9xS1S+kJ0QRUxhZk4k4UxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=wfCLRkKP; arc=none smtp.client-ip=136.175.108.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta94.mxroute.com (ZoneMTA) with ESMTPSA id 18ea581c24b0003bea.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 03 Apr 2024 19:48:48 +0000
X-Zone-Loop: 505b19853a64fc195a41a5aa47bcd2f9a369aeb3b301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WUWgE1DnjMBPuy5PLgN2/f0W38XSumLNGP2rZjB3XuA=; b=wfCLRkKPVOOds6T51nt/KWinGa
	4P2uvdx2JXMT+k9h6TDeiMKDal9WlFQwPToTSlyuh4s0Rc3s8sF+XjDhED3cgzvAb//vVPOoKfPs6
	Cszp2qBdHJ4Pl7MT3JFlzZ6vZ7sbK19WCmdWLpMEc+CV5fty/jD2fzdPRW3DTuynVkLG4JvADrTNS
	GfLGYBa+Lhq+C0x5TFuiFLSJij8w+XfG3rn5kgwRkFWTgeDaDHULwyDavW/72vB3wvAj1/xdu5atj
	9JP3BzEBqEJKnNYgMxj7cr8Ko6gC+GmH5AtRDwP/hf2yyL3srs4Wi3tChGvR4PbAGARtZBhmCWmco
	ItAsMfaA==;
Message-ID: <1080d78d-73f4-41d3-ab72-f2cc1001e184@luigi311.com>
Date: Wed, 3 Apr 2024 13:48:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/25] drivers: media: i2c: imx258: Add support for
 reset gpio
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com,
 mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pavel@ucw.cz, phone-devel@vger.kernel.org
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-25-git@luigi311.com>
 <Zg2Dy2QBguXQoR3P@kekkonen.localdomain>
 <vesqdx7w2sobjnx7tmk6s6i5zplbhsphamoalysx625r4aqffq@hos5otov5ids>
Content-Language: en-US
From: Luigi311 <git@luigi311.com>
In-Reply-To: <vesqdx7w2sobjnx7tmk6s6i5zplbhsphamoalysx625r4aqffq@hos5otov5ids>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: git@luigi311.com

On 4/3/24 11:03, Ondřej Jirman wrote:
> Hi,
> 
> On Wed, Apr 03, 2024 at 04:28:59PM GMT, Sakari Ailus wrote:
>> Hi Luis,
>>
>> Could you unify the subject prefix for the driver patches, please? E.g.
>> "media: imx258: " would be fine.
>>
>> On Wed, Apr 03, 2024 at 09:03:53AM -0600, git@luigi311.com wrote:
>>> From: Luis Garcia <git@luigi311.com>
>>>
>>> It was documented in DT, but not implemented.
>>>
>>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>>> Signed-off-by: Luis Garcia <git@luigi311.com>
>>> ---
>>>  drivers/media/i2c/imx258.c | 14 +++++++++++++-
>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>>> index 163f04f6f954..4c117c4829f1 100644
>>> --- a/drivers/media/i2c/imx258.c
>>> +++ b/drivers/media/i2c/imx258.c
>>> @@ -680,6 +680,7 @@ struct imx258 {
>>>  	unsigned int csi2_flags;
>>>  
>>>  	struct gpio_desc *powerdown_gpio;
>>> +	struct gpio_desc *reset_gpio;
>>>  
>>>  	/*
>>>  	 * Mutex for serialized access:
>>> @@ -1232,7 +1233,11 @@ static int imx258_power_on(struct device *dev)
>>>  		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>>>  	}
>>>  
>>> -	return ret;
>>> +	gpiod_set_value_cansleep(imx258->reset_gpio, 0);
>>> +
>>> +	usleep_range(400, 500);
>>
>> You could mention this at least in the commit message.
> 
> This is T6 in the datasheet: https://megous.com/dl/tmp/92c9223ce877216e.png
> 
> 
>>> +
>>> +	return 0;
>>>  }
>>>  
>>>  static int imx258_power_off(struct device *dev)
>>> @@ -1243,6 +1248,7 @@ static int imx258_power_off(struct device *dev)
>>>  	clk_disable_unprepare(imx258->clk);
>>>  	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>>>  
>>> +	gpiod_set_value_cansleep(imx258->reset_gpio, 1);
>>
>> Same question than on the other GPIO: does this belong here?
> 
> No, this should be before the regulator_bulk_disable.
> 
> See: https://megous.com/dl/tmp/c96180b23d7ce63a.png
> 
> kind regards,
> 	o.
> 

Since I'm supposed to move the reset up should I also
move the power up with it to match your downstream
driver?

>>>  	gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
>>>  
>>>  	return 0;
>>> @@ -1554,6 +1560,12 @@ static int imx258_probe(struct i2c_client *client)
>>>  	if (IS_ERR(imx258->powerdown_gpio))
>>>  		return PTR_ERR(imx258->powerdown_gpio);
>>>  
>>> +	/* request optional reset pin */
>>> +	imx258->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
>>> +						    GPIOD_OUT_HIGH);
>>> +	if (IS_ERR(imx258->reset_gpio))
>>> +		return PTR_ERR(imx258->reset_gpio);
>>> +
>>>  	/* Initialize subdev */
>>>  	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
>>>  
>>
>> -- 
>> Regards,
>>
>> Sakari Ailus


