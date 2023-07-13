Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CAF751DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjGMJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjGMJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:53:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A2268A;
        Thu, 13 Jul 2023 02:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4021D61A98;
        Thu, 13 Jul 2023 09:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D674C433CD;
        Thu, 13 Jul 2023 09:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689242013;
        bh=BWm/olWl0fngm/stPMwo1frRWG1GYu4x/EQXCH6480k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hEB3XE27SjP3dLfoUKnqBskRcXzvjf9S1LEsk9Q2uf11Any0qIGE1Cp+1BYWLSCDk
         c2gM5+zTukrmhfuU8Pt4xN3TthYxhHSTFws4OWdwgL5NSJ/IKAkoIXTmRkS2mUsLdz
         DBa8sMQr4IY7r1qe/KbKeVogAlP4a0JIoATHZCl4NzTX322l7W/QCDVzHBt6nGrPxB
         JayCU8yCieTLSf/rKaW/URWDpTdCBF/lDxq5wrBCLoedsDveAj7POoy8DlpSK7sQ3a
         OeBwecPOU/6XIy54/DcZd8zmUEftRpH48Vk3OU9sSTwRwmjgr1wSHA9FxxksYD87ZT
         EumGmuiH3+mcQ==
Date:   Thu, 13 Jul 2023 10:53:28 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/5] leds: class: store the color index in struct
 led_classdev
Message-ID: <20230713095328.GH10768@google.com>
References: <20230624084217.3079205-1-jjhiblot@traphandler.com>
 <20230624084217.3079205-4-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230624084217.3079205-4-jjhiblot@traphandler.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2023, Jean-Jacques Hiblot wrote:

> This information might be useful for more than only deriving the led's

Please expand on this.  What more?

> name. And since we have this information, we can expose it in the sysfs.

The second sentence doesn't make sense to me.

It's good practice to try and avoid placing "And" as the first word.

> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  Documentation/ABI/testing/sysfs-class-led |  9 +++++++++
>  drivers/leds/led-class.c                  | 20 ++++++++++++++++++++
>  include/linux/leds.h                      |  1 +
>  3 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
> index 2e24ac3bd7ef..1509e71fcde1 100644
> --- a/Documentation/ABI/testing/sysfs-class-led
> +++ b/Documentation/ABI/testing/sysfs-class-led
> @@ -59,6 +59,15 @@ Description:
>  		brightness. Reading this file when no hw brightness change
>  		event has happened will return an ENODATA error.
>  
> +What:		/sys/class/leds/<led>/color
> +Date:		June 2023
> +KernelVersion:	6.5
> +Description:
> +		Color of the led.

s/led/LED/  everywhere please.

> +		This is a read-only file. Reading this file returns the color
> +		of the led as a string (ex: "red", "green", "multicolor").

e.g.

> +
>  What:		/sys/class/leds/<led>/trigger
>  Date:		March 2006
>  KernelVersion:	2.6.17
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index eb1a8494dc5b..6cca21b227dd 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -76,6 +76,18 @@ static ssize_t max_brightness_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(max_brightness);
>  
> +static ssize_t color_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	const char *color_text = "invalid";
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);

Can this be NULL?

> +	if (led_cdev->color < LED_COLOR_ID_MAX)
> +		color_text = led_colors[led_cdev->color];

'\n'

> +	return sysfs_emit(buf, "%s\n", color_text);
> +}
> +static DEVICE_ATTR_RO(color);
> +
>  #ifdef CONFIG_LEDS_TRIGGERS
>  static BIN_ATTR(trigger, 0644, led_trigger_read, led_trigger_write, 0);
>  static struct bin_attribute *led_trigger_bin_attrs[] = {
> @@ -90,6 +102,7 @@ static const struct attribute_group led_trigger_group = {
>  static struct attribute *led_class_attrs[] = {
>  	&dev_attr_brightness.attr,
>  	&dev_attr_max_brightness.attr,
> +	&dev_attr_color.attr,
>  	NULL,
>  };
>  
> @@ -482,6 +495,10 @@ int led_classdev_register_ext(struct device *parent,
>  			if (fwnode_property_present(init_data->fwnode,
>  						    "retain-state-shutdown"))
>  				led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
> +
> +			if (fwnode_property_present(init_data->fwnode, "color"))
> +				fwnode_property_read_u32(init_data->fwnode, "color",
> +							 &led_cdev->color);
>  		}
>  	} else {
>  		proposed_name = led_cdev->name;
> @@ -491,6 +508,9 @@ int led_classdev_register_ext(struct device *parent,
>  	if (ret < 0)
>  		return ret;
>  
> +	if (led_cdev->color >= LED_COLOR_ID_MAX)
> +		dev_warn(parent, "LED %s color identifier out of range\n", final_name);
> +
>  	mutex_init(&led_cdev->led_access);
>  	mutex_lock(&led_cdev->led_access);
>  	led_cdev->dev = device_create_with_groups(leds_class, parent, 0,
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 95311c70d95c..487d00dac4de 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -100,6 +100,7 @@ struct led_classdev {
>  	const char		*name;
>  	unsigned int brightness;
>  	unsigned int max_brightness;
> +	unsigned int color;
>  	int			 flags;
>  
>  	/* Lower 16 bits reflect status */
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
