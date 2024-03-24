Return-Path: <linux-kernel+bounces-113829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 552588886D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA586B2255A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E76C201254;
	Sun, 24 Mar 2024 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzwexvH+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6D1E7712;
	Sun, 24 Mar 2024 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320866; cv=none; b=ncTZDpLzl7r8OPecYlbX9VdP+RtsUK2aoZK5KAUNCi7auMSGtN2aVuohf/ALFqkJJFsy1gQQOUzT5FnEN7eF7Bc0xXiQ0+piqX4wU5t5qrqb4mpMRA7jQdc5wFmZwkhl8ZQ1RAPhFUkoV7aRk7k0iq5HlYHtDuUshfXPCT5FUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320866; c=relaxed/simple;
	bh=EWgKnN4Jo0bf+oXAc5grq6JHSvSF9OfBeXnKDb9HOws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDvOMDPqq1wUmDzAknzozDGzN1bc0gmCGUC1RZpvr55EEHTrIMavR6xnGfYdllgQnt8OPF0WYlZOBM++mh/uphVmEOByiCFDIxQQENa9NB0+BlAZ/4Pk48enLBcHwv1VnbinX8h9MCB0Vf+mauDkC9NpcaEDxOmrPFe8BYYlq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzwexvH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF602C43394;
	Sun, 24 Mar 2024 22:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320865;
	bh=EWgKnN4Jo0bf+oXAc5grq6JHSvSF9OfBeXnKDb9HOws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BzwexvH+GQIdZBtm0Ht2GRegtBRAivvnSrvTxxRIL7ap63otfj4LQ3JtFS9O3JeM+
	 xUDOxtXDFTXFSXeJ123Tew/ZP6gfo2aP/kxD/+nk/LUweWyriVxVz+ZYleu6p23v8p
	 x6FzAS3Jbnwov4oMTJRW+Cu5bKD3P2cXvoUKADDjWlwzKXn81cOrAxeOF1tJKXKFDc
	 ttDf3mQw7a/zBpwLzCYHc4R3oFfh1lv3+Bu3RleuMQXOeTFmcYoLDnbNpU9zlHoWnX
	 8AUykiV6Xjm4k6cvXh5xzUFyre5sGQh/2dDF7hAM+L74ZeOmb70Hzd/t12+JqQHMIK
	 q05nHzK8lR6ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 429/713] media: v4l2-tpg: fix some memleaks in tpg_alloc
Date: Sun, 24 Mar 2024 18:42:35 -0400
Message-ID: <20240324224720.1345309-430-sashal@kernel.org>
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

[ Upstream commit 8cf9c5051076e0eb958f4361d50d8b0c3ee6691c ]

In tpg_alloc, resources should be deallocated in each and every
error-handling paths, since they are allocated in for statements.
Otherwise there would be memleaks because tpg_free is called only when
tpg_alloc return 0.

Fixes: 63881df94d3e ("[media] vivid: add the Test Pattern Generator")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c | 52 +++++++++++++++----
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
index a366566f22c3b..642c48e8c1f58 100644
--- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
+++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
@@ -113,6 +113,7 @@ int tpg_alloc(struct tpg_data *tpg, unsigned max_w)
 {
 	unsigned pat;
 	unsigned plane;
+	int ret = 0;
 
 	tpg->max_line_width = max_w;
 	for (pat = 0; pat < TPG_MAX_PAT_LINES; pat++) {
@@ -121,14 +122,18 @@ int tpg_alloc(struct tpg_data *tpg, unsigned max_w)
 
 			tpg->lines[pat][plane] =
 				vzalloc(array3_size(max_w, 2, pixelsz));
-			if (!tpg->lines[pat][plane])
-				return -ENOMEM;
+			if (!tpg->lines[pat][plane]) {
+				ret = -ENOMEM;
+				goto free_lines;
+			}
 			if (plane == 0)
 				continue;
 			tpg->downsampled_lines[pat][plane] =
 				vzalloc(array3_size(max_w, 2, pixelsz));
-			if (!tpg->downsampled_lines[pat][plane])
-				return -ENOMEM;
+			if (!tpg->downsampled_lines[pat][plane]) {
+				ret = -ENOMEM;
+				goto free_lines;
+			}
 		}
 	}
 	for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
@@ -136,18 +141,45 @@ int tpg_alloc(struct tpg_data *tpg, unsigned max_w)
 
 		tpg->contrast_line[plane] =
 			vzalloc(array_size(pixelsz, max_w));
-		if (!tpg->contrast_line[plane])
-			return -ENOMEM;
+		if (!tpg->contrast_line[plane]) {
+			ret = -ENOMEM;
+			goto free_contrast_line;
+		}
 		tpg->black_line[plane] =
 			vzalloc(array_size(pixelsz, max_w));
-		if (!tpg->black_line[plane])
-			return -ENOMEM;
+		if (!tpg->black_line[plane]) {
+			ret = -ENOMEM;
+			goto free_contrast_line;
+		}
 		tpg->random_line[plane] =
 			vzalloc(array3_size(max_w, 2, pixelsz));
-		if (!tpg->random_line[plane])
-			return -ENOMEM;
+		if (!tpg->random_line[plane]) {
+			ret = -ENOMEM;
+			goto free_contrast_line;
+		}
 	}
 	return 0;
+
+free_contrast_line:
+	for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
+		vfree(tpg->contrast_line[plane]);
+		vfree(tpg->black_line[plane]);
+		vfree(tpg->random_line[plane]);
+		tpg->contrast_line[plane] = NULL;
+		tpg->black_line[plane] = NULL;
+		tpg->random_line[plane] = NULL;
+	}
+free_lines:
+	for (pat = 0; pat < TPG_MAX_PAT_LINES; pat++)
+		for (plane = 0; plane < TPG_MAX_PLANES; plane++) {
+			vfree(tpg->lines[pat][plane]);
+			tpg->lines[pat][plane] = NULL;
+			if (plane == 0)
+				continue;
+			vfree(tpg->downsampled_lines[pat][plane]);
+			tpg->downsampled_lines[pat][plane] = NULL;
+		}
+	return ret;
 }
 EXPORT_SYMBOL_GPL(tpg_alloc);
 
-- 
2.43.0


