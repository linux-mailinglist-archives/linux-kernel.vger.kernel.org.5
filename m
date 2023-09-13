Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E11879E105
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbjIMHmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbjIMHmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:42:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA9C198A;
        Wed, 13 Sep 2023 00:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694590916; x=1726126916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YEdJDHGJGKROfULQ3CMNlWxFjjk89LxF/g8t9X9uSQs=;
  b=icekDOCw/avPzmbwsCWTvjE9sZSedS7WJtGwbXyDHfNKGgZOa18HrrbU
   qCxwAGNCfB+zwVoRaYKhTC5iiu57uJGq2pBiWfN1Lf/K+b6UvHyo//15j
   0eikmUwhsZRuGCm3JgU2DcQG1yryUSFF5ikiG1XRPkj+SuHR+mofQzkEd
   FKr5P+TROVo8C+rWn9BWtux0uRXKPpVXClRqqYMlQJyxYDLUOUNAiD/DQ
   Lde/tWDXaoubgEmqE4ApXrKPT1N5az65I7a3UkOvEOKjIEkV701v1Spf8
   dKqUsOMeIUHYM1xJK/JAg/6NV20DhJDQYMfPWrHVV1b0u0ViZFhyH5lda
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368859139"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="368859139"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 00:41:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747208937"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747208937"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2023 00:41:47 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael.j.wysocki@intel.com, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, paul@crapouillou.net,
        andriy.shevchenko@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [RFC v1 2/2] PM: Update EXPORT_*_DEV_PM_OPS() to EXPORT_*_RUNTIME_PM_OPS()
Date:   Wed, 13 Sep 2023 13:10:32 +0530
Message-Id: <20230913074032.27927-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230913074032.27927-1-raag.jadav@intel.com>
References: <20230913074032.27927-1-raag.jadav@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename EXPORT_*_DEV_PM_OPS() macros to EXPORT_*_RUNTIME_PM_OPS()
and while at it, move them to pm_runtime.h.
This is done in conjunction with the introduction of
EXPORT_*_SIMPLE_PM_OPS() set of macros, to make things less confusing.
This makes both _RUNTIME_ and _SIMPLE_ variants of export macros more
distinguishable and self explanatory.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 include/linux/pm.h         |  5 -----
 include/linux/pm_runtime.h | 13 +++++++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index ae9b4f26d56a..9c6c2322ae5f 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -398,11 +398,6 @@ const struct dev_pm_ops name = { \
 #define _EXPORT_SIMPLE_PM_OPS(name, license, ns)	_PM_OPS(name, license, ns)
 #endif
 
-#define EXPORT_DEV_PM_OPS(name)				_EXPORT_RUNTIME_PM_OPS(name, "", "")
-#define EXPORT_GPL_DEV_PM_OPS(name)			_EXPORT_RUNTIME_PM_OPS(name, "GPL", "")
-#define EXPORT_NS_DEV_PM_OPS(name, ns)			_EXPORT_RUNTIME_PM_OPS(name, "", #ns)
-#define EXPORT_NS_GPL_DEV_PM_OPS(name, ns)		_EXPORT_RUNTIME_PM_OPS(name, "GPL", #ns)
-
 #define EXPORT_SIMPLE_PM_OPS(name)			_EXPORT_SIMPLE_PM_OPS(name, "", "")
 #define EXPORT_GPL_SIMPLE_PM_OPS(name)			_EXPORT_SIMPLE_PM_OPS(name, "GPL", "")
 #define EXPORT_NS_DEV_SIMPLE_OPS(name, ns)		_EXPORT_SIMPLE_PM_OPS(name, "", #ns)
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 7c9b35448563..0b73b00bd59f 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -22,6 +22,11 @@
 					    usage_count */
 #define RPM_AUTO		0x08	/* Use autosuspend_delay */
 
+#define EXPORT_RUNTIME_PM_OPS(name)			_EXPORT_RUNTIME_PM_OPS(name, "", "")
+#define EXPORT_GPL_RUNTIME_PM_OPS(name)			_EXPORT_RUNTIME_PM_OPS(name, "GPL", "")
+#define EXPORT_NS_RUNTIME_PM_OPS(name, ns)		_EXPORT_RUNTIME_PM_OPS(name, "", #ns)
+#define EXPORT_NS_GPL_RUNTIME_PM_OPS(name, ns)		_EXPORT_RUNTIME_PM_OPS(name, "GPL", #ns)
+
 /*
  * Use this for defining a set of PM operations to be used in all situations
  * (system suspend, hibernation or runtime PM).
@@ -40,19 +45,19 @@
 			   resume_fn, idle_fn)
 
 #define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
-	EXPORT_DEV_PM_OPS(name) = { \
+	EXPORT_RUNTIME_PM_OPS(name) = { \
 		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	}
 #define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
-	EXPORT_GPL_DEV_PM_OPS(name) = { \
+	EXPORT_GPL_RUNTIME_PM_OPS(name) = { \
 		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	}
 #define EXPORT_NS_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
-	EXPORT_NS_DEV_PM_OPS(name, ns) = { \
+	EXPORT_NS_RUNTIME_PM_OPS(name, ns) = { \
 		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	}
 #define EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
-	EXPORT_NS_GPL_DEV_PM_OPS(name, ns) = { \
+	EXPORT_NS_GPL_RUNTIME_PM_OPS(name, ns) = { \
 		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	}
 
-- 
2.17.1

