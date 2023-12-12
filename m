Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A16B80EEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376825AbjLLOdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376799AbjLLOdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:33:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610BAAC;
        Tue, 12 Dec 2023 06:33:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RugaIJphZBrKRamzImY/gj9MB9BHJKXCgnf6/EcrcmLRcwfKzhRTGe5DOXPyNSkNeV927OLB6OrMP9VYgz57936wiEz2vrjP0lqwa9IaYObdkMT/hXDsXwSIxqdOK446Loth/Hqvf6vUQ1Z9bHunlAmMj2rXVhZdTm/VdWcXH3b2uom+d6el1QYf1p/cFFWrP/wCkmKilYJbY9tN8WdLSDG+mZYI1V6bhS6xQ027Y5N3bnRM9rleaEeOqEBvmU5VOxdC0aBB2YO3D7vbdVef5KZTBJXmLsz+ZaetdcRk/mGfYW1f4YM7izLuhuuzTxUQDmkNZazZa9B2NxjaaWznJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1WisNiEhQ7jAF7jVHZt8GzMHFYzu7qWDyBCGEJKM4c=;
 b=nM53GkySeLfUCPQmlGJxlJhg946WoK6a251soMpHJf7V5fC3F6PdFtzV4vw84J4TyRbg3HcO29DuwcamwYsSDYfH84hDdmJg7Qgiq062k/wL9edckNcPDLsOvqnahZLgQZHghwihZo27Fo50XwCo3pQhR7l9Mt2D3kGwP5a5ZwpO80+b/8wgBTJjNVPwit7qucC1bRbPh18O6cKFFff0TxFOIjiPwtTnH2TAk0DlbFIEW+ctQQ9Yk9NSX6B6h/Sh2m6q2NHYhV/5Ln5JkHcXK3hUuYWU5yHMHWuPCAZhXV23jYask96ffolAyotomWaO1vrxbL3lB748aAuPpyGdGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1WisNiEhQ7jAF7jVHZt8GzMHFYzu7qWDyBCGEJKM4c=;
 b=OQdVpi3DssbHvnYtxiDwJonnK/SoDRNdYJr46X0xKijuuvjygwNRRS4qhGPQD84I5rz3w2qfWUC2zvAFSYiaPS9STShVO2VChaguZAsgXTlmH6PwgFSy7ZHkft6Q9QIR7a45BqSdZNieZJrtvymgu1WDu8mDKDGR6b13eHBbLOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 14:33:46 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 14:33:46 +0000
