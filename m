Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D206378DDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbjH3S4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbjH3LMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:12:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F7CD6;
        Wed, 30 Aug 2023 04:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXXeN08qpMZyF17cmYzDFWgOG3QRUdUieqZLB/7WmbGdJHy1ZOXT6wVtPUYBc8mjFHZCJ5gy4LnsmP/WY6D5wZTMkr+OJrlcxOXW23/TYGfdPz3HXJi7CAjhugf/3x4JtnDmzOjy+zXYZEB5ObW/CY5nl1GwGQousqzOcXe5aBSO2OEuDYQXLB5ywcpJqwUMIdMiCkIWc96c/1X5L1UAhUuhWqkLSwNg9GbvIth/XiMLHrjCzRI6wplNiUdporXawFhfa3VF//wQfzgO0AA8aUxpV73JcSy52L/QvAxha9KTClTOu7qOfZjBmnkFw5J09iHCurMCHtES4aIW6vvwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d7D5Qcpl6EPzzgDa/kfRS3pg9aqg7AScJeEsjadZvo=;
 b=oMg8U3RVGjOjaJGi3VqOu0yc81gtBnGZCvXlqrlX5YUMU2ad79mne62sGGR7e50EIcgOzBCWHI3SVr6pRcsHzH4QLWgY4w/d71TJKVlg9ULkGI1/HUCkLKyoTvpMPNU573i98SYWZlmTyHrFk62zzyQ/V3BdUQF+LwJ8zDDlFliBIlQ2nVYGoE9nSNRpkrKid3ICAZ8XrpjmC/8dNVP3eLzsWnAWfx3EBL/Rk3991BORsL3shV2TaLXi/jnGPkVcJ7gks6ZCdC4BJkvrzfWIBwXMgheOf5DFl9NMY9l2MBVw4yAmmUDzD0hjVywP98jJ+6wrd97CbtW1oWaJe9y7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d7D5Qcpl6EPzzgDa/kfRS3pg9aqg7AScJeEsjadZvo=;
 b=qoxJhEFOz/fYdcB+rDb41rFBfkO0PQXUgHAXghNlY4PedSazpekBKjGKaJrw7I49WVACYhWHAyclSv5ssipjmvzx5XnMLIeGG1sLu5qMe02HXAWwyhqaQp2iU/6yGGLqI+BytZzNHt/LwJdUAOks7Pg6wHkOCTsh9qPlGkFjoZceapKd6AkBUWPjSOVns1DiDVd3u421lbu1eETwuvhj1sYZ0wskr646yYurt70Xb4tYaQgSxEr90pFUVeDfQ8DF1GU7tYs4mKogCinfnWPkJ/40BMbgrc7xvvLttxhVvsgwAX6ET7/reMFRJCKV6M+5QIe4L+gcC5u2gf5AqWKGBw==
Received: from DM6PR07CA0111.namprd07.prod.outlook.com (2603:10b6:5:330::12)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 11:12:48 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com (2603:10b6:5:330::4)
 by DM6PR07CA0111.outlook.office365.com (2603:10b6:5:330::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Wed, 30 Aug 2023 11:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 11:12:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 04:12:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 30 Aug 2023 04:12:38 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 30 Aug 2023 04:12:37 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/3] Updates to Mellanox PMC driver
Date:   Wed, 30 Aug 2023 07:12:31 -0400
Message-ID: <cover.1693393544.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cd32c7-981d-49b4-5e4e-08dba94a0b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VI0br4eHLtaKjpmdhoZDxZ2LsvGaTyA3i1FhYstJOZXQiAxjs9YnLoCg/DIxHDWUn5UieftH5Q2v+6ea0/Rhkx7YswYM8RzQXBvaPusxdWex38DOU+O/noCNiFo8n/A3HVuGR5lHJr5Gk/ZrWznaZrys7ErQ/xCKFn4Hco0GtzBEyLgSccbV7lve7mDb0csPGNbAaYPc5R33XoWryHFAA7yu86rAnQKk7m2N+ks/KXLSOO5v/AouuUMs6eY4RGFBv43hDIZEakE3OAYPUy8LlXdC7wfb2U1Gedru8bvl4kYKbsDbkLFd0/OIYyqxeOtDZRRHJEYYklVrWd3UR6UAiNOysi+k2Pi6RVjmZHxOY0qmuVI8Ne1Qsmh3vFI646oAQ/pLs4wZInDyAkTqVXQDVsJJeP7Ee98R8lj58jCaGjfnGHJPzohFNxuEwG75KfzmP2j/nYrf1OGvgPKNeWjtOobrhAOXmsDOv7XsYGeBemjkqfqJnRxSpbQHDCXwF0PCzMcirhAHn91hILoROgd9CflnxM0Ot8uNrPWnaWtusoGv6Vz1q89fI+BqVNcSN9mC7Bm8atBF/ah+SuQOiydDx2YQUEH392m1iWlqvPRglUzHtszYpS++nrnH1e65dDkgccEGarmt3QMf1isuyA1tHmwrkbazRfJYKxxfAOlaLFuaiHuZNTDEamroQWDGLTWve+NdRLLFoShtIDN3e8N3PaGyuox2xvxYU3R68Dhw0TSbJiOn6JQQ/BHAlrbEm6a
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(5660300002)(316002)(6636002)(36860700001)(41300700001)(54906003)(70206006)(110136005)(70586007)(83380400001)(356005)(478600001)(7636003)(2906002)(4744005)(8676002)(4326008)(8936002)(47076005)(82740400003)(86362001)(6666004)(40480700001)(7696005)(426003)(2616005)(336012)(36756003)(26005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 11:12:48.2906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cd32c7-981d-49b4-5e4e-08dba94a0b36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This submission consists of 3 patches:
1. Patch 1 replaces sprintf usage with snprintf or sysfs_emit, as applicable.
2. Patch 2 fixes a bug with reading unprogrammed events.
3. Patch 3 adds support for BlueField-3 platform which uses a different
access mechanism.

Shravan Kumar Ramani (3):
  platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
  platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events
  platform/mellanox: mlxbf-pmc: Add support for BlueField-3

 drivers/platform/mellanox/mlxbf-pmc.c | 740 ++++++++++++++++++++++++--
 1 file changed, 681 insertions(+), 59 deletions(-)

-- 
2.30.1

