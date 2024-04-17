Return-Path: <linux-kernel+bounces-147953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972AA8A7BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CA81C21CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5927F524CB;
	Wed, 17 Apr 2024 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g432sKJo"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03883C68C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713331403; cv=fail; b=dgxIKyE5ccdjlOQktmVtENN5Ehyu91XXM4iaQdzPDHJ6zkRHfWsqgfjm2vI5hN6C2oDlkV5zRwAP1vie9ehQdzw9p2c1eoKrrFhaZGfeNQNuxb+9xG/PzXjm5CTeeURhsixpYM4hG8h8IX5FnYserseVeaRGSWbi39IyAGE43s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713331403; c=relaxed/simple;
	bh=RHM1+RXa1sfGC31Smwy00Nk82xD9EZMs2knwiV1v8Sg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YiVJMJXcwXv132zTfVS/6jhRmpLr2A2DgnPUKN8LfUTMzbd2q7YcWPIcg6iSCELh4AbDGwKHnzm9odnDJE9FtArnJSLc8UA/tFy3Vo6qOwxfUgqhZ3kjLgvtpefQPD5nc9BPIg0SLyOtYrfhyMK1iWlfvpkCaCdmbAVv4OhfUyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g432sKJo; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWosSVTMPT85McDGH4Y0ddA3VB5C2IG9KJ+IbHhHAaq/6iXSQ3fO7R78rmhK84OoQFyiyBdVN63Jx6CM5j88LvQ6PCVLff5ci5TP9o0QH1erJfKa6u2yvE4aEunWthRsANYVHbGiWdFRmwur2ZnObQZo6n/ZZm+yA+abgD2wv0p+Lj810wZOE5l6lHannWuUDRkJs3wxyKGfvLxHegnPCPtQ6e27EBVCwOoUZgE411sEiEpOKRKl1PyL5xrj1WkBOXm5LT9NNhASO0mLikZARVYkOA2DaIVNqGIVqQm2YqFADJYHV61WuyErOIJNge49IsiS2ejM7Ny+JrOFK3RAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vROJwB1cRyQgbZjYDw+HW9Dw1r7Vc3cuOOcE6Q5/3+w=;
 b=FPmbDDbKs9xZ2z7Ya3FgxxMZDW8lkv92IMgWOx3E8jhKCAlfLNsJnT0Ct1WB+75aWXIwx92lxcWx63C7mQqfnUf0oBIu5nuKdsi2bafPohqfIfbdW//RRUZVoThrzqqEljPlTy19eoije5gCYNCkWWxP9DatWLGXsT+/x/e6y90sDOPvrwB4Hz7L2u6TJh/YFHspJ65rfrFDa9A7iw3rQL9hPGk9BfTi2idjcRWKnfYqufJzlATx3b+21wGWCjB/Qj7yS6Uf4CsVuvHK8HVAPvRC6t1g70s+jByY6a5dspuUkXBT5Rz1TpwtWafTRPbGEpDgFAb34GxndWLEdivAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vROJwB1cRyQgbZjYDw+HW9Dw1r7Vc3cuOOcE6Q5/3+w=;
 b=g432sKJoruqvVv9+yvuYbGNzgxpaM+zPdvUTHyKxhMA9WceT6CvUFDrv+7g/SqaIn9hBVKtPl3YTih+w9IQz93EehTYBUwtbNCKoaHtvI+mTxgk1zMSrvei/LQPAT/dNJVkevTSiM5AK/tPURMZ0rs7NO4xJ3+t7vwSO0GRvGKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 17 Apr 2024 05:23:12 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 05:23:12 +0000
