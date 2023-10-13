Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234E17C7C94
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjJMEXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMEXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:23:41 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CBEDA;
        Thu, 12 Oct 2023 21:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGR2w+nOHEru/zE5teK+aPzP58u+iaWZSiFWo3GFTLRrLSy6IVbm7yjHRNiD2v/UphsWLEF68YMPpEvXM6fXhYPjaP56JRUBzE9KAsYT0WxtGhPw5HTscrjoZUJjxjPC3nHPDtTBL2YRhlXQXxmh+16V6pI9X5F+Dj0FTWLDHEErpu8qqH4xHPqdXIm13MJgKdnpQm5TmTUbrpXabEDjieA6vu4kSlw0m0ACeaHlIRz9x0z7oPIezu9yyqeuW0VGIremrWhvnETMVo6ZL0ElkDtf9VlxorZjOBTXwZDqql1SokUWuaU2tf1AqrOoIgg1+jto3VCzeuACH7k/IJT8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7hq2iz14PO8pRU1ayPvnuteWuOndJZltF9Cqay+xPQ=;
 b=SPq1hOBWkIkHn8+suBk6FDhTWQN4OKCYSGYdAMlKTDxg+TLf8ritvBicgJdOZKSOcEL3QEOep8bJAbW4P+BaW5PIkeleGC8Y7f7gIiI52myQjP0Wj+SA2HpJnWw0/jf0+tOLIxYbefFrevfvbYs785cD6jbxYYVrFPbgjE5WBRrI4pABgdU/Ghu9U9Y91t39G26YW8/eaQuCRv0fbwszDpdqY0iSW7UVNJeTbH2/4Z4PZU7KLaj24HDw1Zt8zP/uZPW/8DnkiO2FH7V52lWRaft5UCwf1Ku2CoXY1FTdUqFwpFMW/jmrtnod4dlN8edjatIvJZTM6VA+wfeuDI0mOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7hq2iz14PO8pRU1ayPvnuteWuOndJZltF9Cqay+xPQ=;
 b=FZwNyRM9UBxiMjT0739doioh9Rr51z47SLHZy9OW1KmNU1Ou0OsHhMrsXtZLhwQAgXPSAJHHcnmK2R76Cl4F+N+aaT+g9Xt7i5g6pNqZ6rEfdYwGoq+m4MIS4B87X/JVkp4Jc45qlYQEX2p+9a0YVDwjBK/4fhz658CIgDo10L4=
Received: from MN2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:208:d4::37)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 04:23:36 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::3a) by MN2PR04CA0024.outlook.office365.com
 (2603:10b6:208:d4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Fri, 13 Oct 2023 04:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 04:23:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 23:23:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 21:23:35 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 12 Oct 2023 23:23:34 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/4] add zynqmp TCM bindings
Date:   Thu, 12 Oct 2023 21:22:25 -0700
Message-ID: <20231013042229.3954527-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 08429e2f-3e62-4c8d-04b2-08dbcba42ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hVMUlajgT/f/H7i4pVLj47j4FJKstXhQDpnHO698ZFUyLIR/2jW8Z5y4Q8bcbbH9//DDKu9jB4Xn2nz6SE4vjYpx6MOz2Odxcty/zt5nju9GOsOd0Gbc5NduV84Rl00T9UI5+6qckyBKoM2QPKwyUhcmAzLZZtUsL+alfkrtOIkkTynHangLmVjDuRV5P4EGI5vdqDHoM+b7BH1KUp9fRZKFC4j6T/dnNt8IfWEFd0N+rjbf8R7Qm5JEkwJA4dVF6VzpYBYzInQwaSRbYJPqBx3CmWhjULpKo2BgChEaJKtTxyxiqkLoBcPSMuGiFMYacd2gbRTSrS71BBFGKDFRhGiQ/bt4XToMYLvDnvZGblH67c648dM/k2IogNcc1627INRpmJ4ii7sAX2iyI4dv2KaUAPYyD4McZnn4YVSQLbUllZbwZuTz+y7eFOSRS3nu4teinhpk7ha3PtBbEPPae/i5QDNubNZzSTi24AXWT7rALvqYVUib9C8+DFO/4VnuZBD4LRu9CCQx1225EIZXpUJ/n9B8oYXCodAo53GuQ0hjUWLGqRlHRRD+KAfnVG+lrpkqrcerfC13UNnxl98ZOHPUAaHz4CGFfYo9E/3LYKqv9PPGBoem5zBjwqhZ2isvAi1tfcUmEK+epO7m0JZ62Jkq5ogaVBtexgummZSTeZsg5lJKixVj71oPE4MoVL0DWtnMwh/kP9wH3QR6PvRobrLnBuLjfu5NxO/nU9pmyVDg4zT0a7rTO1EsMaHu3jga19bcYY/fsV6G9KiElHIsEvdrFO0mOdsIqf5ZxgQ6dU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(7049001)(40480700001)(40460700003)(6666004)(478600001)(966005)(47076005)(36860700001)(86362001)(36756003)(81166007)(356005)(82740400003)(2906002)(83380400001)(426003)(336012)(26005)(1076003)(2616005)(316002)(5660300002)(70586007)(70206006)(110136005)(54906003)(41300700001)(8936002)(8676002)(4326008)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 04:23:35.7446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08429e2f-3e62-4c8d-04b2-08dbcba42ae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
 drivers/remoteproc/xlnx_r5_remoteproc.c       | 368 ++++++++++++++++--
 4 files changed, 517 insertions(+), 50 deletions(-)


base-commit: a7d272979d3a89b117ca2c547dc8a465c4f28635
-- 
2.25.1

