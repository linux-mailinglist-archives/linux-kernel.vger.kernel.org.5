Return-Path: <linux-kernel+bounces-53012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC69849F85
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D45B1F22EFC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259673BB38;
	Mon,  5 Feb 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="muECNGxM"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CD28DD0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150714; cv=fail; b=jTw4uzNrQjP35H+J36ufxi5MRI0+EWiZksZA4iCgSKfx0/aAlBPYX2Ek91JnqdrlYXy/ot/fk8BQVzMlXj3kEURYNF0FuD0AapvthnvjZwagGN6jIFNcAk7R3TtzWExs+dldrBVZjgwhtMPWCiW0+EUe0XFaUn6esRToIw6u6ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150714; c=relaxed/simple;
	bh=yx0bbtG2r3aUbvcnbBDgIif8j7p8YZZCIvmi4PaIvXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IK4msF0C/m/eUINdYThrnuSS2Q8uexRHmN242dKeR3Ofze88cEUetqe6VZ4jL8LUKrdCyAbAuzXxSqFlFh3XTmY2l2iOFNAVw7nMT/xTXP4vFs8L3jf7FCFt3iUWB4iZuOKDuwvu+eFMRST9W8ncXShwVJ6OTQ8xl7RhbHLYsA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=muECNGxM; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0fOVVr2RVIGtH9KOGifwbiIMnMatiQfMHw4hhcDxIoloM/eTtwjo/tJJfNYx/hwI2LQJhGuX+c5EzkJdtR00PbgBcGc4K21J5oHIG5LvsVMrMM1znSj8vOya7Oy5TttGqzLQYICzerkGQmIp0KB5kpYjCdDVhJWDQpp7QKij9ulRN9DQLK3rs8DyuDZDiLBHq064LZNNkUiZtQilTDUYP213Oj1aETkInxRyTIzyidT/0enn50NN+5BUVrmyMKQiTEOs7EpaJRS/hu0tEmYMfy7+X7oZz1Q/u0op0K78vCMhpKNTEqynD8pUhcueAEbx7yKbrKYO5arBSKSq3Hz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vd5VLnqMBpQ8e2/w02UjvzPG5JBn+TIcoZK+rMmTYwk=;
 b=OwoJ0vGc0bIq3jPYm+cOWcOGEXgjvgep8FjLvgzdL+KkMglVQwLEjZrIgZx5ShCdEcnFPQQt5p43CEm/B3zvGTLrVIutgqm1wgyXQCAO+XL6DR573EIVDAwUAVxFsVYErTxRi6qlOWt3znJuX0Zcs97S6MTB3FFBovwemzH/BFf5w0tDA/8WHBWRM9rN3mefYNmirw55k3lNwCzWmYESGb/6mooBt47XEk0GgDn9qsTwzwv1leUm1tFbrqMcB2hK8WIfVhwODYvDJDB0qdsZR8HwFUC/N3t2gFEdnDlP5/m7Hqs9Eqe9ZFHHGgFOsNUXJqio4CBgHr0qy6mYPfS1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd5VLnqMBpQ8e2/w02UjvzPG5JBn+TIcoZK+rMmTYwk=;
 b=muECNGxMQA/NDN2VXFk9UxxYIkAprzjeO+78RtUjCoDDpGtzIZwekE3Zk6lexT7nbSgv6qbA18lvp7DSbKWlX2r80gHu4G8/2x1z+tMUkTTy8JtrnuSYu+R9yBgMvcKdhRClcNqYH2HwfIxOrjITmtg+FGthzhVNDE1sQuSCyyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 16:31:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Mon, 5 Feb 2024
 16:31:49 +0000
