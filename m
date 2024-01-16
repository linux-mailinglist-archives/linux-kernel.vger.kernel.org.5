Return-Path: <linux-kernel+bounces-26962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4082F82E8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACF5B229C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914E41171A;
	Tue, 16 Jan 2024 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UxXeey57"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDF1118F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ooJddeRrdl0qjdwXSjPWH3RBZn8KCPwqLLnuVC6SkFA=; b=UxXeey57TMOjPuDhqLARRy+/N6
	J6OGiSuQoA3z16aBc+38Bfl69hZvAHKpfArJWNgNgFq7x+RRerbdqeF3LLdII8ik+nDjw4Uytt2gM
	BYJyrdTm4zYzPid+8uurnqtBStgSjCwgb3bXN+iP8XgupMobo7iYUymrYBV+BJKGAhst7UoPHpF0G
	xXEnag4WJoB0DGpAyfICkNO8ZaucIU/6vyoJm7/avfILXEhV4QNQAw7VDmNMDiuLi2FqRMOVgsgwS
	PaH3bUImusNrGArxxYxvDJkddCzskcStKYIk5D4xgylXvcsg8lFJTwSjaSMm/DN9cvoe7Ju6zQbLU
	S7ff9d/A==;
Received: from [177.45.63.147] (helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rPbQv-006r0R-Ox; Tue, 16 Jan 2024 05:52:18 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 2/2] drm/amdgpu: Implement check_async_props for planes
Date: Tue, 16 Jan 2024 01:51:59 -0300
Message-ID: <20240116045159.1015510-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116045159.1015510-1-andrealmeid@igalia.com>
References: <20240116045159.1015510-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

AMD GPUs can do async flips with overlay planes and other props rather
than just FB ID, so implement a custom check_async_props for AMD planes.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 116121e647ca..127cae1f9fb4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -25,6 +25,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
@@ -1430,6 +1431,34 @@ static void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
 	drm_atomic_helper_plane_destroy_state(plane, state);
 }
 
+static int amdgpu_dm_plane_check_async_props(struct drm_property *prop,
+					  struct drm_plane *plane,
+					  struct drm_plane_state *plane_state,
+					  struct drm_mode_object *obj,
+					  u64 prop_value, u64 old_val)
+{
+	struct drm_mode_config *config = &plane->dev->mode_config;
+	int ret;
+
+	if (prop != config->prop_fb_id &&
+	    prop != config->prop_in_fence_fd &&
+	    prop != config->prop_fb_damage_clips) {
+		ret = drm_atomic_plane_get_property(plane, plane_state,
+						    prop, &old_val);
+		return drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
+	}
+
+	if (plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY
+	    && plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY) {
+		drm_dbg_atomic(prop->dev,
+			       "[OBJECT:%d] Only primary or overlay planes can be changed during async flip\n",
+			       obj->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct drm_plane_funcs dm_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
@@ -1438,6 +1467,7 @@ static const struct drm_plane_funcs dm_plane_funcs = {
 	.atomic_duplicate_state = amdgpu_dm_plane_drm_plane_duplicate_state,
 	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
 	.format_mod_supported = amdgpu_dm_plane_format_mod_supported,
+	.check_async_props = amdgpu_dm_plane_check_async_props,
 };
 
 int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
-- 
2.43.0


