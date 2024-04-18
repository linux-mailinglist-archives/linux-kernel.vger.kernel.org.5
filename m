Return-Path: <linux-kernel+bounces-150619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36648AA1E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E131C212A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50657179943;
	Thu, 18 Apr 2024 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TqE71ZqU"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C994433BF;
	Thu, 18 Apr 2024 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464174; cv=fail; b=chqeLBQ1iU1cyLbj2u5Suhv3yqcHGwn9Ei5FSy9mR3/L+cmXv5c2MmJSu1lWYHE9ZHkLENZuf8rlOJPShclfBq8qoxLeaMCDS6T83pbmi+4QqYZFHCjemanDenOoC8z0/rPBT6dHPVjSwvIWoJVdcwahb5HbZk/yzXiRfnMvwyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464174; c=relaxed/simple;
	bh=YldUuLnxA0b/kPZQSqhj0gyzLP9biZjWVXPISLvlGj8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hWMKTYwTNfRruOJSZuGHVvrGy4WwQzGBbItRKOKZKcUdTJiYCNNcnMINDWAOigh8apCu2a51qxM9XC/yQ3n3KbH1lGvnNrLFpHz53dgBalFXsbfVqX13HsaPuYOlOlzMS8wEujfHZsSh3CAP9JH3WT08orFGgH68t/HoqWMg6+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TqE71ZqU; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj4nDx7RGBLyFHriy2Rz55Di1KbNcFH4BNpg8kxZDJCQ45DbOX6+rsiDvI1UufhtOO33pHV+OpdvQMLZiVwTArDrobDmx5CwIDtKG1yDbd60CGTfLO1je6myp5gJmQJw9ZU4f0Pm9qK9hbuCmDCWsVkEgM2gOziYbmcJyVNBnwV31nqcfWNworAumx1m9+H54LY01DTaMDmnDR3K3epvVzsGeIOpgDXwVr6G5hokVEJ3sanrwrTB++biTu/rfKDVG3NSjKECz1leoC5ioUGXOE7usrf7W1qfI/ehSw0ZtIJFmxc+7GbefjaR6EKVkc9rY47+Zdm9h8EIBo8WW3gamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlUF8RC/YeGqD0VOtX6jP9ZFFcgT5zRe9+rBuSCTFVs=;
 b=PamSWC6lj1mzEcY/jcxAP+OYzDx6L0tREjQITbptIVgBvTF7lFTRdd1PrSpVflDV+fTb2PzcC00Pjpstf+t/+uz/xMNi3nLCVMsbv7y1AOHlqbYakqcKVFjrXFHj7lPQyVG6Nhf5VneX6dAFEThbJeCno9q27/HwfI+VPj6rmK05udGOrzPCK/w0TxvNppobYYrj4wlcBZV0I2aIYHSk6J86AruVVW4w5M99XnKIFVTpyyoHKLag8daPwzYcEIHE45p7Z17VAWq5vVhk2y1AYSGaH2Xj4iEsiyCHP2i0xN615IUs5ALsMUVPe679djlqWwxQbnm4woslyefuNLuaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlUF8RC/YeGqD0VOtX6jP9ZFFcgT5zRe9+rBuSCTFVs=;
 b=TqE71ZqU8ihWGHXb94n/QCTjH5D5MgzxHL32sBoLlK5aqOuvC3T0aBXgVK2LT58uZJ6oR2MUMSMABYq/sQNM8N49l+24pS0Nas/ZPM8eoxHk+MvdkwGZAcGdxUXj1mZ6/iE1P+b3H013me2cw0IYWISOy8OTwfh84FNqSt6QN2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Thu, 18 Apr
 2024 18:16:09 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 18:16:09 +0000
