Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B846E8110FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378877AbjLMMVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377651AbjLMMU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:20:57 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3949E12D;
        Wed, 13 Dec 2023 04:20:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjiB0fZF/6jg57iccZmrf7NZroZOSTJk7lzrRfk3LAxHTcLt9oDIOEvUpQm0P/aAQINl7Az1/AUDTrED5S9jYKycjEnH8Wh4Wx+1FvuMLcnJ5f3/vmPvL+pQLQiUn8Kgz3tUHqVNtDJkuuLsJkJy5BmbLSa262+1FBLDk8VV/dJX18Lyjr9cHiu7ks6HenIOVFXHDMHsoyPOzRN2AkqapjQS0pfFuh9nmNvd8sYVbohln1TdvrnNA0keH/dj0aPhGnxA3fkeaX9LPOxUXGL4G3ZMe2jr5Ilw3UNdPmkobr+Mtkk5LAGxn7CbyNb06pfqcdMQluNC7LKA/2tNPzpdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIOXHeEKqp6Dp2DeXIbuqDfw4F6RrUwb4jhPhi8qfyA=;
 b=j8SZGNMWQ1CqP2wEze6LlpOIAasWdbMGcBomxcycwLqn6d65slzyPBdrzJ7zRpBLjGn5RIwYAxHQhka/m896UihwdHR9FxX4CyvyGOmx16cLdnlLxAA5xgSLagj8pbHvJsw3m4Nh894Bh2Q5nKChR5xqzHxtYGQB0pTdu9SBBThwNxpd989u0f5kiUuTr1IqFAhTifCRNmog5joUQh5W2CFQqjiwSgAAhgJd5a1d9qU68ccAyU9syZqGi887lcyUvjHeBEkrYUDT4uguNa65Ypf+gN6SpFcEKCisqQ4Gj59qTfCrpL//S7gyQrI4Ck5Hd2+SMlVtkMiNNIDkxfzzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIOXHeEKqp6Dp2DeXIbuqDfw4F6RrUwb4jhPhi8qfyA=;
 b=t0QxIhv1fIz6bTUejayKBUAH5YucUov/XKcIvnhtXwDXxYAqiu7uxQ5+NIGAqGQ70ByoRrhuGCWfOKYv2StRiTIJe9N4ss7//x5HrT/yConAx/Icg1I/QZxMLUxTl3V+FuxOUzKUobF8jVLdUkBDHXpqsADdwsZ/BwFSp5uAGR1kqRrQtzgZ0pZxSCIis50XnMeMcPiRInUaQ6Vj5uSMhO9W5ezjGFiniIIJ1nDFzgVpoCayBt21/5m5ujm+0PFnmJQJv3uwBm2Y6iBBcuzL/h9AlanhyBDKfU/Yiah8OpinC7YY0aC0L9A8huof83y4UGzKk69HSQinR+U0ZoSiWA==
