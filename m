Return-Path: <linux-kernel+bounces-39499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5558B83D21B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C8E1F25F70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9CFEBE;
	Fri, 26 Jan 2024 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2IaCeNyu"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530E10EB;
	Fri, 26 Jan 2024 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232924; cv=fail; b=kc1B/qMpJUs+xGyiv7t11Jy2FNwwTuVD4LeG4JWbp7xD9h5BKwHBEl82t8Y2iH3AIvwRtWe2Im1g0G6TCRZebmGOKvYOEKLQfvPFPnKpXA6jAYxXoSJeuwFtKFsJvGAoKPWISz2msmqgJTrucYJoJaF35l8BDz59CrjTA5nE4Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232924; c=relaxed/simple;
	bh=OqemQpgRe4vrcr8k/AsuLXd9IZ3cuH14q2G93z7otyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SmFZN2LgEI2B8IxhcEAQXvK/uyK1EAWJjcmMA/9Afc8DaogPn4UFzEup6lceE7p4aYXL5vN4VQDY712Qss9eXWiAxXrnIqMqGTBdlSX4Bhyv+tZbtQ5ULh0fwrQF/qSLX1ZjZVaN0454/3/VhXwoNwM0cfjwzOo4GZMjHkCHdW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2IaCeNyu; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+k2THr6jUvo2gZ1x05IXTs0RcWnPj2ir1gfx9A0/jfE2j16lJyH8EKMvUocoONjV9s7CkpyvlbHVpYZeRDAyBZedV7We4hLqXFINDgOSxwBihQq6MXAbTpzblECQiHkDp04Ovv2SzY4qGXhyMH+E/7mHtr5gXkhpzePDnDaygngi9El3BJHVpSxMXbHhQXmoEhN3grswCNA5DCMSr9AdeU0nteJjAysdAcbl/31YKttcxbO1SNSutWUBW40HgXU9xPGGS89lPPCUmP21teoZTjgxyngMrfj1SKMFHBDZq6wEUyZ4NfTTImdjrEFLO4YET3sD85S1XadrzJO5qYseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR09/pvcysk7vF/t6o/DxzE8KzH2LROYvi0Z3IDUPQo=;
 b=Tl+STmyczp72emb7YyUfW5oaKJ4HWm/Pr0uVoTUzRszq/xkd+Vqm3hcS8unYKmRLw8NgZ0aGbR5JFgTnqazxrZY2v7d35gvufER1QjGASr8sJBWJ+DXNgFRonvqX0MiwnU8bnqN1blLs0cd5GPG0x4Xf2/A55QgaAaYYwORtJUpqlZGFbGY9P+DMkaIiLqw2ElL1PeLbeUUihurzMQ5UAqusEiJzfS5QMJRxevHcxKR2TF5QFL63JHH7Noo6J6iEFZ+/WtnBCHgmcFY1rq3L+GJ8sgF4HRWbxGYU5ffoa4N5pnJdUSRAlB5R63o0gYBl51azkGZWoIOnCjbEfVAj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR09/pvcysk7vF/t6o/DxzE8KzH2LROYvi0Z3IDUPQo=;
 b=2IaCeNyuMyUy9NCro6ETUfyysSGmM++XI2uXIOBXtS7tZuOUsfzkoHsl5ar+k24QgrKWhnfxpfdxVHxEc7lOxkgc1fo1VVmIkC3D1fuovbk/oKsEPZvo/4brq5pYynHwos69r/pKrT/t+nPoYNFRIA4uVECNimqjKb65X0IclHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 01:35:17 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 01:35:17 +0000
Message-ID: <acac059f-6e6e-428b-907c-ef63c79a9410@amd.com>
Date: Thu, 25 Jan 2024 19:35:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tracing: Include Microcode Revision in mce_record
 tracepoint
