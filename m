Return-Path: <linux-kernel+bounces-116169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E78899F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A431F36760
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E713B5A27;
	Mon, 25 Mar 2024 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHKc8EZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE317BB05;
	Sun, 24 Mar 2024 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323748; cv=none; b=tmFXnzEbL6/byinKKBJFOc0pPAnPwULSmrwwzMxpJ811hiliWCu7lRwg9I5gx2VqHsz+9tOdSYrz0JcZWvxwIC3K58R+4QOiTKVXdRVjkHQSldYQ1h5NgDuS6OS6tmgtziXnMLihR8IpdO/q8HslgE+Pd4hMPFOTDxJrE//XFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323748; c=relaxed/simple;
	bh=yR9eDH5FyneCFiaeoSi342C8aJUPm3XBozGPnp/Dtx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9WjffmMXeKLbnX6Oz+eaqXCh7KfDENv9SLLPxyEekjn4Y6bceAj8V4o7PBxQu1q7Aa6BC8NO3CAuO4dsVnuc073zfqHmxLYka6q8xi8JYqaoT+7gy9gUCqQragSkBKqQJttmWnsd+U4IfqxoK3+dN7egYeDWNhkQmTd/r76sXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHKc8EZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3E7C433C7;
	Sun, 24 Mar 2024 23:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323747;
	bh=yR9eDH5FyneCFiaeoSi342C8aJUPm3XBozGPnp/Dtx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PHKc8EZXSlyw2rSRHu1sE2I9wYtAD0fovPuOvGfANgAcLraHq7TxtYrQzjLLtQhz5
	 SXjBXeH2AMwNXtuCuCW8i/5JH2KyYnBq5Q3pSSSSNxryCgDD/+V8htwJjHJItSC60l
	 isQbnZuzo8che1bVTuW2CwWxGWzDsEuGVS65g7xMORQiMr2rudumL4AMtBnvC1mFYl
	 AvIKJX1I5rD6ay5j1iMhmU4nOhwJVJymScbwcA4GFfvoKjnBBIm6dxPmIchJ6mwrBr
	 sNqBEqTpuRAMN8BQX9jPKuTEjaQsk+h6lslNaMD14QHioxwLmGiGa3o/6xrjY91IMW
	 hJtopKQdLw/Bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Qiang Yu <yuq825@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 122/238] drm/lima: fix a memleak in lima_heap_alloc
Date: Sun, 24 Mar 2024 19:38:30 -0400
Message-ID: <20240324234027.1354210-123-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 11223fe348dfe..894175f2ed492 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -74,29 +74,34 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
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


