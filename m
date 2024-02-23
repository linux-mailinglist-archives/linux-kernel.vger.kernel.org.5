Return-Path: <linux-kernel+bounces-77834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16B6860ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E752871D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325AB125D9;
	Fri, 23 Feb 2024 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zSBwmrKM"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CC211CB2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669711; cv=fail; b=KoJubWLhY4y+Zk6hV6GOgdxIOwl7G96hpo/VIKBkoGcdQ1xSf2KFL4VKu+wzZVK8qlBkdNJiwy1Dhm7uoCBeBqQgIOngUY2nC5OitavGDb8TdNQWOIa1FEY9EvyD+hnQEZiDLId8ylv/NeQI4yAPEHe61StZxPDAwr9uiqCSyZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669711; c=relaxed/simple;
	bh=iVj8nfY89Z9LVlF1Dt4LY4+z17IhIBOrMpkhKrRY95M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=By7jc6T7m09FxH7YVBFlo5ZRQsLwa7UahprHGTpXs6yz5B0k75lQxKI7pthTAcyfo4DEkjM1KmdHxZIrqdalRt61ehohowvnQwuz5fVtBOKrIdaNNxqEXj+zvdrQNBa2eUtImlbbaNVkyFZrBMbov+pmR7UM8WlHq/RwAiu4wPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zSBwmrKM; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhMenGa42aEbh6AwvjIfHEFHcGyWFZnSI2yLjKMhubgXwzONXb0jr9ZylBtlHW8KJYBJzgJHFJhkSPt1wProG5boEuX69lHZ0om48ytFjTcWMYmC7yf2jhKLg3UXcgEJLhO/KNbhIPlwLDddI8NdwolhyK9T/IU0mbLkxFl5hXlu+ggINqCVZslTQ3pHz4rZZvi3HP4X5z0htezQnZn9xjqyAE4q98aOcgnF+STA1rTioBUHksWWsgxElT00aSkhMqpyegfy1tho/8ISaXMi99WYPGlWqnqqHTLy5QrsXio8GCIgmaWDLQxWuUVK4HGvx7JHn/hjnaFemKFvpAYjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9OOLRQkIvl5IgRlm8w5h1bi8VuWMK3kzs4qEn46tCU=;
 b=CCFoR8gpoaHY7LfKxg1lNim6ba3bt6yYrnfgdf/qfPycq+jdbxBnGY01i/5K8RgUXZy6HYxlZfMQAw5nMCAWgKT1Xru1ZvJmJ7Js6TmhAgwhngXJeh8z/FIWF/zT3hYOMvl7Af34REF9yc5rItZEd2MpNdZCYtoo3O8e9WBCvhl1pQ3rIunUw3ZQQQa9Raw6Z1+oItznkkU8tlCvZzO94GkDc+fItOvvCp2UKbqtxQIg7WfanhzfEXzJeVRoOKSHNGq1ez8M0V8yOoB1KNaH6Ieu+FVw/c5QVwiS3veRZEERFDKim82O8GTxBWmkuZHSEPaATJP/tns3GabAGceRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9OOLRQkIvl5IgRlm8w5h1bi8VuWMK3kzs4qEn46tCU=;
 b=zSBwmrKMIvN8wmz+7lF4dJAxecn37DsPR4Il/fU2npdcx2dUppsB44V60Mti75LQfS9nvXyZaRvtaHd2BJBgjmUL+eO9X67oSLvF13S13toxqO5UL9SATTRHHBukT9nUwfFw2eJP2YJRNXvDAt+TdyVzFGUwWS7rh39MNg3Pl0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Fri, 23 Feb
 2024 06:28:25 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::ed30:7c14:9d31:bd8a]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::ed30:7c14:9d31:bd8a%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 06:28:25 +0000
