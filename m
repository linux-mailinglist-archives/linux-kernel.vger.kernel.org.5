Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9A87CC619
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344069AbjJQOnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjJQOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:43:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A12BA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkP54UIrXU1/Kn+3YNiWSBi2ZYT0qpKzbtQvUITGqJvI8VrkLN2HpZCiAp9zfdmltRELWcyuGcA2SRZWqr8HQtgtx/7Dmx0ATYNUrTeLuUP3UH7YH09Bti1McFFLwHRfBB8rM7cOw5rBrhrAcaqgu4PGceseGgN8y0yJq8JY9yP8tc3JGPjwfH2lxdF2ToaxFyc0NDqxVIAfzsMN+0Y9Q0bugHnbmU81VcWzi0zhuW441gCuLNCSU2LsAwfXFPCP9j22TI5eFev269LR4SHtmDFb2acKulQI2++BAmdn4BllkHNEXiSLdoWul9Xgejc6eFJqUj2eAKCf9pZf/Ttjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvqNF/Z00hPImL77gykfZBxIqcjrMKj4qye6DdddhBs=;
 b=oTlB9qv8SkbNewdlopv4wIC4Wa9hQAE9jaqbNj6EHjcLR10VnZDnxV5CXiv057ImGN8mHJS8LxKUfJkgyhYjb/EQ51aitzQYlJg/+yPxCCAkEoh7yxcuUwkKehx4JlpYzAGQuoit3T4boeWa5U4fQp4GpfKPCc9xnverXis+HDESgm5oPL0eFpP1omYW5WJIXSWtD/SUsNJmFDOmvkHCo6aQmKgitPWOVkq8wo+MjPPfu4VKh4ridVnycL/YsxL3mSShe8LApUW8XSIW31tItHh2NM4mAWnTdkMDaxDWcIjQYufz6w3ipWxdkUfkau/VJAcX3/gU5kSKsElcQRCU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvqNF/Z00hPImL77gykfZBxIqcjrMKj4qye6DdddhBs=;
 b=o3bdd0y8mXzv8P++8VasMV+tU99grOougeF5+mXHt4SeVT6+aj2hjdO/mzX/oRIxj8nTdjE9SvGb+4U+oP+/WFqKkakZmcc/H8d2RjB6Y/etuD7WMnz3/8u9wVmop6tNGLIflqpFLRqoZ1883HwzZ0FVBLgo766FGySoq2K7H4I=
Received: from SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 14:43:05 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::97) by SN7PR04CA0165.outlook.office365.com
 (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 14:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 14:43:05 +0000
Received: from ruby-95f9host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 09:43:04 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <mlevitsk@redhat.com>, <seanjc@google.com>,
        <vasant.hegde@amd.com>, <jon.grimm@amd.com>,
        <santosh.shukla@amd.com>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Do not flush IRTE when only updating isRun and destination fields
Date:   Tue, 17 Oct 2023 09:42:36 -0500
Message-ID: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MN2PR12MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3963d8-eff9-420e-7711-08dbcf1f5f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PsTMrDY3YCztXSQyCKk821fAt7/QieMbcHhMrFRf936zQOP4tDgWus8OJsZIVhXxulQznqr1VVmBAld3zqletgp/1MXYD3/h7lBN/XMiwLNB+MICC2c76hJtRmE4YKYeNVKNMOIPzS4E4OQzThDB0/VVb0ASYqHnoqdee4dG7MIZV+mNpgCneU9ZCl3Zr4VJGSS9EyAr/rZDdx6NazkyQ9hUbWhDIoW+FGWy+zMnq9+LvictuOyfRaZt7cCIBkF4rV+kU1bWThS1o2pWrA32UMVDnAzswPpNlWDlqpFA2E5Ty6OiMDWYbOK/4ZMvQnonLqVq5PNnCz7ZnxZk07BdWoFTU/wkiIjHMV2lXPnOCwPnCN+5xGogYs2toAPAiwb+LezaV/LXdExAH5DkDod6BB+v/exZGkOlPj2/8yGzRllXHMaoPSE/ZvHU9KSMM8W2k/C9RT2Vq1VhgI9HH8vB0E/sgJI8YwF/WUxcoEv6GXRcSWH5i0IQs7+HEkLR9+dqVik1pspQLssOdeqPZPD4AV8ftq9pQWpETn5/yJPX/YI3iJvt8DsW9xv697dpzC95Xn0qkSJSQ0ZSsU39c5vj83TXOtuoZgwqvsASFFR98a1P7Sy7WKJEJeZ+neB2iiF4fbPs58Fpk9brwWIKOTu0J7B2WmUWrbKht1mGmLhzjnK8E2+MCP82NQ9+RcOmxV2LDUMdzAO70GsXhP2p2lmtTWoUlgSjtWYSy8xgPlhpoAePqxAKS3aKqwZenMEglc3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(41300700001)(44832011)(36860700001)(47076005)(7696005)(5660300002)(83380400001)(8936002)(4326008)(8676002)(2906002)(70586007)(70206006)(36756003)(356005)(316002)(336012)(110136005)(54906003)(426003)(1076003)(2616005)(81166007)(40480700001)(16526019)(82740400003)(26005)(40460700003)(966005)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 14:43:05.4115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3963d8-eff9-420e-7711-08dbcf1f5f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the recent update in the AMD IOMMU spec [1], the IsRun and
Destination fields of the Interrupt Remapping Table Entry (IRTE) are not
cached by the IOMMU hardware.

Therefore, do not issue the INVALIDATE_INTERRUPT_TABLE command when
updating IRTE[IsRun] and IRTE[Destination] when IRTE[GuestMode]=1, which
should help improve IOMMU AVIC/x2AVIC performance.

References:
[1] AMD IOMMU Spec Revision (Rev 3.08-PUB)
(Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)

Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 089886485895..d63590563d3e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2970,8 +2970,8 @@ static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
 	return index;
 }
 
-static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
-			  struct irte_ga *irte)
+static int __modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
+			    struct irte_ga *irte)
 {
 	struct irq_remap_table *table;
 	struct irte_ga *entry;
@@ -2998,6 +2998,18 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 
 	raw_spin_unlock_irqrestore(&table->lock, flags);
 
+	return 0;
+}
+
+static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
+			  struct irte_ga *irte)
+{
+	bool ret;
+
+	ret = __modify_irte_ga(iommu, devid, index, irte);
+	if (ret)
+		return ret;
+
 	iommu_flush_irt_and_complete(iommu, devid);
 
 	return 0;
@@ -3681,8 +3693,8 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	}
 	entry->lo.fields_vapic.is_run = is_run;
 
-	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
-			      ir_data->irq_2_irte.index, entry);
+	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
+				ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 #endif
-- 
2.34.1

