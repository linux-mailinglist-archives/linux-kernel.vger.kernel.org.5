Return-Path: <linux-kernel+bounces-33126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D40836515
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A543B2741C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7661E3DBAA;
	Mon, 22 Jan 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgLRmAKH"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1693DB92;
	Mon, 22 Jan 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932150; cv=none; b=EeQzC7m8h+Hvodutnw/3T4Lq+3ZT46aWv0siJEJVBtnrXvFlcf0Y0PFSu4naLHgZDEKm40rj0T4aaUrqWVIpoOCV3qU4eGzQTXwL1YKcj9gLs1LO9VanhAhwAuzU+mXy2yp+aTlxnfcHhEQseYQtUjSUObhAbzQP2whKFk2Iidc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932150; c=relaxed/simple;
	bh=lsO8tfbwD9AdmOWSFushpOZY+ipFK/d/A6+FIEtkRsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7h38Z0MOLEIQGNU8knXdrByEmytzNKYVj1wtpObTX+5vYbree+E6ZAJAB5QAzHeyt2JhvIouYGJxxbzvT1e04NxU9yz9W485R+KC1uKf+aYgI3hXRM5UQo/vuFnXBxSl61cJBTMOvL8dq0iKfaXp/4VPS/xOBHUts0mZMFU5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgLRmAKH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso1569350b3a.3;
        Mon, 22 Jan 2024 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932148; x=1706536948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjPSFlgRnv/9c3guXKpp1n6ASVGkqJA5QUOIQi+tg3A=;
        b=UgLRmAKHkX33uHUwh35fhTjXZGB+Ndd1sGSlXkv08oFh6Q01c3UHRNKk4xZRG+tqPO
         OzSDAa6XQVpQMY6i2LMZii6PzQfvLvuVco5E6wn2Zth5GvgKNYfz9eqnAyqFptQQdhk/
         +uYAqJjLvwiFUyGvqa3vE2dPSjJJ5LWpIANlMSaQbaH6hvUF05noe8y7kQ6HurZZnnaV
         5DGA6rFtIrm5rJmqn+aXK6+bJkr04sv613Ss6XurAGggHGFuh5eSCQtveLYTX7wkTaAU
         v6wy8/tT7u+aydWwelMlg8Y453YtCA5C6pNdrd1ghDZJX+uH7HgOo7YBPQBAWyu3tfQ2
         rryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932148; x=1706536948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjPSFlgRnv/9c3guXKpp1n6ASVGkqJA5QUOIQi+tg3A=;
        b=lxJ+0z3RHzl+ozVgeT7hbmVz9uxEoDQTJYXPAeCczXIkr8iiEFFpz5Wk+9yhaAvMQ3
         36/lsqD13OuMdIl8+V81tH2cy8jRVA1N6S510Sd9EXey1JkU2QLlb86SdhZjNkNVNtlf
         jGiLo+KU65XVW+wbhHlvH6d1dFtioWtfZvxZWZp4gC3oM4IQa/1MegNUeqZscf8oYclI
         OciTgOasm5oxudEnMrp6nL/Rs1frXtyvwEVN2aNH93PGYxT2CLUWNJrsx+z8E12DPoxs
         ZlHC06rIrSprRA6XO2vLWSrec5CONc76UeyqMwUeA5gxZYw7JhKPiZqhJCckIpqTfWXH
         uGBg==
X-Gm-Message-State: AOJu0YzpAtd8YBeGFuLCt5V0rfUoYqcT5KhMaQyZwlAIo9WjzJvwgiYu
	k2/64Pb+McVrTEKPlhVG9NiDZJ+0S0bCfYw1gtGEyBsxSTWs+8Z7SuBRlvPJ
X-Google-Smtp-Source: AGHT+IErfOnMzZVqFI64j2LTUNuUqhdegSCHK2JHAFvOFMQ9RqK65rBzD1nsZ8xRPWDYFwYhr0UFbQ==
X-Received: by 2002:a05:6a00:244e:b0:6d9:b385:26f9 with SMTP id d14-20020a056a00244e00b006d9b38526f9mr2420201pfj.2.1705932147801;
        Mon, 22 Jan 2024 06:02:27 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:26 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] nilfs2: convert DAT to use kmap_local
Date: Mon, 22 Jan 2024 23:01:54 +0900
Message-Id: <20240122140202.6950-8-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
References: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Concerning the code of the metadata file DAT for disk address translation,
convert all parts that use the deprecated kmap_atomic to use kmap_local.
All transformations are directly possible.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/dat.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 9cf6ba58f585..8f71f8b0e218 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -91,13 +91,13 @@ void nilfs_dat_commit_alloc(struct inode *dat, struct nilfs_palloc_req *req)
 	struct nilfs_dat_entry *entry;
 	void *kaddr;
 
-	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
+	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
 					     req->pr_entry_bh, kaddr);
 	entry->de_start = cpu_to_le64(NILFS_CNO_MIN);
 	entry->de_end = cpu_to_le64(NILFS_CNO_MAX);
 	entry->de_blocknr = cpu_to_le64(0);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	nilfs_palloc_commit_alloc_entry(dat, req);
 	nilfs_dat_commit_entry(dat, req);
