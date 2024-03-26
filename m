Return-Path: <linux-kernel+bounces-119228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77A988C5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6BA1C63F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232EC13C696;
	Tue, 26 Mar 2024 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW34W87t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089A13C680;
	Tue, 26 Mar 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464790; cv=none; b=i9LbPl3uIQdCHEXpFHAbq/oL0aLyik3K/EerenOYPU3zw7ycqzpTRTbSWq6Qh5eKWyMIhK6jhd15KU7Qiq65f/Nh5pH2Wdc8nn9EMKH+lf8QU7426G9WFB4LXyzWRzfuhoUikc3CHBjUnkWAh0pCfthlorThlv62HYSVGNEBVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464790; c=relaxed/simple;
	bh=zmcaILoG9edopCsb9BkgtZjkbl241qwQmZqzbDR5n9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DoO9c7cp1dSD7W+hgGsBkFQjEisz2xolUapyXQ5LMMPFmstnsaXFS5GP6AA06NHzXuTgK/DOQ19rQKGLEmXGFoQzePEOtWIxBeennIuXynsdwlr1sVb4rg9JANmvXtGEn+Z2ou6USJliUIENqTPEuM+dtJdKeIV8FwxvAhiFEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW34W87t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3576CC433C7;
	Tue, 26 Mar 2024 14:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464789;
	bh=zmcaILoG9edopCsb9BkgtZjkbl241qwQmZqzbDR5n9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UW34W87tWJeckzZMXemY9Kl/ntVhl83WMu+Tx1NmAgER6ol3ySvShlWSHxhXAeqj3
	 cTBaywd0BMmspyxP/OKi41cYS5hpuoUYdmRlgYtUxdGlr0wEgcr3h4RkOYdloXAoGg
	 1wJtn+4nhTbkwA5ZrVd+KGR7TSIupKeljESYeSdcvAhrm0a0GTQVqwWse0iP9+N0gi
	 FR1Vg3K/Nh3sIbIsW0mmNaG7TwvsxzWXWiTGv/LLpZLgSUdcLyFhpdthPtughKQjpz
	 K/N/pF0/4euGrcLHqjfsjpzZMqW7Jsu8cpCAcuDH5XE1zioQJWBlTSKQkRwTtxQbfI
	 wbNS1aF84pdlQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Manoj N. Kumar" <manoj@linux.ibm.com>,
	"Matthew R. Ochs" <mrochs@linux.ibm.com>,
	Uma Krishnan <ukrishn@linux.ibm.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 07/12] cxlflash: fix function pointer cast warnings
Date: Tue, 26 Mar 2024 15:51:32 +0100
Message-Id: <20240326145140.3257163-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326144741.3094687-1-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/cxlflash/lunmgt.c    |  4 ++--
 drivers/scsi/cxlflash/main.c      | 14 ++++++-------
 drivers/scsi/cxlflash/superpipe.c | 34 +++++++++++++++----------------
 drivers/scsi/cxlflash/superpipe.h | 11 ++++------
 drivers/scsi/cxlflash/vlun.c      |  7 +++----
 5 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/scsi/cxlflash/lunmgt.c b/drivers/scsi/cxlflash/lunmgt.c
index e0e15b44a2e6..7d5e9b49eb90 100644
--- a/drivers/scsi/cxlflash/lunmgt.c
+++ b/drivers/scsi/cxlflash/lunmgt.c
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
index debd36974119..2ad157e8b1c2 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3279,9 +3279,9 @@ static char *decode_hioctl(unsigned int cmd)
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
@@ -3373,9 +3373,9 @@ static int cxlflash_lun_provision(struct cxlflash_cfg *cfg,
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
@@ -3489,10 +3489,8 @@ static long cxlflash_chr_ioctl(struct file *file, unsigned int cmd,
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
index e1b55b03e812..afbc8619573d 100644
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
@@ -1833,9 +1831,9 @@ static int process_sense(struct scsi_device *sdev,
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
index cbd5a648a131..d9a89fd27645 100644
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


