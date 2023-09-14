Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C2F79FF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjINI4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjINI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:56:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B298A1FF1;
        Thu, 14 Sep 2023 01:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhvQ+qTcXEXkGcOkVDmi2fb5FRVWTrqAkZCkVh6YETkdBVvbbLobbDZKm69IDBh+QRYI5kvO+oDozq7o11RsLCHW3Oe7g8VR5sbEXGPzXb8d0eujv0CIWbEUpO/hliMRKewiQqQC5Pzqtuc+DRjN/VAwVzzSy9Jgdvv6tqJ+z/KAcA/oaXgiiI76NyHXZdsJfJ5asU7x5+e5ocnJicJOcsU7wXyyaFStDYhgIk1JEPSsTIOid6bRYweChqkCawva/2ujskFroWTYPpdneALCphfvsRKpVCeVshYqTm27HfK4Gf2nNPmv0y/MKcqn0jfrYjVa9wkyL6AU9PQxtifeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ12PAz8npyD5wFTFC9pFjfNn7tQSQRaCybCWgYa9R0=;
 b=FRkAlLgSwb/gnrxfe7Fc2//vP3rXQOr++gkqRysUDRaMzy5jIYiJyad9/8M70S7i3Asg0UcJaySFBW0Vv6YOiTmlKd7WpNpbB0sgzy387/hObyaRs1OsVPBldGHkYj+ad06Dyl6kiTXX7rrlFKotkdaPuVYJRMTGnCKQjs8ts5/evXuads9ftE7GWJJyQZzU8OvdH8s4SYtBlR/ZtG5DcdCaZiHv/oI3XHwhE3UM6F3Ug1CArsH6SLTMN/1dwRUJHh/BGgawBNfBBvuIKmRv0+kgxAL1nQpwF1sBrsiHjSfS7yMeAYWS0T2/JhJdUrmdIBlc8W9RComoW/aeU85IqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ12PAz8npyD5wFTFC9pFjfNn7tQSQRaCybCWgYa9R0=;
 b=AdAZmBNTDMetxlcIU8rHqZHr5593g6gARAWAqaNv40D2R6d70bgdNa2MkaPjGQ9AnQ1OWNIO0enucyiR7SZtjWQ2rQQwALwyRaQbD6AKqP/No7Lo/OrtJgtY/NQzU1VblprGhI0lHb1qdfZFb8m/G+o11Ivx2ym513O8fxp1hRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 08:55:50 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7%4]) with mapi id 15.20.6745.035; Thu, 14 Sep 2023
 08:55:50 +0000
