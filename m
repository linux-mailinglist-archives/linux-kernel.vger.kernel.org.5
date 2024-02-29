Return-Path: <linux-kernel+bounces-87559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AE486D5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D727A1C23AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B643474C0C;
	Thu, 29 Feb 2024 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="KVl0+JQc"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64AA74C06
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240870; cv=none; b=Ke6NBOw7a4Pba+2IwuCpn1SZiuJ7aDtyLmS7zSMXdiBfQIFIud0J5UknPlfkqACpPiEVwdzFL/0kv4ugP+fXz0+JkB4hCax2nVw6+ogCbC0LuUG/49BkWyMSe150Bf4DKOI74L0PJIE4tCmj5BGq6GqLaSNbAoj/7/VbDD9DfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240870; c=relaxed/simple;
	bh=P40kUziuLyokqt8ezOh5PiObVcgjV29/BsW4rgJQ09Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCE9adpuAWOJL6GEv1eveOJEy2QkZhY3BqDfqWRX873GABXul8UEiKdPlHxqW+Ppl+iCpNXZndu3ZzNnZC2ToRI7qn4naTIV4BKH9KgNqVFmQCR/wySAYjGCs+fxJWjqly4/SuQli/zq54SCDHrGN0yTZg08wLPO2k8y6XwjU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=KVl0+JQc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so2100021a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709240866; x=1709845666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdfXWZLLwYzD+iUoGVhhT8Bl6KEb0/kYlFIi77YTG+g=;
        b=KVl0+JQcBEFCdQ1RQiT9cs4oecfEay9r63aTFHSUa6vaecAjqHaY6ueRxQPHilJKkR
         DOdPPR8ZzjiNhvks2coaNEUz2hd0fA9mU2fH+l/+g5OL/psHBlZ9eUiyIWc4HXkVhsnn
         tHVt681jDxtXTTG81LlZ7CRDdlanhKYF1Iwvnc/e4SK/z3Fq5XBeuFItfKp9vxovElkF
         5LSp638tEj6i3zIkA05bk3nv9gOe2v18viMs82Ero/h8XtYm7UQx8nFK6pTO4xkNqc+q
         TH0gpOU+JNXV0M7+0T1hd2FikXM7vO1zEdOrwS/qLnQviUNOwEbUKw0dCgDVUj41pxae
         mEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240866; x=1709845666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdfXWZLLwYzD+iUoGVhhT8Bl6KEb0/kYlFIi77YTG+g=;
        b=fXFBJjuyfI3iSF2U9uXmXqNAZI7i2KfXFMg92y3LhuECeq/WDREwir9BLIXm9SjJRE
         TcZmp3mLwLLa9VcM6IJsx2lxM3YJ/YkAkNEB3sK/qicoBF20eFBygtyQ7sGeVWlyx+jX
         zEwK9tkB0Gu2JiSFKhZt40u1iGEShbKZ1jkOrAIgO7Jc8AglPQ7C5e0omRpZKkxW4npP
         F9x07t2ejR5NJtclLSdEUi2YtZ7/foEvA5RedivdyORXDVVU0ZEizwKoDUVNVQabKJhr
         3x4C8z+9GQcHTsCCR1eKtXJq/BtbiHdUxJWwstT1wkWXQ1KqGoH0krcaPvVEqn/d6mt7
         i1kg==
X-Forwarded-Encrypted: i=1; AJvYcCWuqcn9h1/BOnUlA38HnGLZQyVXm0VGWJnLGo1hHmWRa7UsoV1GHxxggDMbTcV/QJl3paQ0dEwy3POcQml9YmKL8pFq4uZDo4a7/CVJ
X-Gm-Message-State: AOJu0YzclNy4zCwPpp3J4PN2aVNjoPle9mzvfQnmOosu24vMjfgDhsel
	VVIAod4JORlRc1M55aJ5taE8uyf0Wnwhe6WGQsgmFv29urwIo/pODISF1RUx67A=
X-Google-Smtp-Source: AGHT+IEdNq8FL3WIQtocjEY8iv1pn5uPjnjxy3oOJZ7eihaUljPVLdkjzHOlXeu5voZGbgrbGmC1gQ==
X-Received: by 2002:a17:906:1685:b0:a3f:1530:ab16 with SMTP id s5-20020a170906168500b00a3f1530ab16mr75240ejd.74.1709240866132;
        Thu, 29 Feb 2024 13:07:46 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-35.dynamic.mnet-online.de. [82.135.80.35])
        by smtp.gmail.com with ESMTPSA id fj5-20020a1709069c8500b00a3e8c3fc3ffsm1045279ejc.10.2024.02.29.13.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:07:45 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: konishi.ryusuke@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-nilfs@vger.kernel.org
