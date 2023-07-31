Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B29076A0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjGaSvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGaSva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:51:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C850139
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VG8rf0n+dDcFRTK6oiAMrBwsuho6UHW9okfNN2GUnzDxy89SZxeEvdnYUCaG4QmpZJBYtWUVhZGsyTw3xfpVOAFpP7yRpVDA99YwgSg25n6MQ4JHdRMj7gMLtFBTQQe//t1IJDDD2JY7uQe59LBSdlou+AYw1ywiV71AE+ioXuOgY7hG2HkSgLq7NJy01IpY0LbIOYxEg+IBaBFZ84JM6O89JLQMB3GdzrNr4zIHN+frpSLeCDdCsy/i98NZ+Czbcs+/AHMerN3+lCO95UBnuT+6iqzPKgfERpLOjHtGRzQm/nNiIYmupfEvmTn5AGOJnj4KFHgbxUQcBRCem4GThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYgDZ5EGiEGzhLj7qJy1EWjkjXCeQLYU5vdMyEi+I6Q=;
 b=JQphs4QklVal61g9NefOAVsueyOrUYCyaV8s08YfdFBwS1N3cyTZF4fc20VCJowOxIKrHMxkMhBfNdEiQKAF9eFblT59oKWTR4XtUmPnESziAwT9CrZBL/4TL6lvB8VsjtArwCdcfcucdXPIk9u7PwuD9Xsg2EgOO6eD3QqYCEIMXIKjJJ/f0Ywu+ocqx3BbdDn7bCefnrC89JDysnf530021nLkjITiqirPqGIKPVnd2iVXWCXsdZVhsgSTDOaE/YNBKM18rXR+SCJNug7h9IiQ8rk8skb8uFsEagc8IhHctei58BVWZvWsSsYztY7V/yEyGSpxfuSPqKY4cXBcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYgDZ5EGiEGzhLj7qJy1EWjkjXCeQLYU5vdMyEi+I6Q=;
 b=MhlfREo/s5fl0f/q2W84mWZvFsarGFCexl8/SpZzInFNZ6QNM5xPPSRCPPpdWoj52FOW+QLoAI9Fnn9QHUdFrxwHpOsbU+X86G/+9zdGauxU3mvju3dCEW6coZH7MnY4srvIlPX8Ucj8uNtPilHkMwMf/9ba80zmFrvoJRpZQYo=
Received: from DM6PR14CA0057.namprd14.prod.outlook.com (2603:10b6:5:18f::34)
 by MW3PR12MB4505.namprd12.prod.outlook.com (2603:10b6:303:5a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 18:51:25 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::e3) by DM6PR14CA0057.outlook.office365.com
 (2603:10b6:5:18f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43 via Frontend
 Transport; Mon, 31 Jul 2023 18:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.42 via Frontend Transport; Mon, 31 Jul 2023 18:51:25 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 13:51:24 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nilskruse97@gmail.com>, <git@augustwikerfors.se>,
        <David.Chang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] nvme: Don't fail to resume if NSIDs change
Date:   Mon, 31 Jul 2023 13:51:03 -0500
Message-ID: <20230731185103.18436-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|MW3PR12MB4505:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d11281-6ad9-49b1-2d01-08db91f7244f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AD5J/SmsOLHTrri96mm4wzrns+F20g63RBtZthFWlCpvapsupIQTBrzgyYWhJI84fzRjQDvpJCgyibx59s6eabWRJEVZTXgCPFewK+mXkzNsIeykQlN1w3M7Io6xbwzG4rrzzY0yZuh4M2fzB/IKATdgFpcMNqksSaetuChycviUZo2ib48lfPLP22uQ9PhOxrxeNPl7zKU/rU63SW40PvQooz1XNsU7yC1Vwct+6UkiOy4U1+GT8jyh/hqbQZvfbRlc5fsJhhm3BebSYnXwbfNoh5xN8uuwahErIaFP35o+89x9aQRJU6aRHxvVZpiWHUgeBNOc65MVkI/9vH5qpeHSayoRcDCREyO7R92z0NHofbkugh8KVTW7T/nVZPQ1VMMMu7/TfF8HQBuoOxIy9tUautsVNN3JA+3DLhHcX9cYFM/eTTn+h1utfCe9VHKdBMlEAx1sOy44pTX6zgqek0+eWqZ2VG+hsobeV827YHWRop0wL4cOxsjaHzV37MZ5qIlwfIQEnCReWC1fQNyGTqPcn1DhJ8Z2DJn85QeXxdujSSkvBAO640fuFObN0mbyBXlVAw0DAFjFUppDNqul8AvR+nEbpSaDBYVj/uLUqETyInHfLZbjo6R70MkJIwl7fGmu77+cPYRD9om37cwiFNmRBnK7n4muZnwiNtq8OPcNjT+IB0UwgVQSIkfBVe5Xt7VJ4ERTZXAagnr1pHj6mbgwgdElxFh2MPDMDsDCKzHxFZX/d/KOyE0ENTIS9B8fCbF1/+VXYQL2QwIW281jvGCiNK5ReSUyMFiw7Q6iKCY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(2616005)(5660300002)(426003)(8936002)(336012)(16526019)(8676002)(1076003)(316002)(36860700001)(83380400001)(26005)(47076005)(44832011)(186003)(478600001)(70206006)(70586007)(4326008)(110136005)(54906003)(7696005)(6666004)(966005)(86362001)(41300700001)(40480700001)(356005)(40460700003)(36756003)(2906002)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:51:25.4394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d11281-6ad9-49b1-2d01-08db91f7244f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4505
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung PM9B1 has problems after resume because NSID has changed.
This has been reported in the past on OEM varities of PM9B1 parts
and fixed by firmware updates on 'some' of those parts.

