Return-Path: <linux-kernel+bounces-7016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CC881A089
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53AC2899FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A493DB9B;
	Wed, 20 Dec 2023 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7AP1VMH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542F3D97A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF137C433C7;
	Wed, 20 Dec 2023 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703080790;
	bh=a+Zr5UnD9JUAPNdpT3P1rGDjRu5/Oz4DN3bx1yho9co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7AP1VMH72ySxKDNYPwmOKGF7q51vqQMEB1+DXpAwpCyC6g85zy8oN8ik0NtuGECt
	 fw5/oI6jiG4jODCmtW47jZNlF0pSs44rma9TnkTgz4+Rn9VKUA0XdZCAbjTTqWg01s
	 1Qe/SnxCpB7xpntmDxOOGwId82y/UnScwUQW/JoHkbw/UZ9V0qRiIdGRM0eexxPq+2
	 YwSJkO5n7pQeyvWeF7tgDH+FLyXYB7cbJ3Xdx7yRW9PwI8Ss8zqIZLy96dglx3O8+0
	 c/34qbSGUVjWs7wAi2hgltZ7HqAb6Ok3MFqvnR6HgZolU06+U4Vu5Pxk3uEynOOqL8
	 M10J8RnmP5IDg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 5/6] f2fs: fix to remove unnecessary f2fs_bug_on() to avoid panic
Date: Wed, 20 Dec 2023 21:59:33 +0800
Message-Id: <20231220135934.3471407-5-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220135934.3471407-1-chao@kernel.org>
References: <20231220135934.3471407-1-chao@kernel.org>
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
index 541c52fe2872..9487581db08a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3489,11 +3489,9 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
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


