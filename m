Return-Path: <linux-kernel+bounces-141123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28528A1A98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6321F250A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A2E1E9C13;
	Thu, 11 Apr 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EqE9uWFr"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86646166C91
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850073; cv=none; b=gQHz/P6jhqX7iaoEEWsr48R/Uz8X3tezRnAS9KstFSRy0QCo3HdEwt+rOzTmWLAUmENEF1gFmMu08KP4GvGVed+KKDK65A7h65RHoz0UUfSgBZPPCw3qMpAdCNeGctIjqJlQ/5zHBR8gAXiiuJBS0+jhemZzhXdFXUdDpy+8FPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850073; c=relaxed/simple;
	bh=DYf2TY+17i5nX7wYtBIghalksv6GFdmvBRWzHUOLMPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6x7ojKMEyoqKC6HMXYf5+G6e2NCgpqlPEU1/JoSnJTE9gO4i4eWgLkqG4hkaGH/WwXb/2UtINOR7+OARPgQVf8sAOs3onuioAS+xoHc1Owv9kTQjoBrk3/MuCnjFvqiEwHH/kVW4OFiwI/Hr2DdwuE+6qEZsIcvzpvmJdEWGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EqE9uWFr; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58227139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850071; x=1713454871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDXwUBD2IGyodxzdSdK7jCrkZvD1GwYQ00rG9c8PhyM=;
        b=EqE9uWFrt41jY/3VasDX6uHnVlWLN8Mue7mHfJ2ssCYLnzKO2hqRN1SiodriDPQMV6
         tN6FGSbxlUFHmmqdkdT2ZQf7nXUHVt7U+RW65o0t3lovTg0u4VwaAYoJ881RnPqKCsm2
         GgJ9qn5+On6ajrHlaFduS9a7lZyrJ6Z0g7VYWLk9E0J7Ln1Xoovch+Ux1qFmb1EcJDl7
         +3h2/8Erbq5GmNPI73ScQLomXt8n70z8oY/4bfodU3K9HMLABClnX7yV+bo3PWZpplaQ
         36oD3wfZs7ODZ5k01mGWNFrn7vxwJ25zsiqNDXZMArEYaGo7qkq4zIXNzS9+sEJrbISG
         7FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850071; x=1713454871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDXwUBD2IGyodxzdSdK7jCrkZvD1GwYQ00rG9c8PhyM=;
        b=KXzQrCPua/BYnzqSThp6yd09Wf9JHxqgAnw9BHBDrZ+wMTv3pnmH76aOgu0khudGJN
         j/ZSrYOLFc2N1LKz2Vwd+eu785shHprZuKRPb4NGPAxqnKpSIF77X+kJkJf/IMHtTtoa
         uw8SkwODnEJy3+tqOqo3we096nfxfRfP6YpGBIUPoRF5zY7Adc/3pvTCV+ZNC0vigvLB
         tyfJQ+ZV08C8Re+MqsWilJG/S6axQ9hLp38WjDOUpNpFmawqFxL4bmUXGsih0FPDULOb
         Mn45JHmUOhODpVkE6ydyqPjizQMrrpbvlhdMRGfDzh8EBns5og4ivLssiYrR7ESFLEJv
         KcOw==
X-Gm-Message-State: AOJu0Ywg8zMo1lmX1QAaiJPCnsPRqoXZrLaksyuEFNla3iCEoqaVSwna
	yVqv8yZCleTAPx6jBw5BkSkAumet98naWn0B/C/hTVI49CGIFf7dobMxPDZ1Zp+rzr/BEMh1NLO
	l
X-Google-Smtp-Source: AGHT+IHiaVztBkemIV0vkEDxEwDiOCkEh16oixrFcwxqpVNF7TWoO09dzAiYDK368FW0By6yGXrF5Q==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr200669iov.2.1712850071299;
        Thu, 11 Apr 2024 08:41:11 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 344/437] s390: tape_char: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:04 -0600
Message-ID: <20240411153126.16201-345-axboe@kernel.dk>
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
 drivers/s390/char/tape_char.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/tape_char.c b/drivers/s390/char/tape_char.c
index cc8237afeffa..b6a8e99f0d31 100644
--- a/drivers/s390/char/tape_char.c
+++ b/drivers/s390/char/tape_char.c
@@ -32,8 +32,8 @@
 /*
  * file operation structure for tape character frontend
  */
-static ssize_t tapechar_read(struct file *, char __user *, size_t, loff_t *);
-static ssize_t tapechar_write(struct file *, const char __user *, size_t, loff_t *);
+static ssize_t tapechar_read_iter(struct kiocb *iocb, struct iov_iter *to);
+static ssize_t tapechar_write_iter(struct kiocb *iocb, struct iov_iter *from);
 static int tapechar_open(struct inode *,struct file *);
 static int tapechar_release(struct inode *,struct file *);
 static long tapechar_ioctl(struct file *, unsigned int, unsigned long);
@@ -44,8 +44,8 @@ static long tapechar_compat_ioctl(struct file *, unsigned int, unsigned long);
 static const struct file_operations tape_fops =
 {
 	.owner = THIS_MODULE,
-	.read = tapechar_read,
-	.write = tapechar_write,
+	.read_iter = tapechar_read_iter,
+	.write_iter = tapechar_write_iter,
 	.unlocked_ioctl = tapechar_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = tapechar_compat_ioctl,
@@ -179,6 +179,7 @@ tapechar_read(struct file *filp, char __user *data, size_t count, loff_t *ppos)
 	tape_free_request(request);
 	return rc;
 }
+FOPS_READ_ITER_HELPER(tapechar_read);
 
 /*
  * Tape device write function
@@ -263,6 +264,7 @@ tapechar_write(struct file *filp, const char __user *data, size_t count, loff_t
 
 	return rc ? rc : written;
 }
+FOPS_WRITE_ITER_HELPER(tapechar_write);
 
 /*
  * Character frontend tape device open function.
-- 
2.43.0


