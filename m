Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBE777FC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353671AbjHQQ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353739AbjHQQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:28:46 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E45AE2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjjaUS2VDhbP6JN/ViJFuw+MVS4tIsmzQu3CEmYVTlEC3VO+HRfKLdv+tVkVLbIo71i7xHYkpEAxydzhomgkOA2kYprxpSKZydrhg6NWRWKzPkkQAq+TQhm7jEKRY86G6AjbUlKEB3YAAO0I41ZLC/+Bb66AW+NyjbPzFfIoL4j9IFwtCcqobBo1z7t5npIMAmi0B0a1PnExssZaxoLBXzPD3hWCy6wd+RZQPwssccvhdjM9tOY2DEE1C4KokcjxCsQ8MWO2y9u4/jY9xX7xd5wqEQJaZhbDIwZJJ9/KeW2mUzZRSqhw9R+DjHmNxieUP8Q+MatCDKS59qBlX85B4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPljuCeY1lmI9pTrzB+xynFv4YYe3vgPJSEAY4CnZo4=;
 b=SIdpkRoOmSqV37QanOvscEBL20/TxjD3DkfZVDEZ/mm8PH2RALZm2KV7LrPJ8zNX9uz57/SB0B9eZ9yDWkZ7ulPCJsC++ZCnWhKfdURZ8Zz8CyNR3waX7zMjzGdUVTjc+OVdycClB47RsqRaGJ5DQ6JKn5NWoINeZMDBd94O7pVeJyc+JbuTk4DnYgoz/y2fZ7FSZVBB90HYApzzAGbaSpuMG//rF4LLJPmrFQHizs1/2ipt2nXboijmR96DFYy8+rZX5QSMA2Yx5ai5sfMvXMWKjNbTd/0WhvN0U7Qpi/lMopKKpIyyLMA0qAqf2wpEE+qRsZZh0zaix7FRmO5Iow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPljuCeY1lmI9pTrzB+xynFv4YYe3vgPJSEAY4CnZo4=;
 b=IBYOIpDWk3AFMSz3dSndBhV4p93eqxn9B962T9yqGmiX5V8UtiWptX6FWCZSGn4NigFqLG3JRgboCkSN08MBDhvG9Z8w5GPi5zw3nxKe1N/wVXuGkHm/pzX9ywCvONDFcAI8DBnYuU8qUojE5CUqV1kz0xF1/zWAMkXFrsSnL+sC0pjd5DO1RWcFySiFMfGxA2WIP9mFwGqZqwHoUxQwuDbXNmuFlRrVjlafHXNzvXxnTS1YDAmsK3Vc3dJfaXUxbuQuqgRHpEb44BNHXirE4qmrnE+H2PLGmL3sIAF192NwgT5R9fLY3ODQV/Fw4aNn1g8A2dkm1IRflQ9jmHGPTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 16:28:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 16:28:41 +0000
Date:   Thu, 17 Aug 2023 13:28:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        joro@8bytes.org, mshavit@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Allow default substream bypass
 with a pasid support
Message-ID: <ZN5Kt4mEGp0XnGVI@nvidia.com>
References: <20230817042135.32822-1-nicolinc@nvidia.com>
 <ZN46upjIBFcI4mL+@nvidia.com>
 <9ba29982-ae96-bf53-f021-21cb1b22643a@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba29982-ae96-bf53-f021-21cb1b22643a@arm.com>
