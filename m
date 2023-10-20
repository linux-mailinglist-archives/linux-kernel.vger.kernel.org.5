Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B4C7D1971
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjJTXBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTXBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:01:11 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2099.outbound.protection.outlook.com [40.107.95.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D3BD6A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 16:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTEz2zzr3nzUn+kHO+o2qFAt1D+byQBWfTBTkGtar3UHZRlb4k1jyUH7BuNoANPt6EVOhkXg+6zo911eVb6BQCGxIlX+x1L71aRizzhJ0Gk5uGRT+bxZF4ouORjgTBzb0fpwbDUvJ4JgzLruFM2xlkjTEM5r4mGA1KG3TXljC/ZRc6+qrj2nZZ3m8LWMYIjahVoYR9A88mFjXMQRk0gkDzB9irY2kIv/h/6EVk0c4SF2Jlqw4CNiQ6qqcPHzMoMcntcNUJxdWfU73Ppu6eSdIvjLwOiBYOy5AXXccuf7SvrVXW9OYyqhhQr5ZOQuQbhhXYVoj97KqoFEoJVydynB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTtiO/7t/djOr2GBKp+C8LLp7CC2WjSfaECM92SF7LM=;
 b=I/TToC1eTN2sRu/sS4ewk7uUQmvG5P/eNLzwoj9/QC7uEudlOETrsi3iTESrXqHURoFQ4ecgnr5lrEFUE9idhQNHj3c0a7UnXQ1gwwmpdtOqAUGbQQyB89p0l6Z3g4bgzOmxLBP/RFy7wNK08v24/ARUunB5VdDwn95bYFxjbF8EklNY67rkLFKa2mc/VVGb8J3I+sNknSA+RX7owcDU8tbnIVO6mUDHEUEIYlIcvrIwlJtdoDCsCR2kg0mVuryLT7cM0RK70Y9YE/js5DloFPPDLi1Smmy0h7L83wD5cuv/SOOW8stfhzEFrkytrIzQ0ZNrSYj1cU9GG8wV9Qdn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTtiO/7t/djOr2GBKp+C8LLp7CC2WjSfaECM92SF7LM=;
 b=nlPkqvoXbyNJ0Kntfrq0H1cU5H9EXx3WizsXMCKeBN2BqKYTSLCbEIC34k957B4hI9Y7rfcp4bAWetBGczh/EfOvXzl0jJFrbobyGUKdnJ3lPwUYI5z38avuQ1AVThaxmOQWKfqoaHfIVyYBrlNPw71upZER4v+aiT8FPk0bw84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO1PR01MB6792.prod.exchangelabs.com (2603:10b6:303:d5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.27; Fri, 20 Oct 2023 23:01:03 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 23:01:03 +0000
Date:   Fri, 20 Oct 2023 16:00:37 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, ilkka@os.amperecomputing.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH 3/3] perf/arm-cmn: Enable per-DTC counter allocation
In-Reply-To: <849f65566582cb102c6d0843d0f26e231180f8ac.1697824215.git.robin.murphy@arm.com>
Message-ID: <fa35f25b-2db8-daa1-1817-3ac256fc27ec@os.amperecomputing.com>
References: <cover.1697824215.git.robin.murphy@arm.com> <849f65566582cb102c6d0843d0f26e231180f8ac.1697824215.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH5P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::14) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CO1PR01MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: e049947c-c5bd-4ec2-73b9-08dbd1c06f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eCJbScBwCBcWV3rGBJgx/GyHPjcbsE4b2NGkcanadkx38ZksMxzWzYYsMTIgywCSprRxwg9EynauFAL1jY2xNZsS/3vC0+ibYxo0lXMow10XFamAKYI5b7nclauZm9WgDeeZzlfrTcciXGkO+ouLkarbPGog+JjgtkrYt0fIiJZw9HLTRJM9Vo4UtKUo1a+3AVjRdp4D8HRPa6j6lPjpUf3c2/dh02G/B+dfVHLQsnAb6WMy6ldncc3xpkUe0Jv6GBI8FF2uIAGQ936ntfhR0TNMtEcLx88VHn47W3hzngB8n8OnwK6L9TT7JGmUtjx8v020mrFFwBepES81QGRCet9AJNOenkk68nKLwND7l+Y+dig46+TtZVSwMf9/obZuMNY3ZImPTrb7GFsv4Gcu2Hyjg6JhHAnxRD41zB36L4asSib/HZnQRxxFMAf3D2SjoaakRpll6tnQ3nfpLk+emyXEIweDXacPc0J9ogOwXuueigKzROqp7pDxnHIXO0IjULIEzRwDMj/ZtyzYo1HIR3/osEXRA/5lEeSX52/o4RhB70zGErsXWAzHacnuzx3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(6666004)(4326008)(8936002)(5660300002)(8676002)(41300700001)(83380400001)(26005)(6506007)(6512007)(2906002)(38100700002)(2616005)(31696002)(86362001)(66556008)(66946007)(66476007)(478600001)(6916009)(6486002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0gFFkd7ppf0yJdSAQHMZidXlyEeYIk4LNERjH6TPEAltITw0f0TwU//HLW5B?=
 =?us-ascii?Q?vgkH11U6ad9Rlpl7GFxt/SUxJmxM0EvdMYDOGy6r3MGZIXL6eiO2WTwIeACt?=
 =?us-ascii?Q?xC8GTpTjIX73GVUcnqwWpEulRB1KRXBbJPTPCbuy0Kh0GZclHLL+FsR1m2XJ?=
 =?us-ascii?Q?WaI2LpXbYbyoVkQAhik6hH+bq5Q0+/23EwE75QYDACnI891pncdw37xoVpmC?=
 =?us-ascii?Q?hdHIZOGWsevGFN0o4F9Mkv1OdeO311Q4Y83EqVo/Gs2Y+qppHODeCVcx8xD9?=
 =?us-ascii?Q?anBF+kZIAStyBDOhruiEnQiCb0fJOMx6QsQ8gvMahyqJanTEYk2EiiEwQtpy?=
 =?us-ascii?Q?BqZd+ivFHbXcshM/e0Q85scktW/KSnULdzNcx3Y6WakuKbJSfR2uYYZg8szh?=
 =?us-ascii?Q?tMSgssLdQNuSzl65lpVtVNaaon7kHHoo3Uf8cQGXJS2Hg7da6wfB06YB0/fB?=
 =?us-ascii?Q?JitAz6JMNvzeBu+rn7ETscIhWgIW5Suwg4uwZ1GCwCD2rBqiQX37dt0rjjFf?=
 =?us-ascii?Q?hA7N//N9WXF2ielExd+R9eEvmu4uf0KZBbI7HrNUgWQ/V4Og4ionS7CizPBe?=
 =?us-ascii?Q?uI2/cZK3vC9Wd5lOnvOJOC3hwfQgqdU2yC3ghYAwruhIUEbbERPXJr8RR1WT?=
 =?us-ascii?Q?SuNEbISAVh+rYsVVl9I7eZjLOIVXxAMAxxLwGmx4Y5t+tGKzLWvtpyq2q4di?=
 =?us-ascii?Q?N7561Zee5KpnBoNnDhyx2MG4AP5Q1tEt6uqpMwDt2Kf2G521KO6ftD3QTmiY?=
 =?us-ascii?Q?zUmKEx9ftyCoGOBgSsB10LweaEHEOAYaQNvGCsp4zqDgF5G/t26MWjyoFYDE?=
 =?us-ascii?Q?W49+mk1YRfeXnBoXiKH10Ai9jjOdS9mw+6Ho7BQq59gFBaazBXI7/tMZeIT1?=
 =?us-ascii?Q?lW9q9rbrxgb3TRdXVpGyl2NTT0SGGllIky4EAN70F07Ze9hfAeb0AQTXjSCR?=
 =?us-ascii?Q?lbWdLtOAiszGqXb6mD7qeCYayvXEdGDiQzMRlOcndaPTW3bJNjM5YaYUFkz3?=
 =?us-ascii?Q?BeedvDUOK5cPWrziMR/FDh8rTAH9ev1dY9t0qMWgjyZCRDk6YFe65We0m2n5?=
 =?us-ascii?Q?xsFC2vkLqwQ8m3F0WnB/+mei5snKr8LRiinqvWj4WpZ8XW5K+3K+nEYBWPqH?=
 =?us-ascii?Q?4SRCSqp6UirPE2vGaOr20y5FhwkvnAhCDDoQD9RgUmZVBp8av9TJSbzYvz0I?=
 =?us-ascii?Q?qEB6sv/4tNBxkSz1Qs9VGHLm6cFQm4XZC9wZqcv0+x32K6Nuikz9kFxwX3Q4?=
 =?us-ascii?Q?MgqClqTSEjjKUKUJIGqWFOk5246PL3jQEcwLX6fwEa62+Rc5D/S0kVvhT870?=
 =?us-ascii?Q?T23wk84cOf36nB7zlm42Sag4AzGCwYhgfEgg/oz631tOOnG7iWVedUHQi5zB?=
 =?us-ascii?Q?flB42PYKHHXIPFGfe1mTIJ473A0wVaTJ9NeqXNRr1w7WJf1S400gLfO3g+/j?=
 =?us-ascii?Q?a56+o0nYg/PYhJsPH83KukC0xbaR5mT2sqL55SMLrV5NvoJYUfVEsAjsesE+?=
 =?us-ascii?Q?Q8rAoHjKkVP67gNLlicOCJ6FSm7Lp0+wJZi9biB2g+AElCUkuBhvR5Wey9eU?=
 =?us-ascii?Q?9dnBErbLodn3uX9xPF1mbzvnbjRDNAXxRv0JjNBVbrfJdNoF8SCEQb6PhWFc?=
 =?us-ascii?Q?B4Mnja+MPf1R9uyu4KA9DTc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e049947c-c5bd-4ec2-73b9-08dbd1c06f47
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 23:01:03.4764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaSGzyOD2LU9uUt8jfbzT6GDEo1sBP1S6Z/foR7ZF1oCnJbkiPsLLGL452YbKl/sgaEghWcqFelatxKM5rCPVKU/029dBJJWvpsjOmtp6jxXucjnI7eTRY+xlbvL1J1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6792
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robin,

It seems that I somehow managed to reply to patch 2/3 second time with the 
comments that were supposed to be here... :(

On Fri, 20 Oct 2023, Robin Murphy wrote:
> Finally enable independent per-DTC-domain counter allocation, except on
> CMN-600 where we still need to cope with not knowing the domain topology
> and thus keep counter indices sychronised across domains. This allows
> users to simultaneously count up to 8 targeted events per domain, rather
> than 8 globally, for up to 4x wider coverage on maximum configurations.
>
> Even though this now looks deceptively simple, I stand by my previous
> assertion that it was a flippin' nightmare to implement; all the real
> head-scratchers are hidden in the foundations in the previous patch...
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks! I had that on my task list but never had time to start working on
it.

Reviewed-by: Ilkka Koskinen <ilkka at os.amperecomputing.com>

Cheers, Ilkka


> ---
> drivers/perf/arm-cmn.c | 18 ++++++++++--------
> 1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 675f1638013e..9479e919c063 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1570,7 +1570,7 @@ struct arm_cmn_val {
> 	u8 dtm_count[CMN_MAX_DTMS];
> 	u8 occupid[CMN_MAX_DTMS][SEL_MAX];
> 	u8 wp[CMN_MAX_DTMS][4];
> -	int dtc_count;
> +	int dtc_count[CMN_MAX_DTCS];
> 	bool cycles;
> };
>
> @@ -1591,7 +1591,8 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
> 		return;
> 	}
>
> -	val->dtc_count++;
> +	for_each_hw_dtc_idx(hw, dtc, idx)
> +		val->dtc_count[dtc]++;
>
> 	for_each_hw_dn(hw, dn, i) {
> 		int wp_idx, dtm = dn->dtm, sel = hw->filter_sel;
> @@ -1638,8 +1639,9 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
> 		goto done;
> 	}
>
> -	if (val->dtc_count == CMN_DT_NUM_COUNTERS)
> -		goto done;
> +	for (i = 0; i < CMN_MAX_DTCS; i++)
> +		if (val->dtc_count[i] == CMN_DT_NUM_COUNTERS)
> +			goto done;
>
> 	for_each_hw_dn(hw, dn, i) {
> 		int wp_idx, wp_cmb, dtm = dn->dtm, sel = hw->filter_sel;
> @@ -1806,9 +1808,9 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
> 		return 0;
> 	}
>
> -	/* Grab a free global counter first... */
> +	/* Grab the global counters first... */
> 	for_each_hw_dtc_idx(hw, j, idx) {
> -		if (j > 0) {
> +		if (cmn->part == PART_CMN600 && j > 0) {
> 			idx = hw->dtc_idx[0];
> 		} else {
> 			idx = 0;
> @@ -1819,10 +1821,10 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
> 		hw->dtc_idx[j] = idx;
> 	}
>
> -	/* ...then the local counters to feed it. */
> +	/* ...then the local counters to feed them */
> 	for_each_hw_dn(hw, dn, i) {
> 		struct arm_cmn_dtm *dtm = &cmn->dtms[dn->dtm] + hw->dtm_offset;
> -		unsigned int dtm_idx, shift, d = 0;
> +		unsigned int dtm_idx, shift, d = max_t(int, dn->dtc, 0);
> 		u64 reg;
>
> 		dtm_idx = 0;
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
