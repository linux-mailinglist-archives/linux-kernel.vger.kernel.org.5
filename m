Return-Path: <linux-kernel+bounces-97196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6558766C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293BCB21272
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B5567A;
	Fri,  8 Mar 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ma7RYtqG"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8FC4C7B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909779; cv=none; b=IWxGK6tQoi6b1TLJx3nu2wLjY6WzeiI7eK59q/X5CEKp5/zK4mJiKEt4iBEJE4q6DA3TuJeBpH8bPe2GkTRCWly932PHPIb+Str9HbN84ey8U1ZWTb3RMQ1aszjdhXoE1CYPry1hmXKNbdgOL6wDwMPQUqcpB+Dcng9GX3/xqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909779; c=relaxed/simple;
	bh=5ThtQbWLBgHmpYKWBlCX/ig9OsKqfKuNyKhycD5kgVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INBWxAHfrOIQHZ/cvtss7gOdJLvpD9qf+3zDFQG+ufrmHnzatAFRsOx4m0QaUOHUw6VRttzaDc2NCxtIs8+8h6rIQGNGHUfpTmwhpyY8+z7LOkZRqvP0OxWVM01JTa7G56HTqeFF6DbrIneVmDEb4mJoEeJWRISkElvCsVIWOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ma7RYtqG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=krDIRYgU1uLFsIvNtqFMjTjuXBLodI3PgcqmjvYIA64=; b=ma7RYtqGTddCWW/HzBOmsnL5Ut
	cpRud3IdvZ/c3pm3joUw6CwSSPeRodpDnGoKBQbAExK6ObI17EF5vq2qqqgbecfUF8g9mnspAHfsv
	AEnNry+B+spRFExeOeJ7Feu0pW6Ka7CMDBjuQumO1dHn0bodi43ZgI49zkYZ1iyf9YD+XfuuittVq
	LI1/4BSoF54VL0KUVUMZ+baz4xTH+8/CxfTLaj7MmV1oigMDTT+UEqAR8QjYkeMkWDl9HI+iv0cfY
	ZpdyKtnv/weyNo+o6G0ZLuPMbcsWObrzPZK1DrEIt7/LuVWax2a3GySvway+4buP7PHI849iQ3b0H
	od/OUN9g==;
Received: from [152.249.135.210] (helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ribdu-007p93-5S; Fri, 08 Mar 2024 15:56:14 +0100
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
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RESEND PATCH v4 2/3] drm: Allow drivers to choose plane types to async flip
Date: Fri,  8 Mar 2024 11:55:52 -0300
Message-ID: <20240308145553.194165-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308145553.194165-1-andrealmeid@igalia.com>
References: <20240308145553.194165-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Different planes may have different capabilities of doing async flips,
so create a field to let drivers allow async flip per plane type.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v4: new patch

 drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
 drivers/gpu/drm/drm_plane.c       | 3 +++
 include/drm/drm_plane.h           | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eecfb9e240d..5c66289188be 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1075,9 +1075,9 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
-		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
+		if (async_flip && !plane_state->plane->async_flip) {
 			drm_dbg_atomic(prop->dev,
-				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
+				       "[OBJECT:%d] This type of plane cannot be changed during async flip\n",
 				       obj->id);
 			ret = -EINVAL;
 			break;
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 672c655c7a8e..71ada690222a 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -366,6 +366,9 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 
 	drm_modeset_lock_init(&plane->mutex);
 
+	if (type == DRM_PLANE_TYPE_PRIMARY)
+		plane->async_flip = true;
+
 	plane->base.properties = &plane->properties;
 	plane->dev = dev;
 	plane->funcs = funcs;
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 641fe298052d..5e9efb7321ac 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -779,6 +779,11 @@ struct drm_plane {
 	 * @hotspot_y_property: property to set mouse hotspot y offset.
 	 */
 	struct drm_property *hotspot_y_property;
+
+	/**
+	 * @async_flip: indicates if a plane can do async flips
+	 */
+	bool async_flip;
 };
 
 #define obj_to_plane(x) container_of(x, struct drm_plane, base)
-- 
2.43.0


