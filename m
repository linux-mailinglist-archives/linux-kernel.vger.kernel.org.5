Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC81E792467
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 17:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjIEP64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353533AbjIEGfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:35:14 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE41BD;
        Mon,  4 Sep 2023 23:35:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 197D81BF20D;
        Tue,  5 Sep 2023 06:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693895708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/qNxvvIN1DMOdd6K0/v1/1he9CNJQC3OqEVPPxjBiI=;
        b=hhHnaTV+C9lUEffPJX6azGDot8g0b39Mf72fpvmqzjYRjVulOK36Qtw8pYE/39dkr9hf/7
        N0VtbZheDJYMrKAMZLVS44rlks58KDIuaXYL5yzIEp0SOW1u07DIVuZSdianwKhrbJQNEI
        eSqUi8R3zBoaHxeGxQGoisatCliJwRccgK9VCCJxWA4kHknBxnq+1cE9B1fgWk45caFQ3p
        7YYN4RACsqgIpP/8AsPk7esT1oz2t4FiEc1mo+A7wlPemtN/AcJPa2wDDgSJB13MwGLM/I
        iMGnL+t1cAM8v8azZC5Zq8kCtcA/2teK5zXyrwuRSxVy7ZmXd5XHVO2XEcwhqw==
Date:   Tue, 5 Sep 2023 08:35:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mia Lin <mimi05633@gmail.com>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, openbmc@lists.ozlabs.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and
 NCT3018Y-R
Message-ID: <202309050635059ecd17a2@mail.local>
References: <20230905060341.5632-1-mimi05633@gmail.com>
 <20230905060341.5632-2-mimi05633@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905060341.5632-2-mimi05633@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 14:03:41+0800, Mia Lin wrote:
