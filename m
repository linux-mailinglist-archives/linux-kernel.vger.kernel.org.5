Return-Path: <linux-kernel+bounces-109424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0788818ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCD61C20EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC4885951;
	Wed, 20 Mar 2024 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gQnzXPKc"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27789224F2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968820; cv=fail; b=Gh9gZQmDaTlk9LIDnx+GEHE5/zT75tezfLy/MCr7HLAbD3DEsAGv/97D4BgEENmzKlFxqKdKVUi4snU31Z2UoLF2C37iBWxurJZRqVeskuvXDo/tFEFEHaf/q/Tgb7hyW4UwhhjDoJJrlpoAY8uBldTvMP2peG7tWyX5ZaFZz+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968820; c=relaxed/simple;
	bh=wpW6a/+2jJ7Qh11giKv6/p2oZeqzJH3D/qoMSY9338k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j9vYbPw3TafYdNCa0p+g6Zjwh32M3Rq+JHbfUIUjmsrp6sRtpRiPheMI/H6Dh7b/uidr7hARezginwOvD5lNjI5QdZP+ptpSDJ+XlrfIwoK0Vj82G7ASU42TBzeCNCpV5BTnvt3ri7ABpExumesSTWhAA37X2GEXFBr3d5sQgUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gQnzXPKc; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmQGVLJc8MxUvt5B7NzMUIUr+GiwqY1ZmgK7V2251Nk8WcSmkSQPLgpJRfWpDETVNVQrZKqWb+xZtbanKXaENd+S4hplFPLEIt7N803mLWR4+OhZERpNJJGo5dhFS8TY34JkAws3+veRgrEkzsLoO6efn53GENYopHtCyjIlHC9giQP334/C8ITdiL6lyuyXcsr9LJoyAcPI7QXpQPcD1z89qsT8WJvyF1jZCkRBD3BZ4nyTjNaIjh/bg14ya11TCg7v1kcSAmNMSrUDi/xcwk9iQ3RjT7H8BrlI1vi6VKhAq44vjeg4P2/ap728oFs30F6e0vpBg9pbQcbjcG5hIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5v/77oyBjyZpHWWq6gW6AALVsLobKlDPS76Rl3+Eo8=;
 b=VkBMa+AzggRtiKX4aAY7OfOoIXTFElWg76ehY9ILXkepXXIaxcsClQjUMWr9wO9gcNhqGhb48ABZQtGqUfxkIelTJZqABjzRWKvhbctgSwnbIytNVAOWMpHPaHgSJqZ9QYcQjzdK2xNJjFI1aosGhHU6NfsH1myNq7XAFaLWM7Mbk8rVcdX2T6K/HRS46Txnu2f1WXJc/TU4qQcDWorFLiXpXVzZswV+rJcEtMD8qQwmmuE7U9giKAdcberUhXK7WSnyZI2+s+rNc8HXbU10CLy/uXpmiUZ6vW4TB3ILE3rmOXQoP1Re7d6Y7hQM7nsv/+qoisuElsfhJwIlbm5M+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5v/77oyBjyZpHWWq6gW6AALVsLobKlDPS76Rl3+Eo8=;
 b=gQnzXPKc6o8fvr4dwikpgwvQ6+D2ijd83gyvS/+T0sN87wTZYr6O+nOZWPx7qfWTHh7zGxugQ7LH23NjqHyWBMAqJc2cjdsxOlEAekY7Eizj0/le7jjV9LPEWF5VAFrg8B7KU1Xzl/GQIjQgr6UJwa7gwkZ26Js9wZ0so0pBrMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 21:06:54 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%5]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 21:06:53 +0000
