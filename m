Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E67873B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbjHXPJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242155AbjHXPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:09:00 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EA519B7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:08:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3c6b:f703:5ab5:f36d])
        by baptiste.telenet-ops.be with bizsmtp
        id dT8t2A00A01sfPQ01T8tZX; Thu, 24 Aug 2023 17:08:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qZBwx-001dhM-Hn;
        Thu, 24 Aug 2023 17:08:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qZBx7-000Vz0-77;
        Thu, 24 Aug 2023 17:08:53 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 5/8] drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()
Date:   Thu, 24 Aug 2023 17:08:43 +0200
Message-Id: <50762fd1694d3b5f6df1bdfa482564adb2ee7f36.1692888745.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692888745.git.geert@linux-m68k.org>
References: <cover.1692888745.git.geert@linux-m68k.org>
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
v2:
  - Add Reviewed-by, Tested-by,
  - s/drm_mode_create_dumb/drm_client_buffer_addfb/ in one-line summary.
---
 drivers/gpu/drm/drm_client.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index 037e36f2049c1793..0ced189befebae12 100644
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

