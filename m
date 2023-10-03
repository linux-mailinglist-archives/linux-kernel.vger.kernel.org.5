Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497C67B6E88
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbjJCQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240421AbjJCQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:32:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11699E;
        Tue,  3 Oct 2023 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696350758; x=1727886758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8G0SXT1YoMI6eryPCFeRwYtEfFd6ZmcJRUCAjCwNUs=;
  b=VpHWl0qPncQPnZ37z0nrG+m8CAeqAak4Tm/mrMv9F51Z3rbZG9z8wKgU
   lGebvCPBg7XHTlcUYRzOdf/1OZJ9AxCMzAWHSBYWRvNtrTMy1UcKcQzPb
   3hESsan7+T4N6/QAMlwRZ110gB8WnEuUHg0TLxpfQyhyoHQ/1aRJhhcY1
   amSZ5NcVSj0vxFOZrQoOyOEoNTWBKaiDSIx8ALd85WXvVW7MogcxFyrkw
   3ueVghvJQ10/jvxiIVEZZEZC9yaF8ZCCet9tjFqnb5gE0XCtlsiAgmNk7
   6gd+KJVHRA3e63+4RQNc4DDJfECFYrjJYcWc7Pbl24To7z5Jxz/sJPZy8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381799119"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381799119"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082069889"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1082069889"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2023 09:32:37 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/4] platform/x86: ISST: Use fuse enabled mask instead of allowed levels
Date:   Tue,  3 Oct 2023 09:32:31 -0700
Message-Id: <20231003163234.1856669-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231003163234.1856669-1-srinivas.pandruvada@linux.intel.com>
References: <20231003163234.1856669-1-srinivas.pandruvada@linux.intel.com>
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

Allowed level mask is a mask of levels, which are currently allowed to
dynamically switch by the OS. Fused mask is a mask of all levels even if
OS is not allowed to switch.

Even if OS is not allowed to dynamically switch, it is still possible for
user to boot to a level by using BIOS option. To decide which level to
boot next time, user wants to check parameters (power, performance or
thermal) of that level to decide.

So, when passing the level mask for display to user space, use fuse
enabled mask, which has all levels.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- Updated the commit description

 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 63faa2ea8327..a672a1c814af 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -704,7 +704,7 @@ static int isst_if_get_perf_level(void __user *argp)
 		return -EINVAL;
 
 	perf_level.max_level = power_domain_info->max_level;
-	perf_level.level_mask = power_domain_info->pp_header.allowed_level_mask;
+	perf_level.level_mask = power_domain_info->pp_header.level_en_mask;
 	perf_level.feature_rev = power_domain_info->pp_header.feature_rev;
 	_read_pp_info("current_level", perf_level.current_level, SST_PP_STATUS_OFFSET,
 		      SST_PP_LEVEL_START, SST_PP_LEVEL_WIDTH, SST_MUL_FACTOR_NONE)
-- 
2.41.0