Message-ID: <354cce06-b1b9-4523-9b71-d0576eb3a01f@amd.com>
Date: Thu, 18 Apr 2024 14:16:06 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] x86/mce: Implement recovery for errors in TDX/SEAM
 non-root mode
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <20240408180944.44638-1-tony.luck@intel.com>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240408180944.44638-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0474.namprd03.prod.outlook.com
 (2603:10b6:408:139::29) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b138a4-42fa-4423-9f75-08dc5fd39efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/HV3TVwFkk737I/2oFagbhLeyyYbuWtmfCmK1ubFTO6I/meRuyNRxjnb+l0B1oqyT3OUyLZ8a8lIMeglqHDB6gkTdjxoj1NEAKogScSOyI5JBKV8TObzLvvlAsDu2aU3OlHekf7oXfSWXKTju4SRLrsurThaE28wESbueFQxbl+ybOwmnsGaxio4kdH8eXAq5T1j5KPAHlcE3j2A2G/ixwJyd/udtnb96rCVLVSQLsjawCVwjLbdOTjc9nVnZUox4lO52SL4NgY6aZZRPXe9egSSgYsJ9PJnxnCMMLoRKiosETrCQw7YoSXCnpeqNFhygpqcX0PanMY9z/sCZGpPPb72Q7DyMka5ntzWSlvdicKsgHD4PyBtYhtFO/wJehrvYEFn4h4UlXlY2qvAqoJoKuPsA+QaBqDxbr9y98e/wO5lTaDVGXJby/W/7duMCBrdv6mT7zeNXrtF75YMjbjU54JI9nK8dnSYlPmBC2y7dsVm86Z71pt/h/KfVYHljaJyJ7kaBv9NfXw8SxuS05cMOCk1EJWcUKBPFC4kUNZbB5JTuy3E9SDpGBJf0SfNaEYiLpm5Di1I1ZSCfg1t1E8AY1W+8Ie/oIAmVbxANC+PxPQMarS5kByY8sUVO9+j5sIS9IgkOuwCBSYfXKNoGFjVjTB/jI/gjJDNNoiheZDvGFs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHlrQ01PY0NsYi9pNEwwNmkrb0YxS1RQdGd6d3ZOZm5DTEJUSVZtcnJaUDMx?=
 =?utf-8?B?Rm1xd0l3dG43WUZLUFhsek9LRlBtMFkwRTg5Nkp2ZFc0cEwxTEtQbHR0T3dV?=
 =?utf-8?B?akZ0SGRxcngwWENxNWtSV1c5TUVGb1RDQ0V5MzdUUUZPYU9OSXJjbjhLeDN4?=
 =?utf-8?B?SW9OSW50b0J0cGN6TlVrMVVFcDZkTTh1WmdERjZMK3BUTFBCR3orYXNLTWh2?=
 =?utf-8?B?blQzMTNWQWRNT0FiQVFjV2hQZFBrOElZR1dMcWw3SnAwaWNjTUhaYlJTM3Ni?=
 =?utf-8?B?SFoySFdGY1lCd3FxUDFmaGh5NUFTUDdzRWxsc0RPT281dU0waklpc05hVEJV?=
 =?utf-8?B?eHdoajlwVEZTdXRkWnFwcGtTb2t2TXJKdXJSMzJMSmM0b3RwZVVuQlFkeWhF?=
 =?utf-8?B?MEpYcUlTYU1kNy9VdXRjM0c0ZTJibDBxYnhqSFo0UEptM21DR3Nha29WeHl6?=
 =?utf-8?B?bC9qY2p6YlpLTVA5andtU0ROb2J1WXhIWnNZemJPbERnUWx5MGtYcXdVSDhq?=
 =?utf-8?B?d1VXRkFFOWJrczZMeFhTS096dWU3cHdpVTdHNU02czNSR2V6TjB6VmJ4Rmho?=
 =?utf-8?B?VDZyWktMb3dJdTd1Z2VSdU1tVUVUY1V1Z1lDT3FWWTJmai9MazhqNEZ1d2I3?=
 =?utf-8?B?eGxjcVc5YzYzbnFaRE1xUEJyV1QwVm9RclpJYnVmMHNCdVh4Q0swTEJFVGk1?=
 =?utf-8?B?ZmN4QVRGL3JCZGlrMldheUY5SXV0c3hzeC9vd1lESnIxbG41Zk94MFY1Nits?=
 =?utf-8?B?dWQ2Rmp3ZFhJMkN0QTVPQ244MEh2Qk9CYlhtK0FNVFFxNkl6VDRMOFNYMTdI?=
 =?utf-8?B?YTRjZ29jYVZwS1ZVQkpqMTFOUFFqcXJJdmp6VnM3UWJ6T3RmNjhJMnpud0xj?=
 =?utf-8?B?TkxvR05OQTRqZThYK0JhOUgwSFZadGFrM3kxaXhpcWhMeUdNNW4xYmg2Q2F0?=
 =?utf-8?B?R3UwM3lmbXZpTnRDNkI2N0dBUFRZYllnR1QwUGpsRDN5cUw0Z3BhaW1iY0s0?=
 =?utf-8?B?WFliekNmc1pSK1RzRkRIWFZkS2ZESHBuTXZ0TmRjaVpyVTNYVERUSVZLMnlD?=
 =?utf-8?B?Vnk0MmEvYk05MUVNeVMzRCt6Yys5b1NSRTNMRlpFOVlWaFUvNElTVHlUN2RJ?=
 =?utf-8?B?UVE4dGJ2RXdZU25iSWdMdTE4TVNQVzBOQ0JjeHBSNFhYcVlpSFhHTnNtNmlU?=
 =?utf-8?B?dVRsbDhlb1ZEQU9hQmRVZEVQQmYveDJmQyt1MmhoRmhNNTFhOHpMbWhEdnhT?=
 =?utf-8?B?N3M0TEZqM01wempKWVh3MnVoa1ZNQm12b2Z6L0NGR2NzeGMvUXhaQjBEdmt6?=
 =?utf-8?B?enlwcFNPNjY5QWZObGFTdE9Iekszd0ZIZjVNZTIzZW1LeHg0V3FKdHBCVmti?=
 =?utf-8?B?RWpHa2IySDI0QitNeFpyeUxGeWpmS2JlTTZqTG9ZZ3lDd1R6QW13Rm1SRTkx?=
 =?utf-8?B?MTh1VlIvRDZuOUxEWS9HZ3BMeUxTcWJUazUxK0lsS2w4dk5QUU9jaDk5QmZF?=
 =?utf-8?B?aUZHOW5jMERYQzhsUjkyZnJNN0hjNVIxRjMrblpRTks1bXVPekZxdlo1ZUx1?=
 =?utf-8?B?WThyRzZXbFVFWGFxbmtZbzAyN3NIY0ZIV3RhOW4yZnQ2clBTMDRaM2N5RXJK?=
 =?utf-8?B?b3dCZGhwNVp1TTBkVCt2Zjc4M1pBc3RRTHlJbk1PNjdoNWw4ZFRJZ1lEUkZS?=
 =?utf-8?B?RkZGMWVpSnV6dTBvYm8zYkppdk1lSWFWemhrTFE4amZmRndEY2tGdTlhaFl1?=
 =?utf-8?B?eEFmei9rN2tldlg1Z1FudkxSRGQ4SGlVMTFhemNlR3EzM0RpWk1kYzNrem90?=
 =?utf-8?B?c3NuZ1FiVVRFTE4vSWNrMDd6Yk1nMFB1YkxwcDJhNUtzT1BqM0g1ZFpLMEo3?=
 =?utf-8?B?cjlUbnhoNmo5TksvWmZrdXI5QnllMGVFWGhud3dOeFlyZXZRWjhTUmNSeklH?=
 =?utf-8?B?emNXL09LOS9KSWxRRjRKZ2dDaWtCa0pXWkFtejBVa0pxTFIzajBmaERkZ1oy?=
 =?utf-8?B?ZzZ1dWZVVEVzOHkyL1M5NTU4V3I5WkZMQ1ZHVUJ4cnFWa3FSMUhacmlUa3hn?=
 =?utf-8?B?bHVPRElmdFhYN25JUEFpNG95TC82MWVEbXBUS25FMnhJZVNEeDdXVjRpdTBn?=
 =?utf-8?Q?YMneWzliW5/palnrcmHNUwHgt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b138a4-42fa-4423-9f75-08dc5fd39efd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 18:16:09.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NR8pKcnl0m02uPMGgcfbhLcO5QtYGEXZKXi2aX+pNpB1bQGw/T2FhiQx3Bz9VOla0AWbNc+4CaEepJF5VAsjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642

