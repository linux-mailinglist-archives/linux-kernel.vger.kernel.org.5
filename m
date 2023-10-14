Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522977C9439
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjJNKyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjJNKyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:54:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2A0AD;
        Sat, 14 Oct 2023 03:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdlnmOaju7p+ePaXKqmGPnLKUiHhIM4r2Dwm/DhTGSFqYv6MEacwLG4lLhHHfE9rE5qSu5Mp3PIy2C/18A3BVUy8gQh5b3zgzP0COsY2Y9lequL4Oq9XBbUuNvmfGobsa5Ir3x8fWxnfAZxZ5gABRSWue4BFeDcUCap3yd28KCA+vTFsG+3kDRzuPypuTTNUjBdExsVjl89XpJDC61u7Afll7DpHoYp4OsMpg4r8QkhMWEmxu6qF9cBpGa6s0sxaJy7ngEq5WWtLbO1NFviyqyTB//UQ9XkXERtnH+bHuJQg1ebqMcUs/1wuAfzK3P9XneC1XxcxT9iqaGTEfHXxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEnrPINaycVAKVwwagSZhm4tQ1BmztctPX1j3CdecUQ=;
 b=RU56XZ2O/OhMGKEWEGaoyhQcLK+QpBUUExlaA3lAppTDZ8deBf2Evu9xat2s/ranwBNk8+o9Or6LydDcfsi52gmMVQUUo8ZuprafRBj2R3UaVgNj8CNuk2HP/RqiWKd341DEtq7MQhz3yHnH1HWuxSjt62UTWyefSy56wtTFmvFCXzQ7EtCV4+4p29f9szLewcwbZ0ZD21pbmCeV42s1N2Hgwis3sVGiOU7NLZ6czdQk4pz6x18bzc2hSz5aGUhrIwKMrWtz/LNLbt6BecVGbtDI5KxQINajxEy4U1rVVAX7KsbQRGiyY/tUJAze8SlYX+63Dkg2MnjXj1TCZRVzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEnrPINaycVAKVwwagSZhm4tQ1BmztctPX1j3CdecUQ=;
 b=QXlQ6wMCwp6BskK5IhLsqyin/kV/7/HMayDv85WWHOUU8qYuJLuMtyCm87WsHCy+wvRBb+udrPKlZ7Gbsmmwr37BQqFvJonb134WL/jW1BBWL8WC3m0H9fWg7NkqVaywWDRPgusqfdA+FxXyyP/+O+7qS7NPtvMfNGJq0Y0MeSanl7Gx6BBEPogXf0/JOPCB4KWaHnGCNqi4fBfzq6w/pb8mY6wgybgi/pwRh1Gub/4Ve1/dQ6G49zeCv+2V7yrjoKpJyxz7chhYI+gHe8bhcy2VgzqCzArln3o5ThyVxAbylB7px4ZydunpkXxWnlCzy3ez+luGXvS2wwRge/WoWA==
Received: from SA1P222CA0079.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::16)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Sat, 14 Oct
 2023 10:54:46 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::9a) by SA1P222CA0079.outlook.office365.com
 (2603:10b6:806:35e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Sat, 14 Oct 2023 10:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 14 Oct 2023 10:54:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 14 Oct
 2023 03:54:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 14 Oct
 2023 03:54:33 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 14 Oct 2023 03:54:29 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v5 0/2] Add support for _TFP and change throttle pctg
