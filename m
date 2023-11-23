Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795DF7F5BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbjKWKH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjKWKHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:07:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9969010E0;
        Thu, 23 Nov 2023 02:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700734048; x=1732270048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ibYMWWRd/P2AQAHicSo9ziPs651CklYQuIen4L+deis=;
  b=TaQG2LewxNxeUWqKuhpYuwb3nBje1pKnwXSRrxiXt4JtjzvoEjvHkmTb
   sIp8GVsY/jwKyW0gzIplwMOSEvwKqa0gRQIFTyWBWtzJPwodg7GNPmmSi
   gSKDOPsLUOinHAj830KcdSW3960ljlHw6noYPybpoUS9h/eqyNRoKJzVR
   pddlpu6tmhYYmlAnGcXZI+FkE4FqEp3f7kPfF8BVMheksBUe/gHzOCcbA
   e1Yb3YpUDJn2g9LAl9eSGpfWFiMZesMoNTqog4NdD0B2utdAKkpDfKrS0
   8i+fnI02nqJlZxHf5+rmzSxWqLnLporMO1OAwd/TfcVtLUcZyHWRmJXOI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456576426"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="456576426"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:07:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767160521"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="767160521"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 02:07:21 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 4/5] efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
Date:   Thu, 23 Nov 2023 15:36:16 +0530
Message-Id: <20231123100617.28020-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231123100617.28020-1-raag.jadav@intel.com>
References: <20231123100617.28020-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have _UID matching support for integer types, we can use
acpi_dev_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/dev-path-parser.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index f80d87c199c3..937be269fee8 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -18,8 +18,6 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
 	struct acpi_device *adev;
 	struct device *phys_dev;
 	char hid[ACPI_ID_LEN];
-	u64 uid;
-	int ret;
 
 	if (node->header.length != 12)
 		return -EINVAL;
@@ -31,10 +29,9 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
 			node->acpi.hid >> 16);
 
 	for_each_acpi_dev_match(adev, hid, NULL, -1) {
-		ret = acpi_dev_uid_to_integer(adev, &uid);
-		if (ret == 0 && node->acpi.uid == uid)
+		if (acpi_dev_uid_match(adev, node->acpi.uid))
 			break;
-		if (ret == -ENODATA && node->acpi.uid == 0)
+		if (!acpi_device_uid(adev) && node->acpi.uid == 0)
 			break;
 	}
 	if (!adev)
-- 
2.17.1

