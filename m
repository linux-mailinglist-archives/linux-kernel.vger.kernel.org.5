Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC77F0858
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 19:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjKSSdV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Nov 2023 13:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSSdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 13:33:19 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E427103
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 10:33:15 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a7b3d33663so41329117b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 10:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700418794; x=1701023594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Sgxs19g9ItwMLXCwSaFSmWY+3YFGqlRFFiHfPCTZTc=;
        b=D3csgkL70qT/IhxcFPUTFE3j9jiZXrYAibcDfE9eb4pdZvmIrfi9WK7KA6zUDFFrs9
         ceiRmjFcqUzvxEhcrmZk8nOhAMwYSE0LfsQgE3CqGx6La4BWIAl8EMlqRejwiN2Gi9IE
         edvYxknILWdZP5CXECQiNEzPzUILL8ELXLoAxxi53fHIWB64H2ncSkoYqYhhZvo28CXn
         NTMxdPdc3OzedjIW44l+OxknWZYSgh7ANbr5x2zqPviZ7koXTfcxSeUsfDTbWmHfMTmT
         0pegjd/j6haH89k0g+zgbo9jxtKxF988/jfmiYhSWcCi+JFEThJPyFB24/tN9ZZpWB4H
         fHew==
X-Gm-Message-State: AOJu0YzPiCYprzwyZlMj/IDlybjfIOt8z/2Fbo+OzVDd/ds11P4jiqPs
        3xFgSXRNm1EgbxgAbQaJp9MpzEn1HgK+XQ==
X-Google-Smtp-Source: AGHT+IHjTDYGhGU4Et9WmcwOpz/AAokSx6odJNLLbToZaVq+AlloAlQvtODu+geMt3H0djy1C633qQ==
X-Received: by 2002:a0d:f701:0:b0:5c8:c9af:3e01 with SMTP id h1-20020a0df701000000b005c8c9af3e01mr5914778ywf.42.1700418794081;
        Sun, 19 Nov 2023 10:33:14 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id c15-20020a81b54f000000b005ca607eb16fsm193934ywk.44.2023.11.19.10.33.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 10:33:13 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5c9d850a0dbso6297027b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 10:33:13 -0800 (PST)
X-Received: by 2002:a81:cb01:0:b0:5ca:9ca4:f412 with SMTP id
 q1-20020a81cb01000000b005ca9ca4f412mr97776ywi.43.1700418793512; Sun, 19 Nov
 2023 10:33:13 -0800 (PST)
MIME-Version: 1.0
References: <47a81d2e0e47b1715718779b6978a8b595cc7c5d.1700140609.git.geert@linux-m68k.org>
 <77c6gkquzq4sdtmrlko3lkxvcnipm2zfjem3kvhgslcellkefh@man7pbbzud47> <a9ade305-f90e-4250-a795-49ef4e29e0ac@xenosoft.de>
In-Reply-To: <a9ade305-f90e-4250-a795-49ef4e29e0ac@xenosoft.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 19 Nov 2023 19:33:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXtUYJmEharJhBXx7D=fA3mQxg6uMP2=4Qgi==2a+kVQw@mail.gmail.com>
Message-ID: <CAMuHMdXtUYJmEharJhBXx7D=fA3mQxg6uMP2=4Qgi==2a+kVQw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Add suppport for non-native buffer formats
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Darren Stevens <darren@stevens-zone.net>,
        Christian Zigotzky <info@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Sun, Nov 19, 2023 at 5:28 PM Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:
> On 16 November 2023 at 03:44 pm, Gerd Hoffmann wrote:
> > On Thu, Nov 16, 2023 at 02:16:54PM +0100, Geert Uytterhoeven wrote:
> >> When using virtgpu on a big-endian machine, e.g. powerpc QEMU:
> >>
> >>      virtio-pci 0000:00:02.0: [drm] *ERROR* fbdev: Failed to setup generic emulation (ret=-2)
> >>
> >> or m68k/virt:
> >>
> >>      virtio-mmio virtio-mmio.125: [drm] *ERROR* fbdev: Failed to setup generic emulation (ret=-2)
> >>
> >> and the graphical display fails to come up.
> >>
> >> Before, the call to drm_mode_addfb() caused a translation from a fourcc
> >> format (XR24) to a bpp/depth pair (32/24) to a potentially different fourcc
> >> format (BX24 on big-endian), due to the quirk processing in
> >> drm_driver_legacy_fb_format().  After, the original fourcc format (XR24)
> >> is passed unmodified.
> >>
> >> However, the virtgpu DRM driver supports only a single format for its
> >> main plane: DRM_FORMAT_HOST_XRGB8888, which is XR24 on little-endian,
> >> and BX24 on big-endian.  I.e. on big-endian, virtgpu does not support
> >> XR24, which is the default DRM format, and must be supported by all
> >> drivers.  Before, this was reported, but didn't lead to a failure:
> >>
> >>      virtio-mmio virtio-mmio.125: [drm] bpp/depth value of 32/24 not supported
> >>      virtio-mmio virtio-mmio.125: [drm] No compatible format found
> >>
> >> As the core virtgpu driver and device support both XR24 and BX24 on both
> >> little-endian and big-endian just fine, fix this extending the list of
> >> supported formats for main plane and cursor plane to XR24/BX24 resp.
> >> AR24/BA24.
> >>
> >> Fixes: 6ae2ff23aa43a0c4 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()")
> >> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> >> Closes: https://lore.kernel.org/r/c47fba21-3ae9-4021-9f4a-09c2670ebdbc@xenosoft.de
> >> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>
> The new patch works but I don't see the virtio-mouse-pci pointer
> anymore. I see the pointer with -device usb-tablet. Please check the
> second patch. I will use the first patch for the RC2 of kernel 6.7.

That's probably partially explained by commit 99748ab64fcc8578 ("drm:
virtio: fix virtio_gpu_cursor_formats"), which forced BA24 for the
cursor plane on big-endian, but unfortunately linked thread doesn't
contain the full picture.

Where is the default cursor format defined?
I see virtio_gpu_mode_dumb_create() still defaults to
DRM_FORMAT_HOST_XRGB8888.  However, that can't be the cause, as the
cursor formats require an alpha channel.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
