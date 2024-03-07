Return-Path: <linux-kernel+bounces-94862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229CE874612
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952A9281DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843BE5C8B;
	Thu,  7 Mar 2024 02:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YK8gescl"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E96B6112
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709778114; cv=none; b=n7CAVNQvZU38K17dyXP9IiwWhWKISEZt8/Ns5hxbjfT5ED0PpltmoSWTMNEK11k/NGIeCHRVBAcZ829vSDaOWJI0Liidys5LX6q20AonvhXx2HI29pVXFGWIQFPYp37dzfVWaYBNc5mKb62a+VtkxvSeubYsJqKXynC0e+OWx8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709778114; c=relaxed/simple;
	bh=wcNAje16nLUZs0HlstOnpDC5DqRaA1co8aNRDvbCu00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BaAbqq7Xx0O8LjI9baCNF8w56p45KSDusckVlkF4y8xS5F0DqlTvt5wS/AfejNHQC7QyMxKnQ28XHipai2fll4Ne2jvDuf4Kw956UPVP75MYbMpmZ8p8eMM5llMDaRelA8LAKFOLNIrh6xWHjN8Pq8Q9BCM81K8J6DPa02Uo4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YK8gescl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709778108;
	bh=wcNAje16nLUZs0HlstOnpDC5DqRaA1co8aNRDvbCu00=;
	h=From:To:Cc:Subject:Date:From;
	b=YK8gescl/5NNxDHgaHtwle1MrckketDstG9otWe59J776ReobQRKuJyYHBlD5auml
	 FoHuaHArOf+ULXKFLEK1RPuyIlNmOA10LeCnrW26dP/hCG2liEf4OwIlWH6bur5iG3
	 kKzTp6y9Gz1cxGnUzqhmHztC+nWiKur3rE5O8c1h8Wa3EGSrEpgCwk847kKVR9ckXb
	 wzYOCJCmqI5rjgWrbe1Jpao1SFShQ3vQAi+hZTyNC0BYPnO7Zf8d57GpEUlxmH/IZ+
	 oG2r/98BPG+j/eLLAM6dXMB4dSAH9C0Ho8E6Rr/onr/48o7S4MmztLM0SZEGEVw+NA
	 pmhlL3t4nEsWw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 95FF737820DA;
	Thu,  7 Mar 2024 02:21:45 +0000 (UTC)
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
Subject: [PATCH v3] drm/ci: update device type for volteer devices
Date: Thu,  7 Mar 2024 07:48:41 +0530
Message-Id: <20240307021841.100561-1-vignesh.raman@collabora.com>
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

Fixes: 0119c894ab0d ("drm: Add initial ci/ subdirectory")
Reviewed-by: David Heidelberg <david.heidelberg@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Add fixes tag so change gets propagated to stable.
    https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1119672

v3:
  - Fix checkpatch warning.
    Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' 

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