Message-ID: <f32b90fe-2d56-4e9e-8f44-c7ee662af43d@amd.com>
Date: Fri, 23 Feb 2024 11:58:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
To: Ankur Arora <ankur.a.arora@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
 torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
 andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <15fcf98c-58c5-fa08-2e21-f3b0baf058e6@amd.com> <87zfvtg2mh.ffs@tglx>
 <f1a5fe09-f4bc-0dc5-edda-6b3e690bc0e3@amd.com> <87ttm0dwhk.ffs@tglx>
 <87bk87c1n7.fsf@oracle.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <87bk87c1n7.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SJ0PR12MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c50f25-ba4e-4456-740f-08dc3438a3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x+gpOruKEKT3eo7IdD+ZT1xwZy8QkoEpycn8fK6AxPmK/ho3A0sBDe8GCn5IEo2lvDznQ6xoADubRF/tWTm1scsFMUn3uDDAJt33Dq4DFlNc80zna5evKep16uX5y4izfCQv8AQFtRRx45r1lmzvBMvwHMj3u3y19NxO+LcKQqy0DROd/BIMqjg0S4H7dMaN9vVYNi/I0HWhRu64jGwwSywGL+A8sVY6cg/tWt463oGPn1r9Eun7LEk3lLP7gYVhv8VJZYyDHKAy6xx+nLwylZ1n8k6zGUf7hDlW0cqCRMPJrnhxQBhm7KQnTfaZB/2GhAYL+El61w78MNG3FiHy9Rpl1abA277eoT5SfjmdsjbNcY7XcyPhWuwHqKX2BlbQ+AutCycqe3ShzBRO9BsPznPaEo3pG3Zqg6K5TON50RIgxxjj1yikA60S5k5fsfptJ2OICvRy8AKH8fLO0cJu+s+ssoGu4gPBcUDOIDFMSZDd2fwFZFilwAMLh/d81eokJ6P7oT8CnlHZKAv/uCoZxtymORC7uuUXk7SgsseS+nQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGdlVTlsbG9ZdW1UYWhsRENTYUZkcnRYaXVDTHNuSFBTbnJadWZwclhaWEZ3?=
 =?utf-8?B?ZnJERFVlUHA1NHd1eDVNdWd2aGdnMi9aMW5ZVUI5WHZYZWhGcVJ0YVdTMjMw?=
 =?utf-8?B?dnhoS2ZvTHdVUE9Vd21FODJEd096dERFTUV4VUo1NkgwUGRBelBTM2k5UVNU?=
 =?utf-8?B?UzNONlJMdnBQNlN2ZWlUSXJhcUxvcUpWTEdOT2JkM2I3Sk1TK1VndDZhQTU5?=
 =?utf-8?B?OHBqWXhNeWx4eGN5Ukg4VG1NUnRmS1AxOVdIblZCZDdDeTcvdHVKWndhbUxw?=
 =?utf-8?B?cjFhM3UySWpoRURFN3M1eWxIR3l1d1J1Qk1VT1A1WjZ4NWZIbGVNRVlsVUIz?=
 =?utf-8?B?djIvNlIvaWlQeU51QkFpTlFrSEFnd3laMHNxUXlwRVMyeE0xTHZLTFNQTktV?=
 =?utf-8?B?L0N4VFcyWmdjQVhpcHZoZFppL0p0cW9jK3FFREFGYWJkb0tnRVpLck5jMktM?=
 =?utf-8?B?Skwra2tMVGJ6RjZDY3dtZEJuNXUyZGl6bDFZTnhqT2RFeUVDVFJVK1Q3cThC?=
 =?utf-8?B?QnVCZi9rMCtEZFMwZEw4ZDU2eGZyWGI5WkJBc0FzTXdESE5weTc1VDNsRUc1?=
 =?utf-8?B?SzFsaTg2VlJzTURTQm5uZDZyS0w0dWg0d1crd2FISGEvZndSa0NRWjR3eStO?=
 =?utf-8?B?Lzd5ZzRrUWFJeVduVUkza0FlWGw0cVgwdFFLSkNzUG9OajVHRXF0Y3JHVklX?=
 =?utf-8?B?N2NocXhQNVBZQU9KcjQyTW5DcWN4TENvb0dxSjFqL2Y0YUhpVFIrVmNNaDd0?=
 =?utf-8?B?SXJsZ1VLZjAyTDBSWmI5Sys5YnZzc1IvTmZzZCtXb2RhbkV1aTdUQmVlc3By?=
 =?utf-8?B?UElpdGNMM011U3hzek5FZzhQNlZYdlZ1UHJxQlE4YnVIWlNIV1RGODh0Nm96?=
 =?utf-8?B?aW5xcWdkcnVHMVY5bnI1ci93c2VFNzJuaklBUllDRlBPRW0yem9VVTJmTEhn?=
 =?utf-8?B?UWxlOEVTenBBVEd4Q0NsOCtFTlMvb2JPYndnZjZWS3RFbE9hMVZOeUtwT1dz?=
 =?utf-8?B?K1IrOUhKSXVLU2dBV3pSa3JURnZWWEluZzhFcEtFeXYyWFRLVk9QODIwVWZm?=
 =?utf-8?B?VnVyWHhTa0UrajB6YjVCWHFKSWtENWszZzJrdGlsK21EcDVyRFRzN0tmNFds?=
 =?utf-8?B?RkFjVkdHd0xCRThxK3pOMExwZjJJQnd3MDVRUVdtYXhLcEtzYUxVS3ZHNGdp?=
 =?utf-8?B?K1BOYXhpZ2FZTzB6a21sd0JoblRZSmQvaWNRVHBiTmZCWTJ2VitSTVgzR25N?=
 =?utf-8?B?aXNLanM4S0VEM0RLUndZZHUvdENLS3JFV0V3bVlHZ1BUSkl2TzFwR2Y4WSt1?=
 =?utf-8?B?bzZXeWJQRzVqNHp3WDZ6N0NJWG82bzJldkJaS3R2L2JFNUZjWnJMN0NnaktQ?=
 =?utf-8?B?aVpMMENuZmU2dm5TbTFjZUdNVVBGRmIzbm00akxzS2ZZU2FpOTdUb1c3UzVh?=
 =?utf-8?B?cFNSR2dROHo4S21MQW1iVXlIR0R4TFdsZUNDRzMvNFNabHZMajVhbysrQ1dT?=
 =?utf-8?B?L3V3bmZYeDd5bUtzeTdBNDVwdTMxSUJNR3hOaW9xOUlNcHRiWGdXVXVPaVFs?=
 =?utf-8?B?UU5JTm5NME1CWVd1N05jWDl3MHMvalVnaXZ0VzdHUlFDcEV5aE80RjFQWU9F?=
 =?utf-8?B?K3UzZm9kM1lnbmYwdEhRUUpLSmxFalB2NzB2WWdtLzN1VExoYk1rdSs1TnRD?=
 =?utf-8?B?Mk1WSjRFbEJ5RTkraXBtbG9YNmRmV3lpR0g3aVo4MDIvenp4UjMwcWRMN2tK?=
 =?utf-8?B?Y3ZCR2FIb3R6cklDd3Z2VXQ5UjZWVkhHNHhwM1RuemMwYm1qY1ozcGRNcU5y?=
 =?utf-8?B?d2paRzNPV2pVdml4RVAxWXNyRE5RWit3Vk5FVjVQeWVZTUU2ejVlYzRtbDhq?=
 =?utf-8?B?bkMrS0FvZnZSUVg0YWIvemYzeXV1S0ppU0xMNlNZYlBWZExsYm5VcC9JK1F0?=
 =?utf-8?B?T2dHUWxOVVRwbkVLZHVtRVAwMWRNcUZwQVZPSG0ySEdOeDhRZXY2MVNnRThY?=
 =?utf-8?B?S1JGcE9kYmZucnN4V3BMMWFXTnFIeUh6S05iK3dVSjMxMHBtYkZCMk5meTll?=
 =?utf-8?B?bnRHSXJKdm5iWXBTNHNKblJDbWRuK2I4QVFvSkQwYk85U1RnWllNMENKRHRl?=
 =?utf-8?Q?VJEXd0udKb5C5aGyp6wQKBz/h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c50f25-ba4e-4456-740f-08dc3438a3a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 06:28:25.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REY5qAgUTCKw65C9r1iVNJTdpR8NPCiOm54LwycQsPq8I5h0SxW86KekjKChL00cb0HSLDeyjzyLlS//GfcjnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469

