Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9637F34FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjKUReu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjKURet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:34:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A59C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700588084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ByVZEV/reknZ3Zg3wcfs0e7TZbUblroVpHLSlR/l4z4=;
        b=DXUlAaqPC7JW+y1GKcPSJwgh1hMHYPAlQGwZ/92bpvJMrSyodzbny3hppyJPCDh3TE90pm
        CvB9SOx9LScZjyj+eRtNSC6Ve2Smw/439eUPwHDqugfVhYBOEWzMuBlw3+6LoxQqc6zZD4
        991IytghcHDxa4gKGkMXMxvY9Qks0fg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Kr7p22T7O_2r_CvgGi462Q-1; Tue, 21 Nov 2023 12:34:38 -0500
X-MC-Unique: Kr7p22T7O_2r_CvgGi462Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a01783d1ab7so87284866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588077; x=1701192877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByVZEV/reknZ3Zg3wcfs0e7TZbUblroVpHLSlR/l4z4=;
        b=Vcf9i5qIkYSWtT0b1MdAgHdxQ6SLTlsofCCsD9NELTqw4q6xjRflGL87z9UQ3RasQp
         veQ6rasTEtwZKk1BiCIKINTcFEvn38AmKObPdhO5RgDgS97cr04iHInJybBKk/ZM7jDv
         Uw2191FktbA6TEqXgw9EIcVCpQZQ0/lVwL8utYHZ4ibXCaR9O8ojSWnDuiuqs9YArG+M
         0asaqGkd0Tm1rOiYH3aEPt1Sz8z4n5j0h6yz0ki+nbqAlPXh9CBJkb996M1FuTmVd/Jm
         VHJxXdZ8Pc/pSpsSWlzoTKmjn46cZOfHk0dTi9Xex/eLKLEcgWxL9atBWB0dSFwabtw7
         FwCw==
X-Gm-Message-State: AOJu0Yx/RMnWW4Z4T55xqqSkbz3RG3r5GzATYFjkoDlsyYKQfTx7Emye
        byhlfoa1GzknCgdEA3HLpW8QjYr940Te1Fzj95ObT9BrIO3Pj94qHRljD2xNUMmI8MbNDodrYVG
        WVNFwajNSUpvRkEr5EHVI5fm5
X-Received: by 2002:a05:6402:b39:b0:543:5789:4d6c with SMTP id bo25-20020a0564020b3900b0054357894d6cmr36677edb.2.1700588077104;
        Tue, 21 Nov 2023 09:34:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKy8N59BGr+oQU2hwAvNDbYNuGAordRcRchCTrTK1v3eBt/CRoZoAT1IrqLNq4wWxfcNcfxA==
X-Received: by 2002:a05:6402:b39:b0:543:5789:4d6c with SMTP id bo25-20020a0564020b3900b0054357894d6cmr36656edb.2.1700588076759;
        Tue, 21 Nov 2023 09:34:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029? (2001-1c00-2a07-3a01-06c4-9fb2-0fbc-7029.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029])
        by smtp.gmail.com with ESMTPSA id k26-20020a056402049a00b0054855988fedsm4544787edv.37.2023.11.21.09.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:34:36 -0800 (PST)
Message-ID: <6a4134f1-4075-43d6-b238-56a31197f7fc@redhat.com>
Date:   Tue, 21 Nov 2023 18:34:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: class: Don't expose color sysfs entry
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        =?UTF-8?Q?Johannes_Pen=C3=9Fel?= <johannes.penssel@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20231121162359.9332-1-tiwai@suse.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231121162359.9332-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/21/23 17:23, Takashi Iwai wrote:
> The commit c7d80059b086 ("leds: class: Store the color index in struct
> led_classdev") introduced a new sysfs entry "color" that is commonly
> created for the led classdev.  Unfortunately, this conflicts with the
> "color" sysfs entry of already existing drivers such as Logitech HID
> or System76 ACPI drivers.  The driver probe fails due to the conflict,
> hence it leads to a severe regression with the missing keyboard, for
> example.
> 
> This patch reverts partially the change in the commit above for
> removing the led class color sysfs entries again for addressing the
> regressions.  The newly introduced led_classdev.color field is kept as
> it's already used by other driver.
> 
> Fixes: c7d80059b086 ("leds: class: Store the color index in struct led_classdev")
> Reported-by: Johannes Penßel <johannes.penssel@gmail.com>
> Closes: https://lore.kernel.org/r/b5646db3-acff-45aa-baef-df3f660486fb@gmail.com
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218045
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218155
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1217172
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thank you for taking care of this, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
> 
> This is a sort of v2 patch, as it turned out that the full revert
> leads to a build error.
> 
>  Documentation/ABI/testing/sysfs-class-led |  9 ---------
>  drivers/leds/led-class.c                  | 14 --------------
>  2 files changed, 23 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
> index b2ff0012c0f2..2e24ac3bd7ef 100644
> --- a/Documentation/ABI/testing/sysfs-class-led
> +++ b/Documentation/ABI/testing/sysfs-class-led
> @@ -59,15 +59,6 @@ Description:
>  		brightness. Reading this file when no hw brightness change
>  		event has happened will return an ENODATA error.
>  
> -What:		/sys/class/leds/<led>/color
> -Date:		June 2023
> -KernelVersion:	6.5
> -Description:
> -		Color of the LED.
> -
> -		This is a read-only file. Reading this file returns the color
> -		of the LED as a string (e.g: "red", "green", "multicolor").
> -
>  What:		/sys/class/leds/<led>/trigger
>  Date:		March 2006
>  KernelVersion:	2.6.17
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 974b84f6bd6a..ba1be15cfd8e 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -75,19 +75,6 @@ static ssize_t max_brightness_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(max_brightness);
>  
> -static ssize_t color_show(struct device *dev,
> -		struct device_attribute *attr, char *buf)
> -{
> -	const char *color_text = "invalid";
> -	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> -
> -	if (led_cdev->color < LED_COLOR_ID_MAX)
> -		color_text = led_colors[led_cdev->color];
> -
> -	return sysfs_emit(buf, "%s\n", color_text);
> -}
> -static DEVICE_ATTR_RO(color);
> -
>  #ifdef CONFIG_LEDS_TRIGGERS
>  static BIN_ATTR(trigger, 0644, led_trigger_read, led_trigger_write, 0);
>  static struct bin_attribute *led_trigger_bin_attrs[] = {
> @@ -102,7 +89,6 @@ static const struct attribute_group led_trigger_group = {
>  static struct attribute *led_class_attrs[] = {
>  	&dev_attr_brightness.attr,
>  	&dev_attr_max_brightness.attr,
> -	&dev_attr_color.attr,
>  	NULL,
>  };
>  

