Return-Path: <linux-kernel+bounces-99047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8BE8782C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3483D281A01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B841C84;
	Mon, 11 Mar 2024 15:11:27 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E341C79
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169887; cv=none; b=K9oEWz4BJlXJ7b70If33ajOGowDHSxPu6Y9e84UrrouuH/TJOwRN7Z7J5jGzTCa6Dugb1IG98CnSzKJNXQ0LwBvskebgVQnsg4J4w0Vp58qLHbm0Gv1W3pczzoRxSsq3vxlevKHaDI9TCS3nt5QbWd6QxrBOqi5dBWxe637wuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169887; c=relaxed/simple;
	bh=aKbkNyegVOyyGFjP/ogRuzQUe4u8kio6NQd41/oE4EA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uqwTQLhKAe5ynPUntmyaw5qdI0GnTU648jTVUjp5SJ1mhf1Z9w9hQ+quWNqM7Sss5uVS+LbBKvyvo0J4oYOXSz4E+nOZdsWaLzfhkPOM8i3Aii3573H0xbUkEWdRvTHtbQ0qKXtfxxcyR5HfeRRjnaRZXaHXw2YG15cUi3dX4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 42BFBB8s005368;
	Mon, 11 Mar 2024 20:41:11 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 42BFBB3J005367;
	Mon, 11 Mar 2024 20:41:11 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2] drm/amdgpu: add ring buffer information in devcoredump
Date: Mon, 11 Mar 2024 20:41:09 +0530
Message-Id: <20240311151109.5336-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add relevant ringbuffer information such as
rptr, wptr,rb mask, ring name, ring size and also
the rings content for each ring on a gpu reset.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 6d059f853adc..a0dbccad2f53 100644
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
+		drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx RB mask: %x\n",
+			   amdgpu_ring_get_rptr(ring),
+			   amdgpu_ring_get_wptr(ring),
+			   ring->buf_mask);
+		drm_printf(&p, "Ring size in dwords: %d\n",
+			   ring->ring_size / 4);
+		drm_printf(&p, "Ring contents\n");
+		drm_printf(&p, "Offset \t Value\n");
+
+		while (j < ring->ring_size) {
+			drm_printf(&p, "0x%x \t 0x%x\n", j, ring->ring[j/4]);
+			j += 4;
+		}
+	}
+
 	if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 	if (coredump->adev->reset_info.num_regs) {
-- 
2.34.1


