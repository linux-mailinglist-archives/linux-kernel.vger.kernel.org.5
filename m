Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6317D7DED0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjKBHGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBHGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:06:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344E5112;
        Thu,  2 Nov 2023 00:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO4gYONhotJMF7Iy1TGZt/O9vBq1JcLoDzCDCA6U0O876jJrNKu3LMFvXDM10yozRiwGd0X+POAIYvu7PJqp6FXdHEsAXKEM+p5dGFsVIvegSG6DGGLkiB+nytWk3dGCYeBfLLbbUVRHPp35wwnynWh+f9FZOnzET1afVVwglm8k7sajdUBmauUm67BMbku2ZnToe0be8nOmygrzqFxEJkVVuYHsWHGDHFA+HYYZceWeE3WU4yLIiHu3xmOk2iZasER29bS56WFGN47utHM9/08qUWKNxrl3UkVmZU6F7b/+O96dmNgT2SxSer/f7QRlSVqLzO4lcZpae8NBbtoe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XVIkZTFrAPYHncqJnWyYkzQ/FwsWNsdfftF5uKp/fo=;
 b=lhppNh0BTEz0hHDTqylzY2RktjpS3qoXDKAE4BK6ugVjjGljaVlMqUtQmuRkikl1YPWiPdxRGUiatblJnQCzj0uO5ADEbGtWOluNxf+TTRR6Fxl6Q1hqw76LaPtQ0DSJrC7K+hjMWRmG2HWSFOCGUDcUDUgwW5b22AUReM1Z3zcJhbwaH50GS7aM7Xbt8e9XzIZAi26KrGq8OxrMPS9hAC4JmNZvTiMCG5pDA9pF+8tIXCAVp+Jl7OP5RAOfe5ilexzE2frzJHdveyo+84csswoggHw2GWJUww0kvfAuokzLTIqeV29R1gud7B3rrJP7j/XHVknbFOrMHdhs0tCM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XVIkZTFrAPYHncqJnWyYkzQ/FwsWNsdfftF5uKp/fo=;
 b=4IKX65v9dXsmcva/qzvZiTxiWIMIsOUQev7t7ok47j3ovNWfOBbZ/35fwjepfnohQdlZSGNjxMQlqs6S+netVtGuG0HFIhloJ9ffIWO8jrI+Ly/Ttj9Sx3j4cu2OIOG+EcMUVtuap13iasncwepXwAuOF1UQOTfAHmLfGvl8SYI=
Received: from BL0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:207:3c::17)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 07:06:25 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::39) by BL0PR02CA0004.outlook.office365.com
 (2603:10b6:207:3c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 07:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.21 via Frontend Transport; Thu, 2 Nov 2023 07:06:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 02:06:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 2 Nov
 2023 02:06:23 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 2 Nov 2023 02:06:21 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <michal.simek@amd.com>, <peter.chen@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <siva.durga.prasad.paladugu@amd.com>,
        <radhey.shyam.pandey@amd.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2] usb: chipidea: udc: Add revision check of 2.20[CI_REVISION_22]
Date:   Thu, 2 Nov 2023 12:36:03 +0530
Message-ID: <20231102070603.777313-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|BL0PR12MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa864fb-e2e1-4cc9-73c5-08dbdb7239f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNM1rQG0UIJK4SS/pk3+fPsdv8HKiBYyN33Cu5qV1F/s95LLd3JFq/yxr4SMnt+BqkkBHtFJJc3PUzz9BXG19EUmuJ9dqt+QsNvz2sux7jduEDSWUCpntWqhfcllmIjbDFmKcH1GtPuSZh0zNxFDp0WxdsPRIxsxOW8DaIGght6OfGiLZF4C2J4upWM6VSbw/J4WMpiN6JpFdwYGkv54ZPlqystzbPoCt+CHObZCDtXB2DwbB84x9Ipz71qC7wHfWXdqjpZtbn9iz8CbMII3eIQvrOQEx3t49D3CmgGt5uMit2M5RmonYMaXUk7eNPyuwR5jqhTlmad41dLmVvZAA5NsJ3eIsqZBAI7okIh0I5RPwvJnhyZQw9gFjavRm31QvCScFhL2cLpLGWKKhLkMcbpPG9keRTiK5MPfTvUMSVeymmsEUfHP1UBW3eCkDGlIWoIY81/XWfJFdelBVvAl0eegGxAzCIYx+I1Y6gPSwprxMy//o+Rg6mBly5g9MK4QDU4vrCuRhSHhSqBsDMfbI1RhWxHe9v5oA3pTpk6sY001Wmt8SLSJWHjan4BFXKsNWFTVVizlB7ohljK0Q2rt9e2B1RBWvlzY6nCVcUfKMbwWcnj9EZ9SB4tX2XQzAlc9e0oh3UpN4JWJQ0B1qMh0aaJUsjF74F3Likasrth0ldTx8+Djgw+GRPGx+LpiWGqpPyK/ZHymZIvEUMLZyMjLgXua/q76ochl7YruwQJZ+2adZyuglBN8o70nOt4NToNv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(6666004)(966005)(40460700003)(2906002)(478600001)(40480700001)(2616005)(26005)(1076003)(426003)(336012)(86362001)(82740400003)(356005)(81166007)(47076005)(36756003)(83380400001)(36860700001)(5660300002)(54906003)(316002)(70206006)(70586007)(110136005)(41300700001)(44832011)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 07:06:24.7730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa864fb-e2e1-4cc9-73c5-08dbdb7239f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue: Adding a dTD to a Primed Endpoint May Not Get Recognized with
revision 2.20a.

There is an issue with the add dTD tripwire semaphore (ATDTW bit in
USBCMD register) that can cause the controller to ignore a dTD that is
added to a primed endpoint. When this happens, the software can read
the tripwire bit and the status bit at '1' even though the endpoint is
unprimed.
This issue observed with the Windows host machine.

Workaround:
The software must implement a periodic cycle, and check for each dTD
pending on execution (Active = 1), if the endpoint is primed. It can do
this by reading the corresponding bits in the ENDPTPRIME and ENDPTSTAT
registers. If these bits are read at 0, the software needs to re-prime
the endpoint by writing 1 to the corresponding bit in the ENDPTPRIME
register.

Added conditional revision check of 2.20[CI_REVISION_22] along with 2.40.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
---
Change in V2:
- Addressed the Peter review comment - Update the subject line.
- Added Peter Ack in patch as Acked-by.
- Switch to new @amd.com to AMD/Xilinx acquisition.

Link: https://lore.kernel.org/all/1629825378-8089-7-git-send-email-manish.narani@xilinx.com
---
 drivers/usb/chipidea/udc.c | 3 ++-
 drivers/usb/chipidea/udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 0b7bd3c643c3..2d7f616270c1 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -688,7 +688,8 @@ static int _hardware_dequeue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 		if ((TD_STATUS_ACTIVE & tmptoken) != 0) {
 			int n = hw_ep_bit(hwep->num, hwep->dir);
 
-			if (ci->rev == CI_REVISION_24)
+			if (ci->rev == CI_REVISION_24 ||
+			    ci->rev == CI_REVISION_22)
 				if (!hw_read(ci, OP_ENDPTSTAT, BIT(n)))
 					reprime_dtd(ci, hwep, node);
 			hwreq->req.status = -EALREADY;
-- 
2.25.1

