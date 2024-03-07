Return-Path: <linux-kernel+bounces-95902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950088754C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57BE1C2311C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F912FF92;
	Thu,  7 Mar 2024 17:00:53 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B069412FF60
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830852; cv=none; b=ryNTb/w+cb26WQ2+1y7eXm136kcA5r2WpA5y7Rt+idlqFQLZ739Opc3gGxTVU0R8c4FHai4EjI4hrW7M8DHJTfvggzEqkjqcllN8g88lfoJ3lZOtsDaDDIlp4myzuMkpATwXHf9udzZt0XZ7YjooDqNrdF+4w2W/jFcqWMeCZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830852; c=relaxed/simple;
	bh=x81ybjupnyX+PAUmlHwHcC5WFsdaIVVpOu7gQj0Xl4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rxFvu5bxzJe3Em32xSo32f5sby3HtUk/JwN83GJhIlG9Nr8CXyTFSA+dIS91YX9mx2hxaZEfimPUs2UQSpw6QPy+hUcDY1kZMZDNNgUmWVAKQSn9muPgLMo/524YRm58kdJlmuBSKbnGbGc8hk3pLqMd1KtK70JMU83fwsxcG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 427H0bgb3857411;
	Thu, 7 Mar 2024 22:30:37 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 427H0bGp3857410;
	Thu, 7 Mar 2024 22:30:37 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Mukul Joshi <mukul.joshi@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add vm fault information to devcoredump
Date: Thu,  7 Mar 2024 22:29:32 +0530
Message-Id: <20240307165932.3856952-3-sunil.khatri@amd.com>
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
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 147100c27c2d..dd39e614d907 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -203,8 +203,20 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   coredump->ring->name);
 	}
 
+	if (coredump->adev) {
+		struct amdgpu_vm_fault_info *fault_info =
+			&coredump->adev->vm_manager.fault_info;
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
 
-- 
2.34.1


