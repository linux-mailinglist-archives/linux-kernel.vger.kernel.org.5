Return-Path: <linux-kernel+bounces-115723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FED8897B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28FBDB24A13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6D221874F;
	Mon, 25 Mar 2024 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJw427EJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223A218538;
	Sun, 24 Mar 2024 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321789; cv=none; b=CGTQWzO0rXcN6iIPN6oUy5oQGBzXdrytLdNAquMGmAn/gkEKubBe6AqN0MzTdNNAHl957+VXvcUta8BN2QGYIb44etozaZWzwjCHRB05ZjK8mz682VDZ4LkAEZ5lArMSnXlUDNO8ykrSdx6/pWlKqs1FtWlbsEE7qqDfd9K/yug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321789; c=relaxed/simple;
	bh=9VqlHXKMnFlXG02wYOr54FZmu6yF+7WTnK+ViQ0gdOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jppXNIaeZSUY/9fpPBrQ+vOtRcujvgbwJLY0p5r+OjUr8Zjsj3mYoKp0nkLQX8FG/1BcjGeEDeoWc/elj9z2oAKTu14OXlLn8fNjHnx9WsRFMcuLVNW9AP2f3hdq5Isf9rPvJ/26XVDi7eoBpzVHbFgBfFcSegJRDXGG8YwxtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJw427EJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B32C43394;
	Sun, 24 Mar 2024 23:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321789;
	bh=9VqlHXKMnFlXG02wYOr54FZmu6yF+7WTnK+ViQ0gdOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJw427EJ/cSxKEzJSQfuQwMnvdzDsQDUDU8sfmFEzz3Z/pYUZS4F+Z8yE+oo04+WL
	 3EsL9VuQvhvVVQrmagsf8IPJMasDpCLf+fbaDCLJfeDX1HmGvbMrjG68Mj6PxFDnbR
	 Tlx4Zj35t5XCF/5t+SpEv3cOFnIYkl0MFK5dpWeMptfJ8/mbhQ1s8Sx9CebnU9Xq1T
	 CfFBYEPRA1K+a/SNUtVx7Gn7mEg52Pm/7jS3A2CG/+n5JeukRxqxMv8finJJJB6uPZ
	 REmU7dfS+Ab1+z27q8NEtGYhnZssj+qxVxtf0FI9T/3ydl+Pb6PmTfjVbKEcdM962m
	 EWYDkYmCSdyIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 517/638] f2fs: fix to remove unnecessary f2fs_bug_on() to avoid panic
Date: Sun, 24 Mar 2024 18:59:14 -0400
Message-ID: <20240324230116.1348576-518-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit b896e302f79678451a94769ddd9e52e954c64fbb ]

verify_blkaddr() will trigger panic once we inject fault into
f2fs_is_valid_blkaddr(), fix to remove this unnecessary f2fs_bug_on().

Fixes: 18792e64c86d ("f2fs: support fault injection for f2fs_is_valid_blkaddr()")
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8e5df06e9bb2c..2e2792a49de0f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3460,11 +3460,9 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
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
2.43.0


