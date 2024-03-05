Return-Path: <linux-kernel+bounces-92154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB51871BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD101C228DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722E45A4CF;
	Tue,  5 Mar 2024 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wneqPtmW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4C5A79B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635169; cv=none; b=EALWDfr+OHdY0aXuWuDFD12Z5st+8eZOGdGZ1mxT6vV00W0R7f0jljHRUx79aL9hFMC4HejBv5SB1cSRmIKX3c+zVEDsiL7lzOcTjQobfgGRXVamqc1oY4/IfZAPD0c9c3EBUSbmEcoXuRHvwPJR6arTSXVS5GeyXXYswDVb8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635169; c=relaxed/simple;
	bh=JUqcL89qGPDZrUKL7gY5CqBHkDlWDEFVMqHLYYGtoEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EMP/KG9o1jVRJj3L50hAAKJ7eWyZNLreOpRRlPLyhIA9Jn07AyuCUd+8bvonQ6r9w/BTNlfMgogFMsVloBrdgySM87D2eB7e9lJu1FHsptqkCwlzKAdp+QAsWzpUWaAHZg7dYdPhSAaOf44cz0ePJoYxPC8oZlqxaEBPiyX//7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wneqPtmW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709635166;
	bh=JUqcL89qGPDZrUKL7gY5CqBHkDlWDEFVMqHLYYGtoEA=;
	h=From:To:Cc:Subject:Date:From;
	b=wneqPtmW64fyroXo9XhZAZ7h+zl/SIdvBarDT6EFhdosc4xg3GZK6CU8xTa3Vc0QW
	 gA5uJ+DLOg4YLEvegcuGGZg6MHsCElk3O8lpd8K/Rn1BvFvd0tAZFOA4pwc15kNu/u
	 trFo49kF2k7Qwy2XkB0H/sJIw9BhyeSeQrt/nFAs0r1p3KxUdzv0NAz5UE6ZqYCCRe
	 2rLJIoLBuNUAU3me/RqkAEccFBMiitlxoAcIBiprZqaaORgxP34jc+uEsXl2oDi6tE
	 mrKQODKR4gt5deNJOFC+o3GayJgj/0kx1u2TBQZh1uRXLjXufpuZAeKMMdAgMk/ymu
	 lvzmxLE2s0/eQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 06F3D37820F2;
	Tue,  5 Mar 2024 10:39:22 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	david.heidelberg@collabora.com,
	sergi.blanch.torne@collabora.com,
	guilherme.gallo@collabora.com,
	robdclark@gmail.com,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tvrtko.ursulin@linux.intel.com,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/ci: update device type for volteer devices
Date: Tue,  5 Mar 2024 16:08:29 +0530
Message-Id: <20240305103829.38350-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Volteer devices in the collabora lab are categorized under the
asus-cx9400-volteer device type. The majority of these units
has an Intel Core i5-1130G7 CPU, while some of them have a
Intel Core i7-1160G7 CPU instead. So due to this difference,
new device type template is added for the Intel Core i5-1130G7
and i7-1160G7 variants of the Acer Chromebook Spin 514 (CP514-2H)
volteer Chromebooks. So update the same in drm-ci.

https://gitlab.collabora.com/lava/lava/-/merge_requests/149

Fixes: 0119c894ab0dc ("drm: Add initial ci/ subdirectory")
Reviewed-by: David Heidelberg <david.heidelberg@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Add fixes tag so change gets propagated to stable.
    https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1119672
---
 drivers/gpu/drm/ci/test.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 0857773e5c5f..8bc63912fddb 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -252,11 +252,11 @@ i915:cml:
 i915:tgl:
   extends:
     - .i915
-  parallel: 8
+  parallel: 5
   variables:
-    DEVICE_TYPE: asus-cx9400-volteer
+    DEVICE_TYPE: acer-cp514-2h-1130g7-volteer
     GPU_VERSION: tgl
-    RUNNER_TAG: mesa-ci-x86-64-lava-asus-cx9400-volteer
+    RUNNER_TAG: mesa-ci-x86-64-lava-acer-cp514-2h-1130g7-volteer
 
 .amdgpu:
   extends:
-- 
2.40.1