Received: from CH0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:b0::16)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 12:20:56 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::99) by CH0PR03CA0011.outlook.office365.com
 (2603:10b6:610:b0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Wed, 13 Dec 2023 12:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 12:20:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Dec
 2023 04:20:39 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Dec 2023 04:20:39 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 13 Dec 2023 04:20:37 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>
CC:     Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH 0/5] Add Tegra Security Engine driver
Date:   Wed, 13 Dec 2023 17:50:25 +0530
Message-ID: <20231213122030.11734-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: e182b08c-fe75-4c5d-b51b-08dbfbd5f464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4ZzryhwII1KUk4NUPtWvlR1FzZr/1DAJbEjomVII0kAHfOqrKSpXq5HQyxr+dskRkxIr0b5d9/i1nXxK216CXaeU+Ih89ZeY4JNOGVwUwuPjak0CYERX0WUj1j13lq6K7TxKaY+BWiE2c4kllVjYeCOTnMaz6epGTCBBW7Bq/TEeJquZhamLSyp3gNFIO7YSC7WBRDOpuFjuEa4kysnL9pT6nh/N+eXZ++dtVvrnf01h55qgPrdnMGHVGlxaeK+1GZCMXctwSawxWPoDC8rabRicC06MhIyNs3gteJ423Fv5Wvxsgw9xY86HlXm68PmNyFNqD17/4ap73XmmMwLIEiQCqANmYHpDtRoavfXp9BHKV5eJ2yY33uFgeD5JMXx3TSoIPZbfvH//QkYY47KogitXACDwH2+YpZLQJbEu2R8zUpFXc8OwWGuxHU3NCGi4qoQOoCa+TXItQzMQ1N9HoQKBTJHt29M3MgyppYFebYQIzNW/c9SQI3k/cqwg3V37KoapGufIgakRXsh5gwE2XfXQFsvgr7eQ3OW19RlEL3ffSNZ4W4KIR09EpnAL4NrjdCRwcNo8VtqfFhrIgaXFno9XJlTXQzmoyPvEp4h1/nzKGq1Asf09aagP75lvOBOu+uiOC4PlnjeZ+snuYyiEOx2VNTa5YnZvfbI4LH7d7j570OuiI3BE4nGMoAStX4gkcRrkqnpOVzRIsLV7CkkkPo8XczDHmejh3/e0l9RmSPmmWg+gX8ymRGuaxpS/1in5ZovDVsv5WZBiAaqNX4URA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(36756003)(86362001)(40460700003)(70206006)(7696005)(70586007)(110136005)(6666004)(82740400003)(2616005)(1076003)(356005)(41300700001)(26005)(7636003)(107886003)(426003)(83380400001)(336012)(47076005)(2906002)(8676002)(15650500001)(478600001)(4326008)(5660300002)(36860700001)(8936002)(316002)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:20:54.8184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e182b08c-fe75-4c5d-b51b-08dbfbd5f464
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Tegra Security Engine which can accelerates various
crypto algorithms. The Engine has two separate instances within for
AES and HASH algorithms respectively.

The driver registers two crypto engines - one for AES and another for
HASH algorithms and these operate independently and both uses the host1x
bus. Additionally, it provides  hardware-assisted key protection for up to
15 symmetric keys which it can use for the cipher operations.

Akhil R (5):
  dt-bindings: crypto: Add Tegra SE DT binding doc
  gpu: host1x: Add Tegra SE to SID table
  crypto: tegra: Add Tegra Security Engine driver
  arm64: defconfig: Enable Tegra Security Engine
  arm64: tegra: Add Tegra Security Engine DT nodes

 .../crypto/nvidia,tegra234-se-aes.yaml        |   53 +
 .../crypto/nvidia,tegra234-se-hash.yaml       |   53 +
 MAINTAINERS                                   |    5 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |   16 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/crypto/Kconfig                        |    8 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/tegra/Makefile                 |    9 +
 drivers/crypto/tegra/tegra-se-aes.c           | 1934 +++++++++++++++++
 drivers/crypto/tegra/tegra-se-hash.c          | 1026 +++++++++
 drivers/crypto/tegra/tegra-se-key.c           |  155 ++
 drivers/crypto/tegra/tegra-se-main.c          |  485 +++++
 drivers/crypto/tegra/tegra-se.h               |  589 +++++
 drivers/gpu/host1x/dev.c                      |   24 +
 14 files changed, 4359 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-aes.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/nvidia,tegra234-se-hash.yaml
 create mode 100644 drivers/crypto/tegra/Makefile
 create mode 100644 drivers/crypto/tegra/tegra-se-aes.c
 create mode 100644 drivers/crypto/tegra/tegra-se-hash.c
 create mode 100644 drivers/crypto/tegra/tegra-se-key.c
 create mode 100644 drivers/crypto/tegra/tegra-se-main.c
 create mode 100644 drivers/crypto/tegra/tegra-se.h

-- 
2.17.1

