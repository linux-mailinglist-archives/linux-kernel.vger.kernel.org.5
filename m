Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4830B7CADAA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjJPPgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjJPPgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8764FF2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697470547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkxXrxFJoOfSag3lJcT86s5RRoGY5wj60RjfYJlKoAY=;
        b=TWSEBERuVrMRTuWXzvHSbHQf2X8YlFPbnUuj8hR2AmZOuH9TIyY6O7G5+qDEMc7EqNyrEi
        lge9Tr+xSX+DOxIQb1O51jqtj75PfC1SFy7f17ircWN1BKlsaI2iQ74FSqEDwz03LFV/YA
        knRvmRLEmehEW5JPqo/yPHb/V5/YMUM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-J-U8hY63OK2x724yMy404A-1; Mon, 16 Oct 2023 11:35:41 -0400
X-MC-Unique: J-U8hY63OK2x724yMy404A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae0bf9c0b4so354057966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470540; x=1698075340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkxXrxFJoOfSag3lJcT86s5RRoGY5wj60RjfYJlKoAY=;
        b=kDLha7pdMbTRYd9pydbLA1onlGZ55CNn+pK7LyiRGF5YbShm8C0O6EcSE6UCo90+Ar
         bjFN0czLTkl2AOCCxrlpUi6v+YVxhnZ/p44hRyionEwXLrVgThNj6o0uYzanqUrUqNak
         ZGplTqOFe0QW7LgntsvQGxH6G55IXTXnETssQ5h/L1W33nX+1Ldyf2nCYWEJZjUiJnBH
         aif6UWWxVbRaLhosg6RW/EJy8ZRTA5Yy9H4PcgbNswIBjYQIIhHx00E6RlTIMbsqZ4sf
         60+aO3yzqFuYbwr2zJC3vBY2lAizM7LiOrhIr4FYjF5sy+kE9H98dAaoA/Wk72xm5kp4
         kTZg==
X-Gm-Message-State: AOJu0Yx/QaBlS2Y0t5RgVUrc1MBfGWITysUjq2R4vvREa73Klsy3h7uw
        j41zN0pmX2KswUcrIn7vNxmXo9rp86ieRgSKWI52Pl8p4cpZFU3+kcygAoWSaMxZf4fEaCI834h
        yoriYEQhKNp7+hEYbvWnHKefG
X-Received: by 2002:a17:907:3e21:b0:9c3:c2e1:a38e with SMTP id hp33-20020a1709073e2100b009c3c2e1a38emr3961960ejc.15.1697470540244;
        Mon, 16 Oct 2023 08:35:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTKR0X0zoEPPDeHbTLqNQJpeU0I7l3n/3nf1jX5QhFkwRi5fTyEEpTgpx8DSwR/Jem6J0Yqg==
X-Received: by 2002:a17:907:3e21:b0:9c3:c2e1:a38e with SMTP id hp33-20020a1709073e2100b009c3c2e1a38emr3961932ejc.15.1697470539811;
        Mon, 16 Oct 2023 08:35:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id xa4-20020a170907b9c400b009b2c5363ebasm4245504ejc.26.2023.10.16.08.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 08:35:39 -0700 (PDT)
Message-ID: <19399d81-d61c-9287-3081-e1da5a833984@redhat.com>
Date:   Mon, 16 Oct 2023 17:35:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] leds: core: Refactor led_update_brightness() to
 use standard pattern
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Denis Osterland-Heim <denis.osterland@diehl.com>
References: <20231016153051.1409074-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231016153051.1409074-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/16/23 17:30, Andy Shevchenko wrote:
> The standard conditional pattern is to check for errors first and
> bail out if any. Refactor led_update_brightness() accordingly.
> 
> While at it, drop unneeded assignment and return 0 unconditionally
> on success.
> 
> Acked-by: Denis Osterland-Heim <denis.osterland@diehl.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> v2: added tag (Denis), Cc'ed to the updated list of LED maintainers
>  drivers/leds/led-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index 2230239283d0..89c9806cc97f 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -364,17 +364,17 @@ EXPORT_SYMBOL_GPL(led_set_brightness_sync);
>  
>  int led_update_brightness(struct led_classdev *led_cdev)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	if (led_cdev->brightness_get) {
>  		ret = led_cdev->brightness_get(led_cdev);
> -		if (ret >= 0) {
> -			led_cdev->brightness = ret;
> -			return 0;
> -		}
> +		if (ret < 0)
> +			return ret;
> +
> +		led_cdev->brightness = ret;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(led_update_brightness);
>  

