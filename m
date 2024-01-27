Return-Path: <linux-kernel+bounces-41227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D437283EDA6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D012843A0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D081128E0B;
	Sat, 27 Jan 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QSlaqoIH"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816B28DC9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366647; cv=fail; b=PycTP87PekrRaJ6ANh9cGgPdgSW4zsnhccZwEmWJYgsxBX5GbmrZcnI/aokBgnhpzHhjlBMUVqX8DeMGEHDilybfXrF2cvVuyVAXgjM4+boHazRFbSPV/MbKAkkO/7tHy9HQKkLBQ5WZIpNHyUHdE4Qpm3v6UW6Ck49ssvHyetE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366647; c=relaxed/simple;
	bh=D7sJer01zibpk1RrsAuwR5qpMAXp21qODaxFvyr9OR0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PkoP4BO40uxJ8PBcgsuMsGvTxJh9ngnkkjrPKMGXBdyLgtBSESL48YdueJC6Ilm7Q2GMeyHkWrbPmlJn2lSEToe5hCG+SvtapeZXtmPF/56qbhM+HLqAD4Jy3P/6ZBFEWNqHs2jAYrWSGLi6ZFqTMKrrENnTQORIkpi0FNeBbyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QSlaqoIH; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGAULDwsAzA157vEJYhJWvhityIF0LV7QHrFQSDYsKtPvL7wQGwx39MYyDh4SK6dNtqRWvlxLH3lDASgn+UkUoC0MGvmDwORKaIhxqft8p4rndcwUTZzlPF2c4Kin0Y8ZDHJp3kWZ7AV/b+SzjyjF0xU4FnBBD/K014qoWFd8fh9LGcX/rCK1qhYzHw8cclSlY+LWqIzboSO5HdcCgyk5nIptBxHHdNRAVJUqpx4GOLj0dZZvlVFtwYUYjEbnJxJXtgzDHIQYaxCu/hvyZl0uzHatkklggatn/xWeyNCsiWEIq2xmy3J4mYYN4l4vxJefzL6jZBf3dVFnInkqyGY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDu58QAhr6T3Akwu16QpAOwjvU+lfgTCDxh+KVfUKZg=;
 b=cebdPuzd6E33k6KR52SutfnvVdwMqBqOziMUE/lYn+NHIHzXKrkZI7egGCJsUX1NFv2HeilniWB0duZq/1hrz3Bm5h/GSXls6+pKMn4lPvVTMB+J3MmT4b+kMIi7BrKHuOQ8sFUd1kB6TnR0SsXFmzzhimwb8Cp4US47HwSwfBEL+aFmLjBXbdDECKnERldepJmDmlBA8Dxh0NacENdQg6SnDsYANZMzWJc3qvPKsk0mgws4OFhlSFDADM9N7qiYbON9hhhFZ61nu776wD533fYBcvrCGgrAsKa4lN5xxGRZ2hjmH/Xbv687/o1R4CdMSkBpzngVm3Z4Thot86QsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDu58QAhr6T3Akwu16QpAOwjvU+lfgTCDxh+KVfUKZg=;
 b=QSlaqoIHfa2oVrFsAVqFAQuXOxmznARVM3bDFM8t915S6SnX2Kw5gb3QV56x5OfzYLTS/Zv5GlI3CH1LhQy85dq+/lbI1ctJWNas7Za7CEN0yfeWMAKHWx2kEF1BZtSFD4kuUNyx/MjPXR7ycRcshgK5ZWHPQwwlL7Q5MTHeZdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.29; Sat, 27 Jan
 2024 14:44:01 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 14:44:01 +0000
