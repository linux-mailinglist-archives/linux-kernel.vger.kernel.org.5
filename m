Return-Path: <linux-kernel+bounces-140815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFAF8A1913
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9267128145F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C12C2941E;
	Thu, 11 Apr 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LPsPlZfk"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729B7829B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849597; cv=none; b=k1ZC5lQJH+lQIS1nr9BFaTPdcQnYeb2Csi+KdAdpgxOOR0QHhMsS8r9RuikaWQgOUdg6EF3UtQsy5Z2v4LsURyE6Fah7uhUsIu43RndcKxK4jo3kfphK9U2gGSG1HPSn3a7T0PIczxZdfpEqMbwOOGOue1dZC9rEEpdJQUNzCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849597; c=relaxed/simple;
	bh=8K4iFByLNkEJg0ZtGD/zZ1ImWA2HssKe9G+FnNpX9so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=in3o9u3kvP3uLt/M15nk06YnKplbDaSAm/nKrD/lwMGPutTWZueVY6M/sVP9Shk0yMQYJlVC8/zGb33a/1zM8FF1h/oFHR7oUNCy2pKqFhiItM0/c0z/rCYsQtonDntQu9GIZD9azKL3WSIRd4XfOgJVIpyYBho/UOGwzB8KQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LPsPlZfk; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8878239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849595; x=1713454395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvmWkjrTymk6TvKQAkDar3sgVevVFpz9szIkUav/6CQ=;
        b=LPsPlZfk5ywn73XvgonzCSh1AJfVCOtEZTB51vT1O/2Bs3Y6BqqSeMkfRRWCI8YFUS
         iZJFNeVo6AAhFBuKgcFyTem80YNM4/+4Pgd8ni5iMi08DEdM8sJ7Fh9oWChgZErH33zA
         AYl/halzXacyr+wlr3szsYJ+N8qT3HktAEpaKSR65hKBMLbUlt2WHxXrP+Vvb6o+u7Ir
         RdhiXNzdShne9bMEmrw5O7XTG/+KRfrqufJ8GcjAfr8p1Qx7MIwTbo/PoTh8/8toegYn
         RvdtswSShwCM/LFNLG1JIEfXWjBx+ZGYpWTG4U/mohpv6FFHrrP3X+uQFG6U+1lRAaH0
         GSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849595; x=1713454395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvmWkjrTymk6TvKQAkDar3sgVevVFpz9szIkUav/6CQ=;
        b=gbE8Knzymodj/a6SU2vMR+prC/seWu1vj/mvumRXyIewM28pqCDZPfdGiurkxCLe75
         XfjIiuSRri6hpqC0h6FBI/JSdKuPP13Rk3Vp+D2qp6DBAeTscuzKNp4etzyDvXPLzSG8
         VjgbnM7vRYlZvQ62sWgj8a5b+8aET/RAysnhBMS47ZoBdQ3cbC5Jf2u0PXolpRzPOezo
         YxueJwKhEHpJxE4mM696DFUgYyk0nSjplp/+bZoXhlWsSBfO9JzAANlCtfgELxkyjYyT
         +T5SPE2Xc3j6k73CMp93f2XACfyBhhE091dxhUuekg+regO1Skpea1HnWGWoDuPdOedm
         MJSg==
X-Gm-Message-State: AOJu0YxsRHgvd7Bd+6k+drOYS8vmK7Dul3o0Kpl1zEjZnYhYeXVaQA5W
	/aazkPZvQ6hgIKB3juuGa78TahwKWnr+dVhRp7aT53lWB6XppiG9JCbwybQz3tXVi7NeDKi5nMn
	i
X-Google-Smtp-Source: AGHT+IHeEJih2Bol0NMGj7Zi6DBozwcad9GW7KCufZs1lijQ748DynHFcHwgvnvtGQUpYilBjjprzw==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr172554ioj.2.1712849595003;
        Thu, 11 Apr 2024 08:33:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 055/437] net: wireless: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:15 -0600
Message-ID: <20240411153126.16201-56-axboe@kernel.dk>
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
 net/wireless/debugfs.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/wireless/debugfs.c b/net/wireless/debugfs.c
index fd4509acec37..014bacd8f6a5 100644
--- a/net/wireless/debugfs.c
+++ b/net/wireless/debugfs.c
@@ -12,19 +12,18 @@
 #include "debugfs.h"
 
 #define DEBUGFS_READONLY_FILE(name, buflen, fmt, value...)		\
-static ssize_t name## _read(struct file *file, char __user *userbuf,	\
-			    size_t count, loff_t *ppos)			\
+static ssize_t name## _read(struct kiocb *iocb, struct iov_iter *to)	\
 {									\
-	struct wiphy *wiphy = file->private_data;			\
+	struct wiphy *wiphy = iocb->ki_filp->private_data;		\
 	char buf[buflen];						\
 	int res;							\
 									\
 	res = scnprintf(buf, buflen, fmt "\n", ##value);		\
-	return simple_read_from_buffer(userbuf, count, ppos, buf, res);	\
+	return simple_copy_to_iter(buf, &iocb->ki_pos, res, to);	\
 }									\
 									\
 static const struct file_operations name## _ops = {			\
-	.read = name## _read,						\
+	.read_iter = name## _read,					\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
@@ -60,11 +59,9 @@ static int ht_print_chan(struct ieee80211_channel *chan,
 				' ' : '+');
 }
 
-static ssize_t ht40allow_map_read(struct file *file,
-				  char __user *user_buf,
-				  size_t count, loff_t *ppos)
+static ssize_t ht40allow_map_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wiphy *wiphy = file->private_data;
+	struct wiphy *wiphy = iocb->ki_filp->private_data;
 	char *buf;
 	unsigned int offset = 0, buf_size = PAGE_SIZE, i;
 	enum nl80211_band band;
@@ -84,15 +81,13 @@ static ssize_t ht40allow_map_read(struct file *file,
 						buf, buf_size, offset);
 	}
 
-	r = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
-
+	r = simple_copy_to_iter(buf, &iocb->ki_pos, offset, to);
 	kfree(buf);
-
 	return r;
 }
 
 static const struct file_operations ht40allow_map_ops = {
-	.read = ht40allow_map_read,
+	.read_iter = ht40allow_map_read_iter,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
-- 
2.43.0


