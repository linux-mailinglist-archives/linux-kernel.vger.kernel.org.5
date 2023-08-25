Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F08789262
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjHYXdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHYXdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:33:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298F2114;
        Fri, 25 Aug 2023 16:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcM4gcyvgPqj4XGm/F8mx/cvbzvBihgH/IpMWVKS+erjY2L5y16JBow0tkbwZq9RyNGAPGZrHyvcnHExcYkuSZ1zvZ5P6tvkIZ0gWIiCvq8diuGMKy0/IhCD9BVWAa/B3FXm8uj8XI1nECfP8OmqVXa+4BiTEmWKhP4bgJkcA5pC5wWIZPiaAG52aNxn7dXPsprENmBn1R4/aHQDJh8lPcNQsmeJzLop9f1cMCMOYE2R8Oz8CLKglUMnWEzkkCFEYk3b/JkOn85U1dVpWO0esMnyYtxYs8dM18UOiJjYrhCVnh8hDzHIwue0L4XnvWc2uE2kpE/QGqg2mYhwfL8A6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJgXFYZ9wbemLABODh/lNfldKXu+EY5UKueoeWpDyzg=;
 b=ePUW9apiAqAcuB4Q9sHWaZ1/Stkx1/iFAm6+SUYXprfrFUtlo+H8ZC34Aev+xrngneJn+vKM6GWw5zOz6u66Wjo+DG00XYaTXoplaSarLjhl4mbn2/gFqk0987SSHvNencS/g8h5qiE4M7zthtpbYg0TpUHXIQPVNIF59/zv6Yywi+cpNO+iH7IuF6JJYJAXPT/QLu1SQYSllwKOHgcaIX0MHwhRsrWKonR4h/O0NxBJkx2ZUiem1FOoektJ+U9AhS2SBib34xxTGLI6hpiNvaMc5vMMQCPJyIH1BQMFz+BKW6D32hlqXlscBfSRmL40THmik073wETCR+CBhe49DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJgXFYZ9wbemLABODh/lNfldKXu+EY5UKueoeWpDyzg=;
 b=adDxPZEkJHTNchVaymENLgmvH2IAz/mi3yPForo9TvCUL7rH2Fj+1LvZOP0vx7BsckmsaCgXgPcu+uJQ5qZbijlmcCsxz6ImxPTvLnLgqTw5hFX2/C52gem1S0ud1M21VDaZg0qbbosAsG1rNo/Q9uECpz3v7bLbbFXRm8YoKik=
Received: from SN6PR05CA0032.namprd05.prod.outlook.com (2603:10b6:805:de::45)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 23:33:26 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::e) by SN6PR05CA0032.outlook.office365.com
 (2603:10b6:805:de::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.20 via Frontend
 Transport; Fri, 25 Aug 2023 23:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 23:33:26 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 18:33:25 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v9 05/15] cxl/pci: Remove Component Register base address from struct cxl_dev_state
Date:   Fri, 25 Aug 2023 18:32:01 -0500
Message-ID: <20230825233211.3029825-6-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 384a713e-7bd2-44dc-49d8-08dba5c3ae4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huFQUza0CO/1Ljub0TQ/dRZY7n59lhK7BlxdQXBJ47YKv5jPi+nSy051Op9QeqfWVwXAuoStFycNxc+Gfp8vpD/QUSOqMELQ5H3su4PwJ4OLmoE9gX+0oQVM0wMc43Rnz8s4/CM+lAaNsD6eCHX6tNQBHvD6SMczUmNvhgfBjQuQlyyGORUV0HWWjYR185Aa1uw6nIKQo+uWzZ3mvs76cCcoLRPlLKQOmG0t/umw+rowBex2goVF5dw7nJQ37wtgkH4go+iFuC5JvSkYHOWCYIsBHXUBqQvsVdZ4SKJB6Wo4VG1ilEiu93lYwMGl3veMUgSYQZSSd3jahQsVkSDD1R3t79X7aWIckdGJhFU57nOmc6BnnSim6Lwxns0Neh8/6kJjCZ13YqCP4gnweOUQoe2TesisfJKYaup//iNpMqMbcHdb0OjM6IidoLNi6a1g8HSR5V917nLEnPrhQDiTnQzdaeU6Cl95Tl2MF31yCSTZrnS27l/zpNXXHREtICdUlxxcvYS9Ff1lRfKetXQew+cS0Wc99Rl17rjLtBA8soRrK/xs6bTKz2nhCWNk360XG+lpOfwXXsUva2BmiollwVqIy7aJuHamDWgeSnzMH5DVsX2YNLuWog8mus9iuzV34e8trP4N7CKi+0UYaRLFSDp/Tclsg8LIBygyytIDLmEhBjV8YiwK1w8WFwEHEm9TB5mXEcPZ0WDXxuLj94iZQ6qDfN10HpNWRfWQhbfALt1mkaHu/phgmOYhZImW1iwB8prrQTBKBPUwtH2rFduOVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400011)(186009)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(54906003)(70206006)(70586007)(316002)(478600001)(110136005)(40480700001)(16526019)(26005)(6666004)(82740400003)(81166007)(41300700001)(86362001)(2906002)(356005)(7696005)(4326008)(8676002)(8936002)(83380400001)(2616005)(40460700003)(5660300002)(47076005)(7416002)(44832011)(426003)(1076003)(336012)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:33:26.3938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384a713e-7bd2-44dc-49d8-08dba5c3ae4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @comp_map instead. Remove the base address.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h         | 2 --
 drivers/cxl/mem.c            | 4 ++--
 drivers/cxl/pci.c            | 3 ---
 tools/testing/cxl/test/mem.c | 1 -
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 607ee34b0ce7..fdfa6e5dd739 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -390,7 +390,6 @@ enum cxl_devtype {
  * @dpa_res: Overall DPA resource tree for the device
  * @pmem_res: Active Persistent memory capacity configuration
  * @ram_res: Active Volatile memory capacity configuration
- * @component_reg_phys: register base of component registers
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
  */
@@ -405,7 +404,6 @@ struct cxl_dev_state {
 	struct resource dpa_res;
 	struct resource pmem_res;
 	struct resource ram_res;
-	resource_size_t component_reg_phys;
 	u64 serial;
 	enum cxl_devtype type;
 };
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 317c7548e4e9..3af3218ebe0e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -49,7 +49,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
 	int rc;
 
@@ -65,8 +64,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		ep->next = down;
 	}
 
+	/* The Endpoint's component regs are located in cxlds. */
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
-				     cxlds->component_reg_phys,
+				     CXL_RESOURCE_NONE,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f8ad601b314e..b71f1c7d16ce 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -835,7 +835,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
 	 */
-	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
 				&cxlds->comp_map);
 	if (rc)
@@ -843,8 +842,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else if (!cxlds->comp_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = cxlds->comp_map.resource;
-
 	rc = cxl_map_component_regs(&cxlds->comp_map, cxlds->dev,
 				    &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 464fc39ed277..aa44d111fd28 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1423,7 +1423,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	cxlds->serial = pdev->id;
 	if (is_rcd(pdev)) {
 		cxlds->rcd = true;
-		cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	}
 
 	rc = cxl_enumerate_cmds(mds);
-- 
2.34.1

