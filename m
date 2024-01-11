Return-Path: <linux-kernel+bounces-22966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1856182A5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FDA287DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A9ECD;
	Thu, 11 Jan 2024 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="efQQGJpB"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75F6EA3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=UYqqg+YYMRYSG+zlZs
	tZepXQitDokxntn9vsV7Aev34=; b=efQQGJpBRsNabI6WsVYUR2dV1yJgJhMsz9
	JMNBg7km+gx17zENtgP4sGRGC335MaIMbyc64tQmmz3Jb1TWIDdVQGox7dXKUU7A
	HqJbU3CZvbX7r9rfpl6Bd89f+PQvfL85/miMCYCuGm6UGsRT6PD6dY4YNrsyfYBW
	WTcrJUphw=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3X4X7UJ9lfpacAA--.59335S2;
	Thu, 11 Jan 2024 10:22:52 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: christian.koenig@amd.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_ib.c
Date: Thu, 11 Jan 2024 02:22:49 +0000
Message-Id: <20240111022249.6151-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3X4X7UJ9lfpacAA--.59335S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryUWFWDAw1rtrWkKFy7GFg_yoWDCFb_CF
	WUJrn5Jr13urnFvr12vr45Z34vvF15uF4kWr12qF9ayry7Z3yUKryDKryrXw1ruas7CFnr
	X3s09rZ8Aa9xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRK9atUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhhixWVEuXnykAABsH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: do not use assignment in if condition

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 6aa3b1d845ab..440e7aa45c66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -191,9 +191,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	}
 
 	need_ctx_switch = ring->current_ctx != fence_ctx;
+	tmp = amdgpu_sync_get_fence(&job->explicit_sync);
 	if (ring->funcs->emit_pipeline_sync && job &&
-	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
-	     (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
+	    (tmp || (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
 	     amdgpu_vm_need_pipeline_sync(ring, job))) {
 		need_pipe_sync = true;
 
-- 
2.17.1


