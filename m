Return-Path: <linux-kernel+bounces-24166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC27482B876
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C851F21E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930C29CA;
	Fri, 12 Jan 2024 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EgzcVnxu"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD8610F1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqeF50yyD5KgMoPSHh80YtRV97WD2wE5ypKdu4LLhRo79A9phb12KUitaS+uLbKL3qVL0WBa7C41FvO6loX2ejZMNkhSaMHR9yYwRYY+jGQB0JFvMr2Jn5G8OFVzK4P1224ct6bMO2+4LODdJNyQUZT+3ohd/ePorQ7yJMJtKZM/nvBFmkwjBImwjIoLmmcywnVQZrCn5OE4lcIFt0D/FzUZp44jVbm7aCDrhx5XpkpSS5tldV3ePKKjzgfbcVjuc7W69szHagaeL0A4QbDCnmZqv+eIoiSCgkxTd2MHct9sT9wSVneQJKKUDnPMBps5Tk1C9SuStO3KTd2AM3upng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMtMZUmwWRjZcfmxigSLp2kk2/qdEcBrj3/zeV8+AkY=;
 b=Jnty5Y6/DmFPgy03lSXrilMJPscUKoMDb73NYidC1KsVZG8mcui55SPtb7udqti6XDbLz378oZnkdLzMZdWQi+xIantdllguqwJ51LVUsoAxNwz6U5YcjkztFMgpa7Vpu5Ybe3Dc8Xevq6HV/lv0AlqF74Dkfu0qorsPsxtcrZt7yw3QgonYSAt4CsJTuFD//2b1xqB1SFv0pi6CUwY8mSoXR20OCUnQtSKcGWb5yFIzTIUkrU6lIRFoPhPrnN0x6hYpttmFpNZ+cf+tiZVIT6c0oVRTia8PiOx/sbFqf9YDlREoaGGOFEYaXMKRaVzO+jYBe1iHmzBKlxtuDs0KuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMtMZUmwWRjZcfmxigSLp2kk2/qdEcBrj3/zeV8+AkY=;
 b=EgzcVnxuyO1Xscg2q90gYh/hA/qJ4GGRhQteFAoryzdnk4QwQi2mez0iBslUrPUumdng6Yi3+nqdmpPyQAqNl/RJM5iNM1WxnvBbrqKPJhCvDiIVmq/zynmu7yaJzVztWOaDXh1HKTGhT243+UcgvXJ1Z4e6EmJ0wA5VdiNeG0I=
Received: from MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::6) by
 CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Fri, 12 Jan 2024 00:07:08 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::dc) by MW4P223CA0001.outlook.office365.com
 (2603:10b6:303:80::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Fri, 12 Jan 2024 00:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 00:07:08 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 18:07:04 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<eric.auger@redhat.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>, <pandoh@google.com>,
	<loganodell@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [RFCv2 PATCH 5/7] iommufd: Introduce data struct for AMD nested domain allocation
Date: Thu, 11 Jan 2024 18:06:44 -0600
Message-ID: <20240112000646.98001-6-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a9f63e-7b22-4c19-913b-08dc13026ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gpO5FXRXrtQIsAlaqWzte4ijTv48z739cRLDcFvhVaBKop3FjVqWhEWnBARXBdrGjBafasUBC9uX2vsZD/D2p648jquJDjqARc0ju1ucUvPqaurmkMMRAXB27pZFEkYBqZruessXsov/zqn6qzMEhjn3aMJ3DzQnxnr2Z272X4cgXN/WINP13i2kxTaNQQMPBM7ztajcHItsvGRRDIfH5SpRwwIrMj0JQsK/6SVdc9GVeIbFQyZTtLhDHvvRkGZZ0v9R0nVeLfV153gwC7e9z0JLKgzSXSR05KsCVCEnfDaCVxUmJnNHlBnp+YzEG4For2GzoqOXs+lv8nGQ+llR7+dUUPPCNL3VTLeco7KVjt1FHvJK8cWMEpQa4F2X1pXSAPeH5qoxytZxSuqHNvJIsY99G73yYrTj+ihtUl0uC1USm4x79/vfs7aLItSNQ3FmE3bUOQgDua5wukEMkz4LDoregw0lTdFCmhiyUz3HIVMF4HQJu1LVYKBa3jcdXEObKwahDiRjeCztqurXlIuLMdGMbMjTvOYi9vXZlFG/CQyal/fllN5ffaLx3scuLYJt1VxucvzmfqpDJqW7qcNCAoBFkuPLZZ4NH13DYdmnLh1qNk9rBYacnSbBWPd+HqW6KnOyvRx1FSWd7jazeos4Q+AYpjVjobgtrUhje2o6Z7+p6Xs+6KbIA5Xh2p207eHPqbpWi18isF4eXMJpbp6P9nzOujMZH4diGpEwVv2WevNPJoaO2cEejbU04fXFFl963oVVubhQza2L+UZu9msALwgidNanw4s2/9CGRQw8MxI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(6666004)(110136005)(54906003)(478600001)(316002)(70206006)(7696005)(70586007)(47076005)(8936002)(36860700001)(8676002)(2616005)(1076003)(26005)(336012)(4326008)(5660300002)(44832011)(7416002)(41300700001)(2906002)(36756003)(426003)(16526019)(82740400003)(356005)(81166007)(86362001)(40460700003)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:07:08.2457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a9f63e-7b22-4c19-913b-08dc13026ae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083

Introduce IOMMU_HWPT_DATA_AMD_V2 data type for AMD IOMMU v2 page table,
which is used for stage-1 in nested translation. The data structure
contains information necessary for setting up the AMD HW-vIOMMU support.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 include/uapi/linux/iommufd.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 9901b9f4abe2..b28ec5947571 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -389,14 +389,39 @@ struct iommu_hwpt_vtd_s1 {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_hwpt_amd_v2 - AMD IOMMU specific user-managed
+ *                            v2 I/O page table data
+ * @gcr3: GCR3 guest physical ddress
+ * @flags.glx: GCR3 table levels
+ * @flags.giov: GIOV mode
+ * @flags.guest_paging_mode: Guest v2 page table paging mode
+ * @flags.reserved : Must be 0
+ * @gdom_id: Guest domain ID
+ * @__reserved: Must be 0
+ */
+struct iommu_hwpt_amd_v2 {
+	__aligned_u64 gcr3;
+	struct {
+		__aligned_u64 glx  : 1,
+			      giov : 1,
+			      guest_paging_mode : 2,
+			      reserved : 60;
+	} flags;
+	__u32 gdom_id;
+	__u32 __reserved;
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
+ * @IOMMU_HWPT_DATA_AMD_V2: AMD IOMMUv2 page table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE,
 	IOMMU_HWPT_DATA_VTD_S1,
+	IOMMU_HWPT_DATA_AMD_V2,
 };
 
 /**
-- 
2.34.1


