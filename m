Return-Path: <linux-kernel+bounces-132045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C039D898F17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F232D1C21D58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6603A134439;
	Thu,  4 Apr 2024 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMENfMrr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D011311A3;
	Thu,  4 Apr 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259328; cv=none; b=SnTUNttBZnHiHIpYi451s4Jnm0qdTHAChrg7egKGTZ7cR6auG03phPcMfwHnGDZFzRPOZdGUAzedTuHbcvxBtI0hQQGYnkDO0ulwUiSYqhlW2QZmC+Lg9MG71/l4RbRKYbkTXZd0AMAkAdd0e9NgdA/U6cc6Ygn36pUntdTeIt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259328; c=relaxed/simple;
	bh=guTUrkGCJ4oBaMte9luwU3S1Hg/eVxHqcTnNcLV1rVw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h0AsCqDsfln/flm9e5rxN3m8/YWyepCE3AFvmFIeJvppfT+g0AzshIo1I6EV3EZKg0pnX8ufUUOjvHuFCArMJ6Quwhbn+CKjSn0UkVclCaA//PBihzSJOMyBUIYIMlzNfgNkmSRDMQNnDRQzZwpCMBsU+DMA/yDWsBkMqD4o+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMENfMrr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712259327; x=1743795327;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=guTUrkGCJ4oBaMte9luwU3S1Hg/eVxHqcTnNcLV1rVw=;
  b=IMENfMrrkHoTHemOntWUqAvGIjJ3Yw7Ff1W+3+FC0gwkEqvn2IKrMMrR
   hhpVGnkEg+gc+4tuYlG61KtOrVB9Se1Vu36nOsp7VmjmjkROsr4Gu+ua7
   2n3mYBYyIYUU1hErfZEkf37b8ybQDcD6Jzi1RQHjrmdTSK/iKdCtYDqk7
   noRzfKl19vWfd0EtnEoirItp4RHgUQfaV8BZ9ByPZBXjAGaULcrKFNIiv
   iuf2O9Xl6scrucAj18hIASXbf2IXatNUYsp2JWphywDZmgouc2u/bIcfE
   BZiOqXTlCjvTHpxRJek6kcN3W5nm7weC0KoUUwIZZvT/sj1LajXkfPHPr
   w==;
X-CSE-ConnectionGUID: LLVtTc1IRQqMaNtQipqwqA==
X-CSE-MsgGUID: 4S7fPRMYQs2fa89KAwJdJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18711914"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18711914"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937087031"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="937087031"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 12:35:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D9A9F3E5; Thu,  4 Apr 2024 22:35:22 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] pinctrl: Use DEFINE_SHOW_STORE_ATTRIBUTE() helper for debugfs
Date: Thu,  4 Apr 2024 22:35:21 +0300
Message-ID: <20240404193521.3581399-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use DEFINE_SHOW_STORE_ATTRIBUTE() helper for read-write file to reduce some
duplicated code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinmux.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index d924207d629b..addba55334d9 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -578,6 +578,7 @@ static int pinmux_functions_show(struct seq_file *s, void *what)
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(pinmux_functions);
 
 static int pinmux_pins_show(struct seq_file *s, void *what)
 {
@@ -650,6 +651,7 @@ static int pinmux_pins_show(struct seq_file *s, void *what)
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(pinmux_pins);
 
 void pinmux_show_map(struct seq_file *s, const struct pinctrl_map *map)
 {
@@ -672,10 +674,12 @@ void pinmux_show_setting(struct seq_file *s,
 		   setting->data.mux.func);
 }
 
-DEFINE_SHOW_ATTRIBUTE(pinmux_functions);
-DEFINE_SHOW_ATTRIBUTE(pinmux_pins);
+static int pinmux_select_show(struct seq_file *s, void *unused)
+{
+	return -EPERM;
+}
 
-static ssize_t pinmux_select(struct file *file, const char __user *user_buf,
+static ssize_t pinmux_select_write(struct file *file, const char __user *user_buf,
 				   size_t len, loff_t *ppos)
 {
 	struct seq_file *sfile = file->private_data;
@@ -749,19 +753,7 @@ static ssize_t pinmux_select(struct file *file, const char __user *user_buf,
 
 	return ret;
 }
-
-static int pinmux_select_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, NULL, inode->i_private);
-}
-
-static const struct file_operations pinmux_select_ops = {
-	.owner = THIS_MODULE,
-	.open = pinmux_select_open,
-	.write = pinmux_select,
-	.llseek = no_llseek,
-	.release = single_release,
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(pinmux_select);
 
 void pinmux_init_device_debugfs(struct dentry *devroot,
 			 struct pinctrl_dev *pctldev)
@@ -771,7 +763,7 @@ void pinmux_init_device_debugfs(struct dentry *devroot,
 	debugfs_create_file("pinmux-pins", 0444,
 			    devroot, pctldev, &pinmux_pins_fops);
 	debugfs_create_file("pinmux-select", 0200,
-			    devroot, pctldev, &pinmux_select_ops);
+			    devroot, pctldev, &pinmux_select_fops);
 }
 
 #endif /* CONFIG_DEBUG_FS */
-- 
2.43.0.rc1.1.gbec44491f096


