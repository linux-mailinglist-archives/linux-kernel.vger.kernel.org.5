Return-Path: <linux-kernel+bounces-146813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 123FF8A6B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65BE1B2218D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8046B12A177;
	Tue, 16 Apr 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a4Y1yRlc"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267812BE8D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271468; cv=fail; b=FWsP+9Vn0tMrXa3aaXR+hGsmJOmvcf3JxZgRy5Ht3upya9vnlbVjsj1HMdxG4Xty6Jens2smKR7X2LJ+13qBZKg9CL1lQsGnTV+Ay/t93x7+eRHoM26NBf16exZE0dksD05zBGOq0PngJDUGZFD4HuLzCa1ET+HAZURBBxyZ2ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271468; c=relaxed/simple;
	bh=qhyMvDpTREIcU5KN/aja0/nj23iGPLkf7jwO4LA6jOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YpIWgpZut7EmBNs9ju0mJ5TK2J+EBB8GpvvBxOaE2RmCQf3BL53Y+BhuMOgOipIpPlw1lIObh6O9w8QU2p2oDuv0mCOEr4I1XcLzFRNsTME38hw3dw/2/Ul+E/euFBrccOS52xOQADmktDcei69A3uh617QLourT1juhK6Ae4TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a4Y1yRlc; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmiBR5YxRuB4Akw0YcJ5e4OEGULMWff7SQV3Cp7dr+4jqMl/OFqJwuSf/RRbSYdKKTiRpV7Uy6r4uL1a0H9Ys2AV4oBmSAsCJzG7wZvKLQkwsRoK//EoLzDdraRm+ZAiuDS2Xpki8RafBk8iQFtKJVzAy11uSh0L9+KjzAPz82sHtmg8jPRmo+z7XjDtXNxkwGgUsbnrq/ccjZVh5cvOvlRirmTGIONTZUkU4HkNfX3EndUjf1ma9T/pjDUvFrg2hTiMagmwdpa6HZkQe8AvOhDq+/7Y4Qi9AR+DEHB3J2T0IR8G056BWgIrGW6waqOEKcc6Q3cEg8Zc5avoGz4HhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTAJR5juVykFb5n/rAqKI8jcqFMV4eUhU9ldZGQrGKo=;
 b=CBElPhQxnTukS7tWndYzLvsdgyXsxf5cL4kPrCDausviOiUYfymMrwEVHM1KiG3qUYmU/Yl8MdwQK3bEyHBBOyihn6hctEHKnuLRnbcX8n+0PMJygNiTc6bcChlnY1TK6BTAls8+M0TqXfDvOdEclfF/G7Y+meCb7LRQVEdNwlHg9CjmE4P2m08mlhI3UXp/9A4MtBzxDO1jaWyyR5aekT958Q79W8sJUZRKpMGJM0WLOKz0EeAxhL/4fTzpgByhwZ5xawhUVtoQx9Y1/4iJG4mBnP2nunxmzf/b26FBdGS5MFc46FspN/IO0RfqBf1H26OE4C++evsI06MdfzSoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTAJR5juVykFb5n/rAqKI8jcqFMV4eUhU9ldZGQrGKo=;
 b=a4Y1yRlc2E6PNXPRb/EQLq2y3gCwliEjayN4aC/iyH2nxRVHPgA7FwJZmswyQXFu/SOSYm1pgQiBU0klyhaaRM9l5erC0kvctx6kw1rbCU0g6wfuEOxaj049vNMmqZeX5kWwfh6SqTCS2a+p2Ue0rtJL9CsvR5vXQMFgmUi21vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 12:44:24 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7409.042; Tue, 16 Apr 2024
 12:44:24 +0000
