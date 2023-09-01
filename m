Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2738278F820
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 07:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbjIAFnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 01:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjIAFnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 01:43:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F8E50;
        Thu, 31 Aug 2023 22:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKTZmdGJ/KSOpiGaAuxVVWVcQ+lTqZjlRp4547GKtyDk28fMEstL+D2ZevSrfe1GpQqEHEZ33297+3ymNAMAdaNy2ZfxUiDuC4KApFsgm/RSX+d0tOOTeZyse9ONDz53f+NeqgcJDxmaIvpRtn4o5CSL163PrV8V0dx18yO31ybjOeFxVFTdSEh4dDoQYdpybshTuy2O7ZNMLp4tq2tQ70kyUt0epTtGRPsM3VGcngKjDD/aN5g/svq/nK02zG9KtTNvvzSQ50UWI6TYB6+KsObfM5lV1x0+6mRL3jG11Jdvb3a6GUKSEkBxRgb/9HSX8bhJRfwANDz6dfYHSliuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0atSOEnHGLVttJ3piVAUCvVp16Ee4vB0W7G+XPU8e6s=;
 b=GPy+o1zRzT2Ql4cWz1CqPMITDrOU3XTR5kF66rsaAfqmjRfi3xWM/EfMWbtg96yafu+BbW+CHsTlrWH8m2auq7fS66fdLXhWlpZlRHIQy2zsR3JzZh0Hvn8x9joMxgdSpAVNTfQlmd4O7TN8/XSk34JaZmPkj2JA79OojfLctN/dmi3d+MB9RWR4O1RrXJR+yAOfvPE+7gMIFEAqQngLTjBbPnVwc5MyTOBQ4IoqHnMQwuziE5KnZFTTUjVV0XhP1wv0BftIJramFfRgsSTgxRzYMzhDXw5TFe517YLzupVkQwQdqg9xQJ38L9uHvkeqPnE9CVxFeHCWzpmJ4rRD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0atSOEnHGLVttJ3piVAUCvVp16Ee4vB0W7G+XPU8e6s=;
 b=BCuFKn9nZxWGZnGoUaVsWmDacyLMp+8iwucGffhiqUJRnPOVM4jf8pKO/02A+cKjbyCS+PE9RjN6a+oTIvW8avwCAtH42A1NU/WtuM9sgHSklc65sM1164IZGIbVQL3iu62t2aj3MSgbAT9KcZCg3ntF5xEbM/P6qjdCzqz3tqG8PuF21qt9C0tkY1A5xQxGK8tW3doI7hSaB15lg8RlyLSGtZHmdY2Sj1M7eiz8DbGXbLkfQpWW8oOhHsDMOLj++iIDSU2+hSExvTaon0rJOisDnVhLyjbWkmMHMbJSaPzv2K0eGsqPUxJItgksh2lNif5MHoj4TYJ6Vk1m8KTpkQ==
Received: from BL1PR13CA0302.namprd13.prod.outlook.com (2603:10b6:208:2c1::7)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Fri, 1 Sep
 2023 05:43:33 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::9c) by BL1PR13CA0302.outlook.office365.com
 (2603:10b6:208:2c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Fri, 1 Sep 2023 05:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 05:43:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 22:43:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 22:43:17 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 31 Aug
 2023 22:43:16 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] Updates to Mellanox PMC driver
Date:   Fri, 1 Sep 2023 01:43:05 -0400
Message-ID: <cover.1693545970.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c39140-2830-4acf-279e-08dbaaae6057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WndLylMvPB6TUsr4tN8Uynzc2BR4ZvX8SQH0/v74o1HilZxvZHNR02ocRQrxX3EnSKpvidzfqf+SwMrAzMg7tv/8q8poyQzTquj6fQjfENVF/EN1qXzomV0KHshE/GKlrSt0V3IQLZwFRfquEO3hTH24jgE+KosLG/3LcjAHM4Nh8GXTr23Xp9donY+o12a0nugrcWfLJRzy/Y0fI1UUvmChtsEKD0JqkDB8nTvAAY8FV8h7wowcP9fRjHC5NPsVNCvp6u4V/W9xW/tfmCrviZgx/9Pr5Syp4NrtgBtsIpgZyrWL66Bn5/WoDuhRU2irkK9V/akwtpo7AepGbB7bCzfTjUEaKZL0ToVsDGSMpxfFVfOIwjWLPXesLghN703UE35h8a5bS4vfqWh05RnIzcBCKVvtQy9+qbA2qI9fk3dyAzucbjiv/7OAQKrd2NYBqq1wS/c1y99HXiB/E208a0qbe1rrQ0ecLeFH2V2M+Z/O92yxw/7IdNnjeO3UKarT9KGV+MbIScn5I0lkBM6mL03CgLhLt5bGUXvivDc1dAAIqwCosf4uRKdsNyUhCG1jVoNkGM1a6Cbebz381Z9nYt87M29DbqnKUJ2dU4nxR8CtHoz8xBKsf5NbI0uYxoHnvSzCQJH4KN3iUIOWVdt5f0Q5f1DWN7X6f2rM+tLO/um2m2QvcMpfsIp0BBxurKyJJKVmDEFB3rc2hn9FgxMz0uXfmRvJwlE1JOa5JDRS8KvkfYhzollhTTkKzvV7mSsu
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(356005)(82740400003)(7636003)(8936002)(6666004)(70206006)(70586007)(110136005)(7696005)(54906003)(478600001)(6636002)(316002)(41300700001)(426003)(40460700003)(86362001)(8676002)(36756003)(26005)(2616005)(83380400001)(47076005)(4744005)(40480700001)(36860700001)(2906002)(336012)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 05:43:31.8381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c39140-2830-4acf-279e-08dbaaae6057
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286
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

Patch 3:
v1 -> v2
1. Fixed naming inconsistency with events struct
2. Replaced switch case instance with if else as suggested
3. Used rounddown instead of calculating the value

v2 -> v3
Removed empty lines and added Reviewed-by tag

Shravan Kumar Ramani (3):
  platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
  platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events
  platform/mellanox: mlxbf-pmc: Add support for BlueField-3

 drivers/platform/mellanox/mlxbf-pmc.c | 726 +++++++++++++++++++++++---
 1 file changed, 667 insertions(+), 59 deletions(-)

-- 
2.30.1

