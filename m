Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF927EF726
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346174AbjKQRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKQRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:42:58 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D51D49;
        Fri, 17 Nov 2023 09:42:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njseX81+YM164nsKgwftn0yKWeR+V3Hp0OIeBHvqx5uuokoh2eJuQfNHZBSwUMLRoA/kd/dMlr9nhI2m+dqaF4tL7qh/zJKElrU41vxo50eoDWtmDLzEHdSsGYOXEtkGPr/1706kkKsbA+s/6Coi04SzsgCfhHwtC1WfSVcv8Qr+xTHfM9q5g3lN8AMYWasxte7AUlC/5Sk4bEVEyWHbNVGlqmRzWJIZo98OYlSbwdZDg+YKhF7ii8gDHHR/vtN3JHhEJbyubv9gxrq1VcP/L/nrirK/ykggDhIW3UoXMBFjGwakFVPV4/V6mOnblwUFbUH18AGwyZE4tnH4gX/wxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yk2wFb+OyRkCb+X6lryRbXXlzujHGuq6g7Au1xOdqE8=;
 b=F9e1VAG39foK+oibICdUK5F5XRHHdlF1uLEOO/dv6LLN8fvOx7qTGKOeCtZpqpHzU3LBjPHQWmtNeNJ2ILOA2Pc6ypQdl66ixXg3erOO4gEmfTteMRgBtarBemyL5LA4BpfUMzYEKjko2jkHnifDnYbVCgk18RpKtkNdiG63sNyomyxCq8IVLL0Dc0A+++xXxA1zSIwgxPO6s2uZMsTk8Zxd/KaCS0GXOABwZPSZoYUOSxYUKGHrgR36tRYGdq4WLqP5O9SgdQgVCBuPn/QrU3HAi/idyYlawmwEbAdtySxfTCho2rBcveRCF5gOTlaFecGCTw5kFyI8hz+3tX7siA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk2wFb+OyRkCb+X6lryRbXXlzujHGuq6g7Au1xOdqE8=;
 b=LHcyLzUpZusAaEcc/Q1f1w2I4vCzV39gLn1OxaDCP0RZIlCQUNE6/BcWcLwUxdRL3xdFKqAPt6tczwgI6r9/Sr3QHFwI7rEXjyGAOacHAiAoI0DxePnYwM2ww4bBka0REJtXpchp+rncESjd5iP7aJ8jrkGzR/sW2/rMPmqOq0Y=
Received: from SN7PR18CA0020.namprd18.prod.outlook.com (2603:10b6:806:f3::14)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Fri, 17 Nov
 2023 17:42:45 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::d6) by SN7PR18CA0020.outlook.office365.com
 (2603:10b6:806:f3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Fri, 17 Nov 2023 17:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 17:42:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 11:42:44 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 17 Nov 2023 11:42:43 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/4] add zynqmp TCM bindings
