Return-Path: <linux-kernel+bounces-94387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED4B873E64
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C321F213FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B7A13E7D1;
	Wed,  6 Mar 2024 18:20:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AED13E7D7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749202; cv=none; b=osstAh/ccFkYDQDuwjXvwvF3BuTk7V1cP6C0x9pLBURdx+mMiVRV0h+TNJtnKFNIUKyILEJaiLzVaQihjaV/TFDNRzRhQzLWP2s+dSTihmc6DON3hrGvlt7gQMIMOQSnXV9/e4x/N2wmqlpG1Bl4kXHFOq3PLx46jTFrLKGLdug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749202; c=relaxed/simple;
	bh=+iollw6RNHf4rVAe+1PGyDqPPQwM/B5Io5R9gOBtVdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2Vy8vmeyenlMi7csdTANoE0Bisc/TK5HhhZi4Lo7rugnjCC/6Eu9mOnSMURiWTDb6rPxmqofJneOzuiE2enIJwO9I4JZCcP5ZWu1D/tauQfR0XVMgQh0oM8nVYEpI3GwlpdX220YFAwmpZVbvHr5wXHx9ZlHVVMhebJgAuEwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 426IJqHF3551787;
	Wed, 6 Mar 2024 23:49:52 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 426IJqmh3551786;
	Wed, 6 Mar 2024 23:49:52 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Mukul Joshi <mukul.joshi@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: add vm fault information to devcoredump
Date: Wed,  6 Mar 2024 23:49:37 +0530
Message-Id: <20240306181937.3551648-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306181937.3551648-1-sunil.khatri@amd.com>
References: <20240306181937.3551648-1-sunil.khatri@amd.com>
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

[gfxhub] Page fault observed for GPU family:143
Faulty page starting at address 0x0000000000000000
Protection fault status register:0x301031

VRAM is lost due to GPU reset!

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 147100c27c2d..d7fea6cdf2f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -203,8 +203,20 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   coredump->ring->name);
 	}
 
+	if (coredump->fault_info.status) {
+		struct amdgpu_vm_fault_info *fault_info = &coredump->fault_info;
+
+		drm_printf(&p, "\n[%s] Page fault observed for GPU family:%d\n",
+			   fault_info->vmhub ? "mmhub" : "gfxhub",
+			   coredump->adev->family);
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
 
@@ -253,6 +265,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
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


