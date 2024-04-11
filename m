Return-Path: <linux-kernel+bounces-141205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7738A1AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C6F287019
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B9D1FF310;
	Thu, 11 Apr 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TxDhkuVf"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922EE1FF2E6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850206; cv=none; b=fZDfVq60pMe11rnjxwAm4p6IjoafgF7fnO60sxuLIwHs3FVCLYS+1Fk9pqg91SkCPLSO1ZDJ5A27exEj1TOn029QxtH8kLDqXwiVmGQuI7T/tdL98xlLMUcXK1ysuot7/er0jCindfyQ66aij7twy8z0IKtUpOqahmDkORxt8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850206; c=relaxed/simple;
	bh=5zCVpjBaXjGTBgAZevMeHanoZk239/v7twU706cYvMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvJqDC84N54VLWA9pRVQBv9tSwR41z7Bn+M2OyZcrQfT1GJPAq52WWD9IRjz08GhQ11Fdkhxpd5AivmMzhVF+lxrbsIKw/FoU7McDr0m49NzxJRTKyt/jI6dNAj9MZP6VLA9Uobx8SwVYZRE85RpLq7s62XQcIbioUFMwg6Ed5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TxDhkuVf; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9949339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850204; x=1713455004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8z5ztjJ4THmHYJLDuFMMRyFgaox4sISmYp0cYX/YIc=;
        b=TxDhkuVf6Id8wkto00mQeEJytycH2Tphm3eZumbee//xc8quR2dJEtSvhrYQUdrOLF
         diiGnTFUDG2Cpx7x5pxoyu5G5XDwUR/GGa2HYyPUlbc8y0MXZt2p2Ge4M6Oi3K1U2Uaq
         s+3rdBrTRxVqCt7zjovH6Zms8J8iYPCHbc+FS4C0gBKPeGWQceJusGsS3h0bXUbasg4m
         ELWbnvaofFBDkwWu+nPdde0iIzwMmduVQKgtLw+WUMO5j/H7Dlog6GharIhlSEScbw5F
         CM8bZz+3vpPHT2B6z3Yx6XAxlgYhyW2yqLyu7eIt6BJ2q4Jb807o7YNQoXfxofZtfQ0D
         VNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850204; x=1713455004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8z5ztjJ4THmHYJLDuFMMRyFgaox4sISmYp0cYX/YIc=;
        b=U7X6pOXc3xo+uA0mi/T9v7CUa4ik5LWPqMm0laQy6I2bNEvXXCiofcLYRjyR6JKmfD
         7GuysDfHtpSNa/eA4etQXggwEvaUnTSJUxUOuZXOAx0pdZI9YSCU/a49yYbjEPaULhN6
         ZaqnOaqqBeHjZWm22Quzerunm1YIeqBA0Alld4fqDsqIs78vdKvSRs7zQpH9ykR70viX
         V6k9GuLYXYbotB8YljE9i4cSgGVkogzmvcHWH6LItC5bYZnT8HVlMbXBR49xXoK5pRxY
         +qVLCmGuhphPnxAeOY0Mq8BSoVgWMLMaWv2Ak103445xADieW0HHJrm6oPje4oZTns1H
         5apA==
X-Gm-Message-State: AOJu0Yxfkw5Xvr6CXtRZaggO7iJKJqZD1uPGipGw61YVGOeg9c7lEk8v
	w9Dgp9eqoQ0kMgCB74qQg4GyWYl3hdG+xosFBF4JA7fslTP3qyKMchfZm7uKcct0CxQj47EiWcH
	R
X-Google-Smtp-Source: AGHT+IEWdNO2E0vN8wpSlbCQZKIj519Eoauzh+iCC7WqoOdKe9Rq/OLI/k+LlRG/pVjByO21d+EmQg==
X-Received: by 2002:a05:6e02:1d87:b0:36a:fba4:ec45 with SMTP id h7-20020a056e021d8700b0036afba4ec45mr3455471ila.3.1712850204478;
        Thu, 11 Apr 2024 08:43:24 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 421/437] media: dbbridge: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:21 -0600
Message-ID: <20240411153126.16201-422-axboe@kernel.dk>
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
 drivers/media/pci/ddbridge/ddbridge-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-core.c b/drivers/media/pci/ddbridge/ddbridge-core.c
index 40e6c873c36d..118f22cced88 100644
--- a/drivers/media/pci/ddbridge/ddbridge-core.c
+++ b/drivers/media/pci/ddbridge/ddbridge-core.c
@@ -731,6 +731,7 @@ static ssize_t ts_write(struct file *file, const __user char *buf,
 	}
 	return (left == count) ? -EAGAIN : (count - left);
 }
+FOPS_WRITE_ITER_HELPER(ts_write);
 
 static ssize_t ts_read(struct file *file, __user char *buf,
 		       size_t count, loff_t *ppos)
@@ -761,6 +762,7 @@ static ssize_t ts_read(struct file *file, __user char *buf,
 	}
 	return (count && (left == count)) ? -EAGAIN : (count - left);
 }
+FOPS_READ_ITER_HELPER(ts_read);
 
 static __poll_t ts_poll(struct file *file, poll_table *wait)
 {
@@ -838,8 +840,8 @@ static int ts_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ci_fops = {
 	.owner   = THIS_MODULE,
-	.read    = ts_read,
-	.write   = ts_write,
+	.read_iter = ts_read_iter,
+	.write_iter = ts_write_iter,
 	.open    = ts_open,
 	.release = ts_release,
 	.poll    = ts_poll,
-- 
2.43.0


