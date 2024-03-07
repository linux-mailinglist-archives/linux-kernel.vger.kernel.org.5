Return-Path: <linux-kernel+bounces-96219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12C38758D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF22E1F21CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8548E13A897;
	Thu,  7 Mar 2024 20:51:15 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F013A266
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844675; cv=none; b=YYlRgnfPkXI5x61P5wo1hy4LE8u2U1uJO1UCw3Jr+LY3NgSB8knv9E+lqqO4lJz9Fr2v24gxx5NoiSBTG7x7eehMtf9B8Itai1zqKJ3UYpFIQvNurV9lRuLjYu1MRXSy91QaOdfb/I+x1JLfOoyoM/6zYwwXrC3/mkX5hDwgGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844675; c=relaxed/simple;
	bh=IGHie16VWCVc7VJZoSlxlZA8C3GhSWjGyA97ROXBdZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fv+j02RNtMuytoVJWs8Re4D8Ipw1XvcAu7mFtYiKeVZ9khc/qO5kHKQjkoFGWfmufNzD5ZS0YKFxyUoea5ouuEv+hobGZKt+HqrI0dEEui0aj5jMMFN3Wmfp7+E/BSqSlxQkXDG1FaOceAgwsnswP9t/hJs4gcxMY5XI5qr3POw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 427KowkS3904709;
	Fri, 8 Mar 2024 02:20:58 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 427KowqA3904708;
	Fri, 8 Mar 2024 02:20:58 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Mukul Joshi <mukul.joshi@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: add vm fault information to devcoredump
Date: Fri,  8 Mar 2024 02:20:54 +0530
Message-Id: <20240307205054.3904657-3-sunil.khatri@amd.com>
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
Faulty page starting at address: 0x0000000000000000
Protection fault status register: 0x301031

VRAM is lost due to GPU reset!

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 147100c27c2d..8794a3c21176 100644
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
+		drm_printf(&p, "Faulty page starting at address: 0x%016llx\n",
+			   fault_info->addr);
+		drm_printf(&p, "Protection fault status register: 0x%x\n",
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


