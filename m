Return-Path: <linux-kernel+bounces-141097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 422058A1A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F19B29C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446D51E2455;
	Thu, 11 Apr 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mUp+fQcG"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C8C50280
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850031; cv=none; b=UJUVmY2jqB3dZ+wr8E4flx4eqWzO8Net2Vl3XsdEJsf10bqnLyFFytOmjyzF52c5Ud2CU1Nrw8ERNQse3mJLJ7/Zsuop/zJqbGVe0TgbGpoDS2JQ1a2jnSXoHWevl3uaElLZv5AKJ4VN4QoafKN1pBdsH/t5TjLPkzCtdpbEKIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850031; c=relaxed/simple;
	bh=ZSbWnKtEB3iUPA46pZTGEkLHYuEn8/MjHsxaJVHhMTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLRjDHFTMrIbmslb0Tlcx3jAlULwnXgPZTJWyfMsxROlvwFSZOTRJsSY2GVxv+umrZoE9s6nCiT0Rig36ryc00lKJokbbCy9TzXHEtAiy1j1k4V/xd7VcukzQOP0MK0Q8GpK2I+rdfcE63Bmoa61b0zt5lelZkyWVDSfHtvfax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mUp+fQcG; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36a34b68277so118685ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850028; x=1713454828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PklJoG+dHcGyORAfKU6STIZs7i0r1PiGXnTWAdv9t5M=;
        b=mUp+fQcG53aUA87/jYVwxAyTacXv1kwjSgCpkqXVh6X9srRlriq5o8d+ns2J0tF/vR
         cXNMLWxsVyWJ+NDSC2gtYeGOh2F9xCRCY8bnPbjGrVcyzdE8AhHY2cY2weQlT5tToPeB
         vK+RwYZJ2Kk6K74qwqzG+9F2kEffUEVJMkzoDAWnxVTYjUROgkFgg/kp8xjxFWNdv7/x
         mhNMdiEXMmlNjK4KPrvVlnyqR4E2a13LJtceoD7ae/M5izP89HH+oNUNJ+iZ6bAvqx9P
         iY+AKhovN4u3uQFA3BsBgvEmELdvsMyN+iW6MCI23IzZU+cbQDBN92Iq+qGxxiGht5HU
         tAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850028; x=1713454828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PklJoG+dHcGyORAfKU6STIZs7i0r1PiGXnTWAdv9t5M=;
        b=cWSW5nGvp2VyuiQAZV9kXCBcSz5ab260rQDSahAYE8QScOQi+JDcIAilvxwDF8+d2D
         ZVkYDSPQ1EtrOfAVKp7YHfQoAM7eKmqjdNEmOUm9W4lA/Ms7LOZC65KTeynJ6UgWRvYD
         msTNu6+qTYqbWUMhkf831qQHVnIBRDzwu+mINfngNTvOLIH3Bs7rXjCSx5OH2fqS8VGv
         6eqD9ptaB2yTLBuVfv0CFNk4TAoo2cj4Ic72iv5Fnf3GNkeSGvVEDv9qAfm+3giHsJfO
         rEKtq8voX7qZtQZ4xb31n290joyr99hGWiK/7krbSO3dfP3jITVV94EfhiRf7SL8Nzvc
         s6og==
X-Gm-Message-State: AOJu0YzcDoUKbX2o1tr1d1EIbbvBb/Fz4xqyFEcvccuKmqBmyVouBftS
	Lh7dNKjre/UAA84RRmVMARPKzcDQI3XvKpNT51KpswbB5DdU7SemKqUrvZUVOiuZuhj+0phZuoP
	Z
X-Google-Smtp-Source: AGHT+IFg8f83mqjYAntkAffdqJm5V5aD21G9tKORlExgHKQQsWaiEVMZfvDaYqC0V25bfmgBloxfjw==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr198422iob.0.1712850028670;
        Thu, 11 Apr 2024 08:40:28 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 319/437] drivers/net/ethernet/broadcom-bnxt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:39 -0600
Message-ID: <20240411153126.16201-320-axboe@kernel.dk>
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
index 156c2404854f..777f2e892869 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
@@ -17,15 +17,14 @@
 
 static struct dentry *bnxt_debug_mnt;
 
-static ssize_t debugfs_dim_read(struct file *filep,
-				char __user *buffer,
-				size_t count, loff_t *ppos)
+static ssize_t debugfs_dim_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct dim *dim = filep->private_data;
+	struct dim *dim = iocb->ki_filp->private_data;
 	int len;
 	char *buf;
+	size_t count = iov_iter_count(to);
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 	if (!dim)
 		return -ENODEV;
@@ -50,7 +49,7 @@ static ssize_t debugfs_dim_read(struct file *filep,
 		kfree(buf);
 		return -ENOSPC;
 	}
-	len = simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
+	len = simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 	kfree(buf);
 	return len;
 }
@@ -58,7 +57,7 @@ static ssize_t debugfs_dim_read(struct file *filep,
 static const struct file_operations debugfs_dim_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = debugfs_dim_read,
+	.read_iter = debugfs_dim_read_iter,
 };
 
 static void debugfs_dim_ring_init(struct dim *dim, int ring_idx,
-- 
2.43.0


