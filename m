Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A955176696F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjG1Jyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbjG1Jye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D93598
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690538022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bXp6qs20yFk9EnCdEdqi8l6MUy4tyubsvE/mVKYrLNU=;
        b=N7GSLRKDGUyBU+eCCt92kwaYVWa3l8GHtS9cZLH0QDtG2cdevGWx0xGG/7lAE4AbtdhAvW
        PHayvgHIrSiN0ovfGPNetT3CjAl6aYSVb33BoK2vjGO7Calq3B1RzurOmFjrq1twlDrNId
        /BY89BTTxdH1sFAgHvxdt4uc1rAQ2d0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-dhVZPscBNkqqBF-9BWMpKA-1; Fri, 28 Jul 2023 05:53:39 -0400
X-MC-Unique: dhVZPscBNkqqBF-9BWMpKA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-315998d6e7fso980017f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690538018; x=1691142818;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXp6qs20yFk9EnCdEdqi8l6MUy4tyubsvE/mVKYrLNU=;
        b=VE2VKqmheE6EY5FQskd1jQfTgZtkGvlBDYi2fXevUASr8wxY8QP8kxCaN3GDc2oPUq
         bXrHT4j8jWUY0zUw/pYLZCScLjjq+luFModPcutsOhqgj9eQkAV43q2Zc53tFDF1v4gN
         IG+U26IbsReG7QhxJxRu08fECQILFImRvfMTbMDZGO45s3p/IJQjEd4OyZdmwGc3LPUq
         k+peIxrUXpuQylkBrn85SkMLRfCVVi38HfM9NsTK5L4PbBxeAvozaTRcJ49gH3+V32iG
         2EyD2gAOWk8+fxNlQ8R0fQZVNtJX28yT7jQbEqYSdKfrD9O+MTcQOP9YrHGDSQ3xXJWy
         0DNw==
X-Gm-Message-State: ABy/qLYemOoNcYe8+zzeOxD2Tr1H64FztR9lm5Hn6VGXvnpeLUfXA34q
        fzZyvnFjD0taCVdGQmnXJNh9JGDiNK7/q1zm8dA2Kz0bZs/wU9b2w5Rh/nj/GL6EWVH2cG04xOP
        kormGETy2c8i/VVkziMvmcnjq
X-Received: by 2002:a5d:60c3:0:b0:317:708e:1c29 with SMTP id x3-20020a5d60c3000000b00317708e1c29mr1393977wrt.40.1690538018141;
        Fri, 28 Jul 2023 02:53:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGHdh4k9+XqI2M+biACVcTzpApaOdCFQjcSh7sREZeHXtgOn2EBmD38pGCEOnj4stb3RQNh+g==
X-Received: by 2002:a5d:60c3:0:b0:317:708e:1c29 with SMTP id x3-20020a5d60c3000000b00317708e1c29mr1393966wrt.40.1690538017820;
        Fri, 28 Jul 2023 02:53:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r5-20020a056000014500b00314367cf43asm4294848wrx.106.2023.07.28.02.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 02:53:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/atomic-helper: Update reference to
 drm_crtc_force_disable_all()
In-Reply-To: <b8c9c1a8a05dbf0be8e8be98cfdeafa9cecd8cef.1690535002.git.geert+renesas@glider.be>
References: <b8c9c1a8a05dbf0be8e8be98cfdeafa9cecd8cef.1690535002.git.geert+renesas@glider.be>
Date:   Fri, 28 Jul 2023 11:53:36 +0200
Message-ID: <87pm4ctl9b.fsf@minerva.mail-host-address-is-not-set>
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

Geert Uytterhoeven <geert+renesas@glider.be> writes:

Hello Geert,

> drm_crtc_force_disable_all() was renamed to
> drm_helper_force_disable_all(), but one reference was not updated.
>
> Fixes: c2d88e06bcb98540 ("drm: Move the legacy kms disable_all helper to crtc helpers")

The dim tool complains that:

-:10: WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")'

So I've fixed it locally to only use the first 12 chars of the sha1.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