Message-ID: <b0db9b48-e9c6-4e40-9d07-c353ab14e4ce@amd.com>
Date: Wed, 17 Apr 2024 10:53:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, ewagner12@gmail.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
 <20240416152943.GU223006@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <20240416152943.GU223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a301e62-2800-4596-a1ca-08dc5e9e7985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RxmbLNx+BtpgJLfwE4jArXfmm1CErMKrIATrou3oJ40XUPfaD+zj+kkqEWB2MQeG6TQbjgtLLrMsowKFf1MBM38aSpWTjS/i6MIYUS8z/8erxGvq4D055iqxW+2kLHrSrm1ium1raInMbAIrSCQm+OImslwfP4MLQNmj1gfGwZJT8v9dZtStZDv7Z0TCXXoYj8gqUZdNk4Rrb3cy9qA0VzrseP8eQk6Uwvq2FXqDsGCctShTwe2cLd9XEYr4kadld2KzNsLbvLpMWMyvAgy89w5r7x6s4JOjVmRI+hdnGAo94sTxx6fVAAOUa8tFjSWbhWrn4spsmHlax9crp1Hq9gW7Px9xHMHZMFrEE+0zjhz5rHoiiMayKHkZmYr/WGBswaheOppV3ImiMPiI2Lcs5PYgc8MHUOlsp8IVcWrJV0SABPYwShM+FdTD6Rnunnwb4DNfThi+svtRwnUxef8TGAeC53s+K/fglgxF33840B1JwVuoqKu0E0b723Yz6Uw5FcUAlhn3Xlflra+C4/O2dXxAhxGu4WbxmXchJtrV78fCftzyJpkijWK8pcoKouy4djCMcmaYFCUjQvXU4MvL+MuQ/qORbpdMsU3GCJwqd8GcWNrZ/KDAMfvE83XoOQ2wzMmtc37FDer+jGTvq+OtiBviiauFuxRrPUFkrfnS29U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjB1cDlnaGNNTytvemd4UlZKelJqNEMwckNuazdHNWZPNHJrSGp1aEpzWGE4?=
 =?utf-8?B?Zmh2NFR3UWJ1M1FvbTl2K3Y3VXVxdFM3VnhSbzFXZDdCSUtTdXdLOE9xWFFE?=
 =?utf-8?B?VlQ2d2xDd05BTlprbGZ1U3YvWFV0eXByVWh4eFBqcmZyQm11eWJ3YXlrTDFF?=
 =?utf-8?B?bkljR2hMK1N5eDhzN0F4bFpmSGVaQno5L204cVQwUCt2bmg3cm9pUVRGSWs2?=
 =?utf-8?B?VTdheDN2OC91cWNmM1FYZE5STEZSV0lLZ2p2M1JiMDlUa1U5bFNEdGQ4TG81?=
 =?utf-8?B?T0ZUek13anM3eFJJM3Q0dHM1MmhzcllVVm45M21nR3ZFbWlIMUR3RE56dXFD?=
 =?utf-8?B?TDVXajdEUkYyWmp4STYrT3lsU1YwQmxjd1kyRm92eVlVcXFIcDdJNDlBdVM0?=
 =?utf-8?B?SStjVTBmVkM3Q3B3cEx1UjgvTit6V1JxbzJnTG93TlV3MHAwNjhyR0FMNVBU?=
 =?utf-8?B?QjhtSWgxTVB2WDJjZWVpdkREbUNINVpXZk1lQ2NXRkk3U3hTdFU0cE44QVJq?=
 =?utf-8?B?SGg5Sy9yYXJHMWFEeG01c1h4RHBxdXZucGI2enlyTENXYjRld1R6NEpIV3dZ?=
 =?utf-8?B?Y2twMkdQanNXYmJaczFyM3Q1WHFSL0gyU3dtR01pdzZDWWVIbGNReXVLVVAx?=
 =?utf-8?B?OVBSaVo5eWJ6VWZiQ2FDbFlIZEZyTDBKM0NvSDNISXp2TGhQQ3BzUG9uaXNq?=
 =?utf-8?B?RGdOY0pnNHhVc2VQWVZFRzVkZ0UySXRXSEl1V0VJQUZWT1BZZ2RRZzFoTTFj?=
 =?utf-8?B?OVB0aU11QTZnMlJKTk81azZNaFlCYTVOU21zWm9RSWRLa1Mwa3NpMXZhVStt?=
 =?utf-8?B?K2R5MTl3endhV2JyTU5oRTVabWd0enBxQ0prRkVXMWdhdDM1UnppTjdjUE9M?=
 =?utf-8?B?QUs4OU1JWDR2bGEwT1lkL0dlbUVUNm9TZ0tzWmo5ck9PcVJTalpzc2RtTDRx?=
 =?utf-8?B?SFlsRmJ5WHhpd0pDcmZXTEZ1QnZwcERPNlpUM0VlZzNRQ1F1L2hxUnlyRW9u?=
 =?utf-8?B?UFJySEZRY2FYZXMvN29jNFBQaEZLOVByR0paaXVKWitUNDZRbUIxb3dlOE1x?=
 =?utf-8?B?SzlkeW5nNGxwK3MvblQ0ek5DOVVNOVlXanVpM3lYVjREejlQMnZRdDdibEJx?=
 =?utf-8?B?U3ZUUzRTZU9xbEFZT3cwVFpoSFlscm1jYzd6SVMzOFRoVTJod0QwVEpyZHAv?=
 =?utf-8?B?akcxVzVoZUxoQmNiNGtkektMK2gvWFI2Sm9TSTdJOXVqaFdUdG9BSjAyaGhK?=
 =?utf-8?B?Z2JRZFUzYURrRDVpVm52SEpOeWw5T0JlUE0ydmJod3g3RndKSERHNWVBUjVH?=
 =?utf-8?B?MEVkS3BJVjdjcE9nYUluL0pDRkRld28wRFBDZ3J5dGZUTGI1bTl5Zldta2tC?=
 =?utf-8?B?REF0SGhhaW1xS290QzNzcWY0K3orY3F0UmNNVlNBYWh3MkFucklwMi9YN3Y4?=
 =?utf-8?B?TGZEOHVEbFNKdzFZQktZTXJqYms0aElrdVFsYkkzQWwzaFQyVFg3Q3FTMjk4?=
 =?utf-8?B?THBPK240eE4rTU4zN2daYkd6c1FsWVF5UE5KZXl3VXNxYWptRGVGVVBOYzd2?=
 =?utf-8?B?amdVVnVQQXNyTjRnKzZtajZwL3hFYStnZ3lDZjZqNVp1c2JjMjdjQ0FHZ3Bk?=
 =?utf-8?B?U3E4RlR0cGYvdXRPQ3FkbHoyUjB2YkQxamFhVXZES3JOS3h6Y1l0eVQ3amZh?=
 =?utf-8?B?cXpDUG1YRlVPT2pGTmp0b0lsaDR1ZUUvblk0aWJ3U2ppVHl2Y21peGIvdzh5?=
 =?utf-8?B?Ly80VHYyVFRYWGV4a2p5aHZnU3ZXczVQelNCZnhVajhCTmlzeFVLUHJ1TGo0?=
 =?utf-8?B?VS83a0thTW80QWFUNTJ4SjRQS1hJMG56VzJSNFlzRmhSd2JQUEJOcHR4WHJj?=
 =?utf-8?B?UFA4TkVzcGFMcHNic1ZxeEwzeFQzWk5odCsvc21ZMzJZQ29ZSUFWQWRnQ1Vs?=
 =?utf-8?B?NjUrVEphekY4WnBxMVlQenlOMEFyaDZMN3RkUW9NY3NDUTFlRHlOZ2ZEL05U?=
 =?utf-8?B?VUdPdUZwRkYzN1YrM2k0T0dhWVBycGRwOFYyUllxaU4yWWlKOE4zRGdXY2ty?=
 =?utf-8?B?OFVlbjR2dHNMcDA4Y1NkWVdIemhJSEViMHpKMmd3ZFFsVHJ2SXcrSzYvUEdP?=
 =?utf-8?Q?pShLdBSpcyKYNiHxeRfqN9N2K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a301e62-2800-4596-a1ca-08dc5e9e7985
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 05:23:11.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hp5QMiON/LYVW+IGKYwBWb3mqqhSlUAYa9KKQzIttq36jcVaNNymbTMgpZIT+Ob6OrBgHaujsZS5E9ar/055Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638

