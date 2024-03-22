Return-Path: <linux-kernel+bounces-111882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B2F887222
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F861C2030D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B21B604DB;
	Fri, 22 Mar 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfkTGieR"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F450604A6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129790; cv=none; b=O8srTVrWRW+4NwhiHehecSUh/WFjtyR3us2sB4JL8tcuh+GWAEodngHSLaOCs9XSwW3h6q4UNjMKul2i005nMhv08DE4NHkEcIzU5tyqgEW8yHq2G9ptk6v+1OjmkNZeCktayvwJpVYLG2WWbtu8SRvUlHzj+hUnKZ8P6hSstY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129790; c=relaxed/simple;
	bh=ytPJs9xhDMPYZaA7pz8Nqr40ih3LKLHLa8nELh0Ejo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iv8tI/7FBEAieOuALajBKPN+ItfhoPe5wCMEFZAki9C33sM9XPDH6hFiWfi9T9amaj8lR30S2k6I3PbhnzAcSs6NfLvJ7wVDpG9DZFOhc5kw3dFFW+TAWRKyy18zdt+ZBZQ+ScCAEphW58WL7eBydhObE2WBsE/R+DZ8CUojdF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfkTGieR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e07cd7b798so14040235ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711129788; x=1711734588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfoeq+6cUg1dwSHsoYFFrThY/ANh42EGrvYWQB15MVo=;
        b=cfkTGieRSy/Hmx8Ei7Sy9yUIsAXDQh/+xXkInSPPb6j77xHYrZKA771nSryF6mZhwE
         Gr2nzOIFsbkUiR6bMcyS6hyv2c2dRAIjs3MomRRGDo9k7gzUDHomRFsUyybK31UtFwT5
         CLlsCY2mwMd8pAi3yuPaPp6yDu6n4YQNESfCWPF0wfD0pc1IhCXWCUyaHaVmpeHd190P
         qvPnTiC49O1+xJum9mD/gZD+Xf7xTQnZV16XOwnWUweSEwDePAx5V9eRAuWLKe01bmqN
         RU85EcLX2wb4oNXGtZi1+ApPM+PR9F5Z1YeUv+uIZFzjEfiB4htHItLVeULg2YlLMTD5
         1MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711129788; x=1711734588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfoeq+6cUg1dwSHsoYFFrThY/ANh42EGrvYWQB15MVo=;
        b=RQuY+883WMba12NlIv23x/pCYlLefwTECwAN9NBIN8+Kw9ze/zyAneQlKhl7rVM8TS
         2iTgxrOJ2BzyBJxNAAJJkFluqO0fr4xLxjURqATZen7w7J5oyVUl0TCjBT05TvkhM7+m
         xnhLEN72UHsdVzFYKSTVnb0Rek4dfx+3QGRLlnuKxMj0QE3J1VOJrY9KWfrT+3YM+JRn
         4tg6o2cwUNEjdQGRKSZIhO6F3L+Kczahq4mhQXgUTyAO0HvMNpWefM5cuYb7Ejy3XsC+
         I9Ly3tBvmzEugDPYzRGyawN73rRt1Alr3v7XKRwfh7RgX/l+s4bFG1eSO561UnS5OTMg
         SLeA==
X-Gm-Message-State: AOJu0YxMoRi+BLH3wz0d7rDZvPbm5IdEA85cDQkOcih5WS8iXjASaVkY
	xek9wcTdrgfkLug0w5Csy0q4MiAInT0Wcy2Sq+51+WLLlO8mG9HbRsPpKzuT
X-Google-Smtp-Source: AGHT+IHBSlzdL28oxOsi0qLLtLmepKBeRoliIAW4D4Xdq2dsDZAjxf8EhlE4bkXQ1af/N3YqWA+R2g==
X-Received: by 2002:a17:903:40c2:b0:1e0:1174:6360 with SMTP id t2-20020a17090340c200b001e011746360mr529213pld.14.1711129787822;
        Fri, 22 Mar 2024 10:49:47 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:cd6c:4747:ed85:6091])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001dbcfa0f1acsm2061plg.83.2024.03.22.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:49:47 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v4] f2fs: prevent writing without fallocate() for pinned files
Date: Fri, 22 Mar 2024 10:49:43 -0700
Message-ID: <20240322174944.1460441-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
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
v4: moved pin file check position in prepare_write_begin()
---
 fs/f2fs/data.c | 20 ++++++++++++++++----
 fs/f2fs/file.c | 16 ++++++++--------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c21b92f18463..88896989bb28 100644
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
@@ -3414,8 +3419,15 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 		/* hole case */
 		err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
-		if (!err && dn.data_blkaddr != NULL_ADDR)
-			goto out;
+		if (!err) {
+			if (dn.data_blkaddr != NULL_ADDR) {
+				goto out;
+			} else if (f2fs_is_pinned_file(inode)) {
+				err = -EIO;
+				goto out;
+			}
+		}
+
 		f2fs_put_dnode(&dn);
 		f2fs_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO);
 		WARN_ON(flag != F2FS_GET_BLOCK_PRE_AIO);
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
2.44.0.396.g6e790dbe36-goog


