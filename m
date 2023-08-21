Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA52C782CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjHUPHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjHUPHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:07:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B3BD1;
        Mon, 21 Aug 2023 08:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZ6I2DZZz2EUrWkCuyeg8dv7BgFqk1ukLA4J2TvVwEvPf44N2LrUEc9g79xiqD4CXLyXlxPdpGTlNKGBKP2LJ0u1Qm+6TlhEvAHnfDTCkyLxsXJu+DFUPLGdHzMsbC4mQHNl9v4UYy18UPAiF0FL5FQLKcxQcV7bHqee3EPuu8VXmI8ccHh/XJai4x+nTj6AWJrpjYPE3zjKjMgbStXH1YwxJ28NcnWbXBp4JRqF5J6qqDGNTR4xcWp0Qu5pVxUMnj7uV9J6LXRt/zk33Zg+Z6Mfa4tVWZob3daNILsH/ljJI3Ye4RWAb984v2h2gSHVkR1F0QNmfPXoHMLGiasv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crmS/WivdPQKYd3aKMn/RcggR7JNT44mq8vQ2IYCylE=;
 b=Xz2A8CZt2aG2ZB89RF9sxl5QxyiQxA3gdJ+cu9TcGa2CT9dEVMx7yXVtqesr71+nylmenC41uD8mlnuuyZeQgt8cQ1hEk9jfVZ24zSoODxQB3HLxfWnlVNqtWXtDTMYV/JMbrIoO4lxUGx5qd+EvVIoEesqFNPBBBCYdF1wi6me2jxfZGS2DfcZfRlcmqS6KRRoZxtlAlVq2zqgnwagZvgcA0q2S4+PI83RzONFA6xIe9uR3C84MiXXUCQqRCwEnrQkXcGwaeY9I8TsxVaFKnzKiPu8wxDRZ9919DhYybyT1fjOJLKZJUoiFwL9rEocxsLRx1N5BKatFnP6WOygVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crmS/WivdPQKYd3aKMn/RcggR7JNT44mq8vQ2IYCylE=;
 b=LutAVMnbtx/qoTGv+gpKmq0v+Nh0LRMwg2N0rj0iHZiEAvlW2O0sazu1Ay6GzYdEw9We07juq8ijblmn6G9/fIJxZfrCQX71sUUIjBsIZZIIN0bOYCOYaFqkLrEJQhNiGIpkFjbPWWilpwodUdAYTt50q1JJjbgvKAsTf8tSY9PLHwP3OezQ8zsTDojr+o35H3tBVWxlsb9PKQKDDdYOvYIWY7/u9JMmDSLmMAnw2B/boJ0B17CfZ5zX7xTpvvgFlY1jMwf+fVQofE2dL5KZJnj88+CAOjrFmCs/7y+CcE6arxxJucswuw6M4Ab05F0/9Q5a3I6bREVgSPWGJ5DeAw==
Received: from CYZPR05CA0046.namprd05.prod.outlook.com (2603:10b6:930:a3::6)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 15:07:03 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::2f) by CYZPR05CA0046.outlook.office365.com
 (2603:10b6:930:a3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 21 Aug 2023 15:07:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 15:07:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 08:06:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 21 Aug 2023 08:06:45 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 21 Aug
 2023 08:06:44 -0700
From:   Shih-Yi Chen <shihyic@nvidia.com>
To:     <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Mark Gross" <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>
CC:     shihyic <shihyic@nvidia.com>, Liming Sung <limings@nvidia.com>,
        "David Thompson" <davthompson@nvidia.com>
Subject: [PATCH] [v2] platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifictions      updated to use set_bit()
Date:   Mon, 21 Aug 2023 11:06:27 -0400
Message-ID: <20230821150627.26075-1-shihyic@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: f8386f04-497a-4273-c20e-08dba25846a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmsJs4K5Ap08hTcN8ZOsIdEdd9w3JpAki8NDrr18EaLJzvVR5h/8UIGYrObx4PnIQnHIEtP0e2Z0lw4znQwn49HCRt80WVEWAD8MPIVIQiDUSsRtymbVpaY5ebp93iI69uOkEI6QfXtSLClH8GKURCyQoum2K+3R1Q7+MH4wsvzIJpkTXVgIpcn/OUJy8gkdOdiMM5PS/kAFSIGHeoKXXDGygNlE4KY6YclAeOOvyCBGR5W5nfd1WGLoUw2Zu6h4cTopGkeG45RTlw06jQnLn3HYquWAu9z5B/nAgAQq1klQusSXDMb2+wKsmmL8Ye3SLQvPyljYsUX3ye+uU5XTINFgAxlmmNl53dONvW86L4h/Z2qFi+HVL3HSiz56fNWTlD0Jy/dg2aL8iazUrRn9j8+xbyODLl7gAaBPZ7iO3epMDPlZkw6k1Tp4+KNXj0RXuqUhnfmBzUgL14CApR0cYBKLNYXsVpa8giJws6xPRQMebN+3O7DAq+v7NXgr//tG52FkS2227BVRmvtlDjT20xoFWhV2YwfQJOqT9/OTeoaBghLoKMrwWbPfpMlrg8eHQEb5B7NwL2wy1iXOgyzlK9M63/oHosbrCgpI8DmlK+orSCXncY5ve8yFuhFFBJDyTO1vHrP+6HS62qmeSn6TfL1OJXnywRpjsGtr2SFoLpZnWJBjncpQEI+jlf92Ay9is6BP5rIIN8M5HfPmtywYEkdtnEo5mOnrWtZSPlFlVcuCmCiIB5bobENo1d10IqV4
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(15650500001)(83380400001)(5660300002)(336012)(426003)(26005)(7696005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(107886003)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(6666004)(36756003)(41300700001)(40460700003)(7636003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:07:02.8184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8386f04-497a-4273-c20e-08dba25846a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: shihyic <shihyic@nvidia.com>

rshim console does not show all entries of dmesg.

Fixed by setting MLXBF_TM_TX_LWM_IRQ for every CONSOLE notification.

Signed-off-by: Shih-Yi Chen <shihyic@nvidia.com>
Reviewed-by: Liming Sung <limings@nvidia.com>, David Thompson <davthompson@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
v1->v2:
 - Per review comment, replaced test_and_set_bit() with set_bit()

 drivers/platform/mellanox/mlxbf-tmfifo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index a79318e90a13..b600b77d91ef 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -887,6 +887,7 @@ static bool mlxbf_tmfifo_virtio_notify(struct virtqueue *vq)
 			tm_vdev = fifo->vdev[VIRTIO_ID_CONSOLE];
 			mlxbf_tmfifo_console_output(tm_vdev, vring);
 			spin_unlock_irqrestore(&fifo->spin_lock[0], flags);
+			set_bit(MLXBF_TM_TX_LWM_IRQ, &fifo->pend_events);
 		} else if (test_and_set_bit(MLXBF_TM_TX_LWM_IRQ,
 					    &fifo->pend_events)) {
 			return true;
-- 
2.30.1

