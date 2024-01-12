Return-Path: <linux-kernel+bounces-25190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D458882C94D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 04:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE284B2473E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 03:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78FD1A5BF;
	Sat, 13 Jan 2024 03:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7pX6qAv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001AE19454
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 03:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722A8C433A6;
	Sat, 13 Jan 2024 03:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705118248;
	bh=SD4fUAPJzN+uvRFc7mA/nW29W2wE766je65+7EHnk/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7pX6qAv4QWcmyVcM0N8hs2jXBfnQxuaoTct/5CLyHPjilaqJZMFGK8SO9fQ4sLq/
	 ccW4m6q/ColKurPEwwFgqle55HWe1LeNVcIf+AZfN5BM48duRlLrN9tQ+PddLGzpP9
	 HVevzbToVs5KN8We5ANKc7Q50q+Dgtm7pRY3y2HlpTgGbB22RuaSNHin9JeIPKie8n
	 g1+/ceNaZF5ZhfCUd5xofzEj8/gvMfX7gqyPcr5xpAa+4Bw0ImkN8yrFtfqLelugAC
	 bt/wDSTrgI5ngPh1t6hXhTQMC5zo2KjZdDZ5pYFa5TTJEtWtcDHc2amWJjyPKaBXBV
	 OfxZkxOp1oJig==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v5 5/6] f2fs: fix to remove unnecessary f2fs_bug_on() to avoid panic
Date: Sat, 13 Jan 2024 03:41:31 +0800
Message-Id: <20240112194132.25637-5-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240112194132.25637-1-chao@kernel.org>
References: <20240112194132.25637-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

verify_blkaddr() will trigger panic once we inject fault into
f2fs_is_valid_blkaddr(), fix to remove this unnecessary f2fs_bug_on().

Fixes: 18792e64c86d ("f2fs: support fault injection for f2fs_is_valid_blkaddr()")
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 69e71460a950..ab710bb6d8b3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3470,11 +3470,9 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 static inline void verify_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type)
 {
-	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type)) {
+	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type))
 		f2fs_err(sbi, "invalid blkaddr: %u, type: %d, run fsck to fix.",
 			 blkaddr, type);
-		f2fs_bug_on(sbi, 1);
-	}
 }
 
 static inline bool __is_valid_data_blkaddr(block_t blkaddr)
-- 
2.40.1


