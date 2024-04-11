Return-Path: <linux-kernel+bounces-141188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55658A1AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174671F21D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD51FA5D4;
	Thu, 11 Apr 2024 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nwXfIA7l"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0F1FA5B3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850180; cv=none; b=D0rUdLFP5Zg3NOaIwvAgO9Y4Y6kyIwSR4mNTs5c2xJwdzOF6eeWVwb0u55V2055jNaTk1o3OIFXbltAqaTTzcG+CKJwNdN9wHi5SGp4WVFX1rsGEvJRPHMtRVsYsl0xogHezzOfiJuLbI1mFwCNJitbKKXhB8KcrpofV5dwS68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850180; c=relaxed/simple;
	bh=Qo9D79pVOxnWtoVCGAcLVjarFHT/n9wZxBlsvf66ulU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9kO5z2JbKpcbKU9cuVQjirkwHOZOxq9Xpu3UsDvOa/jLP8y15MsVd2TcbKhYm7g7FLKKu7PKstkGxUCMQU5AlUClh41z7OzoodfSvQm9lvpkZ/CwmadIvvrDO3fGUm3F5+eILeoAqLK1wUjkNrtO4OZgOTQoJ/K25kFwsYdEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nwXfIA7l; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36a224d7414so198205ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850178; x=1713454978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mls7kBOPQasKlPimrxCMGwZCcxtxZrVxfx4W6x5deIs=;
        b=nwXfIA7ljEJliS7XkUuhIl3vBzbpQvqhFVpCIe3cyticTLBOKNh2TdJPaaRTAKZHLM
         C3y4PQxe0eEv/vanotjePJTJmmvuJeh7n1rrlUKXfjBUAAyjfqU/yM070qKSoD4yvo7C
         kg4qUHnR8pYLFzcmqaiQZqUK9gR4pv0wFP03uQotKa8JujHZtuWpiluorWGzWKg+C/ZN
         FiCM1l8KJMXYAbW7yiAeDAXaHK/42PVxTl9AlAxUmsa8UbncP5bvq04ZmJPtAsl2IEjz
         XaLUZ7n8A8zudR5TfzZEKF/CTiyp7R7MBaYr7GNOzqjWBeBDeg1gulGOsP1EbGrGlsuI
         Lv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850178; x=1713454978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mls7kBOPQasKlPimrxCMGwZCcxtxZrVxfx4W6x5deIs=;
        b=hw+O6NSs010QtqcL26cXpTmIBO4G/J/+AkSHVwgwIEl3cSgxzx+D4IWZJ4PQT53nCp
         2O6vRHF1pcJynr50sFsSE3kLmyd/D4pG0PDVsrOjzceZsiI/9TDLAnmjqBqegCFcoy28
         8x8xImr4pv1X3XgEFWlg/lJwcEFCaOqMDvzZxhmiADDS/fgoCOHERhntjxVrOoL3w+vU
         8Bx2/AXK0spasOeHfSo4RbheHss3L2ODIihRItAvCdu4VnC/Mz/SJNnWOpz7UBUP5RKp
         MAbT41Ur9Zz0zvust77EvDi9225eM6i9lVT3OQvTA7umjSZHc/ya6qhm0nPJE+2vYAyA
         jO7g==
X-Gm-Message-State: AOJu0YxAe54rydYmGOpv0fHGw8SOK1w+WBUiSpaN4uXgamPe2lwTK06U
	F2nPUlcAkJl1w3dFK8CB2iafjh7pTsmjk2gS+83Ex2Nxv3MvmfCQ6o4D2if8sABe0D8KTxIHpZD
	0
X-Google-Smtp-Source: AGHT+IFiQJTauONSy9Zzwzlpjnhlh95u/B+ywkgk6RgXKiohX70z10ONBYAUgiUupAQiN5xeM6OGzw==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr164932ioc.2.1712850178193;
        Thu, 11 Apr 2024 08:42:58 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 404/437] infiniband/core: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:04 -0600
Message-ID: <20240411153126.16201-405-axboe@kernel.dk>
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
 drivers/infiniband/core/ucma.c        |  3 ++-
 drivers/infiniband/core/user_mad.c    |  6 ++++--
 drivers/infiniband/core/uverbs_main.c | 11 +++++++----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 5f5ad8faf86e..b9aa99083dd9 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1746,6 +1746,7 @@ static ssize_t ucma_write(struct file *filp, const char __user *buf,
 
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(ucma_write);
 
 static __poll_t ucma_poll(struct file *filp, struct poll_table_struct *wait)
 {
@@ -1815,7 +1816,7 @@ static const struct file_operations ucma_fops = {
 	.owner 	 = THIS_MODULE,
 	.open 	 = ucma_open,
 	.release = ucma_close,
-	.write	 = ucma_write,
+	.write_iter = ucma_write_iter,
 	.poll    = ucma_poll,
 	.llseek	 = no_llseek,
 };
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index f5feca7fa9b9..dcb065c3d8c5 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -429,6 +429,7 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
 	}
 	return ret;
 }
