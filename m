Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35EB80F919
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377568AbjLLVWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377485AbjLLVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:22:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE7AD;
        Tue, 12 Dec 2023 13:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702416165; x=1733952165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kSQPBcRC7qiyHc9BBLXSnCeVZp/WbDJvRtGqOuMn0T0=;
  b=HCbsEDvsUnwkyuAyqqiaO5i+RheqKLg63SqAJzvvWs5b/oWjzJ3uQJzr
   U7cRA21iGEGEbse/Yx2em7SPmII7nV48gfQFFcnVWnq9kZYjfWS0OrPZl
   0y+IJcHHQct3IgYfMOUcpQYbCGi/OxS3LCx3Ryxi5Ywge2kA1cgtMXDhI
   yKt+DitqgCntcyACJqQw8dliRpkjECKhdRo6yJ8+MmKecECopd2qDteV6
   630iVayMmv0Vx8lEw2DxVDskN/OkOux8r0wHp72lRkv2b2lkU3eawTJbq
   l6E6R00govdti4l+76Mbu+TLHrx/WeU8mhb46ateDHg0x5QLEmFuoN0yY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2040514"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2040514"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:22:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="17648342"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:22:45 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Erwin Tsaur <erwin.tsaur@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] ACPI: extlog: Clear Extended Error Log status when RAS_CEC handled the error
Date:   Tue, 12 Dec 2023 13:22:39 -0800
Message-ID: <20231212212239.8971-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both CONFIG_RAS_CEC and CONFIG_ACPI_EXTLOG are enabled, Linux does
not clear the status word of the BIOS supplied error record for corrected
errors. This may prevent logging of subsequent uncorrected errors.

Fix by clearing the status.

Fixes: 23ba710a0864 ("x86/mce: Fix all mce notifiers to update the mce->kflags bitmask")
Reported-by: Erwin Tsaur <erwin.tsaur@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/acpi_extlog.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e120a96e1eae..71e8d4e7a36c 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -145,9 +145,14 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	static u32 err_seq;
 
 	estatus = extlog_elog_entry_check(cpu, bank);
-	if (estatus == NULL || (mce->kflags & MCE_HANDLED_CEC))
+	if (!estatus)
 		return NOTIFY_DONE;
 
+	if (mce->kflags & MCE_HANDLED_CEC) {
+		estatus->block_status = 0;
+		return NOTIFY_DONE;
+	}
+
 	memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
 	/* clear record status to enable BIOS to update it again */
 	estatus->block_status = 0;
-- 
2.43.0

