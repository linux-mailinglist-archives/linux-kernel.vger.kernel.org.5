Return-Path: <linux-kernel+bounces-113252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B058882A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D671F2230C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057B5FB83;
	Sun, 24 Mar 2024 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIY3k9U+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082A1870C6;
	Sun, 24 Mar 2024 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320052; cv=none; b=OMbVDha95SNI1OSxicQ/MgVFMjuJGF/BpipvaHkLjATXRVZDKZHmpD6FhusPE2XA1d0oWc96VkTGyORpYEkVPtGto7oPxVrQsVPiWkA2Oz/AHkzZbixJU97Ik6b1UkfQD3c/VqZ1tIzGukPiAxsol1K5s98W3oieGuqlimF2Ass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320052; c=relaxed/simple;
	bh=Ke97hrXldFBxj8KzdI5VmMC+f8kuAT2CHHarl1iwKgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBmpthEIbh/NLSqZO8cNlE5YnUA97q1fn3kwrddFLeyWaam8UKssHjTl+a28bQX1/d7s3CbdkcgFCtLJ+wntLqOP1HRGUzaJJJuYQ25oudbhveYnKcNTV5/FgmkSQoeY0m4Cm+e5Ep1n8uHvHJGkAQ5HtLTG9GHkBCwR8TyTAFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIY3k9U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75033C433F1;
	Sun, 24 Mar 2024 22:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320052;
	bh=Ke97hrXldFBxj8KzdI5VmMC+f8kuAT2CHHarl1iwKgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIY3k9U+IcObwFrWPQXzhuPdwPXFruDCLUZ3fej3FXrEBkt1l8qPrqefxi8EigT5Z
	 33qjBfkVxDjSxpj8H1f2jBilZT5nUtVNuauQr/K2C2ZtKkaIVbsG8BrpFtFQNYfnZw
	 mp9HjSoup2l/SKuT40ws/wwZmDWdYkd7NG0MGe1YMSxx41tlwkjeMj1/JIeYOuZpRw
	 lHTEsHEYBdaHB2flai7DibouhVRv38WsEffiVYWoFsSB53qzkg6J61kRGzIsSxoK7c
	 ayPX2lrqBhnomDqniyYafmw0OVxett6eRbuDBf52xmILg3LMB9D6fhc+Vkz8qh08PO
	 PKzJxV49tt3qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 361/715] drm/vmwgfx: fix a memleak in vmw_gmrid_man_get_node
Date: Sun, 24 Mar 2024 18:29:00 -0400
Message-ID: <20240324223455.1342824-362-sashal@kernel.org>
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


