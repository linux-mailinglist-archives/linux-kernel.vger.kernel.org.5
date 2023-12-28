Return-Path: <linux-kernel+bounces-12517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A381F601
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8871C22858
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C31163AB;
	Thu, 28 Dec 2023 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rfe7G5ey"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062A5687
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c4480939-2596-5800-3070-25576c69d871@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703752631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRFNzvntEOnWka4g7V2PQ0cq/lnTbxV0R+1OLRY1Y/M=;
	b=rfe7G5eyI0jFAP8VRieoxC6WfLh/UmkpuJiMz0msTEtnYI5UTnwvCqPQPOsbHolpebPcC2
	dXZlw24fFGFa7FDlbImVXgiOVcoBOElJpYBZfpk2fCMsIZ70LFxC8aDIzYwmllLHJkDsT1
	lBYkUeQ+iPDEJV4VLkOESZlmxFBsXyA=
Date: Thu, 28 Dec 2023 16:37:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: phy: Cleanup struct mdio_driver_common
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, kabel@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <20231228072350.1294425-1-yajun.deng@linux.dev>
 <95b7ee65-5661-6529-07d3-ce13968a3c25@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <95b7ee65-5661-6529-07d3-ce13968a3c25@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2023/12/28 16:24, Przemek Kitszel wrote:
> On 12/28/23 08:23, Yajun Deng wrote:
>> The struct mdio_driver_common is a wrapper for driver-model structure,
>> it contains device_driver and flags. There are only struct phy_driver
>> and mdio_driver that use it. The flags is used to distinguish between
>> struct phy_driver and mdio_driver.
>>
>> We can test that if probe of device_driver is equal to phy_probe. This
>> way, the struct mdio_driver_common is no longer needed, and struct
>> phy_driver and usb_mdio_driver will be consistent with other driver
>> structs.
>>
>> Cleanup struct mdio_driver_common and introduce is_phy_driver(). Use
>> is_phy_driver() test that if the driver is a phy or not.
>>
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> ---
>>   drivers/net/dsa/b53/b53_mdio.c          |  2 +-
>>   drivers/net/dsa/dsa_loop.c              |  2 +-
>>   drivers/net/dsa/lan9303_mdio.c          |  2 +-
>>   drivers/net/dsa/microchip/ksz8863_smi.c |  2 +-
>>   drivers/net/dsa/mt7530-mdio.c           |  2 +-
>>   drivers/net/dsa/mv88e6060.c             |  2 +-
>>   drivers/net/dsa/mv88e6xxx/chip.c        |  2 +-
>>   drivers/net/dsa/qca/ar9331.c            |  2 +-
>>   drivers/net/dsa/qca/qca8k-8xxx.c        |  2 +-
>>   drivers/net/dsa/realtek/realtek-mdio.c  |  2 +-
>>   drivers/net/dsa/xrs700x/xrs700x_mdio.c  |  2 +-
>>   drivers/net/phy/mdio_bus.c              |  2 +-
>>   drivers/net/phy/mdio_device.c           | 21 +++++++--------
>>   drivers/net/phy/phy_device.c            | 35 ++++++++++++++-----------
>>   drivers/net/phy/xilinx_gmii2rgmii.c     |  2 +-
>>   drivers/phy/broadcom/phy-bcm-ns-usb3.c  |  8 +++---
>>   drivers/phy/broadcom/phy-bcm-ns2-pcie.c |  8 +++---
>>   include/linux/mdio.h                    | 16 ++---------
>>   include/linux/phy.h                     |  9 +++----
>>   19 files changed, 54 insertions(+), 69 deletions(-)
>>
>
> some nitpicks from me,
> otherwise looks fine:
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>
> BTW, please send v2 after winter break:
> https://patchwork.hopto.org/net-next.html
>

Ok, thanks.

