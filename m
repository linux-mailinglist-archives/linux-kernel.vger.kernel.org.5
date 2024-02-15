Return-Path: <linux-kernel+bounces-66824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F13856238
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D57B26194
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A089312B141;
	Thu, 15 Feb 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PqgDoG9O"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D6113AF0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997440; cv=fail; b=HohIS5shCNxwRAlCRZBtZd1K3pa/GSLFC/hEYhRlJOisenLUxR/ADIo2GxLj/opnwfSxqMMHgJBWnqPv6KKI2u00Nse0f0P387RihzNkQi2AN0RYX7Wq6lyTunX3pX27cz/hGso7Hn9RnZpj56w4tsolI7RVpp5hfmyl80KBJhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997440; c=relaxed/simple;
	bh=VyrS1NVjb7H5ZYcY+a9i8IFHfMfVRWPbLKqnOB7gqHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XyF4d7GvPNGpWwbW+5fuEQrZE+cZ+5qRbiKO13ztqekylO7Kv9Gb/eTPMX54LvtDdOB7uaMUT97LvslRal4BCh/AhuodudIcwczGeO+Yh7SAu3SZrEiu0KuNwbI4Fd/KP9uhOxSFhSBLAIQFOvNHnZj7p+BGQNCPGyg2A11k83U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PqgDoG9O; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPjU9QhmxgAvssbMwirIxBmYIHMhxy4XFEnMTBDf13NAAIcv8qs5VT/oHBRVdk8djdl55xBCTRy6a6mH4kuB2o97IHR2w1t8MWvagIoRq+r7s5PwHhhGBKvmyJ/yAn7T/uJsUmqd1JnZFOxM7zSVR6O0t1Q7UAohaE+zYyEklx8y4EDYuMOTyzMpnl7EZXFbOIuNSL6AFAjLOoMkD6CHzR2JTFtA/qr9TLiEA1Zr59k5aSNdZk21LJLc5i487VzBL+EiXfEspa5xkI6ysSAeCTferK9ObD+PDOt8Rfk02KpihPVPAsSJ8vxeTZHfNIItgMdhkB50So3MhLxc141sjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lTzEubGCullO4glBrlYdC5tp9Mn6oBFJLoqoMNYkR8=;
 b=JVZQFlaP0aSARWxJ2FQyNS+qcRgSvTgitGWzMf4V/ggBjJOexVl3aC/+4N+d6ojC8T42x8AVjkIsIgmfePyxtWTJFLgysWaLlNfLtDi0KT+krnZB5IWT/zyC0jsqaboySQA1ZkvjMddP6fUk98wM8aPoSeTiezMtpScoA4fig+Gt7zlXZ4RWikTW5pHjXwc0D2t/01MMoKt3LlL9srEVsEN03aa4cUAzZutAoFwDXe6Uw8p+XB/oDL5FkLKe0QOTjc5ty5z9U+wa5B4GXmGEzERbf7/9MQHpkQId0NdXwa3E1OOssnt1afbnCxaWJIiK1rKOo7igwnTvjWrs0XR69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lTzEubGCullO4glBrlYdC5tp9Mn6oBFJLoqoMNYkR8=;
 b=PqgDoG9OMjxlD5vPsO24Rwmt2Ff0/nrl04vaysr5ryvgpR72k4uafy/Dj8scgO654eEGoeHyz1Re3gyBXZxJw64pgwHUTp0D+jQpYjQQFLVzX6yI3lY4B1WYApEVCaIucyxf+CErdn86sPkuNcWAyw69BcD3rDhl0DJGS19K128=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.12; Thu, 15 Feb 2024 11:43:54 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9c66:393e:556b:7420]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9c66:393e:556b:7420%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 11:43:54 +0000
