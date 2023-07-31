Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D476973C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjGaNME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGaNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:12:02 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94BE75;
        Mon, 31 Jul 2023 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690809122; x=1722345122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ShlJENAU4FB1rgfuVa9539xX8KokiA6QIrBsFYJvVps=;
  b=IPMs9JwSAtMhAVGDdYCo3GUFvEpsJ4FSo5jAcxjpW5g/DwFHWoEzk4Eq
   CK3z+OuNwUT6zUCpoTna4qQdSODBDHnDGtMtLuFvEfu12JxGwkdRqJa31
   i+K3EqTRZtChgBjBhcDDgB5kugNGS0sF3p9Vrp79zx27wv7esN58xk5gY
   hzCxHM7XQdvFRybM/5Ybm7/3uGeRDJpubOnhrUAOKSaI0QNCTPtnGsE79
   /SuJm66nsJfepATos2wkMxejiG9wYeM0bDYY7U5pyDLtqOXGLtU8Apran
   s6w3Xy8yKJsjlfZvb9571vKWgOE0PnxwG4hXHUM1/edcGh9TtLILQItlu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366496510"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="366496510"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 06:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871671360"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2023 06:12:02 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH] usb: typec: mux: intel: Add dependency on USB_COMMON
Date:   Mon, 31 Jul 2023 16:12:10 +0300
Message-Id: <20230731131210.43158-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an undefined reference to `usb_debug_root' issue
when USB_COMMON is not enabled.

Fixes: 0a453dc9f260 ("usb: typec: intel_pmc_mux: Expose IOM port status to debugfs")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/lkml/c3bb8781-676d-2448-cfbb-62e29f1f570b@infradead.org/
Cc: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 784b9d8107e9b..65da61150ba78 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -29,6 +29,7 @@ config TYPEC_MUX_INTEL_PMC
 	tristate "Intel PMC mux control"
 	depends on ACPI
 	depends on INTEL_SCU_IPC
+	select USB_COMMON
 	select USB_ROLE_SWITCH
 	help
 	  Driver for USB muxes controlled by Intel PMC FW. Intel PMC FW can
-- 
2.40.1

