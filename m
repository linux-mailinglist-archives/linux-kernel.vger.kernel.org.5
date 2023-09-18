Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1877A4418
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbjIRILB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbjIRIKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:10:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3491;
        Mon, 18 Sep 2023 01:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695024637; x=1726560637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CS1x6EB+y5ievE55O1NlFBffqTHiylV0bTNIqPXKk20=;
  b=PEV7z3GmnQKtbRxOl9Dua5yfh5caz2ETUADcRuDMvh2uUCb+T84c7uUP
   uhsl9KGGnKPuXzuqezeIsTyhm5F4xLCM2wbfu8bmM0DyMhynqPboVDJ64
   /btanz22Rf68iefrK/3m0sLeHMnXuh7v4G/2oqq3thWscPkAECAlHRQmJ
   1cOUVOcoT31Kg97Slegs49pDhqh76UkwhvNnJuNAnlojNhees6ihPkfHJ
   bmllRXmN4OcJaLuz2C3X3t3poHRsGSIxT0YID+rX36sNMX9B1CBBn9B07
   nrVORhkypJVn2C5LVrkWt9zzVszOHBgHnvC/g72NApxHS7obdzZLJHmdy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="410550928"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="410550928"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="695442328"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="695442328"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2023 01:10:26 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, paul@crapouillou.net,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        rmfrfs@gmail.com, jean-baptiste.maneyrol@tdk.com, lee@kernel.org,
        laurentiu.palcu@oss.nxp.com, l.stach@pengutronix.de,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH for-next v2 02/10] PM: Update EXPORT_*_DEV_PM_OPS() to EXPORT_*_RUNTIME_PM_OPS()
Date:   Mon, 18 Sep 2023 13:39:43 +0530
Message-Id: <20230918080951.3615-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918080951.3615-1-raag.jadav@intel.com>
References: <20230918080951.3615-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 6e7ab6950ad1..9ab051f3a351 100644
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
 #define EXPORT_NS_SIMPLE_PM_OPS(name, ns)		_EXPORT_SIMPLE_PM_OPS(name, "", #ns)
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

