Return-Path: <linux-kernel+bounces-23108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A5A82A7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648E21F27418
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE34D281;
	Thu, 11 Jan 2024 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB1XxKtK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA5CA7B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C0EC43399;
	Thu, 11 Jan 2024 06:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704955342;
	bh=gbX4YWfRwjVnF49sDXj1O3cCSmmOzMm5S1M/X7oiEXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GB1XxKtKwAbjoCUkLjjJoGupyaPxCfXinyIZtxjj9h2gCF7xtiv/z0/J3XLuA3w2M
	 B2LfimX/2MM/HUA3rnD7W3oZBvb2aw67It4G85AaSbvCt9yQKfVNYUBcZcZhmqZcnc
	 cs+kHcWdfDgP8ZNs0MNVS4He1flN5E+DXouJPZfCxAtfF3pOnyXHHQ004IhPeMlBu5
	 V1gUtCtI4XF1IjTXutmIDXqs4VAEwbPoV+eHeCub7gz2HmD13o4DK7m8RSAmZP8lF8
	 oae/LmsEx/b1c9a0FvZ7IWl6ik8/Sjhi9TxMrYQBrLWWFUFNz0idA9eUankiINLg+C
	 KIlJksLKi0+tg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 5/6] f2fs: fix to remove unnecessary f2fs_bug_on() to avoid panic
Date: Thu, 11 Jan 2024 14:42:07 +0800
Message-Id: <20240111064208.2969599-5-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240111064208.2969599-1-chao@kernel.org>
References: <20240111064208.2969599-1-chao@kernel.org>
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


