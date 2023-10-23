Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639217D2BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjJWHsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjJWHrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73459D75
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698047218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UMT8ba+r9A0Dp8O1xMjPSLzWa5y2hkT59m9kkQX4WYk=;
        b=Jgljqsj0paB/YbEffDLj3TYw/zWGpJr+/80Oy6FVd0qh6cKp8CUHee4siRpvWE3wdJnDQS
        1JB/E3wRDHC3Cgdp8ajYwPQz89Wj9EMonGC/2NOwq7SoElVB8z1mmNW8sxoVOGz69K1JkF
        B9cpURzvtAS/8ffdLOxffeu5gd0jyuo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-igkbjBZZMaO3OTy9IkNl7w-1; Mon, 23 Oct 2023 03:46:42 -0400
X-MC-Unique: igkbjBZZMaO3OTy9IkNl7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E55FE299E759;
        Mon, 23 Oct 2023 07:46:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C936503B;
        Mon, 23 Oct 2023 07:46:36 +0000 (UTC)
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
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v6 4/9] drm/qxl: Use the hotspot properties from cursor planes
Date:   Mon, 23 Oct 2023 09:46:08 +0200
Message-ID: <20231023074613.41327-5-aesteve@redhat.com>
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

Atomic modesetting got support for mouse hotspots via the hotspot
properties. Port the legacy kms hotspot handling to the new properties
on cursor planes.

Signed-off-by: Zack Rusin <zackr@vmware.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: virtualization@lists.linux-foundation.org
Cc: spice-devel@lists.freedesktop.org
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 6492a70e3c396..5d689e0d3586c 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -485,7 +485,6 @@ static int qxl_primary_atomic_check(struct drm_plane *plane,
 static int qxl_primary_apply_cursor(struct qxl_device *qdev,
 				    struct drm_plane_state *plane_state)
 {
-	struct drm_framebuffer *fb = plane_state->fb;
 	struct qxl_crtc *qcrtc = to_qxl_crtc(plane_state->crtc);
 	struct qxl_cursor_cmd *cmd;
 	struct qxl_release *release;
@@ -510,8 +509,8 @@ static int qxl_primary_apply_cursor(struct qxl_device *qdev,
 
 	cmd = (struct qxl_cursor_cmd *)qxl_release_map(qdev, release);
 	cmd->type = QXL_CURSOR_SET;
-	cmd->u.set.position.x = plane_state->crtc_x + fb->hot_x;
-	cmd->u.set.position.y = plane_state->crtc_y + fb->hot_y;
+	cmd->u.set.position.x = plane_state->crtc_x + plane_state->hotspot_x;
+	cmd->u.set.position.y = plane_state->crtc_y + plane_state->hotspot_y;
 
 	cmd->u.set.shape = qxl_bo_physical_address(qdev, qcrtc->cursor_bo, 0);
 
@@ -531,7 +530,6 @@ static int qxl_primary_apply_cursor(struct qxl_device *qdev,
 static int qxl_primary_move_cursor(struct qxl_device *qdev,
 				   struct drm_plane_state *plane_state)
 {
-	struct drm_framebuffer *fb = plane_state->fb;
 	struct qxl_crtc *qcrtc = to_qxl_crtc(plane_state->crtc);
 	struct qxl_cursor_cmd *cmd;
 	struct qxl_release *release;
@@ -554,8 +552,8 @@ static int qxl_primary_move_cursor(struct qxl_device *qdev,
 
 	cmd = (struct qxl_cursor_cmd *)qxl_release_map(qdev, release);
 	cmd->type = QXL_CURSOR_MOVE;
-	cmd->u.position.x = plane_state->crtc_x + fb->hot_x;
-	cmd->u.position.y = plane_state->crtc_y + fb->hot_y;
+	cmd->u.position.x = plane_state->crtc_x + plane_state->hotspot_x;
+	cmd->u.position.y = plane_state->crtc_y + plane_state->hotspot_y;
 	qxl_release_unmap(qdev, release, &cmd->release_info);
 
 	qxl_release_fence_buffer_objects(release);
@@ -851,8 +849,8 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 		struct qxl_bo *old_cursor_bo = qcrtc->cursor_bo;
 
 		qcrtc->cursor_bo = qxl_create_cursor(qdev, user_bo,
-						     new_state->fb->hot_x,
-						     new_state->fb->hot_y);
+						     new_state->hotspot_x,
+						     new_state->hotspot_y);
 		qxl_free_cursor(old_cursor_bo);
 	}
 
-- 
2.41.0

