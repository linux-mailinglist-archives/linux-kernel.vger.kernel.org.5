Return-Path: <linux-kernel+bounces-140901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8F8A1981
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69593286628
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F069E15E804;
	Thu, 11 Apr 2024 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QF6uCep/"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF115CD7E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849736; cv=none; b=Oc2LMIz/mOqeuNj+bBvRQ5GTCm3tZJ0kHpXqKxWCVBpKGllGtJHq/fA+Ze0UJSX+ZPlQI5vELfvtfdabm2GU3RpXo1kUhDSq6vYZxKdKyxnCXHAwVqvibzlSro+t4SvH9SshngzC4L5+WnxNwx8OTMp+XymeH1MR2KeDNB3v32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849736; c=relaxed/simple;
	bh=2jr1PdrVceH4PaPnyYhMso5x8m+nWkb8VS7w/9lfGfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcD9em7apXFIZNmJUVUDZLrfxaK7WX9dUb/zAgvkgGpj8f+6FYQAEmtWOu6RCWkk2ukviWKHDHY84p+1hb187LHXzxWh20KDDXUskn3odVK4ypnvA1mbNqJ6bZqi0FTR+L2WahTYmgLEReQypvhFzOVPJmBu9QXaUTOnHRMy+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QF6uCep/; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9778439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849732; x=1713454532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMZovEpiWCkttFZIAVtQYL16N1CzowLfOrVR8pz0BT8=;
        b=QF6uCep/jlk7wQ2mW6T9Z/q5f2vXoS2s+N5fnt4Wzumis0BCtKxMZr90LbGqTFvV8B
         VAWKLYsmvslwKuX83kfalHmNF2Hx3Z8iCGSdu1PfPZqA340xtHoLQxsTj+wQS7lBGBxw
         J5mPdaEUXyivd8RmTPT/jJsJHGSaQjyE8lBqc11/WVhEXpHnOwVffwgkE+1H72bmZ0uH
         LtqPpvHWzaZSGY6a+g49duEMhKbb3ecWJo/haGE9zwWwsKmm5+w0a8rvHAeXCuW859t8
         4brt6XTtK+cotDeJcBoYZIrAFcUqVGFzZ5Rzc0b8EQMO1D4Dkd5vrHU/l6a9qhpLJ8rI
         xH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849732; x=1713454532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMZovEpiWCkttFZIAVtQYL16N1CzowLfOrVR8pz0BT8=;
        b=lbnFvQnjPL+xIJ0VuzAyNt1EL6KWSRLu4fl5v7jsQOHjmVYFIRmmadPV9y0rXBfmy/
         Nk53kp2Q95uKQLHHLwVOFOeGryJDLOpzzxtLGycn9kllDv0MCnVZtqydm4slFT2ziw7g
         eWXLpHCQvo6YropKR1WmEFNfeQYCXc/R9Dholsx5V1oaAjDMZMSVoU0z56kia9CPkzmQ
         fc11f/7usAHghiLqp2NVrrDli8U1Q/DWvzpTZXq4Q0Tq6nNfIr8HRrnglb60vKBo4gUi
         6AN/V4OVdoWpJ/ScVfkwHw0ffg8JIKK++SqmA9yp9Edp9w4A+PVbCFXxLWQl1VP1YV+T
         mTwg==
X-Gm-Message-State: AOJu0YzdTIfG/0/yH9KMneVx1GgQBBYN6mnWVRMXBZyRsRplBaOL35He
	5AelfUU+NO5BfclD8d5uDczhOKokZTllsG1oiLkftg8P3GWtSg1mtlLlOknCVHUaMzkDpLYbihE
	s
X-Google-Smtp-Source: AGHT+IEpyxFj+MrEfNGu8fz+KVelChQZTTr487wTd4G41eDA2PHllZ9LYq0wU6JBwsq3MMIHxoRqjw==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr192423iop.1.1712849731865;
        Thu, 11 Apr 2024 08:35:31 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 139/437] drm: amd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:39 -0600
