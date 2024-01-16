Return-Path: <linux-kernel+bounces-27217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE8782EC59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06D7285712
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBE31B959;
	Tue, 16 Jan 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q33qlN5C"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143161B952
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705398958;
	bh=py8W8Asz6iLe+zesCfN7lkNBclqdDY+sNYRWL+acWNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q33qlN5C3QOawEnjwhIwxeamlUwIULyZc5ROCjgkxM0xbGvHo4F9GT6rf0NB/a+Sh
	 JWyQyGCVhATE5xVNBEOv9EUpKOpJQYCJQI9T84EpyKGuL75dfbv/A1njeSVYSXHinv
	 T1hzjOVvJtsP3w1H79FEsRoULr3BW4Gf6VOkwNqnPPlTNIPCYgOqdsO0qbWJFwhXw7
	 V6TTwh06oUo9jmasF7aVHZ/xBBE/EsjjdvaLcd567TiGwZg53oDwgNpvPZ10mzPHpI
	 AL6ajO5Q+k+voViAKDduLlWAhBNluGe2E0bjjp4Cg1Pb/YbChlp7pQicSQRUW+fCaB
	 2ATW/vDWY539w==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 67ED03782067;
	Tue, 16 Jan 2024 09:55:54 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniel@fooishbar.org,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] drm/ci: meson: Add job to test panfrost GPU driver
Date: Tue, 16 Jan 2024 15:24:37 +0530
Message-Id: <20240116095439.107324-6-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240116095439.107324-1-vignesh.raman@collabora.com>
References: <20240116095439.107324-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For amlogic meson SOC the GPU driver is panfrost. So add
support in drm-ci to test panfrost driver for amlogic meson
SOC and update xfails.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Add panfrost GPU jobs for amlogic meson SOC with new xfails.

---
 drivers/gpu/drm/ci/test.yml                      |  7 +++++++
 .../drm/ci/xfails/panfrost-g12b-gpu-fails.txt    | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-gpu-fails.txt

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 8a04f7daafed..1493da288ab2 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -358,6 +358,13 @@ mediatek:mt8183-display:
     DEVICE_TYPE: meson-g12b-a311d-khadas-vim3
     RUNNER_TAG: mesa-ci-x86-64-lava-meson-g12b-a311d-khadas-vim3
 
+meson:g12b-gpu:
+  extends:
+    - .g12b
+  variables:
+    GPU_VERSION: g12b-gpu
+    DRIVER_NAME: panfrost
+
 meson:g12b-display:
   extends:
     - .g12b
diff --git a/drivers/gpu/drm/ci/xfails/panfrost-g12b-gpu-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-g12b-gpu-fails.txt
new file mode 100644
index 000000000000..56a2ae7047b4
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-g12b-gpu-fails.txt
@@ -0,0 +1,16 @@
+kms_3d,Fail
+kms_cursor_legacy@forked-bo,Fail
+kms_cursor_legacy@forked-move,Fail
+kms_cursor_legacy@single-bo,Fail
+kms_cursor_legacy@single-move,Fail
+kms_cursor_legacy@torture-bo,Fail
+kms_cursor_legacy@torture-move,Fail
+kms_force_connector_basic@force-edid,Fail
+kms_hdmi_inject@inject-4k,Fail
+kms_plane_cursor@overlay,Fail
+kms_plane_cursor@primary,Fail
+kms_plane_cursor@viewport,Fail
+kms_properties@connector-properties-atomic,Fail
+kms_properties@connector-properties-legacy,Fail
+kms_properties@get_properties-sanity-atomic,Fail
+kms_properties@get_properties-sanity-non-atomic,Fail
-- 
2.40.1


