Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0905C79E39D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbjIMJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjIMJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:27:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B23A199F;
        Wed, 13 Sep 2023 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694597228; x=1726133228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j/0F9gh51qv3nxHxA3ApGcaoGCNckyw9Qdr3qP/Jtdc=;
  b=av/nzBxyKRi7oxx+syn9zzn16+3CjqHB05SRFmVisL0gH1ggwezJ2rll
   AHDhQFhpMrB5J8WzOvJGigAuLlhkA7hM7Mf7u0HXkLz46LehSI95Axa0Z
   /UA+7IJwDh6i9eGQ38uin4wgJ1YHyPHYe2nb5u6cjB9lYHeEfC34xkN8x
   UEuC4gvH2xQE5Miycat+WNPplKr4ZhQQYrcqya1o2V34N39ld4ZkV7iZw
   DBhPJU2Gm2UsLA8lHQRIKhA0Cp4WoB6ez343/DMp0H16Wx82YKehCkFt3
   QB2y27PlMowt2UW4J12IF+7T1ZwfLzrBYzPeS4aHNkm8VgpC96NrsNkFj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464979134"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="464979134"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867717322"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="867717322"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2023 02:27:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3EC918C9; Wed, 13 Sep 2023 12:27:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] platform/x86: think-lmi: Use strreplace() to replace a character by nul
Date:   Wed, 13 Sep 2023 12:27:01 +0300
Message-Id: <20230913092701.440959-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
References: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can replace
	p = strchrnul(str, '$OLD');
	*p = '\0';
with
	strreplace(str, '$OLD', '\0');
that does the compatible modification without a need of the temporary variable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/think-lmi.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 94a3c7a74bc4..2f20fafe7f55 100644
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
@@ -1418,7 +1409,6 @@ static int tlmi_analyze(void)
 	for (i = 0; i < TLMI_SETTINGS_COUNT; ++i) {
 		struct tlmi_attr_setting *setting;
 		char *item = NULL;
-		char *p;
 
 		tlmi_priv.setting[i] = NULL;
 		ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
@@ -1435,8 +1425,7 @@ static int tlmi_analyze(void)
 		strreplace(item, '/', '\\');
 
 		/* Remove the value part */
-		p = strchrnul(item, ',');
-		*p = '\0';
+		strreplace(item, ',', '\0');
 
 		/* Create a setting entry */
 		setting = kzalloc(sizeof(*setting), GFP_KERNEL);
-- 
2.40.0.1.gaa8946217a0b

