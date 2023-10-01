Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7337B469B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 11:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbjJAJku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjJAJks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 05:40:48 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F050FAC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 02:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7L6pU9X047qYajlNPPyxRS8teZhLkWNIIHLaWHDXAU20FEQKgwRW5Yss5iknzq58APO/mgIWyAj9UAabcY8sliGv06zCtZpFqwb83qNvaNemzD6w+fkFaL60Ht5/UT7uDeDNgn+zc5VHdibtRrQjWTBnlnQzkQAl9tVQ6TRChLrj22t2MaVx+OANGLXO9o231tBE+ZURMPKHq5KoLjJvl7cKy0GHwIKjXETuCtyFFLV+xzV2O9Rw6qPll5IwPpqfV1ylxr/tUnLSmAemX5dNoGqWdxRzC2Wmt+2YpjN4+tr/uX+/bmoE5i0YOyHdI92av670hIgtqyGMxP8vtNVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5jXRUfa+8ZF3164fPP6c/9A2ggDaB9ARUZ7KxTvKh8=;
 b=QEFRBYyL1oBHyzeWiXpsCuXZDi2ARh4Q+jeRz86pfdiunFb97bDi7dmmAC3NVnw9KgHo2TEezpOKgFykAwCy4JI0iybcW67Db019zn9syDU/wUp71d50maedxWNKnjfI38CBnaJ86FplDWcw5hB8D2Ez9aKzDWeFeZblEEF9dOmfza+YF0q87oXKct0NW3pDVEIA48phuFD2ONeYZ1eq3iTgW9X1sjQtUu9ZgLMj4QLWKlKnoGloq6NGeyvKwJSjHztVybspPg4DIIkCRmQlCnsYZPy/76ae8e+xZ48ScEDhB9UzhD/kaaSv8Xxl7RAfFxTI6FcAD4t6mXj7FM9gAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5jXRUfa+8ZF3164fPP6c/9A2ggDaB9ARUZ7KxTvKh8=;
 b=T7Ll5K4sVjHrYbLKVXXcJsIDJmo1SAZ6h2y2KF4/1+VlM1Ajt8Zr8A3PfjGtsiK+D1COBdL06FkpfeWd8fJKPPdVZ6tPHRf37XVyc8ap1STU50M3BJK211fv5nopRSPfuNpq9yOlkWARMW9rss02ZL26zXQ1KPKZOvKcWbRsk+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 09:40:40 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 09:40:39 +0000
