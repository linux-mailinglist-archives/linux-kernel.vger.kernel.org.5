Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104047936F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjIFIMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjIFIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:12:22 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B3EBF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:12:18 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 65534)
        id C93E85875CAF0; Wed,  6 Sep 2023 10:12:16 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 7E56358730358;
        Wed,  6 Sep 2023 10:12:16 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     o-takashi@sakamocchi.jp
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: allow deactivating the IEEE1394 menuconfig section at once
Date:   Wed,  6 Sep 2023 10:12:16 +0200
Message-ID: <20230906081216.22849-1-jengelh@inai.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently, one needs to enter "FireWire (IEEE 1394) subsystem --->",
then deselect all options individually. Speed up that process by
making the "--->" line be togglable in its own right.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 drivers/firewire/Kconfig | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
index 0a6596b027db..be1a9e685782 100644
--- a/drivers/firewire/Kconfig
+++ b/drivers/firewire/Kconfig
@@ -1,8 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
-menu "IEEE 1394 (FireWire) support"
+menuconfig FIREWIRE_SUPPORT
+	bool "IEEE 1394 (FireWire) support"
+	default y
 	depends on PCI || COMPILE_TEST
 	# firewire-core does not depend on PCI but is
 	# not useful without PCI controller driver
+	help
+	  Support for FireWire.
+
+	  The answer to this question will not directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about FireWire.
+
+if FIREWIRE_SUPPORT
 
 config FIREWIRE
 	tristate "FireWire driver stack"
@@ -96,4 +106,4 @@ config FIREWIRE_NOSY
 
 	  If unsure, say N.
 
-endmenu
+endif # FIREWIRE_SUPPORT
-- 
2.42.0

