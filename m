Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB417FC3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345732AbjK1S4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345686AbjK1S4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:56:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4250D64;
        Tue, 28 Nov 2023 10:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701197796; x=1732733796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RpaakXVVU73ujUwc2z7MfhlZOW+dmSN/82961j5n3xI=;
  b=UIMcaI5XJAOEL5sIcrF/s2L8L/Z9iC8Rrso2Z3iRCYHcqDoKuDaaxnpL
   s4G87eUbYnN/Bi3GhgrZyUXPTYc/GOS/Q/8G4IX1D1iLvnxXJMRKSpa3b
   QgdiuVwIPNo/SzPoot7U/01UXs4yiLdxuO76FH1KLwMQ5+R09UzFlBmpO
   WTbXVFUeQeXBE/fEdTua6wEHoD9sZHyOHckN5FoW81nQXnF9cajLAdEUa
   xIkXHZ9ZBY1UGhClw10eZhKqLYbyEkUGjxDI+Rb1tQDQ4du8BpljqslTN
   pUKzXqaHL77E82z7grK7iIQwYqQa7h15xSz13D0jm+Vqj7tG9o7dRFHzG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372366959"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="372366959"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="892165781"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="892165781"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2023 10:56:10 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/6] platform/x86/intel/tpmi: Don't create devices for disabled features
Date:   Tue, 28 Nov 2023 10:56:01 -0800
Message-Id: <20231128185605.3027653-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If some TPMI features are disabled, don't create auxiliary devices. In
this way feature drivers will not load.

While creating auxiliary devices, call tpmi_read_feature_status() to
check feature state and return if the feature is disabled without
creating a device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index c89aa4d14bea..4edaa182db04 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -604,9 +604,17 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
 	struct intel_vsec_device *vsec_dev = tpmi_info->vsec_dev;
 	char feature_id_name[TPMI_FEATURE_NAME_LEN];
 	struct intel_vsec_device *feature_vsec_dev;
+	struct tpmi_feature_state feature_state;
 	struct resource *res, *tmp;
 	const char *name;
-	int i;
+	int i, ret;
+
+	ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &feature_state);
+	if (ret)
+		return ret;
+
+	if (!feature_state.enabled)
+		return -EOPNOTSUPP;
 
 	name = intel_tpmi_name(pfs->pfs_header.tpmi_id);
 	if (!name)
-- 
2.41.0

