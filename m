Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB607CA51F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjJPKRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjJPKQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:16:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D33D49
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:16:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GAGJsZ119482;
        Mon, 16 Oct 2023 05:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697451379;
        bh=mUEmS5X5FgjjtcAPHgw5AMBeixQExKA6lT4KW9jhDGw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mHOQTwW0HDMKQPfWRDS7Zkq4jjdvExdDqf7w3cy8eLS+l6lixh+XZDV9SSG/0P2ya
         wjQbj5wRgBp5W+Q06C0wKWNr0D3rlAQHNsfGy6HqBgxgFmSJa+yVZ8Z8MqYKTAx2Zt
         vqKmIhwCuybhccTxg9n4qzj9X+kt6E05RV9NxbTE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GAGJig020318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Oct 2023 05:16:19 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 05:16:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 05:16:19 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GAG90i033447;
        Mon, 16 Oct 2023 05:16:17 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>, <t-konduru@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <n-francis@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH v3 3/3] soc: ti: k3-socinfo: Revamp driver to accommodate different rev structs
Date:   Mon, 16 Oct 2023 15:46:08 +0530
Message-ID: <20231016101608.993921-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016101608.993921-1-n-francis@ti.com>
References: <20231016101608.993921-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

k3-socinfo.c driver assumes silicon revisions for every platform are
incremental and one-to-one, corresponding to JTAG_ID's variant field:
1.0, 2.0 etc. This assumption is wrong for SoCs such as J721E, where the
variant field to revision mapping is 1.0, 1.1. Further, there are SoCs
such as AM65x where the sub-variant version requires custom decoding of
other registers.

Address this by using conditional handling per JTAG ID that requires an
exception with J721E as the first example. To facilitate this
conversion, use macros to identify the JTAG_ID part number and map them
to predefined string array.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Co-developed-by: Thejasvi Konduru <t-konduru@ti.com>
Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
---
Changes since v2:
	- update commit message
	- move from double Signed-off-by to Co-developed-by
	- make j721e_rev_string_map[] a const char
	- drop k3_rev_string_map[] and continue using old
	  "variant++" logic for the typical cases
	- appropriate error handling with no overrides distinguishing
	  between ENODEV and ENOMEM
 
 drivers/soc/ti/k3-socinfo.c | 71 ++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 7fc3548e084c..7517a9c8c8fa 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -33,19 +33,33 @@
 
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
+static const char * const j721e_rev_string_map[] = {
+	"1.0", "1.1",
 };
 
 static int
@@ -63,6 +77,32 @@ k3_chipinfo_partno_to_names(unsigned int partno,
 	return -ENODEV;
 }
 
+static int
+k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
+			  struct soc_device_attribute *soc_dev_attr)
+{
+	switch (partno) {
+	case JTAG_ID_PARTNO_J721E:
+		if (variant >= ARRAY_SIZE(j721e_rev_string_map))
+			goto err_unknown_variant;
+		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
+						   j721e_rev_string_map[variant]);
+		break;
+	default:
+		variant++;
+		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0",
+						   variant);
+	}
+
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
+
+	return 0;
+
+err_unknown_variant:
+	return -ENODEV;
+}
+
 static int k3_chipinfo_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -94,7 +134,6 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 
 	variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
 		  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
-	variant++;
 
 	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
 		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
@@ -103,16 +142,16 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
-	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
-	if (!soc_dev_attr->revision) {
-		ret = -ENOMEM;
+	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
+	if (ret) {
+		dev_err(dev, "Unknown SoC JTAGID[0x%08X]: %d\n", jtag_id, ret);
 		goto err;
 	}
 
-	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
+	ret = k3_chipinfo_variant_to_sr(partno_id, variant, soc_dev_attr);
 	if (ret) {
-		dev_err(dev, "Unknown SoC JTAGID[0x%08X]: %d\n", jtag_id, ret);
-		goto err_free_rev;
+		dev_err(dev, "Unknown SoC SR[0x%08X]: %d\n", jtag_id, ret);
+		goto err;
 	}
 
 	node = of_find_node_by_path("/");
-- 
2.34.1

