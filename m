Return-Path: <linux-kernel+bounces-140969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D936A8A19DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936F4288E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81BC1BAA9D;
	Thu, 11 Apr 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FMgeg/hD"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0DA1BAA7D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849837; cv=none; b=CRUJHs2DL3e+0lW95axNTjcM5+V7Czya0zqhcuz5UmszV1dfWlnl+VcwyomQuEe+as36S1/kN7aHlStbwFHtSundRPBaGLBi28jIzFUkRcnybrtLYF3CYTr7HR/qtpLnwqh6IIRz3MknKciOfy1nIfhkIQTYtWI9gPl25OvjQN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849837; c=relaxed/simple;
	bh=EP/E7Xm9Ot3Cq2h5oizZSEHHnQWTQ1aP0zUjK8UvbNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKnyAOuNLaxhb/kYXKacMYzmzwXiya388kOEapGjdlABSGLxc0zT3P9jTp5kvqbkc6KHO0Ep5mwrmc5DGTy903NKXANkFC9hgjEZjETOz2esToi36Amf81qxeBNl+aWAE5pEWoIMBJ6/Y19VA/JHrNt0GDAOqpAoOSP2ss8WLyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FMgeg/hD; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170538639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849835; x=1713454635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbXaeKZGRHtIX5aVUzcxot7CPweD14iG6EPytJkWhT8=;
        b=FMgeg/hDc52A0VTtuztDGvNi2RouEO77y5rAH9IRElWRDkGK+uFVQNdu5iMrmHLKJP
         YUW8/P9sNGYzgcje3hfB6m9EYA5wSkmG+wyIi84mLENem/tmTX7SSMT2m403HIcBUHnc
         yy/2I6JPO1t9m12Y+/iweHWhcX4LhUKGG2MpDN7akARYeDRYp/mjnG99frP+zr2ZF/WK
         jXMmSp2YCfQ2cIY7i9s9r8O+GkJXHaK4v5vBodm1GQx2GY/179Y9nsEkMhF/xIvXGnzf
         Yoo9NN1GXm0Pp8/Jtq3wMhCzoCmCNvkUlYzsaDAW6XkIYrNo2wsOLFtbJRziKpZQD4Om
         GmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849835; x=1713454635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbXaeKZGRHtIX5aVUzcxot7CPweD14iG6EPytJkWhT8=;
        b=ewzthh61WKT0TG1Kiwn5Hcr5IxNN8ENafZ8DADOlw3hHTNXjb3Rgc7hob/49lvXaCE
         eoMK7I7VM4kVBOWqWAZjFl4vbYtIOCKGeInMH6E5gqAYTH5905CDNKfEtA2N+S8WcJQx
         /Pamya1iFdcPr7ezeo/oK403tf9KXNmXmW8Mr1C3Do/Pd/bj5izzat8jOOBhDVJmrupN
         Rv3QNn1NZ6RwweY6txDG2RZybWjw6/CEvf0FSNCpt2ghpQ8Xlmu8bI+1lMmlDqZCqwnR
         F2mpyozbXW2iTUYWh9IQ5MQhfZv0eesXoE65uynFmVzem3J1RyYEeNrWM/M3+jcrhX7v
         DI5g==
X-Gm-Message-State: AOJu0YzlU1AXS6lgvyeNHwNSeiiyoRAJFpzAl4irGDr6X42V6jFQmKfR
	bVD8h7uRBRsEVEJdFV0ZCuoZgPXh3LCPNWiU5gxSZeDFPFWH2zHQ0FBM90eiiueISIbreppUEQw
	S
X-Google-Smtp-Source: AGHT+IFnJYsKEzzuOe5VwJd6NN9azrTrqz+FQV451mSVbvFC2Euccz6BlIA9CiK2Ps8FBEN+FJfQxQ==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr224603ioh.0.1712849834729;
        Thu, 11 Apr 2024 08:37:14 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 200/437] staging: axis: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:40 -0600
Message-ID: <20240411153126.16201-201-axboe@kernel.dk>
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
 drivers/staging/axis-fifo/axis-fifo.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index ba8e08be0daf..9c9f0716e5f7 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -33,6 +33,7 @@
 #include <linux/uaccess.h>
 #include <linux/jiffies.h>
 #include <linux/miscdevice.h>
+#include <linux/uio.h>
 
 /* ----------------------------
  *       driver parameters
@@ -332,10 +333,8 @@ static void reset_ip_core(struct axis_fifo *fifo)
 
 /**
  * axis_fifo_read() - Read a packet from AXIS-FIFO character device.
- * @f: Open file.
- * @buf: User space buffer to read to.
- * @len: User space buffer length.
- * @off: Buffer offset.
+ * @iocb: Metadata for IO.
+ * @to: User space buffer to read to.
  *
  * As defined by the device's documentation, we need to check the device's
  * occupancy before reading the length register and then the data. All these
@@ -451,10 +450,8 @@ static ssize_t axis_fifo_read(struct kiocb *iocb, struct iov_iter *to)
 
 /**
  * axis_fifo_write() - Write buffer to AXIS-FIFO character device.
- * @f: Open file.
- * @buf: User space buffer to write to the device.
- * @len: User space buffer length.
- * @off: Buffer offset.
+ * @iocb: Metadata for IO.
+ * @from: User space buffer to write to the device.
  *
  * As defined by the device's documentation, we need to write to the device's
  * data buffer then to the device's packet length register atomically. Also,
-- 
2.43.0


