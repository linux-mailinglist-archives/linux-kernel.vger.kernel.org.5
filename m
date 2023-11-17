Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1D7EEDFC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbjKQI7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjKQI7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:59:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385711A5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700211553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Byhpwk2/A3BTTrDnw3Tvan6MgRg9rKnyNsb/HuoIkE=;
        b=PggCT6JKfBYVo0jxO3s2KkLxUMtN0/QLQ1Z/AJ2jr5zbxB5+UW501fvsuwyhyQI4iIKNjM
        oJqbfDHqnYqQHBilX/4B+ZQnS54TN/waB7Cpyian0sV5IY+Tb7JVQp5uGG4l6TlzOhi4ye
        Q4my8RqNo0rG41PpsF+gDt1cPwq49Yo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-3z_pOCZuMg6R-xdbXNJgyw-1; Fri, 17 Nov 2023 03:59:10 -0500
X-MC-Unique: 3z_pOCZuMg6R-xdbXNJgyw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50985abb593so2034649e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700211549; x=1700816349;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Byhpwk2/A3BTTrDnw3Tvan6MgRg9rKnyNsb/HuoIkE=;
        b=XwecglbsIsrDiLJk/+06iIefTIpqkJcFKOH7ZDxNfb7RaOHW94vJC5sLE/oQlfkDdp
         d32uBcsQx5T0SXnR/EsygIiWbGP0fuy2bA8VzP8IL2Nwii+E4a/8lqopAAS4zqrEz6HZ
         Qic2PRQAWvOYNmp9eB3KLTk9mB4tMO/Tis6dvqNGMdR1yp0x2nBOJaObglzga0NT+5bY
         6K+mlWgdkGSAk70FyGxscwaVxaCMbsYDpfTSDSkWQcZ7JpW0g//s9nAgbd0udzL5byXF
         0S5KxY+iQ6oseeu8+FlJcFVWL1uUiIhxl2cgdnyDEfw+rRXMU2/4//LPsEn9KhGiSXB+
         awFg==
X-Gm-Message-State: AOJu0Ywv6uk0M5cJcuIj4Mo99pCm2OVwsLaSGJ0qXcfURJODPCWhmScC
        A5ambPJbh9/GJaOVsdJNPxkRUU33Ql/jO8g0APalkABzW5QC3hiAMh69IRn/246/m69Fy/Y9IJi
        /H1mdvJgvphOnHZ6YrJnkbzmH
X-Received: by 2002:a19:6750:0:b0:504:4165:54ab with SMTP id e16-20020a196750000000b00504416554abmr12509658lfj.56.1700211549350;
        Fri, 17 Nov 2023 00:59:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Xx/JkBR8X2j/yAZzxPqImj1jjZaqjRHY0rocPVsfRInahUfAj7V5QZs0li/AiGaluqsLJQ==
X-Received: by 2002:a19:6750:0:b0:504:4165:54ab with SMTP id e16-20020a196750000000b00504416554abmr12509649lfj.56.1700211548917;
        Fri, 17 Nov 2023 00:59:08 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i3-20020a5d5583000000b0031f82743e25sm1648384wrv.67.2023.11.17.00.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 00:59:08 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sahaj Sarup <sahaj.sarup@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/ssd130x: Change "solomon,page-offset" property
 default value
In-Reply-To: <yqneztpzmhhqenommpvhw2pksjspq7srpeba7ckfia5z3c5aap@wmnxhbgcflnd>
References: <20231116180743.2763021-1-javierm@redhat.com>
 <20231116180743.2763021-3-javierm@redhat.com>
 <yqneztpzmhhqenommpvhw2pksjspq7srpeba7ckfia5z3c5aap@wmnxhbgcflnd>
Date:   Fri, 17 Nov 2023 09:59:08 +0100
Message-ID: <87bkbs21sz.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

> On Thu, Nov 16, 2023 at 07:07:39PM +0100, Javier Martinez Canillas wrote:
>> This is used to specify the page start address offset of the display RAM.
>> 
>> The value is used as offset when setting the page start address with the
>> SSD130X_SET_PAGE_RANGE command, and the driver currently sets its value to
>> 1 if the property is not present in the Device Tree.
>> 
>> But the datasheet mentions that the value on reset for the page start is a
>> 0, so it makes more sense to also have 0 as the default value for the page
>> offset if the property is not present.
>
> I can see the argument, but that's a DT ABI breaking change.
>

Yes, I know it's a DT ABI breaking change but what I'm trying to argue is
that the DT binding schema isn't correct to start with. Even the RPi DTBO
for this device (which I guess is used by most people with a SSD1306) has
a property to explicitly set this to 0:

  ssd1306: oled@3c{
    ...
    solomon,page-offset = <0>;
    ...
  };

https://github.com/raspberrypi/linux/blob/rpi-6.1.y/arch/arm/boot/dts/overlays/ssd1306-overlay.dts

>> In fact, using a default value of 1 leads to the display not working when
>> the emulated fbdev is attached to the framebuffer console.
>
> Could we fix that one instead? What is the issue about, exactly
>

This is the issue that Sahaj reported:

https://twitter.com/sahajsarup/status/1725088484736766364

I can try to figure out how to make the fbcon to work with a page-offset=1
but didn't investigate since thought that 0 is a much better default. Just
like the maximum resolution is the default if no width and height are set.

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

