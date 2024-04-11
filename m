Return-Path: <linux-kernel+bounces-140800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B77B8A1905
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D812822AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E06758207;
	Thu, 11 Apr 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KL2rj3+c"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFA556B9D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849561; cv=none; b=eX9yektgZhzbXksbL6TRMxxtFHV+FoqTMBwc8z4O+5TvDd9u/pd78E6WEqQyPCazcrdY8bDYQU/jxfQWL8fA4Iaby1oSec1nfhU6WU0OIWiin8fVJnVPOv72Zx4OFX/ftBLiO7DL0w0rgWowzm+1P9vLt7Gxy/pYode3gPcgay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849561; c=relaxed/simple;
	bh=1WKJzdkHI3L2R8jL5pK/9HrXe2zJtfSVj6YY4TNydrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4igiMIIFHFyzSbTD2mbw+bqmgHQz1aoewq2+QcLTO9fKh7CtmncyfTmXq92v/AhiWn41l4IYmsFptO3Vv9Fhh+8Nrx/C9Hlh24aS4BQ1lpSNkI4hyz0mDYujgwxKiilQPq4YfhhMkQ3kmwqifcTDRCyvfPQULrpFaIv/ogL+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KL2rj3+c; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170430439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849559; x=1713454359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wByA9TDnjq1qFFXO1qsOwLDAjmIWq2kN49uCxHbf/dI=;
        b=KL2rj3+c+jWmuXY5iHCvPLuwzkXOkIKuu1amdg7qnzxddadG5uS+fdF+ssI8i6st0Z
         y/eKIlI6pEWNX14RIc2bdnR2owCIXeNoMxvatXcwEwboJqaEyApKqxZVBCjFxiejRIG3
         KERcYV8mnD7/D9BgBVdXosJDvxwtA//wbwh/P/mLkAOhRqyiDwZBQ+V90TeRuMRJDzwz
         cnoyytRGmuJDhlbK/qu882nV6644z3xXWza/LuXGwYaO7DND+gcrbOV7A1tzAOZQuof+
         rJFrroJJAibdV+I4WIvqnSYDnPFyaAk/VFdhzTCQhlziNcDvBerPhnLtcVNOFsynuDhw
         Ocng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849559; x=1713454359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wByA9TDnjq1qFFXO1qsOwLDAjmIWq2kN49uCxHbf/dI=;
        b=A6BYd/U6+SnD0Mr55N6p4kz8/9Za08/PsFoXBcKH0xMeUhqiKA+VVco4WNpIRLD8HF
         NJxc4ABOcvOcoxRAk9G1pYvy7jK3ENXKdLUVxJOIU333zWAABOUel1IFKJt3x1r8kF26
         k8WDkwvmHMExFDsSJvdZRV9tcFXvKNbMvwLDuM+nfhSvT0B4juYaIMjwxZHBrZ17FdBa
         UGypB6PFT+UODfmZjakFSIO2IajXlPr6+I9e8npBqdZTla96I6a7xWS5d9LzUjTpctoA
         Pd/br5VJwW6fmv7VTVzgMF7nNTSmx+YJ+aeW2X78ftsIoGBNIm10KzRAkmTgOtCnIEyt
         AfjQ==
X-Gm-Message-State: AOJu0YzLFpTNrpz6xu4A3WYdE3GckgBmalSX7glcaOP15iSiH6BT8vLL
	oVveqtx8CQs5NmMatDvbqhGEae4hal9JxivjwMIqYlbPTOG2/EsZ/q1tS/oitDG9eQ2y2k3V8K9
	9
X-Google-Smtp-Source: AGHT+IGpgnqH4wZorIUDja2xCsVL7jr+LOzIfF3sCexHZ/xFzzWZfhbNelTZWLfLjxmlDEDFWHHbcg==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr212433ioh.0.1712849558820;
        Thu, 11 Apr 2024 08:32:38 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 041/437] fs: convert any user of fops->read() for seq_read to read_iter
Date: Thu, 11 Apr 2024 09:13:01 -0600
Message-ID: <20240411153126.16201-42-axboe@kernel.dk>
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

