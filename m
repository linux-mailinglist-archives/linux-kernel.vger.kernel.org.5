Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E76799BE1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 00:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343986AbjIIWM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 18:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjIIWM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 18:12:58 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C7D9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 15:12:53 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 385995873035B; Sun, 10 Sep 2023 00:12:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id C940F5872FF4F;
        Sun, 10 Sep 2023 00:12:48 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     o-takashi@sakamocchi.jp
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: dissolve one menu indirection
Date:   Sun, 10 Sep 2023 00:11:35 +0200
Message-ID: <20230909221248.2598-1-jengelh@inai.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909033457.GA59845@workstation.local>
References: <20230909033457.GA59845@workstation.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assume you are in the "Device Drivers" menu in menuconfig, and the
cursor is on "IEEE 1394 (FireWire) support". To deactivate everything
FireWire-related, the following keystrokes are needed:

ENTER N DOWN N RIGHT ENTER

The plan of v6.5-1-gfd416616d099 was to reduce this to just

N

by making "IEEE 1394" a menuconfig item. That did not resonate, so
try a middle way which reduces it to

N DOWN N

without introducing a new config option, by dissolving one level of
menus.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
This patch applies on top of fd416616d0995f4947dd0a7a8c2ac4d9f916a9d0.

 drivers/firewire/Kconfig | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
index be1a9e685782..6b27944059bc 100644
--- a/drivers/firewire/Kconfig
+++ b/drivers/firewire/Kconfig
@@ -1,22 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
-menuconfig FIREWIRE_SUPPORT
-	bool "IEEE 1394 (FireWire) support"
-	default y
+menuconfig FIREWIRE
+	tristate "FireWire driver stack"
+	select CRC_ITU_T
 	depends on PCI || COMPILE_TEST
 	# firewire-core does not depend on PCI but is
 	# not useful without PCI controller driver
-	help
-	  Support for FireWire.
-
-	  The answer to this question will not directly affect the
-	  kernel: saying N will just cause the configurator to skip all
-	  the questions about FireWire.
-
-if FIREWIRE_SUPPORT
-
-config FIREWIRE
-	tristate "FireWire driver stack"
-	select CRC_ITU_T
 	help
 	  This is the new-generation IEEE 1394 (FireWire) driver stack
 	  a.k.a. Juju, a new implementation designed for robustness and
@@ -28,9 +16,11 @@ config FIREWIRE
 	  To compile this driver as a module, say M here: the module will be
 	  called firewire-core.
 
+if FIREWIRE
+
 config FIREWIRE_KUNIT_UAPI_TEST
 	tristate "KUnit tests for layout of structure in UAPI" if !KUNIT_ALL_TESTS
-	depends on FIREWIRE && KUNIT
+	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
 	  This builds the KUnit tests whether structures exposed to user
@@ -46,7 +36,7 @@ config FIREWIRE_KUNIT_UAPI_TEST
 
 config FIREWIRE_OHCI
 	tristate "OHCI-1394 controllers"
-	depends on PCI && FIREWIRE && MMU
+	depends on PCI && MMU
 	help
 	  Enable this driver if you have a FireWire controller based
 	  on the OHCI specification.  For all practical purposes, this
@@ -57,7 +47,7 @@ config FIREWIRE_OHCI
 
 config FIREWIRE_SBP2
 	tristate "Storage devices (SBP-2 protocol)"
-	depends on FIREWIRE && SCSI
+	depends on SCSI
 	help
 	  This option enables you to use SBP-2 devices connected to a
 	  FireWire bus.  SBP-2 devices include storage devices like
@@ -72,7 +62,7 @@ config FIREWIRE_SBP2
 
 config FIREWIRE_NET
 	tristate "IP networking over 1394"
-	depends on FIREWIRE && INET
+	depends on INET
 	help
 	  This enables IPv4/IPv6 over IEEE 1394, providing IP connectivity
 	  with other implementations of RFC 2734/3146 as found on several
@@ -81,6 +71,8 @@ config FIREWIRE_NET
 	  To compile this driver as a module, say M here:  The module will be
 	  called firewire-net.
 
+endif # FIREWIRE
+
 config FIREWIRE_NOSY
 	tristate "Nosy - a FireWire traffic sniffer for PCILynx cards"
 	depends on PCI
@@ -105,5 +97,3 @@ config FIREWIRE_NOSY
 	  nosy-dump, can be found in tools/firewire/ of the kernel sources.
 
 	  If unsure, say N.
-
-endif # FIREWIRE_SUPPORT
-- 
2.42.0

