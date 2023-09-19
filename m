Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0634C7A66B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjISO3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjISO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:28:59 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E6083;
        Tue, 19 Sep 2023 07:28:53 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59c0442a359so47404967b3.0;
        Tue, 19 Sep 2023 07:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695133733; x=1695738533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNgTqTzP+DNN14ddNBvAXkG8Xk8uIXpLMonsvHM2PZ8=;
        b=iKvOUPDGVN5qjIjNiyP6eBzuk1pQLw67QOLK6Q42YivxG5kLD4e7BdaRXCg5mqrtRr
         CDCTCuN0LRWigD7WzRjuB+/W+jLCBoX1nGlP+ybwbzcHlCeYnUB80YJ/LtcHUaYtTc2H
         xEWSUX3m2/O9YX4Fum/O1MsBRzXpF1F3ERX81B2zu8NaIxeKqgRJkQ5x2KzQ6cznghm9
         ylSHkJUqRI3/VcG1hd+sU0MXhuV/budotCyzNxLU/Wbq94kq9PkU/MirJ3JHjloUeMBy
         YVjN1/ERqDsegkVSxjGxXqU6Fa/Q7Shd2D7FvhUlrk1+LNNkXJ2eEDmc/nhgg+h5Q1e0
         IidQ==
X-Gm-Message-State: AOJu0Yw4zMXuJdrlypW2EWHUtg/KGEQNBA9YJ6YzF+V59n4/Nksm4qNr
        RUTuwbwqKZDK2rRj+6+v5yzrvPGsG4va6w==
X-Google-Smtp-Source: AGHT+IFd8EGQV1UhOdqlmUWGRB6s1pdn+29TFWdHxxHXO28ng5ZIz0O5zlg6xBijGR3h8GufKae4Bg==
X-Received: by 2002:a81:4e84:0:b0:581:2887:22be with SMTP id c126-20020a814e84000000b00581288722bemr12982128ywb.37.1695133732650;
        Tue, 19 Sep 2023 07:28:52 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id w135-20020a81498d000000b00577139f85dfsm3181704ywa.22.2023.09.19.07.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 07:28:52 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d81adf0d57fso4762935276.1;
        Tue, 19 Sep 2023 07:28:51 -0700 (PDT)
X-Received: by 2002:a25:ac84:0:b0:d7b:9bd7:f280 with SMTP id
 x4-20020a25ac84000000b00d7b9bd7f280mr12340757ybi.0.1695133731633; Tue, 19 Sep
 2023 07:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694767208.git.geert+renesas@glider.be>
In-Reply-To: <cover.1694767208.git.geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 16:28:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfBTKdXvZutg4LvWqBjuz-X=ZjzX0LKPqD=JxYuLoPRw@mail.gmail.com>
Message-ID: <CAMuHMdWfBTKdXvZutg4LvWqBjuz-X=ZjzX0LKPqD=JxYuLoPRw@mail.gmail.com>
Subject: [GIT PULL] drm: renesas: shmobile: Atomic conversion + DT support
 (was: Re: [PATCH v4 00/41] drm: renesas: shmobile: Atomic conversion + DT support)
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Daniel,

The following changes since commit 0663e1da5ba8e6459e3555ac12c62741668c0d30:

  drm/dp_mst: Tune down error message during payload addition
