Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B837B9F73
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjJEOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjJEOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:22:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634D5AD24
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 02:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBx2M1N/3P9BvpDGiDyh3Fr40iCGkOhvVDrkjfyqwHjLolYGq/v/gZAh27mn2/IrdbN7PYcMTWAhx261u9dpk4VWYjBIFeHapV00E/NwrJ/wTK19pPMOcqIbJTsCcYPPFepcy5FyXjFIRzSZb1DfEEjxMmfuTNu+anKLg4A8o/0MAv+C8NR3NKnK/FbQF2JdRZ4Ht1qQoaNkGnn6JYEhlCoClpqH0cNCSURfoCIg6/O7dY/KBKinUcaio7zZhPu3BMJqcclj3QZzQsjEAgK9NX+naG+0zeswuey5tofcuSRN0iT3gjKAXAzEJgDqwC6JLRfkJOGRJFGnIE7IYoqM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIzz/oykrYscDReyr267u9WwM0eK40wogjZtjYB39es=;
 b=W2bStne8TvCVeirS2W4ABlkgBuTFY6o4aCKtKNI6I1QYHOp1LuqyZDsLugGFn8D+L8vYZqeaYdpFJ9oVfZQgjm4zimTiH4O/tRXGBkRddlNenxhdZ28jBibSkcbw2n6E/9Yu6nqOMUx6p60putK+U6QfXpnn6CMoyg7aw2wcSL3GxGjjxuCtRy4//bpFL4RKELLqYxk9/wRgo7mfQRiiZHga4HXMyu/HI/Q0tFoRujtG++ml1BnaoaEflbL6whM/OWgupP1GxXdAA7HUqELd8HUhAJ9SSfNWKl8qnYjtQkF2QqeXsT++aVGLlvTOBTd6dwbWI0BeayfNdV2UVY9IpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIzz/oykrYscDReyr267u9WwM0eK40wogjZtjYB39es=;
 b=I3bDWiK6koCKho0Xwr/S7v302Yg5Xal8pwd0vlGh5MDzU6fx7uP6KLdYzHdCGYtUUsADhL3mLIz2Dj0xRKTUMGum2bXmuhaKK4HCiq84guCPs0xTq19AuAx+gWgjKN7icj4GKhi39vi2o45X5DHVkRgMxlkoAD5B5YL7YihFlOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 09:36:47 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 09:36:47 +0000
