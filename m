Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1AE7DD14F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344967AbjJaQND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344932AbjJaQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:13:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AB9B4;
        Tue, 31 Oct 2023 09:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPVwuWON2GGWSEVpdrTH93f5fdeB7OZwMmWP0qaAKxOCtJIvxq5GpseNvqLoEfClCqrQa9wkcE++1/JQ3/SuFkxgN7t0YijahrPToHSgfpiP5X7AcP9gzDHCvnAo4uQyIzjDelIu2y2VBoeHVP8mr4KaaItVp03VEom1DMs5aP/eWTP4W1l5mV8g0At2G8wbd2mtSrjf0B1orsu52V1SzTBTy2mX0Q0t02Dq4fSpYYjY1v3yVp9DUDGHtGKQPzh9JTuLVeAeseWPm/hwjRUo+Evx8EX1SHS8U2cHS6UMPqV3C72t3i8lfS1ofOQyy3CnmkfrgnKuP91lMe1qG9Rt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBqhnm858FkMMMTikZwKO/A2KpRT5jvxIeKTQUNmV/I=;
 b=H4jpiEgUNoMARG9yuMo712hsXImP972mpHpdvjyVAo13+Nly0JFkg+qi1GOvkh2zE8Zkq0TG382LKLKXwtKqFXtYwEwu8ur3Q4hdv4LOmaIv1DiOsjhT3rt/pjnhS+ymVMqCteUNiQuh9eXxVRn0pB0iJalriSm6vq2pJC9pnbdG0Q/HIeflCqaMyv1SOgKWJ7E5bz7xKZ7+7DyJH9sxxCrnblOqpmA3ls79/wmPOakM5QDq76wy8M6F3cLLKnmpuo23hwirmBkM6ZHqCaKQVbKw1F6lG6JBu2LQsRWULovXA9Fm9RIql92kZmfMpgZZlaofi8vnBrN5zrwgTMSbhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBqhnm858FkMMMTikZwKO/A2KpRT5jvxIeKTQUNmV/I=;
 b=F7uA1sP8ly21Jq6XodMAlucBbbkM+KmMGZgaKOByGycl+Xwy0B78jc9Q115BAHfjhlk4+R6YWZWT5Ojg7T5ZuJKif9SUo8NXbL09TlNLHeGTIYwk6ZOwNx6+uiaSkkkKf0dAXmpilrym1wO/rmsfyDhEIOoblw7Bg0bCwl93cePGqkrCcBa+U2QOHLxv0NuQIvy2s9WHhXjMAFZs8E6h7jVYdLGFk1ye57NOnSHvNFzOZuMazxOtV1grsy5dp92wGIuHSmHvw5zDztLxsACN/tN9CMAL5qmM0dgEv0XwlF5CcGyCj01awS6KBmHOhMr1945YIVX1C98y+QuyuN4Xog==
