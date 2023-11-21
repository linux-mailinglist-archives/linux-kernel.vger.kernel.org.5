Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0EA7F2AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjKUKjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjKUKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:39:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E7D18C;
        Tue, 21 Nov 2023 02:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563140; x=1732099140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=G01FEu7mgWj6wch0a4BuSRZSlujWtyeQmN3DyjCESFk=;
  b=N+6vK8AHJ7uIgo5uvrxayMWy6QFoS2h2XDKE14xu2aZfn7ineNfmr7bU
   jgInoLJrxFxKtRcjNKOzvQU10PhcGGRxgehr0OkWGFh1T0DrbMUzChUJj
   jlw/TyCJEx5a05p/q4cCj6lx1sAC8D07PQyWB1rrtrc0re7dOc9uE5VAr
   epIfQBoP2IYQkXqukZlpZZ1Xn+U36ai4DD0cie9ky46CfDwTpKsXm9uTD
   xjXXoOyDPu8xqDAkDPSPL5CxAmePszau+pC+swm5yGX5Fo6IOu7pC3dSa
   G6D1mfqEZKbFOROQZxtLbwHCuyRktVivbbcJLMF4SsNfi9ez/w4dQlkF6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371987007"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371987007"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:38:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14871957"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 02:38:56 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 5/6] efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
Date:   Tue, 21 Nov 2023 16:08:28 +0530
Message-Id: <20231121103829.10027-6-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231121103829.10027-1-raag.jadav@intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

