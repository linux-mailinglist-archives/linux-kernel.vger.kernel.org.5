Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE779E39C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbjIMJ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbjIMJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:27:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8445199E;
        Wed, 13 Sep 2023 02:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694597227; x=1726133227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jWur+JX9CJPEdIOhhwD8UkpAw5f715+nAiJqnxYPswY=;
  b=CWhMvJt/BmdxMJT1BxTe6I5ZLpmsdey+f7kaN8kPU1A1GiHK/vqg/r9w
   0jxMGDZGhqWqWahQQS1kVSJsO2f67vz1LGfa1AzHG/1Gq7UY0bK6JS7s/
   RmacgYmw7djStn0Y7q94+V5vcO2OFc3iXvswOkznbHsuxlSVKDqvravV7
   OFDlstJ8QHjHaWMU3YcXPNrrgZjofr/3eZroCXbvdXh6MnLaINgBVm6ZA
   ghSQP0BuGgKdzy6aArLSwkr5FJIkMYV6kWf3xmqTGKlNSUJVMYk5pPV14
   82z2btdfjMF8zujclpJG+dq83wWnKC/Zg/x1x+UFCUoRLpR4kW5jB4/MR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464979127"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="464979127"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867717321"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="867717321"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2023 02:27:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A3A331E5; Wed, 13 Sep 2023 12:27:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] platform/x86: think-lmi: Replace kstrdup() + strreplace() with kstrdup_and_replace()
Date:   Wed, 13 Sep 2023 12:27:00 +0300
Message-Id: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded functionalify of kstrdup_and_replace() with a call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/think-lmi.c | 43 +++++++++++---------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 79346881cadb..94a3c7a74bc4 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -15,7 +15,7 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/mutex.h>
-#include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/types.h>
 #include <linux/dmi.h>
 #include <linux/wmi.h>
@@ -432,13 +432,11 @@ static ssize_t new_password_store(struct kobject *kobj,
 	if (!tlmi_priv.can_set_bios_password)
 		return -EOPNOTSUPP;
 
-	new_pwd = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present, setting password won't work if it is present */
+	new_pwd = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_pwd)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present, setting password won't work if it is present */
-	strip_cr(new_pwd);
-
 	/* Use lock in case multiple WMI operations needed */
 	mutex_lock(&tlmi_mutex);
 
@@ -709,13 +707,11 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 	if (!setting->signature || !setting->signature[0])
 		return -EACCES;
 
-	passwd = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	passwd = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!passwd)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present */
-	strip_cr(passwd);
-
 	/* Format: 'Password,Signature' */
 	auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
 	if (!auth_str) {
@@ -765,11 +761,10 @@ static ssize_t certificate_store(struct kobject *kobj,
 		return ret ?: count;
 	}
 
-	new_cert = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	new_cert = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_cert)
 		return -ENOMEM;
-	/* Strip out CR if one is present */
-	strip_cr(new_cert);
 
 	if (setting->cert_installed) {
 		/* Certificate is installed so this is an update */
@@ -817,13 +812,11 @@ static ssize_t signature_store(struct kobject *kobj,
 	if (!tlmi_priv.certificate_support)
 		return -EOPNOTSUPP;
 
-	new_signature = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	new_signature = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_signature)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present */
-	strip_cr(new_signature);
-
 	/* Free any previous signature */
 	kfree(setting->signature);
 	setting->signature = new_signature;
@@ -846,13 +839,11 @@ static ssize_t save_signature_store(struct kobject *kobj,
 	if (!tlmi_priv.certificate_support)
 		return -EOPNOTSUPP;
 
-	new_signature = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	new_signature = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_signature)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present */
-	strip_cr(new_signature);
-
 	/* Free any previous signature */
 	kfree(setting->save_signature);
 	setting->save_signature = new_signature;
@@ -985,13 +976,11 @@ static ssize_t current_value_store(struct kobject *kobj,
 	if (!tlmi_priv.can_set_bios_settings)
 		return -EOPNOTSUPP;
 
-	new_setting = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	new_setting = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_setting)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present */
-	strip_cr(new_setting);
-
 	/* Use lock in case multiple WMI operations needed */
 	mutex_lock(&tlmi_mutex);
 
@@ -1163,13 +1152,11 @@ static ssize_t debug_cmd_store(struct kobject *kobj, struct kobj_attribute *attr
 	if (!tlmi_priv.can_debug_cmd)
 		return -EOPNOTSUPP;
 
-	new_setting = kstrdup(buf, GFP_KERNEL);
+	/* Strip out CR if one is present */
+	new_setting = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
 	if (!new_setting)
 		return -ENOMEM;
 
-	/* Strip out CR if one is present */
-	strip_cr(new_setting);
-
 	if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
 		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 				tlmi_priv.pwd_admin->password,
-- 
2.40.0.1.gaa8946217a0b