Message-ID: <de66890b-a42c-4d8b-8079-fcfff0007aeb@amd.com>
Date: Mon, 5 Feb 2024 10:31:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Mark interrupt as managed
Content-Language: en-US
To: joro@8bytes.org, suravee.suthikulpanit@amd.com, Vasant.Hegde@amd.com
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240122233400.1802-1-mario.limonciello@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240122233400.1802-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:806:21::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: df7b734e-bca4-4811-2f1d-08dc2667f3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EutEm8UaPa/vMv8xXZpX3JxMkMOB8iPVvLDfB4LLgu8NIxojYYC+HpRUd7VDZMn256EgRKxzPd5XiMqxX1iRBPmdaWVz8B1ixRZtmJ4hBPHYGKVufAxyQdYBWKTN+tEnZ35sLIrOkJrMbO2GryumSpihlDYQORD7KGtdaJyckrFN2bbYUM9yFS4UR9/zDTpH6B41BjJh6uOVseOmQvd+dT+uLyVe6Vy7glfxUYHkrhNXq8VFqsCTCUNTh65KtTE+/L2kPm6OXZDgYjqgwWOGSPyb25JgmEasZldDlUYbHtZJ/3R8iILkEsfp/Qt9sWsd24zDV17+sXH4vDOdDKwCX77UGLAs5uy3L/2cP2xh+LsxCsj9AjK48Xl5+n4NYPWymuYWSbyR1c3boWYGEaVBhRbJWHbGro9f5fMTCcc6E2g4efk3CURHQgXu5ytfg7jicP1Vjq73z14i/2ewIhHq3Fzid5uAAVNsoVH7HBb3dIksrlkOov+A5jaQrBP7xYwpI02IsneTVvYMyCFdTMHFPQTEP1iTcbp5/PPjXgcB5N6aep9Vl6lH1Bl884FVuKazd/L/a/0Bb8vKgxHqGsM24qKitTQgFOYAwqEcdujjOoyOcJnPltL6k8/Y9lCFZcsFtGtrX8PIW4gFtjp5cdP2lg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(41300700001)(2906002)(8676002)(8936002)(6636002)(66556008)(66476007)(316002)(4326008)(44832011)(66946007)(36756003)(31696002)(86362001)(478600001)(6512007)(2616005)(53546011)(83380400001)(6506007)(26005)(966005)(6486002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjU4QUpjSUl0VXc4RmQ2VU83c3pnK0s1STNzNXZDV29qMFdFVmJMY0JyTEt1?=
 =?utf-8?B?UUJMeUVSN3NWTWxJSkE5OGV2cit0c3g3RXdQMmRZeXFpcjkrMmZRMTlCUDNs?=
 =?utf-8?B?S2ZWOHFpYmZsVmtOZDZWeWc4SzVDWVBYV20xblN2a0dBYnJTZDNnOVFaQXRv?=
 =?utf-8?B?N0IzejZsdk4ya1hmVUd2dkg1cllVak1BT1ZSdzFnN0FKTURuWHpnYm5lTFFt?=
 =?utf-8?B?NE1sc1MyeU9WU1lIVDBBN1dHaVZpWEwyclNodzJnbFJhdytSWWVPUUFIVXhM?=
 =?utf-8?B?cVhEbzRYYlhHS3lQNTAwZU9HZzRVbTlFMDlNMzNyQUhFeExXKzBoY0crNUJ3?=
 =?utf-8?B?cElMSUZTM1NueGpoZm10VW1xaU13MXNLR0dtMjN5YzZITXQ0STMzdlR6TFZG?=
 =?utf-8?B?eFpWaTM1cnpoalpyejE5UytqSGtvdGRBS3Nia0VhcmhyUWxpcDBGZGFKdFNv?=
 =?utf-8?B?VDJvbTJ1aUVza29SNys2S1pReXp6R1kxVnRLM0pOemQ3RjJGcWZjVkxXeExj?=
 =?utf-8?B?cHM0R1Z5NSswMUhjL1lQckg4bzV2RmZBcTlFb3dETUYvejN1RFNGakRyU3dM?=
 =?utf-8?B?ZyttNnN6OE53dWRxSjJCT3k1dVJLeXhSbzVZSm9xWnV0Tkg4allQTkRjZlhW?=
 =?utf-8?B?T3ZoZnpLU25xTTlvcGRhT3lCcW9GNVU1OVV3OCtVZy9JLzhkd1JvcVhydkF3?=
 =?utf-8?B?TUVvWkpqbUdWZTQrUFFqSUJGU3hsQTNEWnBsRG5BRklmU052Q0Q3TFFQbEo1?=
 =?utf-8?B?SDFldDF1d3Y4enZEd3VpSW9ldkdFSkNTcE1pd0tKelNDeE1BUHNoK3RiZ3M0?=
 =?utf-8?B?U0ZiTGtjRWhoUG1mTmRjTmlkanNKVDZjWGJyL3VUTWlFR0pDeFJ1bE5KcHJ5?=
 =?utf-8?B?US9Bd0RBMlpOSUFDUmRacFhXSm0xN2d1d3JiYWNJbktHemZKWG83a0JCbm9G?=
 =?utf-8?B?OUZnUFFjbnBNdzlFUkd6VXhrK0lJdWRrSS9BTSt4Y1VnMnAvb1R6NDdqV3I1?=
 =?utf-8?B?L3dRek9pUitwbFo0RFNXa0toREF0YUVOMHhKcVBzVGNVclhiQ3drNG10bjht?=
 =?utf-8?B?ang5aWd4RDJKSDl5dUJlN1VMeGcyNFNzbW5QT0NkUGhiczZjeHNpQklFalpq?=
 =?utf-8?B?L1N6d3F4ZGkzZjFpS3BBdU9MT0NWNUNidWZieGpBWnVSS1JuUjNqVmpIc1dZ?=
 =?utf-8?B?WlZXWnJSUGpyZUxKVEpFTTdVYXFOOEFOdjNyK0lhQUNReVlONXNpTGY4Rlc0?=
 =?utf-8?B?SUhsWGo2ME01bFhKaHpJdEJBVVVMZUN6WnN3SE1MS29FV0cvWHdEMWpjalli?=
 =?utf-8?B?OFIzWFA1aUlpQ2NGOE5kV0s2THZuVjN1Rnhnc1R0TGJUYjJ5blBUYVRWQSt2?=
 =?utf-8?B?UHpvY051UWJ4aFVKdXdxaEd2NlNNbDV4RWpVdktCU1hYb1FEbnA3MmJ2UUZF?=
 =?utf-8?B?cmxVVFRJSGJMSkRqb1FMUGlFdXN4M0lGY0tmMVVTSnh4ZkJXbTBYdEsrUjF1?=
 =?utf-8?B?THBRZEwxbER3YU1iVm0zZktyVUhSWU5yWisvQncxekhoakhpcS9Ob1pjMnN5?=
 =?utf-8?B?ZVUyRUZ1OTlvZy80M0Q3K1QvdWllWnNrejNMWjlSVzVKamhzdG55dUQveVpO?=
 =?utf-8?B?V1hIZVVwRnpaRHNUdmFxUmo3elJEMEdsajdsMXhnMHRwSGlQa1FETHdyQ1Q1?=
 =?utf-8?B?OFVhK3M0b09hQTQza2ZEZWRNRHZPUzRJWjBEOGZlRFhmdTdGa2tBSEZUeGZC?=
 =?utf-8?B?ck5tcmhxTnFRVzNWcmUyM2tBL1hjcmFTMTc0cC9Od05SVEVlVkZiMWNqRFpB?=
 =?utf-8?B?cnZFVFJ4M0RJWHlTMVVCeHdab09qdURscjlTWnVRU1BzL2RLaVBKdWxUblpC?=
 =?utf-8?B?U3d6VGNRUzFLT3dqZnJJVzViK2NobUs0TDlkbFZUalBKUGpSR3V0dTdZOVk5?=
 =?utf-8?B?SWhBUytlY3c3Q05RNFJwYXRUdmNQcHh6MFp5eHZsanpJZWl4YWNtNklUM1Rr?=
 =?utf-8?B?dlAzdzl3VkZiU3FyRk9QL0h1MTN1WnVESmF2QTdueHZOR0NLVTlkdk8xdFpU?=
 =?utf-8?B?elVKd0JXTWZaa0J6Wm9zS1NWcGNnUm9zL2dPT3ZrSEd5cGk3TGRwR2ZxajQw?=
 =?utf-8?Q?OlLIjaymKEXJl97oh0dYaYG6p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7b734e-bca4-4811-2f1d-08dc2667f3f6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 16:31:49.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFpKz1OvnsDtcgfd4cfg9PEPE13lm72STdyiCIcV7ZL5YaH1J4V59pjUk916sVbvn7qTSLC3K9sU5mextXRJbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559

On 1/22/2024 17:34, Mario Limonciello wrote:
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

Hi,

Friendly ping on reviewing this patch.

Thanks,

> ---
>   drivers/iommu/amd/init.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index c83bd0c2a1c9..40979b0f5250 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2068,6 +2068,9 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>   	/* Prevent binding other PCI device drivers to IOMMU devices */
>   	iommu->dev->match_driver = false;
>   
> +	/* ACPI _PRT won't have an IRQ for IOMMU */
> +	iommu->dev->irq_managed = 1;
> +
>   	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
>   			      &iommu->cap);
>   
> 
> base-commit: 75f74f85a42eb294b657f847c33e1bb7921dbec9


