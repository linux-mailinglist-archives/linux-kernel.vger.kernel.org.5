Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2590B7C8158
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjJMJHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjJMJHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:07:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F1B8;
        Fri, 13 Oct 2023 02:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBsKdMz60csfhz8zI6xS9f/QYzy73ylaMWn//gu29dPZK/hM+AT8bK0uVQVqzPgrI0VO6/vu9PB8cy44r+tYd49HvmMl/IO1ENpFlfzV6k9NxYAxoRsgkDO29UGAGchTVTf9Qn1UE/jac3o7UJ7FSXKYEmWiaLrCx1mDCRvIsVzo8WurwmuGOl/HOjR8iF96JOWvATwYRMWAl3zwhYcHlZLs2H7axiQyhBd7CtqHA+Rxaagu+pVmAAzL4yXHylL7BtPE93eveOlpQ7N5itRzuOkvWQkVOTFm4JqN+f6IS8ISteFQGMtCpeQk2nentCKcBM2/I3SDwu6VpWLP2kqGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JwLptKqrCtzzvTAz1R7QFeackvygPt5WFo6JI6yFNw=;
 b=i0NgLh7j7VHXJSTHxPmqairY4z3RUxOOvYbxSTf5T9pjiQckkTkxuKSVX+kLoqCW0jP5FvK3nbiIj0U0jWwrBrl+LVN9533c000xEuP9mfaTUDwGfGLkFVmmWcxT4wexD1o1iB72kjAjzlbV3rgSti1Nf9JpR5TT5yQvMx4AJ5xGgesrFzuVwshPthFnDtCcoQWl8jUw31Fzc+H0zj/Y3TTX7AMs1ygPuMDXly89Ku8OG1KS7QgybVN4kRz0SxdovXhm4M0+8VQNxHVaXJPCuWkbU5k/Kl3eXbUJtO5uYhx6B4yZhrJZi7DDJP4574jZILYXexSXRLVw3nCO2Q9J6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JwLptKqrCtzzvTAz1R7QFeackvygPt5WFo6JI6yFNw=;
 b=3ZuRA9WHnf78PTCWZMKdxYN7NtMgIgj8oAMsKFXbSoYJaCvYYTjQRVByIXF+ak2vLJ2zDxfYc6RXAXTQN7o20JTB2q4h/rYWSrs64EJTaKBEMtdU4e5hQvKpv+MWnRcTM4RFsrJJfm1ve3dp7sYP597mmXXb1umisHZFu2q0c5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 09:07:00 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::ec22:9c20:11d9:e840]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::ec22:9c20:11d9:e840%6]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 09:07:00 +0000
