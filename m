Return-Path: <linux-kernel+bounces-141434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432CA8A1E94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201CBB22673
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472833FE3D;
	Thu, 11 Apr 2024 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyqsyqRF"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD183EA9F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858075; cv=none; b=LuRdR+ZtGFkBgNaYq71fx6igejTwZqIYh4Jsj1QsKeGhxZljcRQUr0vLMFIsu9XK3YUOKtyMri9VEtAaGbrGzvFgILCtpU3dr6wPFFR5CibbFykUSCDXy+HTi3hrSB7kDm5Il+Hy8osBYMxq7G6Im7YFGC6MiCIXHH0il73JCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858075; c=relaxed/simple;
	bh=DiXzGFWF0Q4jY6fTYd85xuh+LWKuzapibVjgBpdtagI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwtwJ9F2wQACpRA/aEJizyb4RLYEmSyJAls/lPA6JFK8ZhpHKdLjOJcwXy7qE8RzmN3g1NAZ8kL45bcNIipfzyz9IsvR/AkB4gVcv6xVLMTK/8EGegkpSUJfQWioX7NJMFAgtHuHeXacz7kh/nj7xcbWY54wcEChTtznGrkQS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyqsyqRF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4149e7695so1116965ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858073; x=1713462873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4DDpn1Eq0nNcCdvrJFmNc0O+jMNIAuY67jvBBKAph0=;
        b=GyqsyqRFT+WlllZhmm5ofhxgfnzKVzX38NONmySO+vPaBRU53j4H9wcDTzdGoy5XGr
         5sAm4yHkTGR8lYTre0SjfWOFpy/HzLOODyWpBqD8mYNogbrj7yRkKqCC334h51mFA+RU
         vmMEkxTPDKxajscDtGr5PAcgY1zn3Xj1ktcsOY8WKUsAKsbhli5KLSOzMmJj9qHb8s/6
         znPN8ntVCAvye1MLgKNWR821ypGqyvsgFeIvQdVaSzottD2dwHcie2IUsBAjtvNdomUs
         Pxpj3WT3Uumr8LELoKd5kobX8FFp2vxEo5aX/aOduSxEISkrwkES+6scbiu8jZXDByxb
         Y60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858073; x=1713462873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4DDpn1Eq0nNcCdvrJFmNc0O+jMNIAuY67jvBBKAph0=;
        b=Vk+WJ4pHtOfTXGNcUvtFkofjlGE/wWBhGdlWtENxnZdtBX17lG7SIXX/pqB5axh+BG
         mEyHwRsYskNZdalAlVbd4jfsLdmj3jDcSMQSLPZ9sqEPVzX7cdE6rLZ3OrTMqs4Zajcl
         9fbHI7CngkMgBoRJI7agYR9O/6tzIY+Qd//2JV+8ZaPM0jpnxZMZzmLRmTlm7aDTY+FW
         j0d54QGakET+K6QioR9iW+LJmOnm2VoR21EVEiP8gtKowtgH/dx1muZh8RO6LDepoxXz
         ykE7HitnXTf8rZLB4aJOxwl5ZFutSiiBLudLiHY+cQlsSEILMBC8nt+nSG4hTV9Bnv3F
         7kyw==
X-Gm-Message-State: AOJu0Yy7EHGMuLTDUyAdetWS752r/JfBX9mHyOf/yCHU7X/Pp3t0hm7E
	Nm3PeJSEIJjH/2eK/T96IYMr7tl1FfFqN10ydMBdmcQ+F3K7GoUyuuBKsg==
X-Google-Smtp-Source: AGHT+IH+Ydi5OoZ6JvRFdb+9Ii5yIhzKmvNDZeyMKRfOU8fdMRUFJ9zfqBVZ6EsrWL8GMc1frhzAYQ==
X-Received: by 2002:a17:902:ba94:b0:1e0:a3dd:82df with SMTP id k20-20020a170902ba9400b001e0a3dd82dfmr152048pls.38.1712858073005;
        Thu, 11 Apr 2024 10:54:33 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:e309:9090:b8ac:35b1])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b001e0af9928casm1444843plg.55.2024.04.11.10.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 10:54:32 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/2] f2fs: prevent writing without fallocate() for pinned files
Date: Thu, 11 Apr 2024 10:54:10 -0700
Message-ID: <20240411175410.2406710-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
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
v7: changed data_blkaddr check condition in mkwrite()
v8: replaced overwrite check parts with f2fs_overwrite_io()
---
 fs/f2fs/file.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1761ad125f97..3ee61bc82c6f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -58,7 +58,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
-	bool need_alloc = true;
+	bool need_alloc = !f2fs_is_pinned_file(inode);
 	int err = 0;
 	vm_fault_t ret;
 
@@ -115,19 +115,18 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
+		if (f2fs_is_pinned_file(inode) &&
+		    !__is_valid_data_blkaddr(dn.data_blkaddr))
+			err = -EIO;
 	}
-#endif
+
 	if (err) {
 		unlock_page(page);
 		goto out_sem;
@@ -3234,7 +3233,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 		goto done;
 	}
 
-	if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
+	if (F2FS_HAS_BLOCKS(inode)) {
 		ret = -EFBIG;
 		goto out;
 	}
@@ -4798,6 +4797,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	bool dio;
 	bool may_need_sync = true;
 	int preallocated;
+	const loff_t pos = iocb->ki_pos;
+	const ssize_t count = iov_iter_count(from);
 	ssize_t ret;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
@@ -4819,6 +4820,12 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		inode_lock(inode);
 	}
 
+	if (f2fs_is_pinned_file(inode) &&
+	    !f2fs_overwrite_io(inode, pos, count)) {
+		ret = -EIO;
+		goto out_unlock;
+	}
+
 	ret = f2fs_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out_unlock;
-- 
2.44.0.683.g7961c838ac-goog


