Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859E176B6DA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjHAOJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjHAOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:09:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957EB1B2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeIIr3PI6b6nMdVj4o7lOgy18POFjVH7/wAoLgEG5qfuNUwy2AE0IA9h/+Y4e1mvuQyH9BV5lw9GNuF8usQ8bQqE5jYkopEC3a4C7FZVMARZR3mKRW5UtFMnWW1efcrW1uo8CEdMXXhPjrLB2zyH6uhJLqSF3ghPzSu43M/0CmhZBFUjQXzu5oyZ8R0MNEvXSOfSNoYFsJzZXtJsCkwJY8l9E3GXkqKqYGWMq51E1ERd1c241MDoREJ5EYhJqbPgM7GeJJ9nGb7VpHBwTw3kvfNl5bI/n3yRTeDWpOyAjrt6LYJvkbMu3dZbolY7eBb6pDmvCN3DHHM5uBhqlt3RMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWatBg4SWmGXeK5tOqX8+W+7rUKR0TaKWClSeqIO0ew=;
 b=BsBiO7jf21SiXF1aOf7RaBCQ/hGmhA0E46Tl323qTrFZGc3x3cG1VhJnYvLzTrQHvYlgoRzmmKaUbovp7rYqrdlo3puGjJpw4v4gQRjuGRri95VB8e1whoJEjR8qfjNOXw76hVxoUs1oShYmHaz08HxQQmqxgKPQlJKnAX/EBpPwb7SlDd1w0P4NN1hyx6HHATkr4vcmsHOT43Ow8NUgyUXSdvnHDs81aZAWUzo6KFo+wzAv+prcoWd42mdqELUQyPKKpNilNVpOVodB5lDm2SrLxkrUtylcH2jQyHGIT7/M2x1UjylK6qnIY/vV+nK7ehL+n207RBazLXtXEbPYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWatBg4SWmGXeK5tOqX8+W+7rUKR0TaKWClSeqIO0ew=;
 b=aUtrj07aZ7vg6kCR+lvweHdh8LhY6WmGr3fTRsH7Rz2EXQEm6SE4lHAsu3X27qwWk/7dq9iWCSX/ptIWvxBz6tksEBY0MwSoYuJQk8dmsaK5ZHSfWw5SGXZVNEsvlEXnhZvKml4p5H7Mafwmzp+WI845bZQIt2gGGgjuN9MPSlYaCQRn99AlSPtbm8LoMazwhkc32frYRN/8C7LNuzdBWSr//hHRNfwL8gBEXv3rDCabDRIEn66sQGj3xPUwg1lZxRfztXiLUDNrQ0VQtOS9+92MOCAytnYlDvZ2qRj0Wz+a5hsEzj3l1K3R5deLX+nmj73uGtvPx1djTMuDOwzLZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 14:09:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:09:34 +0000
Date:   Tue, 1 Aug 2023 11:09:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v2 3/8] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init
 in alloc_cd_tables
