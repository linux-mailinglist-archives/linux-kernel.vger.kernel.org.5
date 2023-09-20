Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E977A7630
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjITImn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjITImd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:42:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BF4B0;
        Wed, 20 Sep 2023 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695199347; x=1726735347;
  h=from:to:cc:subject:date:message-id;
  bh=ZhLtFgkrfa1vb3NSe7b1Jh3EGEctt9IYI0cq0czH4IY=;
  b=i0D60fYdipemgNChU/nDhKlFcfj7moXDGv5VdMYgX+EPaXsH4cfeR1Si
   pG17JbeIRqJCc5ta+zxAc1JP/N1ig82+pXSsxPScCzubwnbJCGh4iC9Ug
   htaPMRMha8+Z+VbDMvftPUrsvVnelChjHoE/n3Q1SdLwsFZkr0B1wrGeV
   oaJHLXuZLpP2pwyYeBOhn354aguWsPnqQ5AvFX5/ykMamC7atd5uVzHyx
   OX+/WUY0KONcmpbdNxX4w85A74y3b7a01GQAk7RDAIlrPa+p28u7vWqNu
   D508il6GAx/serAwL3ti6xl88ergkjemOf/7REkMby5Tg/K9pmDyn9c/r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370479833"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="370479833"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 01:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746564616"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="746564616"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga002.jf.intel.com with ESMTP; 20 Sep 2023 01:42:23 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, paul@crapouillou.net,
        andriy.shevchenko@linux.intel.com, rf@opensource.cirrus.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3] PM: Fix symbol export for _SIMPLE_ variants of _PM_OPS()
Date:   Wed, 20 Sep 2023 14:11:21 +0530
Message-Id: <20230920084121.14131-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently EXPORT_*_SIMPLE_DEV_PM_OPS() use EXPORT_*_DEV_PM_OPS() set
of macros to export dev_pm_ops symbol, which export the symbol in case
CONFIG_PM=y but don't take CONFIG_PM_SLEEP into consideration.

Since _SIMPLE_ variants of _PM_OPS() do not include runtime PM handles
and are only used in case CONFIG_PM_SLEEP=y, we should not be exporting
their dev_pm_ops symbol in case CONFIG_PM_SLEEP=n.

This can be fixed by having two distinct set of export macros for both
_RUNTIME_ and _SIMPLE_ variants of _PM_OPS(), such that the export of
dev_pm_ops symbol used in each variant depends on CONFIG_PM and
CONFIG_PM_SLEEP respectively.

Introduce _DEV_SLEEP_PM_OPS() set of export macros for _SIMPLE_ variants
of _PM_OPS(), which export dev_pm_ops symbol only in case CONFIG_PM_SLEEP=y
and discard it otherwise.

Fixes: 34e1ed189fab ("PM: Improve EXPORT_*_DEV_PM_OPS macros")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
PS: This is a standalone fix and works without updating any drivers.

Changes since v2:
- Drop redundant patches

Changes since v1:
- Update drivers to new set of macros

 include/linux/pm.h | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1400c37b29c7..99a8146fa479 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -374,24 +374,39 @@ const struct dev_pm_ops name = { \
 	RUNTIME_PM_OPS(runtime_suspend_fn, runtime_resume_fn, idle_fn) \
 }
 
-#ifdef CONFIG_PM
-#define _EXPORT_DEV_PM_OPS(name, license, ns)				\
+#define _EXPORT_PM_OPS(name, license, ns)				\
 	const struct dev_pm_ops name;					\
 	__EXPORT_SYMBOL(name, license, ns);				\
 	const struct dev_pm_ops name
-#define EXPORT_PM_FN_GPL(name)		EXPORT_SYMBOL_GPL(name)
-#define EXPORT_PM_FN_NS_GPL(name, ns)	EXPORT_SYMBOL_NS_GPL(name, ns)
-#else
-#define _EXPORT_DEV_PM_OPS(name, license, ns)				\
+
+#define _PM_OPS(name, license, ns)					\
 	static __maybe_unused const struct dev_pm_ops __static_##name
+
+#ifdef CONFIG_PM
+#define _EXPORT_DEV_PM_OPS(name, license, ns)		_EXPORT_PM_OPS(name, license, ns)
+#define EXPORT_PM_FN_GPL(name)				EXPORT_SYMBOL_GPL(name)
+#define EXPORT_PM_FN_NS_GPL(name, ns)			EXPORT_SYMBOL_NS_GPL(name, ns)
+#else
+#define _EXPORT_DEV_PM_OPS(name, license, ns)		_PM_OPS(name, license, ns)
 #define EXPORT_PM_FN_GPL(name)
 #define EXPORT_PM_FN_NS_GPL(name, ns)
 #endif
 
-#define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
-#define EXPORT_GPL_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "GPL", "")
-#define EXPORT_NS_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "", #ns)
-#define EXPORT_NS_GPL_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "GPL", #ns)
+#ifdef CONFIG_PM_SLEEP
+#define _EXPORT_DEV_SLEEP_PM_OPS(name, license, ns)	_EXPORT_PM_OPS(name, license, ns)
+#else
+#define _EXPORT_DEV_SLEEP_PM_OPS(name, license, ns)	_PM_OPS(name, license, ns)
+#endif
+
+#define EXPORT_DEV_PM_OPS(name)				_EXPORT_DEV_PM_OPS(name, "", "")
+#define EXPORT_GPL_DEV_PM_OPS(name)			_EXPORT_DEV_PM_OPS(name, "GPL", "")
+#define EXPORT_NS_DEV_PM_OPS(name, ns)			_EXPORT_DEV_PM_OPS(name, "", #ns)
+#define EXPORT_NS_GPL_DEV_PM_OPS(name, ns)		_EXPORT_DEV_PM_OPS(name, "GPL", #ns)
+
+#define EXPORT_DEV_SLEEP_PM_OPS(name)			_EXPORT_DEV_SLEEP_PM_OPS(name, "", "")
+#define EXPORT_GPL_DEV_SLEEP_PM_OPS(name)		_EXPORT_DEV_SLEEP_PM_OPS(name, "GPL", "")
+#define EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns)		_EXPORT_DEV_SLEEP_PM_OPS(name, "", #ns)
+#define EXPORT_NS_GPL_DEV_SLEEP_PM_OPS(name, ns)	_EXPORT_DEV_SLEEP_PM_OPS(name, "GPL", #ns)
 
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
@@ -404,19 +419,19 @@ const struct dev_pm_ops name = { \
 	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
 
 #define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-	EXPORT_DEV_PM_OPS(name) = { \
+	EXPORT_DEV_SLEEP_PM_OPS(name) = { \
 		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	}
 #define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-	EXPORT_GPL_DEV_PM_OPS(name) = { \
+	EXPORT_GPL_DEV_SLEEP_PM_OPS(name) = { \
 		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	}
 #define EXPORT_NS_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
-	EXPORT_NS_DEV_PM_OPS(name, ns) = { \
+	EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns) = { \
 		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	}
 #define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
-	EXPORT_NS_GPL_DEV_PM_OPS(name, ns) = { \
+	EXPORT_NS_GPL_DEV_SLEEP_PM_OPS(name, ns) = { \
 		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	}
 
-- 
2.17.1

