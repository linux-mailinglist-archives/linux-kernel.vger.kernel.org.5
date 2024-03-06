Return-Path: <linux-kernel+bounces-94386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4F873E63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF621F21AD0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC1137C29;
	Wed,  6 Mar 2024 18:19:56 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DFD133425
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749195; cv=none; b=pyEHPm8WV+x+FZqgKfPjuMCvy13gRa/AgWITjAQoT5RoFC2u/D2nXZxv7RYuycsBIXcey8de+mG3GdjyWhOG7jeyyU9UZWcJiFzT02PxnCrXSyT1R8x2cDNa1ziFRD7TkAvXu40QJIp9b6AwfZXrVDxkBI33Sz9bSrxs4KfQB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749195; c=relaxed/simple;
	bh=UwSlKwtqtVaCmHsmrNN30TBWPNUuqZE56UeFYKoLeD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hbVdVZTsDguCzeZWb7mB2gaqxwnjl1fUx08fLleZc4WaT67devvGZ0Xn9vqvNLPp7Anc47wA0SCYhW/Pha/OEPSknVDKJslVyq0LTmZAmWhQNOk8Tg9JSUqDjeubAc8e/QfaVj3nkr0j6qmdgYvW8+222noASdBajjsiV5b84Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 426IJdCc3551676;
	Wed, 6 Mar 2024 23:49:39 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 426IJdIe3551675;
	Wed, 6 Mar 2024 23:49:39 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Mukul Joshi <mukul.joshi@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: cache in more vm fault information
Date: Wed,  6 Mar 2024 23:49:36 +0530
Message-Id: <20240306181937.3551648-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an  page fault interrupt is raised there
is a lot more information that is useful for
developers to analyse the pagefault.

Add all such information in the last cached
pagefault from an interrupt handler.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 2 +-
 7 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4299ce386322..b77e8e28769d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2905,7 +2905,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
  * Cache the fault info for later use by userspace in debugging.
  */
 void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
-				  unsigned int pasid,
+				  struct amdgpu_iv_entry *entry,
 				  uint64_t addr,
 				  uint32_t status,
 				  unsigned int vmhub)
@@ -2915,7 +2915,7 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 
 	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
 
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	vm = xa_load(&adev->vm_manager.pasids, entry->pasid);
 	/* Don't update the fault cache if status is 0.  In the multiple
 	 * fault case, subsequent faults will return a 0 status which is
 	 * useless for userspace and replaces the useful fault status, so
@@ -2924,6 +2924,11 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 	if (vm && status) {
 		vm->fault_info.addr = addr;
 		vm->fault_info.status = status;
+		vm->fault_info.client_id = entry->client_id;
+		vm->fault_info.src_id = entry->src_id;
+		vm->fault_info.vmid = entry->vmid;
+		vm->fault_info.pasid = entry->pasid;
+		vm->fault_info.ring_id = entry->ring_id;
 		if (AMDGPU_IS_GFXHUB(vmhub)) {
 			vm->fault_info.vmhub = AMDGPU_VMHUB_TYPE_GFX;
 			vm->fault_info.vmhub |=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 047ec1930d12..c7782a89bdb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -286,6 +286,11 @@ struct amdgpu_vm_fault_info {
 	uint32_t	status;
 	/* which vmhub? gfxhub, mmhub, etc. */
 	unsigned int	vmhub;
+	unsigned int	client_id;
+	unsigned int	src_id;
+	unsigned int	ring_id;
+	unsigned int	pasid;
+	unsigned int	vmid;
 };
 
 struct amdgpu_vm {
@@ -605,7 +610,7 @@ static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
 }
 
 void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
-				  unsigned int pasid,
+				  struct amdgpu_iv_entry *entry,
 				  uint64_t addr,
 				  uint32_t status,
 				  unsigned int vmhub);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d933e19e0cf5..6b177ce8db0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -150,7 +150,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
-		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
+		amdgpu_vm_update_fault_cache(adev, entry, addr, status,
 					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 527dc917e049..bcf254856a3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -121,7 +121,7 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 		status = RREG32(hub->vm_l2_pro_fault_status);
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
-		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
+		amdgpu_vm_update_fault_cache(adev, entry, addr, status,
 					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 3da7b6a2b00d..e9517ebbe1fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1270,7 +1270,7 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 	if (!addr && !status)
 		return 0;
 
-	amdgpu_vm_update_fault_cache(adev, entry->pasid,
+	amdgpu_vm_update_fault_cache(adev, entry,
 				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status, AMDGPU_GFXHUB(0));
 
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index d20e5f20ee31..a271bf832312 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1438,7 +1438,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	if (!addr && !status)
 		return 0;
 
-	amdgpu_vm_update_fault_cache(adev, entry->pasid,
+	amdgpu_vm_update_fault_cache(adev, entry,
 				     ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status, AMDGPU_GFXHUB(0));
 
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 47b63a4ce68b..dc9fb1fb9540 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -666,7 +666,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, RW);
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
-	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
+	amdgpu_vm_update_fault_cache(adev, entry, addr, status, vmhub);
 
 	dev_err(adev->dev,
 		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
-- 
2.34.1


