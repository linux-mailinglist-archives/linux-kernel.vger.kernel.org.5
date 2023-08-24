Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15E8787B67
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbjHXWTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbjHXWTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:19:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E880B1BE9;
        Thu, 24 Aug 2023 15:19:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8763A670AB;
        Thu, 24 Aug 2023 22:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CB4C433C8;
        Thu, 24 Aug 2023 22:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692915557;
        bh=3es/qY8hAqckfsTKJx7JrHyF4L4on/xgO9F49tPRTNY=;
        h=From:To:Cc:Subject:Date:From;
        b=KVpLuP1luFzEsGBPK31KdBJKuxQ7nhBGj7YQBg6XBRDfr5NnOKYzEBqf4t2rDLdrX
         ilgfBK6eoMAq53/EqTLdg8RUTZ5aNZL8bskg5oFMMm16UQSiMMvy6pygfhjWbAy/0l
         yKxPDUmXHrC8i3U7W80g8OWt7r/U8xWtBlYdolppwmiCwKLlRgwXnTdu9J90bO+de8
         9D+evBYZ97mlGG4LNekSEVIzhtn916vecInFcFP/b5u/xvRkhHtcFVOSVzfgzjTlJS
         G3p4Jntcigjtx3XO12FV92vTv+vYyeR2qNwhGkQakWM+L0qjoW1DZ0RDivANY8VNma
         LsmKEQ/Swu2OQ==
Received: (nullmailer pid 1583553 invoked by uid 1000);
        Thu, 24 Aug 2023 22:19:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Lizhi Hou <lizhi.hou@amd.com>
Cc:     kernel test robot <lkp@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: unittest: Fix of_unittest_pci_node() kconfig dependencies
Date:   Thu, 24 Aug 2023 17:17:34 -0500
Message-Id: <20230824221743.1581707-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_unittest_pci_node test depends on both CONFIG_PCI_DYNAMIC_OF_NODES
and CONFIG_OF_OVERLAY. Move the test into the existing
CONFIG_OF_OVERLAY ifdef and rework the CONFIG_PCI_DYNAMIC_OF_NODES
dependency to use IS_ENABLED() instead. This reduces the combinations to
build.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308241954.oRNfVqmB-lkp@intel.com/
Fixes: 26409dd04589 ("of: unittest: Add pci_dt_testdrv pci driver")
Cc: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/unittest.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 9c0f352cb241..ad2b7879cc67 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3799,14 +3799,6 @@ static __init void of_unittest_overlay_high_level(void)
 	mutex_unlock(&of_mutex);
 }
 
-#else
-
-static inline __init void of_unittest_overlay_high_level(void) {}
-
-#endif
-
-#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
-
 static int of_unittest_pci_dev_num;
 static int of_unittest_pci_child_num;
 
@@ -3954,6 +3946,9 @@ static void __init of_unittest_pci_node(void)
 	struct pci_dev *pdev = NULL;
 	int rc;
 
+	if (!IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES))
+		return;
+
 	rc = pci_register_driver(&testdrv_driver);
 	unittest(!rc, "Failed to register pci test driver; rc = %d\n", rc);
 	if (rc)
@@ -3987,7 +3982,10 @@ static void __init of_unittest_pci_node(void)
 		pci_dev_put(pdev);
 }
 #else
-static void __init of_unittest_pci_node(void) { }
+
+static inline __init void of_unittest_overlay_high_level(void) {}
+static inline __init void of_unittest_pci_node(void) { }
+
 #endif
 
 static int __init of_unittest(void)
-- 
2.40.1

