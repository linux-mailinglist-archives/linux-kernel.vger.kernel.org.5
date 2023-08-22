Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC927843EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjHVOXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjHVOXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:23:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F40CCA;
        Tue, 22 Aug 2023 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692714187; x=1724250187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3W+VSWBhicURFSXhHWrLL5SZA2vWllHOyZnE2Gl01JM=;
  b=nE9OHfio9BDHsd1Mw5/76433OGYtRoh4mLdfHW+zdj4ZuYgpTcoNx21E
   0v4+FGbermHHCB53/JbCsx4VCQepf8gB42u8ckJ7ixRlVFj4VqY1YfNkW
   IRTLPgZFmmIZ4xkr6Gs9S7tIkhzAORnd99qk73vY5EUd0jgNF7SR7+n5o
   so7nsvDDjT/W2XbDZlj9Fjzoqca99Q7z9LfrxiZOoar+l1tPaKVexUrnB
   qLYnVKlk21W7vl0rfJRUNivIWL7MFFCpUCGPb8pvUXub0esB9WraqINaM
   sdfb9DTwzViw5yqAzEErOwfhI2PkaS2UB/AT7zWxBo3RVAjX74Qx14AAH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="364061949"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="364061949"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 07:19:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="765749248"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="765749248"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2023 07:19:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 84B92379; Tue, 22 Aug 2023 17:19:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] watchdog: simatic: Use idiomatic selection of P2SB
Date:   Tue, 22 Aug 2023 17:18:59 +0300
Message-Id: <20230822141859.2139630-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it's pretty much theoretical to be otherwise, make sure
that P2SB is selected only for X86. This is idiomatic dependency
which is used by all others who select it. Use it for Simatic
as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index a75f6acb986b..751458959411 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1685,7 +1685,7 @@ config SIEMENS_SIMATIC_IPC_WDT
 	depends on SIEMENS_SIMATIC_IPC && PCI
 	default y
 	select WATCHDOG_CORE
-	select P2SB
+	select P2SB if X86
 	help
 	  This driver adds support for several watchdogs found in Industrial
 	  PCs from Siemens.
-- 
2.40.0.1.gaa8946217a0b

