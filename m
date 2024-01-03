Return-Path: <linux-kernel+bounces-16002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 955778236E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BFD2878DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE11D55D;
	Wed,  3 Jan 2024 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oew1Tknd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04C1D54E;
	Wed,  3 Jan 2024 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWNSLJosEIA5n+0KFyha/QJacYo+/I+/T2v8edcP9ilnMkkvoQh2wt+9ORS+l3DIl2Jd7xM48zprxk/JV2vHHpde9mYqzeLyXQfq0rQaPfZG37BARcOUxDnGYiDJIeQBW63o1TF4XiCRq5pPQmc0cCF8h3+4GL+hLgrzpg/XvZycmWUxQyyZlxG3S/vEaGmyDhwbvlIpPafI71f1tVV6ahMKiUzKSJAGNldxaJc7W/2SQcM41vCyfPNT2x+o6xDI0XpllranqRAV8KJ/yzE+xO7GGeaeCN7YBLe3sNKgAuWd4kvovEnUUcGd3aMGABYx83lChTJoIwuUQdizJt2qoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vd1IHZZ5krAwHRsBd/9dX0mIZXgLV55xkCE0sHWHPjU=;
 b=g5xSAgCyz7Pm2A8AE16i23z2SZ0DKgDaOB7oUTpBF+ZpAgd38RugsYm8uTg3jOw9CkrrEW2OynxnAVu434vde9Yftm2zhG2CenKhxxF/KvUGB1H0ez0ONv8iwcGnuoALnWaDDPdK3R4aN1YUDkEqCe0Ho9fXx0SPVaCbcvmOO6arurQ7ID7kjNxk7obJDU0jRkHEak01dOm9Q1hSsicbV4DWEJmltxALhokmTEovpKwTa3niKdftFN2af1mE1T47uLXyxrVcKQSXVNLVLCW2lxzxgijNFTYLHN6sqxYiHPwWbWf3nm6QlMO8RN+0rhuH7p5WZlx+4y++UlJ/GxH3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd1IHZZ5krAwHRsBd/9dX0mIZXgLV55xkCE0sHWHPjU=;
 b=oew1TkndA6/LWdbBOVBn7wfOs4m3Wc8/COmjl/PwBbQ0uERnbCrP+iIL933Y2M8kZYdprgp6lrET+UtjA6bJ1lFwYFVZxA0uUj0WCrWNCS/nn+LsCBcUUklrLcJszbqxRtRfhWUQxJyzvBawFoP/UAzxhlo6clibYmicu6vBpsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 21:03:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7135.026; Wed, 3 Jan 2024
 21:03:07 +0000
