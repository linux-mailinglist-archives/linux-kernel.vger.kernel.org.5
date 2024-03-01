Return-Path: <linux-kernel+bounces-88560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E986E36D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A81C1C225CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B72B9D5;
	Fri,  1 Mar 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lZA3Lzqd"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D11FDD;
	Fri,  1 Mar 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303888; cv=fail; b=H1y7LWfLoxXYyK2xtECOmuWyq7ZsI/Bj7/gvbdNWlCrsN5um7Vq7Nmmbpq/DrIl7wdhzo1xf/9Fajn1/F7IqzXMJA+BIEsyF3myDpvO0nZ52zmAgFhOhDYGM2LYETYKZopt3S0YDefIVe2H3DDRMMwdU7pW8rTXQttQi+YoePSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303888; c=relaxed/simple;
	bh=xv/CdOab1e9dWOCTvgOA3GJTjc4b4HVPqbW/o/wrRL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0dFKzIytzKkVm8UCzw0J7cmM6tvalE73uVztP0NNbgODy1Ky0LuY/UfGm6ymMhjHYfVR51PaxzLNcZXzwSeBO799eqFO1RLR34GHGLIferM7Npwh+RfeTLVdjowNUw6q1mo8W+UW4QYVAI43khwl4rz1L/6c/jUl8SwQ7GFzPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lZA3Lzqd; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BttJcVstw5DVlagofriT3itYjNzVR0kLp/rnWnOVf1wdOkbEf6wBe+L+zLPccLFUK+N/fI9OEezpYkPsmkHYmoJzbG2T/kKvBQhHslE+l+mJkFDcasymEzzviN2+ySHC2a3J2vrybsF3VkAG5H7PxQmR6BG9Tdr+GOooZB69QqC/VnBvFIQ4kNUJ5hUG81nlvSnTfTacg9CPAQq+VtttmRM2mBWrP8mHkqPhTgoxxh+iyxP+8oQaaTXUDVInCpnFi7VRcGI378HoKauEWhrfw7iOR+jcMAIz7CPEtSpCCG/vY4GHM1pSohELTdDMEgbjWciCQZBWc94DE7kOWflXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aZEPY3ieSA1Tv7iGt29eYe7UpRQpivq7wBuJUC6kVU=;
 b=bWeyQDo7Q5ku5oj5i9NofjMl3DZqWpKxeFWloOJ2xs3oN47KHVlCfR/UCir7/giG5xoiuRB6f7ipdXmB+35akr5HpTTlObgiXW4VKR6A7aMLzq+zQT7mCkduKmr6ixr7NrMVlD7M6Cz9sVQMcAY3b63hYIkZ+HHywzXlzas1lL95hzyzwNuvTRCWpbTtHa2+WY4I8VXvk+3kpn2pXE/GeLiGyGS0nVTXG1vcMhrdvcmAJ+OM5vs774Lzpqh40Xnfo4lDCoESW0TAXgHNXl4chFGC0WAcSy2CTtIDm/2PJDOJ6asYXS+Wm6sSlLEOriVRDFSA5VsvBQoWIw3XE++nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aZEPY3ieSA1Tv7iGt29eYe7UpRQpivq7wBuJUC6kVU=;
 b=lZA3LzqdsNX7+k1WZ/XDQ4CzAhcXeuQSKAMATh0kMrG05DfF/EWgcPc66AWUFY3EylqETkAc6ZKjmUNdWpVU4hryZpg6pzhqFvdqWpsdE3ts1mAm+aYLZjWB0nTSmdpSbL51AWhg4qxQKnfjQvx2L9RQLw7WR4+9ZNyy6hxnA1M=
Received: from SN1PR12CA0043.namprd12.prod.outlook.com (2603:10b6:802:20::14)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 14:38:04 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::8f) by SN1PR12CA0043.outlook.office365.com
 (2603:10b6:802:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Fri, 1 Mar 2024 14:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 1 Mar 2024 14:38:04 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 08:37:58 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, <sathyapriya.k@amd.com>,
	<naveenkrishna.chatradhi@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 1/3] RAS: Export helper to get ras_debugfs_dir
