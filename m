Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688D67D69E1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjJYLSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjJYLSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:18:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C1A116;
        Wed, 25 Oct 2023 04:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698232715; x=1729768715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=556kuxWLablNck66gh7gdlu265PifGuIbT7//kLJcU0=;
  b=PQ2gxTkgRv1JEXE3SYXlvvu8hgwQQ/lXs5FBeYhOZW71zsD3ZgKVJlDH
   I62vzLjBuEJOzEXFkhIGEXpp2iO2ACSXtjPQ/d93AF9rkGLpzYLUlrTyz
   JXLoOABNATlnvgZsa3BejPjKy3ABqmMgh4pFA6RHwGZGiKpgeLhi6agOH
   steKGGNFfQeE8f7CGH96Na/x3MsnicSoKHdrgG74+zg+l8KTzhd86vZFc
   56TpkZjGRtZQXnbv0KLHMJJ0HgmB2qq2bntpjwsCoB9o0oKUOn0Ee4/pE
   WSrM7L/IxZxYq05DT7sLGeYTTCoel2P/q3l+XodLpY9vWYqBB8JD8LQ0E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="391154615"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391154615"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762425086"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="762425086"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:18:18 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/6] ACPI: acpi_video: Remove unnecessary checks
Date:   Wed, 25 Oct 2023 14:18:01 +0300
Message-ID: <20231025111806.2416524-2-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025111806.2416524-1-michal.wilczynski@intel.com>
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary checks for NULL for variables that can't be NULL at
the point they're checked for it.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_video.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0b7a01f38b65..c14b44f99e35 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1027,9 +1027,6 @@ static int acpi_video_bus_check(struct acpi_video_bus *video)
 	acpi_status status = -ENOENT;
 	struct pci_dev *dev;
 
-	if (!video)
-		return -EINVAL;
-
 	dev = acpi_get_pci_dev(video->device->handle);
 	if (!dev)
 		return -ENODEV;
@@ -2087,13 +2084,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 static void acpi_video_bus_remove(struct acpi_device *device)
 {
-	struct acpi_video_bus *video = NULL;
-
-
-	if (!device || !acpi_driver_data(device))
-		return;
-
-	video = acpi_driver_data(device);
+	struct acpi_video_bus *video = acpi_driver_data(device);
 
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
 				       acpi_video_bus_notify);
-- 
2.41.0

