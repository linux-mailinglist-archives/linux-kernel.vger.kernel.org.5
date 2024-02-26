Return-Path: <linux-kernel+bounces-82112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B07867F72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F183C291EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E7112EBC1;
	Mon, 26 Feb 2024 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LYFDzpX2"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256012C815;
	Mon, 26 Feb 2024 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970384; cv=fail; b=WDX3Rhyi29C89Iq8GOd6nPOPsgy8dQm0Hd6QLUp+p9mnYXKx3Yzy4IkvPlOW2uhvLsuHBinCHwC2Gm2lXgGg1jqpxOrV8AliNwZaNvQ+iaEs5MzwJOfVpF9+9XErTVJoPqDXbqrLFvfYPlU8g6W+8lNKHosq/7a3oMjIIoGkgCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970384; c=relaxed/simple;
	bh=NaLvMfkxLyxA9mKpFOxT2kSNDFFghnANNLr+eNGJKXM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qspg0nbB+B1CrlmOpmIYMmmhEycSKPl+XvGIY047KrtwlQRSKmM76mmXSKGFSSl/RD1UEtu9YO41pINYopMuYUofUhlq5zr5NCZsw2wcCIMLbTThrHsoCOOezKWGGsH+pPNOphTNpgcodfNusEnaPUD2H0oDbXrfuFxyM4EoPk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LYFDzpX2; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6DyzRukwitUfASgh37Mnq/ymgYAJS6v/PvJVFgWqNOl10iGcPS9GILsA2W7PxtRfHt2/Jz0lm4xtTAW9NPmTcIV5Jsswy+05xd9hc5XHHaM6QPZ+oStaYJxobcW5de7IdcI2ayM+dne2BrClluexJYOz4hWPq0IslgBb/2+YJDeab1bhob+v6wdDkpmFNUf/8d/X09J9MWhJKf0K2t5S7Bd3Su/O4tKMMmAlxltsUSMj01k24XuK4Kwn+Ube3CtqHoEEYNhfmbf7yJSKqECqDkrmMe2mvoxtd69nGj1LWGoYsIs6fZvXGiJIWT1gN+kCzybgdWvapxTRnRHi/SUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntdnWREn2uULbCXKcm5r3vBmkpka6W15eQUnAfms1wo=;
 b=Kdo6m7yRAvuSuOM1PEGBcV2jvzr6aCPfxTxxUyzKp507DM5p0vmClUir+kDT5JlrbmkcqA9IPltEZ+YlxGICvufxWezayXQLkf8Q413xiZV0xIl4w+NzSe9ScxfxA6i7x1trrunXPPNO1PLY7BjkOhv5Sj8LAMW+C8PnpG59zj6yXyctEWo4v0yRwho7m+wAKo8l0iNOs5HJYYX0YPFZ+yXEJ1vArI8SaHnlr3g+UJ01sGarpTnCBU4cJKzarq6wIeUnL0Yqh5pSOHLSp4KofRbsZpZvLw9GV0AR2VajblWsZaOyOuOWcwvqhvwQrkaZ9U2Kyk0tKxLMKHMjofI+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntdnWREn2uULbCXKcm5r3vBmkpka6W15eQUnAfms1wo=;
 b=LYFDzpX2xbmD94gjkGfxMC6wO1xUhZP7WDjO01j6knFJoFKS/Xz9Zz6bIHInFEGEOVay1v7g6b28kzAKXuk9iHbMmRrwxrvGtqbrUAEEnKNRwhyG0knvDolUzaniDHaZjTZ5mKGe+Bn7mTbLVRgVK6Nmi+472BOA2MiyemwO+bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 17:59:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 17:59:38 +0000