Message-ID: <c0e1cd6a-4065-51ac-a398-aa48245f748f@amd.com>
Date: Sat, 27 Jan 2024 08:43:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 04/11] x86/sev: Use kernel provided SVSM Calling Areas
Content-Language: en-US
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <8de29476ed1fcfeae79cbe43ee6dbbfecf7e86ea.1706307364.git.thomas.lendacky@amd.com>
 <CAAH4kHZh1AdjLBNZ-=R6MK3OUmaSSFPWi==C0KVnTOCfVJkYBA@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHZh1AdjLBNZ-=R6MK3OUmaSSFPWi==C0KVnTOCfVJkYBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:806:130::13) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM6PR12MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: b359acc7-9f75-4841-97ab-08dc1f466605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N5dlvG2lwEUG3A05a8+J5/CObVrzDzeBA2UesVqOFNiVboDz9XfF0QPfJ1hYyWWgU3AzgoJECX/o6/9tM/UBDctOoPgELleOPy4/33gtnXmKe+qVLw39kjZ8UL6QqzgRK6lNCwVCkLxwmfTehjSeikBP9PHcAtpCmAmteUblDB/tFZGYLsWcEnNLLWLSS+dinSZAVprY+uMjMqUa/Venlvt0dvhepJCL6QlAVaOE7lmLisg8u5vVEUlnlt34SVbYqMjM8qFXxjiVkG8Ib2xg00AZYV9oHtMlCdZP8vxrJar3/h63lLurey70cnMVBGnLXO0ByeevaQUMyDBAYNatg2zQrFSVW8MQu+zPgIOYSeNsegN5NNOhvRiDrGQf8BL/AZVGVXeVXvSZGSfkn6QvY3esunuvXKxxG6lbzmynMckwxw5GrU709GHozIaDnihuaZt8OkR7ZLoAhKB6EULUyRSr1sghaRHRzkgSW+Udmq/NqtQ/Znl3y9zBfg3BreBX43bobg38T9wEhY+AM7vHEaWMQX+arzelrtOhpWLipx5nCnKCRjspcNu0cVMcdFtkINdb7079ewefde0aDbzbkThE9otxCv+03BoVTj2JiRQPXn+DuT5w93W6PB4SeQ55KHh1nMMJC9576eymBHXEbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(53546011)(6666004)(6506007)(6512007)(2616005)(38100700002)(5660300002)(7416002)(8936002)(4326008)(8676002)(41300700001)(2906002)(6486002)(478600001)(316002)(66556008)(54906003)(6916009)(66476007)(66946007)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0VhNWNDM2pVRitxZ3NkWVE1VEN6VnNja2xDSkd6bG0vMnV5YW1ORkc3Tlo1?=
 =?utf-8?B?QUpGK1EyUUNWMXNkOENZUUVrTWwxcGZCUXgwMk1Yd2I3Z0ZPOTJLV3YzeEVR?=
 =?utf-8?B?WXNhbWkzcU9scG1UWmtWc0FxL1BrRUhFT2pGaEhIeW1CNHVLMzVxb3BxZ241?=
 =?utf-8?B?VXg2ejNOeGhybTRqWFZhZmdkL29BTTVoczl1TVlSL0M2NWxhRDM4c25BMEo3?=
 =?utf-8?B?SHZWbFA5aUlvQ1VnRFJ1dm1Jd3B0bU5QdmlXQVZjaVRCRXkzRzBXK05nSXpi?=
 =?utf-8?B?QkpqOXdZM2s5WlBBZDBoNitXaDN3S2JlUWhieGpWcklqQ1FIU3MzM2VybVJl?=
 =?utf-8?B?Y3Y1RDNIZk05bTlQOUxtTlVpM2FXZTBIZkJqRStKdXptaTdvdDdSd1p1R1Rn?=
 =?utf-8?B?WHNtWmlDNWF0TWxDbDdnYmRWWHQ3Z0oxdU5KeTdUUVNLeTJmWTFMMnMyVVpi?=
 =?utf-8?B?UmllbEtlUmk4aGpOVi81VDVndzByaXBsK2V1OEJDaVN2bWFsSXV5NnF3MFRI?=
 =?utf-8?B?WlJ2NjRtaDFiUStGL1pnN3AxZ01xb2ZOMndzbCtsa3V6NnArMFBvUCsrWVJL?=
 =?utf-8?B?VkxIY3Z5SnRtR1NkQmdJNTBwcEtzWHZSZmxuUzVUL0xlc0F5R2pXakVaTE13?=
 =?utf-8?B?a1pDWmFKa3pNYVdBMnZneTBuT1ZtSGpEblQ5bjYxVjhDRlhZOENXOFF2QkZo?=
 =?utf-8?B?NERUcHNOa1FmUFcrVTVnYzBGNW1qSTJtM0hFVTNUUFZucHY0eWVBZDAvMEMr?=
 =?utf-8?B?Nk5wLzBqTzlwZHEzSlRjUVpyYVJpYXNDYW9XSjlhU3pBK3EySXlSTkxNRUtU?=
 =?utf-8?B?cm5uQUM4VXN0Y2VUcWpwVE9HSlZBSytybk5LOE8zeXVCdjRpQVU3WWdkUzdo?=
 =?utf-8?B?bzhkNmd3cUhaMkJkb1NjenozTnNzOGd1UVdKS1pXZDhQNW1oSkZFYlBLd2s5?=
 =?utf-8?B?dXhKSGVuL2lBWTUzYmFaTTJvWWFRdGM5VWhFREo0SUFFTVlTWnlqYzJkbDI4?=
 =?utf-8?B?U1FibHRPMWhweWhtSko0Q3lKblZ1bGErSitMRWlldVBjNzRXU3FNTFlaSHpG?=
 =?utf-8?B?MGprMVlSS2pYYjhVT0plWFpkUGM5UUp1NVVzTlNUOS90Y05KRlBwMW5Pem5I?=
 =?utf-8?B?TkoyeVpDaUpBeVlsaE1GZ21HdklXKzhVRFpmUVR3ZDd0cGJXeHp1WVZvY2VI?=
 =?utf-8?B?eWltSnNLbHR2amc1b2xSWWVFa0NEbllnS24ySVBScElDVi8zNzNrL29NNVc1?=
 =?utf-8?B?dUNDQ0kwc1BvS2FMK05sUCtoWEtnRDh5QlJnZ0RNaGlQODI4V21QZ25vVHRY?=
 =?utf-8?B?UlNVb21jai9Sa25NRlFxOEhGL042TmxLb1NpKzAzaHMzTzljRWErRWpFaFFr?=
 =?utf-8?B?MHhnRWpSTFpNVlZqZytiWDJLTnZCeVJMQllsVjkrRFRGaExtZDNteVF6SVdO?=
 =?utf-8?B?K21wekludFhRS3VlTE5KbFpWTWJkeS9rRWNzbEpLaVZ3V0tJTTNKVzUrYm5t?=
 =?utf-8?B?N3o5YUNDeTRnVmdPdi9JY3h1L2h5Ti9wZER5S0FEbUMxdTBDZklzVlNDU3c3?=
 =?utf-8?B?TG9zUVQ4OGx1ajV4bnMyZkJ0MFZUZmVwVHNxbHBDN1ZrSTdneDBOVVJGWXVY?=
 =?utf-8?B?UjdaM3JjUGRtdnRMNDNtNHFidXFpWktLVU04WXBJbDFlU2dnUFNqU0hHNXRm?=
 =?utf-8?B?d0JRU1cyQWM5NVNidXVwY0ppcWxGNW1RYVJXVllkcW1nSFhvRlAwdmpQT3F0?=
 =?utf-8?B?UTVwd0tSbUpoQzlEbXNiS3preTlaQ3grVUYraEhzdzE4MzdIZEdTN0pjZlVO?=
 =?utf-8?B?RllQaVlrL0dpMGtMKzFZTEl2MG5uN1lzRi9xcDRkNWZVNXVMUnpXa21OYTFu?=
 =?utf-8?B?WjhjUWZKV21oRFZCTHBTdTNtdzlsWXdDa3FtUUR2UzBjNXF0NHNlaTRHNVM0?=
 =?utf-8?B?cnYxRDVSMHpOb0VRY0hSakQvd0gvTDczUDlHK2pQMkYyaU9NWUsvWXlZREc5?=
 =?utf-8?B?c2gxZDFITytiRmdtTUlBeDZTckY3VE1iV1h4bXhlNDBPb0poNllyVjdkcEYw?=
 =?utf-8?B?QmRYdXZUZks0Q25kODJTZTI5eUNlREtyb1RaYjgzM2s5d084R2laUXh0SWdB?=
 =?utf-8?Q?iNI85IEvlIV/5L1q+dOibmT15?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b359acc7-9f75-4841-97ab-08dc1f466605
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 14:44:00.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQ+NxQRzlUsimDTODvUWhLHneUjTUNPuaCgYsP+a3nOPVM7IB4TivlXo/a3IYcgXw79fG18V9/6lWRrzA72TkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926

