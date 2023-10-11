Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425547C5DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjJKTeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjJKTeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:34:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E59E9E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmGLZ1FRqC4GpkfR2fYITFLMBQss02FNXipJtXSOvm3BWlL/4Jv2+nc0UNbOB4p2EXz5sxgwQNZG8uI2ASNBeBStwlQPOWAIu1u02TShXCqj/nlpzCyWLyeqZIv5S7JGAdjN92p9pWZPgzhBLVTdVuHQhO4RbZcAqN3j71Y+z5Zi+ivHEwDwQsm1LqI+aqtTmOj6D2QJ31/71EN1qakL5PepH3Ad3ZerYGMJ8z7jgkah9NQQNGwTbxEEdXc3qi7bE65oymGTq4WMSKaQKdp7dOT8uSy/3GLT7etHlqqsAx/meL6zt34Ue0cyD348lBToAwsUO+DZOdOt1fQNwlMF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCuLorx78KVrEjTb04MuaM0aK+svKG9hJ2gE4LlMkHI=;
 b=AqN2AZ3NQbUaegyRMqDH0xlxjap8aNflCy8GKJwyBkfOfyyXrBpiukD4qdKbMrJop7x8hyHOMJ3Om3mzCsFtc9b52FzzX61Y+6tpzr6PaUeniIpwqpHxCCt2sPakGLDST8fTcEnqvyQqajtgbkoB8gsNIxu0Ps5IMn9fIYwyf9PdUnbOH7dfGSbfMNOVIbDG0Z89v1riJ7ujjJTTaFvOgX/43jPpyLq/BDAoE8OZyrGCq6wX82o+cLRzKtTYEEpe9/yHIE41WELbObDnSN/iUCYafY4w9h6uePsCdVLUjTb3QLNi9Uh5ak4xVhHoaZEiOG9SyQlCkWNH5aIs6McjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCuLorx78KVrEjTb04MuaM0aK+svKG9hJ2gE4LlMkHI=;
 b=WMXZjq5P13i1ytQUyznr1jfPAPzrajUriC+qs7qFJd/MwW+YEq+JVQc8FnFNpkIVHJhZhqbYT3bGUMi37NOvGw3GhIhkprHw7qlgrfsvBkdRZISNRFX0I+TS/M5HtW2pM8jhVTQQDrCdhgdxePpiwRWjxDi2yauG7Iy1CDa520ZyH1awdPSc9UkrC/1Hmp2YtVrCAVWIcYukDryNOXTL0JkuyhXkt5P7d9V+v/J3EpxLkmN1qOMd8hffR2HlTsLaH5WoFUc9VGtF5sBCgg5l2iZ5t3qpgxdsEWYPzvQ6hOmB98P2GH1Sj5BCGRk6n1CG8k5ewWHwde6I4vQBQi0FUg==
