Return-Path: <linux-kernel+bounces-140774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBC38A18E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C92281BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E0B14286;
	Thu, 11 Apr 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rB4A28kH"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314346535
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849520; cv=none; b=SfGHNNsvSmB+ZqdINnBoqBEi3Oe2JkA5mpQtbB5BTC1nbvi7PZKkUrHIK1A1YjEB8Bk9WfXi9mid5CQNTRhAZ6y/kzoxnAV5uzx7u6Hyo3LpXr0KcuLr/EIFbAdyYiq9Tpop6WBWNO0MrFvGrBteF5HfNyf+COuxIMdvmOfd6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849520; c=relaxed/simple;
	bh=hhjDHri+qBqTDz94sx0jZF+iaEm7tv/4uXBbAVa23OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7bmiHwYKVPvY41LivjHFPAbWtYd5dU4ihvU2m/ANtRIbxvLwHdEpVUKrIJpPrTm1WcHj5dF/QHyYal/6Bg1XdOSTHLxP5qTkSM5NeC35GyYBBpux8JpJP0xNsvOEPrXTOCwNvP36iplWuYMODk8bTlvqWhSCK6aY56PEsHsyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rB4A28kH; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69482339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849518; x=1713454318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIUVHlwQacz3yyXKg2OpE4bMkgCuLl5Zzk6sSz6RfrU=;
        b=rB4A28kHS+7HuJBvrs8KU+X4P6iB8ppEY/ReFnGr+Nd6W9I++vbr0u8u4whmJyyAJo
         CFs3+lhBJQEEmkUwanmHJWSgifKQSNB3da2TFsgQtW52Ui3ljDyxO4ox9VxB8W1OA7PE
         7NSodXn0CsNTx2tBqJ6dOYtq47Fv4hy8P4g9W4I2W7kKSKSH9zvIp/srXydvVUrdQT1R
         K/CctwytKXOWggtfUeWJibq2aLxz4iYD0uQ0TrvvYFsLSJIkWVoTkZNl6I8ZUkrWc/RA
         idV5CF7wpgUpyd4RAWk7hb2PT9vQzhj2Cmpwk7aRF0Jy6zMgHoXNY8hHcdIgAfKGJcR2
         2Z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849518; x=1713454318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIUVHlwQacz3yyXKg2OpE4bMkgCuLl5Zzk6sSz6RfrU=;
        b=h5dFGPkeFEKIWc3suKONRBFaslPRGfBc86d6s+HEezfnLg8vrj8DVtNv6jIrw7vH7e
         Gc1zWtzlUYKFPExMtCvUIE1ntjN/YGAZiXX106qFwr+h8ZG+r8Z4cLWJcsY4zsQJCfgz
         6VbwOp4/V+u/S7BVaP8RKjw0GcpwfnFoHopLmMReKeHJXe2lRoEZ3rtFPK5hlpIIr5/3
         P3oQMAGRP74J5JjeYJH29DIQR4Hb9Vp4f9XK3z96eaDFjq87/2wpWoU8RS/C3bsdLIo8
         NcrdrUzdJJ1y0XhplM75CXrwNLlSPRPsrQjnH3cQNpXaRJtkeblwY4IYG1oNT/XZLa3Y
         fRnA==
X-Gm-Message-State: AOJu0YwOahryOYUIihGwCC99uAQt46RMABRadOSd+NjbLZccOAcvIEAw
	HuSFDE0esLltNLNvDcRqgAaNDX518JB/1+tE6nhDJ45F6Cywtue2QrB1x9ySG6hRu/6VAdVq62l
	e
X-Google-Smtp-Source: AGHT+IGDd3dLPGTeWxTzhP69WgO05OT8mDPgW4etQYmjBC8F5YrU7+Nwuq3pPZCPyMfUz6ekqorvSg==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr201717iof.0.1712849518416;
        Thu, 11 Apr 2024 08:31:58 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 017/437] char/dsp56k: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:37 -0600
Message-ID: <20240411153126.16201-18-axboe@kernel.dk>
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
 drivers/char/dsp56k.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
index bda27e595da1..14f0f284c944 100644
--- a/drivers/char/dsp56k.c
+++ b/drivers/char/dsp56k.c
@@ -242,6 +242,7 @@ static ssize_t dsp56k_read(struct file *file, char __user *buf, size_t count,
 		return -ENXIO;
 	}
 }
+FOPS_READ_ITER_HELPER(dsp56k_read);
 
 static ssize_t dsp56k_write(struct file *file, const char __user *buf, size_t count,
 			    loff_t *ppos)
@@ -304,6 +305,7 @@ static ssize_t dsp56k_write(struct file *file, const char __user *buf, size_t co
 		return -ENXIO;
 	}
 }
+FOPS_WRITE_ITER_HELPER(dsp56k_write);
 
 static long dsp56k_ioctl(struct file *file, unsigned int cmd,
 			 unsigned long arg)
@@ -480,8 +482,8 @@ static int dsp56k_release(struct inode *inode, struct file *file)
 
 static const struct file_operations dsp56k_fops = {
 	.owner		= THIS_MODULE,
-	.read		= dsp56k_read,
-	.write		= dsp56k_write,
+	.read_iter	= dsp56k_read_iter,
+	.write_iter	= dsp56k_write_iter,
 	.unlocked_ioctl	= dsp56k_ioctl,
 	.open		= dsp56k_open,
 	.release	= dsp56k_release,
-- 
2.43.0


