Return-Path: <linux-kernel+bounces-143106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1788A3444
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243ADB2332E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791E014BF9B;
	Fri, 12 Apr 2024 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e7KNBZRX"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835714B065
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941442; cv=fail; b=RHg71Qp907m/lhIz4/H5m9i+BVX9AKcpVlf1utNZy5vsjfVk7I4zaSIy6ky6jzQn4xdu1Nxb0mTo7uT6h9tf++JM/AERE2DCDag9hjeY2sSEEC5OPqOL351nqa6p4Kvq60MoBEn8Zo89FH3+210D5knMX3IYjAsLk3qT8NFXsKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941442; c=relaxed/simple;
	bh=G2DlsiOPwfvgl+r15057uVkGixgr4vxV9CLU8vPOJOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B7VtjRKbC8PZlaMg8aDpxyD11WokGsoJJp4b8Tzf0aaUd+r3+4P61Fu33rGgXwyL3BzxWOwBu1pX8Co3VuLzW8SwyArJWGZmfm8CaFWhj946gx0D68jHSxKNVuQNEEd6CD6s9S2pyGJIojlWbGPDvEq+BYelwlEz5GZBEaNTrro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e7KNBZRX; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neMq4yzkaG08BqygiTyFJlJHE2usjXnwpuSV872wR2hJ1t0DZe2QO0tDuanQeNMBFSkgz7it/AWK0571u2m5y54Umi6cr2WiTpALtSBXzUECxsA2CYhN3ItUksByu2yGXUyAOiSFcXZqOsZBdMh8HAHTQiUOeottWyfy+okNdKlEsWkYmElVgEpuivfSmEmkw9wGH0Lj4gc7A7a24DmmPSnyIPrWUC3DXzK+70qY+D74ATwMFlWgdeSwMc/FLiD2O77m5rjahD2w1yE5+1daWtwxYOmoZn2YuJDDvW9UHx09oFg2rGpMGMTbKqeTyXAKluWsUJud6JlhRtms73dw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJFp22Z9NRJ+zh8RYxcRXpSV3bWV1RMB4YR4o+Dh8bc=;
 b=TQbobRXg/i3ZH/r3tXWpfg1B8JYeCjxKxN51Dr1mYE2qCnIzvJJsPFoSAI+YVB2FPfuLnnfQUM7EMQYiAI27Yp20ovWCPRjr7f0BICDU0TYCQ3rWbAs4k4TdM3UWUQV3D1uAIsnUqGmn3m6dSbjfXEGXguvxyKx8HXcapdK3uR526VQB3avgD0m814QJryPuqyNFX1OzGnsRVOh3kYt3SZe90M0XWb9IovjEHtn9D0aTO4+Rd06RwZHMu7MIlNA2Fu3QvcSz6AEiqOcvIv/bs6l7BEOkmObh7xi+hsymdRGCRE87wpy+N9K7Ilh5KOHhn/F0TSSAWkwq4COLEHA07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJFp22Z9NRJ+zh8RYxcRXpSV3bWV1RMB4YR4o+Dh8bc=;
 b=e7KNBZRXP1wgZBK5phNU4s9CGc7xWbrJJaoojfDk2cjWuCL6+DWT2Q2WfomxxsTRsg86S2sTxbAbps8OVsipJzFtS1bmyuOA8A9UladpBYOdDawXk3kqCi7/JQznHyL61hOam94nemshk2ZWOc6oV41cTfn+eUtzziZk69ZdlC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 12 Apr 2024 17:03:56 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 17:03:56 +0000
