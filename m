Return-Path: <linux-kernel+bounces-114555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D7888B08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150BF1C2720A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0F22E7EC;
	Sun, 24 Mar 2024 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHaYDmJq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D922D884;
	Sun, 24 Mar 2024 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322190; cv=none; b=g/n0CtLzCiZkG8yzKljG2fSNKZlvX34+uGAiJMdU4w2WdNNV6pTuvJSKAaVH9C1Vym12UTyC1gbAZ1f6+NS1Pznk4/0f6nam2ATpRxI56uM8xt8n5hQF7XybgYoCPWkgL7H269xIaJAXD9pW9ZnIBhrjrYeqQPj7wjQxHq5ubzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322190; c=relaxed/simple;
	bh=l+jt0eU5Jjh6/L2EKqkfezPwODvgXeyoiZB8bb9jvVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXWyDpyhWIcuV6WpMtFNuHLaQ6SDACaQbcBsN7bR40bZJTPteAXDIaM42uyKMk965grRaUnp0TCtjvUnl4DPzRhRMaffvYU+2ilZxx6kBK12shV0moudOEP+coTdsbQtyHi8XI2cqBfgmo2vKGRwNA3KySpDmKUsW4O8EdWmMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHaYDmJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3564DC43390;
	Sun, 24 Mar 2024 23:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322188;
	bh=l+jt0eU5Jjh6/L2EKqkfezPwODvgXeyoiZB8bb9jvVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHaYDmJqJNgHJDvg28c21QHRwJPIV/kWEfW+nJoAnfrG1Cj+xdan2bjiSo7X/sw0W
	 ou2C303+cf5YbuEMXO3ACI8vV1d2tEUQaGhpAubEqLYPE7oWBVFjYVkBg13YbkdGKS
	 DBIy+zj7fEZ0c1l3/5/rp9JU7q/Ia24PPHQLZdiwhObK6gN80ZQacGcqEU3+eDpxHG
	 4Ulk8pVrqpBkrU6mmbC53RyCaajFjNjOyvxXS5EmBdkVCjS9B5oesvpQQ+e19rfKg5
	 LDGmR4wZPWfJhjFE07d1W35C+qJuYrMDpjKjwyUI4J7SUjpy+3+D5bpnWHHX4B0Pi6
	 i6k87NbxueBlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 267/451] media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
Date: Sun, 24 Mar 2024 19:09:03 -0400
Message-ID: <20240324231207.1351418-268-sashal@kernel.org>
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
index be7fde1ed3eaa..97645d6509e1c 100644
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