Date:   Fri, 17 Nov 2023 09:42:34 -0800
Message-ID: <20231117174238.1876655-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 2581bcc3-b508-4451-833b-08dbe7949b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCOe3afr7inOt++P6m38iAzsEiRxfHyeLHRVECG+C3SbuX2/2g5Wr8wKtHkNAK/L8jMg5N7/sOidTVFXZT3sdaf5D5c8DbZ/YnIRu+e1le9PSgnZ82EFYLyHTwb8EEdM5ppe8cSHn51MGv9KwGflbe1UsWa+f02dZ+DXi/YZ77q7Gn0gfPYJuZl2CAH6Z0ZrBo/VapA6VvXO/7Cia8zWLLm13KflqifgXHyf9ldN8V5HaTOjX5EwuAfELMcITi6x76Gkh4J2IOy9Fl+67SYxmFexfvsrp+91gcFeg7gaCdCP4npxRFK/Ls4AxGq1WRALfA+v2dMSGvjc49BBUcdKl8YbLUeKmJy7tTiqWHdLg8ADycJNCg2VsChL9MfV5AsPAOLXTjLNtVi/uaiRTU1Ved6p60xyAOoia3ZK1E8teI6YunbsH7ejHmfPvfQuz/uhMbhbaI0QAf/7bfTvOC3rcx07XwJaiJlILfucOkA1dgs5d0Ggv6LUPX3dSBmOq3F33o4JzTTIkmAVaX5bLbMNYI0WxzikNInqqy3HDAvMypzofA7KDamY+t+t/96TLRVLPZ/lXit3Bt/nMGk/qUU+nEGOChGHUDwdxP2+SPge6Nom21ThItMxa8gq2jb2VFgSISgXRPEJ1sgF1VW7hO4RZmSZP2KNZvFlCQgnFKbQ/5X+s85fW3p2ZozfnsXdEtbSm/X4NOoGza7OYcLK5vRsBl+s0bKWU/LxJOG9Cv/9nAFM+u8cYyzDMZfoJLeaDiq1B49ldqB3+pl3dIywlfwUhxfk3tp/mmiScCt0K1eFh5c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(54906003)(26005)(426003)(47076005)(336012)(2616005)(6666004)(83380400001)(8676002)(36860700001)(5660300002)(41300700001)(8936002)(44832011)(2906002)(478600001)(110136005)(966005)(1076003)(316002)(36756003)(70206006)(86362001)(356005)(70586007)(82740400003)(81166007)(4326008)(7049001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 17:42:45.3759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2581bcc3-b508-4451-833b-08dbe7949b98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tightly-Coupled Memories(TCMs) are low-latency memory that provides
predictable instruction execution and predictable data load/store
timing. Each Cortex-R5F processor contains exclusive two 64 KB memory
banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
In lockstep mode, both 128KB memory is accessible to the cluster.

As per ZynqMP Ultrascale+ Technical Reference Manual UG1085, following
is address space of TCM memory. The bindings in this patch series
introduces properties to accommodate following address space with
address translation between Linux and Cortex-R5 views.

|     |     |     |
| --- | --- | --- |
|      *Mode*        |   *R5 View* | *Linux view* |  Notes               |
| *Split Mode*       | *start addr*| *start addr* |                      |
| R5_0 ATCM (64 KB)  | 0x0000_0000 | 0xFFE0_0000  |                      |
| R5_0 BTCM (64 KB)  | 0x0002_0000 | 0xFFE2_0000  |                      |
| R5_1 ATCM (64 KB)  | 0x0000_0000 | 0xFFE9_0000  | alias of 0xFFE1_0000 |
| R5_1 BTCM (64 KB)  | 0x0002_0000 | 0xFFEB_0000  | alias of 0xFFE3_0000 |
|  ___               |     ___     |    ___       |                      |
| *Lockstep Mode*    |             |              |                      |
| R5_0 ATCM (128 KB) | 0x0000_0000 | 0xFFE0_0000  |                      |
| R5_0 BTCM (128 KB) | 0x0002_0000 | 0xFFE2_0000  |                      |

References:
UG1085 TCM address space:
https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Tightly-Coupled-Memory-Address-Map

Changes in v7:
  - %s/pm_dev1/pm_dev_core0/r
  - %s/pm_dev_link1/pm_dev_core0_link/r
  - %s/pm_dev2/pm_dev_core1/r
  - %s/pm_dev_link2/pm_dev_core1_link/r
  - remove pm_domain_id check to move next patch
  - add comment about how 1st entry in pm domain list is used
  - fix loop when jump to fail_add_pm_domains loop
  - move checking of pm_domain_id from previous patch
  - fix mem_bank_data memory allocation

Changes in v6:
  - Introduce new node entry for r5f cluster split mode dts and
    keep it disabled by default.
  - Keep remoteproc lockstep mode enabled by default to maintian
    back compatibility.
  - Enable split mode only for zcu102 board to demo split mode use
  - Remove spurious change
  - Handle errors in add_pm_domains function
  - Remove redundant code to handle errors from remove_pm_domains
  - Missing . at the end of the commit message
  - remove redundant initialization of variables
  - remove fail_tcm label and relevant code to free memory
    acquired using devm_* API. As this will be freed when device free it
  - add extra check to see if "reg" property is supported or not

Changes in v5:
  - maintain Rob's Ack on bindings patch as no changes in bindings
  - split previous patch into multiple patches
  - Use pm domain framework to turn on/off TCM
  - Add support of parsing TCM information from device-tree
  - maintain backward compatibility with previous bindings without
    TCM information available in device-tree

This patch series continues previous effort to upstream ZynqMP
TCM bindings:
Previous v4 version link:
https://lore.kernel.org/all/20230829181900.2561194-1-tanmay.shah@amd.com/

Previous v3 version link:
https://lore.kernel.org/all/1689964908-22371-1-git-send-email-radhey.shyam.pandey@amd.com/
Radhey Shyam Pandey (1):
  dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings


Radhey Shyam Pandey (1):
  dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings

Tanmay Shah (3):
  dts: zynqmp: add properties for TCM in remoteproc
  remoteproc: zynqmp: add pm domains support
  remoteproc: zynqmp: parse TCM from device tree

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 131 ++++++-
 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |   8 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  60 ++-
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 363 ++++++++++++++++--
 4 files changed, 514 insertions(+), 48 deletions(-)


base-commit: 6dc66a3096730db94a89b098da66887a390cc6af
-- 
2.25.1

