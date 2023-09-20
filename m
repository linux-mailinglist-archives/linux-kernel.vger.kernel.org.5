Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240467A701B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 03:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjITB4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 21:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITB4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 21:56:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06ECB3;
        Tue, 19 Sep 2023 18:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2SwyhHicENQQiNEXefj09amo+vlpCtNRWIswMZ3TYyIAUvDUhHAzNI+FPh0q6kswCHsvuR6sxTn8kxmzMec6867qJZ+uWqx0kmgfAZKEKGJ58KW7Zy2Wsvz+PAeQ56pshgP/HSGU5MBEiVi1qc1DjkHJsEcJspdi118Xtc5ATE8gv7xeZgnzaCANHEaKBxqSnoORC67XiJnyHzSQnvd9ngoJwCfS8rQFTsXEkS5bB0wVbUDU8jVPYlvqVYe9jW3iN1G8T19EgPx9L6F8ZNtE2sG1HDp9lw/Vu72kU+OGzwBExPRhS4d0ROYRd+DBHsC5RX8INZ+0F8Wo2nGhJh10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIG0DrZqB0lOVOhvLj20UfsT/MiYdiO6sZfBcsdSvCc=;
 b=L2sX0/XQDLyNvxny/l4Wre/vXbRt8SXW7mi2j4tbcHVkvL0ZRVEEJk9f79SSq5DrKmNJkMi5DSYcL9x6gr+2g0gaTHAtOb2zWbIr2wwU1tvx+AKu309R4mzGyL6vbaRkpTfwa4vHimYAaT3jYN7dEG73SSd/bYTWn4HzZNkxT/vscD4ytgtyJiD1RUfQB8XKm5CwDA5Lq3qxK3G4XMulu8knInKBhw8pPBF53SJo0kMSKffyWiznY0kAEzacyaoCAuK3gvbci2cxV4+2nhpYSiDsibPgHxhmFY5VfHDRfKYcnIb25EwFiXKqV+Oax79XiV05oBAYukwHikjBFZCqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIG0DrZqB0lOVOhvLj20UfsT/MiYdiO6sZfBcsdSvCc=;
 b=5p+D7+YVPHOkkGEkfnMN5cMvzMysKETHILntHoRgsUMXL25INkpN+1MoTyxsGk5HoCB9wrXPj4tL7+9Erpk24eB28foMp0ZnCRkafoQu5R4jYh4BcHXLB/A0mNg/ctPn5A0iyVBTA1z5pmSukODmiyxJftUPbVz613MXIKHlvkM=
Received: from CY5P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::33) by
 SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 01:56:14 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::a7) by CY5P221CA0064.outlook.office365.com
 (2603:10b6:930:4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 01:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 20 Sep 2023 01:56:13 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 20:56:10 -0500
From:   Alexey Kardashevskiy <aik@amd.com>
To:     <linux-kbuild@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH kernel] kbuild: get rid of unwanted "+" when CONFIG_LOCALVERSION is set
Date:   Wed, 20 Sep 2023 11:55:59 +1000
Message-ID: <20230920015559.1877441-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ff88b7-56d5-44f9-a3b8-08dbb97cc558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBHNqI5d4KKl2GAsv++8B/FZD5ZF4g+6Z2pjfsxTB0aBzYCJFn0sj+0LgY7IDk9dL2G2OT2fQviSYKCjHBqgvTVJk6ahNCeAXqD9JBSyvD1BQHIQAPgqBXLzIaQc//xMHLThM02LJVauzH6JGp211IF1rPIJhZ2WAHd6qPI8n05YZExBYWrP9vjqltgUA+2lVSdDP6N0EAvIzuS5hsUYnOOmWciXe0KTnP7aruSpjwVlu0fzBb+W6IejJFAMbk3ocgjOWzvSJn3E1TXYexlaLvr9eH1y2vIfSABqGshO3ctKryp3I1A09N6hC9eEmVyKblohG10nL7fdaFRCpsPnajJcmmwNneSGtbLepsYQvubquItVH3LyjO6MOVEKsEbc6ha7vpHPW6irQ4DA9xL7ir73V/qlpt/FjkOoOW4uS09VMiaeOAK0nTWl7c/33wcOFdcH+/o3GLSnXo/FdUqsNrH+ikNUyvWU1G0oDw9T21QEFBXm+lIvfXFMNdPrlH2gtdutYYmyL5w2W5P3iLTDvf4kA0IHiToPFh+X6GBKW62rzA+jnDDWQsmvDK2igv3uLvYJRtcqsqX0EfCPay7LO6EhSeHhsDUn5rCkF5O9IyBLSBhAle3pEnQsXyk0FeVyPI1hndg/MVtFGHycM+Mr8z12bSIueiM2x4CY0GttnMUIO2BmuwWxdHHHwFo+1F0ow94VAX8MAKx95GeHSx2aX0rjt4NeI6Rjp7/dE9NsuUUrFIFd+cKdII2n6nVxZEzAJ5UTqVVWkQ6zhPm4ccj8BeAFyVZeKLhRTN6paANtPOGmOq8o9nNRMzadL3eVC83S
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(4326008)(7696005)(40460700003)(16526019)(26005)(426003)(40480700001)(336012)(2616005)(1076003)(8936002)(8676002)(83380400001)(356005)(2906002)(82740400003)(81166007)(36860700001)(36756003)(41300700001)(70586007)(54906003)(316002)(6916009)(6666004)(70206006)(5660300002)(47076005)(478600001)(26583001)(26123001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 01:56:13.9967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ff88b7-56d5-44f9-a3b8-08dbb97cc558
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scripts/setlocalversion script correctly tries not adding "+" when
CONFIG_LOCALVERSION is defined. However, instead of grepping for it
(as it is done for CONFIG_LOCALVERSION_AUTO=y), it relies on LOCALVERSION
set in the shell which is not.

Export LOCALVERSION so scripts/setlocalversion could see it and not add
unwanted "+" at the end of the kernelrelease.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 57698d048e2c..fc45bed69790 100644
--- a/Makefile
+++ b/Makefile
@@ -368,7 +368,7 @@ include $(srctree)/scripts/Kbuild.include
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
 KERNELRELEASE = $(call read-file, include/config/kernel.release)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
-export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
+export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION LOCALVERSION
 
 include $(srctree)/scripts/subarch.include
 
-- 
2.41.0

