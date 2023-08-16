Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9472A77EC06
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346614AbjHPVkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346601AbjHPVkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:40:23 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE79A2135;
        Wed, 16 Aug 2023 14:40:20 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E95091C0002;
        Wed, 16 Aug 2023 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692222019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ILBOCGYqQDB8pwu614FuSU0RZXlLWxw78lRzIvHFAWE=;
        b=gs4/5R/I6tI7lLA67r1wDP4Hyt8TCZTga6QjNCPVcle66HY+AhcXLeFgxryYDr3FSZVDUn
        aqD1BY6uX/yoM12xSZJ/8N1p/r/mXmGB1mJDHrKyQU/RtL812jq5K+2vhgu2f2cMTdzaYw
        eToeY1KSnuOiL8DeCzopQ7Pq/EGhDl1zIOpJcFaRm9fRYMdSaUB6YzYwagElVDzG0hXm+b
        qgo4YIiOnBPCocbUv5obvNjgUHNzSVW1k8tFjDC23zDlCJ0dpqM1XhWwY8quxhPUBJ0Z5/
        VM0vNtBCFlCG2MngRK4qQrdNNsEdbzWVl5HJMSS+Urggso7xMzFQVWjCg3WNvQ==
Date:   Wed, 16 Aug 2023 23:40:17 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf85363: Allow to wake up system without IRQ
Message-ID: <202308162140170c067ce7@mail.local>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.eeedf5db-4013-4c3b-be1c-1121df58f897@emailsignatures365.codetwo.com>
 <20230502055458.11004-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502055458.11004-1-mike.looijmans@topic.nl>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

Sorry for the very late review, there is a small change that is needed:

On 02/05/2023 07:54:58+0200, Mike Looijmans wrote:
> When wakeup-source is set in the devicetree, set up the device for
> using the output as interrupt instead of clock. This is similar to
> how other RTC devices handle this.
> 
> This allows the clock chip to turn on the board when wired to do
> so in hardware.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
>  drivers/rtc/rtc-pcf85363.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index 8958eadf1c3e..b1543bcdc530 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -434,23 +434,26 @@ static int pcf85363_probe(struct i2c_client *client)
>  	pcf85363->rtc->range_max = RTC_TIMESTAMP_END_2099;
>  	clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
>  
> +	if (client->irq > 0 || device_property_read_bool(&client->dev,
> +							 "wakeup-source")) {
> +		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
> +		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
> +				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
> +		device_init_wakeup(&client->dev, true);
> +		set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);

This should not be done when devm_request_threaded_irq fails.

> +	}
> +
>  	if (client->irq > 0) {
>  		unsigned long irqflags = IRQF_TRIGGER_LOW;
>  
>  		if (dev_fwnode(&client->dev))
>  			irqflags = 0;
> -
> -		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
> -		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
> -				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
>  						NULL, pcf85363_rtc_handle_irq,
>  						irqflags | IRQF_ONESHOT,
>  						"pcf85363", client);
>  		if (ret)
> -			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
> -		else
> -			set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
> +			dev_warn(&client->dev, "unable to request IRQ, alarm not functional\n");
>  	}
>  
>  	ret = devm_rtc_register_device(pcf85363->rtc);
> -- 
> 2.17.1
> 
> 
> Met vriendelijke groet / kind regards,
> 
> Mike Looijmans
> System Expert
> 
> 
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
> 
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: www.topic.nl
> 
> Please consider the environment before printing this e-mail

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
