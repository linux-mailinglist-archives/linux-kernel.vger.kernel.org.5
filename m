Return-Path: <linux-kernel+bounces-58244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988F184E35F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0881C266EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA9B7B3D3;
	Thu,  8 Feb 2024 14:42:56 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD279DBC;
	Thu,  8 Feb 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403375; cv=none; b=kuf7gmsupBpVj1V/tPsO4F2/nT/NXKrggwAp4FJw9meR4YiWx/UBu+QEDxTC4vJvT3WJKRZLjNNYVhPDBMva7SdOYC/iUls8VHXFgvgtwZJnof7jdY49R03y0NB31AGCP70bFrBxvzWfqWbsbpFIhd6xVUNaJssmOWzucJrDkuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403375; c=relaxed/simple;
	bh=X3hYsJQUl7XAROpU2r6hlHoHIxUPoVToI+Gp6Eg2AZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrFBQJduAknFgosGD+RUiNcjJBA3zRf221IXuy7PBPwwsY62pyxEQw9OCop7DP+Fp4iroktMxJhcB1t7sXRHmWsAqkheSAp2QaVhTyDOeICExh9HN9DOxqO8H4C/rvjIFYxGIjD8h0uQDyNbOIVUIfP6BA2WWPg3T1yMGeC93UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from r.smirnovsmtp.omp.ru (10.189.215.22) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 8 Feb
 2024 17:42:41 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Ryusuke Konishi
	<konishi.ryusuke@gmail.com>, <linux-nilfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexey Khoroshilov <khoroshilov@ispras.ru>,
	<lvc-project@linuxtesting.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, Karina
 Yankevich <k.yankevich@omp.ru>, Andrey Rusalin <a.rusalin@omp.ru>, Sergey
 Yudin <s.yudin@omp.ru>, Valentin Perevozchikov <v.perevozchikov@omp.ru>
Subject: [PATCH 5.10/5.15/6.1 1/1] nilfs2: replace WARN_ONs for invalid DAT metadata block requests
Date: Thu, 8 Feb 2024 14:42:24 +0000
Message-ID: <20240208144224.438146-2-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208144224.438146-1-r.smirnov@omp.ru>
References: <20240208144224.438146-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch02.omp.ru (10.188.4.13) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/08/2024 14:27:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 183298 [Feb 08 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;r.smirnovsmtp.omp.ru:7.1.1;lkml.kernel.org:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/08/2024 14:32:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/8/2024 12:48:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit 5124a0a549857c4b87173280e192eea24dea72ad upstream.

If DAT metadata file block access fails due to corruption of the DAT file
or abnormal virtual block numbers held by b-trees or inodes, a kernel
warning is generated.

This replaces the WARN_ONs by error output, so that a kernel, booted with
panic_on_warn, does not panic.  This patch also replaces the detected
return code -ENOENT with another internal code -EINVAL to notify the bmap
layer of metadata corruption.  When the bmap layer sees -EINVAL, it
handles the abnormal situation with nilfs_bmap_convert_error() and finally
returns code -EIO as it should.

Link: https://lkml.kernel.org/r/0000000000005cc3d205ea23ddcf@google.com
Link: https://lkml.kernel.org/r/20230126164114.6911-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: <syzbot+5d5d25f90f195a3cfcb4@syzkaller.appspotmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 fs/nilfs2/dat.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 9930fa901039..1e7f653c1df7 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -40,8 +40,21 @@ static inline struct nilfs_dat_info *NILFS_DAT_I(struct inode *dat)
 static int nilfs_dat_prepare_entry(struct inode *dat,
 				   struct nilfs_palloc_req *req, int create)
 {
-	return nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
-					    create, &req->pr_entry_bh);
+	int ret;
+
+	ret = nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
+					   create, &req->pr_entry_bh);
+	if (unlikely(ret == -ENOENT)) {
+		nilfs_err(dat->i_sb,
+			  "DAT doesn't have a block to manage vblocknr = %llu",
+			  (unsigned long long)req->pr_entry_nr);
+		/*
+		 * Return internal code -EINVAL to notify bmap layer of
+		 * metadata corruption.
+		 */
+		ret = -EINVAL;
+	}
+	return ret;
 }
 
 static void nilfs_dat_commit_entry(struct inode *dat,
@@ -123,11 +136,7 @@ static void nilfs_dat_commit_free(struct inode *dat,
 
 int nilfs_dat_prepare_start(struct inode *dat, struct nilfs_palloc_req *req)
 {
-	int ret;
-
-	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	WARN_ON(ret == -ENOENT);
-	return ret;
+	return nilfs_dat_prepare_entry(dat, req, 0);
 }
 
 void nilfs_dat_commit_start(struct inode *dat, struct nilfs_palloc_req *req,
@@ -154,10 +163,8 @@ int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 	int ret;
 
 	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	if (ret < 0) {
-		WARN_ON(ret == -ENOENT);
+	if (ret < 0)
 		return ret;
-	}
 
 	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
-- 
2.34.1

