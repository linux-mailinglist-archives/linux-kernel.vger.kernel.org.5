Return-Path: <linux-kernel+bounces-71904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F7185AC50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A94228260E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8859E52F9B;
	Mon, 19 Feb 2024 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QyZAqbNg"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA87952F8A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371948; cv=fail; b=j6579pMzpqOsIE3dRdFNdLQ5XJVAp/E/27SkzPcFnmfo42AqIiN+C4VN/npATFIvG3KJXEOPAl3MQ0uuncTHceCGryjSNgcdYrXa72L4Bt1xC744OIXDd7TGHkAyEhGCWkpqPzRMUvovUgMj1iiTNjfVkELO8UoujKZNJMgg1k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371948; c=relaxed/simple;
	bh=MgBGz4wx/BBLio4kfmEC+PJJmyjUMbAhLkIxXD/EUmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=km2G3JsfhHzitnGxIvR64yiwyVTJhI/PfrZ7J4MxuyH3/broy26q92hmboRxQThg6NtYBlpz0zp4/a2PV0+mScyah6e7gZm3KPcwLbTHBsAMp6AtReFyb+UksjPGnULHNP6WETCkHZA+rT8c4lOx8Yx12P/FaSWBzTu59wdnEPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QyZAqbNg; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cmv4Bk1p2zlsyMuAdMsNEoGPLRaN9PjqBDVK6uY8rbf8R2S6DLi3p0TAwJ+sjPnHDAFAw+gYpT05JN5E0DLhdps1HaM0YxjFj5VNqjWnpKOdMPb3YlhLP6VlTAF5IphfTDX3Z36DsSI3rC9a3WluCHjJxHmcbsLDaU3KLcSQTj8t6NVRtya2iTFQIq/RrAQzsvBqhZw9Dw6A9T69LJ1YsMlZAR/ltSdA6AcsBZm0HYMPIODnKkh4F5Wsi3t8Uy5muEG64wAlNIGz8hhmsKyts/LZBrZutOVfv4Bv0whSd3fPlMS0kGLtHh4J6qaU9Uo1BoxVP8jR4N8gBcK9XVKtzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4xP6F9FhvLA7fTpkAUp62kPfDn54ZiqBqAp/z9ehZE=;
 b=E9PaSdkpPlYS6VauSJ2g8ISCKK/+8y2Gj7Mv0b7tqpI6YFonBAea2JXOTP8GY8OJmUevi3GBOzyzImnlufHOZ3aO/6gyYpIE57CjdPPdfn6bB9Hu98oT/ZKbjmO5GUNz5BUY4vD+EgxOkarD0dEHkGXhlcnF6Xt5fXJRl/fRfC99zpSuaueYtJWyTHh8vnS+YZfOB5MjSKu5Qm/zExCHbweeQ3FF5K7LTbQucsgi78fZVIDkcJNQuYXhoBrWiT098HcV9BCxtqk7y2NdwGP8fFHj5BWzDQlsq/f0bVkoUBNLi4TJCW4+sfiNo/iBwGSMayoUVfv9jzW8oF1V9Ue7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4xP6F9FhvLA7fTpkAUp62kPfDn54ZiqBqAp/z9ehZE=;
 b=QyZAqbNgoURc1D6qV+Rev9dBe3J9UZp4C89og9vY3BvssAAJ6B4Q6Og0g5d840FXT7uJEfApH2bM1hvin5CAW57QOXgPV5uEezgn4+y5jxb7aIjllKPVBzaWjB8irPfcMXmFSQ5OTFaxa+m2Si5wDbpmunRkM4s1+BxJIjwdBMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 19:45:40 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::db9b:a5f:5d0a:2a42%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 19:45:40 +0000
Message-ID: <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
Date: Mon, 19 Feb 2024 13:45:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache flush
 during kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com
