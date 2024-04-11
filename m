Return-Path: <linux-kernel+bounces-141059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042BF8A1A44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3611283BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9591D215C;
	Thu, 11 Apr 2024 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hEmy5Eoa"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DED1D06B7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849974; cv=none; b=jC9VR76PuVRR/hZH7+YYC1cWchZfTxFazPYTeLVhfSRGWlOE8EJpDJHLYgLy0qUkOeXLlfqslzCnUF6iXsQlMuftwpH7Xxydo08EdLBeEdlUnot+ON3WKyVtvLJYHt7RUnlIwxcq7b/uvNG64K4VfdnUkOWnNwyf5+OqIfa51vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849974; c=relaxed/simple;
	bh=sKPRHeETElflsb6nSEP14O/1aFOyRze+VoqZ/IV2QSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLJ9D3WNhAl+mmsaz43wZxKMOrqAH/zFW84rBG32J0wvJZcStfdghhFJaSGECfojBNfavmmQv8egxg/LzCwBuqip41FiSrAyB3hHhU72/7hMZDehH41ibF4osUfQLrrQVozAy1Pne7H0GKEZELRUquoEt8BGRj6a8bVEIc/jOSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hEmy5Eoa; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16212839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849971; x=1713454771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pjd3b1JXXFVuK6R3VsMghe7Mtr0cnNAn12vvOo0KLY=;
        b=hEmy5EoaPOISReBPOt++EXM1j1sWG112FYYRi57MIkbsN72BHafDHv0yc1joJWPILA
         +lEdt9Fh+09KYorlubdiIiaVu4cZxXq2fUfmq7C5/KUSLIQoUBC6Mhg6KN8vish/ZdGf
         MQM3SRgE6QxK/oXzUKfE1S75HqBr3xqS1RR6EDD6crgy5lfMzd+tDWIzT7asiLMkXnLM
         FbgsIwZIvzF0w/L4DVZZeuGE9gSyOPP2/nT8/7ADWKcePPA0YsnfZSh15qOeZ1jU5aWC
         3DDyBDriOaLT1XbcYgxTpXzyVWIwzHh16V922u4f2kr52/fZzMrDAuH0AjZSbxoLDFER
         vMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849971; x=1713454771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pjd3b1JXXFVuK6R3VsMghe7Mtr0cnNAn12vvOo0KLY=;
        b=JqxmmYM8+KtTgMx8Qy0r6A7a8LU7UykYtMdPV8E6lfgMNJwDjKFX+MHa5RGnjFHtxH
         iPUHqDVl4poJorlqSY3UYh9WLGLO6K7LlDDIUTt6rcnwJ7dyIqX2lYAtSrtEXrGx/HLU
         umKaomBEXcLjrv2HplJGjc0joris4c5S87kpHFBerTyEPJ9sKVKDtpsN9VyQtgqf7JL7
         9Yoo7pLHc9rKUqo3YH4ttX6/wkoHCjC2+4XO6FZOBTkvfmts50qGeOKaImtd8NiNmp8k
         iVEv+MGhYGpXQxHN/sTtPyxx5b/u7NLpPuF+YjlDpOzz41CsnXmhT/KcfTfYzAR5nSiz
         vN8w==
X-Gm-Message-State: AOJu0YzXCxoCa4uXM5UjjtYZZLEO4n4JKdONAPAz24LYUN/3XiE0IGRS
	OCZo3kSEwwEd10RMlpzwgS5TsYqh11ncjjRZAmdDJqOAvU3Ory5AQBHhryok9GfYJnMVqw8Tii8
	S
X-Google-Smtp-Source: AGHT+IEPPNqk26FmdivXxob7LijqHEfjQTrgSAleyaKOFR57EK5kRAD+PqOXxVXJxGlY9CG/ZYAz9g==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr195682iov.2.1712849970400;
        Thu, 11 Apr 2024 08:39:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 284/437] fs/coda: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:04 -0600
Message-ID: <20240411153126.16201-285-axboe@kernel.dk>
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
 fs/coda/psdev.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 3c3148588491..1c7f1c5c4941 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -196,16 +196,17 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 out:
         return(count ? count : retval);  
 }
+FOPS_WRITE_ITER_HELPER(coda_psdev_write);
 
 /*
  *	Read a message from the kernel to Venus
  */
 
-static ssize_t coda_psdev_read(struct file * file, char __user * buf, 
-			       size_t nbytes, loff_t *off)
+static ssize_t coda_psdev_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	DECLARE_WAITQUEUE(wait, current);
-        struct venus_comm *vcp = (struct venus_comm *) file->private_data;
+	struct venus_comm *vcp = iocb->ki_filp->private_data;
+	size_t nbytes = iov_iter_count(to);
         struct upc_req *req;
 	ssize_t retval = 0, count = 0;
 
@@ -218,7 +219,7 @@ static ssize_t coda_psdev_read(struct file * file, char __user * buf,
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (list_empty(&vcp->vc_pending)) {
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			break;
 		}
@@ -248,9 +249,9 @@ static ssize_t coda_psdev_read(struct file * file, char __user * buf,
 		count = nbytes;
         }
 
-	if (copy_to_user(buf, req->uc_data, count))
+	if (!copy_to_iter_full(req->uc_data, count, to))
 	        retval = -EFAULT;
-        
+
 	/* If request was not a signal, enqueue and don't free */
 	if (!(req->uc_flags & CODA_REQ_ASYNC)) {
 		req->uc_flags |= CODA_REQ_READ;
@@ -344,8 +345,8 @@ static int coda_psdev_release(struct inode * inode, struct file * file)
 
 static const struct file_operations coda_psdev_fops = {
 	.owner		= THIS_MODULE,
-	.read		= coda_psdev_read,
-	.write		= coda_psdev_write,
+	.read_iter	= coda_psdev_read,
+	.write_iter	= coda_psdev_write_iter,
 	.poll		= coda_psdev_poll,
 	.unlocked_ioctl	= coda_psdev_ioctl,
 	.open		= coda_psdev_open,
-- 
2.43.0


