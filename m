Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B867A88A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbjITPls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjITPlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:41:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA8A3;
        Wed, 20 Sep 2023 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695224499; x=1726760499;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4IOq3bQcNP6yRaXPURSd0zbJucIiKE6IcStgAukEsjA=;
  b=lDHSGO8ql7CKj3xd5C4d+S1xp/ne1jP18tqmmhhCDCRK76PO9KrxBN11
   s4fZhCRVl/Fgd6cBziDdU/AnpHf6TuYO2E0T0Cqydt7NB5+bTEQnLgVXl
   uOlI3LospGwCTQn+TjFgjJLPggWTJkiWa74/YWjlsQAegSHrfU0Yij71o
   CVoHM6f0ikYoC2dCIL4OY/K3w03/tcBMLEmLMQOEdKfsb6qnkKSBrPPeW
   qCnVXL88b8OSIcf2W2mWYTDTRLoQ3gd68qsm0L1NOGGfCQIA5IHSCmoer
   WYqDjJ5OsGJNDVtmZL8ZqXL37afd7PjUKjAkwS9riecLW0ChBcrgNneLA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359647735"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359647735"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 08:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812198866"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="812198866"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 20 Sep 2023 08:41:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 31F3471B; Wed, 20 Sep 2023 18:41:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Georgi Djakov <djakov@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] interconnect: msm8974: Replace custom implementation of COUNT_ARGS()
Date:   Wed, 20 Sep 2023 18:41:31 +0300
Message-Id: <20230920154131.2071112-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom and non-portable implementation of COUNT_ARGS().

Fixes: 4e60a9568dc6 ("interconnect: qcom: add msm8974 driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/interconnect/qcom/msm8974.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 885ca9d6d4ed..21f6c852141e 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -28,6 +28,8 @@
  */
 
 #include <dt-bindings/interconnect/qcom,msm8974.h>
+
+#include <linux/args.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
@@ -231,7 +233,7 @@ struct msm8974_icc_desc {
 		.buswidth = _buswidth,					\
 		.mas_rpm_id = _mas_rpm_id,				\
 		.slv_rpm_id = _slv_rpm_id,				\
-		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
+		.num_links = COUNT_ARGS(__VA_ARGS__),			\
 		.links = { __VA_ARGS__ },				\
 	}
 
-- 
2.40.0.1.gaa8946217a0b

