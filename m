Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DF576814E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 21:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjG2TZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 15:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG2TZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 15:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB101FC9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690658683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hskAr6TIw8osCLe/1nFX1sSnSNJhm4rVeuFgy4UI0XE=;
        b=Z/kSuqMn7XKTGNiW8aLI8+c+q+vGSpKnIxWe1CWhCpbs/JScn34DFPdYOfcnx/tvZfzPbw
        GKCk7EUIXS90S2OTDX88ZRT3MbmSiKQb5XVZpaZWhqXGriUU1XbKfGjnwYKUS5pdBSBfss
        QGD5kzM8AXvFe5hPyGYhEYwUKCahMPw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-cm0oiErvNm6JYiQjH0B5fg-1; Sat, 29 Jul 2023 15:24:42 -0400
X-MC-Unique: cm0oiErvNm6JYiQjH0B5fg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-314256aedcbso1649577f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 12:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690658680; x=1691263480;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hskAr6TIw8osCLe/1nFX1sSnSNJhm4rVeuFgy4UI0XE=;
        b=I0mOZtMRbbPPgJ3tfGjzR9X/VJHoZwNgsKqfCvXireDoD/APspCzukyKQOIswYdc7m
         aacwhdiIoJrWpc7mHWmPNy+VEl0xc0YSDe2pUyPyQYmWggF3+sXnc1U1l9dqBGw5++t7
         b6ALYddPoBroal8/ZRwrSY8XqkFVcGo11ltNTDfvLmGu9zomSdRz8enPKR/QqgtypF/T
         97TCmJ/2BXol8gNLbszzoNn8RKCt9VsA9k6GUhvM44xyRMQjznsbXHVItjJM0GqRJIIJ
         iRGdck7ix4jDL9YiElooF61041PpYLdY2f6gP9BmzWH10m2hyWEJVh9JEuKdqVOTewes
         wtug==
X-Gm-Message-State: ABy/qLZ5qALKJ6ITkJfLCAumvlvvdScvUckGgaU1R3JieCmEAeV1YuMn
        KP3YfE+cdvfh3eHV5R8TjrTEi1nDY2MFZRAfF2PZ9muamsYTJpWIfs5SThKoRDCzgy2gnFikPN9
        AuygqCIxJtPPbxSdFHI34i1V52ev/848A
X-Received: by 2002:a5d:50cf:0:b0:317:7068:4997 with SMTP id f15-20020a5d50cf000000b0031770684997mr4078884wrt.60.1690658680747;
        Sat, 29 Jul 2023 12:24:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGF9+BR0YBluc/fmTt4zwqTslYE7jm872eX8+d+/+3kkajFyZw/n5oyrZ7FmTRawifJ0nHRmg==
X-Received: by 2002:a5d:50cf:0:b0:317:7068:4997 with SMTP id f15-20020a5d50cf000000b0031770684997mr4078879wrt.60.1690658680474;
        Sat, 29 Jul 2023 12:24:40 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g17-20020adfe411000000b0031437299fafsm8234533wrm.34.2023.07.29.12.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 12:24:40 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 5/5] drm/repaper: Reduce temporary buffer size in
 repaper_fb_dirty()
In-Reply-To: <20220317081830.1211400-6-geert@linux-m68k.org>
References: <20220317081830.1211400-1-geert@linux-m68k.org>
 <20220317081830.1211400-6-geert@linux-m68k.org>
Date:   Sat, 29 Jul 2023 21:24:39 +0200
Message-ID: <87v8e2wmfc.fsf@minerva.mail-host-address-is-not-set>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> As the temporary buffer is no longer used to store 8-bit grayscale data,
> its size can be reduced to the size needed to store the monochrome
> bitmap data.
>
> Fixes: 24c6bedefbe71de9 ("drm/repaper: Use format helper for xrgb8888 to monochrome conversion")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

