Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFB7765B11
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjG0R64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjG0R6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:58:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE27359A;
        Thu, 27 Jul 2023 10:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhFpAlpceAqnHbX27Eb4cDdbqsvEtqSDpgANc05Y3P1cBOJEobhIidBiqAQczqR2WEV9fNCvWnPplzkLOEJI6TH15EsJxcRpJwMH3lRxAGYjVu30KCVko6tYkdUTWfNWi6nyquOLl7r6+zhA5yrBHNF69vgn06cNj7z7T5CzvZ4gKbaiw9Kh1mmcPKnKV3vaalZ8ll7pjKAyhFhxSKuJNB/5wJg37gekI4ZCK6qfzarVuZnHvWMwlCSZIig9g10++rVcwnKT0GmCgA8JkCqR6mqoxo3KPJpxp8SXJ8LhRTkMy+5QHFkUkYwoHpGIAO+I7mULPIGMvX/tA9GgBhSlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/3tFs4v94Tz6IrklufFaCOyoSSG3RlgQP34HXOjVRQ=;
 b=DmdcFrK4HLVzii2Xr2d+rV3RZMfzUjULfJwkK3gdJMbjYptJK+8oSTak2td5lqGyZvB+MqNKRh2Wh8XAoj3b6CQ+ely+1EXwhcEzPp1jFPhmZOV89DlwiOfhQAzZvXzobLpTYhrb6pIbi5MfNc1TBOrfoNVPeeCWAU7eNMMi1eB5UJaMLCH5R+8TIykZrMeXJs/iCO+NDXcvsseBakZVKvFmz6hgyi4/gVdjvDSjr3Z1iXYwhCefU2NHfT1OJTfv5w3n6mAHrM7xokuT5IhJNCXf8e2drvfDY4YWbswxyA1aS2e1+ehGufqnGLO7sSALw0C/eCcc0Uz9DO3iDIViTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/3tFs4v94Tz6IrklufFaCOyoSSG3RlgQP34HXOjVRQ=;
 b=Yfv940Upl4uvVhVA+5k2iWq9RMne+xXyYYCUF1CwZmD2eiwafK5v2sGg71oI7wQq+LZsAOiq27WFkthjP9TB6Uaq1oDJICgcQ6ph7dOAyBL9wveQbO/EUDr0il10I+PnSQtFtBah0WHDBuFsz9wo4U5bGKJeez99iZubbUW+p2VSW7YIyP7q8gr0J7/ot1LAp7pueCPNVacmFqDuJz3R+grGqUiHbbsXX9yQZQ97TMR61hu8WUxDxJG2bYBh4qejMjJQT5CrvsbIlWwtCwlLaYQUOUYFsDSTvM8BbJwsu/uFY5WONORQ+BHWmRUbctpHA8VwsbfWzBWl4H7NTZmzDg==
Received: from BY3PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:39a::35)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 17:58:43 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39a:cafe::d9) by BY3PR03CA0030.outlook.office365.com
 (2603:10b6:a03:39a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 17:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 17:58:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 10:58:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 10:58:29 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Thu, 27 Jul 2023 10:58:27 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Parav Pandit" <parav@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 3/4] vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check
Date:   Thu, 27 Jul 2023 20:57:52 +0300
Message-ID: <20230727175757.73988-7-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727175757.73988-1-dtatulea@nvidia.com>
References: <20230727175757.73988-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: eed779e9-cd5a-4f53-5ffe-08db8ecb1dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OxZDZPfx73XLpNIXAhMUUQhAaBuDBwihAxVvBMXSyBmgZCdzYqpclttsfzEVF8bkPkyr+j1+jx9yIiSzZtwmhtvPPxnm7TYdZp8MCgCLtEbJnPpX9k1EuJIvG11MJFHGCds8Gz+5+l/Zl3zygw2S7j5/4YWNwbVxSO0HA9JeJ/kefffLiFena0wakVfw95ny4AjhuVXcGAUygU/c7htHaDx6gNmp+nSUNjmUG26uOfNcNVCYWXptQuJztx29sf6DfY1i+b9/qnUpqax/OWM6oOPjM7i1nTciELzNkjAcK0DTpD6reAzSk9x4KQppPt8gRKXEh/j7L9nRu/B1eKNZRmy+zpn51Jnt6SQ/Cq9rngLinVHDb1VoJTBYDFxFs/R965Ho2ct70vKrdIHFnShuYLEqCb3ZTI/DROKXxaHkn8ahXrf6TNRhh0FfiITK4pn+aRFT3IUE7R5sULh+PGEzgskTF7IF4eWzXfsSSvewNfbBBLSqY+rq9TOEJOLyF1cifBKXl4ETSxcUIKt1Jt0msvX98uJEeQzDOP45opFKYkhDPadxT8B+XcE9tPIj8z7UgjT0BMnpXlodfDT+prESPzhp7NLUdBfkaQdVeSez3UZrSsJcJBaRXoRyizI6fvjsgi/uOB+oSDvCds2ds0nZWrupG1lk2H7jM2uHvz+7P53IO7iJE9JrDXkkE18qapkYDRvXy9rP1DSVoQKwDEb2v65WNWXmXlmFOIY0+zNOIDpmwhUcRpOvhUDJ24Mhf7vh
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(86362001)(7636003)(356005)(36756003)(40460700003)(40480700001)(2906002)(110136005)(478600001)(54906003)(82740400003)(36860700001)(336012)(26005)(1076003)(186003)(426003)(2616005)(47076005)(41300700001)(6636002)(6666004)(316002)(8676002)(83380400001)(4326008)(70206006)(70586007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 17:58:42.8926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed779e9-cd5a-4f53-5ffe-08db8ecb1dab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
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

This patch adds the missing nla_policy for vdpa max vqp attr to avoid
such bugs.

Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Cc: stable@vger.kernel.org
---
 drivers/vdpa/vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 75f1df2b9d2a..f2f654fd84e5 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1247,6 +1247,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
+	[VDPA_ATTR_DEV_NET_CFG_MAX_VQP] = { .type = NLA_U16 },
 	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
 	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
 	[VDPA_ATTR_DEV_QUEUE_INDEX] = { .type = NLA_U32 },
-- 
2.41.0

