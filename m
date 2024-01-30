Return-Path: <linux-kernel+bounces-44798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B69842792
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671FD283F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2D781AC9;
	Tue, 30 Jan 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ryF5aEf/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E2082D93
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627114; cv=none; b=TREPUfO7PLIMGN76WqIcavbwdpygNOdCJnTNDQ8sdcHbUPIJXuqI81JuW7DAtifKO6rydCekDNPuY1o5v61OHJORvjzuW/Y327ixhmzTUkBcUOhQPJhWv1BRCqV6Z9NlSRTSI3SUTq/HMnTFPTjLBnZR0MjUAu7unNsNh+bvn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627114; c=relaxed/simple;
	bh=jWgH1wt2P+WmiafYOD6k4YLKcf4liwSXj2vQg8ErA1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iEZCoBTOMNF7aYGzOIQOpJKpJK6KYdBaej3+pVGPghIKABkg8JcJpfQE3YvKPXHFCaXzNJIRAM43n//Q9MO9BAT+yZHwuZ0HONoJlq3dglcOphKm849rAshHzHUVeVzbZZ+J5LSB9LKv0Xinda4+Lsg/kFgRXatvHuQUGtyciq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ryF5aEf/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706627111;
	bh=jWgH1wt2P+WmiafYOD6k4YLKcf4liwSXj2vQg8ErA1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryF5aEf/x2Xps+n2j+YTnU7IF7HUIfbnr6ze5amLT43mqdhzZYE8MwPFrifkQ33/e
	 9Imu3SdRH5rtUod6+Z+ktYsznMCIaEbR9GI7l0SxN4pe8LsVyEz1NiGtbbSbCPheHI
	 OGcsGngxWSm8dcV6kSuyRvMMsdUgAogUqrvoOTtLzKgv4UqFbmFcH1IZawlziI3U7S
	 Fw/CPOILix0aq6Eho7iOGLI06PYLntrful/9GU8KObaoo2rq51/e8tx9l5PKWg92T3
	 Gxos2veMW5CbaoutP7RLL0W/xZJFvAwID3W7e64Hk30L2wlEecDUJqlJ7NdAYa2+4N
	 aPasaoSR39M/Q==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A5553782079;
	Tue, 30 Jan 2024 15:05:06 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniel@fooishbar.org,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	robdclark@gmail.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] drm/ci: mediatek: Add job to test panfrost and powervr GPU driver
Date: Tue, 30 Jan 2024 20:33:34 +0530
Message-Id: <20240130150340.687871-4-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130150340.687871-1-vignesh.raman@collabora.com>
References: <20240130150340.687871-1-vignesh.raman@collabora.com>
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

---
 MAINTAINERS                                    |  1 +
 drivers/gpu/drm/ci/test.yml                    | 18 ++++++++++++++++++
 drivers/gpu/drm/ci/testlist.txt                | 16 ++++++++++++++++
 .../ci/xfails/mediatek-mt8183-gpu-skips.txt    |  2 ++
 4 files changed, 37 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-gpu-skips.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d959a6881f7..bcdc17d1aa26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1645,6 +1645,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/gpu/panfrost.rst
+F:	drivers/gpu/drm/ci/xfails/panfrost*
 F:	drivers/gpu/drm/panfrost/
 F:	include/uapi/drm/panfrost_drm.h
 
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 0cd44e6ea18b..e153c5a7ad80 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -299,6 +299,17 @@ amdgpu:stoney:
     DEVICE_TYPE: mt8183-kukui-jacuzzi-juniper-sku16
     RUNNER_TAG: mesa-ci-x86-64-lava-mt8183-kukui-jacuzzi-juniper-sku16
 
+mediatek:mt8173-gpu:
+  extends:
+    - .mt8173
+  variables:
+    GPU_VERSION: mediatek-mt8173-gpu
+    DRIVER_NAME: powervr
+  rules:
+    # TODO: powervr driver was merged in linux kernel, but there's no mediatek support yet
+    # Remove the rule once mediatek support is added for powervr
+    - when: never
+
 mediatek:mt8173-display:
   extends:
     - .mt8173
@@ -306,6 +317,13 @@ mediatek:mt8173-display:
     GPU_VERSION: mediatek-mt8173-display
     DRIVER_NAME: mediatek
 
+mediatek:mt8183-gpu:
+  extends:
+    - .mt8183
+  variables:
+    GPU_VERSION: mediatek-mt8183-gpu
+    DRIVER_NAME: panfrost
+
 mediatek:mt8183-display:
   extends:
     - .mt8183
diff --git a/drivers/gpu/drm/ci/testlist.txt b/drivers/gpu/drm/ci/testlist.txt
index eaeb751bb0ad..772fc025b1f8 100644
--- a/drivers/gpu/drm/ci/testlist.txt
+++ b/drivers/gpu/drm/ci/testlist.txt
@@ -2959,3 +2959,19 @@ msm_submit@invalid-duplicate-bo-submit
 msm_submit@invalid-cmd-idx-submit
 msm_submit@invalid-cmd-type-submit
 msm_submit@valid-submit
+panfrost_get_param@base-params
+panfrost_get_param@get-bad-param
+panfrost_get_param@get-bad-padding
+panfrost_gem_new@gem-new-4096
+panfrost_gem_new@gem-new-0
+panfrost_gem_new@gem-new-zeroed
+panfrost_prime@gem-prime-import
+panfrost_submit@pan-submit
+panfrost_submit@pan-submit-error-no-jc
+panfrost_submit@pan-submit-error-bad-in-syncs
+panfrost_submit@pan-submit-error-bad-bo-handles
+panfrost_submit@pan-submit-error-bad-requirements
+panfrost_submit@pan-submit-error-bad-out-sync
+panfrost_submit@pan-reset
+panfrost_submit@pan-submit-and-close
+panfrost_submit@pan-unhandled-pagefault
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-gpu-skips.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-gpu-skips.txt
new file mode 100644
index 000000000000..2ea09d1648bc
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-gpu-skips.txt
@@ -0,0 +1,2 @@
+# Panfrost is not a KMS driver, so skip the KMS tests
+kms_.*
-- 
2.40.1


