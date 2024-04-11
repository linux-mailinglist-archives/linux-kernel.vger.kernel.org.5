Return-Path: <linux-kernel+bounces-140962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D028A19D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3232E1C20F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871CB1B833E;
	Thu, 11 Apr 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k+nqbdj9"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932301B680D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849824; cv=none; b=lRzu1pM9hqcA/Soe9gvXDlh1rdo204uRylTp6FNcU8aY5NbpaWu51vTjwys+t9lYNo/inU9gSU+znM12I8MVgOEYWhWbQpDW+62WE15e8ksOyMR1oTc4R+gvDlmcZWih7juShKJdoFTQ9Xp3zy3gdP2tGRHQ37M60PIBvAS+LSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849824; c=relaxed/simple;
	bh=jWAAAIesOv7fWYH4bNsosL567ts5DOP4/ybaTZSCz4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfAYTmpbSwb6g/J4GVqVHtF37ZL5p7OaiYD1uO3EZAYxYirmwhyauYQGl7551TDEtlztq4YrwFC3iKLBfjomgdmKrIKSdYI7Z+GS+2Us2KFHa5OlCyHgxRg1NelVSYmHhqYCw1jllNg1iuXwB9E6bQch/nkyT9Q+OnlmwQFzcns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k+nqbdj9; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a29832cbdso497025ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849822; x=1713454622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN4C6p8p9L0bxTfswHkbtVwJ+3SBoqwHZjH9HEg+x1c=;
        b=k+nqbdj95PkT5Lk+gxrsJWMexqIEErGB5vkc/u6R3wzLxDQ5LIWI54QW4cVXZSIiAq
         9gHx0b1F/SQgPW9ZuSbitozvZBg4BMp6KwqYTCoyRjlE5rMMYOVx1z86ZLheUdS3NDCa
         i93sdH4cFHMKVhBglgvdd/OV5jK5iRJnQhyAk3zSdOS7U17n1jxkruIz+5YRrmcz+BR/
         nXH/bFuPOwpElghYacgJipS4AmAkn8aRa4+l1mhKq42rqggA3eVy78/jwTQgAeti50V2
         mumODD9n7bPM325rL/JSUB87FVgeEo4L/evRFog9DBJh5D1RrIgPHE9NJGEgozgBw6sU
         i72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849822; x=1713454622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dN4C6p8p9L0bxTfswHkbtVwJ+3SBoqwHZjH9HEg+x1c=;
        b=Hh6fbg8OtSOnPADD0c+rbR4tha6E2lw7xvQjfdqH43igdvOAu1Exg2UGgNKRD7rtoB
         GUnQacC91Dc3UX6j6CbJVpq6UwnzElnxgP4NzBCpCPqbJn9MiEr/yAD/50iqN+zrlQYA
         +uFEjWo7XWN5aQqEyHbSrNK4/c+OODpN/q2DGkNbCQl6b6pEuL0K2idXzH3baVicukKr
         uWYvd0IeCQKKZVvHxqev3Gpg5c9sQik/72Aa71d+cz/XaokzWJbUyi8zWs2OVa88wZcL
         c+VX/TOl80Lg8HxB4qW040OsFy4Huv3W91AEAHq320mcU9g7OeIcm0XIG0yYRCi6/acv
         wAeQ==
X-Gm-Message-State: AOJu0YwvuQVvDZd6qUWbt01mE9qSLe+9w3bECeDVmpUw9uvex4lG8NlR
	OrBGafK3e2gA7SUx2p0QVAOoH3qtD13m/OXVvKKMIIWtykjBLUYb+8gsozxbuWEehhsnwKycrKt
	0
X-Google-Smtp-Source: AGHT+IHBhSjSh7EQAU7KxjO9blQvY+IMYebvXJ7cMRBRdOnB7TuxW71SAejtMqETsz9lR9f5jX41og==
X-Received: by 2002:a92:d352:0:b0:36a:1275:4aeb with SMTP id a18-20020a92d352000000b0036a12754aebmr5884543ilh.1.1712849822391;
        Thu, 11 Apr 2024 08:37:02 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 193/437] scsi: qedi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:33 -0600
Message-ID: <20240411153126.16201-194-axboe@kernel.dk>
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
 drivers/scsi/qedi/qedi_dbg.h     |  6 +++---
 drivers/scsi/qedi/qedi_debugfs.c | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_dbg.h b/drivers/scsi/qedi/qedi_dbg.h
index fdda12ef13b0..2b05de656aa8 100644
--- a/drivers/scsi/qedi/qedi_dbg.h
+++ b/drivers/scsi/qedi/qedi_dbg.h
@@ -114,8 +114,8 @@ struct qedi_debugfs_ops {
 { \
 	.owner  = THIS_MODULE, \
 	.open   = simple_open, \
-	.read   = drv##_dbg_##ops##_cmd_read, \
-	.write  = drv##_dbg_##ops##_cmd_write \
+	.read_iter   = drv##_dbg_##ops##_cmd_read, \
+	.write_iter  = drv##_dbg_##ops##_cmd_write \
 }
 
 /* Used for debugfs sequential files */
@@ -123,7 +123,7 @@ struct qedi_debugfs_ops {
 { \
 	.owner = THIS_MODULE, \
 	.open = drv##_dbg_##ops##_open, \
-	.read = seq_read, \
+	.read_iter = seq_read_iter, \
 	.llseek = seq_lseek, \
 	.release = single_release, \
 }
diff --git a/drivers/scsi/qedi/qedi_debugfs.c b/drivers/scsi/qedi/qedi_debugfs.c
index 8deb2001dc2f..28fbbea694d5 100644
--- a/drivers/scsi/qedi/qedi_debugfs.c
+++ b/drivers/scsi/qedi/qedi_debugfs.c
@@ -91,8 +91,8 @@ const struct qedi_debugfs_ops qedi_debugfs_ops[] = {
 };
 
 static ssize_t
-qedi_dbg_do_not_recover_cmd_write(struct file *filp, const char __user *buffer,
-				  size_t count, loff_t *ppos)
+__qedi_dbg_do_not_recover_cmd_write(struct file *filp, const char __user *buffer,
+				    size_t count, loff_t *ppos)
 {
 	size_t cnt = 0;
 	struct qedi_dbg_ctx *qedi_dbg =
@@ -117,8 +117,14 @@ qedi_dbg_do_not_recover_cmd_write(struct file *filp, const char __user *buffer,
 }
 
 static ssize_t
-qedi_dbg_do_not_recover_cmd_read(struct file *filp, char __user *buffer,
-				 size_t count, loff_t *ppos)
+qedi_dbg_do_not_recover_cmd_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, __qedi_dbg_do_not_recover_cmd_write);
+}
+
+static ssize_t
+__qedi_dbg_do_not_recover_cmd_read(struct file *filp, char __user *buffer,
+				   size_t count, loff_t *ppos)
 {
 	size_t cnt = 0;
 
@@ -131,6 +137,12 @@ qedi_dbg_do_not_recover_cmd_read(struct file *filp, char __user *buffer,
 	return cnt;
 }
 
+static ssize_t
+qedi_dbg_do_not_recover_cmd_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	return vfs_read_iter(iocb, to, __qedi_dbg_do_not_recover_cmd_read);
+}
+
 static int
 qedi_gbl_ctx_show(struct seq_file *s, void *unused)
 {
-- 
2.43.0


