Return-Path: <linux-kernel+bounces-164251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5538B7B63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93735285C01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C96143751;
	Tue, 30 Apr 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XvdJoeXN"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530014373F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490703; cv=fail; b=ERvwarLgFQ1USCKRD3rkkFv/CeLhLEInjADVPza7rHhIUZCMVNciT0pd1kVwQmlrw07qxSA3jtHWWS8zYs2vsxLgk8WlRVuroERKmws7/0sQ3dfr05odNBG+gO/19GTpSNoMQZN6KDrryOvcxzmAua99QLYBQaAaso8gE+V9DEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490703; c=relaxed/simple;
	bh=u0kbh+G26XjoIWmR3j8+BoMComzbFeubj3wXzEQDhrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc6frGgm/3VxdEWRW91bN921W7nvQIQWwMk4S8Euc9I0NV3HWHs89UIwB9IRpq5rnQBaj8Hqa4y2x4GUfBoUghKJFl4L45m24S56OXJGKeqk4hxtfuq/DZFtLxa9i6iVIUq832sUdoCz6wbSfiKS9fhl58GnxUHq4mKmqzJX6wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XvdJoeXN; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVct5jbO6YODUFDQaWW31A2XW1UX3HSXULJhrbb+GBVy3nFfGeRQXLp3ojbE5SSOn2/pr7yCZmSODiglbakAx1zP+ksWcTfjIOEQeE353cAkOcQL0S1eI0L9Z7rRfuGw8LIk05iNOEfIFYOS5gx95I2qRSren9W4cwmTYLAbxS2OC+Z3mMEXecuUUDXP19EM8qD/GnP8g6BAeobRy3rJCISgDA0ApckAfbgMRkUprjS4NOufVSnoxvNZ22X5zaqN7yB3vyPgNynmxZHmzLJh2slamdTJ8dSxWdGey3msR7RX2QkOkFuUdFYzrMdLn4ZqCLim0CwmyiDJX6073erXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=165H4ek7b0kbb1fcqy330nd/jgL1n30mBdRwFSpXITg=;
 b=ItzyyLcZbP9OK4o1sOLO4vz2s9RyxYCHvW9t1q1EBEGY1az4HkKEeRhTIMX2Y0Mi4YMVKzkUl/4mfw+7zTuMWlZ+y/iz59L2P+QTtXSy/uJXlmDtMeK+2qXp7/QE6IEIylEslInLqt2auKHp0reEztYu1uGXNFqdqNlYN1t6tLvZZSKa4FGFUs//5IC8Q0iv2o4OFfZNV3qvCtnu4/KxZyFoHYR34RrIvqLKnZLP+O/lAysxmzXqqT4UeVuqsBtdJAPt3qEvwz0oH+3Q5xlRLIIFzw1+lwQcU+4R+QGKCPs/7qrP5G4/lhREzPCtar4h9tYNt9uaCWxUQLcRoWBYgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=165H4ek7b0kbb1fcqy330nd/jgL1n30mBdRwFSpXITg=;
 b=XvdJoeXNWpPS/l3QZGwpb7D9eIjQ/TsiSSpFV3vvv4M1l2HECvAmbXb/s0HUul+KyKzrEgxuGruHNIhfxtVqN6nGyzPJaa6J3iPlXjk5rXwkbVoAwNBNOyKgpuS0aUgV3ugArvZWqRZOBhPLUwQYSgpZ5SwtGUkWoAY6KO4iqKE=
Received: from PH7PR13CA0005.namprd13.prod.outlook.com (2603:10b6:510:174::8)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 15:24:58 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::b) by PH7PR13CA0005.outlook.office365.com
 (2603:10b6:510:174::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Tue, 30 Apr 2024 15:24:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:24:58 +0000
Received: from purico-e93dhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 10:24:56 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>, <michael.roth@amd.com>,
	<jon.grimm@amd.com>, <rientjes@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/9] iommu/amd: Introduce helper functions for managing IOMMU memory
