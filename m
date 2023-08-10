Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE27777C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjHJMEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjHJMEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:04:41 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2BD10EC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=el2w0CH8LU3jLMn/gfyWXvNMznC8A09Q/JN9qGVyx+T3+wCsUV7t0gzVRHd5FRG9KN1f84p48jY9OkTd4qch16U3sajxXFiPKXMsfaiepWjUkp1h8IhgfeWYA2Qh2OFsldOr8ba+H5fgNupmEXP4NC+abvQ13fdof0kacvoFcagbWIuK+TBmedgFCXt3wfdjbB7rjHw1LscZcQ9rr1a+VX5nyLx6c2f5nmDTrOV/Fg/YEyqOdXnQiNPuPtVjaVo8KNq1uHnsvaui8HxAP2Z/YNtCXPhRVKJxdhhQ1F7z1wwj26WiBSjQQNO/0kAkfN1zc1YtRmiembGHkoUS6tjLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBc21ixDPtO54yW/RZTNCEIRJegne4xPZ6l8w+4Z8Dg=;
 b=c4vus7Fw9NBYM33BmUzsXMMpm5uy7H3zr/C6xmH7EsCo8bwFXxLtw0XGFA58XrO3Gp3tdTY4manz5+HpRyherxkC6FWjE5VUnlpRoU14ZFWfS/fm9VriooxpDMxb8iMjFH5OhhezpThk1gGQuB8fUie7v542bzE3L2C/zWmB4YYSbXPMEdVXcnU+TrEYkR752mMBiQYM1YIqnReqnAmUza8yeJPgE88chpyxTsX+iprH6kMBALr2Mhmy2OaOX0rfZdymax3KKpwd/zrBbY2LDfpVUEXwfctDkg3P+3bgFrHqbtQVQLRrNmCwSBHvqkp+p7zks+ozZG1M7KQ9wd3IZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBc21ixDPtO54yW/RZTNCEIRJegne4xPZ6l8w+4Z8Dg=;
 b=EPSe7AF5mdNYdVluKz68YMB2fUjhyqoOOiZ/zTjkln7EgvOjZS/k3UhbrlwoDT0W+tVBFySQxIP4CAlbOq/Kj3nFlXPYUGh2pCw/x/EgsOEmIAQQVd2uxouwb8r0LLggxAkEiw/DtqRSjyrl0NIxSvjEYoexOe7Hmhn0N7VIRQ4AFIlLEXcv2qy+y5tLh5bmCpjZjp3QhKJuJ6GPF3DMIMn3Bv00+fxufSX99plfknKmZWngiWVtrHl9nVN7CgT+efPw8RdHEfF/3hvWALVe07lf/HllgcdETJljR/EjcD8ffuOC1P65q8LvWQU1zR81wWngPUlGbB217PSNwTkb0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:04:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 12:04:38 +0000
Date:   Thu, 10 Aug 2023 09:04:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Will Deacon <will@kernel.org>
Cc:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <ZNTSU1Jm6OsauygC@nvidia.com>
References: <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck>
 <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck>
 <ZNOr0ggoO9kXHJWl@nvidia.com>
 <20230809162254.GB4591@willie-the-truck>
 <ZNO+QVkXcHG78KG3@nvidia.com>
 <20230809162749.GA4663@willie-the-truck>
 <CAKHBV27JAFb56VkHJO2ZBZt=25aVregeiMjO2YJrg_fW9HQbYg@mail.gmail.com>
 <20230810094323.GC5365@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810094323.GC5365@willie-the-truck>