Message-ID: <a3305a97-4936-4cfd-b706-10b7792acdad@amd.com>
Date:   Tue, 12 Dec 2023 09:33:44 -0500
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        avadhut.naik@amd.com, john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
 <20231212132907.GJZXhgIyss9eT1MsNb@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231212132907.GJZXhgIyss9eT1MsNb@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:408:94::18) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 122a9bc8-56f2-4157-8e7d-08dbfb1f5971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzXDxUW7sqexoBltvf5ZTn0oGHW9X9E0UXVj1QvOuHEkmw/1cXT6k4gVNc+W08WcVUaT971WMBMSbuxFKg9/tt73K3XnM+lUzkMeD2ysQWKUjUJEbyBAsZLx8cJxfHTG5tz2AqpHxcaQugARsmkFDxPUcLuZ8QvCxRpBC5xHUbzfS2SNLFwxzkevWqKBuSMvd/foEkFYxedpCRG50rro1viFnNwgI1PRLj3IuLLEZE17AjZOE5ZKQPkqt41Rx13xcFoRCNQ3BQRdOYaqsCuFPg8fkvCsxZyehJLCW6uYqLb8cY3j/AIPltQA80ENqmKC7QFiNgylIUXrZnd+U8PZqy1LLkghUxSA0fht/pZGuc9m91PeTcoxvg3h79P+xWVgbCBA9z0JVab1nwrQU+udTyfCVPZdzGhu1aiz84vUgcHX3wFyiNU0AGE2glYijiqKadJdxtmEfCJSSZA0xdWFkI1SzMezzZfkAZJ6ziiK58aMm++Kw+4fBMeGEKubhG+1DxYzxUjjiuid7TSdQLO01ZDEIynFGkM8bYHybhxpZKO+01DpggihOw4kl1BTR0q8El+pHbVuUeat5Rjw2HHtIckJ9YjwXzJ+Ou+YcQzUXJOG6fAIQCdODDhtaVw9JOTFHUlliL+s8MZxw4xUAqjDPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(53546011)(31686004)(36756003)(478600001)(2616005)(66946007)(66476007)(66556008)(26005)(6486002)(6916009)(316002)(83380400001)(44832011)(6512007)(4326008)(8936002)(8676002)(2906002)(5660300002)(41300700001)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0k0enMrQ1pINXNjbWd1NFFNV0lTRTNJS0NoTjhFMi9KRFJycnEzbVhxajBD?=
 =?utf-8?B?bGd1SEpZcENpWXJzc2o1Z0taTm5iOURkZ1BYZFNFT2pRK1JWLy9YMjE3MDR1?=
 =?utf-8?B?NkdTYTVjUHNBcG9TbURpSFJENklCcHo2WEI3Vys2OHRsd203NXQrZ25mSUVn?=
 =?utf-8?B?c05IYnZwaWtNK2Jkb0JKTE9naUdYRVlIajVvSVg2TkhKU2g0NDlKM0ZDQk1j?=
 =?utf-8?B?YWdwb0MyeDBIdkJjbm5kSDlmMzRWbW1yTFFoVjlsaTRCZjcyR3l2cXBuSXFD?=
 =?utf-8?B?TVU2Rkd5V1VCV1V0OXpOTFNwNkQ5cURuMENVc050cnlBRkRBdUJmSWVUZEx3?=
 =?utf-8?B?YUtPbW04Zkw0NUVyZjQzU3dDTVEwUVJxaHpsV0REU2dtTnZ2VDRISmlIUVE5?=
 =?utf-8?B?MEdGditndE5yZjRBN2NUTEYwSDZKR096d1ZZTlcwenp4T0hiM0R4MlQxbjVk?=
 =?utf-8?B?Wlp5L0RkNWJkb2UvWkZTTUxXbEpqYzZha25BQWtZUHlWTlEyL2xHcCtUVlFs?=
 =?utf-8?B?NVdGWDVIMEhoYVV1Zm5aNm1sa2ZTOGREeWVLYytwdXFGTW0wbitudjcyUzU0?=
 =?utf-8?B?WGJJY0dsMnlqQ1NaTkhGOHphLzlTejI3MXFiSDFydzZxZ2M4U2owWXMrRXhZ?=
 =?utf-8?B?NGVHbnhULzJLRFNRTHpsU0RMOHBzWU5LUmd4dlNmTmtuaElGU2xiaVpvZzZo?=
 =?utf-8?B?bjIvY1Q4SUFwM1JTTHRqRFVrRGx3WXZqckR4NnlabVFoWXp0U2ZHK1F3ME5I?=
 =?utf-8?B?MkNORHJvemFBVU9majZ5cXY1VUs0M3E2eHlia0ZvbDRmWENJV1lSUUdmUS9K?=
 =?utf-8?B?Q1JZTjNtcTR3K3dLMHh1Z3NPN2E5cE96aE1DUTBQZU1nM0pDYkxTUFl5UGw4?=
 =?utf-8?B?SWR1TVRkUCs4M2l4dTV2MWtFamVEbFZRaW5tRmdicDkvTjJCbVM5aXhsdGlO?=
 =?utf-8?B?RVpTUnJBSzRTWEF2dldJSHlUUWZYTS9jcnVVWVhxcnFndnBUNGFEMmpQOVZ6?=
 =?utf-8?B?MTA5Ly80ckpQcGx1YnRMMXZTSzJJYUt5Q0NpamZHNURMNzI3OU9odFNiTERJ?=
 =?utf-8?B?RTEwNHRxWGI4amVWWVBWNEVBUUFTZGhadjNQOGRwc3R5REJmMEcxUE5YRHE1?=
 =?utf-8?B?NmxQMjA3QjN0NCtuU0ZCU0s0dVAxdnhaV1NBVzQ3SkIvT3E4U2g2OWJpOVM1?=
 =?utf-8?B?KzRUY2JrdW5od1JUbmIzMmZac0luRkVCR1lUZXRSNmJadXJhVXltY1hRZjNZ?=
 =?utf-8?B?WS9PcjFjUXRQelRwckRCald2Wko4UnZqcWk5ZFhHU0V4WEpKUnRVQ3NVNzFL?=
 =?utf-8?B?OHFUdllDd2x1Umx1OWJCS0JyMUJERXc5UkV3ai9HZkJOV3Z1a0ZWdUVnUSti?=
 =?utf-8?B?UExtWmlrQ2VsWk1ObVo2dGdTZzR0Q2FqYk92eTdBcE1RZ2FudWJpdVBaS240?=
 =?utf-8?B?SlhPUklYMUlVdldQN3krV1dFN1ZVTW5YUFRXL09vVmNnTFNYRDdDWjJYWHE2?=
 =?utf-8?B?RmtneTBpZXhBa3owR3FkejYxTjBCWnRWNDIvempVbFY5eUpZTkd1YVNMTG9i?=
 =?utf-8?B?bTdnK0JXTnYxcVdRNkxnUElnZi9mY29rMlYxKzNIWkp6TStqVUFhVEVIckNU?=
 =?utf-8?B?MElRK3pQQVltRld2YlUrRWlhRGZBQzZMU25RM1c3WXU2S2poMVgwTDdHUzBK?=
 =?utf-8?B?cVlFd1RVRjVGOTZndVBwTGwvT3BwS2JQaWI3ekxWQ0VYdFU0eEJlUnhoNVVi?=
 =?utf-8?B?cWkwYVpQVnhXNjczTWV0eU9ubDNmWVV5VEM3UWUvZlFyMXY2VHB6V3czYWRC?=
 =?utf-8?B?S0NXS3RUbmN4MktiUmIrRmc2c3lFTVQ0WVNhcjByRUk0MDdZRGQwYWF5T0t5?=
 =?utf-8?B?b09HSy95Y1RmR0JGWWl1TEZTOThaYkRGb2dHY0lvcEFha3VMZkdEWlhVWG9Q?=
 =?utf-8?B?YmRYMnd2VTZPY2ZWRFFVRDZWdUErTmZtVGlybUpnbkp5QlhBN1BuVzdXUzVY?=
 =?utf-8?B?cUNnUDJIM2prUElSd0FRRjNvZlkzSU5Qc3Z0YSs4ZDJjd1JuQ3B6VVBZcWRJ?=
 =?utf-8?B?ZEpZRVNpVEtxaWtlbHBtbjRuREJCRVA1WCthRTEyOFFYRWQ1TktvbytXdnB3?=
 =?utf-8?Q?5ORFJB4cRAlMQK8rI8VAXdnqz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122a9bc8-56f2-4157-8e7d-08dbfb1f5971
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:33:46.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjDimIE+XDWI6TgJ7Yzh7nmExr2rmrA/tcawtOSRFgUJtXXNG6JgbwVQFKYRdpx7KK55QYR/ihItxWNGt3JirQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 8:29 AM, Borislav Petkov wrote:
> On Sun, Dec 10, 2023 at 01:49:30PM -0600, Yazen Ghannam wrote:
>> diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
>> new file mode 100644
>> index 000000000000..84fe9793694e
>> --- /dev/null
>> +++ b/drivers/ras/amd/atl/dehash.c
>> @@ -0,0 +1,446 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * AMD Address Translation Library
>> + *
>> + * dehash.c : Functions to account for hashing bits
>> + *
>> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
>> + */
>> +
>> +#include "internal.h"
>> +
>> +static inline bool assert_intlv_bit(struct addr_ctx *ctx, u8 bit1, u8 bit2)
>> +{
>> +	if (ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)
>> +		return false;
>> +
>> +	warn_on_assert("%s: Invalid interleave bit: %u",
>> +		       __func__, ctx->map.intlv_bit_pos);
>> +
>> +	return true;
>> +}
>> +
>> +static inline bool assert_num_intlv_dies(struct addr_ctx *ctx, u8 num_intlv_dies)
>> +{
>> +	if (ctx->map.num_intlv_dies <= num_intlv_dies)
>> +		return false;
>> +
>> +	warn_on_assert("%s: Invalid number of interleave dies: %u",
>> +		       __func__, ctx->map.num_intlv_dies);
>> +
>> +	return true;
>> +}
>> +
>> +static inline bool assert_num_intlv_sockets(struct addr_ctx *ctx, u8 num_intlv_sockets)
>> +{
>> +	if (ctx->map.num_intlv_sockets <= num_intlv_sockets)
>> +		return false;
>> +
>> +	warn_on_assert("%s: Invalid number of interleave sockets: %u",
>> +		       __func__, ctx->map.num_intlv_sockets);
>> +
>> +	return true;
>> +}
>> +
>> +static int df2_dehash_addr(struct addr_ctx *ctx)
>> +{
>> +	u8 hashed_bit, intlv_bit, intlv_bit_pos;
>> +
>> +	/* Assert that interleave bit is 8 or 9. */
>> +	if (assert_intlv_bit(ctx, 8, 9))
>> +		return -EINVAL;
> 
> You don't need those homegrown assertions. Instead, you do this:
> 
> diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
> index 84fe9793694e..11634001702e 100644
> --- a/drivers/ras/amd/atl/dehash.c
> +++ b/drivers/ras/amd/atl/dehash.c
> @@ -47,10 +47,12 @@ static inline bool assert_num_intlv_sockets(struct addr_ctx *ctx, u8 num_intlv_s
>   
>   static int df2_dehash_addr(struct addr_ctx *ctx)
>   {
> -	u8 hashed_bit, intlv_bit, intlv_bit_pos;
> +	u8 hashed_bit, intlv_bit;
> +	u8 intlv_bit_pos = ctx->map.intlv_bit_pos;
>   
>   	/* Assert that interleave bit is 8 or 9. */
> -	if (assert_intlv_bit(ctx, 8, 9))
> +	if (WARN(intlv_bit_pos != 8 && intlv_bit_pos != 9,
> +		 "Invalid interleave bit: %u\n", intlv_bit_pos))
>   		return -EINVAL;
>   
>   	/* Assert that die and socket interleaving are disabled. */
> @@ -60,7 +62,6 @@ static int df2_dehash_addr(struct addr_ctx *ctx)
>   	if (assert_num_intlv_sockets(ctx, 1))
>   		return -EINVAL;
>   
> -	intlv_bit_pos = ctx->map.intlv_bit_pos;
>   	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
>   
>   	hashed_bit = intlv_bit;
> 
> and so on for the other two.

That's mostly how it was in the previous revision. Should I go back to 
that then?

> 
>> +	/* Assert that die and socket interleaving are disabled. */
>> +	if (assert_num_intlv_dies(ctx, 1))
>> +		return -EINVAL;
>> +
>> +	if (assert_num_intlv_sockets(ctx, 1))
>> +		return -EINVAL;
>> +
>> +	intlv_bit_pos = ctx->map.intlv_bit_pos;
>> +	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
> 
> Can we keep it simple please?
> 
> 	intlv_bit = !!(BIT_ULL(intlv_bit_pos) & ctx->ret_addr);
> 
> That atl_get_bit() is not necessary.

Okay, will change.

> 
>> +	hashed_bit = intlv_bit;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(12), ctx->ret_addr);
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(18), ctx->ret_addr);
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr);
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr);
>> +
>> +	if (hashed_bit != intlv_bit)
>> +		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
>> +
>> +	return 0;
>> +}
> 
> <---
> 

