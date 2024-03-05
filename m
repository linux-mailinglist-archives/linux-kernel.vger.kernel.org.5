Return-Path: <linux-kernel+bounces-92887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B326872797
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C04D28D286
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98514CB28;
	Tue,  5 Mar 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MExO7epb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB22CCD3;
	Tue,  5 Mar 2024 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667316; cv=fail; b=ehP+ADvqKL8x8I16oFjw4Kg8Z9vXrD8Ht7a6cfHC5ejexvd7hAZ7L17qFO+XhIj9W60OqrLDZlb20qLDA4XtcbBnbfyaE3GAk/7ocWhQFL4KX77hmS2E4JMPKjFJPAy0RJp+DR/uHi8kcOpdikbGyemcbc33TYc3iHlWthTKEFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667316; c=relaxed/simple;
	bh=45+4f2otoWDe4YU3wyHvZVzgnKrdOy7s1zAsLZHwe6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DBFoJFo0wbJKryevZR6qFtFprLXAF024ajRxJJJ2xjF49DRmimzhHmoSZjbOFazCkjfju9eL/2uSy8FAQtDxKmtr9opRhMdUz7d4oDrZNWyEqZ/Es8JJVSb7MQJvIeLGZ6Z6Itn7dj2vRsA9FJDQpHEk29LcfTyD+lpDJ710XbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MExO7epb; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZB8DX0uxW14JNt5YozN99mwUIwB3W1GkGCJZ8WEZ3T1oEzS+w8wNRcyw8N6Qu00iJcIZFhBL11/aW4wgLh72nvx/DYej7joTSCFS3N1eAKCnPMUYd9z3F8oAHrdmHAXv1YAye17d3+20aVJLnokDYmm+iyIyuuyfISQkKPVcF7Yiza2NdFkWIbHC5feBXnQrWfZw2T1pMAuxxRMeD6wSE3MTb9iqja/sGFlRmUCmx65EzbVOl8fsqExYTsvnyp+6z0oAUznKDQzH/jR/r/j7nzhR35u8fGpZAEiPLY9A/Ujc4i9yEwxdKoBnG0EHSowCME0Gnr4/B77bIgOtsWr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWUd+FHwltLjLmMiou5BvN029O8BkZ2p53H5nE8tOEY=;
 b=i+9gWFuRpVbRV/p26r7cyFuRhxsfWqM+nRlrhX6Ypz/g0iUyd3oPlxDlEcgSDmwgqtzZ9eCeDzYi4LezB60RyQkEUVZ9b/3eE6NtyIFCobVYODfCoNFk+q16rc8A9cfpiduBKw9mJVlH3cf1PcjFgi3kmKfcqccuCvmfJ6OknrYc3hIEVPrjaEDSmUbTK3QHVBEstyoDvUbczyR5VO4d8D3AllLyUpvQbxK37PNxBrDhXFW7n0gvNzm9lb11Pg6ZN7oxP8vVWjnLf8s9hpq7gb73TVgT+whAK/FN2gUfSHCwAJqSbmV+Ok8J/oLqPUeCvQXb5bOO2CzXTM1piS82yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWUd+FHwltLjLmMiou5BvN029O8BkZ2p53H5nE8tOEY=;
 b=MExO7epb+cg2HsH8vCjcZ4oidkG1+CWydfiR3IrbTW4FxuQONVqyUgRq3Cay2FoU3rK+bcchecPN2twUyvrCGHmtceb5MYLWo3qEbW3nDk7AaoTujhMOLJiD2ukfxr2XMpnD1dKvOj0kPjgZ6mwJURctfAqp1NVYTJnYJlL0xFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 19:35:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%5]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 19:35:12 +0000
