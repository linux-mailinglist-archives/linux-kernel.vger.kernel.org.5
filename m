Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A237CE743
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjJRS4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjJRS4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:56:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA310121
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioHKVraElLBFjQNXzj6G8CAI4rBJSL1PRBaQKc5O+x8d5+m57XBrJImlHGNpygxgkjOSmvA+6Fcz8EdSLJM2Rs4e30airpo1KqIkSHUKb+drPEeqmoZnqHHxZ2hO2vIN6UOWBRM1z+snr0l0FcxQ7/dsfReol/K8ay3s6vtKcpzEAdfCAD874uDd/BQpj7niuZo4tJq1IEWdIzdmB+hJo3ovp3GpNk1pLBr5WuvH3Cf9XBQYq7PhAgM4Nr6NGYrDd2Bq8eLS9Q+wvcunGt8KLWdP/NUMNdxUGuPRBYL8XJyJ3fHBka5KAADM+4RQLk3TURD/PU3XvZsPH7QKpaAahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1N517LubmDcCvtWTU/b7KwuNWLaNZCwcxRvJvs4gYM=;
 b=MF6VmaCmx2pxkIDKIw3lqYW9OEg6hM6HKo4eFTHvnCzaPIf+8/fIU/llAURPCcm5W1e3ONeSa9QCEsaGW9F6lJq6NRpsrsDwiX5tvnih7TvhUrudBAO3NyRvEs+cVDVPo9UdeqbB/tzQCX4WI1DDeI7UJuLq3o38XjtLPZG6mCN6AgMNZQ4I2y4+PEgzHEja1w7f9sJ8gOnxOfS7I3txbLVqOabDMKGcynK7pN5lQiorkkA2XMM0Rckz0r4nb9SsTfnDxDThEojIxVGivHJFKIZDCfYHfFa9OtT5mHFqZdIxbjOl9OiQV31PF6ZajOkR1KSWNPJRyo3ihZtjVA8WPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1N517LubmDcCvtWTU/b7KwuNWLaNZCwcxRvJvs4gYM=;
 b=rNhhb9/Gh6MhJEZeG48CpD06DvhnqtDfkejbQp32kVgR8sY9WP2UPUIEkdm3MObwUajFoaUnFWZ0wCBmD31In9gbuXcrYNsSH25P27Es/PyC1M0DgiPxHgS2gNcKMcdXZnbTUS4x6Y6j32OXPfnwZO1tsoX6K1uETbESRPbQ5M8QsuvkGPrQZM2uGrczB/8rkfjExgkaKbS6aMOaGunrnLpoBb5TYD4M9o5s9rG3qj8YYIDNBhuBk7AekfVfbc4E6qSRGVLe+iM3F5VqIx7bl6GYf0GkcORfCKMDveAKr3/Sms4wZj684qfD0lKT2f/uwfc/VkUfwW0KxxmMKMZeNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4851.namprd12.prod.outlook.com (2603:10b6:208:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 18:56:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 18:56:31 +0000
Date:   Wed, 18 Oct 2023 15:56:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231018185629.GD3952@nvidia.com>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
 <20231018180128.GA719006@nvidia.com>
 <2023101808-quicksand-roman-0da7@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101808-quicksand-roman-0da7@gregkh>
X-ClientProxiedBy: BYAPR06CA0051.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 248a6a41-4642-4f34-e6a6-08dbd00bf155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o11oW6U5pzdtsRuQWGpeq99atj0BkB+FNN7XtvbuASN6RyiZhhoWl2I8BgqnJI8PB5Z0TBqH5fuN7jOdXi0Qevox6YuL7v+aO3MsRi8EqcBgsPINGK1+wTnv2nTWkzBXfzFoM5AdqyOA6fSKeH5f5v9OiP+maRVVTK1bwOl1epQ/cEEQ/Xh3+C68PIG3Nspw38FUQobdSog4VAHCxauryx0cJCgDrbKbcO41sMzVpqeMUrjEKo8Aa5lybVG4RG3iFYCqQ7C0wChtAHXBEEiN45qRoBPCiFPQRVWXsag0iqEShp9ZXwkVh8TZYzRab3AnO/Ia4IqhHWmaP3jLHFRil4ssk+vlIpM6Smg1xxVngP5at9MCbmmU/vqo6EJ0SiQ29Kjow2jsMh89/uVnSfqHhfu4PBCVT130M5u/eSVfpQBigJpdkmc+kO/FvdOTyOqawdi4bIi02GfOz2Ii8XDwqmoFHkjHQAjP+y7cfj+FZCjrdjrfEjsfF9nls+oRBW5uIGaSdskM9QxsxPMZpaan18J952X2A4/IGpG01XaAVpxvLD37Mpr2nEroEybUA6i5mOuNQ2qZjTP5MYJQy/6MuRYdLTKD3SQ5DBp2Y4jLpN61CYXW1Tgyph2aPNJGbGNWP81s9aL+k/zSVtpJXQUluj8OlXw8EL8l/8kcC6m1siW4+fjLNVzyhYqAI/Vbet+B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(107886003)(26005)(2616005)(1076003)(8936002)(8676002)(4326008)(33656002)(38100700002)(5660300002)(6486002)(2906002)(478600001)(966005)(86362001)(41300700001)(6512007)(316002)(6506007)(66946007)(54906003)(36756003)(66476007)(66556008)(6916009)(42413004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GWwr1X/f7tH4aq0z2DESOsR4n7n27/GgLbBqMOjbcOJu8+H3aMsaj0g8a6w/?=
 =?us-ascii?Q?EYUgUaec6ap8SyAe/t9hIWoZmOTojEJ9J18F19H9r2/7w8m7SXu01TwznYqv?=
 =?us-ascii?Q?aXE6P0511sdHf2SP0v2TaQbmLnA8WdlyMn9rR1zTZHW5LkyK7Sr6tda08+aU?=
 =?us-ascii?Q?BeZkXfjwn/p3Mx0/XK8zkAuSQWHWwAmLKnpCHDiE7xaY2p68Avy3iHGtKNau?=
 =?us-ascii?Q?drWA0Pm/E/xtRyy/EnaoYnVcRDfMIrCvDg+KOSRCF2hk8ZdGPUjSWUXmloXX?=
 =?us-ascii?Q?MPbCY2Vqiq8tA3KXiEwsHmMVnJ5BsetHFADLy89cuPjVh5ntPsACLixw1t8T?=
 =?us-ascii?Q?3S+nzM2sI5r2BW9QvsTvBn6HWqHNpek2XI0ts6UWghuRCrOLdC/wKwAkXOej?=
 =?us-ascii?Q?85LC+IdB4g7QDrL63/Ctzm49Q6diDbbFh6E7oSJ4EWI0PDNcDEOEND9pTJcl?=
 =?us-ascii?Q?XPFoeNe5wibyriIowJdsN85HdOy8EcLNKdxEkOFXgo1PDezao6yY8Nks34u8?=
 =?us-ascii?Q?f8ttoGgaR457srHA3HCCFi/oTq9T3QbZUFSqHn87sbNMiV6LyVOVbWBxa8rJ?=
 =?us-ascii?Q?JVDT6HhIWQeid7lxOlMVxQE/SQcoemq6gFcSb5XQtBNPYKd13/86WcKG+IQ9?=
 =?us-ascii?Q?kEW1pFc/ydQ+9jcGe5OTcSkwue2IrzRSjheGoefHlL0ojIkQF7x9T3eci+w/?=
 =?us-ascii?Q?cX99zXKTvRseUFHiUwANTBm9XkTVxM5lZvW3rIu5WnEJ+/5ENnGhi5e437nn?=
 =?us-ascii?Q?DEs2nOeSnkv78FsVvtfZ0pYCMIx4kiyoI/bNUZ08BSu8xhBEOBKh55Oxm7ZP?=
 =?us-ascii?Q?qWNro5ScmC+MSgNA1qzwh27Prsso/0KZS5HR2/00CMKePEZ282wP8LfKZTQP?=
 =?us-ascii?Q?jF3fx3JldwpQqPH8NtnvJB62FwbuzIXgO40oSyYC8sJZzUNq5qOOQeSuy5k1?=
 =?us-ascii?Q?pFReXmaJZwv2jtpWEdpkJRQI9FoF4+m0KyXeQAr5HcH2MCaugHBM2aW4HkAk?=
 =?us-ascii?Q?FtQ39P6uoem0xQf5P0DWXDAHmCQzrI/gGwy6ycfGwpvFpF2ABMRnTRiV/7Is?=
 =?us-ascii?Q?Si4UbGdqw9+9C0LQr6W/j8qsCmtBnCquKMnzaGv+aB70UTkA6GB2tkb0yuu8?=
 =?us-ascii?Q?ymp/NVJys+lrKpbK1nBBn8Yt/r5QgHv/nhNJ3L9TU+M+C8AJMjGEqoXxlgFO?=
 =?us-ascii?Q?7iv96UHYe6XewTejYVs4g/s4JlPZMuNr6995J7MCPowUK2z9jTHjS+TCEYCd?=
 =?us-ascii?Q?E1yIMQK9f5E4ZPuxA3WLOez85DSSsJ0AMmWXXsufYKvDhFwMI9jpvOam0EbK?=
 =?us-ascii?Q?LEup4eh2mqq1IjQ3BuL9UVdppbg3QSEbntyh8Ar5rhx+1qaCV49bW9gOf1bq?=
 =?us-ascii?Q?n3B+TJZ8JJqmNxr++aoWw+gDeDjOLXSXIWE8BTkCWx265plsr2nZFHK9kV5y?=
 =?us-ascii?Q?OvidtTKcYDM2x7ZgRnZnVv/lssTZNApUqe/UENu4qyVqdZwuq1DPfRKPYvEt?=
 =?us-ascii?Q?mCZNCm9nwcmpAsAdhnchrAOUl9r3V6hTQTShDPvvhcQRbECJ865p0gS492TX?=
 =?us-ascii?Q?4e9Vd79XhVymyhxAdmYJ3GxkpO1b+JdEekQPBrx/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248a6a41-4642-4f34-e6a6-08dbd00bf155
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 18:56:31.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rf41EOQDb30wcHUbbeDtc7f7TBekbszMvVm83g7GSiQAMGyO12UjawHdGfdJFaXe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4851
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 08:22:39PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 18, 2023 at 03:01:28PM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 18, 2023 at 10:30:00AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Oct 18, 2023 at 01:19:38AM -0700, Saeed Mahameed wrote:
> > > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > > 
> > > For dual-licensed code, I need a LOT of documentation as to why this
> > > must be dual-licensed, AND a signed-off-by from your corporate lawyer
> > > agreeing to it so they convey an understanding of just how complex and
> > > messy this will get over time and what you are agreeing to do here.
> > 
> > Can you provide a brief or whitepaper discussing this complexity
> > please? This pushback is news to me, Mellanox and the RDMA ecosystem
> > has been doing this for over 15 years now. I would need something
> > substantive to have a conversation with our legal.
> 
> Have your legal talk to the LF legal working group, they are the ones
> that told me never to mess with this license again.  I'm sure that
> nvidia's lawyers are part of this group, so let's let them hash it
> out.

Are you talking about OpenIB specifically or the concept of dual
license (eg GPL/MIT) in general?

> > However, I believe we can get an exception approval for single license
> > MIT or BSD-3-Clause for this code.
> 
> GPLv2 please, otherwise again, I'm going to demand a really really good
> reason why Linux kernel code needs a non-GPL license and again, a sign
> off from your lawyers explaining why it must be so.

All of the Mellanox driver stack (over 400 files now!) is dual
licensed because we have a large team of people working the Mellanox
driver for many operating systems with many different licenses. We
want the certainty of a permissive license for the driver code we
supply to Linux as the team routinely references and/or re-uses
Mellanox authored Linux driver code into other scenarios under the
permissive side of the dual license.

For instance I could easily see the work Saeed has done here finding
its way into FreeBSD. We significantly support FreeBSD employing
maintainers and develop a sophisticated Mellanox driver over
there. This would not be possible without the Linux driver being dual
licensed.

This has been the direction from our legal for a long time.

AFAIK this has also been a long time accepted Linux practice, there
are many examples in the driver tree. What has changed now that Saeed
tries to add 3 more files the giant driver? I need a bigger
explanation if we are going to revisit this practice with our legal.

To be clear, we can surely get the approvals to remove the offensive
OpenIB from these files. eg mlxsw is already approved using
"BSD-3-Clause OR GPL-2.0".

Further, as a maintainer myself, is this now the community consensus
expected review standard?  When was it discussed? I do not see
evidence of a ban on dual licensing in
https://docs.kernel.org/process/license-rules.html ?

Thanks,
Jason
