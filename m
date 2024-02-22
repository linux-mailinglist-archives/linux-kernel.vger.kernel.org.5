Return-Path: <linux-kernel+bounces-76711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6062885FB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83ADB1C23CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4534F14D43B;
	Thu, 22 Feb 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Dqc4YZz"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB421474D9;
	Thu, 22 Feb 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612461; cv=fail; b=CKOu1xBLjcnF9qkPnuqe5caY4bSqBCVkRdV3X/PNC2jgqBb2vrD010Sbl+KdjIEWQzxvIsZuC2eku1G2nmW7nbYakSduFVBXcJJ3SOCq7i4z85XIzBqESGpZ2eev5uZnaf6FDgoVl2d0/9ZS9FUjcm0Eltdo05vcrhHTyKpAVCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612461; c=relaxed/simple;
	bh=jkUbFhcZul2qqx5yPF6UA84QaMiGtY+vmqnSzgIdtsk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N08VIuZ1AhlCoC00M9pc29ZW1yOzK02bxeK5eg9YGmnCjC52056l+Q3mEMgMNwjpVYjq+bgUCSxbkQgDz5qba8taXMGyMASA5mrV3vR0BnAUbECu0y04wXkPltyPyJ0qXLsDZK0M1fnL3hxbvDMg6DSjF7J9l0Mhc+mFyU8SA6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Dqc4YZz; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuXAttqZ2TggCkh9yL/c/i1rm4bJtvu+uoopVaHO9SqGPYGxV2kd7BXHL87d9uCU039697r7MFljQL8R+H48+xtrKC2MvEpSOZUalzoXRc5IsWfCY/hquLvDv6JeRVQltjunt2NCyv64JQllywrqmJ1J4iqnsl9kBYDZvCYXBDUCKl5oXWoy94iIC+RMmEE8JV4drO5W80WXBaClJPBwh/GKYu8mUfRs9UuDgMen5Biulg2YBbIcdh8rTZG3NFFbnlcDH9PI8YJsvQ4TCSYElnxbsBlvKU43wFPHz4uf4+nkaNOeNDBFJjl1AFLzMi2YilAUC7H6uBfrkr9b2Qf4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlhfb1lk1TzI6rPJ6i4EOcwuRUhV1ad4i13tbp1EBoo=;
 b=KnEFZbnTMDUvSw0dRlbHibtIIK7MafOXZsO2+uLQIrualeneLTM/t5T1bOjLxGvSycN71bNgllET0TIOBx+jP5LSs+4TpsKJRK2R8NGmkv79nHU1hu/g33JT6dukGf61MN1l80pPc1gIcYDlHs/u/7RS6NCKsDHnvUb9eIXUtIiu7vMtUqCx1Chu5HDewfDFRyPrdZAA/cP5ORYqeiowOY736VAvVNyODQQeZ3PrurBVKRfH/QfC4GH2tGzAxtp2+AjJltdqCYDy/GBDx+odyhFh8Amhi9UYngT8PPYlO7SrHrtqz0M3zDTH684GtsDiplDyFMnZXeH7e8/gVfobcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlhfb1lk1TzI6rPJ6i4EOcwuRUhV1ad4i13tbp1EBoo=;
 b=5Dqc4YZzXTPSKCPbdk08iLkojxCOetecfsvf6NAW/YrdfegEvymm+FsLLcFL5jk8gAfuUdcZdhkNob4nI+0V5QaYBTRQWGB8/N/+CO4jHdqMSFIHRA+fkZWpbQPfciLBi8f63QG5xWPAF3xB/VGpaYlnB7ojXxToa7b7z6oHs9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 14:34:14 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 14:34:14 +0000
Message-ID: <65c650e0-3d43-4f86-a79a-fb899012bff1@amd.com>
Date: Thu, 22 Feb 2024 08:34:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] docs: Include simplified link titles in main index
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, rdunlap@infradead.org,
 vegard.nossum@oracle.com
Cc: bilbao@vt.edu, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240109155643.3489369-1-carlos.bilbao@amd.com>
 <6314de0b-a69c-4e72-9538-8b133fc50047@amd.com> <874je1d00v.fsf@meer.lwn.net>
