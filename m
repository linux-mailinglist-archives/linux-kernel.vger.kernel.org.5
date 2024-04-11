Return-Path: <linux-kernel+bounces-141154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C9B8A1ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA561C211C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033081F142A;
	Thu, 11 Apr 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VrUvMuk8"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C51F0B62
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850128; cv=none; b=uyLYwj88YmH+HAgqb9/Ni/Fom8V0dwnA3yP0iPODH/k1+BmEmCiGGA87hn7RBkn/bg3e6shABIQOnkiDNY0h4fDOZ7Mn5ORPP3cBkZmiGu7jWYZwEuEnhbdtYbeBEF9STQ3SqG2SwqP72nhiy4epVLPrZU6uPDoe1S0SLtnxA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850128; c=relaxed/simple;
	bh=r5I+KcW4rIUOXT7uusimjWJMmlJP6KP/Btr5A/eddew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slHinFh/SiIihMB1NOrbL3JzvaGjrBeaYwbyQrATm7oNR1BUw7qgI3l9ksnBPt7pHopMI8yyGfh28Sz9nAZV7Vg0Y4zx23Ax47MKKZM8+VUhIK1B1CyspyvRuvB5vQQlJ4NwmbUPMnNmKAzvXx5OZm3ussnfKgWJld/dW8S7lWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VrUvMuk8; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9087739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850125; x=1713454925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtwbGIz62vYoQMgQ2vNIWBrEq82N7EGI553VAohcxzk=;
        b=VrUvMuk8mMwmqGVXXWR4mlkkfYCZvbo1of/z7W/AZC0IPc0UGmhw+KXTrI7yH3YjPD
         8hKnefHEjZa5pKWfjkuevmtvdxGvTNJFuuL60NKDLLUcxZNyXfnnJbB8pvWQnmDItL3D
         ua2Ff0fKrQhcFb+WcoQ7eaSAAlLpCRAkEYlenuXj+8YFLNut+eIuF+uElnixuD92N8ei
         klWDLgR8plXvm4rEZMMkYAlR5wAd0WFX9sSh98m6lPy6vkJVfXZKtdiO0vWrT3gUlq8j
         ik9uz6Ccg20cx5oR85ckbkvlqCxHF7F+HyMVcZh5BIJtV9WbFFE1Ux0zvApVRuYjPKYu
         fgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850125; x=1713454925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtwbGIz62vYoQMgQ2vNIWBrEq82N7EGI553VAohcxzk=;
        b=RoLV61j+Kx6Dry48bYrt/o6E4oEdPLARXnFNKU41ceQOqVJ3gDII9DdKI8KWsiCU1P
         k1TrmPj863s4Nin+FYnjQpqhO/vu6el0v0BlgQiR6X/3m4NC/M4G7kyNTkl6ls3KGMj/
         Li419sYqJAXG2EM61cg7bUM0Z7JQ7u6jdUYi8xHy361DRTYi2m6CMgYGrwHWhMrInVuf
         oMBuIJex1k8UYj4Kz6FhnaZTQLkewxNzX87Tgn8iLxcBLAtBcX7vmkEMA9kTNS/AVuQR
         oEx1FEDABO/r5wzay/4/mLhx27X3gLSbwXYchSgDVZGeoxWZ/WYuh2O8lkDKgY2Z3VVv
         ridA==
X-Gm-Message-State: AOJu0YwefBcayjXnOAFl8yj70rfoGamSEA4BxVdwtHL+fS6qWrGIcNHO
	0kzjr3W253NnG8ky97u7XRxMN8VdE5YvPJfOhgoMqiZFfexsWheYpOuCCu6rIsdHmDNcxkNPN0Y
	c
X-Google-Smtp-Source: AGHT+IH21WlCt+lC+Q0u8Cl/w7Zwp9YtLpEEWSKuQj0LlI713RZH1hYqq57cXqF1dftw4qkj+7vesg==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr32087ioc.1.1712850124501;
        Thu, 11 Apr 2024 08:42:04 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 371/437] drivers/ntb: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:31 -0600
Message-ID: <20240411153126.16201-372-axboe@kernel.dk>
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
 drivers/ntb/hw/amd/ntb_hw_amd.c    |  10 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c    |  29 ++-
 drivers/ntb/hw/intel/ntb_hw_gen1.c |  21 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.c |   8 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.h |   3 +-
 drivers/ntb/hw/intel/ntb_hw_gen4.c |   8 +-
 drivers/ntb/hw/intel/ntb_hw_gen4.h |   5 +-
 drivers/ntb/ntb_transport.c        |   9 +-
 drivers/ntb/test/ntb_perf.c        |  49 +++--
 drivers/ntb/test/ntb_tool.c        | 307 +++++++++++++----------------
 10 files changed, 203 insertions(+), 246 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d687e8c2cc78..027bcfb2bb11 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -835,8 +835,7 @@ static void ndev_deinit_isr(struct amd_ntb_dev *ndev)
 	}
 }
 
-static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
-				 size_t count, loff_t *offp)
+static ssize_t ndev_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct amd_ntb_dev *ndev;
 	void __iomem *mmio;
@@ -844,8 +843,9 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 	size_t buf_size;
 	ssize_t ret, off;
 	union { u64 v64; u32 v32; u16 v16; } u;
+	size_t count = iov_iter_count(to);
 
-	ndev = filp->private_data;
+	ndev = iocb->ki_filp->private_data;
 	mmio = ndev->self_mmio;
 
 	buf_size = min(count, 0x800ul);
