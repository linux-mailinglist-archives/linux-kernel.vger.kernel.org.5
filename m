Return-Path: <linux-kernel+bounces-140790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392D78A18FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667981C23371
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF8754BF4;
	Thu, 11 Apr 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WrRJHoLY"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394654278
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849544; cv=none; b=jSujd+nCUpuXeZost9153QNlP/86Po1dhbqfYs/8B1SqzV47W5D3tgfUaY+GCr/C91mo8upU3/3prEpkPYPTlrPgNKaJM/zCNHZHx4EeNcAlBOWW1lzSzXNyixsjLs/89F28GF3mUtksvupxTkM6CeZ/Jd7Hshfge7QafiCwKPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849544; c=relaxed/simple;
	bh=DtoSEQNpZigPG1vfntCcaCf+OOyN6d35woKyzdu3Rek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVF5RLOlbGt6NToX9lNeoGMUd6N49QiAcRlbzJzpDqxmCt9ATCqXa9EDqw0DGlzVUoJdxAhxtLOhHAslIf62A5+O0lD0r6086/mtUfafp0zxjNNIMM0/cDxS4x3Vudf+9pVs441BaKLR7k5pgQV5BkzAYirapuwifsJgZvEHRPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WrRJHoLY; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170424339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849542; x=1713454342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/jxhaBpmUPDYm1wddLIk2VLeQX+FQT3khhDsAYeAXk=;
        b=WrRJHoLYV+I6lmtWcIwp4AVckvZX7ER6Zk1kJyV7fsbqzlh+jN+AX/VASATUdoy5rx
         /dYfILVEbuHzMd6a/6Oir2MAjbPap+/AINjjK2976w7RFj4IULhpMx4G/vJB2YLbQwsh
         vEDAxpQzMRT+C70v0CJNjsyYNCBDgux14IM4rM0iXRzJ5lcTlgzK4V5AZon9Zg2k+yWe
         9cDVmAm1q9hVdIIp0hVFT62rg4Hm9WhwDrkrjOFZP1ZdQEPJE8pLb9Wy+mRhVrtnC1rA
         hIhW6vDMQxrvt0D/ThXfXq4iIGceOwPgP/21WtaONHySvMGMjFmIVJdgrWebP2+mgn4S
         8Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849542; x=1713454342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/jxhaBpmUPDYm1wddLIk2VLeQX+FQT3khhDsAYeAXk=;
        b=TJuUoNZ+zzeZXMYFo7yxlF0DF3DFQQ3JtjxgF2GnCtWOiyb/hBI6IHZ3FgbXlpXiDG
         /NsOCLZfNco7UaaexEU/mCxgoi+4DC6R4+XBGumnC+W4qwl9jtgXryjGLlwI1DM9aoxI
         nEwVaWbiQ9tTxhrr2Ml7dSNTkfzuNTkT8bg6Ud9T4LWgtYfe4OrMKockox9PaCy/s5VR
         xD8tamZf7rujA8SyzStGJf2KHI1F03lmRU3mBvdBPuU+sKKm0yYdtzq22gYuRHJkHBSh
         HEaz8PYGacG4y51nbTyG7VESDTwoI6cDQLUhFps3LBRjIAnNa6K1LZhr088EMbhbve0U
         xlqQ==
X-Gm-Message-State: AOJu0Yy1CiLUdo9nZ4JjwwPd2vSulZiQC9R7pag49rEAILqgfpyNbQeS
	7BN3uWSnbNt7OFZrmfsTL41ZqEGuIijqdl4IvQC6b38YEamFeZ2petfgGbDIdYfwI1M1v8bX/H1
	N
X-Google-Smtp-Source: AGHT+IHtEOYA4Dn6NKuMCN/vP+uNdnJGnrgCzUhv9lkIMImtX9twLWrkkd5QRX1W279004qBEOz2rg==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr3783ioc.1.1712849542427;
        Thu, 11 Apr 2024 08:32:22 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 032/437] char/ps3flash: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:52 -0600
Message-ID: <20240411153126.16201-33-axboe@kernel.dk>
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
 drivers/char/ps3flash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
index 23871cde41fb..0d8c29116891 100644
--- a/drivers/char/ps3flash.c
+++ b/drivers/char/ps3flash.c
@@ -239,12 +239,14 @@ static ssize_t ps3flash_user_read(struct file *file, char __user *buf,
 {
 	return ps3flash_read(buf, NULL, count, pos);
 }
+FOPS_READ_ITER_HELPER(ps3flash_user_read);
 
 static ssize_t ps3flash_user_write(struct file *file, const char __user *buf,
 				   size_t count, loff_t *pos)
 {
 	return ps3flash_write(buf, NULL, count, pos);
 }
+FOPS_WRITE_ITER_HELPER(ps3flash_user_write);
 
 static ssize_t ps3flash_kernel_read(void *buf, size_t count, loff_t pos)
 {
@@ -310,8 +312,8 @@ static irqreturn_t ps3flash_interrupt(int irq, void *data)
 static const struct file_operations ps3flash_fops = {
 	.owner	= THIS_MODULE,
 	.llseek	= ps3flash_llseek,
-	.read	= ps3flash_user_read,
-	.write	= ps3flash_user_write,
+	.read_iter	= ps3flash_user_read_iter,
+	.write_iter	= ps3flash_user_write_iter,
 	.flush	= ps3flash_flush,
 	.fsync	= ps3flash_fsync,
 };
-- 
2.43.0


