Return-Path: <linux-kernel+bounces-145960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2E58A5D93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7670D1F22C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F9157A45;
	Mon, 15 Apr 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yrj7Fwsj"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228B1EF1A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713218626; cv=fail; b=VzK8skGy2ClCf4dvC0s6TLlEVMl0VwC0g3W7ZqkwNJElLibkE3Toep4mjY/uTD4QnjHYNR8wBtZZEOHYp/ulMg6Pmg+E2zZcMaChQIl3095QT2ix+jTe/Gw7/X6zLcDcnVC1C50vZED4zZFxY/tWqHIZY/OWpcoGu5BvMFORV0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713218626; c=relaxed/simple;
	bh=J742n1XrXiU/sp/rezaBrJFPzMChZTRX/48Z7SY+Ygs=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=KPZRFEbP7EKF2lzmQfRDMQgugI7nrKnwG70RGuiiXvNn5snonIxrrfI3P+vdHpYLd0Me62ZaV5NiJdam15oj+WgMdEmmmjHFcFsH5vGEae2X+sQQFLG0jwBppnNNHeSc2e7rPFcgum9rosAOIaG45hgd4uNWPoOopClD7wnS5m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yrj7Fwsj; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYqpL9mq0ZFbU2qQIc1uQ+S/IoaV4zPuwnPMVQsTdUBcMsJiKKGWovl1c16l9ERa45tLN2UBLumo1Wv9IIIEzVl5ecIe3VNXXNOk5/d+1MtOd4QzMx+ccbzf7hak7ri6efj9JEbrmAhmqXthFe1MNapPuvxT/ZUXWefnQp5yfb58qJd1zFYYiAUEHLfIYUGaLGTnJaFTL1MZVHB1eNUJakP8U+Qg6oCTOtRqReN6VA8uTDMZFBDAZH7CbJDwQvZGjpdmMv8P/bXVf8rWXWRmIsbC7DlUxbr2+xHCJk48e9UDjYTwpygo5foGA5mcgYGDKRsENWIuAgHIvcNkpG0LVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na0aix/ovaZLr1osBplOGH0oiyYycx4BD0J8zWE9od0=;
 b=U/BDZakwTBnHFE3m5eaymSsexA5vbzPMrZQ52BG7rB5YWOcWHIriknrjzMk90HeOCPsGUQok951ugegSxAelG+dbPL5cUzUwH3RQaOWDRrpYr1ykeb4dELhQppf1nEgQCFtVSqnQhS+KJlMc04B0LM0nowv+jTw5LjUaAY+0o6fuIyD3AdrC7kLHc2za2LKGQoS7iR50qJglFr9/FGJfalB100SReF9KioBxHCw0tLTGyukDUneyISrMEs6I/qglck3ojJG2NYtHu/83Tdnfi9DFh4Xf7nayvjydx4E/3hWuOn3iM4GRxvrqrSoBKUfPdT0YttXy6OwAyLRD5lkISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na0aix/ovaZLr1osBplOGH0oiyYycx4BD0J8zWE9od0=;
 b=yrj7FwsjdvghRbvD0UGJUgiD9+9LeQZk31/LjF0OLUSBe57Dv/jmuPVPBCznHBUaoeQqak8QwFrY4xuheaGJodF2JGvsYH+chIMsjTo6pwffcqmR/3Uvfzk5acz8OLWwaepHCtjqzzpXYkMEmvG/rwwwdsOueUnGNuuQNMDq1s4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 22:03:42 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 22:03:42 +0000
Message-ID: <eb745e16-b3eb-0e9c-59c8-45aa01244386@amd.com>
Date: Mon, 15 Apr 2024 17:03:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
 <1f6f4477-0f2a-434a-8c89-3b5d51d61581@linux.intel.com>
 <19d69960-e548-a2e6-87d9-c463f2851613@amd.com>
 <e286883d-40ef-d749-26a8-7ec6fbd81eae@amd.com>
 <81d05bd9-ef8f-4a3a-a5df-384a82be49f5@linux.intel.com>
 <490a6a10-47d0-0689-432a-cbf22de11ad6@amd.com>
 <7e138229-24bf-447b-b8dd-5340eaa939fe@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
