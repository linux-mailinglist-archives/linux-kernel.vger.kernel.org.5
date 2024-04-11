Return-Path: <linux-kernel+bounces-140884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B9F8A195E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2AE1F21D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83231591F4;
	Thu, 11 Apr 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p+HFY0S5"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953C154453
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849706; cv=none; b=D/O4+MNaXl2au0gbhMRFAiJ+QHHbHbYC9HZHOAUo/3Mq8yPXkZlL/AXbKKv1uI6Fn+Q0+BDIi1djGxYHuqDHCO1tCnpLmL+BbxHzgLMgJAOuDEcKVTeAn9ARbk4gg03LD5C+JC32GrgiGmFzOV2h5UxCzIn1+PYJ0mLb4y6fBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849706; c=relaxed/simple;
	bh=ddwVRkDdBQfcI/LkHmF8rG2qaDBU/hVGb7KrSazxweQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsNtDKTjtddw/DXA4fivMkeaU8sTr2f1j9Umksbd51lXN5DDPPqJUXjx9OLtj8MEb/VdMRWg5HSRPA3JC8zVQ83XRXywoC4ji+l92zuwDAeUN8Y4RJCQKhp+u8TJfyB7zP6LoBdfII5iZ0jxSk/Qi6M+/KSAVqDN/GRwjs+a8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=p+HFY0S5; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a224d7414so180475ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849703; x=1713454503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEHw82QDIJyA4wXzTfT9/81diBLxPZNeaQxLfo+fveU=;
        b=p+HFY0S5eQZvzeuu3wSV8JMA26IksMyfJxuAEsAO0uyObKuhWOdCBLRZeZ9inoUpy5
         V9EHNnfxUocWNpMxKv4lfpdjts/BXwqfK8b1URHKpznX2W3HGClhW2fzTr8iAhcSejaB
         X/zIcXNZzGiFjB1ziub4mCf/gDXkhxNLNYVMmzS4kzLmluzS8/jn8k/eNr014Bt2660Q
         5j6GEQheOL5rWbZJ/70a4IoraKbsB1VO9qFIV67gHZtckAjNk51LEtd/yItkmCpjMAo+
         40Gq3eYbLQqvRYuULQRwDqb13mS95AyA+G6yNq6f10mWiZUretPK1qnZUjHJq/gZh1+5
         uoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849703; x=1713454503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEHw82QDIJyA4wXzTfT9/81diBLxPZNeaQxLfo+fveU=;
        b=AFYbO7UvjneQbZVEilXICVuIYAtynYPbx4lNiKfhidCeSdYT2TID84iweLWOSv7t6L
         CT8OuAqxJ62EJPJofIweGUR0c3t0MimR2woninsyO6RxVs+/EdK4fEl6T1GnnqaFTyMD
         KhXDdo4kXfjlZQPM6AmFaSQXYQF4PpKjwyHa7r0FrIogyue6m1aeWa0NAmKs59v4MzbA
         fhL8+clKxasrleCtj/s6mkRBzMrflpKUXiK8P0bcI33DsQvOa2J4mv4zKIHhryBr5Kai
         QEoEkk6nLtFVBnFdVC+paub7XXOtziVVWqwrOqv5bM4UKGQnLEAPK/ZICXLRrmWE7oIS
         6xBg==
X-Gm-Message-State: AOJu0YzXvRmwoPO2Gk2gVz9nUId84YHr2k8CnfQyPf2oCjsporqxvNSz
	H2XlNIikUMk47I3XjpVqbNQphi92tmdwoKoghqRMKZ54gcnFUz8bObnJg7XmqhmuFcGxn4k7xd7
	k
X-Google-Smtp-Source: AGHT+IFLQP4hLOClhAmCJwMEEzWB7lWTG8tEYxoTtSg1mqUOVnbaO5vWQ5AGA/L6JRbnNOomFufuZA==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr185679iob.0.1712849703577;
        Thu, 11 Apr 2024 08:35:03 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 120/437] fs/eventfd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:20 -0600
Message-ID: <20240411153126.16201-121-axboe@kernel.dk>
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
 fs/eventfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 9afdb722fa92..6995253a37f3 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -244,16 +244,16 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	return sizeof(ucnt);
 }
 
-static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t count,
-			     loff_t *ppos)
+static ssize_t eventfd_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct eventfd_ctx *ctx = file->private_data;
+	struct eventfd_ctx *ctx = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t res;
 	__u64 ucnt;
 
 	if (count != sizeof(ucnt))
 		return -EINVAL;
-	if (copy_from_user(&ucnt, buf, sizeof(ucnt)))
+	if (!copy_from_iter_full(&ucnt, sizeof(ucnt), from))
 		return -EFAULT;
 	if (ucnt == ULLONG_MAX)
 		return -EINVAL;
@@ -261,7 +261,7 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	res = -EAGAIN;
 	if (ULLONG_MAX - ctx->count > ucnt)
 		res = sizeof(ucnt);
-	else if (!(file->f_flags & O_NONBLOCK)) {
+	else if (!(iocb->ki_filp->f_flags & O_NONBLOCK)) {
 		res = wait_event_interruptible_locked_irq(ctx->wqh,
 				ULLONG_MAX - ctx->count > ucnt);
 		if (!res)
@@ -306,7 +306,7 @@ static const struct file_operations eventfd_fops = {
 	.release	= eventfd_release,
 	.poll		= eventfd_poll,
 	.read_iter	= eventfd_read,
-	.write		= eventfd_write,
+	.write_iter	= eventfd_write,
 	.llseek		= noop_llseek,
 };
 
-- 
2.43.0