Date: Tue, 30 Apr 2024 15:24:22 +0000
Message-ID: <20240430152430.4245-2-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 75aed927-eed0-481b-17ef-08dc6929b213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ucbwXUg5svtMBVwpvUwcfXDjKySbmTSo8KhkZMG34FqpVzqWnWd/iJr4S6Cy?=
 =?us-ascii?Q?/DZNuPVExCM59yFUC/vIR+rtpKF6L6POhxGU5Mg9PoOWNXciVHRiSHaeGIPX?=
 =?us-ascii?Q?TZ7X3lMmXaNO9e42i8Bo8GrVJjO14fNKo5D+rjOcJPHf81g8UJcBN5dKnzfX?=
 =?us-ascii?Q?pLDpTBgjQKIX4t31zlvVNhMfwfie3UcTZRtdjN72KwHwixP1/eYa8BWmEzO5?=
 =?us-ascii?Q?hMRBALH299Z7E43l9fbEQnE2WhTdZIl2FIEtTO8JsAm+S5xV/4GuCP2Gq6Bi?=
 =?us-ascii?Q?ivegB+P+hWp4WXuC8auXaqZp/1FM+tBMgDXvYe8+8gqQE0g6VPHodT8i3xHb?=
 =?us-ascii?Q?U6x9c7RtUIli0wwfjAyxTTNTX0bXuMvoilb0qyL3KLdgHynhM+XOpbPK1Ytw?=
 =?us-ascii?Q?S2FRc7GpQs6CmtgA/UK/Xq40acewZ4d8E22Id112l6x5I9UQLlZMpyvmEYWR?=
 =?us-ascii?Q?4BMBs9gNzjJjqcSW/fWRysj+XJxHw0O9RpIUjyr4y9T+XKgxWM5QANAsndkr?=
 =?us-ascii?Q?xMM/R0zDEb80BlJ3y3vob9SnTbDjBhJFmbWeTIk/kBbrZvTdEiwrKRUDka7M?=
 =?us-ascii?Q?ML0adegVyR4rwNPMxd/1UrFTpAb4JNpNAngeDY52RfkvCBuFcjAtlnZZvvCU?=
 =?us-ascii?Q?OOuvUd/lYacoT/r3sFgVmZ9ZkjsOC8Vi545c9f/pE6NkhvCnnemIl7m72uuV?=
 =?us-ascii?Q?QNpyAfOqtyi9Y0UgWgM1ru5aN/649OCcJ9zFi94K7S+TOuPVSA8AO4wUl3Zi?=
 =?us-ascii?Q?6pTO0E1fcL59KMLVjlPALp917hXBtwleHugOqv1dZOeJiEqARbeqkS/YQ5Yh?=
 =?us-ascii?Q?xViOs+Kai9Tqy1DOxfcUNpdMKoZbpDWY3r6LGR5yGeNqeFF7zydrcqJn6URr?=
 =?us-ascii?Q?dO4lXN9e9qb2b9aY0HQHyUufvcXNy+ZkaVPgWiOKjgZ8tiHMRgeY7UBPtymK?=
 =?us-ascii?Q?xor1BfGmNs2vpsxwkqYAe3yKBIQzCBqB2jDPvbkYHLg+glV66hri3ITxy5fu?=
 =?us-ascii?Q?sb5Oov754VowfxqR0jioUsia+F5stfL/+So5jluzrvHWhNBaeU7+A+mv9sRo?=
 =?us-ascii?Q?cm3bhZ284nG9chMrEFZrzUYVpUcqD+RHq0FSGbPBlQKg9G2OWEmEeEhHI5U4?=
 =?us-ascii?Q?nTBaTtMlUVv+lsG5agLPWnOSXqax+8sKBpMprNiNvVUbnaCJpmLN06dlfmoY?=
 =?us-ascii?Q?/vPIRW+YFqcdKm4t5EAd3wRupRDm5rCz+x+JqgnIQWZ2az69bVzu1r6I8OSA?=
 =?us-ascii?Q?z33JK7wVA2AxdSJgyBJOeNM1YSn6KeG9f01ny5V0DczVjZIaZ7egrYluH4Li?=
 =?us-ascii?Q?q+K9+/Clzf9d+aZNc5OzmZqjjTR5TwldjB6ZWLzGAQLIsTVurbnbnZFRuLwP?=
 =?us-ascii?Q?h1CHyB1MEGQuXF1bJbHFF2AWTSQl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:24:58.1001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75aed927-eed0-481b-17ef-08dc6929b213
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082

Depending on the modes of operation, certain AMD IOMMU data structures are
allocated with constraints. For example:

 * Some buffers must be 4K-aligned when running in SNP-enabled host

 * To support AMD IOMMU emulation in an SEV guest, some data structures
   cannot be encrypted so that the VMM can access the memory successfully.

Introduce struct amd_iommu_mem along with helper functions to allocate and
free memory areas based on the modes of operation. Initially, two modes
are supported :

1. 4K-aligned mode: Required when running on SNP-enabled host system.
Note that this mode replaces the iommu_alloc_4k_pages().

2. SEV-guest shared mode: Set memory as shared when in an SEV guest.
Note that the memory encryption bit of the GPA must be cleared when
programming into the guest base address MMIO register field of
these buffers.

Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 29 +++++++++++++
 drivers/iommu/amd/amd_iommu_types.h | 15 +++++++
 drivers/iommu/amd/iommu.c           | 66 +++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2fde1302a584..ccd9003813ac 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -28,6 +28,11 @@ void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
 
+void *amd_iommu_get_zeroed_mem(gfp_t gfp_mask, struct amd_iommu_mem *mem);
+void *amd_iommu_get_zeroed_mem_node(int nid, gfp_t gfp_mask,
+				    struct amd_iommu_mem *mem);
+void amd_iommu_free_mem(struct amd_iommu_mem *mem);
+
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
 #else