Content-Language: en-US
To: Sohil Mehta <sohil.mehta@intel.com>, linux-trace-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org
Cc: rostedt@goodmis.org, tony.luck@intel.com, bp@alien8.de, x86@kernel.org,
 linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125184857.851355-3-avadhut.naik@amd.com>
 <1792a925-172f-4a9e-ad59-dea474bc7cda@intel.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <1792a925-172f-4a9e-ad59-dea474bc7cda@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0021.prod.exchangelabs.com (2603:10b6:805:b6::34)
 To CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 862fa1c9-cfc3-43c7-f2e4-08dc1e0f0d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HlDfyWtxYXGjHftpGma1jqwEv9N6u5mjabHg66LEl7q9yl2M9Oz1T0Z1+dKmd8QPoD/TNc4BBiq6d2aOSo5/uqOzVg41bwWPgbai+Z3Ophs852aLJyza98ehzN/r1dCoJe1wYtsx7ZYl/lngDkPp7AZRe79piRvgIgg3zYdwPFiLP2Xp1XHfWCftT4HUe2YKwghLZ8afY3CHhoqHXmFrNMAIkZGRLiSgqp+8mu8Xg826u1G9kZF1fM7e/BdMxrSq/piIZf5d34OzZXw79JFk79Udoi5VTGT+Ov8NCrZnSvcwEzreacS2AkJ+2b7g7vNco0zHbsbWyb4A+Gw8tI/beWzmcK3kMF02/Xb2WFxGw6dbWjVUyp4m3hC5yv2qgRfyN91MaGwPCUrt71lO+VQfTgoVgx8GGiqYFMykGozENRHC+kwiOQtElost0O1xXECqdDKz+Kb8ZpLwohVOXnwDuwB9G7ujznBqRFwd77D1gSL3ShrbcWgclm7vm/EMwSk04imdC5JU7HVIY/mkL4MH0X3O8sFBK+b073DjCJ5wNExLZixFBXuEwp5kr64u85w/+PjzpKATPxeTfx11vv+2eIpxdb5x639wjn/+jjZF3X0vlgad8534Y0dHKSsi7sm1YT2korv3BfHYer+9UQ29ve8CbL5PmWpTDDjIqKx8uIBVaU+e/G4mzJ8U7YGB26/z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(26005)(2616005)(31686004)(6486002)(36756003)(6512007)(478600001)(6666004)(53546011)(83380400001)(6506007)(38100700002)(66476007)(66556008)(5660300002)(31696002)(66946007)(316002)(2906002)(4326008)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFhadXVzcFdqUnZnZkJWSW1TZzlHbVgrUFdIRTJDWVZYaEsxUFNKanVEbVN0?=
 =?utf-8?B?dGtXNDNLaUxxZWp0TitsemI5bUNuS3lvbHBWcU1sakdRTlpoM3NDT0doNytQ?=
 =?utf-8?B?cUpId2FtWWJPRm5paTdhNmM0MndCYkpSczRPT1FOMVlXUXZOMkxQLzQ4dGVl?=
 =?utf-8?B?WEd0RmNCVEhkYkdwWStGZ0VaeHd6MFZac0RMODVtOThVMmtPbEdQZ01JWEVu?=
 =?utf-8?B?MUxGUFo2S3ZRMk5oYkZPbUlwQTBUMW9uZmRydStHRzNXMG4zbnhKemlEWEJw?=
 =?utf-8?B?QXc0a0Z3eHlWaUVkSFg3SThTNm1HcUNER3NLRXFHWXVnT3dZTCtsWWVGR0pm?=
 =?utf-8?B?L2RWTVQyM0RJSmp6OEp2MURSSng1ampSMy92WWdBUDUwN0NiRDdXYzJUaGFR?=
 =?utf-8?B?WUFrdjFHT08rUklUamx5YXFFT3YvTFUrcWVUd005Y2RLdlVHT016SjN6UUhk?=
 =?utf-8?B?V2NZTElabS9RcVdZNGllWE5ZNWZPNzY3TGJ0SzNZY1VtWDlrM1Z3ZEZhUlRB?=
 =?utf-8?B?Q0J2Z0FjUE9YaXRBaFpaNFBtSG0yL25jTEZUTUtaaURKanNqbER0OGFZYnh2?=
 =?utf-8?B?dElkR0Q4aWUzVjdqWk5KZVM1NVdRbXY1NzlGSjNMNG9rL0loM3o5cy80Yzd3?=
 =?utf-8?B?bjlVczJXMHFwcVFxTlNLYWlXMlRCeGl2Sk1CL1EvUElQV0RuaXFZRHJYbnN1?=
 =?utf-8?B?NVFPbTNjSVg2N0ozeG0zazVPamxpTVMxZkdSSThEdDU4ZUN0UXJ4ZG9KVTEx?=
 =?utf-8?B?dGNCN2FvVkVhdlE1T1R0SjZ2QlN0Sjh5UTA4ODhrbFZndEI0T08rQU56S2xq?=
 =?utf-8?B?S1Zja3VpOHk3MmE2bWMwUXM1aFl6OUNKNGF3RUM4K29FUzR2NUZ1S0l2cFBr?=
 =?utf-8?B?MDFJTUt4d2s1VXgrOTYrRDhhakxGRng3VkJtY2w5VTFUM3lJSlhDNGZSY2k0?=
 =?utf-8?B?TmIvY1RpM2ZDb1VXck5CSzVrL3lndk1BdHhSMWQ2ZDh5d1pXL29HaWJlcGpX?=
 =?utf-8?B?ci9WV0Y1cXZJNDNEK0NTMDAyS1hNRHZmeU8rbEdnNFpFdUh2cTdhWEQ1Q3VY?=
 =?utf-8?B?b1VCVlZUdFYwY2ZsWGx1M2dqcXVaTUN3OVBxSWxOckF1K2VnM3ZxTVpLMGo3?=
 =?utf-8?B?ZDc4TlpaK3ROSWFNVVhKdVpUYW5HRmFoN1MybmEvc0E1aWNydS95KzR1K2s4?=
 =?utf-8?B?R0ZtMzVHUTFFRWp6eVJTSHlydmFYclBPVGZxK2dyRWJRaXlHa2NQbElZWkFB?=
 =?utf-8?B?c3puUlViYXh0azJUL2w1NTV2OTJydU1lMjRac1VaYk0zQVFYZEtjWmx3Rkl6?=
 =?utf-8?B?UGJOQWZzZ0VGQk1UbUNXR3psY21XUCtlU1BPSzRrV0hTWWo5UVpPQlc2U3Z4?=
 =?utf-8?B?eU5wUlhHZ2gxcUlJUnFpUjl6NDBHblhZY0paaDVjc1BFNDJSL0JJM3dUU0M0?=
 =?utf-8?B?dXBFTXQ2c3RYT3ArWm1nV0d3d0tQUGN2SnVSYTVpb0YvUVU3cXNVNDVrV0Q5?=
 =?utf-8?B?bEVXbk5rOUM5TkIzSGtSMUQ2cUJFajgweXAxVHVZN21VREhaVFFoRkEvRlNP?=
 =?utf-8?B?b1B6WUN0bjEzOHF6Ty9UU1Z2dytxS3JROGpybFhJcWkrcnpsOUlSLzBqczNm?=
 =?utf-8?B?b0dsZ20xSUxoS3V3ejNYVHZNNTR0TWRYNTBDdUNWL2d3aFU4V2dmK3ZGRmYw?=
 =?utf-8?B?cVIwN3FpNWZuMXcrck5WZ3AwY2VxODZPMjc4dThrY24xa0ZCOWxRUitPOU5D?=
 =?utf-8?B?dHUrUitTa0xWSzk0cFg3UVd1Tnd3bGZWeUZSMjBYYXI1ZWVFVXByUVVvWkVr?=
 =?utf-8?B?ay96V0N3dkJHU1g3SFRIck93cnZOTWYwY3pUZ2xxU204Tk12TVNpVXljNGph?=
 =?utf-8?B?Z2cvbTQ5QzhrMEptZUF6NFJ6MTJnZ0ZMV0pYcnJUV2lpemd5cU9Ybm9lN1Ix?=
 =?utf-8?B?cm1WTzRrTWNJNHJ3K3hlVFVIVUFBdVp4NEFicjZNaVN6ajFXb3lWVi9jMUZB?=
 =?utf-8?B?dDBPQlNYd1hEQmVwSXYrZm1aczhoUnVJTll4MXhiZ3ZsendsZFM5TlVreWFP?=
 =?utf-8?B?MEJSYkIwU2xyblUxRTlhbVBoQ0Q4U2doYjdzL2hHcXVLMUU5eXRJRlBIQ01N?=
 =?utf-8?Q?F4IJIU1yK+N1fuvEpfVZ7PmOR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862fa1c9-cfc3-43c7-f2e4-08dc1e0f0d1e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 01:35:17.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+RiGCPDyVAZNJAdMvT6JdDXBD/6A18C2gbTQwspozR/3FPwuduiY8cRMOmap/K0cOoVUwZFi2w3IZavxQXJUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823



