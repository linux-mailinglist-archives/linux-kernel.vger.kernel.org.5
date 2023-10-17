Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA917CB9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjJQFYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjJQFXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:23:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6979511A;
        Mon, 16 Oct 2023 22:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3nRbhsmYEDcO7i39N80l9LVH14+qh5dZCOOpw3J2HbQ+v4XCjfSsyLlis4P5qkElKKgubTM8sBgo51tOU1Y9VkPrD+FDnFLSWCh4W2ZiLHESx1Mqui655u1F3k9X1CM+imzB9RD8XbkZewX19zbnF/7rPhvdc2WZlLT5HFJ5MHojbdMiRJbR23BCG4IcqP34o3HgyTXpvLpm9I2oH5epszO1XwbYl0TB3w3lnQx2IeFoMimCtJsLu4LaA44jlgdPZ03n1dryUhXM9iQUKWeYsPgGdZIMe6kNNpGaILy0YQwzkZif21pIcwJAKztdJRGXvGO78QDN4BhJiXVKD9qRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUDn0U9Vj5mshxuMLl85ZX5Xfcf22GbNmQ8HrOCMdsU=;
 b=lWY4nGvOzXnaOmzxOWJkOriZT2S+C1+U2GWQy61SRMfiC51TWI5ex6Ruw7r3yokCBLgZW3QjMuv7fVc4BFc1cThbnSxmckMcfVdmJBshLBi7AGVX2r3I5Lei7vUIOpeKajdQhUgsXM0tNxVuXZMO9gZ/YQEzK0flkYn0gBezbwmW8sbVxNOnt4cU7Tn+OkW2uGPy1f4E6voakVPC1yk6q2v92nTR00qJhCnASPwlZevGDH6wKfbI5sLHxGk2rILge99ZoLbnZFf9tqAY4w5WMITMf5NhyT8j49/2SSCbQWzxzD7Vy6Lsk4nCv04dNeVGKswQr13Duh83mUgqYw79Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUDn0U9Vj5mshxuMLl85ZX5Xfcf22GbNmQ8HrOCMdsU=;
 b=VI9UV/a1yr1Q5SVbTp8i5OwUZoDX6oDGGKBwgfZmbKh4gF+EmmeWge1P78EZlwVRg12IDwSM7G+z7HwdB9TUwbNOPGrmbScNM11v9oYJ0ZkGr2j8WRjBgBEnXKCuR69yV4YuK0yw3yvm5+XrgStJJtLP93uols8R3M8cW2iRGTucYJ9FlXqJ/PHyT7NlmgmUhyZO1OZS7S0SPt9yOUEVwG6aqOAR/xRCGrhB/GPnfM+PMC84CvI49IhIntvnwBV8WPsPlo5zUWoysVrSrxexWVfE5o2ZWlo2ftPj7u3M6MYdmaoWyOHVhX2yxMT8XCWPZPKubIt8bSsvj9vF2xSOpA==
Received: from CY5PR18CA0041.namprd18.prod.outlook.com (2603:10b6:930:13::19)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 05:23:43 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::f) by CY5PR18CA0041.outlook.office365.com
 (2603:10b6:930:13::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 05:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 05:23:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:23:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:23:33 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 22:23:27 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <kkartik@nvidia.com>, <pshete@nvidia.com>, <petlozup@nvidia.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <christophe.jaillet@wanadoo.fr>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v7 0/8] soc/tegra: fuse: Add ACPI support
Date:   Tue, 17 Oct 2023 10:53:14 +0530
Message-ID: <20231017052322.2636-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: e183e5c9-d005-41ed-05ae-08dbced13a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnmN4nAjKB8De+hyqs5ajTmfXlmTPfKSxBUHKlVtFM0EQsO2Z7Iur2fbQ6RN2JHKRZZvqY81GDyU21PBd73FQfu0KSx5KxPBMAm2lHwr9XJ5/2yp6glQMuBGh1w6KagaCfbon7v5ouF1de0JY7vFCQZDG5UZCxBMFgOAD5v2i+g1nrP2G5Gbe0KTzT+4ox3gwkluBttjXX8JX6lUuVkIH+SI0Nds+j9vQyuIh2q2eVo3A4GJ8pSRpjUwJDZciW8DiNhZ2Thyyu+iWAxhS5/rbw31kmfVBZAMNVBbFEDwoojwIj5mA6otQrZjO33StXdeAj+SmtCuCny+rauKAMDOE8A+1xWizSb+OymdxS8waQN9c39pV5SiecYBBwEe1vdOh6q/jz6rTRyBzS9kBlmT/PnA6Kxs5Xomsq0pfsxgDWeZBMFAIEpKcRxTW4aCByAwaKUMAR9zH7MWx0jZ4e6qJ/diddxnAlNyNIP2HPCv7aK0ID3EyGPyWKJsgMwLh44J3vC6Y5hfQB4Bl67YjbHwe4IgeEmE2HsealHhyYjExKT+lfzuG3Z2537h/jgRq2SXi/iE/h0PzqjKosIn46OcIDp4UY/Jt6HpekXllkS9Z1SVUx9Uug3ObTLIabn2KC6+SNUEVxHYTof5fHNHKyFYXiYLYBABpIu57RX1dKaiWUBhBu/VYkf+GNOUromfE9eZrGOWljwFW87PvP5rfCDDQARcB5K4+92oU0zzsXyTmXTdNsWtmLftwMFGRlFZ0KzHYgWOLC3yJbcZyHd4bG0NBwoo4jPP81ofGZYRbctF4on3NOcwgY2OdaQGvv3BrSKC
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(36756003)(40480700001)(26005)(40460700003)(478600001)(2906002)(5660300002)(41300700001)(82740400003)(356005)(921005)(7636003)(6666004)(2616005)(36860700001)(1076003)(336012)(426003)(316002)(70206006)(110136005)(8676002)(70586007)(8936002)(83380400001)(47076005)(7416002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 05:23:42.8138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e183e5c9-d005-41ed-05ae-08dbced13a95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968
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
 drivers/soc/tegra/fuse/fuse-tegra.c    | 112 ++++++++++++++++++-------
 drivers/soc/tegra/fuse/fuse-tegra30.c  |  20 +++++
 drivers/soc/tegra/fuse/fuse.h          |   5 ++
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 110 ++++++++++++++++++++----
 include/linux/string.h                 |   1 +
 include/soc/tegra/fuse.h               |   1 +
 mm/util.c                              |  17 ++++
 8 files changed, 227 insertions(+), 44 deletions(-)

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

