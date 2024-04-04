Return-Path: <linux-kernel+bounces-132250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14708899203
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372931C23E42
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C18113C3FE;
	Thu,  4 Apr 2024 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="OmhWcmTc"
Received: from mail-108-mta101.mxroute.com (mail-108-mta101.mxroute.com [136.175.108.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA813C3CA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272706; cv=none; b=JXr1zj+eaGrgMNAae/yxRKwQpWI6lG5WPe3f9FKrnCy7FyNRD6uI4nz/654E1b1nvhgg0zzXJeRkl4Hf+LXLkynjESyBLPLsIq4f81dONyrual7fcTPsmSuxWa8JN19/Kl9kuDv6irFhX4p/nWSjTqSRKqoDw5AsfzLBVdOhKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272706; c=relaxed/simple;
	bh=Mrk+i3rtrrQiqKcF5jKGWs2vl61KOuvTlYIW8k8/MPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPlFCRiuHewfzkO8XnzN80cQgtktFX3fsldqzajigAVtJGO3zeckRtwXTmScwHS/FOW0O5LjAS39+2ILuh//qVJe2nAqOFQJOAs7lyKeIOMCV9ly1uMQFMtgIceC3VgNugZaRII2NQOrw4xaQ8s2L5zfgQcKIYo4vXNnigRwxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=OmhWcmTc; arc=none smtp.client-ip=136.175.108.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta101.mxroute.com (ZoneMTA) with ESMTPSA id 18eab67d9c60003bea.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 04 Apr 2024 23:18:13 +0000
X-Zone-Loop: 48da78de51024df796f95b2d46ee0a6dbd01f78d45b7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bwJMNX6ZJRpOtWTanY4h6tkZAqYIG8MU3/GQ1Ir4QUU=; b=OmhWcmTc+ZWR/7jOr0eC8Did2s
	XaOoTRQprjnw/jOSBzBf8qWj4VGuJQeZpp4OgU0Hw2+W1MiG9Wk/SxJNk1reSX2pGyLm/gEQCX52F
	4b1FZmdNB3tD+nQKSDI1X+febDGcaztfxp8JtdCKzM3rCz3UKdlaTsOc7oVzH0FNPcz8hglFypx5G
	bRC0hI/GUwYgZZTKujRC4dBuxtGTl5q7BJRfYoaDpgQKYeUo5Kz5na9OiIpUYk7nhgV4wQZ0OFI1h
	qxbHga8hBpyvNgXQgtEvyIjpn0AYllXKbBB9Z/4n0OIaRiacb22SxckwpIxE4zU0zulY4T46I9GGn
	PTn0YqIA==;
Message-ID: <a1db5dc8-5370-4fb8-ad22-2a5c1e45ad58@luigi311.com>
Date: Thu, 4 Apr 2024 17:18:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/25] drivers: media: i2c: imx258: Add support for
 powerdown gpio
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pavel@ucw.cz, phone-devel@vger.kernel.org
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-24-git@luigi311.com>
 <Zg2DBasC501hMQSS@kekkonen.localdomain>
 <wjlcde7yoooygj4hhdmiwrdloh6l4p6i2qbmjek5uwsifyzwgu@xjhutvmsdfou>
 <dd0e64c8-5eef-421a-9d9f-8a5865743369@luigi311.com>
 <CAPY8ntAcB3wyLj1wNE5YBx0_UGRiXEv6057XfEBfjk8NOLC9yQ@mail.gmail.com>
Content-Language: en-US
From: Luis Garcia <git@luigi311.com>
In-Reply-To: <CAPY8ntAcB3wyLj1wNE5YBx0_UGRiXEv6057XfEBfjk8NOLC9yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: git@luigi311.com

On 4/4/24 08:12, Dave Stevenson wrote:
> Hi Luigi
> 
> On Wed, 3 Apr 2024 at 20:34, Luigi311 <git@luigi311.com> wrote:
>>
>> On 4/3/24 10:57, Ondřej Jirman wrote:
>>> Hi Sakari and Luis,
>>>
>>> On Wed, Apr 03, 2024 at 04:25:41PM GMT, Sakari Ailus wrote:
>>>> Hi Luis, Ondrej,
>>>>
>>>> On Wed, Apr 03, 2024 at 09:03:52AM -0600, git@luigi311.com wrote:
>>>>> From: Luis Garcia <git@luigi311.com>
>>>>>
>>>>> On some boards powerdown signal needs to be deasserted for this
>>>>> sensor to be enabled.
>>>>>
>>>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>>>> Signed-off-by: Luis Garcia <git@luigi311.com>
>>>>> ---
>>>>>  drivers/media/i2c/imx258.c | 13 +++++++++++++
>>>>>  1 file changed, 13 insertions(+)
>>>>>
>>>>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>>>>> index 30352c33f63c..163f04f6f954 100644
>>>>> --- a/drivers/media/i2c/imx258.c
>>>>> +++ b/drivers/media/i2c/imx258.c
>>>>> @@ -679,6 +679,8 @@ struct imx258 {
>>>>>     unsigned int lane_mode_idx;
>>>>>     unsigned int csi2_flags;
>>>>>
>>>>> +   struct gpio_desc *powerdown_gpio;
>>>>> +
>>>>>     /*
>>>>>      * Mutex for serialized access:
>>>>>      * Protect sensor module set pad format and start/stop streaming safely.
>>>>> @@ -1213,6 +1215,8 @@ static int imx258_power_on(struct device *dev)
>>>>>     struct imx258 *imx258 = to_imx258(sd);
>>>>>     int ret;
>>>>>
>>>>> +   gpiod_set_value_cansleep(imx258->powerdown_gpio, 0);
>>>>
>>>> What does the spec say? Should this really happen before switching on the
>>>> supplies below?
>>>
>>> There's no powerdown input in the IMX258 manual. The manual only mentions
>>> that XCLR (reset) should be held low during power on.
>>>
>>> https://megous.com/dl/tmp/15b0992a720ab82d.png
>>>
>>> https://megous.com/dl/tmp/f2cc991046d97641.png
>>>
>>>    This sensor doesn’t have a built-in “Power ON Reset” function. The XCLR pin
>>>    is set to “LOW” and the power supplies are brought up. Then the XCLR pin
>>>    should be set to “High” after INCK supplied.
>>>
>>> So this input is some feature on camera module itself outside of the
>>> IMX258 chip, which I think is used to gate power to the module. Eg. on Pinephone
>>> Pro, there are two modules with shared power rails, so enabling supply to
>>> one module enables it to the other one, too. So this input becomes the only way
>>> to really enable/disable power to the chip when both are used at once at some
>>> point, because regulator_bulk_enable/disable becomes ineffective at that point.
>>>
>>> Luis, maybe you saw some other datasheet that mentions this input? IMO,
>>> it just gates the power rails via some mosfets on the module itself, since
>>> there's not power down input to the chip itself.
>>>
>>> kind regards,
>>>       o.
>>>
>>
>> Ondrej, I did not see anything else in the datasheet since I'm pretty sure
>> I'm looking at the same datasheet as it was supplied to me by Pine64. I'm
>> not sure what datasheet Dave has access to since he got his for a
>> completely different module than what we are testing with though.
> 
> I only have a leaked datasheet (isn't the internet wonderful!)  [1]
> XCLR is documented in that, as Ondrej has said.
> 
> If this powerdown GPIO is meant to be driving XCLR, then it is in the
> wrong order against the supplies.
> 
> This does make me confused over the difference between this powerdown
> GPIO and the reset GPIO that you implement in 24/25.
> 
> Following the PinePhone Pro DT [3] and schematics [4]
> reset-gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_LOW>;
> powerdown-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
> 
> Schematic page 11 upper right block
> GPIO1_A0/ISP0_SHUTTER_EN/ISP1_SHUTTER_EN/TCPD_VBUS_SINK_EN_d becomes
> Camera_RST_L. Page 18 feeds that through to the RESET on the camera
> connector.
> Page 11 left middle block GPIO2_D4/SDIO0_BKPWR_d becomes DVP_PDN1_H.
> Page 18 feeds that through to the PWDN on the camera connector.
> 
> Seeing as we apparently have a lens driver kicking around as well,
> potentially one is reset to the VCM, and one to the sensor? DW9714
> does have an XSD shutdown pin.
> Only the module integrator is going to really know the answer,
> although potentially a little poking with gpioset and i2cdetect may
> tell you more.
> 
>   Dave
> 
> [1] https://web.archive.org/web/20201027131326/www.hi.app/IMX258-datasheet.pdf
> [2] https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
> [3] https://xff.cz/git/linux/tree/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts?h=orange-pi-5.18#n868
> [4] https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
> 
> 

Out of curiosity I dropped this and tested it on my PPP and it still loads
up the camera correctly so I am fine with dropping this and patch 22 that
adds in the dt binding

>>>>> +
>>>>>     ret = regulator_bulk_enable(IMX258_NUM_SUPPLIES,
>>>>>                                 imx258->supplies);
>>>>>     if (ret) {
>>>>> @@ -1224,6 +1228,7 @@ static int imx258_power_on(struct device *dev)
>>>>>     ret = clk_prepare_enable(imx258->clk);
>>>>>     if (ret) {
>>>>>             dev_err(dev, "failed to enable clock\n");
>>>>> +           gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
>>>>>             regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>>>>>     }
>>>>>
>>>>> @@ -1238,6 +1243,8 @@ static int imx258_power_off(struct device *dev)
>>>>>     clk_disable_unprepare(imx258->clk);
>>>>>     regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
>>>>>
>>>>> +   gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
>>>>> +
>>>>>     return 0;
>>>>>  }
>>>>>
>>>>> @@ -1541,6 +1548,12 @@ static int imx258_probe(struct i2c_client *client)
>>>>>     if (!imx258->variant_cfg)
>>>>>             imx258->variant_cfg = &imx258_cfg;
>>>>>
>>>>> +   /* request optional power down pin */
>>>>> +   imx258->powerdown_gpio = devm_gpiod_get_optional(&client->dev, "powerdown",
>>>>> +                                               GPIOD_OUT_HIGH);
>>>>> +   if (IS_ERR(imx258->powerdown_gpio))
>>>>> +           return PTR_ERR(imx258->powerdown_gpio);
>>>>> +
>>>>>     /* Initialize subdev */
>>>>>     v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
>>>>>
>>>>
>>>> --
>>>> Regards,
>>>>
>>>> Sakari Ailus
>>


