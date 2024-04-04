Return-Path: <linux-kernel+bounces-132071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E32898F57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4624D28A341
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49A2134CC6;
	Thu,  4 Apr 2024 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mSU1L70P"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2106.outbound.protection.outlook.com [40.107.220.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BE13443F;
	Thu,  4 Apr 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260975; cv=fail; b=TfYTG+LKfFPTz32pQ2B/vtynZpYgSxFxgToj9JgKEv5txhBsYpspRbqSkgOwYTT9wbV26QVPW42JWUEKqNJ4KjoMldDm2a8jd4vaNgS+eAkrT4SGX2XfYL0MWpKRYX2c8N84t5XOvEDmuuIaaXOfZ6l1eOTjOHXVfV0QWLr0/NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260975; c=relaxed/simple;
	bh=XxqkOy3RfNeWS2eQ9XHtNkoPtjLQEhKyqR8hLH8MuBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTbexCQSwFtXBguS7HcJMsMh7yujUnsm5u+bnAVYRueEwcMD0mGPd0TRUjf4FxZAqL2tp89A0/7y7EGJtdwkMtNO0YX45dW3jkERuxqnAAt2wNtUsWipiDoUiOh3Z41OZQuWRgyQYyfUyriDZEJe/mzuloQkhXmzlWvjW1l6kC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mSU1L70P; arc=fail smtp.client-ip=40.107.220.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7xTEKDGkUKF7EBG4PFtaz7OF24bovEt/nDo8/mrn13QidD4vtHW57+NnVDPe04jpU0YDayFT0fcwww0SKYXo4MKMdqiqnh6WrA0JKLwQH4x7VhjfVsayseZKTcvcxmCQzY8Mq+F7rIOgEm+5VIdokFMZYEf/GlixSLPgzPDIf42XrNHS87TQ8x4UrbHIDbHcffTxd9oxqR5V0s61/SHjQXFz8Hk0kDb5dE3KNnW3PZA20RdjhvxnUuc3wm+Gj8svXD6+4/tF7xjQnQd1SvmI5erwIwZ7at66lIbbCVazq5Qe5T5e6kFkQrQn1uuZsnWiPa8Tu8CxDAWF74wBqFpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTFpppTVO1cTIaqG2Lm7Mdb8cqABp8KlpYsoc+YkhBQ=;
 b=EZa4lbI3OX46epVod4cWrn5QddkNUUlgxg6tl5KuIuKBxJSji9CkBca+PlxZdLh/GlQcJ8FkuatgKXlSO1Mb5K03rHhWpbRvbySsdv9zIv4YZckoZ3NI19oT6/8Oy07KVtSEGes8yuBAyR8+IWFI6WEk3UoOI4cw2XwEDnPsQWpRgh7rat0ak5QqjlUcd+Y4EbmXc19ISv+AoFhBVBSk3dqabRmZRtmxXZndHxxWfjNLFVQ1nm6A50FaZs0IOAHqO9SV+IYs8KVHB449mfZCYFwXfahoT81EkRnWys7appp0IAYbPZXOKQICTqAOvyu9AzIDqe/0UTIRGTdXYUDkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTFpppTVO1cTIaqG2Lm7Mdb8cqABp8KlpYsoc+YkhBQ=;
 b=mSU1L70PzoXmAj3hNIYSf2oq1aYdJ1sGkpO/Bs6+FJhPg5raT1pH2Khd36pf+FBQtZfUQLTIe+iFQQOY5kG/04SJOuN0loLjZEJIGR4KBUKymFhguDuBPn5lYdQVVakPA8hESmYhJvpR4ijbCysaKUqby21fOToRFsxsKldE7Co=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 20:02:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 20:02:50 +0000
