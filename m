Return-Path: <linux-kernel+bounces-140770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E4A8A18DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C481F24EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC7142077;
	Thu, 11 Apr 2024 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1/FyNbSU"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076F40870
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849513; cv=none; b=XD3jMTw0kegJ+QEUnBvCxToU5S8mi5gLyooWJUKKYz8CKWiw+XqcEpsiDFK6PGwZdo+PK8FqTFa8/HQ0YfFwQ5hQG9lcVjmOEKd3CAx038XwYIcYOvBpLVUGrEn9/Y6iyS9qnaziL9fYSgvHUJ345BfV9JRKgwvM/0U/wED+plA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849513; c=relaxed/simple;
	bh=0BbIai3xcoBMm6AX7CtizvK5uk1tBG0zn92zXX7H6gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucTJhqWcLaBD9Xk/RpmszMQICC8bnoFgr/DIUVqcy6+dwHhm/hItDEhxxMtkP2vCpGF5mhcJ54/p1eerI+V35p6ws/dqtRaQ7y+wz6gDQ6s9rn2VBznDaLvCimrbeSgIQSi6ljxerl9gYs2o0BELOWY1jLWAccIvpKF1/wd1H2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1/FyNbSU; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180585739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849511; x=1713454311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAtR2mhDsnYSMCpP/HQol96/PSpuexfwRhsrrIksyFM=;
        b=1/FyNbSU69Js0zJxJDdHEkvI5pscHO56XsenNR1leP7dwkyBBxefvSYSLT/CnjdZif
         WEvssdHOTWTyLfSeGrAoI+HwuYvX+dbB9Q4Dfc5nRWX3Ofx6u8U4e5syEmoSe+8UYjGP
         UVp9pAWbTgHbj4/8oYcRsxrVJFtnAA+OWH5c7u1DBj0JNmOMoV8nXHU9RcBXEtfI2CNr
         Csu1GfnVnMAQKVKUxmjJDKqEjdgOsE7tSkfM0cunqJnnkAw/lWMZqqYh8BVhYrpZAH6N
         MQmMt0sIOYJbmFrK9IoTe3Fk4FYT6Znyu3aFY6V1y/mG0N4DqqCLu4d2htL0R8zDGfjY
         IdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849511; x=1713454311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAtR2mhDsnYSMCpP/HQol96/PSpuexfwRhsrrIksyFM=;
        b=c2bGOiATMmNNcXJYb4vSjsJcLGKy6DXVGMwbTQJ3Q/4UhZZMpLs7BH1rgiKfGU46Ee
         SFczJcS9Wnl9IpHQsUW6vATMzrJi/FEVAoghhX8TuzVwiMu/MgBU7OXvWDq6pTK34OnK
         z2MeYH8+32WV6YwJRpRPhUluniNevX8hR1mK0i4ZKGbnoOw8Wbv771sqeB0J354JH0RC
         +qoTe6PS7XRbJdDlm5k2+pRic18vCm4aXz7y2XWH/uom4fxfW2FOq0jOekhNi7SwXT9L
         1RG5Ec+pv+OdsPap6oUGqx5X/BUK1at747XQihn1lt9/VE+giKnng3CWTpTkv2K4Cs05
         EVaA==
X-Gm-Message-State: AOJu0Yy78FBo1uTXB5bAXQg4gzTWiZ4nBIYIWBIOOSJPQ8nq2tzStB8F
	gDGXR1LtR3aw0iTU4tOegW4HFqrIROvh17loz9dP+yQAeiK5dlrpri+XOAoPBXwssHYLcWbNV97
	o
X-Google-Smtp-Source: AGHT+IGGM2PRznFIekb0G+/kIHXXmeEVV/8kDzhczLXSVgKJuYLtjxASpFSx1O4nd6jHSL9nCB2tSg==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr171892iob.1.1712849511189;
        Thu, 11 Apr 2024 08:31:51 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 013/437] char/apm-emulation: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:33 -0600
Message-ID: <20240411153126.16201-14-axboe@kernel.dk>
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
 drivers/char/apm-emulation.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/char/apm-emulation.c b/drivers/char/apm-emulation.c
index e795390b070f..6b0ea84cf9c6 100644
--- a/drivers/char/apm-emulation.c
+++ b/drivers/char/apm-emulation.c
@@ -31,6 +31,7 @@
 #include <linux/completion.h>
 #include <linux/kthread.h>
 #include <linux/delay.h>
+#include <linux/uio.h>
 
 /*
  * One option can be changed at boot time as follows:
@@ -200,9 +201,11 @@ static void queue_event(apm_event_t event)
 	wake_up_interruptible(&apm_waitqueue);
 }
 
-static ssize_t apm_read(struct file *fp, char __user *buf, size_t count, loff_t *ppos)
+static ssize_t apm_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *fp = iocb->ki_filp;
 	struct apm_user *as = fp->private_data;
+	size_t count = iov_iter_count(to);
 	apm_event_t event;
 	int i = count, ret = 0;
 
@@ -218,7 +221,7 @@ static ssize_t apm_read(struct file *fp, char __user *buf, size_t count, loff_t
 		event = queue_get_event(&as->queue);
 
 		ret = -EFAULT;
-		if (copy_to_user(buf, &event, sizeof(event)))
+		if (!copy_to_iter_full(&event, sizeof(event), to))
 			break;
 
 		mutex_lock(&state_lock);
@@ -227,7 +230,6 @@ static ssize_t apm_read(struct file *fp, char __user *buf, size_t count, loff_t
 			as->suspend_state = SUSPEND_READ;
 		mutex_unlock(&state_lock);
 
-		buf += sizeof(event);
 		i -= sizeof(event);
 	}
 
@@ -379,7 +381,7 @@ static int apm_open(struct inode * inode, struct file * filp)
 
 static const struct file_operations apm_bios_fops = {
 	.owner		= THIS_MODULE,
-	.read		= apm_read,
+	.read_iter	= apm_read,
 	.poll		= apm_poll,
 	.unlocked_ioctl	= apm_ioctl,
 	.open		= apm_open,
-- 
2.43.0