Message-ID: <434e65bd-49ec-40f1-bd2b-68765ecbb86d@amd.com>
Date: Thu, 15 Feb 2024 17:13:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Dump SEV_STATUS
To: Borislav Petkov <bp@alien8.de>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20240213163311.32130-1-bp@alien8.de>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20240213163311.32130-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::16) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbdf4c9-04f3-4ea7-4d53-08dc2e1b62e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yR6TtFjr7Zdp/09Qpb4Hy4xMLHhun05t0OSa/aHSgpo0ik2JH7PJdONvF7+5NWOMz971cWoAkSHMCXnSttdrK6rGUCvnlujZ5RPVXIQIDHybEBi186qjmrUTS/0YO3838NboG8+ttRrppNevPo5x5XBO8Ly4CNeFPO0i1gdzm6gDqAQXjw0LRTSDI8bzr5fVWhjJ/RfcU7TVlcFlKyX+wXrrWVX5U9CsuLxjtBK32sbKNFIZmbeBKiDw3Sc/p/Keo/9BvDZYIIo3xnE6ZO1E5oiDFfCD/XafvNcICgiDRuhRPX7Wwz3HoMViqYiTqSc70DkhJ8RaJXpUbmhXIrCXDrZoI9SrUPR5YCHUL6gDZwgdINpGV6q1/izA39DarTvo3fKqDCn7djEk7pVLe8GDEvTMDVgpV56GeOdq9xH1lGhfG6vZTzLlj4q6HDurJAmzensSb2+CKvBm44RcgZ8KgcVSAwE0Wgg5p2w9TT+uiJGjfRxc+AkvkYqnVtmU1MMVO9RSSOhnX+i9YRHLugQlP5nItAAeQg2BNZrgV1RmCozXIHnJoe7VB3BKM9oNvJEW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(2906002)(8676002)(66556008)(8936002)(66476007)(66946007)(4326008)(31696002)(38100700002)(2616005)(41300700001)(26005)(83380400001)(6666004)(36756003)(110136005)(316002)(54906003)(53546011)(478600001)(6636002)(6512007)(6506007)(6486002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXlCa1V0NFg3Zi9zZGRtSlk5cGVsUGJDcmxYZDFQZHBiT29NcFY3RWVESis3?=
 =?utf-8?B?clVvWk05blgxcXV5VDNPUisrOE5zaGkxam04NUNmZHZjR3c0dXdBQ2tFTTNz?=
 =?utf-8?B?SUloNHMzWGVkakJDUUNNU0Rua1paTTQ1ZE5SWEpVcHBQODlOazhsaEFQWXJ4?=
 =?utf-8?B?WURyN2tKTHltaU13bzg3VDVCVzJWT1kvUU56MnIrcjFxc2F3bEtwVWZCRWRq?=
 =?utf-8?B?cTlaK2hYNVAxMW9KbUF0a0NKNkVQaTJ2UWk5RGgrRUJ1M0lzZG9IUmt3UDdl?=
 =?utf-8?B?N1hLTlowdWhQRk9Rc1ZnRmEzTVlITDR1ZG9EaVJtZ0xaNm9SV3h0QldNbWc1?=
 =?utf-8?B?RURVZ2w4SElPM1VVYzFVaVBVYlAyc0FjQi83bGh4SUxWY3pzandFQUh4WHA1?=
 =?utf-8?B?SVE3di9vR0FabDJyT21NcWg4SWZ4UStMdTZ3b05TMmZVTlViNTliTzFwcEVu?=
 =?utf-8?B?UXdEN2dNK2M3NHlxd2F4Z1Z3Ni9tSFZSNnoxRDg2aGsxOUVLUDNSN3FqdjZL?=
 =?utf-8?B?Z3h5Q0xySEljNXkzRGtZU3h4VE54MHZJQUlZUzF4TDk3ZHY1OHZtU3N2czA3?=
 =?utf-8?B?WWlXVVBiT1ZQTEt1ZW0zdnIzaDRTUi9KL2xWcWRmVng4dWFKa0psaEtiZDFQ?=
 =?utf-8?B?a3FFd1VMcGhhVERsMnEvd0hjVngrbDA3dUhtdG5LaTdIT0FxNEZMSEZyc0p3?=
 =?utf-8?B?S1FpdU91WkVCaUxlRVowNmR5c3JEejZxcSt4bW1XN21nY1U5NkJzM0VWVXNo?=
 =?utf-8?B?bldYcUpzRnN2LzlvNG1aVjVLbTI2SWJGSzd0dTBkNFZRTDJONjJ1cjZIbHds?=
 =?utf-8?B?SVhtUU1sSWpneWhHeWYxc1JBTTd6OXluVHhwNFhjakVaWEhnY2tnTUc3Ulpp?=
 =?utf-8?B?V09rQldEZHNHQUpNSFc3YnJzTG1Rak1xWHdMbHBpUnJ0QnBJSHJkOHV0OU9z?=
 =?utf-8?B?RDNXaFFMdlpiWDlkdW05WmlTd0Z4Yk9ZaDZjTnA5NGFwaE9QWjBrbk5nY1NR?=
 =?utf-8?B?TWx1THYrZTduTlR5YU54Qk15QmttVEJvV2VONFRDVmRsZHVqbkF1eHNBTTRF?=
 =?utf-8?B?RXU2QS8zTERlU0dDd1BjUWs2K3lKZHNzQ01pbExobXZWYjJwbUxGdEtJdjI2?=
 =?utf-8?B?enZhblpwTEVOZjVsSEo0L1BVREFiTzhvaUpUOUFjYU9HS1duMUN2K091RExy?=
 =?utf-8?B?azlrU1dqZUNIUFZHY0FNV3lzdmIraENDRXdiajZLbVptaWk3aHlxWW8xNG1P?=
 =?utf-8?B?MG1ZN0NyWUsrZDVGa1JkR3ZicUpkLzdwaFRyeUZIY3o0cGRCQnZ6SnQ0cy9V?=
 =?utf-8?B?eW5BMnc4UXZXR05nYnREY20wTU9XMjhJMHpLaDJkMzdtM1NwWll1K3lMTmNJ?=
 =?utf-8?B?ZVFGUWllandJTFJMWUExYlZWc1pLNGsycjBGK1FaSUlsMERQem5xTEFjZitz?=
 =?utf-8?B?RkZaM1phWWMybmk5UXR6Wm5NT0h3b1dTRXNCUnpFWFBaTFJxOUtQSzhqcVNt?=
 =?utf-8?B?K0VhUEt0dWIveWJKdW1ualk1dW5tRDlGc1pKTWNOQWRuUkVzZjZvL2UxVDFS?=
 =?utf-8?B?QjlmaC90Q2wwckk3NVlxaHNtdXdJSGZtQmJ5V041Sms1dXFIaHk0NzFVUEh3?=
 =?utf-8?B?UFMrNGVQS1Y3L0hCQWY2NkV3UW1vQThiVi92ZlZ3ZTlZOENObktkZHg4bVlk?=
 =?utf-8?B?YVltRzRnT3JvYy84SWwzT1dvRHY3S2pxQ0pGNG1nQWpwY2JyTWpyclRvdTZB?=
 =?utf-8?B?SnhiZkJuN282K0lXdDBDSlR3bHhvSHVtZmpSSHdCODV4d0ZWTitYRnZVMmFt?=
 =?utf-8?B?ODBPMUV1OTVNMEswVll1QkZFQXdJN3IwYlcrdUNwSkpIQjNXMjFraHpwQ1g5?=
 =?utf-8?B?UVhZYmRFcW1ZMEpvV3R6WDhsK3pVT29LbGVEbzN5dEZ5Z3dwcng3b1B1K3RU?=
 =?utf-8?B?RURnb0VERWFqRWVFZzhrYWtsNGR2elZKZ1pCTHlVMzFqRXRES0Z4ZlY1OE01?=
 =?utf-8?B?Y0h3amcvRnBsL1lPVW5ER1EvTUF5YW9zM1lZZWhYd0U3WGZBVmNQQWVZcmhO?=
 =?utf-8?B?bFJRSjJqMjg4YUc1SHRpZVlOWEFDM25mazh1WHVoNlBWWHplUnlYNWtkV2hX?=
 =?utf-8?Q?buYGwc92KjjlwyjW1HQ8HD0iK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbdf4c9-04f3-4ea7-4d53-08dc2e1b62e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:43:54.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhJ9w9aeR2e4G12JdOTOr+VF5cVCRHUesWm3I5qCxbohPPOcq3zLtAImaeE/nPYQPsJizS05Hik4lrTnSDJIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378

On 2/13/2024 10:03 PM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> It is, and will be even more useful in the future, to dump the SEV
> features enabled according to SEV_STATUS. Do so:
> 
>   [    0.542753] Memory Encryption Features active: AMD SEV SEV-ES SEV-SNP
>   [    0.544425] SEV: Status: SEV SEV-ES SEV-SNP DebugSwap
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Definitely very useful:

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
>  arch/x86/boot/compressed/sev.c   |  2 +-
>  arch/x86/include/asm/msr-index.h | 59 +++++++++++++++++++-------------
>  arch/x86/include/asm/sev.h       |  2 ++
>  arch/x86/kernel/sev.c            | 35 +++++++++++++++++++
>  arch/x86/mm/mem_encrypt.c        |  5 +++
>  5 files changed, 78 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index fffdba4ae806..97561eabfbef 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -370,7 +370,7 @@ static void enforce_vmpl0(void)
>  				 MSR_AMD64_SNP_VMPL_SSS |		\
>  				 MSR_AMD64_SNP_SECURE_TSC |		\
>  				 MSR_AMD64_SNP_VMGEXIT_PARAM |		\
> -				 MSR_AMD64_SNP_VMSA_REG_PROTECTION |	\
> +				 MSR_AMD64_SNP_VMSA_REG_PROT |		\
>  				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
>  				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
>  				 MSR_AMD64_SNP_RESERVED_MASK)
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 237c50cc1c72..24c575cdd6b9 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -605,36 +605,47 @@
>  #define MSR_AMD64_SEV_ES_GHCB		0xc0010130
>  #define MSR_AMD64_SEV			0xc0010131
>  #define MSR_AMD64_SEV_ENABLED_BIT	0
> -#define MSR_AMD64_SEV_ES_ENABLED_BIT	1
> -#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
>  #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
> +#define MSR_AMD64_SEV_ES_ENABLED_BIT	1
>  #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
> +#define MSR_AMD64_SEV_SNP_ENABLED_BIT	2
>  #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
> -#define MSR_AMD64_RMP_BASE		0xc0010132
> -#define MSR_AMD64_RMP_END		0xc0010133
> -
> -/* SNP feature bits enabled by the hypervisor */
> -#define MSR_AMD64_SNP_VTOM			BIT_ULL(3)
> -#define MSR_AMD64_SNP_REFLECT_VC		BIT_ULL(4)
> -#define MSR_AMD64_SNP_RESTRICTED_INJ		BIT_ULL(5)
> -#define MSR_AMD64_SNP_ALT_INJ			BIT_ULL(6)
> -#define MSR_AMD64_SNP_DEBUG_SWAP		BIT_ULL(7)
> -#define MSR_AMD64_SNP_PREVENT_HOST_IBS		BIT_ULL(8)
> -#define MSR_AMD64_SNP_BTB_ISOLATION		BIT_ULL(9)
> -#define MSR_AMD64_SNP_VMPL_SSS			BIT_ULL(10)
> -#define MSR_AMD64_SNP_SECURE_TSC		BIT_ULL(11)
> -#define MSR_AMD64_SNP_VMGEXIT_PARAM		BIT_ULL(12)
> -#define MSR_AMD64_SNP_IBS_VIRT			BIT_ULL(14)
> -#define MSR_AMD64_SNP_VMSA_REG_PROTECTION	BIT_ULL(16)
> -#define MSR_AMD64_SNP_SMT_PROTECTION		BIT_ULL(17)
> -
> -/* SNP feature bits reserved for future use. */
> -#define MSR_AMD64_SNP_RESERVED_BIT13		BIT_ULL(13)
> -#define MSR_AMD64_SNP_RESERVED_BIT15		BIT_ULL(15)
> -#define MSR_AMD64_SNP_RESERVED_MASK		GENMASK_ULL(63, 18)
> +#define MSR_AMD64_SNP_VTOM_BIT		3
> +#define MSR_AMD64_SNP_VTOM		BIT_ULL(MSR_AMD64_SNP_VTOM_BIT)
> +#define MSR_AMD64_SNP_REFLECT_VC_BIT	4
> +#define MSR_AMD64_SNP_REFLECT_VC	BIT_ULL(MSR_AMD64_SNP_REFLECT_VC_BIT)
> +#define MSR_AMD64_SNP_RESTRICTED_INJ_BIT 5
> +#define MSR_AMD64_SNP_RESTRICTED_INJ	BIT_ULL(MSR_AMD64_SNP_RESTRICTED_INJ_BIT)
> +#define MSR_AMD64_SNP_ALT_INJ_BIT	6
> +#define MSR_AMD64_SNP_ALT_INJ		BIT_ULL(MSR_AMD64_SNP_ALT_INJ_BIT)
> +#define MSR_AMD64_SNP_DEBUG_SWAP_BIT	7
> +#define MSR_AMD64_SNP_DEBUG_SWAP	BIT_ULL(MSR_AMD64_SNP_DEBUG_SWAP_BIT)
> +#define MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT 8
> +#define MSR_AMD64_SNP_PREVENT_HOST_IBS	BIT_ULL(MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT)
> +#define MSR_AMD64_SNP_BTB_ISOLATION_BIT	9
> +#define MSR_AMD64_SNP_BTB_ISOLATION	BIT_ULL(MSR_AMD64_SNP_BTB_ISOLATION_BIT)
> +#define MSR_AMD64_SNP_VMPL_SSS_BIT	10
> +#define MSR_AMD64_SNP_VMPL_SSS		BIT_ULL(MSR_AMD64_SNP_VMPL_SSS_BIT)
> +#define MSR_AMD64_SNP_SECURE_TSC_BIT	11
> +#define MSR_AMD64_SNP_SECURE_TSC	BIT_ULL(MSR_AMD64_SNP_SECURE_TSC_BIT)
> +#define MSR_AMD64_SNP_VMGEXIT_PARAM_BIT	12
> +#define MSR_AMD64_SNP_VMGEXIT_PARAM	BIT_ULL(MSR_AMD64_SNP_VMGEXIT_PARAM_BIT)
> +#define MSR_AMD64_SNP_RESERVED_BIT13	BIT_ULL(13)
> +#define MSR_AMD64_SNP_IBS_VIRT_BIT	14
> +#define MSR_AMD64_SNP_IBS_VIRT		BIT_ULL(MSR_AMD64_SNP_IBS_VIRT_BIT)
> +#define MSR_AMD64_SNP_RESERVED_BIT15	BIT_ULL(15)
> +#define MSR_AMD64_SNP_VMSA_REG_PROT_BIT	16
> +#define MSR_AMD64_SNP_VMSA_REG_PROT	BIT_ULL(MSR_AMD64_SNP_VMSA_REG_PROT_BIT)
> +#define MSR_AMD64_SNP_SMT_PROT_BIT	17
> +#define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
> +#define MSR_AMD64_SNP_RESV_BIT		18
> +#define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
>  
>  #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
>  
> +#define MSR_AMD64_RMP_BASE		0xc0010132
> +#define MSR_AMD64_RMP_END		0xc0010133
> +
>  /* AMD Collaborative Processor Performance Control MSRs */
>  #define MSR_AMD_CPPC_CAP1		0xc00102b0
>  #define MSR_AMD_CPPC_ENABLE		0xc00102b1
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index d7b27cb34c2b..10f9f1b259c3 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -229,6 +229,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>  u64 snp_get_unsupported_features(u64 status);
>  u64 sev_get_status(void);
>  void kdump_sev_callback(void);
> +void sev_show_status(void);
>  #else
>  static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>  static inline void sev_es_ist_exit(void) { }
> @@ -258,6 +259,7 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>  static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
>  static inline u64 sev_get_status(void) { return 0; }
>  static inline void kdump_sev_callback(void) { }
> +static inline void sev_show_status(void) { }
>  #endif
>  
>  #ifdef CONFIG_KVM_AMD_SEV
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 1ef7ae806a01..081d1391bc18 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -59,6 +59,25 @@
>  #define AP_INIT_CR0_DEFAULT		0x60000010
>  #define AP_INIT_MXCSR_DEFAULT		0x1f80
>  
> +static const char * const sev_status_feat_names[] = {
> +	[MSR_AMD64_SEV_ENABLED_BIT]		= "SEV",
> +	[MSR_AMD64_SEV_ES_ENABLED_BIT]		= "SEV-ES",
> +	[MSR_AMD64_SEV_SNP_ENABLED_BIT]		= "SEV-SNP",
> +	[MSR_AMD64_SNP_VTOM_BIT]		= "vTom",
> +	[MSR_AMD64_SNP_REFLECT_VC_BIT]		= "Reflect VC",
> +	[MSR_AMD64_SNP_RESTRICTED_INJ_BIT]	= "RI",
> +	[MSR_AMD64_SNP_ALT_INJ_BIT]		= "AI",
> +	[MSR_AMD64_SNP_DEBUG_SWAP_BIT]		= "DebugSwap",
> +	[MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT]	= "No HostIBS",
> +	[MSR_AMD64_SNP_BTB_ISOLATION_BIT]	= "BTB Isol",
> +	[MSR_AMD64_SNP_VMPL_SSS_BIT]		= "VmplSSS",
> +	[MSR_AMD64_SNP_SECURE_TSC_BIT]		= "Secure TSC",
> +	[MSR_AMD64_SNP_VMGEXIT_PARAM_BIT]	= "VMGExit param",
> +	[MSR_AMD64_SNP_IBS_VIRT_BIT]		= "IBS Virt",
> +	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	= "VMSA reg prot",
> +	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMT prot",
> +};
> +
>  /* For early boot hypervisor communication in SEV-ES enabled guests */
>  static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>  
> @@ -2275,3 +2294,19 @@ void kdump_sev_callback(void)
>  	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP))
>  		wbinvd();
>  }
> +
> +void sev_show_status(void)
> +{
> +	int i;
> +
> +	pr_info("Status: ");
> +	for (i = 0; i < MSR_AMD64_SNP_RESV_BIT; i++) {
> +		if (sev_status & BIT_ULL(i)) {
> +			if (!sev_status_feat_names[i])
> +				continue;
> +
> +			pr_cont("%s ", sev_status_feat_names[i]);
> +		}
> +	}
> +	pr_cont("\n");
> +}
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index d035bce3a2b0..6f3b3e028718 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -14,6 +14,8 @@
>  #include <linux/mem_encrypt.h>
>  #include <linux/virtio_anchor.h>
>  
> +#include <asm/sev.h>
> +
>  /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>  bool force_dma_unencrypted(struct device *dev)
>  {
> @@ -74,6 +76,9 @@ static void print_mem_encrypt_feature_info(void)
>  			pr_cont(" SEV-SNP");
>  
>  		pr_cont("\n");
> +
> +		sev_show_status();
> +
>  		break;
>  	default:
>  		pr_cont("Unknown\n");


