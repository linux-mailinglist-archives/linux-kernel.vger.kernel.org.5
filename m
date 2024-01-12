Return-Path: <linux-kernel+bounces-24168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF882B878
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D98B24E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2D2EEA3;
	Fri, 12 Jan 2024 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IsGxnow7"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD615BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6fKscQVbfWAh/DMcHIsl+HobxWOKvYdMuifgP5njONJQmKgkaaY4rXwhSXh1dBqJ9abb1KS1U0fc1efjQKcCvKkfZbwm6HkVUYEjcxCNEbzU+f3B8y1h01LKOzidXOXNiOJURef2tOjbigYBPOPhP4haSR76c+c7PO9lFP+3hO6NmZKSa5pCXuR99b2h4ZmJYbmIgOVVnGlmg+R4uZdlV0Ox+aEDhuTjQbeM6eXhbY9Vp8deu+Ji9So+7H+v3csQ+XvFER2o21OSRFEILLnCdGoLoUEMC28sTgWyVIUPMBujiC+pIO7+Lr/ItRef4VB8tfIOuHbr2DMfhM6MopYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfXe4XBzvZvb4xL/HqKvRdR1ZCyTZrTMWw1fobH+VJ8=;
 b=YedveHroogPyiDH1kDWLksaNIhi7lABWr/AmKUtpB88J0Pa/0Sj7dYcYNwHK21HZY7YSVxn67OEEY4/9XMkNa196Mf+gCwGoI+k96SzQzWonQauNWlIjnYl6CZtGuWIfSNUfQH/UmSVo8HMSfPwrJu2qWz7mCbaU4B/vOzO6bIUMDx0h0nzERb1hXoZFmVCsKQydu1mpXlfLf7hF6izVFiqGMUnMjkfXBejcpjj+nnxgPvjoCtmm2WRbmriTVNKNMc6XLFgP7dtnbsaNHYZTiQb0+HsuU32HSLYAs1hm9lHm3Ca1/a9K6NFaM7yHlE0W1FokPKgDEqEr130Pkb2+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfXe4XBzvZvb4xL/HqKvRdR1ZCyTZrTMWw1fobH+VJ8=;
 b=IsGxnow7zcJRozwcEBnEEEFSwf9+8cWSq1bnHVGp4aPn2JpR1nWLfys1q7BlTSsCjd1M99o/rcJomOzN5HB4XPp84v/7Oa2nrYCXP7Pj4fLLNFbp2STWtY/V0tSoXtKMSAOC0vFUgOg7OREltjddCf7F4GCIjMl3jAfbkaz3+bQ=
Received: from MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::21)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 00:07:09 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::7d) by MW4P223CA0016.outlook.office365.com
 (2603:10b6:303:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Fri, 12 Jan 2024 00:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 00:07:09 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 18:07:06 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<eric.auger@redhat.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>, <pandoh@google.com>,
	<loganodell@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [RFCv2 PATCH 7/7] iommu/amd: Add nested domain attach/detach support
Date: Thu, 11 Jan 2024 18:06:46 -0600
Message-ID: <20240112000646.98001-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5c6a1b-27fc-4081-124a-08dc13026ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g8Q/T9MOrEUjKL4ZbrLPatDf4TIUihihb0/1s0dalW9zpo9vlYByYETZ0nxeBskmJpLyVv/jLvVUXpwwIyvWgF8cFg7PiBI6k7gVU3fHTglFmYk6AGEoTzljG7Rswufd5HMg6lCvHUPRaosJIGfHDlF1yvG0hVjLA/t/KRwGLIMgh3MSkjkRJhi7C9Duu81z0DpsS3koXUok1AOmePuiUc7cqQBjLnCYvhPDEb7MX3dQN0tvLPdQ6DDNjIZwnCdiYOuM8qbCA0MdhvSR+A5zz8LfVgrg3VPbsAOjYtM8OkTpX4mlzbe6uw3uuFcdVEYwRKlSqe1gIQSygFKfVZY4Vfwj4q3Q/rW3oGNzqp36rZ6msQO4lDq+uq/yIWVOulfKxuyRZo+MPNjQUjCweKTN5OMKr540wMvQW9kP0YV7/n3l6WPXiBnoaGDCuBBc8epYORQmcqe+slThuMjTbk3K/EUVOwFgWQ9IVkwK4Nfi88ocjJszK8de7PDsRQ7SLdbYawkJ4v2g3qERryHgmKGKxm23w3dfwd9Fn0zfQaWLsgnR/3YvFpg8WEdu4J982LTzkcUtPy+3X9ZjetAeetqJhHFLI8kKD9tYNkxrdamE7BOZ1DFIKjrqOG0Zw4CvLGOqlV1ph2QUGE7NA7OFPTANtpaEvwrCQAsjeIbvf4bTNsfFrw86dJtoTBeQY/v5owavGEJ7vkiRSK4YeO/xfSeqISShO3tCC1hXKb0YCNpeUbukrm2muRkJOlnlt+T+HhGIPqkzJPt8CEz0ZuN/jRXhYDUalwfpF51hAu4XY/BcWyk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(44832011)(40480700001)(40460700003)(2906002)(5660300002)(7416002)(478600001)(81166007)(356005)(4326008)(36756003)(70586007)(8676002)(8936002)(70206006)(54906003)(110136005)(41300700001)(316002)(2616005)(86362001)(1076003)(6666004)(7696005)(26005)(83380400001)(82740400003)(426003)(16526019)(336012)(47076005)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:07:09.5269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5c6a1b-27fc-4081-124a-08dc13026ba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236

With GCR3TRPMode, the AMD IOMMU driver does not need to allocate the GCR3
table and the v2 (stage 1) table. Instead, it uses the GPA of the GCR3
table provided by the guest when attach/detach the nesting domain.

Modify the set_dte_gcr3_table() to program DTE[GCR3 Table Root Pointer]
for nesting domain with the provided GPA.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 45 +++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 51716fa5ccb5..4041ac3fcd1b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1927,15 +1927,16 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 			       struct dev_table_entry *target)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct protection_domain *pdom = dev_data->domain;
 	int devid = dev_data->devid;
 	u64 tmp, gcr3 = 0;
 
