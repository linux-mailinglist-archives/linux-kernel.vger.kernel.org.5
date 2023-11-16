Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA387EE173
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345108AbjKPNWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjKPNWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:22:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB3919D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700140946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F7+iNGSwtyGLrsX7CmnTv6eFqLzHKXVfMpm2hsnu83o=;
        b=Qw6yEuULaPy07kX/aIEPSqiaMfA+dLAqDau2EUMVCY4K3+IhESoY48WgpgP/4z9P+vKseC
        FEZFw9LAKWvQNW4To/jsBvwQnWUx0OIKqci/jgFCtg1k5wsx/lDWNScV96OQlgRpSYLtui
        TR0l9cMTeO0mncXaAyZN9UZTovgUPvQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-rpzMvr8MOQ2aY1BZUMI_mg-1; Thu, 16 Nov 2023 08:22:22 -0500
X-MC-Unique: rpzMvr8MOQ2aY1BZUMI_mg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32f8371247fso430440f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140941; x=1700745741;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7+iNGSwtyGLrsX7CmnTv6eFqLzHKXVfMpm2hsnu83o=;
        b=j+WhSZ3UFGKp+NGBzXClvFLn6j4Rznnbn7Vaj5Ml4UrSTU3Mqyy4xb+pBHuzxdX3jE
         SBv4I6xVg/yfUfpa8L1Nv9ndeelRTxQ19B3nhKGgvhNWPigXO4EcBuFjxRjmreEFfgPQ
         e4ylc6zXbkdh7DE3w/YONMMmKzJ98m8TmfMJlcgBt2AundhwZzoHf7d5iTOdL0WFf8gv
         ujLSYr5az/U6iMJYzQC32O/3fIsT2l8quwxtMzuV7jOW3s8QHJm1aHETOvDh3jWYprH2
         3yV4uOhTGWsNTcZAqh4jVdrghzjuHiFwo5TFAoaHHt0B4JfFp4KoT+4hgAPbzt5LhDtL
         uTcA==
X-Gm-Message-State: AOJu0Yyi/fdPXgUKnjs0Z3L84cu3IE7KC4EbX6HGd6tsLCTSJF/GDFMr
        3V84cMid+5GbQ55hSBBUeN8rC+s0c3Xfqflug9SYUqgW0/ISGVkYQQYuYOxRkVqdlcFsmb/NB6G
        gVF9ZUKKjwiGVBwGVbqLiFUmX
X-Received: by 2002:a5d:5741:0:b0:32f:7db1:22f0 with SMTP id q1-20020a5d5741000000b0032f7db122f0mr10520046wrw.20.1700140941540;
        Thu, 16 Nov 2023 05:22:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFuK+UpxCjYuUwCxoI9MkGHUTPUyNvLFpUtkuAQkHfNvTxAFlBt0TzLY1alrl726JtxtyLtA==
X-Received: by 2002:a5d:5741:0:b0:32f:7db1:22f0 with SMTP id q1-20020a5d5741000000b0032f7db122f0mr10520027wrw.20.1700140941220;
        Thu, 16 Nov 2023 05:22:21 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q4-20020a056000136400b003233b554e6esm13556933wrz.85.2023.11.16.05.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:22:21 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        linux-m68k@lists.linux-m68k.org
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] drm/virtio: Add suppport for non-native buffer formats
In-Reply-To: <47a81d2e0e47b1715718779b6978a8b595cc7c5d.1700140609.git.geert@linux-m68k.org>
References: <47a81d2e0e47b1715718779b6978a8b595cc7c5d.1700140609.git.geert@linux-m68k.org>
Date:   Thu, 16 Nov 2023 14:22:20 +0100
Message-ID: <87ttpl25pv.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> When using virtgpu on a big-endian machine, e.g. powerpc QEMU:
>
>     virtio-pci 0000:00:02.0: [drm] *ERROR* fbdev: Failed to setup generic emulation (ret=-2)
>
> or m68k/virt:
>
>     virtio-mmio virtio-mmio.125: [drm] *ERROR* fbdev: Failed to setup generic emulation (ret=-2)
>
> and the graphical display fails to come up.
>
> Before, the call to drm_mode_addfb() caused a translation from a fourcc
> format (XR24) to a bpp/depth pair (32/24) to a potentially different fourcc
> format (BX24 on big-endian), due to the quirk processing in
> drm_driver_legacy_fb_format().  After, the original fourcc format (XR24)
> is passed unmodified.
>
> However, the virtgpu DRM driver supports only a single format for its
> main plane: DRM_FORMAT_HOST_XRGB8888, which is XR24 on little-endian,
> and BX24 on big-endian.  I.e. on big-endian, virtgpu does not support
> XR24, which is the default DRM format, and must be supported by all
> drivers.  Before, this was reported, but didn't lead to a failure:
>
>     virtio-mmio virtio-mmio.125: [drm] bpp/depth value of 32/24 not supported
>     virtio-mmio virtio-mmio.125: [drm] No compatible format found
>
> As the core virtgpu driver and device support both XR24 and BX24 on both
> little-endian and big-endian just fine, fix this extending the list of
> supported formats for main plane and cursor plane to XR24/BX24 resp.
> AR24/BA24.
>
> Fixes: 6ae2ff23aa43a0c4 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Closes: https://lore.kernel.org/r/c47fba21-3ae9-4021-9f4a-09c2670ebdbc@xenosoft.de
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Fix truncated one-line summary.
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

