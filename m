Return-Path: <linux-kernel+bounces-141124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B636C8A1A99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEDF1F222EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A91E9C34;
	Thu, 11 Apr 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GQtGMwFN"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCA1E9C06
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850075; cv=none; b=KmWR2oeVaw+AnSLUSyk3MH5xKr52lz0ICjLQgEzIifRBWy7Cq4hvrz+Tfbdkf5GtbGJcTVgfQ6ZJUhvR3M+nv1fsZ+5Zh/xksKa8dcfTglg/Whm1MAe/6JpChi0sh+JJp3CE9ckA02EsGNe1LLWN/3Kh5GZN2HInkLwiRo9nx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850075; c=relaxed/simple;
	bh=1Xm1LvJZKXM9ByANh2Jrf1IcSwqEwwhCyyblOz47k50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WU+ouoJNPfWRbz2TmhyxS2naCvP7i/QfPjA3PuJko1GNxGOojm/gTtUFeJiWdmB1VguUN+Xu+IuABpFrgL60MqtkE3b986r6+J4I++h8OZvRb61inUHiAvlMLOm5uwU5BkM8pBewjAzzITppR1jPXJYN0SmGk7SWdsAXE8oBRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GQtGMwFN; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9904139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850073; x=1713454873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qptWCWsiaBboNfaOYpRLtNVackXnhTKqn/zsehAZOC4=;
        b=GQtGMwFN8kg/e+b0h9vtoLMvnP+IzH6YHjbzPmEz5CcxmcIPtJtzL16rXlTaWvl+I+
         toPyT1DxPqYNBD7nTnRlwvbZDRkdUBm0u43gpZtAfuiu8VXBFdq9vaRUkPuzPXiFZycm
         XRJhyegCjrvtFTQhMY5w99gNbwd4np/30I5m+j6G/MXu/UqNEBMdtrWqkBooGvCJhyuC
         uqBOXP95GtHr9eTp+/GCIP8fRIhbkXK1whHB3T8qPuOb3p6iO+fgauc7zBkf4R0mx+KQ
         2y+TADNVImQoifsW6u8nbAH2zdspoy2YiJfBmolZcEW4j9LLGUJQcSGbwsr9Mh0bNA9e
         +0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850073; x=1713454873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qptWCWsiaBboNfaOYpRLtNVackXnhTKqn/zsehAZOC4=;
        b=ki+ykPcikZue6mL2onVGbPAav4aGTw4/0pRkjzv7Dz0dXZfHYRzJ9INb38O7jueXXW
         YJa/rmSEJCcTejp3pSXSeZHQ3GlPNXly7a6/wAraz+f2u0A4fXVjrFSvyyoDw68L9Kvy
         a0dwMeKUHmEXSQFbMDM6qKjNLi2fA768QobKKMC8vcj8crN6o3+ATwtXZLk+d00dy8U0
         LVYBlf44cgeg+BKA8e1ltOyBGqGyNXpFMO7T334taRgyMZOaxlw9W6I0gLNzgbNLDVsN
         IkdYGIoATeFIFHo0AzyONcbSXkuCQvU/N0fpJqYTsfNsmTLXuvHPc1iYg9xhwqx4pa2f
         OJ1g==
X-Gm-Message-State: AOJu0YzU+lTNCW+KoRfNn5L0OrWPmhDaRzefAaO0+SEMAThDYUcQp+UR
	vuVjZxNmCNwgr14sCQrMDDW+rt7ioIJI4t73XWiQNZt23fTlOOJxAK4buZ1Ow1+NgukCKGFjfQ8
	I
X-Google-Smtp-Source: AGHT+IF0tA+SadCsHrXiOM8Cn9xB9/0/ei86nQiSMwGL22g0n4hUr2fR8PAPWnp8pyZqvUu/TxtkgA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr206160iop.1.1712850072879;
        Thu, 11 Apr 2024 08:41:12 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 345/437] s390: vmcp: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:05 -0600
Message-ID: <20240411153126.16201-346-axboe@kernel.dk>
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
 drivers/s390/char/vmcp.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index eb0520a9d4af..348e528a386d 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -128,14 +128,13 @@ static int vmcp_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t
-vmcp_read(struct file *file, char __user *buff, size_t count, loff_t *ppos)
+static ssize_t vmcp_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret;
 	size_t size;
 	struct vmcp_session *session;
 
-	session = file->private_data;
+	session = iocb->ki_filp->private_data;
 	if (mutex_lock_interruptible(&session->mutex))
 		return -ERESTARTSYS;
 	if (!session->response) {
@@ -143,27 +142,25 @@ vmcp_read(struct file *file, char __user *buff, size_t count, loff_t *ppos)
 		return 0;
 	}
 	size = min_t(size_t, session->resp_size, session->bufsize);
-	ret = simple_read_from_buffer(buff, count, ppos,
-					session->response, size);
+	ret = simple_copy_to_iter(session->response, &iocb->ki_pos, size, to);
 
 	mutex_unlock(&session->mutex);
 
 	return ret;
 }
 
-static ssize_t
-vmcp_write(struct file *file, const char __user *buff, size_t count,
-	   loff_t *ppos)
+static ssize_t vmcp_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char *cmd;
 	struct vmcp_session *session;
+	size_t count = iov_iter_count(from);
 
 	if (count > 240)
 		return -EINVAL;
-	cmd = memdup_user_nul(buff, count);
+	cmd = iterdup_nul(from, count);
 	if (IS_ERR(cmd))
 		return PTR_ERR(cmd);
-	session = file->private_data;
+	session = iocb->ki_filp->private_data;
 	if (mutex_lock_interruptible(&session->mutex)) {
 		kfree(cmd);
 		return -ERESTARTSYS;
@@ -180,7 +177,7 @@ vmcp_write(struct file *file, const char __user *buff, size_t count,
 				   &session->resp_code);
 	mutex_unlock(&session->mutex);
 	kfree(cmd);
-	*ppos = 0;		/* reset the file pointer after a command */
+	iocb->ki_pos = 0;	/* reset the file pointer after a command */
 	return count;
 }
 
@@ -238,8 +235,8 @@ static const struct file_operations vmcp_fops = {
 	.owner		= THIS_MODULE,
 	.open		= vmcp_open,
 	.release	= vmcp_release,
-	.read		= vmcp_read,
-	.write		= vmcp_write,
+	.read_iter	= vmcp_read,
+	.write_iter	= vmcp_write,
 	.unlocked_ioctl	= vmcp_ioctl,
 	.compat_ioctl	= vmcp_ioctl,
 	.llseek		= no_llseek,
-- 
2.43.0