From: Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <874je1d00v.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::33) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b8db9c-9a86-4a8b-e307-08dc33b357a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UN57gjMx9jalyNa2igvSW/A1+xtlXl7mo2b46HnDQc5xNR8D6t8qZc3QTFmRDtV9ZV3vXDT3R6UmFypYwSghBkvwnr/t7BsQeSN2vqAOVOqU1OxeX4U7R+MUolfmRUwOjseRFyF6k5BZNlqrFm71zf6TLM91PG+Xww83sjDtHiXu6T2563gnncrLDnJkRGGtx1odPhegNrD4OCadpCCutrDLqQrpiNeIgj1Q3GueCvsRyiNtlrjzLeC6MP6TRGpd9x9uoEnHa/QWvE5RSilDqLV2bTG5KQs+9IoiRGGAzs8JbouY7QSTUyXugW5rb6vxCyHdGy2xdCS7uvKAGnVxd0ZeTIzptehkCBaGx9P+VE9TU3nLjbYdcZLfxlS3EfeFK+KQzc3eGhuzIIvPE3HXTsUXftknqK05jzIh1oLApKSZwAaT6YT6tob5XVgN2J0PVSoY+HcnsmZVUneP0Iw8Xz8ySfIqkW+HtQNy/rDHFsMJMs0N+cIh0435sWNwz7+9AGdgJULALWIuqA+/zngxLorHQ0CAqwZtPcZ8BjXFEqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGkzRTkzOGUzdHBCelp0amZENG5EcDNMeDhwSW1qODZJRy9kNHduM0pyV28v?=
 =?utf-8?B?ZFVINncxTGNna2E1T3R4dGxmM0ZhbmRpUW5zSFFlc3VibVBibFlwTjFSclBV?=
 =?utf-8?B?RWhHemNwUCtUc3MwU0JXMWNZL0RhSUFGUGJDeW1SdnJRd2w5RGs4QkRxSTUw?=
 =?utf-8?B?MGN5S0VwM1NrdXljN3Z5WFhld3pZdHBFMExzU1QyZHprRmxBSm81MHdKMHVS?=
 =?utf-8?B?OHdrQ2hlV2pWV1ltRm9EM2RUKzFnZUFVNGdIZVNzNjYrQWdQS0ttK2pDZHVQ?=
 =?utf-8?B?WENuelNIUlg1UkhSSnFvdi9TTHJ4QjhzQ1ZOSHkxcVFuQW9zZ3RBQzkzWm9F?=
 =?utf-8?B?TWVFakY5M25OVHl0Q3ZzNmVHeTNiQ0d1TGhPTWtkOEVHMEFzVnJYYWZyb1Rh?=
 =?utf-8?B?QXZycEJCalRlNEtCa3NIZ3BFUFR4Q1hham8xNkZSOTVVcEQ1TXozTlE1SjJz?=
 =?utf-8?B?cE10KzR4ZjFpaEtFMlYzck9EZ243QUdHRnkyL2IwUXNiNjUzcU9xdTdQaEtk?=
 =?utf-8?B?WVh1L2grSHI5emNzKzJnVjdSTDJqVnpmWklFSndkZXp3M1FnN3JjT0VIVHZS?=
 =?utf-8?B?eUJFZVVlSkd5YXU1aWV0ZkhpcVpoL3NxMHBRM09jQlNEeFJYWE94c0MyQ010?=
 =?utf-8?B?L085ZWZiRWpzZFlhbFBwV3lsQzVpcFZZKzNQZk1WWE9nTFIrNmdGUnFHa3RS?=
 =?utf-8?B?WE5pYVJGMERJMk1BdkFxYmM2T3haQkg4NUZaOFRVYXlnZWRhVi85bjEzNGRD?=
 =?utf-8?B?UEFtcTFaODQxVE9pSWFPVGpYS3VkT0RjMVFTTTVIL2hzRXFtaXJjTDBTZUQx?=
 =?utf-8?B?N1FFY0t2cFN5WjVsWm9HWXBUS1FXYm0waTQ3TjM3aHMwdUc5NjB1QVJPR2dp?=
 =?utf-8?B?c2tPTTBvSmFKTjVGSVdMMXZGck8zYXBsYWlvTmYrQTcrTTRrVU5sVTFsOXNK?=
 =?utf-8?B?SklSZFVjeW5UMDY1Yjl1VWpNbFV5cEVOUTRtZzJzQ1pNQm1qZ1c5UVk0SDM0?=
 =?utf-8?B?UFNLU3V2YzNBUXVFenFpZ0Qra0laNDRXOHZ1Vm0yZC9sNVZVNGZpT01Vc1ov?=
 =?utf-8?B?MTZUTWpsUGxPTURFeWlsdGNvR0NjaVVKcWxwS1ZjTHk5K3dhS3BSUkpUenpQ?=
 =?utf-8?B?dkZPRlA4aWhhQWV0cEZHWkNEM0p4R21pNnNUalFaZzRYLy8wY0hnQ3lWUFlz?=
 =?utf-8?B?enkyU2VSbU00U1BtM0VQVmY1Wk1kUkVPOTBvRFNHbDNQb1BzWGJPSkZGbERx?=
 =?utf-8?B?QmsrMXo2Zm8xa1pEd1J2cTZrZCs5ai9pdmFacG1PSUNPSHJ5MkxmSHkzajc4?=
 =?utf-8?B?UW5YTlZLRUx3MWhjTDZmRmRwbWg3QXF2Mmc1SnJTL01VMFRpbWFHWlhHVmla?=
 =?utf-8?B?UGV4U2kzU1VzNFhQcFB5Y0ZhMnJPWXIrSi9KeHlPNmw1N29nUlJqOEd1Q1Nk?=
 =?utf-8?B?RVRyRjd3b3VlRGYyWnZtaDhxb0xxbFY2empybWlDUmhvbnNzNi9ZY2lBRjY3?=
 =?utf-8?B?aFljRXVXYTdKVVpERDd3UzJpNEZDdnBKL0NrRFArU1J0QnVzVFk2OXdJamlS?=
 =?utf-8?B?NWVYOFVmbmV5U0FzemJxeHplK0hrOG9nUE9jb1R4R1ppdENXYVpYSCs5MWNk?=
 =?utf-8?B?TXNmcXpEd1RaY3k0alNDRnlEYXBWWEE4TTI0QThaSlEwMmI4ZXBPbVBpM09j?=
 =?utf-8?B?Zms2Q04zc3lhdFIwbzUwalgvT2VyMk9Vak1nRFpSRURKWXB3bSszTHkxWjkx?=
 =?utf-8?B?WkRUNGJ2T0ZhZkFHNFZ6ajcweEc0dXBMUWhteE1JYVREL0RoZEd1OCtGQ3dQ?=
 =?utf-8?B?M090Uis2UnBRV2ZVWkVBVFpWY1F1RHhzazFKaGZFOFJGenBEYS9kdVZhZjZF?=
 =?utf-8?B?eHJSUHkrazFTeEVnd3JHRDJveWZPQ0NWVmVBTTZEN0VhSDg3dUQxbnpmSVpM?=
 =?utf-8?B?ZzBpZHhHZEhHMFNVUzVjYjljWW02U01vQnlQeW1IdFlxRUVlWnZWN2pqNkxl?=
 =?utf-8?B?NHNrL0RxYm9TcGdtM0hCUFE4dmhXd3JWTE8zS0pvTDJxNTZ6MHVodWM3WmtH?=
 =?utf-8?B?bUlDWXBhM2xkRE1WeGYyU3hDc2ZiYzVUSGFJckVIMUFDc2k1N0lmSU1ibE9D?=
 =?utf-8?Q?lRLKsw5FcR4qgoGwFIKCbr0RJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b8db9c-9a86-4a8b-e307-08dc33b357a3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 14:34:14.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck2w6zfv9Fx1Pqa68tsmCAfg/yzTcvAFqREHzr6i0LLBbU8U3v/L039ctZvBvjPbZugySE6zTSqwYsuObkK0ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231

