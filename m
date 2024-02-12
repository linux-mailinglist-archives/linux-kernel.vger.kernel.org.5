Return-Path: <linux-kernel+bounces-61420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDE2851223
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774941F22413
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A66A38FAA;
	Mon, 12 Feb 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bysDX5lN"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF238DE1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737086; cv=fail; b=mlAv4+BLi7UoWo1z76llXs/EUGMjlpnHIS465OIDH6gS9gEqUxHVhIj/lNoH7qzUOZgqZ+dqWMb89P2CYBTlHgQcJbaHEJlk0iScfD9ZwcIuuqw1B82OQiw3QMwHA+iizT1UfB3g60hfB5J3VulZ2FQXc9mMD15gse36vHZ5TOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737086; c=relaxed/simple;
	bh=CKccmy6u1p3FRshzx1bYUiFjkHmYfhO1Te8IBx8fyCc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CJS7Yyc8TB38Uw5AYNnR4QHccMFT2Flrzohg4fv1A1oWnxQCr0DFyUMzbIddTaiPPF3bn7pQ9GvWiBtUn6/upQTT3w+HBO+tih8heJmxtC0k1ciObUue617cQGG5gWPxW8JtY90dDylQ1W85Ioy5jpsY5FVOQ9bTc0T5L9p5ue4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bysDX5lN; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWDpRIGXL2v2THsNaCTQ0RcKvzfmgwhL+hBWqFIWWpEiR2Cz8QA3WGVulc4I38sAwFhrt86EneHePnJUmsbRHU6c7sjq/4BCwfMSzEaqrutC5xobk4VQPAbdimb6j+KM97Ha15k2nUfJmmbeRHPxVhAu2m7Jb8ykIzBY5GnizBj6T9/lmLHI95A8GCEJjyat+yVq4+BkctRz4OpRi1zOsSA02WdT6DBOp898IHxx+5YUUwQFX+dUjgXzyBmiJdbQDoOlP7HE5Udsr5Dgq9bq2BpMuAgCv+7nNuqqcsnx5PUmWByax96/42jEkmcES2rkc6EldDtG5L6Y5T9N+rKDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wen+MDN2dnWzT9DV9AAcAdWmVcavBDaegaU5KNRZesI=;
 b=nT2pgOk++uJ9ObpzjT3fk8Ik0ukKRwoU22BBr9lEXzlJu3AqefGFkxV9yW78CROV1Uo661dBcSdscuribuyFH7lSmunXUT8fM+9NvEbGK4YYuWI+udO9gewYgEBVL2r8fkE4OmfgnpTvvA9Pe0wptAQ19AB1iSNOI6C2panwEqrQGDEsk96agO3IbRsYysV/gWn1oCAWNk2dMyYJwLQF41hxl8lVwxHhPijWLUcq4wZpe1RYN+92z7AXRao0+/OdluIEcLXuCZBAXIlT//2C2skszDfFOtNEF9OADOwqxdrPH3NgttI/FGSPBJClhTMZsrqnX/ohOSnLrulDRD9UJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wen+MDN2dnWzT9DV9AAcAdWmVcavBDaegaU5KNRZesI=;
 b=bysDX5lN3iex7aPmjcYm5+VII69CsZF5feseCteY0J2wiqQJw0UduC9OigmbaWTJEZ28z5LjdtN6eCsdaG4VIF/PSYLjr5zBM/O3j9JMnhPQljjAYEo9KQ6/eHq4J6s8WULBEENpDAXc9Ezn9LcjMEZzDlcmoOhaFPPaPixi7Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Mon, 12 Feb
 2024 11:24:40 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::dffd:76bb:f508:a0de]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::dffd:76bb:f508:a0de%4]) with mapi id 15.20.7292.017; Mon, 12 Feb 2024
 11:24:40 +0000
