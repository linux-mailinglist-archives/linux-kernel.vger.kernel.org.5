Return-Path: <linux-kernel+bounces-122456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D69788F7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF06C1F25BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFED4EB36;
	Thu, 28 Mar 2024 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w1d4nhNv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FC134CB;
	Thu, 28 Mar 2024 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711606611; cv=fail; b=AyltyYAZEHFZziVQldH/PJ7Z6/kQaXZrmNBoEt1p7WP8qpjdFCOF5q9T1mO4+Zg20rnkRktynmfQs+hDedo3RTIzED57A1Ug7hpU0A/HHZN4PE46UQ+lG7awRHQ835pqURX9sHMBG0EMblXaqKgpGr8CjSUt0hf9wEjdyjIKqZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711606611; c=relaxed/simple;
	bh=1GRHjMbSUvnlngpaZtOatBYp7b6gKgurv9GNLS5/5tc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aunu2zBIQ+YhLRRQC0BApEWpFBl542FjrU5GTI3VkWndYCRugr9ia7ky/keSVxIjghkyfgjD7ca6mQ56VuKbethK8bxO37Td87Ms6a0mNf85VVGytr+AFO5lgkTk22MJmCDcrz0qQC5woKZfM8moTRlpCsNcxVCGMUXditAdHh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w1d4nhNv; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Umf+8U0sY/Nqm7xNt5R8+UyIYK6dx3WN0BDwP+kMWpfaf6Uwfm4h5jpQdvGkdBXRjJATVTu9w4zlKSKxJ7s6ihn1T/2RgyVZRjImTbpfmvDbxl1bdshAGbclSvg0+IiGlFcXCpElEsFhhZfLBHvAoDQgH2nwC65r3UIBXT3A6UspoNk/j7xlu6cOJg4553yC5iU3mTcEpFx/xRCRUnj17slmnb8wKM/1TRWAVTKsoBpNnG8RGFcaKFs1SfLyf5C4fKrbJZBpiePQVBs3FV8QZfQlIsZFHuIIhQkwKQz/D3TIgCSz1Yvd50w0IXou1NDabnCBf2bdjHm27sXs/u7MOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4uT/dp0PMeM4TAUgDxMs6CQ/h5cu6Yl8mbmFv2pS80=;
 b=U7MEJwGLutpolZqNT5+8DQe7kXlOrs5FunwcTs/ZaV1mkKBFep9WkHrZIW++DixbNcvn37iQmYzldvufP34BeZANXfmMRUJWP9SPGHRYPHITRW91Om3cDBOpJ4yEiS6DYNL0swDndpOhljNL2J5DMjYGtt0FQ7eOL4N7CBlY4uiA7iIed9gFtcwwZH7ZcX4ikH3LFu23Bep4Jg6DJ2sDZhhcyK5IxHaZu8+UXuDK91EgrtGYc+4ImmbOmrGE379KAQ1m75XK2+RMFeZLpyO5UBnn42nfU54UvXYVw8A00cN350Fk0PZHMaBKGRp7IFlU1qWQlz+mNf9h4scB84dkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4uT/dp0PMeM4TAUgDxMs6CQ/h5cu6Yl8mbmFv2pS80=;
 b=w1d4nhNv5cnYbei5HKIZ4tvyvP7R4QO/5uo5MXfFR7rGpVTqy3KVk7tcVoudNtTugPRsF+oc7nEkIOlzhgcobt3ttQEwVGP3bVKXosDZa/KCf6+r5VKaOM6szPuVsJQkqh3UL6P99zJi3JCWeKcyP2oVV2Iguo9g7Amzp4FcATU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 06:16:46 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%5]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 06:16:46 +0000
Message-ID: <870730a8-cabc-46ab-9ec9-f8e667842203@amd.com>
Date: Thu, 28 Mar 2024 01:16:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] tracing: Include Microcode Revision in mce_record
 tracepoint
