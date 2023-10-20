Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55597D0AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376562AbjJTIs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376523AbjJTIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:48:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69FED52;
        Fri, 20 Oct 2023 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697791693; x=1729327693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ycYM//IBzYahr1OT+k/0SqcANs76449DXAt6/AuLX9M=;
  b=DGUfNDHyfUwZk67l/7ienlCmcACFM+T7a4497ecipvcMGwx61kTH96cj
   hjnCzgj9WGBuqM+LFN8O8o3+9/xOkEF2BA+lTCQnVDWD7hcve1H7IGHLI
   nLK7P48ZxPFlyKsutg+LrQgjACIV7Caxs6wZNmXM5vi0MKPZQbrEhQd/W
   Q8CYhzQeRCI96r5vfj5wRaj9L8v60Swjwd1o024ecpzsmjufeA/421ZF0
   RGn0sW/HRZCp7U0/Sj+wR41rZlQ3XVciY8XDuSsrJGK3K/ygaQOI3r3Js
   5U9Pfiy1CSvrtUs17fxQ7GO5GaXDwckDTfuFNsyGTe0ByS2544JgchEqI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450683524"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450683524"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 01:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873832171"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873832171"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2023 01:48:01 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 4/8] ACPI: utils: use acpi_dev_uid_match() for matching _UID
Date:   Fri, 20 Oct 2023 14:17:28 +0530
Message-Id: <20231020084732.17130-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231020084732.17130-1-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert manual _UID references to use standard ACPI helpers.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 664b9890b625..e3ba835e6590 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -889,8 +889,7 @@ static int acpi_dev_match_cb(struct device *dev, const void *data)
 	if (acpi_match_device_ids(adev, match->hid))
 		return 0;
 
-	if (match->uid && (!adev->pnp.unique_id ||
-	    strcmp(adev->pnp.unique_id, match->uid)))
+	if (!acpi_dev_uid_match(adev, match->uid))
 		return 0;
 
 	if (match->hrv == -1)
-- 
2.17.1