> The NCT3015Y-R and NCT3018Y-R use the same datasheet
>     but have different topologies as follows.
> - Topology (Only 1st i2c can set TWO bit and HF bit)
>   In NCT3015Y-R,
>     rtc 1st i2c is connected to a host CPU
>     rtc 2nd i2c is connected to a BMC
>   In NCT3018Y-R,
>     rtc 1st i2c is connected to a BMC
>     rtc 2nd i2c is connected to a host CPU
> In order to be compatible with NCT3015Y-R and NCT3018Y-R,
> - In probe,
>   If part number is NCT3018Y-R, only set HF bit to 24-Hour format.
>   Else, do nothing
> - In set_time,
>   If part number is NCT3018Y-R && TWO bit is 0,
>      change TWO bit to 1, and restore TWO bit after updating time.
> - Refine error messages to pinpoint the correct location.
> 
> Signed-off-by: Mia Lin <mimi05633@gmail.com>
> ---
>  drivers/rtc/rtc-nct3018y.c | 87 ++++++++++++++++++++++++++++----------
>  1 file changed, 64 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
> index a4e3f924837e..9ec20f241e15 100644
> --- a/drivers/rtc/rtc-nct3018y.c
> +++ b/drivers/rtc/rtc-nct3018y.c
> @@ -23,6 +23,7 @@
>  #define NCT3018Y_REG_CTRL	0x0A /* timer control */
>  #define NCT3018Y_REG_ST		0x0B /* status */
>  #define NCT3018Y_REG_CLKO	0x0C /* clock out */
> +#define NCT3018Y_REG_PART	0x21 /* part info */
>  
>  #define NCT3018Y_BIT_AF		BIT(7)
>  #define NCT3018Y_BIT_ST		BIT(7)
> @@ -37,6 +38,7 @@
>  #define NCT3018Y_REG_BAT_MASK		0x07
>  #define NCT3018Y_REG_CLKO_F_MASK	0x03 /* frequenc mask */
>  #define NCT3018Y_REG_CLKO_CKE		0x80 /* clock out enabled */
> +#define NCT3018Y_REG_PART_NCT3018Y	0x02
>  
>  struct nct3018y {
>  	struct rtc_device *rtc;
> @@ -46,6 +48,8 @@ struct nct3018y {
>  #endif
>  };
>  
> +static int part_num;
> +

This must be part of struct nct3018y.

>  static int nct3018y_set_alarm_mode(struct i2c_client *client, bool on)
>  {
>  	int err, flags;
> @@ -55,7 +59,7 @@ static int nct3018y_set_alarm_mode(struct i2c_client *client, bool on)
>  	flags =  i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
>  	if (flags < 0) {
>  		dev_dbg(&client->dev,
> -			"Failed to read NCT3018Y_REG_CTRL\n");
> +			"%s: Failed to read ctrl reg.\n", __func__);

If you really insist on this change, what about:

#define pr_fmt(fmt) "%s: " fmt, __func__

>  		return flags;
>  	}
>  
> @@ -67,21 +71,21 @@ static int nct3018y_set_alarm_mode(struct i2c_client *client, bool on)
>  	flags |= NCT3018Y_BIT_CIE;
>  	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
>  	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
> +		dev_dbg(&client->dev, "%s: Unable to write ctrl reg.\n", __func__);
>  		return err;
>  	}
>  
>  	flags =  i2c_smbus_read_byte_data(client, NCT3018Y_REG_ST);
>  	if (flags < 0) {
>  		dev_dbg(&client->dev,
> -			"Failed to read NCT3018Y_REG_ST\n");
> +			"%s: Failed to read status reg.\n", __func__);
>  		return flags;
>  	}
>  
>  	flags &= ~(NCT3018Y_BIT_AF);
>  	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_ST, flags);
>  	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_ST\n");
> +		dev_dbg(&client->dev, "%s: Unable to write status reg.\n", __func__);
>  		return err;
>  	}
>  
> @@ -155,7 +159,7 @@ static int nct3018y_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  		return err;
>  
>  	if (!buf[0]) {
> -		dev_dbg(&client->dev, " voltage <=1.7, date/time is not reliable.\n");
> +		dev_dbg(&client->dev, "%s: voltage <=1.7, date/time is not reliable.\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -178,26 +182,44 @@ static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	unsigned char buf[4] = {0};
> -	int err;
> +	int err, flags;
> +	int restore_flags = 0;
> +
> +	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
> +	if (flags < 0) {
> +		dev_dbg(&client->dev, "%s: Failed to read ctrl reg.\n", __func__);
> +		return flags;
> +	}
> +
> +	/* Check and set TWO bit */
> +	if ((part_num & NCT3018Y_REG_PART_NCT3018Y) && !(flags & NCT3018Y_BIT_TWO)) {
> +		restore_flags = 1;
> +		flags |= NCT3018Y_BIT_TWO;
> +		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> +		if (err < 0) {
> +			dev_dbg(&client->dev, "%s: Unable to write ctrl reg.\n", __func__);
> +			return err;
> +		}
> +	}
>  
>  	buf[0] = bin2bcd(tm->tm_sec);
>  	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_SC, buf[0]);
>  	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_SC\n");
> +		dev_dbg(&client->dev, "%s: Unable to write seconds reg.\n", __func__);
>  		return err;
>  	}
>  
>  	buf[0] = bin2bcd(tm->tm_min);
>  	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_MN, buf[0]);
>  	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_MN\n");
> +		dev_dbg(&client->dev, "%s: Unable to write minutes reg.\n", __func__);
>  		return err;
>  	}
>  
>  	buf[0] = bin2bcd(tm->tm_hour);
>  	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_HR, buf[0]);
>  	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_HR\n");
> +		dev_dbg(&client->dev, "%s: Unable to write hour reg.\n", __func__);
>  		return err;
>  	}
>  
> @@ -208,10 +230,22 @@ static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	err = i2c_smbus_write_i2c_block_data(client, NCT3018Y_REG_DW,
>  					     sizeof(buf), buf);
>  	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write for day and mon and year\n");
> +		dev_dbg(&client->dev, "%s: Unable to write for day and mon and year.\n", __func__);
>  		return -EIO;
>  	}
>  
> +	/* Restore TWO bit */
> +	if (restore_flags) {
> +		if (part_num & NCT3018Y_REG_PART_NCT3018Y)
> +			flags &= ~NCT3018Y_BIT_TWO;
> +
> +		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> +		if (err < 0) {
> +			dev_dbg(&client->dev, "%s: Unable to write ctrl reg.\n", __func__);
> +			return err;
> +		}
> +	}
> +
>  	return err;
>  }
>  
> @@ -224,7 +258,7 @@ static int nct3018y_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *tm)
>  	err = i2c_smbus_read_i2c_block_data(client, NCT3018Y_REG_SCA,
>  					    sizeof(buf), buf);
>  	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to read date\n");
> +		dev_dbg(&client->dev, "%s: Unable to read date.\n", __func__);
>  		return -EIO;
>  	}
>  
> @@ -257,19 +291,19 @@ static int nct3018y_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *tm)
>  
>  	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_SCA, bin2bcd(tm->time.tm_sec));
>  	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_SCA\n");
> +		dev_dbg(&client->dev, "%s: Unable to write seconds alarm reg.\n", __func__);
>  		return err;
>  	}
>  
>  	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_MNA, bin2bcd(tm->time.tm_min));
>  	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_MNA\n");
> +		dev_dbg(&client->dev, "%s: Unable to write minutes alarm reg.\n", __func__);
>  		return err;
>  	}
>  
>  	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_HRA, bin2bcd(tm->time.tm_hour));
>  	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_HRA\n");
> +		dev_dbg(&client->dev, "%s: Unable to write hour alarm reg.\n", __func__);
>  		return err;
>  	}
>  
> @@ -473,23 +507,29 @@ static int nct3018y_probe(struct i2c_client *client)
>  
>  	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
>  	if (flags < 0) {
> -		dev_dbg(&client->dev, "%s: read error\n", __func__);
> +		dev_dbg(&client->dev, "%s: Failed to read ctrl reg.\n", __func__);
>  		return flags;
>  	} else if (flags & NCT3018Y_BIT_TWO) {
> -		dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __func__);
> +		dev_dbg(&client->dev, "%s: TWO bit is set.\n", __func__);
>  	}
>  
> -	flags = NCT3018Y_BIT_TWO;
> -	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> -	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
> -		return err;
> +	part_num = i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
> +	if (part_num < 0) {
> +		dev_dbg(&client->dev, "%s: Failed to read part info reg.\n", __func__);
> +		return part_num;
> +	} else if (part_num & NCT3018Y_REG_PART_NCT3018Y) {
> +		flags = NCT3018Y_BIT_HF;
> +		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> +		if (err < 0) {
> +			dev_dbg(&client->dev, "%s: Unable to write ctrl reg.\n", __func__);
> +			return err;
> +		}
>  	}
>  
>  	flags = 0;
>  	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_ST, flags);
>  	if (err < 0) {
> -		dev_dbg(&client->dev, "%s: write error\n", __func__);
> +		dev_dbg(&client->dev, "%s: Failed to clear status reg.\n", __func__);
>  		return err;
>  	}
>  
> @@ -507,7 +547,8 @@ static int nct3018y_probe(struct i2c_client *client)
>  						IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
>  						"nct3018y", client);
>  		if (err) {
> -			dev_dbg(&client->dev, "unable to request IRQ %d\n", client->irq);
> +			dev_dbg(&client->dev, "%s: Unable to request IRQ %d.\n",
> +				__func__, client->irq);
>  			return err;
>  		}
>  	} else {
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
