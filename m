Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B67E7ADA5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjIYOuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjIYOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:49:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E9B180;
        Mon, 25 Sep 2023 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695653391; x=1727189391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=84m75FsmmCxHAs5Vy3y5UlBCIG1MzYs7Y5oMZFaEZNo=;
  b=PPliPTRYiWutXQRnH+SS2qS0dz3S0dZF04BfpK+qpTXcK778PhJuiUxN
   /+cWRoELWJdKYvtiT0Gy1NhmOyO1yJyMbjh0drpewkWM+/uo6d0jxmU2Q
   WwBWB3f48NWweQ1j0xx9/UuTCgEd2SnmolDr6S5xzzralceNHSzmwtuIi
   dYapuildU1x1FwLvG6cf4AbKMWgnPivaVBKuh4I02QpIBAtFcAJkKcKus
   b+WoRcavklTnjeMoDXW3dHWboqiLQ3d/6nyVhe3RCkACXpx6J4/Ws41sR
   7nzjl6GVXIP1qfB6m6Ig84evbZ2eqoiIqVsIADZBYnNCBu98SpSltzzGZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378548124"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="378548124"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995409563"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995409563"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:41 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, rui.zhang@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 9/9] ACPI: NFIT: Don't use KBUILD_MODNAME for driver name
Date:   Mon, 25 Sep 2023 17:48:42 +0300
Message-ID: <20230925144842.586829-10-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925144842.586829-1-michal.wilczynski@intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver name is part of the ABI, so it should be hard-coded, as ABI
should be always kept backward compatible. Prevent ABI from changing
accidentally in case KBUILD_MODNAME change.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f09530d2520a..987eb5567036 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3478,7 +3478,7 @@ MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
 static struct platform_driver acpi_nfit_driver = {
 	.probe = acpi_nfit_probe,
 	.driver = {
-		.name = KBUILD_MODNAME,
+		.name = "nfit",
 		.acpi_match_table = acpi_nfit_ids,
 	},
 };
-- 
2.41.0

