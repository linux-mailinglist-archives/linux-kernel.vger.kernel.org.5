Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F0813A22
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573059AbjLNSjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjLNSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:39:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52891111
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:39:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10639C433C7;
        Thu, 14 Dec 2023 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702579190;
        bh=XAEh20qvBS23cKK2nPKEFW+2DroDAYtyZm3Y94vZ9+A=;
        h=From:To:Cc:Subject:Date:From;
        b=hHi2piBsqatjGYdPPgiGCbp9w7BBK/xwFrUQBb+rtgAaG/vETqeooAc1UZ7ee7QYJ
         W0rhDWFTPwqi3ub3MIb8B78W82lCga7J7j1wn0VWqT0I0BA7AL2/ibudanRXXUPmSv
         P1OJPlUgDyMnZRCQ8k39mWRI2SPPLDvyI+3P5zkcoDBWcALRe+XQtCwnQ1XRNAkIQ1
         H+tVZjntfe7p2l8TsPXKyhPIzn7RkbKLo8k2CK5fA0xjeLgLnC43LLt1mnothqO40R
         TEXEgfYaveQEXLYOBE9ZsESdOUbuOduV/lgyO2fHD+Bg43wWlThiytcGng/fF5phUH
         219PfYxpUVRqw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wentong Wu <wentong.wu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [v2] mei: fix vsc dependency
Date:   Thu, 14 Dec 2023 18:39:31 +0000
Message-Id: <20231214183946.109124-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_INTEL_MEI_VSC_HW can be set to built-in even with CONFIG_MEI=m,
but then the driver is not built because Kbuild never enters the
drivers/misc/mei directory for built-in files, leading to a link
failure:

ERROR: modpost: "vsc_tp_reset" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_init" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_xfer" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_need_read" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_intr_enable" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_intr_synchronize" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_intr_disable" [drivers/misc/mei/mei-vsc.ko] undefined!
ERROR: modpost: "vsc_tp_register_event_cb" [drivers/misc/mei/mei-vsc.ko] undefined!

Add an explicit dependency on CONFIG_MEI that was apparently missing,
to ensure the VSC_HW driver cannot be built-in with MEI itself being
a loadable module.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/mei/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 858bd701d68c..1e28ca23a74a 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -62,6 +62,7 @@ config INTEL_MEI_GSC
 
 config INTEL_MEI_VSC_HW
 	tristate "Intel visual sensing controller device transport driver"
+	depends on INTEL_MEI
 	depends on ACPI && SPI
 	depends on GPIOLIB || COMPILE_TEST
 	help
-- 
2.39.2