On 2/23/2024 8:44 AM, Ankur Arora wrote:
> 
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
>> On Wed, Feb 21 2024 at 22:57, Raghavendra K T wrote:
>>> On 2/21/2024 10:45 PM, Thomas Gleixner wrote:
>>>> On Wed, Feb 21 2024 at 17:53, Raghavendra K T wrote:
>>>>> Configuration tested.
>>>>> a) Base kernel (6.7),
>>>>
>>>> Which scheduling model is the baseline using?
>>>>
>>>
>>> baseline is also PREEMPT_DYNAMIC with voluntary preemption
>>>
>>>>> b) patched with PREEMPT_AUTO voluntary preemption.
>>>>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
>>
>> Which RCU variant do you have enabled with a, b, c ?
>>
>> I.e. PREEMPT_RCU=?
> 
> Raghu please confirm this, but if the defaults were chosen
> then we should have:
> 
>>> baseline is also PREEMPT_DYNAMIC with voluntary preemption
> PREEMPT_RCU=y
> 
>>>>> b) patched with PREEMPT_AUTO voluntary preemption.
> 
> If this was built with PREEMPT_VOLUNTARY then, PREEMPT_RCU=n.
> If with CONFIG_PREEMPT, PREEMPT_RCU=y.
> 
> Might be worth rerunning the tests with the other combination
> as well (still with voluntary preemption).
> 
>>>>> c) patched with PREEMPT_DYNAMIC voluntary preemption.
> PREEMPT_RCU=y

Hello Thomas, Ankur,
Yes, Ankur's understanding is right, defaults were chosen all the time so
for
a) base 6.7.0+ + PREEMPT_DYNAMIC with voluntary preemption PREEMPT_RCU=y
b) patched + PREEMPT_AUTO voluntary preemption. PREEMPT_RCU = n
c) patched + PREEMPT_DYNAMIC with voluntary preemption PREEMPT_RCU=y

I will check with other combination (CONFIG_PREEMPT/PREEMPT_RCU) for (b)
and comeback if I see anything interesting.

Thanks and Regards
- Raghu



