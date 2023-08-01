Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E070F76C139
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjHAXsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjHAXsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:48:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315431BC8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF18kga6qqKyDZkbjeOARTvbjivU77qREvmOGuUAb3oYhMlc3ULjrrIJjrw1u5lXvKPeGDHpIQPElhYJi3/+U7Mfwcwgr69TTGMHKsAnYS3zVQnalvdE4ncwlOumRnedrxEp3InXH8nKB1XcViYvxDHzNava2ecyd1INmjaFhVzRQhD4SaN/LbQPZ0GUlz0BvfIODuwbLoOZImQlT5jILmM6rxOtsOSIfgspl8ksnLSNeii0sPkitFsNiGgJHko0T/vj10pynKQbS55GprITA6ZY59d9TpjIpfNqJ/nyFvqHAvMTjgufEifxJZaO3C8S4WyPqO8frzO8oxVy6K9ZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ai1tr3/B75O/nttszfgoKguZg0TJOdnrbZUjzsxB34=;
 b=WFj5zIdo78XBUrjMkLOag7/DXmAkP75h4766gH+QCpv7jAqYNA5DcDNlwlakKa36ujq9Oxt8yJcy811XY3/r8rVd/wVrfWaBAIAWbW5KT1jbvXFrUtkBZRk+QdxqbWoiLchkAdurXRX+mNZYrw8Yy4bNdp1tXfkCVWZ2c6HYdZ16vVCM88vMAStWgfv3DlgNc4iYl5d8o9wdBwDdbp4hB+FQneKH9B/MR3CzayXbMEYAJOOpm7pgKNnzsyrsNwVv/dZj/NDoPKCAGxRgtu5W08fmyRRnfcTV1AE9cQWJmPai+MZ7wwmBH0WohXdYlWBQNaNvTjQD2H9nBTinQzV3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ai1tr3/B75O/nttszfgoKguZg0TJOdnrbZUjzsxB34=;
 b=N4Q8Fg4h5tXulaK5Y28tmTjPIZhk9SqXhKDgzMZIxIZHmtPgVdtMS31Q9EFSVvhgxJneNrPl31LbeNJPDnXHCyRCTm1mluKPLdLxwiWrIq6rZrzBv5b/g8OMFrrIlr2nqB+VqSaynxRNIS6c2pz5/N2VYNbpE55Fh+sNLfD0wUxtKKrp2u4HG91MTcbzlr5LAZGcNVQQ62aAAjHZxW3r2b2MJTbryL9rp3d6pFNQytpsGPYtgookZnfK2VMlpCAr3thiLPCbZknxb4aVnou0i9F8BAyVmWaXxjy8TGuzukgesTPOOdfmbtV7tFlmJuu7c+ClAcfrDHJh/AZn7OaiZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 23:48:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 23:48:08 +0000
Date:   Tue, 1 Aug 2023 20:48:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org, nicolinc@nvidia.com
Subject: Re: [PATCH v3 2/8] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <ZMmZtvGtQ5mGYSxa@nvidia.com>
References: <20230801183845.4026101-1-mshavit@google.com>
 <20230802023524.v3.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802023524.v3.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