In-Reply-To: <7e138229-24bf-447b-b8dd-5340eaa939fe@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:806:23::21) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f82e27-4e0c-477b-ff08-08dc5d97e9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fxOPwCAehhpWQM0FMhzxjvrRW3AWf/itw70RUepaxrabt9WwnRv+0H5yEkohlfGkvIrnttg/zMWb0zcRhTulLs+Erqb+IdyvGUi4hzlNwIB39Bf5x8Qk4S6YH/yNYJWiNZhiTU6shXiBwX6O5idGbetq+0PT6kwIlSfNQ1mdkvoqgg5fsv29N7VaGag6jILMsOb/vowVNjP7XvOBNYVREgGVwavA68Mbv4QOjEsXR/QsDj5YrmmaFyDaVajrvtGqrUr4i7uOgLRTtUMWIyOKDagTsvet2ty9aNowWsSK5xzl2qRMgjMTp0cb5z5asn8780wvKnEo960F4Q6MF3NlMHcs4UkNLaARpuIpryZ9WdNCq1eFwrAiZlF6l3STvve3fZ7oY3Pl6NlAQhzZiMseX5COCod8XQhp8rQoIGIsX8GblBdvF7QpPgibOjIX2yyPktSQ53OlR49JQrmIa77g/fQuff4uqwaj7bo9SD4gzhLFCyEupR8jrdjRM5N2BX9EavmqZzZsXJ8x+lx25hySGbuirLaqmfmHXppjlW8N3tMqKY1PlZ/Bmo6Pnde8cYomBKKAngQDHahSP58a+64GuolvLUselJoJowzVk5SbHP/DBFlhZ+Sg1KamLPWKOHPAIFXcQOtAk67P+eZMJqxgK5XEwcbZS7ICyfZfeElPEW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW5ORElkSCtkdEdDdmcrWWVsQkMxRTEzWVNBYzJkTkNMY3hSUkluNUEwSlN2?=
 =?utf-8?B?blZFSHZmNkxmWVlDbi80VGpReXVJcG5oR1NsUDZ0bVYxM3JJOEhtdDdBU08y?=
 =?utf-8?B?N1hYc1dwM05DNTl6eENpYWxUNm0xWWJYYytHY1BUY2Z6VXFYVFJRUUFhTVQr?=
 =?utf-8?B?Vzlrbm9Wck9YTk0vemhqL2U3Sk5sMU5VdzlocmRlRE5iRktHSmxhWVRncVlp?=
 =?utf-8?B?SXE1YVNDY3JpelgvRWFpamM3WW11Q3h2VUlaWW5LUWdCaEN1a3JMb2t4aUsw?=
 =?utf-8?B?S01nZU0wZWZkdWk1Lzd5SWJyODFzZzM5cGYxeXh5L1JjOEhpT1J2VzlETDh6?=
 =?utf-8?B?OER4d2phS1c2TlVhVUE1UEV6Ym0yQzY0R0NhaXRtWVRPSnI0TmEydFRKWTVk?=
 =?utf-8?B?anJ3Mk5JbytCVzArN1BIbFJnUUwycGhjRTB3d2NiZG1vLzE1RTYxVkorTGhu?=
 =?utf-8?B?eW1LZFpwTm10aHNPd2xocDdKUjNGZXpjaklEMEF1VUNDU1UzdXY2NUY5b3Bh?=
 =?utf-8?B?UEVacXBnMTlXVVdjOHdySlZnZUhRSEdJbTRkdnA2bU9aaUtYaHFMTFlKUWUx?=
 =?utf-8?B?WFBQcWVMcnhKU3BUTWdHMUZ3VGtGcGRWVG1HZkJCanFMRkZVb3VyU1Bjazht?=
 =?utf-8?B?cmpSK0xRcnN1V3VVR3FRN25DQUQ4TEZUMU9ER0FZK2V6WXNtVXRub3NoK2li?=
 =?utf-8?B?Ky9tQThBNGpRNUttbFBhaU9VNUg4ZUdNdGkzdFZMSUhNenpHb1Zyeno0WVhB?=
 =?utf-8?B?eDViZnZGY05XampGSlhWdzVHcDgzTFVhSWJZdXJ0cjRJTVBnSkJVM0l4TFdV?=
 =?utf-8?B?T1RSSUlCcGZlV2pHVk9JWW5PdjgrMEtaVXNnSUR1Kzg5cmtieEdrLzU4ZTZ4?=
 =?utf-8?B?c2pxZ0hLQVJ4SFdDcUhXeXdtZUIrN3RZZ0UwbTdvWmtFaXBpTkFVZ3NmTXZW?=
 =?utf-8?B?QU5RU2FIZVhERnA2NksxUU9FVHBuRU5UUGdodWg2YkdIcHlHNWhsY1FsbUxz?=
 =?utf-8?B?TzFmRG01YUZjZGNmYUNWd0lVaGFEbjJFSEZNWVpTT3FJR2c5cmY5STFNeS9w?=
 =?utf-8?B?SUpRQmR1YVFydXEzNTZ0a0I3aHF4R1Rpc010M2E0MVAxSVFKUlYvN0U4NVNT?=
 =?utf-8?B?dHBGbmVWc0dRWi96Q1JJOFVZbllHNUxOODBnbHZ3OW5XazFmU0Vhc1BoRHNV?=
 =?utf-8?B?Qm5vWDYxcGdiQVpmZGxJNzI0UFh2RnBaZEE3Sm9yc3hOckVwQ05EcTg0WFpz?=
 =?utf-8?B?cFVGdFQrWVBXSEdaRzh6VURZd3ZMdTcxMHVFdXpUTjZROW5VdHU2Qk90d2c1?=
 =?utf-8?B?MVIzTTlzZmZoMXJPRFBJS2VMUVhZaWEvVklIZVF4dWpia2RSSnRvRjdYbDVO?=
 =?utf-8?B?dk9NOWtMaXRwNlA1bW1QZUl2NXFWTXo2QUNrRFl2U1RpNHhkdS9ZQlluQ281?=
 =?utf-8?B?R0JveWVzYlVPUVVkTWxhbllneWVZMFkvQnh1NnVabHBiNDg1WmJhTlY2SmR6?=
 =?utf-8?B?VkYxVmk5QTQwcTFBN1l0QWNVYmpPUkUrNy9YVHY3Nkt0bUNidTd6YzNHK0pX?=
 =?utf-8?B?ZTdCbnVjcnJkcXNpa1hpWWp5bXE0RGdmYTVnY0lXSjhkMUpsRzdiMnlrQXNN?=
 =?utf-8?B?Y3FTT2dvV1lhM0UvNjA3QTRDTW9tdHM4Vm13cXRUcitsczhSOEpsSUtJandY?=
 =?utf-8?B?cHhKYmNIa0gwc05oTC9pLzZ3bW53YmQxSmxzem9nWEpsYmJURHpZS1Z1M0k5?=
 =?utf-8?B?VjF3UUhRNVZPUTNEZFFjTUV4VDVES1UrU3JJb2luUlhNS3RhT2pCbHI4cmNa?=
 =?utf-8?B?Z2NsTXhBUU11dTBFbS9BM0l4elJzdnJPQlA1bnRMLzM1Qm5IdDd1UVk0RFFt?=
 =?utf-8?B?TE11Z2FXVHErWW8wNWxVVmw1a1I1YVIxQ1dhVjBXUHdRRXZ3aHpsUVZINVVn?=
 =?utf-8?B?N2tScHQ3Qm16UW01TWYwclVEdlBwaXZ5WXhaWlBwRlVaY1d3bWNENmMrTHRx?=
 =?utf-8?B?UmJ5eE40QVpWZk56YzNzZ05aTkg1dnljK1RtNEVjcXRUUmlzRmdHQk9IS0lG?=
 =?utf-8?B?MXNqaDNhMzVJV3drWnQ2clJ3aTRBSXcrdnBGQW85ZnlhMWhVSTRlcS9mczAy?=
 =?utf-8?Q?PcER/87HJZ3Po2SPa11muFc0C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f82e27-4e0c-477b-ff08-08dc5d97e9bb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 22:03:42.4342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ig3L23JABA64WSbhOl1ESXM2BBZVtBUQTp5rILx1O5yix0YJjyYz0+C7U7nQKmkrJbRA+bg/EUAPDrRnclm+4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180

