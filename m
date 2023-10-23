Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969307D2BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjJWHrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjJWHrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABD9D68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698047207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4hcsSZBhMT2HnuxQMp/RpIgkmty3L/dOPYFK1HXmTk=;
        b=RFQwLWsjaVjdkomBM4qp0J/M7vLXrnhzOogbeEmQBuMfVbEpY3Iez9QGjALHDR0JNXgFmJ
        bJYsOCq0UdyDp8fOrY8PnM298TF1lStpz2PYj7Qb8ELmOrOX09rb57GPXUGciQPYrJZTA6
        DU6z02blYt1OzlaS3igJej/0IJg5vsg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-FCtF2yaLNLCosYBbffxBNA-1; Mon, 23 Oct 2023 03:46:32 -0400
X-MC-Unique: FCtF2yaLNLCosYBbffxBNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E993110201F2;
        Mon, 23 Oct 2023 07:46:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9146503B;
        Mon, 23 Oct 2023 07:46:25 +0000 (UTC)
From:   Albert Esteve <aesteve@redhat.com>
To:     qemu-devel@nongnu.org
Cc:     zackr@vmware.com, contact@emersion.fr, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, iforbes@vmware.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        David Airlie <airlied@gmail.com>, banackm@vmware.com,
        Rob Clark <robdclark@gmail.com>, javierm@redhat.com,
        krastevm@vmware.com, spice-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mombasawalam@vmware.com,
        Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v6 2/9] drm/atomic: Add support for mouse hotspots
Date:   Mon, 23 Oct 2023 09:46:06 +0200
Message-ID: <20231023074613.41327-3-aesteve@redhat.com>
In-Reply-To: <20231023074613.41327-1-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zack Rusin <zackr@vmware.com>

Atomic modesetting code lacked support for specifying mouse cursor
hotspots. The legacy kms DRM_IOCTL_MODE_CURSOR2 had support for setting
the hotspot but the functionality was not implemented in the new atomic
paths.

Due to the lack of hotspots in the atomic paths userspace compositors
completely disable atomic modesetting for drivers that require it (i.e.
all paravirtualized drivers).

This change adds hotspot properties to the atomic codepaths throughtout
the DRM core and will allow enabling atomic modesetting for virtualized
drivers in the userspace.

Signed-off-by: Zack Rusin <zackr@vmware.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 14 +++++++
 drivers/gpu/drm/drm_atomic_uapi.c         | 20 +++++++++
 drivers/gpu/drm/drm_plane.c               | 50 +++++++++++++++++++++++
 include/drm/drm_plane.h                   | 14 +++++++
 4 files changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 784e63d70a421..54975de44a0e3 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -275,6 +275,20 @@ void __drm_atomic_helper_plane_state_reset(struct drm_plane_state *plane_state,
 			plane_state->normalized_zpos = val;
 		}
 	}
