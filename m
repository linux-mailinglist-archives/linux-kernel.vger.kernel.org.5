Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6581763E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjGZSbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjGZSbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:31:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B6826B9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK9TfJrvWestqqJs5vcDCu+v/i+zdtDEPEUIGEHb9j7f45nqfcwuBrKfpGYvnQEdVHLdI77EoKIq18gN+NIPFP35MMzhjNz/7O8s+t8T8jE0vOdfIxLWOH7x1St9IVKD6WpwRbbGMRvzryjrfC2/PIqOgI6Wd0eEEDhCybp/fyF0Hw4j8C2qbJN6jZtDdSr4sHorxPByvLr2IIRVt1M2zrpVcp+lchd9WnA5namfpXIVRqKQyaEX+ZSsvTNWxh27yYV/hdrZ2vMKEp4KJyyPH/9Afak6aMLDixuvJur+zRX5qETAWCgwgtirzaOW4XW4RlI/Ziz9u/waEshKUEFmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFUZRT4QgP/tQiG3eOdlHQl4EQlqnOsUuW4VLj7OlF4=;
 b=anrFDj6+C1+KPzdHfiFo3TF2CyXSRk69srJinTSIWZTh4TJRpCBagIgfLBMUgHc1S9OdMjM7XDiu+kXje0yPfn0Ti9rXFBbqaDwS5I2fe8fhfgj+SzWzCUCgGznj7Hft/Znu9h1jv/z3HNJKP7QmPkc8MvXpL8hz8StYcpAzV5kcw4hEnw26yiwlH/IF8Z2i67NTzeC/VjWl/PdrKR5fR/3i7bDC9cgA9aowll1R435wMj47GllS7RjpSLNPVMIUjgGEu0d9GhSYPslvsOxiedN2XTSbBGWO3bSC+LkjwmxgxGUNk+i2wV0En3ywW9XHIgkamVWQndNnChSsfUfCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFUZRT4QgP/tQiG3eOdlHQl4EQlqnOsUuW4VLj7OlF4=;
 b=PHqQMckub2OL8/yGEgeUtNdYg+UvhmO06+SQoYh2Z+iWnT2z9aOjIo3DJgxiyhMDcyXyBafhQ00MzUmbWqVkhE+rLl60en5LO29E9hb2wbml5xZRbt5DIcuA8ft3hRXx0KnuOEJs8paQDfBRgbirurgiQvWNoj137xKx/Cd47twLgRIU2VHhMKHFe4zyT6dtQVhv8ZlOgOnIA4megZWc8SsGi+E+sgVprQGtBVdbKxFPiHBPzADt5hjAmfLbchOtRtnWHNne8cABHTONMtO04Ld34pA58ndpdd3QQ+7eLmViPzT3pFEbrrCEoNl1P7lw//yIltuAVF5HWL985cTTUg==
Received: from DM6PR07CA0057.namprd07.prod.outlook.com (2603:10b6:5:74::34) by
 PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 18:31:27 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::43) by DM6PR07CA0057.outlook.office365.com
 (2603:10b6:5:74::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 18:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 18:31:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Jul 2023
 11:31:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 26 Jul 2023 11:31:13 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Wed, 26 Jul 2023 11:31:11 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Parav Pandit" <parav@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] vdpa: Complement vdpa_nl_policy for nlattr length check
Date:   Wed, 26 Jul 2023 21:30:50 +0300
Message-ID: <20230726183054.10761-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726183054.10761-1-dtatulea@nvidia.com>
References: <20230726183054.10761-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: f774c81c-55ff-4df6-21c4-08db8e0685f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zber/P9Vg2I65fDzWuj4muE8bi9h6Cy7TDGLsjiPJkYP4H7tTEX5crL5ZSkTBzAYvJi0kv84kXvv/FjUnbyK/NKAFx3GBsLNPfEY31R/xvAztQa8g18zDB9FiDJsSB1UwP7GGaiy3Cgn1szPvgKAN9iE7ZrppWuWBpamPh+5xNQVANuFXy2FdgrgPZ+c8ntacmN824bYyyrfwOak0SfMz4C5Uvpu2lbVcFcdYRH+Uv5pvATUGm0B+WhybgNOOiBD9jiwQdTqmI62QOdzAFzZzs3QToEFn0+VWhA1wpUyzO42ddVYvlUC6tjXQCDZ8owwHSK8HRjhNxe1DbY9q4t1e1xi4NlFJAlLVXmDbQWTAEoNbLIYLANuC9thAzpkJx/k5k6fTDox/y1dfhKdEa2PRPS/TvYxlc6PgvMYcWCwQjL9PMms+cw8mnhrymC6vvh/7mVrLdGEqnMFy6bIUhatBZXk1Ze3+rxeZwpn4Q0ooquJj3Ac+BRsR2d/gnO68u9kmNRaXq41WnYyNwV6nD5bhuzbz5C5OacYZBT4LmpsE2YM3krTapc6oR02y2o4WVGtyQLsEWzsvRKhKOYlF2p3Ecw+ikWohNsbEl7NuJmIoPagygfRHiyv8OTNDlMoFrsaZu1fUlsFY0DOJhAb6y9Zh+CFZvd5Of5a1h38FoAUPqbm8nEtP6/EP2LDP4Yc7sCS2Hay6yl0X7eLyBMkljZNE2pbmBxvtqUWebSrXJoYxEhrGJHgmJclrOrERYmx+hX1
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(36756003)(82740400003)(336012)(1076003)(186003)(86362001)(26005)(83380400001)(47076005)(2616005)(426003)(36860700001)(7636003)(356005)(6666004)(478600001)(110136005)(40480700001)(54906003)(70206006)(70586007)(8936002)(41300700001)(8676002)(4326008)(316002)(6636002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 18:31:27.0008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f774c81c-55ff-4df6-21c4-08db8e0685f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Ma <linma@zju.edu.cn>

The vdpa_nl_policy structure is used to validate the nlattr when parsing
the incoming nlmsg. It will ensure the attribute being described produces
a valid nlattr pointer in info->attrs before entering into each handler
in vdpa_nl_ops.

That is to say, the missing part in vdpa_nl_policy may lead to illegal
nlattr after parsing, which could lead to OOB read just like CVE-2023-3773.

This patch adds three missing nla_policy to avoid such bugs.

Fixes: 90fea5a800c3 ("vdpa: device feature provisioning")
Fixes: 13b00b135665 ("vdpa: Add support for querying vendor statistics")
Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 drivers/vdpa/vdpa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 965e32529eb8..f2f654fd84e5 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1247,8 +1247,11 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
+	[VDPA_ATTR_DEV_NET_CFG_MAX_VQP] = { .type = NLA_U16 },
 	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
 	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
+	[VDPA_ATTR_DEV_QUEUE_INDEX] = { .type = NLA_U32 },
+	[VDPA_ATTR_DEV_FEATURES] = { .type = NLA_U64 },
 };
 
 static const struct genl_ops vdpa_nl_ops[] = {
-- 
2.41.0