Ack

>> +static int df3_dehash_addr(struct addr_ctx *ctx)
>> +{
>> +	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
>> +	u8 hashed_bit, intlv_bit, intlv_bit_pos;
>> +
>> +	/* Assert that interleave bit is 8 or 9. */
>> +	if (assert_intlv_bit(ctx, 8, 9))
>> +		return -EINVAL;
>> +
>> +	/* Assert that die and socket interleaving are disabled. */
>> +	if (assert_num_intlv_dies(ctx, 1))
>> +		return -EINVAL;
>> +
>> +	if (assert_num_intlv_sockets(ctx, 1))
>> +		return -EINVAL;
> 
> Those assertions keep repeating. Extract them into a separate function
> which you call from every *dehash_addr function?
> 

Okay, can do. This can drop the assert_*() helpers like the comments above.

>> +	hash_ctl_64k	= FIELD_GET(DF3_HASH_CTL_64K, ctx->map.ctl);
>> +	hash_ctl_2M	= FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
>> +	hash_ctl_1G	= FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);
> 
> I believe without the tabs looks good too:
> 
>          hash_ctl_64k = FIELD_GET(DF3_HASH_CTL_64K, ctx->map.ctl);
>          hash_ctl_2M  = FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
>          hash_ctl_1G  = FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);
> 

