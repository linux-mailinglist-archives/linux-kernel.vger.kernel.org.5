Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4293E7DE353
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344439AbjKAObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjKAObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:31:13 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF6C119;
        Wed,  1 Nov 2023 07:31:07 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 1CC50100006;
        Wed,  1 Nov 2023 17:31:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1CC50100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698849066;
        bh=DgD5JTNI6nJJabYjxiobtjufPjQz5SqcRVez0mQDyQg=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=a++FwFW4y89fGej6ljw7lJ0eUqMh5Ekg891dKMhiZ5KyQnU3ZMeKnixqco94L22QD
         g9jf0hJyPbKjFqOa7LLEqXPfYDUPiPTdslk/nUgJi2MZgM6V4WHR1UyZk2aKWIUqmn
         545ta394c88OsqXf+2GSRm6RLNpQAEqPyirSaJxCqCiLKnRYBPVz+Kx5Pz8q6ZU1jB
         Jz3S1wE5K5SP3gmgQ0uaKlLTiniP5U0+1E4y+1NcY9hlhp1HfzoC9I8xxjVEptWOVV
         +4aExuE0PMg50wJqcjHvhMd8tWKa7c1dOnvKVi6V8f9UVYrh87TUWhGMcUEl39wO9p
         Rkke7fuRuUwPg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  1 Nov 2023 17:31:05 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 1 Nov
 2023 17:31:05 +0300
Date:   Wed, 1 Nov 2023 17:31:05 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <lee@kernel.org>, <pavel@ucw.cz>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 02/11] leds: aw200xx: support HWEN hardware control
Message-ID: <20231101143105.lh2ruhv27m5v5evb@CAB-WSD-L081021>
References: <20231101142445.8753-1-ddrokosov@salutedevices.com>
 <20231101142445.8753-3-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231101142445.8753-3-ddrokosov@salutedevices.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181053 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/01 13:00:00 #22378131
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

I would like to share my thoughts on the gpio-regulator. I have tried
using it and found it to be applicable in this context without any
issues. However, when it comes to the gpio regulator, it is necessary to
directly set the voltage value on the pin from the driver. While the
datasheet provides a description for the HIGH voltage value, it does not
precisely describe the LOW voltage value. To gain more insights, I have
examined other drivers, such as the mmc with vqmmc-supply. In the MMC
driver, the gpio-regulator is used to directly set the voltage values.
However, in our driver, this functionality is not required. Instead,
other led drivers utilize the gpiod subsystem to handle enable-gpios
pins.

On Wed, Nov 01, 2023 at 05:24:36PM +0300, Dmitry Rokosov wrote:
> HWEN is hardware control, which is used for enable/disable aw200xx chip.
> It's high active, internally pulled down to GND.
> 
> After HWEN pin set high the chip begins to load the OTP information,
> which takes 200us to complete. About 200us wait time is needed for
> internal oscillator startup and display SRAM initialization. After
> display SRAM initialization, the registers in page 1 to page 5 can be
> configured via i2c interface.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  drivers/leds/leds-aw200xx.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
> index 842a22087b16..7762b3a132ac 100644
> --- a/drivers/leds/leds-aw200xx.c
> +++ b/drivers/leds/leds-aw200xx.c
> @@ -10,6 +10,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/container_of.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/leds.h>
>  #include <linux/mod_devicetable.h>
> @@ -116,6 +117,7 @@ struct aw200xx {
>  	struct mutex mutex;
>  	u32 num_leds;
>  	u32 display_rows;
> +	struct gpio_desc *hwen;
>  	struct aw200xx_led leds[] __counted_by(num_leds);
>  };
>  
> @@ -358,6 +360,25 @@ static int aw200xx_chip_check(const struct aw200xx *const chip)
>  	return 0;
>  }
>  
> +static void aw200xx_enable(const struct aw200xx *const chip)
> +{
> +	gpiod_set_value_cansleep(chip->hwen, 1);
> +
> +	/*
> +	 * After HWEN pin set high the chip begins to load the OTP information,
> +	 * which takes 200us to complete. About 200us wait time is needed for
> +	 * internal oscillator startup and display SRAM initialization. After
> +	 * display SRAM initialization, the registers in page1 to page5 can be
> +	 * configured via i2c interface.
> +	 */
> +	fsleep(400);
> +}
> +
> +static void aw200xx_disable(const struct aw200xx *const chip)
> +{
> +	return gpiod_set_value_cansleep(chip->hwen, 0);
> +}
> +
>  static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
>  {
>  	struct fwnode_handle *child;
> @@ -517,6 +538,14 @@ static int aw200xx_probe(struct i2c_client *client)
>  	if (IS_ERR(chip->regmap))
>  		return PTR_ERR(chip->regmap);
>  
> +	chip->hwen = devm_gpiod_get_optional(&client->dev, "enable",
> +					     GPIOD_OUT_HIGH);
> +	if (IS_ERR(chip->hwen))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->hwen),
> +				     "Cannot get enable gpio");
> +
> +	aw200xx_enable(chip);
> +
>  	ret = aw200xx_chip_check(chip);
>  	if (ret)
>  		return ret;
> @@ -537,6 +566,9 @@ static int aw200xx_probe(struct i2c_client *client)
>  	ret = aw200xx_chip_init(chip);
>  
>  out_unlock:
> +	if (ret)
> +		aw200xx_disable(chip);
> +
>  	mutex_unlock(&chip->mutex);
>  	return ret;
>  }
> @@ -546,6 +578,7 @@ static void aw200xx_remove(struct i2c_client *client)
>  	struct aw200xx *chip = i2c_get_clientdata(client);
>  
>  	aw200xx_chip_reset(chip);
> +	aw200xx_disable(chip);
>  	mutex_destroy(&chip->mutex);
>  }
>  
> -- 
> 2.36.0
> 

-- 
Thank you,
Dmitry
