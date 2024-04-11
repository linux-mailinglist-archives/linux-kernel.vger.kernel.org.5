Return-Path: <linux-kernel+bounces-141087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9ED8A1A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369882835AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107B41DCA3A;
	Thu, 11 Apr 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0kAX04MT"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6118C1DB555
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850019; cv=none; b=d42fTcdbVCo9eTXUqkA3b7+0ni5PJIxnUzGLBXK2Y5WS8yIVNdfRFZp+oxxC8DY3eEr4Q8KURgG3UdyBWUWKSlQRBleafmQBdFcSwn0WioppTC1Fqe0WmVhYWW+DsqNPCXUWsm7nuQG2dkht6tdrAkERihnMifp+3e9X2Y5Zi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850019; c=relaxed/simple;
	bh=vXyC4AANKAr6PlBsv/DI+7LfBdf8UqFXFRsfcGceumo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecWBJq0WErVN3bIf+ceh/8lQna9Odtxk1GNC/ReJeZP3q6N2mvUvKg44dMl9xUw/ls5KU4RBECskWSrbyrM1Y1iy2oi81xobCoDj/JiTXz569AGd0bm8zyDUZY5Sv/rrwOsZdfuozhZ7JXavQuZeOjZnlkLklH1diOt+V9zJtFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0kAX04MT; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36a34b68277so117835ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850016; x=1713454816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZR+y8WqPnE3aAKTVmYOX0W0a6fUUTCd7lWFhDGiZig=;
        b=0kAX04MTZ/+ob9qSdz0Gy6C7OiwOp3hG3EDa1Xs0JujzX7Gklpbc/4CFwIOsRp7gTa
         K4LmAa7MUAkHrMVXZNynqyslQqa8crcaHC7n4jzCB4TI2A0zwZhxBXD8S/chwi15YEnQ
         6otfeUdUswe/NkhPYAlztFvwjgLG46PKHZk9gUS/QLdbFmXCYAMZJ+S4G1jrwLvv4cGN
         tdBzj+4wfUnMkoDHGhZLAdOQfjFRIPyP992YUIHdoQ/iZbLpFJomhNaaf2u7M7TW3VE/
         SKsilNm8U7hs0ZbC/ycop43PXQETqgAL3Ho8HZvr4S51x5L9shS0jTNqW15AhOQ+Zm5l
         U6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850016; x=1713454816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZR+y8WqPnE3aAKTVmYOX0W0a6fUUTCd7lWFhDGiZig=;
        b=U08z4a/CVL1r5R4Vd5rQthhppbvf30YPRPx0DThhKC+OP80VAg95R6XfxZMNyQmr+0
         RM+wKFtGKR7x8rkUFjBx6yUnOWp0fmAitYuU3co7iGSrUAenASJosrbXkajSh9ms4eaN
         o6lmEU53Q73uJvfbHkgk9AB+injoW+XNrggQli1xtTVaQqIVCMZO8iufhYAxRus3S+Cg
         xbdYaRVs51CTVz+HXMdG0FXfcFGK6RCZojQHO4PcsxlqjhEUV+HJMTkywKU/P128zbtC
         NQPt3KhW3zybWH/kwnuiWyTS9dC4Si9mzWPeYwgNiwkm2c1PPc13ilwYOEXw3L+diJ07
         yt+Q==
X-Gm-Message-State: AOJu0YyCjc/3nlVbDJsyQrPN8K8q+UhhhY/unDyhkdK3tebYqjXTO9aL
	i81eS39EPIcVH83g1bTd9ZsFF4GLy+780Ghk+uWR4fdxQyXw+KHjB368dtdNkhxxmknKolbqh8c
	v
X-Google-Smtp-Source: AGHT+IFhGRBLjxgkcYVyOxDEMZLFhGzdqqzrpPiJxYI6eW6Zp7Uk+QDvoZOd9kbY/sIdH34K54K4QQ==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr197943iob.0.1712850016064;
        Thu, 11 Apr 2024 08:40:16 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 311/437] wifi: rsi: rsi_91x_debugfs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:31 -0600
Message-ID: <20240411153126.16201-312-axboe@kernel.dk>
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
 drivers/net/wireless/rsi/rsi_91x_debugfs.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_debugfs.c b/drivers/net/wireless/rsi/rsi_91x_debugfs.c
index c528e6ca2c8d..4a8e71ff7ba6 100644
--- a/drivers/net/wireless/rsi/rsi_91x_debugfs.c
+++ b/drivers/net/wireless/rsi/rsi_91x_debugfs.c
@@ -222,25 +222,21 @@ static int rsi_debug_read(struct inode *inode,
 /**
  * rsi_debug_zone_write() - This function writes into hal queues as per user
  *			    requirement.
- * @filp: Pointer to the file structure.
- * @buff: Pointer to the character buffer.
- * @len: Length of the data to be written into buffer.
- * @data: Pointer to the data.
+ * @iocb: Metadata for IO.
+ * @from: iov_iter to copy data from.
  *
  * Return: len: Number of bytes read.
  */
-static ssize_t rsi_debug_zone_write(struct file *filp,
-				    const char __user *buff,
-				    size_t len,
-				    loff_t *data)
+static ssize_t rsi_debug_zone_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	unsigned long dbg_zone;
 	int ret;
 
 	if (!len)
 		return 0;
 
-	ret = kstrtoul_from_user(buff, len, 16, &dbg_zone);
+	ret = kstrtoul_from_iter(from, len, 16, &dbg_zone);
 
 	if (ret)
 		return ret;
@@ -252,16 +248,16 @@ static ssize_t rsi_debug_zone_write(struct file *filp,
 #define FOPS(fopen) { \
 	.owner = THIS_MODULE, \
 	.open = (fopen), \
-	.read = seq_read, \
+	.read_iter = seq_read_iter, \
 	.llseek = seq_lseek, \
 }
 
 #define FOPS_RW(fopen, fwrite) { \
 	.owner = THIS_MODULE, \
 	.open = (fopen), \
-	.read = seq_read, \
+	.read_iter = seq_read_iter, \
 	.llseek = seq_lseek, \
-	.write = (fwrite), \
+	.write_iter = (fwrite), \
 }
 
 static const struct rsi_dbg_files dev_debugfs_files[] = {
-- 
2.43.0


