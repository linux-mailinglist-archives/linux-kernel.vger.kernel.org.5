Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F94076B6F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjHAON0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjHAONT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:13:19 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13DE48
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqN6e3UNHra7T3gGIweUjRrmNY5UR0nMwP66cU6dTV+n0PqJzB4A6vOqZy5q+umCAgLcQLAbRgKm8VjDs/fBge+PMZ1kacyskKg26V/uT+c1NKpEFuyXH1aFTsVJz+U7s5gHgqvYI6uWicj86Cv0Kd+mNuBeQsUXCHQIagHP+w6zZox5Q5lNwrti9Y8GQaeYGzWMBStLti8YAK414tO703aQ//QJeEwa/k+KlPNAZELeCXEZx22AtR3qwPsKkPxs7zeEaRLV5jMdw8n5iINf+qG/A7VSARu0MiCFCYAwxPEd9mrPFgQzpYF3ivcewg/qGRpZvn39zQZm19v2comgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vItXsRNIIURttymHEVb+hV4aj9Sq4CmajMnxEaSjspI=;
 b=avtFCEIJyEaOLzOpuwmYltbRKhPXZTmCl8sKHXDju/5VMhGfR2KcKpKKCnxtVPzfiBvVwxB/AAcCTTv/qVaQe9zlqhK9vVOHhcYh00DzyZkdSCSTMaHLN6dNeQmvAorRqYPolKu3ZJ+6V3tMFvhGYBHoAI0rxUMux/AbphgF28b7nB5WgRRbbt4Ts7hCCyL04JS24v8BNAsHTNnhNB8jm8YVZGT9LhLgilnyYCcycBDT0Wcozid6HZuEbM1B1vTB7tdgSd5UkPo91Im75djNnXCIIVNDFJq3YMhsPfbB+VPcRo2j9ZkCLYMfngdJSMxWnUEm3vaBDbChqEHMji+MKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vItXsRNIIURttymHEVb+hV4aj9Sq4CmajMnxEaSjspI=;
 b=iLEVUaxgdcLxzlPBwkvlwOM7aamqFaHxY7IJFPc7uraKSAMoDbUd0g5y+OApRBY7wQu22SVDE9bVGopF44nx0Szv5i0+I1Cw80eNQktS+hX5un67PMxbmTItJ+8qktQgDB3o2FyDPj+AYUb6kv2ZQ2syxVRVLL6grkZLQEkVsHnS8shpWP09emVtAl4YGbxVIoWq3alB6+jB1KZmyqbcr0HeQFAz2mvOeAZaSUMfGvsypjPE9xjqGI5LqFuCuVtiRfecf8MWu5RJ9UPTyZOnXUILakk2t9AfAh41rFtNHYF1ODmUD0MCq9PfykU/NSBqImEqb+wkm8thVr02dQq/mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 14:12:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:12:46 +0000
Date:   Tue, 1 Aug 2023 11:12:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v2 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd
 table
