Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB076893D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 01:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjG3XGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 19:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3XGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 19:06:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FC012F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 16:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PON+puG/Wisv5LFKvMkwLmQOf2NaDOTMX/QRkSWQKMQDIPc0HN7sBlyAnZQfzG4JRULJfbO0uUkYKTwoDPVEA2jv1sIp6enpBHOeOp6qmSGJab4B0FOojLPeu1bcpdsHlhEFQZrJZtnyYGrKk6daNg5NHGFfG13UDlZBwkkiZSmQcJ/Za3lCUAZvKkbRR82yQ0DoodHIm6RpFMpcS0KpeudXPUBNXQOnUiGe4HorT0pI5t2KGGYE7c1Pfav6Qt/jl0xx33L5WfHxBCeDBsDSFDK6pN+MZfjPuMXoDTopqpjMlACZP9HfdeJe+iBamz1rENEVfPpSC6zSF3rbkHu7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfnI9GGr73AiU5HPZH1j/DjDSxviER8PdaC43gRuS1U=;
 b=AxtMkzC1i1vn5pTUy/ay1d+YoDXNUhNYDkFfh0SY/tPPKQD462irJJ0LhrhS9TTOHw/zW9ekk1we/Wqnn+LnffWZNhDsu1kUk/0Tl4T6cyshKCyP8GcqTr2gC2WOrjKzSeOwbAgR2Iq9tBIV5hKCkAziscnm6Mbx/dp5hPJdiKN/hBRBIqFLGrexwbbkGkKlufA1UmCYXe5tJuT4/MgB09ge/nZy8hXebgVyY9JTHOTslHBnRS4c3nd8G/VIMSlZlLhbT50vSNu1KC8Z/LqINk+6k6fWPRN583bPXi1b53wyZbuhq8cuKRIOW331bp4ExKRgQLg9xPhw8MmhhO10gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfnI9GGr73AiU5HPZH1j/DjDSxviER8PdaC43gRuS1U=;
 b=jQQjXuG4ntUYnEtsQwXoaPd8t5iJJagqbJJpGR89+YIxlt4wsUTn+dquss0yB2rZWIDAxssQ0uMUo9BeLZhOaCH47nLRhHFWVT1ZBk9vH0ieSA2csKDOFFEdvtauPYIPFz2bZAvaXBtGtI/K7c8dqVrP8fEIRFnlt4d5LNIDGFVwEyZuvWNbJCv2ThZJZXzsYB5QVnACJpFG5Lz9ogGsoGmLkcT5ooSWdYY6asjuM9u3TwF7JbXyhvkiPnqdXyorCLHexz3nyHw9rW5m5f3wES06fpxeH96SMwq9HLfHNBwja33Aq2PEhz8WjkF03JEH4OL+33hzk7NM1prrYnB+dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Sun, 30 Jul
 2023 23:06:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Sun, 30 Jul 2023
 23:06:00 +0000
Date:   Sun, 30 Jul 2023 20:05:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] iommu/arm-smmu-v3: Replace s1_cfg with
 ctx_desc_cfg
Message-ID: <ZMbs1rquejckws+P@nvidia.com>
References: <20230727182647.4106140-1-mshavit@google.com>
 <20230727182647.4106140-3-mshavit@google.com>
 <ZMLaM9QjHDu11iKf@Asurada-Nvidia>
 <CAKHBV252e5Cx1nssFTPVBmr_iGqLhvp1jjBfR5euRynAzHC12w@mail.gmail.com>
 <ZMOzHJO23ZakRs8b@nvidia.com>
 <ZMQL1qjHT3NE9FR2@Asurada-Nvidia>
 <ZMQO0iLDkgaDe7ZT@nvidia.com>
 <CAKHBV26d16Y2zWiSe2FuMgqGQW3vz9hk9vb=G=h373YN8X9Zgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV26d16Y2zWiSe2FuMgqGQW3vz9hk9vb=G=h373YN8X9Zgw@mail.gmail.com>
