Return-Path: <linux-kernel+bounces-107924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593E28803A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEEE1F25B86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE925776;
	Tue, 19 Mar 2024 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlhro7yo"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6925601
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870001; cv=none; b=pzy9WY4DLywYYTMuIyrEu1Mn0q6+4SNVHLrV64ZcN6V+8YUooS50JK2aeIMCR7mE7llczp/cZKunu2W9V10hc0GuETGlchkh/dKO5/Jar7o0lMSeAtjwu7Hvuakq1yqjguN4CEkF1xOp5gNoI3E0ZfgaGmEztw1fQ0A+x3LAxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870001; c=relaxed/simple;
	bh=I30bldMoMsql+hzCHnhN/5IetJJd8PIn6Aa43/sDw8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwL/uifqof7EX2BWfDfPbQxHtv5zXlhzZpaEiyq2bFR35XB/jKRUJ4919FIy3g8MZIwV3w2s7B0/zmBujYMwDeFj8xLlFAvbcmRb9fB0f3/lsV0LkhIgnntV7wBfktacZOYau2NGj3ptrEH0ql1zT/pmjIXjYoNxmN7WI3O2VyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mlhro7yo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso3598879a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710869999; x=1711474799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbVTZraF0QJZsJx7Z45tBr7Rj39spiA67Pwo/WgWCSA=;
        b=Mlhro7yo5ABClgTDAprC3Xu8Z+DnusuY/jZIqqSdfMjXe25gLCuecJuLa3tB5Z1viU
         +yrdyoyk2/HqZWMYJ9IKEu6VAq5SFQz/nDl37+dGDZCyr2ToobrIw75IPZo/7Chs+JmR
         L3dazb9Bv44ZJm0hsSjn/KorBo3yUmqFyK2YYQPVcRs99jvBD4QmxWWuEaUAO2RDqq6K
         kOBqYFVKYs+Tcy6oz6CSL3LgSfA2NJEx0pRYc2G3nTiUE/rWqMhg3cq3aSjegHlxLYpr
         aYyNjKW9+jZUPUpuP6PU6E3LVuAJAsk8Tq5w+5ouayk8Z95acZtmd2dGSzevaEEoy0U5
         YaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869999; x=1711474799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbVTZraF0QJZsJx7Z45tBr7Rj39spiA67Pwo/WgWCSA=;
        b=w58siXabdW6OpUnM8sXALY02pM+pyllhXNvAPXGkkCNv61XYTHRieOmNjwm26HKHVz
         3Mk5suJhWcqu+RkGtZvLINK7WZpzCNKzrOe4f1ElTnydhxyYBi0drdR2XWvIT/oWaIBk
         Hju/TRLn/6IRotBT5+i8PjfZEoj+o5rMtZVW5QcILPJnul/x98GmHrhvG7Wv/lZCS9qI
         NNXPXaCchWzVCQHaKmu+nFyxkKZ7NxKZLzRcptUtnQ58Z/4OST5wjzrf9CdutQ7PTSAd
         G38+42OMe8g1te/xuw0otRHcDZvtVNwFjl2qZ84/lm3eu0PmKGGpOfm/6ACiX+W4WQKA
         dJCA==
X-Gm-Message-State: AOJu0YyFQXgXPYIf3ZU7ciseShWuPFURFGQh0u333sK9YxNi0WEJUpTe
	Cumb6Oia7SaxbuY0JwAaXFM9SSTdRT+kpRCYS3QcX2TlJAhktH0honDK5cBC
X-Google-Smtp-Source: AGHT+IFYhLc2hSKuMQw5BZW+1ji9lDf9Uyhy39Hk8kaH5hAfZNyyBimblILB6SQU1QfwvKgTXE6xpQ==
X-Received: by 2002:a05:6a20:94cf:b0:1a3:6ee9:305 with SMTP id ht15-20020a056a2094cf00b001a36ee90305mr4484410pzb.2.1710869999244;
        Tue, 19 Mar 2024 10:39:59 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:ce48:f01a:1f52:5e0a])
        by smtp.gmail.com with ESMTPSA id i185-20020a62c1c2000000b006e583a649b4sm10392921pfg.210.2024.03.19.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:39:58 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: prevent writing without fallocate() for pinned files
Date: Tue, 19 Mar 2024 10:39:55 -0700
Message-ID: <20240319173955.4090079-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

In a case writing without fallocate(), we can't guarantee it's allocated
in the conventional area for zoned stroage.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: covered the direct io case
v3: covered the mkwrite case
---
 fs/f2fs/data.c | 14 ++++++++++++--
 fs/f2fs/file.c | 16 ++++++++--------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c21b92f18463..d3e5ab2736a6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1584,8 +1584,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 	/* use out-place-update for direct IO under LFS mode */
 	if (map->m_may_create &&
-	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO))) {
-		if (unlikely(f2fs_cp_error(sbi))) {
+	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
+			 !f2fs_is_pinned_file(inode)))) {
+		if (unlikely(f2fs_cp_error(sbi)) ||
+		    (f2fs_is_pinned_file(inode) && is_hole &&
+		     flag != F2FS_GET_BLOCK_PRE_DIO)) {
 			err = -EIO;
 			goto sync_out;
 		}
@@ -3378,6 +3381,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 		f2fs_map_lock(sbi, flag);
 		locked = true;
 	} else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
+		if (f2fs_is_pinned_file(inode))
+			return -EIO;
 		f2fs_map_lock(sbi, flag);
 		locked = true;
 	}
@@ -3407,6 +3412,11 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (!f2fs_lookup_read_extent_cache_block(inode, index,
 						 &dn.data_blkaddr)) {
+		if (f2fs_is_pinned_file(inode)) {
+			err = -EIO;
+			goto out;
+		}
+
 		if (locked) {
 			err = f2fs_reserve_block(&dn, index);
 			goto out;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 82277e95c88f..4db3b21c804b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -57,7 +57,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
-	bool need_alloc = true;
+	bool need_alloc = !f2fs_is_pinned_file(inode);
 	int err = 0;
 	vm_fault_t ret;
 
@@ -114,19 +114,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out_sem;
 	}
 
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	if (need_alloc) {
 		/* block allocation */
-		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = f2fs_get_block_locked(&dn, page->index);
-	}
-
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (!need_alloc) {
-		set_new_dnode(&dn, inode, NULL, NULL, 0);
+	} else {
 		err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
 		f2fs_put_dnode(&dn);
 	}
-#endif
+
 	if (err) {
 		unlock_page(page);
 		goto out_sem;
@@ -4611,6 +4607,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 			return ret;
 	}
 
+	/* For pinned files, it should be fallocate()-ed in advance. */
+	if (f2fs_is_pinned_file(inode))
+		return 0;
+
 	/* Do not preallocate blocks that will be written partially in 4KB. */
 	map.m_lblk = F2FS_BLK_ALIGN(pos);
 	map.m_len = F2FS_BYTES_TO_BLK(pos + count);
-- 
2.44.0.291.gc1ea87d7ee-goog


