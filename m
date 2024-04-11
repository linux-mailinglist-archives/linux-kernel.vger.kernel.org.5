Return-Path: <linux-kernel+bounces-141178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D01A8A1ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234C21F23414
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E891F82CE;
	Thu, 11 Apr 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="R6F/EN5N"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201AC1F7874
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850164; cv=none; b=cuM+jPC6p2NCoIsEPgbRjFSNjm74tgXg7lGHAdBFPIpcH01vAW2oiPqk9g4/kT3aK9YIL22S4zf/YznDJNy48go3+zZIYs7l6UergEqKthc2rHP4Rxk09Ed7NDdg7FD/pkGeMKzprafhY3j92n3+SrHZ1KRG58jcttfifoV0++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850164; c=relaxed/simple;
	bh=gAk05EH19UAZRUTc19SOoBN9Gb3h0YStlhtozE7ap2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MitAcivNkbQj5wjKbxqY0FQ6OjAzhMUWUV9wL611SsrgBH7FL8n9ZiGmZkJp/GAEyWV41Ssep8lAXGqTfcPkYnJqDAjbS7Yvg+OqUnNvMOMDHqmEnBFmsaVk82e8ey0mkM418uAmWW24V8BapCycYx1UekaGcNHDzxWe1A2LQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=R6F/EN5N; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58270239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850162; x=1713454962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWOu08smcrzd/mJ5G2zeBk679SixjLGMg/kkuPWqYhs=;
        b=R6F/EN5NLYc32NCpc2LcKUik/mFIo0OVlSeX5BbgA8JhZ8QIyNmddXvPXTJrhBDdDe
         lzpcvzU9Jz+zwB6wILKqp24DTBKIm8D3dVDwhz49qJ1bFhcIk8B788xwP5XCVQCmEG3s
         tfa7TJ7oQoNmmJzTe20iKDWyJ3su+f7hp9N8hA2ABkOvKUZ6nV4jKBnRKACZzmwWgawW
         6TQWWJae8HfxOCIt7LbTbhQJiA28SFsNZnTF3CDaGCZbN6DDF/58G3i2/QavOqulg2co
         MFUHqONl7lOTkRrqmUrdH07JO9/siSPJqBjgXuoC5S1P0Xizy2HqW97Ykvz+xUSJ/FLk
         kKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850162; x=1713454962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWOu08smcrzd/mJ5G2zeBk679SixjLGMg/kkuPWqYhs=;
        b=eq59p39IIEqIBVFc5W6CfbH3sNpjvk3px4/nLrPEFrc/kuYXD471z5GJMrXlkTi/iD
         0Vnq/pf/PH6KbTLO38o+jUfdKrxkC0sbIr1KLzEHNIOmmXvek2s+7y1nwcp+ACY9/hvb
         +q5L7OobAG6BuBLrlqtk7y/p0wnYVhBXxp/0wSYh3Rj4kaj2/Isra4e7pOjWAq4JFup2
         ddBLTxytGxOa0wEwiGifNOo5/bwj+IiQ2jz/8ORNmSXdSmI/nV3IfaigUhn9myfksiaM
         QZt1W7vIgeEEXDMh2DwDWLZ6/sfKQXrtxHQQwasQ9j7SOuqyT6aQ5isfmeRbY5BqCkWk
         6LCw==
X-Gm-Message-State: AOJu0YxP5Llz0jGR4mKC9mD/J1cNUr3JhS+hn8EAdZ95rz38K6wYiFrk
	liDeV+nRIQ3/0zTmCQ+eO8OcHMjXlnR5NDLni3Lm3BM3R4oldv9rW1KwIRhBYX7S/8658rRLQ2O
	g
X-Google-Smtp-Source: AGHT+IHTRSKtHBfiZphx13tJYfdKn73f270WntxG5CMhhspJu3UQV8YH+ezCv0l3lVnbmDlt3WU4dA==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr179491ioh.1.1712850162060;
        Thu, 11 Apr 2024 08:42:42 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 394/437] drivers/hsi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:54 -0600
Message-ID: <20240411153126.16201-395-axboe@kernel.dk>
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
 drivers/hsi/clients/hsi_char.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hsi/clients/hsi_char.c b/drivers/hsi/clients/hsi_char.c
index 71ce7dbfe31d..47ddfe14459b 100644
--- a/drivers/hsi/clients/hsi_char.c
+++ b/drivers/hsi/clients/hsi_char.c
@@ -409,10 +409,10 @@ static inline void hsc_tx_get(struct hsi_client *cl, struct hsc_tx_config *txc)
 	txc->arb_mode = cl->tx_cfg.arb_mode;
 }
 
-static ssize_t hsc_read(struct file *file, char __user *buf, size_t len,
-						loff_t *ppos __maybe_unused)
+static ssize_t hsc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hsc_channel *channel = file->private_data;
+	struct hsc_channel *channel = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	struct hsi_msg *msg;
 	ssize_t ret;
 
@@ -451,8 +451,8 @@ static ssize_t hsc_read(struct file *file, char __user *buf, size_t len,
 	msg = hsc_get_first_msg(channel, &channel->rx_msgs_queue);
 	if (msg) {
 		if (msg->status != HSI_STATUS_ERROR) {
-			ret = copy_to_user((void __user *)buf,
-			sg_virt(msg->sgt.sgl), hsc_msg_len_get(msg));
+			ret = !copy_to_iter_full(sg_virt(msg->sgt.sgl),
+						 hsc_msg_len_get(msg), to);
 			if (ret)
 				ret = -EFAULT;
 			else
@@ -468,10 +468,10 @@ static ssize_t hsc_read(struct file *file, char __user *buf, size_t len,
 	return ret;
 }
 
-static ssize_t hsc_write(struct file *file, const char __user *buf, size_t len,
-						loff_t *ppos __maybe_unused)
+static ssize_t hsc_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hsc_channel *channel = file->private_data;
+	struct hsc_channel *channel = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	struct hsi_msg *msg;
 	ssize_t ret;
 
@@ -488,7 +488,7 @@ static ssize_t hsc_write(struct file *file, const char __user *buf, size_t len,
 		clear_bit(HSC_CH_WRITE, &channel->flags);
 		return -ENOSPC;
 	}
-	if (copy_from_user(sg_virt(msg->sgt.sgl), (void __user *)buf, len)) {
+	if (!copy_from_iter_full(sg_virt(msg->sgt.sgl), len, from)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -655,8 +655,8 @@ static int hsc_release(struct inode *inode __maybe_unused, struct file *file)
 
 static const struct file_operations hsc_fops = {
 	.owner		= THIS_MODULE,
-	.read		= hsc_read,
-	.write		= hsc_write,
+	.read_iter	= hsc_read,
+	.write_iter	= hsc_write,
 	.unlocked_ioctl	= hsc_ioctl,
 	.open		= hsc_open,
 	.release	= hsc_release,
-- 
2.43.0


