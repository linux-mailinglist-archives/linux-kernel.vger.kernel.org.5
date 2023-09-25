Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B907ADCB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjIYQHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjIYQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:07:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8404CC0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7HFvzoAMwsz3xf037xx8caNtjJ3PWE8RrmxpJHiKrk948OfMo0q6kBCb8M8YiphhBl2qkFYBEVUzpg1AHmuUKpWawnZlDwLW7ER8qspH5yaPVPNW1p86fIqhzzEbx8GWWzFioiD5ZmIeHgjY4o9o93KzNnTs9U4mAWz0Q+Omcw/PHcz+m4uuKcDXeVmlhde0O5cED015IxslHeW38M7K71ImtJkz0FxSuqYO3zl5Nb70vvy3Si4VLSp3CUtebQpYdz8MDcdAG65vM+TATy2FGT1r9XUW5qlD7h1Q06A7TELTMvjv92F4SqZg+XJYcKcybeiIxUcaav6fnTLtvB/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esEIgCa9NHvodxjFjStLT7g/wRulfGEnyzkd0jrkUc4=;
 b=oC0TLK2FLmSLHFzmwdWmrXOIs5e62iKc6MomDPbrobN2xkVg2Xnlrt9HEWyYE1XxyaLY22u459ObHuFRZ877vTKBoobkXWfRzxsGdfZu9tGq3Bgd7DLb61ylizXLkw3BKy/Wl/ABo0nyeNYxtSo+Q71SqLVV+Mzy0Yu9hoPwLchMSK2S3H+/RpG3z0xap5bCRI3K+Tspj4VFb8XCaTu+Bs0ZWo4dUzzpyL1nw6mmBnSWPEEK9B/yytvalC/kNHzn65jeSVEXFIqoUGmm9EpOg2HBndqzofO4pp7zlrGUfhTwSKQ3Bd/hUFumDogjDc5/M3+BC09crXflr5LlAGu6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esEIgCa9NHvodxjFjStLT7g/wRulfGEnyzkd0jrkUc4=;
 b=cr6VjYN4XNYZvlyqRSPrVO+XZwcBZ+g4qk+atdAu1Z6nqG23QXAeg5eOr6o0VoiPIfhAHQsGUiV36RsT3GYKjeBo5Tpq3Vb04n8DyCPQEOf/rU1L78IvKQLxX3QIY80chLMduAVyC/UostbNCl9EbEqjYLvwaTgXgyG0orQgDZAf9ybp3m9ugwZpVVmNN/EDgiyfy/viYVpSXyD/HC9aBn0n1KkKt0Fm4p2VBp96far930QK/XAkRG3e5BiwZx1ksAaNiDMbG6i5sf5Zkss2tTBXPxoIxFuNVTRzDy4OWpUbFJDLpaNmNKxcsXb7iUQGOibaygmERxhGwROdMA3JMw==
Received: from DM6PR02CA0071.namprd02.prod.outlook.com (2603:10b6:5:177::48)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 16:06:49 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::6b) by DM6PR02CA0071.outlook.office365.com
 (2603:10b6:5:177::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 16:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 16:06:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Sep
 2023 09:06:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Sep
 2023 09:06:34 -0700
Received: from c-237-113-200-209.mtl.labs.mlnx (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 25 Sep 2023 09:06:32 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <mst@redhat.com>, <gal@nvidia.com>,
        <virtualization@lists.linux-foundation.org>
CC:     Dragos Tatulea <dtatulea@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] MAINTAINERS: Add myself as mlx5_vdpa driver
Date:   Mon, 25 Sep 2023 19:06:51 +0300
Message-ID: <20230925160654.1558627-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: db8625e5-8edb-4f28-a974-08dbbde16c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44QcmaP8ZJw7gLhmxEyOczPcX50j9VqAMRJUCkUATdxlICjxBweo4SlEr5oQdLXRh9bxHc5m3Liv1LIFzjg4Es1dmBGQ5HXx9YcYHRER6xITRKFBlmhMhFAjmFTuvy6iaitSR6E1MubvLrGHIio1M6vq/GfFgCqTfb8N5akjTjAR3jifKLoYYM0h5P0x5DZAXAZgJ5SIB05gf4JhioBIZNLXj8G6TM/cqkJ2DkzH5YsoTyJ5yu2FrnE+079Qyl5OyMxwB2otcj0xvsOjwy1ZbPjXpPUCcVpZ2VHt+1dwPwjqkI2F6byxFEpCgwK9zPWvIpC6W7Bpfxwbek+c5s9ik/EUb4q0kAtssxYNIeAKMmlpm2QN71FpNyv73UNL7kf94VeshKFdoNOvDaZFOPdTX5UBKB16tK6repLuCdWjkZceyo3KTDcsU3DtZ4IIV65efTcaFrwb5CKQN5mIv02/pI5bcFYOIEQTiaIKaFmkNy4VjfDBBg/Q9UMZweGl6CUdr0XjB6wezEk0Te5Z4mTBlfJ73bQhyVYWW8KulXwfaEz8eULgy2ROSM+twdZ/5aiD774Yk2QL7tOQGZcSUnBreueKU7NaMucGN5shnRCBpd24SdhVZR8ZcVLPtg3L3PH6ICbtCrUrvoczZ2nd4fw8BS6URLVqjMYXZSj8FkGGLPJA3Bfk85KVdSb02/nTbWrhp9HnWQdt1BoktwMlmPZqR1vZyjl9Iph04ZoLLWYyqdjrhcWKU408fLBAoiBahx5a
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(356005)(478600001)(6666004)(4326008)(36756003)(40460700003)(36860700001)(83380400001)(40480700001)(4744005)(82740400003)(86362001)(7636003)(2616005)(2906002)(336012)(54906003)(47076005)(26005)(1076003)(426003)(8936002)(8676002)(110136005)(41300700001)(70586007)(70206006)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 16:06:48.5781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db8625e5-8edb-4f28-a974-08dbbde16c6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Eli Cohen moved to other work, I'll be the contact point for
mlx5_vdpa.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
Changes since v1:
- Fix alphabetical sorting.
- Make naming consistent with other MELLANOX entries.
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3dde038545d8..611c31b3b9c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13677,6 +13677,12 @@ F:	drivers/infiniband/hw/mlx5/
 F:	include/linux/mlx5/
 F:	include/uapi/rdma/mlx5-abi.h
 
+MELLANOX MLX5 VDPA DRIVER
+M:	Dragos Tatulea <dtatulea@nvidia.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Supported
+F:	drivers/vdpa/mlx5/
+
 MELLANOX MLXCPLD I2C AND MUX DRIVER
 M:	Vadim Pasternak <vadimp@nvidia.com>
 M:	Michael Shych <michaelsh@nvidia.com>
-- 
2.41.0

