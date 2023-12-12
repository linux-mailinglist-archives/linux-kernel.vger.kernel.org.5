Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33EF80F1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377251AbjLLQCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377028AbjLLQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:02:08 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC70DEA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:02:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODyB3yoTLO7HFpVpOQekAseDqNapDXug3cgox1QeVV9Pbec4seP3X/xDipGhMRHBd2XaTAsGbjAZRCnYgcWPHdBmIEvApKEtbTdJU+qd4yAEKxJAo/CGnWFekTsOsFAEu156GNUvaMz1/EXHzYXNZaF+zpV81pSgbUPtPmiRDvbjnqkDOVAfj3fXpGGA27hlJZDXNhTR35FguuK4DD6L22/e2pVEoNLEsmioQQs6Htc8cjHTicX/PxijfbbaB4mdPBlDGZbOpCoRsdKQhfXDOVW4gOfm1XDMvZ2swc86eD/fg2P5itOrTuYcKw4QS36INnfDjs9Nx/0Gr+5gOaoFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0t1O6PS4HQZxDRacCxVotWwYGVY0VRDxpdj2PXvXsI=;
 b=YhKPuBpA5aTYz1H513wX84XXkNjd6p3k9iA7zXXXEBw3gWtYGNAP7E6MjMMPzPv1JjwdWhrl2gxt4o3WpSMX/uBGa9d3xiSj1SO4I+yM/ApZFGfvwIng5fJBaZsfI6srJmad0nqCf6TGqk/5nS1KySozHZqtFPQGy3TzwtWCJkUzPvosxwFnk+Wi2waUgSByaMIGw4Tk5mi+aZV2RLGnKRuPJbz2ErUfYK3kxLijwc0THioRFgWJkQWjgxcT3S50SVFN8pJurcC2V1COdrZkM3Z4CAg2UtWInmhklVPF8z2GUE58fbnuCHVhFZVm5GF60VgC/zxFbrttkZEhnhTWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0t1O6PS4HQZxDRacCxVotWwYGVY0VRDxpdj2PXvXsI=;
 b=B/ts5wjyzCSsJ+spfjm3I8/zWMeBpl+97Ej69ERuiRjpDrRDT9RGpUJDLoo0P+7p9vgmBx8UcYx2LKRUChg+4sTo1J1wzfN/Knuhl8kBUt3o3Lc4ysSlcGVQoJOrMym6mRF/fazwKrgVJqYnAoDK5q4RoRmmYbvUGeHRgLkBv/A=
Received: from BL0PR02CA0078.namprd02.prod.outlook.com (2603:10b6:208:51::19)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 16:02:10 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::f) by BL0PR02CA0078.outlook.office365.com
 (2603:10b6:208:51::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 16:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 16:02:10 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 10:02:07 -0600
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <joro@8bytes.org>, <jgg@nvidia.com>
CC:     <yi.l.liu@intel.com>, <kevin.tian@intel.com>,
        <nicolinc@nvidia.com>, <eric.auger@redhat.com>,
        <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
        <pandoh@google.com>, <loganodell@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH 5/6] iommu/amd: Introduce helper functions to setup GCR3TRPMode
