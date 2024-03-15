Return-Path: <linux-kernel+bounces-104618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4E487D10C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEF01F24355
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23353482D0;
	Fri, 15 Mar 2024 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YpKzkTtW"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFF47F54
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519453; cv=fail; b=heivyRB8VO2GcVVc4U2Z0W719DmJzpyzpFiDf8LHCvIoTK+CTgKVuzD5CCtxKRotBk+2S3/8Ovija1Qn5y8JV7u379XolFPWPU+j9+bjp+A2sBFcstOtd8u8p8Ewlf5MEYk40dTuVBDcDVX8wE+qWr9SAbTjm1fuSA8kSZDqylU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519453; c=relaxed/simple;
	bh=9ED/83by9Nr7RUGvb8DHKHsROj6534bKr8mnc1/7nFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BpBkwSq73QOBt14DeC1pcB3s2nTvLR0P+NcKR5dJUIafYH15eslzgcNWU82Xa0kHeKsaUVxZe7n5Hm9S0sEgMQ4VljcCNYDCcGA9BSMT0E47DIyKz34c2LhkdMliJemy1xHnQNAv8I5PkrSck85dgaq8i02ethV586O+dKC8pVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YpKzkTtW; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMaOQJF6zdLSk9SrTDHtG1BkPFRqSCpEiaTTeVc0vLUfogL5owvbo+SgpB+XrYcS+vaduDeq2eaSJZfROwE4z9PQyByqZCBdnRnI9QQoAZrwlOQVi3cbt9cU6+LYT7dYlPf52aVuC3nsTxeQDZVhvhrHSLQmnz/eOcXB7PIvKpBgRP8ZSwuLUKsBctH2PGozjtknFrHqVj91ufPGJjx59obsn40kkBovDEWzTkvztkvLG2mzx37f3XvEAjNHZI75WcQkduHeJXGK6VZCJFCvkxAJe61KJXrOyr2auStN/cM8pzs/XilNNLuoMvoHFptr5SllPRwoljR2RdkPVR3Vcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwDW5/52kN+sB7uiDUKq6/JUfGfWOQD2kUbv93wxh3k=;
 b=FED3qSw0h8R/+pouBD7erIvMQ5SZY4M3aAwpoiS45ku0YsPshWjqHSx5nL3DkXOfc/mvKdsBMLNNlb3n0PPhIXAZMPeJKz8yLxDD6l7QBxWQlYn0sxkWFcnYnKNQaw+Kp0RHy8KStleQQEc4JFAbM1gyuXdkaa4CoYWeGt0rmBmSYmy7PnNxZr9XkWqw1lxfaybfqQ09bCnnzMsc+bblftVoVt++jwgQj9aH7Bh28JG0Kcv1V1DEOLXbtSbHBc3D/yj4EH9Z4DN/JEIX6s+DOfU6/Go95QMN1C4jYv0f9Ph5HUbO6mquYIDDK+BPSwjFT2iOfeWg6VhxUHyXN8QB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwDW5/52kN+sB7uiDUKq6/JUfGfWOQD2kUbv93wxh3k=;
 b=YpKzkTtW8V36EwwjRmn0ZlUbRn1ihJeAHXBE25izSUcOBeSYHZUxk8ZhAqBGJO+KydchWMf+CkeB7Rk9eANQGJ+wTWujyM2Co3Vcah06qEy0YAX6ts85jWclhgsImM7HJTcX45YC+bVJBWoE2jy+QR+naFMdhowTbyxKM3T9VeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 16:17:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4%5]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 16:17:24 +0000
Message-ID: <162f5113-4eb6-dcea-f034-c81b9dc021b6@amd.com>
Date: Fri, 15 Mar 2024 11:17:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Rex Nie <rex.nie@jaguarmicro.com>, james.morse@arm.com,
 "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
 Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>,
 Borislav Petkov <bp@alien8.de>
