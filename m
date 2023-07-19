Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4446758F33
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGSHic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjGSHia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:38:30 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B555AE47;
        Wed, 19 Jul 2023 00:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATr6MPU/6cU9P2Il045Lp3uB+JgEXkmcHEXyeHZaXDDLrKJxOp3trUYGpmrukWsnA3hmhcRn8wNgvTRxrXX9nuPIfn6R9xY4jkausGrom4ECJd9RwiMZkksyYQOjsXXZicZET6EzyOKfrc565uipKKO7h6b0hkrHCxeu3eq7ckOM5qYNkaf16T9zBE8OTuEtm8WN5m2kHQzhdI3F4Mv9qIUgITKo9p0C6IfnRstDEv0+ouu+k2OT+xHXTKCAW2mTUHFUjy9ZOcuNVZXxqbD37GqFWS7bzMFF3pFU+3CzLhiZ5T7c9xBREJFSMGR+HBx/Jz/mXotYPkwW1B+FyV8A+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHllduRS8RM2SMjQ7dYTR0VtJnjzjQjAXWlYgoyvR4s=;
 b=ZscU3xp5vmt7hn+GPiYCZYOkzit+jImPMJN0IvIejgx8PAYvpz1XKtCCYNmL+3ydmDeG+iIatT4dxDH6QrdxvWhZsIJeqoljkgV8zqkWCDo8f3hafKTVn6nUcGLz4kM2604iH2bdKHRjF6fCPfuRoLisOXoxL5/ESyqAyHhs4pjUXGPtZXLgsGANpODY9InGZgcROFVWazrg/w+n93Id7JZKjzLqk6kp7sG33LFi5ac1tfn8iDsogKeK+2EwiPpkonP7UizyyANNQExkbDz6whLfvzcAuff+03AFX9lEnSQSLecwFb/fTK2WFjuuFFjzbdhlNjZaYKwmGWHGJyKoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHllduRS8RM2SMjQ7dYTR0VtJnjzjQjAXWlYgoyvR4s=;
 b=05VGt52nvRdJHus0iCHS/FUl9RMfNyum+VkS7ZmWabVoe7EwYqW2rdL9ClaClo4qumHROxFxOxkD00zOdivBKfOtBjE/Ukx75NxcRc2RAhgPONUyzVAwsmKU7r0u4CDmDJ60b+v5+cUDPH4xIsglAxByZUARmGHCJBxjs/RmDFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 07:38:26 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f535:4eb5:f7a0:ebac]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f535:4eb5:f7a0:ebac%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 07:38:26 +0000
