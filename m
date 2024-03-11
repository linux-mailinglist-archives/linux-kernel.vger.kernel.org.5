Return-Path: <linux-kernel+bounces-99241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06BD878579
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5676E28274F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7388556451;
	Mon, 11 Mar 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TxaP6kw1"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3951C50
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174471; cv=fail; b=DHrqt68cE86wYfScXceocJo2J0q5ffT/Exer3rkzrS6uSfifH/Sh2Ztv5zGvWBW+jRXWuZ7FMSLoPmrU5p8rCZpJUE7T/PKhwgKpZR9XN8MVg+FqeK9ygihNsGJf0p8Y4GTbSDVuC31iPMd3k4KTCaOvaCniQvOyRRF9Z/NnRyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174471; c=relaxed/simple;
	bh=TgR3aW6yW2OwEwMillVZHuG2xrquNQayDBkbeAITTXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gXoOdvjPckB//Iu1NlMAVmHbOK6Jzi00S8iBHFy132zK7TMzk39YyX8bCrFHfdDe546u84x8KcRYLQGU/WmqrP5wGFiDxE+1NXMsPAmsRpYQ/460khEBSWvnK4a8zPfOLPZBcwNsOJSXUVTNTYx2iuekU1alU9NwJAawY3arr+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TxaP6kw1; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebma8sIcpz9cnj3u7DXlZV9oJXf0E+N4d4Rij4DASvN+mrSZpaMXCckNVyjNQWMj2XdQiiW6KQnJDq0HtLg2HjLEVzDtoaIJk8NuPA0YHugYJbHILkUjdhITnbR60Mi30PsTafKKODKR9hEKE3ouzKExSJNf65t9P4hqX2B3L3ljcVI0kPlilmFuH5ZRVyPjrHVzLTc/8wl6IOC2WYR7Tg/oX1UtIC/FK2Fy0SnqCjZg9/dkNgGRgKpBsDruqFxhg5XldMVeDVKDfL+RUm0MlLBWFURwkOeVKEsLKiCKtlWCKKMQ6asUU26+gOZ1ygZXNukN+BY7M0eLNJa/obe4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGA/nQTR5CkWGjoAOSvpy7emcLH+X8o9TpW4AeV8djM=;
 b=Cp7B/uBV60WzTtXu038BxpLUsa6VkPSpRyfbS1GcZvXJdAItnoxDcVtycbVUkGK+PuHmki9u0LcHr6dBU13tHBWxLm7zgHn8vIN/44ZCoi9GABgzadUO/KIsHpZDZbeX22YGNcgiLCHnDGq9/Uwtv7OtAhfjJplTOF0y9Xh4RJr6RvNxx7+LO2DVqzP7b6bzLJDH/5111JHeADfPlUDxyBCP9dhZO3F9H36va4X+qRKpGd74EHeYjkzskgXlEBLOthUZSEdT1xYFbrPPAKaVbdpk220YVCzXNIXjLlsxG9+mOknd2YybssoLmWo/sa6Up5Au+WlB7SNwWpoW2bisIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGA/nQTR5CkWGjoAOSvpy7emcLH+X8o9TpW4AeV8djM=;
 b=TxaP6kw1I63k6s0fzH+KL6RIwLvwTtORawiNpnsMMQxOQDmXyEAQLTb06aQsIpVgHawPI237rggzQ0TUSPliIaFDo03YesPQsfF+HfntJLxoOmP8dxQKS1SKm9vbhnKpz1VMnclECdzjluy2LArwCh2wKpZFqofSOH8W0qSSuLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:27:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 16:27:47 +0000
