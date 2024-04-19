Return-Path: <linux-kernel+bounces-151831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A3C8AB486
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB401F228A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49A013AD28;
	Fri, 19 Apr 2024 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aCRdVpda"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215D13A86B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713548750; cv=none; b=mEd2xWRbrKPngO47vgkXncL67g1T1etfWESbxFmn7WEir5uvfFC3Z2biXp1i/WMJymO0twnqy9qPtqWc56iYeqUdXtavXBmo86O2DR3sDo2Eo9Wi5cR6xBxCctT0P6OboulCCesF3OXS4u3waVFxDfhbjOvbmB4UcjhqtUQALjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713548750; c=relaxed/simple;
	bh=tg8CNjSpWN2BcBDo2ESp9bjBzlZSzMIk0QNMl4nZYbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=boS9sBNvMx6cQeEMirIiwpZyUFS0+goeyVPCS1EvKweulKC5s73Lp9HSG1a2cr8Q7Zg+lwyS8iS8AVr41QIadlTVGCNDpS15w5tIhvI53zPgJ96PzXaLrU94Em9U4bLbKjmOeyNd6JmiFEOpIVq+BoZVz0s/WbCocxRwYCbVuQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aCRdVpda; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713548746;
	bh=tg8CNjSpWN2BcBDo2ESp9bjBzlZSzMIk0QNMl4nZYbA=;
	h=From:To:Cc:Subject:Date:From;
	b=aCRdVpdahXIbXIWgMggkkeyMfyj00RFePkKCUXa9vvmPOryTab8WeJK1xioUerVe3
	 3j9qCE22dAYsDJfJO8IarsnMX9631nkI/BkTBHo7Me9zzVE4WjxJX3AiAP3pJm49A3
	 YyTsRgMbvJzIbR76votXMr/ObHPp0UHTz16W1xGXS1QPXXz8BH/8JMRsGQ6pSpO5+g
	 S+Bl8WxsE1pcL1869tsyNzY3JN97U3G23JLPyJd5zJ5Yh57tvkvv6PZCe+FLkRyYUt
	 aBV6PSfWhGetcgqmwBh5gVx+IGooPEDOWMzvdfaxrJ45jAZFnl5EJE80zwNqeOOxZJ
	 rWkisKZhhNqiA==
Received: from hermes-devbox.lan (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbeckett)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D62E83782154;
	Fri, 19 Apr 2024 17:45:45 +0000 (UTC)
From: Bob Beckett <bob.beckett@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com,
	Robert Beckett <bob.beckett@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: fix drm lastclose ignoring closed active fbs
Date: Fri, 19 Apr 2024 18:45:30 +0100
Message-ID: <20240419174531.1696581-1-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robert Beckett <bob.beckett@collabora.com>

when fb's have been marked as closed, if there is still something active
then don't restore fbdev during lastclose

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/drm_fb_helper.c |  3 +++
 drivers/gpu/drm/drm_plane.c     | 21 +++++++++++++++++++++
 include/drm/drm_plane.h         |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d612133e2cf7e..b7509b0cd926a 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2002,6 +2002,9 @@ EXPORT_SYMBOL(drm_fb_helper_hotplug_event);
  */
 void drm_fb_helper_lastclose(struct drm_device *dev)
 {
+	if (drm_has_active_plane(dev))
+		return;
+
 	drm_fb_helper_restore_fbdev_mode_unlocked(dev->fb_helper);
 }
 EXPORT_SYMBOL(drm_fb_helper_lastclose);
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 672c655c7a8e7..7eb3d06696ca7 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -930,6 +930,27 @@ static int __setplane_check(struct drm_plane *plane,
 	return 0;
 }
 
+/**
+ * drm_has_active_plane - check whether any planes are currently active
+ * @dev: the DRM device
+ *
+ * Return true if any planes are currently active
+ */
+bool drm_has_active_plane(struct drm_device *dev)
+{
+	struct drm_plane *plane;
+
+	drm_for_each_plane(plane, dev) {
+		if (plane->state && plane->state->crtc && plane->state->fb)
+			return true;
+		if (plane->crtc && plane->fb)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(drm_has_active_plane);
+
 /**
  * drm_any_plane_has_format - Check whether any plane supports this format and modifier combination
  * @dev: DRM device
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 641fe298052dc..74fec8cbee8c6 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -965,6 +965,8 @@ static inline struct drm_plane *drm_plane_find(struct drm_device *dev,
 #define drm_for_each_plane(plane, dev) \
 	list_for_each_entry(plane, &(dev)->mode_config.plane_list, head)
 
+bool drm_has_active_plane(struct drm_device *dev);
+
 bool drm_any_plane_has_format(struct drm_device *dev,
 			      u32 format, u64 modifier);
 
-- 
2.44.0


