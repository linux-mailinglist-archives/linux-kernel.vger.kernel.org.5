Return-Path: <linux-kernel+bounces-119600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0D888CAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032702C60E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036F31CFBE;
	Tue, 26 Mar 2024 17:31:58 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD51CF8D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474317; cv=none; b=VkMmu2dlgZp9bjULeJTUGLtQfgUp/9YEKxeq/5SkqBTopCh8p0f7Bmsu4s+Xbv5eNeigCx6JGaWtgPrZG5lgtKxmCkZJPsmdKGUMLNt1XQ1k2Hr4vmiyf1VhOtDCX8u8m3LtaSfIdLaQaiTugUj8Uf52z0FHa4gj6qv0cazj9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474317; c=relaxed/simple;
	bh=1doTDbfUIsSx7SCqi/b7+CwUUWwogQrO+137VujhPzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kW8z+zgcSq3idrT0FZvjcFYwKopOYBJEKhB1wqRFk1mpKY4Rj6B4f/15+Zlghxg8/sYEFcFjPeXVyVIoRorajSDyI5SyLIytKfojff9YT2Neh7FovzH+0XhzJE0/6B7rv72AVoA8o8YPN8vpiar6Fr9k9IakrE+h1C2Lk2bx8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 42QHVjVC2324656;
	Tue, 26 Mar 2024 23:01:45 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 42QHVj7W2324649;
	Tue, 26 Mar 2024 23:01:45 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: add IP's FW information to devcoredump
Date: Tue, 26 Mar 2024 23:01:42 +0530
Message-Id: <20240326173142.2324624-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add FW information of all the IP's in the devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 44c5da8aa9ce..d598b6520ec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -69,6 +69,124 @@ const char *hw_ip_names[MAX_HWIP] = {
 	[PCIE_HWIP]		= "PCIE",
 };
 
