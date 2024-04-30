Return-Path: <linux-kernel+bounces-164256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1BA8B7B69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EF91C229E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64E179203;
	Tue, 30 Apr 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sKArm3NB"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6F176FA4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490711; cv=fail; b=bLZjuz/eGhc58ntYatGGVvk3MjfGP4OywSDEsXrXkf/mvw1Ur+rwD+MMq+jUtwf7NTm8dMk//cSKmI9fnXKZGAW4WwOH9j/hOiK9UfpJIrnXLwiIzoQN+tyO5BVOy4ND/2TbUWI0GyWdzhQ4bKkNBBFZEqlJtLHc3b2sz1Y2kCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490711; c=relaxed/simple;
	bh=Lb+WDnFpBgqwn8lX9YxN+Pu5Tc8Y29Hz8fIrwZACUiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MP3ugyUScNzehMnKj2clqwCRMBcAyWg1xh4i5RXiWos+ZYpgI8aSC2Au7WcMna6yShHQFso6pA61Lm+dpVj0gO/CiulFDrRTQf3OgSfcpXLaMbTPLPLiO3at1HoGhvA9UMICCZULFPDr+Tc7KvxBz/esb7we3xzfbDCTe6CNrKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sKArm3NB; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+rdSouArhth/eUqf/srY3X4p7/vyknh9np0MPikZfZLEm50edVrrVBKow+S7FdDoUAb3oTxZqxTFnLbuVpC5dnHVT/o+zmOjvuzrPL3A8IEAenAp3jmV/i111Fvjf/XQed3jEH5/T8sFZr3nwHzMtr7UPeZkqJfUeUrfw1qGQFobhfYXB/fi9RM/nnK2Le5KPM1xd8SJ6h0mBT47wxd9B3/we2+v5UnBnyyiYpgaAdWNlfSeIPMDi5ZJmmnKFaZ65XxdD6heECNDpAa+gkGWOWtxE7g8c8JzjPzTNEOquvQEwtF2WnjZpqPcVnbjZuEpk5Jv2cwUZTCGdOb5Pyd9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9ujfRRjSsEgGwrp0xI/pon3AFBauUeQegzwV5o8fLA=;
 b=OvNH8pfPGdNFJekRuWMmrevY3sdF2KOl3TJ7EQOiA0Momr5sOfgWY2ykuVHDGEzAxqQySo+/7Zyz54QoNygl6ljmQ8+TD5gAbs9g2tdcwyGjeU3WFkhmZF5SicRYeZhB5Cj8JZcBKWCvoEJSlZCV/0JjGKjxRzNIKKF8v+F74U5rdgr435Q7N2ePHs5pFORqAl8u1FhgQ4vhpn3CFR9w4IU0kUZ3CUnp2mwUdpkj5uk7Ed50o+3FzeVy1hM6eptN7lVcHbJ3a1ylcJ4QlCbhFa89C9aUXjTKoyVLslEsjYBP/w+LmS1qFFiwmHU0MqGO71dqifWmOLNv/LZ08cd5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9ujfRRjSsEgGwrp0xI/pon3AFBauUeQegzwV5o8fLA=;
 b=sKArm3NBrV/0INSf6Shjx62QewQkoTUBj3qFQIWLcuZ/yRciDZeIVYSfVMDvGTl4Ut4fH9ECb/E2aP2gaw/Iqct7XHAqMyTtRy8Ug2mEasl6ScJONGkvIotEtQ0ytUnBj1XarFIVWmAIUm9+4Vi/+9ukCQlHjPQd/Pm4rMfKBac=
Received: from PH7PR13CA0002.namprd13.prod.outlook.com (2603:10b6:510:174::6)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 15:25:06 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::1e) by PH7PR13CA0002.outlook.office365.com
 (2603:10b6:510:174::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Tue, 30 Apr 2024 15:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:25:04 +0000
Received: from purico-e93dhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 10:24:59 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>, <michael.roth@amd.com>,
	<jon.grimm@amd.com>, <rientjes@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 7/9] iommu/amd: Remove iommu_alloc_4k_pages() helper function
