Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA977A887E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbjITPgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjITPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:36:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DA2B9;
        Wed, 20 Sep 2023 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695224155; x=1726760155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=095TFG+/esafxhlqct1nMwm4P7Exlq7oJurduTbg0qg=;
  b=PNhuuOOetjGmsvJHn8xVUPGHAmszU73j3eWW0qWTiLKzPegqC4er3VLg
   HiW5MSFqAmX9zCWFWkQ+YNzuOQ/2ZFiW8Y5gD9yKggDsPW24DUqRV4X2I
   YSKpvE9O4vGsI03Iafy2ONOKLqum/bLBT7PafKlXbvJg79Uc/J/KLdEVJ
   yjBNqcBOsLnCLKhWDFIicLsdbWSkJOkBoyLWtQEUoubvV0PHEhCn4OgRt
   ZfdSTnqShUYjEVciKBghgIY2lNyhOAeKoh2f/knmNsdsjjcwvwWSqOcxM
   vEuoS234FCI/BRNa9wpFd6UChi+ZdPRm+xN+lbF2aFoTq95IaAaSW5Zrf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="380171758"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="380171758"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 08:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="776039235"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="776039235"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2023 08:34:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 77DAC71B; Wed, 20 Sep 2023 18:34:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v1 1/1] interconnect: imx: Replace custom implementation of COUNT_ARGS()
Date:   Wed, 20 Sep 2023 18:34:32 +0300
Message-Id: <20230920153432.2067664-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom and non-portable implementation of COUNT_ARGS().

Fixes: f0d8048525d7 ("interconnect: Add imx core driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/interconnect/imx/imx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
index 895907cdcb3b..4ec9bc5f383e 100644
--- a/drivers/interconnect/imx/imx.h
+++ b/drivers/interconnect/imx/imx.h
@@ -10,6 +10,7 @@
 #ifndef __DRIVERS_INTERCONNECT_IMX_H
 #define __DRIVERS_INTERCONNECT_IMX_H
 
+#include <linux/args.h>
 #include <linux/interconnect-provider.h>
 #include <linux/kernel.h>
 
@@ -89,7 +90,7 @@ struct imx_icc_noc_setting {
 		.id = _id,						\
 		.name = _name,						\
 		.adj = _adj,						\
-		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
+		.num_links = COUNT_ARGS(__VA_ARGS__),			\
 		.links = { __VA_ARGS__ },				\
 	}
 
-- 
2.40.0.1.gaa8946217a0b

