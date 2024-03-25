Return-Path: <linux-kernel+bounces-117844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7388B055
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805461FA5C55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E2444361;
	Mon, 25 Mar 2024 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F9caHVCh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2127.outbound.protection.outlook.com [40.107.93.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56261BC58;
	Mon, 25 Mar 2024 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395780; cv=fail; b=UPCv6G7dXVhau9IxY470nqFMzOP7aS4R22DaDyAXepYDnkDbsz5Ta+FmQ6eXU1QtK2f8CrEOAiSilDhiic28KaAa+kmMwRotLvwEgp+cGD/2Me9Cd5TSaOiC2vcLhHBYllq9wzUOqA0fKEFQiy59wXp8Q8ShC4+kbQ5hw5ARHEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395780; c=relaxed/simple;
	bh=rJRiAzd8jMWk6atxSnx+S0YQiS/3wLj9H498qqskO8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qI9pgePXAPYs3IbxEtP/VuQqX3AaoRya8plLYVTZUt1yjnYrMt+UGW4Q8LJ1omp85eHD7yHVgPGczJ69e8bfxNezpcqJoLHP/2orCmLTFz6/O2Xk2kBwFp4X7GqbVJ7vtv5sKGcil3jikCuU9oDV9V+6qolPM98jOAMRcpAQorg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F9caHVCh; arc=fail smtp.client-ip=40.107.93.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j94XVSLASQqtctlQ94pMhmXBEQEzIfGn0B1gBN8KIXveDLcsodkygu9aGjI93SuYtq1nNK1M+HHZiiOdc/CRGOdbnBYcT/sURQjQDvXCecwLS1UbiVvrSRJOwP/TeO9IVsZirC1hpqGiK+USLqkJjOoMK7eNPrngRTLvhJT+WB01K/WlwCi+S6VAtq5Akb0bpsdLc1ikJxVZZv1UP3eQkeehM7NhD/+yIAS25X9Wnz6Nvhuu1P+h7NKqilimoLCZjZ8euAxXNuUB8YB96AxCfd+o6IiZUt9u9gGbfIZHdMdJQ8ML8vYxE1yOIocRtDkX6gQyiRmNah+IEYX34N+g0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3fUjfjwHnPjTKPFvXw071FF+Wn7nYjz/DTB2BAzM7w=;
 b=ASUmtfvauxCQmEmJhQls18Oa6XX2P/EojDaYT9zqMxvsXtH4/d7w9Te+iXYqj3WSvw8ws8TqKfpkz0pYjtuC//bNv6E/9NF8fcjHVOX2C4nmSKfMI0RkimwyLaOQlShnp3vz5QiwbibRwtT+bFbvlzKHygySMdjzoTHzHNlaNWgwRTpKQaxYKggIXVpE3BI7xb9fgZKdX2U377k9vzGpOqu+/MI3WgsxXktHHPRcet7X5oXnaENPtm0vr9XQnsK0LT/nL3w1nG3i/soGS+IcgX0SCDZNqiIPRULxPrzXp2crshB10JnN07W11mJ+1ZfUQfvETqfK+UTuWEkBpab7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3fUjfjwHnPjTKPFvXw071FF+Wn7nYjz/DTB2BAzM7w=;
 b=F9caHVChYcacfBjGzbNQenxmju6vZEQh23snyUKUmr9CV8VIdwXyk+qOyMjI6zfC9z48RudBC51JFKDvWMg9su3w3bvinc9gLP+UJ5LH7D+rL0KU4ZkkN9dy6/MLMBzHXPk7EwTAhF2glGJRfwulwsLBpTudonTAivGTfo+vvUo=
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 19:42:54 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::815d:4ebf:44b4:6edb]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::815d:4ebf:44b4:6edb%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 19:42:54 +0000
Message-ID: <7172ec2f-7cba-460b-a6c6-9fff45ba938b@amd.com>
Date: Mon, 25 Mar 2024 14:42:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] PCI/AER: Enable RCEC to report internal error for
 CXL root port
