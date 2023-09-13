Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A2B79E102
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbjIMHlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjIMHlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:41:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE4B1729;
        Wed, 13 Sep 2023 00:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694590907; x=1726126907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=t2NP+b+20XyODzklEgy6Nzs7Ja68QzhRWvysWYPgX50=;
  b=ejmxYs+GDHjni8vHA8D/3chSYbFXBfntJCKDP1bxSRlNqkz0X3aohM74
   qDutBlNQzQkhqxnv3e8dLvUVhMBz3SHr7rvqTwfJh8z8gwQY0vpiQYtdv
   2j5Ss1BOYu6+6j/jqiXNCXFrJJn2JMbcW4rOKyk49bYSkcxnDCsGP+50b
   KX5vd+cURJZDJqCT9fHzKng8T7HFhpBOSFVb/jYD0F8pBVgur21/g9ki7
   yuvuo5c84EYx7ys0NGINTdGWjgAzUGhlIawm7mOd5NLN5DUTD9DVhNo7X
   nwh16t9qcElGt/A+nk3LA3tCxplRsRexkqOslFTJG++oIJtyuXavFJ62s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368859103"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="368859103"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 00:41:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747208904"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747208904"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2023 00:41:44 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael.j.wysocki@intel.com, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, paul@crapouillou.net,
        andriy.shevchenko@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [RFC v1 1/2] PM: Introduce export macros for _SIMPLE_ variants of _PM_OPS()
Date:   Wed, 13 Sep 2023 13:10:31 +0530
Message-Id: <20230913074032.27927-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230913074032.27927-1-raag.jadav@intel.com>
References: <20230913074032.27927-1-raag.jadav@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new set of export macros for _SIMPLE_ variants of _PM_OPS(),
which export dev_pm_ops symbol only in case CONFIG_PM_SLEEP=y and discard
it otherwise.

Fixes: 34e1ed189fab ("PM: Improve EXPORT_*_DEV_PM_OPS macros")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 include/linux/pm.h | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1400c37b29c7..ae9b4f26d56a 100644
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
+#define _EXPORT_RUNTIME_PM_OPS(name, license, ns)	_EXPORT_PM_OPS(name, license, ns)
+#define EXPORT_PM_FN_GPL(name)				EXPORT_SYMBOL_GPL(name)
+#define EXPORT_PM_FN_NS_GPL(name, ns)			EXPORT_SYMBOL_NS_GPL(name, ns)
+#else
+#define _EXPORT_RUNTIME_PM_OPS(name, license, ns)	_PM_OPS(name, license, ns)
 #define EXPORT_PM_FN_GPL(name)
 #define EXPORT_PM_FN_NS_GPL(name, ns)
 #endif
 
-#define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
-#define EXPORT_GPL_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "GPL", "")
-#define EXPORT_NS_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "", #ns)
-#define EXPORT_NS_GPL_DEV_PM_OPS(name, ns) _EXPORT_DEV_PM_OPS(name, "GPL", #ns)
+#ifdef CONFIG_PM_SLEEP
+#define _EXPORT_SIMPLE_PM_OPS(name, license, ns)	_EXPORT_PM_OPS(name, license, ns)
+#else
+#define _EXPORT_SIMPLE_PM_OPS(name, license, ns)	_PM_OPS(name, license, ns)
+#endif
+
+#define EXPORT_DEV_PM_OPS(name)				_EXPORT_RUNTIME_PM_OPS(name, "", "")
+#define EXPORT_GPL_DEV_PM_OPS(name)			_EXPORT_RUNTIME_PM_OPS(name, "GPL", "")
+#define EXPORT_NS_DEV_PM_OPS(name, ns)			_EXPORT_RUNTIME_PM_OPS(name, "", #ns)
+#define EXPORT_NS_GPL_DEV_PM_OPS(name, ns)		_EXPORT_RUNTIME_PM_OPS(name, "GPL", #ns)
+
+#define EXPORT_SIMPLE_PM_OPS(name)			_EXPORT_SIMPLE_PM_OPS(name, "", "")
+#define EXPORT_GPL_SIMPLE_PM_OPS(name)			_EXPORT_SIMPLE_PM_OPS(name, "GPL", "")
+#define EXPORT_NS_DEV_SIMPLE_OPS(name, ns)		_EXPORT_SIMPLE_PM_OPS(name, "", #ns)
+#define EXPORT_NS_GPL_SIMPLE_PM_OPS(name, ns)		_EXPORT_SIMPLE_PM_OPS(name, "GPL", #ns)
 
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
@@ -404,19 +419,19 @@ const struct dev_pm_ops name = { \
 	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
 
 #define EXPORT_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-	EXPORT_DEV_PM_OPS(name) = { \
+	EXPORT_SIMPLE_PM_OPS(name) = { \
 		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	}
 #define EXPORT_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-	EXPORT_GPL_DEV_PM_OPS(name) = { \
+	EXPORT_GPL_SIMPLE_PM_OPS(name) = { \
 		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	}
 #define EXPORT_NS_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
-	EXPORT_NS_DEV_PM_OPS(name, ns) = { \
+	EXPORT_NS_SIMPLE_PM_OPS(name, ns) = { \
 		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	}
 #define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn, ns)	\
-	EXPORT_NS_GPL_DEV_PM_OPS(name, ns) = { \
+	EXPORT_NS_GPL_SIMPLE_PM_OPS(name, ns) = { \
 		SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
 	}
 
-- 
2.17.1

