Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76DA7E7190
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbjKISeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344938AbjKISeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:34:01 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686FA2D44;
        Thu,  9 Nov 2023 10:33:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzmEaxJd2Zxo31UHC2+13YtRIPbmZtR+QaTzsEnhC0SeGQhhnG62Fm5Zz6sqa4hi47+3leHSnDURyaf2fup1sDOcGsornjzlz40iEgcK9DrRGJACUsKfQhfzK558J5Dc8vuVgycRZS60uSAXlsYKEtOnLidA/88et1rqdwfgIQikJAsaiNlAvC0aWhOvR65pGD8liXc9fX6Brblyu5HsENcJN0/anMZ3SkTf9KrnovSfQl5nKLRAUvf0ACcVAPUWj/LmfrqZ+vBrgYrzr53YWpCrK1gXCa14WeOwtW7IjBbaIXI6lIJbKOAWJ5mspajwMUV/EtixM2PRnDhiqvU3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfM3WHIeXjz7sqMCuSqwWTeXBai8vexZaC7tZqa16aU=;
 b=QtGN8rwdDZl3M8cEdhjPwXYovxTj2QPjaO0JTLXPilPKUcXHpyxWlxmwQwzlWwhkUEmvkmc55qcO657w95XeO/kFZjOUR5/59iZxn4cMf5dEwnFmQs1OYSxmrrzPyvFogkJKHoxysut+b39+utnG1+nAeCnrEUHX2FpCfPQWOE9K3WBqSdzkD/cNpplF6nNl+pQB7nVZL9uU7R9J4qZtUC1EaCcpQZ/xVolP6+84zCheK+G0ox8uCk8CPo9dibcv5O5QJjhlzXOsb9Y2nSEMzinNaDWvpiXWshl1MfpmRwhf6Ehgy09b2FgFMA1Go2Fx38zDKJ7lY9PkQkHDd8pQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfM3WHIeXjz7sqMCuSqwWTeXBai8vexZaC7tZqa16aU=;
 b=Msw3YelKvT8ADT7n+L0a1cInvjUZ2jksOcVianrVQ9RCaW2sGYxr6bR6cv3l3c2ryAs4Nfd62UdOzNTUG9iz9qDKkoxzqfl9ya7xmUzkvLjNCxYnpI1oq92dc4s+HVTu9G0qndkc1upR5Qd1OhD3QCJIm+X3xKjNqsXP5Wc9vNYx/ukgHcivUJUd3ta4bONXHO0Nnns8MaHfQ4XclA0zITgG3NRNcc4CYY28dW4qZG8yb2e2xnu+etPblCPgiwRDCa8q1euPBMzTR1YXy/NcckwkkCjJXRsViJu2IHebdtgzaIkrvwEWvzPPA9Yledws7BTMsLii12ZCNEK5P0cAXA==
Received: from MW4PR04CA0300.namprd04.prod.outlook.com (2603:10b6:303:89::35)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 18:33:51 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::f4) by MW4PR04CA0300.outlook.office365.com
 (2603:10b6:303:89::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 18:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 18:33:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Nov 2023
 10:33:31 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Nov 2023
 10:33:31 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 9 Nov 2023 10:33:26 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <lpieralisi@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v6 0/2] Add support for _TFP and change throttle pctg
Date:   Fri, 10 Nov 2023 00:03:20 +0530
Message-ID: <20231109183322.28039-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: 7026923c-5ea4-4e51-89a9-08dbe1526b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7utotz0STRWiBXaS+5A8WtC1XQtfFqXbGtlsEAm9q80tRe4cvk8BWzTsNl0q6ubklzv/Q1WyuRHAXXsAxtTzlPu5/6ZpN0wRN7nN1SigEA1R1l8dzU3Uf0hKWSgdSQeabIMNmMjwEw+4LvolBIyWSQEfFJL7XsdZpoiAYqv29M1Hs443ynlQiTczjxgnt7Pe+QFciMQyAd0omB+4C0zGichGZR3D+YjxpAiBPzFWW1cK2IDATm7A7C8HmiW0zOrQ0hE4rXB9cX9CFVPwSjgiYJzi2aVLf0789h/YXoB+dQI2iWB95o1heI3/rilRXx2lKZr0Aec4AWLl2qRqGiEvFMgBQg2jEApoy80i4P39J/9gjLbR7SBAjJU9+c2XqkEclVCoMya1/Id4qfLWohMANXKVDQVFwgXeo2cktX91x+2sD6xBqIsmNSkzSfZQzkzEcs8kgq5BkHMLXFjYcqBaI179HgO8Zxy4ODjshsVfu73oF+A9ANVqoZKab3Z1uO1KjXI0tC1k3yIanMX6txev1Si5sysC76osS9riVsKf2fOD6QvrjojUhqVx60Ke8xh8rl9ZSen294u/oSxzx670YKxZPFGdQOsEmI8f8a7g3lnBv1GQvRGhwRr6O+UBP5f82XlvwN0q65ZxuTwBKtwReVM585wPgg0rBCZ5D+x6qaHJQ+lNB2oxxhkEF9dMyIGh3N+pUpwgzvEAhQSrU+TotE/hycqYPShRit0qShYaaU0AoOG6ix+WPssnZbT1f7HoBNqA4qnWvCNlLKz/5qAilFbs9st96GAsPKVuUTTi+NIEgjgLTcK04ujqwbIMqsL5ihV3t4C6y46X2EE22STZMhLdCCiQFtVuqZPdbU+eAVl1D/gLMlwCOscmt/ozgNUZQXqpozseWVbSaNNL5s5NxzY9dVOOsAXyO6ua9fqtUwk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230173577357003)(230922051799003)(230273577357003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(2616005)(6666004)(921008)(478600001)(966005)(110136005)(7416002)(70206006)(336012)(426003)(54906003)(41300700001)(1076003)(2906002)(316002)(8936002)(5660300002)(8676002)(7696005)(4326008)(26005)(70586007)(107886003)(36756003)(82740400003)(86362001)(36860700001)(47076005)(83380400001)(356005)(7636003)(40480700001)(40460700003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 18:33:50.6485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7026923c-5ea4-4e51-89a9-08dbe1526b5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
v5[5] -> 6:
- Patch 1: rename passive_delay variable to delay [Rafael]
         : re-structured the if check when reading _TFP [Rafael]
- Patch 2: compile thermal_cpufreq.c by default [Sudeep]
         : rename arch hook to acpi_arch_thermal_cpufreq_pctg() [Sudeep]
         : move null functions from acpi.h to internal.h [Rafael]
         : rename existing reduction_pctg to reduction_step
         : rename cpufreq_thermal_pctg to cpufreq_thermal_reduction_pctg
         : update formula to get same num of max steps as old with 20%

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
 drivers/acpi/arm64/thermal_cpufreq.c | 22 +++++++++++++
 drivers/acpi/internal.h              |  9 +++++
 drivers/acpi/processor_thermal.c     | 49 +++++++++++++++++++++++-----
 drivers/acpi/thermal.c               | 12 +++++--
 5 files changed, 81 insertions(+), 12 deletions(-)
 create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c

[5] https://lore.kernel.org/all/20231014105426.26389-1-sumitg@nvidia.com/
[4] https://lore.kernel.org/lkml/20231009171839.12267-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/linux-acpi/20231006153612.5851-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20230913164659.9345-1-sumitg@nvidia.com/
[1] https://lore.kernel.org/lkml/20230817093011.1378-1-sumitg@nvidia.com/

-- 
2.17.1

