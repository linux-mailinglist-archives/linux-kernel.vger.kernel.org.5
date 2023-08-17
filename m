Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395C677F931
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351967AbjHQOf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352006AbjHQOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:35:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A353F2D76;
        Thu, 17 Aug 2023 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692282919; x=1723818919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gYxhWsxBuKSfOrpimz2j36ZBLG0MdLl1mWDJPTh+l74=;
  b=YZCxXmpOri155w/lIePdQljF2+d1Q3X52QImUIr71pCoUNJ2bSpmBKUG
   R6KjN9/EXyz5qNMQXy+/4V6HN6JiV7jrMuc4CmoeeGn+qOMYOdGYx/etY
   qhwGL1HIIcHM6mTNdVSDhuOaRbhKY9kjR6jxwOsVxMeF2/KQGiyTh0JG0
   w3sMhy4ob/4CzFcqyFEEHXmhNNH3cYfrbcYpzUsijdDyucoJPYfRd0LyP
   0ri8cjMMhJ1llkYCKCygrMbjtBMT/FUosRMIXnqfwmIaQ3G6ViWD675le
   DyKh2VRxmXIX1Z9Vm7XCSEXnfgNrHfn3dOsZXXOc6G3uJGjKdKlARBZd+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="357799604"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="357799604"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="848898010"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848898010"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 07:35:17 -0700
From:   Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        andriy.shevchenko@intel.com, alx.manpages@gmail.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 1/4] linux/array_size.h: Move ARRAY_SIZE(arr) to a separate header
Date:   Thu, 17 Aug 2023 16:33:14 +0200
Message-ID: <20230817143352.132583-2-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
References: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alejandro Colomar <alx.manpages@gmail.com>

Touching files so used for the kernel,
forces 'make' to recompile most of the kernel.

Having those definitions in more granular files
helps avoid recompiling so much of the kernel.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 include/linux/array_size.h                    | 13 +++++++++++++
 include/linux/clk-provider.h                  |  1 +
 include/linux/counter.h                       |  1 +
 include/linux/genl_magic_func.h               |  1 +
 include/linux/hashtable.h                     |  1 +
 include/linux/kernel.h                        |  7 +------
 include/linux/kfifo.h                         |  1 +
 include/linux/kvm_host.h                      |  1 +
 include/linux/moduleparam.h                   |  2 ++
 include/linux/mtd/rawnand.h                   |  1 +
 include/linux/netfilter.h                     |  1 +
 include/linux/pagemap.h                       |  1 +
 include/linux/phy.h                           |  1 +
 include/linux/pinctrl/machine.h               |  2 +-
 include/linux/property.h                      |  1 +
 include/linux/rcupdate_wait.h                 |  1 +
 include/linux/regmap.h                        |  1 +
 include/linux/skmsg.h                         |  1 +
 include/linux/string.h                        |  1 +
 include/linux/surface_aggregator/controller.h |  1 +
 20 files changed, 33 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/array_size.h

diff --git a/include/linux/array_size.h b/include/linux/array_size.h
new file mode 100644
index 000000000000..06d7d83196ca
--- /dev/null
+++ b/include/linux/array_size.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ARRAY_SIZE_H
+#define _LINUX_ARRAY_SIZE_H
+
+#include <linux/compiler.h>
+
+/**
+ * ARRAY_SIZE - get the number of elements in array @arr
+ * @arr: array to be sized
+ */
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
+
+#endif  /* _LINUX_ARRAY_SIZE_H */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 0f0cd01906b4..4f4d4f4af0a6 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -6,6 +6,7 @@
 #ifndef __LINUX_CLK_PROVIDER_H
 #define __LINUX_CLK_PROVIDER_H
 
+#include <linux/array_size.h>
 #include <linux/of.h>
 #include <linux/of_clk.h>
 
diff --git a/include/linux/counter.h b/include/linux/counter.h
index b63746637de2..baf4ffcd8d18 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -6,6 +6,7 @@
 #ifndef _COUNTER_H_
 #define _COUNTER_H_
 
+#include <linux/array_size.h>
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
diff --git a/include/linux/genl_magic_func.h b/include/linux/genl_magic_func.h
index 2984b0cb24b1..cec9cae51f0b 100644
--- a/include/linux/genl_magic_func.h
+++ b/include/linux/genl_magic_func.h
@@ -2,6 +2,7 @@
 #ifndef GENL_MAGIC_FUNC_H
 #define GENL_MAGIC_FUNC_H
 
