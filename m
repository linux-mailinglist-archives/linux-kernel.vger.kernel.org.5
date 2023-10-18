Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A357CE479
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjJRR3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjJRR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:28:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046933A99;
        Wed, 18 Oct 2023 10:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eligYX3FtiEbwYuhR92vTOY8URw8qsY+WWoPkc3Na7sWdVfQ9u86ScuScsv3Yd6BnGD8Xv0iyZxAuFt0WN+9gy9+11cRQ2Ffh6fK7J6obhasctlXKduT79iSOed0pc6mTBwSJIhicvDf1qbOpWWqrnJcgRIrzKkn2U/5pxdCof86JFP5RodvejxsiLv5FxlcOoFZNoNRFTrqC74pwJojpLMd631gRS1KrzvgZ2wJwP7s1Eq8Y4FFPCxwWZZJey81h4rw7rNxjNVvukUzlGbwJkP2LlYKcen9G5HVBvU2CbuX45qkO1EnudhM/l8Qb9CMiz+uDGTEfKqrvNnzqLNWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdHQ6ZapXhY9GyC+7nBOBIusN6J+LUEwgiPEiwaJpNU=;
 b=ZcPn1eOCMaOwOSg5sxs27jdmG4jZ5sSuB5Ar+/ZhgNPaTlOCWG9RTF24At/4Loxwn63TPlIvc9p/u18LfHRv8QjfscZ9ge//cB4GBUYskau10vMYAJTziLGe0WRzRTQVm4gJe2FBWfyQHpvYUaYyrwnb10Gt/iwA9eoDRzATPGFedBgty/4Az/vQVfR9DnkelKJsmZqIURLlTfgWkvtWOKCVUeb/kLxq3ecnG3gdXkdKWk2HctjBlaRvWT84qEzoNc2bRrJ190TXtfYC3k8EP3oQUSTYH+kd9JD5L555sCjxLGIV9p8jk9xBCtChLwNtiiT54/mIW8j2qNOYCFkEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdHQ6ZapXhY9GyC+7nBOBIusN6J+LUEwgiPEiwaJpNU=;
 b=Vb6/N6aTkKbAgTZJwMtYnaQALcdGjfPNUj7pzZiNgcYuzAOPQNGkdsI5VDo3svbCbaItLtVHhcbLKgyptsnK65aImYaZtQNqWBglsjrO+EPCfkOC7AUA/B9MpIo3bfR5ZqXB3eSW8d94BEBPHtin8RQXirCrFVnH08hnqzUKYCs=
Received: from PR0P264CA0176.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::20)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 18 Oct
 2023 17:20:49 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10a6:100:1c:cafe::9a) by PR0P264CA0176.outlook.office365.com
 (2603:10a6:100:1c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:20:48 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:20:41 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 19/20] cxl/core/regs: Rename phys_addr in cxl_map_component_regs()
Date:   Wed, 18 Oct 2023 19:17:12 +0200
Message-ID: <20231018171713.1883517-20-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018171713.1883517-1-rrichter@amd.com>
References: <20231018171713.1883517-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: d81832e1-c18c-413e-ea32-08dbcffe920d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BI25FQKFftXZZ0Rysqk6QxgYIEi+mlCcLAe1+6vuArQ+9vK7tE8f/3V6E9eGBimV6B4Xs5+P3Q7QFrBLsDCs/pRKNEsCOfGpPIfREB1uczl7iK6TlkScG87Jo9rP61erDn6eA9XK5EC3jTzmi3QSrZADOZKYnLJwWTYNuuVwmb0lj8drgcHA6X4ZYt6enJNM1un8EZH0GqaEojGp5aB9dyt/mJVHkLKIqF2HbHFgiypDK06GRQaPRXPTAZyGumS9q9PEiGu7y4aY1p3WAoj/LF0K65bqjaFydjOjupVO4DoFBFwIykLMPE7iZ/F2GfbfydRT2fvKpYq3DzFOujFO0+Iizy+Dj6eXlisfj414byCvckBGFsJU+L+yyyAly0S7d0tJTNLjpmYenKdB1Py3Y+2iIWESTaFUDMT6kqTdyIjVSyB68WDViYKx5vgfWh5ZRomQdZ1/LWQH0VkJ3I+tZoXvFmf/e+O3nw1pMnGdxhriCdw+F6wrjo8QfuVbMp23cXdV1WbRubEKKfUsDeeZINn2lsRJOPtrqzH1j0rDfqCYb1h4MxBYr3dP5TuuKUjMLNcu8GN82i+Ks3WfxVGfDXAM2OyyJxZwALQqLZD208cm6EbAbRTDK3W8GJXuB2mrB4OnmSXBrbFg/RBnBmR+gWyR/CjF+oLQVzzjzs597E+yv/nFd/ekUkbA7Fl5b/x3jk/tecz6kPIwLGEK3h3DYmImN46ELDyGtbKdCsV7nm0GxrWK1nJPynq8R3+s3s/ZJOuPm5Y/cl3X768fd9nthg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(6666004)(8676002)(2616005)(1076003)(70586007)(82740400003)(40480700001)(36860700001)(316002)(478600001)(36756003)(110136005)(356005)(81166007)(40460700003)(426003)(47076005)(7416002)(2906002)(336012)(83380400001)(5660300002)(26005)(16526019)(8936002)(4326008)(70206006)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:20:48.1616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d81832e1-c18c-413e-ea32-08dbcffe920d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial change that renames variable phys_addr in
cxl_map_component_regs() to shorten its length to keep the 80 char
size limit for the line and also for consistency between the different
paths.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 9111ceef1127..cac28a656cb8 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -216,16 +216,16 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 
 	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
 		struct mapinfo *mi = &mapinfo[i];
-		resource_size_t phys_addr;
+		resource_size_t addr;
 		resource_size_t length;
 
 		if (!mi->rmap->valid)
 			continue;
 		if (!test_bit(mi->rmap->id, &map_mask))
 			continue;
-		phys_addr = map->resource + mi->rmap->offset;
+		addr = map->resource + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(host, phys_addr, length);
+		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
-- 
2.30.2