Content-Language: en-US
To: Li Ming <ming4.li@intel.com>, dan.j.williams@intel.com, rrichter@amd.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-4-ming4.li@intel.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240313083602.239201-4-ming4.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:5:120::29) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH8PR12MB6940:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DmTsCdq5O6FZYdJk4pDy59C7iAzwcBSlLSr1GupcEMb8i2pjzYurdl2EBgkK42OjtkCms6+RccA40NC3o6onOYlrSQDxzvoxFFcH5PyeblQLv8coaDYlbLQzH6tdX6f/tox4CqJN1edpNV5WF/iiZc5aeeeqW6AL32Swj/ytuZmaiFx/fzHG6K9y0GSWM84Dl3BWUi0yACosJQAwUTc6Fdib3MzMm8yO3THZ+0YY4+bFpon88G4Df7UtDRN6+wvE/qc3jZyskkGQ3H02NrK1r/XAOT6p7sTh7i8m/jufZ1oPaQjq69t2bniXqDoLHRpI+14QMPUaqYkunbMWagUEAkWNcY4H4Xild2c8wjd+np0e/SA6pNaI2pmAWIoAFCTJghgZSlVigvEypGrl32Rr3lA2L1HDdFTsPEFvOWEak7O3YOGJVT9RUVeRv7mvjLwCs0X26/cF2vCA9d9r5p+8X24POdTGkCk1ur21T4tt4tgRdftGcjkNwL+K8IwHr7ROlMnS0gPzE64n2CVjFIKfySaQlxY3qcynpA4A1Rk19rPJh217Yxb1dk8nxhRUPWijyU/+UHFNu3TsxvlPTA7M+7EHG0+bLsrXTI+IO8uNju+1xNNpTVxLiqzex2uyROcek1vABvWdt3dzbo+jkc6PRr/3XstN2cjz8I/08jwIDRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXRZcDRwNS9PbWxvR1hucDZOZGJ6dFJucGUxTHZzQWlNZ3ZYbmsrQTlVbDBT?=
 =?utf-8?B?MWo4Yzdmb05HSzVMM3ZkTWpnMjBXcXNmbk1ybXhOWlcySXZScVNJeXAxdTBP?=
 =?utf-8?B?NWpyMUNNRUdTOFQ3c1NhQjJkcGNpZjRuc2Q0Sm05VlphZGpRVXYrY2ZaZ0sz?=
 =?utf-8?B?QjByTEhZQnJBT21acGtUWWg4RjZCaFVuYURvRlMvU2JjS0xac3NSZHZ3Lzk4?=
 =?utf-8?B?bHhmRm1jWFpTSmV1VDVHcU5pQ2MvWnQ0Q292dm01bjNvZFhsUjFoS2ZsWVZp?=
 =?utf-8?B?Mk5Uc0poLzlxSXY2M1BuQ0FsYWJyemc5M0FXTWk0aTZJYVEzK3NaVzIySjl2?=
 =?utf-8?B?RitsdmNXbDNGUVFaLzlISHdmdTZyREhNWTNyaFdBelRiWVo4NjdKVnFMVDM1?=
 =?utf-8?B?M3F0SHdXenVYSCs5cXFPQzNaamZ2SnZOQXVDOFA5RTlxZDNSdHRLeXdyaUFW?=
 =?utf-8?B?cnp3NVgzc1JYd2V6Z3dyTkJ4SzRPbzlpSnJRaGZTRFYxOEcvNGFrTjk3WkYx?=
 =?utf-8?B?eVc0RTIyOExhcEcvSUpsQVBrd1IrendYSE94SmxRcFd6enE4Yy9lUWYzaW55?=
 =?utf-8?B?NmJiSDNxb2t6b004Z3NVMS9DTHA4bFJVKzdzbjM5cGFuVlFwbVV2b2ZyREow?=
 =?utf-8?B?Lys4Rng5TjI1Yy90aEJqa2I2dDlzVHhPSFhQZUw5b052MlBkYVdkZkNDcFNE?=
 =?utf-8?B?KzhZV2wwZmNuQU8ybjIvb2VqU1l2VHhBNzMxSzFzbGxJOWxSbG5aZUw0SS9J?=
 =?utf-8?B?TWhEaG9COGU1S0NKbGxJWDd4eklRcHdFMjVJdm9Na1dIWTJhbVJOUng1ekF4?=
 =?utf-8?B?SjdXY1dTeHFzMnhtUEZnOHBZTHNsS04yYXhsa2hmYVo0VGh1dkRtWXpzbTRt?=
 =?utf-8?B?L29DS1FaOTRpT3pVVUc2Ty8wTWZkNENZbGEwSUtEOW83ZGw3WE1kY0Foc3A3?=
 =?utf-8?B?b3pNRlRELzA0ZzgyRFM5Q3ovWTZtZkNJZzlEUHFVZFdocWkxV0piQTVzSjY5?=
 =?utf-8?B?SkRMSCtuRm5ZMWZZVXZ6c0czeTdPbmxnMWRQVnZVU3A3eXhSQU9ZQ0E4OWU3?=
 =?utf-8?B?NmNUTS9zNmYzRk5OS21FQzdpN3hTWUpmbENySjFrWW9hNkFEblFVOW9HRVRP?=
 =?utf-8?B?NFVyRFVKbkd4YXJOejc3NmNoR1MrdXhZVVh2TlZoQi82NW1oK1ppNHJwYjNF?=
 =?utf-8?B?Q3F2V1dxbVpENWt6MEVWREIyRk1NMkdpTUdCNzgxOGhDNFN2TWNPR3pGekZD?=
 =?utf-8?B?MnNmU1NrdDdwK1F6Rm5UVjZsT2dLVGpxeitlazFqcEc0TFNheHdVZTMxaDdm?=
 =?utf-8?B?dEdNcUQzQjYxYjNmdGt5ODAvRDl4OE85WGwxMmd1R3Mvc1IxVmRqaDlIdlhz?=
 =?utf-8?B?ZGhXcS96UUlGcFJQZytHbTFhL1c2NlZidXd0T2xsZnEwYmxUZEp2U2VxeHQy?=
 =?utf-8?B?eGw2RWUvNk9yOEZRN0pzZ2VhSktQQ2RqL1dhd1oraHFCSG91alNUVXFNYXRD?=
 =?utf-8?B?ZUN5Z04rZ0tXUzNaZkFXUncxMDFMNGRWUDNFR1VOWlRrZy95T1kxNktuQ083?=
 =?utf-8?B?K3V3Y2pFV1hWdG1ERi9menpTeEVoSnh2RW4yb3JheENKb3BFMmhxRk1VcFp5?=
 =?utf-8?B?eXpERnliVk1NUkJRUmpnVDdOUXNESzdVN1NPRHZzcjlxUkE4N1hyaHdTZlpY?=
 =?utf-8?B?NUNkM3kySEF3OERWUi9YdWF5T0JFQ1hCK3VGeURRM3VmUW05WGRZUHhOb2tO?=
 =?utf-8?B?QWRsM1dLK0I0ZDBOd3VMemw3V3kwb2hlY0ZUcXdWcWU4b1paVVE5ZTZDZWtJ?=
 =?utf-8?B?T21uVmp4cjhjQ1piUDFXNGRLUkhXTFFpS1J1UHVnSG41RVBMVWxGcEtQZ0pX?=
 =?utf-8?B?Q3pSakliTUlrRDdvNUVFUkdTVVBBbWJwa21rM05ueE84UlVEOGdKVG9LRDlK?=
 =?utf-8?B?YnJKV0g1THgvR3NJcTNFYmZBUGRFSEpYNWxQN1F3WDUxVXNTVlFlVENjMnBH?=
 =?utf-8?B?QWpFc1JBV1BueXNrNEZoS2dDVzloZElOZ1JpaWtYNzdIRmI5L0dRWk45SWNl?=
 =?utf-8?B?M29ncWdscFZ5YlJyTG8zWVZiTlNUZXRPcmY1ZG5JNFhsYWhLTStCb1B1eGkr?=
 =?utf-8?Q?Y3nqB+AA1BRMpLPJwlxKG6GXm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49efcda-52c4-4b43-51e4-08dc4d03c3bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 19:42:54.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcMzppD80kRZxYsjQBOKn27zLwhU+JmmcZp6/60AEFCxC1n9addzTs9ixHCWs6BzCiZLiDyQUMXiXNd/wPlLmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940