Message-ID: <0ac93544-106a-45a9-a3fe-acb107da798b@amd.com>
Date: Wed, 3 Jan 2024 15:03:03 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 2/2] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, seanjc@google.com,
 kim.phillips@amd.com, jmattson@google.com, ilpo.jarvinen@linux.intel.com,
 jithu.joseph@intel.com, kan.liang@linux.intel.com, nikunj@amd.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
 rick.p.edgecombe@intel.com, rppt@kernel.org,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, peternewman@google.com,
 dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <170240414535.760665.1609957728181418569.stgit@bmoger-ubuntu>
 <d9f3d23d-aba7-4229-bddb-5d6801b22f27@intel.com>
 <978719d8-8492-47f8-afdf-09e7c997b0b3@amd.com>
 <ac9916a9-d83e-46e4-8dee-ecc15775e94c@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ac9916a9-d83e-46e4-8dee-ecc15775e94c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0206.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: c56be7f3-1dc9-43d2-0545-08dc0c9f627e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JxYVbaZlFF2ZrntNSJNgge5FByQQEvBWMYkTsDgKO3H6RB9dUGmWNK7t3KLSENVfgJtGi6N7bCW6LsZGR/5AFoVg5CTUzYChNlj8AAnG5QyuibGRcJwnamKoqXQ0RswJaQj2KacEtILHp72T+ADLX955gZqqbLC6YHgfgz//5nMtjR/3bU9ND0jWwZWdFilZTisXF3yTgESiFgaJg9bmiaRZ0UUWec77bb3sIuu0edShEMPJOAx6s+tZU7Xlnkf1OUtl9tjCH0wMqghF1p0HO9Ko8U7TqkLJDhRT9HW79H/EUBTi/FdL+JhTWlX+DUMYYWOZeszCs9yBtwZXyR+1kVZBu81SSHXC58NJvtPBJ/lvG3s6CQL4ZYJSSa12F7UfAG4wBl5nxsTWzC8ADUnAlBwnJaiUwB/kFOQgQoKWS48SyaMoc8A9Jlk5klsULrt/5YrHUHhPO1RWWiZf+bBBY7dwaCeOKSe/bCRdnt/IINlgBMX49jO9Op+UuW1yIyVXUA6/nyymXIc4e1Cknghm/Z1LRzGEf0HDtCg1mL4qZgHC/OSQS/UwAikwm0SniO9Yo1JevOm8VRCNO8lro1bNrTLs5WNofpznddTqVc+silh4SQiz38RX+LWFZ/f+NN+iBQ9WQkke9+pRjZw0VHG+Xw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(6506007)(2616005)(478600001)(31696002)(66556008)(66946007)(86362001)(66476007)(53546011)(316002)(6486002)(41300700001)(6512007)(36756003)(31686004)(83380400001)(38100700002)(4326008)(2906002)(8936002)(8676002)(3450700001)(26005)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU5WV0xLeGVxLytxQUVqaWpoT0g4OTZuejduUTl4bFJ5MHhJWG1zMWVDNHJG?=
 =?utf-8?B?QnVjUmU0QmNSMXAwQjNSYWw5UE56cjkra0tNQlQ1VE01VVlSaDhXVDVnUnN2?=
 =?utf-8?B?SVp4eENQNlRqSE5Sb2FuOEJ4ZUZVeG1iQU1EbUVRNVNncDljU1RTYUZ3Mjln?=
 =?utf-8?B?UmhYUXg0dE83RUdFUEFwYnI1ZFBKQzhHTUt5dWV5aDRhaGs1c1lHTVhlNnB1?=
 =?utf-8?B?V1RPMittb3JteTVpaE1jd0pFVDNsVTIxY1pJbWZQN0VoZDBvT2dNb2hSdmIy?=
 =?utf-8?B?bDdlemtWZlI1UFJZcVRuYzQyY3VCay9oYWVFQjJBZkJPeFUxbjZPWjlNZi9G?=
 =?utf-8?B?eVdTVVM1OW1vQnc0Q0pFeWZQYVFHS2VZd0tWV1YyMHlhVnhIYTB0MVpudlhE?=
 =?utf-8?B?L1dlVHVPUE4xcFFBMGJQUTk5ZDk1cWxHQkxPOVJ2UzhRQk8zTWU3cUJGQ2Ru?=
 =?utf-8?B?QzlDd05yditWMEY1aEpNY2NwNmRKK0xIZG94V29EVGNhYlVzZzRSOUo3bnpW?=
 =?utf-8?B?emo4ZXlKclJYUzhyMG9TZWNRcWZYMjRpd0VnMVBiNFk3VUxFM2NWV3pqVzZi?=
 =?utf-8?B?NWs5Ym5GTC85bUdrWVZDQzFiSkRxSEVrQk1teTd5cWd6aTNpTFVSYXVyR1lQ?=
 =?utf-8?B?SWtQVzZmTkFaejBzSmdmMW5mbUxFY3MvUnBkRm9ob0RYMDdJZWdrWk1LWGx3?=
 =?utf-8?B?TnE0b24yMUhadnFEQ3dPazNkUDVkSjQrWVpCK2gxU1Q0Qk9pNktHbUdvNTNW?=
 =?utf-8?B?NG9NUVhROXdtTTFURzM2WXhoaXRmMVE1VnlybDI0ejhyZ1N6VDk5am5MK1Ru?=
 =?utf-8?B?UEp5Y0xSb3pvSHMzcEtUTGJGT2hIb1dqbWtKdHppRnN3TWtYWlpFT2diczkz?=
 =?utf-8?B?a2QvdW1tU243U1NLRGpzTjJmYzdrajRmTU5EZU9hbk1YUHlZdTFtdzJndVFK?=
 =?utf-8?B?YlRGOW42WmxtQ3YxcFJyNXhwUUYxK3pYZUtvZGwvR0lLU2xsR0FCb2ZJa2lx?=
 =?utf-8?B?UkZhcGd1elNzOEQ2clNKbTFrVXVPakppaGh1dUJPcFpiMXg2Z3cwZzU3S1J4?=
 =?utf-8?B?cUkxVnNRYTBCenJFelV1R1lva2NWWDNtb2R4eGpLcWtUWEN4MVhzdWxyb0dn?=
 =?utf-8?B?ZkM2K0Yzb1pwcjQ0NDZZR0FjbHcrb3R6Y2ZiallOMHViTEZWWDFVazJ5TXo0?=
 =?utf-8?B?bjhaN0M4alRlelFwODAwUmRkZHFqb1NRTFcvbUZyeC9XUmpFbVljVUlSZG85?=
 =?utf-8?B?UDZLakdiekhmdWl2TG9jRzd6WnhScXZnV0NFQ09hOEQvUVJlSmpZQ0poUWYz?=
 =?utf-8?B?emJhWi8vMzFwdGtpOTZmQWlpQ1JRRWpKRjR4cnE5WEs5MVNSZGJIZUd2djR1?=
 =?utf-8?B?WmxGL0JqSElIMnovVEdzK3p3Z3JhV3VtWmYyQS9TeHA4TEV5YVAxaU44bzU1?=
 =?utf-8?B?MWFKNUZPVWxGWUIvNlphWVE1WkUzak04OWlQdXBsZWRzcEtqR083ZitLTkpP?=
 =?utf-8?B?amNEdU85eW9neFQzQW4wS2RoTVZvcHNNeUt3dDZTY1FlNnYyNzJpWnpwbWll?=
 =?utf-8?B?MnA0WFdjTWNsc1NjVkRob1FnL0V2cVRYbVppV3lOOFZ0eE5ySXNlNXVPT0xl?=
 =?utf-8?B?b0x1bmJmaW9xRjBYQ2o4V2NJRFVJbXFzUVhMK3pEYnFEaVVLQy9QenhGaDFG?=
 =?utf-8?B?K1NlVUtFYUxZTjVTaGc3Zk9yK255U0gvZ2x2VUswY3hKVE1MK2c1UzB0M3RE?=
 =?utf-8?B?NXJ1NGptaWE5cFZpRUdwYTFvM05EV1U0TENVT1JDeDI0NHFqZnBiNnZBWDk2?=
 =?utf-8?B?U3FtMnhIWVNKQzZxcGlXaG9VN0tVSm85UTIxRGpobGdjSm1vamRyU01RT3lP?=
 =?utf-8?B?VkFieVd1dEJHK0tjTUx2RUxnRmVtVjkycE9oZ3RjWE1zVFR3QnlLbzM4Q25u?=
 =?utf-8?B?NFRJZ2tFOHFzUEZ1RnBsK0hrdUNQWTV3N29yOUFnM0tPZ0VkaHJLTEIyeEM4?=
 =?utf-8?B?S3pEdEsxSGN1VkpxVGlPemtoUzVEVWIxQURIcU04dVg4NUtESWZCWitXMi9n?=
 =?utf-8?B?b2tBR3Uxd25lcFdpbHdGUmU2RXdoQW1abzc3cDMrQU5zVkVvb1h5Z245Y1FF?=
 =?utf-8?Q?6Hyk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56be7f3-1dc9-43d2-0545-08dc0c9f627e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 21:03:07.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWxhn+1cU4XZk/EgpZYltn4pUBSN1hPBK2JnQIAtAvnq8xW2ITm4A5qpdbcPIEmo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752

