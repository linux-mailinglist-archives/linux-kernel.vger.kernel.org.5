Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC97B811B95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjLMRxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjLMRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:53:49 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8126A83;
        Wed, 13 Dec 2023 09:53:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbw7VEtjUgQym5lKOMbhgQlWIKJ/FNlont36YbYAM8Frj9SDlRthmlupP4bKkHLwGeDoflRo89a3XUgKIe6226okeNRHer7K6JaDLI2iweAreu0Hn5W2JHikY4h9yCt9ZJzTTOOU3GpT2U9I4HCOsm8aKbCEP7Ww/FKCv+DZPBFdT7YliocIDD1ZfEiocGliRZI3BZhCmRuQnbDMXMmglgRBEoPnid3Bx5uvFH47iHtHCb6Ug8ACiDm8Dfuze3SV/n9wl8tFuYqGqnBFtpJoah4lwD/HAEuNvrPMVoAYVJrQ+bisPrw2pj9Tu9+/S6qa0+pucNXSQ4hklBO4fyB1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPTYIujbxYcieE8zsPh1x43g4nGtCoz1IKVa5SKcC3Q=;
 b=QYjnKO7mFU9y0OXt1tu7sydfgyhpNYcjSMP4u+jWCxpQA0b5h+8/qZYDYpFsNvd8ljMT6g7GJj2kO2KqWrwwi6sy4Z9lakjRujLt7YX3QsANGxf+2LR6WUZLEynVnIGgBAw4qcl9UswbcKu3IkV8L/Y1ak4xq/Cm1p4+LOjxn8U+VnVBHeUqFAvqt2DIIzeepFCQu+ewA4p7W8qU4OmuBjNa69MxeiHHEjJP6/AYy6MFhbMVe0WmcYY/sLiV1nrZwsAvHSNa8i1gvUTGdqoMvX/yvkBHM3CvqUtvnuPN5xZPEb1OS668+s+/uR28ezDUPutPOnuHCgei8PwQ0UmtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPTYIujbxYcieE8zsPh1x43g4nGtCoz1IKVa5SKcC3Q=;
 b=BAssbleaEZ3qE8GavUNTHRFXaG1GEPI3WVR4qnjCrXZ605H9SJxcD33Anr591jPh0vcbBIk++zUSR5bJt2o2fGNjCNYz1QNNT531yzPPWII2m623iVLAR15ifG4d6AxtRtVYCYzV6IvCtckzV4tKY0KA7+zMsNdBlkM/W4qQt3bX4srQIbDgn0qSDF3Nl399rjufCpttjzfDy6C17dn+qBYDfmyRCyvurdIGKm68RL+hMxEg+OzkoZHejov2VKNeDJ0Siym97ItPJDnATXaBIQdZhry+sqZqVoj73b2XDpX0TmgXB+QA3rbkXus3/Mw7ttv6/OwSTjogiy/yfm0VKg==