(2023-09-18 16:38:21 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
tags/shmob-drm-atomic-dt-tag1

for you to fetch changes up to bfea0fa9052aa8d235b24957eb84d9ff20cb87b7:

  drm: renesas: shmobile: Add DT support (2023-09-19 15:58:04 +0200)

----------------------------------------------------------------
drm: renesas: shmobile: Atomic conversion + DT support

Currently, there are two drivers for the LCD controller on Renesas
SuperH-based and ARM-based SH-Mobile and R-Mobile SoCs:
  1. sh_mobile_lcdcfb, using the fbdev framework,
  2. shmob_drm, using the DRM framework.
However, only the former driver is used, as all platform support
integrates the former.  None of these drivers support DT-based systems.

Convert the SH-Mobile DRM driver to atomic modesetting, and add DT
support, complemented by the customary set of fixes and improvements.

Link: https://lore.kernel.org/r/cover.1694767208.git.geert+renesas@glider.be/

This PR is based on today's drm-misc/for-linux-next, to avoid a
conflict with commit 775b0669e19f2e4a ("drm/shmobile: Convert to
platform remove callback returning void") in drm-misc/for-linux-next
.
Thanks for pulling!
----------------------------------------------------------------
Geert Uytterhoeven (36):
      MAINTAINER: Create entry for Renesas SH-Mobile DRM drivers
      dt-bindings: display: Add Renesas SH-Mobile LCDC bindings
      media: uapi: Add MEDIA_BUS_FMT_RGB666_2X9_BE format
      drm: renesas: shmobile: Fix overlay plane disable
      drm: renesas: shmobile: Fix ARGB32 overlay format typo
      drm: renesas: shmobile: Correct encoder/connector types
      drm: renesas: shmobile: Add support for Runtime PM
      drm: renesas: shmobile: Restore indentation of shmob_drm_setup_clocks()
      drm: renesas: shmobile: Use %p4cc to print fourcc code
      drm: renesas: shmobile: Add missing YCbCr formats
      drm: renesas: shmobile: Improve shmob_drm_format_info table
      drm: renesas: shmobile: Improve error handling
      drm: renesas: shmobile: Convert to use devm_request_irq()
      drm: renesas: shmobile: Remove custom plane destroy callback
      drm: renesas: shmobile: Use drmm_universal_plane_alloc()
      drm: renesas: shmobile: Embed drm_device in shmob_drm_device
      drm: renesas: shmobile: Convert container helpers to static
inline functions
      drm: renesas: shmobile: Replace .dev_private with container_of()
      drm: renesas: shmobile: Use media bus formats in platform data
      drm: renesas: shmobile: Move interface handling to connector setup
      drm: renesas: shmobile: Unify plane allocation
      drm: renesas: shmobile: Rename shmob_drm_crtc.crtc
      drm: renesas: shmobile: Rename shmob_drm_connector.connector
      drm: renesas: shmobile: Rename shmob_drm_plane.plane
      drm: renesas: shmobile: Use drm_crtc_handle_vblank()
      drm: renesas: shmobile: Move shmob_drm_crtc_finish_page_flip()
      drm: renesas: shmobile: Wait for page flip when turning CRTC off
      drm: renesas: shmobile: Turn vblank on/off when enabling/disabling CRTC
      drm: renesas: shmobile: Shutdown the display on remove
      drm: renesas: shmobile: Cleanup encoder
      drm: renesas: shmobile: Atomic conversion part 1
      drm: renesas: shmobile: Atomic conversion part 2
      drm: renesas: shmobile: Use suspend/resume helpers
      drm: renesas: shmobile: Remove internal CRTC state tracking
      drm: renesas: shmobile: Atomic conversion part 3
      drm: renesas: shmobile: Add DT support

Laurent Pinchart (5):
      drm: renesas: shmobile: Remove backlight support
      drm: renesas: shmobile: Don't set display info width and height twice
      drm: renesas: shmobile: Rename input clocks
      drm: renesas: shmobile: Remove support for SYS panels
      drm: renesas: shmobile: Use struct videomode in platform data

 .../bindings/display/renesas,shmobile-lcdc.yaml    | 130 +++++
 .../userspace-api/media/v4l/subdev-formats.rst     |  72 +++
 MAINTAINERS                                        |  13 +-
 drivers/gpu/drm/renesas/shmobile/Kconfig           |   3 +-
 drivers/gpu/drm/renesas/shmobile/Makefile          |   3 +-
 .../gpu/drm/renesas/shmobile/shmob_drm_backlight.c |  82 ---
 .../gpu/drm/renesas/shmobile/shmob_drm_backlight.h |  19 -
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  | 650 +++++++++------------
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h  |  27 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c   | 179 +++---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h   |  18 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c   |  77 ++-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.h   |   9 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c | 326 ++++++-----
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.h |   5 +-
 include/linux/platform_data/shmob_drm.h            |  57 +-
 include/uapi/linux/media-bus-format.h              |   3 +-
 17 files changed, 860 insertions(+), 813 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
 delete mode 100644 drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.c
 delete mode 100644 drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.h

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