X-ClientProxiedBy: YT4PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 30562a91-d1a7-4d6f-9428-08db92e9c1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10yhTvtIHhSPNt50DJlN7+yl/WFX35WTaxP1YqakPIZFSnnhE+5PQv0asCFYbSGgHve4L6nqRKSDcR71c+cKwFqPBvDjHijMS8qT+NZ0GgYgH/scS0J77w+o760as1A7sSmfkxNeR5NFASN/+ZMuZw3u5r9qn5thZuuVU4tE1Que41sXzzTyIYcruffQx9U5NHLtLxlOD9gzmtCbl5c54U5D/STLM9+YUbq0bgQK1vKuIv/36J0flBw6daXDUFOcGbwffPR90TxLVSccc+DcJS5adFI0LotIkwKCtz5VsmZVeGgZDW2VHqtiS9pjNEkQY9V8J6cGWmTfQQTvoOMlVx6XM2z4ePVjRO4X5BPM7sy3EHeE9yUiUbVWnu+vaHFP9166LV+ReElyaeUx43HXJytyF8oiEa8fkU2X/mqry/Dvlc/R6EHoMW5V+95oWRR+DeQ8zjeUGPGQ0ivPPij/tr7gcwYETPvVppjZNbeGq1aACMBi2QKlXXcj1OJRbHV6wDVWAF8RwhdbypDKkTVwhUoLffocfLQZpOX9YgpHjP8u6zmNGT8Ca+H/C2vDE0uE3RtESJSwrG8qQ5newgnccIAH9TlTPQn4Eh0VtHd9GLCSmANgpWH1b+BBwrch90JBqULCt1phPFtM85d4Ge490g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(186003)(2616005)(36756003)(6512007)(316002)(478600001)(86362001)(38100700002)(66946007)(66556008)(66476007)(6486002)(6916009)(4326008)(26005)(6506007)(41300700001)(107886003)(8676002)(8936002)(83380400001)(5660300002)(2906002)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i9VXEdxcEKqCS5o+uTOqpO9q/iA1uuJkkPg1aEt2+onvtAfhieVJA0dtBJmI?=
 =?us-ascii?Q?twQa15bz4wAv80spDCit7rP7TiiUxgEdfrTwp2+x1zegrfrL1hqB/jmT3XUz?=
 =?us-ascii?Q?0WyqD1YiiryuGI6q9WZgmm7Yd/VCYWgYtzlMLZ9qrYi8lP2deLFvUX8zjEjL?=
 =?us-ascii?Q?UsZdnhpxuQNvrS2iHaYMy2QhVKwpU03xBCNNyjnuDnUhoaFFKEpp8fiEqaNv?=
 =?us-ascii?Q?4GPobsQzVtFiDS4D7w2QnXobHO42KJP3w/f1san6sEFMjZSW6WK1Ck65XFK+?=
 =?us-ascii?Q?oPXP/hMHys+/ZEmPJkCJpdGTJSatOgJPud9alKB1EWfUz8nED6onkUE0e4/l?=
 =?us-ascii?Q?Ql7hxwT9vjFd8VoiPukzlmNEpefft/cPmtUdWv0gwF28INE0luJdzOce5V/F?=
 =?us-ascii?Q?YyeEVPZQ1ixm4yElxuN0n5KQLZj9Oq2pwYjqi/YJ0x7INSfSMahuFMCdNey7?=
 =?us-ascii?Q?gCb44JTCOxbrQE//x+cxcI/DTnE/0UBPOLIii8hdYOaIfjZdDvjt+3bwiiJ+?=
 =?us-ascii?Q?ZlXT6WZgxk0vH1P3rOtT03PYFlF00VWif2vTxMY88R0ALjgerO8K5PdBNAzB?=
 =?us-ascii?Q?lawlWfApfjFuIcC5ZngrbBNGKH5pv8BWk8DIOOVUlTTdiIoyM7nbkSyZpQRJ?=
 =?us-ascii?Q?v4/VlF7MzMF7Nz75lxq/TYiezkERFt5LzUJHtYOcfPWxAOQZNLyT7vbd6Nvd?=
 =?us-ascii?Q?KPrDK8uO37HnDQVN9UqMOTCCZ5pvUVnR3sMNlvDb9sGZe+LizUZn6QlOwP8s?=
 =?us-ascii?Q?fhvh+xBTWhgbtAb/FbvQsLFMKE+pUKkwEI8KZS45uLXHlFzJD6NlxorzkBpF?=
 =?us-ascii?Q?F9FCDGXXdKMfpUPEyiEp22e6e/tTkzp66cWj1XEGqXo5gwMKPQ5xP3DcFc8f?=
 =?us-ascii?Q?kPmFLziE8zk10WS6cmoyxvwM3htpcSVdep0K691CPgnfidTnAVxudXmhb2o/?=
 =?us-ascii?Q?oxiUh+r4ykY3i0VByafylH/NdjqdZYj1/E/PV4Qu4QhpQk7KJQ6OApyORqmZ?=
 =?us-ascii?Q?3QlYSbmX9b4Yag6IjfetiyZrx/CSrvjontN4Ihw5HSOQ5pznANcjR1/ZIu1X?=
 =?us-ascii?Q?FqfS3V5C8Qs6oljLFu76z3FShgi8gWEHdh4palQFPuGMsv8CjY5Uu7XJtTiI?=
 =?us-ascii?Q?v5/CBqMbG+7p0jC9HhI9TOjNe468dS6ebLi7QvTd0LEskqdbaNb4gIQgggOM?=
 =?us-ascii?Q?Y10J8iZWsvZ8tI2Q9y3p9tWUSaZPYXGdQp+fi5g4ZU5/CSZxGImdWV1wppAw?=
 =?us-ascii?Q?5jRBqERWILl59wM2ICHcmF/u7PzyHo4NGLlZQxWfGzOANBpCu11xfsC2cZk4?=
 =?us-ascii?Q?3FGn9Too+t1jKGOkijzGoG+ctLb7ynLeSDvYbbElLHJqItr7KRnm1vQAB0+6?=
 =?us-ascii?Q?dQdMRkWzWb+uSosTJhGloLR0DSfgkjoYoZZQPJ/nNj5++FVh3yKOG36H8j/H?=
 =?us-ascii?Q?Y10c2Q7W91MG9ojj9MX7VtqxSFbcFRlbUYGB4xvztHv4CI1puoqhXK/Oy+qO?=
 =?us-ascii?Q?tifpV58Hx/DFv5BL4GufOLmUQOWxRMv3+EnfSWWaZrQJa1ipG0uEHB4l2cIq?=
 =?us-ascii?Q?FYoLXGdqfUBroot0W7+PoUjO7ZPOa7zsuDcMhgYc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30562a91-d1a7-4d6f-9428-08db92e9c1af
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 23:48:07.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vfA+ufuS8pYC6mTgWHKTrrMgk2LUszBf4QblZnGA5IvDQuTPZSxagkKSluwex8g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
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

On Wed, Aug 02, 2023 at 02:35:19AM +0800, Michael Shavit wrote:
> Remove struct arm_smmu_s1_cfg. This is really just a CD table with a
> bit of extra information. Enhance the existing CD table structure,
> struct arm_smmu_ctx_desc_cfg, with max_cds_bits and replace all usages
> of arm_smmu_s1_cfg with arm_smmu_ctx_desc_cfg.
> 
> Compute the other values that were stored in s1cfg directly from
> existing arm_smmu_ctx_desc_cfg.
> 
> For clarity, use the name "cd_table" for the variables pointing to
> arm_smmu_ctx_desc_cfg in the new code instead of cdcfg. A later patch
> will make this fully consistent.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> Changes in v3:
> - Updated commit messages again
> - Replace more usages of cdcfg with cdtable (lines that were already
>   touched by this commit anyways).
> 
> Changes in v2:
> - Updated commit message
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++----------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 10 ++---
>  2 files changed, 26 insertions(+), 29 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
