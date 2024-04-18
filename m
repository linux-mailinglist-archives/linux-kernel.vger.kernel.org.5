Return-Path: <linux-kernel+bounces-149473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 195EF8A9192
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A4A283581
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93473537EF;
	Thu, 18 Apr 2024 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXcYnAUo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F025338A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411221; cv=none; b=EAgbCnHYNPQAI0QeyyGijWTz9XYwzMxiZVILRUj6Rcdfxgi1CaRj1tAoMhu3CYrPtYrExU9bankkz67E/4o3c5k5x9mYxBr0j4+vzXbn0ogf7K+ROTWSE16RcPacerwS5+VzBnjHnyb042pIOb7Ep66YRjP7SFnyDpGWF8MPfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411221; c=relaxed/simple;
	bh=dtjgZZ6LyAOmfuoyAzD6stsAAaBCfQKvQN9RlMz/f+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CXZobgacygkl+JzhkuIsT91CRSbaduqmCsaB8lN96LFteHGNVmbpQJpQO7FValyLXT425pZyAj4jHCTenWa8O1gfqkyiWwcHW/XCqTAYGHzWaYeG068xRWvAQrWQxbz1vP+7xXkmYkSYpaX4akiUHgsqt+E6cD0gsGcqYqEVHrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXcYnAUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAA5C113CC;
	Thu, 18 Apr 2024 03:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713411221;
	bh=dtjgZZ6LyAOmfuoyAzD6stsAAaBCfQKvQN9RlMz/f+g=;
	h=From:To:Cc:Subject:Date:From;
	b=rXcYnAUoQmz1RoeSI/bOHzs5HBQcoEDjWOcyHplG7AvaejllZ6i2YOcGsyejYXbCQ
	 MQhfjOj3/bwFEzO9EcumWhzk3MqZ3KO9JnznSNPTgcRfeHZhF6dFqzSf/LbPOwBZZg
	 Mszy4ZxKdiduI9gNSCFqPAfNSt68nwnZ2027W7919ixgNHsKsiH1K25/PypzJqvLOW
	 u/KNtN9MFDAcSzaKP/pcxjy+m87+zXbaGIT0FF45K/0hjnfL2CXl6mBWjVTnl3spXC
	 7aJloVkZONMLlcyq1aIgv2bdsEgSopRcvS++3GIeR0OUfTZU5a7nnJQ08PrK+Wec3e
	 VdlKHm3DTUlzA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Hyunchul Lee <cheol.lee@lge.com>
Subject: [PATCH] f2fs: assign write hint in direct write IO path
Date: Thu, 18 Apr 2024 11:33:34 +0800
Message-Id: <20240418033334.861570-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs has its own write_hint policy, let's assign write hint for
direct write bio.

Cc: Hyunchul Lee <cheol.lee@lge.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/file.c    | 15 ++++++++++++++-
 fs/f2fs/segment.c | 17 +++++++++++------
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b3b878acc86b..3f7196122574 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3722,6 +3722,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 			block_t old_addr, block_t new_addr,
 			unsigned char version, bool recover_curseg,
 			bool recover_newaddr);
+int f2fs_get_segment_temp(int seg_type);
 int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			block_t old_blkaddr, block_t *new_blkaddr,
 			struct f2fs_summary *sum, int type,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ac1ae85f3cc3..d382f8bc2fbe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4685,8 +4685,21 @@ static int f2fs_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
 	return 0;
 }
 
+static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
+					struct bio *bio, loff_t file_offset)
+{
+	struct inode *inode = iter->inode;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
+	enum temp_type temp = f2fs_get_segment_temp(seg_type);
+
+	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
+	submit_bio(bio);
+}
+
 static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
-	.end_io = f2fs_dio_write_end_io,
+	.end_io		= f2fs_dio_write_end_io,
+	.submit_io	= f2fs_dio_write_submit_io,
 };
 
 static void f2fs_flush_buffered_write(struct address_space *mapping,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index daa94669f7ee..2206199e8099 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3502,6 +3502,15 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 	}
 }
 
+int f2fs_get_segment_temp(int seg_type)
+{
+	if (IS_HOT(seg_type))
+		return HOT;
+	else if (IS_WARM(seg_type))
+		return WARM;
+	return COLD;
+}
+
 static int __get_segment_type(struct f2fs_io_info *fio)
 {
 	int type = 0;
@@ -3520,12 +3529,8 @@ static int __get_segment_type(struct f2fs_io_info *fio)
 		f2fs_bug_on(fio->sbi, true);
 	}
 
-	if (IS_HOT(type))
-		fio->temp = HOT;
-	else if (IS_WARM(type))
-		fio->temp = WARM;
-	else
-		fio->temp = COLD;
+	fio->temp = f2fs_get_segment_temp(type);
+
 	return type;
 }
 
-- 
2.40.1