However this same issue also happens on 'retail' PM9B1 parts which
Samsung has not released firmware updates for.

As the check has been relaxed at startup for multiple disks with
duplicate NSIDs with commit ac522fc6c3165 ("nvme: don't reject
probe due to duplicate IDs for single-ported PCIe devices") also
relax the check that runs on resume for NSIDs and mark them bogus
if this occurs on resume.

Fixes: 1d5df6af8c74 ("nvme: don't blindly overwrite identifiers on disk revalidate")
Cc: stable@vger.kernel.org # 6.1+
Cc: Nils Kruse <nilskruse97@gmail.com>
Cc: August Wikerfors <git@augustwikerfors.se>
Cc: David Chang <David.Chang@amd.com>
Link: https://github.com/tomsom/yoga-linux/issues/9
Link: https://lore.kernel.org/linux-nvme/b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com/
Link: https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors.se/t/
Link: https://lore.kernel.org/all/d0ce0f3b-9407-9207-73a4-3536f0948653@augustwikerfors.se/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/nvme/host/core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa7466620..fc85b4cd11fa2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3423,6 +3423,16 @@ static int nvme_global_check_duplicate_ids(struct nvme_subsystem *this,
 	return ret;
 }
 
+static void nvme_mark_nid_bogus(struct nvme_ns *ns, struct nvme_ns_info *info)
+{
+	dev_warn(ns->ctrl->device,
+		 "use of /dev/disk/by-id/ may cause data corruption\n");
+	memset(&info->ids.nguid, 0, sizeof(info->ids.nguid));
+	memset(&info->ids.uuid, 0, sizeof(info->ids.uuid));
+	memset(&info->ids.eui64, 0, sizeof(info->ids.eui64));
+	ns->ctrl->quirks |= NVME_QUIRK_BOGUS_NID;
+}
+
 static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -3459,12 +3469,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 
 		dev_err(ctrl->device,
 			"clearing duplicate IDs for nsid %d\n", info->nsid);
-		dev_err(ctrl->device,
-			"use of /dev/disk/by-id/ may cause data corruption\n");
-		memset(&info->ids.nguid, 0, sizeof(info->ids.nguid));
-		memset(&info->ids.uuid, 0, sizeof(info->ids.uuid));
-		memset(&info->ids.eui64, 0, sizeof(info->ids.eui64));
-		ctrl->quirks |= NVME_QUIRK_BOGUS_NID;
+		nvme_mark_nid_bogus(ns, info);
 	}
 
 	mutex_lock(&ctrl->subsys->lock);
@@ -3706,14 +3711,14 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 
-	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
+	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids) &&
+	    !(ns->ctrl->quirks & NVME_QUIRK_BOGUS_NID)) {
 		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		goto out;
+		nvme_mark_nid_bogus(ns, info);
 	}
 
 	ret = nvme_update_ns_info(ns, info);
-out:
 	/*
 	 * Only remove the namespace if we got a fatal error back from the
 	 * device, otherwise ignore the error and just move on.
-- 
2.34.1

