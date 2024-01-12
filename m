Return-Path: <linux-kernel+bounces-24164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1CC82B874
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19448286B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FEC15C6;
	Fri, 12 Jan 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LffQBZQJ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCA7F2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lExFJLd153+gsmdYO8p1jW8rlljHEPSEXMR/eoN8xgPua8oen9U9p4nLb93XZMcvC9DBp/imPjrbAOakLP4OK/gpLK5IyTNBr/Uugb2duCf9sMh8Ijpp44hJzreL4f8dZnjpJYke6/RbufZxiP5pRAUXD/nodgc/zTbonWiC5ymRyeQG3fukhZG1widonf6NnU3SGkuDluBJjDNJGR4APvxPiXqSeC4EpTV16Xx/0Sin9p64/7INAynbX9HEZESV2qW7bjsRznBfFd2G+AdBZDTVt12AJNbLSTn9ksUZQpB0YQfYlIYK6NFJn4tHgadfwixrPzkav94Pip4EquJlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtNMXDQ/R1IcqkDmvWPHjjrqE7FMCvYBy+amnVhYPKE=;
 b=ShfICYf1X/1ZYuF0lhdeQE6jNAveB49QNRYBvhEBg051IjxPiyEGGjW8wW71V3rTzOpLrQxdxR/OO53Iem7ie1WxnOFibOxqZifHh6tEDjlk+yetrTHWyCRlQ9X4++H1tzn1S2hEF7WmfDWRMZd2zwfEb1LJNGFUPfCKcb/KyG0o96guKWEomAAUYAacpNhIRqiwJy7M3OkSELJNWP28o8AzsVBmRK9ScN3BynxYiCEd6sqB6Bee6avv5iDx7GY4KEW8L4lRKc4lfxR5ed15y0HpfFmdfuV96Hk8Yl/R3pNpP9i9KaQU1OAGSrSXHDoa5TXc0zyg/ymbf8NuHP/qAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtNMXDQ/R1IcqkDmvWPHjjrqE7FMCvYBy+amnVhYPKE=;
 b=LffQBZQJUpqFAH4TO3cRL52EhjsY4f0y/4dMaLWxjVcIdHQX3bWAOi6hxn8rfE4SJmD33htvHnRnvGcX0W4uV9ujTc2Rh3zF4yKh7AU4XPFnKv65OUjcB45DLSyAua4S/5wRv6ygmXnOgkJd4CbGx601f0vL4dnQ2kZdAHcPWvU=
