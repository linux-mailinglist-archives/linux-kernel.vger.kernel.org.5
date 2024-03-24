Return-Path: <linux-kernel+bounces-114828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2D988925F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382CB29A02C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9762C1D9B;
	Mon, 25 Mar 2024 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwB0K8OP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB2176FC6;
	Sun, 24 Mar 2024 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323465; cv=none; b=FltNzyl9BFWkT/7E3+/TwNelZ0nlF/K3TRistcWnjWrKCxFMMNELIgIX+FT0xEmAbdJKps+/T8lxnf6NdfS45mK0e5wP4qa/7sa0JxRxegY7BLJ5pTlMTo/LarO3hIc1XLkmwlHa8k5d3/ZhWn0g4HM089kBEHXh/kiJ5dWbrqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323465; c=relaxed/simple;
	bh=MPZkWRHizNJDxVsOELL2yrKRR5ySSqUDjNHTmI+Lx+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DClGeshRqOmnDXQFnpU6WmmlWwV4VHr6jP1ZNqnpvRb4DFA4Z9gf+iqhoAO7dXwFl8wEebmalh5OpygQC4eQc2pVL2jKfYvhjaGYoQYuAhj6n+Q0B+80gZD99OSBXynUGHxMHlW57ZKlsi934MLh0RM/EYE3zKmGUeT0Fscx5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwB0K8OP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21905C43394;
	Sun, 24 Mar 2024 23:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323464;
	bh=MPZkWRHizNJDxVsOELL2yrKRR5ySSqUDjNHTmI+Lx+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwB0K8OPH0/9nVCA9aW9E/paBnD24U6soopKkMwtAyz0b9t12gL3YrVEiYS4g7E2Z
	 +jDdtBBsctogUaCm5jnEZ6Yq3Y4hfVB3DT4MEvmChO+57cTA0HurNfIEpVHzMrDuUz
	 KsagP2O6U2ao+0+CHEj7tYcqNeekfROEWnS136/cem0vHDAmXY+gID7e9Rw0Z2pm7g
	 CIyvx5VUPth9ZpJ7XcjAJts33qJS6H1TqozYcCvlFoHnKeXQeGsd2PibvpPpbFUfzB
	 wGS1xkfXNIQAPVWRaQNzqZqqU8+5J0/UxzDyQ3Xv5Dp6rY3uNxPRvmbcLFNdjxi2MG
	 8RmOs3M6z7CvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 169/317] drm/vmwgfx: fix a memleak in vmw_gmrid_man_get_node
Date: Sun, 24 Mar 2024 19:32:29 -0400
Message-ID: <20240324233458.1352854-170-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index bfd686bb8d194..eef7bab8bc3a6 100644
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


