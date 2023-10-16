Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F77CA51D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjJPKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjJPKQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:16:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3806E8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:16:24 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GAGHs2099117;
        Mon, 16 Oct 2023 05:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697451377;
        bh=88rE/gvk3TLI1pA0SASlq4XLga9h1ZmVfZYQHMJX+90=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hS412G+E7j7iNqklPP1RXxtBSwNA0j2NRQK8Wi4Wj1Wl/J/Rc7MTG82wEwXMTkTVF
         lk+0qxro8gnN5nEctayAAvlD+sPAKX1LFIDSzJnl+Je9wj7xPAOcncQpYMfgiNZJRC
         SpAy1I9VNh+JaloxVQY+J29zF2PttU/eiv5pSphY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GAGHjR029751
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Oct 2023 05:16:17 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 05:16:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 05:16:17 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GAG90h033447;
        Mon, 16 Oct 2023 05:16:15 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>, <t-konduru@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <n-francis@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH v3 2/3] soc: ti: k3-socinfo: Avoid overriding ret
Date:   Mon, 16 Oct 2023 15:46:07 +0530
Message-ID: <20231016101608.993921-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016101608.993921-1-n-francis@ti.com>
References: <20231016101608.993921-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid overriding the return value and make sure the right error code is
reflected. Here, if the partno is none of the identified partnos present
in k3_soc_ids[], return -ENODEV.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Changes since v2:
	- new patch

 drivers/soc/ti/k3-socinfo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index d45f5cb955a6..7fc3548e084c 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -60,7 +60,7 @@ k3_chipinfo_partno_to_names(unsigned int partno,
 			return 0;
 		}
 
-	return -EINVAL;
+	return -ENODEV;
 }
 
 static int k3_chipinfo_probe(struct platform_device *pdev)
@@ -111,8 +111,7 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 
 	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
 	if (ret) {
-		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
-		ret = -ENODEV;
+		dev_err(dev, "Unknown SoC JTAGID[0x%08X]: %d\n", jtag_id, ret);
 		goto err_free_rev;
 	}
 
-- 
2.34.1

