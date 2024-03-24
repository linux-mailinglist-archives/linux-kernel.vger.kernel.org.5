Return-Path: <linux-kernel+bounces-113806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B4889005
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A0CB2B2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840DE1FC0E8;
	Sun, 24 Mar 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKiGlF2L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7F1E61E7;
	Sun, 24 Mar 2024 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320836; cv=none; b=LEGacN68tpB9POXvgwEs9rIVem62zHLU+TFHojRp/jrfmf41Sj9Ob4SizSJob9vzLH0sgb9SDVQ/sUfjKlDtFnKrybBd0LVbktUv2JNNg5dLAI5gK8aGdcXlMk7+U/TdSecHXTKb1ptPoe+aZzWOva7+rLMvabu1e8C+/I32z64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320836; c=relaxed/simple;
	bh=Ke97hrXldFBxj8KzdI5VmMC+f8kuAT2CHHarl1iwKgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9s5U95utmsfE2tleU6MKntM/ouGslS2eDqFtqRQ72vnpgYJBLwO/i15jJiBsXvsxcC6QuAJXz943U3jl0f17wycNHsnDS0CyzWddLFG/Qv+XWZPM3wWJc6pdfPDjYCAD/ZKt1kpmxcW1V6PC9qlke0YW464d+FSFGqvXOqltYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKiGlF2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C29C43399;
	Sun, 24 Mar 2024 22:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320835;
	bh=Ke97hrXldFBxj8KzdI5VmMC+f8kuAT2CHHarl1iwKgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKiGlF2L7pBIltADaYCqRmp6L+DzLTrzgr14mOxHCfe3x60TyPR6RYp1GJmtZ/PQw
	 95AS+MjEhQT1wd/A1oG1VpbpHe0Iec0WtmuA5rIHGR63po/gIqTzIsxiSXRSDqU+zm
	 fvNeQWyrYAlJ4UDi7Bt3vV4p2VblxpIPKIov+vpRfioPV+pWywZEvWDX4T5X9cSh5l
	 5D0zXb4L+t9QIdBkGW5XKSnRB4IEW4yp+DXwEscBU3nWw0T/CZfemHvWa+pobUiDEF
	 OtZpcpxES+aZqkBI78h01uNzQw0hhjrmS0zJA6gwOS/N2wXrvrlq81V2nAX40UPI2e
	 TYxlWmcb3J71g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 400/713] drm/vmwgfx: fix a memleak in vmw_gmrid_man_get_node
Date: Sun, 24 Mar 2024 18:42:06 -0400
Message-ID: <20240324224720.1345309-401-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


