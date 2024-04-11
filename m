Return-Path: <linux-kernel+bounces-141116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D68D8A1A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4402B1C225D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF1C1E7959;
	Thu, 11 Apr 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FJFRpNC4"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1FF1E7921
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850062; cv=none; b=AqFb/KbRVMh0M3O0jlHIOdiBkYn2fWSeZ0FY2DddRGHMU73nPF696D/4hXRFPIncvtbc2fmkzzFrynqFjAeb3BMFbEapgLmIR7TPICZkJtnhshUjndWXlfCmj+3DguQWpC15hOMPiEW/4MycTnd5xNge4WjLDOLOis36mVxnFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850062; c=relaxed/simple;
	bh=jth+F4uG70vpe2kxvXga6lwNcJInrS0k3t+O9eF+9cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ds08Njj3vFM5TiBM0W89NXcW3NXUPN5Bgvf4uXYCUT95rH7Cm8cq3YHEajG7N2eik9gcbl/7tlgqOAQIc3a+c5sneraAp1lpzvb8dpfDCZLM6kjPPomYr8+GtXKMoRuz6Q44ZnOtY+201fB/4BJFSfz+rZLVgeU00DTircNIlzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FJFRpNC4; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36a224d7414so194055ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850059; x=1713454859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkBOZHCj0mE4s6Wdz7tnu5mnp36Z+tn/wx/FdDRdxgE=;
        b=FJFRpNC49EeXqMuP3b9SAnsRDHlkeeHIsIhi7Htq5UXTqD4Venf2vQ4uAASHXDBBVp
         khBOYbVrQVNLA8lH3nNTjU9EX0bdb9MUXdP6lv/goIRMfrWNDFxxsp9QJ7pKBLrl2eNH
         KspjXHsqYG9FiKg9qw/wN1lNTRsUtAOCLzYNEraTm0Bmow4br/OBkINbszBc4BZ1ShdA
         F93DXWt1juCwsHzq8UXgb2/1FzwQbQfIdwdsn0vUsk90dzhVNVEkQIt8jHWkjyigsGdp
         x8+xSI38c71NCs9U9I9GdCa3hJ58EwsKn6mirOKSrM9FEEh86A5DwcmFT1/+wVNfJXN9
         5KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850059; x=1713454859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkBOZHCj0mE4s6Wdz7tnu5mnp36Z+tn/wx/FdDRdxgE=;
        b=cn6w6q8gzKa6tZlXf1mxUVPUqzJHEPQ6mPLlrTYOGJ4yB3pN9cgOm9gDeUnXWi/WXs
         mpdLXfYFyFl+asDsKSkbVZ+DyGJt8kJHwIG6as3G7/GfmPQe6pjV0liSRPPgRxa219p4
         T1PXE2iC3uxL/flD7xr9UOjc/UEZ1DZWO+t5riVJY6rXnW4e7bRyKe0898M2Dn33bRUt
         8yVYzhDySgvUH9jwajzkf5RslZ5y4MPlNMiXN4v/Qmob335eIyHD0hytLZadBc4gtvl1
         OzSz6eoUHnX8AQXjTqLMj0NmiHcvvNTBcICgoyCd0LvgSEydwg+wg5ulAh+QAVbWG45V
         PaMA==
X-Gm-Message-State: AOJu0Yz2f8rmmHoonSaaXCKaR4DeVsQz6W22THc810qHjvLadlkKD3mX
	u6qZtC0XmLVCnpgJ4rvF23onWaxNWkdAAxie3yUxwhTXjwmL/1uEmwXOWX208q47GkcVMqPuGhj
	R
X-Google-Smtp-Source: AGHT+IHANMRC/OqyyT5nzJmEm8dFpxo/Sq1GVyItdO/jf9Y+VJ4GQ3gs22GIiu0fBZr8bFokQxb6bg==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr199420iob.0.1712850059176;
        Thu, 11 Apr 2024 08:40:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 337/437] powerpc/kernel: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:57 -0600
Message-ID: <20240411153126.16201-338-axboe@kernel.dk>
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
 arch/powerpc/kernel/eeh.c | 58 ++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index ab316e155ea9..35ea1c80e0de 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1588,9 +1588,8 @@ static int proc_eeh_show(struct seq_file *m, void *v)
 #ifdef CONFIG_DEBUG_FS
 
 