Message-ID: <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
Date: Mon, 26 Feb 2024 11:59:33 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0066.namprd05.prod.outlook.com
 (2603:10b6:803:41::43) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0352e7-d7c7-40b9-dcb0-08dc36f4b2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iN4dZwQ0DFJC6bi++MkxU07FOV6C1fWAHVTrCfMBRG7T33/14be0xJQOLP2NygN2UYWH2C4uNI2e/zOrNLOkkIIdvDMb3YFuI08I6rVVP9wz55iDWqHQWN5byi1AtrzOifmXOwqHAdMuE6Bs7iXrUw6mFC/iBY23Y4HGbmBJFwMuEChwORtewpY7OtF9vJukqZWRrQo/Rt+RtR4ONrH/l0CjBxkF8p4di2dAgwH01CEJ7UMzcaIt15TmOR+wTNhV+SLSYEePPUqKqIQP8iml6WcyxPWFiXXS5Yc/vkMUjBQotaTYMXi9XNMil+x/haN5FC372XkIYJM8/tdu9ZJSJZPqKG81xjkKaaecDAMYcdsmkXph+rP+FdjkAPbC6/PM/pib/ipj0LSqelctaB36lqtPPaffo7xmIQXvIqyiUTGg52/7gPUulyVY7FNSFO+tRrlj4Er3S5xwdTih54gVTbBX+GcO4kWKKer+4Ajc8QdDaUv8z6OS+0GmN0vzff1lO3NSXClEKwycNP+3kJbP91K99RhSzFeow7YllWgGUPEAx3nXiWfN/NeJdcHT+43FMTFheanzhULnl5lV/yKBRDRdnkjVssuXXQLyn1qDbWXP0Z7SGpgNT0r6GO31mUB9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlZ1b3p6aitBY3kzcHhrZGJGMTNVOExuWFdYOEZWYldCUEhGTDFiclBiSVRG?=
 =?utf-8?B?Y0lwSmFiazhpb3k0RWJHOFAvaTNKL0JGbXp0TEhhMnl5ZVo0bFZiMlJKdElU?=
 =?utf-8?B?TzNJT2luaUR6V1RzZmszaWMxd2paVmRUd0JrdkwvZVhRTjlHV0ErMFh3alVy?=
 =?utf-8?B?cGE2TnI2OURnQndDQm5mVjFuNnJJOW5Lb2JhdVhGNE13eFA4dDBHUkJJdGpt?=
 =?utf-8?B?a1Byb3RtdG5McklFVlJZbFhQZ2ZEVUZsV1c5T0pWUVJ5aUh5T0xQWVdWNCtV?=
 =?utf-8?B?Q0loZlJFMEsxYjlkN3kyZURublRTTnNRbitpUk5lbWZpQVB4U0FzU1lRdEhK?=
 =?utf-8?B?K0wydzVnRzVrTUtuOEpFK3NSZXExVkhabVlTb0t6OG1Sb2pMNkphRm1xSER6?=
 =?utf-8?B?ZFExbWcrWDZmQnIrZjhhV3Noa1ZyaXVhUlVGc0x5MzJPN2xjRjBmOEVFZHlO?=
 =?utf-8?B?OWdhVURpN095cHpldWZ3V0RwelkwSHlWdWorNVU0eTB2eE8rZnZ3MGRWSXZz?=
 =?utf-8?B?WkFDaUlVNjJlYmlRVEdtV0RiZXlub1VWNHFTUHc3UnhqK0ZPdDM1N0VTbDRi?=
 =?utf-8?B?TXAxeU1WanNwOHlGTnhoVDBDdXcxYmQ2NlhibDFPbEh6RDlOdFVFYTNRbEVr?=
 =?utf-8?B?SnJRQlZJQmhXT1hRZVhKMGkzeEhRS3llQVZlTXZ0elBGZ2lVUy80N0VraE1K?=
 =?utf-8?B?STlEWGkrRTROdklnbzcvYmZ1N2J1NmhNRGpLYXozU2hvcmlLYzQwVDNqeTQ1?=
 =?utf-8?B?ajZuSHJLSzcrdVdUb0d6aElwbERNd0dOendHeHZUNFAvdUNYR0NvWkdEalZx?=
 =?utf-8?B?N1JlWk5WaXlpYzQxbktGbjA3Zmdpak5PVHRXdmNnSDRnWk5SMzdITXhEOG9E?=
 =?utf-8?B?Vk5lWjB1VXZpS2RJeldGMGlMMFFMSmg4UlpadmhudlRFQ2Z4UzA1ZER0TkM0?=
 =?utf-8?B?OGhEcFJwRThyL1ZlVllubmFoZktJMTNPUm1hY2s4Y01razFXODBuUVArTEcr?=
 =?utf-8?B?OXJzNnFVc0FMYVlwaFp4RGFCZE5iQ1grRTJpK2hCSkh2TTlKZEFIQkJoeWNJ?=
 =?utf-8?B?dEJ0bmh6bnZ2VitVRTgraW9qRVRwUnRvZjNSc3UzdEMwZ3lFd21yV2pIckZx?=
 =?utf-8?B?Szc3MFppd29xd2NjVHFpdDVCNHN1cFg2R1dUQjQxZVdkTjA4TmEvVDd4bWsy?=
 =?utf-8?B?YXdnTkhOanA5NzdYOWd1YnQ3Q1FhMSsvNERLZHZzRUZ6Mk12WHlKRFJXY2Nl?=
 =?utf-8?B?V3lIQ2ZpejhMSTNkTXFVK2E2bmwwTWR4b3dkU2VSS1Zrc3ZkWS9XZFNYN1BQ?=
 =?utf-8?B?RXIyUzUvV2g3YlR4NXFqR0tvRkRhcjg4L2h0UTBDb0xpSVRKMFVIV2FYVU54?=
 =?utf-8?B?VEtJK2JvK0lUVTRnalVoaHMzT2NiQndBaGpPWi9xV0ZlMXYvQ2tpSStkYXlB?=
 =?utf-8?B?YmkxRnl1UlNoa0dncGdGeE5LcVpGU3M0bFAyWDhrLzdiRXA0a1JTcExVNGpD?=
 =?utf-8?B?MjJRYlA4ZWVXa200cUswYldGWHRiOTVYNWlHM1RMR3IvVDI1SlI4VHluVlZ1?=
 =?utf-8?B?YmthTDZyZzhSUzFpSXpHMDdTbjVFTFVrakJBbVE2RXZ4ZmUxOUxtZXZpQ1o3?=
 =?utf-8?B?TWsycXZYTWpqTnpKS2NjQ1JuMDhjak5lMEU3OVZJUEVWTTlKZThyZWt6UWtL?=
 =?utf-8?B?WE4vcjZZWDNWRnhOTW1hMVU4cHhiVkd1NkdyQkNYZFc5RnhWUS8zYXlwak5Q?=
 =?utf-8?B?UEVlbXpzNnlLQVdHeERtWHlEekVBUnd6VC8vWldwUXlzTndZWW9NdGFqRkRw?=
 =?utf-8?B?TzVCWVlyL2ZuWVQ4VVBxOGhnZlBITyt1bFNnOXVjTjhXUFBtZEdqaWswUG5m?=
 =?utf-8?B?RmsxUUMwVTRpSXVZYjk5TEF2b2hJR05qNkR0Ukw2ZWxROWlGb3VTREtVR3Rv?=
 =?utf-8?B?a3ZuUTl1M2lLbEl5WnhnRlZTcjVmbkthYmtqY1NQZ0ZsTW55akVUSHRVVS85?=
 =?utf-8?B?c3VyNFRvL2JySll3VTZ3NytiL2ZicUN0NW40aW1NYnY2cjZxdFJaT3hMWjl6?=
 =?utf-8?B?ZlQxLys3dTVOWlRGYU83N0JIS0g2M29HVW92M09RRXRtVGZqdWJkbkJlZllu?=
 =?utf-8?Q?CURk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0352e7-d7c7-40b9-dcb0-08dc36f4b2fa
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 17:59:38.3945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WD3LSssZ++/3NkSc8CORwnlQkTGFjczgi9lI1VDpsjs3V9cEruMObfze8aqMm8qO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093

