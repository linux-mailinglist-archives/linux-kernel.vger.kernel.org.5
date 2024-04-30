Return-Path: <linux-kernel+bounces-163293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CCA8B68AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79A4283571
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38301118C;
	Tue, 30 Apr 2024 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vqLaqusM"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DC10A0C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447760; cv=none; b=BSgy5v4tuGeEB004Uzz4LZTUDWKDRcMI7/NpUvNEDwof2kMmv8U3nB/R3q6sK0m2yQ/gFAqvGvZJpkkM9PANdiFyp+LbrnO4ZfhMBnKk47sWlNe2za1z/T+d4qaBbubeirL1PCUg01yR2I0bNuceQDLW+7Sb0atC5fkWrB+EAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447760; c=relaxed/simple;
	bh=VnRQqHRFLfqPj2Ruvuw9m2DS64Doca7tfk1HEDj7DHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FXF71N+8PULSGbXLjLJvQpDX53Um4z0oUV9C8tWPjA7Pf1wHbcsmzZzoAIm30MhpXA9qaj4RNTGIE1sUhBy4tEF8SDrJp7AJgp4mGbB132IQCU6aqTzQgLMXQ3uRZLlTikkxdDEkyZAlKGr8AQ5PBDo6bFg1af4ijgHHRywcbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vqLaqusM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714447754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rT1B236ATkF+Ygc2oPrbUXgNg8LDfbudCEbrCvlSDsk=;
	b=vqLaqusMXP++rirvu4u2Sm1t9uhp7geyDr7eFEcy4hSiMKnM2JlmMlnQKO6wF/5mnw8hJZ
	JczWH9fVezQBgUZ5KxJeyP8z6Xrbh+0HCR3YaXtbfIkWLUx7yT3kpDm3MGkVMDihb0YnPc
	bQc9xot/qqpNojQMUmL3S2Jb/J0x6s4=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] bcachefs: Fix error path of bch2_link_trans()
Date: Tue, 30 Apr 2024 11:28:39 +0800
Message-Id: <20240430032839.948404-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

In bch2_link_trans(), if bch2_inode_nlink_inc() fails, it needs to
call bch2_trans_iter_exit() in the error path.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/fs-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/fs-common.c b/fs/bcachefs/fs-common.c
index 6c737def357e..508d029ac53d 100644
--- a/fs/bcachefs/fs-common.c
+++ b/fs/bcachefs/fs-common.c
@@ -200,12 +200,12 @@ int bch2_link_trans(struct btree_trans *trans,
 
 	ret = bch2_inode_peek(trans, &inode_iter, inode_u, inum, BTREE_ITER_intent);
 	if (ret)
-		goto err;
+		return ret;
 
 	inode_u->bi_ctime = now;
 	ret = bch2_inode_nlink_inc(inode_u);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = bch2_inode_peek(trans, &dir_iter, dir_u, dir, BTREE_ITER_intent);
 	if (ret)
-- 
2.34.1