Message-ID: <7ccd59b8-9fe3-4d1f-82f5-f33d96dbf5ac@amd.com>
Date: Thu, 4 Apr 2024 15:02:45 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCheW=Jz2R3gMKcgwQe6ONDrRqu3tUxeg=A3USg6BC8buA@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCheW=Jz2R3gMKcgwQe6ONDrRqu3tUxeg=A3USg6BC8buA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ev9eobjZOoNoqxlrnqK3e6e30vPPKc2tcauZIa4tfumO/614vxg1KzVIqKvfEHBmbhG2NhZaDyeFyXKGNZ+M9lquHnxf3kFN1Kl+adkkCe5OuUCKPIIB80cXYOc6/LA9tIYhEg3FFlNsPCFqxvNuIcOnVppDLg52ZXlANXqhTfh7L+08W78iTkOX78ZlUkvBEzjYT0ODj+7cMftKTglARIOC5JHX+Bv8V3YYP6v8qlFZDjvy4e8bCXnrWFcibDoA2VWgmcD9t2d9vs/DkVf0mmWYaNMH/hpkrV5KaNZJo/XtivOo4MYaTM8n9qJRXfWIbjvrT/EOt2LwYF2wwpN7rMYtK6F7LXrxmtJd+MfdJSfUK6NaMW9sbgHiRzlb8A7ZZKPigEdF2e+ejLNjorGhgb/q9lvjvPu45NXeL5nj5Ndtwc190C+jqF2W1w3u1oeiT5INU8rCM7yjupfE26movrKHhWrAea+7FBKKnBvvfrAKUmubl6HQmm7d0+U2Q9r7px3PqIMkKo7B7Seqx/XH0XMz7X3pSOruwpzDEXh2M5CnLW2FIzahiR2UKQyrzwpqbIR8A0NF0DvBeQKT2sRqYQbRcBuUDIT2XXNnh64f87Tk5AhR9+w8dVP5m4GfBfIZ7QSx9dALRfzy6SNgfFQgH2t1PSRUZR55mIGZrP3Hl+E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkdPUUp0U0twR21Bb3RXa2h3UWd2VUdDditzZDA0dllJVTRRcGtVbVY1RFNH?=
 =?utf-8?B?WUgzV2xMZFJwWWxlWHNDU255eDdtLy8rQVZZT3oyTXBnSml0b0dFNGsyL2hs?=
 =?utf-8?B?QXh2dU1zbEwrd2tzUWprdVpKVHdFOUZoVE5wZjh0K2FWWXB5dHBPaDh6ZUF2?=
 =?utf-8?B?SjJpb0FRR0hRaDJseGozdHBhM0NieGQ4bXd4UzBLOFJTWFNlZ3lrZXEzeEJM?=
 =?utf-8?B?WncyUWRUQml1YXM4Uk5yL2h3OExRR0kycHV3aGVaRHBRc2E3dXlrcS8yTytS?=
 =?utf-8?B?OHhWeCtPZWlZV3lnRndBSUlnb2hQQnVrVW9zazNmdFFadGtJYjMwZjFaSGxa?=
 =?utf-8?B?TmlOTlo3K0tjdVFHN3NZQWltOUFiSXZoelk0WUZsS1NaUzhkY05USnIzRUFy?=
 =?utf-8?B?dmRsZDN3bW00dzZtL245Tkx3N2ZweHI1UXovOUxhdnlBZDE3WEdTcmtqdVRW?=
 =?utf-8?B?OUE1dTFhZStsZERReHhiRTE1ZGdycjI3SEpuOHFpTSt2aEdXS2VxMHd2dHEz?=
 =?utf-8?B?VGpCVnhTcXA1UkNPdTJWTEtQblk0ZndVOVJKaUQyRTQ1bFlVU3kyWFVYaUMv?=
 =?utf-8?B?a0pNKy9ZOUl0QUt4NERNUWF4ajJYZFZEekdJYU1rS04wS0g5YnNobWZ4ME1Y?=
 =?utf-8?B?b0ZNRHBqa3NaUHphVmdzRkhhYzEyd3ZKU2M1NFNvVzRSd0hCNDlvRkgrYXdZ?=
 =?utf-8?B?UVZZZ212eEFaSDRtTXE2WTVBREFiRlc1Uk1lcXR5WEJZb1lCZjIraktnaUFN?=
 =?utf-8?B?ZzBVdy9LSUg4T3RZbHV5WElMQXplU2VrejAwMFE5Mk4rUVJvWDhIZWRyWWRG?=
 =?utf-8?B?Q2hSSzJoU3J1YkdEcnRXU0NpWmxrbTBwUHFwRmZqUDQyUmE5bzVWbVA3VlBK?=
 =?utf-8?B?RmhxbFpCa1p5YVFZYVJnY1ZUUCtXVU80U0YrL2x5SXBDYVFhcWEvcDZaeHpP?=
 =?utf-8?B?VjAyenpXWXNSN2t6NkFtM0IxRWV6ZUk0NWZydzIvYlFzWnZtZUpqcEZkSTRN?=
 =?utf-8?B?V0VwaThKMzVVdnM3UlB0cCtkV0NxMnIwZHUrMW5KV1dUWkRSKzIyTU94YUZD?=
 =?utf-8?B?RENmemVrY093SUNnM1k5c1pUdWRGVTZwZWpEblRBM1EvWGQzTFB0ak1nVXFO?=
 =?utf-8?B?TEQ5VTY0U0VXRFBqNnRDR0MzNzBtR3RKNGl0WDRITHdYR0NNSDBNWVBOdktH?=
 =?utf-8?B?NVNjRzk1NUlCeGRJc29GVTRhbTRndkJGUWlGV2dMYVZweVU0UnBLV1JPTDc4?=
 =?utf-8?B?VmxTZjd1K2xEZU1XMEJYMGtkbVk4U24wNHJIWXpwcDBieitObExPZGU2Y3gx?=
 =?utf-8?B?MWpnaHI2QzZyaVVQSWFPN0J2QXFYZkhFNnBLY25qUHFaazFLcEhiTXMzZnVH?=
 =?utf-8?B?R3lsd05wc3owSlNKaWZCY2dOQ0JBOEhsTjhXemRwVHBNZzh4b2VSS0N4WmQy?=
 =?utf-8?B?a2hLZFZHbkE1Qm9pOFJWeDBGRHhqMmJZenZ3VkFUa0dpcHEwKzN6OFZsK3pr?=
 =?utf-8?B?aFFsclR5WnoxUzlmYlZKMlFwd3M4clpMTmozbTdoRlVGVFVyUHJ1SzNQK2Jv?=
 =?utf-8?B?YTFkaGZrNWwrTG9oRXFrN3dFRlVVenJHYVh3anMzeU1xeWkxdGYvLzZOWHpq?=
 =?utf-8?B?Q3pKSEJMcGxta2lreTFzMVZCVTEzQVhOTWZReW5QZEppamxnNDJ2UTNrRzVO?=
 =?utf-8?B?Uy95UTRVNzJKSmNLVjJZS0orL1E3SHBtUnAxejhGSUROd1BOelBaVG1sT1lZ?=
 =?utf-8?B?Vnp4S0JrcXlHaXVDNG1LUjlNVG5rOVRFbGNBenc5aitzUmNLM3gvQlJXdm82?=
 =?utf-8?B?VXZSeXYyelJvKzNrVGFHQkVJNUg0U3FKR2d0RzFidHFkSTVEOFlsUm5COUpp?=
 =?utf-8?B?Zk5UdTRma3A5YUdObkZraTFlQ0hiQk8renhaM0dtUmEyeVhKK1JQSzZrWGxR?=
 =?utf-8?B?TUNDTmpINEhSVW9mWjU1RDNOVzNMcWpMZ3hCc0pOVUFPVWVNTlcwaVNVanBI?=
 =?utf-8?B?Vm5pUDU2dXU4S0RrVUcxWmZOVVhUOGVYdkcvcXVXSktmeTVyblNQSnBHNEsw?=
 =?utf-8?B?UzZRWmR3OFZSSmNteVhGZ1M4SFlYK1NYcTd2czdYUmFITEJsN3Z0RE0xL3cz?=
 =?utf-8?Q?N6IM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c394476b-4df1-425f-badb-08dc54e23472
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 20:02:50.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5eohHa7xpRo+ByxnSgSFOzouuqtj9yLIMyXCcLvJoxqa+RvZZ9CQArHnFUgCwg7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253

