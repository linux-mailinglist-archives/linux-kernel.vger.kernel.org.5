Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D3E77BF13
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjHNRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjHNRft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:35:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF210D5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oV3+Ik0492m3BgsgQchPGh1y+6q2i8RaWQzOqKoyYEn1LxGO2hZAcRsemXGaYAgXeL1JKr45nRz7lPz9oVhu0lI52ImEiBYktnJ17qpeq14QrQC/8bMx44nAcZFs2ISFlXxyWMGBpFAkjK+Th73Vrr6lBkc0/5IVaWafKx7EuSB69xJ2di6ci5zbTuGHKXKUl8Lu9tnYHEUxRiAPJlyqrljUlWMqD46C8ZdwoQiVixqv8M5qfO80BApmWPpDvf4o7J1BbmYrWfUc5eFM5izOTFKSQIV13+x64RcFZHoZCNYwC74Lif168Ow+iZ1kbjN7iWSYJzMuibe9KYZyr6Fwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMN6WhXqUtTc1YiWF0LPPCAGNDnMp7uwKlQ5cu+2LXQ=;
 b=aGytxPAxPDihkVAb2yEqzwjeRUf4h466ks3pwJbOTFFHWXIUldKaT2X+Mns5nZcvMdSXOpOBEEMN8946DTaSJ2Nl/9T7PDPx1Lke0P00mJsJE2vACPqPxqDKd8uox3OjcIJsBLeKBXDwAL7Gt3IfhHcFk648WN+2luBTMfvgb92M4wI/V/4dWe/B+wc2x20Vmn4V4+GpTsh4tFETxisIxJt8YPpujwod7UHqcTKn0Aijj5MOfcwh9AUSXegNkse6ra4NVxxBx902XGXzJFOD99RTVYnt00Mx/54/LkuZ8Ax1ADPvF4h/JJp/HiAdP/3sLof4wJKdlNi8fbEeF8GLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMN6WhXqUtTc1YiWF0LPPCAGNDnMp7uwKlQ5cu+2LXQ=;
 b=rmdbK/d+6ogHvlx/ug0i5Tzrp95cGnCXyAygUjz7RwUBjCkGkHjmmuvsP6tWjbzI8pHBTTQQ1agGt3jXFNm9uBhKDbeEWKtWwocyQ1vs0wqlBv1awmSRWlkmY+PXQfeVqi2yKkRAGh5jwI1Se7UWiG4cblNYsyBeqkIuQEFZ7RS+sP8KcMusjKcgT1fjxfH6Old/D8VBR1re8P4jL6va5v1uqiFprCjTvHBbf7kj5PiLMobbWzff30daqhnUd3MChIZ5hAPm4ysIPs+FC1TCQN8ITR6STAVDOpWWXTYIjs1ScEl66NLiUWlIox4S2hk8Gh3agpesAfp5dXlSJw9HlA==
Received: from CY5PR22CA0094.namprd22.prod.outlook.com (2603:10b6:930:65::14)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 17:35:45 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::41) by CY5PR22CA0094.outlook.office365.com
 (2603:10b6:930:65::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 17:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 17:35:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 10:35:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 14 Aug 2023 10:35:35 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 14 Aug
 2023 10:35:34 -0700
From:   Shiih-Yi Chen <shihyic@nvidia.com>
To:     <linux-kernel@vger.kernel.org>
CC:     shihyic <shihyic@nvidia.com>, <davethompson@nvidia.com>,
        <limings@nvidia.com>
Subject: [PATCH v1] [v1] platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifictions
Date:   Mon, 14 Aug 2023 13:35:30 -0400
Message-ID: <20230814173530.5762-1-shihyic@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0a94c7-cce2-459e-923d-08db9cece3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvviSC/PBmbSqPsfnlG6KqqMopiuYlzCFsA6WjpugnOrimJo/wzIxHCg6OXg2I9fsRCJMY9n2zbokaNJ/uINgSOIOyZLsyCv9vM/zCCOa3sIau+WBDkJeeFd85zbJutHUPBlR3f35KUFcZNly1bW21Zqh02ZsUmIr2NESWtZvhV3Se6aBWfSc/9Vi+jrE+VnMHsc8GLGF6vxth1eTkDPRcatXcc5lOtzxYRj8i/A/Xz7QFeosmxDUnIO+YvbVizCRMxK0jz4odHpisEfQb2KRHF7jfscjXeDn3HuD1WvWtg6EPW1O6dhpv4BoXRYbK8zUWXEHG3IpjxoAXEx744dVSfFyf9AybgBIoxWA2R0o+JpgTeinb9XoX7bya47AaMq968BptkghfncP4eoXBN3uhjA7eP952iV8M0kv6C6WVxBNB74hhZaDE03dpAVt48ojZBY6hl6Q644BtEV+VysUkW+Ycg6edL2rbtE7fNWHDbMG0sJi31PEvkqHQDVYvovZqkUVWvyZcC2ZOU67ieqiODgXYEsdbVKG75ORVw5hHW+VkolZljys22fjYcJB+YxMinIm3Zee0MVrEHs6fRABJGxpk0sl0KacnKsYBNThR9hY1DUd9kyc76pSQEVy1TsHJHd3rXMAmLQBs1W4P+gUt26DqymUcbW0ERdjE+UMIzXfshL+3L0MWeQHSRDh85MJrsNr89J7K1YQsCSGXkw6aA8BmG8wfegagID86SoacmACRuii5uGsiPR5KguHOhb
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(1800799006)(82310400008)(186006)(451199021)(46966006)(40470700004)(36840700001)(2906002)(83380400001)(40460700003)(7636003)(336012)(426003)(4744005)(40480700001)(356005)(47076005)(316002)(82740400003)(36860700001)(8676002)(7696005)(6916009)(54906003)(70206006)(70586007)(41300700001)(6666004)(8936002)(4326008)(478600001)(86362001)(36756003)(1076003)(107886003)(2616005)(26005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:35:45.2266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0a94c7-cce2-459e-923d-08db9cece3ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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
 

Signed-off-by: shihyic <shihyic@nvidia.com>
Review-by: limings@nvidia.com

---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index a79318e90a13..4561b7d42412 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -887,6 +887,8 @@ static bool mlxbf_tmfifo_virtio_notify(struct virtqueue *vq)
 			tm_vdev = fifo->vdev[VIRTIO_ID_CONSOLE];
 			mlxbf_tmfifo_console_output(tm_vdev, vring);
 			spin_unlock_irqrestore(&fifo->spin_lock[0], flags);
+			test_and_set_bit(MLXBF_TM_TX_LWM_IRQ,
+					 &fifo->pend_events);
 		} else if (test_and_set_bit(MLXBF_TM_TX_LWM_IRQ,
 					    &fifo->pend_events)) {
 			return true;
-- 
2.30.1