References: <cover.1706698706.git.kai.huang@intel.com>
 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::16) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: fe253d08-9a93-4f1b-22ac-08dc31835a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d/02X+DBEjLGm1CN6Bvk5vOWXbErNw2FbZf2ALHaGkd+gzs29X/V8KfCZy9jvG07KCIqYTjUa3D4oNDregt7YL6tVQ9uQ2+OBrhIQ8tg8gy9djIgxS5Z9HWBwi89eZoaW0plaSm1WF1rLFWmN1XdrJsaftJ/BXgaEktZBiklxwqKJYLwFJFWUdTtYuQeRvoxQzkpP9OKVQBhpSxU7eI0rDxRDwyjXzFQbacYaVgwfcHNoEIro0O4CiqyPWDuLkUP8F2g+DbDvK7MUxlmf0c0cj4qk8y2h+MSHaglgUlg/nz4ea1F1g0+JkDZygzc375XMlPHyS7Y2GeM8o03FcjP0twloqBc63/x3x8y7d4ifQ2X904EWLWJgYUDgsDkesblgoyP/ivAnTRx4mmextWjq7/+bnYYmn29z/nWht62innzvkceGyRSOtgRZkDf70tWlv5IucFve159R1ypn6MOPKTDQ+GE93oOYMV+xBxrsSKnY8PsQhMrGQr0Bu24pDbqSavF8nlaFa2bOe39mPKs5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDFWRmJzb294VXZldS9FSjBYQTV3U0NlKzMvQ0U1L0xZbG5DQzJhUFc3WGY0?=
 =?utf-8?B?dC8rNGNka29sRzhxajdNLzFwOWUzTFFaM3FyUGM1aWp4TFJYd2hGVjJFbDFG?=
 =?utf-8?B?MjZoRGFNRE90dncrNTFlaUtHQ2FLZkI5eXlsMW1BTmgvVFVVV3Y0S1VvcEdI?=
 =?utf-8?B?U1diMmgzLzE5YkhHcHllVjdDeXpobk5sL0Y4SlozTGk0dUVONk5TRGVkRFBj?=
 =?utf-8?B?bEJzSHpyOTRXMlN5NmhRVU9WZDh0NHlzaGVUUzlFQUlYUk5pakdwaXZhVk5L?=
 =?utf-8?B?VHFYdUlZTFV0emtjdWlhbjBiUzg5NVlpOTdWam5RZG5Mbm02ckxHVVM0WXZU?=
 =?utf-8?B?eVBxbHJSYnlnc29Zd1VuSzUxYkd1WE83dlR6ZjBIeFAyeFI5YXVVNm15S2hY?=
 =?utf-8?B?UlFrSzVGTmppUkM2dEpjVFJraUZhS0lEUDRaZkZHR1hPcUtOWnY3NzlZc3hp?=
 =?utf-8?B?bWh2MkhkK2VHYzJVR2luajd2K1EzTVpZQUt4YmJXaHNkUkduV09oVE5sWW5j?=
 =?utf-8?B?NXdCT08zMmczQVJLUFRxZ3VCRVZFWVBRc21UNjBYNldQYk9oZlJqNkpvZnZC?=
 =?utf-8?B?blBrTVRjQnAvNjlaSHRkcmxDL0VIaEpRcnM5RUlHOEVpVm43c1kvVk1XTXFB?=
 =?utf-8?B?M1NyNENLeGZNTERMeG43bTJzT2d0Nk03V2kwNXVJa0hHamYrWUNVdXcyZ1Zk?=
 =?utf-8?B?V1RLUzZSTGp1RXNFTnhEbE9IekRUdVZlNUFDTkhESlFPT3h6ZXlBL0JQOUFQ?=
 =?utf-8?B?dDh5WU1hbnlRbEdxY3BLdzJNSG12T0NpMDNmVVp0eXdWa3BWUE92UEcvUDh6?=
 =?utf-8?B?ellydEt0c3FjcTZieWlvZ0RBWkdiNjltcHBTL2JpSDhrZW1RMnpSWWVQeWRx?=
 =?utf-8?B?aXNNTW5hNS9ydEx6Sk5VU3ozM09BYUlrN1B2QUcwdVJ6TDIxYndnbmttazls?=
 =?utf-8?B?Q3o3dUxpbDRXeUd5UTlBVU5EbFJsL21BTVVCZFpYdHVGaWlnTG5aRlNUUWxp?=
 =?utf-8?B?R2F0aVl5QmhUUXY2VUZCVTloT2ZtSVdkcTdJSnU2SVg5MXhHZllHOWxSNDNK?=
 =?utf-8?B?RmtrZnRrWGFSL0pQeHBWbVQrQXpsemdvY2h3Y25lR2hoTFhFenBXelJTS1FH?=
 =?utf-8?B?aHVpMmxQV2ZQSFcrZVZkTTNUOEN2UTlOK3ZoTmJHdkI0aGZOWEcwQktYSFBB?=
 =?utf-8?B?UlFxWTJEVEFKcDRmbzM5NUx1anU2UkN4V0NaUTJGUzVwYk9nMEM3VUhEUkxU?=
 =?utf-8?B?U3BhL0hyVXFZU2c0UXVGUGlOOWVnUkR0SnNSWUpmdDArdFZnZFZHYktabmZi?=
 =?utf-8?B?Z2QwZnplcGJRNDNqelpFTXZPUk1NRTJPTndDSHkrQzMwdDZ4eE4yYVZHMmJ6?=
 =?utf-8?B?bERQUXl2Z1lDb1VIUllieGo0UjBvT0ZHWkJRN0xqNWVNVGJ1VThpS2RwRjJY?=
 =?utf-8?B?c01zQ0wzVkd3WjMrSDAwK2czUGZVS28vOVNmL3owZXYycm1qS0U2NHJMQmZn?=
 =?utf-8?B?R1lEbitYS0FkbCtYSVk4bU1SWTR1ZnpkWFM2SEVJb0VTVTVlUDhrYzZrUEJK?=
 =?utf-8?B?NW9tSDZGbE9LbVNOdEUrbzgzWFdObS94OVhUSEdyc0NyUWlMaUp1Y1IwczRT?=
 =?utf-8?B?dWVLZWcxbmtmZTMvd1JDUTJEbFk0cEVKbDZ1cUlzUU5YU296NjFiVGJPVEFQ?=
 =?utf-8?B?SFhmbmFNcU5qeXR4WHFDY0t4UzEreDZKRDFUQndBMGk5Kzd6OVNaMVFkeGxm?=
 =?utf-8?B?TFJ3WTMxNWp2eTNRajRGMyszM0M4T3EwT3NFZXNKcDNLL00rdE8yU0dQSnN4?=
 =?utf-8?B?RmhoRmxQbXFHSlFHNHNCWVVtQnI3MHJhRVpRb3Fscld5R0E1UG8wdG9KdC9y?=
 =?utf-8?B?ZWxVSlhVeDRnazRweGJsTEpmcmI0L0lBYlFJTEtRakdxWnl4Ni8vUnJnWFpZ?=
 =?utf-8?B?SWU4L2t4TTNDeUl1UHVGZ1B2dTFtV1ZKOUhPTGQzQVFVbW1kV3BKczc1clFG?=
 =?utf-8?B?a29VbnhvR2c3eE5NTUZxb25SZjc2TDlKKzVCWU1nMTFham1ocnc1TTNicGlG?=
 =?utf-8?B?a0pXcFRpbFZLZmNEcERoblNOMkZvL0Q5K2hVRzd6VC9iU3M0UjZYLzg3blFZ?=
 =?utf-8?Q?DacHoc6V2CyzAGaVY2S9rH0I4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe253d08-9a93-4f1b-22ac-08dc31835a3c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:45:40.5298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JT/vEonoczHzSFWcQA8j84Hl/nUtFdMclzhY6bBkLq0trR9WleQ7O+XTJnmIgiu2ORmwfwhQfEbWIsvIRjhbuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154