@@ -115,13 +115,13 @@ static void nilfs_dat_commit_free(struct inode *dat,
 	struct nilfs_dat_entry *entry;
 	void *kaddr;
 
-	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
+	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
 					     req->pr_entry_bh, kaddr);
 	entry->de_start = cpu_to_le64(NILFS_CNO_MIN);
 	entry->de_end = cpu_to_le64(NILFS_CNO_MIN);
 	entry->de_blocknr = cpu_to_le64(0);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	nilfs_dat_commit_entry(dat, req);
 
@@ -145,12 +145,12 @@ void nilfs_dat_commit_start(struct inode *dat, struct nilfs_palloc_req *req,
 	struct nilfs_dat_entry *entry;
 	void *kaddr;
 
-	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
+	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
 					     req->pr_entry_bh, kaddr);
 	entry->de_start = cpu_to_le64(nilfs_mdt_cno(dat));
 	entry->de_blocknr = cpu_to_le64(blocknr);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	nilfs_dat_commit_entry(dat, req);
 }
@@ -167,12 +167,12 @@ int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
+	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
 					     req->pr_entry_bh, kaddr);
 	start = le64_to_cpu(entry->de_start);
 	blocknr = le64_to_cpu(entry->de_blocknr);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	if (blocknr == 0) {
 		ret = nilfs_palloc_prepare_free_entry(dat, req);
@@ -202,7 +202,7 @@ void nilfs_dat_commit_end(struct inode *dat, struct nilfs_palloc_req *req,
 	sector_t blocknr;
 	void *kaddr;
 
-	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
+	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
 					     req->pr_entry_bh, kaddr);
 	end = start = le64_to_cpu(entry->de_start);
@@ -212,7 +212,7 @@ void nilfs_dat_commit_end(struct inode *dat, struct nilfs_palloc_req *req,
 	}
 	entry->de_end = cpu_to_le64(end);
 	blocknr = le64_to_cpu(entry->de_blocknr);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	if (blocknr == 0)
 		nilfs_dat_commit_free(dat, req);
@@ -227,12 +227,12 @@ void nilfs_dat_abort_end(struct inode *dat, struct nilfs_palloc_req *req)
 	sector_t blocknr;
 	void *kaddr;
 
-	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
+	kaddr = kmap_local_page(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
 					     req->pr_entry_bh, kaddr);
 	start = le64_to_cpu(entry->de_start);
 	blocknr = le64_to_cpu(entry->de_blocknr);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	if (start == nilfs_mdt_cno(dat) && blocknr == 0)
 		nilfs_palloc_abort_free_entry(dat, req);
@@ -362,7 +362,7 @@ int nilfs_dat_move(struct inode *dat, __u64 vblocknr, sector_t blocknr)
 		}
 	}
 
-	kaddr = kmap_atomic(entry_bh->b_page);
+	kaddr = kmap_local_page(entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, vblocknr, entry_bh, kaddr);
 	if (unlikely(entry->de_blocknr == cpu_to_le64(0))) {
 		nilfs_crit(dat->i_sb,
@@ -370,13 +370,13 @@ int nilfs_dat_move(struct inode *dat, __u64 vblocknr, sector_t blocknr)
 			   __func__, (unsigned long long)vblocknr,
 			   (unsigned long long)le64_to_cpu(entry->de_start),
 			   (unsigned long long)le64_to_cpu(entry->de_end));
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		brelse(entry_bh);
 		return -EINVAL;
 	}
 	WARN_ON(blocknr == 0);
 	entry->de_blocknr = cpu_to_le64(blocknr);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	mark_buffer_dirty(entry_bh);
 	nilfs_mdt_mark_dirty(dat);
@@ -426,7 +426,7 @@ int nilfs_dat_translate(struct inode *dat, __u64 vblocknr, sector_t *blocknrp)
 		}
 	}
 
-	kaddr = kmap_atomic(entry_bh->b_page);
+	kaddr = kmap_local_page(entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, vblocknr, entry_bh, kaddr);
 	blocknr = le64_to_cpu(entry->de_blocknr);
 	if (blocknr == 0) {
@@ -436,7 +436,7 @@ int nilfs_dat_translate(struct inode *dat, __u64 vblocknr, sector_t *blocknrp)
 	*blocknrp = blocknr;
 
  out:
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	brelse(entry_bh);
 	return ret;
 }
@@ -457,7 +457,7 @@ ssize_t nilfs_dat_get_vinfo(struct inode *dat, void *buf, unsigned int visz,
 						   0, &entry_bh);
 		if (ret < 0)
 			return ret;
-		kaddr = kmap_atomic(entry_bh->b_page);
+		kaddr = kmap_local_page(entry_bh->b_page);
 		/* last virtual block number in this block */
 		first = vinfo->vi_vblocknr;
 		do_div(first, entries_per_block);
@@ -473,7 +473,7 @@ ssize_t nilfs_dat_get_vinfo(struct inode *dat, void *buf, unsigned int visz,
 			vinfo->vi_end = le64_to_cpu(entry->de_end);
 			vinfo->vi_blocknr = le64_to_cpu(entry->de_blocknr);
 		}
-		kunmap_atomic(kaddr);
+		kunmap_local(kaddr);
 		brelse(entry_bh);
 	}
 
-- 
2.34.1


