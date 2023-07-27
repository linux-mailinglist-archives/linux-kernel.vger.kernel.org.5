Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615C1765593
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjG0OJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjG0OJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BDE113
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690466889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WLo0so7vSQCz5mSuOt/gGcMJDALTX0TGumAYHbwwbM=;
        b=SrrCbuSCJqwmS292AstCY3N0wYGqzH0DBbNj2FPaznPgluE25pZkqgvUQk680enwdCqCGY
        DDQH9ZchEE5pLsqAnJSDcUknwkL4++SduIILZ79etnVurV6nOAtz/xfIEO6XA+rRnBH9Hy
        Zg8WeIyuPfxZ8BlUFEA+m+K25KoWDGA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-DNQSNf46P4eHIpeB7ZrUUQ-1; Thu, 27 Jul 2023 10:08:04 -0400
X-MC-Unique: DNQSNf46P4eHIpeB7ZrUUQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fd2209bde4so5513035e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690466881; x=1691071681;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WLo0so7vSQCz5mSuOt/gGcMJDALTX0TGumAYHbwwbM=;
        b=DzkEUAOMPre1Qj2bCiTTnuaqbSnPzIORk1jrZtUIpa7dQgYIZpaZ5K8D/0XeZiLs5q
         rSSda8MPPaCY5ue7/8EpZHTbkCBIXmwLvKw2vj1lqpiW0/CzIG8NCql2XxvBzJqWsodW
         34jV6c5O9uH67fmBglo8g9iDCPzP57BExdnU9/tL6oJLLr3IzSduf1JtTSM9oT3g8uk1
         6rndIqJdZGpigKeoymlSYtQcfNzimKGCfIp+mQV+28eKwXLzo1gFdGl2vge1akDY7WxH
         DDfKJxYbvHj61B14I22zeLPUf0qo0XC7JP9OVMWH8O9qy052xTOsviyGKZT9YDOmWWs4
         KX4w==
X-Gm-Message-State: ABy/qLaJQoH1LDK1HKZhSe6cD21+ucoXBV6tudnl95QaUAtcSZsZYuuT
        z6s4rBtqlmIdEDkcU+9ZOpVEUCfC/L58G0aneprVu67VwL/TKcOJwK9OjHuGAvGt5jlkyFW67dj
        NfXxvY4UtIoPS6aD2LeaYOCmz
X-Received: by 2002:a7b:c045:0:b0:3fd:2e89:31e2 with SMTP id u5-20020a7bc045000000b003fd2e8931e2mr1692231wmc.17.1690466881143;
        Thu, 27 Jul 2023 07:08:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEV4jneiKEDe4OaGdTfTAZLv22Oiu/PKHqjOR7jaehWNQxZnNwS/CxlRa0KaMfxPmaLk2kZkg==
X-Received: by 2002:a7b:c045:0:b0:3fd:2e89:31e2 with SMTP id u5-20020a7bc045000000b003fd2e8931e2mr1692218wmc.17.1690466880849;
        Thu, 27 Jul 2023 07:08:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c0b4300b003fc015ae1e1sm1961597wmr.3.2023.07.27.07.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:08:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ssd130x: drop DRM_GEM_SHADOW_PLANE_FUNCS override
In-Reply-To: <20230727122412.2464210-1-arnd@kernel.org>
References: <20230727122412.2464210-1-arnd@kernel.org>
Date:   Thu, 27 Jul 2023 16:07:59 +0200
Message-ID: <874jlpv45c.fsf@minerva.mail-host-address-is-not-set>
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

Arnd Bergmann <arnd@kernel.org> writes:

Hello Arnd,

Thanks a lot for your patch.

> From: Arnd Bergmann <arnd@arndb.de>
>
> It is not possible for ssd130x_primary_plane_funcs to use both
> its own reset/duplicate/destroy callbacks and the ones from
> DRM_GEM_SHADOW_PLANE_FUNCS:
>
> In file included from drivers/gpu/drm/solomon/ssd130x.c:29:
> include/drm/drm_gem_atomic_helper.h:100:18: error: initialized field overwritten [-Werror=override-init]
>   100 |         .reset = drm_gem_reset_shadow_plane, \
>   101 |         .atomic_duplicate_state = drm_gem_duplicate_shadow_plane_state, \
>   102 |         .atomic_destroy_state = drm_gem_destroy_shadow_plane_state
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/solomon/ssd130x.c:744:9: note: in expansion of macro 'DRM_GEM_SHADOW_PLANE_FUNCS'
>   744 |         DRM_GEM_SHADOW_PLANE_FUNCS,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>

Gah, I missed that. I wonder how this compile warning doesn't show up for me.

> Since the custom callbacks were just added, I assume these are the
> ones it is meant to use, so remvoe the generic overrides.
>
> Fixes: 45b58669e532b ("drm/ssd130x: Allocate buffer in the plane's .atomic_check() callback")

Unfortunately that's not enough, because the plane atomic state handlers
that were introduced in that commit are broken so removing the macro will
regress the driver.

I've posted a patch that drops the macro but also fixes the handlers for
the driver to work with the custom callbacks:

https://lists.freedesktop.org/archives/dri-devel/2023-July/415897.html

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

