Return-Path: <linux-kernel+bounces-140917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616078A1998
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C281C24849
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FED194C70;
	Thu, 11 Apr 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QnWIUv12"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4466F190675
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849755; cv=none; b=ellaDf14cj/F++YY+P4BVhvHL/rgqWZKgxZoU/C8v21d1DIL7hxu6zNP6ZXLFG68CDYiA2FdXoXPMg1cT6a08fUPhCpn9+6LhvrPzoh+sqJgxuMcNfNkh72jgDUV2skQjLFA6rmB6wNNR5lI36txDxdADdcos44erdnscMsmlYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849755; c=relaxed/simple;
	bh=oaXLa6obNeD7EDzslEqqEuxPOkRKSkrk2y72bWlBbkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qw7LxAAtnb7e7GPhaB2UWbpyXBGSbMLOnwb6DntRidA9m8+ui4JvNuflq3GvzCD1/A1Juz1gcvWSMxq804jAfKCylG0XsKpHYWalWbQ4Um1nxSjp2fZkeLKjN1As0LR6tJMbpifZkuvfNoRhLI0pvkDhDPf2trf+/xha5zI1Yxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QnWIUv12; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58063539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849753; x=1713454553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VIFDzXzmulpK99VEtWO5Vl4TpLAsVTHxAvD7CbNfrk=;
        b=QnWIUv12vk4DaS/H8RU/o9lKeOKqj7H8+f61KBbOs8ST5WMq3JqWe2LfhJL3q+Iner
         stSRpzIPRMRG4xipM5FjtXyDOZ70bJkzPxgUQY7WkqqRVeGto3FNm2HzDz5/jhKZ+Bh7
         23VWnitNofdBI8bA7v4Azc5MIBPMaLlrGzNvE8NwmxwVuT/TikvvjVc7mvrZRW8FxH05
         +FjOsUh+93KmoEQJMqEij6hBvQaqwSf4ENmNCdBkM+OiESGwoqSVAd0VyK/Bthz+sHZv
         cfRpSgv5e6ecsUggR+l8dp6C9ChJwVjL3fmTC7glIDlOwHUy7fseCopaSG0J2drn/X/a
         WPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849753; x=1713454553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VIFDzXzmulpK99VEtWO5Vl4TpLAsVTHxAvD7CbNfrk=;
        b=DHYzdHaxw8HSnqTTtnhu0xS2BbVQbNev0JkRoukif2MnltcYF6BO/S5Olr9BoysNLK
         FL2VqZF1F8c50RGmDl4l94r/er/ywBYYKRqYCgks/t+3qwYPUPEH7IZXkPmkrM8kBVT2
         cMXr+ur7PJbaopqyiKskPBE1YiYYqBAH/HgdqpKPZUX+ItQdZcpPTWUrFsaijodscUal
         9Lv87vdD209v05b1DYICIMGF/VXB8wTZEdpB6RQoKkor4NSlNFqf9sCgcC/pjm3j+2Ew
         d+18MO3Bc2JqMjQJijQHJ+sVDcmlN17zBelKIOLpqd2yn/IA7uTRBroKBMH6LWLFN/yj
         7Fow==
X-Gm-Message-State: AOJu0YxnSJl4h8Okw0lVESbBCNBOixps1bYmPOmVyzCjlHQz62VXDGAZ
	g9W+O2MgN7MejNyPczw2jCYxfJpJlSp+kkkkLabobmNecZq9B+PqkwmrEq8b4rKjYZW5w5SCauc
	j
X-Google-Smtp-Source: AGHT+IGMR2dt7eBUg9M2g0W6xwIHzZTkAKxX9HZgfK99RTKbYjOMOdqWkdMvgyqa6aw/noxKoMnERw==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr204260iog.0.1712849753160;
        Thu, 11 Apr 2024 08:35:53 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 150/437] vga_switcheroo: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:50 -0600
Message-ID: <20240411153126.16201-151-axboe@kernel.dk>
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
 drivers/gpu/vga/vga_switcheroo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 365e6ddbe90f..b7afc48ab39c 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -772,8 +772,7 @@ static bool check_can_switch(void)
 }
 
 static ssize_t
-vga_switcheroo_debugfs_write(struct file *filp, const char __user *ubuf,
-			     size_t cnt, loff_t *ppos)
+vga_switcheroo_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char usercmd[64];
 	int ret;
@@ -781,11 +780,12 @@ vga_switcheroo_debugfs_write(struct file *filp, const char __user *ubuf,
 	bool just_mux = false;
 	enum vga_switcheroo_client_id client_id = VGA_SWITCHEROO_UNKNOWN_ID;
 	struct vga_switcheroo_client *client = NULL;
+	size_t cnt = iov_iter_count(from);
 
 	if (cnt > 63)
 		cnt = 63;
 
-	if (copy_from_user(usercmd, ubuf, cnt))
+	if (!copy_from_iter_full(usercmd, cnt, from))
 		return -EFAULT;
 
 	mutex_lock(&vgasr_mutex);
@@ -899,8 +899,8 @@ vga_switcheroo_debugfs_write(struct file *filp, const char __user *ubuf,
 static const struct file_operations vga_switcheroo_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = vga_switcheroo_debugfs_open,
-	.write = vga_switcheroo_debugfs_write,
-	.read = seq_read,
+	.write_iter = vga_switcheroo_debugfs_write,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