Date: Fri, 1 Mar 2024 08:37:46 -0600
Message-ID: <20240301143748.854090-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301143748.854090-1-yazen.ghannam@amd.com>
References: <20240301143748.854090-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 898bbab4-69e7-4393-73ec-08dc39fd343d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vAxkTZf/bg1QyYWRE9o1Ie8qnFwsyjN72Fp1DQibS+W1G4TjjVR6WAjk+Qiotb8IuoFFVzgqa5c4PTDdw1+ago2/L24civ2J7FtpgYThOAxARlmFo+NACLGKkN7//GAzSB8FZ9S5sRL5JgR7hP8CPxHQwqS82tRJXYrYZ3s1OWExoI2Wxh/rAcicMAyjrpBzqJr9wfzRUxJn7/3J8rQAxRtv5BGxxGE5m8MPpi1BXRK9y4BRgcM8Ku+yQDnogj87JhbKXI4XvBT9PyuYG0NG3C34pdNWARp2ziJfWgE0VMF0P6Ff1RbxfKkGDqwYCnPf0qxjZtYh/QkitV0gW0WrKid2htnSBNbgDZj49kgnJzyUq10RLyJuXzOhbe2O+tN1JQSXt6QJrafXijDLQmZKh6pvcsYPMzUxozd4WVDkAI7NCgtJ8SL9yov2RRLJjzOOJXE1bZ7KIRd2lo0F82ValwM+qBpLh6iy8JE406hWzChOggYrH3T8UqEQRxa7QyDlQKIkDWAkaWJWQfTzJITV+7sdkX7WYwJ+9JjygZi9kIL7r00MD4StQeHk4aCjKP8jUiyTH6gL+LxpROEyEnjcSR9zRjYh/sbgJ2iXnBdV0lAFyRSaVd0WJ0qNunudbIt+59Rf/P+DLkCpaLBOkWjIwWiBaG5mgI/EUxB98Oo2mLIDfxbt6Pudo0FGhXM4FhRYSndGw4yBSVcgY+ZQRyr+4A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:38:04.5094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898bbab4-69e7-4393-73ec-08dc39fd343d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

From: "Borislav Petkov (AMD)" <bp@alien8.de>

..so that RAS modules can use it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20240226152941.2615007-2-yazen.ghannam@amd.com

v1->v2:
* Replace with patch from Boris to export a function.
* Added commit message and authorship to patch from Boris.

 drivers/ras/cec.c     | 10 ++++++++--
 drivers/ras/debugfs.c |  8 +++++++-
 drivers/ras/debugfs.h |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 321af498ee11..e440b15fbabc 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -480,9 +480,15 @@ DEFINE_SHOW_ATTRIBUTE(array);
 
 static int __init create_debugfs_nodes(void)
 {
-	struct dentry *d, *pfn, *decay, *count, *array;
+	struct dentry *d, *pfn, *decay, *count, *array, *dfs;
 
-	d = debugfs_create_dir("cec", ras_debugfs_dir);
+	dfs = ras_get_debugfs_root();
+	if (!dfs) {
+		pr_warn("Error getting RAS debugfs root!\n");
+		return -1;
+	}
+
+	d = debugfs_create_dir("cec", dfs);
 	if (!d) {
 		pr_warn("Error creating cec debugfs node!\n");
 		return -1;
diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index ffb973c328e3..42afd3de68b2 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -3,10 +3,16 @@
 #include <linux/ras.h>
 #include "debugfs.h"
 
-struct dentry *ras_debugfs_dir;
+static struct dentry *ras_debugfs_dir;
 
 static atomic_t trace_count = ATOMIC_INIT(0);
 
+struct dentry *ras_get_debugfs_root(void)
+{
+	return ras_debugfs_dir;
+}
+EXPORT_SYMBOL_GPL(ras_get_debugfs_root);
+
 int ras_userspace_consumers(void)
 {
 	return atomic_read(&trace_count);
diff --git a/drivers/ras/debugfs.h b/drivers/ras/debugfs.h
index c07443b462ad..4749ccdeeba1 100644
--- a/drivers/ras/debugfs.h
+++ b/drivers/ras/debugfs.h
@@ -4,6 +4,6 @@
 
 #include <linux/debugfs.h>
 
-extern struct dentry *ras_debugfs_dir;
+struct dentry *ras_get_debugfs_root(void);
 
 #endif /* __RAS_DEBUGFS_H__ */
-- 
2.34.1


