Return-Path: <linux-kernel+bounces-140858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4598A19C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06615B25642
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AD3139587;
	Thu, 11 Apr 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="S+2bq05v"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75B1384BF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849666; cv=none; b=iTGB6TpmnhYVc3PKgbtavFp8ZKYEHIVzcJ9mEWer2qV5ZV8zQsWGSlDqeQEWv6915DD9ZWpQDhmo9AIvvDkxMh2aMZzUJUT3bmFC4wCDynzsWE++1CsfTlGvz3S92oM2GGqTAZtUFnTqKpUN6qJZu2x23mDtsSWqHQUuEzOanxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849666; c=relaxed/simple;
	bh=qZD/suo6whNiyLcz2/VcBWbVNxWYNc7kW/mQlWm/D0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJ3NcKfdwWWOHPOfwjtwE9j2AnM1kAfQjMY0Hi3zu4UKT6+YcttOEjGpMwsOspxUl7bJX6tTKgMVidZmy2nrjWzJwaG3paYDPgRzi9w6etuS7BISHaKDDElXWXOgQrDZQ6Clr7RvYtQ9EHZ3lvoxuQYCYWxQfcwGozcjLsJBX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=S+2bq05v; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69532439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849664; x=1713454464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iuxr/s+RAL0PuMx52mu+zKInvpaDex7OnP1UZUJEUhw=;
        b=S+2bq05vWe4nwGFF+WzaWJMXH8fA606KRBMs2sAVMJXPO8oKkW+Se7X6LYK1DNwiQn
         y7TvTxKQ5kx4zrFu8vTimKYcLVmhe1s5xzlwLYOLzrMu6l1efT32ZsmFzQNCu4SeoM3l
         hsk4IrLbah0MS4Xu7kChHjENDr2jDvPlddOW+3szQz/P3YCMVD4gYI7BAKkyCRsEvMio
         p0ctnWJvRobOJN1MUVcRWqEfyZvj5wiaSZpxvoB41ynu2tn1HmOzlodr4BLG79HhBTxT
         VdlGIIdEVGTRBDpdyzLigApsRGheMQdvOkFbd/HXeYMXwMgUANmLc/FEt2O7KvyCvM1f
         wqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849664; x=1713454464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iuxr/s+RAL0PuMx52mu+zKInvpaDex7OnP1UZUJEUhw=;
        b=miEfyTHe6l9XIPOnXj3dDIInxAWwhVcJzxwOFWbWzf0T8VyBuYTA1rVbYKaC6Skp/2
         VnOltSJQbpE28rCM3w2ra8HZTi215EXwA/bno1LtOuJEilJKNMqUIb0Xadv3TvZMdKS4
         Z3Hm8QAeKBOcsz9i53AEyxebgJ2IU+D5F6HWD+MVWLJBn8jPvIBgOUp+BSRuAGR157LC
         e8qBAyzR7lneNYmqpg16JIfFGLuaXSuDOnwoutIBlIW+CF/RzB0+DLm1LSgBJfXJy2cp
         F1K+NJ9uDTOlA0tLBnszuQKoDLa4aqsqSNg38y4U4u0yfUpAUlUdw89uDZ0jnigApqqz
         hy8Q==
X-Gm-Message-State: AOJu0Yx/PJHSRpvYukHE8ThuceB7aw6ofZQQAIGos6eJLQ/2LfiXHeS8
	jaAYhYVBUsxQhdSYWKJjbCepMjxb3vtCVNFIjPV/oF4Edu9HWUSvFtG5T3+90jbhHLbVuwt3hz/
	/
X-Google-Smtp-Source: AGHT+IGgvkbHzpgnZWLaC9R4ZLoxrKSrHIKAk/vbIRZ61sdLwwFLuvPpxr3xncTuFMdeTN2WOFAsVQ==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr189506iop.1.1712849664036;
        Thu, 11 Apr 2024 08:34:24 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 095/437] security: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:55 -0600
Message-ID: <20240411153126.16201-96-axboe@kernel.dk>
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
 security/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 9e7cde913667..81a7b43a0009 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -315,15 +315,14 @@ EXPORT_SYMBOL_GPL(securityfs_remove);
 
 #ifdef CONFIG_SECURITY
 static struct dentry *lsm_dentry;
-static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
-			loff_t *ppos)
+static ssize_t lsm_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(buf, count, ppos, lsm_names,
-		strlen(lsm_names));
+	return simple_copy_to_iter(lsm_names, &iocb->ki_pos, strlen(lsm_names),
+					to);
 }
 
 static const struct file_operations lsm_ops = {
-	.read = lsm_read,
+	.read_iter = lsm_read,
 	.llseek = generic_file_llseek,
 };
 #endif
-- 
2.43.0


