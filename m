Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779B97AD474
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjIYJXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjIYJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:23:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA6101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLph7cfILuIQf55Ido1QDR6y0iY+czVC55e1mWhRFLZkWR8QbFwpFdFC2RemYP1pWXtqyYfySCeAvLnQP3o6ehIvjvh1bR8oqX+pxrkt9Pna+VXMG6kxz569xW9e0CEkvKHCQTTY0hToKxAzLC87rL68KMjD5IhltPMQwjfhAS0WUyvPvtRi+ZK+wpuRiOmVzrrsX0wdZyG+5t8Ynjv2bBA/apZJTjR0t1SZbUQnKO7eMQi2nQ1SE7pXVaIMuKh1k/fXlI/n44eD/mvwwDsZTAqVhnU/q6Xf1k+0lQR/4HuLH91NLrsYDfYLgIj9ml1SaSi5aVn+p16JCcmgifxDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Plqravj/r+QLHk8Jv8AQjRYWxXzX53U0yE4ml0raJoc=;
 b=BGTmBANpk+jQ/WLwOOVJ/YRJ+hJ+IzsN4zVRbR0Sx4whIWmtMqn2+6Eqt9KGOM2SFr9Zsxzr381t3B2zIAsHcFnUc3bxij7xf7gA36lC8jh6sqVd/v+gpQEX67qbLe2GjERL5DHnEwGtlmjU98lzC/RAYZ3U7TE0vRPBdT1CoRXcII8tGzowhoKrKp58B8G0TR11jfJcvdT039M64FqJMyh+qFL0qydPE6RJ6atGNpoF2U7b/iD7hhwjyfGWUwEV6FzR3NmYt+X91FsE9f2p8cOJ//7gIHtt2fxGs/aGPspD3sm8DzUBVpaQktQwxeG3V2u8VewV0NfLFLLdGfF0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Plqravj/r+QLHk8Jv8AQjRYWxXzX53U0yE4ml0raJoc=;
 b=Kc2MadKnYfjZbc5uNbLSCVhGU0gyhIFvcg+7DHJj5fljTVFOQaQakivR4CBSkOigiM6DcG45079h4dzrd8ep+vjW5fhMqo/TSNq5SZSVn389Yu15veAWrFNcTU8kl4djgMvLviaRH8w+hiZjm+qQNdCXLaU7ayt4qBaKgDv7lRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31; Mon, 25 Sep
 2023 09:23:11 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 09:23:11 +0000
