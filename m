Return-Path: <linux-kernel+bounces-125321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33068923F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4083F1F246BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1110C13A3FE;
	Fri, 29 Mar 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc/6SO4E"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78013A271
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739610; cv=none; b=lVb8fKEAWpTEcU9XywkzBiA+hmHOETbml74DfaHMAh0vL8Ks7azATRJUOTdNpEKd+p8W9UJ9MbxVkXWFnbldJY0duHyKtiEKFTorS24+O5ndCk+yK4ja9ewX/sxuVmZhwTrgZJn90PUfzvW2Kko+piVJbpoQeuZ9iJ2j+W6mHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739610; c=relaxed/simple;
	bh=b0sLfyWVwjwJJT9f5putmYJxfELv8eQZ5BZuJLn5fKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CshzbzKojy04jqMkMqSmjgeiSVkLVYbUfIrw5qcSCm08Iydu24Yd8eT5pVsryqfGDl2fz5fuLTii/RuRmkw0VdF5D4ZPPmiIP1AXAgra2sDVtzq70m736Cs+84QBrTagqNCCW3b4uwkWDAr7YDZjNWc3Ttk8SV3MhVOIfhWpRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc/6SO4E; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0ae065d24so19905365ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711739608; x=1712344408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OC1MEhfk5zHZtmtDn8IoZmjvwG8ImnYzdrSVs5t8doE=;
        b=jc/6SO4E9SdhHarzOstCZIqXrmvJsdlzVTgvE68Bme6zfnRfIOqe2e1TDBkGhMEgwM
         x6GzEElmtdwBECP6ZNtFVbWI78I9k3coQ+eq3oYx3Eu084Gs7G9zT2wZyjpDoPegM4AZ
         HhJ8Y+8/SCYOz1ELHaNxs+L1KgCWstsoA+97rZLupkJWgW+Ho0jg2D9y9rwQi+TPPjZo
         faOFUaIYO8fuSrRxPvPO3uZB2IZQkLXfstuQkbO3Iqw4HVeeMX9abFwpKlCjxSduyL+9
         O1KXdW8UL0xwngLtoy5YnnQIhchRJc0SvRY0j5u4EQFiG71nMqY8delz8pLyBN6NsJ5l
         Tn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739608; x=1712344408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OC1MEhfk5zHZtmtDn8IoZmjvwG8ImnYzdrSVs5t8doE=;
        b=b9LsJt6JkmoJx+lbMIatMgaWrZQ5EFmWGnPJZnS/gUK6oL47F7/1z10vnSDAdjAnfP
         cqbPe/h/TKwbNHnD4Cf3APREMyGcWZ+mkXezS+2neos4TGVvqsZlXFZ6DWJ12QKEXd6P
         g/2ulVqxtgflt6i6qj9u/ld5ipI5bWWrWWMpXTD2V5oLyfyU2hWP7sa9Xpo8K7pxChsx
         V6gsCJ+ZmqnxchAVY4PTU5ewnnUrxwyItGULZZCcywMUTPKKgQLXNMg9HRavnzZ/w3cM
         XgE4a2RO0SEKzoZJc6vReVQOCdNGzl/kM7i/knRidAWpLVXHTP7PrkWVr7IzcmH7wFkw
         h0QQ==
X-Gm-Message-State: AOJu0YywH5UYeq936A0XmDwF9bOsQHD6JtJKYmkRetYKuDDD5BR1/VW3
	gEuobClLkBBhL25hQITV6evKCM0Jf1cVLXHAniBkGO8nXwHRNAkf3HABNzTD
X-Google-Smtp-Source: AGHT+IEknzraJh4UqQ4FSWGhNpf8wM7e2P/YApxyqJgZzWOUOjUwadFbO+GrnpnhMgoLnPvfhVch2Q==
X-Received: by 2002:a17:902:9691:b0:1e0:e85b:b9ca with SMTP id n17-20020a170902969100b001e0e85bb9camr2974329plp.21.1711739607464;
        Fri, 29 Mar 2024 12:13:27 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:c1e7:139:2884:f40d])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b001e0fdc6e4e7sm3805147plx.173.2024.03.29.12.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 12:13:27 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v6] f2fs: prevent writing without fallocate() for pinned files
Date: Fri, 29 Mar 2024 12:13:24 -0700
Message-ID: <20240329191324.3233324-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

In a case writing without fallocate(), we can't guarantee it's allocated
in the conventional area for zoned stroage. To make it consistent across
storage devices, we disallow it regardless of storage device types.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: covered the direct io case
v3: covered the mkwrite case
v4: moved pin file check position in prepare_write_begin()
v5: removed unnecessary condition in f2fs_map_blocks() and disallowed
    pre-written inodes for file pinning
v6: check a hole for pinned files in mkwrite()
---
 fs/f2fs/data.c | 20 ++++++++++++++++----
 fs/f2fs/file.c | 20 +++++++++++---------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c21b92f18463..1b02a9291176 100644
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
+		    (f2fs_is_pinned_file(inode) &&
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
index 82277e95c88f..6793c96019a2 100644
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
 
@@ -114,19 +114,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
+		if (f2fs_is_pinned_file(inode) && dn.data_blkaddr == NULL_ADDR)
+			err = -EIO;
 	}
-#endif
+
 	if (err) {
 		unlock_page(page);
 		goto out_sem;
@@ -3235,7 +3233,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 		goto done;
 	}
 
-	if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
+	if (F2FS_HAS_BLOCKS(inode)) {
 		ret = -EFBIG;
 		goto out;
 	}
@@ -4611,6 +4609,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
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
2.44.0.478.gd926399ef9-goog


