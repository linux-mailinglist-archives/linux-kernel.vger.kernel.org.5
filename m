Return-Path: <linux-kernel+bounces-33393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FED83692B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA34289F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F066C77F3B;
	Mon, 22 Jan 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQuT7hNN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43677F2C;
	Mon, 22 Jan 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936112; cv=none; b=qz41r85OEDwBqB09efKAUrV3pGxmGA3eM4gg9OJZ5kdEIfHQOm8RqVkk4uSuUImrsXzzFEMUCTPO4xAfZTKTIQuu3FHwI1b1O5J7h+PRRaiomAq5MivQLLQarm9VJTbfMKsa9AlHee5snDlrRxsHCTkvWFFOBe2ZF2D/um77ZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936112; c=relaxed/simple;
	bh=QSXYM/qKEYRrHwsHjMRC7WYNgQDaa6w1LGyVKlLjTJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzWG7lmZJcwJZlheXV9QFwhsWxfk1ww0giRg4UmV6jV/hu6a5Gjqks7H0GR/C+pepb2jutl9bHyArWY6KDgD2GNSnD2Wesej9S2MSbkTp+TkAdwN9vMGW83lZGqnUz0ylDiuRP4sP0+TwspLH8634YKwL34LUFt0FTZsGYqb9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQuT7hNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8442BC43601;
	Mon, 22 Jan 2024 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936112;
	bh=QSXYM/qKEYRrHwsHjMRC7WYNgQDaa6w1LGyVKlLjTJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQuT7hNN3VK7t583sd+4NTXOJf3m7FQwqUtDlYYgOTuf8HZ40g1gvdYMEyUoy6bJn
	 XzdH/BR1h3k7fZqjKFXFwRLMLjW+khhzunAeB1VhcLOQFB6+3bESVxQUJ22VQKpiiV
	 EZksIB1yjn/FsvLEz49jrRQzCb6nqWwb6y7jrPktQU+nH/gFTKO9ywapiloN2CWrSs
	 LrunEQVB8aT5FXMouksRsZy1tuRdsOXALvc9S8uOBh1I3Txao3nACBrdh8w5S46UZJ
	 +ukW9OFyYnfWUeez/yd8n3L7THfYDGlfofJIzRTneiu/z6MvT0d79Ovy8zRdWcFrP+
	 sX6w44aEX0vxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaibo Ma <ent3rm4n@gmail.com>,
	Jay Cornwall <jay.cornwall@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 68/73] Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole"
Date: Mon, 22 Jan 2024 10:02:22 -0500
Message-ID: <20240122150432.992458-68-sashal@kernel.org>
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

From: Kaibo Ma <ent3rm4n@gmail.com>

[ Upstream commit 0f35b0a7b8fa402adbffa2565047cdcc4c480153 ]

That commit causes NULL pointer dereferences in dmesgs when
running applications using ROCm, including clinfo, blender,
and PyTorch, since v6.6.1. Revert it to fix blender again.

This reverts commit 96c211f1f9ef82183493f4ceed4e347b52849149.

Closes: https://github.com/ROCm/ROCm/issues/2596
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2991
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Kaibo Ma <ent3rm4n@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 62b205dac63a..6604a3f99c5e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -330,12 +330,6 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 	pdd->gpuvm_limit =
 		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
 
-	/* dGPUs: the reserved space for kernel
-	 * before SVM
-	 */
-	pdd->qpd.cwsr_base = SVM_CWSR_BASE;
-	pdd->qpd.ib_base = SVM_IB_BASE;
-
 	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
 	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
 }
@@ -345,18 +339,18 @@ static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
 	pdd->lds_base = MAKE_LDS_APP_BASE_V9();
 	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
-	pdd->gpuvm_base = PAGE_SIZE;
+        /* Raven needs SVM to support graphic handle, etc. Leave the small
+         * reserved space before SVM on Raven as well, even though we don't
+         * have to.
+         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so that they
+         * are used in Thunk to reserve SVM.
+         */
+        pdd->gpuvm_base = SVM_USER_BASE;
 	pdd->gpuvm_limit =
 		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
 
 	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
 	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
-
-	/*
-	 * Place TBA/TMA on opposite side of VM hole to prevent
-	 * stray faults from triggering SVM on these pages.
-	 */
-	pdd->qpd.cwsr_base = pdd->dev->kfd->shared_resources.gpuvm_size;
 }
 
 int kfd_init_apertures(struct kfd_process *process)
@@ -413,6 +407,12 @@ int kfd_init_apertures(struct kfd_process *process)
 					return -EINVAL;
 				}
 			}
+
+                        /* dGPUs: the reserved space for kernel
+                         * before SVM
+                         */
+                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
+                        pdd->qpd.ib_base = SVM_IB_BASE;
 		}
 
 		dev_dbg(kfd_device, "node id %u\n", id);
-- 
2.43.0