Okay.

>> +	intlv_bit_pos = ctx->map.intlv_bit_pos;
>> +	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
>> +
>> +	hashed_bit = intlv_bit;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(14), ctx->ret_addr);
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(18), ctx->ret_addr) & hash_ctl_64k;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(23), ctx->ret_addr) & hash_ctl_2M;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(32), ctx->ret_addr) & hash_ctl_1G;
>> +
>> +	if (hashed_bit != intlv_bit)
>> +		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
>> +
>> +	/* Calculation complete for 2 channels. Continue for 4 and 8 channels. */
>> +	if (ctx->map.intlv_mode == DF3_COD4_2CHAN_HASH)
>> +		return 0;
>> +
>> +	intlv_bit = FIELD_GET(BIT_ULL(12), ctx->ret_addr);
>> +
>> +	hashed_bit = intlv_bit;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(16), ctx->ret_addr) & hash_ctl_64k;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr) & hash_ctl_2M;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr) & hash_ctl_1G;
>> +
>> +	if (hashed_bit != intlv_bit)
>> +		ctx->ret_addr ^= BIT_ULL(12);
>> +
>> +	/* Calculation complete for 4 channels. Continue for 8 channels. */
>> +	if (ctx->map.intlv_mode == DF3_COD2_4CHAN_HASH)
>> +		return 0;
>> +
>> +	intlv_bit = FIELD_GET(BIT_ULL(13), ctx->ret_addr);
>> +
>> +	hashed_bit = intlv_bit;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(17), ctx->ret_addr) & hash_ctl_64k;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(22), ctx->ret_addr) & hash_ctl_2M;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(31), ctx->ret_addr) & hash_ctl_1G;
>> +
>> +	if (hashed_bit != intlv_bit)
>> +		ctx->ret_addr ^= BIT_ULL(13);
>> +
>> +	return 0;
>> +}
> 
> Also, same comments about this function as for df2_dehash_addr(). Below
> too.
> 

