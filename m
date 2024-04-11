Return-Path: <linux-kernel+bounces-140948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3118A19C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6221628925D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1512101BB;
	Thu, 11 Apr 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n5ZGFDYx"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C936E21019D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849804; cv=none; b=Ip21KAtp5MeTndPHcqsMFKkgQsN82NPCF6En4Ai2mkbBQ2b86kS+QIiKgMOO83rzzcnc4IYwJ3y3nbfSrZult9PqDXMn1ey74aldoMeOIbcFDHmpdytlIj1f/Ji11mVtAj2KXgoGkTfEeih3vXNZjisRcZbZFsHkEy7kp6qfPss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849804; c=relaxed/simple;
	bh=vQqCsWx37c5fXoCKUup/UXJIYpBCTnV991TQMSFc2Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQ59/gjGtO4XrHxAEiDoW2mQTcYoh/0zk7+jXsPv7L2AG5DplgvvqaI3Rn1HdoZa16d52yy/676qboNu9JY4MWEryfFRnMht9Huhz3JD6LP/r/1IUMn5QUCi4NF3AotjkuCncuYFMGLQ8JyZ8q02O1TH5bXeXBal608dZ8hnr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n5ZGFDYx; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170526839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849801; x=1713454601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAMZb6K9t6m8t6kq1K6RlDLh4PdtnN/Ec68bkSjA/gc=;
        b=n5ZGFDYxQdeSjeHHkQMAl5URgKsTw9HFOWt0ffrTbnrn00cuVXwsO6Zg/hVQPbGzGz
         1YUG5e95tn/HjfcTjd+KF8CqFyTAPCU5tf0R5bUyNJErU09jide0Uc+3TreAfOur7tap
         hrvAs4bonpihqoZXr+EgMZDOLGc/NE27QJQF+GxOrXZdh7Ilj93sDLBXIR5INLCq0bhZ
         v26wpkomYhLoNdoOJuVGdOePGKD0Mg+Xi3AzxEHrB5M0pGXo6MKfG6Dx1boQNxTyKw7Q
         kMDhKHecQV+QcIlR/TM18QjEeZS55LE0n0xuML8W6EAxXhR7jLCr//z2+R9LM1l/2wtc
         qVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849801; x=1713454601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAMZb6K9t6m8t6kq1K6RlDLh4PdtnN/Ec68bkSjA/gc=;
        b=ohP6zBffWNUHkOb3fHLoP8O9k41VMy/ENZxeqV4XSnWn0RdlMcSugCX9U/LiCyGrKU
         BAMVgKshi1Mdx+nlpomxgD2IQb0WkNhbaGmUO8X4zZNnBfBovRpCYbDvjAxv6XwlSLQs
         os8QE0+qAY7+JwyObNkubZSDWsBAB0rpyAfUpfpPDVvuaHzsfKiqvAcsE4ZHt348KsJV
         k0JtT9orh6W9gPQT74BcdcBiN8pMQVURK1SR8RDJ5jKV3huczRwRyR+8BY7Yqm7+NNe1
         XPY1+d4CuSIp2r9zHCBx+iwtPiDTojpGyhJoF90f7VhBIjYgYN3P9OBI25KUofEvLqLx
         v/IA==
X-Gm-Message-State: AOJu0YwZEnYgBNVCDuMG4EP7O4MvPEkgzW5krKiGd1xb2sa+sUcP8aDy
	sMEMo8f4RXehP7zSz9OzS4loHH1s2OW+v6e1JKsSVwPYkoRpLGJ86hXzvhLWzL8XTzhczqMGipr
	g
X-Google-Smtp-Source: AGHT+IGlcCG9WnQUNyIVo5ahNBsCmZpnmq/oTZS0DUZ3QjKAR7lpccts65dCfm+U7Ls7LzQBU332Ug==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr223206ioh.0.1712849801382;
        Thu, 11 Apr 2024 08:36:41 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 179/437] drivers/pinctrl: convert to ->read_iter and ->write_iter
Date: Thu, 11 Apr 2024 09:15:19 -0600
Message-ID: <20240411153126.16201-180-axboe@kernel.dk>
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
 drivers/pinctrl/pinmux.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index d924207d629b..c7b229d76d7b 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -675,18 +675,18 @@ void pinmux_show_setting(struct seq_file *s,
 DEFINE_SHOW_ATTRIBUTE(pinmux_functions);
 DEFINE_SHOW_ATTRIBUTE(pinmux_pins);
 
-static ssize_t pinmux_select(struct file *file, const char __user *user_buf,
-				   size_t len, loff_t *ppos)
+static ssize_t pinmux_select(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *sfile = file->private_data;
+	struct seq_file *sfile = iocb->ki_filp->private_data;
 	struct pinctrl_dev *pctldev = sfile->private;
 	const struct pinmux_ops *pmxops = pctldev->desc->pmxops;
+	size_t len = iov_iter_count(from);
 	const char *const *groups;
 	char *buf, *gname, *fname;
 	unsigned int num_groups;
 	int fsel, gsel, ret;
 
-	buf = memdup_user_nul(user_buf, len);
+	buf = iterdup_nul(from, len);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -758,7 +758,7 @@ static int pinmux_select_open(struct inode *inode, struct file *file)
 static const struct file_operations pinmux_select_ops = {
 	.owner = THIS_MODULE,
 	.open = pinmux_select_open,
-	.write = pinmux_select,
+	.write_iter = pinmux_select,
 	.llseek = no_llseek,
 	.release = single_release,
 };
-- 
2.43.0


