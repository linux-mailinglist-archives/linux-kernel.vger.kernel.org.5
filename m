Return-Path: <linux-kernel+bounces-141046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EF98A1A36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7F21F21516
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1471CEC12;
	Thu, 11 Apr 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lFUG+lNB"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB8154852
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849955; cv=none; b=jrNSxUXDtfWRrbNGbJ96INWnNNyezcqPqXf6Wr3VGtOatnQzdii0uuSFc5V1ZwSV8Z61TwkugHYumz3DBVTHiFxx1NTfDKCAuNP5cXCmI64Z5J8BeTJyWU/FXJuVHH70KXd2sGx1AZvIDSf1YElscRBDt5hcR93bhYAaAQ2ABy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849955; c=relaxed/simple;
	bh=/wkwY1Z44nmGszAk6jmCpjniCVU8/egqz5fntl8fqhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTcD4JvGlfoQ2J1lBVWutBUaUh1+fCzi9BiLksi0bg1EegSE0QqvjsBdm4ddLenBqcFhXzJlfR5u6o1iULzxJ0l7pzgr1WyXny3MfRwTbeBmeMlRxsoJkcOEnLBWcdcz293aM4vENMVtJpqAkYEwt+KE99f+Wg7VyEuo502wm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lFUG+lNB; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36a224d7414so188915ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849952; x=1713454752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=566s8Y6cLJziK/Nzw7hAPOYHoC3UrD4uE/BWUdAvK+8=;
        b=lFUG+lNBXW38KhuzC+vI6/hPIUnjJLnDwpvHDkECCJi4EmJa1z/qP2LWXVchyacfKA
         twiG5eC8KWMG72stUL5X27bI38G2ZhoLN1J2TEu8rRPJPpyd8JV4cb0vl1ZaUoCyLShc
         XFQid4QlywxG3Rw0R340NVyEPR4i+f0u4RyoDrQdd28WpZwqwjI4l+SiWYVk2s8YbEWT
         aKawANF1HvnW1+yPEftaDV/i7wTBCpJ0Khr75WtygPbuyUBxI1op2ELxiwVg+WOkeSfk
         kqsnBl2LGvwlX/8SQGbb/+xUdeGMZ7287vTxV8FDdhiUfbniJJh0JJZdnEXUZWw5NMEE
         n1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849952; x=1713454752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=566s8Y6cLJziK/Nzw7hAPOYHoC3UrD4uE/BWUdAvK+8=;
        b=M4hGNEYTQr7ewqDN56qGYC3Ur+leWjw8bqR4kSD53o5yDSnP5EjSvmCQ4Lpaj2AbNo
         vBkJ6luHUqc1lK3pOK8Xbg/17LqWCx7pnH7TK1qfeVc+jalFXQcbiOa/sHbyBRzgN9Cj
         13nfnVMq2QDQOR4+BLJqE4LXqmOybBT8n/m5GN5ZvjVk9pM13tw70HoDMtRT73tO5clO
         vyVHNuzLc6tnCMlVCl3IA4b2eHgg6ZDaHTLuI5cJT8P+/Cs9QMC4/bGmGIJe4BNLnE35
         Y/KZGOFwx7BaQ0VrM6Ylqb1oDD56mOm2LOGAa4d420bhh2ler1NfYH2RBuK10XMWRFWR
         P49w==
X-Gm-Message-State: AOJu0YxAqQM6aaK8gRp5a3/rFuypGYRJQ7EOjyY5rC1xfwAi5Ql0Fet7
	pZAm/UTg9TZR7F6kQHkPlE+P7DQ2QrEPsHeQi7JCYicnBLeCVq356P18J+kmRd6/vaFmf5qRMwk
	j
X-Google-Smtp-Source: AGHT+IGsfvfbEpGxbvlDWUavSb5evdIAFp6brMAv+k6XjRktkq+wLeNLOn+r5tj2x1PYFF4K23tNVw==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr156141ioc.2.1712849952559;
        Thu, 11 Apr 2024 08:39:12 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 272/437] watchdog: pika_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:52 -0600
Message-ID: <20240411153126.16201-273-axboe@kernel.dk>
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
 drivers/watchdog/pika_wdt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index 782b8c23d99c..bf1ac356df69 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -139,9 +139,10 @@ static int pikawdt_release(struct inode *inode, struct file *file)
 /*
  * Pat the watchdog whenever device is written to.
  */
-static ssize_t pikawdt_write(struct file *file, const char __user *data,
-			     size_t len, loff_t *ppos)
+static ssize_t pikawdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
+
 	if (!len)
 		return 0;
 
@@ -153,7 +154,7 @@ static ssize_t pikawdt_write(struct file *file, const char __user *data,
 
 		for (i = 0; i < len; i++) {
 			char c;
-			if (get_user(c, data + i))
+			if (get_iter(c, from))
 				return -EFAULT;
 			if (c == 'V') {
 				pikawdt_private.expect_close = 42;
@@ -212,7 +213,7 @@ static const struct file_operations pikawdt_fops = {
 	.llseek		= no_llseek,
 	.open		= pikawdt_open,
 	.release	= pikawdt_release,
-	.write		= pikawdt_write,
+	.write_iter	= pikawdt_write,
 	.unlocked_ioctl	= pikawdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 };
-- 
2.43.0