Message-ID: <4ec76a54-cb83-40b1-a156-a6da3453da5c@amd.com>
Date: Tue, 16 Apr 2024 18:14:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Eric Wagner <ewagner12@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
 <20240416003903.GR223006@ziepe.ca>
 <47d4bfd6-1d76-4bb8-a33c-c9c99b86656b@arm.com>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <47d4bfd6-1d76-4bb8-a33c-c9c99b86656b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067EE.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2a) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce0de33-3a02-4eeb-3a6e-08dc5e12f1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9HSkuqUzQU8U1tp1W5FAZOMdvpxExcaVTR/oBexyl3QkkkIn+IfCxpor/FweqZp+FvJJ63WgD0LX14kk0eCE6c+KqMy9TFc5uFMhFk6yFvNwkM1R0kQyA6P8PCRAHF0juUoGh3iibNijUHCVyrLgrqj7IyJIji360r04K1ugXnEvWyOckUCT6n8/3vAq5yMgiMtNg0Gli3tZvCOfLPMAETVVDsD6tzEiAtYIVn3r/xPlK5KWhwZR2eYB40AXfmLzO2BUGlpUEgyrMj1spI/26v6I6RQmvIzxIYKfOaISGhZ9GfDzT+Bqd3PrGI3/oY4tNhpC6T0K7YogO0wJ616fjxaEV/7daUU5pC3AhQrRVeBZW98bN+kKBWUIEdERveso4QNACQAfqMntMZ5IZXyD2ad2+LGqKimzOy5P17eojeRXoHJpjh3elaDeGlQ5VciofQvljY7QrryCYX7OKSgLCti3ce/xZEir0GAcrpQbV4YsCHMxOWdj5m6sGWahvQFmDkVKFZ4DekeOOu3SwTVKw5YE20o82HiDxLeYDQj50uUUg/hSvjSRae0N6fcMSm1XFi1TJur/RvykrVG1VpWEnJf/xxpv3DMZhFWokTE65h3qTp0jVkmigzW2TrBetHdFdHDR+AatNwlfr4pUTNZNopseuOVB6yddXKPJtuVo5I0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlRqV2dsbEQyTjd1a05wa0pZRExRY0V1bFYvVmg2Y2hJSUxHaFRrSDhEYTFh?=
 =?utf-8?B?TWw0TVhDdzJ3YmExNGNDa00yVTA2a3pmM2g2cEk0VnVOSDd6Q3p1b2hEVm0x?=
 =?utf-8?B?RTVQcisxYjdUOGNiNGovVXZkWXR6aXVUdHlERkdXaklJWjBNVG9rcGx6cDg2?=
 =?utf-8?B?L3ZwSWVkZ0NKM2hvOVphRVNkSFUyYUNIVGxTNDBmZEJ3WncwNU9CcDBZQUwr?=
 =?utf-8?B?YmJNbEFicWxlKzAvN2trZk9aL2dta0tPOXNPSm80UndGZzhXazZDS0dBd3hO?=
 =?utf-8?B?TEJaa3hENklaN0xjRmR0ZWZBSGVhajV3WVAvRTBXbGxqaHNYN2dPVUdIWU81?=
 =?utf-8?B?YnBSanEwMkVZN0RIQXZZeWMzQnY3V2M2QjBKRnRlWnhObU9aU2hreStvcjBI?=
 =?utf-8?B?bTRTTW9kdXVGQ1I0cmhTcEdoS1VTNFRqaUVYSGZuWWtVVmdVVUxSb3BFZGln?=
 =?utf-8?B?Y3IzOGdiSkR0Q1ZPbXF5N1pBd2VIbFIrY28wbVowY1dhQklGNGVIcnlmMnJE?=
 =?utf-8?B?SUk3UGw2YnRRQnlkVkQyOXk2UGxuNlFscUV4THdIWHdXa0pqV0FRZHJwWUhR?=
 =?utf-8?B?SFJuSU1yU1pzeTVSdWZUeGpVOVFnc3NOd1V0UHJ4ODJzaUVpUVpTU25SaEZR?=
 =?utf-8?B?NDhFWmsrNWU4SG5TdnQ0cnNSckgxVTh5VHhpTDN0Q0xyVERsMnFIcTBqN2RF?=
 =?utf-8?B?bVJDNmM0TnFpZGp2WlNTYkl2dkZlQVloTmdPWGFmVTlqU3VrUU5pSkNkNldH?=
 =?utf-8?B?TnFub1NnRmpsbjVqR2xLVTg0UnFiUFhiZlAvQ1h6cUV2UFhvZjFad0hTWEh6?=
 =?utf-8?B?aWx1dWFNY0NRS0Z4UVU5RzQvRUZCWUU1V2JpY2RyOWpJMlh3R3pDM3ZDVzZH?=
 =?utf-8?B?VXNrNmw4SlE2dWdrc0hBNG1qRUFNMGFhVXp5aEMzR0c4eUtkcXFNaEhiUWdB?=
 =?utf-8?B?eEFBREFWQm1iZTVFVFJGRDd6ZWxmeW1pRVJqa255N0tJajRLWlJiZnA0NW5V?=
 =?utf-8?B?czQ3T2lKTk4rRFU2K3ltanNvQ1p3aW9PNTR2MTYrMFZDUEhPcUxNSjBrWGQ3?=
 =?utf-8?B?MHM3NzM4SmcvUFNBejZQTXRPWFpndnpsK082OXZjUVBLRnZoLzRwYWxvNDBF?=
 =?utf-8?B?L0tzYXVIWit1SU53bXRobSt1ZXU3bGFVTExpTFlPMjFVK29OTFEwTXJ2c1Aw?=
 =?utf-8?B?Tm9ySjdWeWlTck1STlJNUDJUcXFhdXkrbW00Ri9EdytLc25YbWRLUDBUQ0pN?=
 =?utf-8?B?VFVML080ZDZWb3ZLeWV3YVZQSXd2UzVWU0kxODI0RXN3Mm1udkxENEFTTTlk?=
 =?utf-8?B?amVJUnF0OTVOa0YyckVYcDd5eXJ2OWJzdHp5ZTViY24zbWVoWFI3eGJwWVBT?=
 =?utf-8?B?cDloK0lhckU3QjhXUW1zZGM1d1BCR2NFTjhtN2Fwa1BXM1VkbGlSMTVybldM?=
 =?utf-8?B?L1FNK1NmQm9Gd0gvUzFlVlNVbjlEVGw1NVNWV0tmeDg2MUI4WmFhMGZnY2I3?=
 =?utf-8?B?K04wTzlkTGM3MWVCY3k5YVF4RURsY1hWTlVQaURxUDE4ODlzRFhidVZnZzl0?=
 =?utf-8?B?cnA4LzdhVnQvVGhYVmtReEpUL29PcGtJNFA1SEs5ODBrSmx2VlR1UDhBaHZR?=
 =?utf-8?B?bjZYSHFxcCtXQVM5L0hicDNlbVBHU3I4TUJpUWRZM01MQzVYQk5kWXZWYWUr?=
 =?utf-8?B?ZEk5OUc2RmJnblNBQ0xhcDdWSGwzYnIxU2tLZU80cTJRTlYxTzBKMFROODU0?=
 =?utf-8?B?dnNZcldBMkRHbm9yaUtJMGhFOXBVNGVSb3dldDVPOTcxR1dBNjh2elV4UUwx?=
 =?utf-8?B?UzRJd3Rlcnk0b1gxN3htK1FjK2k0NjF2d2RIU0wyTDFSRFU0S2c5UDl5WWhI?=
 =?utf-8?B?a3JXOHlFWDk4RlhuVENacVJqR0tuaFA5ejJXV3dMSitQZEFZcWc3b0JrOTRT?=
 =?utf-8?B?bDJUZ3dPSklmQzdYTUpucTdUM3RFMnpQdWViRjFGR0NsaWsrMkcxWkN6NnNX?=
 =?utf-8?B?WWdkVkVMTWU1RmZ6TUxydFV0WVhiQjN5bWNLd0dvVWxjMTI1Y3p0K0ZYbjRu?=
 =?utf-8?B?UHBwY0FrUnJXRWdPS3BFYklBMWt5bU1XVmdHUmRzSXdXU2Q2aXY1WWFLbkJM?=
 =?utf-8?Q?2EtIhqcpU8lJYvOEhfIb7yW+h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce0de33-3a02-4eeb-3a6e-08dc5e12f1be
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:44:24.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtH/ntK3E+BUfLaRbAXVzdYzgUfD6bDa1oAiqIEK8AzF/Z8oVJ87HnU+ra2Z9EfYDTHXughjWfYJPFbq5RnK2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613

