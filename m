Return-Path: <linux-kernel+bounces-156700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D78B0700
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F59F1F2404E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4E3159562;
	Wed, 24 Apr 2024 10:11:58 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26491591EE;
	Wed, 24 Apr 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953518; cv=none; b=dzwOwkQFEIywhTttlYQProZTpqRsAZt+DCtaOrGSLWFZntrJnbuJJwnhBrA9IF/8p1TiCLBpvgwGWYSB8q0PwUkXNxW7gRgA/eEOfvRB/3/KQOPmmukNbyZbETx8SdFCNAqZgb33DcbaE00ie5MFq4SYuRW9BorrBIiI9GrKWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953518; c=relaxed/simple;
	bh=KmdReuKakQ27QWiMxDkWfXiDZT5AqYHMhIIFrET7f2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fs3Y/ivoPmkkU5y+0lC+T2fJUHblnm9PmWEVoVLk1pJEL2jwt5wk7M3ARf1ORqun79AGQ/5CpYuFOUBfvVv9cXLKSpNGKkQynqTgXL4f8HexOlyYiNtprlVjVJbCSSnSZxwLmWhm00hmmikhQOAB3uehI5F+T0BJ6f2loimt9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.126.32) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 24 Apr
 2024 13:11:49 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
CC: Roman Smirnov <r.smirnov@omp.ru>, <ntfs3@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	<lvc-project@linuxtesting.org>,
	<syzbot+478c1bf0e6bf4a8f3a04@syzkaller.appspotmail.com>
Subject: [PATCH 6.1 1/1] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date: Wed, 24 Apr 2024 13:11:14 +0300
Message-ID: <20240424101114.192681-2-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424101114.192681-1-r.smirnov@omp.ru>
References: <20240424101114.192681-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/24/2024 09:53:10
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 184894 [Apr 24 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 18 0.3.18
 b9d6ada76958f07c6a68617a7ac8df800bc4166c
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 84.18.126.32 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 84.18.126.32
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/24/2024 09:58:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/24/2024 8:46:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit 91a4b1ee78cb100b19b70f077c247f211110348f upstream. 

Reported-by: syzbot+478c1bf0e6bf4a8f3a04@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
[Roman: added string hint, replaced cluster_bits with sbi->cluster_bits, 
removed redundant checks near "Check MFT record size" and "Check index record 
size".]
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 fs/ntfs3/ntfs_fs.h |  2 ++
 fs/ntfs3/super.c   | 50 +++++++++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 0f9bec29f2b70..50ae3a6cb3559 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -42,9 +42,11 @@ enum utf16_endian;
 #define MINUS_ONE_T			((size_t)(-1))
 /* Biggest MFT / smallest cluster */
 #define MAXIMUM_BYTES_PER_MFT		4096
+#define MAXIMUM_SHIFT_BYTES_PER_MFT	12
 #define NTFS_BLOCKS_PER_MFT_RECORD	(MAXIMUM_BYTES_PER_MFT / 512)
 
 #define MAXIMUM_BYTES_PER_INDEX		4096
+#define MAXIMUM_SHIFT_BYTES_PER_INDEX	12
 #define NTFS_BLOCKS_PER_INODE		(MAXIMUM_BYTES_PER_INDEX / 512)
 
 /* NTFS specific error code when fixup failed. */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 6066eea3f61cb..863119b6a2a8d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -690,6 +690,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	struct buffer_head *bh;
 	struct MFT_REC *rec;
 	u16 fn, ao;
+	const char *hint = "Primary boot";
 
 	sbi->volume.blocks = dev_size >> PAGE_SHIFT;
 
@@ -731,17 +732,24 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	if (mlcn2 * sct_per_clst >= sectors)
 		goto out;
 
-	/* Check MFT record size. */
-	if ((boot->record_size < 0 &&
-	     SECTOR_SIZE > (2U << (-boot->record_size))) ||
-	    (boot->record_size >= 0 && !is_power_of_2(boot->record_size))) {
+	if (boot->record_size >= 0) {
+		record_size = (u32)boot->record_size << sbi->cluster_bits;
+	} else if (-boot->record_size <= MAXIMUM_SHIFT_BYTES_PER_MFT) {
+		record_size = 1u << (-boot->record_size);
+	} else {
+		ntfs_err(sb, "%s: invalid record size %d.", hint,
+			 boot->record_size);
 		goto out;
 	}
 
-	/* Check index record size. */
-	if ((boot->index_size < 0 &&
-	     SECTOR_SIZE > (2U << (-boot->index_size))) ||
-	    (boot->index_size >= 0 && !is_power_of_2(boot->index_size))) {
+	sbi->record_size = record_size;
+	sbi->record_bits = blksize_bits(record_size);
+	sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes
+
+	/* Check MFT record size. */
+	if (record_size < SECTOR_SIZE || !is_power_of_2(record_size)) {
+		ntfs_err(sb, "%s: invalid bytes per MFT record %u (%d).", hint,
+			 record_size, boot->record_size);
 		goto out;
 	}
 
@@ -784,26 +792,32 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	sbi->cluster_mask = sbi->cluster_size - 1;
 	sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
-	sbi->record_size = record_size = boot->record_size < 0
-						 ? 1 << (-boot->record_size)
-						 : (u32)boot->record_size
-							   << sbi->cluster_bits;
 
 	if (record_size > MAXIMUM_BYTES_PER_MFT || record_size < SECTOR_SIZE)
 		goto out;
 
-	sbi->record_bits = blksize_bits(record_size);
-	sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes
+	if (boot->index_size >= 0) {
+		sbi->index_size = (u32)boot->index_size << sbi->cluster_bits;
+	} else if (-boot->index_size <= MAXIMUM_SHIFT_BYTES_PER_INDEX) {
+		sbi->index_size = 1u << (-boot->index_size);
+	} else {
+		ntfs_err(sb, "%s: invalid index size %d.", hint,
+			 boot->index_size);
+		goto out;
+	}
+
+	/* Check index record size. */
+	if (sbi->index_size < SECTOR_SIZE || !is_power_of_2(sbi->index_size)) {
+		ntfs_err(sb, "%s: invalid bytes per index %u(%d).", hint,
+			 sbi->index_size, boot->index_size);
+		goto out;
+	}
 
 	sbi->max_bytes_per_attr =
 		record_size - ALIGN(MFTRECORD_FIXUP_OFFSET_1, 8) -
 		ALIGN(((record_size >> SECTOR_SHIFT) * sizeof(short)), 8) -
 		ALIGN(sizeof(enum ATTR_TYPE), 8);
 
-	sbi->index_size = boot->index_size < 0
-				  ? 1u << (-boot->index_size)
-				  : (u32)boot->index_size << sbi->cluster_bits;
-
 	sbi->volume.ser_num = le64_to_cpu(boot->serial_num);
 
 	/* Warning if RAW volume. */
-- 
2.34.1


