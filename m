Return-Path: <linux-kernel+bounces-116178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286CD889A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADED71F2D642
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4363B785C;
	Mon, 25 Mar 2024 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkFhEpyQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17917C19E;
	Sun, 24 Mar 2024 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323759; cv=none; b=lUZblm7ApVArkYTiJnFdhUDSBv0afq7/gpZPpF09I10SQysEGNOTrVh8WM8YEmQrD8L3XflP2Nh1mXCW9aydptBRWhw7CJpL7eAJe/72kjNQLTn+s4begbjpDR6oVq4u23I8eoG37IE132NrEi2LidVC+xOoHZpJh4JsFmRdZUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323759; c=relaxed/simple;
	bh=lZi2nF932yfaJDHA0T9yEuil3WiBHFu4xjhRzOjRwU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmOeGBALKhMdlVxFxRaK/1ZVFGUf99vIe5e/08kaiDYedlgKIbc5SramDyLI9f8eMHrg9+7tk2j6ihFC7TKUz/CTqtf1usOcOzfmJ7GhkYaU7sgYUiacHJDIObWTw0hYYXX7R2DzX9Vmhi7TFaHuT6uxLN8nVc16jrpJ48DrYBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkFhEpyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6EEC433F1;
	Sun, 24 Mar 2024 23:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323759;
	bh=lZi2nF932yfaJDHA0T9yEuil3WiBHFu4xjhRzOjRwU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AkFhEpyQjyvXmptwbBiY3LolvGtAUB+H+GaQBeCpNc7IM2UR6czMK8fU1DwOQhCxq
	 jkMdj9w5+vPdhfiFZOKBhE5X1CUPphbjK0KA38IluD/eLPQAcnL4ZWlKRu0B+haLgU
	 sz1PYf8VgQPmm/FoEi6rLE14xofwueEV6Wh3rLXUhlah0V+Ho485i3YbWwPBdMKVG+
	 7Pd5+CZSBUuDev3GmjeV0EhXau52aLs3AYt+y3Z+cfbARYj5AjnGQkOJ4JPZKjgVDS
	 MJwetYFLFtury08UXaBITIKE76IaLNIihMQmju/SOosg8icvSKYI9mTXQLH2Rl+ykO
	 5cmj75ePg/kGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 134/238] media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
Date: Sun, 24 Mar 2024 19:38:42 -0400
Message-ID: <20240324234027.1354210-135-sashal@kernel.org>
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
index ad14d52141067..56d320b1a1ca7 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1053,11 +1053,17 @@ static int v4l2_m2m_register_entity(struct media_device *mdev,
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