Message-ID: <0ec93276-e97a-0a66-fe86-4f355cf1d411@amd.com>
Date:   Wed, 19 Jul 2023 13:07:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] x86/cpuid: Add smp helper
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1689748843.git.sandipan.das@amd.com>
 <827723d8f506411700c68bccc5072ec8d918d2de.1689748843.git.sandipan.das@amd.com>
 <20230719072850.GA3529734@hirez.programming.kicks-ass.net>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20230719072850.GA3529734@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::17) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e719ed0-c505-4498-d054-08db882b17a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nq91q77yBs0XmZABGSf4gtpy9VKr9dcF7CcOtohqegx9FMOHXC/6FJQ94h1sZtIVMBFfh1kdKAJj1JcSvxkxV6c26CO7uQTuYAtW4Cth9YRMuxC1JAaHNkmVdiiXce4fFhTQbWXIofDyo2b5SzoAa7/ETJAJfDJOV3B1NAioyeXosKc4b9+hkZ6GfO8qL1rvGqd+9RKaEOWE/u5gYMxxw53q3GzhO9VQrtIVidD1TgyWQpKGvnTCaVrVo9JlvGyGye2XU54fuLkTipTe6H8dfILnViX09c+PssBLS51OOqX/vTwZLWw0uvVRWqAn5LMeh5GVJcmk5YtHYpTcRc1LTN6j+YbwsUbiCZg3Z89lHFYZTz/r8kztOMJPS3J7cHaxpUjQWSUpbSgWJ3ghep7X6ChWPWY8lC5bISxjMVCbumfciMVVt04Env9QzvjFvNz3oaoP2NBLtTQAXHioaaVUHQvf7lZcTabhVEdW30BRBRM4S5q2QwkwZtpKx2p+G679AzmE/1xOIRCPYJljpR2ur9wVvof9rzYq9udeTmCuEG4ei1WANNhgwaoaprE85evzyeDRrbVhzZ78qWzKRZno1b+SLLxC93GUIVG3+HWbeCHed4KKYdNS8cfw32k/eqWBFkcYSSbP5Jz5j5TFynUEyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(86362001)(2616005)(31686004)(36756003)(316002)(6916009)(4326008)(31696002)(6486002)(6512007)(6666004)(38100700002)(6506007)(53546011)(186003)(26005)(478600001)(2906002)(66476007)(5660300002)(66556008)(66946007)(8936002)(7416002)(8676002)(44832011)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXpDYWNORXZBK2pxWG4ycGw0K2xWQk50RENBS1RtcnZNSEtEKzdTbk1CenZC?=
 =?utf-8?B?QUgxQUh2ZGNyQm13YlpWWTN3a2FQS21LTkpoblRRTGhJOUFkWVJoVHZOckla?=
 =?utf-8?B?WDJYRDdPaFc5V3RtV3ZYUllneXlnVDYwaU5jM0o1L0RDYjNiMkZaLzZQQjFs?=
 =?utf-8?B?ZnkzNk1Wc3pKYUNjRzZrZ0xhZElucjBjWVIzb21RcDRxenJsaTNFcHJHbmx4?=
 =?utf-8?B?SVdrOEJSWm9tNkpZYlNFTFJETzdKbDlYK2NtR3d5WG5XbDJlVlFQbnpTakVv?=
 =?utf-8?B?NCtzbDNzL1VtTDBKNDlqYjhJMXlTRG5tdDR4UU56V2luenFQZmZ0UU5XRGtM?=
 =?utf-8?B?eGdiZlkvelMyTTlidy9KbmRWYll1Zm1kYUNTMGZaMVJoYXFkTFhQSGZLd0s0?=
 =?utf-8?B?SmlDQWRENkRmVWRnQlorZUp5RHBTZXVYTTRqWDNQd1h5cmRKZldvdzVxUlBx?=
 =?utf-8?B?RXA4ZS8yWXkzS0pTdURnN3EvdEhvN1VPbW5ocm9OY3p5Q1M0VERLNW1KYWdm?=
 =?utf-8?B?WU1aUjhCTjJlODZ6YlVscUZoQ1hZNFNLaWpCeUY3aU9KditFckZHNFU5azBV?=
 =?utf-8?B?MXJ1U3dORy90T0VPanViNDRxOEFNbUZ6Q2xzSVFlMDNickFIZGgwcDMxd3Y2?=
 =?utf-8?B?ZFVaVkV5bzBJNnB2YWJWaThMS3lKUjBhVTRJM243TFlEd284K1RJRHdqanFP?=
 =?utf-8?B?YWNmNHIyU0I5SENGNGVQQUx4eVlqa2VUZEQ0bEl5V0VTeGcxM2tsRUxnN2FF?=
 =?utf-8?B?NEY1Rzg4bUxnL1R2a20zSFFsdkV2K2w5NCtuVk5XWEQ4RHhjSmswM21pVnVa?=
 =?utf-8?B?b2dHYU4wanF6eXV4TFRoMWY2OTFnc3R2Mm1ENnd3QlhUZmVBaVFrd0ZVL25q?=
 =?utf-8?B?a2FRNXRFUHdrbGcyVGwzNXF2azlkN1FpZU9lT2Y0MzVmdnVKcmoxNEpLZ1lD?=
 =?utf-8?B?dVh0TXNJcExrejRtQjhSMWJHcXVQWkhnaEtsWEtaL2JtbDljVEVHeW14Zy9l?=
 =?utf-8?B?NVM1bi81ckc2MXIzMGNiN2hna3U5NGVMaTFzSExURG9QWVJ3Wm12VDVOc3dk?=
 =?utf-8?B?V29ENnBNT1N1dUdoWUh3TXJHaWoremFVYzRqQmNiaWU3NHVtYlE0SjR0Z2cv?=
 =?utf-8?B?WmE1OXI3NWh5SVlsQnhhbzNmRXdheGtoTW5GSjNPWk94TWVzbVI3b1JBMmZk?=
 =?utf-8?B?cjBJRjdlWHFZcWZvTUFMMFltN3l3bHl4WkQwYVQxZWhDd3g1VExMbDg4aG0y?=
 =?utf-8?B?K0k5WXhCWkk3WHF0R2FHY1hHRGlndW9pTlpTNlpFMUFWZWRFSEtEN1B0SGNv?=
 =?utf-8?B?S3lCZUJZMVE4TmlsekFXOTRxeVp1NkZFOTBXQ3dkS2xMcFdmVTMyZDJLSXZ3?=
 =?utf-8?B?cVhjaS9ERUZQeVI1bW5pRkIwWlNueWxja3NkK2ZEVkExcjF3NXpuYjhTQ3dB?=
 =?utf-8?B?dnhTNXJYc09iZ1Q1alNrdXVNWFZDdUVIcnBEVHY1Rk9PSzBoVW1IWmJ5a0hu?=
 =?utf-8?B?SXJlS3pnTUZiTzVDemZpN1BJanY2ZzBPbkFsT3Z1elg2dXJlOTU5aENPT2s0?=
 =?utf-8?B?MXRtSStBczROcW5NSGN5Y2k1L0dIdnVNdjZYeDhGR2J0YXJ2MysrSlduQXF1?=
 =?utf-8?B?RExJMGQ5YWRxTTJlYWVvaDU3dG5rWlRKclVZWEF5VEpYZ0lFUmtWUzlmSEFL?=
 =?utf-8?B?NFRTTTEvQ2lXNHVQL2RiVUZ5TGh5NUs4ZkVnMVZLcU5hUTBhWm9jdDdzckUx?=
 =?utf-8?B?NWg0QzRSaXRZZUJ0TWd3SU5aZnhxTVRpbkxkV1JWd3doRTk0bDAyZFdVUUh1?=
 =?utf-8?B?NzhEb1ViQjlKa2JFZU1zL1JiNTBoREJPdGYwYzFjeFoweDdoSzlVRS9RMGtv?=
 =?utf-8?B?U2h1Z2NiL2ZsamtnZ2R0dGFWV2M3bmJGSFk2cjhUZDlGVTlJd3pDemcvaVl0?=
 =?utf-8?B?SWt4Wllsb2pwZ2tOVGhBMy93VFRQdDdOUUtSYXRobjVOeE9uYVlmUkJUZ2Fv?=
 =?utf-8?B?dG03YUdoeDlrbDIxUjNGV3ZlZi8zbng2d05jcXF1dkkwbkF6c2JoTW9iK1FE?=
 =?utf-8?B?UnYxOUt0QmhockxlTzhYNnJEZ2MrNCszOERMY2tZRU5vK2w3dm5ldEg2K3Bt?=
 =?utf-8?Q?DWdvU26GHmP4RhWk11f+T+nxg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e719ed0-c505-4498-d054-08db882b17a8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 07:38:26.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQK11iDOL+MFDXLhRfdsP+FaQzOpSTSgfgUepvbl7Ah2dMSArbBM9NQdRItcigb/x9Ncyh5SXAw1z7753KhVCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/2023 12:58 PM, Peter Zijlstra wrote:
> On Wed, Jul 19, 2023 at 12:25:38PM +0530, Sandipan Das wrote:
>> Depending on which CPU the CPUID instruction is executed, some leaves
>> can report different values. There are cases where it may be required
>> to know all possible values.
>>
>> E.g. for AMD Zen 4 processors, the ActiveUmcMask field from leaf
>> 0x80000022 ECX, which provides a way to determine the active memory
>> controllers, can have different masks on CPUs belonging to different
>> sockets as each socket can follow a different DIMM population scheme.
>> Each memory channel is assigned a memory controller (UMC) and if no
>> DIMMs are attached to a channel, the corresponding memory controller
>> is inactive. There are performance monitoring counters exclusive to
>> each memory controller which need to be represented under separate
>> PMUs. So, it will be necessary to know the active memory controllers
>> on each socket during the initialization of the UMC PMUs irrespective
>> of where the uncore driver's module init runs.
>>
>> Add a new helper that executes CPUID on a particular CPU and returns
>> the EAX, EBX, ECX and EDX values.
>>
> 
> So I hate all this for multiple reasons:
> 
>  - the wohle foo_on_cpu() model generally leads to atrocious code that
>    does multiple IPIs, I've seen rdmsr_on_cpu() followed by
>    wrmsr_on_cpu() and worse things, just don't do this.
> 
>  - The whole CPUID thing is insane; we should read CPUID -- all of it --
>    *ONCE* at bringup and thereafter never touch the instruction ever
>    again. It could be people are already working on patches to this
>    effect.
> 
>  - Different CPUID values for different CPUs is a pain :/

Thanks for the clarification. Will remove this.

- Sandipan

