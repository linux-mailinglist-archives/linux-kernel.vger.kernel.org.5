Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B307537C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbjGNKRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbjGNKRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD733AB9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689329783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgsO0LIwFs+B/IpMLrCbpX0oHYjYTeHY2o/wR8hTZgM=;
        b=TFNfsQT3TF1bFr/VEqqwr8z9+pKtHImbIxNvrctWComU8ju3SNyJxV++BbPECS0xuoKf4L
        3pPcU1oxAO83Yc2qTQgQ4eNCDP+aG+kuExEzMlG00WWme1rhvsWVMRcYZq99pmU0M9h3rk
        33yTan7f6maWLR3J/0u21DY8NZEm4Gs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-yKZaCAX5M4auamfUeF4uBA-1; Fri, 14 Jul 2023 06:16:22 -0400
X-MC-Unique: yKZaCAX5M4auamfUeF4uBA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso1025866f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329781; x=1691921781;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgsO0LIwFs+B/IpMLrCbpX0oHYjYTeHY2o/wR8hTZgM=;
        b=RqGTKDE4eZG3q35s4PCA54iYVb+9Ak+qL9RGeHifciHY2GK5kNSb1pLNaKLUt6VKGf
         GNJU4SHfaYz2ftvs5XiY5P28buD8h2FDO6cDPO2KG1a+T2/RkD9+uizSM5VgtmefpMYJ
         L8Xb+fIe+2Vbv4A+QmGMQ67bqjE/RNZoAmDC1wTgAKugc71yv0/mQyOv1UJJvSXqB/Xd
         tK8W5+WSew9kucsB0lMXF7blw01m7pbdlPV5rvRMJP1YWRwpxHp/XtyF9mFnyuA18FUn
         mWzWl+SBjhBb3tkYz4G7Qj7DGDGtxEIaizBltPY2vS/1wbkT9x99DWfdqoxzoIvGKIU3
         drkQ==
X-Gm-Message-State: ABy/qLZ9WOC2dpAtWgLT32oe+enbmRPzzXQiAeVunqzfyIXiY0/n2xyT
        h7KuvkAZpmnsp94HHJXsqVo9myaTpPLjLYJj/BNT5BKoVwVFkD8zT7jMlq08DFavx6HiLh7jVeW
        eCTlTb5wJku0huxelHaUC/UBh
X-Received: by 2002:adf:e58e:0:b0:315:a773:394b with SMTP id l14-20020adfe58e000000b00315a773394bmr3559366wrm.53.1689329781189;
        Fri, 14 Jul 2023 03:16:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF0HtgY6sDDD86tg8fCCTMHAGpwz2OXVfooT8l8cpyZ4ClOcAcJV3byx1AlvhsmA2qwNg6c+g==
X-Received: by 2002:adf:e58e:0:b0:315:a773:394b with SMTP id l14-20020adfe58e000000b00315a773394bmr3559356wrm.53.1689329780953;
        Fri, 14 Jul 2023 03:16:20 -0700 (PDT)
Received: from localhost ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4641000000b0031434936f0dsm10378831wrs.68.2023.07.14.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:16:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/8] drm/client: Convert drm_mode_create_dumb() to
 drm_mode_addfb2()
In-Reply-To: <9090c1b423e0b56c8e906155fe53ff0841830a03.1689252746.git.geert@linux-m68k.org>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <9090c1b423e0b56c8e906155fe53ff0841830a03.1689252746.git.geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 12:16:19 +0200
Message-ID: <87fs5qu7bg.fsf@minerva.mail-host-address-is-not-set>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Currently drm_client_buffer_addfb() uses the legacy drm_mode_addfb(),
> which uses bpp and depth to guess the wanted buffer format.
> However, drm_client_buffer_addfb() already knows the exact buffer
> format, so there is no need to convert back and forth between buffer
> format and bpp/depth, and the function can just call drm_mode_addfb2()
> directly instead.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/gpu/drm/drm_client.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>

Nice cleanup!

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

