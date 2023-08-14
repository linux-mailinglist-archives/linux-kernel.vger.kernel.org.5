Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7777B0E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjHNFxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjHNFxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:53:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08C6E6D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 22:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdxrp+N/UKP1PI6lW3TyXMNqYPh65bkMZyRq/XxEtA7cnJsSwckH0X5hYZBDLn1gEBiFo3v92MaUNQ+gh/CzuzmSU5xWBhpMBx5N/43siavLpN12auDyi7NnFhgsD/v+VuuJkSP8iUUI4Fp2UdyYt1sEhbmyhyB4eRS5xhlVNj535g2ZlisZ1ntz3gtTu7iuvj3pmEPsKzy/HJYDzjfL+QuWImFBSaqWX8Hi2wE8oGjY7M5IPuM1NSmKqgP83oRUVaovIF/4vp3O6Ne2MLXWqukoEg9kfPj5+iRBphnoSx4mgTnB90bPYepO5Q5Y/NqtVL7bc/WxgTAQBXw305eCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDuoLB5ZV1BergQRch39mOmekabGQLXM4wp7o9bjFoo=;
 b=Fi58kOPs710LVY5+VAKk5crHYJZ4pddRHSVXO46oU9KMZE16171PqI4PiQ3yPnDlZMQaANtDZWO+pZTJeMtz+ZiUK5KNzD/aCnn42LTm0mZnlGcoMQYw8EZEeSRy7zaVU3EljWeulGEr2OvbxQtIPRF4ev0XnQA3DgRIulLz71yVjPaGl6A1v8HTtx8iXykyKkO+6SSdgepPPIWS48UcMgZ9CuyDJdN0/Ze4RIw16gOoOI23Yv1TohetnsreJ4wpeHJTWL/9xjYNhdKAcoB9K8kCvbcN+wzGNKxD+yAx9tkRxmYCzT4hHEg88hlp3+jb5BH4hZZqeAY5Avcc9qX5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDuoLB5ZV1BergQRch39mOmekabGQLXM4wp7o9bjFoo=;
 b=RBFq9SaLSTIEAPryI+GNueqbDOwNTm2kBK8SVNQqYRDD1K0R9OPZ2SVkBxAs6++FqQftjiYLscH2VSBteSOOAaNfgGxRwI4yURTi0oZxVrjRc+cwU9Bu9ydC0/H95jSoKMhcTs8V0NR/4a6mLpSi1gjg+kLRvjUgWuKqjq13QyY=
Received: from CY5PR04CA0025.namprd04.prod.outlook.com (2603:10b6:930:1e::28)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 05:52:58 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::8b) by CY5PR04CA0025.outlook.office365.com
 (2603:10b6:930:1e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 05:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 05:52:58 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 00:52:54 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v4 03/14] virt: sev-guest: Replace dev_dbg with pr_debug
Date:   Mon, 14 Aug 2023 11:22:11 +0530
Message-ID: <20230814055222.1056404-4-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814055222.1056404-1-nikunj@amd.com>
References: <20230814055222.1056404-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: ba64edb9-1de8-4395-fbf4-08db9c8ab65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55cNZz069yctnuDIxpP1z994muLwQJYo4Iy7T3T2z4BZ09QOSxC1cxcnhpR6EJYAPXH+BsTXKVcyFv98Y6UcBZWKB+ZB6iVJ1gVlFM1Cy3ZJzgAOrosSqyDiIdsO5vv25UixlfQ6WeyJrcWdmn/oMV6r/nRTCb3DoIWZ1Eo24icX+fBEgHcRGMjxWzSAScBr0oprCpK+MGXKfU3zms7oLw2iJ0JoniMsd8Z6sCeeJnqUH7O7q45UPwKDB+suMrFNKeSealS9IN9uuXR93tQLDqTyGLhbtqJ2+ETXAPM5uGe3JU6RqmANN6jr7ad86lLXIySl38zkO3Wlo5exG5u1KAb7pvLdOYt6+BehjhljXg3eRbnNHmqEglHTSn3+GQdk48+bk2xs+ZNYW0ZyxL+bTdiM6F91WdT+u2MkY3pSizpmvzs7J3AcReN4AXWFjbhoebNdaRT7hdA+UYsNh+/1Fzz1FHrQP3znXHVvE47ur54kZP8gtyPPS1s/5hn+l+vZ477rKdkUdsI2U8UIH6KtYkiWmBXZ+BSQOhdCWtvHOwJvuPCa7/j86UyFOFvkiB5BZA2vtGD6umf+MIJlKuU//+Q0DTFA9RBlV17+4BjUGSEm649o74YphTdIaQbFVFaEdBjJlcMieSbXPdsMg2gJCYpDW2EiLc5OKHCqdcdhiA+wBvYndvYUpucEXk8/wkSdl0BJwj9uKOLcDjSjwJ9ymfwqS2YiZ1qrZ2SxqFWVvQFoEtc1mUmAWTZOpoS/7ZMwhF5mH0jBbwLrnEfX0LvIBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(186006)(1800799006)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(478600001)(81166007)(82740400003)(356005)(6666004)(8936002)(8676002)(4326008)(70586007)(70206006)(54906003)(110136005)(316002)(41300700001)(83380400001)(36860700001)(47076005)(336012)(7696005)(26005)(16526019)(1076003)(426003)(2616005)(2906002)(5660300002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:52:58.1126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba64edb9-1de8-4395-fbf4-08db9c8ab65f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of moving code to arch/x86/kernel/sev.c,
replace dev_dbg with pr_debug.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 8ba624088d73..538c42e64baa 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -206,8 +206,9 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
 	struct aesgcm_ctx *ctx = snp_dev->ctx;
 
-	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
-		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
+	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
+		 resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version,
+		 resp_hdr->msg_sz);
 
 	/* Copy response from shared memory to encrypted memory. */
 	memcpy(resp, snp_dev->response, sizeof(*resp));
@@ -253,8 +254,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	if (!hdr->msg_seqno)
 		return -ENOSR;
 
-	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
-		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
+	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
+		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
 	return __enc_payload(snp_dev->ctx, req, payload, sz);
 }
-- 
2.34.1

