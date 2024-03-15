Return-Path: <linux-kernel+bounces-104382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE3187CD12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AAD283703
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E86E1C28B;
	Fri, 15 Mar 2024 12:13:34 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FE01B7F6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710504813; cv=none; b=dx+uS0Cq+NYt8/td/LhbjlWKRlWIgAftH34t/wzRn/TRknU93fyrOWyClJyRB1Dwm+fvsl5AZGDWsyei6zfqB0EucZVvMsu6aGRdoKcYIOJrZjLH5wu2r+TDr8279NK/VAEsu2wxZJyGkyZhQuTzu+FtJku9CO3JQQ/pVwwGMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710504813; c=relaxed/simple;
	bh=ChL5GpheItVSCs3jljAJjr/cxtujnaEIwTsNjiye2oE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B0Xpwh9RO9ncwIWLdBzrShUwM9zJbcCrCl/e1mxHTvIlaPJs5+wF+riUosQhba09kvEGMW/Lg4W+u8WFDhs41hdKIpHu9906azn3c8QhTPmqrjtn2EAWt4T1t0nCib4G/ONjTZ2ac6eD8iucNH6uUBoljGG+8GzzzprCtUymITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 42FCDHcQ406627;
	Fri, 15 Mar 2024 17:43:17 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 42FCDGq3406620;
	Fri, 15 Mar 2024 17:43:16 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: add the hw_ip version of all IP's
Date: Fri, 15 Mar 2024 17:43:15 +0530
Message-Id: <20240315121315.406601-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add all the IP's version information on a SOC to the
devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 62 +++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index a0dbccad2f53..3d4bfe0a5a7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -29,6 +29,43 @@
 #include "sienna_cichlid.h"
 #include "smu_v13_0_10.h"
 
+const char *hw_ip_names[MAX_HWIP] = {
+	[GC_HWIP]		= "GC",
+	[HDP_HWIP]		= "HDP",
+	[SDMA0_HWIP]		= "SDMA0",
+	[SDMA1_HWIP]		= "SDMA1",
+	[SDMA2_HWIP]		= "SDMA2",
+	[SDMA3_HWIP]		= "SDMA3",
+	[SDMA4_HWIP]		= "SDMA4",
+	[SDMA5_HWIP]		= "SDMA5",
+	[SDMA6_HWIP]		= "SDMA6",
+	[SDMA7_HWIP]		= "SDMA7",
+	[LSDMA_HWIP]		= "LSDMA",
+	[MMHUB_HWIP]		= "MMHUB",
+	[ATHUB_HWIP]		= "ATHUB",
+	[NBIO_HWIP]		= "NBIO",
+	[MP0_HWIP]		= "MP0",
+	[MP1_HWIP]		= "MP1",
+	[UVD_HWIP]		= "UVD/JPEG/VCN",
+	[VCN1_HWIP]		= "VCN1",
+	[VCE_HWIP]		= "VCE",
+	[VPE_HWIP]		= "VPE",
+	[DF_HWIP]		= "DF",
+	[DCE_HWIP]		= "DCE",
+	[OSSSYS_HWIP]		= "OSSSYS",
+	[SMUIO_HWIP]		= "SMUIO",
+	[PWR_HWIP]		= "PWR",
+	[NBIF_HWIP]		= "NBIF",
+	[THM_HWIP]		= "THM",
+	[CLK_HWIP]		= "CLK",
+	[UMC_HWIP]		= "UMC",
+	[RSMU_HWIP]		= "RSMU",
+	[XGMI_HWIP]		= "XGMI",
+	[DCI_HWIP]		= "DCI",
+	[PCIE_HWIP]		= "PCIE",
+};
+
+
 int amdgpu_reset_init(struct amdgpu_device *adev)
 {
 	int ret = 0;
@@ -196,6 +233,31 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   coredump->reset_task_info.process_name,
 			   coredump->reset_task_info.pid);
 
+	/* GPU IP's information of the SOC */
+	if (coredump->adev) {
+
+		drm_printf(&p, "\nIP Information\n");
+		drm_printf(&p, "SOC Family: %d\n", coredump->adev->family);
+		drm_printf(&p, "SOC Revision id: %d\n", coredump->adev->rev_id);
+		drm_printf(&p, "SOC External Revision id: %d\n",
+			   coredump->adev->external_rev_id);
+
+		for (int i = 1; i < MAX_HWIP; i++) {
+			for (int j = 0; j < HWIP_MAX_INSTANCE; j++) {
+				int ver = coredump->adev->ip_versions[i][j];
+
+				if (ver)
+					drm_printf(&p, "HWIP: %s[%d][%d]: v%d.%d.%d.%d.%d\n",
+						   hw_ip_names[i], i, j,
+						   IP_VERSION_MAJ(ver),
+						   IP_VERSION_MIN(ver),
+						   IP_VERSION_REV(ver),
+						   IP_VERSION_VARIANT(ver),
+						   IP_VERSION_SUBREV(ver));
+			}
+		}
+	}
+
 	if (coredump->ring) {
 		drm_printf(&p, "\nRing timed out details\n");
 		drm_printf(&p, "IP Type: %d Ring Name: %s\n",
-- 
2.34.1


