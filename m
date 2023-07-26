Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D791763EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjGZSvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGZSvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:51:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017FA2716;
        Wed, 26 Jul 2023 11:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+pd5A4TY6XCvpsVqtqHyjH8YsYPPEHAIWvQfZJO0+sW+X4dWE/Y537T+woz83YV6k29IPfdK/2Znj5gUtJeAubb9vCtHO/FQDy64SnutPbQqrI8E2egrAWnbnrZN72y6213VqfPgd0JX3M90WgPZYiEb7o9wRHABUZIKcThL+88C/RDZz8PdZklE0lRjLIv8tJR1FJ0Q9YlprrpIXVddMbJu0Qyqw/u6cOvIGUF7mR6hi6DH3wA06Z0+rCGQdcoqtWXt/BhgtrEV2gu8oeO2HuuNbDmSYxEWmcupYhLwfz1ZP5OoXo0d5z6P5ZgRY1sPPwByky+vFPnAGPfPOF8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qnk8lYQBhuGQXuEz6bBixqZoD7hFMU3Cc9st74+voDU=;
 b=dVpBjuKnw4rKUg4xEi5+sGxKHsu0tEVansRYLu3P9UH2bKxHJTEHhNXa8p39uix35n9efwAK5Oyiy4zjsEYq+SMjVGwtsew8KwQrfix+n30zngxhyedRdM4mWnr8n4NsFqlK25zhaeAHSfaeOVYJzCpADg6EFDwg77deFFPOSNY4uou83vwS6HBzwEPlAdMd17HPiCIciGJtqhL9rNDBRX9wusPU0cMgUiBWKRWNgMdg3tKSe9S2XeOztw968pJ+NZI9jOQ3C3At3B+fV4u9UjGKheuC83zDcXZrDANcw+kEYb8we2KbTzMpRRkesJ87SUwknnXZVLMjUIRfu5UJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qnk8lYQBhuGQXuEz6bBixqZoD7hFMU3Cc9st74+voDU=;
 b=dgxyj9A/JXM/p36iWhkRwqJ7w5vFe6k+i44C6NbAPDlFWXg+Ayv+21VubjCYBAFb5CpgY9BDX91MhVcqGB9N44MqtYdcW3udEGzbM9oQcexb9WP0U8DuYB0K/3L6Jw+90o3f32tn/ts6hsY5jcMbgw2cqy2T69uNTNyCcxjeozxKSWjgPM8i5tU/pe6uWYXw4IZedJCxWaUs3MH/NLC3dFU05KzPz2UdZx/67hkxpI/a7aXXEyHDUwORgclgLmr3iY2h7bDqCkwsvI/tuQe7nqXUI5lEHu4RcuAVKUjyN6mrqsRm0OXt0YvCv6dy76hW/G5OmLYekxHBRq6CsbuCGg==
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 18:51:30 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::62) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 18:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 18:51:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Jul 2023
 11:51:15 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 26 Jul
 2023 11:51:15 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 26 Jul 2023 11:51:12 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Parav Pandit" <parav@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH v2 0/2] vdpa: Enable strict validation for netlink ops
Date:   Wed, 26 Jul 2023 21:49:42 +0300
Message-ID: <20230726185104.12479-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: d6209a8f-6a9f-4629-7f9a-08db8e095302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpkjj80YSovpF9mTLrCKLu+WhbGeopoppurnWrsXyQaWRrbP5Yk5aaHlgyPDhJFaLrMqAoj+QpCIbKwKYOgCon7h1i9boJbdGvuVKsJRoLv8b6FhOjskDsYZjB07I2pgkIG7hXp8A1IZN/1RkonzwyZeo/2N3ueUUY+dB3ue+9Wro01QT9+ZlRGuYL7sVxz1XD7lMWQAOh1bHjTiVxAW8xdsSG0pab2jjcSulfDVJpzKARb7sYi8GEsYsuwL37WMUx8LxYut+NVRddSJ6GiuzE8cVISMAnU8EzPxTCbsvhUVAd/D8/xdxezdrJaVni0RuUOjWsODT5d0cKkKfvKCVp/2csffxtQOAl/cHDop73fI/vQGyl+T/EyP/eeqixrJ7Liu00pOWeG/9A5U2nGaUc5EjQqCkMjiW3z0EtRNXRPoeZLXagNy7+SIohXqUiFEo/2GEU2H/jqws2cRqEIWWz1Gd/VUsFi+kuymDYBjmS5Rbf7fQz0UBGwVA0Lhn40JLelfcvpoH3F1PTo3zswZbl0jQReNSvvp3D9sjIydOySyCpPfC3uJbBZ/lcY9PAnwHYSYNGBHBxFroDW1jAkjYuMMRSygOmq//e88KCbeZsijAe6GUO7qBi1thkIWTLy4PDCFevACDcClSztFrJoh5b9DmmFSLpDc4GYl3k3TVYZJXFayEJFJ7yV5CtAnfG3GyksMrDB2+RPd6PsoMAsF42QnjllbpeFONBMk9YMvnKPhCbASel+xMP/50ZVrfpuDCBvEAP39nfRz3OhEaZg0UMnlGCNZIg39sHc29htBcUM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(107886003)(40460700003)(426003)(47076005)(2616005)(186003)(336012)(1076003)(26005)(36860700001)(83380400001)(4326008)(70206006)(6636002)(316002)(8676002)(70586007)(8936002)(5660300002)(41300700001)(6666004)(966005)(4744005)(2906002)(478600001)(54906003)(110136005)(40480700001)(82740400003)(356005)(7636003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 18:51:30.0173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6209a8f-6a9f-4629-7f9a-08db8e095302
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338
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

The original patch from Lin Ma enables the vdpa driver to use validation
netlink ops.

The second patch simply disables the validation skip which is no longer
neccesary. Patchset started of from this discussion [0].

[0] https://lore.kernel.org/virtualization/20230726074710-mutt-send-email-mst@kernel.org/T/#t

v2: cc'ed stable

Dragos Tatulea (1):
  vdpa: Enable strict validation for netlinks ops

Lin Ma (1):
  vdpa: Complement vdpa_nl_policy for nlattr length check

 drivers/vdpa/vdpa.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.41.0

