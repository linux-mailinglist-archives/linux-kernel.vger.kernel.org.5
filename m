Return-Path: <linux-kernel+bounces-33262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F96836785
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229AE1C22FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224055E76;
	Mon, 22 Jan 2024 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjP1HCSH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7797255E5A;
	Mon, 22 Jan 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935515; cv=none; b=q+78Y6aAaeBUNP8y1lzTeZ2sZNFG90kXVDqICINAN8CohbzMcaO8BOAt0Natyq7jLb59A7LU1xqJXsFzChkFJFXVJDzQGHU8esSTHo7k8m5PIFXzKpMKM8bEzF20e1jyejJ557UgP+OTtAKeuTlLriw48Ce2e70ma7FL6dw3qs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935515; c=relaxed/simple;
	bh=7O66GhQEXBkQw7/K94pdY7cKtMA32+rR7WP5iEBOhD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJ44d9p46KLK5uAIkofZYK0OF+xn119n6Cv6JaD5HphwtsIr7CG0hLq+D0pUPOywR7fitiuafOJh0S8EZei4d9qCn5XrVaKkTnu9OhVBCxrepCaZBFeoyXcpJsphDXoIC9JW7CjGE90KWgrdfRBZvu+U04KMo+hJrMJxyYZUDLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjP1HCSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC11C433C7;
	Mon, 22 Jan 2024 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935515;
	bh=7O66GhQEXBkQw7/K94pdY7cKtMA32+rR7WP5iEBOhD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjP1HCSHqQ8sRdAgbIpXa23nqac88+nQSeW33qMjjFgd57HPdSmnIILb8LxBq1utu
	 vKrcyLKP50U+5bqKWFWsgFgdiQ/c6g5+nUZj8peFl5zkEdHyo/5B5jmLYDLfR9aY0B
	 zTtckF1TNplBCZTG1Q4T9BtSZgZZ7dhAV2SNdmM3n2+Sj6xlp9SoncRG2pYe94Jbmq
	 h/LxWWjB/C9NT0c5Sh1Yy1N8d8QQyg4SysGfYra7zzmnbK38UmTmCSGzNfpMQo4ghV
	 4xDRThVlve7ikiB/0DBx8xDe/A2Y1x0kkg36ZI3Iq0NTVTIO2ImOH9XwRvBe+F2roC
	 xEulxzfxrsDfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.7 43/88] f2fs: fix to tag gcing flag on page during block migration
Date: Mon, 22 Jan 2024 09:51:16 -0500
Message-ID: <20240122145608.990137-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 4961acdd65c956e97c1a000c82d91a8c1cdbe44b ]

It needs to add missing gcing flag on page during block migration,
in order to garantee migrated data be persisted during checkpoint,
otherwise out-of-order persistency between data and node may cause
data corruption after SPOR.

Similar issue was fixed by commit 2d1fe8a86bf5 ("f2fs: fix to tag
gcing flag on page during file defragment").

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 4 +++-
 fs/f2fs/file.c     | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 36e5dab6baae..62119f3f7206 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1036,8 +1036,10 @@ static void set_cluster_dirty(struct compress_ctx *cc)
 	int i;
 
 	for (i = 0; i < cc->cluster_size; i++)
-		if (cc->rpages[i])
+		if (cc->rpages[i]) {
 			set_page_dirty(cc->rpages[i]);
+			set_page_private_gcing(cc->rpages[i]);
+		}
 }
 
 static int prepare_compress_overwrite(struct compress_ctx *cc,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e50363583f01..9d2cdae18877 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1317,6 +1317,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			}
 			memcpy_page(pdst, 0, psrc, 0, PAGE_SIZE);
 			set_page_dirty(pdst);
+			set_page_private_gcing(pdst);
 			f2fs_put_page(pdst, 1);
 			f2fs_put_page(psrc, 1);
 
@@ -4054,6 +4055,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 		f2fs_bug_on(F2FS_I_SB(inode), !page);
 
 		set_page_dirty(page);
+		set_page_private_gcing(page);
 		f2fs_put_page(page, 1);
 		f2fs_put_page(page, 0);
 	}
-- 
2.43.0


