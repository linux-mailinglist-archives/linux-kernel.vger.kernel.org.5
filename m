Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60667AC374
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 18:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjIWQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjIWQEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 12:04:39 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D840139
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=hrRrRt8WsW3sIAoTAf
        qtyDId6QcDAcmE+7CIhdxf4T8=; b=PKHal8FOw1c6LoA0bk2DG7cA6aIrbS+vM+
        qy2kGVfUnRc7Z3s9aWGeFFHgEfyBr3fEKWDDF2xrcW6JMZYamThhwwPMnRw8XsIW
        7jdesJaZm/00ALD1cxgVzO0bxBVa2iie7XNgQP3gtyCgwV0XYG2s5fM/tQaJdoCX
        A6MLJA+zI=
Received: from localhost.localdomain (unknown [223.104.131.178])
        by zwqz-smtp-mta-g2-3 (Coremail) with SMTP id _____wAXpmp1DA9lhkCkCw--.52707S2;
        Sun, 24 Sep 2023 00:04:07 +0800 (CST)
From:   liuhaoran <liuhaoran14@163.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liuhaoran <liuhaoran14@163.com>
Subject: [PATCH] arm: match-footbridge: Add error handling in dc21285_setup()
Date:   Sun, 24 Sep 2023 00:03:53 +0800
Message-Id: <20230923160353.42915-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wAXpmp1DA9lhkCkCw--.52707S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1UGrykAF13Jr17uryUZFb_yoW8XrWkpr
        1xCws0krsYgr1UCrsxJr1UZFWfZ3Z2yFW3CrWxt3sFv3WkJFWqgFs0y3s09w45tr1DAw1f
        tF1kAF40qF1DGaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UrPEgUUUUU=
X-Originating-IP: [223.104.131.178]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbibBjzgmNfuLQqtQAAsq
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error-handling for the allocate_resource()
inside the dc21285_setup().

Signed-off-by: liuhaoran <liuhaoran14@163.com>
---
 arch/arm/mach-footbridge/dc21285.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index f8920d0010de..1970c66eb964 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -261,6 +261,7 @@ static struct notifier_block dc21285_pci_bus_nb = {
 int __init dc21285_setup(int nr, struct pci_sys_data *sys)
 {
 	struct resource *res;
+	int error;
 
 	res = kcalloc(2, sizeof(struct resource), GFP_KERNEL);
 	if (!res) {
@@ -273,10 +274,21 @@ int __init dc21285_setup(int nr, struct pci_sys_data *sys)
 	res[1].flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 	res[1].name  = "Footbridge prefetch";
 
-	allocate_resource(&iomem_resource, &res[1], 0x20000000,
+	error = allocate_resource(&iomem_resource, &res[1], 0x20000000,
 			  0xa0000000, 0xffffffff, 0x20000000, NULL, NULL);
+	if (error < 0) {
+		printk(KERN_ERR "%s: allocate_resource failed %d!"
+		       , __func__, error);
+		return 0;
+	}
+
 	allocate_resource(&iomem_resource, &res[0], 0x40000000,
 			  0x80000000, 0xffffffff, 0x40000000, NULL, NULL);
+	if (error < 0) {
+		printk(KERN_ERR "%s: allocate_resource failed %d!"
+		       , __func__, error);
+		return 0;
+	}
 
 	sys->mem_offset  = DC21285_PCI_MEM;
 
-- 
2.17.1

