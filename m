Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D017B792592
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbjIEQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354550AbjIEMfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:35:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3741AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNxxbXArF5zbGzSs2XhWlBdDfNROg3dqAN7DEjZrnItf4vS1UXhArbODz3I+Q3CISC8ybW0++Y3VGBjC1UZx9g32J+WrevD+PZTYu2LHEgkqcMYpinBI4GNIyp5SwrKtlT1sNoeYH+xNkvNfhxmq5HiUg/1/bUdBQXgkKRyDKUDU2tfZI5WIpCbT7mqHcs5fFMxA4SJtrAT2Dq1MusRo4uiqNVKVJ0/YLSRbksXKppO+ROdEeNGm+ioMW9aerd2PdaFvBjfXOLH2tUdTOR1ZcO7FSeZlfF0lv1UUQIBmwPl0h5wf/vHzj9YftrG0PT8abXfPyyINKDSCODqY+QZr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpJAym3ocABoy8OqMrNBtWDKGtb07uHSL3uU7ZrNAVg=;
 b=RdnxshyT3pOXRSp1Zg67rY/72LTeiX74Ep/BSI9B308i2N/y+s/TFPsxDD8KGEjaulAZeDOFWhdscp1FCB8PLuWkS43lVz8tDcpyDdHc7O2q573TtqBNyNzaP95FzgspCZeqfL2VKMMpic6gGbXxaXf57D9V3xaIAWEXoLWKfu+/WWLajYFj5xRLpfnlUVFqhVWSDRhwsatd6NcLUfLsOx5MNgVrJuwEi5RV1H9OAB9CCkPWFKaHbTlq8Rrn3Zbmr21odmpyPN1GBuAPP0ZFMG7Dkn97UhsazbetgxOlOzpSiO/6KXIlqX8L/cy5fOYVJKc8vGnxn7SNu4di3iRgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpJAym3ocABoy8OqMrNBtWDKGtb07uHSL3uU7ZrNAVg=;
 b=ekRMCy5DuZ/eU9IHH0JjRd0MRYGJax8L3rFbYjF/Dv/eeLaAfw+Kw6yfgBOJwx/uGjY67LIHn30R+gVzHwfQzz7dCyqHmVUwJy5TAWPwKV87t1abTplKewwWXNAbaVLQM5iS4nKtkJm/+NTcwOPLPz+jaJP9acs9kF8Xk1j//RKH6zW2GvzAQhQG+/ATdnKAnmI0QHxwmaRt80K9ff0wzZNH8noyUuF4sJVt441jkcox9S2F1oJDlGs6ZkB611Y8Lv+ETjP6t1rTe/6cNM0FicKPajnouIPcsxiDBKdEahQAzzzwWf1oVH/eoeu3elfjC+yOz+D9u6Itm7ns+MzZVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Tue, 5 Sep
 2023 12:35:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%5]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 12:35:31 +0000
Date:   Tue, 5 Sep 2023 09:35:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com,
        jean-philippe@linaro.org, tina.zhang@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v1 0/3] Clean-up arm-smmu-v3-sva.c: remove arm_smmu_bond
