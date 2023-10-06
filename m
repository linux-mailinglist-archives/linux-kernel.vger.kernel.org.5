Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FF77BC17D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjJFVpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjJFVpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:45:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6781CF;
        Fri,  6 Oct 2023 14:45:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19956C433C9;
        Fri,  6 Oct 2023 21:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628719;
        bh=mmwxikbDkXiCI0QTt3gBEdIaksCQS4zhTseYPc+OSPM=;
        h=From:To:Cc:Subject:Date:From;
        b=dqoTQg6T9tcoMVTIiUZE1KNfN8NY9EEQhijANrjoQ8yyGqCP8qXch1Bf4yJAJTN3h
         7RjGl0sYvYEUs0ulbv/Ph/x/t2m7l5e2xFaxerv4upF9xKEgqs6LXcbq5r2A7QeZf4
         zWIXuJDdv5OQokRPurQroX3QqF5nIAipoDO1G2ij3BszhPzidRb9wudaMZfYijJoRs
         Qhhencfu+W5NE2gZh5XggSR001ftBdKqbxk5PrsSR+xNVmuzvgi6faCV5br2t5OyWL
         qFqzFs1UBxBIA9i44jAtIGPyZlbmflQ7fr5BwejsWrwxjJ6pwqEE14UDalfhJdqTZE
         kEi94/jQpDKBQ==
Received: (nullmailer pid 340533 invoked by uid 1000);
        Fri, 06 Oct 2023 21:45:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:45:10 -0500
Message-Id: <20231006214511.340457-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/kernel/pci_sabre.c  |  9 +++++----
 arch/sparc/kernel/pci_schizo.c | 13 +++++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/pci_sabre.c b/arch/sparc/kernel/pci_sabre.c
index 3c38ca40a22b..a84598568300 100644
--- a/arch/sparc/kernel/pci_sabre.c
+++ b/arch/sparc/kernel/pci_sabre.c
@@ -13,7 +13,10 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include <asm/apb.h>
 #include <asm/iommu.h>
@@ -456,7 +459,6 @@ static void sabre_pbm_init(struct pci_pbm_info *pbm,
 static const struct of_device_id sabre_match[];
 static int sabre_probe(struct platform_device *op)
 {
-	const struct of_device_id *match;
 	const struct linux_prom64_registers *pr_regs;
 	struct device_node *dp = op->dev.of_node;
 	struct pci_pbm_info *pbm;
@@ -466,8 +468,7 @@ static int sabre_probe(struct platform_device *op)
 	const u32 *vdma;
 	u64 clear_irq;
 
-	match = of_match_device(sabre_match, &op->dev);
-	hummingbird_p = match && (match->data != NULL);
+	hummingbird_p = (uintptr_t)device_get_match_data(&op->dev);
 	if (!hummingbird_p) {
 		struct device_node *cpu_dp;
 
diff --git a/arch/sparc/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
index 23b47f7fdb1d..5d8dd4949586 100644
--- a/arch/sparc/kernel/pci_schizo.c
+++ b/arch/sparc/kernel/pci_schizo.c
@@ -11,7 +11,10 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/numa.h>
 
 #include <asm/iommu.h>
@@ -1459,15 +1462,13 @@ static int __schizo_init(struct platform_device *op, unsigned long chip_type)
 	return err;
 }
 
-static const struct of_device_id schizo_match[];
 static int schizo_probe(struct platform_device *op)
 {
-	const struct of_device_id *match;
+	unsigned long chip_type = (unsigned long)device_get_match_data(&op->dev);
 
-	match = of_match_device(schizo_match, &op->dev);
-	if (!match)
+	if (!chip_type)
 		return -EINVAL;
-	return __schizo_init(op, (unsigned long)match->data);
+	return __schizo_init(op, chip_type);
 }
 
 /* The ordering of this table is very important.  Some Tomatillo
-- 
2.40.1

