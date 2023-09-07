Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9579735C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbjIGPXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjIGPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:21 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D071BF1;
        Thu,  7 Sep 2023 08:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAJkTDaKLVuTf7shhWLu8hw26FoNkdsR2naogKRu46R6/31o8Gcg317zP3wpObOZb85k4ZGkdq2uVT5EYzKl7dcUtxh4RNkAfvE5KlfNZbyugqo5Si4f7iN9kbp1BIYktvsLiTNCPZriXRVYbsZsdYeY/EFK9JDXpW1bftMXLiC1zD0PMI6Ccv1lj86/TewRUDw1XervDCMQr7I8T/z7Kb4RxJTMRvid2q5y8jxE/84aPeDrJC5mrkfX1svNhmd/rKAC4Azf5F6Hhb763f3oetMHpywfxZSsUonrJTnQ5HRWoLiZHxxKTYAp6JnYkjz0Rz98c127zTwSJWrLl63CZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4HTjBlf/dGPLtfz/FqV8I/iXAwVCZjiX/zFi79vsA8=;
 b=if3c8NjFn8ls0PhSD82LsXAFE8osEa5MXkSCFZ17/yA4P4+nscCQ06k6Q4ahHtX3dO8/8X7wWqd0/TFQQdsXmBwbuIdtSTWhH0UzjChkCO2WCh+ee0aL3JsQbIf7LvmbX6+6noWZYavlC/5IoTiO8rVrOhSszXgSXp90cJpCRjz7oaTv9gE99gy+zn+Cqx3M9CMvSMNmwoKvwBOgepEu+9XI2Bli7obaodnMYxn4Zcuc+WkqWrNFTGH3xtzohRuTDIzImbCHsVNhI7jQ9z1c+/CMtHu5Z049AbmGJm76JmykQvfOKWB+Z2yZopNs9xfLmSJlUU6u63gtT9M+YWp97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4HTjBlf/dGPLtfz/FqV8I/iXAwVCZjiX/zFi79vsA8=;
 b=iRGjqQ/PdhZoHVg8khnuQUs8pAUIjqMk2ssLsxZzYy/GUEQnQFeZtoo3EGUFM7qJydQit51xC4rLDppaaKfMLAG39qOqnPbzIdlV7FovXLUtcqoE3AjVVjduEeNC5ZykFP0K3iydzbwNI4YvXajVt/fMdpgGTUQweK6KiOrY1vOkLtI2DM3K9jg+JqWHhhe/RnczUM4XKk1CfLaOIrrQPWWM6GFmrfh2KBP95e7mS5JFhebODIiR2Filyp3dRCdVZNkjMdGHwgT+sj9dHaxqGGb+iwy+ljPqVKZkoqxUDuC1MbueKYBB97YgSGc1gb48XuQZ38BRSLVwK6UAjyqMzg==
Received: from DM5PR07CA0111.namprd07.prod.outlook.com (2603:10b6:4:ae::40) by
 LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Thu, 7 Sep 2023 06:53:11 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::d) by DM5PR07CA0111.outlook.office365.com
 (2603:10b6:4:ae::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 06:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 06:53:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 6 Sep 2023
 23:52:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 6 Sep 2023
 23:52:57 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 6 Sep
 2023 23:52:54 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 0/2] Fix redundant PLLA update
Date:   Thu, 7 Sep 2023 12:22:11 +0530
Message-ID: <1694069533-7832-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b9c142-d0e9-44d7-1e67-08dbaf6f19a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PfBbBH12rZJF3FCJJ8mgJmtwv3ovlsr/JPctYh65rRBmObgsvjE9ulloCNxAvh20CmjPVLlY0tAezVSazd6fB41PX9QCO+HqrDXbuoB2gMURK0gsY5L2fHCPlLx8L4ulSLYmCh0f9CvOVUUx0lm0z36nxHITyPB6NEExUhl7F6d1oLcZzEvh1dlW8zz5gRnnGhOTatODO351eGI7Nu2QTgU55dnlQJAj4VTZdR14NwjxRwAKmz3C46e8XTxXCgUSc8Oj3hqLnYpkprk21YXiyQ+IXtoO9PmRrtibPNzkGHP/H97RuzOZQo+EPWnRLJ4Xq3YQhP+/nxq/sLCoka02FMeoEib9/Kbuxmxsidyqa9HZDod6vx0WpGaPqC39M6GOJ1R58+/I+zNpUXnFXLRVLiL+WEIqSTo9z/LiUVEzLbCB0VeaYTUQL7zttc5QXmzqHbP5/U3v5UKq8MxcgYsi1M8iHMpflElw0j8k1f3v3ykiqI1kZ44Y6FduMmJZRFI9wO13ttAM1CeQNGBlL2mDsBXaMR4kfOysPYAnbibf3E8q+hGknoR2lInf/jQi8ruyKQtCr7PLv+QKLqfExfjb/cRGscxnZ8kTCcOYJ/zXTa/WnD3ehL2jwA5R9rgYvkip4VKHc0KQD3APb0ETLgyJ2nErpUcMUasXP3eAESPP3HGemHwbB2nJS0MP/U8UO24jmbDMF7TVk+x04bL8vJcSu2xy3QYtP/QnPR1b3CKwi0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(4744005)(15650500001)(41300700001)(40480700001)(8936002)(83380400001)(70206006)(478600001)(6666004)(2906002)(5660300002)(8676002)(4326008)(54906003)(316002)(110136005)(70586007)(40460700003)(7696005)(26005)(36860700001)(2616005)(336012)(426003)(7636003)(47076005)(356005)(36756003)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 06:53:10.8536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b9c142-d0e9-44d7-1e67-08dbaf6f19a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series fixes redundant PLLA updates that happen for
each DAI link in the audio path.

Sameer Pujar (2):
  ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol
  ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates

 sound/soc/soc-utils.c                    |  1 +
 sound/soc/tegra/tegra_audio_graph_card.c | 30 ++++++++++++++----------
 2 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.17.1