Received: from SA0PR11CA0014.namprd11.prod.outlook.com (2603:10b6:806:d3::19)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 16:12:53 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::b8) by SA0PR11CA0014.outlook.office365.com
 (2603:10b6:806:d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 16:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 16:12:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 31 Oct
 2023 09:12:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 31 Oct
 2023 09:12:31 -0700
Received: from 717d7c0-lcedt.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 31 Oct 2023 09:12:31 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     <timestamp@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [GIT PULL] hte: Changes for v6.7-rc1
Date:   Tue, 31 Oct 2023 09:12:20 -0700
Message-ID: <20231031161220.978069-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a59abf1-d336-4cb8-a62b-08dbda2c3c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Esv6hQ8HPKDsE8Xy1LazZGnbM+i2Zg6uxMbOE46bP+L4E96uE4QzA7TTg7tTHECH4nDWPZd4spPQa1Bq+8Yn1NRQ6sFvgTIDTxezn/ex2XnZrCy5kekn6I7y+w2n4Xh6eOVSTFD6NOi3O6JqULUWZUWsJ5LRYNoWH0SLZVaLfWoEJGrfdlP7iYdkhnetOLNdVkxRPl7B2MiEQj/UDcIdAMGT8Rnx0yi1eosf2HRq9nDt8/HWpS3Kx8XbFznAoKzT0mFLbH6zHahcZ7z7rYRNy/dy7VU4UxP0YWN9Gga2dwaGMnQn296SObR+siUmjyXDOFDF6eTVWd2q5XrYhRNVsIok0NwAfirAyDq0P0ux7Q5ED8USNt1cwol7raUFzxdhdVBWhXQnJfVpEGoTDyWSpaiqscfHzVtGrWK95frzSvoThHlLWgYsMzaIcZEXpqjvTY9g4UZ1iRG7PA9T8UVveRrEVjGo+iBH4sBExhgB6BR5ef/I9owTwmi0Di3St6tsUPkYOKMq1aTKYAUBRNS7FSl7j8SitZt7Rq6Xv990/t8n4lFpXDvxjaBdOeeSwQ1KI3PHYYhzlj6JvZtGBhLjIVm165iWhJ2Mv7oj7XzHwHej98zTGh/zzPm6NQKBkS25qzlXVLadiGsYhhp72bg91gX9J12bpf8FQF35qcle0sGu+e3Flg+d2p528TcqWZevrBPZJ9tkiv4tBeqKWC6ASPJNLtRSgihVOwwEBZ3GV8Lb4Ml2R6k1Rpw8svKJj+j8
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(46966006)(40470700004)(36840700001)(86362001)(82740400003)(36756003)(40480700001)(4001150100001)(478600001)(41300700001)(8936002)(4326008)(8676002)(6666004)(7696005)(83380400001)(2906002)(1076003)(26005)(426003)(2616005)(40460700003)(47076005)(5660300002)(316002)(70206006)(70586007)(54906003)(6916009)(7636003)(356005)(336012)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:12:53.0196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a59abf1-d336-4cb8-a62b-08dbda2c3c81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.7-rc1

for you to fetch changes up to fc62d5e214df2dd64f5d675f01b609d86a422a2b:

  hte: Use kasprintf() instead of fixed buffer formatting (2023-10-27 14:09:22 -0700)

----------------------------------------------------------------
hte: Changes for v6.7-rc1

The changes for the hte/timestamp subsystem include the following:
- Improve comments in the translate function
- Reflect the GPIOLIB API changes during calculation of the GPIO base
- Improve error handling in Tegra test and provider drivers
- Improve code to set the line name

This change set has minor merge conflict with the gpio-brgl tree
and could be resolved with below details:

diff --cc drivers/hte/Kconfig
index 8e0fd818a73e,083e67492bf2..000000000000
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@@ -16,8 -16,7 +16,8 @@@ if HT
  
  config HTE_TEGRA194
  	tristate "NVIDIA Tegra194 HTE Support"
- 	depends on ARCH_TEGRA_194_SOC
+ 	depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
 +	depends on GPIOLIB
  	help
  	  Enable this option for integrated hardware timestamping engine also
  	  known as generic timestamping engine (GTE) support on NVIDIA Tegra194


----------------------------------------------------------------
Andy Shevchenko (3):
      hte: tegra194: Remove redundant dev_err()
      hte: tegra194: Switch to LATE_SIMPLE_DEV_PM_OPS()
      hte: Use kasprintf() instead of fixed buffer formatting

Bartosz Golaszewski (2):
      hte: allow building modules with COMPILE_TEST enabled
      hte: tegra194: improve the GPIO-related comment

Harshit Mogalapalli (1):
      hte: tegra: Fix missing error code in tegra_hte_test_probe()

Kees Cook (1):
      hte: Annotate struct hte_device with __counted_by

 drivers/hte/Kconfig             |  4 ++--
 drivers/hte/hte-tegra194-test.c |  4 +++-
 drivers/hte/hte-tegra194.c      | 26 +++++++++++++-------------
 drivers/hte/hte.c               | 15 +++++----------
 4 files changed, 23 insertions(+), 26 deletions(-)