Content-Language: en-US
To: Sohil Mehta <sohil.mehta@intel.com>, linux-trace-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org
Cc: rostedt@goodmis.org, tony.luck@intel.com, bp@alien8.de, x86@kernel.org,
 linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240327205435.3667588-1-avadhut.naik@amd.com>
 <20240327205435.3667588-3-avadhut.naik@amd.com>
 <67ba2ece-6b46-4ae1-a944-a38f84360d0f@intel.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <67ba2ece-6b46-4ae1-a944-a38f84360d0f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:806:d2::23) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbdbdb9-747d-40ce-c64c-08dc4eeea549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h59QuvtiIrMHQrFAJUPtD9FqPUBKXJWKNhDcunjzdQPSbDxgwBudM0vYkfjrXeUQCU0ujQ2abbR2AKXA1vgabmc9Pjw9MBqoYGqM32r9q79IhRmAUMtVLFW3q5OPJvSeVKRGBeSR/OsC5/trB2i0N+Esz3bsR8ciSCU1+H+9s3zFMXeGxY+Z81jk6hCf4Xw/X/wS+rmPXShemfVJEXa28kzOxwJeAgPTp375lycTFZ6heQ5F9ZRNZuc9XQPThX+PekZuN8QkR6EsZrZjTdh1uAXGg333GBAwkO92ldYHRZhgX+pjGBBdYGOnXJKbEvVz20vVIv9JPUjrH8HyjXjU+1YsfJjy2v90LluyaFMRyCQJVNzBfO/LdIw7ZiBkw5VXvANKFZ5eoh9nVKJu82sVg1BZ8CdzINfkaHRmUhnE85KP9ozz24+TV1/xqfHud5m2LypZh7xgPUiindRrZMAdlTvgC7r+30oezc/rxvclx9q5bXkQr8OFsnWnB2Xusl72DoOJ2l4c9jSmmgNzYsCZe3UTLc88m67ClyB7l5MYZzRkMP+plUivIwfvBzrKOgvr76Bvxnzy1voYYJg1z491F5ISsoJ+FSycX0cpVFBh3btMWxOsNcLPnAXG+JajbcVXpoGgX7Jh4iQ8cPlLnAdIIQUqc5pZ6JLpwdH/cic4LGo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3l2NkRCV3dBODYwMGRjWTBETFZ1UUZHOHJ0M1ZYM3E2NTlkQ3FFREo3MnRH?=
 =?utf-8?B?MWt3QmMvWVV3YTFJelhkK2xaUVkzNVo1bG5XUG5ObWU3YThjbnhteSs5dkZC?=
 =?utf-8?B?bVJaNWFTU212YUg2dVJCWUdubzR0VGk5bnZkY3dOMHBxMkRteitadDQ3VXh2?=
 =?utf-8?B?YnZpd2E0STAxR0tmYWt2WXk4dXFmUUpoOWhQUXZxREJLd0thaERGcjdvNEVN?=
 =?utf-8?B?Tm1vN0lWamVBRVZDTDBUNVVMcjYxTkFjOGVFeVRkSEJmd0R1eko5SzBJRW5s?=
 =?utf-8?B?Sk9QdVNGRWw1VXppSGo0dWgycFBFSWhDbU1acXFpWWhTQnJyNGdOeU5jSmll?=
 =?utf-8?B?N2cxd2FPUy9jWDBNTUdDY0xadklYanlzRzhMSGZXdjBhQk8ySE5VdWFqZk1r?=
 =?utf-8?B?enpBeDAxSURlS0w4NGpSY2lmaUNVSEdzaWhOMnEyNjJxVm1FeDBib043ajls?=
 =?utf-8?B?cGF5ZHlZV0ZSbUZLemlCQ29kMHQydytyVUZneE1uY01ueU5GcDQxbm9iRzgz?=
 =?utf-8?B?N25DcGFtTnFyNy9ROU9FS0JLOFJwZWFzbUtEK2Vkb2svSXl6ZzdXVnBHTEFU?=
 =?utf-8?B?MlA2UVdMRVY1QXJKclJCNWlRUXBzbTd0bHM5dUFNcmViWkZNRWY0Si9RcEFt?=
 =?utf-8?B?MmVsamFQNVZvMFN4ZXJCdDlnZjN2Vm9TV1Z6b0xUWVJsMXhacC8yaXJSYUJm?=
 =?utf-8?B?ZzczZjdzT0NZaTdRdk4zM3Jxb29tMEQwcjhWSFA3Z0tWTVRLbzNqZUlTVjNw?=
 =?utf-8?B?Q2hqUTk0eXYvRjNKQS9DeS9CS1Qzdk8xSk93aEVXUFY5K0VDLzJpazI1NHhR?=
 =?utf-8?B?U3B2dzJuM2V0QmR6NG1lTGx2bXpTS0hmOTg0elovYTRUQTZ1bXRDMFF5Q25P?=
 =?utf-8?B?cURpSXZVNmNkQXlZL2pyUjNic2gzQjdDMEJVcjlGaVE5dFE3aytqZzVBQm45?=
 =?utf-8?B?QXpUZ2pqNlR1dWlqcU41Ym9CTnFERTQ1RmZvRlR2a3NlYjcyNnJjMjE1TTBD?=
 =?utf-8?B?cnM2SzY0SGJFY1VuZnJ5MDdPWUJRSlBKZ0pLV0JtZUJ6cHlqMTdhNkxHS2dK?=
 =?utf-8?B?N3Y3NnFOQm9ldk8xMFp6cytIdkFxZllFN3Z0UjUrTXlTYXJMYmZVQzRlUzdo?=
 =?utf-8?B?NXdoTzJpUDlaMTlrSXdRYnp6OVp5SithRVlmZFpxdkRub1d2UUZYT3pRV3Iy?=
 =?utf-8?B?MDJFME5sekFzKytoK29yeHY0cHV3VERiNFMyajRJdmhISDdrZnd4NDJtWUo0?=
 =?utf-8?B?alF4RkRUTU1iMEpSRnZlVDd4M0Z3MG5zamZHWC9qaVBlaWpQTjQwQ1NzTjll?=
 =?utf-8?B?bHY3K0I4djZpNEFETGhlTUVYOUUrVUphVTlzckdZWnp6RTlGbzVVS3JMQ3Mv?=
 =?utf-8?B?ejY3SldxYis2NmJ0d21nMWE1ZGg5dnlWTzdUc1ptbXJFMVE3TDRKc2syS1g2?=
 =?utf-8?B?ZnZzRy9vWGRuRmpEK2o3M2pVNFVISUdQSS94clBYVWh5TkdpcXFMQXBWVzFH?=
 =?utf-8?B?L1V0dWpZc3IraUR4RWw0dWRWb3VlRWZNazFGcFRPclRuSy94NWJUTlVtUCtX?=
 =?utf-8?B?a2wxbGkxamtQNHBYeWQvZG9CVit4QlZGSGUwR2N4YlQyei9oWWpSZEUyZnl0?=
 =?utf-8?B?YW1IMnc4czVTQ2JMTXhtbDM4N3JZTG11RjVNNmVFaWxZdGdsNFU1VURQSGh3?=
 =?utf-8?B?elErTTR0b3MyaVJXenpJVkluQzAxZUk3QWlLdnEweUN1UEdMY09TMWdQOXZ1?=
 =?utf-8?B?UzRlNmFhYmhXSUh2Zzg1ZHF5WHdlNVpibjZPVGZlNmZ0RVNKY20zdGlRMXhW?=
 =?utf-8?B?QStnZzJwczhPbGROQ2lURXFQMXpkbTRSYzVHVksraDhla2NZWHVUSWM1cWky?=
 =?utf-8?B?c2ZHOTJnUDA0ay9DU25hbGlqR3E3emFCaDdxZ3RSSXNvbUZDZlBDZDk4V3Mv?=
 =?utf-8?B?d1FkbHEyQy9QTXF6MjdINVFGVis3aHhkdm4rcWRocFBDYzdoR1lhR0hEVXgy?=
 =?utf-8?B?dFRqT2FEa0QvN1BsUEkvOGd2SjRtQkdTNEt3Z2orU2pVS1NHWG5VL1Q2cUxz?=
 =?utf-8?B?ajgxUkNUdHhMOGNxV1lsM3lSbldsMFFkbjd1UG5MWHJ5TE9yYjBiRE05b0c3?=
 =?utf-8?Q?RZaZZjQSVITtk5IT9jkWc0QHK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbdbdb9-747d-40ce-c64c-08dc4eeea549
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 06:16:46.3834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnEGaSGE/NJ3gROlyFbZKdS1Bm+Bd6fRluaHzCzrWm34IaTDybmJDTOSysCq3GnPp8QTh7plG+qE+GLTMQiHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581



On 3/27/2024 17:31, Sohil Mehta wrote:
> On 3/27/2024 1:54 PM, Avadhut Naik wrote:
> 
>> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
>> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, MICROCODE REVISION: %x",
> 
> Nit: s/MICROCODE REVISION/MICROCODE/g
> 
> You could probably get rid of the word REVISION in the interest of
> brevity similar to __print_mce().
> 
> 	pr_emerg(HW_ERR "PROCESSOR %u:%x TIME %llu SOCKET %u APIC %x microcode
> %x\n",
> 		m->cpuvendor, m->cpuid, m->time, m->socketid, m->apicid,
> 		m->microcode);
> 
>
Okay. Will remove "REVISION".
> -Sohil

-- 
Thanks,
Avadhut Naik

