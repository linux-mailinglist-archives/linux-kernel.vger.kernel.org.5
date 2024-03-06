Return-Path: <linux-kernel+bounces-93273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D27B872D58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC49FB250DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093E517BC5;
	Wed,  6 Mar 2024 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yauTSKWH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D041BDCE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694511; cv=none; b=ijoUZwiDvMqGvkYGVhJhdWROlCvrQYewb0LDhMtvNySuo7rDTBKR4ARsnd25u0DlazqNAE0FjMLXpwv7oQOvSOfRdk6E47Ga7nLyRJSlysEFPXBJwVKm24W9LewJXwUdgvEmArqW6b98I3tnphX2zTgtDkMUnDe/xNGnzN5Fin4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694511; c=relaxed/simple;
	bh=dZZpqBCxb8y7M5MKHNPlz5VMqXrw7cQklFnPCTea1T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKWrUW8t+7lxRSUYw8F89AAd86Reu/ovshT3lGQO92Q+v79FpmQRQhFMol12ndt6trXXlmz71hZNkPIJ8RH8YwQc4Iz1RQhs/5tkw8S0p6MkROZEIX3KZwdHcdoFYS8Y5yfazVUo87DqiJxlHSqzotwf7lYfrqrWx++PFtF23UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yauTSKWH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709694508;
	bh=dZZpqBCxb8y7M5MKHNPlz5VMqXrw7cQklFnPCTea1T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yauTSKWHuKheWOM/eQuJxn95LCKiN4XmruEWzB1kLYgBD3DaaeJbEbBcgE0Iezwe8
	 TlZe5Hg6irmXaQRUGK/KqepVsQ+UIVVJUpfXqIV8Zh9ThqxNkueHTD8JaldbyMuBNu
	 rpmngc8VvVwDyGA4ElFjd8lU1fH7Pjim4NpU3Gzy9PpBPcgC6lo6RKxUT+s1Zakdus
	 5hIV+MJcAsRS8LyBQBqnt+MU2hbY1EMAPp8KsngpOzOniyfY/F3RTgOVenL/gSJOSp
	 srsgjX3/vwax6TjcBCk10Rb5X2KYiZzwFmYrTv1bVViMf1pGabu0o9iVrgkxPmOTnL
	 Pz0HJcQCYcFdw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2AA6537820CC;
	Wed,  6 Mar 2024 03:08:24 +0000 (UTC)
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
Subject: [PATCH v4 08/11] drm/ci: meson: Add job to test panfrost GPU driver
Date: Wed,  6 Mar 2024 08:36:46 +0530
Message-Id: <20240306030649.60269-9-vignesh.raman@collabora.com>
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

For amlogic meson SOC the GPU driver is panfrost. So add
support in drm-ci to test panfrost driver for amlogic meson
SOC and update xfails. Skip KMS tests for panfrost driver
since it is not a not a KMS driver.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Add panfrost GPU jobs for amlogic meson SOC with new xfails.

v3:
  - Skip KMS tests for panfrost driver since it is not a not a KMS
    driver and update xfails. Add the job name in GPU_VERSION and use
    it for xfail file names instead of using DRIVER_NAME.

v4:
  - Remove the gpu suffix in job and rename xfails accordingly.

---
 drivers/gpu/drm/ci/test.yml                       | 8 ++++++++
 drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt | 1 +
 drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt | 2 ++
 3 files changed, 11 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 951a44bf9d19..6ae6398b3d88 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -370,6 +370,14 @@ meson:g12b:
     GPU_VERSION: g12b
     DRIVER_NAME: meson
 
+panfrost:g12b:
+  extends:
+    - .g12b
+  stage: panfrost
+  variables:
+    GPU_VERSION: g12b
+    DRIVER_NAME: panfrost
+
 virtio_gpu:none:
   stage: virtio-gpu
   variables:
diff --git a/drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
new file mode 100644
index 000000000000..6f5e760d5ec0
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
@@ -0,0 +1 @@
+panfrost_prime@gem-prime-import,Fail
diff --git a/drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
new file mode 100644
index 000000000000..2ea09d1648bc
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
@@ -0,0 +1,2 @@
+# Panfrost is not a KMS driver, so skip the KMS tests
+kms_.*
-- 
2.40.1


