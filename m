Return-Path: <linux-kernel+bounces-131804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64687898BEF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631691C21E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4012CD9B;
	Thu,  4 Apr 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4DVk8q1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307512BEAC;
	Thu,  4 Apr 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247331; cv=none; b=pr6ArQYuUnQz5NWUIOvTNk2d+0X3wHHsFwplPP8Znk95w6cfcBSPu+sX4ebxaXi30nxvlNHFNmdIdtwwoJoSQRkEGhgJ0HjfNr3VDs75D44VxAx/NNL+4ECZiMWMqPvXWSr3oYA+jtO8CuNPe5TD2YlC7O9vh+t5mncOkD2bBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247331; c=relaxed/simple;
	bh=3IjOrztsp5OUehJUjNgG3QAcmyGj45Icq+ciHgDNI74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qqIIXRlocjRsxTH/zXUoZyO1I7j336zpPostBgNoEEQpwrtB8ts8Fkl8UfDVp+WXRcLq4QNkg1y8zTc0euLB6eRSbwXKrr5X/qXyOiT2pF4WqrNSGAicMbHFju2slBZHyeN0YmQRLT/ljPFmO9m8qhSQg3x7LTyVcbe1hzbjy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4DVk8q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF5CC433F1;
	Thu,  4 Apr 2024 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712247330;
	bh=3IjOrztsp5OUehJUjNgG3QAcmyGj45Icq+ciHgDNI74=;
	h=From:To:Cc:Subject:Date:From;
	b=d4DVk8q1to+Lhchjp4jF6hMbJ9kSsM8hM0hAZFRPzrtsjKZ0ekvXP2ZwbjkwZVZXf
	 9AbD8mt/aOV4zxUw1q+0opWX+1KXTNxiIME5mGqsEnvKsgc3eJjrUrICrhejLFAXcm
	 R1XFCmPgMntr4IIBGI/ASiJz+bYJX/qd/vpfPAUpGAqRTwmyv+48+S0TMxOfCkOAED
	 uFWq8t52IT/C+j64WoT3EhaaekNVSCuVfhsQP+loHFC9DdrR1TZLo0WfMIv1FvOblv
	 oBFenzhQ5KbTHHF+ckBEzKpmHv1C3JyxkZ1Ve+JP8mDCfZ4oo3MBaNKOrdx4p4JUnc
	 2a+xUJ9/L7/Zw==
From: Arnd Bergmann <arnd@kernel.org>
To: "Manoj N. Kumar" <manoj@linux.ibm.com>,
	"Matthew R. Ochs" <mrochs@linux.ibm.com>,
	Uma Krishnan <ukrishn@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] [v2] cxlflash: fix function pointer cast warnings
Date: Thu,  4 Apr 2024 18:14:58 +0200
Message-Id: <20240404161524.3473857-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Calling a function through an incompatible pointer type causes breaks
kcfi, so clang warns about the assignments:

