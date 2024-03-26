Return-Path: <linux-kernel+bounces-119190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9988C54C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF37B252BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A89413C3D9;
	Tue, 26 Mar 2024 14:38:17 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200F13C3D0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463896; cv=none; b=na9pDGSrsJiPJ1dYgRXSMxFE78H9w4zwu7q4UYN+Ug+nEfK4rRv9ah5A+LWGmh5TU272oRNkdYyRDX5OqGHN6mO6ClpC4Bx56lp3AWi0mpEY4N461I4eVaTqe2k9nZt69awyOi6h8goc8q8DzQLq2p+IuDKyoxL8XVvy6YUPRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463896; c=relaxed/simple;
	bh=43omAjlq2ZrWI3KlUvCu83WnZVKo8Vnn4E/RJ2eoZkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hOojiOJWV3jmiftEGCn9QGVrt6AwsNyjaQ/YQVmN5M1n2WmIqzeWvKTMpao/CVwZIysVjxVVAihjmBmoa3nKCN9wqdhiSBs45zLBkyrQwWqbGBYBve9ryMBVAMgAp6CHM3KZNn1pfgGk+t+DysAUYhMsFZNHlDOGEUq2NymzqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 42QEbt622292989;
	Tue, 26 Mar 2024 20:07:55 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 42QEbshY2292982;
	Tue, 26 Mar 2024 20:07:54 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: add support of bios dump in devcoredump
Date: Tue, 26 Mar 2024 20:07:50 +0530
Message-Id: <20240326143750.2292945-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dump the bios binary in the devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 44c5da8aa9ce..f33963d777eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -132,6 +132,26 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 	drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
 	drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
 
+	/* Dump BIOS */
+	if (coredump->adev->bios && coredump->adev->bios_size) {
+		int i = 0;
+
+		drm_printf(&p, "BIOS Binary dump\n");
+		drm_printf(&p, "Valid BIOS  Size:%d bytes type:%s\n",
+			   coredump->adev->bios_size,
+			   coredump->adev->is_atom_fw ?
+			   "Atom bios":"Non Atom Bios");
+
+		while (i < coredump->adev->bios_size) {
+			/* Printing 15 bytes in a line */
+			if (i % 15 == 0)
+				drm_printf(&p, "\n");
+			drm_printf(&p, "0x%x \t", coredump->adev->bios[i]);
+			i++;
+		}
+		drm_printf(&p, "\n");
+	}
+
 	/* Add ring buffer information */
 	drm_printf(&p, "Ring buffer information\n");
 	for (int i = 0; i < coredump->adev->num_rings; i++) {
-- 
2.34.1


