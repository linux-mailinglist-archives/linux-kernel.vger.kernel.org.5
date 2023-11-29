Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6137FCFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjK2Hft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjK2Hfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:35:46 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1951AD;
        Tue, 28 Nov 2023 23:35:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TE2zGG/pDkckVTTDg0QeyGU2su0mudFOhRynpLuA1eBBcEmUrXZnFOcDnb9BLLEwy0tA+yzSbMtE7RZQslA+PfMtxPkkv+zD6UrdXmGXv/pMrzYBXdUPVVgmAwRZm27l1rC0TToP84dR3T1hzBQD2U1KlKtJD6l+MuruASpzPlOJ4un+2FNPpO8vaDqFdqWTExfWIcGXy/4/WMIbIOHOZlO2MV3LmXKTAJNjkLufeEAhaRAolP+z3aDDEF9MgWcxcAzuE0V8t0VD+NYKifmVNsSaG0YnbEFwld42z9F9vSedo6Lxw3PriTjjbiyKsK/9B8i8v1WrYSVBcGNPTq2KHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfxo7622qMf2qS84bbaG1M5TfCnWVZvyNqARuVIffNo=;
 b=lsVHSWYPloDSM7fycrEeeDaU8XsHet8JFhONJUPjagysCfuPpvXeAys1fmb0LMzF2eWqAMftdKf1l1ntezCRQm54M9ff7ppWoS8qPHyT/y9Ljf1Pgwo/wME6Vhh962YRbkbCszUY8pxCj5a/DzNY1txyIS9CFwAuL5EA5i/ilWN/1GmRmeloUunO50OaIvmdvmd7z4EYKj16VAri5tnVvvAETx4biI4HJtReu/lDd3UOKgTpLPUzS0ETJwJw1FxNwOTmNY+BGCaVIIJ76cCpUFMrlPAz88tTE7XDi49iIkmd6tcoVsp+6h1HBBNSzQPNsoiXjShB40qEDry2bO584w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfxo7622qMf2qS84bbaG1M5TfCnWVZvyNqARuVIffNo=;
 b=PowX6UgN81kkffKy43Pvu8IwbzGkvt8/5aTNob8INYKCbpoGAY8MJ7g/bTUFACVzLDslEdDf5Ds1jVSqgz3vdBlEbXHy24dpoZBg61RCDDnIhXzLEuMZDKgd76ZaOcwXjFbqu2QfMbLSdK4eqQLHOpd+Zu1ZuLLZ652A2O1pRJY=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 07:35:46 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e9) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 07:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 07:35:45 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 01:35:41 -0600
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH v2 0/6] Address Translation support for MI200 and MI300 models
Date:   Wed, 29 Nov 2023 07:35:15 +0000
Message-ID: <20231129073521.2127403-1-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 7305811d-8a9a-4b23-b313-08dbf0adcc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJdprXuexl47Bwoqm/uMS6nFBdYcRkS05k8BTHS52LORBgGBlzYWrzZQeq+7Hd2k2k6ogV3qMiufhKpcRmZCTNs0hCN/jiRVI7+Mf096ZvwTFSxwed1Vsq7BlYZiMQBw3aIgyTpQaV26Km4xWXkSZHRW5fLjPUseZdSLEttHHNf2X75zrq8+bpTHK15sWfvy4oCfV9g0A3Ix6O9qyHtKnmAvx47i5LNBm9Fp4uL5x0JzRvYAbnxB/SmfK7MJ2rIfvA04GKgsqsCGP8WDmRA+YDMtSZY22tyhI/CGPsfkIw7wyrs2//70GDpILnCrqsHYaOzmHeIi83+Hlh/bCvylcxgFfpcmKjByWpaOMNPGMZEgU9W+U3MvqgyVQeX0cwgdeS4DQ2Hq/zzQ6pyvOQ1oou3tXysjXufnoh6k4j7DWAfU5ExiynmcKgxqeBGmziaeN5AmKblMyAztiiXjuzrTlcPbxAOZGtq5CoQl1Mz5xSF81NQoQ/XuuOvAhsxfvqSvdMpD1TJOSMOiQ0d2O84NbiL8qTxAkkNy0ZHVTJRMcQ0EuzidPiwE3puNnYd5k5jEzTFAKA9PsTtFnTV6fs4wi7YVInOOcLKGHzE5DH+QCMjrCCTAiCaYND3bvaFuB+23/JDOLfUtpfNalFYpIJQJMio+hc39LQeVn5AEdqHQukA3EvbFvaQpLkLPVpW0xpj92A3a7AtpYH1M4WmmcxGAw4VDJYljm1eJ7ZRpElnrlZEYbTWXyMDvTLO87Ds34r1DmlKwInNDGrJ4YyeIBw5fkbAxCfSx5iE459SCTrNT5zU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(81166007)(356005)(966005)(82740400003)(426003)(41300700001)(478600001)(4326008)(36756003)(8936002)(47076005)(6916009)(70586007)(316002)(70206006)(336012)(1076003)(26005)(54906003)(7696005)(2616005)(16526019)(83380400001)(8676002)(6666004)(36860700001)(2906002)(5660300002)(40480700001)(170073001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:35:45.1924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7305811d-8a9a-4b23-b313-08dbf0adcc75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

This patchset adds support for MI200 heterogeneous address translation support
and MI300A address translation support, Few fixups on HBM3 memory address maps to
convert on-die(MCA decoded) address to Normalized address.

The patch set depends on the Yazen's patches submitted "AMD Address Translation Library"
https://lore.kernel.org/r/20231005173526.42831-1-yazen.ghannam@amd.com

The patchset does the following

Patch 1:
MI200 heterogeneous address translation support.

Patch 2:
MI300 heterogeneous address translation support.

Patch 3:
Convert HBM3 MCA Decoded address to Normalized address.

Patch 4:
lookup table to get the correct cs instance id for HBM3.

Patch 5:
Convert physical cs id to logical cs id by static lookup
table.

Patch 6:
Identify all 8 column system physical addresses from each HBM3 row and retire all
column addresses when the error is injected to avoid future errors.

Muralidhara M K (6):
  RAS: Add Address Translation support for MI200
  RAS: Add Address Translation support for MI300
  RAS: Add MCA Error address conversion for UMC
  RAS: Add static lookup table to get CS physical ID
  RAS: Add fixed Physical to logical CS ID mapping table
  RAS: EDAC/amd64: Retire all system physical address from HBM3 row

 drivers/edac/amd64_edac.c         |   3 +
 drivers/ras/amd/atl/core.c        |   5 +-
 drivers/ras/amd/atl/dehash.c      | 149 ++++++++++++++++
 drivers/ras/amd/atl/denormalize.c | 110 +++++++++++-
 drivers/ras/amd/atl/internal.h    |  27 ++-
 drivers/ras/amd/atl/map.c         | 158 ++++++++++++++---
 drivers/ras/amd/atl/reg_fields.h  |  34 ++++
 drivers/ras/amd/atl/system.c      |   4 +
 drivers/ras/amd/atl/umc.c         | 284 +++++++++++++++++++++++++++++-
 include/linux/amd-atl.h           |   2 +
 10 files changed, 747 insertions(+), 29 deletions(-)

-- 
2.25.1

