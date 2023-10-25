Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963987D610E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjJYFPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjJYFPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:15:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA2712F;
        Tue, 24 Oct 2023 22:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZOCRjwMZ7Ph0F7mQG3ENht5uqM3fnTyomCJLptjCBtwzcrZvzolapXUVYQCQub6LIyqIh5ds5Bd6DKv/0R/SU8Akb78Ocxuw2yJZFGS+DQwO0T5GMPQFUWd5cuTaZF5jEAMCYSeKL+3jlLhx+jd0m5c5645ZMOawfNJEg2XK5WgLIvtzfjYA+1aovpO+CYJsQ+ECud/YenXTCjDFCKJww85koGvrA8agyaf0UiKRabnJn+XcmJImslFVEe2sXbdNMv94yJvhec1hobm7bKdNoyAIY2PpulmI44qL2aTg5/nXg4+yDHrGFCMXI8Yp2nFUludEJ4P19uiZsqTzLoELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaV19CwG1orY80wW8rlfZSoimcNxtlHK0izFztSmb6o=;
 b=KgKBXm6rn9cHygC2BK+zh577TMVE/vqFF32yf0fLZxeGIFiVKmP8X9W1YiJDh/WarBvUu/XK+3cLaDIlG+7bXs9s8BWKbOfmhX1RG63yw31aspTKhORyguQsi5kueLi0af14z5paX1bbJwcY855B2FC2nA11A49tD5LcKeSbqzWqZFukaOI0KPX1/skweu9Wmtqjrl9QAZWv2jXmDiMJ8W90y5uIM6LiP/Xawl5sRp+/QOYjthzO3Js9W6lon1X3k3ADt3qWDzAmwFOuByXbhpYswV8daRzOltAwXXE/+oZzph06/SMnx/VWuMYojW+0mJlb1hC7kaOzPnwos80PiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaV19CwG1orY80wW8rlfZSoimcNxtlHK0izFztSmb6o=;
 b=xgsb2QTJvbERuGXukCdV+bkaJsM+crVYInSQIAwBknAhU51TR9QnOnTuZALi8TwBXrfR24AEXHFUI1aPvM4Y3fnfk7dtw8hEsHuxMgXnsRy4TgMEDfxWxe3tSxPNXIdvGerPgZs3khQ/+EJDJXGhIxellhA8wDH40HZyp8Az71E=
Received: from CY5P221CA0055.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::20) by
 PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 05:15:32 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::61) by CY5P221CA0055.outlook.office365.com
 (2603:10b6:930:4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 25 Oct 2023 05:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 05:15:32 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 00:15:27 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v2 3/4] EDAC/mc: Add new HBM3 memory type
Date:   Wed, 25 Oct 2023 05:14:54 +0000
Message-ID: <20231025051455.101424-4-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025051455.101424-1-muralimk@amd.com>
References: <20231025051455.101424-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 540fa9f5-c0ea-41d1-f17a-08dbd519696f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfY+sY13ls9Q7I2jyWdQ9NwrQNBcUn0Z76TGg3dtZo3D70Qvkg9ppCtxctL1CHPxdwyGNY1RLqGTfQtiDyJlaG1J2Kit0a4ZEjERpA+Ex3WAYHszrq8OaW3tZqkb2VJYU6IUpIpWMVKC4IrX6Zvi1gPiReChOFYZzrKnxio94SiSGL2v4Y6N8mksy2at8m7ps//GGbVyKRpczlVxIDiP9dCuwZxhAT682Pjw+x4HrqjD4PMk2DkftGmfBIIqrLDj/t0jBgmslQ6oVK6cFLc3nRLHdj2s79dLnc6aFH9WLZO9AV2yd7vxmAVzJ6s4CL5feEQU6UHrHjx93ch7BET4aK3/RCznQis/2QPo1kwuMB9GWbHx4lKKeb0b9VJYfWjRMCZf3ymEKqSJ2SYd95J9T0hm1peSRIuizwZQCvh0/pf2G6eZrxNHbpX7wcvksNAdFq0+9Jgxyeg8Tq08yrLGVP4rNL3MJ6Ui5TJYvbn4wZUHiwsLOmez1T2dD18gPnynWIwOcQjlvU7/W4py3u4W8KeBl+p3DvusQu2m4AlsJtZC1LuaLtc9sAO+NPCbyh+8HMKN7eXGZYc9k8YRnebHbcyTNjPoUMf4mJn/MMR7CoHD5cmwe2rPHHtwt9LhX40XHt5hcxr+osg9fmFd00bESKQF3ZH8otP2HdHj0ihmZoKzzyA4h3JXjMcXvTo5FGd3a1Ki5uV/MvSVNBrqHiAwYMzD2uTDHvNBG5QjRtk0B2Kvj1SkRn9xKBqX1Fw0Q4YnnGC5noQvMUI9UIaUQUfVFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(1800799009)(64100799003)(186009)(36840700001)(46966006)(40470700004)(7696005)(2616005)(40460700003)(356005)(81166007)(36756003)(82740400003)(36860700001)(1076003)(336012)(16526019)(426003)(41300700001)(4326008)(2906002)(478600001)(6666004)(47076005)(40480700001)(83380400001)(8936002)(26005)(8676002)(5660300002)(6916009)(54906003)(70206006)(70586007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 05:15:32.1962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 540fa9f5-c0ea-41d1-f17a-08dbd519696f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

AMD MI300A models use HBM3 (High Bandwidth Memory Gen 3) memory.
HBM is a high-speed computer memory interface for 3D-stacked synchronous
dynamic random-access memory (SDRAM).
So support new memory type by adding a new entry to 'enum mem_type'.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/edac/edac_mc.c | 1 +
 include/linux/edac.h   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 6faeb2ab3960..d6eed727b0cd 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -166,6 +166,7 @@ const char * const edac_mem_types[] = {
 	[MEM_NVDIMM]	= "Non-volatile-RAM",
 	[MEM_WIO2]	= "Wide-IO-2",
 	[MEM_HBM2]	= "High-bandwidth-memory-Gen2",
+	[MEM_HBM3]	= "High-bandwidth-memory-Gen3",
 };
 EXPORT_SYMBOL_GPL(edac_mem_types);
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index fa4bda2a70f6..1174beb94ab6 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -187,6 +187,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  * @MEM_NVDIMM:		Non-volatile RAM
  * @MEM_WIO2:		Wide I/O 2.
  * @MEM_HBM2:		High bandwidth Memory Gen 2.
+ * @MEM_HBM3:		High bandwidth Memory Gen 3.
  */
 enum mem_type {
 	MEM_EMPTY = 0,
@@ -218,6 +219,7 @@ enum mem_type {
 	MEM_NVDIMM,
 	MEM_WIO2,
 	MEM_HBM2,
+	MEM_HBM3,
 };
 
 #define MEM_FLAG_EMPTY		BIT(MEM_EMPTY)
@@ -248,6 +250,7 @@ enum mem_type {
 #define MEM_FLAG_NVDIMM		BIT(MEM_NVDIMM)
 #define MEM_FLAG_WIO2		BIT(MEM_WIO2)
 #define MEM_FLAG_HBM2		BIT(MEM_HBM2)
+#define MEM_FLAG_HBM3		BIT(MEM_HBM3)
 
 /**
  * enum edac_type - Error Detection and Correction capabilities and mode
-- 
2.25.1

