Return-Path: <linux-kernel+bounces-114536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D7F888AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C2828B9CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0325522BF98;
	Sun, 24 Mar 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJurXDGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917314A09D;
	Sun, 24 Mar 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322169; cv=none; b=ulY9FPK1T6rrrFHON5FsclM0Vn2AUlkwwj6tmGYtAockmGHINsktFIo03e22NDaYqif5xiF4zSy/xoEf1dbGuXd6iVjMK0FSZJ5dv6xycZ+c1Oe03iS18LW4QzI1a760Pw03k855xRnI7pwHkHEu/GaxCPJ7f3euUKX/GNxqD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322169; c=relaxed/simple;
	bh=YvAHdfBYNVMUAWyXxI/Q1L63eWCD+RlQtf3uzCgBk+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N26oLre7vYfrDXGL8/kZ3W00B92KRgqHq8EGeXEHkTwvBgvtpDaNX/nON1SjC1Ts4YjrYGu9M+NzbTuXvUaKH9UPurs2LNlxpuXppdfwpaEbQuQKZ2wPEXczmsR9b5OsMRAjq9E7wWL7ZUwdGi2FTdQv963UB23sbjQF5CxImBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJurXDGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F4FC43394;
	Sun, 24 Mar 2024 23:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322167;
	bh=YvAHdfBYNVMUAWyXxI/Q1L63eWCD+RlQtf3uzCgBk+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJurXDGZhi9f1g6wvxe9+9eofFz0LytlmkM6orw8cVVv7vBziOGl59Xr66Xmi8W5t
	 KWGCblMSYQ8LBVx+CaMhrtqOSX4w2XErdVR+Jsk+u4k2zIMZjA392OXuItURBXYhUY
	 rGki4tiTRj3R5PmTc387PVjt0flnFvkISYsivuw900osh34xVj3oqk3b3Kl9JH9CPv
	 UL/EUxc8bpl8vkiDK0iXnQrWZ+exQZzNjfSc2rgxL9W3yPQuT7DMC8b6CHOfgCHW3E
	 ZLwYuuqnb6eJV1I/4yyqATpVLFoigTt0x7bjKF+9Ijf4iFQhzEMG3beRyAJI3nNK5H
	 xdjfE1Z30b9nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 246/451] drm/vmwgfx: fix a memleak in vmw_gmrid_man_get_node
Date: Sun, 24 Mar 2024 19:08:42 -0400
Message-ID: <20240324231207.1351418-247-sashal@kernel.org>
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
index 60e3cc537f365..b9e5c8cd31001 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
@@ -65,8 +65,11 @@ static int vmw_gmrid_man_get_node(struct ttm_resource_manager *man,
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