Cc: fenghua.yu@intel.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org
References: <20240312075349.977-1-rex.nie@jaguarmicro.com>
 <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0135.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2f4de3-1b32-463a-600b-08dc450b6691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Fvoon6qFzq9QljNRBBJ11Q1FvHAP8mzu2AL0FUvNkMuM6Om7hOJGIUsej1GxoRz/I+zkm9X3RMIRemHVuDanDX6y8+pYPGcirK4m2NUAWsNxhfezmRwHX23Ll2hsy5asnhPedYyCzXUYugMeZnkS6rPdPMN5c3FZ5x0zODiA9W+qZyRKJFMRxyt9X07HLfnPcMxtjXfVjbF7EWHyl9SNSQKkmFq5VdFCrV7cU8onRnObv5VRDGrqEEI4zyBAudOK9LzvZObzvlLTUGayn0Zsx8rCb0abenUUijf+4IvfVpZcMSRVlkfPoZboyeSn0v4WCT+su1FcIUIzcIbQ+5VZ45xhLK4DYM/94uX8IEf7Eu4AxpRyZyMuKSAXYQJLLBnWS2pH6tYEl5MNq5MZEDXaEss5rSvjkroSxFj8pRie2pnxA/QvV/3vMdWyRwgs/14KQgB1wyrcA4fMhrF2dGDchnFpjdFpo1uZAbydTAjaFj+/eNpQi9Abt/mybvB2MpykdNER5UQzyPN8fzxFJNSc+GQbStmKW5Dy+uWu794a0G2smoCVLMQcQ1TRUL3s6j5FyyomhVuy+BwWB2CsW5W71v+rsYC7cFnj4HQyDlr8vqH2PfqRuBdXGLJJv2jyqsqak1cqlffBvjF8N2H7wsnHxHXW3PCtm6BTmEbYcgEnyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmluWmNTbWwvMStEaldlYnMxdHE1Rzh0Y1dvYTR1SmYrWWtvWlJtL3pxL1F5?=
 =?utf-8?B?cUVyMTNPckozUkM1dDRIVjRxdDBzdXlLY2s3WVlLUjJzdzc5VFdORk1wdW9G?=
 =?utf-8?B?VmVvN1p4TGhFemROYTJYeUllREoySkR4dHJHVEhYdlJwM1ZTMVg3NjE4U1da?=
 =?utf-8?B?Rmhmd3lwb01iWjl4Nk4rSW5CdXh4OW1aWENhTUZVeGZQUHdXeHBzTHJMR1hH?=
 =?utf-8?B?RjlvaDltcHRUNGRTbEdvcnpxM2RLcG84V1lOUE04cTJxczNrcEV1cnpicE1s?=
 =?utf-8?B?SW9UVTY0cU1lMmVpbHBDSmdHWUR5TjVROFowWHcrZ0t6cVhFUCtDZld0bHVR?=
 =?utf-8?B?UFFqK1g5V0E5cGlCSWJYdnJlN3RCcFhZeWxwOUJiZC9EUGhQdmRFTTRqbmVR?=
 =?utf-8?B?QU1oNmJOVkx0UTM4L3h4dGs3NGpJdFRmakVpRkxpZnY4Ukk1cXo4cHY3YUN6?=
 =?utf-8?B?TEVtakFGOVJuKzJXRHJqa2pLRXpxU0RuUUEzNVo1b2pIRys3YS9FczBKUnlw?=
 =?utf-8?B?eGl4RWl2QTVLS0xwMVRPcXBQUFpmV1FCS2R2VXdEUFY0a29EUDZkd2g3Zm1v?=
 =?utf-8?B?eHJUejE5U1RxVWpwZmtCVTk2TXNJMll6eDBQNHdXOEVZQ2R4L1FuUlBMUDFQ?=
 =?utf-8?B?MyttQmVIMDRaWFIzMXFMeGk5cHBKcndUNnplTUhCeTg5Y0ZKSCtZNTV0c1d0?=
 =?utf-8?B?OUw5bGtxYjBJTUM1VVZ2MnZmd2pUajF5eEZURnR0RTlzbVBwazRlbzNCWmgw?=
 =?utf-8?B?ZXBIaXVFb0NvQTVBNXRQd1RMNGlqOTRvQmRuUnJuMDBzaXptTFY1dCtqWHdT?=
 =?utf-8?B?US9iRW1ObSs1NGRnczBrYmRDTVdRcnhpZjdiMzJGVWo5QThHUm9YcXJEMnVh?=
 =?utf-8?B?eENYNzMwZXRDblRqYnZOL0cwRE96NmtKRmxkVzdSbVVWUnRncmppZU0rNDZV?=
 =?utf-8?B?TFNYN2hXbzFBdjZoYkp5a2VaaDJTZDVtK210K3NZOW5CdHZwUlhoMjZOVU5F?=
 =?utf-8?B?OG00MEQzdHkyZE50ekU4dEVOdFE0dlJPYVlyTjh5bHJBblZOYTdYbEJ5cW9j?=
 =?utf-8?B?LytFUGVKNVdlK3ZDNjZGdjFSZUlJakV4b25rU2lJclA0aFI0a3FmaXlKNUg0?=
 =?utf-8?B?SGVsRDVLQ1J0ZXlGR3VOZ2Z0YW4wMnJZc1RsQWxzOExXbEpFdTdhMmtUTktU?=
 =?utf-8?B?dTA4cXFPMUMzMlQzVjE2aFcwN3RkS2lhYTBzSFk0VDVTN0JGYkJMVlRMdnBu?=
 =?utf-8?B?R0JFczZDYzd4K3JZN2FJdEJjb3V6STZXZjVoUENXankwT0VqbVNUOVdYbEVI?=
 =?utf-8?B?VmtQUFBHcUF0ODlHS1o2WVJGVHptdk5wMTdsVG9pVFVUSmQ1VkRPclhXTTRD?=
 =?utf-8?B?Y0wya1VWTS9DOUNKUUN4ek0xbnhhM29XWTIycWpWVytSZnRNRStuU2lWbEYw?=
 =?utf-8?B?QXVXTG5QVFBqWDdRaTBoUHJVSlhtekdNNjVFcDdQZjBuK2xTVjhWNmVnWnpJ?=
 =?utf-8?B?SFU0ajhZWnJicExkRE1tT2NMRnl2TWZEeFBUT3NhL1RGcElZR29XN3VxY0JH?=
 =?utf-8?B?WjRWUDU2UnFmRWhCYW5PUW1JNndBZjFSd3BUcWp6V0VESUlvQm9kL09RR1cr?=
 =?utf-8?B?RGFONGYyZEFxbENoU1d3ZXd1M1MvM3BaR0JXTFZhT0N5VllQK2Y2Z3pUeFI3?=
 =?utf-8?B?UTZsMWNydXJUckdCcTFIZFpoRk42aXpRclpKWm1Ob0k4Y3locjR1ekZ3VXlk?=
 =?utf-8?B?NXVycGJNRzU2VzV0Z3Q5eFNSaTJSZ0xkajI3M0VVL1loTGpLL1JrbExQUzRK?=
 =?utf-8?B?bUNtTlYvT2lFS2krQzFCeGtzV29kUHdCQzFOaGh6QlVnSmFYSUd5emVKbE85?=
 =?utf-8?B?Qkdta2xWSUlZTTBYZUpuS3lNR1ZzL3FOSXpGcmJ1WHlnZSt6aDhXT2czMCt0?=
 =?utf-8?B?b0dwckJDMVdueko0R1EwbWU5MjBMMHFqYThJYzl3RitXNGNOaGplbkQrOXJQ?=
 =?utf-8?B?T2RxdXVqTVVBMWdsSHJXVHVCVUJmeW9VSEhyaTk3VEszcnhWMUhHR2orcWVE?=
 =?utf-8?B?MEJhZ3htMzVRdjlzQ0NLdEZZMDdzeWpUc0JvOUxoN01ZdWYrSmRkVzU1cWwz?=
 =?utf-8?Q?eRts=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2f4de3-1b32-463a-600b-08dc450b6691
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 16:17:24.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STo3/9eKYjDuNZeO5keKU4cot+DGHlwmW/Ur5K4ObxnObICQzcNyw5pZmF8fECyX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636


