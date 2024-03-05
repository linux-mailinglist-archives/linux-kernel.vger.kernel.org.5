Return-Path: <linux-kernel+bounces-92323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F7871E72
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B22F1C23C97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F835A4E0;
	Tue,  5 Mar 2024 12:00:57 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B65676D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640056; cv=none; b=bg2kXQucIWxwmM7stJSijyRb+qfitzi08LAZylS2wfEUD0oCp310gtd04E5/9ckTrSYAp2uQlFhg3oKSaRNPx9NNYnebqWweZn80Qutm5bnNs4TxYK/rgUM/Uv7S4ZqDTGz3CK8siIqtowBtOidmDor3rJHFOsMmLIdlngUrqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640056; c=relaxed/simple;
	bh=5gIZv6GorinXg3fudJ4cB2QRZoe+7V/CY2OqVWz65kU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XGv7i2ZnaWAWp1J0RwbMJmllaH3OWjy1+pF37C76R3Nx3a9CNZjStnoBOVfqZUMWqij6aV2bXRlGw90lCwcZpVX7Wu/r6/XwCzMtz7OlGhco7D9LSS84WClnihKu8u8QnmQ8Zy5dolOjmjhEekkppxYyJBcC6K6JSY8GwCZ79gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 425Bwua43119821;
	Tue, 5 Mar 2024 17:28:56 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 425BwugX3119820;
	Tue, 5 Mar 2024 17:28:56 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Pan@rtg-sunil-navi33.amd.com,
        Xinhui <Xinhui.Pan@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2] drm/amdgpu: add ring timeout information in devcoredump
Date: Tue,  5 Mar 2024 17:28:43 +0530
Message-Id: <20240305115843.3119708-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ring timeout related information in the amdgpu
devcoredump file for debugging purposes.

During the gpu recovery process the registered call
is triggered and add the debug information in data
file created by devcoredump framework under the
directory /sys/class/devcoredump/devcdx/

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index a59364e9b6ed..aa7fed59a0d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -196,6 +196,13 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   coredump->reset_task_info.process_name,
 			   coredump->reset_task_info.pid);
 
+	if (coredump->ring_timeout) {
+		drm_printf(&p, "\nRing timed out details\n");
+		drm_printf(&p, "IP Type: %d Ring Name: %s \n",
+				coredump->ring->funcs->type,
+				coredump->ring->name);
+	}
+
 	if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 	if (coredump->adev->reset_info.num_regs) {
@@ -220,6 +227,8 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 {
 	struct amdgpu_coredump_info *coredump;
 	struct drm_device *dev = adev_to_drm(adev);
+	struct amdgpu_job *job = reset_context->job;
+	struct drm_sched_job *s_job;
 
 	coredump = kzalloc(sizeof(*coredump), GFP_NOWAIT);
 
@@ -228,6 +237,12 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 		return;
 	}
 
+	if (job) {
+		s_job = &job->base;
+		coredump->ring = to_amdgpu_ring(s_job->sched);
+		coredump->ring_timeout = TRUE;
+	}
+
 	coredump->reset_vram_lost = vram_lost;
 
 	if (reset_context->job && reset_context->job->vm) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 19899f6b9b2b..6d67001a1057 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -97,6 +97,8 @@ struct amdgpu_coredump_info {
 	struct amdgpu_task_info         reset_task_info;
 	struct timespec64               reset_time;
 	bool                            reset_vram_lost;
+	struct amdgpu_ring          *ring;
+	bool                            ring_timeout;
 };
 #endif
 
-- 
2.34.1


