Return-Path: <linux-kernel+bounces-96218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F828758D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD201F22826
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3255113A272;
	Thu,  7 Mar 2024 20:51:14 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835613A254
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844673; cv=none; b=epgsYDRS50w0C6CeDu0ersqXYJ+dw9dfFNXSGMU2cXtvgSFi4EFzj5IqyYtCMK7o4iCJclocota/121Q5HEhsEkRS/K8Pqeb8KE62ylb+qJA2QCOsl4V9L5Ems9oRvpFLK/cTo6Elc3LGZVbjJrhyUN8jnW0EQyn6lScDxFEXss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844673; c=relaxed/simple;
	bh=fqloV27/NI/04cx/aqUgRYcJ7/lE0QhcHUDQkbYUObw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FgTHgqvYgZDpSYE9XfJlqwCyQNK4um5xF4tvdFS1d1wUvYy9sQQLPk2sGNzEvnXSFKbUIsrnNMmeqbMr8cdv/+mvrtOl9PoYw6cY4L0kQeEZnVnkpO7IB+hwRJ3fZUoAfcy0I45rTQcyDLEwwUSPTBXNUfX0vUBU+mO7uktoQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 427KoviT3904698;
	Fri, 8 Mar 2024 02:20:57 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 427KovQR3904697;
	Fri, 8 Mar 2024 02:20:57 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Mukul Joshi <mukul.joshi@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: add recent pagefault info in vm_manager
Date: Fri,  8 Mar 2024 02:20:53 +0530
Message-Id: <20240307205054.3904657-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307205054.3904657-1-sunil.khatri@amd.com>
References: <20240307205054.3904657-1-sunil.khatri@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently page fault information is stored per
vm and which could be freed or stale during
reset. Add it pagefault information in the
vm_manager which is a global space for vm's
and remains valid across.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4299ce386322..81fb3465e197 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2924,6 +2924,14 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 	if (vm && status) {
 		vm->fault_info.addr = addr;
 		vm->fault_info.status = status;
+		/*
+		 * Update the fault information globally for later usage
+		 * when vm could be stale or freed.
+		 */
+		adev->vm_manager.fault_info.addr = addr;
+		adev->vm_manager.fault_info.vmhub = vmhub;
+		adev->vm_manager.fault_info.status = status;
+
 		if (AMDGPU_IS_GFXHUB(vmhub)) {
 			vm->fault_info.vmhub = AMDGPU_VMHUB_TYPE_GFX;
 			vm->fault_info.vmhub |=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 047ec1930d12..8efa8422f4f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -422,6 +422,8 @@ struct amdgpu_vm_manager {
 	 * look up VM of a page fault
 	 */
 	struct xarray				pasids;
+	/* Global registration of recent page fault information */
+	struct amdgpu_vm_fault_info	fault_info;
 };
 
 struct amdgpu_bo_va_mapping;
-- 
2.34.1


