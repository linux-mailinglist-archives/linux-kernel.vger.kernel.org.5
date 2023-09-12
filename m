Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1E979D45D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjILPHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjILPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:07:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B2E7F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694531233; x=1726067233;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5td1gKWCF+rIeOJVYGub5eI8NZKRZhGg2PyDn0c3U94=;
  b=I0YV/487jBgkDiNI55mMr/ujdroKXXLEuEinJIx61c1+GJHHnJ6VQ0aL
   6BFDDwTE/mkEW2iVxvRyOmRyZuizcGHFDJ6Um216WGiWtUQYR/RhXb7tY
   MgweGSdaZWj+/sSqCPHgGINMlXMs93YukOtNNh1Q+T/rpTEcjkPiiWTy0
   dZt4tkaj6KEXr8jeW/m/yf5xmBgRgCqiGbXHkYXZ7LxUwDgV+R+UZwW+l
   0g9U5IkXi74gOskh6Y/SPUHExS+Y+ofco43Pab89JS1Ge70RTZ7H5pZ+S
   jbfjQDqA+eIJj+9vTGeiRHhIgNRaqmMYje66gYiSMn7AKtCu2hbwqcPkz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409356428"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="409356428"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:05:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858836454"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858836454"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2023 08:05:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5DC42248; Tue, 12 Sep 2023 18:05:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()
Date:   Tue, 12 Sep 2023 18:05:46 +0300
Message-Id: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/params.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 2d4a0564697e..3efe6b98a600 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -222,8 +222,7 @@ char *parse_args(const char *doing,
 	}								\
 	int param_get_##name(char *buffer, const struct kernel_param *kp) \
 	{								\
-		return scnprintf(buffer, PAGE_SIZE, format "\n",	\
-				*((type *)kp->arg));			\
+		return sysfs_emit(buffer, format "\n", *((type *)kp->arg));	\
 	}								\
 	const struct kernel_param_ops param_ops_##name = {			\
 		.set = param_set_##name,				\
@@ -287,7 +286,7 @@ EXPORT_SYMBOL(param_set_charp);
 
 int param_get_charp(char *buffer, const struct kernel_param *kp)
 {
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", *((char **)kp->arg));
+	return sysfs_emit(buffer, "%s\n", *((char **)kp->arg));
 }
 EXPORT_SYMBOL(param_get_charp);
 
@@ -318,7 +317,7 @@ EXPORT_SYMBOL(param_set_bool);
 int param_get_bool(char *buffer, const struct kernel_param *kp)
 {
 	/* Y and N chosen as being relatively non-coder friendly */
-	return sprintf(buffer, "%c\n", *(bool *)kp->arg ? 'Y' : 'N');
+	return sysfs_emit(buffer, "%c\n", *(bool *)kp->arg ? 'Y' : 'N');
 }
 EXPORT_SYMBOL(param_get_bool);
 
@@ -377,7 +376,7 @@ EXPORT_SYMBOL(param_set_invbool);
 
 int param_get_invbool(char *buffer, const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%c\n", (*(bool *)kp->arg) ? 'N' : 'Y');
+	return sysfs_emit(buffer, "%c\n", (*(bool *)kp->arg) ? 'N' : 'Y');
 }
 EXPORT_SYMBOL(param_get_invbool);
 
@@ -525,7 +524,8 @@ EXPORT_SYMBOL(param_set_copystring);
 int param_get_string(char *buffer, const struct kernel_param *kp)
 {
 	const struct kparam_string *kps = kp->str;
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", kps->string);
+
+	return sysfs_emit(buffer, "%s\n", kps->string);
 }
 EXPORT_SYMBOL(param_get_string);
 
@@ -859,7 +859,7 @@ ssize_t __modver_version_show(struct module_attribute *mattr,
 	struct module_version_attribute *vattr =
 		container_of(mattr, struct module_version_attribute, mattr);
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", vattr->version);
+	return sysfs_emit(buf, "%s\n", vattr->version);
 }
 
 extern const struct module_version_attribute __start___modver[];
-- 
2.40.0.1.gaa8946217a0b

