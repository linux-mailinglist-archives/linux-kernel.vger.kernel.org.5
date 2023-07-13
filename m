Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C681D752347
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjGMNRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbjGMNRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:17:31 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A01E270D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:17:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6264:77e5:42e2:477d])
        by michel.telenet-ops.be with bizsmtp
        id LdHN2A00Z3wy6xv06dHNad; Thu, 13 Jul 2023 15:17:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qJwC3-001Gqq-0u;
        Thu, 13 Jul 2023 15:17:22 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qJwCA-00GWyY-N9;
        Thu, 13 Jul 2023 15:17:22 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/8] drm/dumb-buffers: Fix drm_mode_create_dumb() for bpp < 8
Date:   Thu, 13 Jul 2023 15:17:10 +0200
Message-Id: <5ba8ac5e465121b646a59487dc75b27017e0c769.1689252746.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689252746.git.geert@linux-m68k.org>
References: <cover.1689252746.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_mode_create_dumb() calculates the number of characters per pixel
from the number of bits per pixel by rounding up, which is not correct
as the actual value of cpp may be non-integer.  While we do not need to
care here about complex formats like YUV, bpp < 8 is a valid use case.

  - The overflow check for the buffer width is not correct if bpp < 8.
    However, it doesn't hurt, as widths larger than U32_MAX / 8 should
    not happen for real anyway.  Add a comment to clarify.
  - Calculating the stride from the number of characters per pixel is
    not correct.  Fix this by calculating it from the number of bits per
    pixel instead.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Why is drm_mode_create_dumb.size __u64?  The test for "args->height >
U32_MAX / stride" rejects all sizes not fitting in __u32 anyway.
---
 drivers/gpu/drm/drm_dumb_buffers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
index 70032bba1c97e787..21a04c32a5e3d785 100644
--- a/drivers/gpu/drm/drm_dumb_buffers.c
+++ b/drivers/gpu/drm/drm_dumb_buffers.c
@@ -71,10 +71,11 @@ int drm_mode_create_dumb(struct drm_device *dev,
 	/* overflow checks for 32bit size calculations */
 	if (args->bpp > U32_MAX - 8)
 		return -EINVAL;
+	/* Incorrect (especially if bpp < 8), but doesn't hurt much */
 	cpp = DIV_ROUND_UP(args->bpp, 8);
 	if (cpp > U32_MAX / args->width)
 		return -EINVAL;
-	stride = cpp * args->width;
+	stride = DIV_ROUND_UP(args->bpp * args->width, 8);
 	if (args->height > U32_MAX / stride)
 		return -EINVAL;
 
-- 
2.34.1