-	if (!gcr3_info || !gcr3_info->gcr3_tbl)
+	if (!gcr3_info || (!gcr3_info->gcr3_tbl && !gcr3_info->trp_gpa))
 		return;
 
-	pr_debug("%s: devid=%#x, glx=%#x, giov=%#x, gcr3_tbl=%#llx\n",
+	pr_debug("%s: devid=%#x, glx=%#x, giov=%#x, gcr3_tbl=%#llx, trp_gpa=%#llx\n",
 		 __func__, devid, gcr3_info->glx, gcr3_info->giov,
-		 (unsigned long long)gcr3_info->gcr3_tbl);
+		 (unsigned long long)gcr3_info->gcr3_tbl, gcr3_info->trp_gpa);
 
 	tmp = gcr3_info->glx;
 	target->data[0] |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
@@ -1951,7 +1952,11 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 	tmp = DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
 	target->data[1] &= ~tmp;
 
-	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+	/* For nested domain, use GCR3 GPA provided */
+	if (amd_iommu_domain_is_nested(pdom))
+		gcr3 = gcr3_info->trp_gpa;
+	else if (gcr3_info->gcr3_tbl)
+		gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
 
 	/* Encode GCR3 table into DTE */
 	tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
@@ -1963,8 +1968,21 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 	tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
 	target->data[1] |= tmp;
 
-	/* Use system default */
-	tmp = amd_iommu_gpt_level;
+	if (amd_iommu_domain_is_nested(pdom)) {
+		/*
+		 * For nested domain, guest provide guest-paging mode.
+		 * We need to check host capability before setting the mode.
+		 */
+		tmp = pdom->guest_paging_mode;
+		if (tmp > amd_iommu_gpt_level) {
+			pr_err("Cannot support Guest paging mode=%#x (dom_id=%#x).\n",
+			       pdom->guest_paging_mode, pdom->id);
+			tmp = amd_iommu_gpt_level;
+		}
+	} else {
+		/* Use system default */
+		tmp = amd_iommu_gpt_level;
+	}
 
 	/* Mask out old values for GuestPagingMode */
 	target->data[2] &= ~(0x3ULL << DTE_GPT_LEVEL_SHIFT);
@@ -1981,6 +1999,13 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	u32 old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
 
+	/*
+	 * For nested domain, use parent domain to setup v1 table
+	 * information and domain id.
+	 */
+	if (amd_iommu_domain_is_nested(domain))
+		domain = domain->parent;
+
 	if (domain_id_is_per_dev(domain))
 		domid = dev_data->domid;
 	else
@@ -2076,7 +2101,8 @@ static int do_attach(struct iommu_dev_data *dev_data,
 		dev_data->domid = domain_id_alloc();
 
 	/* Init GCR3 table and update device table */
-	if (domain->pd_mode == PD_MODE_V2) {
+	if (!amd_iommu_domain_is_nested(domain) &&
+	    pdom_is_v2_pgtbl_mode(domain)) {
 		/*
 		 * By default, setup GCR3 table to support MAX PASIDs
 		 * support by the IOMMU HW.
@@ -2117,8 +2143,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
 
 	iommu = get_amd_iommu_from_dev(dev_data->dev);
 
-	/* Clear GCR3 table */
-	if (domain->pd_mode == PD_MODE_V2) {
+	if (!amd_iommu_domain_is_nested(domain) &&
+	    pdom_is_v2_pgtbl_mode(domain)) {
+		/* Clear GCR3 table */
 		__clear_gcr3(dev_data, 0);
 		free_gcr3_table(dev_data);
 	}
-- 
2.34.1


