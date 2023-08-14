Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C6F77BF60
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjHNRyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjHNRxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:53:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7810DE;
        Mon, 14 Aug 2023 10:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jcen/iKt5HjEDh39zyot+jZSeVSRkHSfRTWRVRK5GGPTGCfCVgQnWauczxPxGfntVtQO8d12BI36oPUH/ZlZYP2+Xu4TtF07FJ6/BrNaawgMMytVhdF95jUBXzKaD30EpSJ+M1u0bcgtGsFeY1JGsUFUFAQfASL9+nEb4V24H+DwA40zmmknd3Yn3Z2dDbXvVRfUE2Etf/46AefXWc/52y7GwlaWyKC3ytiN6uRZ28kLc4p/68MTIbxERsy8/mZn2c6AT1asewsTpfJV48NlN0y+ovpmAMx0Y9hBNYRtjQ41oIyHN68Z6U6Xk0A63hxtIpaDsXNWZioZDcwqHaMnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMN6WhXqUtTc1YiWF0LPPCAGNDnMp7uwKlQ5cu+2LXQ=;
 b=LvIP6vG2tWEFxxX4C6Jg4L5qdVfrlrjgK+vXvqOPiQX/xkOOPfOvFgKz1WiUM7gAcDyH4nOq5kBYa/4LkukoLqn1i3pt0SHjV7dnpGC1ys9keZsf23oS39Fb2tEiGBYSdChSE0lr2bTdPHLwXstdtECxupuB8y8fbozIYVJnIcYr2XJju+mYdPBGOFiiQ6L7ghnyWrdlM6GDwIflGqjZgiNERyOrvavFlww68VCBymrc+hDsB/IrjvW8VXeoxe1rX/3nin6XaXNdHnRc2KWxI7Z8v5TUNpOgcg1tTUtllYpnoC7+QJzyAbuPXwEh5/NK89lRngH3uAMgtWtbKivNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMN6WhXqUtTc1YiWF0LPPCAGNDnMp7uwKlQ5cu+2LXQ=;
 b=mRogemFavf2ZuGaul5K+1ixyEtBXuZk93RBdv135rFTsZf4Qinwb5XLE0+9U/k8xzw3bHlDJo5YIgCfN3e/vPyObFjzqwFlf6Q4zYWsIvzzlM6rTKEgHGqbN7hwk4ZsPd/jcSb2cjo/oH6a83M164whADt0crijS0Yvvh6GVqDAy+64NdVoKjmYgj466L2s2I3eprhQaNG8wYR67nf4JYKWsLfaCdE21lOjmagLuRguyc92w35Q1Oab9UWCqvmZPfA5ODb4/3ocd0/J8b6DkYApQ9hmwf9UkwRgusheCgCDFc9NOFg6TFRuxppZcu9rvcvq8BfNY75bU0lW7xfXEDw==
Received: from SJ0PR13CA0118.namprd13.prod.outlook.com (2603:10b6:a03:2c5::33)
 by PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.23; Mon, 14 Aug
 2023 17:53:33 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::cc) by SJ0PR13CA0118.outlook.office365.com
 (2603:10b6:a03:2c5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.13 via Frontend
 Transport; Mon, 14 Aug 2023 17:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 17:53:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 10:53:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 14 Aug
 2023 10:53:17 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 14 Aug
 2023 10:53:15 -0700
From:   Shiih-Yi Chen <shihyic@nvidia.com>
To:     <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Mark Gross" <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>
CC:     shihyic <shihyic@nvidia.com>, <davthompson@nvidia.com>,
        <limings@nvidia.com>
Subject: [PATCH v1] [v1] platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifictions
Date:   Mon, 14 Aug 2023 13:53:13 -0400
Message-ID: <20230814175313.7101-1-shihyic@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abead0e-8e25-4063-f6af-08db9cef60a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: heWfW+VF4wTNRj8wpyom9ilJACPHFUJIB6Khqn6Q2NzaaBlMwDjWiX7OWQ0qPBAqJhgZau2CdfWt1KnimvHSVeOtRhxi5ED0jSpgXEk7r8eZnDWpwmcBw02eJzL/U83PIcqBuDTqj1DnfJOV82VQ0x7QTWcExPVomjxul+a5DA9uvpslO6wwto41MG+C1qgT2HcaPejoeYyWJjm0TjcTDjJNJ5SLbrE8XUgoH95GlB5NcyZILEnLwFp2pYCVU9k3bA3MDV/75Etnw/j6SyYo2p88NatIPKcAiiPAbT3rFyJt+CGKA1VR0tMOzN5miHIUhCnwX9wBq5ZaNCKwulVEcvDpbHbdvE/hc3DSp24GzVH0HZXRJjbSDtQZ+44wXrxY96nohrfuIZ78Dn2copnamGnMa/OsEEEqYOebgLjvqPC9nZ+c2RvnekEyWrOIbzsKNhMofL+UGltJQxb/I4MHzUEXG3W4TUagKw6mVA19Ro1XZE5tUxo9yVxYHmu0Cz9cDSBxHhy5ubyPH/QwV/2rJ+aJWX3kaVKV55PYxA66dC9gnEhV/ap0wBjIVdIxm3vHXP1PVif3fYNJLTmjdHTc2NZw4LDeyuwlAST3IFzAwaNoVpU3KLw/lqupjZuOxShoSeONtyzL/fF34lPOMrOZspToZd+v7oATAMO0tuwb8OXFI+03FAv8v8FXqM/vcvak7JBytqqgHQQffPGgRW1VFKSYYUd1N+He54CF8H7vsbSbTUbwJS0zj6/aZuVMNhyQ
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(82310400008)(1800799006)(451199021)(186006)(36840700001)(46966006)(40470700004)(2906002)(4744005)(70586007)(40480700001)(316002)(41300700001)(70206006)(4326008)(40460700003)(5660300002)(8936002)(8676002)(1076003)(336012)(26005)(107886003)(2616005)(426003)(47076005)(36860700001)(36756003)(83380400001)(110136005)(478600001)(54906003)(82740400003)(7696005)(7636003)(356005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:53:33.4075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abead0e-8e25-4063-f6af-08db9cef60a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155
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

