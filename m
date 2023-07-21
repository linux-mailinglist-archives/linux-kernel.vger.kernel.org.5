Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC1B75C496
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjGUKYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjGUKXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:23:48 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF591722
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:23:44 -0700 (PDT)
Received: from localhost.ispras.ru (unknown [10.10.165.9])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1128940AE010;
        Fri, 21 Jul 2023 10:16:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1128940AE010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1689934605;
        bh=PHPNcQA/mlieAatBPZHyKEUg1u7Tlcm1+az9zlQDbY8=;
        h=From:To:Cc:Subject:Date:From;
        b=Z3wdixjAMd9W826oQ5ZAmSGo/4lDkslYNWkikcAg4mZdLItvN5NLoUWTxiBZFfvy1
         nhb/vpNqWUKZAAgrz+3p0pAObAE8DrE37IN7H+zaDDkBlc6ZNGX5pXop2AUPeQo3ZX
         9BvqC+gyILNsZn2iinXHztB9mHVFPBjGzqNUee8Q=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Stone <daniels@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] drm/crtc: do not release uninitialized connector reference
Date:   Fri, 21 Jul 2023 13:15:59 +0300
Message-ID: <20230721101600.4392-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside drm_mode_setcrtc() connector_set is allocated using kmalloc_array()
so its values are uninitialized. When filling this array with actual
pointers to drm connector objects, an error caused with invalid ioctl
request data may occur leading us to put references to already taken
objects. However, the last elements of the array are left uninitialized
which makes drm_connector_put() to be called with an invalid argument.

We can obviously just initialize the array with kcalloc() but the current
fix chose a slightly different way.

The index of failing array element is known so just put references to the
array members with lower indices.

The temporary 'connector' pointer seems to be redundant as we can directly
fill the connector_set elements and thus avoid unnecessary NULL
assignments and checks.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: b164d31f50b2 ("drm/modes: add connector reference counting. (v2)")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/gpu/drm/drm_crtc.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index df9bf3c9206e..2a29c3cf12de 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -709,7 +709,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	struct drm_mode_crtc *crtc_req = data;
 	struct drm_crtc *crtc;
 	struct drm_plane *plane;
-	struct drm_connector **connector_set = NULL, *connector;
+	struct drm_connector **connector_set = NULL;
 	struct drm_framebuffer *fb = NULL;
 	struct drm_display_mode *mode = NULL;
 	struct drm_mode_set set;
@@ -852,25 +852,22 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 		}
 
 		for (i = 0; i < crtc_req->count_connectors; i++) {
-			connector_set[i] = NULL;
 			set_connectors_ptr = (uint32_t __user *)(unsigned long)crtc_req->set_connectors_ptr;
 			if (get_user(out_id, &set_connectors_ptr[i])) {
 				ret = -EFAULT;
 				goto out;
 			}
 
-			connector = drm_connector_lookup(dev, file_priv, out_id);
-			if (!connector) {
+			connector_set[i] = drm_connector_lookup(dev, file_priv, out_id);
+			if (!connector_set[i]) {
 				DRM_DEBUG_KMS("Connector id %d unknown\n",
 						out_id);
 				ret = -ENOENT;
 				goto out;
 			}
 			DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
-					connector->base.id,
-					connector->name);
-
-			connector_set[i] = connector;
+					connector_set[i]->base.id,
+					connector_set[i]->name);
 		}
 	}
 
@@ -891,12 +888,9 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	if (fb)
 		drm_framebuffer_put(fb);
 
-	if (connector_set) {
-		for (i = 0; i < crtc_req->count_connectors; i++) {
-			if (connector_set[i])
-				drm_connector_put(connector_set[i]);
-		}
-	}
+	if (connector_set)
+		while (--i >= 0)
+			drm_connector_put(connector_set[i]);
 	kfree(connector_set);
 	drm_mode_destroy(dev, mode);
 
-- 
2.41.0