Message-ID: <53e60186-674f-449b-a99f-01cd759c65de@amd.com>
Date:   Mon, 25 Sep 2023 19:23:04 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kernel] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20230925042302.593317-1-aik@amd.com> <ZRFHtCCsL4kKajKF@gmail.com>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <ZRFHtCCsL4kKajKF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::27) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ab9ffc-d1ff-4f61-5ed3-08dbbda909be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRZ0Y7kvgO7jnRSLVdUR+oO78/3n+Z1k9Xg9dkNm3MgXA68TW/6mG/VzFM+FbOZasQYB/xJX5vP/Wbh+SfHUJlKxkRTVo4m0RvA7oQ9zGe9L1NAzhwbZNWJpWuiBfMl8sI+VipenDN9wH5YTqm1a0cbE+iyWz+T87E7TAd6tW7BENSXIjB09JZT5/E5nvzr6geTXe7UwPPgXclZnenJrdyK9jui5npUAH4Q8YCcBksiSRN6t7/Fk7HJ5iwr63yKXL54wGVDIyYiH1z5z48RjladHJHC7Jx+YJv+m6r5zqgWRYWHv0KzzXo6oV2FI5tFU2cacZkU79lHHO62ZCPwrRVkjHNGstjkOvZb091ud0QD4SCgegWSNdtl10rUYd7zGogT2AtHWPQOdZbNbV3RA5l8X4DvOwqta4ms7XKfLAsr1Mg43+Q6go3Urfqsx/fepMZzsCX+FT0B3qaWEG6Bbk0tWmPhlPdnISR+Yc+xOYhJt4MriNMfkl4BT2evMHmmK3/NGM6plKvFh48lVn962YpFyYjN3MHL8QoXuFF6mBfEr/Nlc7UBPPHgqqPbbGWjdVuD2l+9yXvXePdii7lWDbPgq7DIZVg+6wRPwm3+2IOa2CKQylKwuJy8eTuko/qtxrEP+AXUY69vg8FOfYiI91A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(31696002)(26005)(6506007)(6486002)(2616005)(53546011)(31686004)(83380400001)(38100700002)(966005)(5660300002)(6512007)(6666004)(36756003)(4326008)(66476007)(316002)(66556008)(8936002)(478600001)(2906002)(66946007)(41300700001)(6916009)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnZkOGZRVHlhZEg0VkpXc2g3c3lTUERuVnUxekUwQngwNXFPUkxNa1R1SkFa?=
 =?utf-8?B?bzFoeHRlTWtJNDVrV01CaGRCMnJ4aW8xNEFxYkNuTUJVZHh2TmhhK3hFcE5J?=
 =?utf-8?B?MmJxVnRjdkpzM04rd1RqSFVER2RmWnFEQk1jZHg2bjdxMzV6TlZUQWx3SU5R?=
 =?utf-8?B?dUdlYzh2MWdqRXNrYmJPVUduT0tJK3k2SHlNYzJoMXpMTnkweHFFRjNUTEhT?=
 =?utf-8?B?MTVZMzZqOGxWcnUrN2xzamx6Q2N2SVBQc0VqcitqRFVDZjBuUHN5Q1RzUEIr?=
 =?utf-8?B?aXVsbzNGT1BLNjVFZXUzUGVGaG9hakFjZmN3d3ArRXNTb1Z2ZWtCcUlQbWVm?=
 =?utf-8?B?YzlBN0FHdEpDVldmOFpWRC9DdjhoUStGT2d3aGJmdGhnZHl1R1pwaFFyWkdq?=
 =?utf-8?B?UHU2eGppcUtzVmxuZ2R5Z25UeTlHWkVaaWhwUHlmKzIyeFFUbytTNXRHVjlO?=
 =?utf-8?B?T0lKbzlaWDMwWVdQUkZJWEhXZVNVcVFnWXRmSlZBZ0JIaXpFVHcvQ2lxNzBG?=
 =?utf-8?B?OEhBcDJOcXR5REtFaVByWldSS3J5R1F4QXRlYXhjY3hTQ0ZvRSsxSjZZYWgv?=
 =?utf-8?B?akgwblpZUFU1TnlFaWMzWXlMbEF3NlJONUpyNS9XQTNwTVY4WkJYREorbjRi?=
 =?utf-8?B?dms5cFJUSVR4SzhhN2FVUHdRZGZKbVZVeHhtMWlCdWRlYU5BN1IxeWJLa0p2?=
 =?utf-8?B?MXg0VE1MYWlPYUtLRnQ2RnhJN3hHRzFwMS8xdXQrNEZSZFAvbmdwZHhhNHJ0?=
 =?utf-8?B?VDE3cStMNUR5d3RqWlNKcmJ2OXZoWExETjc1a0ljKzJGcjY1V3doRFg2bU1W?=
 =?utf-8?B?NG1RN1FObk5vcnU3akNDc0MzcGFqbDdOR2ljTHUzTTVKQjNNdEp3TGxoNXEv?=
 =?utf-8?B?QmxJeGRPZFBnRFlIMDM2MXN1ZUQ4YUp2UmVSYit6TGlhNEdFelRFUTFZOEFt?=
 =?utf-8?B?aW5VcDQ4V2F2NU5QZmVpaDU1MFVzRE5KWEpGYWFEVy9hSDhvZDRPSm82UHlY?=
 =?utf-8?B?cDAvSnlNYmxGdGNDUFpDd1h6S0RkZTFxcGo0Q2xPcTBMdThTMDZMeGhBWEYw?=
 =?utf-8?B?bGp0Skdjazdrd1djQ0E4TVNOcTJBVnRyNXJlaUJrODRNWVd5Y0FYU21POWJs?=
 =?utf-8?B?ek5PanFWVEpGSFJUYnAvVStSZnJZTzJLYm5Bd3ZEY0tDbW1WRmlydFFaRmYr?=
 =?utf-8?B?TUowZmxyTCszZzVERkpscnRrdXhxc09oQUliSXpPMU5tVGJZZkJ6aE53STdl?=
 =?utf-8?B?VTljTnBpYzB4OXExL0VsaVlYbmtiN2FlcW41SGxBSGpDRzJ5ZjRyWEtpL0hM?=
 =?utf-8?B?dlM1N29DU2JQQmFlMU11MFpEdHlnNVpUTERhRXBYcFdtTU8wZnNXdlFmdHpM?=
 =?utf-8?B?VG1lb1R4MHhva1ZmYVdOTWhxcFRhUm4xNEVXaXNUZUJuL2dNTk9oZ21ZWTg5?=
 =?utf-8?B?b1JOcTBOUlcrdGcya1JPUmtzU0tHSksvUkF6MnpGQkdsNWVzSjBPY01lcnJq?=
 =?utf-8?B?cmtNcUNrS3ZzZmN1OHF5QjJRNnh4N1V6UzI1MEFlZjFZME9JTEVIKzFNbHBL?=
 =?utf-8?B?UGNpLzhPVFgwRXJEMUtwdWh3TkdldTN4REk3UUlySlB0aGxZWHhWaHl0blE1?=
 =?utf-8?B?Rkt1bkEyOHIvUm9ZQ3NmQ0JKbkJxMnNDcTZnZjBGc1VFWGxSTFpvVUJSZllj?=
 =?utf-8?B?UERlZFVvNkY4M3psRGdjcy9ZeVY5TjIrK2Z5V3RMZHRPdDZOSFB4RkZWZkVP?=
 =?utf-8?B?aU1mdENBVTdjaDJTS0ttTm8vRHQ3Wm83d09kajJIL2FPSXp5NnNTSE5YWGtp?=
 =?utf-8?B?czJBRnVZOXYzMGx6SVFLYXZNd1BKUmlJK2tXdjZXNVErZUkzelppenpndGs1?=
 =?utf-8?B?ejVPTEtjajZHM2ZvSkNiTG9YaDgxbXpIT1RPNlJ5OE9uNVB6WFY4WHkxT3g1?=
 =?utf-8?B?dEkvWUUvd0Q0SmRob3VQUWE1aDdzNUkyQ3NZekUwRFJJVFY3NFF6ZUVrZHhW?=
 =?utf-8?B?bkpZeUNhMnlpSHpEWGJuUitjbE9kREFPSGZvTHBZRzhlQit3NTJqZzk4ai9I?=
 =?utf-8?B?dUpzR3BFdGFuQ3EzVlA0cEdva2FIRFdITUhybVR5eFdjMXZZQUs4MStranNx?=
 =?utf-8?Q?9TOgAjLuq31RJQ0KWJnRUjseV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ab9ffc-d1ff-4f61-5ed3-08dbbda909be
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 09:23:11.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upCvyIO/SJ96qcsVVz1ZBqNfKv5iR6Cai7fR6YQPTJXNUgdtvB8evwIiXj2UPVEDe7xFN98Mf7iYUzLl7gm47g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/9/23 18:41, Ingo Molnar wrote:
> 
> * Alexey Kardashevskiy <aik@amd.com> wrote:
> 
>> For certain intercepts an SNP guest uses the GHCB protocol to talk to
>> the hypervisor from the #VC handler. The protocol requires a shared page so
>> there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
>> handler triggers a #VC, there is another "backup" GHCB page which stores
>> the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
>> The vc_raw_handle_exception() handler manages main and backup GHCB pages
>> via __sev_get_ghcb/__sev_put_ghcb.
>>
>> This works fine for #VC and occasional NMIs. This does not work so fine if
>> the #VC handler causes intercept + another #VC, if NMI arrives during
>> the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
>> The problem place is the #VC CPUID handler. Running perf in the SNP guest
>> crashes with:
>>
>> Kernel panic - not syncing: Unable to handle #VC exception! GHCB and Backup GHCB are already in use
>>
>> vc_raw_handle_exception #1: exit_code 72 (CPUID) eax d ecx 1
>> We lock the main GHCB and while it is locked we get to
>> snp_cpuid_postprocess() which executes "rdmsr" of MSR_IA32_XSS==0xda0 which
>> triggers:
>>
>> vc_raw_handle_exception #2: exit_code 7c (MSR) ecx da0
>> Here we lock the backup ghcb.
>>
>> And then PMC NMI comes which cannot complete as there is no GHCB page left
>> to use:
>>
>> CPU: 5 PID: 566 Comm: touch Not tainted 6.5.0-rc2-aik-ad9c-g7413e71d3dcf-dirty #27
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
>> Call Trace:
>>   <NMI>
>>   dump_stack_lvl+0x44/0x60
>>   panic+0x222/0x310
>>   ____sev_get_ghcb+0x21e/0x220
>>   __sev_es_nmi_complete+0x28/0xf0
>>   exc_nmi+0x1ac/0x1c0
>>   end_repeat_nmi+0x16/0x67
>> ...
>>   </NMI>
>>   <TASK>
>>   vc_raw_handle_exception+0x9e/0x2c0
>>   kernel_exc_vmm_communication+0x4d/0xa0
>>   asm_exc_vmm_communication+0x31/0x60
>> RIP: 0010:snp_cpuid+0x2ad/0x420
>>
>> Drop one #VC by replacing "rdmsr" with GHCB's VMGEXIT to read the value from
>> the hypervisor.
>>
>> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
>> Cc: x86@kernel.org
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
>>
>> This is made on top of (which has the "efi/unaccepted: Make sure unaccepted table is mapped"
>> fix for booting SNP):
>> b996cbe1203c (tip/master) 15 hours ago Ingo Molnar Merge branch into tip/master: 'x86/tdx'
>>
>> plus:
>> https://lore.kernel.org/lkml/a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com/
>> ---
>>   arch/x86/kernel/sev-shared.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>> index e73c90c9cc5b..399219de5a9b 100644
>> --- a/arch/x86/kernel/sev-shared.c
>> +++ b/arch/x86/kernel/sev-shared.c
>> @@ -477,11 +477,19 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>>   		if (leaf->subfn == 1) {
>>   			/* Get XSS value if XSAVES is enabled. */
>>   			if (leaf->eax & BIT(3)) {
>> -				unsigned long lo, hi;
>> -
>> -				asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
>> -						     : "c" (MSR_IA32_XSS));
>> -				xss = (hi << 32) | lo;
>> +				/*
>> +				 * Since we're here, it is SNP and rdmsr will trigger
>> +				 * another #VC and waste one of just two GHCB pages.
>> +				 * Skip the intercept and do direct hypercall.
>> +				 */
>> +				ghcb_set_rcx(ghcb, MSR_IA32_XSS);
>> +				if (sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, 0, 0) != ES_OK)
>> +					return -EINVAL;
>> +
>> +				xss = (ghcb->save.rdx << 32) | ghcb->save.rax;
>> +
>> +				/* Invalidate qwords for likely another following GHCB call */
>> +				vc_ghcb_invalidate(ghcb);
> 
> Ok, so I agree with this fix, but could you please reduce the ugliness
> of this open-coded RDMSR by factoring out this sequence into a new
> helper, called rdmsr_GHCB() or so, with a similar signature as
> rdmsr(), where rdmsr_GHCB() emulates RDMSR behavior via a hypercall?
> 
> That makes this workaround to reduce nesting a lot easier to read & maintain
> in the longer run.

Currently it is:

#define rdmsr(msr, low, high)

Will the below signature do?

#define rdmsr_GHCB(msr, low, high, ghcb, ctxt) {( \
	int __ret; \
	ghcb_set_rcx((ghcb), (msr)); \
	__ret = sev_es_ghcb_hv_call((ghcb), (ctxt), SVM_EXIT_MSR, 0, 0); \
	if (__ret = ES_OK) { \
		low = (ghcb)->save.rax; \
		high = (ghcb)->save.rdx; \
	} \
	__ret; )}


rdmsr() does not return a value but rdmsr_GHCB() has to, can even make 
it static inline function, should I?


Thanks,

> 
> Thanks,
> 
> 	Ingo

-- 
Alexey


