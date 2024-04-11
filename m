Return-Path: <linux-kernel+bounces-141067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC0E8A1A50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA5A1C22628
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0AE1D4293;
	Thu, 11 Apr 2024 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Azk91P5H"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545651D371B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849988; cv=none; b=msz9czNvJ/JEUwA2PTntlUTiX0bCMT34i9iZaFoYoU8KE4wvWxA4FskmKSMFhSMWmkZRF/OCelj4pgcg3DiLv71/3/E33JyIc2VqknEXLVK0dA+oxv5YiQ8baRr8WKqDkYKfSUCXgGi48y03ToXp6XAOehVbB2ImK8A1I02Gxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849988; c=relaxed/simple;
	bh=/Q6KnapLBPJz/Wdlpldx5vt5/82eFPTxGeq6XHjxjjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjkDXPdvSFcHz4atdFyb6s8jI1JBGMvrB7YQzcW3AjcKR+xKDKI7yAMj1DHp7PJ/ftAeFQOGntz9cA5IeHLXQS/8v89S/2WekC3E5fNIUY1zx4vZRVDz1XwkTDHq4CijMBQ+yRK9BtEMYNMahn0MJTrQUSwLrJf7Fvnq8l/qPD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Azk91P5H; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58172639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849985; x=1713454785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKK8dgn5uHLUesU0IBjCDwlOEErVfVZOLDyYwXoDWEY=;
        b=Azk91P5Hwdb/xJrc+7xAw/lBkPyqsgCBnanN9q8xUvQTP6UYSqgnM3D6x971drzrw2
         AYAiCzOVIVcYGbqGOGTpTutq29HyhINzpNP4ERzg84jXgG8xb+HGob8wiu0S2iuYQybW
         klF+pp9LcK29gJ7AeJDRsm1wc8aZgEzSrnFClVS6OsWlNbVRgz20LxuZd/YjezbfRDO2
         Gnmvs+BRFiEBvFLF0sIPYtDxJivFCXBLxsAqfwUByZQ6hP9MwY3XSWsrY9ZtIGFzwNiP
         JQ1Y2HuqLGXGlzWRjyxejds7OwyDhsz/7ah6+vcxh8OCWiAGd1uCmhMKKHfUFEYlxYG5
         NPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849985; x=1713454785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKK8dgn5uHLUesU0IBjCDwlOEErVfVZOLDyYwXoDWEY=;
        b=Fh25VXqX1GCsnq19AQSbai7R00gG9nEkWTZOaTIr44TOXzcde65BtJC9Q4YnIddeOu
         aQuPWweMp2zRkRNTs1PcOyhiIomjQL1dqrN1VBsCzLs6BKI5NjMm86oKfALq7qwNAhDj
         RNg31ihuB18b1BAvUd6YPG9N2tTdv3lKCTWnqqfnwKKri7grUUwUMGXzZmM5pzmvLpdg
         Z6nTy3eKEzIIbOjnO5eAmyI/3Rdy2IcojC7TnApA5pwxNBxbt0Zx9+8DbuCIBflW4pHa
         iqKgOKlvuuGLtvP0TCVDdf0A+SAc2w9CPnNlBPjLU8OSfHMXoJhTpFeR30tPesUxlFhd
         p7Bw==
X-Gm-Message-State: AOJu0YzYWPwc7g1XiJ6BV9Cd8hQdI25Q2jVB4bp2Sw2IzX959fk+/zJ0
	FfgYPRpAS1/mLhluFIkLj7mT0wkjnzAneJ8cKNPG2mu2hUInx+XySAZasNhUeZqAAA3yKxq5yg+
	Q
X-Google-Smtp-Source: AGHT+IHVh6JfR09vkvCedDaYlIm0CPu/ZIhxQhCOwTnDrDtWv8MFcPMxK2RLduyxZknP+Z/1G011fQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr196423iov.2.1712849984910;
        Thu, 11 Apr 2024 08:39:44 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 293/437] fs: convert fs_open to read/write iterators
Date: Thu, 11 Apr 2024 09:17:13 -0600
Message-ID: <20240411153126.16201-294-axboe@kernel.dk>
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
 fs/fsopen.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 6593ae518115..a68b7d4071b1 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -14,6 +14,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/namei.h>
 #include <linux/file.h>
+#include <linux/uio.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 #include "mount.h"
@@ -21,12 +22,12 @@
 /*
  * Allow the user to read back any error, warning or informational messages.
  */
-static ssize_t fscontext_read(struct file *file,
-			      char __user *_buf, size_t len, loff_t *pos)
+static ssize_t fscontext_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct fs_context *fc = file->private_data;
+	struct fs_context *fc = iocb->ki_filp->private_data;
 	struct fc_log *log = fc->log.log;
 	unsigned int logsize = ARRAY_SIZE(log->buffer);
+	size_t len = iov_iter_count(to);
 	ssize_t ret;
 	char *p;
 	bool need_free;
@@ -54,7 +55,7 @@ static ssize_t fscontext_read(struct file *file,
 	if (n > len)
 		goto err_free;
 	ret = -EFAULT;
-	if (copy_to_user(_buf, p, n) != 0)
+	if (!copy_to_iter_full(p, n, to) != 0)
 		goto err_free;
 	ret = n;
 
@@ -76,7 +77,7 @@ static int fscontext_release(struct inode *inode, struct file *file)
 }
 
 const struct file_operations fscontext_fops = {
-	.read		= fscontext_read,
+	.read_iter	= fscontext_read,
 	.release	= fscontext_release,
 	.llseek		= no_llseek,
 };
-- 
2.43.0


