Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4787EE161
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbjKPNTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjKPNTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:19:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A361A5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700140740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2ioSvsdVC24BNs/tJ+ckjjBuQcpkPVhbaN7mfLUSmk=;
        b=gEFhBfNcCbMgIupKMmqeXxjaSPUFpcLPDVixjVMLqjV0z3sIehZ/K+KGSb65me9m+lmEyI
        Kr4RhuZia2JFhZbUgSQ6ILaahlrCQTXBl9E6gR1suQMKXtWUf5n4jl4/r8DOtFd4z0W7tH
        TMRG0UnEXLkp/wNIdVleTZEJfykAbS0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-4Ac5ghfxNkmykLeH5hX4bA-1; Thu, 16 Nov 2023 08:18:59 -0500
X-MC-Unique: 4Ac5ghfxNkmykLeH5hX4bA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40a5290e259so4447815e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140738; x=1700745538;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2ioSvsdVC24BNs/tJ+ckjjBuQcpkPVhbaN7mfLUSmk=;
        b=lhOV165EPgifon3X/hRgaB7a/jXOOBewEnr4HLwlyIhWhAx0xqtztYIy4u/s2aQUmE
         UpROX92q91HoLccVZiTRWKbpwwknzVxo6DXxVNGr2UeuDho+TJ48Gpiw9NoYMUUxTY1r
         iJ0aeirwIvxxRF/MxJ47hbkbmxzc8EjAQolCPOTnkgRYWE0vR3j0UUpwI69rudBoxDau
         nXDTjNn6LXxlLKwR9iQXgRKx3U19as/rehh5xpcZEJJORWxl53wz+jC2gSRgDyUDYMZs
         6Gpuf75vao1SSE/M655wmw/x1J9njJDsL0KTPLf7wdmk8+BZnyIBIL2imTEZpIRhAUAO
         rVyA==
X-Gm-Message-State: AOJu0Yzfvrqc8iWQ3n+zNpUW7Y1yO7auSwGL9eXneMwA58TtETi/cM2s
        wgfwzDFrPIkydYeSuKxR9c04GHpP95x6XDNoIsgeDu5jT7sfVV41xAyEUulTv9RDcksFNWa8YNw
        sHb+ffaa8OS5CNDk414mZ/0FB
X-Received: by 2002:a05:6000:186b:b0:32d:9b3d:4f69 with SMTP id d11-20020a056000186b00b0032d9b3d4f69mr15354765wri.64.1700140737931;
        Thu, 16 Nov 2023 05:18:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZePSLm6805MffvvwhDpaaQKx0BMg13ekmNTxyFySFKHK0WR1spvD11gT9iZCxRQtve/mI9g==
X-Received: by 2002:a05:6000:186b:b0:32d:9b3d:4f69 with SMTP id d11-20020a056000186b00b0032d9b3d4f69mr15354743wri.64.1700140737613;
        Thu, 16 Nov 2023 05:18:57 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g26-20020adfa49a000000b0030647449730sm13748332wrb.74.2023.11.16.05.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:18:57 -0800 (PST)
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
Subject: Re: [PATCH] drm/virtio: Add suppport for non-native
In-Reply-To: <282a31154172a78165912c832a09f6502515d139.1700140178.git.geert@linux-m68k.org>
References: <282a31154172a78165912c832a09f6502515d139.1700140178.git.geert@linux-m68k.org>
Date:   Thu, 16 Nov 2023 14:18:56 +0100
Message-ID: <87wmuh25vj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

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

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

