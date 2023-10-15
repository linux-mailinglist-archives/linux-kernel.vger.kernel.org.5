Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06D07C9997
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjJOO1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 10:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 10:27:11 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A8BA3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 07:27:09 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:441e:d899:20f9:b692])
        by xavier.telenet-ops.be with bizsmtp
        id yET62A00B0qPBYQ01ET6N8; Sun, 15 Oct 2023 16:27:07 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qs258-006eyF-Ll;
        Sun, 15 Oct 2023 16:27:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qs25C-002gOf-1v;
        Sun, 15 Oct 2023 16:27:06 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3] drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()
Date:   Sun, 15 Oct 2023 16:27:04 +0200
Message-Id: <4b84adfc686288714e69d0442d22f1259ff74903.1697379891.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently drm_client_buffer_addfb() uses the legacy drm_mode_addfb(),
which uses bpp and depth to guess the wanted buffer format.
However, drm_client_buffer_addfb() already knows the exact buffer
format, so there is no need to convert back and forth between buffer
format and bpp/depth, and the function can just call drm_mode_addfb2()
directly instead.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Javier Martinez Canillas <javierm@redhat.com>
---
v3:
  - Extract from series "[PATCH v2 0/8] drm: fb-helper/ssd130x: Add
    support for DRM_FORMAT_R1"
    (https://lore.kernel.org/all/cover.1692888745.git.geert@linux-m68k.org),
    as this patch has merits on its own,
v2:
  - Add Reviewed-by, Tested-by,
  - s/drm_mode_create_dumb/drm_client_buffer_addfb/ in one-line summary.
---
 drivers/gpu/drm/drm_client.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index d4296440f297fc5a..a780832a0963fe38 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -395,19 +395,16 @@ static int drm_client_buffer_addfb(struct drm_client_buffer *buffer,
 				   u32 handle)
 {
 	struct drm_client_dev *client = buffer->client;
-	struct drm_mode_fb_cmd fb_req = { };
-	const struct drm_format_info *info;
+	struct drm_mode_fb_cmd2 fb_req = { };
 	int ret;
 
-	info = drm_format_info(format);
-	fb_req.bpp = drm_format_info_bpp(info, 0);
-	fb_req.depth = info->depth;
 	fb_req.width = width;
 	fb_req.height = height;
-	fb_req.handle = handle;
-	fb_req.pitch = buffer->pitch;
+	fb_req.pixel_format = format;
+	fb_req.handles[0] = handle;
+	fb_req.pitches[0] = buffer->pitch;
 
-	ret = drm_mode_addfb(client->dev, &fb_req, client->file);
+	ret = drm_mode_addfb2(client->dev, &fb_req, client->file);
 	if (ret)
 		return ret;
 
-- 
2.34.1

