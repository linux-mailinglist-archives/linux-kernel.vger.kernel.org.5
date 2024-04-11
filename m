Return-Path: <linux-kernel+bounces-141047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F96E8A1A38
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB661F225F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC721CFD19;
	Thu, 11 Apr 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z0eMUD8c"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99815487B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849956; cv=none; b=F7fMmYRxr4q6M0GHi5KW2tPKbQtYAvTfIjxh1r6am9KBW6JW0uRYKHiq7QJRqsjOlZYUufIJIip1JQbmbakq4FPo+7QOsPiUe/OH8sNm5vxtHuSizoTc7VMuv8xtFHH7yOTyPZw7MbJdE72mjNmS5vodOPm7aez18UkNitBZzHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849956; c=relaxed/simple;
	bh=VcsBVZtz+JJy48VV91zYEvK1ueffH3e4bxoR66JiCys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xb64Klxqy+TLitXDbiXpdXpoqKaDbiUxPumzYIe9H4k9rV4EN/RppmUFEgRCwABjmi8G3h259/nq9oLHjQ7mRa55s5X3y1qBmbPTr1pO4iK0u3IXIwL5p1U4K1yPXjiMjLdR87oKZFjicO1z61T1i789AuoMVMo7pWAzLr66rZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z0eMUD8c; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58156439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849954; x=1713454754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULLvcJ//537IPsZSnWbIfATv4VlFUZIbUClwMCj/AXo=;
        b=z0eMUD8cnb2bQja+w5DgzMh9NJvi5wYURnLiZnqmKcNq2AS2hm2w/jroNpmn0fyLi+
         AGgM8sW9L6qCaQ5YUFpP5zkl5VG5WoQDN1+N6Yk66v+CV8vVtaOYWqOfA67UUZHvRr+s
         Jvh8EsErH8SzprLe5K6+tY+DY06i0Smkba0rm4tPfKwuxXzrTHne6x+gpTr57DV/sOFp
         Opmzy2VptxGJhOfmj9H6zg+cjwdQqckn9iaUUSuzAa4JeVZgqhoqYV82z1F0lgPs3N+E
         jjZ7tTMwo0MedZMNozGQthIaVHwf/PNnaRbF0yD9l2jy1ySe+37P9k+aJZlUlUoMz561
         k97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849954; x=1713454754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULLvcJ//537IPsZSnWbIfATv4VlFUZIbUClwMCj/AXo=;
        b=t8e3shCQvZeWvzj2mEivYv1QCSg+1lVwbnOcXAT+x7gUPX1UJiR2NW/MaZUzXvORlA
         2ixDVWlQHX/y/sp0l7coNfub62t3jmkl9uOeXZ9cWNZeirEcdVVg9F9BJcwY7BVMAh6T
         nZ/9OLPvcxAH4xBjJk3WFM11x8bN2r5F7Kg0my4C8pWwHeWG0Pxr2kUgucEnaDOt7/WC
         DVghqOrTm80a1DzGm29XCkggLZteGlcHubJ0K910q6dzfW5QKM5ktRwGduTcMUEvgjrE
         J05t8xcjg7vy2gA3F4rCgU+LInBRkFS4pLBMiVrUOEL7jgEbG/adLvbBIJ/Qrw7WOXM9
         YOsQ==
X-Gm-Message-State: AOJu0Yz0yFwJdPccKGKulfU9TokVL/Xm10sxJVIkmzV/UQRhuvSdooLx
	DnG59oY4DQdNWnhh/rwC2w9/gX9bP/9ZPhVB9f8AK845sDc9ytASM5D+crsE+0EBajX65pexLkm
	Z
X-Google-Smtp-Source: AGHT+IE61O5n7k0vrG2eFRX2nYSl0SnD44wEqJb8nO2P+iRMkkizkUbXBHk3N8A5QhgXHGADQwISNw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr169444ioh.1.1712849954189;
        Thu, 11 Apr 2024 08:39:14 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 273/437] watchdog: rc32434_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:53 -0600
Message-ID: <20240411153126.16201-274-axboe@kernel.dk>
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
 drivers/watchdog/rc32434_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
index 417f9b75679c..76c046c9beb9 100644
--- a/drivers/watchdog/rc32434_wdt.c
+++ b/drivers/watchdog/rc32434_wdt.c
@@ -161,9 +161,9 @@ static int rc32434_wdt_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t rc32434_wdt_write(struct file *file, const char *data,
-				size_t len, loff_t *ppos)
+static ssize_t rc32434_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	if (len) {
 		if (!nowayout) {
 			size_t i;
@@ -173,7 +173,7 @@ static ssize_t rc32434_wdt_write(struct file *file, const char *data,
 
 			for (i = 0; i != len; i++) {
 				char c;
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -243,7 +243,7 @@ static long rc32434_wdt_ioctl(struct file *file, unsigned int cmd,
 static const struct file_operations rc32434_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= rc32434_wdt_write,
+	.write_iter	= rc32434_wdt_write,
 	.unlocked_ioctl	= rc32434_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= rc32434_wdt_open,
-- 
2.43.0


