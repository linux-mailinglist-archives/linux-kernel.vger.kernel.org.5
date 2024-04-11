Return-Path: <linux-kernel+bounces-141218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A28A1B09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725592821E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57232204058;
	Thu, 11 Apr 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vwu/SXdE"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A832035AF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850224; cv=none; b=uMG8/p7Lo/mZpVmIMEtx2suYlcoqKHbDi9jJVjp2KUZoD46HypSel5qbNllDTxkQ2dft2q0bEiz3FT4/p5VqbuuFKmhujpFcg0UUDE2pnNKM8X6PIuxqCcYaa7u6YrChaN9Vwj61CPuekWFQtb0ZPF8gea9lvWUX09aQbW65pck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850224; c=relaxed/simple;
	bh=IMBKNykXgoR5Z68gbJPYMGQFh6CxDlMrK1BgOu93NB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2/LT5UUx/m1ntWKLp1c2XfuZGZrHqgABA65z+pu5axQXpHg5ZcU8jHpqOm+1g5eAbRxya7pLCsreOg+v+fiuvBhyTmGE3AMAO7GawkMbJ0o0/ORyt66aK0fDRVHf9ObdP/EKnUpp8tkBjgu+RynZtzw2p5QXWkEG+4/1fSZ2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vwu/SXdE; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a34b68277so125435ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850222; x=1713455022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ+X3I425i0EDOsy4DD7c66IPiuYwpNwo+cA0gVDxrE=;
        b=Vwu/SXdEw08H4BAxcffa/OLLweuX/x98P3EMr/iPNgchrle9kQzwXNowxWhkk/MPkj
         bB+ALAcNyfbAlnUFjyRsaXIiM0WWZjyQ6iuc8CAmiGg1gb7mjAWnNovwI0/0uSQi12kI
         4IOaOM/U6RfCXkxqp1ZNuIyHvMnbNWgTufDhgm9ZbqvrWp3rHp17auNynLqkjJiWX5si
         GctKqStnzOFd2UBPAPjdg3qMkt7bdZIweyxDuVi/VVGZ3E+/kRYKTTYNk/IhJU0OoVmx
         //9ndE4TYNm1JbFqwcdAdAlj5Q8AeA7GUtHg3eVVSztH6VHL2qGrw8yAGgpm+Ft1UHYO
         YORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850222; x=1713455022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ+X3I425i0EDOsy4DD7c66IPiuYwpNwo+cA0gVDxrE=;
        b=OcCdWzUWMRqh8m3CBvYSby57MSOE4fe0TrRmllHdkOe5j/AOmoCPD6AEht7w34Pg0l
         0zk1Ge6KG2cVtfU2RvPxm8jBKChCG9BQHIaL9zdYRDwSxHqmT08280XXcwL8FXPPHJ/c
         l6xTNpv6RIQKDE4zUq+6wI+hNWelVPrxPm9HL9VXIUGLCbhBCQaaYI2gqjz7zgwvo4Vj
         amxheLFcnwPOPs+7wQDOYCQIYoX3IZ79aW56jsxMmef7kd6ilBzlOI522eslwWHgJE08
         WDtNajM5BKiVCjwruLCoTAtuSj3tR4Oq3maXvBzB84yxSB0IQzQ9qAdzOer4AwNl4wuL
         E2pQ==
X-Gm-Message-State: AOJu0YxLVMqm+lB8v5NUctfUZk4rDVdktD8fw8AeANrCgKuVCt7Qw1Fe
	lhjV+SRk/qTWtUGbzoBoKMc78dOXFM7eKPD47tZODYbGNwoSbG0c15U84KRxbM5FEyqMvuK37BB
	2
X-Google-Smtp-Source: AGHT+IE4QLorZ4CWvw/y1YDoU9HySlxvZA3auJxAwqwUnp9j4MyJHNIdj3d9CtdDKXdFabgW97yWXA==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr206117iob.0.1712850222230;
        Thu, 11 Apr 2024 08:43:42 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 431/437] pci: hotplug: cpqphp: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:31 -0600
Message-ID: <20240411153126.16201-432-axboe@kernel.dk>
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
 drivers/pci/hotplug/cpqphp_sysfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_sysfs.c b/drivers/pci/hotplug/cpqphp_sysfs.c
index fed1360ee9b1..234e7ab66660 100644
--- a/drivers/pci/hotplug/cpqphp_sysfs.c
+++ b/drivers/pci/hotplug/cpqphp_sysfs.c
@@ -157,11 +157,10 @@ static loff_t lseek(struct file *file, loff_t off, int whence)
 	return fixed_size_llseek(file, off, whence, dbg->size);
 }
 
-static ssize_t read(struct file *file, char __user *buf,
-		    size_t nbytes, loff_t *ppos)
+static ssize_t read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ctrl_dbg *dbg = file->private_data;
-	return simple_read_from_buffer(buf, nbytes, ppos, dbg->data, dbg->size);
+	struct ctrl_dbg *dbg = iocb->ki_filp->private_data;
+	return simple_copy_from_iter(dbg->data, &iocb->ki_pos, dbg->size, to);
 }
 
 static int release(struct inode *inode, struct file *file)
@@ -177,7 +176,7 @@ static const struct file_operations debug_ops = {
 	.owner = THIS_MODULE,
 	.open = open,
 	.llseek = lseek,
-	.read = read,
+	.read_iter = read,
 	.release = release,
 };
 
-- 
2.43.0


