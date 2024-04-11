Return-Path: <linux-kernel+bounces-141200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FCD8A1AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497971F269F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395FF1FE08E;
	Thu, 11 Apr 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RNj+MACZ"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D71FE06E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850199; cv=none; b=Szja1lTTzzM0foPo2DQ58Zb5MaE4/K+Ip45rBtrAV7p3n6osGNquEEsem6MRdGc0eMglJsCtdJFwY6Y9W8a6bp9gPMd8h9RS3hBoKCavD2siFHtKEO5Mb11UbF9Fef/KBzMwtLcPdmh/6mzQ3sOkIrxgJAwycys+eQIW+j3iU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850199; c=relaxed/simple;
	bh=NHBw/9/ROJ6V5PiUZXpvKYZp1j6w+cgCgjaOlmrOcDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAtYhms2p9IZoAOe//s8Xb5+S4MiqDhk4+UxYrEjI2QiXeRffT5cpv8s4v2TAy416xUeVbkloTZnEOj89GsrKFMdFZZ7Z/I+e6aRV1BZ87dfSlMO29775WLhyI12lua1eCTdL2uWgkNCGeutGrd4+k29Q/PrMKyftHyeO2D07DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RNj+MACZ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36a34b68277so124885ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850197; x=1713454997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmx6EoPvOpnZ1mWnkOtiZZUNK9XDRnpmps8Fo4ojJlQ=;
        b=RNj+MACZi2aKO9V5mMnaHD2hi3dVEPOxnNY72MSs8UyY4R3KUjySD7uVOQhmhAXke8
         eCliAmcPE3UaiVnMOwPRbcYRY4ni5xAs/U96phsjZldBEW/jHG2OZSjskcvvhQ+R4+v+
         71PXLTzlR+8qjhaLJSmKmrXmZENVt+hixRJGWQ1rXAlkqMEPvmkDEtSefreBjF4OrcVS
         BS+8K+4F6r7GOn3k2wkVCoqf9fnly8ac6zvXALlNukHi4LWTMENjgX1PpPMDo7XwXulJ
         jmgtIpJ+Wxcv113H531pmMSv0zH5SQI6JYRHPG9+FP5VQzr/2CuG/iywW/MnyRbR1YV1
         XKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850197; x=1713454997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmx6EoPvOpnZ1mWnkOtiZZUNK9XDRnpmps8Fo4ojJlQ=;
        b=aAA8/OSLHPEH6j1wgXO01C8LGhPpBNUVZ0phIcCbYOjUCRDEcbLOkn8CFDaz2tXe7R
         7vEeE/XKLrJEP/MGJK3To4i72dgg27RhHqcMLt/vNP4TculuCqO8PwBd3ufGrIMCgF0j
         FPb2y7bmjSAXRx+CePlec0NNND4teW2AN1JPaUVZ8NVw0Hhf/w7fpuoTQJsFmZTZwnB0
         SEIG884VyNi/RWPjiZV4XeltqQbY12d8S1zV0gRRZT4X0ib1x9QChN87VbF0xhO+IwkN
         urWc0zFKVsZH9Z5wtOdwIkSIeMO/HvgcWQF0NB4zXforRoy0a4oZ2y2BFFZoB1uvTbpW
         m/EQ==
X-Gm-Message-State: AOJu0Yx7+5k1oaK1MtUJ5lTEitGyasnJvK5pEMFzPOvtFJzPlIIrEKWZ
	F2ko12wl8W3E+gO7THa2tqSaBRbOAgBOMpeHPjHJnkInbd4Htz/r72jDF7cx2apzVTzWMNwztjd
	N
X-Google-Smtp-Source: AGHT+IE+UrvE7Zc/7CplAR6O5IJckWlMxTDspzBoq8kviwQyDMeJdPaKmtSIFMpzvN0FSb5rEIPMoA==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr204979iob.0.1712850197000;
        Thu, 11 Apr 2024 08:43:17 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 416/437] media/platform: amphion: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:16 -0600
Message-ID: <20240411153126.16201-417-axboe@kernel.dk>
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
 drivers/media/platform/amphion/vpu_dbg.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index 940e5bda5fa3..71c752081ab3 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -353,21 +353,19 @@ static int vpu_dbg_inst_open(struct inode *inode, struct file *filp)
 	return single_open(filp, vpu_dbg_instance, inode->i_private);
 }
 
-static ssize_t vpu_dbg_inst_write(struct file *file,
-				  const char __user *user_buf, size_t size, loff_t *ppos)
+static ssize_t vpu_dbg_inst_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
 	struct vpu_inst *inst = s->private;
 
 	vpu_session_debug(inst);
 
-	return size;
+	return iov_iter_count(from);
 }
 
-static ssize_t vpu_dbg_core_write(struct file *file,
-				  const char __user *user_buf, size_t size, loff_t *ppos)
+static ssize_t vpu_dbg_core_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
 	struct vpu_core *core = s->private;
 
 	pm_runtime_resume_and_get(core->dev);
@@ -382,7 +380,7 @@ static ssize_t vpu_dbg_core_write(struct file *file,
 	mutex_unlock(&core->lock);
 	pm_runtime_put_sync(core->dev);
 
-	return size;
+	return iov_iter_count(from);
 }
 
 static int vpu_dbg_core_open(struct inode *inode, struct file *filp)
@@ -399,23 +397,23 @@ static const struct file_operations vpu_dbg_inst_fops = {
 	.owner = THIS_MODULE,
 	.open = vpu_dbg_inst_open,
 	.release = single_release,
-	.read = seq_read,
-	.write = vpu_dbg_inst_write,
+	.read_iter = seq_read_iter,
+	.write_iter = vpu_dbg_inst_write,
 };
 
 static const struct file_operations vpu_dbg_core_fops = {
 	.owner = THIS_MODULE,
 	.open = vpu_dbg_core_open,
 	.release = single_release,
-	.read = seq_read,
-	.write = vpu_dbg_core_write,
+	.read_iter = seq_read_iter,
+	.write_iter = vpu_dbg_core_write,
 };
 
 static const struct file_operations vpu_dbg_fwlog_fops = {
 	.owner = THIS_MODULE,
 	.open = vpu_dbg_fwlog_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 };
 
 int vpu_inst_create_dbgfs_file(struct vpu_inst *inst)
-- 
2.43.0


