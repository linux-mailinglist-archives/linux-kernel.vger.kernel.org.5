Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6337F3DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKVFoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVFoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:44:14 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D3B90;
        Tue, 21 Nov 2023 21:44:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXuklrMiDG22t4rmsfeI2OEgDnQ4SIKW+Nlk8heW4IdWt8mIXtSovchOjPkEUZfpMExlVnViDciAWSNcHPrispaqJ1AvCUBXpF27mFlMJ60nf0z4uyXdQ/8qd6jRg3rfmc4YjOd8jKEiuI95o9ZjRozsJPX3zV7JckBbuOvYvxGzWYUHASIkh5Mbw9WnNWUmkCYyglBmHB2VvbjHst495CFdiOaDtYcOkAkd6/cJcD1czoXyTh1n2Byihzmt5BQXEf0XxM9G/BYthPDuUynBiUMgl97hHCC8TulqURsy0O1E2WKH1D4Q0YHBBa1eH3hmAzYQb8L0dPgO7hBuImMk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBEZ3OOURH6+pqT6ym6VnjOU8xSZA4K9FTxjOLlfsgA=;
 b=jlmTl4+RyxXDH25dw/FlYyQ2xGRH25SsXrtHyKKfpGHPI5IE8rGDFYTPVNspzn7cP0R5UMzPjiz/h7R4TtJ/Zw9Ff7qVUIHfDxNsq8Hn9tsfUQrp3MX14zAXVzSvYnwffekg4W8rMKEYbapfG6lZzL02US+mziZR/S9sEeaWPIkZgU8ZjQJ6ksy2+oATptO3dIzE3IYvSJCTUfl7/HgM5Kdb+naGeFeNG/2+17NrAInDT8ylN/FdNRtWKS9FHpNzIHp6okLn/8Bp2/2P8EkAT+vyxaesTmUIoe+n2/uNRqxP+5jxnnFkmw2CYtFDYWUqBqPYM9MfIDx/WuCPD3udNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBEZ3OOURH6+pqT6ym6VnjOU8xSZA4K9FTxjOLlfsgA=;
 b=EeQwKh9Ks9xE3SGeuQjErld5UA6sKCBPXlkI7ga+brAy9rStLkD7HLC60y7JsTUoUPftWZh4Vb3vO0J6+pdHWUzD0WBamfMI/ZN1LPTeItQYJzE9lrntgyjhqGqTKDpJDWA5urvgxjo0+t7g7zaPZSAUT8zV4xiTE5tA/GnGUhI=
Received: from BL1PR13CA0433.namprd13.prod.outlook.com (2603:10b6:208:2c3::18)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 05:44:08 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::74) by BL1PR13CA0433.outlook.office365.com
 (2603:10b6:208:2c3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 05:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 05:44:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 23:44:06 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <mathieu.poirier@linaro.org>,
        <ben.levinsky@amd.com>, <sai.krishna.potthuri@amd.com>,
        <tanmay.shah@amd.com>, <nava.kishore.manne@amd.com>,
        <dhaval.r.shah@amd.com>, <arnd@arndb.de>,
        <shubhrajyoti.datta@amd.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 0/3]fpga: Add encrypted Bitstream loading support
Date:   Wed, 22 Nov 2023 11:14:01 +0530
Message-ID: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CH2PR12MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 976e95e1-e707-4e04-e95f-08dbeb1e0ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+LeO8nNw3fywuNb3gQLhscOK054CcP9y3TxFxQ0buXM4jyKsYKI/OdDarmwXNI57lRofSP1lcK4T+7NmK2QoVGWj20YbI8iHlVv6LqTTsUFR2W5zVfqgOSIe2xF7RbAuLNv6cixI7nTaF6a7bpx6/ReeSGLnGasy2Grsi36dDnuTPSXk3rcvapgCXjsYnXSVyBpEkiIHpf2F50XxAoFxrPJHW3lfGw9jQHmV32no17uK0mGJyqtyOZJzsFpW1eTeQpZT7aNDRUd3clTrXpBPQT4Qhf/XTYcgylkWzTf4QlhmGF9aAswjbEtUuyn6o9IdbfX6FCiA5ov/K8WCrDeRBY3OQ1+ebyKxR0SiaNUfC1nqC+Ant4voFHq5VyNxsW6e97xQQ6qo6Uw+jlzKrMlev77DoOQ4R/mPjE8yD76Wj9PLQKTjcAIkz3d8rhjpXtMHZWsQlsWTBbum6lZ0NLsIcSU23bQm1C8ngwV8XXt5d3UwjM20VJDItWcm6KWl+VL0eZwIsKSDzraFJCL9Dy61NEhv5lgSOquQKNopuZad3p6qfw1s8ikwOpFnhiz7rmbSW2IXPsZT1WJlkDL1IFOgTKp5494jv1V6dzR1Ktdw7WCCkfuyHpQO43ZwXACHS1OAuaRSBQcUrqL6E4QPoeWGI0FdETSg+Ii8aLhWkGdR3ANLp/pl/p+fmtOLdxqIafCmi+xBwvOakUciPkuCEkr3ueXQzNJbVNjMTget5KoRKEGMUVPrTN7fAQUnYs6uL1PoBUxVaJIZdXei92kdMemeYXYOa2QAEfrq5qQngIrDV8Zuaj5xOHFXFI/Hbpb6HFRGuujVqDTtti6avzoFGQOIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(40470700004)(36840700001)(70586007)(316002)(40460700003)(110136005)(70206006)(2616005)(6666004)(426003)(81166007)(336012)(16526019)(478600001)(1076003)(26005)(36860700001)(921008)(82740400003)(83380400001)(103116003)(356005)(86362001)(47076005)(36756003)(40480700001)(2906002)(7416002)(5660300002)(8936002)(8676002)(41300700001)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 05:44:07.9688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976e95e1-e707-4e04-e95f-08dbeb1e0ba7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
X-Spam-Status: No, score=1.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For user-key encrypted bitstream loading use case, users can encrypt
FPGA configuration Images with their own key.While decrypting the
configuration Image the user needs to provide the same key.To support
this use case with the existing FPGA manager framework is not possible
because it doesn’t have a mechanism to get the required inputs from
the user. So this patch series adds the required changes to the FPGA
manager framework to support user-key encrypted bitstream image loading
use case.

Please take a look at the changes and let us know if any improvements
are required.

Nava kishore Manne (3):
  dt-bindings: fpga: Add support for user-key encrypted bitstream
    loading
  drivers: fpga: Add user-key encrypted FPGA Image loading support
  fpga: zynqmp: Add encrypted Bitstream loading support

 .../devicetree/bindings/fpga/fpga-region.txt  | 32 +++++++
 drivers/fpga/fpga-mgr.c                       | 86 +++++++++++++++++--
 drivers/fpga/of-fpga-region.c                 | 10 +++
 drivers/fpga/zynqmp-fpga.c                    | 53 +++++++++++-
 include/linux/firmware/xlnx-zynqmp.h          |  2 +
 include/linux/fpga/fpga-mgr.h                 |  8 ++
 6 files changed, 181 insertions(+), 10 deletions(-)

-- 
2.25.1