Message-ID: <ZMkS3C01IuvrI1fc@nvidia.com>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731184817.v2.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
X-ClientProxiedBy: YT3PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 762f1fde-2450-4b69-5ffb-08db92996153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UaVjzB0xfwiXicKAFR0czxSn3rajKV1E3+yQGS2SZCkLSC01FxK4OIgXmBBE0eXCnVOKygYMhZiGhquWgLLbOux3CFB7TMXUJDvho67CQbQFih9iI5IVvHaTuUbKfrfYal0mSnNN7tcxwpJNojH1683IPonhFHU5cMhUHdeCQmhSNmQuDHQVToJvfWWycf4YYA5crmVJS/FZLD0iacb5S3d7Gti4Fsv278ZcinFhFlTtYRIx2tV72PfvfN3WENQYVXojsuCJYiMi9BUOBUBmrSPXlSZmGQI8b5DWvdfoAg4V7ogqslxkVTALWdOvtlpdCIWgNULwaZJolgXtMSz26DmzO46Se4fTA7H90cZIlRuyNYbYRByKw2k9wT0kQKn5Fmoc2jwP5U04hPgf8MzlU6L5UH/gRi+p4TCWQO8+ZEVJtLmE64vT50mgvRkyA5T2lqc1CupOoF8MGLK48YxFnReiXWpxT61yndO+GWrTH6cB8tgNEVfTMvKbF7yHQPpTIOcuhn7RLyuZoNAKySHwKIssPsRszAdhuf1xzjmcXMzvCvfPMTw7hJYP+HyByAoc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(6512007)(5660300002)(186003)(66946007)(66556008)(66476007)(4326008)(6916009)(478600001)(6486002)(316002)(41300700001)(8936002)(8676002)(26005)(38100700002)(86362001)(6506007)(36756003)(2906002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gFwOs9iOoAxpqFiorU68zCWz16M9e4QP780vjIca0srxzEu/rl5yYDtxC0bk?=
 =?us-ascii?Q?IXrXGC+tz1PfgwtvA7tLNPcDLk8WAFsg39FiKxLHcq4xFjuiXEUERWCcVxA7?=
 =?us-ascii?Q?4/pFm02GK66NH/4CZMshDySwMmi38gDStwLifOn35feMUVWCmpo23GAE0zbW?=
 =?us-ascii?Q?jBfeLmKJwiG5MdUltbxppzkvuZjhEc7KQH2hV99/Vhxd85CvpRv4+MKXjOur?=
 =?us-ascii?Q?oa0VUcb9+RJ7v5kvXV1FSJCFOJWIBi2Hv+u61KsoeyEIU7ZJkn7ns9nPDAHK?=
 =?us-ascii?Q?2La8vs3OaSBfig/3XySWCiHR+iswnySTWdf0/LsT99LsSqUO0OgTGy5wKXHr?=
 =?us-ascii?Q?9qQku5EPjqSmhtO5ydI8Kq9W1EjbxRQTHwO4UuEAqepeZnWBxc6ohSlyFb1X?=
 =?us-ascii?Q?Xy+02Lrp0WWbWO55m/zFNhZTguGhpCXgFoyLWCpAiEr9xE+4KVIzU4bTYFny?=
 =?us-ascii?Q?lQgFrO03d+gXUn0KjAb+/YwBh4dZe3c7f7XbA2cAZTjP8sAuGG/5u8TDaWKT?=
 =?us-ascii?Q?n+/06GMPnd4JirRekJjo538Ns5oX7Djoa8m4TW7/ef030LjnAY3PvHPRzb+0?=
 =?us-ascii?Q?/gb+z3jsJYR0I8q0NT2Ov/ybi9TffiJAMqTWUfg08dWvFcQTdBf42j60OKrP?=
 =?us-ascii?Q?URaPA/IKYJU5Sa75EDW5r5VZo4jxc+wnpQKulINs2l9329i5SIdtr5QRE2wI?=
 =?us-ascii?Q?df3E7VZqhlB+AgCuO9xcoFoN/sJBElXi9w7RPsQSivcjQMiFJwrzv1NkZWKb?=
 =?us-ascii?Q?bK+6HVooGHbotL1P9YafZkJpMYhEyLHxQ3GNCKAH9qBnR4eV0v0xPTrJ7TN9?=
 =?us-ascii?Q?NAK0EbWdGgEGPRmZJUPMWG8MJwBONX5RGFLylOrnX6gEb3RxqupQ04Lm/8Jx?=
 =?us-ascii?Q?e35tXre3fyBln6V5wEF0eJpgLnfUoyCxHzt2BzaTMuyqxjciPOf2bGOjjytI?=
 =?us-ascii?Q?j3sh9lid4YZJJ529JWyDwTapOJZ6BkJYusVM0TAuv553hnXMWsfW7Br5YS/d?=
 =?us-ascii?Q?1JPXQzKb1E3HvCwVootvsbpnIidRetDEWcMJievMuXoegWZYERbqrvth0AAK?=
 =?us-ascii?Q?CPxO8ORLEJGVrpU8dh4U4QupWoIn2p5pTDaZJCjzrDhbK0xco666SL3oqV7I?=
 =?us-ascii?Q?VoZjeSBDDWlk9J6XF7vQl6jA/UiacdMH8JDUZZPJLlDzhTlUP/Rx8IMrQqGC?=
 =?us-ascii?Q?MzkOOhDaIPU7xO7hLVZ5rDjTo2wY7JV3SMDXc/jRekrDQRKT7ouygFF2mzEj?=
 =?us-ascii?Q?fPyk2h5833I5NdOZbi8n4mm4VB4gRQ/6j/gMlFKOZbkex2VXgTg4ZomySW1D?=
 =?us-ascii?Q?ITZ12lLaBMTqugvCw46IlW02amTmR8IbNNxfBPTmRDoKLtkIMKFnUZCk8RxX?=
 =?us-ascii?Q?zDUS70Fv2dklsrEQ+Lfh/zin1fh/grvAvmjDdnTCjzri1mJv0TGS25B2VAHB?=
 =?us-ascii?Q?dm/apCO819WBz+VjikQepBGCO7JCI0mRN8TC7VIX0GwYLuZdYZSBIFXZh/fG?=
 =?us-ascii?Q?akbe4gQZL++JSbbH83d8A3w8Sqk/USHbbr/61bQCxQudUqTR898VaCihSmip?=
 =?us-ascii?Q?Vh+nbLgb/nCKW1v3QgkI/IW6ckt/fFzGlK4r/NAG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762f1fde-2450-4b69-5ffb-08db92996153
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:12:46.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zOUm1Aji6u59znIa6ZbS2pQjFHWm7O8kvXSbDE17zsFyy4O4mjQ2MInS5tkjFZE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
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

On Mon, Jul 31, 2023 at 06:48:14PM +0800, Michael Shavit wrote:
> This controls whether CD entries will have the stall bit set when
> writing entries into the table.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> Changes in v2:
> - Use a bitfield instead of a bool for stall_enabled
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ++-
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8a286e3838d70..654acf6002bf3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1114,7 +1114,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
>  			CTXDESC_CD_0_V;
>  
> -		if (smmu_domain->stall_enabled)
> +		if (smmu_domain->cd_table.stall_enabled)
>  			val |= CTXDESC_CD_0_S;
>  	}

Since patch 6 makes arm_smmu_write_ctx_desc() take in the master
parameter, it does make sense to just refer to the stall in the master
at this point. Can you defer this until after patch 6?

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 35a93e8858872..05b1f0ee60808 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -597,6 +597,8 @@ struct arm_smmu_ctx_desc_cfg {
>  	unsigned int			num_l1_ents;
>  	/* log2 of the maximum number of CDs supported by this table */
>  	u8				max_cds_bits;
> +	/* Whether CD entries in this table have the stall bit set. */
> +	u8				stall_enabled:1;
>  };
>  
>  struct arm_smmu_s2_cfg {
> @@ -714,7 +716,6 @@ struct arm_smmu_domain {
>  	struct mutex			init_mutex; /* Protects smmu pointer */
>  
>  	struct io_pgtable_ops		*pgtbl_ops;
> -	bool				stall_enabled;
>  	atomic_t			nr_ats_masters;
>  
>  	enum arm_smmu_domain_stage	stage;

But this also makes sense, and removing stall_enabled from the domain
is important, so

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

If you keep it this way

Jason
