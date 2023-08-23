Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9544786338
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbjHWWNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbjHWWMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:12:54 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381FFDF;
        Wed, 23 Aug 2023 15:12:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DD63FF803;
        Wed, 23 Aug 2023 22:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692828769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzRJm47GV3ZxZ9JfsOAXY5oqbwPNNdB91XFC7KDvxvw=;
        b=jfxTzDI1DokQqoONSKdQC0GW63736/5v2d+zLi1k9hMLkXLN+oP+BZt6vUoHBJNPhlCrCP
        IPY6gC+7awEoMO6c5dr10eVf4S6bFv7tFyheeFqmmARuK/RI1Kt5ohZEB39mVYRsuaKtXj
        OGA3gRVpJ9kji4UwjE7EapWh3vSZvuyl4Z/kLwj7prLmTMI8O+gby2f+fdF3RVg8Hyow8F
        yLudVZ+8JQp9o/uPhwya1V9ipC/DYavWAzT7uHP4R/GSXyVTiTBKvYzjo+W6XTrgVJuNLv
        I86S/Y2wPGdzkz+68ir7GTzDcxQIYCoghldbt7tgtJ5/mxjYNNakVbjzp1S50A==
Date:   Thu, 24 Aug 2023 00:12:43 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mia Lin <mimi05633@gmail.com>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, openbmc@lists.ozlabs.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and
 NCT3018Y-R
Message-ID: <2023082322124382cfd168@mail.local>
References: <20230816012540.18464-1-mimi05633@gmail.com>
 <20230816012540.18464-2-mimi05633@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816012540.18464-2-mimi05633@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 16/08/2023 09:25:40+0800, Mia Lin wrote:
> -	dev_dbg(&client->dev, "%s:alarm_enable:%x alarm_flag:%x\n",
> -		__func__, *alarm_enable, *alarm_flag);
> +	if (alarm_enable && alarm_flag)

I don't really see the point of conditionally displaying this debug
message.

> +		dev_dbg(&client->dev, "%s: alarm_enable=%x, alarm_flag=%x.\n",
> +			__func__, *alarm_enable, *alarm_flag);
>  
>  	return 0;
>  }
> @@ -123,17 +124,17 @@ static irqreturn_t nct3018y_irq(int irq, void *dev_id)
>  	unsigned char alarm_flag;
>  	unsigned char alarm_enable;
>  
> -	dev_dbg(&client->dev, "%s:irq:%d\n", __func__, irq);
> +	dev_dbg(&client->dev, "%s: irq=%d.\n", __func__, irq);

You have many of those changes where you only add a space, I feel like
this is a matter of taste and this makes it more difficult than
necessary to read your patch.

>  	err = nct3018y_get_alarm_mode(nct3018y->client, &alarm_enable, &alarm_flag);
>  	if (err)
>  		return IRQ_NONE;
>  
>  	if (alarm_flag) {
> -		dev_dbg(&client->dev, "%s:alarm flag:%x\n",
> +		dev_dbg(&client->dev, "%s: alarm flag=%x.\n",
>  			__func__, alarm_flag);
>  		rtc_update_irq(nct3018y->rtc, 1, RTC_IRQF | RTC_AF);
>  		nct3018y_set_alarm_mode(nct3018y->client, 0);
> -		dev_dbg(&client->dev, "%s:IRQ_HANDLED\n", __func__);
> +		dev_dbg(&client->dev, "%s: IRQ_HANDLED.\n", __func__);
>  		return IRQ_HANDLED;
>  	}
>  
> @@ -155,7 +156,7 @@ static int nct3018y_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  		return err;
>  
>  	if (!buf[0]) {
> -		dev_dbg(&client->dev, " voltage <=1.7, date/time is not reliable.\n");
> +		dev_dbg(&client->dev, "%s: voltage <=1.7, date/time is not reliable.\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -178,26 +179,50 @@ static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	unsigned char buf[4] = {0};
> -	int err;
> +	int err, part_num, flags;
> +	int restore_flags = 0;
> +
> +	part_num = i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);

Do you really have to check the part number every time you set the time?
I don't expect it to change once read in probe.

> +	if (part_num < 0) {
> +		dev_dbg(&client->dev, "%s: Failed to read part info reg.\n", __func__);
> +		return part_num;
> +	}
> +

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
