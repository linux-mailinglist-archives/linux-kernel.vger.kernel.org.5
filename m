Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A9785976
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjHWNiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjHWNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:37:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50298184;
        Wed, 23 Aug 2023 06:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4nbaBXpsY259lqIW+rHO4CYKzS00iDLQFudF1M9bqEOKb6UCyOwfVt45FTb2e0hmYxpbEfy44v1vmM7VdFCE1YW8UwMfY6DQAcbAFi/pmqISOXxp4ZLTvQdbl6BrqrMc/z385j8hOxnI/Wcu+YFdeLN6lr4nraeJ4qSYbr1SdJIt4kBo2Re7tRmHANVynXoB+UQZ19Ycz7Tey4jx8RjJWn4lBm4gTWPfao5a+ap8RVrtn1rk4lG3QdPmj8i30RDiIp0rs5Hi7rmavEHeDAUf8uuBUXwZeN+PbFXhBV30eaCJiRd05vme4ski0tuSNsORlTqcyPDPmwgGlV/LX74nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLFt0UIDokvByyMGlHncPf52dWJ1eSphWwflNOsuKck=;
 b=ctL9uAABXQq4GonSQvkf9yrxIEv+scQ6+GdxWwol0rGxh4xWJOXLHa8WETuHUzG9Gu0AO8O1tgw55ycDcGTsXIXuv173tyGtq2fwZ8Uvd/oLLPlguQdDSZJ/UsCBFdJLjtVvp7oAJGGu5BZ2T5X+8xvxLZ0uGwV8mfkiAyM467ycvxdyRqbnAfjbKOt/nDxbpAv456m91G+PhyBo8twxO9kaF+04vFp/LAAHdkeC/rnGaF9OteAxafu/O5Tf8djJj5bnYfn0j0VgFoE3qJ0Fnz9xUQourxmq5MCM3OI2cg28hDv6ij8r39DsUVmNr2CRP7F6F0ixO9o5GLM31dbDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLFt0UIDokvByyMGlHncPf52dWJ1eSphWwflNOsuKck=;
 b=s5AzpQW0JHQzyC8P4AxxK79ocutmIDhhPO7z/S1njOVzCHE8i/qhdspHU8ZZ55AipEOwO3m6n/Z4B4Ka9IMObv5FMdhL3WEvchs9GQrtevq/dlXHEZyeJjJ0WGqIv01Sr1XOdHyz7wZisfzQ1o5QOzh6MBJit49q2MSCRKM+Orky2WVxYvfegpLRmKXHVLPzT/5A4wbX8ThmWC78Dc3uheoW0pXWGHbDf1PIqSJ/R3HydUhkdF3TUwxcBafdrXm9YGNcu8VAnLCgOdqf0RSjF1MP0ktLC3Nn2t4eq3D8eFmYMsFGHhm7CvTZWI/3a30zOlZD99cb9SR+gtJYbKkjdg==
Received: from CY8PR19CA0024.namprd19.prod.outlook.com (2603:10b6:930:44::18)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 13:37:54 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:44:cafe::fa) by CY8PR19CA0024.outlook.office365.com
 (2603:10b6:930:44::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 13:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 13:37:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 23 Aug 2023
 06:37:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 23 Aug 2023 06:37:46 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 23 Aug 2023 06:37:45 -0700
From:   David Thompson <davthompson@nvidia.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <asmaa@nvidia.com>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v1] pwr-mlxbf: extend Kconfig to include gpio-mlxbf3 dependency
Date:   Wed, 23 Aug 2023 09:37:43 -0400
Message-ID: <20230823133743.31275-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: e0820464-84bc-45a2-5b67-08dba3de273d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKl0v/oHp4yoGPKusBo58nXoNYZyx2TEbHSMWHxcrUuSGNouOfSWKn8KBEi+hskyzFPO6Uvtt1E2DMikVOBrh+9/wgzbAlfXtrK5dhlwua1XgLAzDo9o7zaLVbdckK7fcQi/8kxtIqOjJjf5gE9M+yn3M/s4ynwxAZBwqZ8gKlMlusD74NQxNqYvLC7WFlbRg8VK83rP7NHTXKsXVB2Gd8BDx82chNmfs9o2+aMDn4IO919YB0WyxdjxvGhdli9r8kw4J2dAnMNR6mfg0CkJE9/Fi9c7lLYgfpDuMnzwwhtHW7jq8JiB7Zvnh5FrfUr+c8IZcNaE5ZUclgQgEZq9ZtOBpCLjMynPC0seIEd2vrykVz3ToBsgcqYh/Ztq7lqqFnxxfv/5CGSU1W2upf1qTipE7In5ooonOea5KhMQbdKgp041jXg2nPkoHajWsDy8MdOHKaXZfumUGge/9Lh6nWGgoEKvDXpLavhMkukQCw3GpDWhPRkfxcXUSesW6CUGETVVdhPS+gTcorKaCbhbv7tPDOq20f5GgG3aJuV6dI03PSwsvEt5ESYxXa0+Ja5L6+9eG2/3gxQyIwoGNIn0+MiSksp0l8x2Syg767BX6+nN09T6YfUl6OTAeYc0HT4qlFNMYohq6PWoxtVXbT0BF9dItf6zPjeKO1u6KeL7RRnFOglt2VnxtzPOfOVnF3Je+jP9p3SZHVFUmv2RFDjSxZjIazMVsn8LlI3bSu7goijDa8IMxHPzcV9ZdHQ3YJ8v
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(7696005)(2616005)(1076003)(107886003)(40460700003)(86362001)(4326008)(5660300002)(4744005)(2906002)(70586007)(70206006)(54906003)(8676002)(8936002)(36756003)(41300700001)(6916009)(316002)(7636003)(478600001)(82740400003)(36860700001)(83380400001)(356005)(426003)(47076005)(336012)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 13:37:53.8519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0820464-84bc-45a2-5b67-08dba3de273d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BlueField power handling driver (pwr-mlxbf.c) provides
functionality for both BlueField-2 and BlueField-3 based
platforms.  This driver also depends on the SoC-specific
BlueField GPIO driver, whether gpio-mlxbf2 or gpio-mlxbf3.
This patch extends the Kconfig definition to include the
dependency on the gpio-mlxbf3 driver, if applicable.

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fff07b2bd77b..62f592e61733 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -307,7 +307,7 @@ config NVMEM_REBOOT_MODE
 
 config POWER_MLXBF
 	tristate "Mellanox BlueField power handling driver"
-	depends on (GPIO_MLXBF2 && ACPI)
+	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
 	help
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
-- 
2.30.1

