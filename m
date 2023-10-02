Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044327B51D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbjJBL4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbjJBL4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:56:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE9E94;
        Mon,  2 Oct 2023 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696247791; x=1727783791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IRRnuOQjo/t+81SN6PQRu1LzvvNzgDfNyCxd/Q98TH4=;
  b=D6LKC8nIvUlYh++51BDfyD47vm1F0VT6bI4WVwxRImARXTTZnE5U6mm5
   ZtsrJR0yor6C+eDTQaayXE8P28oWYEAf2gyIeBOUAsB66YyRL8xQR3jQ4
   lmY+O9I35g2cl/XDRW/1mQ+8A3hqDIvxkcCY/doviK0+6saW547H1sDEU
   P2CjhckoHwqN3fg2MEWezeG5HF4TncYlZ37/0/nBFFhONsvvHWJlckZB0
   3JfLzAVce98UPhNBj6nFzRRFHC/9NRF2i/iimWTNXh+3Edjf2pb5frhAl
   3okX7YLmGKwx+1UFcojUJ035AtpoGjDWlhe0rqVhcxHCSLWvk6ZexB458
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="362004204"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362004204"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="750560388"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="750560388"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga002.jf.intel.com with ESMTP; 02 Oct 2023 04:56:31 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86/intel-uncore-freq: Conditionally create attribute for read frequency
Date:   Mon,  2 Oct 2023 04:56:22 -0700
Message-Id: <20231002115622.1588852-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
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

When the current uncore frequency can't be read, don't create attribute
"current_freq_khz" as any read will fail later. Some user space
applications like turbostat fail to continue with the failure. So, check
error during attribute creation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
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