Message-ID: <d698b3a0-c4a9-1ff1-dbf0-f795b5d4f29c@amd.com>
Date: Mon, 12 Feb 2024 16:54:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Mark interrupt as managed
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240122233400.1802-1-mario.limonciello@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240122233400.1802-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::21) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 323348ff-ce8c-4611-0845-08dc2bbd33d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SpQ7MF+MCKWFrtxISCdECX4OSiti2r4doscju/Dp++3ZgkqIvnr8UY6hfBpIsSmIyDUQcPEgZGbphL9Hcj8cpUWlooZTyjxb4eiiinxe5/74YBhwAHuIdHF6nRI3epwT1z/5yAOa0/rku5bLMSgJw43AgRbqAbSMzDBcbOctzpsbj920slmf7/iavLukxhQup6jd477JysW4h6Bni/Qyf+jOWWbrn9e81+DR1ZSPlnMi6sLlLqDDgBarWj86q13pjmKCR6q3KyoZI3zZdubdnp1HOT/n9yPrzhqAupPkrobzgp51dBTNESDzLgXncXXWcRJ2OpgRx+HX+uP7XydlHrcroExlDhtKho83qLp10gd/aG0D87UTBwn+SCGJVOaD02dRjjvvUfjZqfnn+ntXSdmDJ3wPlESWgxQvCzvWneZEqGk1osBxdxFZwfIKFvm8oIxsenBjnuSSnNi7+4BQ38l7nKtEDBWVBgGOPj71n1/EtXpiZi6AR8VgDuV2bxZJBvJz65xlRzIpOCeZid1GdoU9l/dyi1IF0qNIvT0q7AGlfclMwKZyCAVYoqrgdRML
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(31686004)(38100700002)(31696002)(41300700001)(86362001)(83380400001)(2906002)(66476007)(66556008)(66946007)(5660300002)(44832011)(8676002)(8936002)(4326008)(2616005)(6636002)(316002)(36756003)(966005)(6486002)(478600001)(53546011)(6512007)(6666004)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1RUOGFDUml2NHp5SlhuNEpiZm9sSEMxOW9qMGtCVVNPdmhWcUNXRy9SdjYw?=
 =?utf-8?B?ODdhcjNwQnhVQUlhSWphcnhJNVR1Y1hsalJxWE4yaXd6enkzVjQ0RDlqT3gy?=
 =?utf-8?B?MitHNHN2d1lzK3NWVzg1UkNicXBoODJ5L2Nlc0FidHVzOVBaM3lReWhJSHVO?=
 =?utf-8?B?Rk54bEpjZGtzeWRSdVpEZGt4TzN5YWZONFFyNHRja0loK3FESTNyaVN5YTl2?=
 =?utf-8?B?bGFwNmNuZUkrMnljUjJRd05kWTF2azFORHl1ZGNjMFJKekpSYURhSXpUcklj?=
 =?utf-8?B?QkJMcDc4aFNOa21kNEx4VlpLZnVTUnh1VUJlcTVzSHRvZ21paDF4ZytCek9G?=
 =?utf-8?B?aDRDTkMxRVgxdDlRbVRBbEFEZ25jOEpCMUlRVHp2OVA1N0NodTdWQTJZcW40?=
 =?utf-8?B?UGZsM3lZTEl1a1JyUU8rdUUwZXlwVWg5bXpIanZCOFpGY0hZSFFLd2ZKV3hJ?=
 =?utf-8?B?R3ZXT3FpU2dRRXBFNUJMWVRqdlhQanM3b3RpVmNSSWtiN1MvdXc5dVBRQnc4?=
 =?utf-8?B?Q29BSWhQc1J0Q0ZvVGRZb0tqcTNkUXJHZUNYSUtaUituYTdPU0VLOWs4Rzhj?=
 =?utf-8?B?V3pMSXQ1U091dHhGMVpoTExrdUExR2hmZHdwalJQRGFjT2R0bFBSK0dWUU5Q?=
 =?utf-8?B?ZFBRS3cwNTB5MVZpVHVrdVVhajB2aDliVEtkSVh2ajQzenBWK0c1K0VBb3A4?=
 =?utf-8?B?aFhBM1FIeGtlZUx1eDJRV3FsS1lzWXErcE9RNWNBeWxqVjE5c2ZDQmh4a2F1?=
 =?utf-8?B?M1grajJrUnRZSWxUNkN3Z1ZRMFFmeDV2MFhlUEF3cnFmbVhJODhQaGFOM1Ro?=
 =?utf-8?B?UFlIZ1h6R0pubEJQUFB3Wnh4TVc2bjJ4Rnk2T2RGdkcwd1FjR3R2Um9valY1?=
 =?utf-8?B?aSthMWtZa3V2NHdMN0l6YXgvWXNidTA2WXRQc2RjRE1abEIrZjNpOUtOQVlj?=
 =?utf-8?B?RWc3Y0lqQll3MFFQdG1VSlVEd21ZRmFSV1pUeWdaclRWcmY3TER1WERMOVhE?=
 =?utf-8?B?eDhmVWN5Q2Q4dklnQ1lsZ0JCbTZEdENnakRQRTRNYlpLRFRTRWVOUUx0ZXp6?=
 =?utf-8?B?bTBFZjNhRWs1NVNNZHpmdjBZUGFEMzYxUnNVTHMvV2kwV2h3T2NjaGRqQWwx?=
 =?utf-8?B?RFc5NUhWUlFETnlvQ3didHY2VEtXbENjdVBBUDVJZkJuc1Z5dkQvdHNpeU9j?=
 =?utf-8?B?SHpMY3NEVjkreTg0WmJhSFlDTFJCQUhibHdKVWh2TGhBbEh4ck5Wd0dkREJS?=
 =?utf-8?B?SUhVZUNjVTFQK1E4MnFKc3F4b2xVZW50a1UvU29NbFlaMnNON2RyakV3TEFN?=
 =?utf-8?B?U2xRV3pZdUxodWREREhlK1BqNlY5WHV4TFpiT1cvdVRPV0lCWGk3M3RYOU84?=
 =?utf-8?B?TlcrN2dPYUFPWTlpa1p1RDFoRy9VNHZpVGxBb0ZLNGtOUThBWE9HcGlSNWRa?=
 =?utf-8?B?Z25aV2MrWjZWYjRXYXBoa1kwb1BVYU03Z1NtNlIxUTFUSXVFalNzUlhwOWVr?=
 =?utf-8?B?VFZlVlU2bXh1WU9CbTI4U1pFMlpRR0E0bVBraUtWK1gwYXBqYUdtUVRMRElq?=
 =?utf-8?B?QzI3aitMYXZYSnh4cVVRUFpORzZoQmdjNEtRSmJvU2ZpVDNzWVFMRGI5TUxw?=
 =?utf-8?B?QVNpUkI4aDA2QjBEeHY0M1VZZFpjM0ZNbWZtMzV3cVhGZVVFb0IxV0M1NFAv?=
 =?utf-8?B?VlVjTWVFc0xON09RRkNmWlRLd3QwdVZpa256MTJQTndWYVowZS9iUUZqb05M?=
 =?utf-8?B?WENmTnp5OFFGRUZRRnd2dXJrRzhiTU5kQndiY29qWmVuWExMM3JDWTUzblFY?=
 =?utf-8?B?K3NodDVUSE5OczVkb3dSazRHOXdxWk85ZndyeXlOMjVHVmpWdjd6bVlqaitO?=
 =?utf-8?B?cXZSTkFMN09oTy9sbVJyeDVlRVdjSjJPcUVHNjhYKytyeUhRMEp5UnIxN2xo?=
 =?utf-8?B?cjd4cmVWL1lxd0RiYmp3NS9XZzJFRzB1ckkvUlRiU1RLTDZsb2p3b2ZTbU1n?=
 =?utf-8?B?a1BNd2thUEhGVDlEemxXN3hXaUQ0N1NhaW1rclhIZGd2SHBkVVF5d3ZXYWNK?=
 =?utf-8?B?VlpPWTJtbXhqK3BrVFdnNTJtMXFrSDBVM2QydHgwZ3pVVVgvM3dCbFZGV3N4?=
 =?utf-8?Q?qk97NqsjJ0wtJri6DqES86B1m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323348ff-ce8c-4611-0845-08dc2bbd33d8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 11:24:40.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkQVMoR+b62OvbZPjLC4+LsuQX4WJ3HEdLPy1SiCHlXGtmhTdrk6wbEsinY33uT6rQSuGamzZeiAwZNAzym6TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110



