Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFCA80EE93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376575AbjLLOXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376447AbjLLOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:23:46 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D865999;
        Tue, 12 Dec 2023 06:23:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CADSziEZAqojyiNDtsrEeqWd2/k2GOcvJzcn69ezy7/VkCfAP0sTKpk8N3S5SjQKg02vJy3Fw2A3slHH2No6qjJTNsXLcNe2powRmI9yvPs+X6P395/6uTzCfNBE5BaRLMFTfentihozvMMF9ufg42ZZoo+Zt/Z7Dqd5ChcLw1HMOXtKEHwc67QBDe3INlU2vQ8CBGN9hwNW0UVANFuPekFDBTID7QroSmli3YRJDYogXiJsUXDpiKC0w6MYu0drHzmWGF2nLiYCuo4ykk8SY/up+1z7fTHrywZE+dB8uygGskGp+7UwcvqWgola2Q3puLPFF3HVeulLb3tiOFIhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOQtnEuHGVILp/LD/8I8fjCccO+cNlqns9klNNzhq+g=;
 b=mTX95nAoPdWXZ7TqmE3wGWL4amWbCOrMH84Y5ZPkO9FrFanxu9vTSquOzuNyLG1IE2cWwtOIJ+hRpdRR/WFRm5OWxp4bHm9n7OFV+OJL5CsWwY6iVhdqM+gpLY/kg1GLHqfw8yxlClAXvOVTnpuwlG1xkd3VSNReWcnQVP+QGunb3aRMTS+oB4La4WOj1x1uP9vLVmfqWPT9MOuKUmS9geL64Yg9G2RwKsBHY8D1ZRdkbH8XfiL5yiPpU0FQEVueG7taKcEaC2lpmPaMagt/Uh8rKhQQc3XU40VxlFjilAvRhmqBjrKh4XlJDirChafZuFS8PzFaNQXIEWkHsQuc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOQtnEuHGVILp/LD/8I8fjCccO+cNlqns9klNNzhq+g=;
 b=4F4ggFQzgJSTrpOov4Tp65G7XNRNjSE3YWw9ZtuaS+kpRI500a3srvVOt66vPu74shprWQKosu83dfFBV2qr/UuT1GOT+/MlJ7CqdqefW0FsumwitNsfaFqFT6BjGsxZ2qOoNRXftkqjmmZ1HGHsNVjWXek6/31cN1+9nvWuTtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 14:23:49 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 14:23:49 +0000