There's a seq_read_iter that can be used, do that.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/dlm/debug_fs.c              | 10 +++++-----
 fs/gfs2/glock.c                |  6 +++---
 fs/ocfs2/cluster/netdebug.c    |  6 +++---
 fs/ocfs2/dlm/dlmdebug.c        |  2 +-
 fs/ocfs2/dlmglue.c             |  2 +-
 fs/orangefs/orangefs-debugfs.c |  2 +-
 fs/proc/array.c                |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 4fa11d9ddbb6..1236e8d13453 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -774,7 +774,7 @@ static int table_open5(struct inode *inode, struct file *file)
 static const struct file_operations format1_fops = {
 	.owner   = THIS_MODULE,
 	.open    = table_open1,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
@@ -782,7 +782,7 @@ static const struct file_operations format1_fops = {
 static const struct file_operations format2_fops = {
 	.owner   = THIS_MODULE,
 	.open    = table_open2,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.write   = table_write2,
 	.llseek  = seq_lseek,
 	.release = seq_release
@@ -791,7 +791,7 @@ static const struct file_operations format2_fops = {
 static const struct file_operations format3_fops = {
 	.owner   = THIS_MODULE,
 	.open    = table_open3,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
@@ -799,7 +799,7 @@ static const struct file_operations format3_fops = {
 static const struct file_operations format4_fops = {
 	.owner   = THIS_MODULE,
 	.open    = table_open4,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
@@ -807,7 +807,7 @@ static const struct file_operations format4_fops = {
 static const struct file_operations format5_fops = {
 	.owner   = THIS_MODULE,
 	.open    = table_open5,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 34540f9d011c..c57d468dce21 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2699,7 +2699,7 @@ static int gfs2_glstats_open(struct inode *inode, struct file *file)
 static const struct file_operations gfs2_glocks_fops = {
 	.owner   = THIS_MODULE,
 	.open    = gfs2_glocks_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = gfs2_glocks_release,
 };
@@ -2707,7 +2707,7 @@ static const struct file_operations gfs2_glocks_fops = {
 static const struct file_operations gfs2_glstats_fops = {
 	.owner   = THIS_MODULE,
 	.open    = gfs2_glstats_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = gfs2_glocks_release,
 };
@@ -2876,7 +2876,7 @@ static int gfs2_glockfd_open(struct inode *inode, struct file *file)
 static const struct file_operations gfs2_glockfd_fops = {
 	.owner   = THIS_MODULE,
 	.open    = gfs2_glockfd_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private,
 };
diff --git a/fs/ocfs2/cluster/netdebug.c b/fs/ocfs2/cluster/netdebug.c
index bc27301eab6d..fde10358c8ee 100644
--- a/fs/ocfs2/cluster/netdebug.c
+++ b/fs/ocfs2/cluster/netdebug.c
@@ -184,7 +184,7 @@ static int nst_fop_release(struct inode *inode, struct file *file)
 
 static const struct file_operations nst_seq_fops = {
 	.open = nst_fop_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = nst_fop_release,
 };
@@ -416,7 +416,7 @@ static int stats_fop_open(struct inode *inode, struct file *file)
 
 static const struct file_operations stats_seq_fops = {
 	.open = stats_fop_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = sc_fop_release,
 };
@@ -428,7 +428,7 @@ static int sc_fop_open(struct inode *inode, struct file *file)
 
 static const struct file_operations sc_seq_fops = {
 	.open = sc_fop_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = sc_fop_release,
 };
diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index be5e9ed7da8d..cd4857d5a44a 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -651,7 +651,7 @@ static int debug_lockres_release(struct inode *inode, struct file *file)
 static const struct file_operations debug_lockres_fops = {
 	.open =		debug_lockres_open,
 	.release =	debug_lockres_release,
-	.read =		seq_read,
+	.read_iter =	seq_read_iter,
 	.llseek =	seq_lseek,
 };
 /* end - debug lockres funcs */
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index cb40cafbc062..673697bfae39 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -3299,7 +3299,7 @@ static int ocfs2_dlm_debug_open(struct inode *inode, struct file *file)
 static const struct file_operations ocfs2_dlm_debug_fops = {
 	.open =		ocfs2_dlm_debug_open,
 	.release =	ocfs2_dlm_debug_release,
-	.read =		seq_read,
+	.read_iter =	seq_read_iter,
 	.llseek =	seq_lseek,
 };
 
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 1b508f543384..2f1ed95ac8fb 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -116,7 +116,7 @@ static const struct seq_operations help_debug_ops = {
 static const struct file_operations debug_help_fops = {
 	.owner		= THIS_MODULE,
 	.open           = orangefs_debug_help_open,
-	.read           = seq_read,
+	.read_iter      = seq_read_iter,
 	.release        = seq_release,
 	.llseek         = seq_lseek,
 };
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 34a47fb0c57f..756fc6accd26 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -815,7 +815,7 @@ static int children_seq_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_tid_children_operations = {
 	.open    = children_seq_open,
-	.read    = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
-- 
2.43.0