Hi Jason, Robin,


On 4/16/2024 8:59 PM, Jason Gunthorpe wrote:
> On Tue, Apr 16, 2024 at 02:00:43PM +0100, Robin Murphy wrote:
>> Previously, an untrusted device forcing IOMMU_DOMAIN_DMA always took
>> precedence over whatever a driver's def_domain_type may have wanted to
>> say. This was intentionally handled in core code since 3 years prior,
>> to avoid drivers poking at the details of what is essentially a policy
>> between the PCI core and the IOMMU core. Now, though, we go to the
>> length of evaluating both constraints to check for any conflict, and if
>> so throw our toys out of the pram and refuse to handle the device at
>> all. Regardless of any intent, in practice this leaves the device, and
>> potentially the rest of its group or even the whole IOMMU, in a largely
>> undetermined state, which at worst may render the whole system
>> unusable.
> 
> For systems supporting untrusted device security the translation must
> be BLOCKED at this point.
> 
>> Unfortunately it turns out that this is a realistic situation to run
>> into by connecting a PASID-capable device (e.g. a GPU) to an AMD-based
>> laptop via a Thunderbolt expansion box, since the AMD IOMMU driver needs
>> an identity default domain for PASIDs to be usable, and thus sets a
>> def_domain_type override based on PASID capability.
> 
> The majority of places implementing def_domain_type are using it as a
> statement of HW capability that should not be ignored by the core code:
> 
>  - DART
>    * system page size is too small, can't map IOPTEs, force identity
>    * iommu does not support IDENTITY at all, force paging
>  - tegra: Device quirks mean paging and DMA API doesn't work
>  - amd: The driver can't support PAGING when in SNP mode