Hi Li, 

I added comments below.

On 3/13/24 03:35, Li Ming wrote:
> Per CXl r3.1 section 12.2.2, CXL.cachemem protocol erros detected by CXL
> root port could be logged in RCEC AER Extended Capability as
> PCI_ERR_UNC_INTN or PCI_ERR_COR_INTERNAL. Unmask these errors for that
> case.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 42a3bd35a3e1..364c74e47273 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -985,7 +985,7 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>  {
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  
> -	return (pcie_ports_native || host->native_aer);
> +	return (pcie_ports_native || host->native_aer) && host->is_cxl;
>  }
>  
>  static bool is_internal_error(struct aer_err_info *info)
> @@ -1041,8 +1041,13 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>  {
>  	bool *handles_cxl = data;
>  
> -	if (!*handles_cxl)
> -		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> +	if (!*handles_cxl && cxl_error_is_native(dev)) {
> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END &&
> +		    dev->rcec && is_cxl_mem_dev(dev))
> +			*handles_cxl = true;
> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +			*handles_cxl = true;
> +	}
I understand a root port can be found under an RCEC. It's possible. But, does the downstream 
root port forward AER to the upstream RCEC? My understanding is AER is handled and processed
at the first root port/RCEC upstream from the device/RCH/USP/DSP.
 
Regards,
Terry

>  
>  	/* Non-zero terminates iteration */
>  	return *handles_cxl;
> @@ -1054,13 +1059,18 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
>  
>  	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
>  	    pcie_aer_is_native(rcec))
> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> +		pcie_walk_rcec_all(rcec, handles_cxl_error_iter, &handles_cxl);
>  
>  	return handles_cxl;
>  }
>  
> -static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> +static void cxl_enable_rcec(struct pci_dev *rcec)
>  {
> +	/*
> +	 * Enable RCEC's internal error report for two cases:
> +	 * 1. RCiEP detected CXL.cachemem protocol errors
> +	 * 2. CXL root port detected CXL.cachemem protocol errors.
> +	 */
>  	if (!handles_cxl_errors(rcec))
>  		return;
>  
> @@ -1069,7 +1079,7 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>  }
>  
>  #else
> -static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
> +static inline void cxl_enable_rcec(struct pci_dev *dev) { }
>  static inline void cxl_rch_handle_error(struct pci_dev *dev,
>  					struct aer_err_info *info) { }
>  #endif
> @@ -1494,7 +1504,7 @@ static int aer_probe(struct pcie_device *dev)
>  		return status;
>  	}
>  
> -	cxl_rch_enable_rcec(port);
> +	cxl_enable_rcec(port);
>  	aer_enable_rootport(rpc);
>  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>  	return 0;

