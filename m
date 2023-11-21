Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA37F2626
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjKUHIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUHIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:08:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C69790;
        Mon, 20 Nov 2023 23:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700550513; x=1732086513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j1YTYr5QMSSnYnwbqsWG2+lRzMcgqrlEjIafePktic4=;
  b=ViOdeK6wLhqEp/vX2pe3UP+iZhZYRq1A0Ke1HlPcwKDsNzQMMDOdahXP
   49UqcwakGzI7f0J1xx5L1vodxEYdXYszkl76xbP7d/yueaJ9OaCBMSxSX
   dUDSEjzlZZB69IH5EkFx3Y3X4o4SH0CXXTidhS7l5Og9K8+QXfX1qOpvo
   yx6WBy8hrNnGkseZLmTVmO9B9PprzxckWoIYoLXapNh5lMVgerpj5oRiH
   gTCNPWGjGtyzgMV5iPAZvcYLtpg08wyaej17viNd8nsIL3lwr7LuGfgyy
   3YJHbnDnGVdc0PKZp+SobyUc2NljDwV/pSJfHgFIZoqfE8ycgZ3unvvXO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376817041"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376817041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884097545"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="884097545"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:08:31 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id C9EE611FC2D;
        Tue, 21 Nov 2023 09:08:27 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH 1/1] ACPI: scan: Fix an error print in DisCo for Imaging support
Date:   Tue, 21 Nov 2023 09:08:26 +0200
Message-Id: <20231121070826.1637628-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
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

The recently merged DisCo for Imaging support used a wrong printk
specifier in printing a message. Fix it by using %zu instead of %lu.
Also use "bits" instead of "bytes" as these are indeed bytes.

Fixes: a6cb0a611273 ("ACPI: scan: Extract MIPI DisCo for Imaging data into swnodes")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/mipi-disco-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index cad72d1fc127..7286cf4579bc 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -533,7 +533,7 @@ static void init_csi2_port(struct acpi_device *adev,
 	if (ret < 0) {
 		acpi_handle_debug(handle, "Lane polarity bytes missing\n");
 	} else if (ret * BITS_PER_TYPE(u8) < num_lanes + 1) {
-		acpi_handle_info(handle, "Too few lane polarity bytes (%lu vs. %d)\n",
+		acpi_handle_info(handle, "Too few lane polarity bits (%zu vs. %d)\n",
 				 ret * BITS_PER_TYPE(u8), num_lanes + 1);
 	} else {
 		unsigned long mask = 0;
-- 
2.39.2

