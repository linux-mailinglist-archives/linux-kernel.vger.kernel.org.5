Return-Path: <linux-kernel+bounces-141168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C358A1ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891211F22480
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1248F1F466F;
	Thu, 11 Apr 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kbmlCuHw"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106191F4FBC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850151; cv=none; b=lwzquC5WgpXtAVq8IW3Ti07pNaUb/WW3k6yM/Jb0Ed6DNGjK2jibBJtpuJnCoQ7vkl6p5PJlWEx68pzKgNJL6fmoICkKkRVocibSe3+or2GVcQfiYi4p8pNM63gYLdvZEU2iX1JyiY0KMJDzsHmwU33ufmq4gPEqdNUgfAQhM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850151; c=relaxed/simple;
	bh=p7WctMMlRWAdNTE5fVv6wre2OmE47Vk1NhNg4CBgEmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klofzsIXSY0SfljlKy7fCFKHNVQPSUcQhFo9BmT05d6bz/zh8BM0EEGeiS0152fj+X0gWom5VbA2Romkkm5Wg0rO3y80TZwzZImQ78KiFnCwN4kr67a8sIkigZ3y18QkhryQB8Gr2McrmbAjOO5VmvQJtq2NrgPcus4LUvwWTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kbmlCuHw; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9933039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850148; x=1713454948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE2I3/W/bjcYxnc4E8ZkJcIASksO6YWQlrWRDVCmGeU=;
        b=kbmlCuHwaadVLTlGki8nRKiSq/LUS17l1Ri9aUtCzupcczQS25mL4yUyT9MSQpGR6C
         Z5bPgaVoQoI2iYpV+Q/m4CvntLUJ4P/UEVmJ+q7xtNmYr+EEvvJktkxnOL6Sb+CBN8Ry
         30VlDkkQBQ2rQWNEvwtNqctcxwXskeu3bShu3T4gfw38eDkOXDeIlSUaEwKi3Aw4FVpZ
         j6CXyRWR/Yyp0F0lefNYR9mYyajLaTpsyzFlX1oLO6yk3lY472VD/etNGXEv9fs142bn
         QGxtY2sAYRPg9eYAts+VHq0fRs7eSksY8l2kNKa3/ZQN2GYDb03AgfUvQaojrQ38ZkEP
         owaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850148; x=1713454948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE2I3/W/bjcYxnc4E8ZkJcIASksO6YWQlrWRDVCmGeU=;
        b=JQPBfeesmdB/F42ONn3J4AviQB+6lBzyI7NVhmHQseoiqzNqBqLIDreWlKf/CEKLGF
         oTJMBAtgtbCPc0BLFm8y1P5n9sqoC8/SAoH29q9Bja7DQsJPiHc/kCiMA5kvGt4f6z1+
         c9ZyAfPzrKDlckGNdZIEKjrazIBpsBiPShQRS4MovYRe9hXfNX+DjagKe79likru9fsu
         RgoaE7/wPCbrsBYKrBdHeWFxZDfWMc5oaGITQEwu4hnmxjrk1NdzweRlHv8t2a4H2005
         CAlQgCwzjQPytOd8J6IXhVZxtfx/dexY4XXLxWG2LcygzCCDpqoGwMZkOwxHuFwGF3l2
         eA0w==
X-Gm-Message-State: AOJu0YypKRbiK1wF/4wKyNieJmaSvneD3EOpI+fWhmzh28DE9k1Emf16
	PFE4SW2sdkcqMcCkN5aWKTxlBNOpoW8avlS+7OS/tGWPEaJI+uePsAqtTcTSeWUVVL5cy93+BwL
	6
X-Google-Smtp-Source: AGHT+IHAJsov8U6CuMQNiOy2a4pMXy8XEU9tTAyFifxKw0xmawEYZk7u7YMT5fEeNl3bREyVG6redw==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr209308iop.1.1712850148360;
        Thu, 11 Apr 2024 08:42:28 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 386/437] EDAC/versal: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:46 -0600
Message-ID: <20240411153126.16201-387-axboe@kernel.dk>
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
 drivers/edac/versal_edac.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 1688a5050f63..bd3abd3598ba 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -781,16 +781,16 @@ static void xddr_inject_data_ce_store(struct mem_ctl_info *mci, u8 ce_bitpos)
  *
  * Upon doing a read to the address the errors are injected.
  */
-static ssize_t inject_data_ce_store(struct file *file, const char __user *data,
-				    size_t count, loff_t *ppos)
+static ssize_t inject_data_ce_store(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct device *dev = file->private_data;
+	struct device *dev = iocb->ki_filp->private_data;
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct edac_priv *priv = mci->pvt_info;
+	size_t count = iov_iter_count(from);
 	u8 ce_bitpos;
 	int ret;
 
-	ret = kstrtou8_from_user(data, count, 0, &ce_bitpos);
+	ret = kstrtou8_from_iter(from, count, 0, &ce_bitpos);
 	if (ret)
 		return ret;
 
@@ -812,7 +812,7 @@ static ssize_t inject_data_ce_store(struct file *file, const char __user *data,
 
 static const struct file_operations xddr_inject_ce_fops = {
 	.open = simple_open,
-	.write = inject_data_ce_store,
+	.write_iter = inject_data_ce_store,
 	.llseek = generic_file_llseek,
 };
 
@@ -845,19 +845,19 @@ static void xddr_inject_data_ue_store(struct mem_ctl_info *mci, u32 val0, u32 va
  *
  * Upon doing a read to the address the errors are injected.
  */
-static ssize_t inject_data_ue_store(struct file *file, const char __user *data,
-				    size_t count, loff_t *ppos)
+static ssize_t inject_data_ue_store(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct device *dev = file->private_data;
+	struct device *dev = iocb->ki_filp->private_data;
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct edac_priv *priv = mci->pvt_info;
+	size_t count = iov_iter_count(from);
 	char buf[6], *pbuf, *token[2];
 	u32 val0 = 0, val1 = 0;
 	u8 len, ue0, ue1;
 	int i, ret;
 
 	len = min_t(size_t, count, sizeof(buf));
-	if (copy_from_user(buf, data, len))
+	if (!copy_from_iter_full(from, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -903,7 +903,7 @@ static ssize_t inject_data_ue_store(struct file *file, const char __user *data,
 
 static const struct file_operations xddr_inject_ue_fops = {
 	.open = simple_open,
-	.write = inject_data_ue_store,
+	.write_iter = inject_data_ue_store,
 	.llseek = generic_file_llseek,
 };
 
-- 
2.43.0


