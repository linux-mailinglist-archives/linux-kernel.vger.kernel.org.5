Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C627E77729F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjHJIQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjHJIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:16:35 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EBE1BCF;
        Thu, 10 Aug 2023 01:16:32 -0700 (PDT)
Received: from [192.168.0.2] (unknown [95.91.208.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EFEC061E5FE04;
        Thu, 10 Aug 2023 10:15:57 +0200 (CEST)
Message-ID: <72507232-d6df-40b3-8e23-40af05b85c14@molgen.mpg.de>
Date:   Thu, 10 Aug 2023 10:15:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rtc: nuvoton: Compatible with NCT3015Y-R and
 NCT3018Y-R
Content-Language: en-US
To:     Mia Lin <mimi05633@gmail.com>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20230809095112.2836-1-mimi05633@gmail.com>
 <20230809095112.2836-3-mimi05633@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230809095112.2836-3-mimi05633@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mia,


Thank you for your patch.

It’d be great if you made the commit message summary/title more 
specific. Maybe:

Add support for NCT3015Y-R

Am 09.08.23 um 11:51 schrieb Mia Lin:

An introduction what the NCT3015Y-R is and listing the differences to 
NCT3018Y-R would be nice.

> - In probe,
>    If part number is NCT3018Y-R, only set HF bit to 24-Hour format.
>    Else, do nothing
> - In set_time,
>    If part number is NCT3018Y-R && TWO bit is 0,
>      change TWO bit to 1, and restore TWO bit after updating time.

Why? This also looks unrelated to the NCT3015Y-R support. Could you 
factor it out into separate patch?

> - Use DT compatible to check the chip matches or not.

Could you please add the datasheet name and revision?

> Signed-off-by: Mia Lin <mimi05633@gmail.com>
> ---
>   drivers/rtc/rtc-nct3018y.c | 88 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 78 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
> index a4e3f924837e..edc73be3ab59 100644
> --- a/drivers/rtc/rtc-nct3018y.c
> +++ b/drivers/rtc/rtc-nct3018y.c
> @@ -7,6 +7,7 @@
>   #include <linux/i2c.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_device.h>
>   #include <linux/rtc.h>
>   #include <linux/slab.h>
>   
> @@ -23,6 +24,7 @@
>   #define NCT3018Y_REG_CTRL	0x0A /* timer control */
>   #define NCT3018Y_REG_ST		0x0B /* status */
>   #define NCT3018Y_REG_CLKO	0x0C /* clock out */
> +#define NCT3018Y_REG_PART	0x21 /* part info */
>   
>   #define NCT3018Y_BIT_AF		BIT(7)
>   #define NCT3018Y_BIT_ST		BIT(7)
> @@ -37,6 +39,20 @@
>   #define NCT3018Y_REG_BAT_MASK		0x07
>   #define NCT3018Y_REG_CLKO_F_MASK	0x03 /* frequenc mask */
>   #define NCT3018Y_REG_CLKO_CKE		0x80 /* clock out enabled */
> +#define NCT3018Y_REG_PART_NCT3015Y	0x01
> +#define NCT3018Y_REG_PART_NCT3018Y	0x02
> +
> +struct rtc_data {
> +	u8 part_number;
> +};
> +
> +static const struct rtc_data nct3015y_rtc_data = {
> +	.part_number = NCT3018Y_REG_PART_NCT3015Y,
> +};
> +
> +static const struct rtc_data nct3018y_rtc_data = {
> +	.part_number = NCT3018Y_REG_PART_NCT3018Y,
> +};
>   
>   struct nct3018y {
>   	struct rtc_device *rtc;
> @@ -52,7 +68,7 @@ static int nct3018y_set_alarm_mode(struct i2c_client *client, bool on)
>   
>   	dev_dbg(&client->dev, "%s:on:%d\n", __func__, on);
>   
> -	flags =  i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
> +	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
>   	if (flags < 0) {
>   		dev_dbg(&client->dev,
>   			"Failed to read NCT3018Y_REG_CTRL\n");
> @@ -109,8 +125,10 @@ static int nct3018y_get_alarm_mode(struct i2c_client *client, unsigned char *ala
>   		*alarm_flag = flags & NCT3018Y_BIT_AF;
>   	}
>   
> -	dev_dbg(&client->dev, "%s:alarm_enable:%x alarm_flag:%x\n",
> -		__func__, *alarm_enable, *alarm_flag);
> +	if (alarm_enable && alarm_flag) {
> +		dev_dbg(&client->dev, "%s:alarm_enable:%x alarm_flag:%x\n",
> +			__func__, *alarm_enable, *alarm_flag);
> +	}

The two hunks look like unrelated fixes. It’d be great, if you factored 
those out into a separate patch.

>   
>   	return 0;
>   }
> @@ -178,7 +196,30 @@ static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
>   {
>   	struct i2c_client *client = to_i2c_client(dev);
>   	unsigned char buf[4] = {0};
> -	int err;
> +	int err, part_num, flags, restore_flags = 0;

Why is err now initialized to 0?

> +	part_num = i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
> +	if (part_num < 0) {
> +		dev_dbg(&client->dev, "%s: read error\n", __func__);
> +		return part_num;
> +	}
> +
> +	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
> +	if (flags < 0) {
> +		dev_dbg(&client->dev, "%s: read error\n", __func__);

Could you make these distinct error messages, so users are able to 
pinpoint the correct location right away? (Or does `dev_dbg` already 
provide that information? Maybe the line? (Also more cases below.)

> +		return flags;
> +	}
> +
> +	/* Check and set TWO bit */
> +	if ((part_num & NCT3018Y_REG_PART_NCT3018Y) && !(flags & NCT3018Y_BIT_TWO)) {
> +		restore_flags = 1;
> +		flags |= NCT3018Y_BIT_TWO;
> +		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> +		if (err < 0) {
> +			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
> +			return err;
> +		}
> +	}
>   
>   	buf[0] = bin2bcd(tm->tm_sec);
>   	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_SC, buf[0]);
> @@ -212,6 +253,18 @@ static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
>   		return -EIO;
>   	}
>   
> +	/* Restore TWO bit */
> +	if (restore_flags) {
> +		if (part_num & NCT3018Y_REG_PART_NCT3018Y)
> +			flags &= ~NCT3018Y_BIT_TWO;
> +
> +		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> +		if (err < 0) {
> +			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
> +			return err;
> +		}
> +	}
> +
>   	return err;
>   }
>   
> @@ -456,6 +509,7 @@ static int nct3018y_probe(struct i2c_client *client)
>   {
>   	struct nct3018y *nct3018y;
>   	int err, flags;
> +	const struct rtc_data *data = of_device_get_match_data(&client->dev);
>   
>   	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
>   				     I2C_FUNC_SMBUS_BYTE |
> @@ -479,11 +533,24 @@ static int nct3018y_probe(struct i2c_client *client)
>   		dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __func__);
>   	}
>   
> -	flags = NCT3018Y_BIT_TWO;
> -	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> -	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
> -		return err;
> +	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
> +	if (flags < 0) {
> +		dev_dbg(&client->dev, "%s: read error\n", __func__);
> +		return flags;
> +	} else if (flags & NCT3018Y_REG_PART_NCT3018Y) {
> +		if (!(flags & data->part_number))
> +			dev_warn(&client->dev, "%s: part_num=0x%x but NCT3018Y_REG_PART=0x%x\n",
> +				 __func__, data->part_number, flags);
> +		flags = NCT3018Y_BIT_HF;
> +		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> +		if (err < 0) {
> +			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
> +			return err;
> +		}
> +	} else if (flags & NCT3018Y_REG_PART_NCT3015Y) {
> +		if (!(flags & data->part_number))
> +			dev_warn(&client->dev, "%s: part_num=0x%x but NCT3018Y_REG_PART=0x%x\n",
> +				 __func__, data->part_number, flags);
>   	}
>   
>   	flags = 0;
> @@ -530,7 +597,8 @@ static const struct i2c_device_id nct3018y_id[] = {
>   MODULE_DEVICE_TABLE(i2c, nct3018y_id);
>   
>   static const struct of_device_id nct3018y_of_match[] = {
> -	{ .compatible = "nuvoton,nct3018y" },
> +	{ .compatible = "nuvoton,nct3015y", .data = &nct3015y_rtc_data },
> +	{ .compatible = "nuvoton,nct3018y", .data = &nct3018y_rtc_data },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, nct3018y_of_match);


Kind regards,

Paul
