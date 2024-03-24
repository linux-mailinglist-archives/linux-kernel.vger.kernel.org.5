Return-Path: <linux-kernel+bounces-114263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9AB888975
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C73288ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C24E20AF9D;
	Sun, 24 Mar 2024 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qicy6O2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E960920C03E;
	Sun, 24 Mar 2024 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321625; cv=none; b=GVbCH8j2SSzmjb5vM8VR+zeaSUw8jq2soyQIz2Iz13gaI4/YirxMOghCBhe3dKRVIVfvU69QDdweVX5tfb9ArVAe4ujoA2fv8F4C2E9htmDHzn55C/04Eu2zhkb706gMN9bNG3C97fM6rDLBdhs7pg6pSI98lxh2fULOm91If7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321625; c=relaxed/simple;
	bh=Ke97hrXldFBxj8KzdI5VmMC+f8kuAT2CHHarl1iwKgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EojwjPtl2jtzKyQKi0v6jlskGgvjmv/cEdfhMcbypGrM1/ahpP58BrS1x1iXwMV9tP3xLkNdOE0yV11U/FJWDKw+4y2Nerno/7ElFq8xV12YvJKfFEI71WiqR45gAaw0IeG+WlcfpmnmDnLu0qlOnwOApIT5FwpnR8lN1I1ucz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qicy6O2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDEDC43399;
	Sun, 24 Mar 2024 23:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321623;
	bh=Ke97hrXldFBxj8KzdI5VmMC+f8kuAT2CHHarl1iwKgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qicy6O2udrG9QIL005xRkTkPC0KOyho1v5NXj9Vh5iMagk25H/ChxZERdhLC2QoPr
	 ce2259LCiDMzTPsY+MLSkPlPCp1i9Yp1olZMRBEe8sOwsZ+WvhRs3COFlXcqQ2SLVd
	 eTO9axbLu70JZbn3ZPAjVLuu+Uxx2JuPKsQIrS1zsS6sy5OhEA2Rg9JW0qPmTU2iP7
	 LrvkFyEV7u2yqbMuKLXeF0/1bZiBM85oMl80AGTG3oN/7UzzMtUGOla7yCLTwyMF8g
	 gtRIBMVOQd6rMrXLIpg4kQQmnQqoHIG+Rw6GlLuF9fhF/4nnLlpcTvQoL8FOByG6/H
	 ndjvdAbtTBzJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 354/638] drm/vmwgfx: fix a memleak in vmw_gmrid_man_get_node
Date: Sun, 24 Mar 2024 18:56:31 -0400
Message-ID: <20240324230116.1348576-355-sashal@kernel.org>
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

[ Upstream commit 89709105a6091948ffb6ec2427954cbfe45358ce ]

When ida_alloc_max fails, resources allocated before should be freed,
including *res allocated by kmalloc and ttm_resource_init.

Fixes: d3bcb4b02fe9 ("drm/vmwgfx: switch the TTM backends to self alloc")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231204091416.3308430-1-alexious@zju.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
index ceb4d3d3b965a..a0b47c9b33f55 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
@@ -64,8 +64,11 @@ static int vmw_gmrid_man_get_node(struct ttm_resource_manager *man,
 	ttm_resource_init(bo, place, *res);
 
 	id = ida_alloc_max(&gman->gmr_ida, gman->max_gmr_ids - 1, GFP_KERNEL);
-	if (id < 0)
+	if (id < 0) {
+		ttm_resource_fini(man, *res);
+		kfree(*res);
 		return id;
+	}
 
 	spin_lock(&gman->lock);
 
-- 
2.43.0