Date:   Sat, 14 Oct 2023 16:24:24 +0530
Message-ID: <20231014105426.26389-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f25d8e0-2688-47d9-ef0d-08dbcca3faed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpGLKSeN+rXGdHXIUdIN0ye1Ywc5bzuFaylKLMbqm1VJwxtpj2H1li67V1Xqe8W7w9rEc0ltSIQW10b80dJY7IaCJmnHwSfCTcsoccKgN4vuvA0x+1sVeWGlG8osVPEBFwvgIqYWSltFISIriTtySuY8mhTqbOvzF+CKtDJqrz5cRIVNgHg+f+l9FRHLAQEyTeyASVW4OBwJq73PXLDp3eofGLnTyzY1/qlM5tst8HaWhP9STsBXRvf/xs/ikCM3vUUX/PuNq+vYG8lcxyxpib2Gzy+fK16DK3GZDX0OpYySKIShwnOJopdYoHeCgYUuerzeH9Zz6PyD1LmxrfJnE+47oLzo8gATVUwaUPBpdadsxkEEOqt/NzQXahiZNKgYsDW5kq6H+OFceAImbDHvxhZlp7K70nkNqjuP4IpfSVB6cJ3mKe5JhHIhm94GwsfWcUe10v8drrkhH7SAJYHnc/7R6XIr5tlYeMRXk+xexjn+kHVe8JStMk1+AqTDMWizsbDCPwhSIjsgn9w2UITwApYHbhpfIWIIJZyoENLDsiXmm2qVJ1dNj4Z4X32yA6NUscfSTBaXCxJEHSnDQIQSRIAGps+NMp+yXIG7le3JHjWcWTom9V/4O3pJZ4qfAN434pbtStAOk2eSlJfCqyI3C/7VQSxMTIABCpU8pQQO9+5y3yw9r1G++RBovqynD06m2yjgjC9YX914lCfNvR+jITQIugk8b7ix7eUcZoSVoizG/ICgKE7BR1x9ng4FYVqL9KaTcs/UKbtbusB6uXXWyQ0BJmH7xnHkXIo/IBHTYq3OYBhvOMvdeJc615kPPYESV3jrgsihIlJ0cK+AkUmSFQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(7696005)(6666004)(966005)(478600001)(36860700001)(47076005)(36756003)(86362001)(7636003)(356005)(82740400003)(2906002)(83380400001)(1076003)(426003)(336012)(26005)(107886003)(2616005)(70206006)(70586007)(5660300002)(41300700001)(110136005)(54906003)(8936002)(8676002)(4326008)(316002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 10:54:46.3283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f25d8e0-2688-47d9-ef0d-08dbcca3faed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds two improvements to get a finer control over the
impact of thermal throttling on performance. Requesting to merge the
patches if no further changes needed. 

 1) Patch 1: Adds support to read "Thermal fast Sampling Period (_TFP)"
    ACPI object and use it over "Thermal Sampling Period (_TSP)" for
    Passive cooling if both are present.

 2) Patch 2: Adds support to reduce the CPUFREQ reduction percentage
    and not always cause throttling in steps of "20%" for Tegra241 SoC.

Both patches can be applied independently.

---
v4[4] -> 5:
- Patch 2: fix kernel robot warning for acpi_thermal_cpufreq_pctg().

v3[3] -> 4:
- Patch 2: move ARM code from generic to new file 'thermal_cpufreq.c'.
         : get 'cpufreq_thermal_pctg' value for Tegra241 from new file.
         : move dummy/null function to 'acpi.h'.

v2[2] -> v3:
- Patch1: rebased on top of linux-next.
- Patch2: use __read_mostly for the cpufreq_thermal_* variables.
        : add static to new function acpi_thermal_cpufreq_config_nvidia.
        : add null function if CONFIG_HAVE_ARM_SMCCC_DISCOVERY undefined
        : removed redundant parenthesis.

v1[1] -> v2:
- Patch1: add ACPI spec section info in commit description and rebased.
- Patch2: add info about hardware in the commit description.
        : switched CPUFREQ THERMAL tuning macros to static variables.
        : update the tunings for Tegra241 SoC only using soc_id check.

Jeff Brasen (1):
  ACPI: thermal: Add Thermal fast Sampling Period (_TFP) support

Srikar Srimath Tirumala (1):
  ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241

 drivers/acpi/arm64/Makefile          |  1 +
 drivers/acpi/arm64/thermal_cpufreq.c | 20 ++++++++++++++++
 drivers/acpi/processor_thermal.c     | 35 +++++++++++++++++++++++++---
 drivers/acpi/thermal.c               | 17 +++++++++-----
 include/linux/acpi.h                 |  9 +++++++
 5 files changed, 73 insertions(+), 9 deletions(-)
 create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c

[4] https://lore.kernel.org/lkml/20231009171839.12267-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/linux-acpi/20231006153612.5851-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20230913164659.9345-1-sumitg@nvidia.com/
[1] https://lore.kernel.org/lkml/20230817093011.1378-1-sumitg@nvidia.com/

-- 
2.17.1

