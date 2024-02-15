Return-Path: <linux-kernel+bounces-67646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7BE856E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854701F222AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F2413AA3C;
	Thu, 15 Feb 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMTIPpJW"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4913A89D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028199; cv=none; b=h8wwNeSHBhq0Sc/VlW/Xu2hKSZNEh+ExQcI6AK1kA3mKisIPi1PoqLw+CDGQ+X/oGFbTTR1t6oZGmxVxqlKv8VzvrXuZd9M3aPha6nz0L7HUt3G9/21u4CqYYmcCrapqPWhUbMBV4/UO53VsnSPiXngQK2mE65cz8FYiAoo0mQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028199; c=relaxed/simple;
	bh=Rc+wFF8XwoxmiSTIWAhXtIZ51HaxsOuoOAWgYCs312I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fu0FZ/s0IqNuQLOO07WtJXD9RrW+uuwvRcVLxKvtGRfliSZH4A0EmAEnogxAmyiMKhdjXOR6IH9JHbyhzAboB5rP+83qsfavdFXLzHmHEP/Y1ywJ3KBvLMHsCfFqsokloXJdUHzgj0sbVl0aIlHFdyOXOHCYpUIeCyXKH5HDQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMTIPpJW; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c403dbf3adso57783639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708028197; x=1708632997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRbCvS6akiTk5hc1Brxft3yENJUwXLjbz8kHtexxn8g=;
        b=gMTIPpJWfl3nCeUIoGoA3eGsGm28hDsAnbuWvu/0y+xIGVMS1+RBoDT8XnwWPBMYB2
         jGraUdsemUkjQbvZYxkHCvxJMRHmFmf6oJWvNm4R2wI5PTraR22cIdKD1sVeogYuH9Rk
         ZIJZ2SrNrJ5AeaIqNsm4xoL2UZyRcgm99oXHy9Nhu+uWQSnjzZhW/71aRp2s9lapQTZH
         iYR8zrdi4RG6hLOBeQ9VcYGMmzNOZI/SatzQTwDDQJKYBUJBQ3xO2RskPINLikwoxS3u
         OM3GeR4Xa45tQ9vmUxsbypbCWxFtHCkCECmaip4lYq6IJ6MH3GtsYVbPqk7S1LmWn17+
         weng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708028197; x=1708632997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRbCvS6akiTk5hc1Brxft3yENJUwXLjbz8kHtexxn8g=;
        b=Vu2qsdcN/OGmwrcHP5Ttueb1M0YOFdCLIscX3vij3O31TQPnl7E0auNb/IYH5pp/rw
         xVon5bTB+2aIu4od96m4onPwYwIBVwWP0nKcpEihXIAzGyLnhLzQhEaZ/vVOWke8J68j
         tSI4qzzLKelJbD2Z9Goh1/YjY+0QvC0Z/B3WW8AwZgtPCgaBWombWQqOmcPytCORDolv
         tzuiMFeGyh13iUGGH6HDPXQpz5dyG0Mg07fnbsoO4XU6/pwsQRjUPMZrdgmN02J13Q+i
         Ma4klOgUkfLXJ7Zn67pxE5PiU+iIvRILuREcLK9GDdvyTkyp1tcuMQIUshTb0osthX6R
         bvFA==
X-Gm-Message-State: AOJu0Yw5Q4eKbQ9xy7eZ2ba2m45wTLxJeWZMnFx9GaXtWAckmYZwxOfi
	C75okfU5hQSCuxojPP3n5Ksh/S8PXBJv+rDjXlMe9jIpb7q155/gp89pT6pv
X-Google-Smtp-Source: AGHT+IFRY0k5Jgy0p7AxCyDD24+LQh095SXYW99gcqvx7TZpeAvHu8G/N9rBnTECSPbh2xe6rqXu8A==
X-Received: by 2002:a05:6e02:1182:b0:363:ba17:8dd with SMTP id y2-20020a056e02118200b00363ba1708ddmr2921934ili.15.1708028197279;
        Thu, 15 Feb 2024 12:16:37 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:3772:8174:2d71:3b60])
        by smtp.gmail.com with ESMTPSA id o4-20020a655204000000b005dc26144d96sm1628482pgp.75.2024.02.15.12.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:16:36 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: support SEEK_DATA and SEEK_HOLE for compression files
Date: Thu, 15 Feb 2024 12:16:33 -0800
Message-ID: <20240215201633.2365333-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Fix to support SEEK_DATA and SEEK_HOLE for compression files

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 21c3aa93a8db..aa19d8bed479 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -394,9 +394,20 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	return f2fs_do_sync_file(file, start, end, datasync, false);
 }
 
-static bool __found_offset(struct address_space *mapping, block_t blkaddr,
-				pgoff_t index, int whence)
+static bool __found_offset(struct address_space *mapping,
+		struct dnode_of_data *dn, pgoff_t index, int whence)
 {
+	block_t blkaddr = f2fs_data_blkaddr(dn);
+	struct inode *inode = mapping->host;
+	bool compressed_cluster = false;
+
+	if (f2fs_compressed_file(inode)) {
+		block_t first_blkaddr = data_blkaddr(dn->inode, dn->node_page,
+		    ALIGN_DOWN(dn->ofs_in_node, F2FS_I(inode)->i_cluster_size));
+
+		compressed_cluster = first_blkaddr == COMPRESS_ADDR;
+	}
+
 	switch (whence) {
 	case SEEK_DATA:
 		if (__is_valid_data_blkaddr(blkaddr))
@@ -404,8 +415,12 @@ static bool __found_offset(struct address_space *mapping, block_t blkaddr,
 		if (blkaddr == NEW_ADDR &&
 		    xa_get_mark(&mapping->i_pages, index, PAGECACHE_TAG_DIRTY))
 			return true;
+		if (compressed_cluster)
+			return true;
 		break;
 	case SEEK_HOLE:
+		if (compressed_cluster)
+			return false;
 		if (blkaddr == NULL_ADDR)
 			return true;
 		break;
@@ -474,7 +489,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 				goto fail;
 			}
 
-			if (__found_offset(file->f_mapping, blkaddr,
+			if (__found_offset(file->f_mapping, &dn,
 							pgofs, whence)) {
 				f2fs_put_dnode(&dn);
 				goto found;
-- 
2.43.0.687.g38aa6559b0-goog


