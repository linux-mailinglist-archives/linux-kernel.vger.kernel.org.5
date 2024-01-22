Return-Path: <linux-kernel+bounces-33477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C90836A23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA50285139
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92388134741;
	Mon, 22 Jan 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikKYr9Bf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8300134732;
	Mon, 22 Jan 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936434; cv=none; b=Zqof4NJHKnJmpDYOCt6vS7Bd7BUJosa+AwcEVTt1QGhV2r3Vi1VzDmD9smqYSBHhC2QVUMF7BU8bZwnWpkd7Z7qPKb3/pKBwiDL8DYu4mdaNoYUmawCv1mM0MZsZS6lEo+PVtGH87yWoN0D+xEUMuSWlm+HMfIx/4tRhpS58lMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936434; c=relaxed/simple;
	bh=Sa6kKliqi6TRKNMJZrqcEHRWzDRql/cto/qdXv2ICOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKNmQs3BVh/nehgeXCk6Ro2GHIlbqRjoMadAugF0lZO7jx0WBq8QBmfssLL9CnzOOqrSgZcFqG062ATrrvptrK/gH+1gcw2clo8t1gz/unTmySj3aVDu3Hc+6Xt6AM8H6Oi08sRiSbGfs8fAMwxc+9VqJTUqCvkoLBP/GndyKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikKYr9Bf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAE2C43601;
	Mon, 22 Jan 2024 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936434;
	bh=Sa6kKliqi6TRKNMJZrqcEHRWzDRql/cto/qdXv2ICOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikKYr9BfXOVNjlsGPgomkuQRSZBkaOz7V9d+QAzc9T/zDzhNY19QZv9nsWDUziD9Q
	 sqLOmJqEHY1L6aQQ+bfrjrRvmPTJukeBKOFz4NA8uzuT6orhEp96r58txgeJZ2Oqhg
	 /A18eppTcghSjix7slI4JBy2qXTXnKB5gUU0lmmoHaeNv8oRslRsiUBYvDqGvAQY+S
	 zGec+TPZu3L9CQPqpOX9HF8KJqRfM3K7/9Lq4HoSbVSiS756TJtG8PtJsvoByTnPFI
	 14g8EdtBRupzT2YT9of06NruI7mpwtMt4/stkXqYTbOtYvK2SnyJd4jO84CrwsSbuj
	 ybZNNcGt1IUPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 20/35] f2fs: fix to tag gcing flag on page during block migration
Date: Mon, 22 Jan 2024 10:12:17 -0500
Message-ID: <20240122151302.995456-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index 3982b4a7618c..7b4479d5b531 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1037,8 +1037,10 @@ static void set_cluster_dirty(struct compress_ctx *cc)
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
index 58fd32db025d..5c63cbb06faa 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1278,6 +1278,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			}
 			f2fs_copy_page(psrc, pdst);
 			set_page_dirty(pdst);
+			set_page_private_gcing(pdst);
 			f2fs_put_page(pdst, 1);
 			f2fs_put_page(psrc, 1);
 
@@ -3976,6 +3977,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 			break;
 		}
 		set_page_dirty(page);
+		set_page_private_gcing(page);
 		f2fs_put_page(page, 1);
 		f2fs_put_page(page, 0);
 	}
-- 
2.43.0


