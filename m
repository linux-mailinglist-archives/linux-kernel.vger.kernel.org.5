Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0BC81113C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377628AbjLMMnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjLMMnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:43:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF701F5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:43:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65C5C433CA;
        Wed, 13 Dec 2023 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702471395;
        bh=S5dSnA41y/QX1OV5ufybA5eBL4578WDAqBgybqwlsMY=;
        h=From:To:Cc:Subject:Date:From;
        b=AtqJIpxEVNKW8/4YwZ052AvcohHWiFlJwJj7skuxaQZeMTqux4ITVcKJZijEnWbT6
         /9C+uxjHsphZIiLt6MdoI1FKPJG2VS+8OmXfi+lnmBcHrqxfHFO3FTYfDgxbQGvD7W
         /HAsU0ysZInnThshhwkyB9JyRVbVyZNDYUln1+N/361VCoV+PdMlgZw/dYt/Qe3NP0
         dKYHlRgcW8D4x4oQ+BaJMuO6MjzjgB+V41lHrig55InkCXDbqu+r9SMMQ+ILDxfdRQ
         LYC/0mBhAYHpLandcdZd60VOS+ARalvZWZAcGIrO75MStxeQR5bkDTDBas+rYYSKMc
         wJgOyhJ5a92lg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wentong Wu <wentong.wu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mei: fix vsc dependency
Date:   Wed, 13 Dec 2023 13:43:05 +0100
Message-Id: <20231213124310.761638-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The Kconfig dependency in the new module is reversed from the dependency
on the exported symbols, so it fails to link with CONFIG_INTEL_MEI_VSC
disabled and CONFIG_INTEL_MEI_VSC_HW enabled:

ERROR: modpost: "vsc_tp_reset" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_init" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_xfer" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_need_read" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_intr_enable" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_intr_synchronize" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_intr_disable" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_register_event_cb" [drivers/misc/mei/mei-vsc.ko] undefined!

Make the dependency reflect the module dependency.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/mei/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 858bd701d68c..eb69987f8325 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -64,6 +64,7 @@ config INTEL_MEI_VSC_HW
 	tristate "Intel visual sensing controller device transport driver"
 	depends on ACPI && SPI
 	depends on GPIOLIB || COMPILE_TEST
+	depends on INTEL_MEI_VSC
 	help
 	  Intel SPI transport driver between host and Intel visual sensing
 	  controller (IVSC) device.
@@ -73,7 +74,6 @@ config INTEL_MEI_VSC_HW
 
 config INTEL_MEI_VSC
 	tristate "Intel visual sensing controller device with ME interface"
-	depends on INTEL_MEI_VSC_HW
 	depends on INTEL_MEI
 	help
 	  Intel MEI over SPI driver for Intel visual sensing controller
-- 
2.39.2

