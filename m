Return-Path: <linux-kernel+bounces-141195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75058A1AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4487B1F25CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0071FC9F8;
	Thu, 11 Apr 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="D+N3v4dY"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47621FBC27
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850191; cv=none; b=RUcL8mLHd+6rPlq/VgOMLSHjlPATHiRlsli6ndo78JaXZoZjv6DRGd1Vlj5n0x/UJzSq9+bRlp/JQ0vPDWehtwBF1IhtwNUH5UE08QmE5+IzwuvBIz74wp+gk/03riZ24BlPknan8F45sJKcdVnbPFQydKGBQlr/u1lqGEpUpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850191; c=relaxed/simple;
	bh=O5/25u3M0hLBhAldisL5jWU5tFnGtfchd3XWmQPUvDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6FZLh3o6o0k2vIcQi4BcnMYFOCaulaNcBOqp5az2m6vYYqy2BxtHwlcz+Hr3JbCgvws9lUfuEKytMVmwUc1elXoZtCt7U1tW2zaKhYnYaGzgGX0OaZRXeK1OvJcYv7Qd3qW4a0ibe7m3DbWOfGv3vBn/CoYG523uMRo0rv4W/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=D+N3v4dY; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58280239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850188; x=1713454988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5S1f4gpbGHboTPY4NXCFhAAb64BXO4SSHJif6cAnVA=;
        b=D+N3v4dYBmvJPZoARvS8jNo7Zsyii+vwd7qYEKscHInAlXBeW62vee2Gh2Sz1S2eSx
         Vb24EpGjtKiMpwbyh211P/4cs1NnAyjOalqJSj0n+vJVu0WlUfn+XJYxCHZ95NYCJ9ZJ
         W50y3s0CMYgiBanhcFDTy3NWHFLSbMPl97azcyg0jxXuINLizKSxAEsK/9zN4N4XtG/4
         iWo4bXT6I76iPRUqnIMlEvZAS1zImB0hOuS1bqGzRhcm4przeoS5JyvOPnaaF44bzDo2
         f7kMlUHKQTzPlKUhUcYpJMCCnFcA7zHyZTmgJ+meodBMuHk73j2+rvnmjnWWMUFCcagh
         tyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850188; x=1713454988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5S1f4gpbGHboTPY4NXCFhAAb64BXO4SSHJif6cAnVA=;
        b=ia0HUkTRL6Tag1SP4MJlpocj9ndNgCL7jHcxd1Ic/zlCAn8hDCyOSvtho47ykvZBV6
         atGld1i6EzV7hFEOi1urE8WpmRkxD3OL0i7zp8QKhnFlxXNCFUXqPGEjnALmymxO6pve
         AyeqseM+m8ujkuP0je4R7jvt5FKyfaoONPXnUlRdSNQlFZJTgFilIZrxeGRr03GGebag
         eb4VuPZsk3DeTWBjAO/th23JReJlmfvCnqv8OGqUZ/n/I+9E9LxmArL5dqGNlQ928K5N
         mOqp/nipGnItoFVQrppZLpl/sTOZVztMtUJ3ypSLgcGufwZFN9R+9EFkG5D9HkZNWDkg
         2JjA==
X-Gm-Message-State: AOJu0Yx+s7kkg75UboLWlxNwcopbk7ovxQ4wF0uqbZUsgKCA2jt7N6zz
	otjNV8LFXuJeh5rt0+D34FgSViS1KFh6ucDVblj0HN9TLV24kZrDYrCKX0GETA3MkwVmnKwcsxe
	0
X-Google-Smtp-Source: AGHT+IGDiK6C2xJCTBS1vaje9Id5fA3wSFd69wzCpq5hbnU4HfuAuUUnPVyAmZkAizzn6nUanuegJQ==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr180873ioh.1.1712850188629;
        Thu, 11 Apr 2024 08:43:08 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 411/437] infiniband/usnic: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:11 -0600
Message-ID: <20240411153126.16201-412-axboe@kernel.dk>
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
 drivers/infiniband/hw/usnic/usnic_debugfs.c | 22 ++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_debugfs.c b/drivers/infiniband/hw/usnic/usnic_debugfs.c
index 10a8cd5ba076..7383b0131cd4 100644
--- a/drivers/infiniband/hw/usnic/usnic_debugfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_debugfs.c
@@ -42,13 +42,13 @@
 static struct dentry *debugfs_root;
 static struct dentry *flows_dentry;
 
-static ssize_t usnic_debugfs_buildinfo_read(struct file *f, char __user *data,
-						size_t count, loff_t *ppos)
+static ssize_t usnic_debugfs_buildinfo_read(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
 	char buf[500];
 	int res;
 
-	if (*ppos > 0)
+	if (iocb->ki_pos > 0)
 		return 0;
 
 	res = scnprintf(buf, sizeof(buf),
@@ -56,29 +56,29 @@ static ssize_t usnic_debugfs_buildinfo_read(struct file *f, char __user *data,
 			"build date:    %s\n",
 			DRV_VERSION, DRV_RELDATE);
 
-	return simple_read_from_buffer(data, count, ppos, buf, res);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, res, to);
 }
 
 static const struct file_operations usnic_debugfs_buildinfo_ops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = usnic_debugfs_buildinfo_read
+	.read_iter = usnic_debugfs_buildinfo_read
 };
 
-static ssize_t flowinfo_read(struct file *f, char __user *data,
-				size_t count, loff_t *ppos)
+static ssize_t flowinfo_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct usnic_ib_qp_grp_flow *qp_flow;
+	size_t count = iov_iter_count(to);
 	int n;
 	int left;
 	char *ptr;
 	char buf[512];
 
-	qp_flow = f->private_data;
+	qp_flow = iocb->ki_filp->private_data;
 	ptr = buf;
 	left = count;
 
-	if (*ppos > 0)
+	if (iocb->ki_pos > 0)
 		return 0;
 
 	spin_lock(&qp_flow->qp_grp->lock);
@@ -100,13 +100,13 @@ static ssize_t flowinfo_read(struct file *f, char __user *data,
 	}
 	spin_unlock(&qp_flow->qp_grp->lock);
 
-	return simple_read_from_buffer(data, count, ppos, buf, ptr - buf);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, ptr - buf, to);
 }
 
 static const struct file_operations flowinfo_ops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = flowinfo_read,
+	.read_iter = flowinfo_read,
 };
 
 void usnic_debugfs_init(void)
-- 
2.43.0


