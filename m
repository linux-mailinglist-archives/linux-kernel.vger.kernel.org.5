Return-Path: <linux-kernel+bounces-141217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A845E8A1B08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1781F280D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FB42035B2;
	Thu, 11 Apr 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MThp6PIw"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B740203580
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850222; cv=none; b=FDkDAGgJfE4EENsM2+hJJm9RwZw7N/KeX3G/iIkpc6UH7z2oa7ES79+XUxEzqVxsagkgyJIUN1Y6NEf6y17ELUe3/uh/5P4f4zHsL6f6TWcETsKXRFAFWJJk3sE8NXTezy8ywFi9N6v0XZ38vS/7xbcIQllSoJnUJlxw4J8HfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850222; c=relaxed/simple;
	bh=i81SoTpfZoCttmw03BT4HXoOjPTFbjdS87pTUWjCFL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1wtI9WeiO4dqR16MRz0E6l2KZVajE+M9xMBu+PcFOZVAm4EvSfzjEmnMMU9cnnmCc3CjgtJAsz32FzEMrHCeA7UIWjRQbuGWInyDdk/JhtZxzSYKc7VIioctmuA70fsIzapWuDa6YxeCLFVBKaSu7iwA7HEbTg5x/K4qLDP7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MThp6PIw; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9953439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850220; x=1713455020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y693zVyKx5Xj5+ZmbaRfysNOquN2tS7NYbAkTC+dKIw=;
        b=MThp6PIwqqd1AKVdrh3Sl4r/w2jk35nlbunr0LQ2WpRg+zab4mTkybCeamSJDEKUHm
         oKgBNsbs2klJP97RwCPqsx4rRIHfuUVtMut2XWDU/elA2OcY8nh+QrBsbJ+4ceFRXNbA
         Ip3qDCY+tkY29z6A+q1hp72coRRmrzwjU5wQn0r/l+gHbpp2Fgu/WTRzxTlapvGTtQqm
         M6aT4ItrTPZ3UnkDl9Pe4tNfACfLXcOWg7M4k+YeP1eOYdaUGcVNlPirBRXJ61HarRVv
         A0WU7x6MQaanOBanXEbmcyF0ZmG25bX0ytnrn8la8xBbQF5RkZYFUWkvhN8QrIajBXnz
         5W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850220; x=1713455020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y693zVyKx5Xj5+ZmbaRfysNOquN2tS7NYbAkTC+dKIw=;
        b=HqRpP4fuZNiTOficH1YAXqCc11PEXm0X8kIGK4njUWlrspW3S1zzqwdAINSmHCvXGm
         yMooHN3pcRJEJ2YLSKYK4EZrCK3Z3E1fqdu8+EiE6RKTQIIo5EJ1xCRc2ps5DxLNsT1Z
         4SEtKkLEvcKywYuaBCJ3lDsZP/nyHYsBiBHYIcjknVmbDCBV2wdJdiWYuBMoBEVVRRj6
         HHJe9jNCNl1jXiugfcHoHQ0vC9En62T8S5UI1uhNTbHk+YCMD+MSAYJ/HmlRTLbdRrte
         jvTX2bDaYsy0aaxUt71s7FB94icKsGQlWnwft0lTLqYo0HMWLkBO7nmoRku8Xk6nx1cD
         esVg==
X-Gm-Message-State: AOJu0YzHNW/90rFz67wSwlDgLDPXAZ9SSPkTcARbggiJrcuui2HyOd87
	ij0NvlOLrqxc/S+H8+e+RNXAl73onkI4QDgTPLbXjVThmSqoaM0krQPcyIF0Y45hS9XZZFzboa4
	2
X-Google-Smtp-Source: AGHT+IEWrfbd88bnUiW00XiRmvhgc0AOpozz4nHHdElKVS126DsFNkT+7m7nooW2oaaqlTHqgd2YMg==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr58046iob.2.1712850220403;
        Thu, 11 Apr 2024 08:43:40 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 430/437] sbus: flash: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:30 -0600
Message-ID: <20240411153126.16201-431-axboe@kernel.dk>
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
 drivers/sbus/char/flash.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index 05d37d31c3b8..4b21dc0cb3c4 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -98,11 +98,10 @@ flash_llseek(struct file *file, long long offset, int origin)
 	return file->f_pos;
 }
 
-static ssize_t
-flash_read(struct file * file, char __user * buf,
-	   size_t count, loff_t *ppos)
+static ssize_t flash_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	loff_t p = *ppos;
+	size_t count = iov_iter_count(to);
+	loff_t p = iocb->ki_pos;
 	int i;
 
 	if (count > flash.read_size - p)
@@ -110,12 +109,11 @@ flash_read(struct file * file, char __user * buf,
 
 	for (i = 0; i < count; i++) {
 		u8 data = upa_readb(flash.read_base + p + i);
-		if (put_user(data, buf))
+		if (put_iter(data, to))
 			return -EFAULT;
-		buf++;
 	}
 
-	*ppos += count;
+	iocb->ki_pos += count;
 	return count;
 }
 
@@ -148,7 +146,7 @@ static const struct file_operations flash_fops = {
 	 */
 	.owner =	THIS_MODULE,
 	.llseek =	flash_llseek,
-	.read =		flash_read,
+	.read_iter =	flash_read,
 	.mmap =		flash_mmap,
 	.open =		flash_open,
 	.release =	flash_release,
-- 
2.43.0