Hi Reinette,

On 2/23/24 16:21, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/23/2024 12:11 PM, Moger, Babu wrote:
>> On 2/23/24 11:17, Reinette Chatre wrote:
>>>
>>>
>>> On 2/20/2024 12:48 PM, Moger, Babu wrote:
>>>> On 2/20/24 09:21, James Morse wrote:
>>>>> On 19/01/2024 18:22, Babu Moger wrote:
>>>
>>>>>> e. Enable ABMC mode.
>>>>>>
>>>>>> 	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>>>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>>>>>>         1
>>>>>
>>>>> Why does this mode need enabling? Can't it be enabled automatically on hardware that
>>>>> supports it, or enabled implicitly when the first assignment attempt arrives?
>>>>>
>>>>> I guess this is really needed for a reset - could we implement that instead? This way
>>>>> there isn't an extra step user-space has to do to make the assignments work.
>>>>
>>>> Mostly the new features are added as an opt-in method. So, kept it that
>>>> way. If we enable this feature automatically, then we have provide an
>>>> option to disable it.
>>>>
>>>
>>> At the same time it sounds to me like ABMC can improve current users'
>>> experience without requiring them to do anything. This sounds appealing.
>>> For example, if I understand correctly, it may be possible to start resctrl
>>> with ABMC enabled by default and the number of monitoring groups (currently
>>> exposed to user space via "num_rmids") limited to the number of counters
>>> supported by ABMC. Existing users would then by default obtain better behavior
>>> of counters not resetting.
>>
>> Yes, I like the idea. But i will break compatibility with pqos
>> tool(intel_cmt_cat utility). pqos tool monitoring will not work without
>> supporting ABMC enablement in the tool. ABMC feature requires an extra
>> step to assign the counters for monitor to work.
> 
> I am considering two scenarios, the "default behavior" is what a user will
> experience when booting resctrl on an ABMC system and the "new feature
> behavior" where a user can take full advantage of all that ABMC (and soft
> RMID, and MPAM) can offer.
> 
> So, first, on an ABMC system in the "default behavior" scenario I expect
> that resctrl can do required ABMC counter configuration automatically at
> the time a monitor group is created. In this "default behavior" scenario
> resctrl would expose "num_rmids" to be half of the number of assignable
> counters. When a user then creates a monitor group two counters will be
> used and configured to count the local and total bytes respectively. If
> two counters are not available then ENOSPC returned, just like when system
> is out of closid/rmid.  With this "default behavior" user space thus gets
> improved behavior without making any changes on its part. I do not have

