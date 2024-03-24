Return-Path: <linux-kernel+bounces-114834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79276889265
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89AF1C2E17A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216AC2C36A0;
	Mon, 25 Mar 2024 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCiyveN6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AEC176FDF;
	Sun, 24 Mar 2024 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323468; cv=none; b=OHMnyJlxD2Jb5m+ZfTjttyTQWvj0jGz1fxLekoyRBTOzwDROMEOTsB2UoX4+wiRHAhjjGCtElExi80WfDU7ovxhcFjp0DtuyLmT897eUvA5C1R9EDt5iLkvKnHMBUfOc51TI+apgCgmjg9jVNhIFg9e3LsRoKdyTOTSAbUtenNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323468; c=relaxed/simple;
	bh=WgZqRi5VOX6J/3ZZhpL+EoSiIi/iIK8rQSXlaTAdAaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGdW7qq3sA2qjaB5TCFx8vwWrG79g2CG1OV6+92stZMdZZsvN7PlVwp348qrL8ZyV/4j6YTU2lcP86XLkZRmZbP3iKK14KgslFyxcPwa6j1d7L+mDSam4am/5P9yhWYbXuL2aybeW2Tt4zzJjRNMIfWcAygP2loQeXbO/c5elfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCiyveN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00152C433F1;
	Sun, 24 Mar 2024 23:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323467;
	bh=WgZqRi5VOX6J/3ZZhpL+EoSiIi/iIK8rQSXlaTAdAaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCiyveN609ESnYdwFSje9lIyJHZGXVYrgxQSWxffB2cTynjAYPNpn9t0e4s5D6bp8
	 KIOnwqoA++WZSujXTqja+qUmRtlU5u4o6BtZaoChqBwqKOU+/EHpcrm2GQvsWzZOxc
	 zWRNqKZgBziubufknK3Vk0/UU3CXPH0BmgLw6xyn6Zz03CzBmqvxJ+ryJsy+J9N0Qo
	 7i0mNrOklGYrhpnhJxJOjswGiXiiUkgec+p+ZZbPGiVpaPIZVEt+t36QmqSnkEPTRo
	 RAntahniq3knCwW6CNQdTuaVfX1mAul+DLqdc/IHN9EfGbdUYVj6UE8zg2kl9wSAoO
	 U51wQMGcTpbHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Qiang Yu <yuq825@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 172/317] drm/lima: fix a memleak in lima_heap_alloc
Date: Sun, 24 Mar 2024 19:32:32 -0400
Message-ID: <20240324233458.1352854-173-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 09ea621a4806c..65c4327b6d10c 100644
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


