Return-Path: <linux-kernel+bounces-116177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D23889A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082CA1F2F970
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02103B718D;
	Mon, 25 Mar 2024 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5r8xYQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5217C194;
	Sun, 24 Mar 2024 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323758; cv=none; b=p3Ki9IhI8DxRF0HErnRsk4zqpedFA6Rw6MJeARas7HNyfddPSIbLiSc+to/oDKXFBr0IozkLXIiyjxy/oLSllzDAuT5elyayi2XN+MG/J9i6ynbIZKUm8TLj7eMj/EB0QG9rTdqCvMcUY4z3/k0S60Obqm1Giprfg+IerFk7oes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323758; c=relaxed/simple;
	bh=VybEtaiHM3RUVHWaxHA3J6K57xG86oXNEcOzIuXJSE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qf53vZG64WYPwejOdaMsASZSI5uXUakgn5MSb6n3LX7nocd56Cf7C5L3H+SiYaAynQ2JgIrZQPR0UhDTYj+hOfY4UjK6FQCT8wqpqKQU+keCxhY4EZeT+dUAvaMXQzUst4cOw8KUkB5U8ch1uv1of6Sw/1x17BxxsVk6l3fgL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5r8xYQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197C1C43399;
	Sun, 24 Mar 2024 23:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323758;
	bh=VybEtaiHM3RUVHWaxHA3J6K57xG86oXNEcOzIuXJSE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5r8xYQXEC298YDT/EbAroiynk62lajnPi06ok2aXaW3g3SL4FRmikMEp5nvcT5O2
	 6s8LRBmhVhbpOXHl5OU+7EIqgaIusSJcqcO09VvDQI5faAWkaTYzKZOibycHaVnfK8
	 RNuvByVFDOq56pHrneAGKxFCjHyF9+f+pinb/BcXtl1f9wj64FAfJzOhba3zbBdTF2
	 4qZHykXocCrG+mTIATtCkymzs5VHs1AbJ6Ulc8m/F8US3LUTfpdmxsCY36Rm/OS0rU
	 Nfi94335wCdeqjDhkTjNi698+3XoOHNr1KBNFJnh10q5D8l7njDh1k+pfVKS0Fox5G
	 CLRGs+3KsPbgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 133/238] media: v4l2-tpg: fix some memleaks in tpg_alloc
Date: Sun, 24 Mar 2024 19:38:41 -0400
Message-ID: <20240324234027.1354210-134-sashal@kernel.org>
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
index 7607b516a7c43..68968bfa2edc1 100644
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


