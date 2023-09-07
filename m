Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4089797B60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbjIGSPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242208AbjIGSPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:15:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AAE198E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+LON2yt7J5Kuu5tt/97XDV94NGOjSwagFThwBHAYUYk+7kx6773bXL+gJ4Xss9Gt7Wq/+am6vQip4/RcBzyPXqGSOj1aKamF/JER0+E7lf0J8ppcj/ntxEM2zITCaL+M3hdTFtiPzJIcQwHpM6fc/2o3CrLzPXSoHI6xa2NR+NCxZTE+nlpV2T9ePeFw8YGhWcwRTRv1fJZ9gAcwFOwYf0auTWX1GIFPZw33qAFlhMuBTSXWS1NOpTw6Jd/ocWEUjiadqU+WUZPzsUyOUpPY0qfud34UjDVGb69hBKOj19JVodT6c7Q598f0/Y/l39s2EeX7CVNBhHjItynTT3Dqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7guXSnVgzXmBLZaK/Htm+O00j14TMVn7RHlHieV1do=;
 b=L6KjqXgsqkLm/JEqaz3KSo7TlLbuoAnW97NOm1YZCAcTAbgOD3fcTJMSXEfMEcEycA0//BOuwSrnsh37NaIlTfb34YMQfP1lp7Sm0xCKDholIJP5I2VH+eFjpa7ymKFr7rc6P3X/k55j8HX3Wb6zTozbA4cu75hzlKHjMvoEQJNGVC0P3gOeIkxJdn8HHIb8GjOYmMsVpBB1+9nTO+0FPGY0gx0eNqCzp1k2fddvPaz+YcsM+SfaLq3Cle89Ptia2AjqARBGjUPJL3D7xA8MCES3U2E3GWkvlXJ3bgko6gnQg8E2N1NLRwVRzRPlw3ZJ5tFlGKWW7xh+LFjEfhynSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7guXSnVgzXmBLZaK/Htm+O00j14TMVn7RHlHieV1do=;
 b=q9YCgBFCWpA+gMsSjwANoGiSaR81zc1YRg5BrmKQoaUGpEbsrDW6f9t0PNUTAYYz0sElIIEBp89Pkv7XIu5WgmKRDvkSsD7X9LqqNlFs6G/9Zr8k2f1st41KfE8yhwN8C/HLK8IwD+55ZB3hmiwnm5b3aK+e2lB4wnpkUdaspZKyGXyV5b1Rzw+VUVCCjsvciyMU+zYjZNFDneCh1e8yhGEc1kLpB/9Ouy3J/DVTCXheSbqEk6YsMcakyeVMGK3RIVtMq6niDoZO6ENUW74V0eQyPKju6o7Tl7Vg+1GJJkNJ+7e3HJ+J0bne/V9xvHD7rM/7H4OcdSWV3muShb+NeQ==
Received: from DM6PR08CA0040.namprd08.prod.outlook.com (2603:10b6:5:1e0::14)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 18:15:09 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::c3) by DM6PR08CA0040.outlook.office365.com
 (2603:10b6:5:1e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 18:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 18:15:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 11:15:00 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 11:14:59 -0700
Received: from ankita-dt2.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 7 Sep 2023 11:14:59 -0700
From:   <ankita@nvidia.com>
To:     <ankita@nvidia.com>, <jgg@nvidia.com>, <maz@kernel.org>,
        <oliver.upton@linux.dev>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
        <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
        <apopple@nvidia.com>, <jhubbard@nvidia.com>, <danw@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] KVM: arm64: support write combining and cachable IO memory in VMs
