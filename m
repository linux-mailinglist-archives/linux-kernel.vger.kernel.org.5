Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE75F78C9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbjH2Qry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbjH2Qrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:47:35 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872661B1;
        Tue, 29 Aug 2023 09:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7A1eDg+YkYz5RpGIHrjFAM63rf+egFc9CxkojvMq0uAaCuqM4/6zN2NhZXhJxfd6vpdKOYIlKsOLr6F/h0j1fI/1q1gZiw8zd6Q1XkwQxwjUwon/yaFsgaTRFz9rJe69ojU/SE9aHKpIMTvqSUl8i/N0iyToYLjaBDceBhZzt6XCfSNOxXPVZaLeMihFQA7d9O9JhZ97A9GrZB8j4/G8GugJcQCMuGzIu9x0/IjVVygjn9oB/NoMBDdR8wrEAWbJCnpCdAAuO8TZJvavXEsfmBKBamD34O1rLnYYNkyw2nbVUcKhMkFhDimUqF4DscI1Fcs1v+oID9rvjwplB29OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D9L96jyi9UDGf5JGHIXyXVEfPTNUQmQm29z/RSF2SM=;
 b=Ah3f5uTX3Vaut34hD+IoylbpfXeuRORwtQF105Fm7ZaKikJnSqTFKFi/SQzNZ+0dDwTYA4Vp9BYO3R0H0xmwstSWScXCa82awSjeiwX6L0rlboDwpsZ+PmNowOFWwIeKZ9sRXJE2HYZPiWFSn5MfvezvMqLfmoMwfuQfQ8T0wNw+GVtnQx+XJknvxze21WtvOub63yAMXMQT6Cl10dvNiuqF9NG3QpiNVtMf+fpiO4bul/2VCU4YonU8FdP0df0EOLoQ40C+3+wAHLpGiAehc3uQXn2lChwSfpus0uy1FtDgRk2DU9MlMqyzZqVBqJ+AWPfmuE+m3VMNDDdqOgJ0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D9L96jyi9UDGf5JGHIXyXVEfPTNUQmQm29z/RSF2SM=;
 b=Kh5MWok8zfz8uT2NiqO1M+zjFLBog4OCBMgY3Q5NnUYPSPGUIWrkNn6vCVy5Bedrcv1ucdhVHyonteND1LqoudHrAKA34RbgczO1mYy+NKUeUBCfr42Qy0kXabuQNzc5FwRAlHvXS+UG+alVqc/nnNRw+w4XVa4q0/u4Se1s5J0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3818.namprd12.prod.outlook.com (2603:10b6:5:1cf::24)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:47:29 +0000