Message-ID: <06e02957-4cfe-4dba-a7a3-fa08e7a199c3@amd.com>
Date: Mon, 11 Mar 2024 17:27:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add ring buffer information in devcoredump
Content-Language: en-US
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240311122212.13713-1-sunil.khatri@amd.com>
 <9e1dbcbc-f00e-417c-995e-d9c539292e03@amd.com>
 <34ed7275-e1a5-4d93-8ba1-ef3c597eaef3@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <34ed7275-e1a5-4d93-8ba1-ef3c597eaef3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 51be8f33-a4a4-489b-2d14-08dc41e82f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GHKJhc95zhq3R6qFaPLRWwkzdJC4RdO2wfXbJDEV4H3t8NOc2tAZNo6gnkm1H153DyDOsqObihiKP4dFNhWPjKuXir7aUEMhDip+TJolb14xV4jZXSVXs7txhrNmvVyrB9wq3wqYpFolYR/OhilRxu9ii4JYpiOjqQZMU+frj8utWPtLS5hkb87eC5+DhYp0EDKdSpSnItLpZZ1HhC0J8ad9cDotL+GGEHVerSabunGQrw97uW1osbry6nN1b+60oNgRJNLHWVyJC0I/8Gml9YI7r6xrv7ItO2BsFopGG2nL0DU8LBY0V+OgrGT5wUaFDq/NKnO6AsiuUstZ16RtGSHSKFQvBpOjnBsqnMbTmpt3HpZRUi/Oc0/yLP07dCy75IOmKVm65jigKiNj77ayMLQ1owdWt5kdMXTmJzxNXpr7cc7vzZLC4y0klaLD47mTjo7yL19ps6RFG/xXj8WOZJ5S9ov7rhKtau8eTDXnH6PDjrzDflxkhRaUSqxLPQ60qMnHiF9F6wH9+QHOArEWzO9tDVhbGrfGNh/N11f0oBWLpmRQU2iBGmgFfyUT7USKsD4D68hsPOfLKk1pb1PUF7Kjnt23RgvfEkYl9RO4UNznHP2ibzxCsLZNMavaTkvwoGItJvw8qjFF9y5vvbo2HOGfGLlhWOQ4H7tUeVNhR4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b012eXV5blQrS1dNTTdOTHZOV2d4aGZLU0hvTjVtMnl5ZlkyUjVmMDdTNlhU?=
 =?utf-8?B?Q2VaRHFwbGIySHhtc0hDVUVVdzVUVFZSTVU0WWVzbVBwL3NxQzlyTlZ4ZHZO?=
 =?utf-8?B?Tm9mR1EyY3ZyTzFWcFQvejYzVWVOSEFJTnJwRnRQVlM1OC9XMExFSzF0aHlC?=
 =?utf-8?B?aXRjRm13QXFOSXNTK2dDdVNjRHFLSEtvOWFPeTB1WXZLTXZ5YWM3Ry9Ldi93?=
 =?utf-8?B?SkF4bzhWdXNvaUc2enJ1aU9Jei9ERnFVZEF5Q3RIYzZ1bHlidjRicnZsdXk1?=
 =?utf-8?B?WWRBVGlMNytDd1VheURXaWN2VFoxL3dWeFg0VWZ4aFBxZ3lqckJCMk51NW9h?=
 =?utf-8?B?MXhjVDltUndpMk9qM2ZHMjJZbmJnYWJJNVV5aGVrUVNFajl6WEp5RlJSWU1l?=
 =?utf-8?B?cCtEWWtJallHa2Z3VTJiUlpubVIvWVpSYnlLL1RqdkxNdXFObkNGbkE1MGFH?=
 =?utf-8?B?aGp4WFY2KzdLTnppcTVjTmxISlJwOUo1MjFCU05zRGc5YTY5QUs2QmFIZWhK?=
 =?utf-8?B?TDBFWVNSRUVQNjg0R0Y1d2FTdWlTT1piWWFUTDBUSTAvWXJna2VGU2YwbUdI?=
 =?utf-8?B?ajlMZi9xMFJoY3p5TnM3bVgxQVlWa3QzRTJIa3J4N3pDR29UR2JFWjVvODEw?=
 =?utf-8?B?VU1jeHdrS2IrVGY4bjFtQzNMWjNUOFdTTzRpTVhEV0tzejkrV1p5R2xaUzVq?=
 =?utf-8?B?SUM0aFNjUHBzd1NaZjdtMURVdUZkRzhHNG1lNmlIbTE4TFZHWmtMSzNyenZN?=
 =?utf-8?B?UlpWbVRUV2Zkamg4WW5LM1pDWnhKbVc5Z0hHVjVUWlNVUXk2dW1meERkTk9t?=
 =?utf-8?B?OUZLazFlSWJXZTZEUk9FMVkwWXo3RzhsZnlNQUdCYkh5TkdrR1cvTVZzei8v?=
 =?utf-8?B?WER3TWN0dThEd2M1SVFHaHc5L0g3aW91U3dKSzFncHZFYlVWVW9hMG1wc1Bp?=
 =?utf-8?B?aWJQWjNkZkMrUDZaRXZUd3YvQ0xhM2E0NUdaUTJzd3p5LzBjRVlvdFFPUzlN?=
 =?utf-8?B?THI4VE5sNlVna0JsMVdoeFNXVWVLZElYVEs1dWU0OUxkMjlYWk1rNENWSk9q?=
 =?utf-8?B?QXA0S2VCUFFJUzBLRThWVUVWRlJ3bWsvSm9ialdtYTJmY1Z1WVBrL0FwMDVE?=
 =?utf-8?B?alo0NGVadzVzWTBUMDdJTEw0RjFsYks5S3B3U3lIekIrQnpoZ3M0TWEvdEly?=
 =?utf-8?B?QjdIa3RPdUJXRTFTOWZHTjdMeWZXT2swQVlkU09CZTZYd21aRUkxVWxMVmNZ?=
 =?utf-8?B?K2Z2cGQ0UDBBWmZiMU1ML0d1bkF3cmhucGJrcERSQUZOVW9xY0ZvRTArdUlr?=
 =?utf-8?B?MUhMMHVLOTE4a1FnVEFnd002Q09DNkYyZ2VrRGR5UE9mWlUrTXVRMGovK3ZC?=
 =?utf-8?B?YSsrWXA0L2Z2RUhneFFsNjNuWmlQZ0JmTzRXUnBuVHRMTmlTajlXVE9wR1A0?=
 =?utf-8?B?RjIrM1ZMMERicFZ1VXEwMHQwMU1iVG02RGUzM1JIZUdPVTRaOXdPSWQ4Q01D?=
 =?utf-8?B?VGF3Qkc4YkRocmVEUWZxRC9IYXVYNGVPUUN5QVgxbHludXUra2FrQkJJK1JO?=
 =?utf-8?B?UGNrNi8yYWxpTVJtOU1HOHZzY2VQRXM1VTZJZGhuMjNxdmdITDVDT1dTRXRq?=
 =?utf-8?B?TW5DRHRTNHRkclc1dklPam5nSjdBUGlqaFlFdmVSb0pkSzNvVm1qMXZBUWFt?=
 =?utf-8?B?OUl2bTRad0NJSlNPQWM0em0xbkM2T2xvVlJBT3VRTnFWRjhhOTg5bDEzNGZn?=
 =?utf-8?B?TVRIK085VHVwa09ZQ3lya2VCNFRHUytUZWw3MVoxaTRrMGFRM3FBQ25PTU9h?=
 =?utf-8?B?Y1FZYXRTbWJENE53eTl6YndhejR2R3M1ZGVnWkpGdEY2TDhGakZUQjl2SDVX?=
 =?utf-8?B?SklMTkRXa2QvYVRaSlJWT0R0aEo0Y3gyL0g0YnliczlBVzRUVFd0cmh6UGo3?=
 =?utf-8?B?WitNd0M5MkxxejAycTB3VHlnTjF4NDRKVlZMWmkyTm54V21CbVVxNExnTks0?=
 =?utf-8?B?b3M3SW1HSDgyRDlWT1lvZkVmVzIzUzdqZG5tTjZha1ZUd25EQUhZbUFRS29Z?=
 =?utf-8?B?SDgzRG9sWko1T3VkVnRpUUtLM3FVTTJIQWp4SDBmQ2NvQXI1Qk91MnFWMmtm?=
 =?utf-8?Q?2t6c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51be8f33-a4a4-489b-2d14-08dc41e82f9b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:27:46.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlzUIm5+yl/bPasZAq1ZRuKGo13IG0kSojGm+Jr5IltHYgszPmwcKwZ/phbcnBZE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899