On 2/21/24 14:40, Jonathan Corbet wrote:
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
> 
>> Hello,
>>
>> On 1/9/24 09:56, Carlos Bilbao wrote:
>>> The general consensus is that the documentation's website main entry point
>>> and its sidebar leave room for improvement. Something we can easily fix is
>>> that there's too much duplicated text.
>>>
>>> To that point, consider the titles "The Linux kernel user's and
>>> administrator's guide" and "The Linux kernel user-space API guide." We get
>>> it, it's the Linux kernel. It's assumed that everything listed pertains to
>>> the Linux kernel, given the overarching title, "The Linux Kernel
>>> documentation." Constant repetition of "Linux" and "kernel" (45 times
>>> each), "documentation" (21 times), and "guide" (18 times) are excessive and
>>> affect UX.
>>>
>>> I propose simplifying without altering actual document titles, the text
>>> linking to these documents on the main page ("link titles"). For example,
>>> "The Linux kernel user's and administrator's guide" could become "User's
>>> and Administrator's Guide," and "A guide to the Kernel Development Process"
>>> could be "Development Process". This is what my patch does.
>>>
>>> Also, I send a patch fixing the formatting of the title of
>>> admin-guide/index.rst (The Linux kernel user's and administrator's guide);
>>> a detail I noticed because the link title would not work otherwise.
>>>
>>> Thanks,
>>> Carlos
>>>
>>> Carlos Bilbao (2):
>>>       docs: Correct formatting of title in admin-guide/index.rst
>>>       docs: Include simplified link titles in main index
>>
>> Is there a reason why this patch set is currently on hold? It must to be
>> feeling a bit lonely by now.
> 
> It's been sitting there because, as I explained in response to the first
> version, I'm not really convinced that it's the best idea.  We're
> trading off the readability of the main page to make things better for
> the sidebar, and I think there are better ways to improve the sidebar.
> 
> That said, I've not managed to get around to experimenting with any of
> those better ways, and I don't see that happening anytime this side of
> the next merge window.
> 
> So I'll go ahead and apply the series, but I do still intend to revisit
> this area when I can.

 From my perspective, this improves readability for both the sidebar and
the main page, but I know that is a subjective perception. I look forward
to helping with alternative ways in the future.

> 
> Thanks,
> 
> jon

Thanks,
Carlos

