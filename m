Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA1B7A165D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjIOGrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjIOGrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:47:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DDC2708
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:47:06 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38F6kugw055862;
        Fri, 15 Sep 2023 01:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694760416;
        bh=/RvhdqzvbWlRZowZI1olXzllsSEefhamT5zJVlhk5+E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lHUmNT+BzY9mTxRert7GHeNPRrJwDOJStH7RxpuC1O5S0qnOFwcHM4ECLosDgIAY0
         Ht663MjBrivfv8qGhyC9+1FBAkcMNG6xrnoPIBgqEoxESGr5oZxMDbse8GEvRyD+ac
         hnNftydkLkuv02sSGgYm+hHWWuchdv85Kfi8BSPQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38F6kuvv043861
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Sep 2023 01:46:56 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 01:46:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 01:46:55 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38F6kotb071619;
        Fri, 15 Sep 2023 01:46:53 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>, <t-konduru@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <n-francis@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH v2 1/2] soc: ti: k3-socinfo: Revamp driver to accommodate different rev structs
Date:   Fri, 15 Sep 2023 12:16:49 +0530
Message-ID: <20230915064650.2287638-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915064650.2287638-1-n-francis@ti.com>
References: <20230915064650.2287638-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

k3-socinfo.c driver assumes silicon revisions to be 1.0, 2.0 etc. for
every platform. However this typical style is not followed by J721E
(1.0, 1.1) and need not be followed by upcoming silicon revisions as
well. Adapt the driver to be similar to its U-Boot counterpart
(drivers/soc/soc_ti_k3.c) that accounts for this difference on the
basis of partno/family.

Note that we change the order of invocation of
k3_chipinfo_partno_to_names before k3_chipinfo_variant_to_sr so we
have the family name in case error is returned.

Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 71 +++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 6ea9b8c7d335..6de1e3531af9 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -33,19 +33,37 @@
 
 #define CTRLMMR_WKUP_JTAGID_MFG_TI		0x17
 
+#define JTAG_ID_PARTNO_AM65X		0xBB5A
+#define JTAG_ID_PARTNO_J721E		0xBB64
+#define JTAG_ID_PARTNO_J7200		0xBB6D
+#define JTAG_ID_PARTNO_AM64X		0xBB38
+#define JTAG_ID_PARTNO_J721S2		0xBB75
+#define JTAG_ID_PARTNO_AM62X		0xBB7E
+#define JTAG_ID_PARTNO_J784S4		0xBB80
+#define JTAG_ID_PARTNO_AM62AX		0xBB8D
+#define JTAG_ID_PARTNO_AM62PX		0xBB9D
+
 static const struct k3_soc_id {
 	unsigned int id;
 	const char *family_name;
 } k3_soc_ids[] = {
-	{ 0xBB5A, "AM65X" },
-	{ 0xBB64, "J721E" },
-	{ 0xBB6D, "J7200" },
-	{ 0xBB38, "AM64X" },
-	{ 0xBB75, "J721S2"},
-	{ 0xBB7E, "AM62X" },
-	{ 0xBB80, "J784S4" },
-	{ 0xBB8D, "AM62AX" },
-	{ 0xBB9D, "AM62PX" },
+	{ JTAG_ID_PARTNO_AM65X, "AM65X" },
+	{ JTAG_ID_PARTNO_J721E, "J721E" },
+	{ JTAG_ID_PARTNO_J7200, "J7200" },
+	{ JTAG_ID_PARTNO_AM64X, "AM64X" },
+	{ JTAG_ID_PARTNO_J721S2, "J721S2"},
+	{ JTAG_ID_PARTNO_AM62X, "AM62X" },
+	{ JTAG_ID_PARTNO_J784S4, "J784S4" },
+	{ JTAG_ID_PARTNO_AM62AX, "AM62AX" },
+	{ JTAG_ID_PARTNO_AM62PX, "AM62PX" },
+};
+
+static char *j721e_rev_string_map[] = {
+	"1.0", "1.1",
+};
+
+static char *k3_rev_string_map[] = {
+	"1.0", "2.0", "3.0",
 };
 
 static int
@@ -63,6 +81,29 @@ k3_chipinfo_partno_to_names(unsigned int partno,
 	return -EINVAL;
 }
 
+static int
+k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
+			  struct soc_device_attribute *soc_dev_attr)
+{
+	switch (partno) {
+	case JTAG_ID_PARTNO_J721E:
+		if (variant >= ARRAY_SIZE(j721e_rev_string_map))
+			goto bail;
+		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
+						   j721e_rev_string_map[variant]);
+		break;
+	default:
+		if (variant >= ARRAY_SIZE(k3_rev_string_map))
+			goto bail;
+		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
+						   k3_rev_string_map[variant]);
+	}
+	return 0;
+
+bail:
+	return -EINVAL;
+}
+
 static int k3_chipinfo_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -94,7 +135,6 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 
 	variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
 		  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
-	variant++;
 
 	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
 		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
@@ -103,15 +143,16 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
-	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
-	if (!soc_dev_attr->revision) {
-		ret = -ENOMEM;
+	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
+	if (ret) {
+		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
+		ret = -ENODEV;
 		goto err;
 	}
 
-	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
+	ret = k3_chipinfo_variant_to_sr(partno_id, variant, soc_dev_attr);
 	if (ret) {
-		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
+		dev_err(dev, "Unknown revision for %s\n", soc_dev_attr->family);
 		ret = -ENODEV;
 		goto err_free_rev;
 	}
-- 
2.34.1