Message-ID: <5dec29f9-fe1c-4155-b745-d6a76592dbf3@amd.com>
Date: Tue, 5 Mar 2024 13:35:08 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Peter Newman <peternewman@google.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
 <474ebe02-2d24-4ce3-b26a-46c520efd453@amd.com>
 <b6bb6a59-67c2-47bc-b8d3-04cf8fd21219@intel.com>
 <3fe3f235-d8a6-453b-b69d-6b7f81c07ae1@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
 <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
 <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
 <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
 <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
 <d29a28c8-1180-45ec-bd87-d2e8a8124c42@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d29a28c8-1180-45ec-bd87-d2e8a8124c42@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:806:d1::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d502537-4a8c-4b51-4cc9-08dc3d4b5fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8IgVAH7Zx8dTqyLQsHSUI5ounaFEvRtzsMcXBUgu6L4Q+6j8+tSjEZaudHz3MeE0D1YPvgmVRNLdcR8tppg3PcmSkuVYCCuN6FWpsBbwTGM+7FkrZHGGi/Jx8JWrzcw8i7huz+qJbMzk+vVAwpoP7uoGCWreb6G3Zi9SpOf/wAkF/nomJs+xTlCMuGr3QaUhGpC/2tfqCJMtaQJJzAfkxeTj9estnoa/ScV1QmhP1tVwpnGHtWeW/5wdgunps8B0WaL/p6uqnigzoka5CZYnLgna22FBIA1eVWF4oQzyUymXzU/cXTqUHCkNG1Gd/tXiIyYJPM9ppIZBKo/1jQBBdn44lgKYHQkNhfBJadFtZnA7cqRSqo5nFjKfeVbJg9v3pAOxLa6Rk2SU3SaNwn6zsMUhT8Jt+nusN8x0GB5DRWhIfvZVIwUR10OZePOpsQReHnSxApRfAknSwnQOM5nEWf8Fqdc+TBpCfsvBLzveXnhBMpR9mVRrNkjypRpg45fQaytlJHjMIQ2cqm4RloQpCVv2RJi7fFFJEYVK3z9dh0nHwA6QlHleCnkpjt8MzE8BTHw5lklsVMObSzjz7L6bjo0rJHRhDk6dvc26lRaM/9fQ3hJ1fD7vagb44zwnTZb5qNeKwv/rGEyd0Fs9RHfPixKTHBXxjfuYXU2t5anfnYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkFxZXNsZFQ1bi9TTmlDbDRzeWFtRU55VmhrU00rOGFzSXgwZjlpdTVzajBt?=
 =?utf-8?B?OVJaS2J3MGtsZXFYTVZUckJpcGNaKyt3UmJZckxjL3B6TFZydmVFZmlpVmlS?=
 =?utf-8?B?dzlVVXFHVjZwT2hzREcwY0wxZ2dKSWRWcFMwV1RsNWUrcW4zaWFUMDRBbnlk?=
 =?utf-8?B?YnZJNmkwT0pHQjBxUmRmZGtGdjlLdGN1d21XT3ZzbWFMc01SZ2JUMGR0Z0d0?=
 =?utf-8?B?RkJyMHZWejVrZUpBaWNabERsaE1vd0lWMUlQdkZZbmtoWmluTjlqMkZac2Q5?=
 =?utf-8?B?Mk5OcmFFZDE0aUF0b2haUVdLOUgyRnBjTVoyOFFpQ0JhdzRFSS9iTjdjNHBN?=
 =?utf-8?B?eW5TTHRNMDZhUWZzN04ralNHLzVXU0pLanZMK2tiK1V4U0dWS1Q2RzNqNkVG?=
 =?utf-8?B?MFljOUY1NUg5Vkwyd2llWmhQN3lYdXpBWFVXdTZXZmpUNTNINnc4K0Rzalcv?=
 =?utf-8?B?UDI4WWFPd2dJam1hNFl5MzBwbGV1dTVNU010M2x6eG5ua0FuVTZUVDBadk8x?=
 =?utf-8?B?SGp6Vm9lNUhldUhDeEdVcFRacTNjNlVtY0pLTm1VamhML1RKZldKU3dhSHYx?=
 =?utf-8?B?TkJPNDByRHFhTzZneUhBT3RNV3lweVlZQWhaYmdiTmVncHVvbk80SmtvU1hH?=
 =?utf-8?B?K0Z1V3VDdnU2aForZkdEU2dtZS9oeGNCODZ0OFhoUlpFUVJWLzBSYXZRVGd6?=
 =?utf-8?B?Z1MwNmlKSFFncWRmaE5UTHMyZFdFNmFjL2xJa3FxNzlZVlRIa0NVb1lzTG12?=
 =?utf-8?B?b0IwOFJ3WnlOa3M4K1VRUGhveUJkaDVsc2xXREJRYnJiNFd5ZmlMUHNFK0xH?=
 =?utf-8?B?OGRvUndjS0QvNzZFditLSVhrZXQ3U2pOdm4rZnprcUpoS2xCdWFTZXpMVFIv?=
 =?utf-8?B?UTdhWm9sWGx1SU9wZWVGQUFEN3J4cEVQVXp3RDVrSXYyWDFTR1IwOGZLZW5T?=
 =?utf-8?B?T1dyMHRuRVd4RGhURjBuMFlib2RuZkJGWE1vcUhWNFQ4aGhFemV0TjhjM3hk?=
 =?utf-8?B?WnhiRG5peUNUWlcrczZ3b2ZNN24zbW40S2hyQmhJdDd1cng4bENqeGdqRHAr?=
 =?utf-8?B?SStMOGRnVmw1NG1Sa1RrWkNWNFR2MnNoRU5IT2xXU3hmZHpkMWZzenlBbVUx?=
 =?utf-8?B?b09JZDhVNGsvNW12c2FraVEya2dIQVdvYndGU2s2TDF0bEdTZVhJSG0zRHlL?=
 =?utf-8?B?ajMyNDV5UEtEcW9ZQlEvMFhlZjRTaCtGUkU2U3JxS3BNdmRueTJmcnZ3WlNu?=
 =?utf-8?B?Njc1SnN4Q3ZOcnQ0YUNJcGZrYU56eTNuMkJ2RHdSaXJKWGpObmhTaDlFRG42?=
 =?utf-8?B?K2pGZXF6TXR0YlFMdEFuYnRUZVlRb1lUMzUxaUI2bHprUXhGcWtCaytXUEJr?=
 =?utf-8?B?bldOYmljODFXKzdWQzQySGlCUFhxQit4RWdpbG1BS3FMVEtxU1U2OEhFWjBS?=
 =?utf-8?B?MEtoaE5FS2RZUDY2U2I1RVIwZVFESGRONVdXS0RhOXZjWDM0L3NOZVdmRWJE?=
 =?utf-8?B?Zkkydm5uUWF1bk9DMTBoNzUzeW1VYmJQN1F2dHhrbUxEZmIxSjFuTjFjUEZT?=
 =?utf-8?B?cDhPZUhmQ0VLaHlMQzd4SHh6NkZTa3V0aS9tRDM3aCszeVl5LzQxZ1ZUUFk4?=
 =?utf-8?B?andGQ3FiTFVsMHk3S0VZNXRtSFFQNW81K3ZJU2NRWm13Mk53ZGFhbnZPRzh1?=
 =?utf-8?B?MjQzTGQrbzJaVDNQM1ArenljN0toUjQ3S1QzR2ZGUC9pSjZoVGFuY0ZIenRn?=
 =?utf-8?B?VkgzWXFBSEhzTlRDNmV1cWdJcVFsR3QvR1NSblNBU0tnQ25ZbS8rU2JMV0Uv?=
 =?utf-8?B?SklWWlBhamFYcjFTOGR2TnJCWGNDNnNVT245QStlTmlKU2ZJZVU0eFFLZE5Y?=
 =?utf-8?B?ekI1QkUxTTc1bTVvSXZJNVIrdVZMWDNaQSs2ZDVBMStzMmRha2MrZWQrRWpL?=
 =?utf-8?B?eE1BaXNVWjR0TkpFUTlLcXhXc05SWEk1ZkIyNmVNTEhjSzhWay8wOXBrblh3?=
 =?utf-8?B?RWZIQ1pqNjBxa0huWUw0RWZhY1o1WWhWRWRIT3paYytQVVB1Z1AxOUpaVWlH?=
 =?utf-8?B?K0dlQWdBbDFjYmF4MnIyenNRaVRDRGxJeWpxVXlsT0x1OEwwbWpqSUpkS0Fz?=
 =?utf-8?Q?tyBk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d502537-4a8c-4b51-4cc9-08dc3d4b5fff
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 19:35:12.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3J76bpALo1fTHxUH5qmeZw5jtaK7bT51h3XKjFDzU0Ulf07C9CTHI/1kv1ChgLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

