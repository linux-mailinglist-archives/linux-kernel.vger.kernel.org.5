Return-Path: <linux-kernel+bounces-115688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BC188990C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C872FB33BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384820C819;
	Mon, 25 Mar 2024 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFHipJpf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9120C046;
	Sun, 24 Mar 2024 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321628; cv=none; b=XL4fNLRnZlObMzaKmrFE2lF2IgmxPw9FrB5ikcHoalMvHYTe9zALEGmf9Z/Nu0zmZ4pYVYbOKg5e3Y5OExiFZaiWK2T6R6120o7ssBSiHf2rfnwae35Lv3Mp9Y+8L0NRhuslPreBxCuhKKyeYSMPdHLhfOegP7B8mdxbcLo0Kv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321628; c=relaxed/simple;
	bh=0nT6+dnLat5eW46YYuat1egqogoXhgAReEx7/an+0Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZQXb3Y49C9RV9TG11tMYIWmlV1Dg/lsGyB2Ecsq2ZkHF+ueyOEjz6jm/OvkHbNAs3wnUfCmtR3t4yB0fAPj1FI2DcrrfB3biYqzZ3Zp05efAeRgl8EIUNe6m0KFIXOhpU4UdTS9BNVphIVaZCmAHWIQ8lbrjAwrFK9FqWcRH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFHipJpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9126C43390;
	Sun, 24 Mar 2024 23:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321627;
	bh=0nT6+dnLat5eW46YYuat1egqogoXhgAReEx7/an+0Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFHipJpfBEKne+auhGqA8qS3kFTrUHaiI/kcRlRdbZW849lh8vMwgN29Yg1Evf9nA
	 L0aGrVru/F9e4Kysw5xCAFyUeGECymlXRUEGxbwbeqv1R1kmN0uekayn7yiPCkfdyB
	 S6J67E+WgY/XExqnFLQ5oMsYJjI+S3/jhSWeSuDjYJXbVgctIKtHweXtOCwS27uKhy
	 VwaQwBYFM1xyq1pDSXyUNFotVwEA7VZlze+K1P8vJEbPxsruLTNqttVXALw2fzO41/
	 ptj2SNfVye6RnboZ35ytWIx05yKQrluBW69Cco0PCGKdt3tDkzXwvmbpFY0V/gAdD3
	 Ff895bZRnSagQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Qiang Yu <yuq825@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 358/638] drm/lima: fix a memleak in lima_heap_alloc
Date: Sun, 24 Mar 2024 18:56:35 -0400
Message-ID: <20240324230116.1348576-359-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit 04ae3eb470e52a3c41babe85ff8cee195e4dcbea ]

When lima_vm_map_bo fails, the resources need to be deallocated, or
there will be memleaks.

Fixes: 6aebc51d7aef ("drm/lima: support heap buffer creation")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240117071328.3811480-1-alexious@zju.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/lima/lima_gem.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 4f9736e5f929b..7ea244d876ca6 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -75,29 +75,34 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
 	} else {
 		bo->base.sgt = kmalloc(sizeof(*bo->base.sgt), GFP_KERNEL);
 		if (!bo->base.sgt) {
-			sg_free_table(&sgt);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_out0;
 		}
 	}
 
 	ret = dma_map_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
-	if (ret) {
-		sg_free_table(&sgt);
-		kfree(bo->base.sgt);
-		bo->base.sgt = NULL;
-		return ret;
-	}
+	if (ret)
+		goto err_out1;
 
 	*bo->base.sgt = sgt;
 
 	if (vm) {
 		ret = lima_vm_map_bo(vm, bo, old_size >> PAGE_SHIFT);
 		if (ret)
-			return ret;
+			goto err_out2;
 	}
 
 	bo->heap_size = new_size;
 	return 0;
+
+err_out2:
+	dma_unmap_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
+err_out1:
+	kfree(bo->base.sgt);
+	bo->base.sgt = NULL;
+err_out0:
+	sg_free_table(&sgt);
+	return ret;
 }
 
 int lima_gem_create_handle(struct drm_device *dev, struct drm_file *file,
-- 
2.43.0


