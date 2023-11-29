Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED937FDA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjK2OxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjK2OxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:53:15 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA6D6DD;
        Wed, 29 Nov 2023 06:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=/S2A/EeNHbYjLnA0IJ
        VqikibUA8CJdMhN9CjXBD7ITw=; b=kuj9Ho/DifavLASqZBVo0EQMGnWGpdX57G
        Odr/0Fsl2iXVz7D4QHgIQYHwiGa/9H7wTyj3iVpOSKlt3bRXYqwa8VcORu2rBokH
        gpU3pdT+yhFBsE/9p2jqA7JFXlR8ojb7qkMTQWSTrzVy7Oc2lMUPXTZjFnQOiwTZ
        JmjHD8Ks8=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wD333ERUGdls+wAAA--.230S2;
        Wed, 29 Nov 2023 22:52:03 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [scsi] lasi700: Add error handling in lasi700_probe
Date:   Wed, 29 Nov 2023 06:52:00 -0800
Message-Id: <20231129145200.34596-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD333ERUGdls+wAAA--.230S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4UJr4DCry7ur4kXr4kXrb_yoW8Zr1Dpa
        ykGws8Crs8Jr1xCw13Ja1UAF1Yq3yftry7Ka43Z3sIv3W3JFyktr4vyFyruFyrKrWvk3WU
        XF1jqrW293WDCFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pZjqiDUUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZRo3gl8ZaQ-qYQADsi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces improved error handling for the dma_set_mask and
ioremap calls in the lasi700_probe function within drivers/scsi/lasi700.c.
Previously, the function did not properly handle the potential failure of
these calls, which could lead to improper device initialization and
unpredictable behavior.

Although the error addressed by this patch may not occur in the current
environment, I still suggest implementing these error handling routines
if the function is not highly time-sensitive. As the environment evolves
or the code gets reused in different contexts, there's a possibility that
these errors might occur. Addressing them now can prevent potential
debugging efforts in the future, which could be quite resource-intensive.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/scsi/lasi700.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lasi700.c b/drivers/scsi/lasi700.c
index 86fe19e0468d..8d482bee940d 100644
--- a/drivers/scsi/lasi700.c
+++ b/drivers/scsi/lasi700.c
@@ -87,6 +87,7 @@ lasi700_probe(struct parisc_device *dev)
 	unsigned long base = dev->hpa.start + LASI_SCSI_CORE_OFFSET;
 	struct NCR_700_Host_Parameters *hostdata;
 	struct Scsi_Host *host;
+	int err;
 
 	hostdata = kzalloc(sizeof(*hostdata), GFP_KERNEL);
 	if (!hostdata) {
@@ -95,8 +96,20 @@ lasi700_probe(struct parisc_device *dev)
 	}
 
 	hostdata->dev = &dev->dev;
-	dma_set_mask(&dev->dev, DMA_BIT_MASK(32));
+	err = dma_set_mask(&dev->dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err(&dev->dev, "Failed to set DMA mask: %d\n", err);
+		kfree(hostdata);
+		return err;
+	}
+
 	hostdata->base = ioremap(base, 0x100);
+	if (!hostdata->base) {
+		dev_err(&dev->dev, "ioremap failed\n");
+		kfree(hostdata);
+		return -ENOMEM;
+	}
+
 	hostdata->differential = 0;
 
 	if (dev->id.sversion == LASI_700_SVERSION) {
-- 
2.17.1

