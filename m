Return-Path: <linux-kernel+bounces-140968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71528A19DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB02288240
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D171BAA7F;
	Thu, 11 Apr 2024 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nGgqGcFl"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E31B9DB5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849835; cv=none; b=Ni+eaVfbotM5oVxif7GQIJXROBArNDw5ug7gTsgEWyZJjxiCm/RAlSwI62lQSdWHDCYeWQgp9E+0n0cNaJBXBaT/w4sMzzIkZd2cKeMgXdRr3n3WTSG5C/adx5nzAvSbBcs3vEl2Z61pQ4iTLptaYVsR193xUDB3auBnlbKNNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849835; c=relaxed/simple;
	bh=LSCemXyH/56SX1zJGrPgI2h0vvaWN2kJRtNTOLW9cqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJO1pqQ0YdaN6bA3f6uW3sdZqqoQtZyq1GtuAWmIpxnRyuuHr8PhQN++TjTJNCk0BexWtj4ZTMoABYb0s2BWES5w7sXnmo6NEVU9Umw7APErAjwWqr4zfd4CsNFWUwp62rY3LpaSWxuZCzlt7g8uUuUVK32/B5/97cdCTdxBA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nGgqGcFl; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8969539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849833; x=1713454633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5oledHPLkideaj9uMygX8qyloig1YMiFxHvmZuz7h8=;
        b=nGgqGcFlWnPo9v0jyQ7tekIh1qbhu8ee1j8kM4vJzYNZrMPwBwa0O2vigjcu2Of9d7
         rMjTzwfIj/JMo6Y56AC4nIUB9JFBn+LofHpmXfs8uC8TYfh8GpzPkPZXyEC0XVuVwByp
         km5uLohs4wonZ9Jw5HCh1o3LK5lkWqDLdURD4GyJGdjk+3I16s65R4FkSy09/UbhCKUy
         K6xHxYktgK27R6yLWEFvYuSbajpC370SLs0j3UBEfmUAs2Lv1Uztx3BzD7DKSa+goJat
         HLdeBSCu/Idz9U54LdegxgTNuunce/aMAJ1FruvsftxxwY46wbk6/xF7SjjYAtyOBvX4
         qymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849833; x=1713454633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5oledHPLkideaj9uMygX8qyloig1YMiFxHvmZuz7h8=;
        b=fShFN/KJNlReVOpjOP6l/LPquVoGKcBpGsJov9s0Nq15frDppZmgo7xDyaQwkC4rVf
         fNCjoOi0absv02MoQEir8ZgSrYgsNa18LosIgdYRd+2azHI3FQF+rl7YYzUrcjuNnSuv
         CKnxCZof/szxqBiu/D/IIo74+VIYFLkbZ9kO+hCafiwhO7ejfscVScHl/fj3pCfIw86I
         iVMo+3Xa6SAvz9iFQmWnGEEr5aShvJ1paVdgx6h1EUBEEZduyBZgm3FRrUSLATfA03to
         gi09Ey5JBQpzi3xGvOTS7hHR9Sq6QYv/asBrVOByB27LxB3ZhuM58UGOA7KyUND3+J3E
         E8Gw==
X-Gm-Message-State: AOJu0YxKUe7NUeuYwZM5/g5SdMGmHkv4zPSSwtupGFfZ68RqIWkC5ZNW
	kCTMasPFTA6hYBwDc6XpMEr1nkLRck3Qe1NEksKyQ9vsvy9XJILOt3q//cva0xmZhDxzvb711Gb
	F
X-Google-Smtp-Source: AGHT+IE9eIzvCX4LFfiaC6+USmpTRCiOAJl9udwOwJhsNeXUdKr7qLcTfv34xuDNpRzdBKyGt1+jyg==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr19055ioc.1.1712849833025;
        Thu, 11 Apr 2024 08:37:13 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 199/437] scsi: st: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:39 -0600
Message-ID: <20240411153126.16201-200-axboe@kernel.dk>
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
 drivers/scsi/st.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 5a9bcf8e0792..e96eb3607a82 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -1891,7 +1891,8 @@ st_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 
 	return retval;
 }
-
+FOPS_WRITE_ITER_HELPER(st_write);
+
 /* Read data from the tape. Returns zero in the normal case, one if the
    eof status has changed, and the negative error code in case of a
    fatal error. Otherwise updates the buffer and the eof state.
@@ -2238,8 +2239,7 @@ st_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 
 	return retval;
 }
-
-
+FOPS_READ_ITER_HELPER(st_read);
 
 DEB(
 /* Set the driver options */
@@ -4146,8 +4146,8 @@ __setup("st=", st_setup);
 static const struct file_operations st_fops =
 {
 	.owner =	THIS_MODULE,
-	.read =		st_read,
-	.write =	st_write,
+	.read_iter =	st_read_iter,
+	.write_iter =	st_write_iter,
 	.unlocked_ioctl = st_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = st_compat_ioctl,
-- 
2.43.0