+
+	if (plane->hotspot_x_property) {
+		if (!drm_object_property_get_default_value(&plane->base,
+							   plane->hotspot_x_property,
+							   &val))
+			plane_state->hotspot_x = val;
+	}
+
+	if (plane->hotspot_y_property) {
+		if (!drm_object_property_get_default_value(&plane->base,
+							   plane->hotspot_y_property,
+							   &val))
+			plane_state->hotspot_y = val;
+	}
 }
 EXPORT_SYMBOL(__drm_atomic_helper_plane_state_reset);
 
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 98d3b10c08ae1..07a7b3f18df26 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -593,6 +593,22 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 	} else if (plane->funcs->atomic_set_property) {
 		return plane->funcs->atomic_set_property(plane, state,
 				property, val);
+	} else if (property == plane->hotspot_x_property) {
+		if (plane->type != DRM_PLANE_TYPE_CURSOR) {
+			drm_dbg_atomic(plane->dev,
+				       "[PLANE:%d:%s] is not a cursor plane: 0x%llx\n",
+				       plane->base.id, plane->name, val);
+			return -EINVAL;
+		}
+		state->hotspot_x = val;
+	} else if (property == plane->hotspot_y_property) {
+		if (plane->type != DRM_PLANE_TYPE_CURSOR) {
+			drm_dbg_atomic(plane->dev,
+				       "[PLANE:%d:%s] is not a cursor plane: 0x%llx\n",
+				       plane->base.id, plane->name, val);
+			return -EINVAL;
+		}
+		state->hotspot_y = val;
 	} else {
 		drm_dbg_atomic(plane->dev,
 			       "[PLANE:%d:%s] unknown property [PROP:%d:%s]\n",
@@ -653,6 +669,10 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
 		*val = state->scaling_filter;
 	} else if (plane->funcs->atomic_get_property) {
 		return plane->funcs->atomic_get_property(plane, state, property, val);
+	} else if (property == plane->hotspot_x_property) {
+		*val = state->hotspot_x;
+	} else if (property == plane->hotspot_y_property) {
+		*val = state->hotspot_y;
 	} else {
 		drm_dbg_atomic(dev,
 			       "[PLANE:%d:%s] unknown property [PROP:%d:%s]\n",
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index c6bbb0c209f47..eaca367bdc7e7 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -230,6 +230,47 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
 	return 0;
 }
 
+/**
+ * drm_plane_create_hotspot_properties - creates the mouse hotspot
+ * properties and attaches them to the given cursor plane
+ *
+ * @plane: drm cursor plane
+ *
+ * This function enables the mouse hotspot property on a given
+ * cursor plane.
+ *
+ * RETURNS:
+ * Zero for success or -errno
+ */
+static int drm_plane_create_hotspot_properties(struct drm_plane *plane)
+{
+	struct drm_property *prop_x;
+	struct drm_property *prop_y;
+
+	drm_WARN_ON(plane->dev,
+		    !drm_core_check_feature(plane->dev,
+					    DRIVER_CURSOR_HOTSPOT));
+
+	prop_x = drm_property_create_signed_range(plane->dev, 0, "HOTSPOT_X",
+						  INT_MIN, INT_MAX);
+	if (IS_ERR(prop_x))
+		return PTR_ERR(prop_x);
+
+	prop_y = drm_property_create_signed_range(plane->dev, 0, "HOTSPOT_Y",
+						  INT_MIN, INT_MAX);
+	if (IS_ERR(prop_y)) {
+		drm_property_destroy(plane->dev, prop_x);
+		return PTR_ERR(prop_y);
+	}
+
+	drm_object_attach_property(&plane->base, prop_x, 0);
+	drm_object_attach_property(&plane->base, prop_y, 0);
+	plane->hotspot_x_property = prop_x;
+	plane->hotspot_y_property = prop_y;
+
+	return 0;
+}
+
 __printf(9, 0)
 static int __drm_universal_plane_init(struct drm_device *dev,
 				      struct drm_plane *plane,
@@ -348,6 +389,10 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 		drm_object_attach_property(&plane->base, config->prop_src_w, 0);
 		drm_object_attach_property(&plane->base, config->prop_src_h, 0);
 	}
+	if (drm_core_check_feature(dev, DRIVER_CURSOR_HOTSPOT) &&
+	    type == DRM_PLANE_TYPE_CURSOR) {
+		drm_plane_create_hotspot_properties(plane);
+	}
 
 	if (format_modifier_count)
 		create_in_format_blob(dev, plane);
@@ -1067,6 +1112,11 @@ static int drm_mode_cursor_universal(struct drm_crtc *crtc,
 
 			fb->hot_x = req->hot_x;
 			fb->hot_y = req->hot_y;
+
+			if (plane->hotspot_x_property && plane->state)
+				plane->state->hotspot_x = req->hot_x;
+			if (plane->hotspot_y_property && plane->state)
+				plane->state->hotspot_y = req->hot_y;
 		} else {
 			fb = NULL;
 		}
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 79d62856defbf..e2c671585775b 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -116,6 +116,10 @@ struct drm_plane_state {
 	/** @src_h: height of visible portion of plane (in 16.16) */
 	uint32_t src_h, src_w;
 
+	/** @hotspot_x: x offset to mouse cursor hotspot */
+	/** @hotspot_y: y offset to mouse cursor hotspot */
+	int32_t hotspot_x, hotspot_y;
+
 	/**
 	 * @alpha:
 	 * Opacity of the plane with 0 as completely transparent and 0xffff as
@@ -748,6 +752,16 @@ struct drm_plane {
 	 * scaling.
 	 */
 	struct drm_property *scaling_filter_property;
+
+	/**
+	 * @hotspot_x_property: property to set mouse hotspot x offset.
+	 */
+	struct drm_property *hotspot_x_property;
+
+	/**
+	 * @hotspot_y_property: property to set mouse hotspot y offset.
+	 */
+	struct drm_property *hotspot_y_property;
 };
 
 #define obj_to_plane(x) container_of(x, struct drm_plane, base)
-- 
2.41.0