Hi Peter,


On 4/4/24 14:08, Peter Newman wrote:
> Hi Babu,
> 
> On Thu, Mar 28, 2024 at 6:07 PM Babu Moger <babu.moger@amd.com> wrote:
>>    The list follows the following format:
>>
>>        * Default CTRL_MON group:
>>                "//<domain_id>=<assignment_flags>"
>>
>>        * Non-default CTRL_MON group:
>>                "<CTRL_MON group>//<domain_id>=<assignment_flags>"
>>
>>        * Child MON group of default CTRL_MON group:
>>                "/<MON group>/<domain_id>=<assignment_flags>"
>>
>>        * Child MON group of non-default CTRL_MON group:
>>                "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
>>
>>        Assignment flags can be one of the following:
>>
>>         t  MBM total event is assigned
>>         l  MBM local event is assigned
>>         tl Both total and local MBM events are assigned
>>         _  None of the MBM events are assigned
>>
>>         Examples:
>>
>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>         non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>         non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>         //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>         /default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>
>>         There are four groups and all the groups have local and total event assigned.
>>
>>         "//" - This is a default CONTROL MON group
>>
>>         "non_defult_group//" - This is non default CONTROL MON group
>>
>>         "/default_mon1/"  - This is Child MON group of the defult group
>>
>>         "non_defult_group/non_default_mon1/" - This is child MON group of the non default group
>>
>>         =tl means both total and local events are assigned.
> 
> I recall there was supposed to be a way to perform the same update on
> all domains together so that it isn't tedious to not do per-domain

