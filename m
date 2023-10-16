Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CAA7C9ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjJPFe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJPFeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:34:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86CDA1;
        Sun, 15 Oct 2023 22:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqQn9iEM6FAQgVuE+qkX+T71NJCFDJ1dVdfD2VA8KNhveIhtU/eBKan6ZjouwTWvossieZ4cmx2yWWA7mbdfhurIeIMUArR5RByugfQJMh0hwIhg5sX3iAh1MScOy1ZeEXxZ7uynD7OdhKj9KZBxFQ53oAjJbm/NJ+VqrfcyHlXRvFoMWpN4HR9pFYhEr62h9TJtgerXATfC4ieuQX2rN5MeArKrXNEOSUjKj6Wn1qL535oeg0JmJ6pC78CZJO9XMxEuWG/cRluptKaFJp1jT55GJEAW4bo2UcpYNTEQBakB4DO/UUJNNXD82i4j8oF292H2EBvlF0ldi0qvv/WMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lMcHtHlfc+scOjuKrrrGbzEQEpskvGWFEsC9BqVUaI=;
 b=AbtpbL4QdCV9i3t6ZmzwvhKyj+9KLfrOc9ep+LhuVRG6oEMS0BemtIBGVOwpou5KxGqmLBV7A7kwaVNBE56rFB0K6cDlQeHSjNiP0s4G/13lbIG1JhEVzindi8aZpn6Uc9UvOIxX8hh7NvOUPHbw0A9eaFlBHSC9imkgZnPI2fU8DjAu5WCdk0FFtPNvKoYKDdPRQVptqqqHoylVs2N9hGLRBjlv6EfRbzD/VHcbilNaD5UVLpz8c/UYJjKOt39lxnLB1xxRCqd3NfOCpDxJ106rwTI9vZeZ1H5KPZgShZfy7+uAJDGrxwCoul/8KZjxTHZj35nrjqWW/HawevaGIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lMcHtHlfc+scOjuKrrrGbzEQEpskvGWFEsC9BqVUaI=;
 b=m8+BDF1HJaEK8tk+k1yvx4SGEQsVtpBAJAUZGAt5Tb1GivtTNSywDqsOWQk55vX3giW99T9fKRNbZWLFYi+8S0n7iK50o39vvqcf0jJpnH8txmQVxi1h4H7TvuRESE+shqf3CHTXfRtMlEyvkVejq/DMV4pS/tbo/JUlK2Ho6aokDYksY4FRuKddOk+6zVqcU6VduH8A2csLdNB72/puFVAZj6ewlWAg8DEBjLBrXWkf0G7kN+ZU6nLaYNc5Wf3iwRbUP0rTwxd4yUA0aj+kvyQipR9+H0myAh+lSpyQzkC1rroUxA4/ZhASKbl1HMWu1beR/ypMsh+eDF00H48wnQ==
Received: from SA9PR13CA0077.namprd13.prod.outlook.com (2603:10b6:806:23::22)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.34; Mon, 16 Oct 2023 05:34:21 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::89) by SA9PR13CA0077.outlook.office365.com
 (2603:10b6:806:23::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Mon, 16 Oct 2023 05:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:34:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 22:34:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 15 Oct 2023 22:34:20 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 15 Oct 2023 22:34:15 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <kkartik@nvidia.com>, <pshete@nvidia.com>, <petlozup@nvidia.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v5 0/8] soc/tegra: fuse: Add ACPI support
