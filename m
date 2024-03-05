Return-Path: <linux-kernel+bounces-92110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F002871B47
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150A91F216AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91A57322;
	Tue,  5 Mar 2024 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0A7eN71r"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024453E03
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633836; cv=none; b=ZGqL7vXvRIOzlNzirP8CsIwivXizXd4FJmrG2LXtFEReOhIgtSpeb75cS/90J40alLvp9KYdgEwRpTbsNKJmP1WWMclzbp7kiGMIhMA2hhtO1iZ2xBdXm7hkM8rY8z3b4KJd9JOV9MaWQhchlEH3+3b55Exhpsfn+0lH+3EcbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633836; c=relaxed/simple;
	bh=b7UcicYM6WU8vJRmKmFjap9G0GMKJpkN4ML3k9zwggk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X/mhY0Y5+TWaO0SAMM0phk21ryTwuyKQ3XDmOMr2tOu2IefxIq6ln9CXtHVOOhxoS+qyTHAFsHUIX5lRe6h5twOlVtRO0LRRrOuLvfOvYM5HkK8sQ1UwLOzN3/NMHDQlInKsvwstts+cVQJQgG/zrWWUl/JmdJcMD3gmrAgpri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0A7eN71r; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709633832;
	bh=b7UcicYM6WU8vJRmKmFjap9G0GMKJpkN4ML3k9zwggk=;
	h=From:To:Cc:Subject:Date:From;
	b=0A7eN71rp+UmAoxwyim+zhX2GcJKHy8D8BNGiyNBc65PzZfcTxY5pqLL8kkAoXbLN
	 Ndxdhbdls9ML9rNipM2Gu4y0L2/KUkrrxrceTJR/K4B6IZ29HS72Xwx0kg3EFMTshT
	 MRvsb5kRVD9H/iajJmDV0qoxOoT/Skrnld2+O9fwdlCaiggS43sBQvEsRJymkZLnQe
	 h5FI1Z7hXI6Q6CFsmRe6UzndZrfTJxc7jZZpOQ5uMTXoNsOI6QsM3/mRKECSfVHmQp
	 a5W6gFtsseZeVLiGi4UbvwTm2b0Jd4uualf50P+9fjudEFYfDpfn+qImzinYZEusNf
	 JfzUsx+AgwJzw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4F7833781FEF;
	Tue,  5 Mar 2024 10:17:08 +0000 (UTC)
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
Subject: [PATCH] drm/ci: update device type for volteer devices
Date: Tue,  5 Mar 2024 15:46:26 +0530
Message-Id: <20240305101626.36357-1-vignesh.raman@collabora.com>
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

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
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


