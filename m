Return-Path: <linux-kernel+bounces-98767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4D877F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8510B2103A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B0E3AC08;
	Mon, 11 Mar 2024 11:34:09 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D539FF2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156849; cv=none; b=CUQsX+n4aUVikl6JYBtJ/8nceOzJqg234Q0CQiu9O4aiEU7qJTvrinoJXaX0Efg71W6h9Fk/KI0kyYsuMSVueighzd2Za155QBzIp1QfljI42S/RlFXeq0dVl5vAp9DJpuYQhDq/2dOAFuO87S2jzSEmHUlNkZl4p78/iUp2VeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156849; c=relaxed/simple;
	bh=cft7UKF6xabIfHwSAFwTmYgpj+/RSlDj98/pFvHY9v8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tXKxpKrkDpKfJ7ymJOo75NUwqqa9GcTy4tb51LZeBWX1er4kcTQPuAyz8IKwkRnaREDOM+pchyDsu6VxStlT2kAq0/tB6LAlGrV4dDZViA1eoGSgQLTvr7ZobJwWV0mZczR/da9iqBV1kqGpR5X8BnQBcgra+wBGvHAVMVs4ysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 42BBXrYj271754;
	Mon, 11 Mar 2024 17:03:53 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 42BBXr2d271753;
	Mon, 11 Mar 2024 17:03:53 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: add all ringbuffer information in devcoredump
Date: Mon, 11 Mar 2024 17:03:51 +0530
Message-Id: <20240311113351.271734-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ringbuffer information such as:
rptr, wptr, ring name, ring size and also the ring
contents for each ring on a gpu reset.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 6d059f853adc..1992760039da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -215,6 +215,27 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   fault_info->status);
 	}
 
+	drm_printf(&p, "Ring buffer information\n");
+	for (int i = 0; i < coredump->adev->num_rings; i++) {
+		int j = 0;
+		struct amdgpu_ring *ring = coredump->adev->rings[i];
+
+		drm_printf(&p, "ring name: %s\n", ring->name);
+		drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx\n",
+			   amdgpu_ring_get_rptr(ring) & ring->buf_mask,
+			   amdgpu_ring_get_wptr(ring) & ring->buf_mask);
+		drm_printf(&p, "Ring size in dwords: %d\n",
+			   ring->ring_size / 4);
+		drm_printf(&p, "Ring contents\n");
+		drm_printf(&p, "Offset \t Value\n");
+
+		while (j < ring->ring_size) {
+			drm_printf(&p, "0x%x \t 0x%x\n", j, ring->ring[j/4]);
+			j += 4;
+		}
+		drm_printf(&p, "Ring dumped\n");
+	}
+
 	if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 	if (coredump->adev->reset_info.num_regs) {
-- 
2.34.1


