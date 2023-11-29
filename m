Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB017FD901
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjK2OLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjK2OLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:11:07 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCEB91AD;
        Wed, 29 Nov 2023 06:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=2DM1TPPWwU3qPVxxhW
        pOITp7B/LQX04hd6p42UYn2qY=; b=h77KGws7GG1sK8KFpyfBOO4DepKQf45wnt
        p2KG+j3BA7oDoJp/0/ZzuuNZnjTL5cfdFRCJ6sIZWZT3L9m3IfbHRfyYRac29RWo
        5Kb+GOrX6kOpQLlOLBKpi1tV2IMXV4JPr9wqZ7r4XM1mGgdkkWQgOISieA5Mra9J
        P4nsljw18=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wC3XyZiRmdlNnxRBw--.40401S2;
        Wed, 29 Nov 2023 22:10:44 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     pedrom.sousa@synopsys.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [ufs] tc-dwc-g210: Add error handling in tc_dwc_g210_pltfm_probe
Date:   Wed, 29 Nov 2023 06:10:41 -0800
Message-Id: <20231129141041.34275-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wC3XyZiRmdlNnxRBw--.40401S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW5XF4xAr1DCw1fCr1fXrb_yoWDKrbE93
        97WryxGw4rJF1vqwna9ryfCrZ5GF4Ivr1DCrn2qFs5Ka4UuFy5JwsFvr4xAa4rW3y2yFyD
        Zws8Xr4ruw1xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRHyI73UUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwgU3glc6616szwAAsJ
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

This patch adds error handling for the of_match_node call in the
tc_dwc_g210_pltfm_probe function within
drivers/ufs/host/tc-dwc-g210-pltfrm.c. Previously, the function did
not properly handle a null return value from of_match_node, which could
lead to issues if the device tree matching failed.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/ufs/host/tc-dwc-g210-pltfrm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ufs/host/tc-dwc-g210-pltfrm.c b/drivers/ufs/host/tc-dwc-g210-pltfrm.c
index a3877592604d..991069bfe570 100644
--- a/drivers/ufs/host/tc-dwc-g210-pltfrm.c
+++ b/drivers/ufs/host/tc-dwc-g210-pltfrm.c
@@ -59,6 +59,11 @@ static int tc_dwc_g210_pltfm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 
 	of_id = of_match_node(tc_dwc_g210_pltfm_match, dev->of_node);
+	if (!of_id) {
+		dev_err(dev, "No matching device found\n");
+		return -ENODEV;
+	}
+
 	vops = (struct ufs_hba_variant_ops *)of_id->data;
 
 	/* Perform generic probe */
-- 
2.17.1

