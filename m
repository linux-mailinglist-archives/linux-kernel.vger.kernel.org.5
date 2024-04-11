Return-Path: <linux-kernel+bounces-140842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038648A192B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC611C214D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DA2132C3B;
	Thu, 11 Apr 2024 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r53+Po80"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6521327E8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849642; cv=none; b=gpid+Y5k6B6sDARF36KVeeK5TZ4rAcZc6w/cjZblkV5I6+RC7EDfflGwpldv309mY88ZDXRv08xanws6Glq/n04cE+YLG2WnesvSDWL4AmiDrXRZBfafcQL3yIwLByX6e4yUH6CfhqzUBmvrGhhODHta5FwkhFSMIUIbUC5X9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849642; c=relaxed/simple;
	bh=7sv9860TXH7IOdatpF5LRD+bbd/JtMyPBrPs8cfsoNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdY51wG/RGa1o6XEfRRRpHMa96YGPXuety7Mjn3wuuBpOlj8Lpyta6ZWalEmOwpfqWUYsu9LrLVPQvaTyUQ8u94D9lNRHYsc6w3gwFhupw0soC5+dspvZqpfWvrEC6v/YR3bmnCVqPfbMQK3mlzujBU0YIHYzb2nzyjhBANHy0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r53+Po80; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16131339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849639; x=1713454439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNMxscXeqQTEhlFBdcHasiHVnqmxq8lHL2PENTNUxmc=;
        b=r53+Po80cL3mUDkRbz1JSxAesj7jsoNBCahgXZ+Dg/6DIufh4s1crdYCJjyhYD4oDW
         bpmlT/F8SqhaNuybFubDUA1W4if2BdLPPwlknS2xw5+nLdN4jREoyFQ40s4w0nlRjNy5
         znE3no9MHoJIwwvvJmyLo0oxNXJk0gj9Q8G3Rsoe4JjIRGhLhC7cgV5AZxBkRp4kdEi4
         zPRrXCdWNnYpHjr0HAgiJUmdXo+CF8uehHEaoOjQuaxZIKq8tZCME6Ay8Qwt/ovH23/R
         YQ9URpfgwAodm++3+UoRAACM6H9dt4X7C/1jI3IeGH6ZjeWlull7yC4HqUabZbkFWkcS
         WtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849639; x=1713454439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNMxscXeqQTEhlFBdcHasiHVnqmxq8lHL2PENTNUxmc=;
        b=lVAUv24D1vfvWj58UyXNvH/8OHnY0snMIYuaGBLP9uNynO+388X1YLv3c91RzLs5JW
         ytUUuiyfNbDWssGuLwI+TVDVU58gwcq1+tMse7ivxCCfvgz0ypeJP4XbZeSy9tRpYEST
         iFMf0J1bcn6RbqNL2tohgkFdzTUfL4uGHWBLk6UpDL6Rb65Ndk1hqiSyNktu4pbGcbmn
         84ldN4lUVeFKh3KdwStmo+Vwuf59rfwa1ScJsMN7edAuldrUbUSA0oXRevX3QTgAjaaP
         YHwy4d4ELqG9I5os6Jm0HYR3VOsHMoLhOmj/boeDIiBeCL+bLlF+SADpJGtVZ8mMRxG2
         ZYzQ==
X-Gm-Message-State: AOJu0Yy0GLXy8KI/414rwP90Y9UU4R+iH/lFtb/B7OFXAKmczaL+pHV0
	qGsKvymEYaUuWXoFCc8NxuD+5PXl694aRthtPkal5AuxoCR5pUHA1amg5hPR5MUsjRgOk0ujA2+
	C
X-Google-Smtp-Source: AGHT+IH/bYpC5CvfGe5kVS6YqlavyxZW4EpB8OHIj2cH0URM+diHGzI5+V2/eT3s5P+JILweSe//2g==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr154917ioh.1.1712849639318;
        Thu, 11 Apr 2024 08:33:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 081/437] gcov: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:41 -0600
Message-ID: <20240411153126.16201-82-axboe@kernel.dk>
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
 kernel/gcov/fs.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 01520689b57c..02f966688ca3 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -379,14 +379,13 @@ static void remove_node(struct gcov_node *node);
  * corresponding file. If all associated object files have been unloaded,
  * remove the debug fs node as well.
  */
-static ssize_t gcov_seq_write(struct file *file, const char __user *addr,
-			      size_t len, loff_t *pos)
+static ssize_t gcov_seq_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct seq_file *seq;
 	struct gcov_info *info;
 	struct gcov_node *node;
 
-	seq = file->private_data;
+	seq = iocb->ki_filp->private_data;
 	info = gcov_iter_get_info(seq->private);
 	mutex_lock(&node_lock);
 	node = get_node_by_name(gcov_info_filename(info));
@@ -401,7 +400,7 @@ static ssize_t gcov_seq_write(struct file *file, const char __user *addr,
 	gcov_info_reset(info);
 	mutex_unlock(&node_lock);
 
-	return len;
+	return iov_iter_count(from);
 }
 
 /*
@@ -511,9 +510,9 @@ static void add_links(struct gcov_node *node, struct dentry *parent)
 static const struct file_operations gcov_data_fops = {
 	.open		= gcov_seq_open,
 	.release	= gcov_seq_release,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
-	.write		= gcov_seq_write,
+	.write_iter	= gcov_seq_write,
 };
 
 /* Basic initialization of a new node. */
@@ -632,8 +631,7 @@ static struct gcov_node *get_child_by_name(struct gcov_node *parent,
  * write() implementation for reset file. Reset all profiling data to zero
  * and remove nodes for which all associated object files are unloaded.
  */
-static ssize_t reset_write(struct file *file, const char __user *addr,
-			   size_t len, loff_t *pos)
+static ssize_t reset_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct gcov_node *node;
 
@@ -650,20 +648,19 @@ static ssize_t reset_write(struct file *file, const char __user *addr,
 	}
 	mutex_unlock(&node_lock);
 
-	return len;
+	return iov_iter_count(from);
 }
 
 /* read() implementation for reset file. Unused. */
-static ssize_t reset_read(struct file *file, char __user *addr, size_t len,
-			  loff_t *pos)
+static ssize_t reset_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	/* Allow read operation so that a recursive copy won't fail. */
 	return 0;
 }
 
 static const struct file_operations gcov_reset_fops = {
-	.write	= reset_write,
-	.read	= reset_read,
+	.write_iter	= reset_write,
+	.read_iter	= reset_read,
 	.llseek = noop_llseek,
 };
 
-- 
2.43.0