On 4/15/24 16:50, Kuppuswamy Sathyanarayanan wrote:
> 
> On 4/15/24 1:13 PM, Tom Lendacky wrote:
>> On 4/15/24 14:48, Kuppuswamy Sathyanarayanan wrote:
>>> Hi,
>>>
>>> On 4/15/24 12:16 PM, Tom Lendacky wrote:
>>>> On 4/12/24 10:52, Tom Lendacky wrote:
>>>>> On 4/9/24 13:12, Kuppuswamy Sathyanarayanan wrote:
>>>>>> On 3/25/24 3:26 PM, Tom Lendacky wrote:
>>>>>>> Config-fs provides support to hide individual attribute entries. Using
>>>>>>> this support, base the display of the SVSM related entries on the presence
>>>>>>> of an SVSM.
>>>>>>>
>>>>>>> Cc: Joel Becker <jlbec@evilplan.org>
>>>>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>>>>>> ---
>>>>>>>     arch/x86/coco/core.c        |  4 ++++
>>>>>>>     drivers/virt/coco/tsm.c     | 14 ++++++++++----
>>>>>>>     include/linux/cc_platform.h |  8 ++++++++
>>>>>>>     3 files changed, 22 insertions(+), 4 deletions(-)
>>>>>>>
>>>>
>>>>>>
>>>>>> Any comment about the following query? I think introducing a CC flag for this use
>>>>>> case is over kill.
>>>>>>
>>>>>> https://lore.kernel.org/lkml/6b90b223-46e0-4e6d-a17c-5caf72e3c949@linux.intel.com/
>>>>>
>>>>> If you don't think TDX will be able to make use of the SVSM attribute I can look at adding a callback. But I was waiting to see if anyone else had comments, for or against, before re-doing it all.
>>>>>
>>>>
>>>> What about something like this (applied on top of patch 13):
>>>>
>>
>>>> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
>>>> index 27cc97fe8dcd..5aaf626d178d 100644
>>>> --- a/include/linux/tsm.h
>>>> +++ b/include/linux/tsm.h
>>>> @@ -74,7 +74,20 @@ extern const struct config_item_type tsm_report_default_type;
>>>>    /* publish @privlevel, @privlevel_floor, and @auxblob attributes */
>>>>    extern const struct config_item_type tsm_report_extra_type;
>>>>    +/*
>>>> + * Used to indicate the attribute group type to the visibility callback to
>>>> + * avoid the callback having to examine the attribute name.
>>>
>>> Checking the attribute name will give more flexibility, right? Since it is one time
>>> check, it should not be costly, right?
>>
>> I thought about checking the name(s), but what if in the future another attribute is added, then you have to remember to update multiple places. This way you have an enum that represents the related attributes. Is there a
> 
> I think it depends on how you implement the visibility function. If the vendor driver allows all attributes by default and denies few selected ones, you don't have to update the vendor driver for all new attributes. Letting the vendor driver decide whether to support any new attributes makes sense to me.
> 
>> scenario where you would want to not hide all attributes that are related? String comparisons just seem awkward to me.
>>
>> I suppose the config_item and configfs_attr could also be supplied on the callback if that's a requirement.
> 
> 
> I am ok with enum based checks. But lets see what others think. Personally I think checking config attr name is more flexible.

I think we can do both. Supply the enum, config_item and configfs_attr 
and then the callback can decide using the enum and/or the attribute name.

It could be extended to the current extra attributes, too. The enum 
could have a TSM_TYPE_EXTRA (for the privlevel, privlevel_floor and 
auxblob) and allow those to be hidden as appropriate, too.

Thanks,
Tom

> 
> 
>>
>>>
>>>> +enum tsm_type {
>>>> +    TSM_TYPE_SERVICE_PROVIDER,
>>>> +
>>>> +    TSM_TYPE_MAX
>>>> +};
>>>> +
>>>> +typedef bool (*tsm_visibility_t)(enum tsm_type type);
>>>> +
>>>>    int tsm_register(const struct tsm_ops *ops, void *priv,
>>>> -         const struct config_item_type *type);
>>>> +         const struct config_item_type *type,
>>>> +         tsm_visibility_t visibility);
>>>>    int tsm_unregister(const struct tsm_ops *ops);
>>>>    #endif /* __TSM_H */
>>>>
>>>
>>> Why not add a callback in tsm_ops?
>>
>> That's an option, too. Either way works for me.
>>
>> Thanks,
>> Tom
>>
>>>
>>>>> Thanks,
>>>>> Tom
>>>>>
>>

