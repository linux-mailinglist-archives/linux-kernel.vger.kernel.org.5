Return-Path: <linux-kernel+bounces-141090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EECA8A1A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A33D1C22A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB001DDD27;
	Thu, 11 Apr 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QA3OhOYz"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED21DCA20
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850020; cv=none; b=JRBF7O7dQM+9zYMLzEshJzg4zj5e3NemgfOztlCjpNtknpC5+t/NMUbPIST+egRDUsBxdsZsu1Dv5Ecp7DwRX5K3PSx3hcPMAVFb39nkwwm7Q53O5UT+t4sYA9ye8EqIMpCGx7+oXzua0ZU8qApBESXVhCqUm5YSIgUithlZRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850020; c=relaxed/simple;
	bh=js9GE4LMX9Z2We0bcU81rJzAr5QwVHpMDDZ2Y0rzVX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVnasrETtRDLwVRtxRhZg6iZ+h2ArXxSNUXRIMQ9fBRcmg2avS48LygJVJEbxJMFFQAxq9N+fv05BqLWI//os2mecUxp3EpDtDsjA0lYSfvGUQnd9mG3GIK5383/oKN4UfWiOCGbvVOpZ+yk7FcjYCXSb1mF/iaNvBA0Q0vyqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QA3OhOYz; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170599239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850018; x=1713454818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/QYmI5ugy0XGE/tgifhxkcM3dLUJZaiJX3VosdM4eY=;
        b=QA3OhOYzc9gWYWYf/WdOaUKkm8HYHw0yZ4JiFar2uSHG/nkIkMT7D9HU2BtXRmL4oL
         sZEhtHS5o6V/rD9gVYfupDV78KWX4zhBbRMBLGuR7vwtt3xJCOFJSk6M9ZWaDdVUfBsI
         v9ezZzohGCMVVhkeLDxtSfUDJgP22QwZs53q/09WXVMPiy3xurVn8XxN9zSQjecCI2Ax
         McWwkdU11C23CuEDayxrSO27wkWxQ6WxFjitVwzRPJ6vhzl/oN0w50cX+n6HfdN9C3gR
         5kxkn9SzcNCEv8m9dsEx49evaqRlLSbbmwiH4mPG99smmXg51z+CmJunHqP7AAB55vPj
         CnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850018; x=1713454818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/QYmI5ugy0XGE/tgifhxkcM3dLUJZaiJX3VosdM4eY=;
        b=a7nmYUgp6AWrTLS6WOdXj9xQNYp/OPeOdIujSei/9s1jPM76ioLRnqZmtYiRLck60F
         Hbstx/8D2zX2fXThXXCW6X1IPNzq6c+4MJfyBBiJk3yA0bRSYhYS+ph+PmG/sB8sqrGo
         li7woqr0EkO1RWlBJEX+U3MtyP1ZD54Sv/Daj2NUFYMGCO1FnTqfFp5SUCKA9zqhAz0D
         73XS0p5gEyNj5YVcD6P7tw7dPMTj8l0uIIMivzkOpB6GJQCUepp1Q4dvdugpJ22g6bW2
         HESBL1gUaC4wxoT2iSfhYCgC4j6mcRgZEUs8yc2yd/VB0eNLndyPOXv4zVQDNdL/lXMm
         Wyow==
X-Gm-Message-State: AOJu0Yy63A0EcsNnLNSLtBw5WMNbq1EtIc/xlAxDUamRikBb15lJiyol
	0jp76fa8nhDQk4VHQTXcOEEjhfH3P1h2SeruusPq4mxc3WgJz3/8qZ/hh47WHJylELmlJs4TzWV
	p
X-Google-Smtp-Source: AGHT+IHlwhRWNDOoSAht86PQWeTOgXnXcNF3LMoHxueV6PMXS5IUh0mQ1ODNOW88upskCt2xPxc1BQ==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr232654ioh.0.1712850018012;
        Thu, 11 Apr 2024 08:40:18 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 312/437] drivers/net/wireless/silabs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:32 -0600