On 1/23/2024 5:04 AM, Mario Limonciello wrote:
> On many systems that have an AMD IOMMU the following sequence of
> warnings is observed during bootup.
> 
> ```
> pci 0000:00:00.2  can't derive routing for PCI INT A
> pci 0000:00:00.2: PCI INT A: not connected
> ```
> 
> This series of events happens because of the IOMMU initialization
> sequence order and the lack of _PRT entries for the IOMMU.
> 
> During initialization the IOMMU driver first enables the PCI device
> using pci_enable_device().  This will call acpi_pci_irq_enable()
> which will check if the interrupt is declared in a PCI routing table
> (_PRT) entry. According to the PCI spec [1] these routing entries
> are only required under PCI root bridges:
> 	The _PRT object is required under all PCI root bridges
> 
> The IOMMU is directly connected to the root complex, so there is no
> parent bridge to look for a _PRT entry. The first warning is emitted
> since no entry could be found in the hierarchy. The second warning is
> then emitted because the interrupt hasn't yet been configured to any
> value.  The pin was configured in pci_read_irq() but the byte in
> PCI_INTERRUPT_LINE return 0xff which means "Unknown".
> 
> After that sequence of events pci_enable_msi() is called and this
> will allocate an interrupt.
> 
> That is both of these warnings are totally harmless because the IOMMU
> uses MSI for interrupts.  To avoid even trying to probe for a _PRT
> entry mark the IOMMU as IRQ managed. This avoids both warnings.
> 
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html?highlight=_prt#prt-pci-routing-table [1]
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patch looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/amd/init.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index c83bd0c2a1c9..40979b0f5250 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2068,6 +2068,9 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  	/* Prevent binding other PCI device drivers to IOMMU devices */
>  	iommu->dev->match_driver = false;
>  
> +	/* ACPI _PRT won't have an IRQ for IOMMU */
> +	iommu->dev->irq_managed = 1;
> +
>  	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
>  			      &iommu->cap);
>  
> 
> base-commit: 75f74f85a42eb294b657f847c33e1bb7921dbec9