Message-ID: <f06ef3dd-dd71-4ba4-a4fa-18a08788c035@amd.com>
Date:   Thu, 14 Sep 2023 14:25:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Content-Language: en-US
To:     Jirka Hladky <jhladky@redhat.com>, Breno Leitao <leitao@debian.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>, leit@fb.com,
        dcostantino@meta.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZQHiJxHSSGNk+ul5@gmail.com>
 <CAE4VaGBXO5Joynan_o13XpT=mNrwt4D84NTZF6H62GXJjpMbBA@mail.gmail.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAE4VaGBXO5Joynan_o13XpT=mNrwt4D84NTZF6H62GXJjpMbBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::20) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 26147481-9f41-4425-032c-08dbb50064bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQr8MVu2udN2qEMCZAXB1+7tAJDQx7T2Kq1J8rvYs471ZvW9PCSt4GDp4mzPKgtp/hLx28HlTEzeg9+0Q95SPgSvMil/opK4F3NswdXV9BJ1bPJjHh0F4jME/mLuOtCnoV0qZ/QkxVwa+VsRiQ2Za8g0337VX2b7O+nQsn+35CxCj0wEOWmqhycqWW8qItW4M20mzEXXXNjy7zZ/Rtb5Vr59hyzGLVPDcx4VMQQijFHb0uTw1xXrgvwNhrceQyZoZ/w/E58Vx9KCFO69mD2Z6czyiCkKnuBfwzhbEQY8YkkSzYJn5eVoPUxmhx+1Q0QA3+FBUIe7EtEHf6wDkI9ujX9gbtgYtU/RzHNv0Dp73LSlTF1dD0jFUOyBzeBvB7AgIy8eDTG0VejYSSYKIYSioN6E5uDu9uOpURk8DkJ5HPA9Oq2nh7DkY5XYI7wmhsEYbDqC+aX8uU0ucRWcHfnluvv2VIpTAAi/MC/zgpB4jqPbleygZHmXoPT17bIfy07cBTwYuXwLmL4yAR3Uus3ZrnFPN/whOOyC4IBZOScQ/vKCNMeIqnoZlupJZPTzS0Ej21Wygq0JdJfOhVwmhn+vWpY7ynvIfBoR3/y9HMyxqhUIg3WPZCOIIpp29JXeNP9gVQVfFvoc9ZJJN2CCXXuaeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6512007)(53546011)(6506007)(2616005)(6486002)(26005)(8676002)(44832011)(7416002)(8936002)(5660300002)(4326008)(31696002)(2906002)(41300700001)(86362001)(110136005)(36756003)(66476007)(54906003)(316002)(66946007)(66556008)(38100700002)(478600001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFJrQU9ZT001VFhtQk5iVWtBc00wUjQzdTBJdFI0TXI2ZEV2MXBqNzBicDNX?=
 =?utf-8?B?OGlFYmpvNTRtcmYrUmlRc2lmNzNYLytRaHBzcnZ1aFZzUXhFdHFmUnhKY2Q1?=
 =?utf-8?B?M0drZnlENzRTTGNEODFlQmJ1a1hUVmVaUmJ6ZFJ1aXJuRWJWV2ZwRGwvZ0VD?=
 =?utf-8?B?NUIyT1RiaTQ0TFpqOHcycFBhMlNJNjlqT0k5cDFZTXk1MGVieFd2NnlhRVZk?=
 =?utf-8?B?VThhaVZ6bzY1NU5Rem5wdktXREdzZHVSa254NXkzYStKSklDTjVmc0NlS2V2?=
 =?utf-8?B?YnVSRG1aZndHVjZpUUZ3VkJyeXpTeFdpY3g3blV1QmpCaG41WHhBVngxVlJ6?=
 =?utf-8?B?NUZYUjFibDlGVGZmOFAwTmZ1THhsaFVFL0s5RlFZcm11WE9jajN3WUhWdWFs?=
 =?utf-8?B?K3hkSzVnWHZKcm5iL0xJTkYrUnVNNk5pcUNxVDBDNm1Xck5yS1JncWVucWha?=
 =?utf-8?B?Y0JSMDAyaTNqZGRVYUt4WGNJTm1sYXYyT2NNQ1ZhVlF1R0k2MkUvTjR4c0tB?=
 =?utf-8?B?Qktqa25qY1dienBjTGxqaGRUQWtzYW1pQ3l6ZS9vSFRIaHB2NGpBVE5GZUEy?=
 =?utf-8?B?OGp4ZGZlYWtXUXlpaDZYcWtSaHdSTVVkQS9vTGIrOVVRUEpIU2t3L0tTMVdm?=
 =?utf-8?B?dUtjaitMdjBFcDdGaVlsenNUV0pWQk9DdS9Wdng1WlBZUG9PMHpmaUVvQlFm?=
 =?utf-8?B?Z3lTQzQzbGxwemtNRS9ZWWhKTGJ6dTJGZ0d0b0htYVNodzI1SFFET3FRWFFw?=
 =?utf-8?B?bm41UnFWMDhVd0pudHY4TlFleTRueitwS1FDL1J6Q2FCZjZaTzh5MjZpa3JT?=
 =?utf-8?B?cHB3eFJzajB5cTNiU0NDSHVFaElEeDdJbGVrNFRtYjMzNGtmWTI2cUplQUVw?=
 =?utf-8?B?WmorWlVPL1l5UXdiWFZnSGlEcXV0Q09zMk13RDVKL25LTmtvVzFod1BiSStG?=
 =?utf-8?B?ZHYyTWRRMmVDZDE3SE83UFhFbXRTR1ppeERYWWUyMUd5dHBDZktEc2tteFdH?=
 =?utf-8?B?ZGNtczd2enJuS0RZd2k0Ni96Y1JEalVoM2pmYzBQN3FNdGJGdWpiaXpvcWx0?=
 =?utf-8?B?cVQ4cjIzdHJJV3JOV2hrY1pFczhuRGVxWTZXdWxVcFRmRFliZU1nNVdETk5t?=
 =?utf-8?B?Z3cxelhOaE5pWEpLK1hZZUxKQWpuNkRXelUxRnNnK041dVhKeGFWSjdnZHRM?=
 =?utf-8?B?NEJ4L3BrRXFKNUs3eTV4N1hBNXpMVmdFbEo1cktuY3U0alRLdTExYVllbzRH?=
 =?utf-8?B?UWE0MXNpQjQweEl3U29DcVB6ODNTMnpsU1doNHBNWS9qM0k1OGdXYjlSYlZR?=
 =?utf-8?B?QnRMekgzWVhXdUpBWHVITVJKM3FmM2k5cTJPOHVjdStUR0w1dGRVMDNuYTJh?=
 =?utf-8?B?M0hzTEVvc252eXB4UEYrZWk4UUMrZ1l2UHVENVdQNGI1VHVhakhua1FsZE1v?=
 =?utf-8?B?Vms1ZXR2YjRjcTRnWS8wQk5oL3pBZUQrMXlMSG1ZRHFVZlVoYmlZSDNJaXFs?=
 =?utf-8?B?UDNWeGt0Uy9YNHpVWEQ0VlB0eGJZOVZWbGN6ZFd5YTRzK291dXRaMVJEMXY1?=
 =?utf-8?B?WmhwOHhKaXFsMERTYVNWaS9jcGE5K3NXMzFqRndsUGJlV3R5VGtnaC9YemtX?=
 =?utf-8?B?RHM2NlE2cjZZNHJzZ2EvaHowbTdQZFhGUzhEemluU1kxQ1dhbGRReGU3R0V2?=
 =?utf-8?B?MitOR205Tis1bGw2Rys2NEtuUExDeTlzb1lkSE9VZTd6WHdRc0ljZ0hsNGow?=
 =?utf-8?B?b1VnR2hVdWR4dXJabExQd0ZRSHNYZVlBQThwbUNqY00zd3NHMUFtSHFiZG5m?=
 =?utf-8?B?STZ2VGJ6a2JjemJhOEJseWZNN3Y4a0xiTjcraGV0L1RyZFZlNHFjL3QzRkhU?=
 =?utf-8?B?bVpYM0dsVTI3enh6TmxScTV5TmVYNS9wMnZBMHdtVXdRQ0VkK3F4NFlLeEVT?=
 =?utf-8?B?Qk9qWDNZRGVFVDhKSmNNNFJKYmFQZTZqd3pKUFk5K3cvMTVqVml3c0Z5TTgy?=
 =?utf-8?B?aVpWVUVTcDNIbExiOW9SWGQxTnNTOFgvRmRaYklXMDJNamMvTWpmaW1tNUtJ?=
 =?utf-8?B?RUdvRS82TytpMVVyYk84VVdpck1hZ1RaL2NkbkhVNzZEMjhkSi9kQ3FRcVNS?=
 =?utf-8?Q?GeyuOfm9kenSAtO1w0cTqmHXh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26147481-9f41-4425-032c-08dbb50064bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 08:55:50.0898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3HhdvEUADNXQesNPQR5AkSwV4ZeZNf3Se6gelZ+8l2TZ3Je1WivjxQMmAUvNKsZCTANKyakTCvH2W3AYrWIxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Breno, Jirka,

On 9/14/2023 2:15 PM, Jirka Hladky wrote:
> Hi Breno,
> 
> I'm definitively voting for using WARN_ON_ONCE - in the current
> implementation, we are getting thousands of the same warnings and Call
> Traces, causing the system to become unusable.
> 
>> Anyway, please let me know whatever is your preferred way and I will submit a v2.
> @Peter Zijlstra and @Sandipan - could you please comment on the
> preferred implementation of the patch?
> 

I agree with using WARN_ON_ONCE() to make this less intrusive.

> 
> On Wed, Sep 13, 2023 at 6:24 PM Breno Leitao <leitao@debian.org> wrote:
>>
>> Hi Peter,
>>
>> On Fri, Jun 16, 2023 at 03:29:54PM +0200, Peter Zijlstra wrote:
>>> On Fri, Jun 16, 2023 at 04:53:15AM -0700, Breno Leitao wrote:
>>>> On some systems, the Performance Counter Global Status Register is
>>>> coming with reserved bits set, which causes the system to be unusable
>>>> if a simple `perf top` runs. The system hits the WARN() thousands times
>>>> while perf runs.
>>>>
>>>> WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_handle_irq+0x1be/0x2b0
>>>>
>>>> This happens because the "Performance Counter Global Status Register"
>>>> (PerfCntGlobalStatus) MSR has bit 7 set. Bit 7 should be reserved according
>>>> to the documentation (Figure 13-12 from "AMD64 Architecture Programmer’s
>>>> Manual, Volume 2: System Programming, 24593"[1]
>>>
>>> Would it then not make more sense to mask out bit7 before:
>>>
>>> +     status &= ~AMD_PMU_V2_GLOBAL_STATUS_RESERVED;
>>>       if (!status)
>>>               goto done;
>>
>> Instead of masking `status` against AMD_PMU_V2_GLOBAL_STATUS_RESERVED
>> (AMD64_NUM_COUNTERS?), I opted for using the `amd_pmu_global_cntr_mask`
>> global variable because it seems to represent what the loop below is
>> iterating over:
>>
>>         /* PMC Enable and Overflow bits for PerfCntrGlobal* registers */
>>         static u64 amd_pmu_global_cntr_mask __read_mostly;
>>
>> Also, I think we want to WARN_ON_ONCE() if we see this problem. Right
>> now, it warns at every time we call this function, which makes the
>> machine unusable, but, warning it once could be helpful to figure out
>> there is something wrong with the machine/firmware.
>>
>> Anyway, please let me know whatever is your preferred way and I will
>> submit a v2.
>>
> 
> 