Date: Tue, 30 Apr 2024 15:24:28 +0000
Message-ID: <20240430152430.4245-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc623ae-b4e9-484d-7418-08dc6929b5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sMCFGOb+3G1nsByoGOsSmHRUWl2iD7egxu4UyZLLxbQJN/YJpjh6Z+6sS/+9?=
 =?us-ascii?Q?uXWdfpciSh6EvJ1rL77x+z7oGNYcC+sjktTxn+R3kIy4ag9HpuO6anp0+5nk?=
 =?us-ascii?Q?cKMtAPa6iwbxogLANQqkrI6VPPJ4vu27rM+elQ7VkWP43VOaoveV0BMBC8Fu?=
 =?us-ascii?Q?kuJysgHdu+mOgQXwaljV9Ad35cU3yOZ4aS3jYKnS5yarp4gEfFzwkvatze1/?=
 =?us-ascii?Q?xzwU4J0NLT5AZVQQP5m3nB50wF3Iu2sUdqIzYNd5XXYOaL34A0tOmm0Z1WhZ?=
 =?us-ascii?Q?44G2yIi7g7dtRXKpv6IvXsbztl803mvBb6hycNSTxHx2B/+Z6/JoZl/0Sklm?=
 =?us-ascii?Q?QunwAF782sn6iuILIArv32t0t3JPoEpEqNbPvAvZPdyqjIGekdYdb9jJaO5v?=
 =?us-ascii?Q?lCDjfpnSe++3Q2nUG3iTCRFLMY0TGQDihkLhyDYwo7pCpDhPMxhb2lFMpSgj?=
 =?us-ascii?Q?2T2cuD/x8oQIem2c7O4iLMp3TnwXuU+qDHM35gxeC7UaOEcBz8uB69acAByF?=
 =?us-ascii?Q?c0C8BsZFM6rFYyxw7sR0hAyXa1uNvSdQCWBRoaPiCixAk3IkIh6scpF/pswC?=
 =?us-ascii?Q?yMvOryS3QnmIQvzwWAZDws77AVzVyG/tU073reIAbouYUdtmBA7woWKxAVPj?=
 =?us-ascii?Q?hFr4qAGD60z8BgHbHxcgWaZq5xEzS23TLezGFyq2JRgwpU4F3DckSWBCTcp6?=
 =?us-ascii?Q?/ZX0j5C38adJtQjbpVXsiFUHw6tgGca6i5+wEdIAqBiftW3hjsTnJhSWllx+?=
 =?us-ascii?Q?2GmIIoVTeiABbSq663Ws8VBCW1Mk2XvYMAbOBb872p5pQ++lzk+RX886Epm+?=
 =?us-ascii?Q?b91WYW5C+wq4bOSCi32aYVAxmXLEQ1yIzrrUyqvTIflk3hRiWXeQkp2BHYND?=
 =?us-ascii?Q?d28e43S54NXRGT2I88H/lK1nl6bjLauGRdQd89PyWXtbC4AKv5g1SL0PjBR0?=
 =?us-ascii?Q?YX4IPqe/c7P5vFVTM8YaBBCMSBD4GtbE3aqATHecuVYLSbDSQkyh46rKFZQY?=
 =?us-ascii?Q?GiWh306E+CzKK0Lh5Xxb66N57OTiVARZd9uiEDFkfTdbri67hoT2VZodpTEb?=
 =?us-ascii?Q?kkP53wMrAtdQafZBaKxVd0fNCX8+q6LDqdMWSpbJ28I7AxLi7WoDi0qSheLs?=
 =?us-ascii?Q?xNOkUhBGVmACKSi0z/2veLWXZGVSSjUXO7wBSxq9A87RWOUhjxth2jfXCZLN?=
 =?us-ascii?Q?R0kcj9flcJOxc0QqtUtwlj8GR8J+C2xZAcGw0KAJ5yUJzu4yH1X8QWJu0Fiv?=
 =?us-ascii?Q?RosDlnc7BFkZzvSlBuQHPZhaK163GA0QTZP5izVz/ADKEoZu65us8CVCIbSn?=
 =?us-ascii?Q?aPaLkO5rsd5G+Aq38uG17fuxUo13symE4qyVnjcHdLYl67SCWErFBh+7YkJ2?=
 =?us-ascii?Q?SzqBl+0JYDCTZITZUom8AoV0s3Hj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:25:04.6470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc623ae-b4e9-484d-7418-08dc6929b5fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309

Since it is replaced with the amd_iommu_get_zeroed_mem().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 --
 drivers/iommu/amd/init.c      | 16 ----------------
 2 files changed, 18 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index ccd9003813ac..1ca7e1e389c4 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -25,8 +25,6 @@ void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
 void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
-void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
-				  gfp_t gfp, size_t size);
 
 void *amd_iommu_get_zeroed_mem(gfp_t gfp_mask, struct amd_iommu_mem *mem);
 void *amd_iommu_get_zeroed_mem_node(int nid, gfp_t gfp_mask,
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b62d4c806155..1b74a31b4337 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -841,22 +841,6 @@ static void __init free_command_buffer(struct amd_iommu *iommu)
 	amd_iommu_free_mem(&iommu->cmd_buf_mem);
 }
 
-void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu, gfp_t gfp,
-				  size_t size)
-{
-	int order = get_order(size);
-	void *buf = iommu_alloc_pages(gfp, order);
-
-	if (buf &&
-	    check_feature(FEATURE_SNP) &&
-	    set_memory_4k((unsigned long)buf, (1 << order))) {
-		iommu_free_pages(buf, order);
-		buf = NULL;
-	}
-
-	return buf;
-}
-
 /* allocates the memory where the IOMMU will log its events to */
 static int __init alloc_event_buffer(struct amd_iommu *iommu)
 {
-- 
2.34.1