Message-ID: <20240411153126.16201-140-axboe@kernel.dk>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  71 +++++++----
 .../drm/amd/amdgpu/amdgpu_fw_attestation.c    |  23 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c    |  18 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c       |  14 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  34 +++---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  22 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_securedisplay.c |  14 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  56 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c      |  13 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  19 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 111 ++++++++++--------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  11 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  17 +--
 17 files changed, 231 insertions(+), 209 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 493982f94649..8fd471e72ae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -840,7 +840,7 @@ static int aca_dump_ce_open(struct inode *inode, struct file *file)
 static const struct file_operations aca_ce_dump_debug_fops = {
 	.owner = THIS_MODULE,
 	.open = aca_dump_ce_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -858,7 +858,7 @@ static int aca_dump_ue_open(struct inode *inode, struct file *file)
 static const struct file_operations aca_ue_dump_debug_fops = {
 	.owner = THIS_MODULE,
 	.open = aca_dump_ue_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f5d0fa207a88..f816d92430ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -194,6 +194,7 @@ static ssize_t amdgpu_debugfs_regs_read(struct file *f, char __user *buf,
 {
 	return amdgpu_debugfs_process_reg_op(true, f, buf, size, pos);
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_regs_read);
 
 /*
  * amdgpu_debugfs_regs_write - Callback for writing MMIO registers
@@ -203,6 +204,7 @@ static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
 {
 	return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, size, pos);
 }
+FOPS_WRITE_ITER_HELPER(amdgpu_debugfs_regs_write);
 
 static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
 {
@@ -365,11 +367,13 @@ static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *buf, size_
 {
 	return amdgpu_debugfs_regs2_op(f, buf, *pos, size, 0);
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_regs2_read);
 
 static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __user *buf, size_t size, loff_t *pos)
 {
 	return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1);
 }
+FOPS_WRITE_ITER_HELPER(amdgpu_debugfs_regs2_write);
 
 static int amdgpu_debugfs_gprwave_open(struct inode *inode, struct file *file)
 {
@@ -475,6 +479,7 @@ static ssize_t amdgpu_debugfs_gprwave_read(struct file *f, char __user *buf, siz
 	kfree(data);
 	return result;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_gprwave_read);
 
 static long amdgpu_debugfs_gprwave_ioctl(struct file *f, unsigned int cmd, unsigned long data)
 {
@@ -562,6 +567,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	amdgpu_virt_disable_access_debugfs(adev);
 	return r;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_regs_pcie_read);
 
 /**
  * amdgpu_debugfs_regs_pcie_write - Write to a PCIE register
@@ -622,6 +628,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 	amdgpu_virt_disable_access_debugfs(adev);
 	return r;
 }
+FOPS_WRITE_ITER_HELPER(amdgpu_debugfs_regs_pcie_write);
 
 /**
  * amdgpu_debugfs_regs_didt_read - Read from a DIDT register
@@ -681,6 +688,7 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	amdgpu_virt_disable_access_debugfs(adev);
 	return r;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_regs_didt_read);
 
 /**
  * amdgpu_debugfs_regs_didt_write - Write to a DIDT register
@@ -741,6 +749,7 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	amdgpu_virt_disable_access_debugfs(adev);
 	return r;
 }
+FOPS_WRITE_ITER_HELPER(amdgpu_debugfs_regs_didt_write);
 
 /**
  * amdgpu_debugfs_regs_smc_read - Read from a SMC register
@@ -800,6 +809,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	amdgpu_virt_disable_access_debugfs(adev);
 	return r;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_regs_smc_read);
 
 /**
  * amdgpu_debugfs_regs_smc_write - Write to a SMC register
@@ -860,6 +870,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	amdgpu_virt_disable_access_debugfs(adev);
 	return r;
 }
+FOPS_WRITE_ITER_HELPER(amdgpu_debugfs_regs_smc_write);
 
 /**
  * amdgpu_debugfs_gca_config_read - Read from gfx config data
@@ -957,6 +968,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
 	kfree(config);
 	return result;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_gca_config_read);
 
 /**
  * amdgpu_debugfs_sensor_read - Read from the powerplay sensors
@@ -1030,6 +1042,7 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
 	amdgpu_virt_disable_access_debugfs(adev);
 	return !r ? outsize : r;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_sensor_read);
 
 /** amdgpu_debugfs_wave_read - Read WAVE STATUS data
  *
@@ -1121,6 +1134,7 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 	amdgpu_virt_disable_access_debugfs(adev);
 	return result;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_wave_read);
 
 /** amdgpu_debugfs_gpr_read - Read wave gprs
  *
@@ -1219,6 +1233,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	kfree(data);
 	return r;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_gpr_read);
 
 /**
  * amdgpu_debugfs_gfxoff_residency_read - Read GFXOFF residency
@@ -1271,6 +1286,7 @@ static ssize_t amdgpu_debugfs_gfxoff_residency_read(struct file *f, char __user
 
 	return r;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_gfxoff_residency_read);
 
 /**
  * amdgpu_debugfs_gfxoff_residency_write - Log GFXOFF Residency
@@ -1320,7 +1336,7 @@ static ssize_t amdgpu_debugfs_gfxoff_residency_write(struct file *f, const char
 
 	return r;
 }
-
+FOPS_WRITE_ITER_HELPER(amdgpu_debugfs_gfxoff_residency_write);
 
 /**
  * amdgpu_debugfs_gfxoff_count_read - Read GFXOFF entry count
@@ -1370,6 +1386,7 @@ static ssize_t amdgpu_debugfs_gfxoff_count_read(struct file *f, char __user *buf
 
 	return r;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_gfxoff_count_read);
 
 /**
  * amdgpu_debugfs_gfxoff_write - Enable/disable GFXOFF
@@ -1419,7 +1436,7 @@ static ssize_t amdgpu_debugfs_gfxoff_write(struct file *f, const char __user *bu
 
 	return r;
 }
-
+FOPS_WRITE_ITER_HELPER(amdgpu_debugfs_gfxoff_write);
 
 /**
  * amdgpu_debugfs_gfxoff_read - read gfxoff status
@@ -1465,6 +1482,7 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
 
 	return r;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_gfxoff_read);
 
 static ssize_t amdgpu_debugfs_gfxoff_status_read(struct file *f, char __user *buf,
 						 size_t size, loff_t *pos)
@@ -1506,12 +1524,13 @@ static ssize_t amdgpu_debugfs_gfxoff_status_read(struct file *f, char __user *bu
 
 	return r;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_gfxoff_status_read);
 
 static const struct file_operations amdgpu_debugfs_regs2_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
-	.read = amdgpu_debugfs_regs2_read,
-	.write = amdgpu_debugfs_regs2_write,
+	.read_iter = amdgpu_debugfs_regs2_read_iter,
+	.write_iter = amdgpu_debugfs_regs2_write_iter,
 	.open = amdgpu_debugfs_regs2_open,
 	.release = amdgpu_debugfs_regs2_release,
 	.llseek = default_llseek
@@ -1520,7 +1539,7 @@ static const struct file_operations amdgpu_debugfs_regs2_fops = {
 static const struct file_operations amdgpu_debugfs_gprwave_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = amdgpu_debugfs_gprwave_ioctl,
-	.read = amdgpu_debugfs_gprwave_read,
+	.read_iter = amdgpu_debugfs_gprwave_read_iter,
 	.open = amdgpu_debugfs_gprwave_open,
 	.release = amdgpu_debugfs_gprwave_release,
 	.llseek = default_llseek
@@ -1528,75 +1547,75 @@ static const struct file_operations amdgpu_debugfs_gprwave_fops = {
 
 static const struct file_operations amdgpu_debugfs_regs_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_regs_read,
-	.write = amdgpu_debugfs_regs_write,
+	.read_iter = amdgpu_debugfs_regs_read_iter,
+	.write_iter = amdgpu_debugfs_regs_write_iter,
 	.llseek = default_llseek
 };
 static const struct file_operations amdgpu_debugfs_regs_didt_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_regs_didt_read,
-	.write = amdgpu_debugfs_regs_didt_write,
+	.read_iter = amdgpu_debugfs_regs_didt_read_iter,
+	.write_iter = amdgpu_debugfs_regs_didt_write_iter,
 	.llseek = default_llseek
 };
 static const struct file_operations amdgpu_debugfs_regs_pcie_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_regs_pcie_read,
-	.write = amdgpu_debugfs_regs_pcie_write,
+	.read_iter = amdgpu_debugfs_regs_pcie_read_iter,
+	.write_iter = amdgpu_debugfs_regs_pcie_write_iter,
 	.llseek = default_llseek
 };
 static const struct file_operations amdgpu_debugfs_regs_smc_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_regs_smc_read,
-	.write = amdgpu_debugfs_regs_smc_write,
+	.read_iter = amdgpu_debugfs_regs_smc_read_iter,
+	.write_iter = amdgpu_debugfs_regs_smc_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations amdgpu_debugfs_gca_config_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_gca_config_read,
+	.read_iter = amdgpu_debugfs_gca_config_read_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations amdgpu_debugfs_sensors_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_sensor_read,
+	.read_iter = amdgpu_debugfs_sensor_read_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations amdgpu_debugfs_wave_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_wave_read,
+	.read_iter = amdgpu_debugfs_wave_read_iter,
 	.llseek = default_llseek
 };
 static const struct file_operations amdgpu_debugfs_gpr_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_gpr_read,
+	.read_iter = amdgpu_debugfs_gpr_read_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_gfxoff_read,
-	.write = amdgpu_debugfs_gfxoff_write,
+	.read_iter = amdgpu_debugfs_gfxoff_read_iter,
+	.write_iter = amdgpu_debugfs_gfxoff_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations amdgpu_debugfs_gfxoff_status_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_gfxoff_status_read,
+	.read_iter = amdgpu_debugfs_gfxoff_status_read_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations amdgpu_debugfs_gfxoff_count_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_gfxoff_count_read,
+	.read_iter = amdgpu_debugfs_gfxoff_count_read_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations amdgpu_debugfs_gfxoff_residency_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_gfxoff_residency_read,
-	.write = amdgpu_debugfs_gfxoff_residency_write,
+	.read_iter = amdgpu_debugfs_gfxoff_residency_read_iter,
+	.write_iter = amdgpu_debugfs_gfxoff_residency_write_iter,
 	.llseek = default_llseek
 };
 
@@ -2058,6 +2077,7 @@ static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
 
 	return len;
 }
+FOPS_READ_ITER_HELPER(amdgpu_reset_dump_register_list_read);
 
 static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 			const char __user *buf, size_t size, loff_t *pos)
@@ -2111,11 +2131,12 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 	kfree(new);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(amdgpu_reset_dump_register_list_write);
 
 static const struct file_operations amdgpu_reset_dump_register_list = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_reset_dump_register_list_read,
-	.write = amdgpu_reset_dump_register_list_write,
+	.read_iter = amdgpu_reset_dump_register_list_read_iter,
+	.write_iter = amdgpu_reset_dump_register_list_write_iter,
 	.llseek = default_llseek
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
index 2d4b67175b55..a5edb6de1c10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
@@ -50,23 +50,22 @@ struct FW_ATT_RECORD {
 	uint32_t AttFwTaId;              /* Ta ID (only in TA Attestation Table) */
 };
 
-static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
-						  char __user *buf,
-						  size_t size,
-						  loff_t *pos)
+static ssize_t amdgpu_fw_attestation_debugfs_read(struct kiocb *iocb,
+						  struct iov_iter *to)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_device *adev = file_inode(iocb->ki_filp)->i_private;
 	uint64_t records_addr = 0;
 	uint64_t vram_pos = 0;
 	struct FW_ATT_DB_HEADER fw_att_hdr = {0};
 	struct FW_ATT_RECORD fw_att_record = {0};
+	size_t size = iov_iter_count(to);
 
 	if (size < sizeof(struct FW_ATT_RECORD)) {
 		DRM_WARN("FW attestation input buffer not enough memory");
 		return -EINVAL;
 	}
 
-	if ((*pos + sizeof(struct FW_ATT_DB_HEADER)) >= FW_ATTESTATION_MAX_SIZE) {
+	if ((iocb->ki_pos + sizeof(struct FW_ATT_DB_HEADER)) >= FW_ATTESTATION_MAX_SIZE) {
 		DRM_WARN("FW attestation out of bounds");
 		return 0;
 	}
@@ -78,7 +77,7 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
 
 	vram_pos =  records_addr - adev->gmc.vram_start;
 
-	if (*pos == 0) {
+	if (iocb->ki_pos == 0) {
 		amdgpu_device_vram_access(adev,
 					  vram_pos,
 					  (uint32_t *)&fw_att_hdr,
@@ -94,7 +93,7 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
 	}
 
 	amdgpu_device_vram_access(adev,
-				  vram_pos + sizeof(struct FW_ATT_DB_HEADER) + *pos,
+				  vram_pos + sizeof(struct FW_ATT_DB_HEADER) + iocb->ki_pos,
 				  (uint32_t *)&fw_att_record,
 				  sizeof(struct FW_ATT_RECORD),
 				  false);
@@ -102,18 +101,16 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
 	if (fw_att_record.RecordValid != FW_ATTESTATION_RECORD_VALID)
 		return 0;
 
-	if (copy_to_user(buf, (void *)&fw_att_record, sizeof(struct FW_ATT_RECORD)))
+	if (!copy_to_iter_full((void *)&fw_att_record, sizeof(struct FW_ATT_RECORD), to))
 		return -EINVAL;
 
-	*pos += sizeof(struct FW_ATT_RECORD);
-
+	iocb->ki_pos += sizeof(struct FW_ATT_RECORD);
 	return sizeof(struct FW_ATT_RECORD);
 }
 
 static const struct file_operations amdgpu_fw_attestation_debugfs_ops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_fw_attestation_debugfs_read,
-	.write = NULL,
+	.read_iter = amdgpu_fw_attestation_debugfs_read,
 	.llseek = default_llseek
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 24ad4b97177b..c6a971a260df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -480,7 +480,7 @@ static int mca_dump_ce_open(struct inode *inode, struct file *file)
 static const struct file_operations mca_ce_dump_debug_fops = {
 	.owner = THIS_MODULE,
 	.open = mca_dump_ce_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -498,7 +498,7 @@ static int mca_dump_ue_open(struct inode *inode, struct file *file)
 static const struct file_operations mca_ue_dump_debug_fops = {
 	.owner = THIS_MODULE,
 	.open = mca_dump_ue_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index ca5c86e5f7cd..f96fde084fc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -26,12 +26,9 @@
 
 #if defined(CONFIG_DEBUG_FS)
 
-static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf,
-					    size_t len, loff_t *off);
-static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf,
-					    size_t len, loff_t *off);
-static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf,
-					    size_t len, loff_t *off);
+static ssize_t ta_if_load_debugfs_write_iter(struct kiocb *, struct iov_iter *);
+static ssize_t ta_if_unload_debugfs_write_iter(struct kiocb *, struct iov_iter *);
+static ssize_t ta_if_invoke_debugfs_write_iter(struct kiocb *, struct iov_iter *);
 
 static uint32_t get_bin_version(const uint8_t *bin)
 {
@@ -84,19 +81,19 @@ static void set_ta_context_funcs(struct psp_context *psp,
 }
 
 static const struct file_operations ta_load_debugfs_fops = {
-	.write  = ta_if_load_debugfs_write,
+	.write_iter  = ta_if_load_debugfs_write_iter,
 	.llseek = default_llseek,
 	.owner  = THIS_MODULE
 };
 
 static const struct file_operations ta_unload_debugfs_fops = {
-	.write  = ta_if_unload_debugfs_write,
+	.write_iter  = ta_if_unload_debugfs_write_iter,
 	.llseek = default_llseek,
 	.owner  = THIS_MODULE
 };
 
 static const struct file_operations ta_invoke_debugfs_fops = {
-	.write  = ta_if_invoke_debugfs_write,
+	.write_iter  = ta_if_invoke_debugfs_write_iter,
 	.llseek = default_llseek,
 	.owner  = THIS_MODULE
 };
@@ -240,6 +237,7 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(ta_if_load_debugfs_write);
 
 static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
 {
@@ -286,6 +284,7 @@ static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf, size
 
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(ta_if_unload_debugfs_write);
 
 static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
 {
@@ -370,6 +369,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(ta_if_invoke_debugfs_write);
 
 void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
index 123bcf5c2bb1..b946c94972b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
@@ -40,21 +40,22 @@
  * from header file ta_rap_if.h
  *
  */
-static ssize_t amdgpu_rap_debugfs_write(struct file *f, const char __user *buf,
-		size_t size, loff_t *pos)
+static ssize_t amdgpu_rap_debugfs_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_device *adev = file_inode(iocb->ki_filp)->i_private;
 	struct ta_rap_shared_memory *rap_shared_mem;
 	struct ta_rap_cmd_output_data *rap_cmd_output;
 	struct drm_device *dev = adev_to_drm(adev);
+	size_t size = iov_iter_count(from);
 	uint32_t op;
 	enum ta_rap_status status;
 	int ret;
 
-	if (*pos || size != 2)
+	if (iocb->ki_pos || size != 2)
 		return -EINVAL;
 
-	ret = kstrtouint_from_user(buf, size, *pos, &op);
+	ret = kstrtouint_from_iter(from, size, iocb->ki_pos, &op);
 	if (ret)
 		return ret;
 
@@ -109,8 +110,7 @@ static ssize_t amdgpu_rap_debugfs_write(struct file *f, const char __user *buf,
 
 static const struct file_operations amdgpu_rap_debugfs_ops = {
 	.owner = THIS_MODULE,
-	.read = NULL,
-	.write = amdgpu_rap_debugfs_write,
+	.write_iter = amdgpu_rap_debugfs_write,
 	.llseek = default_llseek
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8ebab6f22e5a..f8daf833f0c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -201,13 +201,13 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 	return 0;
 }
 
-static ssize_t amdgpu_ras_debugfs_read(struct file *f, char __user *buf,
-					size_t size, loff_t *pos)
+static ssize_t amdgpu_ras_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ras_manager *obj = (struct ras_manager *)file_inode(f)->i_private;
+	struct ras_manager *obj = file_inode(iocb->ki_filp)->i_private;
 	struct ras_query_if info = {
 		.head = obj->head,
 	};
+	size_t size = iov_iter_count(to);
 	ssize_t s;
 	char val[128];
 
@@ -224,25 +224,23 @@ static ssize_t amdgpu_ras_debugfs_read(struct file *f, char __user *buf,
 	s = snprintf(val, sizeof(val), "%s: %lu\n%s: %lu\n",
 			"ue", info.ue_count,
 			"ce", info.ce_count);
-	if (*pos >= s)
+	if (iocb->ki_pos >= s)
 		return 0;
 
-	s -= *pos;
+	s -= iocb->ki_pos;
 	s = min_t(u64, s, size);
 
 
-	if (copy_to_user(buf, &val[*pos], s))
+	if (!copy_to_iter_full(&val[iocb->ki_pos], s, to))
 		return -EINVAL;
 
-	*pos += s;
-
+	iocb->ki_pos += s;
 	return s;
 }
 
 static const struct file_operations amdgpu_ras_debugfs_ops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_ras_debugfs_read,
-	.write = NULL,
+	.read_iter = amdgpu_ras_debugfs_read,
 	.llseek = default_llseek
 };
 
@@ -541,6 +539,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(amdgpu_ras_debugfs_ctrl_write);
 
 /**
  * DOC: AMDGPU RAS debugfs EEPROM table reset interface
@@ -558,12 +557,11 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
  * will reset EEPROM table to 0 entries.
  *
  */
-static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f,
-					       const char __user *buf,
-					       size_t size, loff_t *pos)
+static ssize_t amdgpu_ras_debugfs_eeprom_write(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct amdgpu_device *adev =
-		(struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_device *adev = file_inode(iocb->ki_filp)->i_private;
+	size_t size = iov_iter_count(from);
 	int ret;
 
 	ret = amdgpu_ras_eeprom_reset_table(
@@ -581,15 +579,13 @@ static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f,
 
 static const struct file_operations amdgpu_ras_debugfs_ctrl_ops = {
 	.owner = THIS_MODULE,
-	.read = NULL,
-	.write = amdgpu_ras_debugfs_ctrl_write,
+	.write_iter = amdgpu_ras_debugfs_ctrl_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations amdgpu_ras_debugfs_eeprom_ops = {
 	.owner = THIS_MODULE,
-	.read = NULL,
-	.write = amdgpu_ras_debugfs_eeprom_write,
+	.write_iter = amdgpu_ras_debugfs_eeprom_write,
 	.llseek = default_llseek
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index b12808c0c331..4d62691e3804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1001,12 +1001,12 @@ uint32_t amdgpu_ras_eeprom_max_record_count(struct amdgpu_ras_eeprom_control *co
 }
 
 static ssize_t
-amdgpu_ras_debugfs_eeprom_size_read(struct file *f, char __user *buf,
-				    size_t size, loff_t *pos)
+amdgpu_ras_debugfs_eeprom_size_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_device *adev = file_inode(iocb->ki_filp)->i_private;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
+	size_t size = iov_iter_count(to);
 	u8 data[50];
 	int res;
 
@@ -1020,24 +1020,22 @@ amdgpu_ras_debugfs_eeprom_size_read(struct file *f, char __user *buf,
 			       RAS_TBL_SIZE_BYTES, control->ras_max_record_count);
 	}
 
-	if (*pos >= res)
+	if (iocb->ki_pos >= res)
 		return 0;
 
-	res -= *pos;
+	res -= iocb->ki_pos;
 	res = min_t(size_t, res, size);
 
-	if (copy_to_user(buf, &data[*pos], res))
+	if (!copy_to_iter_full(&data[iocb->ki_pos], res, to))
 		return -EFAULT;
 
-	*pos += res;
-
+	iocb->ki_pos += res;
 	return res;
 }
 
 const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_ras_debugfs_eeprom_size_read,
-	.write = NULL,
+	.read_iter = amdgpu_ras_debugfs_eeprom_size_read,
 	.llseek = default_llseek,
 };
 
@@ -1215,11 +1213,11 @@ amdgpu_ras_debugfs_eeprom_table_read(struct file *f, char __user *buf,
 		return amdgpu_ras_debugfs_table_read(f, buf, size, pos);
 	}
 }
+FOPS_READ_ITER_HELPER(amdgpu_ras_debugfs_eeprom_table_read);
 
 const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_ras_debugfs_eeprom_table_read,
-	.write = NULL,
+	.read_iter = amdgpu_ras_debugfs_eeprom_table_read_iter,
 	.llseek = default_llseek,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 06f0a6534a94..a03bc2765b88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -512,10 +512,11 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 
 	return result;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_ring_read);
 
 static const struct file_operations amdgpu_debugfs_ring_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_ring_read,
+	.read_iter = amdgpu_debugfs_ring_read_iter,
 	.llseek = default_llseek
 };
 
@@ -577,10 +578,11 @@ static ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,
 	kfree(kbuf);
 	return r;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_mqd_read);
 
 static const struct file_operations amdgpu_debugfs_mqd_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_mqd_read,
+	.read_iter = amdgpu_debugfs_mqd_read_iter,
 	.llseek = default_llseek
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 8ed0e073656f..f7bfa470979f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -88,23 +88,24 @@ void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct ta_securedis
 
 #if defined(CONFIG_DEBUG_FS)
 
-static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __user *buf,
-		size_t size, loff_t *pos)
+static ssize_t amdgpu_securedisplay_debugfs_write(struct kiocb *iocb,
+						  struct iov_iter *from)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_device *adev = file_inode(iocb->ki_filp)->i_private;
 	struct psp_context *psp = &adev->psp;
 	struct ta_securedisplay_cmd *securedisplay_cmd;
 	struct drm_device *dev = adev_to_drm(adev);
+	size_t size = iov_iter_count(from);
 	uint32_t phy_id;
 	uint32_t op;
 	char str[64];
 	int ret;
 
-	if (*pos || size > sizeof(str) - 1)
+	if (iocb->ki_pos || size > sizeof(str) - 1)
 		return -EINVAL;
 
 	memset(str,  0, sizeof(str));
-	ret = copy_from_user(str, buf, size);
+	ret = !copy_from_iter_full(str, size, from);
 	if (ret)
 		return -EFAULT;
 
@@ -163,8 +164,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 
 static const struct file_operations amdgpu_securedisplay_debugfs_ops = {
 	.owner = THIS_MODULE,
-	.read = NULL,
-	.write = amdgpu_securedisplay_debugfs_write,
+	.write_iter = amdgpu_securedisplay_debugfs_write,
 	.llseek = default_llseek
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index fc418e670fda..dd5a73291d85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2311,30 +2311,29 @@ DEFINE_SHOW_ATTRIBUTE(amdgpu_ttm_page_pool);
  *
  * Accesses VRAM via MMIO for debugging purposes.
  */
-static ssize_t amdgpu_ttm_vram_read(struct file *f, char __user *buf,
-				    size_t size, loff_t *pos)
+static ssize_t amdgpu_ttm_vram_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct amdgpu_device *adev = file_inode(f)->i_private;
+	struct amdgpu_device *adev = file_inode(iocb->ki_filp)->i_private;
+	size_t size = iov_iter_count(to);
 	ssize_t result = 0;
 
-	if (size & 0x3 || *pos & 0x3)
+	if (size & 0x3 || iocb->ki_pos & 0x3)
 		return -EINVAL;
 
-	if (*pos >= adev->gmc.mc_vram_size)
+	if (iocb->ki_pos >= adev->gmc.mc_vram_size)
 		return -ENXIO;
 
-	size = min(size, (size_t)(adev->gmc.mc_vram_size - *pos));
+	size = min(size, (size_t)(adev->gmc.mc_vram_size - iocb->ki_pos));
 	while (size) {
 		size_t bytes = min(size, AMDGPU_TTM_VRAM_MAX_DW_READ * 4);
 		uint32_t value[AMDGPU_TTM_VRAM_MAX_DW_READ];
 
-		amdgpu_device_vram_access(adev, *pos, value, bytes, false);
-		if (copy_to_user(buf, value, bytes))
+		amdgpu_device_vram_access(adev, iocb->ki_pos, value, bytes, false);
+		if (!copy_to_iter_full(value, bytes, to))
 			return -EFAULT;
 
 		result += bytes;
-		buf += bytes;
-		*pos += bytes;
+		iocb->ki_pos += bytes;
 		size -= bytes;
 	}
 
@@ -2379,11 +2378,12 @@ static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
 
 	return result;
 }
+FOPS_WRITE_ITER_HELPER(amdgpu_ttm_vram_write);
 
 static const struct file_operations amdgpu_ttm_vram_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_ttm_vram_read,
-	.write = amdgpu_ttm_vram_write,
+	.read_iter = amdgpu_ttm_vram_read,
+	.write_iter = amdgpu_ttm_vram_write_iter,
 	.llseek = default_llseek,
 };
 