Message-ID: <9b0472c6-d2a9-9718-f73b-84aa775d8bf6@amd.com>
Date: Fri, 12 Apr 2024 19:03:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/14] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <e8d4877f3b7248031931ed193c026c42dd3363ef.1711405593.git.thomas.lendacky@amd.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <e8d4877f3b7248031931ed193c026c42dd3363ef.1711405593.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::8) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9af0f7-6640-4960-057b-08dc5b1289df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JsY67+S/34hm3sAuOExcdAJVDcQ9bZRYOS23R2h0P5dBndqwTmZ7wn5VC+yvrcr6DAGmR37ei7360UgJN8Y2jN0Jbd7+yWt2p3Ebi+qTQLpsbXqmsqUp7JujhXMpx1fOz7209+K24Etf8QfxDkGzVfpxISj6txaOH9E2u/Yagm8SbAU+z3ZF+vWqUAF4hE5mDswmq6o9OtcOx+yLsM3LhOBAwtnMtbBq3aERnb4J4FUqQCdZIveFYQAbDDZRULzYBklFIpITrDEsShecL3Zil8y420h7fqndFHgwWGf4coFcR9y/v8WfJggxE5mxeDnZi7gbtSdkke0wYtY2WkmF+FH2UcZlgBJyN2WgpM5Q3y2L2xOPDnosbZpWEa8+F7zg0/iY1lBxO/IDhv9y4W3JP2wnxws/On69FhIrHyzbkm12NdZGg8J7pB8onpbFASNrS999xvAGoQEu5zEW90qFi9nYtsPAoCj379NY0eLU/JghacMbo8j0ZGzi8L8fqdCgDpH+EsanyQeC7p06x0FXkutsHOoVklQlfb1/a3f7ApbcV9S5kbluhe2b3lJ9R+Xp3WMvnrK5cGqCE4IpD5n958bbhCZpTgiNI7v1hpZuGMaGLjrEYOAjhFXAhkOxip2V/Tszeq4HptsYBVpoPbAuHGP8d7omX2XnWi3ykKSRJsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S21Pd2k2YTdTV0lBa29yUnJPOXB6V2c1U2k3Vi9QbFM3MTZoL0JLZUhUZlI0?=
 =?utf-8?B?ZVE3a1BYQ2JDQjNseHkralJtYWUwbU93bGFtdEJiYXV2ODRubzJTQkVTWXds?=
 =?utf-8?B?YUU3RWpYZFkxL3VqV0RQNlVVV3JnUGF2cmR4em9zQUVwSXlnQVNOQmJrMnFa?=
 =?utf-8?B?SjlGa3Z0ME9KRUcrejZOQ3dYSlU2aGd1WkZsaVVEVk54TUNMa0NTd2FRdStL?=
 =?utf-8?B?Z0l4RllqTllIaHpFMld1RlpNaFI4VUN3bHA5M1RTM0p5WkdCTHN6MDZXWXZD?=
 =?utf-8?B?SEtxNWVtTlJLakZ1dlNGT21xcllqTU54d1pOSnM4WUl0d2Zsb0xzM013QllW?=
 =?utf-8?B?UjQ1NVdzbWxuSXRjMy9GUkJyM1JpZEhXVDFRUkQwcW51WjdXbE5sMldxWUpz?=
 =?utf-8?B?QXFFRE1SaDVEVWdYR3ZiRTZiU2VMMGZZSktZazNJTlFlNjduS3hpUnVzUjh3?=
 =?utf-8?B?d2VVMm1PMWFmbStQKzZKN3lDL2gyOTd6YjloYTY2NUo0RlhvM0UrSkU5dnlm?=
 =?utf-8?B?N0xvbkpQamJyVWVFNjNzRnFVVUxxYUROUXlkSTBaUXV0dEFDYWM0ZitwZEtP?=
 =?utf-8?B?Tm5HVHRRbkJOdzJVT1QydUdzZkRENzZuZzBObHJQUTNJZXJvdjg5MVJXMkt6?=
 =?utf-8?B?dW5udUQrNEY0aVNxSHJXdURxa1ZKcm9DaDdmYWZ0M1RGeFMwN2NYYXFOWWxS?=
 =?utf-8?B?T1hLaGpjK25RNklOcnQxaWlLYlJTYzNBY2JrT0dmR2dHTEZTdXE3dVNjM0Ju?=
 =?utf-8?B?SGRCWnZFUVRWUHVzWGk5NFphRlFWZ1hiVTJETW9RTVFjSDNSbGUyM3UzNzcv?=
 =?utf-8?B?ZmZjeUJ3NTFPU1Zib3ltcUZyaFdzcEEzNUF6KzlZNitlTFJod3pUK2p2MjE0?=
 =?utf-8?B?UjJwOGwzZXRxcThoTWlLOTh1Z2VQRTl4TnJDZjZZY0liYlU0QjFERnJrS0hq?=
 =?utf-8?B?WEh3a3UvQTEwNmRUeDhXdDcza25pRUszN2plcDR3VlJUSFRyRjJrd29UL3lY?=
 =?utf-8?B?NURRa09TVWpGUUJseEswWFQ4R2V5SUQrMzF5SUNWb1Q0UWl2VzNVNzNieUZz?=
 =?utf-8?B?QnVTVGFTc0xhY3FUaTJYY1prTHQ2N2ZjRlhlK0dKVWZhQjJqdEs2em9ubHhW?=
 =?utf-8?B?R0Ezc2pDdVVJTE1xN25naFM2djlrTy9KRitTK0JtSE9WTHNTWUtlODh4U005?=
 =?utf-8?B?WW1nRGhkazJvMXNBZEZtTENjT1hTeVlvNS9JSjAxM2l2ck5ZY3dJaXNUZUpW?=
 =?utf-8?B?TXh5S2VpNmlzOHlSVG5mV1BJb2s0SDdtZmpjejNxRGlJZ2hIZjFJam9VV0hp?=
 =?utf-8?B?V3dyd2tIa3AzTWFEVk1OUlRLT0hINXdHeXcxNmd6UFJwTGREZ0hyNVo0RGJw?=
 =?utf-8?B?T2NOVUtoWHpZTkxWTlNoczBqeVhmdG4wZ2VLUElHUGtXd1pvcjFhN1FmVFJa?=
 =?utf-8?B?MjJqcWMxNVFFVVdvbHNNOVdGNm5Cd2g1WVZ3MExrOTc4Sk54NmVIdkFBSjMz?=
 =?utf-8?B?S0JOa3UzQXpVdUs0OHlWTU0rRzlPZldXZ3JjK2pyclR0b1RDNThXRVkxWlZY?=
 =?utf-8?B?TzFsaUx4UTJDNTRXekMzSXUxSXBOOVV1OGt4VGdPMnppVkZUMGhEUkcrVi9m?=
 =?utf-8?B?S0tiNGowd0ozT1h1Z3p3Ry9waTdPQkxyMDVVV2tRSnh4cXNTZUpINnFMWkRN?=
 =?utf-8?B?L0M0bmZPVG1BYXdHcCszeVYyS1gyT1RGRUYwWU92Y3RmT0MrY3RGSVRPVEsw?=
 =?utf-8?B?NjNlNkVFVG9DWHFWWlpXZk9OMTFHcllEWllUZ0NmV1prWHNVUnEwRGMxSFlB?=
 =?utf-8?B?V2lpZmNLZ3U4RHQwRlk1QUJ5V092MmZHRTI3cmNuK3A2WjYvRUI2ZGdQWWhS?=
 =?utf-8?B?Q0pVenhKTDFpS3ZPdllsN0phYzRFK0o2V0N1OGwrSThuZnp0cThXV3JKQTF1?=
 =?utf-8?B?SFFHTDdVeFowN0Q1VXlpbFljRXpZNGlBY3VqbXdkNWl1RnAxald1Mlp4ZzMx?=
 =?utf-8?B?RFRYdEVGbGtRS2JMVWNQY2gzUkVuWE1JTE0yaFA4bm1yYWtJeXpvMHF4SmlK?=
 =?utf-8?B?SUI1blVtK0xUK2l4V0FQYzUrZW1NdnA2V2Y3WFRLejc2MnVnYnBNRUhxd3JE?=
 =?utf-8?Q?+t6U2Zw06JPFQcd+HBK89JzE3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9af0f7-6640-4960-057b-08dc5b1289df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:03:56.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gISRBfWQzc8WAitTrQV8kvD5AUX695V2/pT3w14hSYPu9GSUAz0yC00VdSdqkdVK0YwPWR01Psy8m83gcpJ6dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717

