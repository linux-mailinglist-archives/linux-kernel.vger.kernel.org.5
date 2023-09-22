Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D627AA882
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 07:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjIVFrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 01:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVFrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:47:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13718F;
        Thu, 21 Sep 2023 22:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695361628; x=1726897628;
  h=from:to:cc:subject:date:message-id;
  bh=E934W0ha3pK8ajkIFoaGlzg0zJoW8eJf9K2yV/pdMhs=;
  b=N5p0MKEwtap6HfFcQBJPnPWH0Cd9CpxH4qVAFGCXVO5Qe/sqpkKrsQPg
   Az8IHHzL9/AFQzTGRgDrVYqn89vdApVHlIkQkgpn5SfF5ItrgQf2hKCuF
   p0o7sc7Em+KglcXK1wQf7iZRw8LuDw6fowwik1Z8J352x5qVFPKTdAwpt
   RI7+I3aU+Zc+fJBw09k+pC87N4WMG3++atBEvq0Xtzs2Zt7Fe7gkd+fLi
   R5dTfAoL/BCaOYOqr/KeE92QxPPkpO678wwbqvK32Fm5MAX8MsLfpbpmZ
   TCDPb+Sl0xZRPl/ANOySWUaC0rReoMeXvstXuo3E8W7LEKEr3bfiz51kV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="411688436"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="411688436"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 22:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="871136956"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="871136956"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga004.jf.intel.com with ESMTP; 21 Sep 2023 22:47:04 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, paul@crapouillou.net,
        andriy.shevchenko@linux.intel.com, rf@opensource.cirrus.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4] PM: Fix symbol export for _SIMPLE_ variants of _PM_OPS()
Date:   Fri, 22 Sep 2023 11:15:52 +0530
Message-Id: <20230922054552.3570-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
dev_pm_ops symbol for them in case CONFIG_PM_SLEEP=n.

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
PS: This is a standalone fix and works without updating existing drivers.

Changes since v3:
- Rename _PM_OPS macro to _DISCARD_PM_OPS

Changes since v2:
- Drop redundant patches

Changes since v1:
- Update drivers to new set of macros

 include/linux/pm.h | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1400c37b29c7..629c1633bbd0 100644
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
+#define _DISCARD_PM_OPS(name, license, ns)				\
 	static __maybe_unused const struct dev_pm_ops __static_##name
+
+#ifdef CONFIG_PM
+#define _EXPORT_DEV_PM_OPS(name, license, ns)		_EXPORT_PM_OPS(name, license, ns)
+#define EXPORT_PM_FN_GPL(name)				EXPORT_SYMBOL_GPL(name)
+#define EXPORT_PM_FN_NS_GPL(name, ns)			EXPORT_SYMBOL_NS_GPL(name, ns)
+#else
+#define _EXPORT_DEV_PM_OPS(name, license, ns)		_DISCARD_PM_OPS(name, license, ns)
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
+#define _EXPORT_DEV_SLEEP_PM_OPS(name, license, ns)	_DISCARD_PM_OPS(name, license, ns)
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

