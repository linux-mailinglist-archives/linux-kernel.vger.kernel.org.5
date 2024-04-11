Return-Path: <linux-kernel+bounces-140847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC9A8A1930
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0571B2814B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A06135A67;
	Thu, 11 Apr 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LG3LPh00"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CBA135405
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849649; cv=none; b=ogVTFM7x4ZzJzBD7Gv1EoBP5XXSVstVMlwUCxT6A2BOKtcbZ5AR2Ya6fsgi2KaJ8ikcOS+8AAcKjgcvm34/sCbBIAH0SRzcZBnDaNSVk8mNmFy6o/bnSVu56BJ1osr+C2CLBWc32mCUTwIfovREylBqH/KfzvMUoo41HfaMYfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849649; c=relaxed/simple;
	bh=SbovdU9VFO+HM6AUrI8to95LAggTnrNdLYtygBnGjPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBEFJ9/s6zQND+cYlHYuRPifACuBMMTNCA3PUBRdtz4tghSUlQTG0wkDC3bOgvF6m03irR05W+vsOU1YCUZXzDE9H0GjXF1OVA7UQS16PbRwEqQhKPC55bW+c8KTYfbs489G20qhY1kseqZxVDUIYGmEAPkaF7Tp5To3NCWwZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LG3LPh00; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180627539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849646; x=1713454446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adaeF9DmdVys/XfYHkM+InWjJid8VOet2hxIDinjd6M=;
        b=LG3LPh00SgLYjP7IZ5G/devPbIuoHRK+FRToCGPi21osp70KAsxWgQFYeaRYpE0r/0
         IZRnu24zbUDuMrFVK5yywODQw2n58nK6JPnh6K7JXEkXt1+uSup53UfLrYPRUU5O+drI
         YW+llU++W4H6jcdrfPT0PNxULQ/BWcunmTcbQw8McCWaGILbucr3doMw/UXHEmwBWh8+
         5SQlSVzMQUWoCpR5c9GNGboqrcsUGyBlY0w9vAuI0eVQQp5VXcTP3kuzIZYR3OdNwmCK
         31y7mobPcAK0/+/xqdXtzFgJdz1S8H57hLgOCE88SDMoJBLMCz4HVeR+vocHGCfb+AJc
         JiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849646; x=1713454446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adaeF9DmdVys/XfYHkM+InWjJid8VOet2hxIDinjd6M=;
        b=LgsSSIisRhFHtbE9W6olHH5Ytwz8Ot9jOMb6EtrFt0/P9nrhMikKw48DNbIz31Gthi
         PpF1kF3df+sc/YAW/O37A8ahPQ6SvELiNoZsu5adKD7so6ZP72tpJC7Usja1zULHOgNh
         apNHc6Bl8GQpMt9qgor3uaODiQyvniDIJQZesq60aQLq72SHVI8pMR+W2vUu9IPoUIEF
         VUtuEAb/2pRTUjmndkUGlzg/nROogJT48Fie1dgnp1Sb9a9xw89RhVcrqo6j2WY8jzz6
         pzW1X1t8iv3UKjN0cbpM7dXpDBprHXQWfUVlaWZ7LYSvXs8DGiLlHnbJ2+F9YGBscQ1h
         SK4g==
X-Gm-Message-State: AOJu0YxzF1BBzhqcUs8Pr2LzsfuJBWqLPoLx4zUoP1eUblFv+jQ1xs2i
	6IkuThO7EN0/FTiYnJUsgfuT3GvRinzwL/VBimskwAlrS8eI5/n+wf480roCwaXOGdnPAmB1fDN
	4
X-Google-Smtp-Source: AGHT+IEti6MBOZk3z9r4uF8Fk4TTGgKkCiL1FWai877sTsbEMQqmiYvfTpaXO0lJgzPBMoRFJB61kQ==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr144069ioc.2.1712849646619;
        Thu, 11 Apr 2024 08:34:06 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 085/437] kprobes: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:45 -0600
Message-ID: <20240411153126.16201-86-axboe@kernel.dk>
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
 kernel/kprobes.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9d9095e81792..ead4b7cb70d0 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2971,8 +2971,7 @@ static int disarm_all_kprobes(void)
  * when the bool state is switched. We can reuse that facility when
  * available
  */
-static ssize_t read_enabled_file_bool(struct file *file,
-	       char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t read_enabled_file_bool(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[3];
 
@@ -2982,16 +2981,16 @@ static ssize_t read_enabled_file_bool(struct file *file,
 		buf[0] = '0';
 	buf[1] = '\n';
 	buf[2] = 0x00;
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t write_enabled_file_bool(struct file *file,
-	       const char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t write_enabled_file_bool(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	bool enable;
 	int ret;
 
-	ret = kstrtobool_from_user(user_buf, count, &enable);
+	ret = kstrtobool_from_iter(from, count, &enable);
 	if (ret)
 		return ret;
 
@@ -3003,8 +3002,8 @@ static ssize_t write_enabled_file_bool(struct file *file,
 }
 
 static const struct file_operations fops_kp = {
-	.read =         read_enabled_file_bool,
-	.write =        write_enabled_file_bool,
+	.read_iter =    read_enabled_file_bool,
+	.write_iter =   write_enabled_file_bool,
 	.llseek =	default_llseek,
 };
 
-- 
2.43.0


