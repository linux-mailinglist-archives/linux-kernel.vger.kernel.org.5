Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325827DBFD6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjJ3S0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjJ3S0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:26:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5715DF9;
        Mon, 30 Oct 2023 11:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVSzcw4lzycN7CezidacQRWg+BB1xo2fRl1nnkqAE7EU13YY1GnSMiqFBHH+O2duDqkS67Gcyw/yp0u2dJ53ZgKmqLbXdiZgbGlc/oTxQlpE+hqBq2ZSDlpEjlQMgB1ZtlC9ktsFtPq4Xih9KZdpbySNmI1yVIMacxmATvrAodpMb/l4OC/NdGNwaXNr2LOilazdMZgcn1oWPLGMOBBWK97MhkZRZLUQReipUAY3ynvx7jKfFjByaJSYfeuH1vhcrcy1MQAkj2/0dLeZvcmRGQZKjXrFnDBTl+tYz88F3AnQaa7FUWObl6r2TgNxKcYnIE3ZUg3nZ3UWA3EMO/Z5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5YGtEKGaq8+tCKA1pmTCvsQGjQTmXysW/A/ymENySo=;
 b=bLwzPOpq/Ru93rwy1llug6JDhUBItBk+vC0t21i1g8sy7MABrFr/me/tG+qCyCPV+1+KQIC96PHU/iNnEX7UDt3+vIVgE2Lbykqn1lKgXW9ggoRMs4DUq5PnxMm5kF7U3pcYmsoEHZQO03MnTYwOdkQNdkIqgs63eDnG5bCmwUOBMT+NINpdvvSTK5xKUHh3k1zlhjCj2M0EmEreg58CI6xPhntY6zvENb+Z7jmvnkPaOio9K1AqnWwWX3FZpuoHIGrVcnnMp52YNdtnPYMwuWPc/IBIUgz3/jVho8t4maVkEQ1lM70pmjlASQqrbsVYXgNOU8nGxL8TancwqBMZ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5YGtEKGaq8+tCKA1pmTCvsQGjQTmXysW/A/ymENySo=;
 b=lP3X0aQB1HiOO4NBhWHLutNtz0KwuUtQhTmJIM2Vbroo6jttqiN5ecykbplGCdznNuihOQfsQ1R6H4yvlA4E2tQCGp4eowbHQ/9b7eY/4FsRIegXgrqZKx3jxlKxznW/lJHvaKT223jFnrvhaJ6fipsnzuUk4RwmWLqqoL5JBO5ArOh3d/Sl2Kbbi0NU1U6wD2fH1tSVnp8hu4Zh2xMEgJCsEcXvw4uHuHwnnlpBMJ3mujAlBcHjQFUPQpaDeaOOB+9XFEbj9CNRQRJ3NLYqOSrfn9lr3UjD+VLzvLJQzHQNAQAbEFQkwTQDt1JRP5l4xxTcNMdzVC4hiEB70iHePg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 18:26:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 18:26:23 +0000
Date:   Mon, 30 Oct 2023 15:26:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231030182621.GV3952@nvidia.com>
References: <20231027155522.6b2863a4@canb.auug.org.au>
 <20231027171522.692a58ec@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027171522.692a58ec@canb.auug.org.au>
