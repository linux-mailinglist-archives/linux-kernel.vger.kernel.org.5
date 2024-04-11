Return-Path: <linux-kernel+bounces-140768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCB38A18DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5301F2571A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FDF3FB3B;
	Thu, 11 Apr 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W6XMIGeq"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F923D994
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849510; cv=none; b=WAaNG8j5lZSueUJNAZdiQn66b8xx0DbNkyzpZNZEtB19iADaPSNkI0Sbu9V49SMZRmIqGybo4kPOb2s/GIG17mwnUbgJEq7Em+taTgh5ZeX6tZBa+QHCCWRXeecbYTzCLQ2LfDW0NTUN/C4spfUocBHBCZwhj7qz16e1QXQbTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849510; c=relaxed/simple;
	bh=YFSjkIyMvV/B3c/pNdT/UFmxAspHxJVXohBIvw0zUWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYt4NwLdQFzzzCrzwUkOadXndT6SXq4h7EUTQktiCLcgTFPa8vNvclqShKfUZjIgkJrt07947OVBbV+UzKVb0rmEIp5QNZc7nXi9xoZMvaSlnuFza4KICFjGDhxLUgNzZZOsa5MKqgbipIS7NyIfcrUR/V6fNym3pLwWsM+WBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W6XMIGeq; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9691539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849507; x=1713454307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83kOshJJaLZ7SIF5wsRq6xBjLbldVO/DvvsYIUNmSyA=;
        b=W6XMIGeqazkaXpiE/Qx39Aksxg/PI4jHjnfUN5XMtThXGOZF33OS1NP9xFzqZWvnvp
         B4HlpjvLWI0LlCpYz6f46AjBZiXnZGdK9pMDoWuCNA3TuM6qwfe4lP9sGWlnCT6Rkhvy
         qulMDMueOY2xW6h39AdFgjZNRDwm1u2Hd3jKsu9WjItuQrYrtn026hatvX4JHLVZkAR6
         DqLdML/Ixs11BGr2YVkC7fONRM4msE/PhYRs+teyPprMoaL+8WyvqKak7ReGQT9bL7O7
         AHIeiFtgtNJJ50kXGSP5htKP5XcV9crBmLdV53FgaHeARyi2tK8PCUAGzxGhRELYI0K3
         o5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849507; x=1713454307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83kOshJJaLZ7SIF5wsRq6xBjLbldVO/DvvsYIUNmSyA=;
        b=YLbgyBO5mUxD4UmCLTc7knAC3lv0YRDWjh+8OgYnly7tw6PE2cX1HlIMCXZN9UPikf
         vHJb32JAqJCh3796o558V8EFydvKAP7QstlOACOeI8D105ORWDqofL7Y4tGYdcLn3LP3
         Yo+aGnQ1WKhwk4YIvVuAs2Uq/EWc5GQfiEugiBOSc3I88q8JWlsI10CyjG+LjZVA8g9u
         uNi4k0fcZigQEYTnrh3wjW9JpaY6rqYHGmZmHPdt5BO9GX38azeoaoM08KhV0b2uGZqq
         4zVgPvqPA52ExdZibjpUKbLuymf85Ncqd0GMYdUULmH8tYYA081O/1fkMVcnGjGCRApc
         Ot8A==
X-Gm-Message-State: AOJu0YwRCyTjrr5Juh526mEcheAdAbAJK8DXV3od9h+tWkmBqiDJhXzd
	N74ht7w0CAZPVeBeeadRYSFzJ33v2sL2TgKWCqES8C7vMyX4nuYMkc2uj5/T1LK1RcIiq/rX5x2
	q
X-Google-Smtp-Source: AGHT+IHcO/jMt0Sh+JGzqMXL4SJO/qgQ3K6VAzpv+CKJ3Mn5pqWNcXGbM2mQvi+fQGiUa6CqzVNKVA==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr201026iof.0.1712849507619;
        Thu, 11 Apr 2024 08:31:47 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 011/437] virtio_console: convert to read/write iterator helpers
Date: Thu, 11 Apr 2024 09:12:31 -0600
Message-ID: <20240411153126.16201-12-axboe@kernel.dk>
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

Add stub read/write iterators which just use the VFS helpers, and
kill the ->read() and ->write() usage.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/char/virtio_console.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 035f89f1a251..154934eb9ae9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -771,6 +771,7 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 
 	return fill_readbuf(port, ubuf, count, true);
 }
+FOPS_READ_ITER_HELPER(port_fops_read);
 
 static int wait_port_writable(struct port *port, bool nonblock)
 {
@@ -844,6 +845,7 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 out:
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(port_fops_write);
 
 struct sg_list {
 	unsigned int n;
@@ -1087,8 +1089,8 @@ static int port_fops_fasync(int fd, struct file *filp, int mode)
 static const struct file_operations port_fops = {
 	.owner = THIS_MODULE,
 	.open  = port_fops_open,
-	.read  = port_fops_read,
-	.write = port_fops_write,
+	.read_iter  = port_fops_read_iter,
+	.write_iter = port_fops_write_iter,
 	.splice_write = port_fops_splice_write,
 	.poll  = port_fops_poll,
 	.release = port_fops_release,
-- 
2.43.0


