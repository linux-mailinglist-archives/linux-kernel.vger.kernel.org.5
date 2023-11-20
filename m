Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4487F12D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjKTMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjKTMJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:09:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0B9CF;
        Mon, 20 Nov 2023 04:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700482158; x=1732018158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=G01FEu7mgWj6wch0a4BuSRZSlujWtyeQmN3DyjCESFk=;
  b=i74tk9rWI7un0hPI06+gjrAwxTDmVOZfYtqG4kFiIwl5wJLWJJeoNR2z
   kJXJioL1Dgcu6ZMotG2WxGlVTWqm76rPbL8qK1G3HrrGJYmUg/EEVZbAa
   +/zYDLhUbZ9cXngfvgTRxpQt5vkiRAqSFgmsW0NLj7VSfwn/88CFNPvIO
   wGYqvz4ExqOL5IFYRGzXetjaZ3QICeWwQRmDXYLd8BrEYXU5fe8O+k+p/
   Q1WBV0nI1AY49i0Z0k2RFpiBA3v2CNg4YpGfKKvc0jHZlSdgp97z4ji6X
   A9wotPZKfhbH8n18mXs5pSNXQFXFrDCW1d6os7xGWGiJNv7M+RwKHwb90
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394455773"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394455773"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:09:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769878675"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769878675"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2023 04:09:08 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 5/6] efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
Date:   Mon, 20 Nov 2023 17:38:36 +0530
Message-Id: <20231120120837.3002-6-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120120837.3002-1-raag.jadav@intel.com>
References: <20231120120837.3002-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have _UID matching support for integer types, we can use
acpi_dev_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
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