+static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
+				       struct drm_printer *p)
+{
+	uint32_t version;
+	uint32_t feature;
+	uint8_t smu_program, smu_major, smu_minor, smu_debug;
+
+	drm_printf(p, "VCE feature version: %u, fw version: 0x%08x\n",
+		   adev->vce.fb_version, adev->vce.fw_version);
+	drm_printf(p, "UVD feature version: %u, fw version: 0x%08x\n", 0,
+		   adev->uvd.fw_version);
+	drm_printf(p, "GMC feature version: %u, fw version: 0x%08x\n", 0,
+		   adev->gmc.fw_version);
+	drm_printf(p, "ME feature version: %u, fw version: 0x%08x\n",
+		   adev->gfx.me_feature_version, adev->gfx.me_fw_version);
+	drm_printf(p, "PFP feature version: %u, fw version: 0x%08x\n",
+		   adev->gfx.pfp_feature_version, adev->gfx.pfp_fw_version);
+	drm_printf(p, "CE feature version: %u, fw version: 0x%08x\n",
+		   adev->gfx.ce_feature_version, adev->gfx.ce_fw_version);
+	drm_printf(p, "RLC feature version: %u, fw version: 0x%08x\n",
+		   adev->gfx.rlc_feature_version, adev->gfx.rlc_fw_version);
+
+	drm_printf(p, "RLC SRLC feature version: %u, fw version: 0x%08x\n",
+		   adev->gfx.rlc_srlc_feature_version,
+		   adev->gfx.rlc_srlc_fw_version);
+	drm_printf(p, "RLC SRLG feature version: %u, fw version: 0x%08x\n",
+		   adev->gfx.rlc_srlg_feature_version,
+		   adev->gfx.rlc_srlg_fw_version);
+	drm_printf(p, "RLC SRLS feature version: %u, fw version: 0x%08x\n",
+		   adev->gfx.rlc_srls_feature_version,
+		   adev->gfx.rlc_srls_fw_version);
+	drm_printf(p, "RLCP feature version: %u, fw version: 0x%08x\n",
+		   adev->gfx.rlcp_ucode_feature_version,
+		   adev->gfx.rlcp_ucode_version);
+	drm_printf(p, "RLCV feature version: %u, fw version: 0x%08x\n",
+		   adev->gfx.rlcv_ucode_feature_version,
+		   adev->gfx.rlcv_ucode_version);
+	drm_printf(p, "MEC feature version: %u, fw version: 0x%08x\n",
+		   adev->gfx.mec_feature_version, adev->gfx.mec_fw_version);
+
+	if (adev->gfx.mec2_fw)
+		drm_printf(p, "MEC2 feature version: %u, fw version: 0x%08x\n",
+			   adev->gfx.mec2_feature_version,
+			   adev->gfx.mec2_fw_version);
+
+	drm_printf(p, "IMU feature version: %u, fw version: 0x%08x\n", 0,
+		   adev->gfx.imu_fw_version);
+	drm_printf(p, "PSP SOS feature version: %u, fw version: 0x%08x\n",
+		   adev->psp.sos.feature_version, adev->psp.sos.fw_version);
+	drm_printf(p, "PSP ASD feature version: %u, fw version: 0x%08x\n",
+		   adev->psp.asd_context.bin_desc.feature_version,
+		   adev->psp.asd_context.bin_desc.fw_version);
+
+	drm_printf(p, "TA XGMI feature version: 0x%08x, fw version: 0x%08x\n",
+		   adev->psp.xgmi_context.context.bin_desc.feature_version,
+		   adev->psp.xgmi_context.context.bin_desc.fw_version);
+	drm_printf(p, "TA RAS feature version: 0x%08x, fw version: 0x%08x\n",
+		   adev->psp.ras_context.context.bin_desc.feature_version,
+		   adev->psp.ras_context.context.bin_desc.fw_version);
+	drm_printf(p, "TA HDCP feature version: 0x%08x, fw version: 0x%08x\n",
+		   adev->psp.hdcp_context.context.bin_desc.feature_version,
+		   adev->psp.hdcp_context.context.bin_desc.fw_version);
+	drm_printf(p, "TA DTM feature version: 0x%08x, fw version: 0x%08x\n",
+		   adev->psp.dtm_context.context.bin_desc.feature_version,
+		   adev->psp.dtm_context.context.bin_desc.fw_version);
+	drm_printf(p, "TA RAP feature version: 0x%08x, fw version: 0x%08x\n",
+		   adev->psp.rap_context.context.bin_desc.feature_version,
+		   adev->psp.rap_context.context.bin_desc.fw_version);
+	drm_printf(
+		p,
+		"TA SECURE DISPLAY feature version: 0x%08x, fw version: 0x%08x\n",
+		adev->psp.securedisplay_context.context.bin_desc.feature_version,
+		adev->psp.securedisplay_context.context.bin_desc.fw_version);
+
+	/* SMC firmware */
+	version = adev->pm.fw_version;
+
+	smu_program = (version >> 24) & 0xff;
+	smu_major = (version >> 16) & 0xff;
+	smu_minor = (version >> 8) & 0xff;
+	smu_debug = (version >> 0) & 0xff;
+	drm_printf(p,
+		   "SMC feature version: %u, program: %d, fw version: 0x%08x (%d.%d.%d)\n",
+		   0, smu_program, version, smu_major, smu_minor, smu_debug);
+
+	/* SDMA firmware */
+	for (int i = 0; i < adev->sdma.num_instances; i++) {
+		drm_printf(p,
+			   "SDMA%d feature version: %u, firmware version: 0x%08x\n",
+			   i, adev->sdma.instance[i].feature_version,
+			   adev->sdma.instance[i].fw_version);
+	}
+
+	drm_printf(p, "VCN feature version: %u, fw version: 0x%08x\n", 0,
+		   adev->vcn.fw_version);
+	drm_printf(p, "DMCU feature version: %u, fw version: 0x%08x\n", 0,
+		   adev->dm.dmcu_fw_version);
+	drm_printf(p, "DMCUB feature version: %u, fw version: 0x%08x\n", 0,
+		   adev->dm.dmcub_fw_version);
+	drm_printf(p, "PSP TOC feature version: %u, fw version: 0x%08x\n",
+		   adev->psp.toc.feature_version, adev->psp.toc.fw_version);
+
+	version = adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK;
+	feature = (adev->mes.kiq_version & AMDGPU_MES_FEAT_VERSION_MASK) >>
+		  AMDGPU_MES_FEAT_VERSION_SHIFT;
+	drm_printf(p, "MES_KIQ feature version: %u, fw version: 0x%08x\n",
+		   feature, version);
+
+	version = adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
+	feature = (adev->mes.sched_version & AMDGPU_MES_FEAT_VERSION_MASK) >>
+		  AMDGPU_MES_FEAT_VERSION_SHIFT;
+	drm_printf(p, "MES feature version: %u, fw version: 0x%08x\n", feature,
+		   version);
+
+	drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
+		   adev->vpe.feature_version, adev->vpe.fw_version);
+}
+
 static ssize_t
 amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen)
@@ -118,6 +236,10 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 		}
 	}
 
+	/* IP firmware information */
+	drm_printf(&p, "\nIP Firmwares\n");
+	amdgpu_devcoredump_fw_info(coredump->adev, &p);
+
 	if (coredump->ring) {
 		drm_printf(&p, "\nRing timed out details\n");
 		drm_printf(&p, "IP Type: %d Ring Name: %s\n",
-- 
2.34.1