Okay.

>> +
>> +static int df3_6chan_dehash_addr(struct addr_ctx *ctx)
>> +{
>> +	u8 intlv_bit_pos = ctx->map.intlv_bit_pos;
>> +	u8 hashed_bit, intlv_bit, num_intlv_bits;
>> +	bool hash_ctl_2M, hash_ctl_1G;
>> +
>> +	if (ctx->map.intlv_mode != DF3_6CHAN) {
>> +		warn_on_bad_intlv_mode(ctx);
>> +		return -EINVAL;
>> +	}
>> +
>> +	num_intlv_bits = ilog2(ctx->map.num_intlv_chan) + 1;
>> +
>> +	hash_ctl_2M	= FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
>> +	hash_ctl_1G	= FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);
>> +
>> +	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
>> +
>> +	hashed_bit = intlv_bit;
>> +	hashed_bit ^= atl_get_bit((intlv_bit_pos + num_intlv_bits), ctx->ret_addr);
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(23), ctx->ret_addr) & hash_ctl_2M;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(32), ctx->ret_addr) & hash_ctl_1G;
>> +
>> +	if (hashed_bit != intlv_bit)
>> +		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
>> +
>> +	intlv_bit_pos++;
>> +	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
>> +
>> +	hashed_bit = intlv_bit;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr) & hash_ctl_2M;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr) & hash_ctl_1G;
>> +
>> +	if (hashed_bit != intlv_bit)
>> +		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
>> +
>> +	intlv_bit_pos++;
>> +	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
>> +
>> +	hashed_bit = intlv_bit;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(22), ctx->ret_addr) & hash_ctl_2M;
>> +	hashed_bit ^= FIELD_GET(BIT_ULL(31), ctx->ret_addr) & hash_ctl_1G;
>> +
>> +	if (hashed_bit != intlv_bit)
>> +		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
>> +
>> +	return 0;
>> +}
> 
> ...
> 

Thanks,
Yazen
