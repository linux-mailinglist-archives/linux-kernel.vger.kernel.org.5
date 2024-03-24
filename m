Return-Path: <linux-kernel+bounces-113287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1220688831F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F051C23335
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9618E0D1;
	Sun, 24 Mar 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQX4ijUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250486BB51;
	Sun, 24 Mar 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320088; cv=none; b=E3JuI49N3pWWFXbDHc61iaVCVKpci9CwowbPBuija+sUkEazoKtxtcepGx18+qX1x3fVfvwTXlkvSuBkmZxm9Asqr1JBOimwPIymGYMeQBhDzptla3x5MPPx+okJOEL6QZisUTYQ32K1gsaOR0wa/siDCcK8GOkj/xTlA5H4BNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320088; c=relaxed/simple;
	bh=d6lzkkIjVC8j7FCAyLRzMX5ir2uPOxbS8UYQkWRwhlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y46QL5DDgxmWWhCYYvoM8Xcmo/jtEDcf2CcVwu5vDp0Ekzk3SpXQmlkfCNPX0uO+4534VbddlmYj5KzE5TsXGdOtAMtpCKO5K+WCY00Z6ytB7q2taMN9vZvTthXAes6AIye2EvVvYshpQ0bw4oioSwrVG/7Lh0zrlSx8pPLOlNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQX4ijUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D144C433C7;
	Sun, 24 Mar 2024 22:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320087;
	bh=d6lzkkIjVC8j7FCAyLRzMX5ir2uPOxbS8UYQkWRwhlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQX4ijUvkMl/CYFB9Pg2IhrXEc57kxKfvrti/osl2DMGDWjM+MoFVtRccNZ346WHi
	 EYUY0t4nybEDaiVnYbMOZaXdOVeEYUEz1tQK1LIs6P3dJcOliX5Trgpghbsf4ooxag
	 3EghFDi2DLCZSQhCYGiWpcuB1hYOS9+f79cd0Pqe1P6VxiMiuyZ27PLppYNyN5+alk
	 9AAE6jJ65YhXMOMFIa1JkxfiLTIOojIo4Zo1XxgMG4ti9xAezREvWxCb/nvw26MAnH
	 8ZWH01JnuKIpY3hEfgnrw1L9C+Kd2PxaaUcV8p+YiIX5AjMwKk5ARu7vt+1stDB8cd
	 T4baoQ8wjyZSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 396/715] media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
Date: Sun, 24 Mar 2024 18:29:35 -0400
Message-ID: <20240324223455.1342824-397-sashal@kernel.org>
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

[ Upstream commit 8f94b49a5b5d386c038e355bef6347298aabd211 ]

The entity->name (i.e. name) is allocated in v4l2_m2m_register_entity
but isn't freed in its following error-handling paths. This patch
adds such deallocation to prevent memleak of entity->name.

Fixes: be2fff656322 ("media: add helpers for memory-to-memory media controller")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 9e983176542be..75517134a5e94 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1087,11 +1087,17 @@ static int v4l2_m2m_register_entity(struct media_device *mdev,
 	entity->function = function;
 
 	ret = media_entity_pads_init(entity, num_pads, pads);
-	if (ret)
+	if (ret) {
+		kfree(entity->name);
+		entity->name = NULL;
 		return ret;
+	}
 	ret = media_device_register_entity(mdev, entity);
-	if (ret)
+	if (ret) {
+		kfree(entity->name);
+		entity->name = NULL;
 		return ret;
+	}
 
 	return 0;
 }
-- 
2.43.0


