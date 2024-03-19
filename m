Return-Path: <linux-kernel+bounces-108149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09B68806AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F652842AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C94F606;
	Tue, 19 Mar 2024 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFWs7HQ+"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB544F5E6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883403; cv=none; b=H5li/g+U41tjKPtq5l98SWkCjObWaTVyOmOSsWEybAnK5juseZ7CpMKWRfYSDKOphOxx3g/STUKrCxb4ljOx7D97xcqbWNID6D7qmatbo59SPFpk4eJ8DRa6drkZoE7MO7Kj4ga6PgDzhdkEfT21UV+qui7zb0d9E8cGYJb+etU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883403; c=relaxed/simple;
	bh=I30bldMoMsql+hzCHnhN/5IetJJd8PIn6Aa43/sDw8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxzjB4Fw1SACnk3sUNpkbJaYYLKMs2SJd1s7dMTOuAbSycenz9hyOyAgfmr49/jLapOs+px85e9x19bbcdizquhFS7Yrz7HuejpvyaLVMH6YsdgD/C1qffYOyq9Rnnr+hugQhntHpl3k5bjc2Faz7+vqI2DHf6o3HulzR0vvaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFWs7HQ+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dd955753edso49012975ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710883401; x=1711488201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbVTZraF0QJZsJx7Z45tBr7Rj39spiA67Pwo/WgWCSA=;
        b=LFWs7HQ+9hpb/ndFR7SVSx+ApeQBBfaUqdzQi2x4751vMLjW96iM3sbtU0xnXi8jGU
         jXq5vjfkXoWgrdyMVMYvxYzVpDD6ycFuthv3xD7PQ+QpUCKuNe639J3c9VNdiabInuey
         w8IU1nrcr4soeqmY69LCpJZ29RPajeOTB93mBpGKA6Z46p1AeyFa63iJD6y0my6nr2Ri
         57ABALGLPyO5z3Coa+7eHUMQQCUGrjWu63ug8q16WRjJIfvpo8XktceuParIUakFyRBU
         TeDt18RlwdBzvO7Y2GZ6PEzVMiDij/ZkbTQzTnG1kKTTiay7y3spF+0jSUCNafBxaElR
         KgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710883401; x=1711488201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbVTZraF0QJZsJx7Z45tBr7Rj39spiA67Pwo/WgWCSA=;
        b=N9jxOpwqZWsQ743XLCulgPLcR9j7pNCU1jhwhrDF7my0fjuZEv5ps41MJpkvlPf9Iu
         ZytpB8+I8B0c+rhUgGoL9rJwQ/IFFT+27jj20hMdTC59SEx5yEesV/cPPPf79vdpB4or
         0he9XCcVW0dDciw7RLcrq1eBThwetMqLtIF0hdxdWZOx3a8J1zd2WsfYR/K5wrz+fahy
         ev7P8yMz5jeGYGNCp0JZi9jK4woBLNwHVerdYwi+WIfRuXyAkVB+tJUgvFJr2dnqPLey
         Wgt0lt6VWo70fA7YzXOv3wir9QySjOV+LmnPzn8otHgxyU3x2s9ilksfMVL+hc4U5LfK
         IMVw==
X-Gm-Message-State: AOJu0Yxp+S5e2gdQMRmjnKtPixoY79d0viAT8flInWJBncH02ty/VWzX
	mGUadAf125EmmJoyVSnnGz6mo6ypBJEpikPT0xf0NSRbHX4j7wQHHEU0nuAU
X-Google-Smtp-Source: AGHT+IHdjdv+4okA5Kq7qrqysZRqYyE5cosG4uacKotZlgLZ+KDOK+5X2eAlLu/RoJua4ZlsLFOqTQ==
X-Received: by 2002:a17:903:11c8:b0:1dd:8ee9:62c0 with SMTP id q8-20020a17090311c800b001dd8ee962c0mr16359417plh.34.1710883400709;
        Tue, 19 Mar 2024 14:23:20 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:ce48:f01a:1f52:5e0a])
        by smtp.gmail.com with ESMTPSA id lh6-20020a170903290600b001d94678a76csm11893613plb.117.2024.03.19.14.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:23:20 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: prevent writing without fallocate() for pinned files
Date: Tue, 19 Mar 2024 14:23:16 -0700
Message-ID: <20240319212316.4193790-1-daeho43@gmail.com>
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


