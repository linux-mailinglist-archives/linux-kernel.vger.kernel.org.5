Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F43F7A4EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjIRQUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjIRQUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:20:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D58821E8A;
        Mon, 18 Sep 2023 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053686; x=1726589686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sd1SNlTvmOATvlRFlysvoBSqt4ze4z/xZDqqZbR2w/A=;
  b=nndvrnwXfBJdThWHu6Dk5E3oW6B8cph4M0E6JJ3qjt9HXFDHHMuwgiqv
   8NCayhc7OW/zFOK2O3ESUOp0Ok5kKXnmZHdbzaa9UlhrFx4zfoILiTlwu
   KY6cpNzMRyqGpGePt7naeBf3u2wnVDwLl66718zs+SpCvt2W9SV18gNBF
   yZ8L5rRoLqAWoQF3gauPZfsqpV7up0JSTVqISNNwpgdDyD1dbtkTb1Njf
   TGAoebCHeafQxQFpri8a1232e0/55B/NVDwiI79UX+p9L29cHQHG8cpu4
   y/9rZLOsL668H+mo0C825rc4LjMcRqDP9j2oZs9aieUI1m4UFfpe5G959
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379564934"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="379564934"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076596418"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="1076596418"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 18 Sep 2023 06:51:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 432D91CA; Mon, 18 Sep 2023 16:51:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/2] platform/x86: think-lmi: Use strreplace() to replace a character by nul
Date:   Mon, 18 Sep 2023 16:51:16 +0300
Message-Id: <20230918135116.1248560-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230918135116.1248560-1-andriy.shevchenko@linux.intel.com>
References: <20230918135116.1248560-1-andriy.shevchenko@linux.intel.com>
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

We can replace
	p = strchrnul(str, '$OLD');
	*p = '\0';
with
	strreplace(str, '$OLD', '\0');
that does the compatible modification without a need of the temporary variable.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on top of review-hans (Hans), added tag (Ilpo)

 drivers/platform/x86/think-lmi.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 4e0d52dc3944..5a1ceb4298a4 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -198,14 +198,6 @@ static struct think_lmi tlmi_priv;
 static struct class *fw_attr_class;
 static DEFINE_MUTEX(tlmi_mutex);
 
-/* ------ Utility functions ------------*/
-/* Strip out CR if one is present */
-static void strip_cr(char *str)
-{
-	char *p = strchrnul(str, '\n');
-	*p = '\0';
-}
-
 /* Convert BIOS WMI error string to suitable error code */
 static int tlmi_errstr_to_err(const char *errstr)
 {
@@ -411,7 +403,7 @@ static ssize_t current_password_store(struct kobject *kobj,
 
 	strscpy(setting->password, buf, setting->maxlen);
 	/* Strip out CR if one is present, setting password won't work if it is present */
-	strip_cr(setting->password);
+	strreplace(setting->password, '\n', '\0');
 	return count;
 }
 
@@ -921,7 +913,7 @@ static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *at
 static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
-	char *item, *value, *p;
+	char *item, *value;
 	int ret;
 
 	ret = tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID);
@@ -934,8 +926,7 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
 		ret = -EINVAL;
 	else {
 		/* On Workstations remove the Options part after the value */
-		p = strchrnul(value, ';');
-		*p = '\0';
+		strreplace(value, ';', '\0');
 		ret = sysfs_emit(buf, "%s\n", value + 1);
 	}
 	kfree(item);
@@ -1540,7 +1531,6 @@ static int tlmi_analyze(void)
 	for (i = 0; i < TLMI_SETTINGS_COUNT; ++i) {
 		struct tlmi_attr_setting *setting;
 		char *item = NULL;
-		char *p;
 
 		tlmi_priv.setting[i] = NULL;
 		ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
@@ -1557,8 +1547,7 @@ static int tlmi_analyze(void)
 		strreplace(item, '/', '\\');
 
 		/* Remove the value part */
-		p = strchrnul(item, ',');
-		*p = '\0';
+		strreplace(item, ',', '\0');
 
 		/* Create a setting entry */
 		setting = kzalloc(sizeof(*setting), GFP_KERNEL);
-- 
2.40.0.1.gaa8946217a0b