X-ClientProxiedBy: MN2PR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:208:237::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: f54ef95a-4ba2-4d26-c897-08dbd975b82f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEaM/oFApDs3TsxPFd0p2OgFILMHLxMVGGluLqpg8OF9HK0r2SQfDagEnkBq1Ws//L+KR+0hkXGWAUhzDBadeGsDDO/K8o0EryVWEH6bzAJJfLTOZJO2UHduYS6OH4u8Y2QK1vP61FdD/ouiMuWXA3EYjuEuN7dydOc+z3WVZad2OXw3Z/L1lF50eYMq08uEwvOO/erRl4w235CVSABw3GzH++xUWI1eAt2yAWxD1tQzlqJ2bdIJMfz1n4D3dgDMAIQoCTGf9svvGP7QtOUU5TArMP9XqWf1XsSePIPmYn8KHy/jgRi0tBVHsSiqSnTZs5nyOjbwBgPVRjOgVKiCdhdKciGLYK2ZGVINCxfNglcOAv7ADhZdZsioSk96VBgMvb5SeNxWOBR28bhEbBpkZ+mrdPPv1yZw0//H3XUVM906oTLHfFOdlh2umf/X/626coBcRWwivZglrLiVq17VFPIlx/vYmURYjWFMX4/9yjqnM72VSWSBuYzQ/W0OeuHazZ3VEvbZ+Rcev6aVIVuItHMGMg8DuoK6HxP3BSBV7PSv6S0EDULTbxdvaSSL3nSq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(8936002)(4326008)(8676002)(5660300002)(83380400001)(41300700001)(316002)(66556008)(54906003)(6916009)(66946007)(66476007)(478600001)(6486002)(2906002)(6506007)(26005)(2616005)(1076003)(6512007)(33656002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KGZ+BZ1x+vJI+4DylcTbqHgX7MrB1efo6TtgIA3EXpqymGAOolKOreBrkS8z?=
 =?us-ascii?Q?WVyIT7crXhHvEEhYiZGtt7xa1TO8pLYtCw3pjQIEyNEXAqau727MDZRN+em9?=
 =?us-ascii?Q?vB5IKmSeEvXnG8HEyDeLZkfaodosU3BlWhuPOCGyG1CBrU5pvCOxYsmAUMSw?=
 =?us-ascii?Q?FXEumcqlroHZJesRoK0004DjyLGaxIilQI6VkHS5avIJgV3j4BvSU0BEYjw2?=
 =?us-ascii?Q?uvIfEgpfQbuGgQ8OVAyFDCC5bYAaBxuRvzPO5fOz5C7SXyB0HKIUxdzveuoC?=
 =?us-ascii?Q?uaz6HORq5nelj2Hp89zAoijKzXfndjFS80szvo9YRxlohRi9/RyyjB5NuwzQ?=
 =?us-ascii?Q?sYb1FsXnFx4H+ap+fV2fvSdUAHcgUBr4/D4DKxLrJdg9x/wtdnyj4bfFVZxW?=
 =?us-ascii?Q?GO1ocZzYP+0V39LucTvU4sEDx8OHPHRjQBgCMqKS0NHJJyN8nJpIwvuZfsfx?=
 =?us-ascii?Q?9q/EvIVmHkEvAJ42p6uYlhXwW97xaYY35x8bvfz6jbKmEmqwVeL89GsAeGmE?=
 =?us-ascii?Q?39Hlu6F+ua8NxtSiUBadhfJmw5yN89LXd2qSk4StCxlrRVnumz509YC+Fc2R?=
 =?us-ascii?Q?eRbR3H2Oq1gwVfcrFEDDdYe66v4c+fwjJXM/x1LvFynxtpx1wHwYRZM9/BfX?=
 =?us-ascii?Q?c97ZbKMam/CbrvzfoGlkfwq64w6fmDu9Y94W8AwdTRXmg+ook5HO7cFtU7uj?=
 =?us-ascii?Q?kdiNTdRGWCeYAcyE+AWpXhP+i59i4YEF+FdsdlAmRB3Fm6evChA7yPOBcmRc?=
 =?us-ascii?Q?dBhq9IqBGxmJSUIxREqNrayo3icplAAHrNb8WVv5JTApX3RYjxRvxm/Pbwc9?=
 =?us-ascii?Q?cyZVwZs5nxcfQ3kYd+Ka4JzgJRLT/BiBKfjitEhehZCozyh9IyxQ9kElLw1e?=
 =?us-ascii?Q?gYBU4AhZ1BznpB1zNhOWAi/4MldrlnyxZudoHlkph2618gTEbe3U0fIdTAaF?=
 =?us-ascii?Q?sUvI4/VdiDRoDtaQjV2KL4yqvAX3FGShmTfb5NbsK1PSCfMDTdqlCYoVeoEd?=
 =?us-ascii?Q?G7+hcgxSEx8HdwolzpKs1yA173krnWXzuSMLjX+T3Nz19AVWJm3MfQkS+02h?=
 =?us-ascii?Q?2p62UZyb8bDJmDl0F7yI+u1KBjPP5cBDQG4BuN7x66HA/+zMZjJ+aQSgiLYR?=
 =?us-ascii?Q?KMGolOVXLhUC5AwXT4Xzzwqxn5vses+26/y8hFiC/yl1WrxvcxaJws0x3tZF?=
 =?us-ascii?Q?r9TqY/un6UA+dJR20b2ilYJLMI021HGxwnKnHc+0ZqDhYkkHzr65iGBkJO+L?=
 =?us-ascii?Q?2DJS3P92AsBVM5ygNAdgMPsGh4yV3d86tLAnWilUtXYVJKoLTnAmnsjP91am?=
 =?us-ascii?Q?bHXQuUGXfZGR8t6EuVxwGykED7swzECSVzbaIw2BmF3BxhIrYSway4qVT2yp?=
 =?us-ascii?Q?g5A31ysss3ASkuxP68csEZ9HnjMVJ/ikDIK/QYKhHnDJ2opjIcyCSNrUlY9c?=
 =?us-ascii?Q?tj7wvSjmpI3c/u4RhSI3p1qNDAvvKiI0wbYZI1Sps2Jra3eeD9JKhgHQ0iTa?=
 =?us-ascii?Q?u2lFOqBprbTIFK2mdIbM/ZH6rRkmIc64oygjE8nxXjkjRBgbY+az6lue6lKP?=
 =?us-ascii?Q?KaUjNXV8GuUzfkPjzc36hCXyEsOLG+FyfjtaQLsk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54ef95a-4ba2-4d26-c897-08dbd975b82f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 18:26:22.9404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vP6v9weVX32okY92Y1LrP8Kw09DMsfnR9R4zQZ6qCitS1TtDbjpR/Xqn/3/6yaUI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:15:22PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Fri, 27 Oct 2023 15:55:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the iommufd tree got a conflict in:
> > 
> >   drivers/iommu/iommufd/selftest.c
> > 
> > between commits:
> > 
> >   1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
> >   13fbceb1b8e9 ("iommufd: Convert to alloc_domain_paging()")
> > 
> > from the iommu tree and commits:
> > 
> >   408663619fcf ("iommufd/selftest: Add domain_alloc_user() support in iommu mock")
> >   266ce58989ba ("iommufd/selftest: Test IOMMU_HWPT_ALLOC_DIRTY_TRACKING")
> >   7adf267d66d1 ("iommufd/selftest: Test IOMMU_HWPT_SET_DIRTY_TRACKING")
> >   a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
> >   0795b305da89 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag")
> >   65fe32f7a447 ("iommufd/selftest: Add nested domain allocation for mock domain")
> > 
> > from the iommufd tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> The resolution should have been as below (I think).

This was too horrible, I pushed a patch to reorganize the new iommufd side
code to more closely match how the domain_alloc_paging stuff is
supposed to work

Thanks,
Jason

