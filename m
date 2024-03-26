Return-Path: <linux-kernel+bounces-119924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F588CEFE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E75E1F33FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCA712B152;
	Tue, 26 Mar 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cll2y3EP"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531712B149
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485096; cv=none; b=eMqxnD1Q7EPgbgQ7kte87RmWIujj4wi1M1csZjwogWP3ocYE0k8sawADGvSPSEy2GYb8vmzAJ3DUQCCXrKvqUnE4RkjqscX5QB27G+Of+23UzzD8CXQMX5+2eGgBREGYB+zzulRaRgFhkhMfmYOwlesy7EelmYSmZHPMpyIFsjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485096; c=relaxed/simple;
	bh=evfHZFmAivw5Tzsqyp6alzJJjVcNw+9R6AYc1vJWM+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4egdhDh+GFOWm0fIv82smjWYSIIbgViBkFO8TZ0SXAMeycI3GHRd47F0XlNKMs9vGeUvxHopcOz9B2Rq1mqpXXNgnydILyunbWyxIGx+3BxU2ZxO8pjhhlax1uSWYl5DuU4BYY3cIl6OST4Iqf9bVzkAz/6Y/rLf51ag9D2KK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cll2y3EP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso4336355b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711485093; x=1712089893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWIpvUmmuUd4IVbU7Iw4AFY1pG5K7APNMP8l68hu9ho=;
        b=cll2y3EPYFjCGoPgUtklR6X36t3hYQP8vrmdO3UMZq34M+yAAw8ieiQoIvjqZkkVbu
         lwAfkB1iTvILjoSktIrgrZVVtGiv5XpYkKaxtrNejQE9WSUj3iY5rU6Ea3pvKKAuoOoZ
         n8Q0F0/BCERfN1MlXMQtx62HYOiyUTjKda2antrUQ3FDi5c+RJwHMLZUp2brvSO1fT7p
         ECF6QHmvuU2hEUpx+ZzhfYD+Is67ydlJKkWi06ZGeMo3ppktkZl38vo5AEEqHph9yj5e
         6vgL/LUJSXbJ3HUpcNDpHeSEXyvi3TDYyVG+JKimF0Fc58y/vEmcWIJoCrRD9CP5EeNa
         KD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485093; x=1712089893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWIpvUmmuUd4IVbU7Iw4AFY1pG5K7APNMP8l68hu9ho=;
        b=k6+pcxK+SvLbvwggmr6hosg0suE+GqxjxXvSGtZF72YDfj0XXok+nd2WPidq/pPQ0V
         7Wh+bTks3szPv/J1dltAh1LH55SPfU+JmJKrPcYmWJHEl7jRP3ND46jDC7r/jKpYaQlt
         mkJaC14x5DZ6EllQ6iOMcUU55GpLOVYC1W2++8zHF3vW5urb/qtJwVMfAZYj8rC0vNL8
         99k2cRyCwV/d/71A+AO8JfX2a6sdUSygtxWdAOLpOf0LveOH5lKeB6woX0EKxG2kMyu5
         zOQ1T95qhEhkbNzBm2APumBiPIgS7xF5ZAQFn2Aq2idKJnZdR6qX8/DJbzOs1/L7NVWy
         +KNQ==
X-Gm-Message-State: AOJu0Yyndi4bRR+/4sXfle/jWaSG3JM/okd0/l88CcZfrOKmIKZXd5GY
	l5f/pqaEWX4AXnMOyYdgn+b0lLo7jVNIEksSfXkA9WUfvQjPxTQPZmsZv1gB
X-Google-Smtp-Source: AGHT+IFvFxp511Ppefu6lB/2hF5JJHC2DrMBwr+oLjF2vHyJWwQlH/ghml9tDaCKjUMnMtZTyYhbmw==
X-Received: by 2002:a05:6a00:ad5:b0:6ea:7468:1f31 with SMTP id c21-20020a056a000ad500b006ea74681f31mr997043pfl.30.1711485093309;
        Tue, 26 Mar 2024 13:31:33 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:6e7a:7c1d:ebf:951e])
        by smtp.gmail.com with ESMTPSA id k9-20020aa79d09000000b006e535bf8da4sm6364595pfp.57.2024.03.26.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:31:32 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v5] f2fs: prevent writing without fallocate() for pinned files
Date: Tue, 26 Mar 2024 13:31:30 -0700
Message-ID: <20240326203130.85748-1-daeho43@gmail.com>
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
in the conventional area for zoned stroage. To make it consistent across
storage devices, we disallow it regardless of storage device types.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: covered the direct io case
v3: covered the mkwrite case
v4: moved pin file check position in prepare_write_begin()
v5: removed unnecessary condition in f2fs_map_blocks() and disallowed
    pre-written inodes for file pinning
---
 fs/f2fs/data.c | 20 ++++++++++++++++----
 fs/f2fs/file.c | 18 +++++++++---------
 2 files changed, 25 insertions(+), 13 deletions(-)

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
index 82277e95c88f..7aa53cf553a1 100644
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
@@ -3235,7 +3231,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 		goto done;
 	}
 
-	if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
+	if (F2FS_HAS_BLOCKS(inode)) {
 		ret = -EFBIG;
 		goto out;
 	}
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