Date:   Mon, 16 Oct 2023 11:04:03 +0530
Message-ID: <20231016053411.3380-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: f096e474-f2b3-4087-65e9-08dbce098cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgdpyCs04jsBpD4mpW5Wb+M60f8Qa47GT5/qVPbXnKb/OdX8qq5J8uydtE0GZCpd8jp5nHwOd7xki742L5uSfzdz6djExefdajA5z44TbZ57sB7hEHvKyaLV0GpV1ba818PEUtCMhliJ8/iFAWFEYGm5zk4QpymWFi7moG/Nvc2q3hvZjc6K1P0qQMvp+aW7UNuV48AFbIeWg0tBufPMowQdHhyK+MUq6YfzNKGRwJHFG1VgzRsFGSmio5WGb3t9snDJrQqPfkp6AlP8oRMkItRdC+Nh2efWbxvBLXVg04ltuIV/SW/AWSEFgYu21wt0EGGH4QAEfRXuHzk0RkzITgRO3riSxB4szPHapPFIOv95KkA0MfGhCcbVngeeMljmuGkLIq01RDHEaDJAKoGevUjttLrq55dHj7OBET66OqJXi6q48jn2UvYalpnYnELmU2jpM8mCDPm1zljEM7qJ+LZs+sJZeOVbRrh9fsF5UG2P2XKLe4hquSmQ7a3Ckljw6LN4F5l5LwrEG92yAa/Dblh0lfDSdbg9G2Rw93Bi22mxubEvsis5v57S9mcK62B+LsOFLJIz70aE3ofAle9QnXHLb37j1VGnobo2fhOJiaI35z6Bv2wctZD0CvaU31mAE9GbNV9XT1PZwtv+/jcrOAAkHxAcyDyiXTf9gKljdN3g7RjPFhKcNHtJF+8pJPJ0CL+6nkmWwVNyUDyhKW8TIVAEEyELRKyEHzMQbgCXSEHvsOleCztkQuOmnhApWikp2jSsXpZKN0EZxRs49Z+xyfNTB3I5LJu0gITmWJY42vXrIBXLkChLCBXCYqPuzpn9
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(82740400003)(36756003)(7636003)(921005)(356005)(36860700001)(47076005)(83380400001)(6666004)(26005)(426003)(70586007)(70206006)(316002)(478600001)(1076003)(336012)(2616005)(110136005)(7416002)(41300700001)(2906002)(86362001)(5660300002)(8936002)(8676002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:34:21.4473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f096e474-f2b3-4087-65e9-08dbce098cd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add ACPI support for Tegra194 and Tegra234 in
Tegra fuse and apbmisc drivers. It also adds support for Tegra241
which uses ACPI boot.

Kartik (8):
  mm/util: Introduce kmemdup_array()
  soc/tegra: fuse: Use dev_err_probe for probe failures
  soc/tegra: fuse: Refactor resource mapping
  soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
  soc/tegra: fuse: Add function to add lookups
  soc/tegra: fuse: Add function to print SKU info
  soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
  soc/tegra: fuse: Add support for Tegra241

 drivers/soc/tegra/Kconfig              |   5 ++
 drivers/soc/tegra/fuse/fuse-tegra.c    | 114 ++++++++++++++++++-------
 drivers/soc/tegra/fuse/fuse-tegra30.c  |  20 +++++
 drivers/soc/tegra/fuse/fuse.h          |   5 ++
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 110 ++++++++++++++++++++----
 include/linux/string.h                 |   1 +
 include/soc/tegra/fuse.h               |   1 +
 mm/util.c                              |  17 ++++
 8 files changed, 228 insertions(+), 45 deletions(-)

---
v3 -> v4:
	* Added following patch to introduce kmemdup_array:
	  "mm/util: Introduce kmemdup_array() to duplicate an array"
	* Add "soc/tegra: fuse: Use dev_err_probe for probe failures".
v2 -> v3:
	* Minor changes in following patches:
	  soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
	  soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234

v1 -> v2:
	* Used '--patience' while formatting patches.
	* Added "soc/tegra: fuse: Refactor resource mapping" to share
	  the common code between tegra_init_apbmisc() and
	  tegra_acpi_init_apbmisc() functions.
	* Dropped "soc/tegra: fuse: Add function to register nvmem"
	  as ACPI and device-tree boot are sharing the same probe.
	  So, no need to refactor the code here.
---
-- 
2.34.1