X-ClientProxiedBy: BL1PR13CA0352.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b46b865-b6fd-4e9f-427f-08db9f3f0465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bINT23Q9qVgVZtM6HSLJ868IKeYwioEG+spAm1t8ajHZ0xYAgHURkOZrKWb2GybBxPKmod7Ur15yc+NDNXhQhc5lW1agqV/bgRfgPr0E/+xaysRf/Zwt1Kf0frwuCws+e80TpC0Xzmu+1Kus8ZCngEFh6xXxafM8TsjoTt6AcLo2ATkb+J1LrQUKk32OzvzFaAd3GeBFyK5r8bUTgyE016pm56BTifEU5sJGg5ifmgLE0VCJzsK49rq3i83Y7z+A70bj3iqcpZg8UIc4tomly+O/RFSIjDMKAZMfA1SdoixpyWPI6d+ooLHqGSrlqfLjcxeXlxTbWXqoSdItyOoo6yl27ZBoCTMwri3Ms/o8wbxHGp7bgJhomDeJFiKH0lj0QT/8WK2RuFl7xJT0udMdoBNcGx91wc+/tTvtDin9w/Wu9VMpSJlHX/s1x6AQmetSnKYv6OoDq4vw10kyrAccdpicfZzMNDVViwfoe+tRIJCrCLVvIe1yPCu2c3mEleaIGEvwEPZJbG/Yph/GeJs3r9XLHD9oFD/SD6F6F8NEl9uzO2cyTgmY04/LLxnFowq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(36756003)(6506007)(2616005)(6486002)(6512007)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kzyYoAcazLMIws+GWg5wFvlis9UJ6EQ/VyHXY6vq9bl/uMgbXCuQcZ3cT3o5?=
 =?us-ascii?Q?mDX2PWD7CNGcYHz9sov5eAUZlcm9PVHXmRgh8h3XaRLhiz0Tnwpigw6M8a7b?=
 =?us-ascii?Q?caq6JrkhQGghG+S7/4e50bp6vnCo9zO1GD7QGpkBloF+QYtOtngdCEuFdnEd?=
 =?us-ascii?Q?18nridMo4iGmZS++81+VXKF9HcaxmxKwKzZCSrSxY8xDScVdubXj+nvIkzo8?=
 =?us-ascii?Q?sPk/LR3DLEDqg/tSbbeD6Be+WeSIoAHNVUxF6Tlr7uaq8h0QMDXln2eYrHMx?=
 =?us-ascii?Q?RqNlcqdMYXLd50zlRLUSsKxz36X19aKKbJ4PorA1MP7MLZ8GsBTGDf6JDJmQ?=
 =?us-ascii?Q?HREZ7Mqm/rorRaSKTBXSLPPPOvNn9uqw19yJUWUrxQnhOjJNg1qQyBT1fuEV?=
 =?us-ascii?Q?BbOEZwLQXJqbLTQ+KHjYCeQ3S8IKxF8KHsBleTZjobj1cC4cXpLdEmV0hjTI?=
 =?us-ascii?Q?nyH4IJFFaHKCzPGrp427IhFLDozEAUJTMY4fKbHrjjdb2Kq3WV1uAL0txU/Y?=
 =?us-ascii?Q?ZwSbv8GE7CGkpLftibv1eRqWvx66uwK0tEEJt3CgjLyRSN41n156gMkvLZTM?=
 =?us-ascii?Q?V3fxoXfh0WIsaTgjNRRypzhv88J+rXXakEQqknhBCKyViW/E7zrUme5eUNKW?=
 =?us-ascii?Q?GajMw+ECfy/GN8tsNrrlMJ9STp5ldvjH2Buhhod2ZfyDmFV8EIZk85W1QtFM?=
 =?us-ascii?Q?TPoj2uzhHb5uPNccZRaxMKhV2/HSKA7xaJMvRA23z/kBWSLql2RWHCv9kCfW?=
 =?us-ascii?Q?K22JpmqBZ8LMUpudIlf14a7LERzEgxorh0ouo9TkWNRRzclJ3NgR69LDO/7z?=
 =?us-ascii?Q?IvqZ2NT0LJowgaLqtieYjLb501OE6eu/u2EWBwkC1yRoPgT/xIHPNQu+gUXD?=
 =?us-ascii?Q?0ElOPM80LzwtZVEw//PqlBuaEF3nBXRb8TQtM0lHLtHEGYocWlWeSb72YPNK?=
 =?us-ascii?Q?jxZMnQZp2UO4nLDuIoWoXmknHgbHDiHUzbDxVznqic5pG0rvOxaUmC/IUTpk?=
 =?us-ascii?Q?/hj2dxrSNNRHUr/JZ2dlWQPor9OcgNx4tzXr5PQSBrAu5YWGfxMsNG8Zy954?=
 =?us-ascii?Q?Rtf2injXqADq1ULXgvxdgbD2qh8rID6d2fWwDWdTAn5vMke+i3a4HoDDsuhQ?=
 =?us-ascii?Q?BwKjAiUoOu1MpyX2LAseZnF3TQKuwbkqMB3ZhHaaPZihGR2JRTs98QJqmEuU?=
 =?us-ascii?Q?NYbik1ebsNU6gxCXzoFfe4yjjIi7fvacSq8yjdaIXHBvm58SyE8bgveri8PK?=
 =?us-ascii?Q?NGLwFcPc5DtLTo2siBVfy0HSfIDgP52WNTqCN8lIKau/oZqbotLYyNCYes6g?=
 =?us-ascii?Q?s6vkDRfuZn9nAF8EnK/zK6UXqWA0LgESm38HVgdXh63N3XN7V3jtumyZAzq+?=
 =?us-ascii?Q?zN83FuJ342UA//8K9cNkj1xv8PTixRSzJete+8KD6sBcDyIABpMzAImwQ6z/?=
 =?us-ascii?Q?rrTRtb+wfV899YR2c/vc/A4Of+3E17yq7MPD3gG0fduYY2SmJq33pCfooCmO?=
 =?us-ascii?Q?v6e9+ljvemBrqUrdG7bejEYs2P8wjwgojvUZTX7bbzMGOTa5q0yP1BpeZA4t?=
 =?us-ascii?Q?se6EH5HSm/t5H3WbRUfrhhJN4atVV1g0ekPxTpPK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b46b865-b6fd-4e9f-427f-08db9f3f0465
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 16:28:41.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AhbweqGA0FRgA0qtsYFTwogJiTzB2940Zzw2XujJcTLVVmZxJvSmQa/WynFSktT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:24:51PM +0100, Robin Murphy wrote:
> > > @@ -2435,6 +2440,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >   	} else if (smmu_domain->smmu != smmu)
> > >   		ret = -EINVAL;
> > > +	/*
> > > +	 * When attaching an IDENTITY domain to a master with pasid capability,
> > > +	 * the master can still enable SVA feature by allocating a multi-entry
> > > +	 * CD table and attaching the IDENTITY domain to its default substream
> > > +	 * that alone can be byassed using the S1DSS field of the STE.
> > > +	 */
> > > +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS && master->ssid_bits &&
> > > +	    smmu->features & ARM_SMMU_FEAT_TRANS_S1)
> > > +		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS_S1DSS;
> > 
> > Then you don't technically need to do this.
> > 
> > Though if we can't atomically change the STE from IDENTITY to IDENTIY
> > with a CD then you still have to do something here,
> 
> Strictly I think we are safe to do that - fill in all the S1* fields while
> Config[0] is still 0 and they're ignored, sync, then set Config[0]. Adding a
> CD table under a translation domain should be achievable as well, since
> S1CDMax, S1ContextPtr and S1Fmt can all be updated together atomically
> (although it's still the kind of switcheroo where I'd be scared of a massive
> boulder suddenly rolling out of the ceiling...)

That sounds pretty good then we don't have to force staying in CD mode

> > but really what we
> > want is to force a CD table for all cases if PASID is enabled, and
> > force DMA domains to be S2 domains as well.
> 
> Wut? No, DMA domains really want to be stage 1, for many reasons.
> Implementing them with stage 2 when stage 1 isn't supported was always a bit
> of a bodge, but thankfully I'm not aware of anyone ever building a
> stage-2-only SMMUv3 anyway.
> 
> The most glaringly obvious one, though, is that I think people like PASID
> support and SVA to actually work ;)

Blah, I keep doing this and swapping S1/S2 in this confusing naming
scheme (and it doesn't help that AMD is backwards, sigh) - I ment what
you said :)

Thanks,
Jason
