Return-Path: <linux-kernel+bounces-113828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 004108886CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839B1B20AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65891200A5D;
	Sun, 24 Mar 2024 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZeJPLbg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B231E770D;
	Sun, 24 Mar 2024 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320866; cv=none; b=UxNgdD0pt/YiXwxon35uPeGj6+JG8Xo0z0vh7w0FGidwNejWXqwjo2crU5PsO1435K9ry4Tw6vxi48Htl+Mw9cAiMPRu06scTOnmKigirxNxn7IZU4PECZPA2bhoLZGX59NlHiEVY3dw+1UOSi/1HTJ39iKaSRSDzIKynM4V2XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320866; c=relaxed/simple;
	bh=8POOEHMBodqPxKTRL+FZX71hTSWmfb8XiVKdy1zhITA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srW1W5DJ0C/PUbycMCM7YsgebJV1c+LchHlJ4/ixufndVq+LVapGKWumaFvFAuWsIih3CQnJnLJJWGHvjvZiNU4VdJ95S2wSFF8twdjR1l0NuhnuKLBM6OQ709/DlHfCIk1fms00QO0cw9okdY3KxX9T+BvzZ8KJTlrzqH+x/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZeJPLbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4050C433C7;
	Sun, 24 Mar 2024 22:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320866;
	bh=8POOEHMBodqPxKTRL+FZX71hTSWmfb8XiVKdy1zhITA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZeJPLbg4ZvZTIvXV++2eZFofUih5w5+dJKVfOrnbH3/Xtj09kPU4h1JPXC02rHlg
	 1lqviXH1s/6AtgfsJrTUJ5f3WgfGCn1yLX4Xtkfnad3k9DzMSuUKihP4coixs7nnZT
	 EyKrJ0fQT7iTM2i0MSn9dj8c15cZw3594Bf8fNJBNS79ltMTAKOAShztkaskXEbtIi
	 PhrePkv7FcP1mRtbmkU8hrEgYj/U6C3oc1brOP3gFCKj+Ebm5RI9vnb0bLiLAobrk5
	 Sg5Q8Exn80z2eN3fhTLYQHLq7QghAmIZTKnu3Lhr69DB2RScqd2ynSGVIPsgEtPgKz
	 ouYoju4hC3P9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 430/713] media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
Date: Sun, 24 Mar 2024 18:42:36 -0400
Message-ID: <20240324224720.1345309-431-sashal@kernel.org>
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
index 0cc30397fbad5..8db9ac9c1433f 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1084,11 +1084,17 @@ static int v4l2_m2m_register_entity(struct media_device *mdev,
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


