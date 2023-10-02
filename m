Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88F7B53D7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbjJBNVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjJBNVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:21:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61BEB0;
        Mon,  2 Oct 2023 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696252862; x=1727788862;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fUFfbgGjJz6tv9OfY0S0wOao3CYBuChbfMLdgABf2U4=;
  b=gNueukOY2gkIcNl6pcw8Smjc4YR5K0Hc1XEd+pDuzOEVROmDUMgvs7g/
   72YjNErK+M1Z3Kfn0OFvN4Zqu+34E4SjbmUKtbpeyvNfUDJWjHkYzmzCO
   XSdB8DszFxTTXvK1Nl059sY/lJfS6DDyHBf1MVkVFvP8MazF64mpt7yWn
   AnX1wkgZaWa0MunRUi2pobQBdro7T/pnSTqMML/zNT1DwcQHj5kKYasPf
   Rm5Pe9X5mbXKI5bKxHI6qqGqeDIDT/JvMNp765fiG+RN/DiXDAXLMzfiM
   +DIjbVtHUNHZZguCcv9FrI9ZWqs0sUkICMVfxNcXI3vcXFhY+Mzox4Evd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382546833"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382546833"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="997617882"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="997617882"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga006.fm.intel.com with ESMTP; 02 Oct 2023 06:18:27 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [UPDATE][PATCH] platform/x86/intel-uncore-freq: Conditionally create attribute for read frequency
Date:   Mon,  2 Oct 2023 06:18:17 -0700
Message-Id: <20231002131817.1590966-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
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

When the current uncore frequency can't be read, don't create attribute
"current_freq_khz" as any read will fail later. Some user space
applications like turbostat fail to continue with the failure. So, check
error during attribute creation.

Fixes: 8a54e2253e4c ("platform/x86/intel-uncore-freq: Uncore frequency control via TPMI")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
update
- Added Fixes tag

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
2.40.1

