Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335367B547F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbjJBNw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbjJBNwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:52:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B4DAD;
        Mon,  2 Oct 2023 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254743; x=1727790743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7nlAn6hAP7k5T95XmMXzQAXl6G0OaiWRwQc+BLw1N8A=;
  b=dTw+/Y9Z9KpYjfurAQXQ10EY/GAvxNG23QNLXVWC1nK3V7nb2G64Xi1n
   ioIWpr00KZU3f/DVPIh/uQtN9+LxMQkexbFJ87F1R7MuUy8jyvX99tZg+
   wxmPvJ9yASNbpovDBc6dpvb8EsfjbVHPLKsfgs2qFxvx/vpAarM3zjkJi
   jyXo9lgW7Tl1JEK/q9/uYbuEWbwmfojCWWsjsDf0O1y9LpVtSipzObdGU
   pyNmRm4GZU1tddPUutxAOHhNDq4XhfLduXEoTaeN3t08Z+p2lvjml7AI1
   STYKHSNwfAY3qd6BTkNWwWLKrHhMsXWuDSXGz7SKpd94hULnLU/iJkEXg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="4220507"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="4220507"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="816290762"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="816290762"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Oct 2023 06:52:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3BF251A7; Mon,  2 Oct 2023 16:52:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: x86: s2idle: Switch to use acpi_evaluate_dsm_typed()
Date:   Mon,  2 Oct 2023 16:52:18 +0300
Message-Id: <20231002135218.2602969-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/x86/s2idle.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 08f7c6708206..7d64e655f1b8 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -417,11 +417,10 @@ static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *d
 	int ret = -EINVAL;
 
 	guid_parse(uuid, dsm_guid);
-	obj = acpi_evaluate_dsm(handle, dsm_guid, rev, 0, NULL);
 
 	/* Check if the _DSM is present and as expected. */
-	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length == 0 ||
-	    obj->buffer.length > sizeof(u32)) {
+	obj = acpi_evaluate_dsm_typed(handle, dsm_guid, rev, 0, NULL, ACPI_TYPE_BUFFER);
+	if (!obj || obj->buffer.length == 0 || obj->buffer.length > sizeof(u32)) {
 		acpi_handle_debug(handle,
 				"_DSM UUID %s rev %d function 0 evaluation failed\n", uuid, rev);
 		goto out;
-- 
2.40.0.1.gaa8946217a0b