On 2/19/24 10:16, Borislav Petkov wrote:
> On Wed, Jan 31, 2024 at 11:31:53AM +0000, Huang, Kai wrote:
>> From: Kai Huang <kai.huang@intel.com>
>>
>> Currently on AMD SME platforms, during kexec() caches are flushed
>> manually before jumping to the new kernel due to memory encryption.
>> Intel TDX needs to flush cachelines of TDX private memory before
>> jumping to the second kernel too, otherwise they may silently corrupt
>> the new kernel.
>>
>> Instead of sprinkling both AMD and Intel's specific checks around,
>> introduce a new CC_ATTR_HOST_MEM_INCOHERENT attribute to unify both
>> Intel and AMD, and simplify the logic:
>>
>> 	Could the old kernel leave incoherent caches around?
> 
> 	"Is it possible that the kernel could leave caches in incoherent state?"
> 
>> 	If so, do WBINVD.
>>
>> Convert the AMD SME to use this new CC attribute.
> 
>> A later patch will
>> utilize this new attribute for Intel TDX too.
> 
> Yeah, once those are all in git, the concept of "subsequent patch"
> becomes ambiguous depending on how you're sorting them. So try to read
> that commit message out of the context of all those "subsequent patches"
> and see if it still makes sense.
> 
> IOW, you should strive for your commit messages to make sense on their
> own, without referencing other patches.
> 
> In this particular case, that "later patch" can go.
> 
>> Specifically, AMD SME flushes caches at two places: 1) stop_this_cpu();
>> 2) relocate_kernel().  stop_this_cpu() checks the CPUID directly to do
>> WBINVD for the reason that the current kernel's SME enabling status may
>> not match the new kernel's choice.  However the relocate_kernel() only
>> does the WBINVD when the current kernel has enabled SME for the reason
>> that the new kernel is always placed in an "unencrypted" area.
>>
>> To simplify the logic, for AMD SME change to always use the way that is
>> done in stop_this_cpu().  This will cause an additional WBINVD in
>> relocate_kernel() when the current kernel hasn't enabled SME (e.g.,
>> disabled by kernel command line), but this is acceptable for the sake of
>> having less complicated code (see [1] for the relevant discussion).
>>
>> Note currently the kernel only advertises CC vendor for AMD SME when SME
>> is actually enabled by the kernel.  To always advertise the new
>> CC_ATTR_HOST_MEM_INCOHERENT regardless of the kernel's SME enabling
>> status, change to set CC vendor as long as the hardware has enabled SME.
>>
>> Note "advertising CC_ATTR_HOST_MEM_INCOHERENT when the hardware has
>> enabled SME" is still different from "checking the CPUID" (the way that
>> is done in stop_this_cpu()), but technically the former also serves the
>> purpose and is actually more accurate.
>>
>> Such change allows sme_me_mask to be 0 while CC vendor reports as AMD.
>> But this doesn't impact other CC attributes on AMD platforms, nor does
>> it impact the cc_mkdec()/cc_mkenc().
>>
>> [1] https://lore.kernel.org/lkml/cbc9c527-17e5-4a63-80fe-85451394cc7c@amd.com/
>>
>> Suggested-by: Dave Hansen <dave.hansen@intel.com>
>> Signed-off-by: Kai Huang <kai.huang@intel.com>
>> ---
>>   arch/x86/coco/core.c               | 13 +++++++++++++
>>   arch/x86/kernel/machine_kexec_64.c |  2 +-
>>   arch/x86/kernel/process.c          | 14 +++-----------
>>   arch/x86/mm/mem_encrypt_identity.c | 11 ++++++++++-
>>   include/linux/cc_platform.h        | 15 +++++++++++++++
>>   5 files changed, 42 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
>> index eeec9986570e..8d6d727e6e18 100644
>> --- a/arch/x86/coco/core.c
>> +++ b/arch/x86/coco/core.c
>> @@ -72,6 +72,19 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
>>   	case CC_ATTR_HOST_MEM_ENCRYPT:
>>   		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
>>   
>> +	case CC_ATTR_HOST_MEM_INCOHERENT:
>> +		/*
>> +		 * CC_ATTR_HOST_MEM_INCOHERENT represents whether SME has
>> +		 * enabled on the platform regardless whether the kernel
>> +		 * has actually enabled the SME.
>> +
> 
> "represents whether SME has [been] enabled ... regardless whether the
> kernel has enabled SME"?!?
> 
> I think this needs to be:
> 
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index d07be9d05cd0..e3653465e532 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -67,6 +67,13 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
>   
>          switch (attr) {
>          case CC_ATTR_MEM_ENCRYPT:
> +
> +               /*
> +                * CC_ATTR_HOST_MEM_INCOHERENT represents whether SME has
> +                * enabled on the platform regardless whether the kernel
> +                * has actually enabled the SME.
> +                */
> +       case CC_ATTR_HOST_MEM_INCOHERENT:

This change won't return the correct answer. The check needs to remain 
against the sev_status value.

>                  return sme_me_mask;
>   
>          case CC_ATTR_HOST_MEM_ENCRYPT:
> 
> 
>> +		return !(sev_status & MSR_AMD64_SEV_ENABLED);
>> +
>> +	/*
>> +	 * For all CC_ATTR_GUEST_* there's no need to check sme_me_mask
>> +	 * as it must be true when there's any SEV enable bit set in
>> +	 * sev_status.
>> +	 */
> 
> Superfluous comment.
> 
>>   	case CC_ATTR_GUEST_MEM_ENCRYPT:
>>   		return sev_status & MSR_AMD64_SEV_ENABLED;
>>   
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index bc0a5348b4a6..c9c6974e2e9c 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -358,7 +358,7 @@ void machine_kexec(struct kimage *image)
>>   				       (unsigned long)page_list,
>>   				       image->start,
>>   				       image->preserve_context,
>> -				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
>> +				       cc_platform_has(CC_ATTR_HOST_MEM_INCOHERENT));
>>   
>>   #ifdef CONFIG_KEXEC_JUMP
>>   	if (image->preserve_context)
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index ab49ade31b0d..2c7e8d9889c0 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -813,18 +813,10 @@ void __noreturn stop_this_cpu(void *dummy)
>>   	mcheck_cpu_clear(c);
>>   
>>   	/*
>> -	 * Use wbinvd on processors that support SME. This provides support
>> -	 * for performing a successful kexec when going from SME inactive
>> -	 * to SME active (or vice-versa). The cache must be cleared so that
>> -	 * if there are entries with the same physical address, both with and
>> -	 * without the encryption bit, they don't race each other when flushed
>> -	 * and potentially end up with the wrong entry being committed to
>> -	 * memory.
>> -	 *
>> -	 * Test the CPUID bit directly because the machine might've cleared
>> -	 * X86_FEATURE_SME due to cmdline options.
>> +	 * Use wbinvd on processors that the first kernel *could*
>> +	 * potentially leave incoherent cachelines.
> 
> No need for that comment anymore - people can grep for
> CC_ATTR_HOST_MEM_INCOHERENT's definition simply.
> 
>>   	 */
>> -	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
>> +	if (cc_platform_has(CC_ATTR_HOST_MEM_INCOHERENT))
>>   		native_wbinvd();
>>   
>>   	/*
>> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
>> index 7f72472a34d6..87e4fddab770 100644
>> --- a/arch/x86/mm/mem_encrypt_identity.c
>> +++ b/arch/x86/mm/mem_encrypt_identity.c
>> @@ -570,9 +570,19 @@ void __init sme_enable(struct boot_params *bp)
>>   		msr = __rdmsr(MSR_AMD64_SYSCFG);
>>   		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
>>   			return;
>> +
>> +		/*
>> +		 * Always set CC vendor when the platform has SME enabled
>> +		 * regardless whether the kernel will actually activates the
>> +		 * SME or not.  This reports the CC_ATTR_HOST_MEM_INCOHERENT
>> +		 * being true as long as the platform has SME enabled so that
>> +		 * stop_this_cpu() can do necessary WBINVD during kexec().
>> +		 */
>> +		cc_vendor = CC_VENDOR_AMD;
>>   	} else {
>>   		/* SEV state cannot be controlled by a command line option */
>>   		sme_me_mask = me_mask;
>> +		cc_vendor = CC_VENDOR_AMD;
>>   		goto out;
>>   	}
>>   
> 
> So you can't put it before the if - just slap it in both branches. Geez!

