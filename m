Return-Path: <linux-kernel+bounces-140873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60918A194F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180581C21398
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1901514E7;
	Thu, 11 Apr 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GVkfeJzU"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E315099E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849689; cv=none; b=ELIWX3dGrxolCztGwvwV5k1a1sssKo0au/0lKPxitJ/f9V4VdyShApZh7IucZkMeoTxDxqiv6DwklUuhuIPF1GfWRYaVOaQt1XwuQzk8M9lGomX0L9f/WV0lhK9oqDfk6MOCcRsvMr4L6LGTptK5LSo3ePfND6ECtPbGnb+WQVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849689; c=relaxed/simple;
	bh=rH4xWmOjEh9ggvK4HZA3bxS+4Y2+sObA+7spUVITJew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSWg5kqaG61PMuEDI+MBa37OVaqvbD/rF+der7HxtSx2bdGCmpZCEyfMYum6KvGtbOiV4Wm2IULdGImOUJ7lT92yY2pUSeWb+hSXGLBQ1/L++KNdIN/Co0suU1vB9jp2GzLLtS1+aetFQ0jHXgLZPzp0MEtnMLfEbbw+0r+nTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GVkfeJzU; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58028439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849686; x=1713454486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alLIDaWImDwGCGuPvCF5X8BDMP8Ns0YtWOOvHhwc1lY=;
        b=GVkfeJzUvTuTOtMsLSh9UiPcciLp8mK/Q0u45InwzaMtpzsicGE0NKI4L3BH32DjHK
         Wl/VYmG5SWI/dSS5ECEAxJ4rCoDVqH2NPm4KvVXp+eEJvfhzUxVvQnvAPIMCBcxdyIbM
         pjYuYj+QJZaQFJlKnuxm9iO/3MkpmluFyScjqDoDZ5tYB6LC60rQPl5Frtlxfaa4HH24
         gO0LdjY+HmtKf+jLaSSgN3xaLrxO6YHO3C4clOB8dM4FTk6rkAliUj4fgikYPltp59gd
         LaKhKSlDDO0Pwu0HGH3BVCtoe1jXPZyw+V/Fx4kKJ8OIeI5cygKAzZ+HyJDWwHJMc3RB
         Q9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849686; x=1713454486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alLIDaWImDwGCGuPvCF5X8BDMP8Ns0YtWOOvHhwc1lY=;
        b=TIi75Ay0C1x6K5VEi27seAuMCBeNbk4KTtt4bBbKEGkKUiMOedKEVIFTMwbNfWcuiG
         kp8DLgln64dmuk/sBrGjXVNqYbrRngGBTUmCDhUu1Qg3OsqvYgaWCcO9+cV9ojb4YaLF
         Qvj+1Edn3iPl2wgoqLzN1SIyZhlZzWDURZEs6hLZ05mSkP3K38xVqcijOKaFuVbgUMp7
         f4wjlqexsXqe2AVqFdamDvE0QaQcvXNFXEYlIm6kozMNT1d/UPezAT/j1bO3BXLGbg4g
         SVnQ4RuBf5p/sD98glCUcyBv7/DGfVI6+WM9xMF/GnUmUOHlUZj0PMIbrvLOpiQeJAG9
         pp3A==
X-Gm-Message-State: AOJu0YwPoUEAIFENj1nex6gFyYJV3+jE2ny8RBmdirk31LvAv9pVQXiH
	rux3JSvi47dy52zNy+o3Zqg10Kgr0tvmWMWYhAKsch4apFFrdmSb7PNCUUkUZr24zed8V4xcplA
	b
X-Google-Smtp-Source: AGHT+IHHwIF27V4XkjzNd2/o/b/IEBGt7lTfrtEZ/MpiaVTYdYh22Z+v763odGvqFzijun63z50x5g==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr157230ioh.1.1712849686524;
        Thu, 11 Apr 2024 08:34:46 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 110/437] fs/pstore: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:10 -0600
Message-ID: <20240411153126.16201-111-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/pstore/ftrace.c | 16 ++++++++--------
 fs/pstore/inode.c  | 13 ++++++-------
 fs/pstore/pmsg.c   |  3 ++-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 776cae20af4e..8c7244df7787 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -88,13 +88,14 @@ static int pstore_set_ftrace_enabled(bool on)
 	return ret;
 }
 
-static ssize_t pstore_ftrace_knob_write(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t pstore_ftrace_knob_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	u8 on;
 	ssize_t ret;
 
-	ret = kstrtou8_from_user(buf, count, 2, &on);
+	ret = kstrtou8_from_iter(from, count, 2, &on);
 	if (ret)
 		return ret;
 
@@ -108,18 +109,17 @@ static ssize_t pstore_ftrace_knob_write(struct file *f, const char __user *buf,
 	return ret;
 }
 
-static ssize_t pstore_ftrace_knob_read(struct file *f, char __user *buf,
-				       size_t count, loff_t *ppos)
+static ssize_t pstore_ftrace_knob_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char val[] = { '0' + pstore_ftrace_enabled, '\n' };
 
-	return simple_read_from_buffer(buf, count, ppos, val, sizeof(val));
+	return simple_copy_to_iter(val, &iocb->ki_pos, sizeof(val), to);
 }
 
 static const struct file_operations pstore_knob_fops = {
 	.open	= simple_open,
-	.read	= pstore_ftrace_knob_read,
-	.write	= pstore_ftrace_knob_write,
+	.read_iter	= pstore_ftrace_knob_read,
+	.write_iter	= pstore_ftrace_knob_write,
 };
 
 static struct dentry *pstore_ftrace_dir;
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 56815799ce79..581f014149a9 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -127,16 +127,15 @@ static const struct seq_operations pstore_ftrace_seq_ops = {
 	.show	= pstore_ftrace_seq_show,
 };
 
-static ssize_t pstore_file_read(struct file *file, char __user *userbuf,
-						size_t count, loff_t *ppos)
+static ssize_t pstore_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct seq_file *sf = file->private_data;
+	struct seq_file *sf = iocb->ki_filp->private_data;
 	struct pstore_private *ps = sf->private;
 
 	if (ps->record->type == PSTORE_TYPE_FTRACE)
-		return seq_read(file, userbuf, count, ppos);
-	return simple_read_from_buffer(userbuf, count, ppos,
-				       ps->record->buf, ps->total_size);
+		return seq_read_iter(iocb, to);
+	return simple_copy_to_iter(ps->record->buf, &iocb->ki_pos,
+					ps->total_size, to);
 }
 
 static int pstore_file_open(struct inode *inode, struct file *file)
@@ -170,7 +169,7 @@ static loff_t pstore_file_llseek(struct file *file, loff_t off, int whence)
 
 static const struct file_operations pstore_file_operations = {
 	.open		= pstore_file_open,
-	.read		= pstore_file_read,
+	.read_iter	= pstore_file_read,
 	.llseek		= pstore_file_llseek,
 	.release	= seq_release,
 };
diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index 55f139afa327..83fef50ecce5 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -33,11 +33,12 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
 	mutex_unlock(&pmsg_lock);
 	return ret ? ret : count;
 }
+FOPS_WRITE_ITER_HELPER(write_pmsg);
 
 static const struct file_operations pmsg_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= noop_llseek,
-	.write		= write_pmsg,
+	.write_iter	= write_pmsg_iter,
 };
 
 static struct class *pmsg_class;
-- 
2.43.0