Hi Reinette,

On 3/5/24 11:12, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/4/2024 2:24 PM, Moger, Babu wrote:
> 
>> Based on our discussion, I am listing few examples here. Let me know if I missed something.
>>
>>   mount  -t resctrl resctrl /sys/fs/resctrl/
> 
> When creating examples it may help to accompany it with an overview of
> which groups exist.

Ok. I can add a line about types of groups before the examples.

> 
>>
>> 1. Assign both local and total counters to default group on domain 0 and 1.
>>    $echo "//00=lt;01=lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>    //00=lt;01=lt
> 
> I also think it will be useful to always print a small header that guides
> the interpretation. For example,
> 
> $ cat mbm_assign_control 
> #control_group/monitor_group/flags
> ...

Ok. Sure

> 
>>
>> 2. Assign a total event to mon group inside the default group for both domain 0 and 1.
>>
>>    $mkdir /sys/fs/resctrl/mon_groups/mon_a
>>    $echo "/mon_a/00+t;01+t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>    //00=lt;01=lt
>>    /mon_a/00=t;01=t
> 
> For an example of "+" I think understanding the output will be easier if the "before" view with
> existing flags is available. For example,
> if it was
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    #control_group/monitor_group/flags
>    /mon_a/00=l;01=l
> 
> then
>    $echo "/mon_a/00+t;01+t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