Am 11.03.24 um 15:48 schrieb Khatri, Sunil:
>
> On 3/11/2024 7:29 PM, Christian König wrote:
>>
>>
>> Am 11.03.24 um 13:22 schrieb Sunil Khatri:
>>> Add relevant ringbuffer information such as
>>> rptr, wptr, ring name, ring size and also
>>> the ring contents for each ring on a gpu reset.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> index 6d059f853adc..1992760039da 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> @@ -215,6 +215,27 @@ amdgpu_devcoredump_read(char *buffer, loff_t 
>>> offset, size_t count,
>>>                  fault_info->status);
>>>       }
>>>   +    drm_printf(&p, "Ring buffer information\n");
>>> +    for (int i = 0; i < coredump->adev->num_rings; i++) {
>>> +        int j = 0;
>>> +        struct amdgpu_ring *ring = coredump->adev->rings[i];
>>> +
>>> +        drm_printf(&p, "ring name: %s\n", ring->name);
>>> +        drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx\n",
>>> +               amdgpu_ring_get_rptr(ring) & ring->buf_mask,
>>> +               amdgpu_ring_get_wptr(ring) & ring->buf_mask);
>>
>> Don't apply the mask here. We do have some use cases where the rptr 
>> and wptr are outside the ring buffer.
> Sure i will remove the mask.
>>
>>> +        drm_printf(&p, "Ring size in dwords: %d\n",
>>> +               ring->ring_size / 4);
>>
>> Rather print the mask as additional value here.
> Does that help adding the mask value ?

I think it should help as a reminder that rptr & wptr needs to be masked 
to become valid indexes.

Some hw generations have really crude workarounds where we have to 
allocate an extra page after the ring buffer because the hw is buddy and 
sometimes tries to read command from there as well.

So when we see a hang with some rptr and wptr values which don't fit 
into the mask we will know that the hw has another issue in that direction.

Regards,
Christian.

>>
>>> +        drm_printf(&p, "Ring contents\n");
>>> +        drm_printf(&p, "Offset \t Value\n");
>>> +
>>> +        while (j < ring->ring_size) {
>>> +            drm_printf(&p, "0x%x \t 0x%x\n", j, ring->ring[j/4]);
>>> +            j += 4;
>>> +        }
>>
>>> +        drm_printf(&p, "Ring dumped\n");
>>
>> That seems superfluous.
>
> Noted
>
>
> Regards
> Sunil
>
>>
>> Regards,
>> Christian.
>>
>>> +    }
>>> +
>>>       if (coredump->reset_vram_lost)
>>>           drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>>>       if (coredump->adev->reset_info.num_regs) {
>>


