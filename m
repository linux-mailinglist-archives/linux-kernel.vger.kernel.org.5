Return-Path: <linux-kernel+bounces-105303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2802787DBF6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B6F1C20A6E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 23:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CE81C698;
	Sat, 16 Mar 2024 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PjZnPFEY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C051B949
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710630805; cv=none; b=GRw7lOxWPkkP9qFnjErB9LNLKf59lRf55becd52hTJCxVHwI8UEnC15ztZBKTCgsZBwYXrl1ZpypOvwLa890vvXPJPEhphPz1qNuorwhI+0lPNou1ZGfSCCSskqCQv1pxVfugiFIwqJsEpXeR/a5pF4LqNc8c1OnosWJN+Li1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710630805; c=relaxed/simple;
	bh=IhpBXYmi/BsEsq/CSAb6QqrLjEY2i/Yps1Od4RNhUH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nYMTeoXzAakne/FSBNkdTdbMZ1MQrzXJlMj/4ekdamKN+2otNAWHG02w4zeg13IE7p0vzTtv5GH/wkL7E/a1geRGityju6Wp5wgpDYm+2OrIAcBm1HfEjavHnnXYXRaFZxO9dm+n2lg3awtMVN+EqU1GyGXtkbea0cOiIEWfhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PjZnPFEY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710630796;
	bh=IhpBXYmi/BsEsq/CSAb6QqrLjEY2i/Yps1Od4RNhUH8=;
	h=From:To:Cc:Subject:Date:From;
	b=PjZnPFEYAUQQQG4/5HoJ3yMf5wRmZ+oxtmYJcXJq0qpIUlLS7HCVBsNgTWSPRL3g9
	 QnxyEuWAjUg0iGqVLcNj1xQ9oAJqlwLThwZkO8SfAd/TYvXDRpiO1uyxFgpdTe2qN7
	 /ZkTelRCYSlR8e/9pUvP9h5RrBmBH2BYRe/7QG4vKZxn3+NPfmwd+GL1c1bkqG2Uv4
	 AXQoQizkCZBHZqcE+8NuhqAt0eRMizUJ9MfSVcAaOqeYUup5opRFQWOmm0zSB/q7tr
	 fY/Cs1ufXMrenlU2T7MJ01FKEng6+ydGyeAeFipjSD0g+Nqz5/DJmWcMZ6+27hsQXf
	 I48YaIaHeyumA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 726D6378020D;
	Sat, 16 Mar 2024 23:13:15 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panfrost: Only display fdinfo's engine and cycle tags when profiling is on
Date: Sat, 16 Mar 2024 23:13:04 +0000
Message-ID: <20240316231306.293817-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If job accounting is disabled, then both fdinfo's drm-engine and drm-cycle
key values will remain immutable. In that case, it makes more sense not to
display them at all to avoid confusing user space profiling tools.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index eec250114114..ef9f6c0716d5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -550,10 +550,12 @@ static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
 	BUILD_BUG_ON(ARRAY_SIZE(engine_names) != NUM_JOB_SLOTS);
 
 	for (i = 0; i < NUM_JOB_SLOTS - 1; i++) {
-		drm_printf(p, "drm-engine-%s:\t%llu ns\n",
-			   engine_names[i], panfrost_priv->engine_usage.elapsed_ns[i]);
-		drm_printf(p, "drm-cycles-%s:\t%llu\n",
-			   engine_names[i], panfrost_priv->engine_usage.cycles[i]);
+		if (pfdev->profile_mode) {
+			drm_printf(p, "drm-engine-%s:\t%llu ns\n",
+				   engine_names[i], panfrost_priv->engine_usage.elapsed_ns[i]);
+			drm_printf(p, "drm-cycles-%s:\t%llu\n",
+				   engine_names[i], panfrost_priv->engine_usage.cycles[i]);
+		}
 		drm_printf(p, "drm-maxfreq-%s:\t%lu Hz\n",
 			   engine_names[i], pfdev->pfdevfreq.fast_rate);
 		drm_printf(p, "drm-curfreq-%s:\t%lu Hz\n",

base-commit: 97252d0a4bfbb07079503d059f7522d305fe0f7a
-- 
2.43.0


