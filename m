Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5027FDADC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjK2PMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjK2PL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:11:59 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3C7EBE;
        Wed, 29 Nov 2023 07:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=feMp/yQdhv1cPkfaZT
        swMPfvGgf29QwDsfVs7q/7umg=; b=meQcnt+xpXwd4m9WQE94rE3uXOU9rxyby3
        nCUuPH1Jmj8w+ncT1y6F9uYoaN806rnOYheXjvJnj1241XXTv79QDufXln9BrUDG
        /3jJ+Q0te7YPGdQVn7IH1DOGXjpffx6uMc5mxKGsH1c8T1qC8pgIm29BMNWFNN1V
        6zShKMRU0=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wC3njG5VGdlx_XzEA--.39554S2;
        Wed, 29 Nov 2023 23:11:55 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [scsi] sni_53c710: Add error handling in snirm710_probe
Date:   Wed, 29 Nov 2023 07:11:52 -0800
Message-Id: <20231129151152.34829-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wC3njG5VGdlx_XzEA--.39554S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kry7ur4fKF18JryDCrW3Wrg_yoW8Wr45p3
        9xGw45Ca97GF1xA343Xa18u3Z0yaySkrZrK3W7W3sI9a1rJFyYqr4SyFyagFW8GrWktF4U
        Xr1UtFWI93WDCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRa9akUUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZRo3gl8ZaQ-qYQAFsk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds checks for the return values of dma_set_mask and ioremap.
Previously, the function did not handle potential failures of these calls,
which could lead to improper device initialization and unpredictable
behavior.

Although the error addressed by this patch may not occur in the current
environment, I still suggest implementing these error handling routines
if the function is not highly time-sensitive. As the environment evolves
or the code gets reused in different contexts, there's a possibility that
these errors might occur. Addressing them now can prevent potential
debugging efforts in the future, which could be quite resource-intensive.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/scsi/sni_53c710.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sni_53c710.c b/drivers/scsi/sni_53c710.c
index 678651b9b4dd..41414d0c64f8 100644
--- a/drivers/scsi/sni_53c710.c
+++ b/drivers/scsi/sni_53c710.c
@@ -69,8 +69,19 @@ static int snirm710_probe(struct platform_device *dev)
 		return -ENOMEM;
 
 	hostdata->dev = &dev->dev;
-	dma_set_mask(&dev->dev, DMA_BIT_MASK(32));
+	rc = dma_set_mask(&dev->dev, DMA_BIT_MASK(32));
+	if (rc) {
+		printk(KERN_ERR "snirm710: dma_set_mask failed!\n");
+		goto out_kfree;
+	}
+
 	hostdata->base = ioremap(base, 0x100);
+	if (!hostdata->base) {
+		printk(KERN_ERR "snirm710: ioremap failed!\n");
+		rc = -ENOMEM;
+		goto out_kfree;
+	}
+
 	hostdata->differential = 0;
 
 	hostdata->clock = SNIRM710_CLOCK;
-- 
2.17.1

