Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88627E8A01
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 10:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjKKJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 04:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKKJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 04:11:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B93AA2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 01:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699693849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7c/Lm/uJDATCAgPRHFNpVgc8PBzSucZIj3Gj3ErqE9E=;
        b=ZGNoxyrgCVI+tISyX3/mx2xbRK6ZHfkdRnyVAIORUZOGGX6cA5SyxO+PWpDEorjlWjN87t
        5zs2hhXe9NNxQwkGPk/MRPjGX4rKkECuoPZD9gQuin12ebsRghe5Lp14Z9FUKymOzWJYwU
        qzV49FEAmQ62E1Mdy5Sqb7OdyPEK/10=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-S9Icv50kPMOYamG8LbMkog-1; Sat, 11 Nov 2023 04:10:47 -0500
X-MC-Unique: S9Icv50kPMOYamG8LbMkog-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5079a8c68c6so2678031e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 01:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699693846; x=1700298646;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7c/Lm/uJDATCAgPRHFNpVgc8PBzSucZIj3Gj3ErqE9E=;
        b=DYqH/gEzqBpoaDadf9DX8m0uvp2R+wKq0uzDHT3B0jNzLoikKzK5PyIxHfPOMTOekN
         cSdQAuW7+bHYu33bBuwQQ+ByHoHu5T6UTZeIeN6jC+CTM7jvzzo6klI8IFLkitVJNyyL
         qsYMJiadLYVUngGZDB6/BCOV0kTCZanSWVFN4e1nEshWKQ05jJgY1au9HHybKCFkeKVi
         jYo16HwM16q69DWAMbDhojJtMCyO4NW/olUqXbUCFtJldsQvVZFeFCCOL7oGzissmGfb
         IWvWiqX4QIcOnipjFYjRzy4m20+6pxLFenUv1qNxi+VFP6fe76JVZYnElbdI81vQq7QA
         awSg==
X-Gm-Message-State: AOJu0YxX0sA+C5Syk4ZSBx50Pkl0zXUHySSRt5+8gMGk9CbpiTPw+yyM
        MvpnYwdVzrHJLXJD1YOWBrzN50z1c5FJebUKd3CO/9t6rIohv2cFbQ/8Vr/XzxUnm7YyOx3clzd
        k8+H93K3r+BNfaP8Kb0aoMhIN
X-Received: by 2002:ac2:5551:0:b0:509:2b80:f90c with SMTP id l17-20020ac25551000000b005092b80f90cmr749741lfk.68.1699693845894;
        Sat, 11 Nov 2023 01:10:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPc9NJxiye/TNgxXuVbWNyzEeyOp6micERKdg2Co2s8cthNpH2I7hrfr/C39Ll0Y6NaWzR1A==
X-Received: by 2002:ac2:5551:0:b0:509:2b80:f90c with SMTP id l17-20020ac25551000000b005092b80f90cmr749726lfk.68.1699693845545;
        Sat, 11 Nov 2023 01:10:45 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l5-20020adfa385000000b0032da8fb0d05sm1070611wrb.110.2023.11.11.01.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:10:45 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andrew Worsley <amworsley@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR FIRMWARE FRAMEBUFFERS" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix failure of simpledrm probe when trying to grab FB
 from the EFI-based Framebuffer
In-Reply-To: <CA+Y=x3mF4jFX7PiJQ-1Gk9zyBE1mwZaF_GLYjSspT+mxtMn4GQ@mail.gmail.com>
References: <20231111042926.52990-1-amworsley@gmail.com>
 <20231111042926.52990-2-amworsley@gmail.com>
 <CA+Y=x3mF4jFX7PiJQ-1Gk9zyBE1mwZaF_GLYjSspT+mxtMn4GQ@mail.gmail.com>
Date:   Sat, 11 Nov 2023 10:10:44 +0100
Message-ID: <87cywgac4r.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Worsley <amworsley@gmail.com> writes:

> It's inline - part of the email - not an attachment?
>
> I can see it in the copy that went to me...
>
> Andrew
>
> On Sat, 11 Nov 2023 at 15:30, Andrew Worsley <amworsley@gmail.com> wrote:
>>
>>    The simpledrm.c does not call aperture_remove_conflicting_devices() in it's probe
>>    function as the drivers/video/aperture.c documentation says it should. Consequently
>>    it's request for the FB memory fails.
>>

The current behaviour is correct since aperture_remove_conflicting_devices()
is for native drivers to remove simple framebuffer devices such as simpledrm,
simplefb, efifb, etc.

>> ...
>> [    3.085302] simple-framebuffer bd58dc000.framebuffer: [drm] *ERROR* could not acquire memory range [??? 0xffff6e1d8629d580-0x2a5000001a7 flags 0x0]: -16
>> [    3.086433] simple-framebuffer: probe of bd58dc000.framebuffer failed with error -16
>> ...
>>

This is -EBUSY. What is your kernel configuration? Can you share it please.

>>    In my case no driver provided /dev/dri/card0 device is available on boot up and X
>>    fails to start as per this from X start up log.
>>
>> ...
>> [     5.616] (WW) Falling back to old probe method for modesetting
>> [     5.616] (EE) open /dev/dri/card0: No such file or directory
>> ...
>>
>>    Fault confirmed and fixed on Asahi 6.5.0 kernel with both CONFIG_FB_EFI and
>>    CONFIG_DRM_SIMPLEDRM config options set.
>>
>> Signed-off-by: Andrew Worsley <amworsley@gmail.com>
>> ---

I wonder if this is anothe side effect of commit 60aebc955949
("drivers/firmware: Move sysfb_init() from device_initcall to
subsys_initcall_sync").

Can you try reverting that one and see if it helps?

>>  drivers/gpu/drm/tiny/simpledrm.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
>> index 5fefc895bca2..e55a536b04cf 100644
>> --- a/drivers/gpu/drm/tiny/simpledrm.c
>> +++ b/drivers/gpu/drm/tiny/simpledrm.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_domain.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/aperture.h>
>>
>>  #include <drm/drm_aperture.h>
>>  #include <drm/drm_atomic.h>
>> @@ -828,6 +829,13 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>         if (mem) {
>>                 void *screen_base;
>>
>> +               ret = aperture_remove_conflicting_devices(mem->start, resource_size(mem),
>> +                       DRIVER_NAME);
>> +               if (ret) {

DRM drivers should use drm_aperture_remove_framebuffers() instead. But
this shouldn't be needed for the simpledrm driver as mentioned, since
there shouldn't be another device grabbing this aperture at this point.

I would rather try to understand what is going on in your setup and why 
the acquire is returning -EBUSY.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