Message-ID: <ZPcgkO7omYremwyV@nvidia.com>
References: <20230905115013.1572240-1-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905115013.1572240-1-mshavit@google.com>
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 116ef032-fd2e-4165-18f4-08dbae0c97c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0QeaTuhgTiKQBhxx4qy3SH1UzjjypIY3iG7JhjLjbf7MKMaAmT1vR6gcHPJe1dh/A9ghEhEIy84DlA0L87AduwDamzaSZAxZGSdWz2PE/nBzGiysXK1jb2f4zcHNI185nja5nFT6D6uBSqhrPAv39ZNJVeUD1zwiF3KfVQXOg3AD4wpbaw8BrnfbVuKC9d1MlvJUFvnQb5t7aOZmUvUKLVpfPuWx04DjQ9So9KO0bmQNSfZQoKkFfLBZYuAT1suLWMjSI463UPpV7IEtDdEWbhNIkpfJbXgc507Mg9XGnHl1KjEWV3htdt5wfTmTEiorbW6WMDLqlbCO6QsTrk0gxK5rjevFP9S8xpga73xKw6bsiSpD+od0M7rVODtyDltQbg7JkP7CxqEgKFksBjOzOl8KYXgJlTiwhG6qU4+goP35Wv/4z0SeSW+o9yrh/7J4fuooGnJqtIvZCcc0LQKlIIGZBhQBqKUARt5fl7naIkInK1chvEJ3DcN66rPP+x5A8TLIwn0H8VA53PO4xf39D+Vv0RNxRZxwjht6oDdZn5ASf+gJFj/Bj3Hbg5Qe+m6vlsqsr1VDyKaHAONpVgmuSyBDPTWmFKQjaacXohq2Ts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(7416002)(5660300002)(36756003)(86362001)(41300700001)(38100700002)(66556008)(26005)(66946007)(66476007)(478600001)(6506007)(2616005)(6666004)(966005)(6512007)(4326008)(8676002)(8936002)(316002)(2906002)(6486002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KCPLkYzcEV2gS+4Akk6WbZQHlj2/EHarZ53VAE1ptzDQw7PaLL1zDBorIuTh?=
 =?us-ascii?Q?EWByVbtU/c7hQFPR9ru9GTxfpmgp9ItvWXz2UtAEHt1Y5rLW02NAUs8E8ZZy?=
 =?us-ascii?Q?7s98K5b74hOioOYTviHCCBbyZGNzhuhA2pGO/FeDuOTxJs2nSo21ZBXObWPd?=
 =?us-ascii?Q?nChkHmPAatukk3P+mp2KgE28HOhj+IsIP+R/NDbBwu6Bw58KFDb4eLYsDszr?=
 =?us-ascii?Q?mNNrqor9lTD6tb5332Uc/7R5goe81BVYy2UUfWEFAQECbKBcWEzUWhPsE3Rs?=
 =?us-ascii?Q?cE83HbfMhe3Yviq2rJY0n3/3+M1h7pBye0ypT8II6vdJZjOOGSVxqzU/kng1?=
 =?us-ascii?Q?bztyxr3HBF4E2m71f9ocX0BtPL6+94rcaoqAG4Ae8sk9YmOa3soJoR4XMHTd?=
 =?us-ascii?Q?aPsl2VRwAjbdYWP6y2VhTxQ1hg75kpISV9qYFxiGlUWZ2iL7U1V6beebZVud?=
 =?us-ascii?Q?YMxpDh6GX7rsSgjwdLNbCBG/334mQeMp1V+iBYMwdNsZi71lT3nByUcG7n6+?=
 =?us-ascii?Q?27guS0FlHH+5xGUYvk2psOnGBTXO/MqWcucd28ZEXd8xfrF2WQh0WxjlLMI3?=
 =?us-ascii?Q?8i15mCs1MKACmr9mE0HKnBro1cun6GNxNIdypI/a3G8FmcM/t9ghVP93r/z7?=
 =?us-ascii?Q?LczfA6f7U7+VuVDycwqe/awJzrLUKairaaDm0BovZZHWrwiMhiqRC3Z3fJL5?=
 =?us-ascii?Q?IlaOZ3BjZ03RQVYlcVmAoIDbNoFueBqgrWGkuwB9/Y+KmetM0UN6XsHTTvHN?=
 =?us-ascii?Q?WgYya30Ofa5o2R/1jFi8WwF/ulL4eSggnA/o0ea3xod5yUKcTL1dQBr2e9l9?=
 =?us-ascii?Q?/6GZ+j8AmOiUA8Pmifmi6bikZi2qOegkbH33hY0+/T0zWicG6KMOvNhfp7q3?=
 =?us-ascii?Q?qCFOxQUJibzU6zTheGAEfMXgkONw0239ZBA5QB1Ar3Oxxu6RKN2HbrX0c7L9?=
 =?us-ascii?Q?agkfDoPhZ58iAaZ3Ed2ZQPuPUnMJZ+7RGAtz0mYZxtFfiGB4CkrnZs8R7TtO?=
 =?us-ascii?Q?KPMKC3lcCkvCMfz2ZnLn5QeEVFVAWtQ0bT+YPzVuorrXcObZMopAcZgrCQVo?=
 =?us-ascii?Q?Wvi1lLhjZC8wMAPBO/fosar/xMdAjgJY/rzXaWNEvfr625+fEl/vmlRp7sUe?=
 =?us-ascii?Q?ioYvbSvz9wEekMMgK4ShCKfRAVZEKlHhOZXEgQR36HQFTX49qvMxfwt4NEUE?=
 =?us-ascii?Q?+iYX7tZjsBvVycH0VdZ3n4hRn/vOYY4l+8KlOQPcPjC8lc8j939JcY9zbgNy?=
 =?us-ascii?Q?JeRUfTKuMX/j+NmYDVgkxp7N+Chtp4ItsTejbTUSFG0vPQRAFDJFpmLbSjYO?=
 =?us-ascii?Q?49QkLGnIFA9D6U0hv9wrOxHD40frOayxCNDnWCeDme14mBZrdCN8YfHz3DPR?=
 =?us-ascii?Q?T34UB8W2hPi7hA5uc9J3x44g4oiu4fofXauSGg3AJgsnlPl/vXx6kMac1jLq?=
 =?us-ascii?Q?1zTxXnq+x7YoIyiBPCIjojnbMXih0DW/ssDJWLacLWzQ6qhZ/nor7VUf/1Zg?=
 =?us-ascii?Q?zakaoMDNqeO+FZy4f6mYOjArf4h1epc+wPQqYcMKZBbWlMZ1NMpTFArKMMgN?=
 =?us-ascii?Q?CkJlUF9SK+ZJ6J4SBpaN7YegGHH/LnS/kRV5QdGf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116ef032-fd2e-4165-18f4-08dbae0c97c3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 12:35:31.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCktZQTiYCuWwqmk34RsLcPN2SYCoy5g3vJsOYFTlXTRhZCLEuz00kHFP9J7gPXp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 07:49:11PM +0800, Michael Shavit wrote:
> 
> This small series was originally part of a larger effort to support
> set_dev_pasid in arm-smmu-v3.c and a related SVA refactoring. But it can
> also stand on its own as an initial and prepatory clean-up.
> 
> The crux of this series relies on the observation that SVA won't
> allocate multiple SVA domains for the same device and mm pair. 

Yes, I think that is true, certainly no-intree user of this stuff
wants to do that.

It is enforced to be true after Tina's series:

https://lore.kernel.org/r/20230905000930.24515-1-tina.zhang@intel.com

Which makes one SVA domain per mm.

> There's therefore no reason for the driver to try to normalize data
> allocated for a device/mm pair across set_dev_pasid calls. 

Indeed, this is where we are trying to get to. This de-duplication
code in every driver is quite horrible.

> Note that arm-smmu-v3-sva performs a second level of normalization by
> mapping multiple bonds (now SVA domains) attached to devices with the
> same SMMU (if those devices have the same RID domain attached) to a
> single arm_smmu_mmu_notifier. This is not affected by these patches.

Ultimately the notifier should be per-iommu_domain as well.

Thanks,
Jason