@@ -927,7 +927,7 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 	off += scnprintf(buf + off, buf_size - off,
 			 "LMT45 -\t\t\t%#018llx\n", u.v64);
 
-	ret = simple_read_from_buffer(ubuf, count, offp, buf, off);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, off, to);
 	kfree(buf);
 	return ret;
 }
@@ -1299,7 +1299,7 @@ static void amd_ntb_pci_shutdown(struct pci_dev *pdev)
 static const struct file_operations amd_ntb_debugfs_info = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = ndev_debugfs_read,
+	.read_iter = ndev_debugfs_read,
 };
 
 static const struct ntb_dev_data dev_data[] = {
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 48823b53ede3..9213ba1eb36f 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2312,18 +2312,6 @@ static void idt_unregister_device(struct idt_ntb_dev *ndev)
  *=============================================================================
  */
 
-static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
-				   size_t count, loff_t *offp);
-
-/*
- * Driver DebugFS info file operations
- */
-static const struct file_operations idt_dbgfs_info_ops = {
-	.owner = THIS_MODULE,
-	.open = simple_open,
-	.read = idt_dbgfs_info_read
-};
-
 /*
  * idt_dbgfs_info_read() - DebugFS read info node callback
  * @file:	File node descriptor.
@@ -2331,10 +2319,10 @@ static const struct file_operations idt_dbgfs_info_ops = {
  * @count:	Size of the buffer
  * @offp:	Offset within the buffer
  */
-static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
-				   size_t count, loff_t *offp)
+static ssize_t idt_dbgfs_info_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct idt_ntb_dev *ndev = filp->private_data;
+	struct idt_ntb_dev *ndev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	unsigned char idx, pidx, cnt;
 	unsigned long irqflags, mdeg;
 	ssize_t ret = 0, off = 0;
@@ -2492,12 +2480,21 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
 		idt_get_deg(mdeg), idt_get_deg_frac(mdeg));
 
 	/* Copy the buffer to the User Space */
-	ret = simple_read_from_buffer(ubuf, count, offp, strbuf, off);
+	ret = simple_copy_to_iter(strbuf, &iocb->ki_pos, off, to);
 	kfree(strbuf);
 
 	return ret;
 }
 
