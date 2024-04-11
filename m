Return-Path: <linux-kernel+bounces-140852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D38AE8A1997
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD1B2B2DA78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442A7137908;
	Thu, 11 Apr 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lOJBrBRG"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F113775D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849657; cv=none; b=bGuhpKiU1hYxPX4HWxK0QIZsDmLt7IjM5pi3NAGSLsXfhAZSNv9fVf1scCO5Y+b2++pi/wghQTC3lLT8zeFfk63DWLhotf2RdA978I3Khrbkvmy+u2WOfKmyeiNLPjSwI6b1SZOMNZ9f8tJ1LcxawrVMWIjZFdrYXuORfcaHfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849657; c=relaxed/simple;
	bh=IrOVJYKYkD/uixTWBJui+AZJOs9K49x8gTcXl9hNTdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epsZ6Oa0snQRedBNhpcpHpwFcscBjGLrKdB89vuQRi00sQ7JLF/VloL3n/PwlINTd9ihNg28GnW33RWXY42gC93qpm+wfuSvTWgNtlwWyNy31aRwkLgU2Q2Bn2ARQsYegbUzeUVuLsVU4w/qqOzaUHu19efOLXoKn5LnGlw0dGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lOJBrBRG; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9752339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849655; x=1713454455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve5FDQCQGXd6KkbwdWDSWiHyt+M8i4Vx8XVycwHSjkM=;
        b=lOJBrBRGb+mY0T/ylfsuZGGKSEiFOIPyLip8/DU7FND+zrGjuDFzhjSTg/yf9qOrcf
         WIwPvowvPEpuwd6v72XC5HzkPL/vLyTc8f0bBWhd4O8Pf8M+1Rd4QglO41cwOESU7wAu
         IUWN+u9WedoNkCQDtilc4oXIyKGcRM+fEYPp09gBeOeGqdYF+ocM8Of8HND4OzHnBf4H
         P2qyBOzZWwYKVa6OXXyBSVP0yBaeIVLDMYzMnGRXPK8/eljTR+QW4KFpKL6Hcvwqx6lS
         gmqDNCOcDqZkbZWUU2M+BGUo8I2MQRtBxyvFP1WzTsd+2fLJXckM0loEtIKYWVaa+Rfv
         f8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849655; x=1713454455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ve5FDQCQGXd6KkbwdWDSWiHyt+M8i4Vx8XVycwHSjkM=;
        b=hnJCZwjACT5CQ/0tcWgv+J3aM0qmscj6zwXs+kLnONu4gQ7qO24OGS/0xxoI62WHSU
         EhLw4qROborAhd3sazEtFuYI0yGPQWNk81dnMvH/J3UJU4daVQV0p0YQSeAbgvhW5HQR
         1trVYlFmkCXsKZ1NDlDSivScWZS4BbzwihpJ0UnxhNdAZ3/Xg0qextdlOJxZqc5x2Q6g
         5LswpkWIoawBY+t0Zi50sUOD8MtLXUIbD3HECGmuN6QdkblVxp61hP+AWE5whiLaTc9X
         SDK5I9j82mYRk3h6AN1HgmYHz+MutHYe1xlH7ZVGuY1VV6PejP+8103GWN0NLJG2dObU
         Kz2g==
X-Gm-Message-State: AOJu0Ywat1Ri+siimud3Z/ABhJ1TuDMbg0L9VkDYpAb9NGuTpTXTiq3g
	N1lKEHGw6Mq0etbx+vy/6SRSwbNYjmTEFpA3I86RnUggo3/y5K4lYPd1tcVd1DMjwwG6JpA9RJ9
	i
X-Google-Smtp-Source: AGHT+IH/MUvgNYYKrisZ+Ji8Fa7GnMX9eiOPSrfoI8cmqlvHL9B+2t656LZplSjVIl+mDY7eVjw1nA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr189079iop.1.1712849655188;
        Thu, 11 Apr 2024 08:34:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 090/437] landlock: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:50 -0600
Message-ID: <20240411153126.16201-91-axboe@kernel.dk>
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
 security/landlock/syscalls.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 6788e73b6681..9a79b90f4dc9 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -122,21 +122,12 @@ static int fop_ruleset_release(struct inode *const inode,
 	return 0;
 }
 
-static ssize_t fop_dummy_read(struct file *const filp, char __user *const buf,
-			      const size_t size, loff_t *const ppos)
+static ssize_t fop_dummy_iter(struct kiocb *iocb, struct iov_iter *iov)
 {
 	/* Dummy handler to enable FMODE_CAN_READ. */
 	return -EINVAL;
 }
 
-static ssize_t fop_dummy_write(struct file *const filp,
-			       const char __user *const buf, const size_t size,
-			       loff_t *const ppos)
-{
-	/* Dummy handler to enable FMODE_CAN_WRITE. */
-	return -EINVAL;
-}
-
 /*
  * A ruleset file descriptor enables to build a ruleset by adding (i.e.
  * writing) rule after rule, without relying on the task's context.  This
@@ -145,8 +136,8 @@ static ssize_t fop_dummy_write(struct file *const filp,
  */
 static const struct file_operations ruleset_fops = {
 	.release = fop_ruleset_release,
-	.read = fop_dummy_read,
-	.write = fop_dummy_write,
+	.read_iter = fop_dummy_iter,
+	.write_iter = fop_dummy_iter,
 };
 
 #define LANDLOCK_ABI_VERSION 4
-- 
2.43.0


