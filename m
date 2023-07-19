Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42840759CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjGSRuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGSRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB261BF6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689788964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XYue51ytI6NDHPfrk6nzrr+J7lvDM0nrv78I+/fXUNw=;
        b=R2kObZgY4hhHWw9fQleV5Wj7fC05dZF3J2LskRwlYgw2RuAGp7EydMSxr5QLmQjS3Cji7j
        hS/YW9Y+NKIpLS0jhTg9Tttf+leDkH6Gy1sUlk0e5Cesh2U6Td+ryyJeyc/jbYkjBx4I1c
        5NkLsPm86FbG99O0kDzd9Dsa2FNtMvs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-CI3AZDWyNyyafRsGwrmQbQ-1; Wed, 19 Jul 2023 13:49:20 -0400
X-MC-Unique: CI3AZDWyNyyafRsGwrmQbQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b707829eb9so66949111fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689788959; x=1690393759;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYue51ytI6NDHPfrk6nzrr+J7lvDM0nrv78I+/fXUNw=;
        b=D+gaPz3VCn2z+jVl+m7WYtUFWMX/Y5W9K/Gd+wOxknlIe/0mljv/JHR85O7ap/w9h8
         oTHGKi1D/hdNFUXjLilUKoHcKvogFvmU7Fr4zggM05AFbYAVdUQvqEQ4EGYQ2eEhmEAd
         pY/mKqfbVlMGABWcJx2tyHAuhogsFWYD0lz3ZFqgmKZMf+waxC41nBlhgGz69W8KISRS
         wuQgK+aXWXE3dX3hzpJ/JWTFxa2FyzirkpfFT2UUYhkd3rXxoRd4uiJ9ENX/8k+NOqJa
         JKXv9gKbvPCAZ+7tL0EO+pXRWTJf+EosLiG+0RcY47CEvCfi9bu4PQFnafMvhQoRr3kP
         rusg==
X-Gm-Message-State: ABy/qLYDH+BEv2CJYw1gSUFs2xOX83u9n0CBQmV4/yH2fkFHayBh3XPo
        IvYLj8aRC890C7esmdg0AGFid/bRo7tCfPAwj3DAA/AxtTEkbFi5mMoQA06fNJOVpjvHbtwyzca
        9BoP8izKUlPQOJVjvkIJbeseC
X-Received: by 2002:a2e:b60a:0:b0:2b6:c8e8:915f with SMTP id r10-20020a2eb60a000000b002b6c8e8915fmr525303ljn.22.1689788959378;
        Wed, 19 Jul 2023 10:49:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGcoA3ayLgHeAmqmqFqjnQ7AOt3SyqJk7AsijJMopV3od5+bU+++6SyugmvMMgSvDsgJiIRg==
X-Received: by 2002:a2e:b60a:0:b0:2b6:c8e8:915f with SMTP id r10-20020a2eb60a000000b002b6c8e8915fmr525282ljn.22.1689788958986;
        Wed, 19 Jul 2023 10:49:18 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t13-20020a7bc3cd000000b003fc05b89e5bsm2165158wmj.34.2023.07.19.10.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 10:49:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v6 0/4] Allow disabling all native fbdev drivers and
 only keeping DRM emulation
In-Reply-To: <46d933f5-38e4-b46a-f94b-0e9a6e3b2e31@gmx.de>
References: <20230719081544.741051-1-javierm@redhat.com>
 <46d933f5-38e4-b46a-f94b-0e9a6e3b2e31@gmx.de>
Date:   Wed, 19 Jul 2023 19:49:17 +0200
Message-ID: <877cqvkd0i.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Deller <deller@gmx.de> writes:

Hello Helge,

> Hi Javier,
>
> On 7/19/23 10:15, Javier Martinez Canillas wrote:
>> This patch series splits the fbdev core support in two different Kconfig
>> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
>> be disabled, while still having the the core fbdev support needed for the
>
> One "the" too much.
> (correcting just because this is a cover letter)
>
>> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
>> disabling all fbdev drivers instead of having to be disabled individually.
>>
>> The reason for doing this is that now with simpledrm, there's no need for
>> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
>> now disable them. > But it would simplify the config a lot fo have a single
>> Kconfig symbol to disable all fbdev drivers.
>
> I suggest to rephrase this, e.g.:
> The reason for doing this is that with simpledrm, mainstream Linux distributions
> like Fedora, SUSE or Ubuntu can then more easily enable the DRM drivers only
> by switching off legacy fbdev drivers with one Kconfig option (e.g. for efifb or
> vesafb).
>
> (note: there are quite many other distributions, e.g. debian and the derivates,
> which still need the fbdev drivers for the various other architectures)
>

Right, I meant that there is no need anymore for the remaining fbdev
drivers that many distributions used to enable only to have fallback
fbcon/VT (like vesafb, efifb, simplefb, etc). But I'm OK with your
rephrasing and agree that's more accurate to cover all the distros.

>> I've built tested with possible combinations of CONFIG_FB, CONFIG_FB_CORE,
>> CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_DEVICE symbols set to 'y' or 'n'.
>>
>> Patch #1 moves the auxdisplay drivers to "Graphics support" Kconfig menu,
>> patch #2 moves the core fbdev Kconfig symbols to a separate Kconfig file,
>> patch #3 does the FB symbol split and introduces the FB_CORE symbol and
>> finally patch #4 makes the DRM symbol to select FB_CORE if the DRM fbdev
>> emualtion support was enabled.
>>
>> Since this series touches three subsystems (auxdisplay, fbdev and DRM),
>> I would like to merge it through DRM with the acks of these maintainers.
>
> Sure. Ack from me.
>
> The patch series look good otherwise. You may add:
> Acked-by: Helge Deller <deller@gmx.de>
>

Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