Robin,

On 4/16/2024 4:55 PM, Robin Murphy wrote:
> On 2024-04-16 1:39 am, Jason Gunthorpe wrote:
>> On Mon, Apr 15, 2024 at 10:44:34PM +0100, Robin Murphy wrote:
>>> On 2024-04-15 7:57 pm, Eric Wagner wrote:
>>>> Apologies if I made a mistake in the first bisect, I'm new to kernel
>>>> debugging.
>>>>
>>>> I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
>>>> 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both were good.
>>>> Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
>>>> as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good and the
>>>> bisect log is attached. It ended up at the same commit as before.
>>>>
>>>> I've also attached a picture of the boot screen that occurs when it hangs.
>>>> 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's causing the
>>>> problem.

../...

> 
> "Failing" iommu_probe_device is merely how we tell ourselves that we're not 
> interested in a device, and consequently tell the rest of the kernel it doesn't 
> have an IOMMU (via device_iommu_mapped() returning false). This is normal and 
> expected for devices which legitimately have no IOMMU in the first place; 
> conversely we don't do a great deal for unexpected failures since those 
> typically represent system-fatal conditions whatever we might try to do. We've 
> never had much of a notion of expected failures when an IOMMU *is* present, but 
> even then, denying any trace of the IOMMU and removing ourselves from the 
> picture is clearly not the ideal way to approach that. We're running off a bus 
> notifier (or even later), so ultimately our return value is meaningless; at that 
> point the device already exists and has been added to its bus, we can't undo that.
> 
> However it looks to be even more fun if failure occurs in *deferred* default 
> domain creation via bus_iommu_probe(), since then we give up and dismiss the 
> entire IOMMU. Except the x86 drivers ignore the return from 
> iommu_device_register(), so further hilarity ensues...
> 
> I think I've now satisfied myself that a simple fix for the core code is 
> appropriate and will write that up now; one other thing I couldn't quite figure 
> out is whether the AMD driver somehow prevents PASIDs being used while the group 
> is attached to a non-identity (and non-nested) domain - that's probably one for 
> Vasant to confirm.

AMD driver supports PASID with below domain type :
   - Identity domain
   - DMA translation mode (DMA and DMA_FQ) with AMD v2 page table 
(amd_iommu=pgtbl_v2).


Currently amd_iommu_def_domain_type() tries to put PASID capable devices in 
identity domain mode. This is something to fix. Its in my TODO list. I will try 
to get into it soon.

Hope this clarifies.

-Vasant