Yes. Makes Sense.
> 
> would result in:
>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    #control_group/monitor_group/flags
>    /mon_a/00=lt;01=lt
> 
> An example like above would make it easier to understand how it is different
> from using "=" like in example 1.

Yes. Sure.
> 
>>
>> 3. Assign a local event to non-default control mon group both domain 0 and 1.
>>    $mkdir /sys/fs/resctrl/ctrl_a
>>    $echo "/ctrl_a/00=l;01=l"  > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> I think this should be:
> 	$echo "ctrl_a//00=l;01=l"  > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

Ok.

> 
>>
>>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>    //00=lt;01=lt
>>    /mon_a/00=t;01=t
>>    /ctrl_a/00=l;01=l
> 
>      ctrl_a//00=l;01=l

Yes.
> 
>>
>> 4. Assign a both counters to mon group inside another control group(non-default).
>>    $mkdir /sys/fs/resctrl/ctrl_a/mon_ab/
> 
> Above will not work.

Yes. Missed that.
> 
>      $ mkdir /sys/fs/resctrl/ctrl_a
>      $ mkdir /sys/fs/resctrl/ctrl_a/mon_groups/mon_ab
> 
>>    $echo "ctrl_a/mon_ab/00=lt;01=lt" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro
> 
> (watch out for typos in examples)

Sure.
> 
>>
>>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>    //00=lt;01=lt
>>    /mon_a/00=t;01=t
>>    /ctrl_a/00=l;01=l
>>    ctrl_a/mon_ab/00=lt;01=lt
>>
>> 5. Unassign a counter to mon group inside another control group(non-default).
>>    $echo "ctrl_a/mon_ab/00-l;01-l" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>
>>   $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>   //00=lt;01=lt
>>   /mon_a/00=t;01=t
>>   /ctrl_a/00=l;01=l
>>   ctrl_a/mon_ab/00=t;01=t
> 
> ack.
> 
>>
>> 6. Unassign all the counters on a specific group.
>>    $echo "ctrl_a/mon_ab/00=_" > /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
> 
> (watch for typos)
> 
> Note that this only did unassign on domain 0.

Yes.
> 
>>
>>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>    //00=lt;01=lt
>>    /mon_a/00=t;01=t
>>    /ctrl_a/00=l;01=l
>>    ctrl_a/mon_ab/00=_;01=_
> 
>      ctrl_a/mon_ab/00=_;01=t
> 
> To address some earlier requirements I think it will be helpful to also
> show an example of multiple groups changed with a single write.

oh.. ok. Two groups delimeted by "\n".

-- 
Thanks
Babu Moger