+/*
+ * Driver DebugFS info file operations
+ */
+static const struct file_operations idt_dbgfs_info_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read_iter = idt_dbgfs_info_read
+};
+
 /*
  * idt_init_dbgfs() - initialize DebugFS node
  * @ndev:	IDT NTB hardware driver descriptor
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 9ab836d0d4f1..de31b75f3d20 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -488,8 +488,7 @@ static void ndev_deinit_isr(struct intel_ntb_dev *ndev)
 	}
 }
 
-static ssize_t ndev_ntb_debugfs_read(struct file *filp, char __user *ubuf,
-				     size_t count, loff_t *offp)
+static ssize_t ndev_ntb_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct intel_ntb_dev *ndev;
 	struct pci_dev *pdev;
@@ -498,8 +497,9 @@ static ssize_t ndev_ntb_debugfs_read(struct file *filp, char __user *ubuf,
 	size_t buf_size;
 	ssize_t ret, off;
 	union { u64 v64; u32 v32; u16 v16; u8 v8; } u;
+	size_t count = iov_iter_count(to);
 
-	ndev = filp->private_data;
+	ndev = iocb->ki_filp->private_data;
 	pdev = ndev->ntb.pdev;
 	mmio = ndev->self_mmio;
 
@@ -749,22 +749,21 @@ static ssize_t ndev_ntb_debugfs_read(struct file *filp, char __user *ubuf,
 					 "CORERRSTS -\t\t%#06x\n", u.v32);
 	}
 
-	ret = simple_read_from_buffer(ubuf, count, offp, buf, off);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, off, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
-				 size_t count, loff_t *offp)
+static ssize_t ndev_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct intel_ntb_dev *ndev = filp->private_data;
+	struct intel_ntb_dev *ndev = iocb->ki_filp->private_data;
 
 	if (pdev_is_gen1(ndev->ntb.pdev))
-		return ndev_ntb_debugfs_read(filp, ubuf, count, offp);
+		return ndev_ntb_debugfs_read(iocb, to);
 	else if (pdev_is_gen3(ndev->ntb.pdev))
-		return ndev_ntb3_debugfs_read(filp, ubuf, count, offp);
+		return ndev_ntb3_debugfs_read(iocb, to);
 	else if (pdev_is_gen4(ndev->ntb.pdev) || pdev_is_gen5(ndev->ntb.pdev))
-		return ndev_ntb4_debugfs_read(filp, ubuf, count, offp);
+		return ndev_ntb4_debugfs_read(iocb, to);
 
 	return -ENXIO;
 }
@@ -2021,7 +2020,7 @@ static const struct ntb_dev_ops intel_ntb_ops = {
 static const struct file_operations intel_ntb_debugfs_info = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = ndev_debugfs_read,
+	.read_iter = ndev_debugfs_read,
 };
 
 static const struct pci_device_id intel_ntb_pci_tbl[] = {
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
index ffcfc3e02c35..56caeb639016 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
@@ -252,8 +252,7 @@ int gen3_init_dev(struct intel_ntb_dev *ndev)
 	return gen3_init_isr(ndev);
 }
 
-ssize_t ndev_ntb3_debugfs_read(struct file *filp, char __user *ubuf,
-				      size_t count, loff_t *offp)
+ssize_t ndev_ntb3_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct intel_ntb_dev *ndev;
 	void __iomem *mmio;
@@ -261,8 +260,9 @@ ssize_t ndev_ntb3_debugfs_read(struct file *filp, char __user *ubuf,
 	size_t buf_size;
 	ssize_t ret, off;
 	union { u64 v64; u32 v32; u16 v16; } u;
+	size_t count = iov_iter_count(to);
 
-	ndev = filp->private_data;
+	ndev = iocb->ki_filp->private_data;
 	mmio = ndev->self_mmio;
 
 	buf_size = min(count, 0x800ul);
@@ -410,7 +410,7 @@ ssize_t ndev_ntb3_debugfs_read(struct file *filp, char __user *ubuf,
 		off += scnprintf(buf + off, buf_size - off,
 				 "CORERRSTS -\t\t%#06x\n", u.v32);
 
-	ret = simple_read_from_buffer(ubuf, count, offp, buf, off);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, off, to);
 	kfree(buf);
 	return ret;
 }
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.h b/drivers/ntb/hw/intel/ntb_hw_gen3.h
index dea93989942d..0eddbee39972 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.h
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.h
@@ -101,8 +101,7 @@ static inline void gen3_db_iowrite(u64 bits, void __iomem *mmio)
 	iowrite64(bits, mmio);
 }
 
-ssize_t ndev_ntb3_debugfs_read(struct file *filp, char __user *ubuf,
-				      size_t count, loff_t *offp);
+ssize_t ndev_ntb3_debugfs_read(struct kiocb *iocb, struct iov_iter *to);
 int gen3_init_dev(struct intel_ntb_dev *ndev);
 int intel_ntb3_link_enable(struct ntb_dev *ntb, enum ntb_speed max_speed,
 		enum ntb_width max_width);
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
index 22cac7975b3c..7fb3d963abec 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
@@ -216,8 +216,7 @@ int gen4_init_dev(struct intel_ntb_dev *ndev)
 	return gen4_init_isr(ndev);
 }
 
-ssize_t ndev_ntb4_debugfs_read(struct file *filp, char __user *ubuf,
-				      size_t count, loff_t *offp)
+ssize_t ndev_ntb4_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct intel_ntb_dev *ndev;
 	void __iomem *mmio;
@@ -225,8 +224,9 @@ ssize_t ndev_ntb4_debugfs_read(struct file *filp, char __user *ubuf,
 	size_t buf_size;
 	ssize_t ret, off;
 	union { u64 v64; u32 v32; u16 v16; } u;
+	size_t count = iov_iter_count(to);
 
-	ndev = filp->private_data;
+	ndev = iocb->ki_filp->private_data;
 	mmio = ndev->self_mmio;
 
 	buf_size = min(count, 0x800ul);
@@ -329,7 +329,7 @@ ssize_t ndev_ntb4_debugfs_read(struct file *filp, char __user *ubuf,
 		off += scnprintf(buf + off, buf_size - off,
 				 "CORERRSTS -\t\t%#06x\n", u.v32);
 
-	ret = simple_read_from_buffer(ubuf, count, offp, buf, off);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, off, to);
 	kfree(buf);
 	return ret;
 }
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.h b/drivers/ntb/hw/intel/ntb_hw_gen4.h
index f91323eaf5ce..6c0fa8c99715 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen4.h
+++ b/drivers/ntb/hw/intel/ntb_hw_gen4.h
@@ -103,11 +103,8 @@
 #define NTB_LTR_IDLE_LATSCALE		0x0800  /* 1us scale */
 #define NTB_LTR_IDLE_REQMNT		0x8000  /* snoop req enable */
 
-ssize_t ndev_ntb4_debugfs_read(struct file *filp, char __user *ubuf,
-				      size_t count, loff_t *offp);
+ssize_t ndev_ntb4_debugfs_read(struct kiocb *iocb, struct iov_iter *to);
 int gen4_init_dev(struct intel_ntb_dev *ndev);
-ssize_t ndev_ntb4_debugfs_read(struct file *filp, char __user *ubuf,
-				      size_t count, loff_t *offp);
 
 extern const struct ntb_dev_ops intel_ntb4_ops;
 
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9e7847a378e..bc69e3d81350 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -460,14 +460,13 @@ void ntb_transport_unregister_client(struct ntb_transport_client *drv)
 }
 EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
 
-static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
-			    loff_t *offp)
+static ssize_t debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct ntb_transport_qp *qp;
 	char *buf;
 	ssize_t ret, out_offset, out_count;
 
-	qp = filp->private_data;
+	qp = iocb->ki_filp->private_data;
 
 	if (!qp || !qp->link_is_up)
 		return 0;
@@ -548,7 +547,7 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 	if (out_offset > out_count)
 		out_offset = out_count;
 
-	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, out_offset, to);
 	kfree(buf);
 	return ret;
 }
@@ -556,7 +555,7 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 static const struct file_operations ntb_qp_debugfs_stats = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = debugfs_read,
+	.read_iter = debugfs_read,
 };
 
 static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 553f1f46bc66..d3f9d2f5015d 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1179,10 +1179,10 @@ static void perf_clear_threads(struct perf_ctx *perf)
  *==============================================================================
  */
 
-static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
-				    size_t size, loff_t *offp)
+static ssize_t perf_dbgfs_read_info(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct perf_ctx *perf = filep->private_data;
+	struct perf_ctx *perf = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(to);
 	struct perf_peer *peer;
 	size_t buf_size;
 	ssize_t pos = 0;
@@ -1251,7 +1251,7 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
 			"\tIn buffer xlat %pad[p]\n", &peer->inbuf_xlat);
 	}
 