Yes. Correct. Reinette suggested to have "no domains" means ALL the domains.

Example:

Initial list:
$cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
non_def_ctrl_mon_grep//0=_;1=_;2=_;3=_;4=_;5=_;6=_;7=_;
//0=_;1=_;2=_;3=_;4=_;5=_;6=_;7=_;

Two groups and no events assigned.


To assign total event on all the domains, The command will look like this.

$ echo "//=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

Parsing becomes ugly here. I look for domain number after the name. Now I
have add some ugly checks there.


I also thought about something like this:

$ echo "//FFFF=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

FFFF means all the domains. But there could be domain number with FFFF also.

So, I dropped the idea.


> customizations. (And also to avoid serializing programming all the
> domains the same way.)

One more thing with respect to domains:

This series updates all the domains when assignment is requested.
Makes it easy to implement.

For example:

$ echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

This command will assign total event on all the domains on default group
even though user passed only domain 0.

I am looking at supporting domain specific assignment right now.
If your use case is specific to each domain then I can add that support in
in next revision.

> 
> 
>>
>>  .../admin-guide/kernel-parameters.txt         |   2 +-
>>  Documentation/arch/x86/resctrl.rst            | 144 ++++
>>  arch/x86/include/asm/cpufeatures.h            |   1 +
>>  arch/x86/include/asm/msr-index.h              |   2 +
>>  arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
>>  arch/x86/kernel/cpu/resctrl/core.c            |  25 +-
>>  arch/x86/kernel/cpu/resctrl/internal.h        |  56 +-
>>  arch/x86/kernel/cpu/resctrl/monitor.c         |  24 +-
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 714 +++++++++++++++++-
>>  arch/x86/kernel/cpu/scattered.c               |   1 +
>>  include/linux/resctrl.h                       |  12 +
>>  11 files changed, 964 insertions(+), 20 deletions(-)
>>
>> --
>> 2.34.1
>>
> 
> This should be fine for me to get started with. I'll see if I can work
> backwards from the patches adding the parsing code to see how I'll
> work the software implementation in.
> 
> Thanks!
> -Peter

-- 
Thanks
Babu Moger

