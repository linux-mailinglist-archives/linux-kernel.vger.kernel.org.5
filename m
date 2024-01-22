Return-Path: <linux-kernel+bounces-33359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DABDC8368C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425C9284E76
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4C4679F1;
	Mon, 22 Jan 2024 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nghyl0os"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E763487AB;
	Mon, 22 Jan 2024 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935968; cv=none; b=UQlHe4uWYRenPj3ZKf2vxc3HIgFaS7Lb5ywFr8+tpa4D/CVCbY/4R3qgzT0ptAUltysNZ4xhmCELqot+epMyFDDobaTG4phMMKLjHtJ4qaTVBTXSxTJDRnm3KMBexaq16F3dVPCzWv7egil90e07+sHe5CPyDy8tIL5iBEFnmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935968; c=relaxed/simple;
	bh=1Irrl3whR3uHGgveTPJ/UzYt6DSNqgYXdIW4ybupJ9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUBxgunUu/AbOGSBY8LJkcoWjhCX77TC3M670/yznkSFwRn45wZ+ZcgsSiIZmfqPK333f+34wURJKibTMAollvBQdBYj8Af4npd8eZ/sLmtKWoRKTEEf+UZSAtHntNRcayl/dNYINRwH5doGQ3fc2q/sfJkkgqGMce+y0wVmb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nghyl0os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C6FC43390;
	Mon, 22 Jan 2024 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935968;
	bh=1Irrl3whR3uHGgveTPJ/UzYt6DSNqgYXdIW4ybupJ9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nghyl0osfnAaECeK1m6mMxeD6gdtVmvTzokV+dzIq8w2KVPUMYdFa2+/IFWCF276u
	 USFHmMec0QGDj9x1YODJTOFqDIepfW7lWzKDbTDiSe3olbra3bkqsr0JjW0JxoYhGj
	 PMpSQd1//siV/9bJlcNO9lBtCVq6K96I8lZJ5QzIghmkvjow+Rl55rK2aXVDVHZd0a
	 kgDOC3Lpoilz1+vFwS2GdmFoNzYFlJi5/sCxgKFoTxVnFakIHQ16tQnbl8yPTquNOo
	 F4Xh+o9rMOJbq2r9THDTm0xNMvyf1kn8m82s/FQxxkk2POYviMSf5WKShOCQw3Azew
	 B0ksgEh559BXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 37/73] f2fs: fix to tag gcing flag on page during block migration
Date: Mon, 22 Jan 2024 10:01:51 -0500
Message-ID: <20240122150432.992458-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 7514661bbfbb..372616ca8fb5 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1029,8 +1029,10 @@ static void set_cluster_dirty(struct compress_ctx *cc)
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
index a06f03d23762..d6962f4ccad3 100644
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


