Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DFD7A88E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbjITPtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjITPth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:49:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4BFAF;
        Wed, 20 Sep 2023 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695224972; x=1726760972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9BObM4Lytu9yb7SGsKBARlJL+kOZDhJhXYFWzJTPPfU=;
  b=iZ4wPBfBgQABGZ8g/ETgLej1sJQxucwYqRou2+crFVBxj9i0CWHFnFRr
   LNlaRzlwKrVunZ4TIJbfQ4NSM/1pags949duo4FaNvfXCO4YkQBQh4sdp
   /iPdUkV/WkVHvUgnoGyWLe4IilqKFjEiZDPFk2uqpqvc2W7v+f/BNJpnu
   jTM/B7lkbImHREtRWRl+cVuWQ682YwGCLmBnw7BczVYv27t4kNn3fthmw
   J/kG7FftezdKgfhfVh26bL98+Kc0QANf3RRQLHbABaDG3qUwMF350+JSc
   AFftkO3N793wH7i7Y1WtJG77eOw+duzwYuDKdW8H1r9VNF3kT6DtCMsGN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="446730107"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="446730107"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 08:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="993654619"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="993654619"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Sep 2023 08:49:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E416F71B; Wed, 20 Sep 2023 18:49:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] interconnect: qcom: osm-l3: Replace custom implementation of COUNT_ARGS()
Date:   Wed, 20 Sep 2023 18:49:27 +0300
Message-Id: <20230920154927.2090732-1-andriy.shevchenko@linux.intel.com>
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

Fixes: 5bc9900addaf ("interconnect: qcom: Add OSM L3 interconnect provider support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/interconnect/qcom/osm-l3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index dc321bb86d0b..e97478bbc282 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/args.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/interconnect-provider.h>
@@ -78,7 +79,7 @@ enum {
 		.name = #_name,						\
 		.id = _id,						\
 		.buswidth = _buswidth,					\
-		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
+		.num_links = COUNT_ARGS(__VA_ARGS__),			\
 		.links = { __VA_ARGS__ },				\
 	}
 
-- 
2.40.0.1.gaa8946217a0b

