Return-Path: <linux-kernel+bounces-105739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF23887E3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFE31F21524
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25DA22337;
	Mon, 18 Mar 2024 06:29:49 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACAB2206B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710743389; cv=none; b=ArT/DE6b5h191z2idHTCiUvNYgZRNtw6B0RWcCNyz4B8mXzPeOe7PsUukxbQNsxpwEvJaYbFu9p9GphO4OVC+4ROZ7DC6mSs9q2rM0LSkoK97/gOinwI3FD9hwVPYkytMe7KhXor23OhlsCId6KmLEvLP28svD0+IcrLMNMFHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710743389; c=relaxed/simple;
	bh=7jvQOzUJqW0xMgnNlhRG9qLmbztRbUK6pROxk+hT+lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EU+2Snk0HVQw34FUc5lkareijHIZiTkn1+X734tVU+Y8IOcrSUk7Z4HcW9Lgxt9ez9omfTPNH7tmtd174Hw8XXErHCU/OzhuAjwZ9/jf4TZRAMBfI/joIWwXOSV79g9LuqjCSj1x/lXgRJg48vqlC5F9GIwSlwOvwZvNv7RZ7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 42I6TQxT541993;
	Mon, 18 Mar 2024 11:59:26 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 42I6TPKA541992;
	Mon, 18 Mar 2024 11:59:25 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sunil Khatri <sunil.khatri@amd.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amdgpu: remove the adev check for NULL
Date: Mon, 18 Mar 2024 11:59:00 +0530
Message-Id: <20240318062900.541823-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adev is a global data structure and isn't expected
to be NULL and hence removing the redundant adev
check from the devcoredump code.

CC: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 57 ++++++++++-------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 1434e9a5506b..3398f2a368d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -211,7 +211,8 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 	struct drm_printer p;
 	struct amdgpu_coredump_info *coredump = data;
 	struct drm_print_iterator iter;
-	int i;
+	struct amdgpu_vm_fault_info *fault_info;
+	int i, ver;
 
 	iter.data = buffer;
 	iter.offset = 0;
@@ -233,26 +234,22 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   coredump->reset_task_info.pid);
 
 	/* GPU IP's information of the SOC */
-	if (coredump->adev) {
-		drm_printf(&p, "\nIP Information\n");
-		drm_printf(&p, "SOC Family: %d\n", coredump->adev->family);
-		drm_printf(&p, "SOC Revision id: %d\n", coredump->adev->rev_id);
-		drm_printf(&p, "SOC External Revision id: %d\n",
-			   coredump->adev->external_rev_id);
-
-		for (int i = 1; i < MAX_HWIP; i++) {
-			for (int j = 0; j < HWIP_MAX_INSTANCE; j++) {
-				int ver = coredump->adev->ip_versions[i][j];
-
-				if (ver)
-					drm_printf(&p, "HWIP: %s[%d][%d]: v%d.%d.%d.%d.%d\n",
-						   hw_ip_names[i], i, j,
-						   IP_VERSION_MAJ(ver),
-						   IP_VERSION_MIN(ver),
-						   IP_VERSION_REV(ver),
-						   IP_VERSION_VARIANT(ver),
-						   IP_VERSION_SUBREV(ver));
-			}
+	drm_printf(&p, "\nIP Information\n");
+	drm_printf(&p, "SOC Family: %d\n", coredump->adev->family);
+	drm_printf(&p, "SOC Revision id: %d\n", coredump->adev->rev_id);
+	drm_printf(&p, "SOC External Revision id: %d\n", coredump->adev->external_rev_id);
+
+	for (int i = 1; i < MAX_HWIP; i++) {
+		for (int j = 0; j < HWIP_MAX_INSTANCE; j++) {
+			ver = coredump->adev->ip_versions[i][j];
+			if (ver)
+				drm_printf(&p, "HWIP: %s[%d][%d]: v%d.%d.%d.%d.%d\n",
+					   hw_ip_names[i], i, j,
+					   IP_VERSION_MAJ(ver),
+					   IP_VERSION_MIN(ver),
+					   IP_VERSION_REV(ver),
+					   IP_VERSION_VARIANT(ver),
+					   IP_VERSION_SUBREV(ver));
 		}
 	}
 
@@ -263,18 +260,14 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   coredump->ring->name);
 	}
 
-	if (coredump->adev) {
-		struct amdgpu_vm_fault_info *fault_info =
-			&coredump->adev->vm_manager.fault_info;
-
-		drm_printf(&p, "\n[%s] Page fault observed\n",
-			   fault_info->vmhub ? "mmhub" : "gfxhub");
-		drm_printf(&p, "Faulty page starting at address: 0x%016llx\n",
-			   fault_info->addr);
-		drm_printf(&p, "Protection fault status register: 0x%x\n\n",
-			   fault_info->status);
-	}
+	/* Add page fault information */
+	fault_info = &coredump->adev->vm_manager.fault_info;
+	drm_printf(&p, "\n[%s] Page fault observed\n",
+		   fault_info->vmhub ? "mmhub" : "gfxhub");
+	drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
+	drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
 
+	/* Add ring buffer information */
 	drm_printf(&p, "Ring buffer information\n");
 	for (int i = 0; i < coredump->adev->num_rings; i++) {
 		int j = 0;
-- 
2.34.1


