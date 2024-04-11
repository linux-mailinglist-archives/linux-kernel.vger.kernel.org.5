Return-Path: <linux-kernel+bounces-140984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 038C48A19EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3065F1C21759
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF8C1BE405;
	Thu, 11 Apr 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="inMV2Mjz"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479F3B2A8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849860; cv=none; b=Ho0U+8aohNnNDhnFEU6cc2Ld1HYaoU7+pVilxPklzKmhFaslp6aWOQD1jSlpgczUBeI9M2GPDXJIO4KiNPCc7Qsr1QVnvTJ6fxmeK2tk48VbDU1yd/eXGmHpLjuP6x+t77ML7c562XO8W3ORR+3uySKZClgkjsnjG4fEnef3vrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849860; c=relaxed/simple;
	bh=fuNH7H35Fr1gbYOH3tDTlpJb1H8dO6w2oUmmxKFFPCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmS+NpbVdyng2YJ9hL7iso+TkYHkKDE/xunxv0SVFQdYV9bHd8+10OhW2TRgXkdVdf7LRsnvFuCGRBFKYpcwm1vdCukDp0/EEIpE3T0oODWUVj1fgemEJRZ7BoHBQXSRQ3B8cRmFRZwQztrvqhpKhXygZJW3C03UofpOUiVfhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=inMV2Mjz; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36a224d7414so185945ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849858; x=1713454658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkxbKUE7zw8SWj7NeL7kJSvCh3cG4pC9ZQfME48WxZw=;
        b=inMV2MjzKoN+cf3DzJHPQuVvJviolz7MUoaVtiouD+ZxB7nunvPS/PxpCwA0M5kvp4
         CFIuNHIq5yDxV/1lsYtAIDMx0erA6MQv9sWdnXvT9BeMtlbVu98lo8/cL41FovOEY7wq
         FHm6o4XwArumDCHuov1Q2AZLzh5MwYt/D2r66k69pVKqUDPoDLVK3FCcipyKxv0fuBhu
         YlRYsJ9IyY1nfa6seuOMTTMhm/mSB+Y8wPCXjZoSDc/+sNmMdnt8WdVImwx5ETQuuhaZ
         ym/cC2c0zNoNKkvmsKrV2h15wbNIZnCQ3x3CNPjyZ2cx8xYzgvnVSPaWVkIb7T80fEi8
         9HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849858; x=1713454658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkxbKUE7zw8SWj7NeL7kJSvCh3cG4pC9ZQfME48WxZw=;
        b=fgURrv44nFI64iO++vgoYF1TZn4rWEHNPzGZkGT7m/WHV1ZjpfDTHHoqCxpN1tVBnY
         JRL/4/MqFnaEP7RXz2eNHBitzHbgNpTf1U18hiyivvTm42xUgCZrZ38l6xi9qrTgw2yZ
         a1UuC4B9QKImIYdk0uBTXFHwDZ47P+ii1wQ72duCaVwFkBbavC8wTWrzM04k7dPGpoQz
         PSxLu7GVFvvQUdxmizyiQGhLe7yablnofQYaGQkz8WhfO3eCkuHqXCPfx9XnCfjT1O+e
         5XWDlm6yee1I0MvtDe+vgpiXEDvhA3NB2nvtm4BUedG/pec+2ooC+OVlRFfooRIC7hcT
         9F7w==
X-Gm-Message-State: AOJu0YwAX+evFMCORqdaiMq6MSh0iIx/3Njnv/OY27cDOQyu0kfyfIik
	xcCnhVjkoCv53C3EQ2DxHks9vB/qRsppUaCtFF/TTJD8IDqF3X+FF7B9QJrdWaA3lld597+vRJQ
	Y
X-Google-Smtp-Source: AGHT+IGXxfNPFZVg02CSpk2D+4CXTmtslsx+KNhszjd3sOKYvU0s9Xsise+s1/EAJOXbgUaWYjL6NA==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr152695ioc.2.1712849857826;
        Thu, 11 Apr 2024 08:37:37 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 214/437] misc: eeprom/idt_89hpesx: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:54 -0600
Message-ID: <20240411153126.16201-215-axboe@kernel.dk>
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
 drivers/misc/eeprom/idt_89hpesx.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 327afb866b21..dfb68c0cc999 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -900,20 +900,20 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
  * "<reg addr>:<value>". Register address must be aligned within 4 bytes
  * (one DWORD).
  */
-static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
-				   size_t count, loff_t *offp)
+static ssize_t idt_dbgfs_csr_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct idt_89hpesx_dev *pdev = filep->private_data;
+	struct idt_89hpesx_dev *pdev = iocb->ki_filp->private_data;
 	char *colon_ch, *csraddr_str, *csrval_str;
+	size_t count = iov_iter_count(from);
 	int ret;
 	u32 csraddr, csrval;
 	char *buf;
 
-	if (*offp)
+	if (iocb->ki_pos)
 		return 0;
 
 	/* Copy data from User-space */
-	buf = memdup_user_nul(ubuf, count);
+	buf = iterdup(from, count);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -987,10 +987,9 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
  * It just prints the pair "0x<reg addr>:0x<value>" to passed buffer.
  */
 #define CSRBUF_SIZE	((size_t)32)
-static ssize_t idt_dbgfs_csr_read(struct file *filep, char __user *ubuf,
-				  size_t count, loff_t *offp)
+static ssize_t idt_dbgfs_csr_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct idt_89hpesx_dev *pdev = filep->private_data;
+	struct idt_89hpesx_dev *pdev = iocb->ki_filp->private_data;
 	u32 csraddr, csrval;
 	char buf[CSRBUF_SIZE];
 	int ret, size;
@@ -1008,7 +1007,7 @@ static ssize_t idt_dbgfs_csr_read(struct file *filep, char __user *ubuf,
 		(unsigned int)csraddr, (unsigned int)csrval);
 
 	/* Copy data to User-space */
-	return simple_read_from_buffer(ubuf, count, offp, buf, size);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, size, to);
 }
 
 /*
@@ -1025,8 +1024,8 @@ static BIN_ATTR_RW(eeprom, EEPROM_DEF_SIZE);
 static const struct file_operations csr_dbgfs_ops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = idt_dbgfs_csr_write,
-	.read = idt_dbgfs_csr_read
+	.write_iter = idt_dbgfs_csr_write,
+	.read_iter = idt_dbgfs_csr_read
 };
 
 /*===========================================================================
-- 
2.43.0