@@ -137,6 +142,30 @@ static inline u64 iommu_virt_to_phys(void *vaddr)
 	return (u64)__sme_set(virt_to_phys(vaddr));
 }
 
+static inline bool amd_iommu_mem_is_decrypted(struct amd_iommu_mem *mem)
+{
+	return (mem->modes & ALLOC_MODE_GUEST_MEM_DECRYPT);
+}
+
+static inline bool amd_iommu_mem_is_4k(struct amd_iommu_mem *mem)
+{
+	return (mem->modes & ALLOC_MODE_4K);
+}
+
+static inline u64 amd_iommu_mem_to_phys(struct amd_iommu_mem *mem)
+{
+	/*
+	 * Return physical address without the encryption bit for data
+	 * structures allocated with the flag ALLOC_MODE_GUEST_MEM_DECRYPT
+	 * when running in SEV guest.
+	 */
+	if (amd_iommu_mem_is_decrypted(mem) &&
+	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return (u64)virt_to_phys(mem->buf);
+
+	return iommu_virt_to_phys(mem->buf);
+}
+
 static inline void *iommu_phys_to_virt(unsigned long paddr)
 {
 	return phys_to_virt(__sme_clr(paddr));
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 2b76b5dedc1d..a42e10777922 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -479,6 +479,21 @@ extern bool amd_iommu_np_cache;
 /* Only true if all IOMMUs support device IOTLBs */
 extern bool amd_iommu_iotlb_sup;
 
+/*
+ * Allocation modes for struct amd_iommu_mem.
+ */
+
+/* Allocate memory as 4K-aligned mode */
+#define ALLOC_MODE_4K			BIT(0)
+/* Allocate memory as decrypted mode (for SEV guest) */
+#define ALLOC_MODE_GUEST_MEM_DECRYPT	BIT(1)
+
+struct amd_iommu_mem {
+	void *buf;
+	int order;
+	u32 modes;
+};
+
 struct irq_remap_table {
 	raw_spinlock_t lock;
 	unsigned min_index;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1fdf37e04215..05e967ad7032 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -37,6 +37,7 @@
 #include <asm/iommu.h>
 #include <asm/gart.h>
 #include <asm/dma.h>
+#include <asm/set_memory.h>
 #include <uapi/linux/iommufd.h>
 
 #include "amd_iommu.h"
@@ -574,6 +575,71 @@ static void amd_iommu_uninit_device(struct device *dev)
 	 */
 }
 
+void amd_iommu_free_mem(struct amd_iommu_mem *mem)
+{
+	int ret;
+	unsigned long addr = (unsigned long)mem->buf;
+
+	if (amd_iommu_mem_is_decrypted(mem) &&
+	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		ret = set_memory_encrypted(addr, 1 << mem->order);
+		if (ret) {
+			pr_warn("%s: Fail to set memory encrypted (ret=%d)\n",
+				__func__, ret);
+			return;
+		}
+	}
+
+	iommu_free_pages(mem->buf, mem->order);
+	mem->buf = NULL;
+}
+
+void *amd_iommu_get_zeroed_mem_node(int nid, gfp_t gfp_mask, struct amd_iommu_mem *mem)
+{
+	int ret;
+	unsigned long addr;
+	int numpages = (1 << mem->order);
+
+	mem->buf = iommu_alloc_pages_node(nid, gfp_mask, mem->order);
+	if (!mem->buf)
+		return NULL;
+
+	addr = (unsigned long)mem->buf;
+
+	/* Allocate SEV guest memory as decrypted */
+	if (amd_iommu_mem_is_decrypted(mem) &&
+	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		ret = set_memory_decrypted(addr, numpages);
+		if (ret) {
+			pr_warn("%s: Fail to set memory decrypted (ret=%d)\n",
+				__func__, ret);
+			goto out_free;
+		}
+	}
+
+	/* Allocate memory as 4K-aligned on SNP-enabled system. */
+	if (amd_iommu_mem_is_4k(mem) &&
+	    check_feature(FEATURE_SNP)) {
+		ret = set_memory_4k(addr, numpages);
+		if (ret) {
+			pr_warn("%s: Fail to set memory 4K(ret=%d)\n",
+				__func__, ret);
+			goto out_free;
+		}
+	}
+
+	return mem->buf;
+
+out_free:
+	amd_iommu_free_mem(mem);
+	return NULL;
+}
+
+void *amd_iommu_get_zeroed_mem(gfp_t gfp_mask, struct amd_iommu_mem *mem)
+{
+	return amd_iommu_get_zeroed_mem_node(NUMA_NO_NODE, gfp_mask, mem);
+}
+
 /****************************************************************************
  *
  * Interrupt handling functions
-- 
2.34.1