Message-ID: <af42b662-1183-4968-807c-96b37166d316@amd.com>
Date: Wed, 20 Mar 2024 16:06:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
To: "Huang, Kai" <kai.huang@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
 bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com,
 ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com,
 nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
 <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
 <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::22) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 68670b15-318e-420b-c824-08dc4921ab52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OSwkTYdvs508FtADzZyWQkkMQRw//VRxj8FISWCBZ6jn6NhyIkxbvzFjM/iYoLaufd6RHhOOB2oiOQG/fTm/C+RbBxL83tbGj5/42xrbgp9aHe85eYyI6TFzAl7D5B+OLjq1jlZPduc9GBAcotJt45Wel3AIqG9F+NEsfqsIwypHuYjHmu4AWZyAW1JtGII9fJpSE10C4kD3jwT7AWPb4lmpf3bU9mR8YgSp7YEQwgEdfn5Sv0W+mW1XIY9NIwXSQf9OHc0qr5sAVUUDDXPZmS7gQvBbk6ItBEHcOTwk4XY576/3797fnpVpaWKJ8geQqGvPpBNyn/nGossJAeqv8Q+mHmFvZmeqHRwEn1L0pLwLrSonqV9jU5zWAH/NwtwIcFGxBC9eyVG8H00Kb7VJdgLCUFa3PsRHsl00WJc9ZsbDPRW768Dg1p1Nt3uPtmu/dxlvoX58t+kfvnDqBMxEaVo0JP0ZX/PtlIqMZbcJyfZ1ol7QqneqKGIPb65rAHLIpbU8iSqJv2N0RlX05Zu7LtauHVa34Ex0sFmt0wX1SOmtqawPO5DJDXme4InvOzQfb16ZauoMb3vBjXjLbFr9zQ/49QTFyYiiJ7qynD/Xoc8vc3ovrlfu4wmf7pYdQ/wVQi4c2mP+UIAov3een8yZE8yCPPnEzwGc4Wz5pD+kZ9U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGh1OGJMbTNybDFrTjNCYUJWWEM0ZE8zLzhUMmlRTlBKY01FNERscCtuaDkv?=
 =?utf-8?B?Y3dSeDhCdTRpWFFxdGpFbEhxUkRjZFVjUHZYVXpyRVNJaStWYmdJY2pmVWxF?=
 =?utf-8?B?dlE0aGttUEVJQ1h5cWhnaTNLTGY1RG9rY21NSjBHWjBCNENmNTBHZUNLeWhr?=
 =?utf-8?B?Q203S2d6K3NlajR3REFmVk5Td3pRV0NGUUhXalZlWWtwLzNEV3VxSFgrQm5M?=
 =?utf-8?B?LzkxK2RZV1lGMTE2YlQwZ0ZZRHE2bzRzTVJLZUZkc2sxM21KWXI4eE8xZWRD?=
 =?utf-8?B?VnJ3MXVTWFBIMGt3QkZoVEhKU3QxMlJpVTh5NDhFakxSUzNiVE5QR0Nrclc4?=
 =?utf-8?B?SXBsZ2pUVUUyUmxxbWR6WXBpZzFONmdWZ2JTY3BGNkVqaXhLdXBaOXkxVDZs?=
 =?utf-8?B?UkRnVUtEbmprSG4rRjdwTjJlVnpVSG1aL0NseTFtYzhvWGM4TzVZME9HRTM3?=
 =?utf-8?B?MlVJVjRMNU5XcEZheHNZcExYTFdFZERFelozRllKa2hsVm43WGpCR1N4YVgz?=
 =?utf-8?B?WmpIbEgwaFYzbW00L0RtaUtSMCtXaDZ4TXMrYllacWh5L0NpSTdzZlNkNVIr?=
 =?utf-8?B?cTNzeXhFZ0JoRGg4eWRuL1pxb21lc0EyV0lDUDRoZlkyemJnREF1S1FTN0Rw?=
 =?utf-8?B?M2pLZXZpTHVGd0NnRzVBalIxQkdteGxTWFFEeUJBMmo4Wk9ISjhFWi9yU2dR?=
 =?utf-8?B?RkdJUkNGUjY5dC9JRXhnU2R6RDVLbjRGRWM5Y1NBcTlrSmI5MjNPT29oWDc0?=
 =?utf-8?B?NkxCR1RKT1pnMis1UXVrdGQwTEhMVlBCc0JJZHFmMzVKMTByMFV3aStWZUdn?=
 =?utf-8?B?b2llS3Nkc0hUMEs5eDBodEZKS2VTS1hvRmwzdjZCdFkwL0RWWjg2cFYraDZ0?=
 =?utf-8?B?c1p3RHg5Yk5Ld0NGZ2tiWE5ZeVVRak81NndHU0o4a1JCNkF1RDNhM0hoeWIv?=
 =?utf-8?B?SXlhaUlpRTJRdkpVVy9nQmxSTk5Tb3lxcE5sOWhJbWt4bHcwOW1td2VRZnN5?=
 =?utf-8?B?N2p0blVkaEhBbmg1dUhNVUNzZXFwSWhXdGxLNGFxNlVzd05kZFowVHpmK3hk?=
 =?utf-8?B?RWJsN0V4RHFaRzRjeFNjcHc2dHhUR3RPQ2NhTVh5VXdxY3VWdTdwYVM0cnI0?=
 =?utf-8?B?TzdrbWpZSDdMNERVM29HYzFRMTJMK0NCVm4raERLTDBHVDlmUyttTHQrWjBX?=
 =?utf-8?B?VHVOYUZkV2tFdlVKbng4N3hONHUzYVkvcDRBKzAwbFVicDU5Mm1WMElYaUc5?=
 =?utf-8?B?ODFETUJENkhNVTVEMzNzSllXYlIyMXRJeVRWRVdSTWthY1k3NlljMkFXdThj?=
 =?utf-8?B?UldMZXF6MjA5cWR3SU9KRHNzSDdFNVlValNWTm5DY3JJYnpXUTY0VHR4eERv?=
 =?utf-8?B?QnY1WWtpVzhGM092Q3lRcVJMR2xJUXgvS2FWaVhtOXh2U1l5RDIyZHJRNjdv?=
 =?utf-8?B?dk5Zb2tUV0dOenRjeTNVdUtlTFJBbWhBaTNVL2x5OGROMWp3bXEzUnJZZTM2?=
 =?utf-8?B?UTNOV1VBQW9DVmFkWHRsd2NuQVhVTHhIVDJUb1gycmNJNG5NdlZObzhneUFC?=
 =?utf-8?B?bDhyR281RHJEbEZpb25EMURuUWdXbVFVVEY3ZGs0YVBrR1Mxd3d0SWV2VTVk?=
 =?utf-8?B?NEZWYXNYOVpjZVRMaTdYSXhHbjJJMEFBR1NVTncxVVV0WmRndEN1WW5La1Rv?=
 =?utf-8?B?T0xYYmxIWnFzYnIrQStlSkJZeE5UeDdLbER4NVZ0aHBFZGlETDlUYzgxOXJh?=
 =?utf-8?B?NVVpK0xka0pxYlBlTjluSVpHSkVHNnYyYXczektsRFl6cVdia1YwOCtlREtp?=
 =?utf-8?B?WHFITEpkS0ZpVnRoaUlnVHlaOVdaSUhieDBxQ3Z0M29XaUdzRXNpRDU4TlI3?=
 =?utf-8?B?WklpWGlId1ZPNG5uQVJaMVFnaEs1dWhzTmFkUmNuT0xlbUFwempMdzZ6K2FH?=
 =?utf-8?B?WE1Pa1AwNSsvckpTVERSZXZ4SlZ6SW5JQjVlbzlhWFcrSXFkMTdJQkRGSzRv?=
 =?utf-8?B?bzF0M25Mb2ZxRVRuTXpJMlVoVlVzQitTQ0pGaHRhRGZzaUFOV0tLTWN4ajQx?=
 =?utf-8?B?NXRLSEZCc0hlYXozeXJERTBtV2hVV3kyZkJhSC9iZS9lVlF4aHUvZWQwWlhm?=
 =?utf-8?Q?rVrCwjn/EahxLvpvIZc2WEJGP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68670b15-318e-420b-c824-08dc4921ab52
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 21:06:53.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+uvYXHZYE7TPIYWGNUt/ngUurohy/5RpVkbpHlYVv3blijQ3d3TevJ4dJ+EYwuHwz07vqVVFG3pafgXy2eXJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081

On 3/20/24 15:48, Huang, Kai wrote:
> 
>>> Hi Tom,
>>>
>>> I am not aware of kexec() support status for SEV-ES/SEV-SNP guests. 
>>> Does patch 1 break them?
>>
>> SNP guests can kexec with some patches that are currently in process 
>> around shared to private memory conversions. ES guests can only kexec 
>> with a single vCPU. There was a recent patch series to add support for 
>> multiple vCPUs.
>>
>> Patch #1 doesn't break either ES or SNP because we still have an IDT and 
>> traditional kernel addressing in place, so the #VC can be handled.
> 
> How about plain SEV guest?

A plain SEV guest is fine, since WBINVD is intercepted and would just exit 
to the hypervisor (#VC doesn't happen with plain SEV).

Thanks,
Tom

> 
>>
>> Whereas patch #2 has switched to identity mapping and removed the IDT, 
>> so a #VC causes a triple fault.
> 
> That makes sense.  Thanks.
> 
> Hi Kirill,
> 
> Does TDX guest have similar behaviour -- that WBINVD in stop_this_cpu() 
> can be handled although it causes #VE, while WBINVD in relocate_kernel() 
> will just triple fault the guest?