Date:   Tue, 12 Dec 2023 10:01:38 -0600
Message-ID: <20231212160139.174229-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: e439176e-317f-47ca-4043-08dbfb2bb290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fnh6WCFqm1X3IWub83d5d7QVKKTWUsaP/ARE0ywaml+i84X+B3j/ou8zKoqKpNzWjrVTuv5TjRLdF8uim2NsY6iibp5n842GUUoTTDUGW47PHlzfGs9uymnjTEtvcD+vPaFZA9Csa9n7SaV1nf0peipl/ZmX85RvMuZXX2jze1ggDO646vq9kpZugIqGIKXTOVhyU9909G6gquCUyXLNN06UJ5hmjxNBgKnKj2vXmfUWvIotEpEvSZXYQPnQ4SQGIURbUdFQe5QD0o5o2bGxax792xY8lHoRrPpOoUEor2/oraAqszdGnwMxM/wtNTDBliPGhOUHHMUh+q5+pM8QN+SWUKSOz/pEJJTOtIYuxkX2k+lyuZIyHuzFYQvqsoWckJCeF5dnB8ZfmfbUxjdkcKzE2YENaJvab/RQ+dcsKfdfQroJ79E5f4txSYUMgIlBxELrqewl2s+n9IorXivsbzOwBi2TGrJX8upqrioHU9hsA30WGsCgel0yzUAac2gt1/NO5oeNCIT6XIpT2AnGKD1mOhUPfJYzZTRfoGQCcmmD0nv7MvMwlB3gCNP281SsfKJxH0In8R7GuM3cAZnWOz/doxLP0pJ58lNK3yR0cZIfRh4WQHzjTJchXXPUZSLsMeLsGyGyMqZunTcgRUPAp6p4xYVtAW4jPIFV9lSax+Ou0BQ78JBwb8Gj/tNgncJwNIwPYRgxDlmO5hZQ7idQC6f0oYH3Mk1er/o3lAXqcYwhY4EWlZoLVmI6E+aNUTebgaNIKLg7Dxn8XHxxVpph3VPkVwo8e+0jYGp/6dI2mco/6LqyR3Sx2+F75Xkit68n+RnNn+aoLAJNzoCj9wF3wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(1076003)(47076005)(5660300002)(336012)(26005)(2616005)(16526019)(44832011)(36756003)(40480700001)(426003)(54906003)(70586007)(70206006)(7416002)(2906002)(83380400001)(82740400003)(86362001)(81166007)(478600001)(41300700001)(356005)(4326008)(7696005)(8936002)(8676002)(6666004)(110136005)(316002)(71600200004)(32563001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:02:10.0552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e439176e-317f-47ca-4043-08dbfb2bb290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCR3TRPMode allows IOMMU hardware to use GPA when programming the
GCR3 table root pointer (GCR3TRP) in the DTE. The GPA will be translated
by the IOMMU using the v1 page table referenced by the
DTE[Host Page Table Root Pointer].

Please see the AMD IOMMU Specification for more detail.
(https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   2 +
 drivers/iommu/amd/amd_iommu_types.h |   1 +
 drivers/iommu/amd/iommu.c           | 132 +++++++++++++++++++++++++++-
 3 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 7783a933ad14..55479a6efaae 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -56,6 +56,8 @@ void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3);
 int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
+int amd_iommu_set_gcr3tbl_trp(struct amd_iommu *iommu, struct pci_dev *pdev,
+			      u64 gcr3_tbl, u16 glx, u16 guest_paging_mode);
 
 /*
  * This function flushes all internal caches of
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a00731673c50..1b150e0cb689 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -541,6 +541,7 @@ struct gcr3_tbl_info {
 	u64	*gcr3_tbl;	/* Guest CR3 table */
 	int	glx;		/* Number of levels for GCR3 table */
 	u32	pasid_cnt;	/* Track attached PASIDs */
+	bool	trp;		/* TRP support */
 };
 
 struct amd_io_pgtable {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d18b23ac6357..8bf12674dc84 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -93,6 +93,9 @@ static void detach_device(struct device *dev);
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
 
+static void amd_iommu_clear_gcr3tbl_trp(struct amd_iommu *iommu,
+					struct iommu_dev_data *dev_data);
+
 /****************************************************************************
  *
  * Helper functions
@@ -2146,15 +2149,25 @@ static int do_attach(struct iommu_dev_data *dev_data,
 
 static void do_detach(struct iommu_dev_data *dev_data)
 {
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 
 	iommu = get_amd_iommu_from_dev(dev_data->dev);
 
-	/* Clear GCR3 table */
-	if (domain->pd_mode == PD_MODE_V2) {
-		__clear_gcr3(dev_data, 0);
-		free_gcr3_table(dev_data);
+	if (gcr3_info->gcr3_tbl) {
+		if (gcr3_info->trp) {
+			/*
+			 * In GCR3TRPMode, the GCR3 table contains GPA,
+			 * which is setup by guest kernel. Therefore, we just
+			 * need to clean up the DTE settings for guest translation.
+			 */
+			amd_iommu_clear_gcr3tbl_trp(iommu, dev_data);
+		} else {
+			/* Clear GCR3 table */
+			__clear_gcr3(dev_data, 0);
+			free_gcr3_table(dev_data);
+		}
 	}
 
 	/* Update data structures */
@@ -2951,6 +2964,117 @@ const struct iommu_ops amd_iommu_ops = {
 	}
 };
 
+/*
+ * For GCR3TRPMode, user-space provides GPA for the GCR3 Root Pointer Table.
+ */
+int amd_iommu_set_gcr3tbl_trp(struct amd_iommu *iommu, struct pci_dev *pdev,
+			      u64 gcr3_tbl, u16 glx, u16 guest_paging_mode)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	int devid = pci_dev_id(pdev);
+	u64 data0 = dev_table[devid].data[0];
+	u64 data1 = dev_table[devid].data[1];
+	u64 data2 = dev_table[devid].data[2];
+	u64 tmp;
+
+	pr_debug("%s: devid=%d, glx=%#x, gcr3_tbl=%#llx\n",
+		__func__, devid, glx, gcr3_tbl);
+
+	WARN_ON(gcr3_info->trp);
+
+	gcr3_info->trp = true;
+	gcr3_info->gcr3_tbl = (u64 *)gcr3_tbl;
+
+	data0 |= DTE_FLAG_GV | DTE_FLAG_GIOV;
+	tmp = glx;
+	data0 |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
+
+	/* First mask out possible old values for GCR3 table */
+	tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
+	data0 &= ~tmp;
+
+	tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
+	data1 &= ~tmp;
+
+	tmp = DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+	data1 &= ~tmp;
+
+	/* Encode GCR3 table into DTE */
+	tmp = DTE_GCR3_VAL_A(gcr3_tbl) << DTE_GCR3_SHIFT_A;
+	data0 |= tmp;
+
+	tmp = DTE_GCR3_VAL_B(gcr3_tbl) << DTE_GCR3_SHIFT_B;
+	data1 |= tmp;
+
+	tmp = DTE_GCR3_VAL_C(gcr3_tbl) << DTE_GCR3_SHIFT_C;
+	data1 |= tmp;
+
+	/* Mask out old values for GuestPagingMode */
+	data2 &= ~(0x3ULL << DTE_GPT_LEVEL_SHIFT);
+
+	/* Check 5-level support for the host before enabling on behalf of the guest */
+	tmp = (u64)guest_paging_mode;
+	if ((tmp == GUEST_PGTABLE_5_LEVEL) &&
+	    (check_feature_gpt_level() < GUEST_PGTABLE_5_LEVEL)) {
+		pr_err("Cannot support 5-level v2 page table.\n");
+		return -EINVAL;
+	}
+	data2 |= (tmp << DTE_GPT_LEVEL_SHIFT);
+
+	dev_table[devid].data[2] = data2;
+	dev_table[devid].data[1] = data1;
+	dev_table[devid].data[0] = data0;
+
+	device_flush_dte(dev_data);
+	iommu_completion_wait(iommu);
+
+	return 0;
+}
+
+void amd_iommu_clear_gcr3tbl_trp(struct amd_iommu *iommu,
+				 struct iommu_dev_data *dev_data)
+{
+	int devid = dev_data->devid;
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	u64 data0 = dev_table[devid].data[0];
+	u64 data1 = dev_table[devid].data[1];
+	u64 data2 = dev_table[devid].data[2];
+	u64 tmp;
+
+	if (!gcr3_info->trp)
+		return;
+
+	pr_debug("%s: devid=%#x, gcr3_tbl=%#llx\n", __func__, devid,
+		 (unsigned long long)gcr3_info->gcr3_tbl);
+
+	tmp = DTE_GLX_MASK;
+	data0 &= ~(tmp << DTE_GLX_SHIFT);
+	data0 &= ~(DTE_FLAG_GV | DTE_FLAG_GIOV);
+
+	/* Mask out possible old values for GCR3 table */
+	tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
+	data0 &= ~tmp;
+
+	tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
+	data1 &= ~tmp;
+
+	tmp = DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+	data1 &= ~tmp;
+
+	/* Mask out old values for GuestPagingMode */
+	data2 &= ~(0x3ULL << DTE_GPT_LEVEL_SHIFT);
+
+	dev_table[devid].data[2] = data2;
+	dev_table[devid].data[1] = data1;
+	dev_table[devid].data[0] = data0;
+
+	gcr3_info->trp = false;
+	gcr3_info->gcr3_tbl = NULL;
+}
+
 #ifdef CONFIG_IRQ_REMAP
 
 /*****************************************************************************
-- 
2.34.1