Message-ID: <ZMkSG1KpICgSsvWC@nvidia.com>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731184817.v2.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
X-ClientProxiedBy: YT4P288CA0077.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 113cbd9e-3ffb-45ae-c234-08db9298eec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyCgf6lCwaGPwgS6Hf0c8V9VXnFRiSn5P7SNtkIFN791pV4gkpsovMcUX0hGT8o5YM5sPQBiiBHCjGgOwQ0ghTDui0w6nB7tyL1iphjIKijXtSs2A7Ru80UJs9Nnc1cdPZ3Bbb6HuGU/y1RwFUtVTGCNRkT2h99j9RROMlbB8g2j5sWEKrIuJSFwjCCQaksm4eE1jhl4NrOONZ3f0i3GxePEdCvKJyhK8qlQGAkVp71dThX1kAhOXE4x3HD7CrqfPiyzWV/rD3sSG4THLrdklLtBKrw7HCVMpzN00SZ6wNIdmTKgoXuhV77prT1IhfK0AzuE1AVNRIsACB6SWwhuWSqmfhshfiPwVunddmGILbe1wwTqN7b3MgtuWQ97arvQk87ug6mewsIRPI+dFGctugMq0CXsts0lCgk9TZCsUMIsmbKu3knrR+zN/FWjDwzsbDUPL5gfr4bymKJupRcQCti6WBeDEyCpBMSBaEWq28NuF32w5Whh63aa8KXI+MYmYUPYlOkEadZyidvkKVejtY+sGiiqma32V6OSLnGDkkpPKNXO2afcYpbzoju5seHK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(4326008)(66556008)(41300700001)(8676002)(66946007)(6916009)(8936002)(5660300002)(66476007)(478600001)(2906002)(4744005)(316002)(86362001)(6512007)(6666004)(38100700002)(6486002)(83380400001)(6506007)(26005)(36756003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2aKMHYMdR2pWbfzdishvtZ60Tf9xWZW4XTDUMA79ZGOLe8c8HlCcJq15x0ko?=
 =?us-ascii?Q?OKEwy/FizpkFK/ythnofRqxdhEDHCEsFgYdT27AcASaoWSW7RM73ctQjRm1V?=
 =?us-ascii?Q?8ph4WzzhMmVXFhZya+5NfEvLdquMYuTHzUceKdHSdnZBVCogJjApe2QsMnQA?=
 =?us-ascii?Q?wIukQhSUYU43N6MiZrEhBO3R2QEgs8H7WkYLyBO3Rzze4RRSpnGh6QKf0KNO?=
 =?us-ascii?Q?Mjs0hv+EIhO3pBTMqgmraWATFJlM96bXszpnn2FdLCTAbTLoi2q+j0UZ2leU?=
 =?us-ascii?Q?QpjDL+uaJbYnAhWvC51pCuDtKtohU8LQ0LUxtNLmTGj7r4xg1X6AaOvUOc93?=
 =?us-ascii?Q?7d+Kis0ZmCk64IwRioD6vkHg4dN4Ldt8Sb6DvDkBy3GU0HlFQ0u/CHRjxVQM?=
 =?us-ascii?Q?zojMhyrgTxL2L2xiNfikqMsRkeWdby41Sn3zjCHyvcPEuauWMWoKkMpXP7fU?=
 =?us-ascii?Q?JWKuFj9c503etdYXd8qFvLmijgaF8Z8eEC5x0PGU9j9/bzu9gk0MCkSbk1wf?=
 =?us-ascii?Q?gjAUYXdfwuHGiGgF9cstbQDvsNdtfthHk5/uTyjMTxnI9M7cdY7SkI5utUeA?=
 =?us-ascii?Q?jfvNRi7G50O/uZ2cJ45Kkuj5Nsdcmps/HEY7vrd2Lk2VUCOF/vdBHl2ll4uW?=
 =?us-ascii?Q?LGU90OrKDI2eOqqtKHdmiMZfcKJ8wC2ji090/OgsUR8x5IdNmNZRmZN+85e5?=
 =?us-ascii?Q?W245+sm/tVMdKGUmW1/7VD6z3XDF+LECd9z4jp+F7vxnNitbaNVwAeafkOOg?=
 =?us-ascii?Q?9BhDG/Hzxi9hz1Vc64K1EGYy6ej9/BW76Rwt/FQSMyWze79JVsb3/z/z1CQg?=
 =?us-ascii?Q?FPBxDWrwsiM0QFJnSy/8/Dm0Js/DJ1Xuurniepee3lHHBjhXfI3o8EwuTYlT?=
 =?us-ascii?Q?/vZlt+KtVhmdDo+nOA6pv2cf5/MNJ7Mz2hNv8+bRsrSXUv71hawaFOYsyvEC?=
 =?us-ascii?Q?xDYlfWscsvqmpBWadDzl2izOOhlxzxDyybeY7BQmjWKINQZpbcXZzDqFgljn?=
 =?us-ascii?Q?tZKkraqCO18sXsV1f3zE2onPkTxSD+Y1+yAGVxeA5T3YYw7BBUixPrdprUXM?=
 =?us-ascii?Q?bCoKeBRb51BzJgqQlNG3W5pwg8UOusB5Yll/5Wuh4rzYNjXZuv6yqNs1Wy+W?=
 =?us-ascii?Q?zfll8RdcCFkzJP6zoWoOxn4E/rmOblJC9vFmh/SCNVX/wz+fORMtF097r+za?=
 =?us-ascii?Q?+DvIksoX3NBeVGk/dyP5VXIb5D4ptqCR6lbz0HFheIEbHnKWV0f6N4W2VQmP?=
 =?us-ascii?Q?yGAeftQ1a0wI/Fh9Ur87lcqeKVseS+2OQfNpc3EPHzmyGTwSIDonUVu8E97w?=
 =?us-ascii?Q?YkM/ofXqGcm6Ba62mkSNCD+HkfkV8zEiWEY1Jxj4ui8BA4dtDi5bzaO6oK9i?=
 =?us-ascii?Q?XDmI7fBdnuYpC45JQ9aaNz3RcfffikLPD4T5VFsqxLRt8u2sWc2wn/nfRUw4?=
 =?us-ascii?Q?a41ztzCguJu7wWBF5QIbHJL0ZwTswRd+EWZrj3YdtG8inV4yquoV/INHS6Nv?=
 =?us-ascii?Q?4qhA2DDv/Z5+1sdGmapBXzPiXPcqRBXhzcJhDPN3lmn62bvI3wACFHYFJN+P?=
 =?us-ascii?Q?AthVDIM3EUSbbbasrx0u4eVX7NdMM+PE2UJG+5aC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113cbd9e-3ffb-45ae-c234-08db9298eec6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:09:34.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsJ7L3G8FfjNyxzm+ikHBgxrpx2ZdM7dBHM+3sbTIACsqlkeS3hhbXhflx0v436c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:48:13PM +0800, Michael Shavit wrote:
> This is slighlty cleaner: arm_smmu_ctx_desc_cfg is initialized in a
> single function instead of having pieces set ahead-of time by its caller.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Yeah, this is the right direction, make a self-contained API around
'struct arm_smmu_ctx_desc_cfg'

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
