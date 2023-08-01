Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8296D76C13D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjHAXuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHAXuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:50:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7821BC7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMOe1IVOyrWgFHYHPPprduQ7xaKyQ7ZKmEHfrJejCw+vVATFVYC82mpvN1VnxzzFJ85Qda99mMvgZ00086HbdRtX9qaUoJp+7xfvkRGtkKvplypXH1ZaO/QlIl7+VQigjvFESufmHXle4fgUTIVf4OGJjp81/P3Ewn0EVwL+6TS+W9UVKVHP3f1BLw0VEWLaw9cX4BJJH1Opuq77HHTfAd7q+H6Sw+1XoU3RGsGgO3dMhRDJnYMa9KZAx8VEu4Vx5CLRau9Dxo25Ne8aDW2XTV1XbtRJFEvQWguQ5YRmKL9IgOG95SD52Zuoiz+m2F78GnFpb6Pl8wem+SWaUd3e+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyKBTzVhJLf0TU5o+g2qG0alEO7+1Dx2qn/E4vl1n/I=;
 b=kpjUsDHJ5OATys5XCPsuEv4Pw5MDzBjOXnF9FMPgKO14nNsP283bXMo1N2yKc3xw5DdJrHE+HG22md2sUwhYXbLwLTRrIm+24ACgmMnOUdLKlsbYRxKyAKi/a3uUwownl1xx7m5NRC+9bFjohyJJB4gm8xBjnZpxtFAksEO+1LQX22hUDNWOO6kofEPDml3nPjiGcHNXYVNxTgoUq2xkH9E4pMNQz/6X3b2wmXFLwMgZp3z8U3t9cyrPBaod/UFRMzYB7Nca6a2LpoipPGwUWG48bS40tZNR8iX/xF58RIVlHiXfjbLspE6KGJLdZwxIPoQIvrVPO0wJeglgP5bB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyKBTzVhJLf0TU5o+g2qG0alEO7+1Dx2qn/E4vl1n/I=;
 b=q4xOXcTzAeKcwBGjoARqskpNlLGgbeFgcB41fusovqH/I42m8wgAvtDNuKxky8sJKohCzSCcbB/KpjOeAVaQNqePNqADPaUF2B83AR1xq8oy/W3R+c9Sxb3rNTqtdCFsYlDqANfRbYBVdou4dbY6ajfH1mwU7myboY3NwgV+iQJfcqnkP52s0DOT7z/RCT31TrIWHoFVPECfXlT7HuV8oBHHzLi1HGfAC9aHWDD0nLTjWRUWVe8BR/sLUuVfDEa8oEhjngsvL+8GdrBsrG4mXEAQZXvViNTgTj3BAGVjWGzhSRIICiABUsCI2bifJO53sSczm2FIKVE4+BoLlHa/kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 23:50:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 23:50:49 +0000
Date:   Tue, 1 Aug 2023 20:50:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org, nicolinc@nvidia.com
Subject: Re: [PATCH v3 5/8] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <ZMmaV+e6BtyJgn9R@nvidia.com>
References: <20230801183845.4026101-1-mshavit@google.com>
 <20230802023524.v3.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802023524.v3.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
