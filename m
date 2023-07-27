Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A6B765B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjG0R6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG0R6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:58:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86602D64;
        Thu, 27 Jul 2023 10:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTJmiqk1nsJkXmDexxTkRkf7NfuJCgmdAvmL7NBEGjN2geqXM1vHMpobTOWk9dpWfXzJn1a6M377WCxIM4G66vPY51b/JgCCb4Ae3TEfAQC6WAAkNU5QzSUyMYml6euw2N6ixxkCGeTGhjgJZmFBD6uj2AXPtGq1MPBzR+euIW76UQuX3RDCHe+RyaOAEOMyO2fefA/IQLIfB7TI7WWlzyc9xIa2zKEArcKwHiH6RiDtw/ZNvwNp3gA7fDG85YzlkaCxuZTdmwKBVk/zgrnYY4r5cxtaAO24/SxdsDkR3IqCRZySGnw4yv/BHskUK4RGbXJ5E4Q+wnhS5CrZEsrcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0X9WamVdIhTmxfAVDjnZRe5MLzXc6VbF1Lk426V1E4=;
 b=JihgaJtHF6RpmQDc4Ntoh+BTFOQjF36bXrGzIMPdGMUxLqoUVC1OGSOvPdXGMN8wmdJuoCoa4/DAyGsn2X+uTl0E2jji4nVIbcMY3tc5VU1J9kv6vZu2szoOM6iQYyAahz9PCNKGtC38wUVM9NFBoP4YXwGjk3toZpKKivMsMtZQbfQEmYsT68Wav6ChGbSDSoglDtbcjkxdUMj8qYzKUzxWrUBppV6LM0oVrvpV7l7OJGYUqtjB47GTcTSPEOaTBqKNxIzE0lJ4Ras+LwGFUUPnLpFoAiagDYqCXB87cS9+OFZGoJS/FXaiWylmqvFMlPYO9DcvRexfPjyVpyCqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0X9WamVdIhTmxfAVDjnZRe5MLzXc6VbF1Lk426V1E4=;
 b=VRkxDOYyrTh2rDLKEOBzH5LJCXPm81W+Pqt+3nNiK1osguT+18UOZZbmvgI6e0dKXssbI13QOusk1yZtE9HCgOQYLGYJhn2k4qglkVUvrqCtSPSz7mzyV9i3uYn8Sqjie9kpIAM22SD/tbKZrZO1wIF01LwTFftVwPDALVspiWoDWaD0l6gArEBfSP3r1n7X1rYHmQlCqGqbVCkbr3Mp3mMKcW2RUB3ISqxMDxdCSlfR3yzsF7hWyh/xoJ8dVJC2Uzac1Kn2m87dFyU1JZsrTiIf6lID9c1IIOiZ/xnSyEf/hdUBAYCgl4pZFr769SIAyeKpI2V/YnNm1HMCGywYjg==
Received: from DM6PR03CA0050.namprd03.prod.outlook.com (2603:10b6:5:100::27)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 17:58:27 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::c6) by DM6PR03CA0050.outlook.office365.com
 (2603:10b6:5:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 17:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 17:58:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 10:58:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 10:58:14 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Thu, 27 Jul 2023 10:58:12 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Parav Pandit" <parav@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/4] vdpa: Add features attr to vdpa_nl_policy for nlattr length check
Date:   Thu, 27 Jul 2023 20:57:48 +0300
Message-ID: <20230727175757.73988-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727175757.73988-1-dtatulea@nvidia.com>
References: <20230727175757.73988-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: c16c23f6-8353-4d50-363f-08db8ecb1456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+LH2QriJ49GfF5yQIU/hIp+nqZ24XGOD2OJfeq6pB5y9nKfju6dIuUY2u+gvKDHnIlKqtzPpQgJfk5bjFlv++BD/g6bateRkStjQKip0Q/W4MeQdwtn49QFfdUDJYQk5v2K78bsGp8PFahKJBOLTfn0WkytYzx9dexbJ6kH1S46ieVwn9ATI5ul4bvwjqk5L4ViUgjv1UcxGdVBRq49IJ4UVQ0wpgJzdJIYMTq7Pwc/Mjvxqi0PXXaNvu5AVYPtYGGvCp4zAEa/ygHEsxWhbW/wTLNcbnLZ50FP+oy1WcYwyRfSOOh5YlMX5M+7Ve+gKBNeGAtwvsDELJlMHGet4fzH2SdRKXbAbEGtIu+1pQVSZ19/fuNIapGMgYsUA2A0qQ8rvoHr18NysujDHSk3HeUkAYijq+S8bvs1lOrbrs5KVfWawE/SOJrGbXGLwXCPygFiqjvvR81DXEasQSD0hPoyDR3ZY2YRxEnV12Z4oN5DwfzJ3KKTIg9TOWUMy6arhJnFE5GPvkwS4DJ4JS24jAa5m4Zg+Lc0DHLiLj8E+L8WXrVDnN6zBzk2z4kzTtQz8GOpDOSrC1YjVWwDJQo/Z6b65gn9mDsz6sj8QZFEFr/tg6Ikbe9p1faoOJByqgyg39YFa6gwA+izl3U3GesEefFhYU5/m1qbd6aFENPMAPg0M560X3v3BGzz+r8JAXWQlqFAcC0KUNUZ/19OVJ88b0mIUOmS88KKCNZzXkysRU7wLdPLqRyrY7G3jLQxNKUB
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(86362001)(41300700001)(2906002)(316002)(5660300002)(8936002)(8676002)(36756003)(40480700001)(40460700003)(1076003)(26005)(478600001)(7636003)(82740400003)(356005)(6666004)(47076005)(83380400001)(36860700001)(186003)(336012)(426003)(2616005)(4326008)(6636002)(70206006)(54906003)(110136005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 17:58:27.2350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c16c23f6-8353-4d50-363f-08db8ecb1456
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

This patch adds the missing nla_policy for vdpa features attr to avoid
such bugs.

Fixes: 90fea5a800c3 ("vdpa: device feature provisioning")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Cc: stable@vger.kernel.org
---
 drivers/vdpa/vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 965e32529eb8..3ad355a2208a 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1249,6 +1249,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
 	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
 	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
+	[VDPA_ATTR_DEV_FEATURES] = { .type = NLA_U64 },
 };
 
 static const struct genl_ops vdpa_nl_ops[] = {
-- 
2.41.0