On 3/25/2024 11:26 PM, Tom Lendacky wrote:
> During early boot phases, check for the presence of an SVSM when running
> as an SEV-SNP guest.
> 
> An SVSM is present if the 64-bit value at offset 0x148 into the secrets
> page is non-zero. If an SVSM is present, save the SVSM Calling Area
> address (CAA), located at offset 0x150 into the secrets page, and set
> the VMPL level of the guest, which should be non-zero, to indicate the
> presence of an SVSM.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Looks good.
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   arch/x86/boot/compressed/sev.c    | 35 ++++++++---------
>   arch/x86/include/asm/sev-common.h |  4 ++
>   arch/x86/include/asm/sev.h        | 25 +++++++++++-
>   arch/x86/kernel/sev-shared.c      | 64 +++++++++++++++++++++++++++++++
>   arch/x86/kernel/sev.c             | 16 ++++++++
>   5 files changed, 125 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 49dc9661176d..fe61ff630c7e 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -12,6 +12,7 @@
>    */
>   #include "misc.h"
>   
> +#include <linux/mm.h>
>   #include <asm/bootparam.h>
>   #include <asm/pgtable_types.h>
>   #include <asm/sev.h>
> @@ -29,6 +30,15 @@
>   static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
>   struct ghcb *boot_ghcb;
>   
> +/*
> + * SVSM related information:
> + *   When running under an SVSM, the VMPL that Linux is executing at must be
> + *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
> + */
> +static u8 vmpl __section(".data");
> +static u64 boot_svsm_caa_pa __section(".data");
> +static struct svsm_ca *boot_svsm_caa __section(".data");
> +
>   /*
>    * Copy a version of this function here - insn-eval.c can't be used in
>    * pre-decompression code.
> @@ -335,24 +345,6 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
>   		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
>   }
>   
> -static bool running_at_vmpl0(void *va)
> -{
> -	u64 attrs;
> -
> -	/*
> -	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
> -	 * higher) privilege level. Here, clear the VMPL1 permission mask of the
> -	 * GHCB page. If the guest is not running at VMPL0, this will fail.
> -	 *
> -	 * If the guest is running at VMPL0, it will succeed. Even if that operation
> -	 * modifies permission bits, it is still ok to do so currently because Linux
> -	 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
> -	 * permission mask changes are a don't-care.
> -	 */
> -	attrs = 1;
> -	return !rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
> -}
> -
>   /*
>    * SNP_FEATURES_IMPL_REQ is the mask of SNP features that will need
>    * guest side implementation for proper functioning of the guest. If any
> @@ -480,6 +472,13 @@ static bool early_snp_init(struct boot_params *bp)
>   	 */
>   	setup_cpuid_table(cc_info);
>   
> +	/*
> +	 * Record the SVSM Calling Area address (CAA) if the guest is not
> +	 * running at VMPL0. The CA will be used to communicate with the
> +	 * SVSM to perform the SVSM services.
> +	 */
> +	setup_svsm_ca(cc_info);
> +
>   	/*
>   	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
>   	 * config table doesn't need to be searched again during early startup
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index b463fcbd4b90..68a8cdf6fd6a 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -159,6 +159,10 @@ struct snp_psc_desc {
>   #define GHCB_TERM_NOT_VMPL0		3	/* SNP guest is not running at VMPL-0 */
>   #define GHCB_TERM_CPUID			4	/* CPUID-validation failure */
>   #define GHCB_TERM_CPUID_HV		5	/* CPUID failure during hypervisor fallback */
> +#define GHCB_TERM_SECRETS_PAGE		6	/* Secrets page failure */
> +#define GHCB_TERM_NO_SVSM		7	/* SVSM is not advertised in the secrets page */
> +#define GHCB_TERM_SVSM_VMPL0		8	/* SVSM is present but has set VMPL to 0 */
> +#define GHCB_TERM_SVSM_CAA		9	/* SVSM is present but the CA is not page aligned */
>   
>   #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
>   
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 9477b4053bce..891e7d9a1f66 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -152,9 +152,32 @@ struct snp_secrets_page_layout {
>   	u8 vmpck2[VMPCK_KEY_LEN];
>   	u8 vmpck3[VMPCK_KEY_LEN];
>   	struct secrets_os_area os_area;
> -	u8 rsvd3[3840];
> +
> +	u8 vmsa_tweak_bitmap[64];
> +
> +	/* SVSM fields */
> +	u64 svsm_base;
> +	u64 svsm_size;
> +	u64 svsm_caa;
> +	u32 svsm_max_version;
> +	u8 svsm_guest_vmpl;
> +	u8 rsvd3[3];
> +
> +	/* Remainder of page */
> +	u8 rsvd4[3744];
>   } __packed;
>   
> +/*
> + * The SVSM Calling Area (CA) related structures.
> + */
> +struct svsm_ca {
> +	u8 call_pending;
> +	u8 mem_available;
> +	u8 rsvd1[6];
> +
> +	u8 svsm_buffer[PAGE_SIZE - 8];
> +};
> +
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   extern void __sev_es_ist_enter(struct pt_regs *regs);
>   extern void __sev_es_ist_exit(void);
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 8b04958da5e7..66d33292eb78 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -111,6 +111,24 @@ sev_es_terminate(unsigned int set, unsigned int reason)
>   		asm volatile("hlt\n" : : : "memory");
>   }
>   
> +static bool running_at_vmpl0(void *va)
> +{
> +	u64 attrs;
> +
> +	/*
> +	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
> +	 * higher) privilege level. Here, clear the VMPL1 permission mask of the
> +	 * GHCB page. If the guest is not running at VMPL0, this will fail.
> +	 *
> +	 * If the guest is running at VMPL0, it will succeed. Even if that operation
> +	 * modifies permission bits, it is still ok to do so currently because Linux
> +	 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
> +	 * permission mask changes are a don't-care.
> +	 */
> +	attrs = 1;
> +	return !rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
> +}
> +
>   /*
>    * The hypervisor features are available from GHCB version 2 onward.
>    */
> @@ -1267,3 +1285,49 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
>   
>   	return ES_UNSUPPORTED;
>   }
> +
> +/*
> + * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
> + * services needed when not running in VMPL0.
> + */
> +static void __head setup_svsm_ca(const struct cc_blob_sev_info *cc_info)
> +{
> +	struct snp_secrets_page_layout *secrets_page;
> +	u64 caa;
> +
> +	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
> +
> +	/*
> +	 * Use __pa() since this routine is running identity mapped when
> +	 * called, both by the decompressor code and the early kernel code.
> +	 */
> +	if (running_at_vmpl0((void *)__pa(&boot_ghcb_page)))
> +		return;
> +
> +	/*
> +	 * Not running at VMPL0, ensure everything has been properly supplied
> +	 * for running under an SVSM.
> +	 */
> +	if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len != PAGE_SIZE)
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PAGE);
> +
> +	secrets_page = (struct snp_secrets_page_layout *)cc_info->secrets_phys;
> +	if (!secrets_page->svsm_size)
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NO_SVSM);
> +
> +	if (!secrets_page->svsm_guest_vmpl)
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
> +
> +	vmpl = secrets_page->svsm_guest_vmpl;
> +
> +	caa = secrets_page->svsm_caa;
> +	if (!PAGE_ALIGNED(caa))
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
> +
> +	/*
> +	 * The CA is identity mapped when this routine is called, both by the
> +	 * decompressor code and the early kernel code.
> +	 */
> +	boot_svsm_caa = (struct svsm_ca *)caa;
> +	boot_svsm_caa_pa = caa;
> +}
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index b59b09c2f284..64799a04feb4 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -135,6 +135,15 @@ struct ghcb_state {
>   static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>   static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
>   
> +/*
> + * SVSM related information:
> + *   When running under an SVSM, the VMPL that Linux is executing at must be
> + *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
> + */
> +static u8 vmpl __ro_after_init;
> +static struct svsm_ca *boot_svsm_caa __ro_after_init;
> +static u64 boot_svsm_caa_pa __ro_after_init;
> +
>   struct sev_config {
>   	__u64 debug		: 1,
>   
> @@ -2122,6 +2131,13 @@ bool __head snp_init(struct boot_params *bp)
>   
>   	setup_cpuid_table(cc_info);
>   
> +	/*
> +	 * Record the SVSM Calling Area address (CAA) if the guest is not
> +	 * running at VMPL0. The CA will be used to communicate with the
> +	 * SVSM to perform the SVSM services.
> +	 */
> +	setup_svsm_ca(cc_info);
> +
>   	/*
>   	 * The CC blob will be used later to access the secrets page. Cache
>   	 * it here like the boot kernel does.