On 1/25/2024 3:03 PM, Sohil Mehta wrote:
> On 1/25/2024 10:48 AM, Avadhut Naik wrote:
>> Currently, the microcode field (Microcode Revision) of struct mce is not
>> exported to userspace through the mce_record tracepoint.
>>
>> Export it through the tracepoint as it may provide useful information for
>> debug and analysis.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
> 
> A couple of nits below.
> 
> Apart from that the patch looks fine to me.
> 
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> 
>>  include/trace/events/mce.h | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
>> index 657b93ec8176..203baccd3c5c 100644
>> --- a/include/trace/events/mce.h
>> +++ b/include/trace/events/mce.h
>> @@ -34,6 +34,7 @@ TRACE_EVENT(mce_record,
>>  		__field(	u8,		cs		)
>>  		__field(	u8,		bank		)
>>  		__field(	u8,		cpuvendor	)
>> +		__field(	u32,	microcode	)
> 
> Tab alignment is inconsistent.
> 
>>  	),
>>  
>>  	TP_fast_assign(
>> @@ -55,9 +56,10 @@ TRACE_EVENT(mce_record,
>>  		__entry->cs		= m->cs;
>>  		__entry->bank		= m->bank;
>>  		__entry->cpuvendor	= m->cpuvendor;
>> +		__entry->microcode	= m->microcode;
>>  	),
>>  
>> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
>> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, MICROCODE REVISION: %u",
> 
> Should microcode by printed as a decimal or an hexadecimal? Elsewhere
> such as __print_mce(), it is printed as an hexadecimal:
> 
>         /*
>          * Note this output is parsed by external tools and old fields
>          * should not be changed.
>          */
>         pr_emerg(HW_ERR "PROCESSOR %u:%x TIME %llu SOCKET %u APIC %x
> microcode %x\n",
>                 m->cpuvendor, m->cpuid, m->time, m->socketid, m->apicid,
>                 m->microcode);
> 
> 
Had kept the field as decimal since I considered that version should be a decimal
number instead of a hex value. Hadn't noticed the above log in core.c file.
Thanks for pointing it out.

Since we now have precedent that microcode version values are being reported in hex,
will change the above format specifier to %x.
Will just submit a new version, addressing the tab alignments too.
> 
> 
>>  		__entry->cpu,
>>  		__entry->mcgcap, __entry->mcgstatus,
>>  		__entry->bank, __entry->status,
>> @@ -69,7 +71,8 @@ TRACE_EVENT(mce_record,
>>  		__entry->cpuvendor, __entry->cpuid,
>>  		__entry->walltime,
>>  		__entry->socketid,
>> -		__entry->apicid)
>> +		__entry->apicid,
>> +		__entry->microcode)
>>  );
>>  
>>  #endif /* _TRACE_MCE_H */
> 

-- 
Thanks,
Avadhut Naik

