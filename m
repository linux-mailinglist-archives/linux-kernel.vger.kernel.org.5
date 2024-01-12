Return-Path: <linux-kernel+bounces-24165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E382B875
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014D9283F61
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACAA2908;
	Fri, 12 Jan 2024 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SP6mNu3T"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD22ED5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTlsB8BWDBQgJI6AUcyv0AvWDaRn0tsy7Rspr9OUN0z1qyZ8Mkl1JcYb9Y5LyYQY6LjZ11pt03YtGJVtCg1ppSK4enVxq6BqgOu/0z3NkXmtn9Kt1dksFCtkk4tR4MW/ZXCNBDLy91zBC9Y0T4OO0NFvybd+ztOQRzaiG/t1o+brA/1T9v+xmsc0V3dzqFhRS1KfXHFeyhYNirJCOXCOiQn/JKdXHoVx5WEMgXOD3syDwa3j1zkRa/u2+4RdyMW8lUPLw7vdBrGPA7mp9jK0Vr8+w1WUXYGqJ5rIQ0eQQxizBGM63jv4aPoTcI9xk41iHRFMZAulBIoUXs4mGgD8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//YdT+7tyguq7bE9Z/ENbW5plhkXZTzu8xe/E/1DUDA=;
 b=lcbLxVwMH5rpSbB9aFEM4qWWqh7emxwxqCaEWGfLHQ5SeWTq+I2zDsc9NewDONwN90WZVIj6cUAC7dknZrXq+ooasl6yho3sG5koP85CBYVBaUTH+bbAOiwp7ZX47JW7NgG5OL3/jlgo2uo2Hcqj9Pw5J1b0c5tpeVY+2+v+6F2xrjsAS2HZ/3H9zY6J5sDzharrpcXuF/jfFgzp8ZBnPGclHJqzyYAJbcl/0dxUKGUaCqcZZ1+HB8ejvB3eRX1wZErMBSMD45LIzN4FR4lMNOQbHOtJP4gYLPiIIn6feTi8Ik2XcK960GdRyrYswOuIbo1oPvNIx4oKuhow3S6P0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//YdT+7tyguq7bE9Z/ENbW5plhkXZTzu8xe/E/1DUDA=;
 b=SP6mNu3TBnUplY3SRGRmAaKpiRQO4e7D6h7qLxeqnAOepoqTBY4B+tldymvcFkKHka41z8YwSyeSScF/oPwD0+oq5in3R7cSb8ltJB7W1FZjg6xVilJwTWQb2+hy2jqc0sFdI03xA3SO+7Xw2csdirQ2e8/03cxblq6DWQsj8dU=
Received: from MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::8) by
 PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 00:07:04 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::1c) by MW4P223CA0003.outlook.office365.com
 (2603:10b6:303:80::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Fri, 12 Jan 2024 00:07:04 +0000
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
 2024 18:07:01 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<eric.auger@redhat.com>, <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>, <pandoh@google.com>,
	<loganodell@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [RFCv2 PATCH 1/7] iommu/amd: Introduce struct gcr3_tbl_info.giov
Date: Thu, 11 Jan 2024 18:06:40 -0600
Message-ID: <20240112000646.98001-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 178e9bbb-2145-4c80-3818-08dc13026861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AVBuLjj4Z+v8vaFY9p0Tgc7p+1OQ69LTDK1DrS7COoTXXgb4HinaZ6VSHJM29i5iyWm2X3s8L1Q/weAGYRUTUyYiS5NJLx1g7C0yisOi3hm1KhxHGdfNzP6mJ4YPpbrjfGklyImutClvgUjwihXIZuwhbYwzEOzOUyeYIANVu02xAyQriqwG6XPmnfjDMmrvknsVnnwv5kcPTZ58ZHJZQB/x68H71EcmpoQrx+PMXpKx/gdzETWfO9wu0pGQWJV81ecYb/9MHGW9xf8lRoWiPsqktZ6n813a9XuO4a7UKPgwcVJoV/thujKDUB/eu8uFwipzjOPvrgExOT4NDmR2Qhp/i9OEfh3QYXeFeIn3rrm01HVDQIXyhiiu4SiQArYqowSMwAdyHLJtz+tZksDWriqlpM5bzmnlQ9LmHhcwHxey8TEg2iEtO2sxVkwomRu61bRl1XifLKxf/Sgxni/L9OIOJ2K3FwQXbU09+iYHV2Gqj6vwlm4hYuenIidvBkVZfvttsQiabCXZZq777PArowN3+Xu3E49jYJnDjpBkz6XmTTN3jEfXvmNy0IS5ni8xXR6uUM0i/Gpf8txZ8tVK+ankQoMQVRIKQCmLYa7MB3B+yx5M9FdWtkD2AakL80KcfkxUtl3tGYcavmIoKSYcKtZPLt3fcWtaBKqolL+9Iy7iyN1U4H6FMGwt+HOYT5kb52faBNVqHLs3y0HbJ+PxFp+tGijjvGoSQ7W/ccqqeYlHnGQ9Mry8gdh0lAsmZMviR4Qf67vn6QeyrtkkeEqy3SJarQGKG4vU3unUzmxC/Tw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(47076005)(110136005)(81166007)(36756003)(356005)(86362001)(36860700001)(8676002)(4326008)(82740400003)(83380400001)(1076003)(2616005)(336012)(26005)(5660300002)(426003)(16526019)(54906003)(478600001)(6666004)(316002)(70586007)(70206006)(41300700001)(7416002)(2906002)(8936002)(44832011)(7696005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:07:04.0425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 178e9bbb-2145-4c80-3818-08dc13026861
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049

To track DTE[GIOV] programming during IOMMU domain attach, also add logic
to determine if the GIOV is required, and set the variable accordinglly.

This is also a preparation for adding nested domain support, where the GIOV
setting is determined by the child domain.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3dc39bbc05fc..ff56c857f6ad 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -536,6 +536,7 @@ struct gcr3_tbl_info {
 	u64	*gcr3_tbl;	/* Guest CR3 table */
 	int	glx;		/* Number of levels for GCR3 table */
 	u32	pasid_cnt;	/* Track attached PASIDs */
+	bool	giov;		/* Track DTE[GIOV] */
 };
 
 struct amd_io_pgtable {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4e4ff1550cf3..b9759f6d8be2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1990,8 +1990,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
 		}
 
-		/* GIOV is supported with V2 page table mode only */
-		if (pdom_is_v2_pgtbl_mode(domain))
+		if (gcr3_info->giov)
 			pte_root |= DTE_FLAG_GIOV;
 	}
 
@@ -2067,6 +2066,14 @@ static int do_attach(struct iommu_dev_data *dev_data,
 			free_gcr3_table(dev_data);
 			return ret;
 		}
+
+		/*
+		 * GIOV is required for PD_MODE_V2 because we need
+		 * to support the case where the end-point device
+		 * does not have PASID in the TLP prefix when setting
+		 * up to use the v2 table.
+		 */
+		dev_data->gcr3_info.giov = true;
 	}
 
 	/* Update device table */
-- 
2.34.1


