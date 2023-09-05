Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB85792BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbjIEQ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354693AbjIENeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:34:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFFCCDC;
        Tue,  5 Sep 2023 06:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daQIRZ9/EiK1D1c+NzGBZ+DkmCdzaQptcqbiJhoKZwUWehPhDi3rRbfBbNA5C952YrX3rMoGu5C29RgvX01M5WXIlntEoUxio2GxhgkEfzuEfqqZHzzSQESid6tR9zJCW9Xp2KR8meOpAei8yQsSHh0PdgvlC76U8J5v+GrhO0U7dj+RsjquxrrB5kAtpMfPvgXf5KwQ4equBYrv6gbFjyAF1gD/SvjXSdXv9yF9ThQu/dAyLTY36Zaw++dK6LchUgn7OzXOHTy2zH+HKd6FwBorXLupc/kkQj+tugbQEciqvdSKF8SWVDl2JTZABT8ITE55xpHFfp9USukb79YZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS9G98LB+jAuAWd1v10rXXIsxxAX0S8B8XysschkdQ8=;
 b=D6KvLkMtcsPvsKCFsbwiret0OSTH759jksPeghRFDVrfiVTyb87+GPCkOEd4MSUUUqiTvCpjc/2pur8TtjPOzA22Wj+5oVkelULPI70J2Y5ZSKd4JUuwqDLWmuyNsvo3ngMquhx3bt3fp45/T4tKsy4Y3GmlfxtdfO7j932cpu21FlAhz47dHwMeiyzAzkh7LQNHPPbybHCvv142EyF6wGNVLcwZd4+tgMAalpr0117vorO3Aari+MLxJT4KjaGuiLRcByNZO8cdNsR5Y8omfulml8PNSaL8dvwD8HZpo6xPvN70EoFeRi/UUoMJVHqC0PKJ+1TZ/Ykw+q5Ai9/flg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS9G98LB+jAuAWd1v10rXXIsxxAX0S8B8XysschkdQ8=;
 b=r6dWzP3fF2TDmEub1ofZWZVSUkVjPeljaGpF8fk63xzRYC5D4temSYDamymXFAlElfvLR45W6kFgc5WYe+YS0clr33itkYxW/n0E0eNzkfiLikb0Ga6BtUt49LSlzrR79hy6IvZKvxu/hgqCBCKdRFF3QS0x/a4M4fVdY+Bkphos20OB/hMEb4W5uHFPDQd8JKhaHtvJ65WIaRPQL5QmiShWSobMqgzLnIva1OzT7+j4lCSvS+gboTd4wDymHQ/vZ9BKHKuLHajWq6nnlyqldOGOoM/3O5OQz4N/7pJydAchdyQAv2Pqwa19Zocf3fX83o3Mh8MtZmwz5wkCNLjjfw==
Received: from BYAPR02CA0007.namprd02.prod.outlook.com (2603:10b6:a02:ee::20)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 13:33:02 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::6e) by BYAPR02CA0007.outlook.office365.com
 (2603:10b6:a02:ee::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 13:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 13:33:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 06:32:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 5 Sep 2023
 06:32:46 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 5 Sep
 2023 06:32:45 -0700
From:   David Thompson <davthompson@nvidia.com>
To:     <hdegoede@redhat.com>, <markgross@kernel.org>, <vadimp@nvidia.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Thompson <davthompson@nvidia.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1] mlxbf-bootctl: add NET dependency into Kconfig
Date:   Tue, 5 Sep 2023 09:32:43 -0400
Message-ID: <20230905133243.31550-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|BL1PR12MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 746e0831-5a22-4d71-e7c8-08dbae14a061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZKxrzQHh6oKk0hG7kAnMsqdnwcNrabKRxnik7PnDooCY8FuyPQm1H27kBvJ+3PvsVGd7auZg6jJ1pCrfiLPjsHkxoAVQvEPkrVtzKEqDHYK554OGkNrTPFFhX3mu0h5yc7PLUvvfFY8KfpnLS0zRmkpO7YXe0sz6rVnWCcSsJNjRtGSt+6R145ZITZhPG9bgZBWNeN5YmHlMFR7eOO9LsjeKfPMjEJgCLbgHNDcnHmHOypus7Uh+bXUsyhx8RZL2Qv/GF/Hzwj5EUdC045etLwPMimRSGFD50gckciVBNd3cqLYJHOTS79PUa3pSMusRtwEXkA4VoxqWz2lYlsorcQsQXF/5RAcLosYS1wDfMlpBc8W4SH/f3AgFGE+tTui1t3pBvLMDQebH6CxVX2AfeUhvyHaMKWiN/ibRfap3xjnzPK+aANQK9FYzDFV0QSYWXEStAWO8brBaGpHTLw15204n1RcCQLqMrqgPlYbfB8EaMqr2JE7EdPa4P/JbQJHoaPLxYs/mmZET1pO7o8LwdHNXqos/ASNb/s2szTxVkoXhjXk0pY+p8/y5LwyaU5c9xzlqWfZxk2wqLHj7hsnG7BPXRhoEA9x1NOm2CI9UXBqO/oe94Tw6JLI5A4QgHQGKx733oOoR9mR9vU8TLEtYqy8aeGpEBgb3cLWERiT+nJsp+naffRwR+voGhsq5xRXihaQiT0gZl6Assa6Jev4X82Zq7c8HrT46+3fSOH1ycSubkDaBTD6DmRGfQtGQ3XQurm4Q8n2HsfAjJjx7P8dRdcrZh3tiMb/xvSmlXpsepY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(7696005)(1076003)(2616005)(110136005)(86362001)(478600001)(83380400001)(47076005)(36860700001)(336012)(966005)(7636003)(26005)(356005)(82740400003)(426003)(70586007)(40460700003)(8676002)(8936002)(5660300002)(4326008)(36756003)(316002)(6636002)(54906003)(70206006)(40480700001)(41300700001)(4744005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 13:33:01.5469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746e0831-5a22-4d71-e7c8-08dbae14a061
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of the mlxbf_bootctl driver utilizes
"sysfs_format_mac", and this API is only available if
NET is defined in the kernel configuration. This patch
changes the mlxbf_bootctl Kconfig to depend on NET.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309031058.JvwNDBKt-lkp@intel.com/
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 drivers/platform/mellanox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
index 382793e73a60..e52aea996ca5 100644
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -60,6 +60,7 @@ config MLXBF_BOOTCTL
 	tristate "Mellanox BlueField Firmware Boot Control driver"
 	depends on ARM64
 	depends on ACPI
+	depends on NET
 	help
 	  The Mellanox BlueField firmware implements functionality to
 	  request swapping the primary and alternate eMMC boot partition,
-- 
2.30.1

