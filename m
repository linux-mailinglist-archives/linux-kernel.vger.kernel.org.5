Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72A7FA07C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjK0NRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjK0NRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:17:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693821A1;
        Mon, 27 Nov 2023 05:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701091030; x=1732627030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hlesYW8rOy1XULs0ORzCaeEOdp4ntoGv7wHs6RrOTq4=;
  b=Arx0+kECHD7iU2ss0hRNKmOwUZNDhXuYU7O6+Arq95nIwECR5753Loiu
   jUJIHz3uBBrnlFytOYeyWLxjIT/dNiwFaSsmsWX02nY1PEjVbRQmjPg5a
   hFDyDZwrSX/IibocZxRF2hds0lvmU1yffwiQWonijwm/I0lMLnEfSoObz
   Hl0qjbMoVDG6M9YgyFfp1/f2oHMxj6xE930mAWLgyzORyl0TOHEqmzVCL
   hffvMvFSKG3bWwGm9dztS3p2u+UR4dVUdc/3iEDMHrYHpOLfTQKbb/Mdv
   Rfj/ao0Snuf+1is6mUBHFBQCBizNRmEc4EftyFulQhRCyMW9dI91j4hRP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="423833674"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="423833674"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 05:17:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="718031609"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="718031609"
Received: from zhipengw-mobl1.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.237])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 05:17:07 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (coretemp) Introduce enum for attr index
Date:   Mon, 27 Nov 2023 21:16:49 +0800
Message-Id: <20231127131651.476795-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127131651.476795-1-rui.zhang@intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce enum coretemp_attr_index to better describe the index of each
sensor attribute and the maximum number of basic/possible attributes.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index ba82d1e79c13..6053ed3761c2 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -43,10 +43,18 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
 #define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
-#define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
-#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
 
+enum coretemp_attr_index {
+	ATTR_LABEL,
+	ATTR_CRIT_ALARM,
+	ATTR_TEMP,
+	ATTR_TJMAX,
+	ATTR_TTARGET,
+	TOTAL_ATTRS,			/* Maximum no of possible attrs */
+	MAX_CORE_ATTRS = ATTR_TJMAX + 1	/* Maximum no of basic attrs */
+};
+
 #ifdef CONFIG_SMP
 #define for_each_sibling(i, cpu) \
 	for_each_cpu(i, topology_sibling_cpumask(cpu))
-- 
2.34.1

