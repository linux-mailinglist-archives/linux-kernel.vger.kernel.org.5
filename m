Return-Path: <linux-kernel+bounces-100773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9B879D13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD5D282B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC8A142919;
	Tue, 12 Mar 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba9qWc/V"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9170382
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710276584; cv=none; b=h8EBsF3hzJF1wMYYQDZbZ61+x5kw/LSIm7b+ceA01b2+i+NMJ/0IqLyhIx/Boel+pTSG+5AHfnXoclnJ1WG3FRNEjsyvAkfCBIPidK8W25O6qxNsO5ipDy6eXia7q8u3fX1ZwyZMvWHLxh5y5yYVs92RpIEOXU3sWE22MjjeEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710276584; c=relaxed/simple;
	bh=s7yetZINvVGkwh2viHpzX3thMCYNMMpe0vsJdDUq/6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1VyEnLa8yU2EHfJWjW71VznlnaENLDu++L5V5JnK/3q1nWT6JI9Z1YHZBWsvC0yImkANk9JlkphhzWwWNbt3FNvJfZLqr3lzQoCflVTREoVaY8FCJOj3Yn484u/Dk3OaHDYT7RnDmZ7W6Rbw3WYfXZUPSVoJu8NrL7Zqpa9LHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba9qWc/V; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6b54a28ebso247849b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710276582; x=1710881382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bB56P06OHjbd5cYcDuPAUzuPbwD4N6mkH0bYvbyASco=;
        b=ba9qWc/Vms/5MkdwAanguIcYbjH2/rLCxovCeFW0pk/g7rBQo7Awxja2y4JROK8D5j
         nDyOp8+hMJ8a/EoeNnJ/G1GsrLxhj0V+FHGjpTNxCPZ08A7twzCYHMfyq8j3sAqqSxMT
         wqQrzy31KYkXsN5kHY2aSTxUqdsvFYN58FH9nNAQC1l5Xkj1NTa9yRWJRiOmweUufg8c
         T1dqIynhFZkhX8Ky20fYznGSQd2/w1GavDibLkxa0qUNzC0hjZHA+rXRMb6odzDAD+1N
         6VR8xiopqzpsU3jT4YvmQHSImAb2FJzXk6fQiSErQ+fdwQ5beohg9UJeCSS4aWzRB2Sp
         OxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710276582; x=1710881382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bB56P06OHjbd5cYcDuPAUzuPbwD4N6mkH0bYvbyASco=;
        b=SNmAa6T1Dr3VAv1yx7P98C+b6x02QiKe66NZyHLLd0jgigOTglEJoeXUI588cfIZOu
         V+ZmMYakLRDwXGHw8ahB/W+Afn9fUDWjzk1mgskhr2l2PYGYXCTF14YToG+W0rCiE4X5
         GfeMoDbGGhNVtCM1pLF/XYhc9JIoQtZBSBKTnyg5hVih+U4x5GOxWaY68qJgVIMYLiCf
         XwizHTKGSIsMxLDXG0YA2aE26iL+AcjvowmKuUM92rW3J5RBPsoFG/l1IH1XUeWhud+Q
         ToPN229bLrI4kF9r+QjpQllJidQBd7zXah/rX8zd89+QnTeWb9Pf5DHB/ZRe9aKiG9Tv
         8yhA==
X-Gm-Message-State: AOJu0YyKaIu9takfpP6NMFM1Pm9PHXWRz7XJGuvtD7lFDX1ZUgL+bpXQ
	N2zmzGTnDqggr497ETY2bNJbDn194SQdiVS3/Y1Czcr2RrSn4cnFqVxG2XsT
X-Google-Smtp-Source: AGHT+IGCBd+YyZi0mfy1tRQSsTshYWkyuEEX55fLUykzElnQVOW63tOvfLKwEZDTGkkdyJ1s08PYAQ==
X-Received: by 2002:a05:6a20:948e:b0:1a3:1136:e71e with SMTP id hs14-20020a056a20948e00b001a31136e71emr3755548pzb.36.1710276581649;
        Tue, 12 Mar 2024 13:49:41 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:2d5a:c16f:aa67:a34d])
        by smtp.gmail.com with ESMTPSA id l17-20020a656811000000b005dc8702f0a9sm5714191pgt.1.2024.03.12.13.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 13:49:41 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: prevent writing without fallocate() for pinned files
Date: Tue, 12 Mar 2024 13:49:34 -0700
Message-ID: <20240312204934.2249696-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
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
---
 fs/f2fs/data.c | 14 ++++++++++++--
 fs/f2fs/file.c |  4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

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
index 82277e95c88f..f98730932fc4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4611,6 +4611,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
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
2.44.0.278.ge034bb2e1d-goog