Message-ID: <e009f70e-32fc-404a-8560-f059b8999895@amd.com>
Date:   Sun, 1 Oct 2023 20:40:30 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kernel v2] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20230926040526.957240-1-aik@amd.com>
 <20230930071759.GAZRfLpz38AAITSZzW@fat_crate.local>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20230930071759.GAZRfLpz38AAITSZzW@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0062.namprd12.prod.outlook.com
 (2603:10b6:802:20::33) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfdac7c-d4ad-421d-f273-08dbc2627867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQbSAmHlBxzfDQJ+bprMm2JMOeivcecSD3Izx4iyjb7qFTKBhc9AimJkZPZwG+72werkrdo0h1z0EAVxFLtFzjVfKGOn81kV9wnyD79CM1BAiItfgZJZoq1+r+53xygCiqIp3AbmG5U/rAgsc+DGs4rzRoEcTaWBgJDubkvKHnA8WLS9/lyknGaigUM4aPy7XrZSN9Oa66SHMuAZ+O9E/ox67TsHs9CS+RIVDL5r+eLMC8enHK/6vW61UXUxYkCQjCOhx0lHo40eZUKVOXGEJLO4cI66C/TRa1CmwJBTvAumfLDZErCgCeKyrcBtDit0ZmSZtdyhPQBfHtGoVAHm7/TogF/0v2N3jbxwOCBbTFXQa9RwAn0mJLqjQkQP3XtTkvKCeSwROJL9A9BuApyXJIWrvTLXzrNz66RL1SMt0ebZON6g/zq3iVu7QZ/qeXpH3deNkh3pzlSmdYnYZ+TLobKtmMjpnvGVdu7JwrVjSHY+1tW0ra+1QKgaEcTeYyNfBKF7ZKD4Z9ACOcmCbo5K8VWH/Lm755OX0nm83rGCVkst8iDMe/rxaO8TIOsMdeXfpxXKXWmF13TgGl8D++ZwdE1tkEBPUMyhE+YYbOTQBUkVwVPn8DtJShecRO6+qX/4U79f+xWE765lhK9brtaurw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(4326008)(8936002)(8676002)(5660300002)(2616005)(26005)(38100700002)(478600001)(41300700001)(31696002)(2906002)(6666004)(53546011)(6512007)(6506007)(6486002)(6916009)(316002)(36756003)(66946007)(66476007)(54906003)(31686004)(66556008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1N5ZVlMMVpXK3ZsT1BXSlZDWndiL29YWitIZVlXQTFJSU1qSjBabTZOZy9r?=
 =?utf-8?B?Yi9yNTFyclptd2l3cGw3TXdCWnRSQUZUaEpaM0o0YncxQXVWclFOMHJHdzUy?=
 =?utf-8?B?allNcUpaQW4xcWdFQ1VhQzUxS3hJMGRLMFIvVEQwakwzd1U2R2xaWm1rVUxE?=
 =?utf-8?B?OHNRRUxUMlJlbjgwckFHanRLSXdQWW94b2ZHRDFPTHBTSnRBenkzVmpDZ2pO?=
 =?utf-8?B?ZEptVU9sRzM3U2Faei9FWTVvVDVjdkoxTmpOVlE1Vlg0R3lvTUJyR21jaTFT?=
 =?utf-8?B?bkc2WnR2MUFuZXpPR1EzdHlka29ERXdKWjFSM1JxZzNScjY3N2llNFZvWFJZ?=
 =?utf-8?B?bFZ1dFZLczJRMnVuMDZ0V1RDc3VBOTBwNDU3L1F1TEhnNjJNNkVDYUJJT1F3?=
 =?utf-8?B?ZXV2VGRpL3l4Mm5RTXVEamZWb3EydVNuNlJ1UVJ6TTFuT3FVb04zMytKT1Nk?=
 =?utf-8?B?VnpHbCtObUNuUzdIdVYwam81WEZKanVDZzVUek1PRGVjUG5ZSDRMZDEzK25T?=
 =?utf-8?B?T25TY2srem5vOFRWK2NBRllBU1A3aG81RlVJQnpqLzlLM3BNdlk0dThUbFVO?=
 =?utf-8?B?SWtoVGw5SG1VUjNWR3ZjUHRMSVl6YmxIMVhHRkRRbWxzQ3JPU0svYjJHNHNU?=
 =?utf-8?B?UkxtTXJ0L3BXS1l0TStxbExmeTJUWDA0aHEwTFd2cU9iOWlVU2dJTWNzMlRz?=
 =?utf-8?B?NjhUejNZMEx6dVJiR2JJL2JZdWsyb2VNcFd3UmhCNHZMdGNBQ2FTbVVZZEFi?=
 =?utf-8?B?N3B1OEtkRDllcnZ0alRIM1g1TFVRUm43MEF4dDZHcEtoYVRaWDZXMkphNXVN?=
 =?utf-8?B?R0JDUTRuaFMrL1ZVTU9meGlXeFBxV0htdzlXWkxCTklIQ1NoMjduMWF4cXBI?=
 =?utf-8?B?R2duQ1hrSzhsalFxcThlWEtQeHNWdmhhT0VKMlhvR2JNUjhKRWkxL1hTSzA5?=
 =?utf-8?B?S0RuUHY2ZHdDeStOa0VSOEhFVEJQNi9MZ29OdUVQaTNlV1QweVU3UG54YmN6?=
 =?utf-8?B?b2ZaNWZuNkJ4SEVhOStZYzRsam03Q1BCYXBjV2lRMjRMN2dvdXlEaW1ETEps?=
 =?utf-8?B?NnBKTXdzV0FsUStsR3piY210aVV4NUR4RnlGOG84VUJNcFZYTHhFRjB2Q2tE?=
 =?utf-8?B?R0JlVlA3S3FlR2p2eWRqWXh0eDlXNnJoQjFzRGdhRVRHV1VEOFd0VGpISTFY?=
 =?utf-8?B?TXlPVWp4akxsbmZDK1ZoaForcVdrNXlCZzhhR2ROek5ZMDgvZHozMVFTU0dG?=
 =?utf-8?B?dnVlVFUxZWN2bGVTS1F2ZjBKSjJwRzIzdmNMM1dPV24wYW1TMmM2SWhuN2dF?=
 =?utf-8?B?eGYrZXI4SnIxc0xudUVBQXprSVhzNzY4ZmhqeDlJd3JMSzlublJJUFJLRy94?=
 =?utf-8?B?YkwyamdJM08xZ0FVd0hEU2lQUDhDNEhYY29namFRQXpxbzVQN21aRFoxSkdZ?=
 =?utf-8?B?VnljbjhZN09NaitQelVDZ21NUzlHdWIzTTNscFFrZTU4UFZTakpScGZualh3?=
 =?utf-8?B?Ly9hMERGdTFwejRrWVJIbk5PaExoRUJlYTEwVUNlYjIrZ2FIYmJmVTBUNjdH?=
 =?utf-8?B?dnRGN0V4cUdDNSsyeHZKbkx2ZHlHYThTVzZqR2o2d1dxb0MrQU9GT1cvRlFQ?=
 =?utf-8?B?TGRkTGVUQXMwcG5QYzIyT3VBZ2phaXM2V3NXckN4UDE3VzcyRHpNOExmZjRy?=
 =?utf-8?B?VDJCelhZaTlMODJqWDZUU2dDWE40NUUrKzNhdGtMazlKeEhTNWpsSlNjSW9s?=
 =?utf-8?B?amsxbytKWldvK2l3cmJRZkM0aE9YSVdnbWJQYU1xTkxWcGdrRGFMTnpQWkxj?=
 =?utf-8?B?QzY2Q0QrREFEUm1MRCs5eG9Ca25BK2Ezc2xBdVJYVE9jdC9BbDVtNHJTZTVj?=
 =?utf-8?B?SERJS29tRkU3UzNHUkkrSnV6STRWdFdPYzZWYTVYWGRiK0Vzd1RLeHNrTEly?=
 =?utf-8?B?Vi9sN0t5WVRSSFU0TnE4VUVYblZZd2FuOTVhS1ovakIvelIvN0dWTnpQU2pz?=
 =?utf-8?B?dTR6WUhYamxjUTl1Qm9XWWhkMTE0WUNhUVc2b3pUTlpyd2dVdVR5SU0yWkxV?=
 =?utf-8?B?a2Y0OGJlaEpjQm5WTTBjYTJ2QXc2ejFucldtSFNOdjl2dXBhejh6RjQ5anZ0?=
 =?utf-8?Q?8ExGdhTWTz60nC3nI2XWzZcMt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfdac7c-d4ad-421d-f273-08dbc2627867
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 09:40:38.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXJtoitP3n408uToIgEsiKBBjz9VEKgpmyDasJ7YXbODtHiTu04lBohWXtXEFRjhXK/KWmyKUMSiNrjTjue3eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/9/23 17:17, Borislav Petkov wrote:
> On Tue, Sep 26, 2023 at 02:05:26PM +1000, Alexey Kardashevskiy wrote:
>> vc_raw_handle_exception #1: exit_code 72 (CPUID) eax d ecx 1
>> We lock the main GHCB and while it is locked we get to
> 
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
> 
> Also, pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst for more details.
> 
> Also, see section "Changelog" in
> Documentation/process/maintainer-tip.rst
> 
> Bottom line is: personal pronouns are ambiguous in text, especially with
> so many parties/companies/etc developing the kernel so let's avoid them
> please.
> 
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
> 
> Drop that splat like we talked.
> 
>> +/* Paravirt SEV-ES rdmsr which avoids extra #VC event */
>> +#define rdmsr_safe_GHCB(msr, low, high, ghcb, ctxt) ({				\
>> +	int __ret;								\
>> +										\
>> +	ghcb_set_rcx((ghcb), (msr));						\
>> +	__ret = sev_es_ghcb_hv_call((ghcb), (ctxt), SVM_EXIT_MSR, 0, 0);	\
>> +	if (__ret == ES_OK) {							\
>> +		low  = (ghcb)->save.rax;					\
>> +		high = (ghcb)->save.rdx;					\
>> +		/* Invalidate qwords for likely another following GHCB call */	\
>> +		vc_ghcb_invalidate(ghcb);					\
>> +	}									\
>> +	__ret; })
>> +
> 
> First of all, this should be a function, not a macro.

Ingo says different, who wins? :)

> Then, it should be defined only in sev-shared.c for now.

sev-shared.c makes me sad. Including .c is not ... nice, I would avoid 
adding stuff to it at any cost.

> Furthermore, it should not be called "rdmsr" or so but something like
> 
> ghcb_prot_read_msr()
> 
> or so to denote that it is using the GHCB protocol to read the MSR. I'm
> sure it'll gain more users with time.

What is "prot" going to signify?

And what about Tom's "x86/sev: Fix SNP CPUID requests to the 
hypervisor", are you taking that one or I have to repost this one and 
the Tom's patch?


-- 
Alexey