X-ClientProxiedBy: CH0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:610:e5::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1ccd11-5234-463b-2b6e-08db92ea21be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOzUsAP8k8nb1j1L0sPdh9wjg2KkBLM1FXhP/P+9H1pHRFn6SBzN+qxCMTbFivumQYkGfEp54Q4g2d4Oozl0du83hABZ0HSL5kcHTbFzc9jEaFd+Eka/GJrfeEvcHQ/EHhbSzJ/Zg/N6ZwoaXEULaeLswG7dQMKqqR5ZNKh61F0ifXoe6SkVOyhb5XEYatMuWsknZ3x58LJHydyIjVIHkskr08G3R2dfN/1QLHcTg+x8XIoPpclPJaay4wNf4Tv4maEFy3JfQr3Yn1lcA6IHhH5VlmXtTGSe0iKzV55E8Pt/RDBAdO0B5Rpixa6UyG0pUjt6i7iOtFvqnBTSNdA4ku/6BL3bzRSnZ4oZRUW56goVxYtfz6ixnMkzWM2ssMQ3mPm/eWuem2GI/SHGggqbDO5VM/8ZfYmXdO8gk0lRhnnTa87c1uKQsL9zxycUEScgFtjit+w5oyKcjUq+QTg/QTsPm9cA32W20WwRwpPPRket2KmV+2IruPh83i20uwRrlEaIma2NNV3y523dpv1RmfrhyxDXaCYQ6hpxjdXPIgo7ODCSHADNtZkdrcYabY9aw5lE2y2W4hYxc5mSJcWagEHKUXyQ+zbgnSD08CsH1qk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(186003)(2616005)(36756003)(6512007)(316002)(478600001)(86362001)(38100700002)(66946007)(66556008)(66476007)(6486002)(6916009)(4326008)(26005)(6506007)(41300700001)(107886003)(8676002)(8936002)(83380400001)(5660300002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ZcVdpGTjxjnWLCLiihnK26ijl/dlAnoZQUOGm9SHBu11Q0XibD7zImWRarh?=
 =?us-ascii?Q?RnNjvGmmjMCnaWpQAt6gSBPdw0KSeEhIoBZTyLn+YcTNpkh5044YfFNYA2JS?=
 =?us-ascii?Q?rPlPqxXNYbwx1mr/4ABRzOJpJGO9mz0GsCqUOgPaQPEEInMcR6ONMvMVYvcu?=
 =?us-ascii?Q?bz7mIdbQGXvzy7j3JHA/KNs4Yh9eXAi2yrE89e7saFdtXaW3C0R4veBVlTlc?=
 =?us-ascii?Q?WdAafReAFOZ0/KWXPT9LivaIEhr3t7YVwTbCaausoIv71qKF8CCQnt4m1Ehh?=
 =?us-ascii?Q?aYM/yAZtduSh24RKDE3kSmfYq6SJwPN35eb1ajFSMRYjFDuUrsFF+2kT33VE?=
 =?us-ascii?Q?7IGHU+2MNYMbftLCvB1uxgQm4uYHgr2PrOYS9WoaSnmnaIPoaPcFXhoVuM4X?=
 =?us-ascii?Q?QCuGq8czIasHdzkykKNiNjgXyocT5oVXs0ojgOJFyJ1+vpqPOlhqeybmsQn0?=
 =?us-ascii?Q?jO/s/96jb4IgHJs9+dmZeGPmdeOmNXWl3ZmJO1bX5NP3fqiYM35FB/P0bzJq?=
 =?us-ascii?Q?TVztXIjyPAQ8vrtSUIJT7iLzQBOb8RhcvW+l6BXHK9SRfHogy573Kg6pCHA9?=
 =?us-ascii?Q?w88TTCJME2tkjRBumgawPHLKHw6OYAQKYY4NAXcWtyu6Ie+2ulhVfc9HpQdr?=
 =?us-ascii?Q?1ihKRb9QJjG2xsXjaZvhL0d+p94shtInnVeEfw8VTygssTeqUsipbNv59Kzk?=
 =?us-ascii?Q?pTlca5OCmAdJepOuVcC8IgRr+t845WtLy7UyTGQ80NJdWFUSqbd9A6pAtYbr?=
 =?us-ascii?Q?IcydC4Bc27LgXDQyVzYwD3n4RPvbL0aLzeMATAU8MMEJPSQEI+BiA/eZVxnx?=
 =?us-ascii?Q?udJuPatkY88e5JgXRQBJtDXmuvyKCsHL48eWc2NHlQZbGVqd6UiOX7EbhMaE?=
 =?us-ascii?Q?2zrvEe7y3wntuajPuVAj6VD9CfoxZZ6BgcnAM+ooJAHYcXumeYZ22sbIFtQt?=
 =?us-ascii?Q?3Af0p5kEr8yQRmq9nkht7zwTkFBDljqys8439IsbNEphq0M3nGpMs5X0fQLA?=
 =?us-ascii?Q?79fYqtTV7OOX1hIRgHWNsT5GFQNJmBi4jEzgG6dfQM+kKYgL8EakXggjBZHZ?=
 =?us-ascii?Q?Q781sZ78xxX1y/Ti0Ap+4HhhoUE+7gsJ49qXM2dPu1DQ7GvnYHz8K0nf5XLj?=
 =?us-ascii?Q?QWhg4zSrGALuJ1EO87Ag3t3VAcjYLGxRzUfE5tMn3gkvvvut/SYAccBMGCYt?=
 =?us-ascii?Q?JEql4QtnnsotO157pv7PaPZX1QS/z3s9qPfLR3nC4cDKEufQAYODJYvGNp1m?=
 =?us-ascii?Q?Lc+dZEemeS27U8TLq170iLvaguKeSGo6Alnm92iaIYGPxQo6Bjmu5tPMd0Tm?=
 =?us-ascii?Q?tU2iIBN1hlq/DpXgwejryg0mx+MEIgMpzlUajuQrP3TBw+usroDde99Ycr2w?=
 =?us-ascii?Q?Vkf7rDCor0gGnIBrU0ZseuzpkGyIHCA7/2ypQelabBgUnNWBDcHluT6lFdli?=
 =?us-ascii?Q?j6pQtN924O9rjO/NuRh7HJdPSvC4GIX604OISkpzaJ//VOHsNYZZgxaXYWBq?=
 =?us-ascii?Q?Q4RN3DP/tZA3+szpsU32m2AW+Gpq7PAUrGZQiZWsgLVFaNzO15yz5vfgdxe9?=
 =?us-ascii?Q?VMn4uU9k3KeZcemOMUYjis440sTSkDw0rEQMFWAa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1ccd11-5234-463b-2b6e-08db92ea21be
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 23:50:49.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ejttiOyHoCYAENpIV2Ggmh0JN5MkUtKtM5AyZ2zs4xafQMpVMIuJISNYp09ZDYH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 02:35:22AM +0800, Michael Shavit wrote:
> Update arm_smmu_write_ctx_desc and downstream functions to operate on
> a master instead of an smmu domain. We expect arm_smmu_write_ctx_desc()
> to only be called to write a CD entry into a CD table owned by the
> master. Under the hood, arm_smmu_write_ctx_desc still fetches the CD
> table from the domain that is attached to the master, but a subsequent
> commit will move that table's ownership to the master.
> 
> Note that this change isn't a nop refactor since SVA will call
> arm_smmu_write_ctx_desc in a loop for every master the domain is
> attached to despite the fact that they all share the same CD table. This
> loop may look weird but becomes necessary when the CD table becomes
> per-master in a subsequent commit.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> Changes in v3:
> - Add a helper to write a CD to all masters that a domain is attached
>   to.
> - Fixed an issue where an arm_smmu_write_ctx_desc error return wasn't
>   correctly handled by its caller.
> 
> Changes in v2:
> - minor style fixes
> 
> Changes in v1:
> - arm_smmu_write_ctx_desc now get's the CD table to write to from the
>   master parameter instead of a distinct parameter. This works well
>   because the CD table being written to should always be owned by the
>   master by the end of this series. This version no longer allows master
>   to be NULL.
> 
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 31 +++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 51 +++++++------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
>  3 files changed, 46 insertions(+), 38 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
