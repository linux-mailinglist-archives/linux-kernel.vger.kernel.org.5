Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6122A80BC72
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjLJRuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjLJRuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:50:05 -0500
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1AEFD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:50:11 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id CNwNr4gNwWblTCNwNrbUKc; Sun, 10 Dec 2023 18:50:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702230610;
        bh=HzZTGQuA0kr0qzhf9S/gzmjguN57sJaWf26PktWi9U4=;
        h=From:To:Cc:Subject:Date;
        b=s2eZNshYTi2b1eXXjtC1TXyhFurVyBUyFnpASCghE6xZzdQkacTO0gSetG+bHAMwD
         GmbWPPMyGUzSOl98YCRa6qF3nOMDLpgz+TRyWu2SGI8v4UGoMbvAfxR76+62pXOPtM
         PUvKS7UcyX1kdIUeNMk33quvsuptSz5xrX/YDOyD7apbb6wFtbN8o5faCStcgpj7mX
         p+P9DxWPO+NGkbJRXHVmWc5DHX3QJrJcBRHzsxDTlPhhd03WlITdC6n4c/UJsxCJF/
         pRieHQaY2FJblcUFaY+2gjI3twk9LYvFJRcVs8tvVa6lNPfrQJt/IoulMAxIZkKnDY
         NG84iK8KS0gaQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 18:50:10 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: vmd: Remove usage of the deprecated ida_simple_xx() API
Date:   Sun, 10 Dec 2023 18:50:03 +0100
Message-Id: <270f25cdc154f3b0309e57b2f6421776752e2170.1702230593.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/vmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 94ba61fe1c44..00a4264711f1 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -984,7 +984,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	vmd->dev = dev;
-	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
+	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
 		return vmd->instance;
 
@@ -1026,7 +1026,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return 0;
 
  out_release_instance:
-	ida_simple_remove(&vmd_instance_ida, vmd->instance);
+	ida_free(&vmd_instance_ida, vmd->instance);
 	return err;
 }
 
@@ -1048,7 +1048,7 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
-	ida_simple_remove(&vmd_instance_ida, vmd->instance);
+	ida_free(&vmd_instance_ida, vmd->instance);
 }
 
 static void vmd_shutdown(struct pci_dev *dev)
-- 
2.34.1