On 4/8/2024 2:09 PM, Tony Luck wrote:
> Machine check SMIs (MSMI) signaled during SEAM operation (typically
> inside TDX guests), on a system with Intel eMCA enabled, might eventually
> be reported to the kernel #MC handler with the saved RIP on the stack
> pointing to the instruction in kernel code after the SEAMCALL instruction
> that entered the SEAM operation. Linux currently says that is a fatal
> error and shuts down.
> 
> There is a new bit in IA32_MCG_STATUS that, when set to 1, indicates
> that the machine check didn't originally occur at that saved RIP, but
> during SEAM non-root operation.
> 
> Add new entries to the severity table to detect this for both data load
> and instruction fetch that set the severity to "AR" (action required).
> 
> Increase the width of the mcgmask/mcgres fields in "struct severity"
> from unsigned char to unsigned short since the new bit is in position 12.
> 
> Action required for these errors is just mark the page as poisoned and
> return from the machine check handler.
> 
> Backport note. Little value in backporting this patch to stable or LTS
> kernels as this is only relevant with support for TDX, which I assume
> won't be backported. But for anyone taking this to v6.1 or older, you
> also need commit a51cbd0d86d3 ("x86/mce: Use severity table to handle
> uncorrected errors in kernel")
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> The SEAM_NR bit in IA32_MCG_STATUS hasn't yet made it into the Intel
> Software Developers' Manual. But it is described in section 16.5.2
> of "Intel(R) Trust Domain Extensions (Intel(R) TDX) Module Base
> Architecture Specification" downloadable from:
> https://cdrdv2.intel.com/v1/dl/getContent/733575
> ---
>  arch/x86/include/asm/mce.h         |  2 ++
>  arch/x86/kernel/cpu/mce/core.c     | 18 ++++++++++++++++++
>  arch/x86/kernel/cpu/mce/severity.c | 16 ++++++++++++++--
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index de3118305838..dfd2e9699bd7 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -13,6 +13,7 @@
>  #define MCG_CTL_P		BIT_ULL(8)   /* MCG_CTL register available */
>  #define MCG_EXT_P		BIT_ULL(9)   /* Extended registers available */
>  #define MCG_CMCI_P		BIT_ULL(10)  /* CMCI supported */
> +#define MCG_SEAM_NR		BIT_ULL(12)  /* MCG_STATUS_SEAM_NR supported */
>  #define MCG_EXT_CNT_MASK	0xff0000     /* Number of Extended registers */
>  #define MCG_EXT_CNT_SHIFT	16
>  #define MCG_EXT_CNT(c)		(((c) & MCG_EXT_CNT_MASK) >> MCG_EXT_CNT_SHIFT)
> @@ -25,6 +26,7 @@
>  #define MCG_STATUS_EIPV		BIT_ULL(1)   /* ip points to correct instruction */
>  #define MCG_STATUS_MCIP		BIT_ULL(2)   /* machine check in progress */
>  #define MCG_STATUS_LMCES	BIT_ULL(3)   /* LMCE signaled */
> +#define MCG_STATUS_SEAM_NR	BIT_ULL(12)  /* Machine check inside SEAM non-root mode */
>  
>  /* MCG_EXT_CTL register defines */
>  #define MCG_EXT_CTL_LMCE_EN	BIT_ULL(0) /* Enable LMCE */
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 84d41be6d06b..771a9f183260 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1593,6 +1593,24 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  		else
>  			queue_task_work(&m, msg, kill_me_maybe);
>  
> +	} else if (m.mcgstatus & MCG_STATUS_SEAM_NR) {

MCG_CAP[12] (MCG_SEAM_NR) should be checked first, correct? This could be a
new mce_vendor_flags field set during MCA init.

> +		/*
> +		 * Saved RIP on stack makes it look like the machine check
> +		 * was taken in the kernel on the instruction following
> +		 * the entry to SEAM mode. But MCG_STATUS_SEAM_NR indicates
> +		 * that the machine check was taken inside SEAM non-root
> +		 * mode.  CPU core has already marked that guest as dead.
> +		 * It is OK for the kernel to resume execution at the
> +		 * apparent point of the machine check as the fault did
> +		 * not occur there. Mark the page as poisoned so it won't
> +		 * be added to free list when the guest is terminated.
> +		 */
> +		if (mce_usable_address(&m)) {
> +			struct page *p = pfn_to_online_page(m.addr >> PAGE_SHIFT);
> +
> +			if (p)
> +				SetPageHWPoison(p);
> +		}

I think this is okay, and it could even be more generalized as a "page
offline" action.

Here's some WIP for a generic MCE "action table":
https://github.com/AMDESE/linux/commit/cf0b8a97240ab

This is based on the short discussion here:
https://lore.kernel.org/linux-edac/ZD7gPkfWQeEeEfBe@agluck-desk3.sc.intel.com/

Basically, all the status bits would be checked in mce_severity() and the
appropriate action is set to be done later.

This would be future work, of course. What do you think?

Thanks,
Yazen

