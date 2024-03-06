Return-Path: <linux-kernel+bounces-93271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C260C872D55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514FA28D7C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0953C1B800;
	Wed,  6 Mar 2024 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hxSPIOO4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83721B818
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694502; cv=none; b=nCuVV21xkXXYK0DjaLZUMt5oB9SRTzDp6OnILnwmcirtrXm0uKAVRp0pEDNzVwyqJulvnj/g1KIQqiLC7aPUcZvxun3rUfqZk45T/JkNqLONK8+adQ8GSiVDL6Hh5ldHJO/MdYvuLK21BBk3ydsb56+BWqNmPxUD5R/0SeWQFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694502; c=relaxed/simple;
	bh=ZKVm2EEro0twvk7ZrKgD0JwVVO0iBbsdkqUjhD2/Zh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sFOaFAZT5owmfPHyBb1pNT9hWFG4rNbG0LDZibFq9S6d9jeLiegLZj9pDuOHU7Nplg7VhZrLUGJvLZLzLWyr93GoAPlxwmy5B9LU7OsHa4OmpTltF1Ae5/nV0GBhSlZthrNp+Y/tC6A+97IsY1UW3cBvGKlI120MQbz1IaKoYLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hxSPIOO4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709694499;
	bh=ZKVm2EEro0twvk7ZrKgD0JwVVO0iBbsdkqUjhD2/Zh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxSPIOO4Fd61/uN3kLv120LrOR+6ogsGF9uad8VKQ+hNTxdFt0eQ1faTaLUqG7isZ
	 mLu8f4WM3XGrGnjteHZI6TiYU+ffg/qJktIypRoXoSwRuV27S52qEzTxP++BsFgrHL
	 SIrFFhY/ciUMtbyO6pOIGYUpYygxAUStJSi8o0/P7l/gthvr0FqPgKcm5KKwECHX+8
	 Og8gl7KE7bv/LXVQs1BopXfCuqsbYTOliInFr6BWc5WB3xR3iy5UTEdBoMFugiUeBI
	 YRVa6PfWnrGRoNbP8G5Q+8HAnUS6/+tNAMlpJIWw81ymJYhkx5RdWvTag5g7AGHdu3
	 CQCbom4JVpy5g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 72C1037820DA;
	Wed,  6 Mar 2024 03:08:15 +0000 (UTC)
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
Subject: [PATCH v4 06/11] drm/ci: mediatek: Add job to test panfrost and powervr GPU driver
Date: Wed,  6 Mar 2024 08:36:44 +0530
Message-Id: <20240306030649.60269-7-vignesh.raman@collabora.com>
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

For mediatek mt8173, the GPU driver is powervr and for mediatek
mt8183, the GPU driver is panfrost. So add support in drm-ci to
test panfrost and powervr GPU driver for mediatek SOCs and update
xfails. Powervr driver was merged in linux kernel, but there's no
mediatek support yet. So disable the mt8173-gpu job which uses
powervr driver.

Add panfrost specific tests to testlist and skip KMS tests for
panfrost driver since it is not a not a KMS driver. Also update
the MAINTAINERS file to include xfails for panfrost driver.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Add panfrost and PVR GPU jobs for mediatek SOC with new xfails, add xfail
    entry to MAINTAINERS.

v3:
  - Add panfrost specific tests to testlist and skip KMS tests for
    panfrost driver since it is not a not a KMS driver and update xfails.
    Update the MAINTAINERS file to include xfails for panfrost driver.
    Add the job name in GPU_VERSION and use it for xfail file names instead
    of using DRIVER_NAME.

v4:
  - Remove the gpu suffix in job and rename xfails accordingly.
    Update the MAINTAINERS file to include xfails for panfrost driver.

---
 MAINTAINERS                                   |  1 +
 drivers/gpu/drm/ci/gitlab-ci.yml              |  2 ++
 drivers/gpu/drm/ci/test.yml                   | 20 +++++++++++++++++++
 .../drm/ci/xfails/panfrost-mt8183-fails.txt   |  1 +
 .../drm/ci/xfails/panfrost-mt8183-skips.txt   |  2 ++
 5 files changed, 26 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 4da66ca92f1a..264b23108847 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1667,6 +1667,7 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/gpu/panfrost.rst
 F:	drivers/gpu/drm/ci/testlist-panfrost.txt
 F:	drivers/gpu/drm/ci/testlist.txt
+F:	drivers/gpu/drm/ci/xfails/panfrost*
 F:	drivers/gpu/drm/panfrost/
 F:	include/uapi/drm/panfrost_drm.h
 
diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index e2b021616a8e..9dae74465ce1 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -107,6 +107,8 @@ stages:
   - meson
   - msm
   - rockchip
+  - panfrost
+  - powervr
   - virtio-gpu
 
 # YAML anchors for rule conditions
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index f8f48523ada3..99fd101ce2fe 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -309,6 +309,18 @@ mediatek:mt8173:
     GPU_VERSION: mt8173
     DRIVER_NAME: mediatek
 
+powervr:mt8173:
+  extends:
+    - .mt8173
+  stage: powervr
+  variables:
+    GPU_VERSION: mt8173
+    DRIVER_NAME: powervr
+  rules:
+    # TODO: powervr driver was merged in linux kernel, but there's no mediatek support yet
+    # Remove the rule once mediatek support is added for powervr
+    - when: never
+
 mediatek:mt8183:
   extends:
     - .mt8183
@@ -316,6 +328,14 @@ mediatek:mt8183:
     GPU_VERSION: mt8183
     DRIVER_NAME: mediatek
 
+panfrost:mt8183:
+  extends:
+    - .mt8183
+  stage: panfrost
+  variables:
+    GPU_VERSION: mt8183
+    DRIVER_NAME: panfrost
+
 # drm-mtk doesn't even probe yet in mainline for mt8192
 .mediatek:mt8192:
   extends:
diff --git a/drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt b/drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt
new file mode 100644
index 000000000000..6f5e760d5ec0
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt
@@ -0,0 +1 @@
+panfrost_prime@gem-prime-import,Fail
diff --git a/drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt b/drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt
new file mode 100644
index 000000000000..2ea09d1648bc
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt
@@ -0,0 +1,2 @@
+# Panfrost is not a KMS driver, so skip the KMS tests
+kms_.*
-- 
2.40.1