>
>> diff --git a/drivers/net/dsa/b53/b53_mdio.c 
>> b/drivers/net/dsa/b53/b53_mdio.c
>> index 897e5e8b3d69..1ececa4d44e4 100644
>> --- a/drivers/net/dsa/b53/b53_mdio.c
>> +++ b/drivers/net/dsa/b53/b53_mdio.c
>> @@ -392,7 +392,7 @@ static struct mdio_driver b53_mdio_driver = {
>>       .probe    = b53_mdio_probe,
>>       .remove    = b53_mdio_remove,
>>       .shutdown = b53_mdio_shutdown,
>> -    .mdiodrv.driver = {
>> +    .driver = {
>>           .name = "bcm53xx",
>>           .of_match_table = b53_of_match,
>>       },
>> diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
>> index c70ed67cc188..3f885878be3a 100644
>> --- a/drivers/net/dsa/dsa_loop.c
>> +++ b/drivers/net/dsa/dsa_loop.c
>> @@ -375,7 +375,7 @@ static void dsa_loop_drv_shutdown(struct 
>> mdio_device *mdiodev)
>>   }
>>     static struct mdio_driver dsa_loop_drv = {
>> -    .mdiodrv.driver    = {
>> +    .driver    = {
>>           .name    = "dsa-loop",
>>       },
>>       .probe    = dsa_loop_drv_probe,
>> diff --git a/drivers/net/dsa/lan9303_mdio.c 
>> b/drivers/net/dsa/lan9303_mdio.c
>> index 167a86f39f27..7cb7e2b1478a 100644
>> --- a/drivers/net/dsa/lan9303_mdio.c
>> +++ b/drivers/net/dsa/lan9303_mdio.c
>> @@ -162,7 +162,7 @@ static const struct of_device_id 
>> lan9303_mdio_of_match[] = {
>>   MODULE_DEVICE_TABLE(of, lan9303_mdio_of_match);
>>     static struct mdio_driver lan9303_mdio_driver = {
>> -    .mdiodrv.driver = {
>> +    .driver = {
>>           .name = "LAN9303_MDIO",
>>           .of_match_table = lan9303_mdio_of_match,
>>       },
>> diff --git a/drivers/net/dsa/microchip/ksz8863_smi.c 
>> b/drivers/net/dsa/microchip/ksz8863_smi.c
>> index 5711a59e2ac9..c788cadd7595 100644
>> --- a/drivers/net/dsa/microchip/ksz8863_smi.c
>> +++ b/drivers/net/dsa/microchip/ksz8863_smi.c
>> @@ -213,7 +213,7 @@ static struct mdio_driver ksz8863_driver = {
>>       .probe    = ksz8863_smi_probe,
>>       .remove    = ksz8863_smi_remove,
>>       .shutdown = ksz8863_smi_shutdown,
>> -    .mdiodrv.driver = {
>> +    .driver = {
>>           .name    = "ksz8863-switch",
>>           .of_match_table = ksz8863_dt_ids,
>>       },
>> diff --git a/drivers/net/dsa/mt7530-mdio.c 
>> b/drivers/net/dsa/mt7530-mdio.c
>> index 088533663b83..7315654a6757 100644
>> --- a/drivers/net/dsa/mt7530-mdio.c
>> +++ b/drivers/net/dsa/mt7530-mdio.c
>> @@ -258,7 +258,7 @@ static struct mdio_driver mt7530_mdio_driver = {
>>       .probe  = mt7530_probe,
>>       .remove = mt7530_remove,
>>       .shutdown = mt7530_shutdown,
>> -    .mdiodrv.driver = {
>> +    .driver = {
>>           .name = "mt7530-mdio",
>>           .of_match_table = mt7530_of_match,
>>       },
>> diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
>> index 294312b58e4f..5925f23e7ab3 100644
>> --- a/drivers/net/dsa/mv88e6060.c
>> +++ b/drivers/net/dsa/mv88e6060.c
>> @@ -367,7 +367,7 @@ static struct mdio_driver mv88e6060_driver = {
>>       .probe    = mv88e6060_probe,
>>       .remove = mv88e6060_remove,
>>       .shutdown = mv88e6060_shutdown,
>> -    .mdiodrv.driver = {
>> +    .driver = {
>>           .name = "mv88e6060",
>>           .of_match_table = mv88e6060_of_match,
>>       },
>> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c 
>> b/drivers/net/dsa/mv88e6xxx/chip.c
>> index 383b3c4d6f59..4f24699264d1 100644
>> --- a/drivers/net/dsa/mv88e6xxx/chip.c
>> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
>> @@ -7258,7 +7258,7 @@ static struct mdio_driver mv88e6xxx_driver = {
>>       .probe    = mv88e6xxx_probe,
>>       .remove = mv88e6xxx_remove,
>>       .shutdown = mv88e6xxx_shutdown,
>> -    .mdiodrv.driver = {
>> +    .driver = {
>>           .name = "mv88e6085",
>>           .of_match_table = mv88e6xxx_of_match,
>>           .pm = &mv88e6xxx_pm_ops,
>> diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
>> index 8d9d271ac3af..da392d60c9e7 100644
>> --- a/drivers/net/dsa/qca/ar9331.c
>> +++ b/drivers/net/dsa/qca/ar9331.c
>> @@ -1122,7 +1122,7 @@ static struct mdio_driver ar9331_sw_mdio_driver 
>> = {
>>       .probe = ar9331_sw_probe,
>>       .remove = ar9331_sw_remove,
>>       .shutdown = ar9331_sw_shutdown,
>> -    .mdiodrv.driver = {
>> +    .driver = {
>>           .name = AR9331_SW_NAME,
>>           .of_match_table = ar9331_sw_of_match,
>>       },
>> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c 
>> b/drivers/net/dsa/qca/qca8k-8xxx.c
>> index ec57d9d52072..fe396397f405 100644
>> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
>> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
>> @@ -2187,7 +2187,7 @@ static struct mdio_driver qca8kmdio_driver = {
>>       .probe  = qca8k_sw_probe,
>>       .remove = qca8k_sw_remove,
>>       .shutdown = qca8k_sw_shutdown,
>> -    .mdiodrv.driver = {
>> +    .driver = {
>>           .name = "qca8k",
>>           .of_match_table = qca8k_of_match,
>>           .pm = &qca8k_pm_ops,
>> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c 
>> b/drivers/net/dsa/realtek/realtek-mdio.c
>> index 292e6d087e8b..8e6a951b391c 100644
>> --- a/drivers/net/dsa/realtek/realtek-mdio.c
>> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
>> @@ -274,7 +274,7 @@ static const struct of_device_id 
>> realtek_mdio_of_match[] = {
>>   MODULE_DEVICE_TABLE(of, realtek_mdio_of_match);
>>     static struct mdio_driver realtek_mdio_driver = {
>> -    .mdiodrv.driver = {
>> +    .driver = {
>>           .name = "realtek-mdio",
>>           .of_match_table = realtek_mdio_of_match,
>>       },
>> diff --git a/drivers/net/dsa/xrs700x/xrs700x_mdio.c 
>> b/drivers/net/dsa/xrs700x/xrs700x_mdio.c
>> index 5f7d344b5d73..1a76d9d49f13 100644
>> --- a/drivers/net/dsa/xrs700x/xrs700x_mdio.c
>> +++ b/drivers/net/dsa/xrs700x/xrs700x_mdio.c
>> @@ -164,7 +164,7 @@ static const struct of_device_id __maybe_unused 
>> xrs700x_mdio_dt_ids[] = {
>>   MODULE_DEVICE_TABLE(of, xrs700x_mdio_dt_ids);
>>     static struct mdio_driver xrs700x_mdio_driver = {
>> -    .mdiodrv.driver = {
>> +    .driver = {
>>           .name    = "xrs700x-mdio",
>>           .of_match_table = of_match_ptr(xrs700x_mdio_dt_ids),
>>       },
>> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
>> index 6cf73c15635b..a1092c641d14 100644
>> --- a/drivers/net/phy/mdio_bus.c
>> +++ b/drivers/net/phy/mdio_bus.c
>> @@ -1342,7 +1342,7 @@ static int mdio_bus_match(struct device *dev, 
>> struct device_driver *drv)
>>       struct mdio_device *mdio = to_mdio_device(dev);
>>         /* Both the driver and device must type-match */
>> -    if (!(mdiodrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY) !=
>> +    if (!(is_phy_driver(&mdiodrv->driver)) !=
>>           !(mdio->flags & MDIO_DEVICE_FLAG_PHY))
>
> you could remove one pair of parens, and even change condition to:
>   if (is_phy_driver(&mdiodrv->driver) == !(mdio->flags &
>       MDIO_DEVICE_FLAG_PHY))
>
>
>>           return 0;
>>   diff --git a/drivers/net/phy/mdio_device.c 
>> b/drivers/net/phy/mdio_device.c
>> index 73f6539b9e50..16232e7a1255 100644
>> --- a/drivers/net/phy/mdio_device.c
>> +++ b/drivers/net/phy/mdio_device.c
>> @@ -40,7 +40,7 @@ int mdio_device_bus_match(struct device *dev, 
>> struct device_driver *drv)
>>       struct mdio_device *mdiodev = to_mdio_device(dev);
>>       struct mdio_driver *mdiodrv = to_mdio_driver(drv);
>>   -    if (mdiodrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY)
>> +    if (is_phy_driver(&mdiodrv->driver))
>>           return 0;
>>         return strcmp(mdiodev->modalias, drv->name) == 0;
>> @@ -203,20 +203,19 @@ static void mdio_shutdown(struct device *dev)
>>    */
>>   int mdio_driver_register(struct mdio_driver *drv)
>>   {
>> -    struct mdio_driver_common *mdiodrv = &drv->mdiodrv;
>>       int retval;
>>   -    pr_debug("%s: %s\n", __func__, mdiodrv->driver.name);
>> +    pr_debug("%s: %s\n", __func__, drv->driver.name);
>>   -    mdiodrv->driver.bus = &mdio_bus_type;
>> -    mdiodrv->driver.probe = mdio_probe;
>> -    mdiodrv->driver.remove = mdio_remove;
>> -    mdiodrv->driver.shutdown = mdio_shutdown;
>> +    drv->driver.bus = &mdio_bus_type;
>> +    drv->driver.probe = mdio_probe;
>> +    drv->driver.remove = mdio_remove;
>> +    drv->driver.shutdown = mdio_shutdown;
>>   -    retval = driver_register(&mdiodrv->driver);
>> +    retval = driver_register(&drv->driver);
>>       if (retval) {
>>           pr_err("%s: Error %d in registering driver\n",
>> -               mdiodrv->driver.name, retval);
>> +               drv->driver.name, retval);
>>             return retval;
>>       }
>> @@ -227,8 +226,6 @@ EXPORT_SYMBOL(mdio_driver_register);
>>     void mdio_driver_unregister(struct mdio_driver *drv)
>>   {
>> -    struct mdio_driver_common *mdiodrv = &drv->mdiodrv;
>> -
>> -    driver_unregister(&mdiodrv->driver);
>> +    driver_unregister(&drv->driver);
>>   }
>>   EXPORT_SYMBOL(mdio_driver_unregister);
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 3611ea64875e..55494a345bd4 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -529,7 +529,7 @@ static int phy_bus_match(struct device *dev, 
>> struct device_driver *drv)
>>       const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
>>       int i;
>>   -    if (!(phydrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY))
>> +    if (!(is_phy_driver(&phydrv->driver)))
>
> here parens are redundant too
>
>>           return 0;
>>         if (phydrv->match_phy_device)
>> @@ -1456,9 +1456,9 @@ int phy_attach_direct(struct net_device *dev, 
>> struct phy_device *phydev,
>>        */
>>       if (!d->driver) {
>>           if (phydev->is_c45)
>> -            d->driver = &genphy_c45_driver.mdiodrv.driver;
>> +            d->driver = &genphy_c45_driver.driver;
>>           else
>> -            d->driver = &genphy_driver.mdiodrv.driver;
>> +            d->driver = &genphy_driver.driver;
>>             using_genphy = true;
>>       }
>> @@ -1638,14 +1638,14 @@ static bool phy_driver_is_genphy_kind(struct 
>> phy_device *phydev,
>>   bool phy_driver_is_genphy(struct phy_device *phydev)
>>   {
>>       return phy_driver_is_genphy_kind(phydev,
>> -                     &genphy_driver.mdiodrv.driver);
>> +                     &genphy_driver.driver);
>>   }
>>   EXPORT_SYMBOL_GPL(phy_driver_is_genphy);
>>     bool phy_driver_is_genphy_10g(struct phy_device *phydev)
>>   {
>>       return phy_driver_is_genphy_kind(phydev,
>> -                     &genphy_c45_driver.mdiodrv.driver);
>> +                     &genphy_c45_driver.driver);
>
> now it fits into one line (same for phy_driver_is_genphy())
>
>>   }
>>   EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);
>
> [snip]
>

