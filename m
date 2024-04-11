Return-Path: <linux-kernel+bounces-140949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC638A1A02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7B6B2A2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABF121C180;
	Thu, 11 Apr 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xIuHu5hP"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3E2101B3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849805; cv=none; b=f3GNHMOzNTxQ8BEOK5ZxUt72Vcne0P/VTg3yXv0sxO2ZPf6ZhlUlMqfL+1pDvtNdtb72HMtJX+cq05ThaTbnAndnbYgCPaN5M2wAglArJNZRNgOZ+UX/26kd9tDlPL41LKlaYVqAfqMN2C0vlrO4H4Q20+jc3arSokWVxABZ9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849805; c=relaxed/simple;
	bh=pyvYWWGUyjKMAk/AcOSdEVAaBBpYfumBGfWTAKnEFSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOyQ5pQtYVs6BSuLVPQTG3Rg1BYOdmloy4BDoeehTx7FOTD2T+nhHJ9R5K1cae7hBk3PnIqAqY5Aq/KNYyzBGDb4jqiRizuflhhr6qG4j7I44IGh7uwn7HxFovPKiMMvsfpu8RqGHKbUWt4WNjBxcKN2X1Q3lgG04vIuJ+f2ipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xIuHu5hP; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69580039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849803; x=1713454603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKA2d/aP6YRdYPNLwp4fx6i6jJCH9DtxdgR1kae3vbk=;
        b=xIuHu5hP7ZDKOuiiIqnPF3mnGrIwPm92hU2OH+raqnFMbXxy9L3ILRIrZHj0OnTc8N
         YMAIVpto7ED2I6xb7r0rVCO54wteQx2N4ZrRarqiZILMSlLCHRaCJaYJYRm6kE3A9M1q
         hQMCuRDHx/uAsga0KWzv6ZB5SLGdQ5EHHRQbuA5cLzcs8evxYP861pMT9O1RT4TppuEk
         bJao3bidys0A6oCSsuumTCsB6fgNSi8THYqyp14mXyYnx/2XrLwZzKgYD8qN9Vkl69Xi
         n2KFJKBYLkVxtz6svB0Muq8K0S4DL9iPZwrTHcsZyq972i3nOHt98qb3GSTKmf6kvcpn
         19nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849803; x=1713454603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKA2d/aP6YRdYPNLwp4fx6i6jJCH9DtxdgR1kae3vbk=;
        b=ZXoPoAHiigs+a5hGAMJvWVPLiuOsYxLotgdEifHxqBwq6IsFXvI6ab5coQ+V4qcSFZ
         h1P2JHmdBQtadDz1HheULtmW2CH8wv5ROTcM/dPHuMx0syqvQP5l2I3SNtDgTjc1JYw8
         JSEbHXdCTYtyiHXysLsfXoCiYY7kBkxv6N1+Z15dZEu4MB9WTFFgIQUbuC0CXb/f6MvB
         XIiGqxmSto50vqI+9N+KbisMfFyR1qC8eDQIEMyPeBfzxp8eFDa8M/V+2NODL9eHNDKY
         /wfMRG0OE3f2GN9o+kZKEUJCyCDf/03m8CgHu7/+OyR4xJwaaxXsJZHc6ZbDcUm5KOYh
         mG8A==
X-Gm-Message-State: AOJu0YxktsTTbmH0TxVaASitDN9EBs+BSz3HC2B0Htl2P5qVR1DD3EkD
	QOQY0EyanGBXsbPCnACMsAdpYYQnGFwSJJHXtdb6lTz9Pn5ljbdcrvqtV7Te8LNSQxqlTJ6esUh
	d
X-Google-Smtp-Source: AGHT+IGBYVgA+CRyZYc1vhEASB0uOlHIAl4EMw35fkcKYfaTffCPX5bWT3S3pePOhPU9ubf7C3tCHA==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr218896iof.0.1712849803358;
        Thu, 11 Apr 2024 08:36:43 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 180/437] drivers/phy: convert to ->read_iter and ->write_iter
Date: Thu, 11 Apr 2024 09:15:20 -0600
Message-ID: <20240411153126.16201-181-axboe@kernel.dk>
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
 drivers/phy/mediatek/phy-mtk-tphy.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 25b86bbb9cec..8c57e2d89415 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -448,19 +448,19 @@ static int u2_phy_params_open(struct inode *inode, struct file *file)
 	return single_open(file, u2_phy_params_show, inode->i_private);
 }
 
-static ssize_t u2_phy_params_write(struct file *file, const char __user *ubuf,
-				   size_t count, loff_t *ppos)
+static ssize_t u2_phy_params_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	const char *fname = file_dentry(file)->d_iname;
-	struct seq_file *sf = file->private_data;
+	const char *fname = file_dentry(iocb->ki_filp)->d_iname;
+	struct seq_file *sf = iocb->ki_filp->private_data;
 	struct mtk_phy_instance *inst = sf->private;
 	struct u2phy_banks *u2_banks = &inst->u2_banks;
+	size_t count = iov_iter_count(from);
 	void __iomem *com = u2_banks->com;
 	ssize_t rc;
 	u32 val;
 	int ret;
 
-	rc = kstrtouint_from_user(ubuf, USER_BUF_LEN(count), 0, &val);
+	rc = kstrtouint_from_iter(from, USER_BUF_LEN(count), 0, &val);
 	if (rc)
 		return rc;
 
@@ -504,8 +504,8 @@ static ssize_t u2_phy_params_write(struct file *file, const char __user *ubuf,
 
 static const struct file_operations u2_phy_fops = {
 	.open = u2_phy_params_open,
-	.write = u2_phy_params_write,
-	.read = seq_read,
+	.write_iter = u2_phy_params_write,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -574,19 +574,19 @@ static int u3_phy_params_open(struct inode *inode, struct file *file)
 	return single_open(file, u3_phy_params_show, inode->i_private);
 }
 
-static ssize_t u3_phy_params_write(struct file *file, const char __user *ubuf,
-				   size_t count, loff_t *ppos)
+static ssize_t u3_phy_params_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	const char *fname = file_dentry(file)->d_iname;
-	struct seq_file *sf = file->private_data;
+	const char *fname = file_dentry(iocb->ki_filp)->d_iname;
+	struct seq_file *sf = iocb->ki_filp->private_data;
 	struct mtk_phy_instance *inst = sf->private;
 	struct u3phy_banks *u3_banks = &inst->u3_banks;
 	void __iomem *phyd = u3_banks->phyd;
+	size_t count = iov_iter_count(from);
 	ssize_t rc;
 	u32 val;
 	int ret;
 
-	rc = kstrtouint_from_user(ubuf, USER_BUF_LEN(count), 0, &val);
+	rc = kstrtouint_from_iter(from, USER_BUF_LEN(count), 0, &val);
 	if (rc)
 		return rc;
 
@@ -624,8 +624,8 @@ static ssize_t u3_phy_params_write(struct file *file, const char __user *ubuf,
 
 static const struct file_operations u3_phy_fops = {
 	.open = u3_phy_params_open,
-	.write = u3_phy_params_write,
-	.read = seq_read,
+	.write_iter = u3_phy_params_write,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


