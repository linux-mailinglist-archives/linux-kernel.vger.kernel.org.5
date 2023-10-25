Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF627D5F40
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjJYAyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjJYAxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:53:52 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0D128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2ipLywiKe03HXmSk3vSJ4s2gBzs/5qTiNVoKg2/Jy+Y=; b=nTYgai2REMNJ3OlVhUKnKdD1iG
        zk+dMfkoOYgieRo1YaXnehzQZlUM2zF+93yQDRttEtWnJF4Y/bMN1E8beo02QdM+dBM4CdtBxezde
        N8FPtcrNyFETLIZ0y9ymHDXai7wYfWgyt7UUeP5v9jPSg1dH1iYeJUlnxBZ05m2frv+t8YEx8Vn3Z
        SGeoHHrCxdorlOBcuehXtnc4ANFo4D6tDEtVHB7RKdHftEQ6FljlpQwtxbpnsOWSVy7fyYyj3k85t
        t5WBxr9ckQSqK5wGGYIfsiQbdS5HF52Yhu8ZA8C9iN5T1bCDDs4xPpH+JjzhCxeBNuiZmIiDqdL9H
        TzHPVquQ==;
Received: from [191.193.179.125] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qvS9a-006qog-Ty; Wed, 25 Oct 2023 02:53:47 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v8 4/6] drm: Refuse to async flip with atomic prop changes
Date:   Tue, 24 Oct 2023 21:53:16 -0300
Message-ID: <20231025005318.293690-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025005318.293690-1-andrealmeid@igalia.com>
References: <20231025005318.293690-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that prop changes may lead to modesetting, which would defeat the
fast path of the async flip, refuse any atomic prop change for async
flips in atomic API. The only exception is the framebuffer ID to flip
to. Currently the only plane type supported is the primary one.

Reviewed-by: Simon Ser <contact@emersion.fr>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v8: add a check for plane type, we can only flip primary planes
v7: drop the mode_id exception for prop changes
---
---
 drivers/gpu/drm/drm_atomic_uapi.c   | 54 +++++++++++++++++++++++++++--
 drivers/gpu/drm/drm_crtc_internal.h |  2 +-
 drivers/gpu/drm/drm_mode_object.c   |  2 +-
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index a15121e75a0a..ebaa6413d5a0 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1006,13 +1006,28 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
 	return ret;
 }
 
+static int drm_atomic_check_prop_changes(int ret, uint64_t old_val, uint64_t prop_value,
+					 struct drm_property *prop)
+{
+	if (ret != 0 || old_val != prop_value) {
+		drm_dbg_atomic(prop->dev,
+			       "[PROP:%d:%s] No prop can be changed during async flip\n",
+			       prop->base.id, prop->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int drm_atomic_set_property(struct drm_atomic_state *state,
 			    struct drm_file *file_priv,
 			    struct drm_mode_object *obj,
 			    struct drm_property *prop,
-			    uint64_t prop_value)
+			    uint64_t prop_value,
+			    bool async_flip)
 {
 	struct drm_mode_object *ref;
+	uint64_t old_val;
 	int ret;
 
 	if (!drm_property_change_valid_get(prop, prop_value, &ref))
@@ -1029,6 +1044,13 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
+		if (async_flip) {
+			ret = drm_atomic_connector_get_property(connector, connector_state,
+								prop, &old_val);
+			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
+			break;
+		}
+
 		ret = drm_atomic_connector_set_property(connector,
 				connector_state, file_priv,
 				prop, prop_value);
@@ -1044,6 +1066,13 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
+		if (async_flip) {
+			ret = drm_atomic_crtc_get_property(crtc, crtc_state,
+							   prop, &old_val);
+			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
+			break;
+		}
+
 		ret = drm_atomic_crtc_set_property(crtc,
 				crtc_state, prop, prop_value);
 		break;
@@ -1051,6 +1080,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 	case DRM_MODE_OBJECT_PLANE: {
 		struct drm_plane *plane = obj_to_plane(obj);
 		struct drm_plane_state *plane_state;
+		struct drm_mode_config *config = &plane->dev->mode_config;
 
 		plane_state = drm_atomic_get_plane_state(state, plane);
 		if (IS_ERR(plane_state)) {
@@ -1058,6 +1088,21 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
+		if (async_flip && prop != config->prop_fb_id) {
+			ret = drm_atomic_plane_get_property(plane, plane_state,
+							    prop, &old_val);
+			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
+			break;
+		}
+
+		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
+			drm_dbg_atomic(prop->dev,
+				"[OBJECT:%d] Only primary planes can be changed during async flip\n",
+				obj->id);
+			ret = -EINVAL;
+			break;
+		}
+
 		ret = drm_atomic_plane_set_property(plane,
 				plane_state, file_priv,
 				prop, prop_value);
@@ -1349,6 +1394,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	struct drm_out_fence_state *fence_state;
 	int ret = 0;
 	unsigned int i, j, num_fences;
+	bool async_flip = false;
 
 	/* disallow for drivers not supporting atomic: */
 	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
@@ -1385,6 +1431,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 				       "commit failed: DRM_MODE_PAGE_FLIP_ASYNC not supported with atomic\n");
 			return -EINVAL;
 		}
+
+		async_flip = true;
 	}
 
 	/* can't test and expect an event at the same time. */
@@ -1469,8 +1517,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 				goto out;
 			}
 
-			ret = drm_atomic_set_property(state, file_priv,
-						      obj, prop, prop_value);
+			ret = drm_atomic_set_property(state, file_priv, obj,
+						      prop, prop_value, async_flip);
 			if (ret) {
 				drm_mode_object_put(obj);
 				goto out;
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 8556c3b3ff88..a4c2ea33b1ef 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -251,7 +251,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			    struct drm_file *file_priv,
 			    struct drm_mode_object *obj,
 			    struct drm_property *prop,
-			    uint64_t prop_value);
+			    uint64_t prop_value, bool async_flip);
 int drm_atomic_get_property(struct drm_mode_object *obj,
 			    struct drm_property *property, uint64_t *val);
 
diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index ac0d2ce3f870..0e8355063eee 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -538,7 +538,7 @@ static int set_property_atomic(struct drm_mode_object *obj,
 						       obj_to_connector(obj),
 						       prop_value);
 	} else {
-		ret = drm_atomic_set_property(state, file_priv, obj, prop, prop_value);
+		ret = drm_atomic_set_property(state, file_priv, obj, prop, prop_value, false);
 		if (ret)
 			goto out;
 		ret = drm_atomic_commit(state);
-- 
2.42.0