Received: from BLAPR03CA0096.namprd03.prod.outlook.com (2603:10b6:208:32a::11)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 19:34:09 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::62) by BLAPR03CA0096.outlook.office365.com
 (2603:10b6:208:32a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Wed, 11 Oct 2023 19:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 19:34:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 12:33:30 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 12:33:29 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 12:33:29 -0700
Date:   Wed, 11 Oct 2023 12:33:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Tina Zhang <tina.zhang@intel.com>
CC:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [v6 PATCH 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <ZSb4h+I/IKHjVKLK@Asurada-Nvidia>
References: <20231011065132.102676-1-tina.zhang@intel.com>
 <20231011065132.102676-5-tina.zhang@intel.com>
 <20231011123910.GD55194@ziepe.ca>
 <ba9ed927-0672-4252-9cfd-c43febf68d49@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ba9ed927-0672-4252-9cfd-c43febf68d49@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: e09db2d0-24a0-4c5d-3aed-08dbca910a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFoowfda2izRTt7FUf8S1HGfT1csQHP72JcWyUBmNoj5YN2IGbfoKDaqabHHG0mlVw+dMBpcSfeYQX5eSX0aSaTu6N2fQUF2cTmQrMvdV4YruKJmjuD6r94TJH64TEd0MvZxiJAoqeTcxjTGFf7EQLJkMkIBxQ52ShsoufhSSuwCAX+SoNKUyHPWEY+phPIDy0tJBN92QofbCEnVj1VMh9gcrQxGm5FoikEKBW+9eS7MMJ3N42yMqajPS18AgmdljlY6QjDsvfkHbvpMRlCuQBzUdDZm7KpkX6vSsDDhMlUr9GHhwnqY7JMkmRFg5BtmNKkpbyRrNM/I+ylCGlV2+ohk0uljnSdltECQ0B9s8nlTNaH9uX27vFMzo5bj5XxuvUm8YxPZfFBU88obuK8+T8fDnTQC5nXRbMIHNKyeIUZQkZ4eVQ60V4bNXKW9KOrgx/nh5htEtUBEa1QNcyq6Ul5AYNb7BcJoXeHG5mhlK04mVnpx3SJnIDsASVVyhUiMAOh7QlmLORDwwI6x2/8WsG1oNYGGM2Ihi/Dtu91xhu78v0myQ6BJ1NP/OSTokV+E9LTHtq9CBBVa4ZRg1fex10r2UFa1ysOyfL9oxIr2drcV7YxUDTew85eDjLXHHv8lLucLgNJvW+sz4/9sEbhYaau7/Tul8QsKZh00AiAQoeoIyj6eflmSsIcxeT4Fu1cV2nwdxCiqpxZKc6etgOusBqn2JL5H3133gcpsoywLYrVQgPYdGUNa3wP5p9QwQynA
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(70586007)(82740400003)(316002)(83380400001)(54906003)(40480700001)(356005)(9686003)(70206006)(336012)(7636003)(26005)(426003)(53546011)(47076005)(478600001)(110136005)(2906002)(5660300002)(41300700001)(8676002)(8936002)(4326008)(55016003)(86362001)(36860700001)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 19:34:09.3517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e09db2d0-24a0-4c5d-3aed-08dbca910a56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:26:12PM +0800, Tina Zhang wrote:
> On 10/11/23 20:39, Jason Gunthorpe wrote:
> > On Wed, Oct 11, 2023 at 02:51:31PM +0800, Tina Zhang wrote:
> > 
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 3b6d20dfb9a8..985403a7a747 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -1277,7 +1277,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
> > >      mm_init_cpumask(mm);
> > >      mm_init_aio(mm);
> > >      mm_init_owner(mm, p);
> > > -    mm_pasid_init(mm);
> > >      RCU_INIT_POINTER(mm->exe_file, NULL);
> > >      mmu_notifier_subscriptions_init(mm);
> > >      init_tlb_flush_pending(mm);
> > 
> > Nicolin debugged his crash report last night and sent me the details.
> > 
> > This hunk is the cause of the bug that Nicolin reported.
> > 
> > The dup_mm() flow does:
> > 
> > static struct mm_struct *dup_mm(struct task_struct *tsk,
> >                               struct mm_struct *oldmm)
> > {
> >       struct mm_struct *mm;
> >       int err;
> > 
> >       mm = allocate_mm();
> >       if (!mm)
> >               goto fail_nomem;
> > 
> >       memcpy(mm, oldmm, sizeof(*mm));
> > 
> >       if (!mm_init(mm, tsk, mm->user_ns))
> >               goto fail_nomem;
> > 
> > It is essential that mm_pasid_init() zero the new pointer otherwise,
> > due to the memcpy, after a fork two mm structs will point to the same
> > thing and one will UAF/doube free.
> Good catch.
> 
> Thanks,
> -Tina
> > 
> > Keep mm_pasid_init() and add zeroing the new pointer to it.

Yea, testing with this sees no more WARN_ON:

---------------------------------------------------------
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3d782fd0f485..4bc3c49cdaf9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1208,2 +1208,6 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 #ifdef CONFIG_IOMMU_SVA
+static inline void mm_pasid_init(struct mm_struct *mm)
+{
+	mm->iommu_mm = NULL;
+}
 static inline bool mm_valid_pasid(struct mm_struct *mm)
@@ -1240,2 +1244,3 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
+static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
diff --git a/kernel/fork.c b/kernel/fork.c
index f06392dd1ca8..d2e12b6d2b18 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1276,2 +1276,3 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_owner(mm, p);
+	mm_pasid_init(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
---------------------------------------------------------

I'll confirm with v7 too.

Thanks
Nicolin