-	ret = simple_read_from_buffer(ubuf, size, offp, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 
 	return ret;
@@ -1259,13 +1259,12 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
 
 static const struct file_operations perf_dbgfs_info = {
 	.open = simple_open,
-	.read = perf_dbgfs_read_info
+	.read_iter = perf_dbgfs_read_info
 };
 
-static ssize_t perf_dbgfs_read_run(struct file *filep, char __user *ubuf,
-				   size_t size, loff_t *offp)
+static ssize_t perf_dbgfs_read_run(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct perf_ctx *perf = filep->private_data;
+	struct perf_ctx *perf = iocb->ki_filp->private_data;
 	ssize_t ret, pos = 0;
 	char *buf;
 
@@ -1277,21 +1276,21 @@ static ssize_t perf_dbgfs_read_run(struct file *filep, char __user *ubuf,
 	if (ret)
 		goto err_free;
 
-	ret = simple_read_from_buffer(ubuf, size, offp, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 err_free:
 	kfree(buf);
 
 	return ret;
 }
 
-static ssize_t perf_dbgfs_write_run(struct file *filep, const char __user *ubuf,
-				    size_t size, loff_t *offp)
+static ssize_t perf_dbgfs_write_run(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct perf_ctx *perf = filep->private_data;
+	struct perf_ctx *perf = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	struct perf_peer *peer;
 	int pidx, ret;
 
-	ret = kstrtoint_from_user(ubuf, size, 0, &pidx);
+	ret = kstrtoint_from_iter(from, size, 0, &pidx);
 	if (ret)
 		return ret;
 
@@ -1309,31 +1308,29 @@ static ssize_t perf_dbgfs_write_run(struct file *filep, const char __user *ubuf,
 
 static const struct file_operations perf_dbgfs_run = {
 	.open = simple_open,
-	.read = perf_dbgfs_read_run,
-	.write = perf_dbgfs_write_run
+	.read_iter = perf_dbgfs_read_run,
+	.write_iter = perf_dbgfs_write_run,
 };
 
-static ssize_t perf_dbgfs_read_tcnt(struct file *filep, char __user *ubuf,
-				    size_t size, loff_t *offp)
+static ssize_t perf_dbgfs_read_tcnt(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct perf_ctx *perf = filep->private_data;
+	struct perf_ctx *perf = iocb->ki_filp->private_data;
 	char buf[8];
 	ssize_t pos;
 
 	pos = scnprintf(buf, sizeof(buf), "%hhu\n", perf->tcnt);
 
-	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t perf_dbgfs_write_tcnt(struct file *filep,
-				     const char __user *ubuf,
-				     size_t size, loff_t *offp)
+static ssize_t perf_dbgfs_write_tcnt(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct perf_ctx *perf = filep->private_data;
+	struct perf_ctx *perf = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	int ret;
 	u8 val;
 
-	ret = kstrtou8_from_user(ubuf, size, 0, &val);
+	ret = kstrtou8_from_iter(from, size, 0, &val);
 	if (ret)
 		return ret;
 
@@ -1346,8 +1343,8 @@ static ssize_t perf_dbgfs_write_tcnt(struct file *filep,
 
 static const struct file_operations perf_dbgfs_tcnt = {
 	.open = simple_open,
-	.read = perf_dbgfs_read_tcnt,
-	.write = perf_dbgfs_write_tcnt
+	.read_iter = perf_dbgfs_read_tcnt,
+	.write_iter = perf_dbgfs_write_tcnt,
 };
 
 static void perf_setup_dbgfs(struct perf_ctx *perf)
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 641cb7e05a47..e3988468c92f 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -273,8 +273,8 @@ struct tool_ctx {
 	const struct file_operations __name = {	\
 		.owner = THIS_MODULE,		\
 		.open = simple_open,		\
-		.read = __read,			\
-		.write = __write,		\
+		.read_iter = __read,		\
+		.write_iter = __write,		\
 	}
 
 #define TOOL_BUF_LEN 32
@@ -338,8 +338,8 @@ static const struct ntb_ctx_ops tool_ops = {
  *==============================================================================
  */
 
-static ssize_t tool_fn_read(struct tool_ctx *tc, char __user *ubuf,
-			    size_t size, loff_t *offp,
+static ssize_t tool_fn_read(struct tool_ctx *tc, struct kiocb *iocb,
+			    struct iov_iter *to,
 			    u64 (*fn_read)(struct ntb_dev *))
 {
 	size_t buf_size;
@@ -349,28 +349,28 @@ static ssize_t tool_fn_read(struct tool_ctx *tc, char __user *ubuf,
 	if (!fn_read)
 		return -EINVAL;
 
-	buf_size = min(size, sizeof(buf));
+	buf_size = min(iov_iter_count(to), sizeof(buf));
 
 	pos = scnprintf(buf, buf_size, "%#llx\n", fn_read(tc->ntb));
 
-	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t tool_fn_write(struct tool_ctx *tc,
-			     const char __user *ubuf,
-			     size_t size, loff_t *offp,
+static ssize_t tool_fn_write(struct tool_ctx *tc, struct kiocb *iocb,
+			     struct iov_iter *from,
 			     int (*fn_set)(struct ntb_dev *, u64),
 			     int (*fn_clear)(struct ntb_dev *, u64))
 {
+	size_t size = iov_iter_count(from);
 	char *buf, cmd;
 	ssize_t ret;
 	u64 bits;
 	int n;
 
-	if (*offp)
+	if (iocb->ki_pos)
 		return 0;
 
-	buf = memdup_user_nul(ubuf, size);
+	buf = iterdup_nul(from, size);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -402,26 +402,24 @@ static ssize_t tool_fn_write(struct tool_ctx *tc,
  *==============================================================================
  */
 
-static ssize_t tool_port_read(struct file *filep, char __user *ubuf,
-			      size_t size, loff_t *offp)
+static ssize_t tool_port_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 	char buf[TOOL_BUF_LEN];
 	int pos;
 
 	pos = scnprintf(buf, sizeof(buf), "%d\n", ntb_port_number(tc->ntb));
 
-	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static TOOL_FOPS_RDWR(tool_port_fops,
 		      tool_port_read,
 		      NULL);
 
-static ssize_t tool_peer_port_read(struct file *filep, char __user *ubuf,
-				   size_t size, loff_t *offp)
+static ssize_t tool_peer_port_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_peer *peer = filep->private_data;
+	struct tool_peer *peer = iocb->ki_filp->private_data;
 	struct tool_ctx *tc = peer->tc;
 	char buf[TOOL_BUF_LEN];
 	int pos;
@@ -429,7 +427,7 @@ static ssize_t tool_peer_port_read(struct file *filep, char __user *ubuf,
 	pos = scnprintf(buf, sizeof(buf), "%d\n",
 		ntb_peer_port_number(tc->ntb, peer->pidx));
 
-	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static TOOL_FOPS_RDWR(tool_peer_port_fops,
@@ -459,14 +457,14 @@ static int tool_init_peers(struct tool_ctx *tc)
  *==============================================================================
  */
 
-static ssize_t tool_link_write(struct file *filep, const char __user *ubuf,
-			       size_t size, loff_t *offp)
+static ssize_t tool_link_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	bool val;
 	int ret;
 
-	ret = kstrtobool_from_user(ubuf, size, &val);
+	ret = kstrtobool_from_iter(from, size, &val);
 	if (ret)
 		return ret;
 
@@ -485,10 +483,9 @@ static TOOL_FOPS_RDWR(tool_link_fops,
 		      NULL,
 		      tool_link_write);
 
-static ssize_t tool_peer_link_read(struct file *filep, char __user *ubuf,
-				   size_t size, loff_t *offp)
+static ssize_t tool_peer_link_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_peer *peer = filep->private_data;
+	struct tool_peer *peer = iocb->ki_filp->private_data;
 	struct tool_ctx *tc = peer->tc;
 	char buf[3];
 
@@ -499,24 +496,24 @@ static ssize_t tool_peer_link_read(struct file *filep, char __user *ubuf,
 	buf[1] = '\n';
 	buf[2] = '\0';
 
-	return simple_read_from_buffer(ubuf, size, offp, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
 static TOOL_FOPS_RDWR(tool_peer_link_fops,
 		      tool_peer_link_read,
 		      NULL);
 
-static ssize_t tool_peer_link_event_write(struct file *filep,
-					  const char __user *ubuf,
-					  size_t size, loff_t *offp)
+static ssize_t tool_peer_link_event_write(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct tool_peer *peer = filep->private_data;
+	struct tool_peer *peer = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	struct tool_ctx *tc = peer->tc;
 	u64 link_msk;
 	bool val;
 	int ret;
 
-	ret = kstrtobool_from_user(ubuf, size, &val);
+	ret = kstrtobool_from_iter(from, size, &val);
 	if (ret)
 		return ret;
 
@@ -538,28 +535,25 @@ static TOOL_FOPS_RDWR(tool_peer_link_event_fops,
  *==============================================================================
  */
 
-static ssize_t tool_mw_read(struct file *filep, char __user *ubuf,
-			    size_t size, loff_t *offp)
+static ssize_t tool_mw_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_mw *inmw = filep->private_data;
+	struct tool_mw *inmw = iocb->ki_filp->private_data;
 
 	if (inmw->mm_base == NULL)
 		return -ENXIO;
 
-	return simple_read_from_buffer(ubuf, size, offp,
-				       inmw->mm_base, inmw->size);
+	return simple_copy_to_iter(inmw->mm_base, &iocb->ki_pos, inmw->size, to);
 }
 
-static ssize_t tool_mw_write(struct file *filep, const char __user *ubuf,
-			     size_t size, loff_t *offp)
+static ssize_t tool_mw_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_mw *inmw = filep->private_data;
+	struct tool_mw *inmw = iocb->ki_filp->private_data;
 
 	if (inmw->mm_base == NULL)
 		return -ENXIO;
 
-	return simple_write_to_buffer(inmw->mm_base, inmw->size, offp,
-				      ubuf, size);
+	return simple_copy_from_iter(inmw->mm_base, &iocb->ki_pos, inmw->size,
+				     from);
 }
 
 static TOOL_FOPS_RDWR(tool_mw_fops,
@@ -634,10 +628,10 @@ static void tool_free_mw(struct tool_ctx *tc, int pidx, int widx)
 	inmw->dbgfs_file = NULL;
 }
 
-static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
-				  size_t size, loff_t *offp)
+static ssize_t tool_mw_trans_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_mw *inmw = filep->private_data;
+	struct tool_mw *inmw = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(to);
 	resource_size_t addr_align;
 	resource_size_t size_align;
 	resource_size_t size_max;
@@ -688,7 +682,7 @@ static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
 			 "Size Max       \t%pap\n",
 			 &size_max);
 
-	ret = simple_read_from_buffer(ubuf, size, offp, buf, off);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, off, to);
 
 err:
 	kfree(buf);
@@ -696,14 +690,14 @@ static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
 	return ret;
 }
 
-static ssize_t tool_mw_trans_write(struct file *filep, const char __user *ubuf,
-				   size_t size, loff_t *offp)
+static ssize_t tool_mw_trans_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_mw *inmw = filep->private_data;
+	struct tool_mw *inmw = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	unsigned int val;
 	int ret;
 
-	ret = kstrtouint_from_user(ubuf, size, 0, &val);
+	ret = kstrtouint_from_iter(from, size, 0, &val);
 	if (ret)
 		return ret;
 
@@ -721,11 +715,11 @@ static TOOL_FOPS_RDWR(tool_mw_trans_fops,
 		      tool_mw_trans_read,
 		      tool_mw_trans_write);
 
-static ssize_t tool_peer_mw_read(struct file *filep, char __user *ubuf,
-				 size_t size, loff_t *offp)
+static ssize_t tool_peer_mw_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_mw *outmw = filep->private_data;
-	loff_t pos = *offp;
+	struct tool_mw *outmw = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(to);
+	loff_t pos = iocb->ki_pos;
 	ssize_t ret;
 	void *buf;
 
@@ -743,14 +737,14 @@ static ssize_t tool_peer_mw_read(struct file *filep, char __user *ubuf,
 		return -ENOMEM;
 
 	memcpy_fromio(buf, outmw->io_base + pos, size);
-	ret = copy_to_user(ubuf, buf, size);
-	if (ret == size) {
+	ret = copy_to_iter(buf, size, to);
+	if (!ret) {
 		ret = -EFAULT;
 		goto err_free;
 	}
 
 	size -= ret;
-	*offp = pos + size;
+	iocb->ki_pos = pos + size;
 	ret = size;
 
 err_free:
@@ -759,12 +753,12 @@ static ssize_t tool_peer_mw_read(struct file *filep, char __user *ubuf,
 	return ret;
 }
 
-static ssize_t tool_peer_mw_write(struct file *filep, const char __user *ubuf,
-				  size_t size, loff_t *offp)
+static ssize_t tool_peer_mw_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_mw *outmw = filep->private_data;
+	struct tool_mw *outmw = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	ssize_t ret;
-	loff_t pos = *offp;
+	loff_t pos = iocb->ki_pos;
 	void *buf;
 
 	if (outmw->io_base == NULL)
@@ -779,14 +773,14 @@ static ssize_t tool_peer_mw_write(struct file *filep, const char __user *ubuf,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = copy_from_user(buf, ubuf, size);
-	if (ret == size) {
+	ret = copy_from_iter(buf, size, from);
+	if (!ret) {
 		ret = -EFAULT;
 		goto err_free;
 	}
 
 	size -= ret;
-	*offp = pos + size;
+	iocb->ki_pos = pos + size;
 	ret = size;
 
 	memcpy_toio(outmw->io_base + pos, buf, size);
@@ -862,11 +856,11 @@ static void tool_free_peer_mw(struct tool_ctx *tc, int widx)
 	outmw->dbgfs_file = NULL;
 }
 
-static ssize_t tool_peer_mw_trans_read(struct file *filep, char __user *ubuf,
-					size_t size, loff_t *offp)
+static ssize_t tool_peer_mw_trans_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_mw_wrap *outmw_wrap = filep->private_data;
+	struct tool_mw_wrap *outmw_wrap = iocb->ki_filp->private_data;
 	struct tool_mw *outmw = outmw_wrap->mw;
+	size_t size = iov_iter_count(to);
 	resource_size_t map_size;
 	phys_addr_t map_base;
 	ssize_t off = 0;
@@ -913,25 +907,25 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep, char __user *ubuf,
 	off += scnprintf(buf + off, buf_size - off,
 			 "Window Size         \t%pap\n", &outmw->size);
 
-	ret = simple_read_from_buffer(ubuf, size, offp, buf, off);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, off, to);
 	kfree(buf);
 
 	return ret;
 }
 
-static ssize_t tool_peer_mw_trans_write(struct file *filep,
-					const char __user *ubuf,
-					size_t size, loff_t *offp)
+static ssize_t tool_peer_mw_trans_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct tool_mw_wrap *outmw_wrap = filep->private_data;
+	struct tool_mw_wrap *outmw_wrap = iocb->ki_filp->private_data;
 	struct tool_mw *outmw = outmw_wrap->mw;
+	size_t size = iov_iter_count(from);
 	size_t buf_size, wsize;
 	char buf[TOOL_BUF_LEN];
 	int ret, n;
 	u64 addr;
 
 	buf_size = min(size, (sizeof(buf) - 1));
-	if (copy_from_user(buf, ubuf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
@@ -1022,20 +1016,18 @@ static void tool_clear_mws(struct tool_ctx *tc)
  *==============================================================================
  */
 
-static ssize_t tool_db_read(struct file *filep, char __user *ubuf,
-			    size_t size, loff_t *offp)
+static ssize_t tool_db_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->db_read);
+	return tool_fn_read(tc, iocb, to, tc->ntb->ops->db_read);
 }
 
-static ssize_t tool_db_write(struct file *filep, const char __user *ubuf,
-			     size_t size, loff_t *offp)
+static ssize_t tool_db_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_write(tc, ubuf, size, offp, tc->ntb->ops->db_set,
+	return tool_fn_write(tc, iocb, from, tc->ntb->ops->db_set,
 			     tc->ntb->ops->db_clear);
 }
 
@@ -1043,32 +1035,29 @@ static TOOL_FOPS_RDWR(tool_db_fops,
 		      tool_db_read,
 		      tool_db_write);
 
-static ssize_t tool_db_valid_mask_read(struct file *filep, char __user *ubuf,
-				       size_t size, loff_t *offp)
+static ssize_t tool_db_valid_mask_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->db_valid_mask);
+	return tool_fn_read(tc, iocb, to, tc->ntb->ops->db_valid_mask);
 }
 
 static TOOL_FOPS_RDWR(tool_db_valid_mask_fops,
 		      tool_db_valid_mask_read,
 		      NULL);
 
-static ssize_t tool_db_mask_read(struct file *filep, char __user *ubuf,
-				 size_t size, loff_t *offp)
+static ssize_t tool_db_mask_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->db_read_mask);
+	return tool_fn_read(tc, iocb, to, tc->ntb->ops->db_read_mask);
 }
 
-static ssize_t tool_db_mask_write(struct file *filep, const char __user *ubuf,
-			       size_t size, loff_t *offp)
+static ssize_t tool_db_mask_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_write(tc, ubuf, size, offp, tc->ntb->ops->db_set_mask,
+	return tool_fn_write(tc, iocb, from, tc->ntb->ops->db_set_mask,
 			     tc->ntb->ops->db_clear_mask);
 }
 
@@ -1076,20 +1065,18 @@ static TOOL_FOPS_RDWR(tool_db_mask_fops,
 		      tool_db_mask_read,
 		      tool_db_mask_write);
 
-static ssize_t tool_peer_db_read(struct file *filep, char __user *ubuf,
-				 size_t size, loff_t *offp)
+static ssize_t tool_peer_db_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->peer_db_read);
+	return tool_fn_read(tc, iocb, to, tc->ntb->ops->peer_db_read);
 }
 
-static ssize_t tool_peer_db_write(struct file *filep, const char __user *ubuf,
-				  size_t size, loff_t *offp)
+static ssize_t tool_peer_db_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_write(tc, ubuf, size, offp, tc->ntb->ops->peer_db_set,
+	return tool_fn_write(tc, iocb, from, tc->ntb->ops->peer_db_set,
 			     tc->ntb->ops->peer_db_clear);
 }
 
@@ -1097,23 +1084,18 @@ static TOOL_FOPS_RDWR(tool_peer_db_fops,
 		      tool_peer_db_read,
 		      tool_peer_db_write);
 
-static ssize_t tool_peer_db_mask_read(struct file *filep, char __user *ubuf,
-				   size_t size, loff_t *offp)
+static ssize_t tool_peer_db_mask_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_read(tc, ubuf, size, offp,
-			    tc->ntb->ops->peer_db_read_mask);
+	return tool_fn_read(tc, iocb, to, tc->ntb->ops->peer_db_read_mask);
 }
 
-static ssize_t tool_peer_db_mask_write(struct file *filep,
-				       const char __user *ubuf,
-				       size_t size, loff_t *offp)
+static ssize_t tool_peer_db_mask_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_write(tc, ubuf, size, offp,
-			     tc->ntb->ops->peer_db_set_mask,
+	return tool_fn_write(tc, iocb, from, tc->ntb->ops->peer_db_set_mask,
 			     tc->ntb->ops->peer_db_clear_mask);
 }
 
@@ -1121,15 +1103,14 @@ static TOOL_FOPS_RDWR(tool_peer_db_mask_fops,
 		      tool_peer_db_mask_read,
 		      tool_peer_db_mask_write);
 
-static ssize_t tool_db_event_write(struct file *filep,
-				   const char __user *ubuf,
-				   size_t size, loff_t *offp)
+static ssize_t tool_db_event_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	u64 val;
 	int ret;
 
-	ret = kstrtou64_from_user(ubuf, size, 0, &val);
+	ret = kstrtou64_from_iter(from, size, 0, &val);
 	if (ret)
 		return ret;
 
@@ -1148,10 +1129,9 @@ static TOOL_FOPS_RDWR(tool_db_event_fops,
  *==============================================================================
  */
 
-static ssize_t tool_spad_read(struct file *filep, char __user *ubuf,
-			      size_t size, loff_t *offp)
+static ssize_t tool_spad_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_spad *spad = filep->private_data;
+	struct tool_spad *spad = iocb->ki_filp->private_data;
 	char buf[TOOL_BUF_LEN];
 	ssize_t pos;
 
@@ -1161,13 +1141,13 @@ static ssize_t tool_spad_read(struct file *filep, char __user *ubuf,
 	pos = scnprintf(buf, sizeof(buf), "%#x\n",
 		ntb_spad_read(spad->tc->ntb, spad->sidx));
 
-	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t tool_spad_write(struct file *filep, const char __user *ubuf,
-			       size_t size, loff_t *offp)
+static ssize_t tool_spad_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_spad *spad = filep->private_data;
+	struct tool_spad *spad = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	u32 val;
 	int ret;
 
@@ -1176,7 +1156,7 @@ static ssize_t tool_spad_write(struct file *filep, const char __user *ubuf,
 		return -EINVAL;
 	}
 
-	ret = kstrtou32_from_user(ubuf, size, 0, &val);
+	ret = kstrtou32_from_iter(from, size, 0, &val);
 	if (ret)
 		return ret;
 
@@ -1189,10 +1169,9 @@ static TOOL_FOPS_RDWR(tool_spad_fops,
 		      tool_spad_read,
 		      tool_spad_write);
 
-static ssize_t tool_peer_spad_read(struct file *filep, char __user *ubuf,
-				   size_t size, loff_t *offp)
+static ssize_t tool_peer_spad_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_spad *spad = filep->private_data;
+	struct tool_spad *spad = iocb->ki_filp->private_data;
 	char buf[TOOL_BUF_LEN];
 	ssize_t pos;
 
@@ -1202,13 +1181,13 @@ static ssize_t tool_peer_spad_read(struct file *filep, char __user *ubuf,
 	pos = scnprintf(buf, sizeof(buf), "%#x\n",
 		ntb_peer_spad_read(spad->tc->ntb, spad->pidx, spad->sidx));
 
-	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t tool_peer_spad_write(struct file *filep, const char __user *ubuf,
-				    size_t size, loff_t *offp)
+static ssize_t tool_peer_spad_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_spad *spad = filep->private_data;
+	struct tool_spad *spad = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	u32 val;
 	int ret;
 
@@ -1217,7 +1196,7 @@ static ssize_t tool_peer_spad_write(struct file *filep, const char __user *ubuf,
 		return -EINVAL;
 	}
 
-	ret = kstrtou32_from_user(ubuf, size, 0, &val);
+	ret = kstrtou32_from_iter(from, size, 0, &val);
 	if (ret)
 		return ret;
 
@@ -1271,10 +1250,9 @@ static int tool_init_spads(struct tool_ctx *tc)
  *==============================================================================
  */
 
-static ssize_t tool_inmsg_read(struct file *filep, char __user *ubuf,
-			       size_t size, loff_t *offp)
+static ssize_t tool_inmsg_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_msg *msg = filep->private_data;
+	struct tool_msg *msg = iocb->ki_filp->private_data;
 	char buf[TOOL_BUF_LEN];
 	ssize_t pos;
 	u32 data;
@@ -1284,22 +1262,21 @@ static ssize_t tool_inmsg_read(struct file *filep, char __user *ubuf,
 
 	pos = scnprintf(buf, sizeof(buf), "0x%08x<-%d\n", data, pidx);
 
-	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static TOOL_FOPS_RDWR(tool_inmsg_fops,
 		      tool_inmsg_read,
 		      NULL);
 
-static ssize_t tool_outmsg_write(struct file *filep,
-				 const char __user *ubuf,
-				 size_t size, loff_t *offp)
+static ssize_t tool_outmsg_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_msg *msg = filep->private_data;
+	struct tool_msg *msg = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	u32 val;
 	int ret;
 
-	ret = kstrtou32_from_user(ubuf, size, 0, &val);
+	ret = kstrtou32_from_iter(from, size, 0, &val);
 	if (ret)
 		return ret;
 
@@ -1312,58 +1289,51 @@ static TOOL_FOPS_RDWR(tool_outmsg_fops,
 		      NULL,
 		      tool_outmsg_write);
 
-static ssize_t tool_msg_sts_read(struct file *filep, char __user *ubuf,
-				 size_t size, loff_t *offp)
+static ssize_t tool_msg_sts_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->msg_read_sts);
+	return tool_fn_read(tc, iocb, to, tc->ntb->ops->msg_read_sts);
 }
 
-static ssize_t tool_msg_sts_write(struct file *filep, const char __user *ubuf,
-				  size_t size, loff_t *offp)
+static ssize_t tool_msg_sts_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_write(tc, ubuf, size, offp, NULL,
-			     tc->ntb->ops->msg_clear_sts);
+	return tool_fn_write(tc, iocb, from, NULL, tc->ntb->ops->msg_clear_sts);
 }
 
 static TOOL_FOPS_RDWR(tool_msg_sts_fops,
 		      tool_msg_sts_read,
 		      tool_msg_sts_write);
 
-static ssize_t tool_msg_inbits_read(struct file *filep, char __user *ubuf,
-				    size_t size, loff_t *offp)
+static ssize_t tool_msg_inbits_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->msg_inbits);
+	return tool_fn_read(tc, iocb, to, tc->ntb->ops->msg_inbits);
 }
 
 static TOOL_FOPS_RDWR(tool_msg_inbits_fops,
 		      tool_msg_inbits_read,
 		      NULL);
 
-static ssize_t tool_msg_outbits_read(struct file *filep, char __user *ubuf,
-				     size_t size, loff_t *offp)
+static ssize_t tool_msg_outbits_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_read(tc, ubuf, size, offp, tc->ntb->ops->msg_outbits);
+	return tool_fn_read(tc, iocb, to, tc->ntb->ops->msg_outbits);
 }
 
 static TOOL_FOPS_RDWR(tool_msg_outbits_fops,
 		      tool_msg_outbits_read,
 		      NULL);
 
-static ssize_t tool_msg_mask_write(struct file *filep, const char __user *ubuf,
-				   size_t size, loff_t *offp)
+static ssize_t tool_msg_mask_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
 
-	return tool_fn_write(tc, ubuf, size, offp,
-			     tc->ntb->ops->msg_set_mask,
+	return tool_fn_write(tc, iocb, from, tc->ntb->ops->msg_set_mask,
 			     tc->ntb->ops->msg_clear_mask);
 }
 
@@ -1371,15 +1341,14 @@ static TOOL_FOPS_RDWR(tool_msg_mask_fops,
 		      NULL,
 		      tool_msg_mask_write);
 
-static ssize_t tool_msg_event_write(struct file *filep,
-				    const char __user *ubuf,
-				    size_t size, loff_t *offp)
+static ssize_t tool_msg_event_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct tool_ctx *tc = filep->private_data;
+	struct tool_ctx *tc = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	u64 val;
 	int ret;
 
-	ret = kstrtou64_from_user(ubuf, size, 0, &val);
+	ret = kstrtou64_from_iter(from, size, 0, &val);
 	if (ret)
 		return ret;
 
-- 
2.43.0