Received: from MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::29)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 00:07:05 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::ed) by MW4P223CA0024.outlook.office365.com
 (2603:10b6:303:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Fri, 12 Jan 2024 00:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 00:07:04 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 18:07:02 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<eric.auger@redhat.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>, <pandoh@google.com>,
	<loganodell@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [RFCv2 PATCH 2/7] iommu/amd: Refactor set_dte_entry
Date: Thu, 11 Jan 2024 18:06:41 -0600
Message-ID: <20240112000646.98001-3-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: e163f7b2-019a-45ac-f6f1-08dc130268e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hzCswMhRPSy+4tCFuL6+rn06T/+4FBX9a7991uYiCX9awQQYmOGUVyYSV04xPIdoeLlaiI8S/1ZQV8BTyr7HGecINIkWBbLtTY4dYeoVwEKnrhHgiv8DmpBA7fGnjbM9g6ijOBu1scySXOQOmXiONvnhhmcDsQwX/AQaajepafgo1AOEhAwJ+WUZxOrgqTaGq+KP0pO+5JoPoJbCRFOUtL9pCAmpF1/smH5nH3eWYFPQMtL2Tn5XSyQ4qwD6lMyUMRRkhC3HPnNoO+VeKWOjgpFj+fcWRTzVFybLEHrZ0BcOEn8o927LCwN8qMqPcNTkRBvmthY9mwJoLdgfmnHWiX27XO0J7eTtLIt9Fz6ka1op3H+zFGXfzLibvYbKKtnDZvEOI4SW55Yx/OFwCuP/Eo+K7R8BjSJl69y8S4+fLMUOuNRgQkzM4SU3IzNls1gdddB6bV4leqeD4ycq63rEuH6BKsHHjGbl23qCa7vsyuU977xAsJX9Zni8qVThEoWxtVhcJppkkClvwkzfbrOXW+490CP3g9lPW9UNnFshaVq51y5k+KYseIrrpFkM7Pjxg5ZA3DUyajjblWVZRMi+P3NCOOjw7Uw8AdhcHjA76k0HcLY3sYkt5+b6Tei1onIGE3ia7Uv6prykjxt/CToiXZ5w5NG8goPcG7IHcZ95VD6FoVlWp7fCqRT4+86lT+pndwp55u3ysXqwm86bU1sA3Vl9TlSeLj3EzhGVN27SLTw46NS+UDVbKZXcd1z6gqjrgzP/wrr+5IAQxLNB8WMwMUuQl3uz2LWiXHqeE7XSHWs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(36860700001)(7416002)(478600001)(6666004)(5660300002)(7696005)(86362001)(41300700001)(2616005)(8676002)(316002)(110136005)(70586007)(47076005)(8936002)(54906003)(70206006)(36756003)(82740400003)(26005)(83380400001)(336012)(426003)(1076003)(16526019)(356005)(81166007)(4326008)(44832011)(40480700001)(2906002)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:07:04.8863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e163f7b2-019a-45ac-f6f1-08dc130268e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571

Separate logic for setting DTE[GCR3 Root Pointer Table] into a helper
function set_dte_gcr3_table() to prepare for adding nested domain support.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 124 ++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 52 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b9759f6d8be2..71099e5fbaee 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1917,89 +1917,109 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
+static void set_dte_gcr3_table(struct amd_iommu *iommu,
+			       struct iommu_dev_data *dev_data,
+			       struct dev_table_entry *target)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	int devid = dev_data->devid;
+	u64 tmp, gcr3 = 0;
+
+	if (!gcr3_info || !gcr3_info->gcr3_tbl)
+		return;
+
+	pr_debug("%s: devid=%#x, glx=%#x, giov=%#x, gcr3_tbl=%#llx\n",
+		 __func__, devid, gcr3_info->glx, gcr3_info->giov,
+		 (unsigned long long)gcr3_info->gcr3_tbl);
+
+	tmp = gcr3_info->glx;
+	target->data[0] |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
+	if (gcr3_info->giov)
+		target->data[0] |= DTE_FLAG_GIOV;
+	target->data[0] |= DTE_FLAG_GV;
+
+	/* First mask out possible old values for GCR3 table */
+	tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
+	target->data[0] &= ~tmp;
+	tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
+	target->data[1] &= ~tmp;
+	tmp = DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+	target->data[1] &= ~tmp;
+
+	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+
+	/* Encode GCR3 table into DTE */
+	tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
+	target->data[0] |= tmp;
+	tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
+	target->data[1] |= tmp;
+	tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
+	target->data[1] |= tmp;
+	tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
+	target->data[1] |= tmp;
+
+	/* Use system default */
+	tmp = amd_iommu_gpt_level;
+
+	/* Mask out old values for GuestPagingMode */
+	target->data[2] &= ~(0x3ULL << DTE_GPT_LEVEL_SHIFT);
+	target->data[2] |= (tmp << DTE_GPT_LEVEL_SHIFT);
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
-	u64 pte_root = 0;
-	u64 flags = 0;
-	u32 old_domid;
-	u16 devid = dev_data->devid;
 	u16 domid;
+	u16 devid = dev_data->devid;
 	struct protection_domain *domain = dev_data->domain;
+	struct dev_table_entry target = {.data = {0, 0, 0, 0}};
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
-	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u32 old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
 
 	if (domain_id_is_per_dev(domain))
 		domid = dev_data->domid;
 	else
 		domid = domain->id;
 
+	/*
+	 * Need to get the current value in dte[1,2] because they contain
+	 * interrupt-remapping settings, which has been programmed earlier.
+	 */
+	target.data[1] = dev_table[devid].data[1];
+	target.data[2] = dev_table[devid].data[2];
+
 	if (domain->iop.mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(domain->iop.root);
+		target.data[0] = iommu_virt_to_phys(domain->iop.root);
 
-	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
+	target.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+	target.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
 
 	/*
 	 * When SNP is enabled, Only set TV bit when IOMMU
 	 * page translation is in use.
 	 */
 	if (!amd_iommu_snp_en || (domid != 0))
-		pte_root |= DTE_FLAG_TV;
-
-	flags = dev_table[devid].data[1];
+		target.data[0] |= DTE_FLAG_TV;
 
 	if (dev_data->ats_enabled)
-		flags |= DTE_FLAG_IOTLB;
+		target.data[1] |= DTE_FLAG_IOTLB;
 
 	if (dev_data->ppr)
-		pte_root |= 1ULL << DEV_ENTRY_PPR;
+		target.data[0] |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
-		pte_root |= DTE_FLAG_HAD;
-
-	if (gcr3_info && gcr3_info->gcr3_tbl) {
-		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
-		u64 glx  = gcr3_info->glx;
-		u64 tmp;
-
-		pte_root |= DTE_FLAG_GV;
-		pte_root |= (glx & DTE_GLX_MASK) << DTE_GLX_SHIFT;
-
-		/* First mask out possible old values for GCR3 table */
-		tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
-		flags    &= ~tmp;
+		target.data[0] |= DTE_FLAG_HAD;
 
-		tmp = DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
-		flags    &= ~tmp;
-
-		/* Encode GCR3 table into DTE */
-		tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
-		pte_root |= tmp;
-
-		tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
-		flags    |= tmp;
-
-		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
-		flags    |= tmp;
-
-		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
-			dev_table[devid].data[2] |=
-				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
-		}
-
-		if (gcr3_info->giov)
-			pte_root |= DTE_FLAG_GIOV;
-	}
+	target.data[1] &= ~DEV_DOMID_MASK;
+	target.data[1] |= domid;
 
-	flags &= ~DEV_DOMID_MASK;
-	flags |= domid;
+	set_dte_gcr3_table(iommu, dev_data, &target);
 
-	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
-	dev_table[devid].data[1]  = flags;
-	dev_table[devid].data[0]  = pte_root;
+	dev_table[devid].data[0] = target.data[0];
+	dev_table[devid].data[1] = target.data[1];
+	dev_table[devid].data[2] = target.data[2];
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
-- 
2.34.1


