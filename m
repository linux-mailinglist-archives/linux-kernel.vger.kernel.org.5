Return-Path: <linux-kernel+bounces-113256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A48882B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863421F223E0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45A1187E8B;
	Sun, 24 Mar 2024 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I37O5HjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED5E187E6D;
	Sun, 24 Mar 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320056; cv=none; b=cs7NK6rbOEJ8RBq6hQjGIQMIMWd3jfl1HTZH0bdt2BRido9PZCiuyHdkEjyYuigLwurmE7cAqcMW/THZcObFJN8dyAYuUp0CI5Rjb5GnmalrM/6QKw7X/mUIzxXn/iC9gn72RalsN5gnc/dtfk1LYDo5JFx23tEoPAMRpW12ZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320056; c=relaxed/simple;
	bh=0nT6+dnLat5eW46YYuat1egqogoXhgAReEx7/an+0Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsELGmXW5My+29kC0igKiG4LoieDZfb5AmeE1+rT6KVJ4ZFo/35ze5gtT0ykydZO8imcR6C8ELuXp1cOSqegbgusl7Zq5fzaNjUe5VScRc/FZhcPY+O3BhnbXiBSgQaHonHLfH0Aoc34pP1/3vVsIp2CpNVOFmW2iTA92Lc4S/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I37O5HjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C437C433F1;
	Sun, 24 Mar 2024 22:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320055;
	bh=0nT6+dnLat5eW46YYuat1egqogoXhgAReEx7/an+0Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I37O5HjNSeBQCM6xRflx/AMKd3ey5UzG5frdF1nhAVmOqzl6BxyrKMTEMnuJ4dfPG
	 fSk2C6su7Z5FLEwIN/g/vbB6cPLTi97EAqb2JbvaVHX2H90fK3caqxGFXTqoImJ/+U
	 iNieJKMCiGUql7TXxAOL15lNoVyWsKVT4cXQKilL9pdI4DOexqVwEam9w8+Vp88X+l
	 I7WGR+8lVnSH25/r4r10ZZPYY6+psuJb5s+b7ZGYYqTHDd9iNKrhTX49m5IH7x8dV+
	 nH4YdhrpGlxhrdH+TJiTB92EFeKDvYt9rUbM1rE6viDlonhzEeVwr0vEwR3tGRzkEO
	 YJ5G0ZFmYsCLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Qiang Yu <yuq825@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 365/715] drm/lima: fix a memleak in lima_heap_alloc
Date: Sun, 24 Mar 2024 18:29:04 -0400
Message-ID: <20240324223455.1342824-366-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


