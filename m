Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0357B88C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjJDST2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjJDST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:19:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D241CA6;
        Wed,  4 Oct 2023 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696443562; x=1727979562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=398Y4rRHiy+pPsE5SVEZ7szUZOVOCdlOKy5wmqw0uZI=;
  b=USaAEg3lE0w4IHKBZcawZMLQFItzxy8HpLEzcQmRDxcOOjZLvYj54foI
   quKqYvGw5Yu+SQQnYQ3+7kbAxH1btVmZXuEHcs1rqhHXGI48AHnGbzNfj
   Kjl5G8pqJRaPVxAtoqVDCn3atyay+SaTp1ZmtQU64SpoOHyL1i1TxkunA
   Ue+PvHKMxq8pcFR0d1e988HMC3IBiNrk+45Znp8zHuhs720rx0OHFPlyO
   D/5GFGrFjZAalUUPRcV75JiOC/WtwMP4UurBJrN0JVyrDxsa8wXJ0tYMt
   neaJpHCWHMIbUo2kE1Z/21Kl/PnolbFBZW3mciezat2fyjNsDfQROw69K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383164361"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="383164361"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="925269272"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="925269272"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga005.jf.intel.com with ESMTP; 04 Oct 2023 11:19:19 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [UPDATE][PATCH] platform/x86/intel-uncore-freq: Conditionally create attribute for read frequency
Date:   Wed,  4 Oct 2023 11:19:15 -0700
Message-Id: <20231004181915.1887913-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the current uncore frequency can't be read, don't create attribute
"current_freq_khz" as any read will fail later. Some user space
applications like turbostat fail to continue with the failure. So, check
error during attribute creation.

Fixes: 414eef27283a ("platform/x86/intel/uncore-freq: Display uncore current frequency")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Added fixes tag which added current_freq_khz. But after this
tag there is reorg of code, so need manual backport for some versions.
I will separately submit to stable trees after merge.

 .../x86/intel/uncore-frequency/uncore-frequency-common.c  | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 1152deaa0078..33ab207493e3 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -176,7 +176,7 @@ show_uncore_data(initial_max_freq_khz);
 
 static int create_attr_group(struct uncore_data *data, char *name)
 {
-	int ret, index = 0;
+	int ret, freq, index = 0;
 
 	init_attribute_rw(max_freq_khz);
 	init_attribute_rw(min_freq_khz);
@@ -197,7 +197,11 @@ static int create_attr_group(struct uncore_data *data, char *name)
 	data->uncore_attrs[index++] = &data->min_freq_khz_dev_attr.attr;
 	data->uncore_attrs[index++] = &data->initial_min_freq_khz_dev_attr.attr;
 	data->uncore_attrs[index++] = &data->initial_max_freq_khz_dev_attr.attr;
-	data->uncore_attrs[index++] = &data->current_freq_khz_dev_attr.attr;
+
+	ret = uncore_read_freq(data, &freq);
+	if (!ret)
+		data->uncore_attrs[index++] = &data->current_freq_khz_dev_attr.attr;
+
 	data->uncore_attrs[index] = NULL;
 
 	data->uncore_attr_group.name = name;
-- 
2.41.0

