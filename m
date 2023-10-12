Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9469D7C7A22
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443082AbjJLXDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443114AbjJLXDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:03:15 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEEDD7;
        Thu, 12 Oct 2023 16:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqYaAj1v34RBKJJ77Pkm9dleoQzBDCFpNmun2gU0968UljZvszR8BP8poizOzzqHcJOy85iZIJEqide4bMkSqfZWe4LGb8uaD6G+tl1Pvusbd0G+88K/q0i9dOTuiZQJwwHLA1nVzqsM95cOhLZyXNcCbT316T7wA5CrhaF+Bs+HwnTSVujekzAZy2R8wBmEVgG0rwpRvNw0Y1GJPDn+pCZN4YX4WWmgwrqyTJoEBz28bP92LeOArnU9nfspcmLJvY3lOUOv8CF0623+n3ORFRxcBizfuY2ol+K3ljWgvv3QV9kALWaTXXwNHyUbJ4W+Hf1jH4zjPY2MCYLU9pnBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjkzFype70iW0b9GFHLXH8amblyeWcr+4vuVvmjUEYU=;
 b=T32uOaQttJg22UbkOP9rVYMIC5dOQsOb/PbXI+eVncEVWCLTktzYKHB6TKEBBxg/p1VflBg6YO6XxsjtzujBlBmpdGKliGITc7fBk8HAn4fxvMP39eOHLDiv1VCxIpGp9vzMNY1RVxeono3j4nsHX6OjEanmFs6s6F8Njp8BTQLagYFSsphrJ54dpRp7LDO6Zlf74qtdRahZW9oDrMEVRn8udytGJkOJkgLTTwim8QjjAiKaqYrY2KUtPeKzEFmHyPNokKwfZIO5/nmmCXkPv7iEGORa/EropFmBknnDvqkRcqXh23a7U8Ei+RPlYtoOJURIEm6FqWMmq4zssQrbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjkzFype70iW0b9GFHLXH8amblyeWcr+4vuVvmjUEYU=;
 b=NVyALjhLLVsllt1lBg7//VFIcFmFOvrpnr9TfWQj+FD1dg3ZJWasyl22xPbxkwbQbZUNhCn2hmddLHDcPf+hoszhjUZ3ss7j3MGpwaP3IcAUnrtv88IHFsoT+CTLIwJhom/gdSHfRLvsRLrXL5tPpmBIy4H6nY8zF5DPb3t3FpNDmO3pDdg0Dy9X2puDWLrUio/KI88PMdkFa1V7IscBLErrRUJ6iQVDbC2TcApZpsd6r0ZYzUQjUSdlOZnT6olH8HX5UaJaSJtQBfQSgBXyNqQC99SlKaIAZWE2ZfYPXA1S+qDfG/PdCxvXdXh7gqq21Y98xdntTF67UyrQTkrz1w==
Received: from MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::35)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 12 Oct
 2023 23:03:02 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::87) by MW4P223CA0030.outlook.office365.com
 (2603:10b6:303:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Thu, 12 Oct 2023 23:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 23:03:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 12 Oct
 2023 16:02:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 12 Oct
 2023 16:02:39 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Thu, 12 Oct
 2023 16:02:38 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     Liming Sun <limings@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] platform/mellanox: mlxbf-tmfifo: Fix a warning message
Date:   Thu, 12 Oct 2023 19:02:35 -0400
Message-ID: <20231012230235.219861-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <bb8bc77e6ecc2287fc9110cfa08caa48eb2a0385.1696508228.git.limings@nvidia.com>
References: <bb8bc77e6ecc2287fc9110cfa08caa48eb2a0385.1696508228.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: e513000d-718a-4ed9-338f-08dbcb7762a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QKujscur9SY2RPsOdDZ4/qUME5/O+qcjPkkOWDgJKqsritg2Ho31B0BfiPN2h6nfewUcu2zWxjsJVfXKh2oMlNHldMQDIxB8va2a+GnFuESGlqhsC3eLh1lQg5gsqbtoDkNfNWB0rLEiqy3bGt0J3qTfUxUU6SKqBxjpXF4ldo8tIVFrKr7J1O/hLz9mortuxhAZzILiwhXKNtf0q1mUYdfCD3uwaTPkfW0Cym8npZS8gANRJiRPbcUwXkeV1evSbyfGo5/O7NT1Z0gR6rxwvYeTuAds5l8zU5TnIXFmmUxxrRnft6pbwDTo2BKhQsuI4tOyV8UpvNtLIBNOIpfYA6NBNqxXm4HxJYroXkNF0k7ONFIjIimQFAGW9qVsDHvRxfhn+BE/el8Uuibco04uMCg3/l6F+w05G9z3r3kIiE8n0MemUG5Lr+vx0C8OOIuzwJfLT2Xkh1zhL7I8Gcquo7D/V7rzMKHa0NHF5+UTX9e4UgB7A5yT67m2w4L7uvkU9Q9sRE5F+Omw1e7symJxjlCXq4t2Va9GWvuW6hhNYNn1gTgyjVo0UYfxbSTbT6MpMGu7DNcNHpt4WxazP66u8lRuV46x76ZrnmmfrDLWRgZAJp58fo8Ih97Zlf+fM4HHddWNQGLXCoN6zX/3E+Ml5ZQSaZICoYQsx1ICWNrhlhSot90Yr2CS+QB3NAC9N+7T94ZJRAoQxhyLitfzSablfsRulVofKjBPvUU1m62sGafJ555SjYQMkTwV6ZCFwLh
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(478600001)(36756003)(2616005)(1076003)(26005)(426003)(2906002)(336012)(356005)(7636003)(82740400003)(6666004)(83380400001)(86362001)(40480700001)(47076005)(36860700001)(7696005)(110136005)(8936002)(8676002)(4326008)(70206006)(70586007)(54906003)(41300700001)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:03:01.8750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e513000d-718a-4ed9-338f-08dbcb7762a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the smatch static checker warning in function
mlxbf_tmfifo_rxtx_word() which complains data not initialized at
line 634 when IS_VRING_DROP() is TRUE.

Signed-off-by: Liming Sun <limings@nvidia.com>
---
v1->v2: Logic adjustment for Hans's comment
  - Adjust the logic to avoid confusion.
v1: Initial version.
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index f3696a54a2bd..d9615ad60012 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -607,24 +607,25 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 
 	if (vring->cur_len + sizeof(u64) <= len) {
 		/* The whole word. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       sizeof(u64));
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       sizeof(u64));
+		} else {
+			memcpy(&data, addr + vring->cur_len,
+			       sizeof(u64));
 		}
 		vring->cur_len += sizeof(u64);
 	} else {
 		/* Leftover bytes. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       len - vring->cur_len);
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       len - vring->cur_len);
+		} else {
+			data = 0;
+			memcpy(&data, addr + vring->cur_len,
+			       len - vring->cur_len);
 		}
 		vring->cur_len = len;
 	}
-- 
2.30.1