On 1/26/24 18:45, Dionna Amalie Glaze wrote:
> On Fri, Jan 26, 2024 at 2:17 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> The SVSM Calling Area (CA) is used to communicate between Linux and the
>> SVSM. Since the firmware supplied CA for the BSP is likely to be in
>> reserved memory, switch off that CA to a kernel provided CA so that access
>> and use of the CA is available during boot. The CA switch is done using
>> the SVSM core protocol SVSM_CORE_REMAP_CAA call.
> 
> REMAP_CA, not CAA.

Will fix.

> 
>>
>> An SVSM call is executed by filling out the SVSM CA and setting the proper
>> register state as documented by the SVSM protocol. The SVSM is invoked by
>> by requesting the hypervisor to run VMPL0.
>>
>> Once it is safe to allocate/reserve memory, allocate a CA for each CPU.
>> After allocating the new CAs, the BSP will switch from the boot CA to the
>> per-CPU CA. The CA for an AP is identified to the SVSM when creating the
>> VMSA in preparation for booting the AP.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/include/asm/sev-common.h |  13 ++
>>   arch/x86/include/asm/sev.h        |  32 +++++
>>   arch/x86/include/uapi/asm/svm.h   |   1 +
>>   arch/x86/kernel/sev-shared.c      |  94 +++++++++++++-
>>   arch/x86/kernel/sev.c             | 207 +++++++++++++++++++++++++-----
>>   arch/x86/mm/mem_encrypt_amd.c     |   8 +-
>>   6 files changed, 320 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index 68a8cdf6fd6a..71db5ba020b9 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h

>> +
>> +#define SVSM_CORE_CALL(x)              ((0ULL << 32) | (x))
> 
> Given that we should expect to see other SVSM protocols used in the
> kernel, should we not have
> 
> #define SVSM_PROTOCOL_CALL(protocol, call) (((unsigned long)(protocol)
> << 32) | (call))
> #define SVSM_CORE_PROTOCOL 0
> #define SVSM_ATTESTATION_PROTOCOL 1
> #define SVSM_VTPM_PROTOCOL 2
> 
> And then
> 
> #define SVSM_CORE_CALL(x) SVSM_PROTOCOL_CALL(SVSM_CORE_PROTOCOL, x)
> 
> or be cute and use symbol concatenation like
> 
> #define SVSM_PROTOCOL_ID(id) SVSM_##id##_PROTOCOL
> #define SVSM_CALL(id, call) SVSM_PROTOCOL_CALL(SVSM_PROTOCOL_ID(id), call)
> 
> So you can just do SVSM_CALL(CORE, 0) ?

I thought about doing things along that line. You could do it any number 
of ways, but it really just comes down to preference. I decided with just 
the explicit SVSM_CORE_CALL() form.

Thanks,
Tom

> 

