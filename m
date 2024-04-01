Return-Path: <linux-kernel+bounces-126421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A1893797
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE001C20CAE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034DBB667;
	Mon,  1 Apr 2024 03:01:20 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040CF9476
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940479; cv=none; b=mTVHOz5BISKs/wb8Soqocyq+QwYVL02RZuzxWNc0zxxcKbmY769bOZb5Tfy2pIEXlx5Pln42Gk2mZA2wOvwuP7Gjj4wRAdJYDwRYskks/rNtLR7CL5SfsfzMABW6mopw6Ihh4sxGF+h1yWHiUx2BBgQtw5FezaxyIStLuMWjbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940479; c=relaxed/simple;
	bh=09cfv2HqlHO5VRCUk7y4Zi5qMZ0l71UdrvTD9j/Li4w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ND57J09MrDNSVWyMKNvi1wj4bKnY/vMMfVsNNGyzKi0FxgTJoPAGAWE5lXNHrtCgPmmUjcA/bwetGkwiOclkq1cXXaf9CA6UFuwF4h2/OSG1JvRhJ+RN2UkOqbKRAMnctHmDMnad93H5hQhLwUsEqjMDLzAAsdY9TZ9HUv2ET6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf0ebfda8so375598139f.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 20:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711940477; x=1712545277;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+TgIiUsE8RrMBkq8bzA1B10PH4cPI3Mb4LWWXLc1x0=;
        b=HCcBhkLp6ZYNIIbZPDm8TIYwpqDkOCyDYMMHBPrKQ3lp7eIZjgSN37pcLIpy2wOUQQ
         jJCsWs9wtZHja+cJMMRVyVHZhjR5v5lofzy9guYQcg5v0cF99qYnTI8lWBrmOZ8ITYl9
         crnFSKfETYgxnJ9DazSceAcDkKXesu3gI1WpbcWtjrlo4afWcXxE3YYwWJWe+Yahwcnv
         ghQKqthq2P3top9IG39QSfA5KvE3tK4KDISqmWg7Ew0Vl4UYPRmCGCTEN2Lx+jCphUSb
         l0/jP0C5c8VfabNTL1ghfxBD11rcFah8rWHuYZUryfrPSgqPFVbBhQby/c9VSK7dIwPv
         I87Q==
X-Gm-Message-State: AOJu0Yyx2iZlbwDqgoVuIoZCk8uApX8jlD2MMgsMYE7Cj6G5Rm35jA+s
	as1fYwwgFaKSNsVtz2gJ4s1dds88eTMjAdajIXTxMgIfzVkN/kuhySrZZJaB1I8kfxka43k/Muv
	MhxoWKiZWtLp6g/cieNVrak5mi1BogWH2YnJ5/iTIOvrSjKz0xSJ/nSCawA==
X-Google-Smtp-Source: AGHT+IHDx9NylnH7GMgaNQCIjd2uCcKvCFj6Y8qWPhA+6GD/eaZhZWSC1eLj7rQ3lSToXkZ93KxMqLtYdZTcSfpjv8rK41CtK7DF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150c:b0:476:7265:9bfc with SMTP id
 b12-20020a056638150c00b0047672659bfcmr499384jat.6.1711940477104; Sun, 31 Mar
 2024 20:01:17 -0700 (PDT)
Date: Sun, 31 Mar 2024 20:01:17 -0700
In-Reply-To: <0000000000001126200614f5c9c4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003c216061500343d@google.com>
Subject: Re: [syzbot] [syzbot] [hfs?] KASAN: slab-use-after-free Read in
 hfsplus_read_wrapper (2)
From: syzbot <syzbot+fa7b3ab32bcb56c10961@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [hfs?] KASAN: slab-use-after-free Read in hfsplus_read_wrapper (2)
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index ce9346099c72..31ae9f95c3aa 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -179,16 +179,13 @@ int hfsplus_read_wrapper(struct super_block *sb)
 	sbi->s_vhdr_buf = kmalloc(hfsplus_min_io_size(sb), GFP_KERNEL);
 	if (!sbi->s_vhdr_buf)
 		goto out;
-	sbi->s_backup_vhdr_buf = kmalloc(hfsplus_min_io_size(sb), GFP_KERNEL);
-	if (!sbi->s_backup_vhdr_buf)
-		goto out_free_vhdr;
 
 reread:
 	error = hfsplus_submit_bio(sb, part_start + HFSPLUS_VOLHEAD_SECTOR,
 				   sbi->s_vhdr_buf, (void **)&sbi->s_vhdr,
 				   REQ_OP_READ);
 	if (error)
-		goto out_free_backup_vhdr;
+		goto out_free_vhdr;
 
 	error = -EINVAL;
 	switch (sbi->s_vhdr->signature) {
@@ -199,7 +196,7 @@ int hfsplus_read_wrapper(struct super_block *sb)
 		break;
 	case cpu_to_be16(HFSP_WRAP_MAGIC):
 		if (!hfsplus_read_mdb(sbi->s_vhdr, &wd))
-			goto out_free_backup_vhdr;
+			goto out_free_vhdr;
 		wd.ablk_size >>= HFSPLUS_SECTOR_SHIFT;
 		part_start += (sector_t)wd.ablk_start +
 			       (sector_t)wd.embed_start * wd.ablk_size;
@@ -212,10 +209,13 @@ int hfsplus_read_wrapper(struct super_block *sb)
 		 * (should do this only for cdrom/loop though)
 		 */
 		if (hfs_part_find(sb, &part_start, &part_size))
-			goto out_free_backup_vhdr;
+			goto out_free_vhdr;
 		goto reread;
 	}
 
+	sbi->s_backup_vhdr_buf = kmalloc(hfsplus_min_io_size(sb), GFP_KERNEL);
+	if (!sbi->s_backup_vhdr_buf)
+		goto out_free_backup_vhdr;
 	error = hfsplus_submit_bio(sb, part_start + part_size - 2,
 				   sbi->s_backup_vhdr_buf,
 				   (void **)&sbi->s_backup_vhdr, REQ_OP_READ);
-- 
2.43.0


