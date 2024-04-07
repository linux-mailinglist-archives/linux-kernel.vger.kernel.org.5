Return-Path: <linux-kernel+bounces-134454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED0589B1AF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5426AB2253C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE638612E;
	Sun,  7 Apr 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nuv96dqY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5485C44;
	Sun,  7 Apr 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495585; cv=none; b=Q6CG/AnhFsl5CQP4Au9U12MiXnLvscvtEuaaw1HUMGtCseTFTZgpq3//LTH6uB7VmeWjLBy8KBuVYOgFXtMuiCy5xA+FJ6tmiFzPde+c5eUeXEpIWoKXjnfgEKT3Clo9TM0J/Gqmaed1KsASVKob5qmZgFWo8WBuXzotQEx0y+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495585; c=relaxed/simple;
	bh=oWCzXN+vCCpyVNvZ5+D/zJUDwJXHUttz1Y7S2CW20QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyPBE0iqBLTHb98cqGwv+OsvIKNaXJMUQ8ovB8NboZ5Nu8D59BgD6WQk5rpG5w+ZkI+egaIhm3LzALf0Ey3hXnOII0/XM6MKt6vTqI71VL42U2p8EQJvSevMQz6pOERCGP9yR1ftATKfNvJt7oZzprFn9fxvI8UyuUScGF/ErbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nuv96dqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F14EC43390;
	Sun,  7 Apr 2024 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495584;
	bh=oWCzXN+vCCpyVNvZ5+D/zJUDwJXHUttz1Y7S2CW20QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nuv96dqYDUMBjFLenYi3+hNkO8RbpZayPFxsoCGbGOfw0gZoGKuyiNssoOnnVs13b
	 Tpo4LB1bYJVoYFePIzKY0My65PtxldWt8UqZRzRRKRBaeAjsc/f+UZzAg+Wm1AMVI8
	 9158ECT6WaWMoDPujaoejQ8UK90zcq02R7v/KhJRrsUI5qaASyYNTiH90AwxDQhzpj
	 m5Xqrlupn5q9CCE8yFlOcbunODsoOPEDMdBas5FP3U/77nbIrXLMWvemItStQEQPdI
	 RQTWTe0S7hM1Jh0/CL1qEbfAlJwRh1zL2xAax14cdAkTc88yaeJ9bA+YOPEqAr8Eg6
	 f58jN06aUD8aQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Kim <Jonathan.Kim@amd.com>,
	Jonathan Kim <jonathan.kim@amd.com>,
	Jesse Zhang <jesse.zhang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 19/22] drm/amdkfd: range check cp bad op exception interrupts
Date: Sun,  7 Apr 2024 09:12:18 -0400
Message-ID: <20240407131231.1051652-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
Content-Transfer-Encoding: 8bit

From: Jonathan Kim <Jonathan.Kim@amd.com>

[ Upstream commit 0cac183b98d8a8c692c98e8dba37df15a9e9210d ]

Due to a CP interrupt bug, bad packet garbage exception codes are raised.
Do a range check so that the debugger and runtime do not receive garbage
codes.
Update the user api to guard exception code type checking as well.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Tested-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c    |  3 ++-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c    |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c |  3 ++-
 include/uapi/linux/kfd_ioctl.h                  | 17 ++++++++++++++---
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index a7697ec8188e0..f85ca6cb90f56 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -336,7 +336,8 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 				break;
 			}
 			kfd_signal_event_interrupt(pasid, context_id0 & 0x7fffff, 23);
-		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
+		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
+			   KFD_DBG_EC_TYPE_IS_PACKET(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0))) {
 			kfd_set_dbg_ev_from_interrupt(dev, pasid,
 				KFD_DEBUG_DOORBELL_ID(context_id0),
 				KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index 2a65792fd1162..3ca9c160da7c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -325,7 +325,8 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 		/* CP */
 		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
 			kfd_signal_event_interrupt(pasid, context_id0, 32);
-		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
+		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
+			 KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)))
 			kfd_set_dbg_ev_from_interrupt(dev, pasid,
 				KFD_CTXID0_DOORBELL_ID(context_id0),
 				KFD_EC_MASK(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 27cdaea405017..8a6729939ae55 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -385,7 +385,8 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 				break;
 			}
 			kfd_signal_event_interrupt(pasid, sq_int_data, 24);
-		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
+		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
+			   KFD_DBG_EC_TYPE_IS_PACKET(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0))) {
 			kfd_set_dbg_ev_from_interrupt(dev, pasid,
 				KFD_DEBUG_DOORBELL_ID(context_id0),
 				KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index eeb2fdcbdcb70..cd924c959d732 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -909,14 +909,25 @@ enum kfd_dbg_trap_exception_code {
 				 KFD_EC_MASK(EC_DEVICE_NEW))
 #define KFD_EC_MASK_PROCESS	(KFD_EC_MASK(EC_PROCESS_RUNTIME) |	\
 				 KFD_EC_MASK(EC_PROCESS_DEVICE_REMOVE))
+#define KFD_EC_MASK_PACKET	(KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_DIM_INVALID) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_GROUP_SEGMENT_SIZE_INVALID) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_CODE_INVALID) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_RESERVED) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_UNSUPPORTED) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_VENDOR_UNSUPPORTED))
 
 /* Checks for exception code types for KFD search */
+#define KFD_DBG_EC_IS_VALID(ecode) (ecode > EC_NONE && ecode < EC_MAX)
 #define KFD_DBG_EC_TYPE_IS_QUEUE(ecode)					\
-			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_QUEUE))
+			(KFD_DBG_EC_IS_VALID(ecode) && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_QUEUE))
 #define KFD_DBG_EC_TYPE_IS_DEVICE(ecode)				\
-			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_DEVICE))
+			(KFD_DBG_EC_IS_VALID(ecode) && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_DEVICE))
 #define KFD_DBG_EC_TYPE_IS_PROCESS(ecode)				\
-			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PROCESS))
+			(KFD_DBG_EC_IS_VALID(ecode) && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PROCESS))
+#define KFD_DBG_EC_TYPE_IS_PACKET(ecode)				\
+			(KFD_DBG_EC_IS_VALID(ecode) && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PACKET))
 
 
 /* Runtime enable states */
-- 
2.43.0