Received: from DM6PR12MB3818.namprd12.prod.outlook.com
 ([fe80::7c3:6646:9b4f:258f]) by DM6PR12MB3818.namprd12.prod.outlook.com
 ([fe80::7c3:6646:9b4f:258f%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 16:47:29 +0000
Message-ID: <b04ac070-2149-4d61-ad90-75401e173b29@amd.com>
Date:   Tue, 29 Aug 2023 22:17:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
To:     Dave Hansen <dave.hansen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        SivaSangeetha SK <SivaSangeetha.SK@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>
References: <7531423fcb3b18ff78737ae5eabc84b0e3cb2909.1692369704.git.Devaraj.Rangasamy@amd.com>
 <b908433c-0924-fbf7-f555-532e438ff050@intel.com>
Content-Language: en-US
From:   Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Organization: AMD
In-Reply-To: <b908433c-0924-fbf7-f555-532e438ff050@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::10) To DM6PR12MB3818.namprd12.prod.outlook.com
 (2603:10b6:5:1cf::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3818:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4037bb-95da-4bfd-ba40-08dba8afa196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+kdm4pAaMTys2kdBegkU3pWFi9k7/3lGCeFnCBPbU6uYXQFu373czdpNhAiCDwXDroQ7NvS8DATPVQnPBxPaelo77gZxRycgUfC9pL8G7uZRN9iGwT9b5Md+X28Ow0qwJOfRJEgiEqwdshVX7P8U+blWK2TuVxe9Pf3g/HTF+zxN/virgyms9jVfgw5wRoJKN1YHraR7Alm56+UQHeSGTh2IQjhaXahT0e4761a10LTYIsONe2LrsDM78sxWyrSbNtO//YRThQr5SuRXIEmAiXqoAegY4PA8G34RSt2Kdv841uSR6OLxF4rmYYz8O2E+8jC2G+MGvqgklZqyFWpMSoflhs00l2zRVJJTQfglzv4hph9oh7SZZcfjuneCjs5F2STgqvH+nbA/EPUmff51gHBOuCqiDSrXJKuSIRNnmsFM2PlT91MEeHI+it+y6PHLC0Atg+VlXFgWOgXOhuv1+LC4Z3W8l9XVXs/ND1LnLRaBC1jZBtIAqHZD3WtmBB/Ic1yprfBj0p70jbpahMezhW2FyX55hW3PmYYtjq1DOKbyYg/UjvKgcyrkRpmmPOhnSLwsmir7Bj80fUnU7msOZuP+LVGXgoElsO4x7pa/e2MV1Ho8QIzEEMHUkYYJoYGzBs1suyAlkF8Gr+VBwF7o/sqrVFERHe7rov+pjHdzVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3818.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199024)(186009)(1800799009)(31686004)(6666004)(6512007)(6506007)(36916002)(6486002)(86362001)(36756003)(31696002)(38100700002)(921005)(2616005)(478600001)(2906002)(26005)(83380400001)(53546011)(110136005)(8936002)(54906003)(41300700001)(66556008)(66476007)(66946007)(5660300002)(8676002)(4326008)(7416002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJQaU5HQ01laDZXdXlQaXk3WWp1VWRZZDJiZUJIZTdPVVFzaG5TRWxiNHps?=
 =?utf-8?B?czlpQkV1NS9ZOE9oRG5aWUQ5TTYzRlM1UTRBcGlGNUMyVnR4WWg5dW1JSnBh?=
 =?utf-8?B?V2s1WDIrVHFsbDdYVzhxdlRMbU4vUDBCYjZDT0srM0pURERnL0RobDNYRjFi?=
 =?utf-8?B?eUJ1SFRpTVAvNGU0MzNPNnhiQkNrbzhWalBLZlVUNWN2UThSb09jSmNOYVRo?=
 =?utf-8?B?Z01wU05HZXlXeWVmeDJQSGNCQUN5dTg5aVNxTk56MjdCc1poLzIxNXg2eUJQ?=
 =?utf-8?B?WHRnU1B4eTJJWDNyT2VaNVh2cW5wVGtCaEMwLzZIeDdLZS8xTUxHd2tYcjZj?=
 =?utf-8?B?ZFVLUS9Sb1RZNnM0MXVCRkpSeVBTQVN0WFM4S2E5NFlhbXB6b0hFWVVOM05m?=
 =?utf-8?B?OUtCT3NocG1CMHM3L3k5TzNCdjgxR3krMVZDM1FDYnBLYkRMVGZSWU90QVJl?=
 =?utf-8?B?NURSMlhGMjEvbk5xUUZ2LytZemcxY1diY0s4aGNvbFUwRk8yODVTSFQyOWpC?=
 =?utf-8?B?MXp5Qm9wR1pMQTArQnJWcTNZcXBENy9ZWUd4TzNXQnhzdk9Va0pHRVNLRVRp?=
 =?utf-8?B?b1diMTNwUVVZSUU0ZDBYblZ1ZzA5SEtIeHRWRnVORWVXQUR1N3Z2dDBGdEVV?=
 =?utf-8?B?RXgxSW5MTmcvTFo0NkplUUNLUVdPRTNRM3FBWEFQbVVEVzNxZDBka3phb1Bp?=
 =?utf-8?B?OVpOZmdVekh6SDZ1ZUNwV2Fsa05NOExBUzJtR2dDbldickl5Q0NsYjRFRDJE?=
 =?utf-8?B?UFZEUGI5bVo4WkhRM2huemwvaERqenpwbDUvcVB4N29GZk5mVWE4cHhIdmtJ?=
 =?utf-8?B?bUxRaHBGY29vOXZhcFRSS1hEWUJld1dHRWZXZk1NWkZYOVl6YW9GREl3LzJT?=
 =?utf-8?B?NitaTTJLeStyZ2tNVlF2eEMwY3p4N01zWXlsRmR1WWsrY2JORlRxc2lKWC9Z?=
 =?utf-8?B?WHF1MjkzVjM0Y1pLVE9WSEJZSjVQVWtLQkgzaEpYdkZWQzdJZTFLaWpUd3lG?=
 =?utf-8?B?ekNGRmkxQm1JMWNZR2NlaWhsTmQ4UDBDRERiNWJlNjMrWUtOM0txRkZwSGsx?=
 =?utf-8?B?U0FBVlpDTm5hREFQUUNGTXg4dXo5dFMyQ1l0bGdFaXBMOG9Tbm0wOENtUnZ2?=
 =?utf-8?B?a1BUTW5XVGtZOTJ2NUxHWkdqbndkWE5zQmV0TFJEdDJqY0dsV3crYXE2UTNw?=
 =?utf-8?B?SE9zdUFYVEszam5uQTh3UllUcU1kQUdlY0RGYmFzOXNQcVdMNFV3YmFOUi9G?=
 =?utf-8?B?dE5aRVdaUy9WTG5yWnFGOTBxOWkxV0dpRGdGdjU0bjErUkN5YzNDN0xwR3k3?=
 =?utf-8?B?WUtVNGZvUGhIamFPbmFYK0JXYUtIWmtnK0g4em8vaEZ3UTNpN2RPbVM2N0xv?=
 =?utf-8?B?UHVNM1IxQWFHWlpoZy92dGFYQ1pMR3BtT3h2VU8yR2FBY0hRS1pSTjhIemFv?=
 =?utf-8?B?VEV6dTl5a1hmbUFnN0VXSCtlUStWVjBDU1FxNTQxZDFwQ21qbWVhOTB2Q1U0?=
 =?utf-8?B?ZWtHcGVuMmc5WWRMeGZSYnRvdmNaL3l4alRHTG9tUHB3SU5MdWJ5anpRVnB3?=
 =?utf-8?B?ZHBZRUNBSk1BcHgrcUEwSW90TkRYM2JQanJiTktaUXRJaG1keXVWN1dYdi81?=
 =?utf-8?B?ZjdBZGR3YkY5a3ZhckNVdEpVR1FXR1Znd2F4UCtOTktjRzN3SFF3QUhXR01i?=
 =?utf-8?B?bVVIQit0TEkrOWtNUFdSVXZTaXVMSEdxNUdqbDJKblAwNkRmOXVvZ1VhR3Er?=
 =?utf-8?B?bVVDU2MrbFVXaHR2eE1sRHRiTk03Z0JqblhYNTUyRnJ3Q2NsdVUraHpUcUJS?=
 =?utf-8?B?bEdGOVlyUFd2TWswVEp1c2x4anBSUzJFVWRmdTlDaXZ0WHo0aWVqUE1KN0x3?=
 =?utf-8?B?T1B2cFdvVEVaeTltdTgvYUM2REZhSVBLSkVPSWxWQmZ2aTY3cmt3VmFwWWpW?=
 =?utf-8?B?SDlXcGJETkRseWIranYvK015amxzS2VPcEY1cmpQeXpORm1zejJuT1FsbVlp?=
 =?utf-8?B?ZnlWa2ZLVnc4UUorRGprVk5Ea05wQ3FCNTZTd3psbk9Yc1FLNkFzNU05Myt5?=
 =?utf-8?B?ekl1L2ZTaUUrWHJCcUhVcDZhclM2bnlWdWorYmRHaGZoeUF3dmtlaGhZcnBZ?=
 =?utf-8?Q?Oz/4KJI+R6FvptHCj6vZZh+U6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4037bb-95da-4bfd-ba40-08dba8afa196
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3818.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:47:28.9222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9dc3jVVbWZdwltUxQrPOP4ik3tzrTnTvvl3b5kpgw+9tI2tLWp1EY1+SI8Jwj/QZ91m+Ltwtn/tg6mgIQVGWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/18/2023 8:56 PM, Dave Hansen wrote:
> On 8/18/23 07:42, Devaraj Rangasamy wrote:
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -1223,6 +1223,8 @@ void __init setup_arch(char **cmdline_p)
>>   	initmem_init();
>>   	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>>   
>> +	amdtee_cma_reserve();
>> +
>>   	if (boot_cpu_has(X86_FEATURE_GBPAGES))
>>   		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> Right now, we have *A* global CMA pool set up in
> dma_contiguous_reserve() that everyone shares.
>
> Why does this *one* driver deserve to be a special snowflake and get its
> own private CMA area and own command-line options?
>
> It seems to me like you should just tell users to set
> CONFIG_CMA_SIZE_MBYTES or use cma=size on the command-line and just use
> the global pool.  If you want to make it a special snowflake, there's a
> much higher bar to clear, and there's zero justification for that right now.

Ack.

We had exclusive cma zone due to concern over contention for generic cma 
zone, and to guarentee buffer allocation. We profiled and migrated to 
generic cma zone.

> Oh, and this:
>
>>   static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
>>   			 size_t size, size_t align)
>>   {
>>   	unsigned int order = get_order(size);
>>   	unsigned long va;
>>   	int rc;
>>   
>>   	/*
>>   	 * Ignore alignment since this is already going to be page aligned
>>   	 * and there's no need for any larger alignment.
>>   	 */
>> 	va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> is goofy.  It either only needs powers-of-2 and can take "order" as an
> argument instead of 'size', or it should be using alloc_pages_exact() to
> avoid wasting memory.

Ack.
This was inherently introduced by __get_free_pages() requirement, and 
constly indeed.
alloc_pages_exact() do call __get_free_pages() internally, and doesnot 
prevent memory fragmentation. but at least unnecessary pages are 
returned back to free pool.

We will update the section accordingly, and post updated patch. Thanks 
for the review.