-static struct pci_dev *eeh_debug_lookup_pdev(struct file *filp,
-					     const char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static struct pci_dev *eeh_debug_lookup_pdev(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
 	uint32_t domain, bus, dev, fn;
 	struct pci_dev *pdev;
@@ -1598,7 +1597,7 @@ static struct pci_dev *eeh_debug_lookup_pdev(struct file *filp,
 	int ret;
 
 	memset(buf, 0, sizeof(buf));
-	ret = simple_write_to_buffer(buf, sizeof(buf)-1, ppos, user_buf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf)-1, from);
 	if (!ret)
 		return ERR_PTR(-EFAULT);
 
@@ -1637,17 +1636,16 @@ static int eeh_enable_dbgfs_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(eeh_enable_dbgfs_ops, eeh_enable_dbgfs_get,
 			 eeh_enable_dbgfs_set, "0x%llx\n");
 
-static ssize_t eeh_force_recover_write(struct file *filp,
-				const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t eeh_force_recover_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct pci_controller *hose;
 	uint32_t phbid, pe_no;
 	struct eeh_pe *pe;
 	char buf[20];
 	int ret;
 
-	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf), from);
 	if (!ret)
 		return -EFAULT;
 
@@ -1690,28 +1688,23 @@ static ssize_t eeh_force_recover_write(struct file *filp,
 static const struct file_operations eeh_force_recover_fops = {
 	.open	= simple_open,
 	.llseek	= no_llseek,
-	.write	= eeh_force_recover_write,
+	.write_iter = eeh_force_recover_write,
 };
 
-static ssize_t eeh_debugfs_dev_usage(struct file *filp,
-				char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t eeh_debugfs_dev_usage(struct kiocb *iocb, struct iov_iter *to)
 {
 	static const char usage[] = "input format: <domain>:<bus>:<dev>.<fn>\n";
 
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       usage, sizeof(usage) - 1);
+	return simple_copy_to_iter(usage, &iocb->ki_pos, sizeof(usage) - 1, to);
 }
 
-static ssize_t eeh_dev_check_write(struct file *filp,
-				const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t eeh_dev_check_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct pci_dev *pdev;
 	struct eeh_dev *edev;
 	int ret;
 
-	pdev = eeh_debug_lookup_pdev(filp, user_buf, count, ppos);
+	pdev = eeh_debug_lookup_pdev(iocb, from);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
@@ -1728,14 +1721,14 @@ static ssize_t eeh_dev_check_write(struct file *filp,
 
 	pci_dev_put(pdev);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations eeh_dev_check_fops = {
 	.open	= simple_open,
 	.llseek	= no_llseek,
-	.write	= eeh_dev_check_write,
-	.read   = eeh_debugfs_dev_usage,
+	.write_iter = eeh_dev_check_write,
+	.read_iter = eeh_debugfs_dev_usage,
 };
 
 static int eeh_debugfs_break_device(struct pci_dev *pdev)
@@ -1831,14 +1824,12 @@ static int eeh_debugfs_break_device(struct pci_dev *pdev)
 	return 0;
 }
 
-static ssize_t eeh_dev_break_write(struct file *filp,
-				const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t eeh_dev_break_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct pci_dev *pdev;
 	int ret;
 
-	pdev = eeh_debug_lookup_pdev(filp, user_buf, count, ppos);
+	pdev = eeh_debug_lookup_pdev(iocb, from);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
@@ -1848,25 +1839,24 @@ static ssize_t eeh_dev_break_write(struct file *filp,
 	if (ret < 0)
 		return ret;
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations eeh_dev_break_fops = {
 	.open	= simple_open,
 	.llseek	= no_llseek,
-	.write	= eeh_dev_break_write,
-	.read   = eeh_debugfs_dev_usage,
+	.write_iter = eeh_dev_break_write,
+	.read_iter = eeh_debugfs_dev_usage,
 };
 
-static ssize_t eeh_dev_can_recover(struct file *filp,
-				   const char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t eeh_dev_can_recover(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct pci_driver *drv;
 	struct pci_dev *pdev;
 	size_t ret;
 
-	pdev = eeh_debug_lookup_pdev(filp, user_buf, count, ppos);
+	pdev = eeh_debug_lookup_pdev(iocb, from);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
@@ -1901,8 +1891,8 @@ static ssize_t eeh_dev_can_recover(struct file *filp,
 static const struct file_operations eeh_dev_can_recover_fops = {
 	.open	= simple_open,
 	.llseek	= no_llseek,
-	.write	= eeh_dev_can_recover,
-	.read   = eeh_debugfs_dev_usage,
+	.write_iter = eeh_dev_can_recover,
+	.read_iter = eeh_debugfs_dev_usage,
 };
 
 #endif
-- 
2.43.0


