Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E2080179A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441868AbjLAXZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAXZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:25:22 -0500
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B3C1;
        Fri,  1 Dec 2023 15:25:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA3zUv7HWR9u9TQP32ZcK7zMfPes4As9ZhSv9aweEMgOOQY16YfaKPqQp1f65UrdH2FVASShcDb3sV65wXBoD4XDNzh2JVL8hbwCUldQQvqBq3nGkKm3y1jTA4XVkorP06LvrvJ5WPi0bN43VIxQOG+1/+5mnGJFDBGbUWTEbDXD1Xk9+fy9mI/gUosPbK6Whe0tAE/PCNU8XH+/ar36/3BTXGcctJhoAjk7f+ZW80HYq9nun64sGUIOHwJPAlr8Z/esNLk4jsEyMW6FjgdUbsvzQEbZbHwZJudDBJjwGsW5hDuod44x5DG9JB6ihEtHsIn+JU3OGa3XWi1ncN0HTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPOUHCXmygdEkzbrmdAnw2+yVj7EiUemlaEy4umZI+Q=;
 b=l8Y7StJtIqtlp5OEF3xd1QfsBohSV1Ev5/3fT9W0KimF12h1uEn/+bHgwQzgTynM/ZEJZqzyN9Dyz+/G4grL/3nK2hDwrKawZLzi5HfdnbxLru9TEOZoqzhPfU9PVYEHu95YBv3m9Z21Pnnu1gmczKZemstpUSgMjmy/kGAHRYA0WUTm8BH8sPQ/giBPP0ZT4VkdjpTiBddgN036oClMV40jj2efeMoaVjL64Ul0R/zJxKhf+0qVY63KiNiiDjXMZ+atVvHDJGzRkSEbR8pam6nvxemTQRfPGBkSAiQZvAVQ3WmWpgUERllUveOTPw8jC1lL9k7M2e+KgAVl/CHOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPOUHCXmygdEkzbrmdAnw2+yVj7EiUemlaEy4umZI+Q=;
 b=GhvMrELaFJqzIxc73ouqq11bWg38OCitMHjAkDCshrcFXW1vgj5SMn9RhqaJMRilKXevXgaHF58fUpEJdgd3gmyKfd2/2uvseB84zTJtFeocl4WXFMg2YMrq4ttLr/DUQGNL/LkTtYaESadqF8kjIedq8oEd978LvwG8gluAlQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from MWHPR05MB3648.namprd05.prod.outlook.com (2603:10b6:301:45::23)
 by SJ0PR05MB7787.namprd05.prod.outlook.com (2603:10b6:a03:2e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 23:25:05 +0000
Received: from MWHPR05MB3648.namprd05.prod.outlook.com
 ([fe80::10f0:590a:708:4ad7]) by MWHPR05MB3648.namprd05.prod.outlook.com
 ([fe80::10f0:590a:708:4ad7%2]) with mapi id 15.20.7025.021; Fri, 1 Dec 2023
 23:25:05 +0000
From:   Alexey Makhalov <amakhalov@vmware.com>
To:     linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        hpa@zytor.com, dave.hansen@linux.intel.co, bp@alien8.d,
        mingo@redhat.com, tglx@linutronix.de
Cc:     x86@kernel.org, netdev@vger.kernel.org, richardcochran@gmail.com,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        pv-drivers@vmware.com, namit@vmware.com, timothym@vmware.com,
        akaher@vmware.com, jsipek@vmware.com,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, horms@kernel.org
Subject: [PATCH v2 0/6] VMware hypercalls enhancements
Date:   Fri,  1 Dec 2023 15:24:46 -0800
Message-Id: <20231201232452.220355-1-amakhalov@vmware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122233058.185601-8-amakhalov@vmware.com>
References: <20231122233058.185601-8-amakhalov@vmware.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a03:505::17) To MWHPR05MB3648.namprd05.prod.outlook.com
 (2603:10b6:301:45::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR05MB3648:EE_|SJ0PR05MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d14b7a-8f5f-41bb-db8d-08dbf2c4bfdd
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtFwd,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLVZ8PYbeLz95BcxaydHAqYHwbZV4LJcSaiR5+V1CktXh8Rb0OMmiorBCXn7ZinfMbVdesWunbMYDEg3yZ6/dB1ZwxcKiJpiuUZPG4eWcPAnyBkyof2Ur/w/9//P4iYc08emgzVjSjYBDyyKKBO6LsDHT4oQhVCFJ7G3IbwUtqGnQyYfSunAPzZcIbic/bEwXpJcFy2LLdAduvL0MxS2ervv69VHkdf8FaN0Go10M75/9a4K2iNYhl30CA3lRhGyIcsYPvUrdaovpVuE22xMtEg+lb18Xvb0FPGotzzE8IscdZanHaERTFKmWcw4L3jgo4GSLX1CwiEtGo3Tcxh+AzS4gUqCZCjC62pUi82lXdp3voPt8P7brLKcEdAoYs+uA+ZxjqvJgl5tgWhIIlx0GPsTzyaI7MeYL4RxPD0m/C3mDvclfAmL1nVx+3H/sRyBJs9Um3BBYOl9JPzPSPcQi1klH2jsD99Dej0lorAjMSCgoRRjH+dDLRxgosQqcPfT+PwxUqG/GzxtizFpmKR96UAuXGW5FtloGQyeQEeQhiqklp9KVdBLgxNh+FusgdLLoz5ByMsPZr5CjL2VkIJDeN7PkD3+gRRfR+jpgqnwYgjT3l/08xxAeVNUI1xXKEAlz28pKImjnm2b4TNtY8xEBdEhTL+IlhtPGSDhnuboLvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR05MB3648.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(36756003)(8936002)(316002)(66556008)(66946007)(66476007)(8676002)(4326008)(478600001)(6486002)(41300700001)(2906002)(7416002)(86362001)(5660300002)(38350700005)(38100700002)(2616005)(26005)(1076003)(6666004)(6506007)(52116002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gkMa84Ovp5lQeKp0m8DV9hjB5kQWKAUucqztCfGGmAwLBCE5cOF7mcx+Ar8D?=
 =?us-ascii?Q?5/xSEGkFOi0LWYa4PbKRilZcOCizHVsvPSHoESFnv5bn+vboxgG77CyLHMc4?=
 =?us-ascii?Q?qP912ez+K+akUeYry50SFIuLb+B7+e16oUkHbCSe93D8eCpU0QobDVA3ijRk?=
 =?us-ascii?Q?xlc1btpbgjnhNTsFLQ8DC0Xty3zNNO8vCxER0EZN/6WjwzPyxteKT9DQrWMe?=
 =?us-ascii?Q?mAPJxJZ3tjDibkPM2Zr5n7yHXd9VVV5OOOlWN3IVGe+Mm7i+meAVL8Ta5F4d?=
 =?us-ascii?Q?Sx9n3fiQ2KPF/am0qq5tiHstplY8BdizjQZt9ft2AjuCtV5OviKxAZ+U1hzp?=
 =?us-ascii?Q?bgGa3RcNB3RiTumEaejkMJGyKmoUbQaxm+2zrBBW12Y94Axa8NufkPwZObuh?=
 =?us-ascii?Q?i0XIPpo2e1nyPbNvHoJf8H4Xig9SV05Yzp3FBr6Zr/o9zOAr0IVwJ1hHl2iY?=
 =?us-ascii?Q?D6zujunRE5vK2lwDPl+NwV8ZWEIHMIw23kEEiHUJUfu/UCM51aGGFbr53ypm?=
 =?us-ascii?Q?rUBZ8Dn2V4AQergTFd3u54H0UGIV5nt+VM9z7DgSak5pRrvCBVk9Ch/qQImT?=
 =?us-ascii?Q?190jvFciNmwEMgKzQgIlBGADOBXetKT+7RHCnRUrVneLoK+AFM4z2diSxM+7?=
 =?us-ascii?Q?5dq7klrP2bbjQKgrbO8uGYpJYhAfQQbXpOS9mN+qTrD9aJNeoTRLLTlBZ75X?=
 =?us-ascii?Q?6Uzbd/qJqe3g+I+oESOIN5sLY7yKBib5MjWzK6dKhpbkjNAo0+Yej8vocVT3?=
 =?us-ascii?Q?21p7bGbfmGfYvlbl9PD3wq2zrWOtRo0ONv/PJoVQsaVO7to8w3Eb9qCdNmuu?=
 =?us-ascii?Q?REdga77Z8v7XZwn5lqONC7K6jvqPHov/+7aE87nWqT8I9TDQeNHyyp/+X2dV?=
 =?us-ascii?Q?VHIxuYMICo/kG2hu2lsN8+vvuhj62/plVa1zKbrO5tdUBjkWPAdxfiKb0ooG?=
 =?us-ascii?Q?7DiN9THp5S6KbK5CNpkPG1qK74LW/OfUq9+XzEU6X41rbypP5tcnE2qbZ2Hf?=
 =?us-ascii?Q?wfllGEc2iTghVDppvMw/gEKbtxPG1FoRaR/1EPxsr0tHfZYRoJDRsHg/2dXB?=
 =?us-ascii?Q?XAZopEc9p9EcXkvKJbGZmkdC2PYwh1jFa5HKKCEMOOqMcRRG/JQcHxcT3JIL?=
 =?us-ascii?Q?XS1gCOccdJZhCC7W9D/LLToBopWlJ7nBI5LP5T9jPh5UrECQa+4ZX6AIQL4x?=
 =?us-ascii?Q?uvhwSQkXIFWQFEHg7VQFS0QKYoTMUiAeBnWa0WMt17h7f2nNZZG9aUBTY2+q?=
 =?us-ascii?Q?P2XTKkeRKNb00etg4RQoL2NLq9PeAFXnIvqoCCEcgMXMX+/E3E3/bxSAmQXU?=
 =?us-ascii?Q?ihAareH7EHviv98S3VarfQpkmco6Yk3SdOarp2igrVXrzGBEMTuOyyLWppfS?=
 =?us-ascii?Q?KmK0zymGKPCQRX+tG/qmm4abaKwi9amBpWz6IYl0+5yz6nQgug7Vf70iJJlf?=
 =?us-ascii?Q?HGsSaduCaDOJmb9Jua8+MlRatmJZnF5wa7k/QaCghLbQeRbllE2VaD+SMm01?=
 =?us-ascii?Q?aALvpW3hERl/HuYil0pGlxU1wp8kVumAPnQHM6fXiTSedYLT2MuyJRm3LjiR?=
 =?us-ascii?Q?LdSn4aAMw5Vle1PstdXmUDvSXd9yRMh0hskDaRd7?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d14b7a-8f5f-41bb-db8d-08dbf2c4bfdd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR05MB3648.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 23:25:05.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+L/jgdkMy6B5UOMCuEuNFYZnGiRA1JerU9ZOYrpgB95DqpZfedG0tthOYp26eVH+kC10PCcBfWJ+FUnMIVn7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7787
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Makhalov <alexey.amakhalov@broadcom.com>

VMware hypercalls invocations were all spread out across the kernel
implementing same ABI as in-place asm-inline. With encrypted memory
and confidential computing it became harder to maintain every changes
in these hypercall implementations.

Intention of this patchset is to introduce arch independent VMware
hypercall API layer other subsystems such as device drivers can call
to, while hiding architecture specific implementation behind.

Second patch introduces the vmware_hypercall low and high bandwidth
families of functions, with little enhancements there.
Sixth patch adds tdx hypercall support

arm64 implementation of vmware_hypercalls is in drivers/gpu/drm/
vmwgfx/vmwgfx_msg_arm64.h and going to be moved to arch/arm64 with
a separate patchset with the introduction of VMware Linux guest
support for arm64.

No functional changes in drivers/input/mouse/vmmouse.c and
drivers/ptp/ptp_vmw.c

v1->v2 changes (no functional changes):
- Improved commit message in patches 2 and 5.
- Added Reviewed-by for all patches.
- Added Ack from Dmitry Torokhov in patch 4. No fixes regarding reported
  by Simon Horman gcc error in this patch.

x86 maintainers, please consider merging this patch set in your branch. 

Alexey Makhalov (6):
  x86/vmware: Move common macros to vmware.h
  x86/vmware: Introduce vmware_hypercall API
  ptp/vmware: Use vmware_hypercall API
  input/vmmouse: Use vmware_hypercall API
  drm/vmwgfx: Use vmware_hypercall API
  x86/vmware: Add TDX hypercall support

 arch/x86/include/asm/vmware.h             | 327 ++++++++++++++++++++--
 arch/x86/kernel/cpu/vmware.c              | 101 ++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++--------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 197 +++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 ------------
 drivers/input/mouse/vmmouse.c             |  76 ++---
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 551 insertions(+), 520 deletions(-)

-- 
2.39.0

