Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440737E6416
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjKIHAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjKIHAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:00:51 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219102D4F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:00:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHFDT3Cw4p/1KTZL8Rlz0KDDG1EqGgYKAxF0HD5+4F0HMrYTNndEelDNdNH1I/RqaozMIc7/Hs+zfbRgjeJEpOy/0uGAKySkBNy6FItVVuTpWWCwGV1qZQA5HJAmnHPNl/QDneKVLLdChQHSaaLUMbsVJWI4gsbqd2b4YZ+73ussUPOMY0sh8moz/PycLrX3tfUXr6VAzilCxGWzDUl9LrywtqYb87vW/SbZaHesxrz5j5MejWm7s9pPL2EzPMQeZRgQcJtX2+c0iPXRJ+Pi3+ujkE38CLDcsgsjVtniP/o3z/zbPOAAGY5YROgBvCcAWNhQexT9bkrhv+Nv+YE1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPicbYDIUG2R9HYH+CTa8RS18Avgiw4UruD5F+LeWVk=;
 b=gU27J1W4RKLF3J1yPq7q5M8nBBs6eSZAW5pVhexAoIqpZfvzX25HuLjRaqU92hg3DIGtB90E6xgCObbE9f9dx8S0DeHFjJWHEvVkj/lISj8lphro9FRDqvTx25PRblzbWtuFx7zmNw80l2tp4WOGno7fui8v58d3ehYap3SaqMmKZry6wTmL/f/NNMnL24UOL4TSOu+ZGrlwYLPlpyNK59cqDT+MHLIIGev39+i3A/nIHWoXSpg2cUkEOhxpZAx0HBG1OyvfpBGcvnUnXO+Ga4SDWwgQFA2ozUGLUdEx8cPAsUYxnBR/ajY1RHFKp511yOa8G/qqqcu8DfUc9+N0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPicbYDIUG2R9HYH+CTa8RS18Avgiw4UruD5F+LeWVk=;
 b=ttTAGjo4M38bUir9LeKuPJsiffE4o3fFgH6OPHH2oY8FYESZy/hfZY6nlUvP8+OjpIqwyGv7iMt1mZywX1lpRkDO22N5n9ZNw1ub92B+hbVyS1xm7IQ4a/K9OaczBo7fiA4ASbXdPJXFFFPISLqGT+3lpcKTAjnublscjxZ8fiU=
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 07:00:46 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::39) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 07:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 07:00:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 01:00:44 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 9 Nov 2023 01:00:43 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <mathieu.poirier@linaro.org>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <sai.krishna.potthuri@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <ruanjinjie@huawei.com>, <arnd@arndb.de>,
        <shubhrajyoti.datta@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v4 0/5] update for versal net platform
Date:   Wed, 8 Nov 2023 23:00:16 -0800
Message-ID: <20231109070021.16291-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e253e4e-225f-4333-0d0a-08dbe0f19883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/UA5WjDYPD/m8qrj3d5ptsyIdJkK5ejOW3C5bIV3NpqaB7Ixd1XjJ2zKXkErHZRruUxr8tNcmgCmMMqBzqzrizrrVX7nxjn03vPYQNHXZK4vfFqzJYxQBpMTtnUNvn0ge5uc9UDNzQdWAkhfboedJje3y7RR/6t+hU0woBMhdNC87YTYc9nIYpL4PFynZ26XNTdqJWRfaFKGNAujJ7xP0/v+1h58GheO83E9qiKqfG417ILYe1Vd+163deeLfi/SEAG98sEAht+KrZFT1aTfwrc0QcfUnMBNdHfBn7E0nddw8J7NltrVm0GwLvDYP/B6PXEdaEN2UCPA/mV2qCYEEh5FRVbMFDurizeBpthU1vHi7502JJoBbJm6vsO5vU5g8GxiuzwLVIdBIKqfMibqVQSlsVaQkaORT54UcypWpMNCeJEIc1U/8sAsH7KUPC+cVns+OAv9Vps0To5yX/1bcJbeUjnqRjyW9BqZUePG7jVPFiKUhBlaBJy07x2Sp5leIfKlbWJrpQckDDPEueKmeVQBKjrY+D/+z61Lkw41ZKZw6dDhbWj8Sr721xWMiuxkQKyJ0akfs6UK6vHuFFuu6wSfGjtttTPZgnA9sXHQZkbCQC78qJgfgtJKEiTyWQ1b4sKxlFBXzLhfc+4kDFevi2NHedUWYNpHcsxKR7p5ube5nAFZ25l/7oWU8aOmf3fXCBavO4D2kr/HcoGnYfVCYPZWtD8ZTqiaPUy5+ExsMbW70AcoaXaMIF7Intk9sketCj8p3h3ifxByMe+kITtZWb6mU4toILBt/UTyBWoVNZl8AkbqGWIHaQ+RGmpYNLvfNRMSJ9O7VZjw/ffMW5zXLuJfaJAxyHNln1bz+6gJA4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(70586007)(478600001)(966005)(110136005)(6636002)(54906003)(26005)(1076003)(70206006)(336012)(2616005)(15650500001)(6666004)(316002)(4326008)(8936002)(8676002)(44832011)(2906002)(41300700001)(5660300002)(36756003)(86362001)(36860700001)(47076005)(83380400001)(81166007)(921008)(356005)(82740400003)(426003)(40480700001)(40460700003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:00:45.1960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e253e4e-225f-4333-0d0a-08dbe0f19883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update firmware and SoC drivers to support for Versal NET platform.
Versal Net is a new AMD/Xilinx SoC.

V1: https://lore.kernel.org/linux-arm-kernel/20230929105558.11893-1-jay.buddhabhatti@amd.com/
V2: https://lore.kernel.org/linux-arm-kernel/20231004094116.27128-1-jay.buddhabhatti@amd.com/
V3: https://lore.kernel.org/linux-arm-kernel/20231016111301.13369-1-jay.buddhabhatti@amd.com/
Changes in V4:
- Used variable arguments in patch #1 for adding support for additional
  arguments

Changes in V3:
- Addressed formatting related comments
- Removed below patch to update maintainer of event management driver from v2 patch series
  https://lore.kernel.org/linux-arm-kernel/20231004094116.27128-7-jay.buddhabhatti@amd.com/

Changes in V2:
- Removed below patch from V1 patch series
  https://lore.kernel.org/linux-arm-kernel/20230929105558.11893-4-jay.buddhabhatti@amd.com/
- Corrected maintainer name format in patch #6 as per tool requirement

Jay Buddhabhatti (5):
  firmware: xilinx: Update firmware call interface to support additional
    args
  firmware: xilinx: Expand feature check to support all PLM modules
  firmware: xilinx: Register event manager driver
  drivers: soc: xilinx: Fix error message on SGI registration failure
  firmware: zynqmp: Add support to handle IPI CRC failure

 drivers/firmware/xilinx/zynqmp.c        | 329 ++++++++++++------------
 drivers/soc/xilinx/xlnx_event_manager.c |   8 +-
 drivers/soc/xilinx/zynqmp_power.c       |   2 +-
 include/linux/firmware/xlnx-zynqmp.h    |  16 +-
 4 files changed, 179 insertions(+), 176 deletions(-)

-- 
2.17.1