Received: from MN2PR15CA0015.namprd15.prod.outlook.com (2603:10b6:208:1b4::28)
 by DS0PR08MB9424.namprd08.prod.outlook.com (2603:10b6:8:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.25; Wed, 13 Dec
 2023 17:53:50 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::3d) by MN2PR15CA0015.outlook.office365.com
 (2603:10b6:208:1b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 17:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 17:53:49 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW36EX19B.micron.com
 (137.201.85.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Wed, 13 Dec
 2023 10:53:49 -0700
Received: from micron.com (10.3.116.19) by RestrictedRelay36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27 via Frontend
 Transport; Wed, 13 Dec 2023 10:53:43 -0700
From:   <sthanneeru.opensrc@micron.com>
To:     <sthanneeru.opensrc@micron.com>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <sthanneeru@micron.com>, <aneesh.kumar@linux.ibm.com>,
        <dan.j.williams@intel.com>, <ying.huang@intel.com>,
        <gregory.price@memverge.com>, <mhocko@suse.com>, <tj@kernel.org>,
        <john@jagalactic.com>, <emirakhur@micron.com>,
        <vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
        <Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 0/2] Node migration between memory tiers
Date:   Wed, 13 Dec 2023 23:23:27 +0530
Message-ID: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DS0PR08MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b880a5-a234-4407-0a36-08dbfc047678
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5pN6J85TBtbITYv8skWa6C6jasX06rx5z5d2pe/4tVV2a+AJrRbnVF03GREmjJoNlaeMmPHh43SzW/yrePAAIzYfrgBaTtzymidnhtoH9pSSIXgAoqtrsll9KRVxS/7cc+IPls4pZVUwDfG1WMBu8gMGUwkQ7r7xeyt1591vJberYOU2rFouR2nG0NN7isIzPRrXVQXB4aMp2uRZsMNGKG+niGaQyKErVoEU6WG4UJx4csfMQLLyb2CZ59cUE9Sw5tuCUIiLH++0MfyN1yx0yzjFViD7X9gEqaWblQtgFzkjpXVT04Q3vPvsqIlm2gD7biz/6b6IXwgPJxXFzHChsyfRBaj9iIyzkvSELrZLUtZc8UHzogevEQDkLCbSV9dmZoOklSk3NFARWdzjz2afq48/VB7zDtd2RS5wekib3LtTcffylaMHI2GXyjuN6V/Tqv8/OngaTnQIlXQvoIhGsMGG7Z6icknf7qC22JCixb/CPNXiBZGN+wkmrUkLjZA9XW1U7cKXzgana9+XA8barDMTcIZjrS3ZKRsV7PYPcMzg5uX3pznVLpJ9XIj69K/7+imHn8512A1jaqqUOcodvzLLv157YqCdAi3bsg98yQXUTkEa29bT7ETgWdQn/iQHZurm13jcNLs+ZpLl4Znoo6luPRAQ/x92L9oXnf75aW0x+cmMGK3xk+59DLGGuRpVco10BzD2BuAj9N6dfmbg44WPJcgydvgckXVZc0MYobZBRpQYTbDYOe69no7d0SZ
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(54906003)(70586007)(70206006)(110136005)(1076003)(7696005)(6286002)(2616005)(7636003)(336012)(26005)(426003)(6666004)(36756003)(47076005)(86362001)(82740400003)(356005)(83380400001)(966005)(36860700001)(478600001)(41300700001)(40480700001)(8676002)(8936002)(2906002)(2876002)(4326008)(55016003)(5660300002)(316002)(40460700003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 17:53:49.8673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b880a5-a234-4407-0a36-08dbfc047678
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR08MB9424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

The memory tiers feature allows nodes with similar memory types
or performance characteristics to be grouped together in a
memory tier. However, there is currently no provision for
moving a node from one tier to another on demand.

This patch series aims to support node migration between tiers
on demand by sysadmin/root user using the provided sysfs for
node migration.

To migrate a node to a tier, the corresponding node’s sysfs
memtier_override is written with target tier id.

Example: Move node2 to memory tier2 from its default tier(i.e 4)

1. To check current memtier of node2
$cat  /sys/devices/system/node/node2/memtier_override
memory_tier4

2. To migrate node2 to memory_tier2
$echo 2 > /sys/devices/system/node/node2/memtier_override
$cat  /sys/devices/system/node/node2/memtier_override
memory_tier2

Usecases:

1. Useful to move cxl nodes to the right tiers from userspace, when
   the hardware fails to assign the tiers correctly based on
   memorytypes.

   On some platforms we have observed cxl memory being assigned to
   the same tier as DDR memory. This is arguably a system firmware
   bug, but it is true that tiers represent *ranges* of performance
   and we believe it's important for the system operator to have
   the ability to override bad firmware or OS decisions about tier
   assignment as a fail-safe against potential bad outcomes.

2. Useful if we want interleave weights to be applied on memory tiers
   instead of nodes.
In a previous thread, Huang Ying <ying.huang@intel.com> thought
this feature might be useful to overcome limitations of systems
where nodes with different bandwidth characteristics are grouped
in a single tier.
https://lore.kernel.org/lkml/87a5rw1wu8.fsf@yhuang6-desk2.ccr.corp.intel.com/

=============
Version Notes:

V2 : Changed interface to memtier_override from adistance_offset.
memtier_override was recommended by
1. John Groves <john@jagalactic.com>
2. Ravi Shankar <ravis.opensrc@micron.com>
3. Brice Goglin <Brice.Goglin@inria.fr>

V1 : Introduced adistance_offset sysfs.

=============

Srinivasulu Thanneeru (2):
  base/node: Add sysfs for memtier_override
  memory tier: Support node migration between tiers

 Documentation/ABI/stable/sysfs-devices-node |  7 ++
 drivers/base/node.c                         | 47 ++++++++++++
 include/linux/memory-tiers.h                | 11 +++
 include/linux/node.h                        | 11 +++
 mm/memory-tiers.c                           | 85 ++++++++++++---------
 5 files changed, 125 insertions(+), 36 deletions(-)

-- 
2.25.1

