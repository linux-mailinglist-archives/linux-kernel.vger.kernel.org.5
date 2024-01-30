Return-Path: <linux-kernel+bounces-44799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464DC842797
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023D12847F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890382D93;
	Tue, 30 Jan 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OR4aG3gc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E185C73
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627119; cv=none; b=R1W+PC2CBRMLL4KVAKlhiwxjpJWz4bgWJe1SrRmDhRVTToNlvbg8dkQ3FmZdxExwi0R2XcgG5+r1tOvStXp0XdLVwZlvzYYDdcnU+pGoAb3SnccPcLCGWszOftw/52gcgNELEd3i00Txd84CdaoslsodqqwSVKLv+x9JlRh0FTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627119; c=relaxed/simple;
	bh=6N6FAjXigJ9d8AkYgIE1f8w7WFjcPKRaWeUfSnl1DpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3MeC8/fDhPat2ny/zzDfJcDGAdUc3aOehf6ToSx2Hj4289ra4PsRyX3RGi6xFKUkrAg3kOGjnYXklZPzQowvUuvvasoFE4lEdcI9eh96JDwmTUuAFl7HqaFce3o/M4VB7oICXjP7HEyEOiZZ5yeRfHjr/ZVdCxVcMuKS/J9IPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OR4aG3gc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706627116;
	bh=6N6FAjXigJ9d8AkYgIE1f8w7WFjcPKRaWeUfSnl1DpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OR4aG3gcL75Vg89pgrdxJiieN9PUUtjILkykBHeHB/ibJ7dpxnh7arOXTZuyQlzLT
	 FmtSdff3adspZonXecyllV1UluP+Zc6Mr/3ZkcXEX5l265ITrK55RL5ELXMpDkXwWA
	 8y6D+aLEF/A34hnrn8NjWoe3lvA7szctTHo4f9n500nb3+IVVxhpx8ybyWsZwNFWGb
	 GVRnlsM/enEmxW+w27FNqoBEIXcoAuo/grBJ3R7CdaSI8nmfXRBb3qM7tqkXeCfRK1
	 taGEpnOkR+Cjx82fR7d5RTxpLILgvwd57Z/y1dj70+z4ZeS0l7VXtrXyJ00h25ouX9
	 Rsxi1mP2vCaLQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AA71C3782081;
	Tue, 30 Jan 2024 15:05:11 +0000 (UTC)
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
Subject: [PATCH v3 4/9] drm/ci: meson: Rename exisitng job
Date: Tue, 30 Jan 2024 20:33:35 +0530
Message-Id: <20240130150340.687871-5-vignesh.raman@collabora.com>
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

For Amlogic Meson SOC the display driver is meson. Currently,
in drm-ci for meson, only the display driver is tested.
So rename the meson job to indicate that display driver is tested.

Rename the name of xfail files for meson (g12b), to include
information about the tested driver and update xfails
accordingly.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Refactor the patch to rename job to indicate display driver testing,
    rename the existing xfail files.

v3:
  - Add the job name in GPU_VERSION and use it for xfail file names instead
    of using DRIVER_NAME.

---
 drivers/gpu/drm/ci/test.yml                           | 11 ++++++++---
 ...on-g12b-fails.txt => meson-g12b-display-fails.txt} |  3 ---
 2 files changed, 8 insertions(+), 6 deletions(-)
 rename drivers/gpu/drm/ci/xfails/{meson-g12b-fails.txt => meson-g12b-display-fails.txt} (84%)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index e153c5a7ad80..bf4c303a65f2 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -346,20 +346,25 @@ mediatek:mt8183-display:
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
-    GPU_VERSION: meson-g12b
     RUNNER_TAG: mesa-ci-x86-64-lava-meson-g12b-a311d-khadas-vim3
 
+meson:g12b-display:
+  extends:
+    - .g12b
+  variables:
+    GPU_VERSION: meson-g12b-display
+    DRIVER_NAME: meson
+
 virtio_gpu:none:
   stage: virtio-gpu
   variables:
diff --git a/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt b/drivers/gpu/drm/ci/xfails/meson-g12b-display-fails.txt
similarity index 84%
rename from drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
rename to drivers/gpu/drm/ci/xfails/meson-g12b-display-fails.txt
index 56a2ae7047b4..f123fb0cb820 100644
--- a/drivers/gpu/drm/ci/xfails/meson-g12b-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/meson-g12b-display-fails.txt
@@ -7,9 +7,6 @@ kms_cursor_legacy@torture-bo,Fail
 kms_cursor_legacy@torture-move,Fail
 kms_force_connector_basic@force-edid,Fail
 kms_hdmi_inject@inject-4k,Fail
-kms_plane_cursor@overlay,Fail
-kms_plane_cursor@primary,Fail
-kms_plane_cursor@viewport,Fail
 kms_properties@connector-properties-atomic,Fail
 kms_properties@connector-properties-legacy,Fail
 kms_properties@get_properties-sanity-atomic,Fail
-- 
2.40.1