On 3/14/2024 10:25 AM, Reinette Chatre wrote:
> +x86 maintainers, Tony, Babu, Peter
>
> Hi Everybody,
>
> On 3/12/2024 12:53 AM, Rex Nie wrote:
>> Below statement from mkdir_mondata_subdir function will loss precision,
>> because it assigns int to 14 bits bitfield.
>> 	priv.u.domid = d->id;
>>
>> On some platforms(e.g.,x86), the max cache_id is the amount of L3 caches,
>> so it is not in the range of 0x3fff. But some platforms use higher
>> cache_id, e.g., arm uses cache_id as locator for cache MSC. This will
>> cause below issue if cache_id > 0x3fff likes:
>> /sys/fs/resctrl/mon_groups/p1/mon_data/mon_L3_1048564 # cat llc_occupancy
>> cat: read error: No such file or directory
>>
>> This is the call trace when cat llc_occupancy:
>> rdtgroup_mondata_show()
>> 	domid = md.u.domid
>> 	d = resctrl_arch_find_domain(r, domid)
>>
>> d is null here because of lossing precision
>>
>> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
>> ---
>>   fs/resctrl/internal.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index 7a6f46b4edd0..096317610949 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -94,7 +94,7 @@ union mon_data_bits {
>>   	struct {
>>   		unsigned int rid		: 10;
>>   		enum resctrl_event_id evtid	: 8;
>> -		unsigned int domid		: 14;
>> +		u32				domid;
>>   	} u;
>>   };
>>   
> resctrl currently supports 32bit builds. Fixing this issue* in this way

I have never bothered about 32bit builds.   Is Intel still testing 32bit 
builds?


> would first require that resctrl (the architecture independent fs part)
> depend on X86_64. Is this a change that everybody will be comfortable with?
>
> (Of course, there are other solutions available to address the issue mentioned
> in this patch that do not require depending on X86_64, but I would like
> to take this moment to understand the sentiment surrounding continuing support
> for 32bit resctrl.)

I am thinking we have bigger problem here.

The structure pointer "union mon_data_bits priv;" is created in stack 
and passed to create mondata directory. We are reading it later again in 
rdtgroup_mondata_show.

How is this pointer valid again?  Shouldn't we use static pointer or 
allocate memory for the pointer?

thanks

Babu



>
> Thank you.
>
> Reinette
>
> * Please note that this is not an urgent fix but instead a preparatory change
>    for future Arm support.
>

