Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9E37B9E34
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjJEN4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbjJENyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:54:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D5261AA;
        Thu,  5 Oct 2023 05:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdgWLuqnaWyR8SetD+KAHA5y1l6oEH7mYXb3pffjkes9lVfut1lhQ+hgyRkR6lWW6EQx+b6WP5FObUOAXHST4ErKNNTWhn5IuPf0YTsQfabNEvdpexZcypBsazRzoe8brQ29Z6/5CNzAzn8j2AWQtrEQesYGQtbaxhSsvkpHiAS4q+B3/NCF6wwMVRSknJXewQKshK60LMnaIe4Q7bfOXs6Tjz5SMK+i7uf4OKKAdM2fMPf5PB3sH13pICluxkAxnVhtWdOIciZZzGsiUA4RUwV/ZG++mS8BKq+KuxJF+uK9e58e9URaZkPi9DLacTCjvjFnoutXkinMm4TQcm4rPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8pCM4h7jsIVZQAzLcbu7enq4yK8XeBa+NTzQJlpjT8=;
 b=Ygw4FCjFDXtHB20H2laQVQjhmoso0rz8bn9iV3z4fGOISdSO+fhnIoGdUcuIyUUOL+sGAXyB3qQtzlkmcjultSjLw4U6Pavy4LNM0U5DXS0R7S9E/7I4jm+D2eHVJ31jRp+ZGyaYwCilvGBK4lOqnroH8H2pgAA9o4xtN4b+f1Lov7g/YnpsNZ/iCnrNOF56TKcAySQs4EoNUQIMM2N9v9j+z1q0XFt3DWfMIER7xrUQyjV20Sw1hZSfx5BMRps44frOgHuwXsQUftBBgbzCThLZg8jh5Qd6O20/qrN/BVAGz7dhJe1XX9ZffAFUj815kRyw9abqWGHpEf4A5U1TLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8pCM4h7jsIVZQAzLcbu7enq4yK8XeBa+NTzQJlpjT8=;
 b=cKNtycylcJsQWaw8Xab43joCcXkInaRpvbB1sWR4HZ2TGh5cnQytGg8ZSdQzNxEq1GShS12KvyLPi8WNcFh2i2MXTY9d5vJ0zAHNwB9/ItaylA3OetSyax2jXCYniWB1It0Zq7BpKyhGqlb02uYKAZY672ZZEXZVHyvApNIn+trh85ouMciiMxiLp/XvaH1uj6mnD7t6JLoCUrJblCvM1ATUn/gO3ZOCKpbyHk0R8sUip2cSfdF/sV2uLRcy88XpX6OPvdqWTmkqvu2WXLNKl3ZNH3Xcqq1x3W15Zc6i34UpWOxoIRtByLuVg6mV34OmgWz/ddqO+90GE14amjf5SA==
Received: from CY5PR22CA0080.namprd22.prod.outlook.com (2603:10b6:930:80::19)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 5 Oct
 2023 12:18:12 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:80:cafe::bb) by CY5PR22CA0080.outlook.office365.com
 (2603:10b6:930:80::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34 via Frontend
 Transport; Thu, 5 Oct 2023 12:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 5 Oct 2023 12:18:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 5 Oct 2023
 05:18:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 5 Oct 2023
 05:18:06 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Thu, 5 Oct
 2023 05:18:05 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     Liming Sun <limings@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a warning message
Date:   Thu, 5 Oct 2023 08:18:01 -0400
Message-ID: <bb8bc77e6ecc2287fc9110cfa08caa48eb2a0385.1696508228.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: ce18e61d-7d77-4706-baaf-08dbc59d251d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ccBVT5j9N2hkj5fabTY339HyJ545sDr9wyYtQQcfm4wHXTKt6vPEDQMMvxix1c4ikiqT4ZiKJU7cYWNeWtKrh2nd4d5mfm3f2HMM9FlrdsgtlnI2jFZ3B5DxRIrnFjeCffMg+f9UDHNtHsocu2DyQU7jfMKAGXMNSAmqG8gI9JU2aHGuCPzJJbKQIGL7+yrP/3snS4vrNPB0N5w95/fOu4ODyRxCsHn4PFIay1tJBj2/SaxhD2ohbKy0x5F26+jKe/52b6ZLlCUmyEQxKn1wVlfua12eFe3fjF0bfzNs9dpSBpVVrLEZoPiiE7lczbpCSvTCGGz2h+ryF78N0Fu8fwvWhWRC1+k6eczqoyCOSdzxwZgWaQSykHXBp1wT1vgWwx5p789lFheXl8G1smJOnOCz1Fv564mtJw+eZQXqkINVK5IeGfl6sh5ufFtBnXGYUDBfDKFenCi4/4E3ElHro2MQ00gFqgfarVYSMOBpkp3sdnxVpJup2Yip6Wmk2TVD/2PGfDzLqdaRl7YMy+CNJe3H+0/mPfFQyh7Y0oUYz4vQIACoVoIDGilvEB5YMfAj3yczFgU2cz1YfOs6SKDnABtuMciLKRbVmnujkGw1V0vzg0rI2kpRmtLMSglL+6tgm07s1oIq6d3vvU93X/ZE616rtIa0qXWWfNEPls3QPpEZ8JJvDF+OHX9TZLzQJ4yF1A9MKr4bUjML/M27NK9hLEe9XDrODOwUrtyeqgE5kJF7RTHdnlaQyIRRt7WoEokG
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(6666004)(40460700003)(2616005)(36860700001)(36756003)(47076005)(2906002)(86362001)(82740400003)(54906003)(478600001)(356005)(7636003)(4326008)(41300700001)(83380400001)(8936002)(70206006)(26005)(336012)(70586007)(7696005)(40480700001)(316002)(8676002)(426003)(5660300002)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 12:18:12.4893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce18e61d-7d77-4706-baaf-08dbc59d251d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the smatch static checker warning in
mlxbf_tmfifo_rxtx_word() which complains data not initialized at
line 634 when IS_VRING_DROP() is TRUE. This is not a real bug since
line 634 is for Tx while IS_VRING_DROP() is only set for Rx. So there
is no case that line 634 is executed when IS_VRING_DROP() is TRUE.

This commit initializes the local data variable to avoid unnecessary
confusion to those static analyzing tools.

Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index f3696a54a2bd..ccc4b51d3379 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -595,8 +595,8 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 {
 	struct virtio_device *vdev = vring->vq->vdev;
 	struct mlxbf_tmfifo *fifo = vring->fifo;
+	u64 data = 0;
 	void *addr;
-	u64 data;
 
 	/* Get the buffer address of this desc. */
 	addr = phys_to_virt(virtio64_to_cpu(vdev, desc->addr));
-- 
2.30.1

