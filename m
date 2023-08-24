Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735847873B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbjHXPJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242150AbjHXPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:08:59 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D9319B5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:08:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3c6b:f703:5ab5:f36d])
        by michel.telenet-ops.be with bizsmtp
        id dT8t2A00701sfPQ06T8tSB; Thu, 24 Aug 2023 17:08:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qZBwx-001dh9-Ep;
        Thu, 24 Aug 2023 17:08:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qZBx7-000Vyn-44;
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
Subject: [PATCH v2 2/8] drm/ssd130x: Fix screen clearing
Date:   Thu, 24 Aug 2023 17:08:40 +0200
Message-Id: <c19cd5a57205597bb38a446c3871092993498f01.1692888745.git.geert@linux-m68k.org>
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

Due to the reuse of buffers, ssd130x_clear_screen() no longers clears
the screen, but merely redraws the last image that is residing in the
intermediate buffer.

As there is no point in clearing the intermediate buffer and transposing
an all-black image, fix this by just clearing the HW format buffer, and
writing it to the panel.

Fixes: 49d7d581ceaf4cf8 ("drm/ssd130x: Don't allocate buffers on each plane update")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
ssd130x_clear_screen() is only called from
ssd130x_primary_plane_helper_atomic_disable(), but this never happens on
my system.

Tested by adding some extra calls to ssd130x_clear_screen() at regular
intervals.

v2:
  - New.
---
 drivers/gpu/drm/solomon/ssd130x.c | 47 +++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 5a80b228d18cae33..78272b1f9d5b167f 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -553,14 +553,45 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 static void ssd130x_clear_screen(struct ssd130x_device *ssd130x,
 				 struct ssd130x_plane_state *ssd130x_state)
 {
-	struct drm_rect fullscreen = {
-		.x1 = 0,
-		.x2 = ssd130x->width,
-		.y1 = 0,
-		.y2 = ssd130x->height,
-	};
-
-	ssd130x_update_rect(ssd130x, ssd130x_state, &fullscreen);
+	unsigned int page_height = ssd130x->device_info->page_height;
+	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
+	u8 *data_array = ssd130x_state->data_array;
+	unsigned int width = ssd130x->width;
+	int ret, i;
+
+	if (!ssd130x->page_address_mode) {
+		memset(data_array, 0, width * pages);
+
+		/* Set address range for horizontal addressing mode */
+		ret = ssd130x_set_col_range(ssd130x, ssd130x->col_offset, width);
+		if (ret < 0)
+			return;
+
+		ret = ssd130x_set_page_range(ssd130x, ssd130x->page_offset, pages);
+		if (ret < 0)
+			return;
+
+		/* Write out update in one go if we aren't using page addressing mode */
+		ssd130x_write_data(ssd130x, data_array, width * pages);
+	} else {
+		/*
+		 * In page addressing mode, the start address needs to be reset,
+		 * and each page then needs to be written out separately.
+		 */
+		memset(data_array, 0, width);
+
+		for (i = 0; i < pages; i++) {
+			ret = ssd130x_set_page_pos(ssd130x,
+						   ssd130x->page_offset + i,
+						   ssd130x->col_offset);
+			if (ret < 0)
+				return;
+
+			ret = ssd130x_write_data(ssd130x, data_array, width);
+			if (ret < 0)
+				return;
+		}
+	}
 }
 
 static int ssd130x_fb_blit_rect(struct drm_plane_state *state,
-- 
2.34.1

