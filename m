Return-Path: <linux-kernel+bounces-93272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB45872D56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADCD287AE8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CA6134B2;
	Wed,  6 Mar 2024 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="raCF6Mf6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B581BC58
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694507; cv=none; b=pyioBCLlxmQ3fUqB56daEpWRcz2MLbSc3KQcUdky3fmJdrgqma8P/TQtOIG34Lp5CnbcMPQG19bTutyJp5RSPSpBHRePfz0ECGikdL5YXGKgEDIXZ8yxdd43SEWkgdm3PHDc4QXJMnsPaffLaKxV7t5Snoi9lYfwHr/AHXUXvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694507; c=relaxed/simple;
	bh=WrPzrnol5F76rUH/mCw3AKr49uKqT5kpb9joX4owG+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vk8Qd7XwPrs+jKJYH0TGqQlaDTOVONj7oWjKyygsYtapSVymRkEF6eijRxLxDfc7Q/ti8uNo+9hhOVMMxn8QypGhVoWN4dBEwlapxDwFowErqVNc9DfvGBrC+vbq8BbZFcW7xja6e1xyOz3s97JYLTID/8v/1P5XBNsCZ/zZ//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=raCF6Mf6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709694503;
	bh=WrPzrnol5F76rUH/mCw3AKr49uKqT5kpb9joX4owG+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raCF6Mf6XNvcbIo2js1OPjlcSQBgbrd5ikm/VipSzvi5gJMqJJG9yhu7CyFWpyJZa
	 6EYDZnYDkDTCdxyhiuhpndJLdmrd5i7qquF0ooZf4mffmHscbeITUl4+nQXIWJBKMF
	 OSoN1t0vwYIj9EYbuFLa5Jh5qkdAEyhXAWmWcc5dgW4XjmtRx7FeHdQt+REYVirATv
	 0nJwSx/Ut739rin++CFUhFJNVhQtPk/KyxcuTh5zcRIzYor3AaYVjpLQA/QFEuhr2n
	 8fLQ6SYI7cpqh9rYTa5wL53Bo1TGjiRoScahRUeELK0aZTBLfv0nKeGXP2Gt7LioIF
	 MmDb3QOVzVZTw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7E98A3780624;
	Wed,  6 Mar 2024 03:08:19 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	emma@anholt.net,
	robdclark@gmail.com,
	david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	hamohammed.sa@gmail.com,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	mairacanal@riseup.net,
	mcanal@igalia.com,
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] drm/ci: meson: Refactor existing meson jobs
Date: Wed,  6 Mar 2024 08:36:45 +0530
Message-Id: <20240306030649.60269-8-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240306030649.60269-1-vignesh.raman@collabora.com>
References: <20240306030649.60269-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Amlogic Meson SOC the display driver is meson. Currently,
in drm-ci for meson, only the display driver is tested.
Refactor the existing meson jobs so that gpu driver testing
jobs can be added later and update xfails accordingly.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Refactor the patch to rename job to indicate display driver testing,
    rename the existing xfail files.

v3:
  - Add the job name in GPU_VERSION and use it for xfail file names instead
    of using DRIVER_NAME.

v4:
  - Remove the display suffix in job and rename xfails accordingly.
    Remove the change adding job name in GPU_VERSION.

---
 drivers/gpu/drm/ci/test.yml                    | 11 ++++++++---
 drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt |  5 -----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 99fd101ce2fe..951a44bf9d19 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -351,20 +351,25 @@ panfrost:mt8183:
     - .lava-igt:arm64
   stage: meson
   variables:
-    DRIVER_NAME: meson
     DTB: ${DEVICE_TYPE}
     BOOT_METHOD: u-boot
     KERNEL_IMAGE_TYPE: "image"
 
-meson:g12b:
+.g12b:
   extends:
     - .meson
   parallel: 3
   variables:
     DEVICE_TYPE: meson-g12b-a311d-khadas-vim3
-    GPU_VERSION: g12b
     RUNNER_TAG: mesa-ci-x86-64-lava-meson-g12b-a311d-khadas-vim3
 
+meson:g12b:
+  extends:
+    - .g12b
+  variables:
+    GPU_VERSION: g12b
+    DRIVER_NAME: meson
+
 virtio_gpu:none:
   stage: virtio-gpu
   variables:
diff --git a/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt b/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
index 56a2ae7047b4..029b4ade21f6 100644
--- a/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
@@ -5,11 +5,6 @@ kms_cursor_legacy@single-bo,Fail
 kms_cursor_legacy@single-move,Fail
 kms_cursor_legacy@torture-bo,Fail
 kms_cursor_legacy@torture-move,Fail
-kms_force_connector_basic@force-edid,Fail
-kms_hdmi_inject@inject-4k,Fail
-kms_plane_cursor@overlay,Fail
-kms_plane_cursor@primary,Fail
-kms_plane_cursor@viewport,Fail
 kms_properties@connector-properties-atomic,Fail
 kms_properties@connector-properties-legacy,Fail
 kms_properties@get_properties-sanity-atomic,Fail
-- 
2.40.1


