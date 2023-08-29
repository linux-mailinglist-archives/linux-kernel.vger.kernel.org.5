Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C078CBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbjH2STi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbjH2STd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:19:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1910D132;
        Tue, 29 Aug 2023 11:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTe0W358QiXD1smZuwT55Eb05kA+foROCX5WVt0CTz2D7s0tzSXGwIsAZd3kznu0RV+AAXkYUc1i9mL+YbunPEecjjKIYsMwU/UvaOpnVAv5eE+24K/+KhdhzXTs6G3YHElan72bf63aQb0frJEq7R71+bWbBQ3SLp3+w1BmQKliQrOGNMtw8sAAl32Na/yXE13KkFWeoZrWasVGhQFnoKsfNj83JBgl2K7NVHkWgmF2zRbLTtR9w3fnk4HpJPrEKE2K7kk2zdGXDAv0FJkpsQBW4cFG4gFnVJ48xlbTbp94Kqm3VifG4fuS4HpHopVYNCwFnGmerYMQ1rB0saVsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1xsTo3yr97HxbCNltfufUIwFQGbj86ukci8T1jWy1A=;
 b=cTVHfthsYMVf7sHYNNgFEQrGu8v7ZxvN49VLeXpZkrPUywUIbSYj96WR4prElSb/cE6BJH6pOzWCRJycQaP8e5YMuGhl4+KUB60EPRrjIHWSn3AVNf4nflpb1MGUi6F+jo1VcSgLMY7Yz2Ho41ryx+LqohbIt1gmL9YuhvXDKSDzGxrdvRZuXQuGmdMiUxROUEPvGU6lXd86l6bBzE3C3BASc16jqsHJERTEnMykflm2TUiKDchi6Y0W/Qn8V5ClJRne5xOYjez1y7zg8V/Yut/MdQTs06GELaS+5czGL9tpc9phpKvGpKRsabyjv0Fl/URuQIWLto1oJgCutM+hZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1xsTo3yr97HxbCNltfufUIwFQGbj86ukci8T1jWy1A=;
 b=U5C5tOqIdWdJs096Wv+G/Azk4aRwPN2Rd5rgIaSPKatRKvme4O4R0HaIZ+mp+MudRXaNM1iSsMfOFJxQ9PzV6BBdu7CmXX5rbZSLuwYxG10iza8pbfukCasvCIC2OqwEJueSj01TCt0SditoZj1NjdpAXE2K7Riz0MTnywPN1nM=
Received: from BY5PR13CA0031.namprd13.prod.outlook.com (2603:10b6:a03:180::44)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 18:19:26 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::cd) by BY5PR13CA0031.outlook.office365.com
 (2603:10b6:a03:180::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17 via Frontend
 Transport; Tue, 29 Aug 2023 18:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 18:19:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 13:19:09 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 29 Aug 2023 13:19:08 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        "Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH v4 0/3] add zynqmp TCM bindings
Date:   Tue, 29 Aug 2023 11:18:57 -0700
Message-ID: <20230829181900.2561194-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|CH0PR12MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: b912a2ea-1ddc-49c1-0ff4-08dba8bc7a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ay0eY2NPfpEHfqO13UwpkAxZkVu2ZLzD5TZJMx0f368TaQ1xWLfs5OzfqwwUr8+m411ZsUUuO9t4X14dDequC87ozktSi2Bhcfaev11A2bceuvLvIGCFycrDSa+oTG25ebZ6Aq5sySY7vYbeDdqQbPi6XgK9giudLxlqawpDNukfk+1rOPt+gL3/S1bP0bOU2uKpRsaDlMoUI3wgi0soJPzhy4ewuB6ZPQoHwETPaD1BhbAcgNTEbL/V/LC95fBKr7WF2VGFytuv+6+uwJ1Mfxph9oUQKp1WTB4ZETPWUrEq+HYTF9TqKlEOrl2bZbt2p1WP+Al6/rWuiQ+dikFKWyt8Zi5x54K8ETfWzWee3mkSwarrIUir4p9/lv/5jsKmlmSxgZufTkx3hWuM4VtLy+St24xrjQjbRW8Q7/wk4hGrePW0bVQMspDYyeQJ1ru5MOdBNFpZPpskeiJSunHx3iMur5d+wZ0IFPDuTNmgliSO/zeHls00HxUwPYeMwRtGrEdCLxzzkQArj7FQ4T7jOhQ+nJzUmtDB9rPUFXX5BA64lw6Ab7V7Qb/2IRmxq8e2p/n63jkkiA0f3u3y1MVCxPfKTLCkScHIZXH11MkTeiS8cBDBbMY+b6StG5ZM1CcQ3F/FScA+WPBTpr+ZVeRSbWaXyeVYou5SbIIG1AnQdhcyFD3tM/Aqh5SxZ9hOcVvjQV2ZJKq6NgNugqYyvou7I+wcy7i4aOssEJEp0o09/YGPKwXMJ6/44GQtCcVTUTWmXbM/IftVCwqln4VIakMBpQH8cgLt1q7ZHeiH1UMjU0Jd1ri9bTDssRxKoVNN/XO1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(6666004)(83380400001)(966005)(478600001)(1076003)(26005)(426003)(336012)(2906002)(6636002)(316002)(70206006)(41300700001)(70586007)(8936002)(110136005)(54906003)(5660300002)(8676002)(44832011)(4326008)(2616005)(36756003)(40460700003)(86362001)(40480700001)(36860700001)(47076005)(81166007)(356005)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 18:19:26.1353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b912a2ea-1ddc-49c1-0ff4-08dba8bc7a5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
| R5_0 BTCM (64 KB)  | 0x0000_2000 | 0xFFE2_0000  |                      |
| R5_1 ATCM (64 KB)  | 0x0000_0000 | 0xFFE9_0000  | alias of 0xFFE1_0000 |
| R5_1 BTCM (64 KB)  | 0x0000_2000 | 0xFFEB_0000  | alias of 0xFFE3_0000 |
|  ___               |     ___     |    ___       |                      |
| *Lockstep Mode*    |             |              |                      |
| R5_0 ATCM (128 KB) | 0x0000_0000 | 0xFFE0_0000  |                      |
| R5_0 ATCM (128 KB) | 0x0002_0000 | 0xFFE2_0000  |                      |

References:
UG1085 TCM address space: https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Tightly-Coupled-Memory-Address-Map

This patch series continues previous effort to upstream ZynqMP
TCM bindings:
Previous v3 version link:
https://lore.kernel.org/all/1689964908-22371-1-git-send-email-radhey.shyam.pandey@amd.com/

Changes in v4:
  - Use address-cells and size-cells value 2
  - Modify ranges property as per new value of address-cells
    and size-cells
  - Modify child node "reg" property accordingly 
  - Remove previous ack for further review
  - Introduce device-tree change with split mode representation of
    r5 cluster and each corresponding TCM
  - Introduce corresponding driver change to use TCM

Radhey Shyam Pandey (1):
  dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings

Tanmay Shah (2):
  dts: zynqmp: add properties for TCM in remoteproc
  remoteproc: zynqmp: get TCM from device-tree

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 131 ++++++--
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  28 +-
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 279 ++++++++++++++----
 3 files changed, 356 insertions(+), 82 deletions(-)


base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.25.1