Hi Reinette,

On 1/3/24 12:38, Reinette Chatre wrote:
> Hi Babu,
> 
> On 1/2/2024 12:00 PM, Moger, Babu wrote:
>> On 12/14/23 19:24, Reinette Chatre wrote:
>>> On 12/12/2023 10:02 AM, Babu Moger wrote:
> 
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> index f136ac046851..30bf919edfda 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> @@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>>>  		return ret;
>>>>  
>>>>  	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
>>>> +		u32 eax, ebx, ecx, edx;
>>>> +
>>>> +		/* Detect list of bandwidth sources that can be tracked */
>>>> +		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
>>>> +		hw_res->event_mask = ecx;
>>>> +
>>>
>>> This has the same issue as I mentioned in V1. Note that this treats
>>> reserved bits as valid values. I think this is a risky thing to do. For example
>>> when this code is run on future hardware the currently reserved bits may have
>>> values with different meaning than what this code uses it for.
>>
>> Sure. Will use the mask MAX_EVT_CONFIG_BITS.
>>               hw_res->mbm_cfg_mask = ecx &  MAX_EVT_CONFIG_BITS;
>>
>>>
>>>>  		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
>>>>  			mbm_total_event.configurable = true;
>>>>  			mbm_config_rftype_init("mbm_total_bytes_config");
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 69a1de92384a..8a1e9fdab974 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -1537,17 +1537,14 @@ static void mon_event_config_read(void *info)
>>>>  {
>>>>  	struct mon_config_info *mon_info = info;
>>>>  	unsigned int index;
>>>> -	u64 msrval;
>>>> +	u32 h;
>>>>  
>>>>  	index = mon_event_config_index_get(mon_info->evtid);
>>>>  	if (index == INVALID_CONFIG_INDEX) {
>>>>  		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>>>>  		return;
>>>>  	}
>>>> -	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>>>> -
>>>> -	/* Report only the valid event configuration bits */
>>>> -	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>>>> +	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
>>>
>>> I do not think this code needed to be changed. We do not want to treat
>>> reserved bits as valid values. 
>>
>> The logic is still the same. We don't have access to rdt_hw_resource in
>> this function. So, I just moved the masking to mbm_config_show while printing.
> 
> Why do you need access to rdt_hw_resource? This comment is not about the bandwidth
> events supported by the device but instead the bits used to represent these events.
> This is the same issue as in rdt_get_mon_l3_config. The above change returns
> reserved bits as valid while the original code ensured that only bits used for
> field are returned (through the usage of MAX_EVT_CONFIG_BITS).

We are already saving the valid bits in hw_res->mbm_cfg_mask during the init.

hw_res->mbm_cfg_mask = ecx &  MAX_EVT_CONFIG_BITS;

I thought we can use it here directly to mask any unsupported bits. So, I
re-arranged the code here.
-- 
Thanks
Babu Moger

