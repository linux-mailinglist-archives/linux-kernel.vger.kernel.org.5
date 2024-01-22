Return-Path: <linux-kernel+bounces-33367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC08368DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C8E1C23441
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96DD48CEF;
	Mon, 22 Jan 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljIxy1dN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE7C6BB2A;
	Mon, 22 Jan 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935999; cv=none; b=luKH8YzneKQJLRkxq5ITmUVF6ZqGdot5J/O02wY9CJpHmyReWp/atmUN4I9e6761gVvzx2vMBmPqdBU80iaM2IwsbAVE4Vpy1zMp61XZQnuz6e52e37/KU1tz9XHjEavlWmLilBbv77GCoJQMjnEtuHmfN5bWepRse+vgK2RvGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935999; c=relaxed/simple;
	bh=t4szPEH73ERPUcFP+yabDVdAL8MA+TsN97r2lOYwNvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rO3Ej1Kf3X9YMHJg0goyMJmZTuMNS89KlHFb4sRVh+WBoCsXbTVYg7QwCBLaA+RVwRoZeOXhoM10kSuoWJMxoCB7EbH7Rpzg1wmgFQIuErjbkM4Pm/3C+QysqdN40h4PWAixuvO2htQJ3I2gxZ2cSwk1r8fT6hOa2wcHxA/5ldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljIxy1dN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D763C43399;
	Mon, 22 Jan 2024 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935998;
	bh=t4szPEH73ERPUcFP+yabDVdAL8MA+TsN97r2lOYwNvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljIxy1dN2RTA+h6A4CssR3L3btDn2i5Rsz6wXQ6zlGiS9p5cAVMRGmYa+qt1fmXw0
	 4nndERyYapSlXPNADiGXcKOf5D8U0f9ZF9tLDZoAYoRgkFTM9AcPbhMd++j0pMaiI4
	 5Rf/ArWI9Yov8KGmzgqzeliOosx8XTb5QkviSrxha9kYO0C5zKrL9fsKXZ+CIK0jMw
	 gTnE9FI9/MmNViJ8sFXQkQ2owz3tUVHCaypmiEQ/ksuSM926Nqwe3qf4FArbcVyMg+
	 p5aRacmFPbTlBY9B6sZRFJ4Uwye9OAx62gKd4gMZEA21q1HGsGczNPd4eYf14h/n8W
	 XCzP/gimF1W9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Kim <jonathan.kim@amd.com>,
	Alice Wong <shiwei.wong@amd.com>,
	Eric Huang <jinhuieric.huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Felix.Kuehling@amd.com,
	guchun.chen@amd.com,
	Jack.Xiao@amd.com,
	shashank.sharma@amd.com,
	Tim.Huang@amd.com,
	shaoyun.liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 45/73] drm/amdkfd: fix mes set shader debugger process management
Date: Mon, 22 Jan 2024 10:01:59 -0500
Message-ID: <20240122150432.992458-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Jonathan Kim <jonathan.kim@amd.com>

[ Upstream commit bd33bb1409b494558a2935f7bbc7842def957fcd ]

MES provides the driver a call to explicitly flush stale process memory
within the MES to avoid a race condition that results in a fatal
memory violation.

When SET_SHADER_DEBUGGER is called, the driver passes a memory address
that represents a process context address MES uses to keep track of
future per-process calls.

Normally, MES will purge its process context list when the last queue
has been removed.  The driver, however, can call SET_SHADER_DEBUGGER
regardless of whether a queue has been added or not.

If SET_SHADER_DEBUGGER has been called with no queues as the last call
prior to process termination, the passed process context address will
still reside within MES.

On a new process call to SET_SHADER_DEBUGGER, the driver may end up
passing an identical process context address value (based on per-process
gpu memory address) to MES but is now pointing to a new allocated buffer
object during KFD process creation.  Since the MES is unaware of this,
access of the passed address points to the stale object within MES and
triggers a fatal memory violation.

The solution is for KFD to explicitly flush the process context address
from MES on process termination.

Note that the flush call and the MES debugger calls use the same MES
interface but are separated as KFD calls to avoid conflicting with each
other.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Tested-by: Alice Wong <shiwei.wong@amd.com>
Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 31 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 10 +++---
 .../amd/amdkfd/kfd_process_queue_manager.c    |  1 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  3 +-
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 6aa75052309f..15c67fa404ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -885,6 +885,11 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 	op_input.op = MES_MISC_OP_SET_SHADER_DEBUGGER;
 	op_input.set_shader_debugger.process_context_addr = process_context_addr;
 	op_input.set_shader_debugger.flags.u32all = flags;
+
+	/* use amdgpu mes_flush_shader_debugger instead */
+	if (op_input.set_shader_debugger.flags.process_ctx_flush)
+		return -EINVAL;
+
 	op_input.set_shader_debugger.spi_gdbg_per_vmid_cntl = spi_gdbg_per_vmid_cntl;
 	memcpy(op_input.set_shader_debugger.tcp_watch_cntl, tcp_watch_cntl,
 			sizeof(op_input.set_shader_debugger.tcp_watch_cntl));
@@ -904,6 +909,32 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
+				     uint64_t process_context_addr)
+{
+	struct mes_misc_op_input op_input = {0};
+	int r;
+
+	if (!adev->mes.funcs->misc_op) {
+		DRM_ERROR("mes flush shader debugger is not supported!\n");
+		return -EINVAL;
+	}
+
+	op_input.op = MES_MISC_OP_SET_SHADER_DEBUGGER;
+	op_input.set_shader_debugger.process_context_addr = process_context_addr;
+	op_input.set_shader_debugger.flags.process_ctx_flush = true;
+
+	amdgpu_mes_lock(&adev->mes);
+
+	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	if (r)
+		DRM_ERROR("failed to set_shader_debugger\n");
+
+	amdgpu_mes_unlock(&adev->mes);
+
+	return r;
+}
+
 static void
 amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
 			       struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index a27b424ffe00..c2c88b772361 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -291,9 +291,10 @@ struct mes_misc_op_input {
 			uint64_t process_context_addr;
 			union {
 				struct {
-					uint64_t single_memop : 1;
-					uint64_t single_alu_op : 1;
-					uint64_t reserved: 30;
+					uint32_t single_memop : 1;
+					uint32_t single_alu_op : 1;
+					uint32_t reserved: 29;
+					uint32_t process_ctx_flush: 1;
 				};
 				uint32_t u32all;
 			} flags;
@@ -369,7 +370,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				const uint32_t *tcp_watch_cntl,
 				uint32_t flags,
 				bool trap_en);
-
+int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
+				uint64_t process_context_addr);
 int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 			int queue_type, int idx,
 			struct amdgpu_mes_ctx_data *ctx_data,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 77649392e233..7f5aab1fb8f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -87,6 +87,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 		return;
 
 	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
+	amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
 	pdd->already_dequeued = true;
 }
 
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index b1db2b190187..e07e93167a82 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -571,7 +571,8 @@ struct SET_SHADER_DEBUGGER {
 		struct {
 			uint32_t single_memop : 1;  /* SQ_DEBUG.single_memop */
 			uint32_t single_alu_op : 1; /* SQ_DEBUG.single_alu_op */
-			uint32_t reserved : 30;
+			uint32_t reserved : 29;
+			uint32_t process_ctx_flush : 1;
 		};
 		uint32_t u32all;
 	} flags;
-- 
2.43.0


