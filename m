Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A227FDB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343530AbjK2P0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjK2P01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:26:27 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5EC026A4;
        Wed, 29 Nov 2023 07:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=UPZvZWVao0sExJphY6
        iK/2uDTmwrQQRv+cgzaIF0dp0=; b=KSMNxT4GPPRCEOpgve90N0x7jjZoVu2qry
        2BhIkk3wUy3OKVvpgFMX9h68DRlGIbjTMsKndt0x5I8Mwys54dLhi9C7EVzYQRXr
        k2TVDarBI+IxfdN0xD9eb+EiIYPgYB2g0WeF/zn32lna0q7+m2Mnspc0QU1ETvIr
        Hoyhc3kc0=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3v+H7V2dlgmDOBQ--.15191S2;
        Wed, 29 Nov 2023 23:25:48 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     James.Bottomley@HansenPartnership.com
Cc:     deller@gmx.de, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [parisc] superio: Add error handling for request_region in superio_init
Date:   Wed, 29 Nov 2023 07:25:46 -0800
Message-Id: <20231129152546.34962-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3v+H7V2dlgmDOBQ--.15191S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1xWr47GFy3tr15GFWUtwb_yoW8Zry5pa
        y3Cws5ArW8Zw1xZ34kXa93XFnY9anayFyUG3ZrK34fZF4rGrWjyr4rt3WYvFy5u3y7Jw13
        ZFn8GryfCF1jva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ptg4zPUUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwhw3glc661-fYAAAsN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces error handling for the request_region call in the
superio_init function within drivers/parisc/superio.c. Prior to this patch,
the function did not handle the scenario where request_region might fail,
potentially leading to resource conflicts.

Although the error addressed by this patch may not occur in the current
environment, I still suggest implementing these error handling routines
if the function is not highly time-sensitive. As the environment evolves
or the code gets reused in different contexts, there's a possibility that
these errors might occur. Addressing them now can prevent potential
debugging efforts in the future, which could be quite resource-intensive.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/parisc/superio.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/parisc/superio.c b/drivers/parisc/superio.c
index e973c6893203..36c01e70671d 100644
--- a/drivers/parisc/superio.c
+++ b/drivers/parisc/superio.c
@@ -187,9 +187,23 @@ superio_init(struct pci_dev *pcidev)
 	sio->acpi_base &= ~1;
 	printk(KERN_INFO PFX "ACPI at 0x%x\n", sio->acpi_base);
 
-	request_region (IC_PIC1, 0x1f, "pic1");
-	request_region (IC_PIC2, 0x1f, "pic2");
-	request_region (sio->acpi_base, 0x1f, "acpi");
+	if (!request_region(IC_PIC1, 0x1f, "pic1")) {
+		printk(KERN_ERR PFX "request_region failed for pic1\n");
+		return;
+	}
+
+	if (!request_region(IC_PIC2, 0x1f, "pic2")) {
+		printk(KERN_ERR PFX "request_region failed for pic2\n");
+		release_region(IC_PIC1, 0x1f);
+		return;
+	}
+
+	if (!request_region(sio->acpi_base, 0x1f, "acpi")) {
+		printk(KERN_ERR PFX "request_region failed for acpi\n");
+		release_region(IC_PIC1, 0x1f);
+		release_region(IC_PIC2, 0x1f);
+		return;
+	}
 
 	/* Enable the legacy I/O function */
 	pci_read_config_word (pdev, PCI_COMMAND, &word);
-- 
2.17.1

