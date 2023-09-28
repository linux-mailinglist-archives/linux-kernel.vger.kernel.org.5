Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524D67B1BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjI1MQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjI1MQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:16:27 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30D7136
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:16:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:e207:8adb:af22:7f1e])
        by laurent.telenet-ops.be with bizsmtp
        id rQGH2A00P3w8i7m01QGHJn; Thu, 28 Sep 2023 14:16:22 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qlpvt-004mR5-5A;
        Thu, 28 Sep 2023 14:16:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qlpwH-001OAd-JO;
        Thu, 28 Sep 2023 14:16:17 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] drm: Split drm_modeset_helper_vtables.h
Date:   Thu, 28 Sep 2023 14:16:10 +0200
Message-Id: <cover.1695903065.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

<drm/drm_modeset_helper_vtables.h> is the second largest header file in
the DRM subsystem, and declares helpers vtables for various DRM
components.  Several vtables contain methods with the same name, and all
but one vtable do not fit on the screen, making it hard to navigate to
the actual method one is interested in.

Hence this patch series splits <drm/drm_modeset_helper_vtables.h> in
multiple header files, one per DRM component, preceded by a few spelling
fix this to avoid checkpatch warnings.  A future patch could replace
inclusion of <drm/drm_modeset_helper_vtables.h> by inclusion of one or
more of the new files, to reduce compilation time.

I marked the last patch RFC, the first two patches can be applied
immediately.

Thanks for your comments!

Geert Uytterhoeven (3):
  drm: Spelling s/hardward/hardware/g
  drm: Spelling s/preceeding/preceding/g
  [RFC] drm: Split drm_modeset_helper_vtables.h

 drivers/gpu/drm/drm_atomic_helper.c         |    4 +-
 include/drm/drm_bridge.h                    |    2 +-
 include/drm/drm_connector_helper_vtable.h   |  364 +++++
 include/drm/drm_crtc_helper_vtable.h        |  483 ++++++
 include/drm/drm_encoder_helper_vtable.h     |  381 +++++
 include/drm/drm_mode_config_helper_vtable.h |   97 ++
 include/drm/drm_modeset_helper_vtables.h    | 1466 +------------------
 include/drm/drm_plane_helper_vtable.h       |  297 ++++
 8 files changed, 1630 insertions(+), 1464 deletions(-)
 create mode 100644 include/drm/drm_connector_helper_vtable.h
 create mode 100644 include/drm/drm_crtc_helper_vtable.h
 create mode 100644 include/drm/drm_encoder_helper_vtable.h
 create mode 100644 include/drm/drm_mode_config_helper_vtable.h
 create mode 100644 include/drm/drm_plane_helper_vtable.h

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
