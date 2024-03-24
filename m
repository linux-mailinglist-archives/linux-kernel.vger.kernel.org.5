Return-Path: <linux-kernel+bounces-112757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D97887DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54D4281333
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223631862F;
	Sun, 24 Mar 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liJCm0D/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6413444393;
	Sun, 24 Mar 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300000; cv=none; b=IFoJWHUHY8oaUak7J7htsnbPZeB6kriY0//kF44QcBzGoiDzB7Zt7JWVa7UL7BDzUl93z12WjnEAKLWO/DjWVQam1i8N4vaTo9aRsRBm6+pZ1mpyNhskALraUPU5WQ+f8ywvJLWKWHAH/AKSHjzBqGtNzbS+DmJsW3Bci4aovs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300000; c=relaxed/simple;
	bh=EMTz2DrqA4rESU7pXmXjgPYgY3R8oMc/rZtnvteLh48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eupEhb3gyaaDc/c0lxs6S403St1Gto0dkdgU1Iu/3nO/cI/htP0vzSQtjo81WhR4xE6yfNHWaWgPU3uFAEISbDO1fGCaA9cRm+X2OS4H70JdIthdQl9OuUOsnlhkTNFrPl9WpO1iyGlTT6r8YeSHN0Hpi6VRco1GGYBklWbMxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liJCm0D/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14607C433F1;
	Sun, 24 Mar 2024 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299999;
	bh=EMTz2DrqA4rESU7pXmXjgPYgY3R8oMc/rZtnvteLh48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liJCm0D/mQLvvuuZPykc2X1Pxmq+b0vN6kFQ9mS0dyeMZUaD+Bm3j3+rMMqc4DT/3
	 cxxQmayqLUIvUBtxNXptot4cvY8nbPdLmSUWhQ9qCCaXkWK6HqqYZS6JNWYpxw1JZ4
	 Ez2qid8xXyu5fmNxNfc/DmFch+eld82ONBg8asOlaOpEsumAwCVbAZ9U2Ij8JIWMsK
	 vacZmQhk8Z3Qumbc0q3zYAcat20tUlfCyJQk0apZgnbAH21hlYR6e8p7rdg8SYY8IT
	 SjQOiBApWDb9w/C7R8YSpalzqDDXrzZJmRypHI9eor+kmCIKW+6BNegXjjM9ZlFqPi
	 9I7+RnLRvgqyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 11/11] nvme: clear caller pointer on identify failure
Date: Sun, 24 Mar 2024 13:06:14 -0400
Message-ID: <20240324170619.545975-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170619.545975-1-sashal@kernel.org>
References: <20240324170619.545975-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.10
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 7e80eb792bd7377a20f204943ac31c77d859be89 ]

The memory allocated for the identification is freed on failure. Set
it to NULL so the caller doesn't have a pointer to that freed address.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 86149275ccb8e..ab90b8a118351 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1341,8 +1341,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1471,6 +1473,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 	return error;
 }
-- 
2.43.0


