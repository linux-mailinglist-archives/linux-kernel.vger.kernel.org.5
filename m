Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BDE777F28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjHJRcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjHJRcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:32:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C372704
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGWC2QHVsprjSJkdIJUBqhGCLQHPgV+UzHPNOz0x3zJ/P6Z6ayT/1xmml2oClpDzkyDLVy7bvmfiSKGWY0BFLQIA2T/yqgx3Ed/d5WSU0NSb7MwCYs8t2z/5ES0V7DAx9hvFLjkRppHsrZR8Sc3AATiO3vDF8u5WBnhUmQKz1AApiJoLkq7qReM8FT+1nk/Ww32yYS4p6sFRY+CqIYLJBCCxUN+pddY0UZm2ieUhIcBGgSWEMAKaFAQGrw7A2gvSoGUWav9MDDcZDlpdXN7ktQaxJ9io3o4yZfVUcUJivhk4PGu8MF+F5r9Ov81iA3Lsqm2lObzCI5IdfjAovZqTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JomUoqbClQ1zQd7Be+e0MTC1s6BJe/PZhCZ3UgUnQTM=;
 b=W3ImaomDm4EF+G8i+XeecoAKx+Kg9OKPA5oEUBn5lGyDphBWMnFWRUooVcQRg0z0hqtaECFbyOMHKpxkDBiEzFIrwA2fLthjW/H7qV0+hS7SFaHaFs0TN94WPJuGgQjHcVdmAtiIzPOYtmPs1W/u5N2BSjRPNnT20NWx+VpbmjycwDJQ09MoEmSZ5Lj/UynMK5iVV07DE+Z60gbGxe6QTEKIZxjtM905eXtSNFdsbWvqhvH7SGMBcjGtF3D0fQJqb97CrfMzCtJ7THCYIZ3cEvylocvhDYI7gE2tFUmypR2f1fsPVk2oZOkhOWJfpnnnSLAyg7ZPVvX+0ikjMjoUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JomUoqbClQ1zQd7Be+e0MTC1s6BJe/PZhCZ3UgUnQTM=;
 b=lipkZEO4rEl+A0nuB3vn3M5g1zkVQIKTfxJDxLv45q3qaZJIc2NugTwBimIP1taAoGiKF1hnxFIgv+4TzFxNWvvXNmEXbLuybvTUhHlvMO0xl2KTMI2mZJblb4LVi88X7KushSdgFAhsAVOlNY8QuveIgqjDgwKQfDgDeEi/CtXzdnvgMwdOkyGiiJRPR1eo8wJMtx2FPOl+DsJWpbmAmM1HMRG2vMKg/PirxrhZU2AVHQBKW+7ItyJ2af9RKA4fE2vJax3HEPjEkY6mo79zTI+A7pw0YJnruTCQitm0eZlNrcRz75bcVBFvQBBdCewkeVdOVlotWmoBfWx5NBSWXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 17:32:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 17:32:09 +0000
Date:   Thu, 10 Aug 2023 14:32:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <ZNUfF1h5+SLlmwz/@nvidia.com>
References: <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck>
 <ZNOr0ggoO9kXHJWl@nvidia.com>
 <20230809162254.GB4591@willie-the-truck>
 <ZNO+QVkXcHG78KG3@nvidia.com>
 <20230809162749.GA4663@willie-the-truck>
 <CAKHBV27JAFb56VkHJO2ZBZt=25aVregeiMjO2YJrg_fW9HQbYg@mail.gmail.com>
 <20230810094323.GC5365@willie-the-truck>
 <ZNTSU1Jm6OsauygC@nvidia.com>
 <CAKHBV254QmO3iXyEL6w0PqvVofm_UCDd13LKmpbhU-cEORB5ww@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV254QmO3iXyEL6w0PqvVofm_UCDd13LKmpbhU-cEORB5ww@mail.gmail.com>