Message-ID: <6955339f-9bc5-4a84-acdc-205b90d4127c@amd.com>
Date:   Fri, 13 Oct 2023 14:37:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/uncore: fix error codes in amd_uncore_init()
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
 <fbc90ef0-1418-4c7b-8f3e-7dd1a0d7499e@amd.com> <ZSkH64SpvOTOJSpE@gmail.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <ZSkH64SpvOTOJSpE@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM6PR12MB4500:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6b3a05-0f50-4928-dfd8-08dbcbcbc205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXSrn3K3HC9lGWOSrJmFDghQtvlLAcN5Dzxy6/ymynPpD4bTfqlFK2R327aC3HQrsHfqz6OBThd+r/v7qB6od2FAhyP4+4VOOaR4phf42J9KklAXb3JoXdAb0iVUyeYxWd72yeIk7jN1xMVDz1lvbBXByyqXULDFrrEYfDgUeAHH3vseY3viQHUCPmCqQMHf8hX8NlKSNGoNCJMpnoL4TnGM80PJQO/94nkFQqe19yxGT6FCHCqFc5h5d9hyLVl5H9npbb66J1xIv1f6KaEosXHYcG10dMKB7UN00kJLaMU6FAI4U6ShbTuBIRwhpXxIrmSCwCUZNZAAgMapZ/CjGb6mqXeww7MhOYDERaEohDRNNw5qzpehQmrDlfzgEyVciaVS8PWGev+pD2r3AyNos3l/3B9x2i4ZEdAvFddjuWsBghvIIcNZk2KkQzeydRcIrCBMPrjYYep3ZVWXXZfsTXwalK16Rb/utLHYGeEWDQg2tUXcmUb04BLnodSqNaLcjaP65Kpqgw+tRlgfHGtQWnfI2C/BJex/5bW19d078MFQyF5Y3CtAcUrLQEEX0LY+e1K2SIxDTRxiJO4fvbOM1EwGa/U3WOspcSPDNg+4Yi7XyqN5i7DFO9jpbN8MEgBznqaVBD1OQLIDl63pWp1Ncg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(6506007)(83380400001)(26005)(38100700002)(53546011)(2616005)(6486002)(478600001)(31686004)(6916009)(5660300002)(66946007)(66556008)(66476007)(54906003)(41300700001)(8936002)(8676002)(44832011)(4326008)(2906002)(7416002)(316002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blBTaWVoT01acGpNOVN5R056Mzg4VW5LUkYyK0dyb2pvZUcxaTcxMUptajlj?=
 =?utf-8?B?MVZ2TmxUKzdnbE5XZDN2L3FiZlJHNUxPU3lOcmVEWWVENUpKWmdUNE9PcHUw?=
 =?utf-8?B?S1hWLzMrKzVENjI0dFk0T1JHNGlUVTU2dDZqQmVVZDR4N2VOQzdhMERFczFZ?=
 =?utf-8?B?dTY0cXBFeXpEaHB4b3ZXREs5RlhtZmxoazREQnJ2YlU4bkJWZUEySnA1dU9q?=
 =?utf-8?B?eEJaS0p0bG13UFRjbUplWEVZbnV0SnVVWThLRFZma2htOVExQXdOaU1QZ1Rm?=
 =?utf-8?B?TmxLRWh5QUxVMDNpblRsVE5NcURhTnBON0VRZGs5eSt6MzBpMDRnWTMzb0lI?=
 =?utf-8?B?WjE0K1ViUkxWSkpsSW1OU0JWNndFRXBpUERaM1BXUGY3UmFwQVdYOCtMb2kw?=
 =?utf-8?B?eExxNjRyRGhWWjhuR3pTNkRTanl2YU9NOElwOTdHMU5nLzg5alNPU1JqcFM3?=
 =?utf-8?B?NHhRR3ZWVWlRcGlZb1JlQ1dnbzlaRGlSUGpMSXM4UTV6WC9RNFVkd0lUekRI?=
 =?utf-8?B?ZDIzVVRUUWtobXp1MjRMTEptWStjUG02SzZxbG1DczdDQ0hUUUdCUDZIRDhI?=
 =?utf-8?B?eXk0aTNaSjk1VzZmYjhiOEI0RHZxVFhDcnZ5YzZGREN5eStQQkFyUFFiZmpO?=
 =?utf-8?B?cU1FQ1hYVW5lZ2IrOCtNaGhkQUdEcmlZdm0wcWtWbDd0azNZcFhKZTRqOEZN?=
 =?utf-8?B?TEdnV01rUXQ1S3dhOSt2d1Zzc3NacEFzUU8vbjd5UjhEelJ4cy9sUWttYlg4?=
 =?utf-8?B?M3g4bjBpaEk2R0t3RUkxNXNzcVVvTEU0Ly9VSGZmZWdXVTVuRDY2Y2lGMGht?=
 =?utf-8?B?ZjVFeUp0RVdtemFsNjZ6QmpENHRHODNnMzlVRkxGSlJOU3l3TkJCcEhKM3N1?=
 =?utf-8?B?N1BUYVkxVzFpR1dDaWNvb0Ftbnpib25rS0ZxM0NSRjM3S2VXWlR3M2EvTVQ4?=
 =?utf-8?B?MHFlMGdkcmFIdEo0Z1F1Y3NSZEJRMkVrNnM5WFpjcWhMK28vUzZFdEtQMlNM?=
 =?utf-8?B?SExHTldKWWYvTGpGaHF0bVhtOGxHZ0FwUGFKWkQrUnNiQ3kvVk91cXA2eGs5?=
 =?utf-8?B?clhLYmFpOW5WYmtHcGZEWDdJM1oxN2k2VlpwZWRyQUYya01PSzFEelRwVzNu?=
 =?utf-8?B?WFhFMllaZ3lQRktiM1VZZXpWZDlRMFBQN3FNclBtclhvUW5IWHpiRVZBTDFR?=
 =?utf-8?B?dzV0bWR5V1dESUM2VW9CY043TjBnQlphWE5pc2xLUDZMcW1GbG96K2xuQ3Mv?=
 =?utf-8?B?ekpkZ2w1Q0RsVkx3c0dwVXE0bTZaZWo3aGNIQ3JGZEFzMVIwYnBCOUtPLzJK?=
 =?utf-8?B?VG1WTEY5SEx4eGZiWEJrRWhTSEVkTG82eGQvQ0Jac2luZGJEaHZnZU1JbWZW?=
 =?utf-8?B?ZFIxczZtblk5Mk93ZWU5WnRPREhFRlB1Z0NoSllHdURwUHpOSExaVWJiWU85?=
 =?utf-8?B?S0xqckxxMnJGSHQ0bzMrQ1J6MGJBWDQ4QVRsa2J6cUhwRC9CWEt2SENGZ1Js?=
 =?utf-8?B?VFgwVlF6bzRkR05kMHV5VEZCQks3blJON0tnMW01S2E4dmtLa2RpaDl6ZzZ0?=
 =?utf-8?B?cXpEcU91SWFtKzJtYld4amYxMjBndGhqcjRmb1czakJFb1kwUHRYSHJ6aXY5?=
 =?utf-8?B?TkhPekY4cExCb3dZWmJpL0p6SllwKytUbVh4TW9EMFJuOUdXeU5Od3JScGtJ?=
 =?utf-8?B?Z2lPblVub3B6OEk2SDNNam9OMkFHbFZLcnFYc3dXM2dwUHpPZWJ5N3poc1Mr?=
 =?utf-8?B?dWJkcDNyL2pjUi9rVXFPbThvOHNBcGMwcmFqK3Y4RWgrU0NvckpqSnhWbFJX?=
 =?utf-8?B?eDQzbVdTSEJIMS9IU3dNVFZqVUxVeDZNWU1HellXTmpwQXlZMEZpN0JTekJE?=
 =?utf-8?B?VWRPMFdZRmtaQTVTRzJ2VzNaeFlCVVpNSm9COXcydG1DajhhV0Y4RXBCdFk2?=
 =?utf-8?B?YUpIREhSV3I3QXRNaUtycGV2VCtKMmNLZ2pMZzk3SU9mUVdoeHZIOVVCVStS?=
 =?utf-8?B?aFVDdVNHV0VVTnhVWFRtdGtsMHgxTWo3b1BGbmNYeHR1QXprM21nN1lReFc3?=
 =?utf-8?B?Mnp3L2hLVmhOUmo0S24rTWZpRHhneG0vR2N0VHZPN0lIbkJFckV3cTN5MGVj?=
 =?utf-8?Q?IFFzY3TB2T1XbMveYTuGarTCC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6b3a05-0f50-4928-dfd8-08dbcbcbc205
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:07:00.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJAh8oQ1ANpP88HS29TUJ/9EwlI3yD0uRqVLBcuFGmco6Qk6NzSKc0vz6J9L9m25TIt7JjWNHGwrHk5fLYxOjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2023 2:33 PM, Ingo Molnar wrote:
> 
> * Sandipan Das <sandipan.das@amd.com> wrote:
> 
>> On 10/13/2023 12:48 PM, Dan Carpenter wrote:
>>> Some of the error paths in this function return don't initialize the
>>> error code.  Return -ENODEV.
>>>
>>> Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> ---
>>>  arch/x86/events/amd/uncore.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
>>> index 9b444ce24108..a389828f378c 100644
>>> --- a/arch/x86/events/amd/uncore.c
>>> +++ b/arch/x86/events/amd/uncore.c
>>> @@ -1009,7 +1009,8 @@ static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
>>>  static int __init amd_uncore_init(void)
>>>  {
>>>  	struct amd_uncore *uncore;
>>> -	int ret, i;
>>> +	int ret = -ENODEV;
>>> +	int i;
>>>  
>>>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>>>  	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
>>
>>
>> Thanks for catching this. I see that 'ret' remains uninitialized for cases
>> where the hotplug callback registration fails and was thinking if the
>> following is a better fix for this as the reason might not be ENODEV.
> 
> Yeah, passing through the real error codes is usually better.
> 
> Here's it's probably a bit academic, as I don't think we are even using the 
> init return code in the init sequence iterator, see how the return code by 
> do_one_initcall() gets ignored by do_initcall_level() & do_pre_smp_initcalls() ...
> 
> Nevertheless, mind submitting this as a separate patch?
> 

Sure. Will do.
