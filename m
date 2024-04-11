Return-Path: <linux-kernel+bounces-140888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4D8A1964
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D912A288282
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A75C15AAB0;
	Thu, 11 Apr 2024 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="07PPhPxG"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983815A492
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849713; cv=none; b=JRCXqdc/nqBY9ACb7ipVbp/VM57U+Uuc87HBvUbQzfQX0ZBYh0IPEzWm4uy/MwE8ynoe01AqP/8lTIiH8ykDnodxpJyEkzC56aR58KhhM7kqYlIy0eyOVtq3gwai7NSjYMzfjYuE4fkzloage1PO0G139kHgDCh96KqJuoZDItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849713; c=relaxed/simple;
	bh=vu1XF/AtPBcXnoX1unYcCGFAhoB1kL5REzq/ANwBo2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2np1R88ZXGG3zmMh+IJ4FN8LcJSXDPkS1oIuFunRtP4yior3zXU7JLjKgqWw5hiZFTagQTHMS7ROqDBkmXPr/bwZzjHOvNiu9t+cbXB0r9gBOy3a0akxjcnzRZvIq/Gm3Bjvuj+1o/fENi2nemZiimPsE+HXBaZWWn/bmopxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=07PPhPxG; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9771139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849710; x=1713454510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T2b1mgDom2zUdQYb9qf0HYWqW2qIVM34qu/et0XRtU=;
        b=07PPhPxGizeK2zkPYdocGyhjkFPP8d9VicWIBigY+6YP8DZKMsF9zn92kGL33fdrK4
         oLC7DrkbiMyyYT1LUUKB2Vab3UbXPGs9Igha4rZbxxWfj2s6gR4PmzWFpe8Vs/pffZWM
         au38rqd8mjgG6y5ejbnwYBK747lioKZSSgglGt+QXxYbUHjrScCK+3LlLYjotlsmPQgj
         6LhzEWrF5QwNU8efr6Q3wA9iVNM4mrra/tFbLRbuLEHAnC7ijBkMWTn9KB97RiZ2qZ1I
         C2iTh7XC6Zuk4ykQ1VODvonIgieQLa5NajIReK9OoAM551OqQx1nKHTMr82TZ314bjlV
         yppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849710; x=1713454510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8T2b1mgDom2zUdQYb9qf0HYWqW2qIVM34qu/et0XRtU=;
        b=MVndcrk4MjgQxvv1Jj+nLg08fUcsVQicbjAsQKbhOCCP4d+Q74sPeLwitEE0sG1mxK
         fLniYKJZZafGSF9o0hyZLSqH8TwacTgPy5j2C8gj6BwvZ6+GmWapCbNV+D5IRchY2V5B
         J7xSkpvWICwzzV7DjMcPoc3cKXHKZW/CzfddTT392xR/kEJ61YXrGboh9enT4xMquxcf
         iagME4eKNysCISrYzdu8A0P3zi+1MBUgs+h2joVYYBPCToN+RnZwzJfckT3mH4ADSk/c
         /frTngluHJEEMxCwwg7bEEIIbyC7ufD/EjGK2+Ooq4eCUOa3cKpTmuXVIhYRR66GPQA6
         Xr+g==
X-Gm-Message-State: AOJu0YxjOdS3vCBAeFX3QdKaHpTTDRuWeOocJp+71CLs878TC3uTUsOx
	lgKnRX2QxVn8vDOiWoHYoCGP2xVnesR16KpO9WuLVFr7QP3ejXz9CZfZvuTimW+6oYILmvPxxuc
	7
X-Google-Smtp-Source: AGHT+IG2f8hCOg/fJWazEyfeU9rd3SxfsDUIwa6QoIW6CEPz34ihYErd7wSRtkqcYD/Vtmk3dXkW/g==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr214083iof.0.1712849710433;
        Thu, 11 Apr 2024 08:35:10 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 124/437] firmware: arm_scmi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:24 -0600
Message-ID: <20240411153126.16201-125-axboe@kernel.dk>
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
 drivers/firmware/arm_scmi/raw_mode.c | 94 ++++++++++++----------------
 1 file changed, 40 insertions(+), 54 deletions(-)

diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 350573518503..95915540165a 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -765,46 +765,41 @@ static int scmi_raw_message_receive(struct scmi_raw_mode_info *raw,
 
 /* SCMI Raw debugfs helpers */
 
-static ssize_t scmi_dbg_raw_mode_common_read(struct file *filp,
-					     char __user *buf,
-					     size_t count, loff_t *ppos,
+static ssize_t scmi_dbg_raw_mode_common_read(struct kiocb *iocb,
+					     struct iov_iter *to,
 					     unsigned int idx)
 {
-	ssize_t cnt;
-	struct scmi_dbg_raw_data *rd = filp->private_data;
+	struct scmi_dbg_raw_data *rd = iocb->ki_filp->private_data;
 
 	if (!rd->rx_size) {
 		int ret;
 
 		ret = scmi_raw_message_receive(rd->raw, rd->rx.buf, rd->rx.len,
 					       &rd->rx_size, idx, rd->chan_id,
-					       filp->f_flags & O_NONBLOCK);
+					       iocb->ki_filp->f_flags & O_NONBLOCK);
 		if (ret) {
 			rd->rx_size = 0;
 			return ret;
 		}
 
 		/* Reset any previous filepos change, including writes */
-		*ppos = 0;
-	} else if (*ppos == rd->rx_size) {
+		iocb->ki_pos = 0;
+	} else if (iocb->ki_pos == rd->rx_size) {
 		/* Return EOF once all the message has been read-out */
 		rd->rx_size = 0;
 		return 0;
 	}
 
-	cnt = simple_read_from_buffer(buf, count, ppos,
-				      rd->rx.buf, rd->rx_size);
-
-	return cnt;
+	return simple_copy_to_iter(rd->rx.buf, &iocb->ki_pos, rd->rx_size, to);
 }
 
-static ssize_t scmi_dbg_raw_mode_common_write(struct file *filp,
-					      const char __user *buf,
-					      size_t count, loff_t *ppos,
+static ssize_t scmi_dbg_raw_mode_common_write(struct kiocb *iocb,
+					      struct iov_iter *from,
 					      bool async)
 {
 	int ret;
-	struct scmi_dbg_raw_data *rd = filp->private_data;
+	struct scmi_dbg_raw_data *rd = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
 	if (count > rd->tx.len - rd->tx_size)
 		return -ENOSPC;
@@ -820,8 +815,8 @@ static ssize_t scmi_dbg_raw_mode_common_write(struct file *filp,
 	if (rd->tx_size < rd->tx_req_size) {
 		ssize_t cnt;
 
-		cnt = simple_write_to_buffer(rd->tx.buf, rd->tx.len, ppos,
-					     buf, count);
+		cnt = simple_copy_from_iter(rd->tx.buf, &iocb->ki_pos,
+					     rd->tx.len, from);
 		if (cnt < 0)
 			return cnt;
 
@@ -835,7 +830,7 @@ static ssize_t scmi_dbg_raw_mode_common_write(struct file *filp,
 
 	/* Reset ppos for next message ... */
 	rd->tx_size = 0;
-	*ppos = 0;
+	iocb->ki_pos = 0;
 
 	return ret ?: count;
 }
@@ -863,19 +858,16 @@ static __poll_t scmi_test_dbg_raw_common_poll(struct file *filp,
 	return mask;
 }
 
-static ssize_t scmi_dbg_raw_mode_message_read(struct file *filp,
-					      char __user *buf,
-					      size_t count, loff_t *ppos)
+static ssize_t scmi_dbg_raw_mode_message_read(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	return scmi_dbg_raw_mode_common_read(filp, buf, count, ppos,
-					     SCMI_RAW_REPLY_QUEUE);
+	return scmi_dbg_raw_mode_common_read(iocb, to, SCMI_RAW_REPLY_QUEUE);
 }
 
-static ssize_t scmi_dbg_raw_mode_message_write(struct file *filp,
-					       const char __user *buf,
-					       size_t count, loff_t *ppos)
+static ssize_t scmi_dbg_raw_mode_message_write(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	return scmi_dbg_raw_mode_common_write(filp, buf, count, ppos, false);
+	return scmi_dbg_raw_mode_common_write(iocb, from, false);
 }
 
 static __poll_t scmi_dbg_raw_mode_message_poll(struct file *filp,
@@ -935,55 +927,51 @@ static int scmi_dbg_raw_mode_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t scmi_dbg_raw_mode_reset_write(struct file *filp,
-					     const char __user *buf,
-					     size_t count, loff_t *ppos)
+static ssize_t scmi_dbg_raw_mode_reset_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct scmi_dbg_raw_data *rd = filp->private_data;
+	struct scmi_dbg_raw_data *rd = iocb->ki_filp->private_data;
 
 	scmi_xfer_raw_reset(rd->raw);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations scmi_dbg_raw_mode_reset_fops = {
 	.open = scmi_dbg_raw_mode_open,
 	.release = scmi_dbg_raw_mode_release,
-	.write = scmi_dbg_raw_mode_reset_write,
+	.write_iter = scmi_dbg_raw_mode_reset_write,
 	.owner = THIS_MODULE,
 };
 
 static const struct file_operations scmi_dbg_raw_mode_message_fops = {
 	.open = scmi_dbg_raw_mode_open,
 	.release = scmi_dbg_raw_mode_release,
-	.read = scmi_dbg_raw_mode_message_read,
-	.write = scmi_dbg_raw_mode_message_write,
+	.read_iter = scmi_dbg_raw_mode_message_read,
+	.write_iter = scmi_dbg_raw_mode_message_write,
 	.poll = scmi_dbg_raw_mode_message_poll,
 	.owner = THIS_MODULE,
 };
 
-static ssize_t scmi_dbg_raw_mode_message_async_write(struct file *filp,
-						     const char __user *buf,
-						     size_t count, loff_t *ppos)
+static ssize_t scmi_dbg_raw_mode_message_async_write(struct kiocb *iocb,
+						     struct iov_iter *from)
 {
-	return scmi_dbg_raw_mode_common_write(filp, buf, count, ppos, true);
+	return scmi_dbg_raw_mode_common_write(iocb, from, true);
 }
 
 static const struct file_operations scmi_dbg_raw_mode_message_async_fops = {
 	.open = scmi_dbg_raw_mode_open,
 	.release = scmi_dbg_raw_mode_release,
-	.read = scmi_dbg_raw_mode_message_read,
-	.write = scmi_dbg_raw_mode_message_async_write,
+	.read_iter = scmi_dbg_raw_mode_message_read,
+	.write_iter = scmi_dbg_raw_mode_message_async_write,
 	.poll = scmi_dbg_raw_mode_message_poll,
 	.owner = THIS_MODULE,
 };
 
-static ssize_t scmi_test_dbg_raw_mode_notif_read(struct file *filp,
-						 char __user *buf,
-						 size_t count, loff_t *ppos)
+static ssize_t scmi_test_dbg_raw_mode_notif_read(struct kiocb *iocb,
+						 struct iov_iter *to)
 {
-	return scmi_dbg_raw_mode_common_read(filp, buf, count, ppos,
-					     SCMI_RAW_NOTIF_QUEUE);
+	return scmi_dbg_raw_mode_common_read(iocb, to, SCMI_RAW_NOTIF_QUEUE);
 }
 
 static __poll_t
@@ -996,17 +984,15 @@ scmi_test_dbg_raw_mode_notif_poll(struct file *filp,
 static const struct file_operations scmi_dbg_raw_mode_notification_fops = {
 	.open = scmi_dbg_raw_mode_open,
 	.release = scmi_dbg_raw_mode_release,
-	.read = scmi_test_dbg_raw_mode_notif_read,
+	.read_iter = scmi_test_dbg_raw_mode_notif_read,
 	.poll = scmi_test_dbg_raw_mode_notif_poll,
 	.owner = THIS_MODULE,
 };
 
-static ssize_t scmi_test_dbg_raw_mode_errors_read(struct file *filp,
-						  char __user *buf,
-						  size_t count, loff_t *ppos)
+static ssize_t scmi_test_dbg_raw_mode_errors_read(struct kiocb *iocb,
+						  struct iov_iter *to)
 {
-	return scmi_dbg_raw_mode_common_read(filp, buf, count, ppos,
-					     SCMI_RAW_ERRS_QUEUE);
+	return scmi_dbg_raw_mode_common_read(iocb, to, SCMI_RAW_ERRS_QUEUE);
 }
 
 static __poll_t
@@ -1019,7 +1005,7 @@ scmi_test_dbg_raw_mode_errors_poll(struct file *filp,
 static const struct file_operations scmi_dbg_raw_mode_errors_fops = {
 	.open = scmi_dbg_raw_mode_open,
 	.release = scmi_dbg_raw_mode_release,
-	.read = scmi_test_dbg_raw_mode_errors_read,
+	.read_iter = scmi_test_dbg_raw_mode_errors_read,
 	.poll = scmi_test_dbg_raw_mode_errors_poll,
 	.owner = THIS_MODULE,
 };
-- 
2.43.0


