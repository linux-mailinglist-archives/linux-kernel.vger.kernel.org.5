Return-Path: <linux-kernel+bounces-140955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E548F8A1A22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE24B2A8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5F1B5C49;
	Thu, 11 Apr 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M7Y/y4zV"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E93DAC18
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849814; cv=none; b=VTnfCJSzh2720rkgH8P9V7DBqM3tfEOaNRpBtj5UVEtL74kJYCqCuCU0waRGCuXbm9hTQSxuG2GZPOuBo8pSMRYDuwMSQVlrZP1vakxiuc6smZIhhaJd0XtMs30qe4UAUAEFH4ui5SBkGdy2lvQ9Bdw2Qhb+oUue1Zu78Mh/nX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849814; c=relaxed/simple;
	bh=rfz+O0uqNZr/oKCISs7Obwt+TIPvlNs8ZU0ahYZ9hMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlMs47EM+OTueE7p2+oaIbXe4Cx9yZgMbAKnyA0Ap8bWb6pNEXoAZTIJLW7PwXwvO8iRZJ6fQ2t5aTaUju3rYkqSxHxMjpwEAzfF6QlY4keH8IZcWbKwbEcX1Q3LgJIjq2MZFBF7S3MpIxZ0+lYzTDt8xyYv+7cc8UvMJ7XzL4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M7Y/y4zV; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8961439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849812; x=1713454612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+niwRwTilEtv6H6ChbZaxgzmpgAHxtENASmAVbkG/nU=;
        b=M7Y/y4zV+kFqUMAZDX7rQl9UqSHYpDB/tQgbl13CTi9BlWvZtd+V/8cyZZw9GCXjZq
         tJ5SasZbxtPcQHAdnZeVxhLzdkFjUIx/tBuHnl+PtYHwQQ0xKH7aSv6TPxIiMsAeR0Vx
         V7Lvos1wihhhYikJwn5Uy6S39vmO0P4EDDcPRIAPqaFOF+zAE0jLrczxHCz75hLJAF2I
         WgZYk0P7Jbk7SSs8Dx2krt8B5FwPKmG109oy6D5eF9/0P+YbuJMkRPMigTUrAuT6r3Bw
         cX/So8lWYwJkeVrG+VMYBu+ivTJWZz9jMWUR8kPxyx95lbtvkAV/l0SBBpWk1PIZ5dmJ
         /lWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849812; x=1713454612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+niwRwTilEtv6H6ChbZaxgzmpgAHxtENASmAVbkG/nU=;
        b=Js1Q7UKUsDmvDDxMVeunc/vatBXg3hpLkSXIq+cKsKMoRBv9dMc9ucDjfQMX8c+2N2
         pe9plSefBSjyulVAoSxiekFk4ryS9F+x5B72kt+n/Cbhra8eObuTkyrjikyQpQbnt1rS
         6SNjKk5P4FUeelGGkQMl0/DBJvyvV4hXf858EvYMQ6hoskj3ke9bC6MuzXe1wDeRe5zx
         jiqJCBj+PKB/GevmMR4Q7jBooGnhf8XYd3G/aHDzb/qydR0RBQpl3xWMy7cErHfImkRN
         5ofsOvm7qXxtob/4TzXgjjlN6ojnr1JDtb1IwaMJltgXSrOFmFADFcXmrgP0neXV8fB5
         r2YA==
X-Gm-Message-State: AOJu0YwqlRK7tYC2zzMmOMEtn1UpmJyP3MXd9mx+5NBl1132qikNAZSJ
	0A56/KgLCla1Fn1i7tWYtT7f8ABOIHFc9vU8xObWNvBZlCORDWL01lSNdBZvI5RI7vt+ycBbXTk
	0
X-Google-Smtp-Source: AGHT+IGMkeTtLoziutSAhwMvmaLe2zdxfslFrCy8hFB3sNO6kTGHkMF2NA+Gp4O9xoepp/n+n1dNyw==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr223683ioh.0.1712849812110;
        Thu, 11 Apr 2024 08:36:52 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 186/437] scsi: csiostor: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:26 -0600
Message-ID: <20240411153126.16201-187-axboe@kernel.dk>
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
 drivers/scsi/csiostor/csio_init.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
index d649b7a2a879..177d485975e1 100644
--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -59,13 +59,14 @@ static struct scsi_transport_template *csio_fcoe_transport_vport;
 /*
  * debugfs support
  */
-static ssize_t
-csio_mem_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+static ssize_t csio_mem_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	loff_t pos = *ppos;
+	loff_t pos = iocb->ki_pos;
+	struct file *file = iocb->ki_filp;
 	loff_t avail = file_inode(file)->i_size;
 	unsigned int mem = (uintptr_t)file->private_data & 3;
 	struct csio_hw *hw = file->private_data - mem;
+	size_t count = iov_iter_count(to);
 
 	if (pos < 0)
 		return -EINVAL;
@@ -90,22 +91,21 @@ csio_mem_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 		ofst = pos % sizeof(data);
 		len = min(count, sizeof(data) - ofst);
-		if (copy_to_user(buf, (u8 *)data + ofst, len))
+		if (!copy_to_iter_full((u8 *)data + ofst, len, to))
 			return -EFAULT;
 
-		buf += len;
 		pos += len;
 		count -= len;
 	}
-	count = pos - *ppos;
-	*ppos = pos;
+	count = pos - iocb->ki_pos;
+	iocb->ki_pos = pos;
 	return count;
 }
 
 static const struct file_operations csio_mem_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = simple_open,
-	.read    = csio_mem_read,
+	.read_iter = csio_mem_read,
 	.llseek  = default_llseek,
 };
 
-- 
2.43.0


