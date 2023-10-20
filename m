Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCF17D194F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjJTWqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTWqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:46:49 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2112.outbound.protection.outlook.com [40.107.212.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDA791
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaa/tW8FLVsFZlKjEMVkqArXIU6KKdsaYdu+92vvM/B8Qcx/7Be1zXQ2MXf72aAkp+td8i0/8WmbSm/1CPA0a3w7anrdYkDEIHbMHugMPbgC7LsBBuxhd5/ukwtewybustCuRfrNC9YFMUHk3E04/TqWa2ShW6yRaRL9yp7NGpNDUap1EFqvqPYDMxgkE9dWICOJ0lrK/x8nsWt07eNqYnVQgSIlsPDY4jXFl/9zHM29Biewj7vf75UM+J+sxJPprFTmHKou9j/lI/p8RGfW6UL2Tlnmlb/q51A1zjuqYgpSp0YLrwaDltN4m1r/Rmzgtj4HL27fLEZWknWhWLeNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=093HsMWzjZcvHCm2V0M9uZ6YO8O7GQTIDq8vCzeC41M=;
 b=Bps3BBLRyExXTl6VGqrkMDp0Q03NiLHsTBo0LHM4SLGmDxTlVMlOzub5NVnOfwxRGj2/+KFfvP/7vSJjAEGALPji1h6KP2OXfHSlV/Jo7GHnZWLjmjQ0WyVSk6AVD23S4U+yFPoPzV8tCP7IcaY+TNV3ZVneCzomAF9bP9JH5XDehQeLCX3/CFBWms9aYQsjTgFPiBC71nZ89wRW3vo3y9fEpQDWiCpPNRydo+VXH9sAFUvi68xRsndlOEf17EinfdrcIvqKsijVSfTiS4xgQtLO26jiz/BrV9hyoB6J4uaWZBOtX7Z6UiaZhd22MeY/3zfsM3I/c0p1igm79M0qUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=093HsMWzjZcvHCm2V0M9uZ6YO8O7GQTIDq8vCzeC41M=;
 b=Me+XjqMqg/oKPhmo6+iFXVo5Ipet0XX8aZgo8p4Zs/UO8EjI4s/2ah9ZrJ2I5DtW9GEVsCX9nArOUeem0XMO31ig/Pu4+bP8Su5Ldh0pEMb3I/bJdPDUHmR/DCUadhwJtw0gPtjQI1Ih1UodOvsLxVPNXS4RJtFeMnHtJlWKO9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 LV3PR01MB8439.prod.exchangelabs.com (2603:10b6:408:1a2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Fri, 20 Oct 2023 22:46:40 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 22:46:40 +0000
Date:   Fri, 20 Oct 2023 15:45:24 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, ilkka@os.amperecomputing.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH 1/3] perf/arm-cmn: Fix DTC domain detection
In-Reply-To: <3076ee83d0554f6939fbb6ee49ab2bdb28d8c7ee.1697824215.git.robin.murphy@arm.com>
Message-ID: <f5881d86-eb14-a0da-b5f9-96a374a0bc7b@os.amperecomputing.com>
References: <cover.1697824215.git.robin.murphy@arm.com> <3076ee83d0554f6939fbb6ee49ab2bdb28d8c7ee.1697824215.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CY5PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:930:12::12) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|LV3PR01MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 476d08e8-9f70-47a0-42a9-08dbd1be6c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZA1Aqw+rAF16ecai2/mBTp2OVvj+RI1NO7GvQaHapaH4IyFV4oP3VWMM3j4IUcLcPY5BkgVz9m7JsBxhwxsubICNjwXS0ULCtEzVPVtp3O1+sLGxJbaTriINA++lXy1XLGRkTKTGyUM3k+gWNxdbvfMgn/6p4pX9sFQvS7ak79O599YFTs4lQu9/XX2mXnBG8YcZPg4424bRWNwdMEZFa8k0XKpDdyfj51tcFHVPXGYmIZumNCCfolpCC6CefaGmDG3Ur31hhNdSO27Jzou+wJpZqS9x8nPSMACzThcVFi9EpVx466165vdCsDD/ZkSzA2rQihvlkC1WmdI+YIKXQQlxuPRLc4GGPKf8POTWjUSVG4ieC9qiCzPbERKOyvnsaRU7mDygU+mSYt3uJOZDDRsZR6JhYM5fhIBzhCJpjIz1brvjdzOU2u+ZUNKGaG3C6HcrRr9SyKzWgdA8ZyknqYbxPXdDyLjh59LSKbKefTlUrEYhHLkSreminPkbgilwwBwlAXxZo7hgyA8MlcGWcOKRa2SF8xTDkfR3BVQY7FF8GGCf98G+pFu/DMFXl4F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(31686004)(38100700002)(6916009)(83380400001)(4326008)(8936002)(8676002)(66946007)(5660300002)(86362001)(2906002)(6506007)(6486002)(66556008)(478600001)(316002)(6666004)(31696002)(66476007)(2616005)(41300700001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h6JqadZw2evt1cMR8LbOMngE8utWUOfj/02bKvHUnB2rdl2oev8Qg1SkX7ZN?=
 =?us-ascii?Q?n1vAAAYvVtnVC+jeTmtXealf+DiX8ZcIvIFuh+fTk0l+A+m2cymR9W0b7sRD?=
 =?us-ascii?Q?3WWh0Id7lH9v6qWteQMmL/hbreQ3es8uzeKJYWiOiQHfEvWESL/F2Zy3qDXJ?=
 =?us-ascii?Q?oNuFTyldQqEBnWr49MoTIJMSdEV+Qn4hVKf4eJPsP4aWZvI/ecELuDDKiVBI?=
 =?us-ascii?Q?cgLJXCf6bClqw8ruEITROlLFAtmbr2ugseSI/HrZrLGHFvRY3PYI8X2++zw1?=
 =?us-ascii?Q?xCMckaHawrn4dSt0x1ro6JLlE9D5vlEB60hlZ9vx6dQvcnJuvj+83nJL+LuX?=
 =?us-ascii?Q?jPmn42TcyLRQxd9RBpiF2xbCBTFCGvVl2VWnp5TdWZVpVgreGLjZNaXpfAEZ?=
 =?us-ascii?Q?nmuXvlI/95JZK8adi/fdiTJB2z1JvTtXjc25VCVfzbL+/Abir+Gdyz5etEXZ?=
 =?us-ascii?Q?ovleeXwbWEBsj9MZC0qDEuHq1MlkxkqNk7Aa+6yF+T3Cn9KSddwLiNehAzx5?=
 =?us-ascii?Q?amc902IH7fqHqd2V/hUq2+YdUki3gZWs4JBxgy5Eja9XPBDACm0YyKpqCd39?=
 =?us-ascii?Q?pUuV74RdIPzmsPkFMReEY4CD3ihkfKxjnfk26tfJEnmJMXDAEkbMDgz0QQyR?=
 =?us-ascii?Q?LD8/dvk6Tb6aWGFhzNcgH4TpUBMoe4nCogXk+9yDScv/+HZ+NKAiDfCoRtbM?=
 =?us-ascii?Q?Us16B8nEZo/hSAu7SxdYqEOYz4n+lXwcouR/PLALd/NPVgLLqZRksn9+qCtW?=
 =?us-ascii?Q?B8o7XKqTIC7WxlW4TH1nDHiAm4P6/N4FpRr+mYMzzwy4/q4EvWLo5DOv3t2S?=
 =?us-ascii?Q?WJg0jjp9H4BgxpmwhGxh5DNssLMA/YDqlntDB55IhPzFoCtH0VMXqtmHEEFJ?=
 =?us-ascii?Q?+Ck9o65P0kvM8PpdOIu16RRLIalPYpr2Xb8RuXZtQO5/hGhKijHO8qdoqJm0?=
 =?us-ascii?Q?5D2Nt5zY/Tpv1ZYtT0uFYUOGtip2sasSTrf/e1OGu/LKNCkT/SRRjEYdkfcZ?=
 =?us-ascii?Q?TcX7IWNM0pj4eFRe4+ZzOVh4WYPV+i4KG5cORhKyMxRhxENlW17Gv6Ltm6gu?=
 =?us-ascii?Q?6UjRPDxEcNnQzt/qR5Bh7StwqiKHM/eCPnraWtxfVUG5sjes8dPZ7sMlkyjS?=
 =?us-ascii?Q?E41DC1nP0gC6oWeapf0sbpksClsCKTyPE3VmVw/L2LRe1kucS73vY0L4EY//?=
 =?us-ascii?Q?KHDTXFFAscbX5dCzWSh3n7ttfdISTqCLv60j564OaZvW1RioEpcB+dJC5rf4?=
 =?us-ascii?Q?dKpEOX6ESxqOvhudHAFwZCJCm9DVGScJyNbuYQxvsMbLPC9Goy7fmK8jfS0H?=
 =?us-ascii?Q?8lsS4+vcgcQljGa5sdk/nW6co9pN/d6Jn7hAS5HqEI6FAWQ99tQZ5miC2om7?=
 =?us-ascii?Q?qyB+k9Yajnxrchr3zdC/VjLWuvyTGVRst6sLzWoV8v+joU7q42W6TUtS28KH?=
 =?us-ascii?Q?GHa8UAXcnqqIVbCcBvqQv1imIbUGWZH1f7EtpNkNjlWGYrSpmnkdWg4vaKsb?=
 =?us-ascii?Q?jety9f3Jt9jRP4HtW/KFxf8LC2Kw6HvaoyIxnKqgdpTZnzQ8L7K8DbdzCUko?=
 =?us-ascii?Q?1k5smFoQQ/X8M9BcY7wIHHtSzsCQJO79ytGA+y6RUaX9TBabyzUnLPc708YO?=
 =?us-ascii?Q?QDh1kRVIieGSK56wlgoS2pA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476d08e8-9f70-47a0-42a9-08dbd1be6c26
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:46:40.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/I9l4m82bf/mWaVMM9GrqdmGlcDnAQNyCrGG/XFyZfUc2NQpObHomEFWMhZ6j+3O/qQxcIfU+bFgiZeSBDeHw2pV1xA2sS2Ob10I+/RXpwX1+8jaxHRJdHpmCEMAUAO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8439
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Oct 2023, Robin Murphy wrote:
> It transpires that dtm_unit_info is another register which got shuffled
> in CMN-700 without me noticing. Fix that in a way which also proactively
> fixes the fragile laziness of its consumer, just in case any further
> fields ever get added alongside dtc_domain.
>
> Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
> drivers/perf/arm-cmn.c | 16 ++++++++++++++--
> 1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 913dc04b3a40..f1ac8d0cdb3b 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -112,7 +112,9 @@
>
> #define CMN_DTM_PMEVCNTSR		0x240
>
> -#define CMN_DTM_UNIT_INFO		0x0910
> +#define CMN650_DTM_UNIT_INFO		0x0910
> +#define CMN_DTM_UNIT_INFO		0x0960
> +#define CMN_DTM_UNIT_INFO_DTC_DOMAIN	GENMASK_ULL(1, 0)
>
> #define CMN_DTM_NUM_COUNTERS		4
> /* Want more local counters? Why not replicate the whole DTM! Ugh... */
> @@ -2117,6 +2119,16 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
> 	return 0;
> }
>
> +static unsigned int arm_cmn_dtc_domain(struct arm_cmn *cmn, void __iomem *xp_region)
> +{
> +	int offset = CMN_DTM_UNIT_INFO;
> +
> +	if (cmn->part == PART_CMN650 || cmn->part == PART_CI700)
> +		offset = CMN650_DTM_UNIT_INFO;
> +
> +	return FIELD_GET(CMN_DTM_UNIT_INFO_DTC_DOMAIN, readl_relaxed(xp_region + offset));
> +}
> +
> static void arm_cmn_init_node_info(struct arm_cmn *cmn, u32 offset, struct arm_cmn_node *node)
> {
> 	int level;
> @@ -2248,7 +2260,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 		if (cmn->part == PART_CMN600)
> 			xp->dtc = 0xf;
> 		else
> -			xp->dtc = 1 << readl_relaxed(xp_region + CMN_DTM_UNIT_INFO);
> +			xp->dtc = 1 << arm_cmn_dtc_domain(cmn, xp_region);
>
> 		xp->dtm = dtm - cmn->dtms;
> 		arm_cmn_init_dtm(dtm++, xp, 0);
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
