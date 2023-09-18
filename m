Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E0D7A4F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjIRQeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjIRQeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:34:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE71199FE;
        Mon, 18 Sep 2023 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053670; x=1726589670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7q0+gtbfGqVgyGk+Cwd1SLXvZsiPOH5fBdOFQlGjaJU=;
  b=PmCom6xpPlzdGH4XcSi2e1G+lx4KzaHHtp8ImZDqb1qbgSGYGFxpZVLU
   S4+tGcHvb2MAzH8CobOpqw5MyNdzlod0ueUSitFFlCymu6AaXpsLCTevL
   tvtHLGqkFaKv6XNk2ohzonfI0m0WoQjjHXYgH/w5lv59oY0R7xQgJzLhy
   l6lMsZYB9j5fSHeQdHAMqxjlB/G1o9MWdqdLoXD280HH5pDaVXWLT+6vD
   2yslC+eb232RBrBTJTS8WGUyzc6wZtwzseMR3pa+5rZrvNuVta2rb3EY9
   3TwIRAKHOQAdPEEXbEWLl6NFijL4zmewBE5oqXKBmRodDagR6A+L3H/W1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379564931"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="379564931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="775135964"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="775135964"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Sep 2023 06:51:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9699118E; Mon, 18 Sep 2023 16:51:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/2] platform/x86: think-lmi: Replace kstrdup() + strreplace() with kstrdup_and_replace()
Date:   Mon, 18 Sep 2023 16:51:15 +0300
Message-Id: <20230918135116.1248560-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded functionalify of kstrdup_and_replace() with a call.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on top of review-hans (Hans), added tag (Ilpo)
 drivers/platform/x86/think-lmi.c | 43 +++++++++++---------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index f69003c30fa2..4e0d52dc3944 100644
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
@@ -992,13 +983,11 @@ static ssize_t current_value_store(struct kobject *kobj,
 	if (tlmi_priv.save_mode == TLMI_SAVE_BULK && tlmi_priv.reboot_required)
 		return -EPERM;
 
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
 
@@ -1279,13 +1268,11 @@ static ssize_t debug_cmd_store(struct kobject *kobj, struct kobj_attribute *attr
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