Subject: [PATCH v2] nilfs2: Use div64_ul() instead of do_div()
Date: Thu, 29 Feb 2024 22:04:57 +0100
Message-ID: <20240229210456.63234-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <BFEA2A31-3147-49EF-A9BE-592C90E783DD@toblux.com>
References: <BFEA2A31-3147-49EF-A9BE-592C90E783DD@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Coccinelle/coccicheck warnings reported by do_div.cocci.

Compared to do_div(), div64_ul() does not implicitly cast the divisor and
does not unnecessarily calculate the remainder.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/nilfs2/cpfile.c    | 2 +-
 fs/nilfs2/dat.c       | 2 +-
 fs/nilfs2/ioctl.c     | 4 ++--
 fs/nilfs2/sufile.c    | 2 +-
 fs/nilfs2/super.c     | 2 +-
 fs/nilfs2/the_nilfs.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 39136637f715..bafbdca1a17d 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -28,7 +28,7 @@ nilfs_cpfile_get_blkoff(const struct inode *cpfile, __u64 cno)
 {
 	__u64 tcno = cno + NILFS_MDT(cpfile)->mi_first_entry_offset - 1;
 
-	do_div(tcno, nilfs_cpfile_checkpoints_per_block(cpfile));
+	tcno = div64_ul(tcno, nilfs_cpfile_checkpoints_per_block(cpfile));
 	return (unsigned long)tcno;
 }
 
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 9cf6ba58f585..df5324b0c0cd 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -460,7 +460,7 @@ ssize_t nilfs_dat_get_vinfo(struct inode *dat, void *buf, unsigned int visz,
 		kaddr = kmap_atomic(entry_bh->b_page);
 		/* last virtual block number in this block */
 		first = vinfo->vi_vblocknr;
-		do_div(first, entries_per_block);
+		first = div64_ul(first, entries_per_block);
 		first *= entries_per_block;
 		last = first + entries_per_block - 1;
 		for (j = i, n = 0;
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index cfb6aca5ec38..f1a01c191cf5 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -1111,7 +1111,7 @@ static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
 	segbytes = nilfs->ns_blocks_per_segment * nilfs->ns_blocksize;
 
 	minseg = range[0] + segbytes - 1;
-	do_div(minseg, segbytes);
+	minseg = div64_ul(minseg, segbytes);
 
 	if (range[1] < 4096)
 		goto out;
@@ -1120,7 +1120,7 @@ static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
 	if (maxseg < segbytes)
 		goto out;
 
-	do_div(maxseg, segbytes);
+	maxseg = div64_ul(maxseg, segbytes);
 	maxseg--;
 
 	ret = nilfs_sufile_set_alloc_range(nilfs->ns_sufile, minseg, maxseg);
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 0a8119456c21..c02b523d9c7e 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -48,7 +48,7 @@ nilfs_sufile_get_blkoff(const struct inode *sufile, __u64 segnum)
 {
 	__u64 t = segnum + NILFS_MDT(sufile)->mi_first_entry_offset;
 
-	do_div(t, nilfs_sufile_segment_usages_per_block(sufile));
+	t = div64_ul(t, nilfs_sufile_segment_usages_per_block(sufile));
 	return (unsigned long)t;
 }
 
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index df8674173b22..fc19ccfe555c 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -448,7 +448,7 @@ int nilfs_resize_fs(struct super_block *sb, __u64 newsize)
 
 	sb2off = NILFS_SB2_OFFSET_BYTES(newsize);
 	newnsegs = sb2off >> nilfs->ns_blocksize_bits;
-	do_div(newnsegs, nilfs->ns_blocks_per_segment);
+	newnsegs = div64_ul(newnsegs, nilfs->ns_blocks_per_segment);
 
 	ret = nilfs_sufile_resize(nilfs->ns_sufile, newnsegs);
 	up_write(&nilfs->ns_segctor_sem);
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 71400496ed36..2ae2c1bbf6d1 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -413,7 +413,7 @@ static u64 nilfs_max_segment_count(struct the_nilfs *nilfs)
 {
 	u64 max_count = U64_MAX;
 
-	do_div(max_count, nilfs->ns_blocks_per_segment);
+	max_count = div64_ul(max_count, nilfs->ns_blocks_per_segment);
 	return min_t(u64, max_count, ULONG_MAX);
 }
 
-- 
2.44.0