X-ClientProxiedBy: CH2PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:610:4f::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 234cee00-9808-4ae2-8f19-08db91518a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpSjw6fHagay5RV0B/7u55/ipd6z45TkmLca9UBLA+nXyZlHCNfS0LnKp2gRG0QOncxe8902TC84OOzsOQ4gqEhXFKz7p7EdzwtYdELJ4SZT8lY+IxTzG2lj30hpNJw1IMOMYdEnwbhE1DXRzyk8Au2DHwt9FpqGNLffM5uyuoX2VWhKCRhRqBfbT9H0xxWfIqGNcVDKgaBPzbYSxlZ1nwvjMBFK0iy/lr+5Qyzw57q+y9Tw95XO5JyB8MSJTjpNqEYAiFwdu1mEzVHEWo0ZfD4r+3g/C4p84lRcqS5mOfCtnivrkWVstC4MYZfmQw5ZHAEx6SlkoOJHa2AVKf3FOQnO24fz6EKfciYozp/Bwj3fW804jP011m3GWBBwRG/9xVkfUgXLTvS/XDE1lLHh1h5kVFZCyXUMscfJ7ESj069wqMrohzxpHiinwWDpVfx8Fa/tYQ0HCcQo8Bif2W62ejDRmFPfJ2FQDE4qzGeO/c9Gzj3jleX3eGobImqwieEaDfZaJeJDZrLhxUE37XdNKxne/ZWUDNiQxJ0LZ+4DH0HQp+7GopdQXRykqGihhj5mhLelWFPdHzb41ORFQQe/spZNkA8cSD+OSPHTzcujj2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(38100700002)(86362001)(36756003)(6512007)(478600001)(6486002)(2616005)(53546011)(186003)(6506007)(26005)(8676002)(8936002)(5660300002)(4326008)(6916009)(66946007)(66556008)(66476007)(2906002)(54906003)(41300700001)(316002)(4744005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzVaMWNNNzFKVGtFK1h0T0c2UllhSnRhNDVVNm9aaHRVaStWQkE2RTl0cklu?=
 =?utf-8?B?ZHUxS2lwNitWd09HNGM3YXNIZnNKcEFLVnJ4bmxyanFSWkptdXB3ZkNtZFRu?=
 =?utf-8?B?aUp4TW9hNFZvTUxPblhWWTBVZjBpMW9MOFA0VEZKVUorSWxJOVYrYTFtaFJK?=
 =?utf-8?B?ZmlwYVZUaTdlNlVNZDJYbXJVdnQzeHpDclFURkV4V3B0ZjZjdHh2SDdaNE81?=
 =?utf-8?B?R0Z2cUtuVXlOQzhsMnpYOVFPVkxxWncvTHM5MEg4NmVHNFR3SGgvMVBLY25z?=
 =?utf-8?B?WnpBSExKQlM4eWZvTFpCSzVJU0xTT0tNQVJuV3V2S3YwQ0VUZHh3YkNDRWNz?=
 =?utf-8?B?bFdicEVNbk1Tb2tWaGRPa3NZamVYblAyOUNjbG5aUG1LalRCd25qemJ5WUlV?=
 =?utf-8?B?VkFpNnB3Tm5zcVdiYVllTDcxSldKb2FMU2hUR0p4SlRlaDhUMzRtelJram5R?=
 =?utf-8?B?MVNiZWJhdVJOK2NlNThOQ3FiclR5ckR3RVVuSEVpRit6bmtUcHFqQ1RkNjI0?=
 =?utf-8?B?dUN6aXVTc3l6aDdEYS9JM2FRbHRHMzEweE81S3krKyt3ZjAvTndEaDRqMVlm?=
 =?utf-8?B?VTJsM2pxeXM0UzFLR28waktBUStaZkFKcXN6UWJBUzR0N05UZ2NjZjZxQ2hl?=
 =?utf-8?B?V2FKWTVBQnB2SXdJenNRRm82dzBnUDY4Skh6TUNaVVJDZUFUbGx5TVV2ZDJB?=
 =?utf-8?B?Njg3aU4rcGEvZVp3M3EyZGUyYklMelpHS2QxZ2JwQUNFekI4bjJ4Z2ZDUVg3?=
 =?utf-8?B?U1VFU3F4cmloSnR0MUtkaW16QTBHVTRHeEZZdXBxdHJSRXhlSWNJNmkwd012?=
 =?utf-8?B?SVhDNUxqUm1WNXJEVTlZQUwrcW1hQVNXV2NGYUhLUDBVc2xvMHZsZG0yRksr?=
 =?utf-8?B?cWhmUU9LWC9UQ3MzU1hDbGY1MnMxcXlCSTdHWDA0VlBJNnZBRGxTeWpHMjV4?=
 =?utf-8?B?R2hqNnI0TGZyZE5DVU5ITEVSQWpCVmJFenRVSENlQkRGY0ZJTjBFK1BGZHVV?=
 =?utf-8?B?MTdPVUpPb0NhV0Vzalk3dEgvL1ZtZTMrYmVqaGVQWUp4Q01iMGpuQm1QeWFq?=
 =?utf-8?B?VUlmUFVpR2dBRTlBelA2OFBaRlJYTEY4THc1ektGamZLTmZyeUJmdXlyOGJV?=
 =?utf-8?B?alExdExwdTVUcTR0dS9HQUQ2N24vZ05jclBrZDArODZqSkNsaTZHRElpck5s?=
 =?utf-8?B?TTM3Tzhqd01XU2RZa3RTVnc3cXFHUHZEdWg3bnlkSFEwM01QSlpPSlBHNkpl?=
 =?utf-8?B?L2pQZFk4LzhlMHpVSXFkSjFNWW1zaEJYYThJODNMdEpVcnVzdGVMeS9CVEZE?=
 =?utf-8?B?U1NBcnUvaXRnRnl5TFRvUzAyaXhEejlZdmY0bUM5eFJVODVmdU4rdWtyVzBv?=
 =?utf-8?B?QjZVQUJEQThFMXZzWnRnOEdKTDhVSm1CSU5PTVhKNEM4SGVPUTlHNHkwbWQr?=
 =?utf-8?B?QUIvaVVCWXZ6cWlENit4cjl5RFR2YVEwZmF1TVVaR1lxSS9ZL3MzdzFNQnhI?=
 =?utf-8?B?TEtvYXdTWkZSbTNodjVEblVYVE1FVmtZcGRkenFKc0RxR284WDZFdWFTbm4r?=
 =?utf-8?B?MUZDenhmQmRGYnM5eWlqWFlMRkl1RjFDdVpnQ1VtQlpCMmdkdzA2aTVRWWlr?=
 =?utf-8?B?ZWJYcmd1a1dYVndQNUd2VEFzKzVTMTBCTDROUEs3SUdQdVc4UW9kdzhUWTVB?=
 =?utf-8?B?TXpiMkRrNzFiOTZVMFpGUjFPOGg4Qkd3MWtnMXNlZ0FJelRCTjhIU0F6Y2Rp?=
 =?utf-8?B?aTJEWnJ5ZjVGN3YxVzJJVXRVMjhOQ0cvVE1CN21mTjYvcW5MdGp4RTE0d211?=
 =?utf-8?B?S0FGcEQvcXpaMERsanl6cGFpcWU3Y0JuY2RUNmFTZ0wzdjlvTzk4cE95RVpH?=
 =?utf-8?B?MzI5RjRBamRhNTRsZFdPdENIdGJ6M3NndlVablA5NFVBRTMrSWE2VGlUMm8w?=
 =?utf-8?B?ckw2VmE4QVJwWXQwV1BJbTljK0s0M240YURJTUpYeFhQZVU0WE9mdHhCc1Ja?=
 =?utf-8?B?TGUzV2hEa25BaFVDSzN6TFpuQlUza1U4eTUwbFluTXdkaVp0WXRBdmVySmlT?=
 =?utf-8?B?dVVNYXZZWVA1eDZEWmZudktZdFhJZHhuMUxsUGVOclQ4MVNJRTF5dytBbU5Y?=
 =?utf-8?Q?hZMU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234cee00-9808-4ae2-8f19-08db91518a91
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 23:06:00.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xf/BEakjRxxQ4wUSTQHhtsiuCi6mN03LQ2peXsKIDBGTUiUB+JETUeNtZhY1RytY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 07:24:28PM +0800, Michael Shavit wrote:
> On Sat, Jul 29, 2023 at 2:54 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > Still, it would be odd to have "cdcfg" and "cd_table" at the same
> > > time. If we have to be conservative, perhaps we should just align
> > > with the old naming: "struct arm_smmu_ctx_desc_cfg *cdcfg;"...
> >
> > Yeah, I think changing to cd_table in the places touched makes alot of
> > sense
> 
> A bit confused by the "Yeah" reply given the quote... Are we ok
> keeping the v1 version of this patch w.r.t. to cd_table/cdcfg and
> struct naming?

I think you should optimistically use the name "cd_table" in any place
you touch. Leave cdcfg as is if you don't touch it. Consider a final
patch at the end to fix the cdcfgs, and see if Willy agrees.

Jason
