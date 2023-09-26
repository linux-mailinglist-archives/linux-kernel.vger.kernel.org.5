Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361267AF6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjIZXoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjIZXl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:41:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581DB213B;
        Tue, 26 Sep 2023 15:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695769098; x=1727305098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s4nbWPXt0jBdK8UpfhF2ooQidQPMY3DrIy5/uJVqdK8=;
  b=iU2Fx/GlVL9wohH80SGLOGbFsP2CSiKRacxXq/2guosonqLLZjFLOOFk
   EG0/Zm6Om3SGtpESuFF3c6wrTFQJq1TiSm00WQglPWW/4QnYWAQhLGxM8
   ZEJnAHNqSnkatEHFfq08yOBx3aHIGipHGp/df/1MebgosAYwTRmj3ukr1
   u5iAOi54MlDBOr8aWAYOkmEu9F33qz4f3vWQM5dTpKxZ9tMNgNtuAFoDV
   GDU22fXTOl8zT6ZEa9zD8cDykf1pxQNLvLHUm9bQLFiP/CwcZHXGwy+Dt
   r+MZx7sl6LpS/c+QzFeXax2BjcN0I6oAwL4FJG71d76bAKv32IzQsyWtd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412599590"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="412599590"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 15:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752346091"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="752346091"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2023 15:58:15 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/5] thermal: int340x: processor_thermal: Enable power floor support
Date:   Tue, 26 Sep 2023 15:58:12 -0700
Message-Id: <20230926225813.995948-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926225813.995948-1-srinivas.pandruvada@linux.intel.com>
References: <20230926225813.995948-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable power floor feature support for Meteor Lake processors.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index a5accc290a3d..2ca4860df092 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -395,7 +395,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
-	  PROC_THERMAL_FEATURE_WT_HINT) },
+	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
 	{ PCI_DEVICE_DATA(INTEL, ARL_S_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_WT_HINT) },
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
-- 
2.41.0

