Return-Path: <linux-kernel+bounces-94949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E52874718
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D4C1C22899
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D38414AB2;
	Thu,  7 Mar 2024 04:11:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F601B962
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709784663; cv=none; b=tdk2EIqUDRLlvsaxYix47JL4rFSu2RBqaq2vhfTLqc0dzs9v8DMoF7aoYm6ACTFqkG9ovp0fuDYHOt6cFdIqm6HUwRzdH4OQqXT8a+6n8BgnTQnXv760PEqQ9QxFfsAJf9zbhmR1OD8H+By8vcyRvEk7AzcEntJpXS0FHkD5d5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709784663; c=relaxed/simple;
	bh=k3qyKkv+E2ApIfcL1QbQsAKtPsA5QPQNEmbqxrXiekc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A8z3id41xxTaK9ICpE8NXJCbuf4iLmFrFjE9iRb6Kfl85ryRtd8/DRcATMZ1NwgwSTI+RNrdqpEia2P3LK/jDli/U1c0WulkWzKio9mPmfcw3+/wcO6TJoZ95FlUhR4mwcK8g+CA3SbTfTAOlgr0z8+41n4Qp82TQqayv+I/+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 4274AqAn3587923;
	Thu, 7 Mar 2024 09:40:52 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4274Ap3c3587922;
	Thu, 7 Mar 2024 09:40:51 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Mukul Joshi <mukul.joshi@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2] drm/amdgpu: add vm fault information to devcoredump
Date: Thu,  7 Mar 2024 09:40:37 +0530
Message-Id: <20240307041037.3587797-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add page fault information to the devcoredump.

Output of devcoredump:
**** AMDGPU Device Coredump ****
version: 1
kernel: 6.7.0-amd-staging-drm-next
module: amdgpu
time: 29.725011811
process_name: soft_recovery_p PID: 1720

Ring timed out details
IP Type: 0 Ring Name: gfx_0.0.0

[gfxhub] Page fault observed
Faulty page starting at address 0x0000000000000000
Protection fault status register:0x301031

VRAM is lost due to GPU reset!

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 147100c27c2d..1c1dc3162a14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -203,8 +203,19 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   coredump->ring->name);
 	}
 
+	if (coredump->fault_info.status) {
+		struct amdgpu_vm_fault_info *fault_info = &coredump->fault_info;
+
+		drm_printf(&p, "\n[%s] Page fault observed\n",
+			   fault_info->vmhub ? "mmhub" : "gfxhub");
+		drm_printf(&p, "Faulty page starting at address 0x%016llx\n",
+			   fault_info->addr);
+		drm_printf(&p, "Protection fault status register:0x%x\n",
+			   fault_info->status);
+	}
+
 	if (coredump->reset_vram_lost)
-		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
+		drm_printf(&p, "\nVRAM is lost due to GPU reset!\n");
 	if (coredump->adev->reset_info.num_regs) {
 		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
 
@@ -253,6 +264,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 	if (job) {
 		s_job = &job->base;
 		coredump->ring = to_amdgpu_ring(s_job->sched);
+		coredump->fault_info = job->vm->fault_info;
 	}
 
 	coredump->adev = adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 60522963aaca..3197955264f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -98,6 +98,7 @@ struct amdgpu_coredump_info {
 	struct timespec64               reset_time;
 	bool                            reset_vram_lost;
 	struct amdgpu_ring			*ring;
+	struct amdgpu_vm_fault_info	fault_info;
 };
 #endif
 
-- 
2.34.1