Actually When SNP (Secure Nested Paging) is enabled in host, AMD driver forces
DMA translation mode with AMD V1 page table.


>  - SMMU: The driver can't support paging when in legacy binding mode and
>          paging domain allocation fails as well
>  - qcom: Looks like these devices have some iommu bypass bus in their
>          HW and paging doesn't work
>  - SMMUv3: The comment says HISI devices cannot support paging due to a HW quirk
> 
> For these force overriding the driver knowledge will either result in
> domain allocate/attach failure or a broken DMA environment anyhow.
> 
> The AMD PASID thing is actually unique because the driver can still
> fully support PAGING, despite it wrongly telling the core code that it
> can't.

As I mentioned in other thread, AMD driver will be fixed to support paging mode
with V2 page table for PASID. I will look into it soon.


> 
> This is happening because it is all just a hack to work around the
> incomplete SW implementation in the AMD driver. When the AMD driver is
> completed its def_domain_type should be removed entirely.

Not related to this topic, but for completeness.. AMD driver has many condition
to deal. like :
  - Memory Encryption support - by default enforce paging mode
  - SNP - Enforce paging mode with AMD V1 page table
  - GPUs - Identity mapping

> 
> Since actual PASID AMD attach isn't implemented yet we could just
> remove that check from def_domain_type as an RC fix. Vasant can sort
> it out properly by disabling pasid support on untrusted devices until
> the DTE logic is fully completed.

Keeping PASID support aside, largely the question is who should handle/decide
domain type for untrusted device? Is it core IOMMU layer -OR- HW driver?
  - If its core layer, then this patch looks good to me.
  - If its individual driver, then I can try to add fix in AMD driver. But then
what is the expectation? Driver is expected to return IOMMU_DOMAIN_DMA -OR- core
IOMMU layer is expected to adhere to whatever driver returned?


-Vasant


> 
>> In general, restoring the old behaviour of forcing translation will not
>> make that device's operation any more broken than leaving it potentially
>> blocked or subject to the rest of a group's translations would, nor will
>> it be any less safe than leaving it potentially bypassed or subject to
>> the rest of a group's translations would, so do that, and let eGPUs work
>> again.
> 
> Well, this is true, since we can't handle the probe error it doesn't
> matter what we do.
> 
> Jason