@@ -2394,10 +2394,10 @@ static const struct file_operations amdgpu_ttm_vram_fops = {
  * GPU and the known addresses are not physical addresses but instead
  * bus addresses (e.g., what you'd put in an IB or ring buffer).
  */
-static ssize_t amdgpu_iomem_read(struct file *f, char __user *buf,
-				 size_t size, loff_t *pos)
+static ssize_t amdgpu_iomem_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct amdgpu_device *adev = file_inode(f)->i_private;
+	struct amdgpu_device *adev = file_inode(iocb->ki_filp)->i_private;
+	size_t size = iov_iter_count(to);
 	struct iommu_domain *dom;
 	ssize_t result = 0;
 	int r;
@@ -2406,8 +2406,8 @@ static ssize_t amdgpu_iomem_read(struct file *f, char __user *buf,
 	dom = iommu_get_domain_for_dev(adev->dev);
 
 	while (size) {
-		phys_addr_t addr = *pos & PAGE_MASK;
-		loff_t off = *pos & ~PAGE_MASK;
+		phys_addr_t addr = iocb->ki_pos & PAGE_MASK;
+		loff_t off = iocb->ki_pos & ~PAGE_MASK;
 		size_t bytes = PAGE_SIZE - off;
 		unsigned long pfn;
 		struct page *p;
@@ -2430,13 +2430,13 @@ static ssize_t amdgpu_iomem_read(struct file *f, char __user *buf,
 			return -EPERM;
 
 		ptr = kmap_local_page(p);
-		r = copy_to_user(buf, ptr + off, bytes);
+		r = !copy_to_iter_full(ptr + off, bytes, to);
 		kunmap_local(ptr);
 		if (r)
 			return -EFAULT;
 
 		size -= bytes;
-		*pos += bytes;
+		iocb->ki_pos += bytes;
 		result += bytes;
 	}
 
@@ -2450,10 +2450,10 @@ static ssize_t amdgpu_iomem_read(struct file *f, char __user *buf,
  * GPU and the known addresses are not physical addresses but instead
  * bus addresses (e.g., what you'd put in an IB or ring buffer).
  */
-static ssize_t amdgpu_iomem_write(struct file *f, const char __user *buf,
-				 size_t size, loff_t *pos)
+static ssize_t amdgpu_iomem_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct amdgpu_device *adev = file_inode(f)->i_private;
+	struct amdgpu_device *adev = file_inode(iocb->ki_filp)->i_private;
+	size_t size = iov_iter_count(from);
 	struct iommu_domain *dom;
 	ssize_t result = 0;
 	int r;
@@ -2461,8 +2461,8 @@ static ssize_t amdgpu_iomem_write(struct file *f, const char __user *buf,
 	dom = iommu_get_domain_for_dev(adev->dev);
 
 	while (size) {
-		phys_addr_t addr = *pos & PAGE_MASK;
-		loff_t off = *pos & ~PAGE_MASK;
+		phys_addr_t addr = iocb->ki_pos & PAGE_MASK;
+		loff_t off = iocb->ki_pos & ~PAGE_MASK;
 		size_t bytes = PAGE_SIZE - off;
 		unsigned long pfn;
 		struct page *p;
@@ -2481,13 +2481,13 @@ static ssize_t amdgpu_iomem_write(struct file *f, const char __user *buf,
 			return -EPERM;
 
 		ptr = kmap_local_page(p);
-		r = copy_from_user(ptr + off, buf, bytes);
+		r = !copy_from_iter_full(ptr + off, bytes, from);
 		kunmap_local(ptr);
 		if (r)
 			return -EFAULT;
 
 		size -= bytes;
-		*pos += bytes;
+		iocb->ki_pos += bytes;
 		result += bytes;
 	}
 
@@ -2496,8 +2496,8 @@ static ssize_t amdgpu_iomem_write(struct file *f, const char __user *buf,
 
 static const struct file_operations amdgpu_ttm_iomem_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_iomem_read,
-	.write = amdgpu_iomem_write,
+	.read_iter = amdgpu_iomem_read,
+	.write_iter = amdgpu_iomem_write,
 	.llseek = default_llseek
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9c514a606a2f..e2596f9fe6f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1142,10 +1142,11 @@ static ssize_t amdgpu_debugfs_vcn_fwlog_read(struct file *f, char __user *buf,
 	*pos += read_bytes;
 	return read_bytes;
 }
+FOPS_READ_ITER_HELPER(amdgpu_debugfs_vcn_fwlog_read);
 
 static const struct file_operations amdgpu_debugfs_vcnfwlog_fops = {
 	.owner = THIS_MODULE,
-	.read = amdgpu_debugfs_vcn_fwlog_read,
+	.read_iter = amdgpu_debugfs_vcn_fwlog_read_iter,
 	.llseek = default_llseek
 };
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 4a5a0a4e00f2..1f03e7915b99 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -40,9 +40,10 @@ static int kfd_debugfs_hang_hws_read(struct seq_file *m, void *data)
 	return 0;
 }
 
-static ssize_t kfd_debugfs_hang_hws_write(struct file *file,
-	const char __user *user_buf, size_t size, loff_t *ppos)
+static ssize_t kfd_debugfs_hang_hws_write(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
+	size_t size = iov_iter_count(from);
 	struct kfd_node *dev;
 	char tmp[16];
 	uint32_t gpu_id;
@@ -53,7 +54,7 @@ static ssize_t kfd_debugfs_hang_hws_write(struct file *file,
 		pr_err("Invalid input for gpu id.\n");
 		goto out;
 	}
-	if (copy_from_user(tmp, user_buf, size)) {
+	if (!copy_from_iter_full(tmp, size, from)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -75,7 +76,7 @@ static ssize_t kfd_debugfs_hang_hws_write(struct file *file,
 static const struct file_operations kfd_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = kfd_debugfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -83,8 +84,8 @@ static const struct file_operations kfd_debugfs_fops = {
 static const struct file_operations kfd_debugfs_hang_hws_fops = {
 	.owner = THIS_MODULE,
 	.open = kfd_debugfs_open,
-	.read = seq_read,
-	.write = kfd_debugfs_hang_hws_write,
+	.read_iter = seq_read_iter,
+	.write_iter = kfd_debugfs_hang_hws_write,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 06ac835190f9..04eba7e9dfae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -46,9 +46,8 @@ struct kfd_smi_client {
 #define MAX_KFIFO_SIZE	1024
 
 static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_struct *);
-static ssize_t kfd_smi_ev_read(struct file *, char __user *, size_t, loff_t *);
-static ssize_t kfd_smi_ev_write(struct file *, const char __user *, size_t,
-				loff_t *);
+static ssize_t kfd_smi_ev_read_iter(struct kiocb *, struct iov_iter *);
+static ssize_t kfd_smi_ev_write(struct kiocb *, struct iov_iter *);
 static int kfd_smi_ev_release(struct inode *, struct file *);
 
 static const char kfd_smi_name[] = "kfd_smi_ev";
@@ -56,8 +55,8 @@ static const char kfd_smi_name[] = "kfd_smi_ev";
 static const struct file_operations kfd_smi_ev_fops = {
 	.owner = THIS_MODULE,
 	.poll = kfd_smi_ev_poll,
-	.read = kfd_smi_ev_read,
-	.write = kfd_smi_ev_write,
+	.read_iter = kfd_smi_ev_read_iter,
+	.write_iter = kfd_smi_ev_write,
 	.release = kfd_smi_ev_release
 };
 
@@ -121,16 +120,14 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 	kfree(buf);
 	return ret;
 }
+FOPS_READ_ITER_HELPER(kfd_smi_ev_read);
 
-static ssize_t kfd_smi_ev_write(struct file *filep, const char __user *user,
-				size_t size, loff_t *offset)
+static ssize_t kfd_smi_ev_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct kfd_smi_client *client = filep->private_data;
+	struct kfd_smi_client *client = iocb->ki_filp->private_data;
 	uint64_t events;
 
-	if (!access_ok(user, size) || size < sizeof(events))
-		return -EFAULT;
-	if (copy_from_user(&events, user, sizeof(events)))
+	if (!copy_from_iter_full(&events, sizeof(events), from))
 		return -EFAULT;
 
 	WRITE_ONCE(client->events, events);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index eee4945653e2..ee1bd4372074 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -249,6 +249,7 @@ static ssize_t dp_link_settings_read(struct file *f, char __user *buf,
 	kfree(rd_buf);
 	return result;
 }
+FOPS_READ_ITER_HELPER(dp_link_settings_read);
 
 static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 				 size_t size, loff_t *pos)
@@ -336,6 +337,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	kfree(wr_buf);
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(dp_link_settings_write);
 
 static bool dp_mst_is_end_device(struct amdgpu_dm_connector *aconnector)
 {
@@ -483,6 +485,7 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
 	kfree(wr_buf);
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(dp_mst_link_setting);
 
 /* function: get current DP PHY settings: voltage swing, pre-emphasis,
  * post-cursor2 (defined by VESA DP specification)
@@ -566,6 +569,7 @@ static ssize_t dp_phy_settings_read(struct file *f, char __user *buf,
 	kfree(rd_buf);
 	return result;
 }
+FOPS_READ_ITER_HELPER(dp_phy_settings_read);
 
 static int dp_lttpr_status_show(struct seq_file *m, void *unused)
 {
@@ -686,6 +690,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 	kfree(wr_buf);
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(dp_phy_settings_write);
 
 /* function description
  *
@@ -892,6 +897,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(dp_phy_test_pattern_debugfs_write);
 
 /*
  * Returns the DMCUB tracebuffer contents.
@@ -1149,6 +1155,7 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
 	kfree(wr_buf);
 	return 0;
 }
+FOPS_WRITE_ITER_HELPER(dp_dsc_passthrough_set);
 
 /*
  * Returns the HDCP capability of the Display (1.4 for now).
@@ -1270,6 +1277,7 @@ static ssize_t dp_sdp_message_debugfs_write(struct file *f, const char __user *b
 
 	return write_size;
 }
+FOPS_WRITE_ITER_HELPER(dp_sdp_message_debugfs_write);
 
 /* function: Read link's DSC & FEC capabilities
  *
@@ -1456,6 +1464,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(trigger_hotplug);
 
 /* function: read DSC status on the connector
  *
@@ -1527,6 +1536,7 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	kfree(rd_buf);
 	return result;
 }
+FOPS_READ_ITER_HELPER(dp_dsc_clock_en_read);
 
 /* function: write force DSC on the connector
  *
@@ -1641,6 +1651,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
 	kfree(wr_buf);
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(dp_dsc_clock_en_write);
 
 /* function: read DSC slice width parameter on the connector
  *
@@ -1713,6 +1724,7 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 	kfree(rd_buf);
 	return result;
 }
+FOPS_READ_ITER_HELPER(dp_dsc_slice_width_read);
 
 /* function: write DSC slice width parameter
  *
@@ -1825,6 +1837,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
 	kfree(wr_buf);
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(dp_dsc_slice_width_write);
 
 /* function: read DSC slice height parameter on the connector
  *
@@ -1897,6 +1910,7 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 	kfree(rd_buf);
 	return result;
 }
+FOPS_READ_ITER_HELPER(dp_dsc_slice_height_read);
 
 /* function: write DSC slice height parameter
  *
@@ -2009,6 +2023,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
 	kfree(wr_buf);
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(dp_dsc_slice_height_write);
 
 /* function: read DSC target rate on the connector in bits per pixel
  *
@@ -2077,6 +2092,7 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 	kfree(rd_buf);
 	return result;
 }
+FOPS_READ_ITER_HELPER(dp_dsc_bits_per_pixel_read);
 
 /* function: write DSC target rate in bits per pixel
  *
@@ -2181,6 +2197,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
 	kfree(wr_buf);
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(dp_dsc_bits_per_pixel_write);
 
 /* function: read DSC picture width parameter on the connector
  *
@@ -2252,6 +2269,7 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 	kfree(rd_buf);
 	return result;
 }
+FOPS_READ_ITER_HELPER(dp_dsc_pic_width_read);
 
 static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 				    size_t size, loff_t *pos)
@@ -2308,6 +2326,7 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 	kfree(rd_buf);
 	return result;
 }
+FOPS_READ_ITER_HELPER(dp_dsc_pic_height_read);
 
 /* function: read DSC chunk size parameter on the connector
  *
@@ -2379,6 +2398,7 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 	kfree(rd_buf);
 	return result;
 }
+FOPS_READ_ITER_HELPER(dp_dsc_chunk_size_read);
 
 /* function: read DSC slice bpg offset on the connector
  *
@@ -2450,7 +2470,7 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 	kfree(rd_buf);
 	return result;
 }
-
+FOPS_READ_ITER_HELPER(dp_dsc_slice_bpg_offset_read);
 
 /*
  * function description: Read max_requested_bpc property from the connector
@@ -2511,7 +2531,7 @@ static ssize_t dp_max_bpc_read(struct file *f, char __user *buf,
 	kfree(rd_buf);
 	return result;
 }
-
+FOPS_READ_ITER_HELPER(dp_max_bpc_read);
 
 /*
  * function description: Set max_requested_bpc property on the connector
@@ -2593,6 +2613,7 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
 	kfree(wr_buf);
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(dp_max_bpc_write);
 
 /*
  * Backlight at this moment.  Read only.
@@ -2751,104 +2772,104 @@ DEFINE_SHOW_ATTRIBUTE(is_dpia_link);
 
 static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.read = dp_dsc_clock_en_read,
-	.write = dp_dsc_clock_en_write,
+	.read_iter = dp_dsc_clock_en_read_iter,
+	.write_iter = dp_dsc_clock_en_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_dsc_slice_width_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.read = dp_dsc_slice_width_read,
-	.write = dp_dsc_slice_width_write,
+	.read_iter = dp_dsc_slice_width_read_iter,
+	.write_iter = dp_dsc_slice_width_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_dsc_slice_height_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.read = dp_dsc_slice_height_read,
-	.write = dp_dsc_slice_height_write,
+	.read_iter = dp_dsc_slice_height_read_iter,
+	.write_iter = dp_dsc_slice_height_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_dsc_bits_per_pixel_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.read = dp_dsc_bits_per_pixel_read,
-	.write = dp_dsc_bits_per_pixel_write,
+	.read_iter = dp_dsc_bits_per_pixel_read_iter,
+	.write_iter = dp_dsc_bits_per_pixel_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_dsc_pic_width_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.read = dp_dsc_pic_width_read,
+	.read_iter = dp_dsc_pic_width_read_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_dsc_pic_height_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.read = dp_dsc_pic_height_read,
+	.read_iter = dp_dsc_pic_height_read_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_dsc_chunk_size_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.read = dp_dsc_chunk_size_read,
+	.read_iter = dp_dsc_chunk_size_read_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_dsc_slice_bpg_offset_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.read = dp_dsc_slice_bpg_offset_read,
+	.read_iter = dp_dsc_slice_bpg_offset_read_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations trigger_hotplug_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.write = trigger_hotplug,
+	.write_iter = trigger_hotplug_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_link_settings_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.read = dp_link_settings_read,
-	.write = dp_link_settings_write,
+	.read_iter = dp_link_settings_read_iter,
+	.write_iter = dp_link_settings_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_phy_settings_debugfs_fop = {
 	.owner = THIS_MODULE,
-	.read = dp_phy_settings_read,
-	.write = dp_phy_settings_write,
+	.read_iter = dp_phy_settings_read_iter,
+	.write_iter = dp_phy_settings_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_phy_test_pattern_fops = {
 	.owner = THIS_MODULE,
-	.write = dp_phy_test_pattern_debugfs_write,
+	.write_iter = dp_phy_test_pattern_debugfs_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations sdp_message_fops = {
 	.owner = THIS_MODULE,
-	.write = dp_sdp_message_debugfs_write,
+	.write_iter = dp_sdp_message_debugfs_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_max_bpc_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.read = dp_max_bpc_read,
-	.write = dp_max_bpc_write,
+	.read_iter = dp_max_bpc_read_iter,
+	.write_iter = dp_max_bpc_write_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_dsc_disable_passthrough_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.write = dp_dsc_passthrough_set,
+	.write_iter = dp_dsc_passthrough_set_iter,
 	.llseek = default_llseek
 };
 
 static const struct file_operations dp_mst_link_settings_debugfs_fops = {
 	.owner = THIS_MODULE,
-	.write = dp_mst_link_setting,
+	.write_iter = dp_mst_link_setting_iter,
 	.llseek = default_llseek
 };
 
@@ -3275,6 +3296,7 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 	kfree(wr_buf);
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(edp_ilr_write);
 
 static int edp_ilr_open(struct inode *inode, struct file *file)
 {
@@ -3284,10 +3306,10 @@ static int edp_ilr_open(struct inode *inode, struct file *file)
 static const struct file_operations edp_ilr_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = edp_ilr_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = edp_ilr_write
+	.write_iter = edp_ilr_write_iter
 };
 
 void connector_debugfs_init(struct amdgpu_dm_connector *connector)
@@ -3552,18 +3574,15 @@ void crtc_debugfs_init(struct drm_crtc *crtc)
  * Writes DTN log state to the user supplied buffer.
  * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_dtn_log
  */
-static ssize_t dtn_log_read(
-	struct file *f,
-	char __user *buf,
-	size_t size,
-	loff_t *pos)
+static ssize_t dtn_log_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct amdgpu_device *adev = file_inode(f)->i_private;
+	struct amdgpu_device *adev = file_inode(iocb->ki_filp)->i_private;
 	struct dc *dc = adev->dm.dc;
 	struct dc_log_buffer_ctx log_ctx = { 0 };
+	size_t size = iov_iter_count(to);
 	ssize_t result = 0;
 
-	if (!buf || !size)
+	if (!size)
 		return -EINVAL;
 
 	if (!dc->hwss.log_hw_state)
@@ -3571,13 +3590,13 @@ static ssize_t dtn_log_read(
 
 	dc->hwss.log_hw_state(dc, &log_ctx);
 
-	if (*pos < log_ctx.pos) {
-		size_t to_copy = log_ctx.pos - *pos;
+	if (iocb->ki_pos < log_ctx.pos) {
+		size_t to_copy = log_ctx.pos - iocb->ki_pos;
 
 		to_copy = min(to_copy, size);
 
-		if (!copy_to_user(buf, log_ctx.buf + *pos, to_copy)) {
-			*pos += to_copy;
+		if (copy_to_iter_full(log_ctx.buf + iocb->ki_pos, to_copy, to)) {
+			iocb->ki_pos += to_copy;
 			result = to_copy;
 		}
 	}
@@ -3591,13 +3610,10 @@ static ssize_t dtn_log_read(
  * Writes DTN log state to dmesg when triggered via a write.
  * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dtn_log
  */
-static ssize_t dtn_log_write(
-	struct file *f,
-	const char __user *buf,
-	size_t size,
-	loff_t *pos)
+static ssize_t dtn_log_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct amdgpu_device *adev = file_inode(f)->i_private;
+	struct amdgpu_device *adev = file_inode(iocb->ki_filp)->i_private;
+	size_t size = iov_iter_count(from);
 	struct dc *dc = adev->dm.dc;
 
 	/* Write triggers log output via dmesg. */
@@ -3972,18 +3988,19 @@ static ssize_t dcc_en_bits_read(
 	kfree(rd_buf);
 	return result;
 }
+FOPS_READ_ITER_HELPER(dcc_en_bits_read);
 
 void dtn_debugfs_init(struct amdgpu_device *adev)
 {
 	static const struct file_operations dtn_log_fops = {
 		.owner = THIS_MODULE,
-		.read = dtn_log_read,
-		.write = dtn_log_write,
+		.read_iter = dtn_log_read,
+		.write_iter = dtn_log_write,
 		.llseek = default_llseek
 	};
 	static const struct file_operations dcc_en_bits_fops = {
 		.owner = THIS_MODULE,
-		.read = dcc_en_bits_read,
+		.read_iter = dcc_en_bits_read_iter,
 		.llseek = default_llseek
 	};
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f09b9d49297e..d78f7b351f7d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4572,10 +4572,9 @@ DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_pm_info);
  *
  * Reads debug memory region allocated to PMFW
  */
-static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
-					 size_t size, loff_t *pos)
+static ssize_t amdgpu_pm_prv_buffer_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct amdgpu_device *adev = file_inode(f)->i_private;
+	struct amdgpu_device *adev = file_inode(iocb->ki_filp)->i_private;
 	size_t smu_prv_buf_size;
 	void *smu_prv_buf;
 	int ret = 0;
@@ -4592,14 +4591,14 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
 	if (!smu_prv_buf || !smu_prv_buf_size)
 		return -EINVAL;
 
-	return simple_read_from_buffer(buf, size, pos, smu_prv_buf,
-				       smu_prv_buf_size);
+	return simple_copy_to_iter(smu_prv_buf, &iocb->ki_pos,
+					smu_prv_buf_size, to);
 }
 
 static const struct file_operations amdgpu_debugfs_pm_prv_buffer_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = amdgpu_pm_prv_buffer_read,
+	.read_iter = amdgpu_pm_prv_buffer_read,
 	.llseek = default_llseek,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 246b211b1e85..04332432e57f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3603,20 +3603,13 @@ static int smu_stb_debugfs_open(struct inode *inode, struct file *filp)
 	return r;
 }
 
-static ssize_t smu_stb_debugfs_read(struct file *filp, char __user *buf, size_t size,
-				loff_t *pos)
+static ssize_t smu_stb_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct amdgpu_device *adev = filp->f_inode->i_private;
+	struct amdgpu_device *adev = iocb->ki_filp->f_inode->i_private;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-
-	if (!filp->private_data)
-		return -EINVAL;
-
-	return simple_read_from_buffer(buf,
-				       size,
-				       pos, filp->private_data,
-				       smu->stb_context.stb_buf_size);
+	return simple_copy_to_iter(adev, &iocb->ki_pos,
+				       smu->stb_context.stb_buf_size, to);
 }
 
 static int smu_stb_debugfs_release(struct inode *inode, struct file *filp)
@@ -3637,7 +3630,7 @@ static int smu_stb_debugfs_release(struct inode *inode, struct file *filp)
 static const struct file_operations smu_stb_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = smu_stb_debugfs_open,
-	.read = smu_stb_debugfs_read,
+	.read_iter = smu_stb_debugfs_read,
 	.release = smu_stb_debugfs_release,
 	.llseek = default_llseek,
 };
-- 
2.43.0