X-ClientProxiedBy: CH0P221CA0045.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0d168e-cecf-40f0-5ef7-08db99c7b97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pigqlPond22nvs5S2e51I309krpzVyoUaKsq6iZbPfA+SB5epS1UIMVIVyOJSczD/2l5Yt7KcvnPFTaAbzIUlk82pzYAQPF+JGuPBpozwpFWaGH0+PX5x+JblFqRuoyMFRAMHwdPWhUkqSiwjIfMwt7uILzmtgwhiLI9p6ScAE6iT+78BYj0qhqtfwIl5sw7RSrx86BiMSjruVsXCcFKOxDA58USiUedB2RADTwra36GlpKOe9UD7fqnux0Z1+HutUMgFYYdXuc9obtf0xtqMMooRy75H2nsyceOjR5EqV1PLR+AkrJ5ixpWH7qCwFwmWMhgyzKBgBwEUour9IQAM4XCysYf/yUFpohAAHj2D6Fl3/NOhfc1cujOkywp7OlLsdifgjfuwSxRrgKeHZNY/wSbrPsKWsuvC5Jt8xZDc90aY2KOsIB+aZkxK8cim1Jqyxf/bz9tGPv9eh3jx+aXdfuuRMcGnNOjybGoQjCr6boiCRgU3pxo/zEJPO9KYvmhRc9jCiQ3+uBrZkvbyz3lDxt8K6fjQxBN/rhJViRvcpAjE6U4++djZPffe0gfQk6r7vO5qR7xPnbedh4BuECiqarPInyE6h2NKjH8Vvq4ergQktupJ8dTXvTNY9uyuzx+Gl+E5HLpBrh6dUOYAemyzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(186006)(451199021)(1800799006)(2906002)(6506007)(36756003)(478600001)(26005)(6512007)(6486002)(86362001)(316002)(8676002)(8936002)(6916009)(66556008)(4326008)(66476007)(5660300002)(41300700001)(66946007)(38100700002)(2616005)(66899021)(83380400001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MJq6EoO9ro6mB/8KLhPlSxcUwrpSTA5n85F6ZzrbE2uGhXjIu07x/JHs5P1X?=
 =?us-ascii?Q?hKnJliD9V8QUk9z7yYH7lqBH651gli5xEFlcZdPeVc2UhuO28e4wW99C/DFJ?=
 =?us-ascii?Q?E3fbYxfxNvFdeqmGvc0UvAfPqUQRwimriYEqzaEZ0/srI7iGk+Sp2yFIeeVX?=
 =?us-ascii?Q?qIBkveLKWaypELM5mTlFrJgAGYitEHl6YfJPyk9scLW5i4vhUpsrlCyc2zLc?=
 =?us-ascii?Q?6FXbMhJrGpAMe0+SQlunBJs0et42SOnAFHFIEvTNAeN4LUdXfRW21D4zO7n0?=
 =?us-ascii?Q?43OkNtd7yYBGwRIiy3aweqgJlYhKyGXoafPRZILoED6GtwEKCjB1t7KezhUw?=
 =?us-ascii?Q?MfCbqDbNl1teExbeyCxUy3XQeBXJsCCKIiR0wQUsZCC/et6Mo00l+l9nee/v?=
 =?us-ascii?Q?9rdSzAn2Z9VfHjLEFDbtrQf97L4v3bnACJTPZvR1Vsecl4JarXXvhDlpvvrF?=
 =?us-ascii?Q?rFqyl0ykoqBib2GKfF5YCWS1vDEAAzDBLiX5OL0cS4sPhX4yaNzp9Rl1sJyI?=
 =?us-ascii?Q?sohUbrUYu1Gw7N/F6RQpUBQLnBYicyn6kr86GzJRf96Q9kw2fgloFBWB/aI8?=
 =?us-ascii?Q?mZllrWGFV7emNLVgdPJkGo53Xpp52/7RAItgphpJmoVZ54DTmYJ3Z5AoWhFK?=
 =?us-ascii?Q?V4LDxs+Up8nqcucjkoBBocmaprUFBLax4grYYqI9WtMrXpUUV/G8JaSMzwOd?=
 =?us-ascii?Q?rjEGHGude2MuWJ0a2lZDXtODvQJsPcaCu2WYZI3RkyiVwH+5mKS2JErFSChL?=
 =?us-ascii?Q?Yz3OAvnh6GGAjA2tEd/P+dtHs+WvwE2oSK5yL7a1cmvLTeATzQJjbidUOVVw?=
 =?us-ascii?Q?PHgiXCWEdRSAwNdRaMKt3pMLWOiJa4VUTDhWf4mYHdxzhqmUgj/QgvU/TqW7?=
 =?us-ascii?Q?NwuaLYaF8UmMeAx/Q1259Zfr42nWj3DKDzR0BcWknsdhGtH71BmuEeajsSdc?=
 =?us-ascii?Q?cnNFkA2ZOlBP/xq4eIEB6tX3PpGe7a1q429Ts+0qNyq9Yd/bZtj7mufMaf9P?=
 =?us-ascii?Q?ljtwg87aVQ11mteZdKodVie8QJ2zBiloAFyisjjnsTtSIn+mAceH/PN6GC59?=
 =?us-ascii?Q?kTabu6Ho17m0c84UlC41XzE8R6RTfH83pDISvhFn5brokgy0QMsphR80Peqf?=
 =?us-ascii?Q?SnCuEXTrw4pJifut0X9sOEG86XRBXPY+DxIUlcg8l47awvfK0IJeLZ8aBmTN?=
 =?us-ascii?Q?AejpnyeyVOfWGerpMjJx3MHipxVHCoz7BeYAblf/fF5731tFjtzIhHfBwb+M?=
 =?us-ascii?Q?F0xdDNoEG4nulj88QveZ9pP6CgfyzeO41dtqdkwRPKFn9y00z2ChS6cN7uOx?=
 =?us-ascii?Q?rqbS8AqqrMXUJhCh3zna2szHXDfWQXwDM2cFFI98y/YbKzq+079dKAU4oZOP?=
 =?us-ascii?Q?rjJNuEPuLsEJoWUtyw5DWqrX5lmmsZ2tz9Xk+nKntcoLN/PFHPF8CpfZ7J7A?=
 =?us-ascii?Q?7Ihi/Q3Eir2xYG+m76cOmGxrarOEY0CjFhdkgitHJOBGSygmrwSXkwr84m7Q?=
 =?us-ascii?Q?EJgSElxath8arWLQFr8gk15itexuQLutoakTM21EvMgpY03mksJziwVTdemn?=
 =?us-ascii?Q?N0aYf5pZhpwWye6ohdRwlusLIGTsTc9bL2OdzoCz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0d168e-cecf-40f0-5ef7-08db99c7b97c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 17:32:09.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQIvlyoxdDtU66mW0wjIrPicixWEXyNFTYfwfmSYt6T4rlF1mbATD0SXQxQmLNeQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:15:14AM +0800, Michael Shavit wrote:
> > > > What dead code? Is the deal here that we keep the field, but still
> > > > infer the value to write from (cd_table->l1_desc == null) in
> > > > arm_smmu_write_strtab_ent??
> > >
> > > Keep the field and write it directly when populating the ste (i.e. don't
> > > infer anything), but the field moves into 'struct arm_smmu_ctx_desc_cfg'.
> >
> > Yes - the 'dead code' is that we introduce storage for a field that is
> > always a known constant (STRTAB_STE_0_S1FMT_64K_L2).
> 
> I'm not sure we're on the same page here. s1fmt could contain either
> `STRTAB_STE_0_S1FMT_64K_L2` or `STRTAB_STE_0_S1FMT_LINEAR`, and this
> value will be directly copied in arm_smmu_write_strtab_ent.

Ah, I did not check this closely, Will said:

 > But the computation isn't happening -- the STRTAB_STE_0_S1FMT_64K_L2
 > constant is hardcoded here.

So the nuanced answer is that computation is happening because today
the format of the CD table (linear vs 64k) is encoded in l1_desc:

 +				  cd_table->l1_desc ?
 +					  STRTAB_STE_0_S1FMT_64K_L2 :
 +					  STRTAB_STE_0_S1FMT_LINEAR);

So I would suggest that along with adding s1fmt to
arm_smmu_ctx_desc_cfg you also go and normalize the usage:

@@ -1030,7 +1030,7 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
        struct arm_smmu_device *smmu = master->smmu;
        struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
-       if (!cd_table->l1_desc)
+       if (cd_table->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
                return cd_table->cdtab + ssid * CTXDESC_CD_DWORDS;

Jason
