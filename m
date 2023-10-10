Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E297BF62E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjJJIjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjJJIjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862D0125
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696927134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n//jsDJfypoE/LOiLD/tH7GoyXaKfj2A1kjaWCaSoa4=;
        b=CfaefVF4zsFKBAcFjtJsn0Izn7c/tqh7m7YdAbCPs7fUwoIYhUHd6t9wHw3U2qEVZBKcK0
        3JaZFBO3NWmOw1jIIzmJApfj4BBIfzEJBgvwdvNrnh7+aCDrxSl99qjqLCLJA+exZppu8e
        Inm8932vU88+m1H0CfXeHiq1t/Wy7TQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-7IGwCH2yMgGZ1USkhfYpPw-1; Tue, 10 Oct 2023 04:38:53 -0400
X-MC-Unique: 7IGwCH2yMgGZ1USkhfYpPw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-405917470e8so40842065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696927132; x=1697531932;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n//jsDJfypoE/LOiLD/tH7GoyXaKfj2A1kjaWCaSoa4=;
        b=w0XTeFXvDKsS9hg4JbgLRQv6/jYO9QALMSNpD/KvHTxtleasIeyd7xqreYwBU22HXE
         /R6/wCsm0eC58cJJkO8gs3gbgX2T+xjY3VoOqRyJMPMCRNI/ZhLF+noVyWPyUFHoPYwz
         +FSKYHkt8sF0mw9RTHtfu1RUbGFP44a9RhH5s1tQimusa0vAc4c8XeYz9br5ZBqUXOS2
         ll1eOJFvPJJG/gQo9XB5Znadz1YnkGP8tXZgL7XI/uf+CzhqiFuceqIJcyC+UZ/FaDYZ
         T9iRkT6Byqm1zbdLvIiIDg5F7+tCrl8WRLtEEFbEWFJ0hFQNgbvygGP5LvNvOQeRTxnO
         cbZg==
X-Gm-Message-State: AOJu0YybidyMvnvYrhwFELkhsxzJfPwft2jw2Bjx7e6b5ZgCSrPYswtb
        q5hkNRA5f8pbAevpSA+YHFPvcvZzfxju3ghtAY6y7fhL8IcQS7xfDpjakYUYEa/vQL5YaV7T5Qe
        6rVLpY++6CjaKGRCKEF3BBcN6
X-Received: by 2002:a05:600c:220b:b0:406:7029:c4f2 with SMTP id z11-20020a05600c220b00b004067029c4f2mr15142593wml.26.1696927132140;
        Tue, 10 Oct 2023 01:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxPcuYqMPw8109qxsMV7LN4jYO5X+gVGkVFnZppMIRXqHgr44a7fh+Ud+Q6ZZnEL2EottGHQ==
X-Received: by 2002:a05:600c:220b:b0:406:7029:c4f2 with SMTP id z11-20020a05600c220b00b004067029c4f2mr15142575wml.26.1696927131818;
        Tue, 10 Oct 2023 01:38:51 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm13447886wma.45.2023.10.10.01.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:38:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] drm/solomon: Rename ssd130x driver to ssd13xx
In-Reply-To: <now7afxcqtkizrxy45t5lmit4kpwkoxkogbhgnflje2frspnas@dh65qao7fhfm>
References: <20231009183522.543918-1-javierm@redhat.com>
 <20231009183522.543918-2-javierm@redhat.com>
 <now7afxcqtkizrxy45t5lmit4kpwkoxkogbhgnflje2frspnas@dh65qao7fhfm>
Date:   Tue, 10 Oct 2023 10:38:50 +0200
Message-ID: <87cyxm50th.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

Thanks for the feedback.

> Hi,
>
> On Mon, Oct 09, 2023 at 08:34:15PM +0200, Javier Martinez Canillas wrote:
>> The driver only supports the SSD130x family of Solomon OLED controllers
>> now, but will be extended to also support the SSD132x (4-bit grayscale)
>> and SSD133x (16-bit RGB) controller families. Rename driver to ssd13xx.
>> 
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> I'm not sure it's worth it. I understand what you want to achieve, but
> this will create conflicts, affect the configuration of everyone
> enabling that driver, etc.
>
> And we have plenty of drivers that don't match all the devices they
> support anyway.
>

Yeah, I was on the fence and even discussed this with others. I'm OK with
dropping this patch if the agreegment is that isn't worth it to make the
name more accurate.

> Plus ....
>
>> @@ -11,10 +11,10 @@
>>  #include <linux/i2c.h>
>>  #include <linux/module.h>
>>  
>> -#include "ssd130x.h"
>> +#include "ssd13xx.h"
>>  
>> -#define DRIVER_NAME	"ssd130x-i2c"
>> -#define DRIVER_DESC	"DRM driver for Solomon SSD130x OLED displays (I2C)"
>> +#define DRIVER_NAME	"ssd13xx-i2c"
>> +#define DRIVER_DESC	"DRM driver for Solomon SSD13xx OLED displays (I2C)"
>>  
>>  static const struct regmap_config ssd130x_i2c_regmap_config = {
>>  	.reg_bits = 8,
>
> ... We now end up with a lot of inconsistencies where some things are
> called ssd130x and others ssd13xx.
>

Yes, but I fix that in patch #2.

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

