Return-Path: <linux-kernel+bounces-115221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48579889581
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2408DB28AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9441CC46D;
	Mon, 25 Mar 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDW1mlv4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56695132808;
	Sun, 24 Mar 2024 23:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324310; cv=none; b=YxoinMpwo5XDh32DjkpmsgiNcshWQ8KrZxpxm29SuIR2tYd20mVaNiu5AwqN12aEllcv/K5cU7P+pq7h7bKtbAsClHyzIoCJPTGIJx7u6uf+DD0C2xe2GZfokBNhvVvYXAl8iC34nKcAJHR1iIY1fOjwjEM8khrBbpXmTy4pBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324310; c=relaxed/simple;
	bh=8z5IHMv3GWG41+xjtTI2imOucUx5FAko19b1cKHsbNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKyu+f2UIu5/zhni1Ihga1QqigoKL9+GhErE9RIV4ElVLq6vREWdCujmMz9bgvnfcWZgXCoL4607Tdak66N8yYzTYuJm8IKwzWHWOZQkDw6QfJ7Zlou5fmccczxU6cmJ4mm3y47dRZB7oKTNIwOSQcexAwtI/OyEaXqLD7hQkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDW1mlv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8C5C43390;
	Sun, 24 Mar 2024 23:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324309;
	bh=8z5IHMv3GWG41+xjtTI2imOucUx5FAko19b1cKHsbNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDW1mlv4dDWUW69Sgid9mVGHxwwz1PziL3IHAvQrDEZcFTKx/YiE9FDLnW6OlIh9d
	 IgW9UAbkkd/A20YGItd8xMn0STghEky9WwBJNa03ytxREWDqi2XQhX/lK05fdsmcOB
	 lZk5JTdV+3H3Xa+fgcUF+PfeliBRU6cWVcYduvv5tHR7158EPJw41Qag7a10AHap/9
	 QcLZtcLWdj62Nj6wjrcizXvBdyHR3ki/hDm0OfuDcfJxVVgmYaPmOS6wtm0iqAFsuQ
	 0q0eMAnZPKj16vkEvirUnoZj5hOT3pJWos71mJW3XEjvqleyJbWMn8KQcquDP1yEXY
	 rRaMdSnAuKedA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 081/148] media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
Date: Sun, 24 Mar 2024 19:49:05 -0400
Message-ID: <20240324235012.1356413-82-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 75c51007768e3..5c4e4d101ca46 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -775,11 +775,17 @@ static int v4l2_m2m_register_entity(struct media_device *mdev,
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


