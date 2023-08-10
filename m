Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D3777787
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjHJLvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjHJLvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:51:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01646E4D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:51:14 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM4t562TkzcdDd;
        Thu, 10 Aug 2023 19:47:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 19:51:11 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <u.kleine-koenig@pengutronix.de>,
        <wsa+renesas@sang-engineering.com>, <luca.ceresoli@bootlin.com>,
        <jdelvare@suse.de>
CC:     <yuancan@huawei.com>, <lizetao1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] misc: eeprom/idt_89hpesx: Use devm_kmemdup to replace devm_kmalloc + memcpy
Date:   Thu, 10 Aug 2023 19:50:49 +0800
Message-ID: <20230810115049.2104099-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper function devm_kmemdup() rather than duplicating its
implementation, which helps to enhance code readability.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/misc/eeprom/idt_89hpesx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 740c06382b83..043762c3b033 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -1294,14 +1294,15 @@ static int idt_create_sysfs_files(struct idt_89hpesx_dev *pdev)
 		return 0;
 	}
 
-	/* Allocate memory for attribute file */
-	pdev->ee_file = devm_kmalloc(dev, sizeof(*pdev->ee_file), GFP_KERNEL);
+	/*
+	 * Allocate memory for attribute file and copy the declared EEPROM attr
+	 * structure to change some of fields
+	 */
+	pdev->ee_file = devm_kmemdup(dev, &bin_attr_eeprom,
+				     sizeof(*pdev->ee_file), GFP_KERNEL);
 	if (!pdev->ee_file)
 		return -ENOMEM;
 
-	/* Copy the declared EEPROM attr structure to change some of fields */
-	memcpy(pdev->ee_file, &bin_attr_eeprom, sizeof(*pdev->ee_file));
-
 	/* In case of read-only EEPROM get rid of write ability */
 	if (pdev->eero) {
 		pdev->ee_file->attr.mode &= ~0200;
-- 
2.34.1