X-ClientProxiedBy: YT4P288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fff71e-308c-4489-cd83-08db9999f845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WyK4xQrTxSScNXFyrblKac0PpuxrLjpguUv0LqcOXFv+tGc4i6y9IZkwxdJ2wK0QPdTK9O8UOiI4vTN86YCwtRLoBtIgEyWwfO303x1daep2SSjn6YQIGnKIGUlurIS9lIuCewZEFst0zgPD9lCovUJMWAvz9BGqDFg+OrclWhxyaciCvp/Scq+kS4rHuvx6UDfpe751x+oL8HSIIJ/A32cg7W2bMhk1C+/mLgDIjjK6MT/sgGnBGH8He0ZFEo6Sbo0TvsdUiQEcTftY25wU85eKf/Upr95YPE7pQFJwmIjf3GbtCPfYxHSMNl6PlS7sc6kI7uuAFZvKYYinS47bnu0hgMFyHOCPJEFd6VWEhqjtT5o6gZyfVC4XccVHH9YKkf18fCxtT271ycgiSrAYpZHe8s220UTH5H/R61bxg803vQnN+jQKuLYq7KOgvslhJAfA/QuhkwQ37PBV2qal106ZHEO8doWKOt59wruupqf+x0U+NHP+80en/Vav3FG4SoKGTxV18UK0aSga0PfpiNjodSwajm3Vc4wtkTAm+M8UVszFdMZGx8i6DKNcOUxHzuM13eFzG/N1ni0ShldUJOm+arqc9/Vp9zyzgqs/oHwTKb8FEJbDddjlcbV6I2Ro5ewlTMM4mIj54ZB3778XMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(186006)(1800799006)(478600001)(6486002)(86362001)(6666004)(26005)(316002)(6506007)(38100700002)(6916009)(6512007)(4326008)(66946007)(66556008)(66476007)(41300700001)(5660300002)(66899021)(36756003)(2906002)(4744005)(2616005)(8676002)(8936002)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uu+K8uBUT/lKGlSsVqmL5sp4a0BmMWofJF0wLJuHFAA8zg1w67S1RBIJMWZO?=
 =?us-ascii?Q?XbufIxW9nUflS3wyjnc+7KmKougubzM13f948q3e/j+pYU55FCvzocBvyXEQ?=
 =?us-ascii?Q?PLkxvPRc+BPfHFjlTkd4bczmxf0YoSBGmdjfcd9KY7iQT6gCl6L8z5UK+w96?=
 =?us-ascii?Q?CzOVyz0syWFt7fOVc23+Nf2tScRLcx0F3mWFUbdL2cFh7uP4BPjmLBfjCn9d?=
 =?us-ascii?Q?lM/yMb6QFZmZLHC74QeRsSddMKiMYQ5Z+q69ESZIRw0nHZIVZFo+vJfmSslm?=
 =?us-ascii?Q?bltEf7c/cAulsViwI1T66UHGsjtppfQ9PlAVs+9/fuDp198k2cHxboe7c+vu?=
 =?us-ascii?Q?/uoTLyHjAnShTmywwhwMwkB1SQmt37XzsQBeIIDhHwHXjgGEblJbIEh48iND?=
 =?us-ascii?Q?jlavg2DzdbBzAb6U8LwrL+xh0gRsQI1wYN5H9+hjPMQOQcmiUDp706woOuO8?=
 =?us-ascii?Q?AQZu4FyPSyzDClLgBVsSw4DrjAR9lZSblqRtywP1V5fRCfSHXnyFY+nYwlVD?=
 =?us-ascii?Q?Vgs1dTeAjYsx+NdhOPQoVZAKDeKd0ZGeyeTH1d32pcInf+y6y5Dj9bC+yecH?=
 =?us-ascii?Q?go6/fFyEmYHL/bMchAlw90jhGMKqUDiddoNm6JZ2FtWM1fWJ01eYPHlGABaP?=
 =?us-ascii?Q?3jk5FWnRo/Y0TTVmFUkuJaIn0WtY3vXEToH4kRJaFyR1vkkyXu0jYSYBEAW2?=
 =?us-ascii?Q?7YZ31B4wjdjgez25njUoelRGXV4bMJSRA2gFhIBRODoGEoiLLTnIYdFG8yXC?=
 =?us-ascii?Q?RWoxMbaEgBB+YPbc9ijZLWiyK8DmaRxMBWhPVlAN+n0/2FSQhKPXCB6g1hSv?=
 =?us-ascii?Q?928sP8rqmT4MD/wQJZ1NqfAqQ8qgudX/4zuEI2w7USNLLtWQWVKsCgAZg7Gq?=
 =?us-ascii?Q?C3CrceecqDwZ2mLumaWO8PbxnXOqGjs42huCeenjMBJhoARtuBtlMJwYnu+P?=
 =?us-ascii?Q?JM5OR4UoYHwprZVakKas7+VtU4SBGO1oApFcZVrKpnQtKnRpsRxa1Hsrv2jJ?=
 =?us-ascii?Q?OB6tCJl+bKBxUF5GdTV4i2a7Z4bOI+80RP/ZKZ3Unn4SvHJqy2lx1ojGaaxf?=
 =?us-ascii?Q?5L4eqdvmgdoj812nj/4KmUJI59B4sl+PlQVj6f24mfsETZRc8fD8ZtGQXJFh?=
 =?us-ascii?Q?QMZupsgJ5E14dW8PUfBX4fa9gxonD5Pun/RdSg7byeveU9VHmnNTHNdxm4bT?=
 =?us-ascii?Q?+X5SMrIace8c13HGpBAFW8TU/PZN+Z+tjQxvaFzhQ17Kft2PK+MUsrJJams4?=
 =?us-ascii?Q?qfoJ0J8C0OUmSw/bTRmsuMqJBKazTG7NXWdb6bP9xXuBs3Hf4v5JVptrH7Ft?=
 =?us-ascii?Q?fM/lJX0hVnlG9eoxCddfHUmaezPVHuhnahnRnXCTpHJ553CdaX5MqA9WhiDa?=
 =?us-ascii?Q?PYgK2Y0Qbg4Jday5XRI2aZWpMOinMw2tGKvAhG0N6kzWUYDYRZumCWJWkfX2?=
 =?us-ascii?Q?mh9GVCKE/BHV5fTMGRLjA0rW/zly8hIDoKCAPYHPE3E5tzG+MAaSM6Rte4XN?=
 =?us-ascii?Q?2lg3gaErBr8gT87deohpcR2dSFu24mdS0YJmRu7dXJUTQfplV29qUo3w7Gah?=
 =?us-ascii?Q?j9AvK9xOiyCUlE6+BLmSqCJ3WjmpRGC4/8Fzc/vP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fff71e-308c-4489-cd83-08db9999f845
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 12:04:37.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvuqP+1v7BPk+wvvqdlcXbw8QYPsLTZ2QCr8ZO5JxBlSYXe1qB5m3/w0R8LO5Q9S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:43:33AM +0100, Will Deacon wrote:
> On Thu, Aug 10, 2023 at 05:33:53PM +0800, Michael Shavit wrote:
> > > > > Sounds a lot like the existing s1fmt field. Can we keep it?
> > > >
> > > > If you are OK with the dead code, I don't object. But let's put it in
> > > > the struct arm_smmu_ctx_desc_cfg.
> > >
> > > Ok, we have a deal!
> > 
> > What dead code? Is the deal here that we keep the field, but still
> > infer the value to write from (cd_table->l1_desc == null) in
> > arm_smmu_write_strtab_ent??
> 
> Keep the field and write it directly when populating the ste (i.e. don't
> infer anything), but the field moves into 'struct arm_smmu_ctx_desc_cfg'.

Yes - the 'dead code' is that we introduce storage for a field that is
always a known constant (STRTAB_STE_0_S1FMT_64K_L2).

Jason
