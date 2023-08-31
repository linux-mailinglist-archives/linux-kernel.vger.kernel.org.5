Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D775678EB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbjHaLGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjHaLGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:06:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E95FCE4;
        Thu, 31 Aug 2023 04:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTmsIknEyA+pqrA7I6u4TE4CeZMuK5uVwxh5JK0bRHyU+GOr8GQnu9tcDOUjL3LdIPGA6jLM1/oowTpNWSEAlxNkoNtegA7Wg13qiowBchU7Sor7E88aClb2eHL3HClYkUyFXgNexQdUsjD3W6Juv2EGWlQgJ8VbFOsohKTv4LGPrAhmQFgouN1aUVNZ7V7ZyK1IlsxgwVrEt98sNKj3q5VJEFN07aDhirr15H2TaL411ZMs7VXhX+EhqsBRG8adDR49n1Jaa5F2PV+f5X0IIdmLprCjVMH6Dv4TQ/tv1BzN2Wii/f/aLTjTsFX792H0i/o5iG/vhtHQv+znzULvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnPQ4HP5pv8jcZDxSipYoLfC80eONVr6prZh2lyub7o=;
 b=PJlKoSBP8inqsCa9Kjc9Y5Fz8XhuXqDOkVci9HIjea2Vl2tycEyjo8zmBJhdvuFbw016SY/du2Ji8SCKEs/hArMweK/GQG4b3kzB/mCvj1APRHrQ6xymis2A4cBzl5MI4BgTFvcgIKVVnjwgAmjkYbCZn8zz7XwWgjweU7lK/Irsm3WVwAzK4zaLAVfndg2El7XOO+ejEVdOTaWA6LIoPNG0kwwdPwrHXyW90N1nw/ekyn6juAXoZbxhqWyQVNvP4MDLKNXu9ioBoR5zhKBzuuuHzeA8PNtLBm4nRfJ4CIBjZuovwxK4df3XC9wI2lr3ePqlPNihDpIjrUCCuYDJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnPQ4HP5pv8jcZDxSipYoLfC80eONVr6prZh2lyub7o=;
 b=jZ9M0m1fTGLZRe3B728rQfVG0XhNhsVwtrb7OZS+jV46hz7lrVzmWH+1rQBwY0utRGLcWhMtlL3GIpfHEfFQnRODkZsWBNq46JCVUWSlBBhY7HTJTmCCdrJaKM1RkWSQUZx3l2jhayp6mmMQKH4IetnsreRdlfPRsFkbvWpEOqsoivqSLIq337mZhPN5NjbEpWeFZZzFTpe72mH655oLMNQAAX520woqoxPt12pzFoUppRc2P2sq+PbF5MMvROgE8ffPeSQudVgm7U/ATxwZWZII1ERXakeTxRiBaIFll3OmL+Q1VrqbJ5j6IPu9MgSM7bboBJXPI3WujYVK49+8IA==
Received: from CYXPR02CA0075.namprd02.prod.outlook.com (2603:10b6:930:ce::28)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.37; Thu, 31 Aug
 2023 11:06:26 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::1d) by CYXPR02CA0075.outlook.office365.com
 (2603:10b6:930:ce::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 11:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 11:06:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 04:06:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 31 Aug 2023 04:06:22 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 31 Aug 2023 04:06:22 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] Updates to Mellanox PMC driver
Date:   Thu, 31 Aug 2023 07:06:16 -0400
Message-ID: <cover.1693479119.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|BY5PR12MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd5ef86-d01b-47ab-c5e2-08dbaa1251f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcAusP6Wv0cYjHZULACEOii4srWmG1ml4UUxKXKpyIq/WyqNu5r1SM0PytaYMf+k73XJ9SmuXhi80a6UfLN1eOxb7yntMblrMuOMWdwaeXwPuSA5t6Ntz4KUV6fMA9YaIkK02eZ9btmQQ28OC/Utofa2nhXWIir9lqYvvnS2rnKfe2J6vu0yVWDM8lpG+9is6lqR091mq76kJvF0yuEFQD8Y/F9VnMzqNgFKH6NIK+v1I4pAL9DRjrvVWRbbbPnk8T4ig0+F48BNWGYhT9KrST0sNgcc5KFYy2Z/ygcZIsd9lII80TyK470RKPzKY4aB88csXkgra0TO/nBhaNl9CEblWSdeT8mqpCdlX4dnZO42UzcxAV+lj+cpoqOH5L7aAnRwvcrO49Fz8TmD1ZTgIGSbfiB3jGPwUwAJjRlSsEwY6Xy5KbgIk0ERFva/7ZmD0c+kT6GjvrL0nLWrvh25NjlAVNLP/geChNACJdBi77AYlgS2SCRhhUXV9UZq43/SjzVMRTZ5KMU/W8QE7doYo6B9DTietbGmNupkWXreYwmqzOMJTGz/draRlZhfAshuxBbBsczlDQ9K0BzzUEbI8V5qpMaGeqBBvld7bfRtfAlO5wkorSTc9KruFQAnp7V4NF7W7BT3HUAAX5TMqdgWLc1A0TzphF4x/3eMvFW2v9ZkLuqVKZkh0d6sVYSeLPjgAvONNjXCCicu1wJ32viY+YvMOFiCtIF2nqw59f/jNgPGpHgilD8czyC1Vtw6xauB
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(4744005)(356005)(82740400003)(110136005)(54906003)(70586007)(70206006)(426003)(6666004)(336012)(83380400001)(7636003)(316002)(6636002)(86362001)(7696005)(2616005)(2906002)(41300700001)(478600001)(36756003)(4326008)(8936002)(8676002)(47076005)(26005)(36860700001)(40460700003)(5660300002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 11:06:26.3001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd5ef86-d01b-47ab-c5e2-08dbaa1251f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
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

v1 -> v2
Patch 3:
1. Fixed naming inconsistency with events struct
2. Replaced switch case instance with if else as suggested
3. Used rounddown instead of calculating the value

Shravan Kumar Ramani (3):
  platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
  platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events
  platform/mellanox: mlxbf-pmc: Add support for BlueField-3

 drivers/platform/mellanox/mlxbf-pmc.c | 728 +++++++++++++++++++++++---
 1 file changed, 669 insertions(+), 59 deletions(-)

-- 
2.30.1

