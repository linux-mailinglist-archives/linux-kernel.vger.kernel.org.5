Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B9B752349
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjGMNSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjGMNRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:17:32 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2DC2711
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:17:25 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6264:77e5:42e2:477d])
        by laurent.telenet-ops.be with bizsmtp
        id LdHN2A00R3wy6xv01dHNpa; Thu, 13 Jul 2023 15:17:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qJwC3-001Gqu-1Z;
        Thu, 13 Jul 2023 15:17:22 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qJwCA-00GWyd-No;
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
Subject: [PATCH/RFC 3/8] drm/ssd130x: Bail out early if data_array is not yet available
Date:   Thu, 13 Jul 2023 15:17:11 +0200
Message-Id: <c1030f3a445ee130c6a582fe10431c90018278e5.1689252746.git.geert@linux-m68k.org>
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

Calling ssd130x_buf_alloc() from ssd130x_encoder_helper_atomic_enable()
is too late, causing a NULL pointer dereference:

    ssd130x_update_rect.isra.0+0x13c/0x340
    ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
    drm_atomic_helper_commit_planes+0xfc/0x27c

Work around that by checking if data_array is valid.

Obviously this needs a better fix...

Fixes: 49d7d581ceaf4cf8 ("drm/ssd130x: Don't allocate buffers on each plane update")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/gpu/drm/solomon/ssd130x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index b4c376962629580b..8ef5f61854fd7340 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -481,6 +481,7 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x, struct drm_rect *
 	u32 array_idx = 0;
 	int ret, i, j, k;
 
+if (!data_array) { pr_info("%s: data_array not yet initialized\n", __func__); return 0; }
 	drm_WARN_ONCE(drm, y % 8 != 0, "y must be aligned to screen page\n");
 
 	/*
-- 
2.34.1