We can automatically assign the h/w counter when monitor group is created
until we run out of h/w counters. That is good idea. By default user will
not notice any difference in ABMC mode.

> insight into how many counters ABMC could be expected to expose though ...
> so some users may be surprised at how few monitor groups can be created
> with new hardware? This may not be an issue since that would accurately
> reflect how many _reliable_ monitor groups can be created and if user needs
> more monitor groups then that would be a time to explore the "new feature"
> that requires changes in how user interacts with resctrl.

Currently, 32 h/w counters are available to configure. With two counters
for each group, we can create 16 groups(15 new groups plus the default
group). That should be fine as pqos tool creates only 16 groups when it is
started.

> 
> Apart from the "default behavior" there are two options to consider ...
> (a) the "original" behavior(? I do not know what to call it) - this would be
>     where user space wants(?) to have the current non-ABMC behavior on an ABMC
>     system, where the previous "num_rmids" monitor groups can be created but
>     the counters are reset unpredictably ... should this still be supported
>     on ABMC systems though?

I would say yes. For some reason user(hardware or software issues) is not
able to use ABMC mode, they have an option to go back to legacy mode.

> (b) the "new feature" behavior where user space gets full benefit of ABMC
>     that allows user space to create any number of monitor groups but then
>     user space needs to let hardware (via resctrl) know which
>     events should be counted.

Is this "new feature" is enabled by default when ABMC is available?

Or we need to provide an interface to enable this feature?


> 
> I expect that only (b) above would require user space change. Considering
> that per documentation, "num_rmids" means "This is the upper bound for how
> many "CTRL_MON" + "MON" groups can be created" I expect that "num_rmids"
> becomes undefined when "new feature" is enabled. When this new feature is enabled
> then user space is no longer limited by number of RMIDs on how many monitor

With ABMC, we will have a new field "mbm_assignable_counters". We don't
have to change the definition of "num_rmids".

> groups can be created and this is the point that the user interface that you
> and Peter have ideas about comes into play. Specifically, user space needing
> a way to specify:
> (a) "let me create more monitor groups that the hardware can support"/"let me
>      control which events/monitor groups are counted"
>      (like the "mbm_assign" file in your proposal)
> (b) "here are the events that need to be counted" 
>      (like the "monitor_state" and "mbm_{local,total}_bytes_assigned" proposals)

With global assignment option out of way for now(may be introduced later),
we can provide two interfaces.

1. /sys/fs/resctrl/info/L3_MON/mbm_assign
This will be enabled by default when ABMC is available. Users can disable
this option to go back to legacy mode.

2. /sys/fs/resctrl/monitor_state.
This can used to individually assign or unassign the counters in each group.

When assigned:
#cat /sys/fs/resctrl/monitor_state
0=total-assign,local-assign;1=total-assign,local-assign

When unassigned:
#cat /sys/fs/resctrl/monitor_state
0=total-unassign,local-unassign;1=total-unassign,local-unassign


Thoughts?
-- 
Thanks
Babu Moger

