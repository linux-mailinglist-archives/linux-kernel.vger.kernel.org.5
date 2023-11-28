Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB537FC3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346548AbjK1S4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjK1S4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:56:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7842710CA;
        Tue, 28 Nov 2023 10:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701197797; x=1732733797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5dtYDObwlKHQyEbosOUa1Fd1SVW+pbbQr48EWL4aGw=;
  b=ikNknR8bXrdlQLqx1AIkz+hGNEo0QRt/IFs12Mw7bZWVwLa3U4l1FeM7
   JFXMgffF+R2M2wU2EjpyUB+uQmvOZUMN927MNAQZuvjBcBdr3d4AbzhQG
   UuEv9uauNAMsNdVYMPTadj1AaRg1TJXflhFedxKHx9x3xQpKUDTh1mpMm
   YRp1PNhrLlQ7z45/UeQb8CraiEgINRx3OSXSWDqmfNI76tJYy1UfKE/hy
   DbSdTt/gOnIF/xGjUIwQCdX/GxF3rgHQVb6xu+7I/NaY9ehtjRvAAwdNn
   waLic7yAnNvadGHkTjdwjhsm7b/QSeXnpDqJ1YD/tAU2UPdg+KF1NShxT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="372366960"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="372366960"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="892165782"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="892165782"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2023 10:56:11 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/6] platform/x86/intel/tpmi: Modify external interface to get read/write state
Date:   Tue, 28 Nov 2023 10:56:02 -0800
Message-Id: <20231128185605.3027653-4-srinivas.pandruvada@linux.intel.com>
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

Modify the external interface tpmi_get_feature_status() to get read
and write blocked instead of locked and disabled. Since auxiliary device
is not created when disabled, no use of returning disabled state. Also
locked state is not useful as feature driver can't use locked state
in a meaningful way.

Using read and write state, feature driver can decide which operations
to restrict for that feature.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 8 ++++----
 include/linux/intel_tpmi.h        | 5 ++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 4edaa182db04..44773c210324 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -351,8 +351,8 @@ static int tpmi_read_feature_status(struct intel_tpmi_info *tpmi_info, int featu
 	return ret;
 }
 
-int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id,
-			    int *locked, int *disabled)
+int tpmi_get_feature_status(struct auxiliary_device *auxdev,
+			    int feature_id, int *read_blocked, int *write_blocked)
 {
 	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(auxdev->dev.parent);
 	struct intel_tpmi_info *tpmi_info = auxiliary_get_drvdata(&intel_vsec_dev->auxdev);
@@ -363,8 +363,8 @@ int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id,
 	if (ret)
 		return ret;
 
-	*locked = feature_state.locked;
-	*disabled = !feature_state.enabled;
+	*read_blocked = feature_state.read_blocked;
+	*write_blocked = feature_state.write_blocked;
 
 	return 0;
 }
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index 939663bb095f..a240e15ef77f 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -38,7 +38,6 @@ struct intel_tpmi_plat_info {
 struct intel_tpmi_plat_info *tpmi_get_platform_data(struct auxiliary_device *auxdev);
 struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int index);
 int tpmi_get_resource_count(struct auxiliary_device *auxdev);
-
-int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id, int *locked,
-			    int *disabled);
+int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id, int *read_blocked,
+			    int *write_blocked);
 #endif
-- 
2.41.0