+FOPS_READ_ITER_HELPER(ib_umad_read);
 
 static int copy_rmpp_mad(struct ib_mad_send_buf *msg, const char __user *buf)
 {
@@ -660,6 +661,7 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 	kfree(packet);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(ib_umad_write);
 
 static __poll_t ib_umad_poll(struct file *filp, struct poll_table_struct *wait)
 {
@@ -1064,8 +1066,8 @@ static int ib_umad_close(struct inode *inode, struct file *filp)
 
 static const struct file_operations umad_fops = {
 	.owner		= THIS_MODULE,
-	.read		= ib_umad_read,
-	.write		= ib_umad_write,
+	.read_iter	= ib_umad_read_iter,
+	.write_iter	= ib_umad_write_iter,
 	.poll		= ib_umad_poll,
 	.unlocked_ioctl = ib_umad_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 495d5a5d0373..7834a30e182b 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -285,6 +285,7 @@ static ssize_t ib_uverbs_async_event_read(struct file *filp, char __user *buf,
 	return ib_uverbs_event_read(&file->ev_queue, filp, buf, count, pos,
 				    sizeof(struct ib_uverbs_async_event_desc));
 }
+FOPS_READ_ITER_HELPER(ib_uverbs_async_event_read);
 
 static ssize_t ib_uverbs_comp_event_read(struct file *filp, char __user *buf,
 					 size_t count, loff_t *pos)
@@ -296,6 +297,7 @@ static ssize_t ib_uverbs_comp_event_read(struct file *filp, char __user *buf,
 				    pos,
 				    sizeof(struct ib_uverbs_comp_event_desc));
 }
+FOPS_READ_ITER_HELPER(ib_uverbs_comp_event_read);
 
 static __poll_t ib_uverbs_event_poll(struct ib_uverbs_event_queue *ev_queue,
 					 struct file *filp,
@@ -349,7 +351,7 @@ static int ib_uverbs_comp_event_fasync(int fd, struct file *filp, int on)
 
 const struct file_operations uverbs_event_fops = {
 	.owner	 = THIS_MODULE,
-	.read	 = ib_uverbs_comp_event_read,
+	.read_iter = ib_uverbs_comp_event_read_iter,
 	.poll    = ib_uverbs_comp_event_poll,
 	.release = uverbs_uobject_fd_release,
 	.fasync  = ib_uverbs_comp_event_fasync,
@@ -358,7 +360,7 @@ const struct file_operations uverbs_event_fops = {
 
 const struct file_operations uverbs_async_event_fops = {
 	.owner	 = THIS_MODULE,
-	.read	 = ib_uverbs_async_event_read,
+	.read_iter = ib_uverbs_async_event_read_iter,
 	.poll    = ib_uverbs_async_event_poll,
 	.release = uverbs_async_event_release,
 	.fasync  = ib_uverbs_async_event_fasync,
@@ -684,6 +686,7 @@ static ssize_t ib_uverbs_write(struct file *filp, const char __user *buf,
 	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
 	return (ret) ? : count;
 }
+FOPS_WRITE_ITER_HELPER(ib_uverbs_write);
 
 static const struct vm_operations_struct rdma_umap_ops;
 
@@ -988,7 +991,7 @@ static int ib_uverbs_close(struct inode *inode, struct file *filp)
 
 static const struct file_operations uverbs_fops = {
 	.owner	 = THIS_MODULE,
-	.write	 = ib_uverbs_write,
+	.write_iter = ib_uverbs_write_iter,
 	.open	 = ib_uverbs_open,
 	.release = ib_uverbs_close,
 	.llseek	 = no_llseek,
@@ -998,7 +1001,7 @@ static const struct file_operations uverbs_fops = {
 
 static const struct file_operations uverbs_mmap_fops = {
 	.owner	 = THIS_MODULE,
-	.write	 = ib_uverbs_write,
+	.write_iter = ib_uverbs_write_iter,
 	.mmap    = ib_uverbs_mmap,
 	.open	 = ib_uverbs_open,
 	.release = ib_uverbs_close,
-- 
2.43.0


