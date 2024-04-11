Return-Path: <linux-kernel+bounces-140967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2612E8A19D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CFA1C20EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF071B9DBF;
	Thu, 11 Apr 2024 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wGkXU0R0"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFBC1B9D98
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849833; cv=none; b=lvEfpW2H7q1iMbIiwJT1snPjajIUrMyX4kf73la8kM0gH3D1999UwUPmpFw7voiICZQlLvRWskHc21T6RuLszC288ejlAOL202U08BgmRJ+Uj4pLuNIKwynYzsHhFf2/pGP/w+eda3qK1W7JCFjx6OWzaVw/CAeV/C0pPDpKU+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849833; c=relaxed/simple;
	bh=odAQ04P+3BOnBe320L7TKciJlTg7ftopyYuNxjuDYuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4hJYx0hlGDzFmz7ukzN5ifw976HpRi7UGfZD1GAJRddFWnOIXqSw5M52/PQFP3N2gzOn+vUkgyzrimqEerN5GFvhgHfIM5dggOkCZT9xk4VnnQBtYxqE6gGYbM8bP7Qnu0v4aAGJlm4qUNnPvlnBYEHRC8SafGUKLmcQDsxRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wGkXU0R0; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8969139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849831; x=1713454631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTpZYBkmfcRYdVtNQ9732MLhYR6po5tgWuFll5r7dqw=;
        b=wGkXU0R0KgF7s8t8xkgHI+9ZqGHFAhywir3LWYQTxYualkhTratEpq8GY4Qi0iigBq
         q7Pa6WFjZeBcQJD7oNmukf2GCr2tI6iGh/a8cREqu5gWmuFbQJRErGVM2U78MkMZx2G6
         s9RBqmTYBOQzcuYmVyf0TEimy7DVe3am0clim91RJNv+1F0EVurTHsIdNF2Ef3qo+UYi
         +UemnuUxzFPFr0Wv+Db2X65qsRDALCIyyPhZfb16FQeJKQFoLYPfE8CwN/1aM3Mz9AWa
         5J32U94c+MCZ5AG/0dkrkNJqP2KHLmh12f+RjMTEKVo243fQxJLagFJlvBr/h4vc5IoS
         lvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849831; x=1713454631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTpZYBkmfcRYdVtNQ9732MLhYR6po5tgWuFll5r7dqw=;
        b=Znxk5d9Nl+YwK8TYNoFqOb+XdlbAhjJGDDYo+3VQiYgk9SqJVQ/x7HZFcOoaTqf+Pp
         6V6G4FJSPufmmul0w4O9wVeHK+Zjo/DXjTHNmW764oCxfD+6UX+eNb27RbPE8pdnDOb0
         A6yoIgYfeo4nm8F9VnYsDgGBULP/rBkmBqDv6ZLRA55Hxd4ehH90/fkRfJAFcnrKI1M8
         gMh1b00oQ3G8EsbW+OnW7XJ1f3dryp84yxCO7SSTFfv4ByJd01SnEMSpz+klwnoqd7X7
         tDk/N1OlCEGrrUH7s7K41nZjf8dF8Cl4S2yXMp7o7trZ1eieBsjGuA9KrAGyM/Mw9B1q
         AJrg==
X-Gm-Message-State: AOJu0YwYWE+9eM96XnfZ7DfSfcz2NYta4xXeRHQxg+BZp0xHNbmxkssh
	2QmVgjyUFhdEDnw8Z+10mB+S3htGJFqMgHyvX2ct9T346cgWRQrFLnNlQ+LlkNM4Q70PzQgwGB7
	C
X-Google-Smtp-Source: AGHT+IHLjPI86ucGR63DQvwMt9s/TYMWGBwrX8CdICAoaP5Q68eO98+NDFgxLik5oi6FVpjYggHfmw==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr183166ioj.2.1712849831372;
        Thu, 11 Apr 2024 08:37:11 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 198/437] scsi: sg: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:38 -0600
Message-ID: <20240411153126.16201-199-axboe@kernel.dk>
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
 drivers/scsi/sg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 386981c6976a..c8047981eb9e 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -553,6 +553,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 	kfree(old_hdr);
 	return retval;
 }
+FOPS_READ_ITER_HELPER(sg_read);
 
 static ssize_t
 sg_new_read(Sg_fd * sfp, char __user *buf, size_t count, Sg_request * srp)
@@ -707,6 +708,7 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	k = sg_common_write(sfp, srp, cmnd, sfp->timeout, blocking);
 	return (k < 0) ? k : count;
 }
+FOPS_WRITE_ITER_HELPER(sg_write);
 
 static ssize_t
 sg_new_write(Sg_fd *sfp, struct file *file, const char __user *buf,
@@ -1412,8 +1414,8 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 
 static const struct file_operations sg_fops = {
 	.owner = THIS_MODULE,
-	.read = sg_read,
-	.write = sg_write,
+	.read_iter = sg_read_iter,
+	.write_iter = sg_write_iter,
 	.poll = sg_poll,
 	.unlocked_ioctl = sg_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
-- 
2.43.0