Message-ID: <20240411153126.16201-313-axboe@kernel.dk>
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
 drivers/net/wireless/silabs/wfx/debug.c | 34 ++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/debug.c b/drivers/net/wireless/silabs/wfx/debug.c
index e8265208f9a5..bd39be6a7f58 100644
--- a/drivers/net/wireless/silabs/wfx/debug.c
+++ b/drivers/net/wireless/silabs/wfx/debug.c
@@ -202,21 +202,21 @@ static int wfx_tx_power_loop_show(struct seq_file *seq, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(wfx_tx_power_loop);
 
-static ssize_t wfx_send_pds_write(struct file *file, const char __user *user_buf,
-				  size_t count, loff_t *ppos)
+static ssize_t wfx_send_pds_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wfx_dev *wdev = file->private_data;
+	struct wfx_dev *wdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char *buf;
 	int ret;
 
-	if (*ppos != 0) {
+	if (iocb->ki_pos != 0) {
 		dev_dbg(wdev->dev, "PDS data must be written in one transaction");
 		return -EBUSY;
 	}
-	buf = memdup_user(user_buf, count);
+	buf = iterdup(from, count);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
-	*ppos = *ppos + count;
+	iocb->ki_pos += count;
 	ret = wfx_send_pds(wdev, buf, count);
 	kfree(buf);
 	if (ret < 0)
@@ -226,7 +226,7 @@ static ssize_t wfx_send_pds_write(struct file *file, const char __user *user_buf
 
 static const struct file_operations wfx_send_pds_fops = {
 	.open = simple_open,
-	.write = wfx_send_pds_write,
+	.write_iter = wfx_send_pds_write,
 };
 
 struct dbgfs_hif_msg {
@@ -236,10 +236,10 @@ struct dbgfs_hif_msg {
 	int ret;
 };
 
-static ssize_t wfx_send_hif_msg_write(struct file *file, const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t wfx_send_hif_msg_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct dbgfs_hif_msg *context = file->private_data;
+	struct dbgfs_hif_msg *context = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wfx_dev *wdev = context->wdev;
 	struct wfx_hif_msg *request;
 
@@ -255,7 +255,7 @@ static ssize_t wfx_send_hif_msg_write(struct file *file, const char __user *user
 	 * memory pattern may help user.
 	 */
 	memset(context->reply, 0xFF, sizeof(context->reply));
-	request = memdup_user(user_buf, count);
+	request = iterdup(from, count);
 	if (IS_ERR(request))
 		return PTR_ERR(request);
 	if (le16_to_cpu(request->len) != count) {
@@ -269,10 +269,10 @@ static ssize_t wfx_send_hif_msg_write(struct file *file, const char __user *user
 	return count;
 }
 
-static ssize_t wfx_send_hif_msg_read(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t wfx_send_hif_msg_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct dbgfs_hif_msg *context = file->private_data;
+	struct dbgfs_hif_msg *context = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	int ret;
 
 	if (count > sizeof(context->reply))
@@ -283,7 +283,7 @@ static ssize_t wfx_send_hif_msg_read(struct file *file, char __user *user_buf,
 	if (context->ret < 0)
 		return context->ret;
 	/* Be careful, write() is waiting for a full message while read() only returns a payload */
-	if (copy_to_user(user_buf, context->reply, count))
+	if (!copy_to_iter_full(context->reply, count, to))
 		return -EFAULT;
 
 	return count;
@@ -312,8 +312,8 @@ static int wfx_send_hif_msg_release(struct inode *inode, struct file *file)
 static const struct file_operations wfx_send_hif_msg_fops = {
 	.open = wfx_send_hif_msg_open,
 	.release = wfx_send_hif_msg_release,
-	.write = wfx_send_hif_msg_write,
-	.read = wfx_send_hif_msg_read,
+	.write_iter = wfx_send_hif_msg_write,
+	.read_iter = wfx_send_hif_msg_read,
 };
 
 int wfx_debug_init(struct wfx_dev *wdev)
-- 
2.43.0


