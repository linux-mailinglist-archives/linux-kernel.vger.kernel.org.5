Return-Path: <linux-kernel+bounces-95901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 279458754BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592F31C22A46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319F130AC1;
	Thu,  7 Mar 2024 17:00:37 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8487812FF60
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830837; cv=none; b=P/3gthLo9G4RJ7tWKfSCefmzM5K6+AyqhCeNizeLfJymsR2kC5F8r2xAWjdyEyTcMhGNI5GCnKf4p2T4/Y6vt2fAL9SBdvBHXxWWrxNHIcFZ0k8WjHL5A/OT4S4GCASZ7iAAMgh6UGfKc+ne2QKDpSUGYy2QSTll7Wj/fHxivGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830837; c=relaxed/simple;
	bh=fqloV27/NI/04cx/aqUgRYcJ7/lE0QhcHUDQkbYUObw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fAuoAZLzWN5hCMv/ILyYHOe1JmuuI2nIDj8/V0DNR2JzYHKDb03KkYH77dZhSlKlrFSuqlVFl1snvYQ+ZgMFIj6HTbm2y9+w7YbfgYRK2m4jY+GQLHU/OvGQ3OTgoslePQzhW+6IqrJuqyDlrSW7yyyz9RQ686IQ+y3Xm1nsEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 427H0Mv13857295;
	Thu, 7 Mar 2024 22:30:22 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 427H0MFH3857294;
	Thu, 7 Mar 2024 22:30:22 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Mukul Joshi <mukul.joshi@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add recent pagefault info in vm_manager
Date: Thu,  7 Mar 2024 22:29:31 +0530
Message-Id: <20240307165932.3856952-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307165932.3856952-1-sunil.khatri@amd.com>
References: <20240307165932.3856952-1-sunil.khatri@amd.com>
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


