Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6678926C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjHYXfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjHYXfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:35:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F792D46;
        Fri, 25 Aug 2023 16:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8aTalKUPUPu0PIbThhovb8iKjRn3Jt2IKJXKqDBqkJIPeDrdDPgaPs74Ly8GeOC2hl9g4OQQgnr3djhWbKgbOdGUYXmo68UQYVKraW0f2a8epufjySpPNhzqdMeBNQPv9tOgjOA005k+tsRSWTgET7DduTq6LIawZ3kebt+2/x4b/JVfEUEUG8OzmRwGFbDfN1JdAf4NeDdZTWwutiVylnlPCvwiOK8+0fVzPHqmbWbGWGzUd6AeyqjSR9fXy9Ix5mnoGXPk+LEPPNv+hup75y2Pj247LyFi34Al2fBZE+998q60bhAY+6xrfPuT/kHwY2nOzVYFwJ8/hxpBXuKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3IZX7Q9P/TJEBatpsJlr78YlkkbpyRmEaO1Jf98tNs=;
 b=fa81ADP5BPp8/Y4TBN+pW0qhikyk0oylYrdwUuJx6UPG5HSk8Y57FvNhpDwGQRUtqz4XKtd6Q93CAW2ifOxLZQUZ83jLWz0eRpOOBlARA6sSa9EirVHmroL857QrSwqL/TzvXOid/P/hV3HQrFwwr1me/813VwxGLr/3qU8ziIRy/4tSZ9dpxzWkfPAB6qmXQvFVU/mWcsjZeLSPP/ONWPCDW+/5g6x6ZFLeY96iWr04HHywSVK8S84D1iuDoZRynrh65AjLVXp+6BcRZu18CTRhexBowr5BbaF9n4Okyhler8qOqlvrrnUl+/M0hRHqIaF8okwY8TcljFFnO4hwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3IZX7Q9P/TJEBatpsJlr78YlkkbpyRmEaO1Jf98tNs=;
 b=B1vraNaWMGDY5QXLRsOKHvJn4X8FZ3aq7DdikZtFPlKf2zzZEIBtWtBMr51xkS2acYZNRxDMp71TXeeGAx1ZPrShjfi8F6npcLi579EXcVNje/UC6rIqmiz6y7AL9dhGrjRGkUiuKfWyEcBPRBtpMGdLzUmjVwU6pqKUegQAO7Y=
Received: from SA9PR10CA0003.namprd10.prod.outlook.com (2603:10b6:806:a7::8)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 23:34:24 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::a9) by SA9PR10CA0003.outlook.office365.com
 (2603:10b6:806:a7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 23:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 23:34:22 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:34:22 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v9 10/15] cxl/pci: Map RCH downstream AER registers for logging protocol errors