Date:   Thu, 7 Sep 2023 11:14:57 -0700
Message-ID: <20230907181459.18145-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 1888e66f-57b2-4968-36ad-08dbafce5e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDhCUTRNHKGkajrk+hQ4gbi+WI0L5/QDIhVbxM/I6omfpvF1HQcSF2Qb86PAb1VBV0qKwBZqiGjMCGA9HM4iMef3ifBg+ds7w7AsSvP2X3zBuhMCBBW2reA+Ufuhlb0jNOJB07o56gAWVt1KuNQaOIrXQXqp8NsKbIEcgGJSbmh6E5GBhimhEDsKGHUnEn/1dbl7uWsLMo3bS/NmVqwac0Tox+pPfctF0XbxnQIJdo0Y5i26y5IUxrBRQP9+HjxI11NLGFvtSMVC4/tQp20/FE/ETRHTIw2HeynNHz9ImehvufX6NNW/wSPlDOq4Gs+dNDbV5lrPM76GLaP82j4QPcK2ZUzdjWNF1aA7sa0zsaHLvXuo7HNHVyP5QqyppRtp93EMMVLksx+6cSm2tqK99qsEJIEnHL6Y4APMkbRPvB11daQQ/mph/v1HKCywC6bu7tbikkOWN/Hm1bquFib0vkdaEce9fTCQBqTTvK2gc+Iv0wh1nrByK3ErCi127NPI6o/86IV/asY7iC2+63367hBhtfzUlwYTQWLA0y8/+03lQxCHgwfS9GfTKk+JGkJWcmUfgNHRLIhcmr0U4opKzbfisLX0HeCUg74Yf/biweydwVzx998WibEe+4LXw/VO0fBT/x7mjcWKDQCvT4ubSS1orv611lteWh6WLxkXtn2SeLutmwCUSq0WcFu+OxuwMQ6Xu90OZpsVl3FkLaC4SoBh7sT9RqQhUBCHOBKlm1ilwEZvovgybFeKm8BdRQj+
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(82310400011)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(7696005)(478600001)(83380400001)(2906002)(1076003)(2616005)(26005)(336012)(426003)(110136005)(2876002)(41300700001)(316002)(54906003)(70586007)(4326008)(70206006)(5660300002)(8676002)(8936002)(40460700003)(82740400003)(40480700001)(47076005)(36860700001)(36756003)(86362001)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:15:08.6546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1888e66f-57b2-4968-36ad-08dbafce5e94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankit Agrawal <ankita@nvidia.com>

Today KVM forces all of the memory to either NORMAL or DEVICE_nGnRE
largely based on pfn_is_map_memory() and ignores the per-VMA flags
that indicate the memory attributes.

This means there is no way for a VM to get NORMAL_NC IO memory (what
Linux calls WC memory, which is used for performance in certain NIC
and GPU devices). There is also no way for a VM to get cachable IO
memory (like from a CXL or pre-CXL device). In both cases the memory
will be forced to be DEVICE_nGnRE and the VM's memory attributes will
be ignored.

After some discussions with ARM and CPU architects we reached the
conclusion there was no need for KVM to prevent the VM from selecting
between DEVICE_* and NORMAL_NC for IO memory in VMs. There was a fear
that NORMAL_NC could result in uncontained failures, but upon deeper
analysis it turns out there are already possible cases for uncontained
failures with DEVICE types too. Ultimately the platform must be
implemented in a way that ensures that all DEVICE_* and NORMAL_NC
accesses have no uncontained failures.

Fortunately real platforms do tend to implement this.

This is similar to x86 where various BIOS choices can result in
uncontained failures (machine checks in x86 speak) on IO memory. On
either architecture there is no way for KVM to know if the underlying
platform is fully safe or not.

This series expands the assumption that any uncachable IO will not
have any uncontained failures for DEVICE_* and NORMAL_NC and that
cachable IO will not have uncontained failures for NORMAL. We hope ARM
will publish information helping platform designers follow these
guidelines.

Additionally have KVM drive the decision on cachable or not entirely
on the VMA. If the VMA is cachable then the KVM memory is made NORMAL
regardless of pfn_is_map_memory(). This closes a hole where cachable
VMA mappings in a process could be accessed via an uncached alias
through KVM.

Applied over next-20230906

Ankit Agrawal (2):
  KVM: arm64: determine memory type from VMA
  KVM: arm64: allow the VM to select DEVICE_* and NORMAL_NC for IO
    memory

 arch/arm64/include/asm/kvm_pgtable.h |  8 ++++++
 arch/arm64/include/asm/memory.h      |  2 ++
 arch/arm64/kvm/hyp/pgtable.c         |  4 +--
 arch/arm64/kvm/mmu.c                 | 40 +++++++++++++++++++++++++---
 4 files changed, 48 insertions(+), 6 deletions(-)

-- 
2.17.1

