Return-Path: <linux-kernel+bounces-114540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72578888AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4CE28BB98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC9A2922A9;
	Sun, 24 Mar 2024 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTF99TH6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1A22BC07;
	Sun, 24 Mar 2024 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322173; cv=none; b=u5C0V9MAFJb7Z4A/1KzP3g4W9ZYAMUjXMdkJV+nBdzWobl7H6IoNM+YmBG6EB9Z8YSdU+IGqr6/9HmkNKwPdy9cqoL5vLfo/0srtRIqwNcOY9iISkx55NuOL76Q/vjit6iihHlbfucmf4FQCo5bPjAhGgcu+sxX/UqIj9IMMdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322173; c=relaxed/simple;
	bh=eSTwvTlA0juuAVRBMRKhbIVopLvVWcqyvHTPU+4JcNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtM+vZz4a3M/unglkUrEFgGEkiNo9ZuFjohust2wuvTj4cVCXqECS27pRrG7zmwTIq60DpfDPsbXcv2FXXfiETr4qfHbMCJCsDqllkJiLrS1IWHXUaHCy6orwuK32TJwEDSEvsVFkFPpKAnSKM2AeVxtpj2Cnl+iVtOPPFgwfmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTF99TH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8888C433F1;
	Sun, 24 Mar 2024 23:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322171;
	bh=eSTwvTlA0juuAVRBMRKhbIVopLvVWcqyvHTPU+4JcNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTF99TH6JSyVfbwTwqU3JLOd73ltz1LtIRWAjv4zr6kp8XHa4T0lb0i4+g6TyxHxx
	 faLklukR4rfLMJpDAHkXN7zHRxhYO3wbRcA0FvDOW8d+rBOJ91xzFqWc4wCfBj+3Sr
	 Gwc1gEvLjXK2Cq9hgXxgwq+FGJxg+FbGtQufGnAiIjDJdVeu/EtWupFPbLAG7SesL8
	 47KdqvMUbyZALM12CLxTpJGmGgrS2UjAvuSMpI2TcgbeiHqytlfn6yQXG64ur6OxO1
	 GY1aeHQULlbBv05KDQ7ehqEdp/eL0UThMzGBqeDp+AyKlnhihp4CcPvxkN2qEoTuhn
	 HiL/9t463QW/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Qiang Yu <yuq825@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 250/451] drm/lima: fix a memleak in lima_heap_alloc
Date: Sun, 24 Mar 2024 19:08:46 -0400
Message-ID: <20240324231207.1351418-251-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 0f1ca0b0db495..d72c5bf4e5ac1 100644
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