Message-ID: <1d9a3a05-fbcb-49b5-955a-a3686ab3efdd@amd.com>
Date:   Thu, 5 Oct 2023 20:36:37 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kernel v3] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>
References: <20231003073123.1763564-1-aik@amd.com>
 <32c0080f-1bd1-32c4-2bfa-910537a50ca8@amd.com>
 <14619d42-b319-4b5c-9363-c75096d27584@amd.com>
 <37f536c7-0b09-89f2-5556-d403a0726fdb@amd.com>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <37f536c7-0b09-89f2-5556-d403a0726fdb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:806:23::31) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|BL1PR12MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ca49c0-4984-44f5-e9e8-08dbc58697b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPzwIH9h4KDY4hDzXMIbvlhUUb8jQSboAdxH8AKED/Y8B9+BpV6nWITFHIi51yhI7K2IxJ7YGNSZxPUg2/qwqWrl0tKxmSQJMTFzl6SylKr3bhiVV5ONjvpdaekrptuv0Xrm3KdKbEqC3B+qterdEpoN/orrBwreQasHkwcUKLNEHl/DivLFhRthjERlUMYmhNOpDS0vMT18l8SAzyk9tI1I5qWJSPhCHThbVs7CnEPEEsdcRxh2f8X+KSc2dtxwded8brcmBJ4laXczEvF86P69ptFu66byLgnduceZA1K3NYNerGbFC5wrRsGFppymTPB5O/VPv5uy6AK3Qbp5eFK5a4FqiMAI6jlQZBmJcUm6j4UCGL4o5RGZyskM7RhpdVHuA/t+ma/S65AJh77pGyfPM+96zbxJicrR2F1dU59r9Mzrj6NbR1Z3UkcESGu+A0rmsx3rZEhtNQ36HjnrURhMNHOs9Wu2gF16CrxMDl4S2bC+32RaTzcFsvDdg7eGvl4EEpo2CJVXxXQ4g/zLlcV5RqDKuwhQVc7N5ku7PqkuvOQgByDykgeQWQ2urhy4LEB9rp+RFqcAHlaU1copmS74UgK6DMRtDvLXCXYXhppllbpP60IJX+/lVVw2ZSDf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(5660300002)(6512007)(31686004)(26005)(83380400001)(6486002)(53546011)(6506007)(478600001)(38100700002)(6666004)(966005)(54906003)(316002)(66476007)(66556008)(66946007)(41300700001)(31696002)(2906002)(36756003)(8936002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFNai9ua3l5WlcrWUJrU21BVWRxZkZ6empJUFJXTUpUaWpuczF3UGl4U1dT?=
 =?utf-8?B?V3BKVXE5K0VyWWdqVkkyMkR6Z09PNEpOVU9ZK0RoOWRVb0EzS1pxUkhEUktY?=
 =?utf-8?B?alpXNFFvZy9KMFIzYXF5aDN2VDJVSEQ3OU9hVjR1bVk4dnRRdExSQm5VTnU2?=
 =?utf-8?B?ekZzZG5jQmd4bzZUL1ppSVZyOXRzV1FuY2thMExxUTJsMEFIRVhBUFVTc3B3?=
 =?utf-8?B?dVFveFFGdjBabHhMSGI0b0dGemp0SkhqUkx4amZVOGNaSjZJVXhpT0tybnBM?=
 =?utf-8?B?NWZVKzNvZmxWVjR2M3FVYlM3M2FHRm93MzMvYXUvK2VGTEhDVFZxeVpocjJK?=
 =?utf-8?B?WmZIT2pkRGd5eFp3ZDlLU2UxUCtndXN1Yjh0bDJMTXhZcEhQeFpyWWpSaXpu?=
 =?utf-8?B?NUY2amhtU09pd0ZHbzk4c21RMWhBY1dNUy9CNkFKMFlTZHE1Q2IxbDhuTmFZ?=
 =?utf-8?B?dWtmcEhmWjhmQWEvNHZBU0wwamQ5VVFtbTcwM0FaTUhBQjRmMFljVDRoRDFI?=
 =?utf-8?B?ampkYktlSndPd1JnQ1BqMDdFYXFLdERjSERDNmsxeHNYRXlPQUdyMW1ObjJj?=
 =?utf-8?B?N2VCcVBKMXdwWlREZEdjcHRlRUlQdC9pbkRvOGpEMXlJK1NtcEZ0eEQvYXZy?=
 =?utf-8?B?QTVWSWtKdU44OTRtUDZzdjdBb3Y3UXZ3Z2xOTEdhVktLVUlDTG1nYlEvZXJs?=
 =?utf-8?B?QmZLZ2Rvai85U2dFazhxSUx1YllrRlExb0xaZnBPL3VqYXgydXlLTEdEbWQ1?=
 =?utf-8?B?Mmx5T1pTK2lWWXhtYXlEOTRkeHk4d2pzS1VxUlF5QVRTdFZOTW1NRjdJcVFL?=
 =?utf-8?B?ZmZKdVpHUitEcVhZMHFkMEl1N3IwNFFFS0pQNTZsVjlacFRPc2ZKVjRRclMy?=
 =?utf-8?B?NFlvbkRFSWkvWVg4TEs5VjRkOEo0YjNoVUxRM0l1R0krUzlHMklncEV4NGxk?=
 =?utf-8?B?ZnMySTAweTBuNlFPZzhUdzJLSlhsSlVlQ04ydGhBZ1lZVFVPVXFoeGxDazNM?=
 =?utf-8?B?aCtBcUZ6d1JCMGVsZnQ0b0ttT2ZXNGJBK0pCSmp2SCt4SXJwNWNDUG1zWnh2?=
 =?utf-8?B?bkZXd2dMYkZtMWJybDNUT0V6bzUzbzZEdFdwN1BZTiswTXIrbUN1RlpOLzYx?=
 =?utf-8?B?bTM4U2lQVGxCUysrRDl5eXR0SmRFckhGTVVrVytSNCtLYzl2VXB2eWJ4cmd6?=
 =?utf-8?B?OFUyY29BYUtURzdyWURra2ZURWUyMVkwMklvdHhScEpIVmhyK05qWEZUUDhI?=
 =?utf-8?B?Nmp4b3ZXZFBSUG5wUnZudzlhYis1N2Q0RGszZit4aTFMdVhIdFAvWGI0M2Vh?=
 =?utf-8?B?ODVMNThWWU44VzFQUHZGL0p2YTFRWSthb3o1bGFyQWExdkR0S1ZEVlNMb0VF?=
 =?utf-8?B?ZEg5eVVBUEpzeFB0dGM5S3V3aWxxbUtod2RNbVA5dUd0amZwanVtQWV4Z0o4?=
 =?utf-8?B?WGM4alRXeUc5RTdMd0l3dDNqcHUzUnd2ZGlWY2N0TnRJWWcrRnpBVXRvaWox?=
 =?utf-8?B?TzNqaHVYRzVUbXNTYWpqc2FpNTVtUEtaRks3UVFnQm5xbUF3UlhuZzEyZkM5?=
 =?utf-8?B?d2gzQ1AwY2V2Znd5RzhINk13cFcyUUF2S2RoMUVhcUpuSEY5VDE3VFdZYjNS?=
 =?utf-8?B?VU0vcUdEaHBkQlBhUklMRGlZUGE2TXlnVk4yakpDcE5qc1R3N2duTzBNOFNs?=
 =?utf-8?B?aU55ai9NVmczYVJ5RndIcnhaWlZ5bm1TL0dWc0dZWTRsUEM4aGsrcnJ2RWFF?=
 =?utf-8?B?SThXQXVvT0lJQ1BOckFpSmY0bnZ6bGdqNWdXQXlVeThxbEhUNVFzWi84MFRi?=
 =?utf-8?B?VHllU1V0VEwwd2lNek5oY3VvMDRTWXRJZkFINkdaWWxiZ0NJTVlqSTU4eXFs?=
 =?utf-8?B?RWRvNjRGL0pLVVFocW1WQ2hpcWZUczR5dEE4ZXFteUtGbmJkOTNpWExiWHRz?=
 =?utf-8?B?Mm1QVkQvU25WMDF0bVJJdzY5dWdaT25qOGFmT1pEMHhOQ01yTGdkNzc0TnRh?=
 =?utf-8?B?NkFHSDk2bXdxRFNRY29Ecy9tTWo2amtGaFVBaGpqNm9aWjFWbDREWHJ4UjI1?=
 =?utf-8?B?WTZCM1VscGxFVmlaWG5vVm1BSlFQcG9sNUI4eWg4WGk5eWltdjdCS0E1VjVr?=
 =?utf-8?Q?E65c36XZUIxHY0EcgJA3Axt8A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ca49c0-4984-44f5-e9e8-08dbc58697b2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 09:36:46.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ABBx0Q3qk8r6pnpZp3ckkbscCJZF6XguAORgSVvorJvAmc1K5juhBXRfFoX5ykeRGIi0IDxaiBCxBCYP6JfJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/10/23 00:53, Tom Lendacky wrote:
> On 10/3/23 18:22, Alexey Kardashevskiy wrote:
>>
>> On 4/10/23 04:21, Tom Lendacky wrote:
>>> On 10/3/23 02:31, Alexey Kardashevskiy wrote:
>>>> For certain intercepts an SNP guest uses the GHCB protocol to talk to
>>>> the hypervisor from the #VC handler. The protocol requires a shared 
>>>> page so
>>>> there is one per vCPU. In case NMI arrives in a middle of #VC or the 
>>>> NMI
>>>> handler triggers a #VC, there is another "backup" GHCB page which 
>>>> stores
>>>> the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
>>>> The vc_raw_handle_exception() handler manages main and backup GHCB 
>>>> pages
>>>> via __sev_get_ghcb/__sev_put_ghcb.
>>>>
>>>> This works fine for #VC and occasional NMIs but not so fine when the 
>>>> #VC
>>>> handler causes intercept + another #VC. If NMI arrives during
>>>> the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
>>>> The problem place is the #VC CPUID handler which reads an MSR which
>>>> triggers another #VC and if "perf" was running, panic happens:
>>>>
>>>> Kernel panic - not syncing: Unable to handle #VC exception! GHCB and 
>>>> Backup GHCB are already in use
>>>>
>>>> Add a helper similar to native_read_msr_safe() for making a direct 
>>>> hypercall
>>>> in the SEV-ES environment. Use the new helper instead of the raw 
>>>> "rdmsr" to
>>>> avoid the extra #VC event.
>>>>
>>>> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP 
>>>> CPUID table in #VC handlers")
>>>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>>>> ---
>>>>
>>>> Based on:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent
>>>> which top at the time was:
>>>> 62d5e970d022 "x86/sev: Change npages to unsigned long in 
>>>> snp_accept_memory()"
>>>>
>>>> ---
>>>> Changes:
>>>> v3:
>>>> * made it a function, mimic native_read_msr_safe() which 1) returns 
>>>> value 2) returns an error
>>>> * removed debug backtraces the commit log as these were added for 
>>>> debugging and never
>>>> appear with actual kernels
>>>>
>>>>
>>>> v2:
>>>> * de-uglify by defining rdmsr_safe_GHCB()
>>>> ---
>>>>   arch/x86/kernel/sev-shared.c | 27 +++++++++++++++++---
>>>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/sev-shared.c 
>>>> b/arch/x86/kernel/sev-shared.c
>>>> index dcf325b7b022..494d92a71986 100644
>>>> --- a/arch/x86/kernel/sev-shared.c
>>>> +++ b/arch/x86/kernel/sev-shared.c
>>>> @@ -241,6 +241,25 @@ static enum es_result 
>>>> sev_es_ghcb_hv_call(struct ghcb *ghcb,
>>>>       return verify_exception_info(ghcb, ctxt);
>>>>   }
>>>> +
>>>> +/* Paravirt SEV-ES rdmsr which avoids extra #VC event */
>>>> +static unsigned long long ghcb_prot_read_msr(unsigned int msr, 
>>>> struct ghcb *ghcb,
>>>> +                         struct es_em_ctxt *ctxt, int *err)
>>>
>>> Alternatively you could return enum es_result and take xss as a 
>>> parameter... six of one, half dozen of another I guess.
>>
>> How do we decide on this? :)
>>
>> and yeah, I need to s/int/enum es_result/
>>
>>>> +{
>>>> +    unsigned long long ret = 0;
>>>> +
>>>> +    ghcb_set_rcx(ghcb, msr);
>>>> +
>>>> +    *err = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, 0, 0);
>>>> +    if (*err == ES_OK)
>>>> +        ret = (ghcb->save.rdx << 32) | ghcb->save.rax;
>>>
>>> You should check ghcb_rax_is_valid(ghcb) and ghcb_rdx_is_valid(ghcb) 
>>> before using the values.
>>
>> Huh. v4 is coming then. Although what are the chances of *err == ES_OK 
>> and !ghcb_rax_is_valid() at the same time? What if *err == ES_OK and 
>> ghcb_rdx_is_valid()==true but ghcb_rax_is_valid()==false?
>>
>> return ((ghcb_rdx_is_valid(ghcb)?(ghcb->save.rdx << 32):0) |
>>      (ghcb_rax_is_valid(ghcb)?ghcb->save.rax:0;
>>
>> Or I can just drop *err, invalidate ghcb before sev_es_ghcb_hv_call() 
>> and only rely on (ghcb_rdx_is_valid() && ghcb_rax_is_valid)?
>>
>> Where should I stop with this? :)
> 
> No, you can't drop *err. The GHCB protocol specifically calls out how 
> errors can be returned and how register state is returned.
> 
> In this case, sev_es_ghcb_hv_call() will check for general errors being 
> returned from the hypervisor, e.g. non-zero SW_EXITINFO1[31:0] and that 
> is why you need to check *err.
> 
> Then you need to validate that the hypervisor set the proper registers, 
> hence the check for ghcb_rax/rdx_is_valid() (see __sev_cpuid_hv_ghcb() 
> as an example).


After an offline discussion, it turns out this intercepted rdmsr of XSS 
in this particular place (postprocessing of CPUID 0xd:0x1 bit3 == 
"XSAVES, XRSTOR, and XSS are supported") in the guest should not have 
been intercepted in the first place as it is virtualized and swapped as 
typeB, but it is intercepted as this is the default.


This applied to KVM fixes the guest crashing problem:

--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4266,6 +4266,11 @@ static void svm_vcpu_after_set_cpuid(struct 
kvm_vcpu *vcpu)
         vcpu->arch.xsaves_enabled = guest_cpuid_has(vcpu, 
X86_FEATURE_XSAVE) &&
                                     boot_cpu_has(X86_FEATURE_XSAVE) &&
                                     boot_cpu_has(X86_FEATURE_XSAVES);
+       if (vcpu->arch.xsaves_enabled)
+               set_msr_interception(vcpu, svm->msrpm, MSR_IA32_XSS, 1, 1);


Sooo. I guess we want to fix the KVM but at least for now the guest 
needs the fix too, does not it?

And adding Sean in cc.

Thanks,


> 
> Thanks,
> Tom
> 
>>
>>>> +
>>>> +    /* Invalidate qwords for likely another following GHCB call */
>>>> +    vc_ghcb_invalidate(ghcb);
>>>
>>> We should probably call this on entry to the function, too, right? 
>>> Not sure it really matters though.
>>
>> The SVM_EXIT_MSR's handler in SVM/KVM only cares if RCX is valid in 
>> sev_es_validate_vmgexit() and the guest's ghcb_set_rcx() does that. 
>> Nothing in SVM enforces that other (unused) registers are not valid 
>> though. Thanks,
>>
>>
>>>
>>> Thanks,
>>> Tom
>>>
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>   static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
>>>>   {
>>>>       u64 val;
>>>> @@ -477,11 +496,11 @@ static int snp_cpuid_postprocess(struct ghcb 
>>>> *ghcb, struct es_em_ctxt *ctxt,
>>>>           if (leaf->subfn == 1) {
>>>>               /* Get XSS value if XSAVES is enabled. */
>>>>               if (leaf->eax & BIT(3)) {
>>>> -                unsigned long lo, hi;
>>>> +                int err = 0;
>>>> -                asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
>>>> -                             : "c" (MSR_IA32_XSS));
>>>> -                xss = (hi << 32) | lo;
>>>> +                xss = ghcb_prot_read_msr(MSR_IA32_XSS, ghcb, ctxt, 
>>>> &err);
>>>> +                if (err != ES_OK)
>>>> +                    return -EINVAL;
>>>>               }
>>>>               /*
>>

-- 
Alexey