drivers/scsi/cxlflash/main.c:3498:3: error: cast from 'int (*)(struct cxlflash_cfg *, struct ht_cxlflash_lun_provision *)' to 'hioctl' (aka 'int (*)(struct cxlflash_cfg *, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 3498 |                 (hioctl)cxlflash_lun_provision },
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/cxlflash/main.c:3500:3: error: cast from 'int (*)(struct cxlflash_cfg *, struct ht_cxlflash_afu_debug *)' to 'hioctl' (aka 'int (*)(struct cxlflash_cfg *, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 3500 |                 (hioctl)cxlflash_afu_debug },
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~

Address these by changing the functions to have the correct type
and replace the function pointer cast with a cast of its argument.

Link: https://lore.kernel.org/lkml/20240326145140.3257163-6-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: update kerneldoc documentation
---
 drivers/scsi/cxlflash/lunmgt.c    |  6 ++---
 drivers/scsi/cxlflash/main.c      | 18 +++++++-------
 drivers/scsi/cxlflash/superpipe.c | 40 +++++++++++++++----------------
 drivers/scsi/cxlflash/superpipe.h | 11 ++++-----
 drivers/scsi/cxlflash/vlun.c      |  9 ++++---
 5 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/scsi/cxlflash/lunmgt.c b/drivers/scsi/cxlflash/lunmgt.c
index e0e15b44a2e6..52405c6462f8 100644
--- a/drivers/scsi/cxlflash/lunmgt.c
+++ b/drivers/scsi/cxlflash/lunmgt.c
@@ -216,7 +216,7 @@ void cxlflash_term_global_luns(void)
 /**
  * cxlflash_manage_lun() - handles LUN management activities
  * @sdev:	SCSI device associated with LUN.
- * @manage:	Manage ioctl data structure.
+ * @arg:	Manage ioctl data structure.
  *
  * This routine is used to notify the driver about a LUN's WWID and associate
  * SCSI devices (sdev) with a global LUN instance. Additionally it serves to
@@ -224,9 +224,9 @@ void cxlflash_term_global_luns(void)
  *
  * Return: 0 on success, -errno on failure
  */
-int cxlflash_manage_lun(struct scsi_device *sdev,
-			struct dk_cxlflash_manage_lun *manage)
+int cxlflash_manage_lun(struct scsi_device *sdev, void *arg)
 {
+	struct dk_cxlflash_manage_lun *manage = arg;
 	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
 	struct device *dev = &cfg->dev->dev;
 	struct llun_info *lli = NULL;
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index e8382cc5cf23..e4b45b7e3277 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3280,13 +3280,13 @@ static char *decode_hioctl(unsigned int cmd)
 /**
  * cxlflash_lun_provision() - host LUN provisioning handler
  * @cfg:	Internal structure associated with the host.
- * @lunprov:	Kernel copy of userspace ioctl data structure.
+ * @arg:	Kernel copy of userspace ioctl data structure.
  *
  * Return: 0 on success, -errno on failure
  */
-static int cxlflash_lun_provision(struct cxlflash_cfg *cfg,
-				  struct ht_cxlflash_lun_provision *lunprov)
+static int cxlflash_lun_provision(struct cxlflash_cfg *cfg, void *arg)
 {
+	struct ht_cxlflash_lun_provision *lunprov = arg;
 	struct afu *afu = cfg->afu;
 	struct device *dev = &cfg->dev->dev;
 	struct sisl_ioarcb rcb;
@@ -3371,16 +3371,16 @@ static int cxlflash_lun_provision(struct cxlflash_cfg *cfg,
 /**
  * cxlflash_afu_debug() - host AFU debug handler
  * @cfg:	Internal structure associated with the host.
- * @afu_dbg:	Kernel copy of userspace ioctl data structure.
+ * @arg:	Kernel copy of userspace ioctl data structure.
  *
  * For debug requests requiring a data buffer, always provide an aligned
  * (cache line) buffer to the AFU to appease any alignment requirements.
  *
  * Return: 0 on success, -errno on failure
  */
-static int cxlflash_afu_debug(struct cxlflash_cfg *cfg,
-			      struct ht_cxlflash_afu_debug *afu_dbg)
+static int cxlflash_afu_debug(struct cxlflash_cfg *cfg, void *arg)
 {
+	struct ht_cxlflash_afu_debug *afu_dbg = arg;
 	struct afu *afu = cfg->afu;
 	struct device *dev = &cfg->dev->dev;
 	struct sisl_ioarcb rcb;
@@ -3494,10 +3494,8 @@ static long cxlflash_chr_ioctl(struct file *file, unsigned int cmd,
 		size_t size;
 		hioctl ioctl;
 	} ioctl_tbl[] = {	/* NOTE: order matters here */
-	{ sizeof(struct ht_cxlflash_lun_provision),
-		(hioctl)cxlflash_lun_provision },
-	{ sizeof(struct ht_cxlflash_afu_debug),
-		(hioctl)cxlflash_afu_debug },
+	{ sizeof(struct ht_cxlflash_lun_provision), cxlflash_lun_provision },
+	{ sizeof(struct ht_cxlflash_afu_debug), cxlflash_afu_debug },
 	};
 
 	/* Hold read semaphore so we can drain if needed */
diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index e1b55b03e812..2d356fe2457a 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -729,8 +729,7 @@ int _cxlflash_disk_release(struct scsi_device *sdev,
 	return rc;
 }
 
-int cxlflash_disk_release(struct scsi_device *sdev,
-			  struct dk_cxlflash_release *release)
+int cxlflash_disk_release(struct scsi_device *sdev, void *release)
 {
 	return _cxlflash_disk_release(sdev, NULL, release);
 }
@@ -955,8 +954,7 @@ static int _cxlflash_disk_detach(struct scsi_device *sdev,
 	return rc;
 }
 
-static int cxlflash_disk_detach(struct scsi_device *sdev,
-				struct dk_cxlflash_detach *detach)
+static int cxlflash_disk_detach(struct scsi_device *sdev, void *detach)
 {
 	return _cxlflash_disk_detach(sdev, NULL, detach);
 }
@@ -1305,7 +1303,7 @@ int check_state(struct cxlflash_cfg *cfg)
 /**
  * cxlflash_disk_attach() - attach a LUN to a context
  * @sdev:	SCSI device associated with LUN.
- * @attach:	Attach ioctl data structure.
+ * @arg:	Attach ioctl data structure.
  *
  * Creates a context and attaches LUN to it. A LUN can only be attached
  * one time to a context (subsequent attaches for the same context/LUN pair
@@ -1314,9 +1312,9 @@ int check_state(struct cxlflash_cfg *cfg)
  *
  * Return: 0 on success, -errno on failure
  */
-static int cxlflash_disk_attach(struct scsi_device *sdev,
-				struct dk_cxlflash_attach *attach)
+static int cxlflash_disk_attach(struct scsi_device *sdev, void *arg)
 {
+	struct dk_cxlflash_attach *attach = arg;
 	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
 	struct device *dev = &cfg->dev->dev;
 	struct afu *afu = cfg->afu;
@@ -1621,7 +1619,7 @@ static int recover_context(struct cxlflash_cfg *cfg,
 /**
  * cxlflash_afu_recover() - initiates AFU recovery
  * @sdev:	SCSI device associated with LUN.
- * @recover:	Recover ioctl data structure.
+ * @arg:	Recover ioctl data structure.
  *
  * Only a single recovery is allowed at a time to avoid exhausting CXL
  * resources (leading to recovery failure) in the event that we're up
@@ -1648,9 +1646,9 @@ static int recover_context(struct cxlflash_cfg *cfg,
  *
  * Return: 0 on success, -errno on failure
  */
-static int cxlflash_afu_recover(struct scsi_device *sdev,
-				struct dk_cxlflash_recover_afu *recover)
+static int cxlflash_afu_recover(struct scsi_device *sdev, void *arg)
 {
+	struct dk_cxlflash_recover_afu *recover = arg;
 	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
 	struct device *dev = &cfg->dev->dev;
 	struct llun_info *lli = sdev->hostdata;
@@ -1829,13 +1827,13 @@ static int process_sense(struct scsi_device *sdev,
 /**
  * cxlflash_disk_verify() - verifies a LUN is the same and handle size changes
  * @sdev:	SCSI device associated with LUN.
- * @verify:	Verify ioctl data structure.
+ * @arg:	Verify ioctl data structure.
  *
  * Return: 0 on success, -errno on failure
  */
-static int cxlflash_disk_verify(struct scsi_device *sdev,
-				struct dk_cxlflash_verify *verify)
+static int cxlflash_disk_verify(struct scsi_device *sdev, void *arg)
 {
+	struct dk_cxlflash_verify *verify = arg;
 	int rc = 0;
 	struct ctx_info *ctxi = NULL;
 	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
@@ -2111,16 +2109,16 @@ int cxlflash_ioctl(struct scsi_device *sdev, unsigned int cmd, void __user *arg)
 		size_t size;
 		sioctl ioctl;
 	} ioctl_tbl[] = {	/* NOTE: order matters here */
-	{sizeof(struct dk_cxlflash_attach), (sioctl)cxlflash_disk_attach},
+	{sizeof(struct dk_cxlflash_attach), cxlflash_disk_attach},
 	{sizeof(struct dk_cxlflash_udirect), cxlflash_disk_direct_open},
-	{sizeof(struct dk_cxlflash_release), (sioctl)cxlflash_disk_release},
-	{sizeof(struct dk_cxlflash_detach), (sioctl)cxlflash_disk_detach},
-	{sizeof(struct dk_cxlflash_verify), (sioctl)cxlflash_disk_verify},
-	{sizeof(struct dk_cxlflash_recover_afu), (sioctl)cxlflash_afu_recover},
-	{sizeof(struct dk_cxlflash_manage_lun), (sioctl)cxlflash_manage_lun},
+	{sizeof(struct dk_cxlflash_release), cxlflash_disk_release},
+	{sizeof(struct dk_cxlflash_detach), cxlflash_disk_detach},
+	{sizeof(struct dk_cxlflash_verify), cxlflash_disk_verify},
+	{sizeof(struct dk_cxlflash_recover_afu), cxlflash_afu_recover},
+	{sizeof(struct dk_cxlflash_manage_lun), cxlflash_manage_lun},
 	{sizeof(struct dk_cxlflash_uvirtual), cxlflash_disk_virtual_open},
-	{sizeof(struct dk_cxlflash_resize), (sioctl)cxlflash_vlun_resize},
-	{sizeof(struct dk_cxlflash_clone), (sioctl)cxlflash_disk_clone},
+	{sizeof(struct dk_cxlflash_resize), cxlflash_vlun_resize},
+	{sizeof(struct dk_cxlflash_clone), cxlflash_disk_clone},
 	};
 
 	/* Hold read semaphore so we can drain if needed */
diff --git a/drivers/scsi/cxlflash/superpipe.h b/drivers/scsi/cxlflash/superpipe.h
index 0e3b45964066..fe8c975d13d7 100644
--- a/drivers/scsi/cxlflash/superpipe.h
+++ b/drivers/scsi/cxlflash/superpipe.h
@@ -114,18 +114,16 @@ struct cxlflash_global {
 	struct page *err_page; /* One page of all 0xF for error notification */
 };
 
-int cxlflash_vlun_resize(struct scsi_device *sdev,
-			 struct dk_cxlflash_resize *resize);
+int cxlflash_vlun_resize(struct scsi_device *sdev, void *resize);
 int _cxlflash_vlun_resize(struct scsi_device *sdev, struct ctx_info *ctxi,
 			  struct dk_cxlflash_resize *resize);
 
 int cxlflash_disk_release(struct scsi_device *sdev,
-			  struct dk_cxlflash_release *release);
+			  void *release);
 int _cxlflash_disk_release(struct scsi_device *sdev, struct ctx_info *ctxi,
 			   struct dk_cxlflash_release *release);
 
-int cxlflash_disk_clone(struct scsi_device *sdev,
-			struct dk_cxlflash_clone *clone);
+int cxlflash_disk_clone(struct scsi_device *sdev, void *arg);
 
 int cxlflash_disk_virtual_open(struct scsi_device *sdev, void *arg);
 
@@ -145,8 +143,7 @@ void rhte_checkin(struct ctx_info *ctxi, struct sisl_rht_entry *rhte);
 
 void cxlflash_ba_terminate(struct ba_lun *ba_lun);
 
-int cxlflash_manage_lun(struct scsi_device *sdev,
-			struct dk_cxlflash_manage_lun *manage);
+int cxlflash_manage_lun(struct scsi_device *sdev, void *manage);
 
 int check_state(struct cxlflash_cfg *cfg);
 
diff --git a/drivers/scsi/cxlflash/vlun.c b/drivers/scsi/cxlflash/vlun.c
index cbd5a648a131..35326e311991 100644
--- a/drivers/scsi/cxlflash/vlun.c
+++ b/drivers/scsi/cxlflash/vlun.c
@@ -819,8 +819,7 @@ int _cxlflash_vlun_resize(struct scsi_device *sdev,
 	return rc;
 }
 
-int cxlflash_vlun_resize(struct scsi_device *sdev,
-			 struct dk_cxlflash_resize *resize)
+int cxlflash_vlun_resize(struct scsi_device *sdev, void *resize)
 {
 	return _cxlflash_vlun_resize(sdev, NULL, resize);
 }
@@ -1178,7 +1177,7 @@ static int clone_lxt(struct afu *afu,
 /**
  * cxlflash_disk_clone() - clone a context by making snapshot of another
  * @sdev:	SCSI device associated with LUN owning virtual LUN.
- * @clone:	Clone ioctl data structure.
+ * @arg:	Clone ioctl data structure.
  *
  * This routine effectively performs cxlflash_disk_open operation for each
  * in-use virtual resource in the source context. Note that the destination
@@ -1187,9 +1186,9 @@ static int clone_lxt(struct afu *afu,
  *
  * Return: 0 on success, -errno on failure
  */
-int cxlflash_disk_clone(struct scsi_device *sdev,
-			struct dk_cxlflash_clone *clone)
+int cxlflash_disk_clone(struct scsi_device *sdev, void *arg)
 {
+	struct dk_cxlflash_clone *clone = arg;
 	struct cxlflash_cfg *cfg = shost_priv(sdev->host);
 	struct device *dev = &cfg->dev->dev;
 	struct llun_info *lli = sdev->hostdata;
-- 
2.39.2