I think that will still work because sme_me_mask and sev_status will both 
be 0 on bare-metal if 'msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT' doesn't 
evaluate to true. However, that will cause any platform that hasn't 
enabled memory encryption (see SYS_CFG MSR), to also perform the WBINVD.

The idea looks like it was to keep existing behavior where cc_vendor 
wasn't set if 'msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT' is false.

> 
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 0166ab1780cc..1e4566cc233f 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -549,6 +549,8 @@ void __init sme_enable(struct boot_params *bp)
>          if (snp && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
>                  snp_abort();
>   
> +       cc_vendor = CC_VENDOR_AMD;
> +
>          /* Check if memory encryption is enabled */
>          if (feature_mask == AMD_SME_BIT) {
>                  /*
> @@ -597,6 +599,5 @@ void __init sme_enable(struct boot_params *bp)
>   out:
>          RIP_REL_REF(sme_me_mask) = me_mask;
>          physical_mask &= ~me_mask;
> -       cc_vendor = CC_VENDOR_AMD;
>          cc_set_mask(me_mask);
>   }
> 
> Btw, pls do your patches ontop of tip/master as other patches in there
> are touching this file.
> 
>> @@ -608,7 +618,6 @@ void __init sme_enable(struct boot_params *bp)
>>   out:
>>   	if (sme_me_mask) {
>>   		physical_mask &= ~sme_me_mask;
>> -		cc_vendor = CC_VENDOR_AMD;
>>   		cc_set_mask(sme_me_mask);
>>   	}
>>   }
>> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
>> index cb0d6cd1c12f..2f7273596102 100644
>> --- a/include/linux/cc_platform.h
>> +++ b/include/linux/cc_platform.h
>> @@ -42,6 +42,21 @@ enum cc_attr {
>>   	 */
>>   	CC_ATTR_HOST_MEM_ENCRYPT,
>>   
> 
> This goes to the end of the enum.
> 
>> +	/**
>> +	 * @CC_ATTR_HOST_MEM_INCOHERENT: Host memory encryption can be
>> +	 * incoherent
> 
> "...can leave caches in an incoherent state."
> 
>> +	 *
>> +	 * The platform/OS is running as a bare-metal system or a hypervisor.
>> +	 * The memory encryption engine might have left non-cache-coherent
>> +	 * data in the caches that needs to be flushed.
>> +	 *
>> +	 * Use this in places where the cache coherency of the memory matters
>> +	 * but the encryption status does not.
>> +	 *
>> +	 * Includes all systems that set CC_ATTR_HOST_MEM_ENCRYPT.
> 
> If that is the case, why do you even need a new CC_ATTR define?
> 
> Might as well do:
> 
> 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> 		native_wbinvd();

That won't work, because the current system may not have SME active. The 
cases that needs to be caught are kexec'ing from a mem_encrypt=off to a 
mem_encrypt=on or from a mem_encrypt=on to a mem_encrypt=off.

For the first case, you need to determine if the system is SME capable, 
because cc_platform_has(CC_ATTR_MEM_ENCRYPT) will return false if SME is 
not active.

Thanks,
Tom

> 
> ?
> 
>> +	 */
>> +	CC_ATTR_HOST_MEM_INCOHERENT,
>> +
> 
> 