+#include <linux/array_size.h>
 #include <linux/build_bug.h>
 #include <linux/genl_magic_struct.h>
 
diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index f6c666730b8c..09c5f1522b06 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_HASHTABLE_H
 #define _LINUX_HASHTABLE_H
 
+#include <linux/array_size.h>
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0d91e0af0125..7195c6f27a22 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_KERNEL_H
 #define _LINUX_KERNEL_H
 
+#include <linux/array_size.h>
 #include <linux/stdarg.h>
 #include <linux/align.h>
 #include <linux/limits.h>
@@ -49,12 +50,6 @@
 #define READ			0
 #define WRITE			1
 
-/**
- * ARRAY_SIZE - get the number of elements in array @arr
- * @arr: array to be sized
- */
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
-
 #define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
 
 #define u64_to_user_ptr(x) (		\
diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 0b35a41440ff..b6fdd92ccb56 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -36,6 +36,7 @@
  * to lock the reader.
  */
 
+#include <linux/array_size.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9d3ac7720da9..a629b398a592 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -3,6 +3,7 @@
 #define __KVM_HOST_H
 
 
+#include <linux/array_size.h>
 #include <linux/types.h>
 #include <linux/hardirq.h>
 #include <linux/list.h>
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 962cd41a2cb5..3cecef5fa1cf 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_MODULE_PARAMS_H
 #define _LINUX_MODULE_PARAMS_H
 /* (C) Copyright 2001, 2002 Rusty Russell IBM Corporation */
+
+#include <linux/array_size.h>
 #include <linux/init.h>
 #include <linux/stringify.h>
 #include <linux/kernel.h>
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 5159d692f9ce..cd27ef633a4f 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -13,6 +13,7 @@
 #ifndef __LINUX_MTD_RAWNAND_H
 #define __LINUX_MTD_RAWNAND_H
 
+#include <linux/array_size.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/flashchip.h>
diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index d4fed4c508ca..f9ca506c4261 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_NETFILTER_H
 #define __LINUX_NETFILTER_H
 
+#include <linux/array_size.h>
 #include <linux/init.h>
 #include <linux/skbuff.h>
 #include <linux/net.h>
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 716953ee1ebd..7a3de980ed9d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -5,6 +5,7 @@
 /*
  * Copyright 1995 Linus Torvalds
  */
+#include <linux/array_size.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/list.h>
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 11c1e91563d4..39e88b570ead 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -11,6 +11,7 @@
 #ifndef __PHY_H
 #define __PHY_H
 
+#include <linux/array_size.h>
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/ethtool.h>
diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/machine.h
index 0639b36f43c5..ee8803f6ad07 100644
--- a/include/linux/pinctrl/machine.h
+++ b/include/linux/pinctrl/machine.h
@@ -11,7 +11,7 @@
 #ifndef __LINUX_PINCTRL_MACHINE_H
 #define __LINUX_PINCTRL_MACHINE_H
 
-#include <linux/kernel.h>	/* ARRAY_SIZE() */
+#include <linux/array_size.h>
 
 #include <linux/pinctrl/pinctrl-state.h>
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 8c3c6685a2ae..f7889c7c3a66 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -10,6 +10,7 @@
 #ifndef _LINUX_PROPERTY_H_
 #define _LINUX_PROPERTY_H_
 
+#include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/fwnode.h>
 #include <linux/stddef.h>
diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 699b938358bf..a321404eeec0 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -6,6 +6,7 @@
  * RCU synchronization types and methods:
  */
 
+#include <linux/array_size.h>
 #include <linux/rcupdate.h>
 #include <linux/completion.h>
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 8fc0b3ebce44..af0430dc0945 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -10,6 +10,7 @@
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
  */
 
+#include <linux/array_size.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/ktime.h>
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 054d7911bfc9..d7e3b9f46d58 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -4,6 +4,7 @@
 #ifndef _LINUX_SKMSG_H
 #define _LINUX_SKMSG_H
 
+#include <linux/array_size.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/scatterlist.h>
diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..3c920b6d609b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_STRING_H_
 #define _LINUX_STRING_H_
 
+#include <linux/array_size.h>
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
diff --git a/include/linux/surface_aggregator/controller.h b/include/linux/surface_aggregator/controller.h
index cb7980805920..dcce0b663a3a 100644
--- a/include/linux/surface_aggregator/controller.h
+++ b/include/linux/surface_aggregator/controller.h
@@ -12,6 +12,7 @@
 #ifndef _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H
 #define _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H
 
+#include <linux/array_size.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/types.h>
-- 
2.41.0