Message-ID: <295f3cc9-6140-4813-b107-8c8b60f8aaa1@amd.com>
Date:   Tue, 12 Dec 2023 09:23:44 -0500
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        avadhut.naik@amd.com, john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
To:     Borislav Petkov <bp@alien8.de>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
 <20231211195739.GIZXdps9DNvOgCR5Xs@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231211195739.GIZXdps9DNvOgCR5Xs@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 6359f670-8afa-4d4e-c5a2-08dbfb1df540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bbFWk+JpGi/GAIIVgl5/H4dJkbe3UslF/24aWSSDsBk8E6If74ZohcElSZZTurDImbt9rpEXovW+bbThvrDmKmnCxyJNZGmVngtPGFanQHEvZMurTUnWZ9VnprwZ2oV2sGX2GuHfMLF5Onlt0q/RdeRdmFDsarRC5PfJ9uOB/300TxrWMT0O6A08efQJSgd4+xTtxn991nMBNAyI12R3Ghqpo1fAwlnX8H58yEtn9gI6LKGxpncpVjBzXaT8YZJk9slYgSpYzr7ooqI6sN2Oisb3L8uZWEz00CSjEGur9jbAfsHJxbCu8W/a3XmGgoUswicC/IcIaE+tlG5A2UkuQS4CgWae64rNYXMIOKaxO8Fu3lr9jHFTIQWkJor6eH9R326oh3jNvlIiMUn+2a4Vk7rzTIAJMomGaOFwozCeSlWKGIeXQTEJ3xk4VB1/udqFpoGV7ImECbkt1brDmELvXFnFYGa4OAKMhqxNhhuAXGRrZvHToubMymUAFKpg47M7TrpvPoK74vd9IOHH5FepUL2wvPOUqLP46BX7Z1kKop7uzl2n1ffMvEi3N4s/AolTAP5m7XNpmCPdrEi8NO6bwcBogkcuq84QLObSCblkxAJeUx9TODV/Yyvojiqfr+NX7oZ/0RRryvhKBvbpyY/VMuzpbCKdvzjvfSEEBTXYFEA4FzEh+Sw2b8b2/EMGfD5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(8676002)(4326008)(44832011)(8936002)(2906002)(31686004)(6916009)(316002)(5660300002)(66476007)(66556008)(66946007)(478600001)(6486002)(26005)(36756003)(6506007)(6512007)(6666004)(53546011)(41300700001)(2616005)(83380400001)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxYTHI5ZTdQNytZdmJNYkJONzNMZUVIRXJRQ2Jrc3RxSldUNkwwQUt4djlm?=
 =?utf-8?B?MW5ZUmdieTlMOGk5Z245dkM0Z25IeEMvM1ZkcHBJMUthUTNkZU1HNGlEV0Z5?=
 =?utf-8?B?NGdIMjlacU5FeU9VRXprTkw1VUVHYWNGTDJ5eFFveUhPUlYrclBnK24vWStY?=
 =?utf-8?B?YWN6anluM050SU5xZGdrKzRkTDN1Q2cwNHIxUXRjakNEb3h0RFZ5S1d5bmcv?=
 =?utf-8?B?TjRhN01oTzRoc1NYQUMzWWlzS3RqU2VxTzQrY0JHcVU5ZUtKRWFQeVVtMDFO?=
 =?utf-8?B?THY1RWZkL0Z2c0M5ZGNHR05TOTI5dXl1dmdiYlZ3bkZ6YzdJYktoVlRXbG5u?=
 =?utf-8?B?UG9BclkzUG1PanA2ekZJVVRYSHB4NElmcUd2UTNEYitGdm9PemNVRkZrMjJz?=
 =?utf-8?B?M1hLVUV3cWJHNVVLR21FaTZMcVROTHFhNVFMTVJRMUN2K1NNV0Q0Y3ZrVWx2?=
 =?utf-8?B?MG1ieDNid1o0b1JTTGxpMVlldUNHU0cwRHV5UFQ1Y3JFclFoQVB4QUFISDhN?=
 =?utf-8?B?ejNWUmRJQU91VC9uZC9JS0ZRVXBsc0FibXYrc2owdWcyWTFFMDVvZ0hKN1ps?=
 =?utf-8?B?bC92dDJtS2Iyc1hrMUR6TUdZQ0hXQ1Zwam1SZSs4S1FHOEREZXBuVjhocHJh?=
 =?utf-8?B?SDl0NFRlK09NRHhxUkRzY3FYZ1JQUjJrc0R6UlUySGQ5KzU1bXFjMkhtSi9S?=
 =?utf-8?B?d01kenhtNnl1OXFnRXBqTytZM2RMajB4RTRobkoyMlgyZmh5M0EyZ0FUZHBS?=
 =?utf-8?B?aks2a29vdFUxMTZ6YXdNMFdRNm01R3FrWkdHTVVNZXpJRGo1KzdGTjdneGYz?=
 =?utf-8?B?b3F4WmZMQWhDNWlmRFVkN3J4NUZUd0xQekJ3Y0xjU0Q1MUtGOUJGbEhIR1pq?=
 =?utf-8?B?L2VDZHU0bEpXUWlzUHpFek9zbGFQUkkyMmZEM1hPSlZLM1RraWFxUGF6dzJL?=
 =?utf-8?B?ZmVjTm8vWUlmNFNtZW1JaCtVTVFEU3FycytrVHQrUjhKSTRnU0M0dWU4Qndi?=
 =?utf-8?B?dmVHL3krRFMrMnQyWlNNQUFUZUc0ekJhV0ttTTJXaVFmWnFYNTRyMktnTmRS?=
 =?utf-8?B?SEYweUxnV0RsQVN6VjdwY1plZS9QZVhPYVNPbU5jWlB3eVNrQlNINVhTeStm?=
 =?utf-8?B?NGVRU3F5cXdUOUJZNEhTRERyZTFULzlMdm0zVzJYMHV2c01zTmN1Mk9waHg2?=
 =?utf-8?B?aE5FcFhkdzVVVkVMTGpmZEc5WCs0cGpxaG1ySHB0VlJPbGdjdGROSGRMc2VG?=
 =?utf-8?B?QVdwU0VBb1JHLytoWTZaaWJGRzZEcjhZSjVjU1kwSVE5bWxDdnc0ME1pREZo?=
 =?utf-8?B?YlNZdFZtaGZNNUVnWEtzQnNRbCtVcUFxQnFaRjdkMHljUnlxOGpmWWMwbWZU?=
 =?utf-8?B?cUkwUXVBQTBPbXFrUk1ZQlBRQnczVXFpQmZQcUZJYnFOOGl3ci81eWtpMTJB?=
 =?utf-8?B?UlBtQ1pZODZGOWltQTlVWlJnM3FQZC9qTUo5cTdWeU9qZlhhWVN4SjBoZ1E5?=
 =?utf-8?B?SjRvakJSbFQ2b2huNXRISXlLSENHSXAxNVRicldTSU5zVUZ0MUNUWkJDOHRt?=
 =?utf-8?B?V1BVR251TjBwMnJpZlIwcU00VHozbTRObC9YckR5S05aVDBZQVA5aG1OZFFU?=
 =?utf-8?B?M3FQRFhEZHlrdXhqMFlNYjJpa3RRVW9EbURzdlRxek1rS29QaUhvdThhYXlN?=
 =?utf-8?B?ZE50a2YzN3U1L3hpVG5vL3lLVjFyMGd5SWo0V3NIR3FXQjRLZTEzM0phTFFw?=
 =?utf-8?B?ckI0RTI2UHpYYkhJcUJjbGV2b1U3S2hwdFJsL3AyVFRxTWZWaE02Q2lpMmtT?=
 =?utf-8?B?YUUwQ3RLdWVRVnNpT1RKVlZ1TW1rK3BxdjBUUHlUWThXZE5zWmprK2t5TmVt?=
 =?utf-8?B?eEdON1hscXIrZWZXUTlaNWZEZG1sUzZRVkpzS3pMU2JYYVU3YzdhekhwLy9M?=
 =?utf-8?B?N1o1N3FFeXIzMC95Ri9NNHd2aGZoQUdObGdNa3pXZitrU1luSlJOUjVFQjA5?=
 =?utf-8?B?MlZlNjcxMEZBa2IzbTlqY3VFUGZNaXBnMmNnbGJnUUlCMlNhS1JtN2g4V1dt?=
 =?utf-8?B?TUR4dUwrQ3hFTnFhWlp6cER2OHdFcDlrenU0a1RZaktGUmIya21MVklmYTZY?=
 =?utf-8?Q?/Va+LddjQY3H19hfwEd8mtp2j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6359f670-8afa-4d4e-c5a2-08dbfb1df540
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:23:49.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VCOgmM8PIgXg1lBda1XsRF2J6ovKznfiYwTV5INVqO538yWMme722+XHAFeYtIwizhPpiHZc95mqEcs9b4TlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2023 2:57 PM, Borislav Petkov wrote:
> On Sun, Dec 10, 2023 at 01:49:30PM -0600, Yazen Ghannam wrote:
>> diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
>> new file mode 100644
>> index 000000000000..6a6220fef81f
>> --- /dev/null
>> +++ b/drivers/ras/amd/atl/core.c
>> @@ -0,0 +1,217 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * AMD Address Translation Library
>> + *
>> + * core.c : Module init and base translation functions
>> + *
>> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <asm/cpu_device_id.h>
>> +
>> +#include "internal.h"
>> +
>> +struct df_config df_cfg __read_mostly;
>> +
>> +static int addr_over_limit(struct addr_ctx *ctx)
>> +{
>> +	u64 dram_limit_addr;
>> +
>> +	if (df_cfg.rev >= DF4)
>> +		dram_limit_addr  = FIELD_GET(DF4_DRAM_LIMIT_ADDR, ctx->map.limit);
>> +	else
>> +		dram_limit_addr  = FIELD_GET(DF2_DRAM_LIMIT_ADDR, ctx->map.limit);
> 
> One too many spaces before the '='.
> 

Ack

>> +
>> +	dram_limit_addr <<= DF_DRAM_BASE_LIMIT_LSB;
>> +	dram_limit_addr |= GENMASK(DF_DRAM_BASE_LIMIT_LSB - 1, 0);
>> +
>> +	/* Is calculated system address above DRAM limit address? */
>> +	if (ctx->ret_addr > dram_limit_addr) {
>> +		warn_on_assert("Calculated address (0x%016llx) > DRAM limit (0x%016llx)",
> 
> Hmm, where is the "assert" aspect of that macro?
> 

I'm thinking that the warning only happens if the "assert" condition 
above is hit.

> It looks to me more like atl_warn() type thing which you define for your
> driver to do special stuff.
> 

Right, that's what I was going for. I can rename/rework it.

> Also, are you sure you want to dump it here on every attempted SPA
> conversion?
> 
> I guess yes. I'm just worried that it might become too noisy but we'll
> fix it later if that turns out to be the case...
>

In older revisions, I had all these messages as "debug" loglevel. I 
don't think there's anything a user can do to fix these issues. They're 
either coding bugs in the library or system configuration.

I'd rather go back to the debug messages if you don't mind. It's not 
difficult to enable dynamic debug messages compared to DEBUG Kconfig 
options. So I think it'd be okay to work with users on this if they 
encounter an issue.

>> +			       ctx->ret_addr, dram_limit_addr);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static bool legacy_hole_en(struct addr_ctx *ctx)
>> +{
>> +	u32 reg = ctx->map.base;
>> +
>> +	if (df_cfg.rev >= DF4)
>> +		reg = ctx->map.ctl;
>> +
>> +	return FIELD_GET(DF_LEGACY_MMIO_HOLE_EN, reg);
>> +}
>> +
>> +static int add_legacy_hole(struct addr_ctx *ctx)
>> +{
>> +	u32 dram_hole_base;
>> +	u8 func = 0;
>> +
>> +	if (!legacy_hole_en(ctx))
>> +		return 0;
>> +
>> +	if (df_cfg.rev >= DF4)
>> +		func = 7;
>> +
>> +	if (df_indirect_read_broadcast(ctx->node_id, func, 0x104, &dram_hole_base))
>> +		return -EINVAL;
>> +
>> +	dram_hole_base &= DF_DRAM_HOLE_BASE_MASK;
>> +
>> +	if (ctx->ret_addr >= dram_hole_base)
>> +		ctx->ret_addr += (BIT_ULL(32) - dram_hole_base);
>> +
>> +	return 0;
>> +}
>> +
>> +static u64 get_base_addr(struct addr_ctx *ctx)
>> +{
>> +	u64 base_addr;
>> +
>> +	if (df_cfg.rev >= DF4)
>> +		base_addr = FIELD_GET(DF4_BASE_ADDR, ctx->map.base);
>> +	else
>> +		base_addr = FIELD_GET(DF2_BASE_ADDR, ctx->map.base);
>> +
>> +	return base_addr << DF_DRAM_BASE_LIMIT_LSB;
>> +}
>> +
>> +static int add_base_and_hole(struct addr_ctx *ctx)
>> +{
>> +	ctx->ret_addr += get_base_addr(ctx);
>> +
>> +	if (add_legacy_hole(ctx))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static bool late_hole_remove(struct addr_ctx *ctx)
>> +{
>> +	if (df_cfg.rev == DF3p5)
>> +		return true;
>> +
>> +	if (df_cfg.rev == DF4)
>> +		return true;
>> +
>> +	if (ctx->map.intlv_mode == DF3_6CHAN)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +int norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr)
> 								^^^^^^^^^
> 
> Can we not do that? Output function parameters.
> 
> Are all addr values valid or is there an invalid one - -1 for example
> - which you can use as an error value?
> 
> And then you can turn this into:
> 
> unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, unsigned long addr)
> 
> and callers can do IS_ERR_VALUE(ret) on the return value.
> 
> See include/linux/err.h
> 

Good idea. I'll look into it.

>> +{
>> +	struct addr_ctx ctx;
>> +
>> +	if (df_cfg.rev == UNKNOWN)
>> +		return -EINVAL;
>> +
>> +	memset(&ctx, 0, sizeof(ctx));
>> +
>> +	/* We start from the normalized address */
> 
> s/We start/Start/
> 

Ack

>> +	ctx.ret_addr = *addr;
>> +	ctx.inst_id = cs_inst_id;
>> +
>> +	ctx.inputs.norm_addr = *addr;
>> +	ctx.inputs.socket_id = socket_id;
>> +	ctx.inputs.die_id = die_id;
>> +	ctx.inputs.cs_inst_id = cs_inst_id;
>> +
>> +	if (determine_node_id(&ctx, socket_id, die_id))
>> +		return -EINVAL;
>> +
>> +	if (get_address_map(&ctx))
>> +		return -EINVAL;
>> +
>> +	if (denormalize_address(&ctx))
>> +		return -EINVAL;
>> +
>> +	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx))
>> +		return -EINVAL;
>> +
>> +	if (dehash_address(&ctx))
>> +		return -EINVAL;
>> +
>> +	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx))
>> +		return -EINVAL;
>> +
>> +	if (addr_over_limit(&ctx))
>> +		return -EINVAL;
>> +
>> +	*addr = ctx.ret_addr;
>> +	return 0;
>> +}
>> +
>> +static void check_for_legacy_df_access(void)
>> +{
>> +	/*
>> +	 * All Zen-based systems before Family 19h use the legacy
>> +	 * DF Indirect Access (FICAA/FICAD) offsets.
>> +	 */
>> +	if (boot_cpu_data.x86 < 0x19) {
>> +		df_cfg.flags.legacy_ficaa = true;
>> +		return;
>> +	}
>> +
>> +	/* All systems after Family 19h use the current offsets. */
>> +	if (boot_cpu_data.x86 > 0x19)
>> +		return;
>> +
>> +	/* Some Family 19h systems use the legacy offsets. */
>> +	switch (boot_cpu_data.x86_model) {
>> +	case 0x00 ... 0x0f:
>> +	case 0x20 ... 0x5f:
>> +	       df_cfg.flags.legacy_ficaa = true;
>> +	}
>> +}
>> +
>> +static const struct x86_cpu_id amd_atl_cpuids[] = {
>> +	X86_MATCH_FEATURE(X86_FEATURE_SMCA, NULL),
> 
> I'd expect for only this one to be needed, but not those below.
> 

Me too. Those below are to workaround a current module loading issue. 
I'll add a code comment for that.

>> +	X86_MATCH_FEATURE(X86_FEATURE_ZEN, NULL),
>> +	X86_MATCH_FEATURE(X86_FEATURE_ZEN2, NULL),
>> +	X86_MATCH_FEATURE(X86_FEATURE_ZEN3, NULL),
>> +	X86_MATCH_FEATURE(X86_FEATURE_ZEN4, NULL),
>> +	{ }
>> +};
> 
> To be continued...
> 

Thanks,
Yazen