Date:   Fri, 25 Aug 2023 18:32:06 -0500
Message-ID: <20230825233211.3029825-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825233211.3029825-1-terry.bowman@amd.com>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 70397a8b-ed66-45c9-026f-08dba5c3cff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgpTv/AFKv9kleE2Vby7WNoSZd0h6v9DrCTr1JzPMvmDV80R5CGOzim9tfMxyfcra8Ug0uFH+4WwauAA5Li9WnJs1zS/B7VHaubaz38SHAQxIthsVYOL6j5c+cnFX3lchZFQRkC9CN8UubMtDnrMZRW3PdQNIUxVkmSVu6FDyBvOJNsFgVUn+Rl3ltCR+ybVsTDwdUMP2NYlUXEuAmyCJx4PQ0gWTIHJdZ7Wv7DhwcRln6UrnHVakJYWlHdSVP4N6r8nhS9aGEgk9RUWe3LI9KZgWjyqNU/0X4HJW9PeS0cVk5EP46+o8PN83nZnMdw/JaZuFRLmSI4VbmTxTApg1z/X82VNZexgGNnTSVomwMZ9CXOCBa1JIpILjj+KkFRL7G5aBkX38cF/an4CkyzPvwlRBIowuZfyXOEGeJ05R1a2YGK98zBhwDb6sjgKWamaOjPYBnxMnmnKiAkM/yLADie5g1YBO58LjI4FAs9oUGDKto5jbhfft9DkqJNAhi6RBBmiEgX17lbwnLeAK3rvkPUJHpcTp9jDOTHKQrbLAIfko5wbLQWtTLYWDBFtNDSXCwq+45XFuiJTFPDj5I9nU1rmKxErIY/mu/lh9wdRLX4KSf30Nl8KzPT9T2fnTTjwkOKiRsYuMuWJT49NnK+c2jhIQ4of4RxQLNF4G9Irn+2pd9FQSyXPd0z0A3czjY+lJ0x/YU/3ZJ+yaDDCcvHOW2QJInOQeJAOUBCQvZiuMxKTHE4w5Azju3e8beCu74aIFjyTNjKg2M34kxyQIFTT+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(2616005)(5660300002)(8676002)(4326008)(8936002)(47076005)(426003)(36756003)(336012)(63350400001)(83380400001)(7416002)(63370400001)(44832011)(36860700001)(26005)(40480700001)(16526019)(82740400003)(6666004)(356005)(81166007)(70206006)(70586007)(54906003)(7696005)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:34:22.8513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70397a8b-ed66-45c9-026f-08dba5c3cff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The restricted CXL host (RCH) error handler will log protocol errors
using AER and RAS status registers. The AER and RAS registers need
to be virtually memory mapped before enabling interrupts. Update
__devm_cxl_add_dport() to include RCH RAS and AER mapping.

Add 'struct cxl_regs' to 'struct cxl_dport' for saving a pointer to
the RCH downstream port's AER and RAS registers.

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 +
 drivers/cxl/cxl.h       | 12 ++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f3bb7ea37b44..5fae1c06de22 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/aer.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
@@ -948,6 +949,37 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
+static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
+{
+	struct cxl_rcrb_info *ri = &dport->rcrb;
+	struct cxl_port *port = dport->port;
+	void __iomem *dport_aer = NULL;
+	resource_size_t aer_phys;
+
+	if (dport->rch && ri->aer_cap) {
+		aer_phys = ri->aer_cap + ri->base;
+		dport_aer = devm_cxl_iomap_block(&port->dev, aer_phys,
+				sizeof(struct aer_capability_regs));
+	}
+
+	dport->regs.dport_aer = dport_aer;
+}
+
+static void cxl_dport_map_regs(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->comp_map;
+	struct device *dev = dport->dport_dev;
+
+	if (!map->component_map.ras.valid)
+		dev_dbg(dev, "RAS registers not found\n");
+	else if (cxl_map_component_regs(map, dev, &dport->regs.component,
+					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(dev, "Failed to map RAS capability.\n");
+
+	if (dport->rch)
+		cxl_dport_map_rch_aer(dport);
+}
+
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		     int port_id, resource_size_t component_reg_phys,
@@ -1007,6 +1039,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	cxl_dport_map_regs(dport);
+
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index c8562cdbd17b..5cb78b76c757 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct device *dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b4383697180f..251cda10c283 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -221,6 +221,14 @@ struct cxl_regs {
 	struct_group_tagged(cxl_pmu_regs, pmu_regs,
 		void __iomem *pmu;
 	);
+
+	/*
+	 * RCH downstream port specific RAS register
+	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rch_regs, rch_regs,
+		void __iomem *dport_aer;
+	);
 };
 
 struct cxl_reg_map {
@@ -273,6 +281,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct device *dev,
 			   struct cxl_component_regs *regs,
@@ -625,6 +635,7 @@ struct cxl_rcrb_info {
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
+ * @regs: Dport parsed register blocks
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -633,6 +644,7 @@ struct cxl_dport {
 	struct cxl_rcrb_info rcrb;
 	bool rch;
 	struct cxl_port *port;
+	struct cxl_regs regs;
 };
 
 /**
-- 
2.34.1

