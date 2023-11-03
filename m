Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EFE7E0C17
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjKCXQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjKCXQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:16:46 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A249EA2;
        Fri,  3 Nov 2023 16:16:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9CAF1BF204;
        Fri,  3 Nov 2023 23:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699053400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPB150XnVQwk5yPjWi0UDGYMA4E6lDNYkvhQ2f6W0E8=;
        b=ZrWtrYP/5OMu1HbOBC2T8IQiUQlgkTqtNyB/EVannJ00ZVEYQvEbxhZmNWlb0VmzsDY2c4
        zg1hPdNolnLYe6ODkKZqTJIRJFP3Cv7cqhKGVzJBC4GVvfLig5Off/IIK9Vt4+MsFboams
        h5f37DI8TjOh5YpEId93lKpziMxzuTf7LDq2HLwUAG3FC0M818KX1YdBoPTFmJo4gLWWox
        JjvzLzILl4lHBpIUQP7bTdBUAtHSnV1RT2AHeB4N0lH0OK0E4mOpvz3Kt8idHPeBMwlqNw
        X9Ru5e8TeRlthgj6qGZTKdbVFPgA8N76rxx3yKx6CCTlv5CwtNnmfnn2ZRLULA==
Date:   Sat, 4 Nov 2023 00:16:39 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mia Lin <mimi05633@gmail.com>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, openbmc@lists.ozlabs.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and
 NCT3018Y-R
Message-ID: <20231103231639fd4b631c@mail.local>
References: <20230913013719.8342-1-mimi05633@gmail.com>
 <20230913013719.8342-2-mimi05633@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913013719.8342-2-mimi05633@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 09:37:19+0800, Mia Lin wrote:
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
> 
> Signed-off-by: Mia Lin <mimi05633@gmail.com>
> ---
>  drivers/rtc/rtc-nct3018y.c | 52 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
> index ed4e606be8e5..b006b58e15e2 100644
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
> @@ -37,10 +38,12 @@
>  #define NCT3018Y_REG_BAT_MASK		0x07
>  #define NCT3018Y_REG_CLKO_F_MASK	0x03 /* frequenc mask */
>  #define NCT3018Y_REG_CLKO_CKE		0x80 /* clock out enabled */
> +#define NCT3018Y_REG_PART_NCT3018Y	0x02
>  
>  struct nct3018y {
>  	struct rtc_device *rtc;
>  	struct i2c_client *client;
> +	int part_num;
>  #ifdef CONFIG_COMMON_CLK
>  	struct clk_hw clkout_hw;
>  #endif
> @@ -177,8 +180,27 @@ static int nct3018y_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct nct3018y *nct3018y = dev_get_drvdata(dev);
>  	unsigned char buf[4] = {0};
> -	int err;
> +	int err, flags;
> +	int restore_flags = 0;
> +
> +	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
> +	if (flags < 0) {
> +		dev_dbg(&client->dev, "Failed to read NCT3018Y_REG_CTRL.\n");
> +		return flags;
> +	}
> +
> +	/* Check and set TWO bit */
> +	if ((nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y) && !(flags & NCT3018Y_BIT_TWO)) {
> +		restore_flags = 1;
> +		flags |= NCT3018Y_BIT_TWO;
> +		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> +		if (err < 0) {
> +			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n");
> +			return err;
> +		}
> +	}
>  
>  	buf[0] = bin2bcd(tm->tm_sec);
>  	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_SC, buf[0]);
> @@ -212,6 +234,18 @@ static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  		return -EIO;
>  	}
>  
> +	/* Restore TWO bit */
> +	if (restore_flags) {
> +		if (nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y)
> +			flags &= ~NCT3018Y_BIT_TWO;
> +
> +		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> +		if (err < 0) {
> +			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n");
> +			return err;
> +		}
> +	}
> +
>  	return err;
>  }
>  
> @@ -479,11 +513,17 @@ static int nct3018y_probe(struct i2c_client *client)
>  		dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __func__);
>  	}
>  
> -	flags = NCT3018Y_BIT_TWO;
> -	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> -	if (err < 0) {
> -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
> -		return err;
> +	nct3018y->part_num = i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
> +	if (nct3018y->part_num < 0) {
> +		dev_dbg(&client->dev, "Failed to read NCT3018Y_REG_PART.\n");
> +		return nct3018y->part_num;
> +	} else if (nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y) {

This is a weird way to check as this will accept any value of
NCT3018Y_REG_PART as long as bit 1 is set, is this really what you want?

> +		flags = NCT3018Y_BIT_HF;
> +		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> +		if (err < 0) {
> +			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n");
> +			return err;
> +		}
>  	}
>  
>  	flags = 0;
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
