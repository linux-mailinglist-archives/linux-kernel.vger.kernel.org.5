Return-Path: <linux-kernel+bounces-143054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D328A33A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7741C21908
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE9914A08A;
	Fri, 12 Apr 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gxrbju0U"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C2205E2B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938813; cv=fail; b=FrmIuCTeR1MM5coy8eo4qNDx4Nz0PUMbDnFOChtlKMfkYmXkRIQpFFo6FVpglcmrOxi5QG7XwBd1y1tiTvnn2UOuJFyQ1O9b084z9sqA7T4B3NzZfdHL6qwdtW05ZZAKoo3SFzTb4s29hcSnDV4QEaNPMN2q8boVwArmMVUnBJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938813; c=relaxed/simple;
	bh=dt5ZMn768LJzVnzo4wn0INYOikERmnle4ZSm5MOiRnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dA8JbgPlEFFmTQxms/8rMOmcMhvw/SmR0xTbEfo6hHkt/2kT+vfyXqjmuOJqahsOxekDzvR36jMAPQihlPXNNaNBTtcFdHxccMkfWpRAXL4WuViBVNwcMH9gfqKthNGSLvKsd4/yz7+YtTCnEXp+ZY2boLBjLWF/9RBrBUCwAyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gxrbju0U; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/akTK7Bt7XVjiFb4/fwFPk1/h8Pxp1neyi3taHqcs5CPvLT91+hCf8u0LmfOKnTBCYPLghj8Dcky2ir1/Q8jXxtilAdkK68r+Z79LLgIEMi7mjYKuRneeSDEcaUgSMRCjKZd/f2TvkVN+3tZOA74Iz5V1cdQku0Dg4obvzX3Oal8HMf54dsmNzPrHnVHlP1V5ms+I+n3L8ZsRmGzhHX/R5HBlrucNIY5r7eE7TpxZyv5M3mUu0S9JDS4uNd8YBmVpAw0ntlKJ8/EYmA3CW81nK7inapBMcARzO3ZhbqXV/FrnVpQ0+hJ/m32HHNJ6f21K9rHsom+UWcyfdJ9PcyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BwBU9/PaPth1d3VLAsnTLHcR0Cc45ku7tK85UHZvIQ=;
 b=FSTFdj4GkRcyqdMfvAErKOYtTwwn1gAIPS5G0Zw12ej/5kyBM+ofwDF4W6Sqm1Lac/uPTn/klvq0jDtQvnqZNSMPIafxYDSLr74XSBlF/kY9yOejmbI6Mjam4yIfp3FBW6JVOxxiSwQkgsooZaQPHrMCMtwWR7hwPbOHfdmcXEnlnmZ5L2dUj1qULcdyBb4ykrgh0hLYBeeYWeOA12SGLuMpfmpiuf2rR2xFUT1PDQsBa4+5ZJ5/tgU5Z3VCxk+e0eHmkWNfmp0XTFZuDhJWjk6S7ub89pUdaGSq4UlLpxdaKHfKlGJd1mektrhT2vq6fj+vrP0T5Qcr33NKrFc/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BwBU9/PaPth1d3VLAsnTLHcR0Cc45ku7tK85UHZvIQ=;
 b=gxrbju0UiW5pjB//hR9CGLoFVCvtisVRGmoFcGjoEpCKcsFdO+LEFzlngMI24Il3/VyaqPQOApN1aLipZNYGyfMvoSkX4N1Tt7XCfyO1FWuKcbHM5ONmSuVCTPFSMjr+ccS0o6VMwcp+Ovy+VM3al/t+1aW9+kp46cCT2Ef5Rf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 16:20:06 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8af6:1232:41ce:24a3%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 16:20:06 +0000
Message-ID: <4c6d1088-71f0-c558-dc4e-bd6371a0ac35@amd.com>
Date: Fri, 12 Apr 2024 18:19:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 01/14] x86/sev: Rename snp_init() in the
 boot/compressed/sev.c file
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
 <425afa6512994b1ca1bb366eb7abfb24d65175aa.1711405593.git.thomas.lendacky@amd.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <425afa6512994b1ca1bb366eb7abfb24d65175aa.1711405593.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 81819caf-9c9f-437d-ab40-08dc5b0c6a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xHtWwQ7CP+5Mz5rWZde8hXXJ/vyWKQlTSjSRRdudPK6PldE4kR5/5ux8hvqJIvi3aOIZNYOkrGkPFcwPmTOGFOYjn1lVOdrPRfMvNRrP/8OrRx7Rih9agoJeIKw4ljr4BDRAx9czL8X1ZerH+4W7n3WwWgU9EEtEI0NOVBVISngBUxOyVXjYjMu7iq7cvWV4vpt+MKSzAFLr0uxkmDIRNkIbcJep9A1yIVFdca47z57pUw8rAmwQ37lf7ygxKuiEliAoa8l4ODzhcO/rV7tfcKZ3cRQZlg7VBwHmP7678U0/moLB5vSIbyaim8v+3j/+ItC4WdHKVMFOXIcmmMCR9jsmx2OyNoAAv8wJeq2VDdnRTsNbprghLK53riSc6YkPk0JsTV52z9FbW5wKxq6CqZKekPrnL6RPJ3y6Eh7Ax10UyNkx/M91O12UkKcJAOtpgkVslHO6mEHmZxxPM2oe4NeyjhidPJIztOqoOJqlCQST7QBvwv8zyg2O/prME2GS1kv3qGlEXVRL2Wg+IuiIyPsE3D8fYeJ3faK0C4zS6z1z57vHBvfTdwCwU99FQ57lOYL8XtLWPhrILakw5Iynazcj8LjUrkNAxGUOTKHD+fbFHSUmZx2b2gyWn8MwGfzJjGTW82W4u2S+oZj8o0a9f5ICGSzg2wYp8wHZmk0XNs4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDVhSTBWeEtpcnVjQWZ1MGp6eExONDBlem94Y1pBTlJ3OTlUOXZOanhYamp0?=
 =?utf-8?B?MWZLMHlZcXYrdkhjbVRBYytNRnhjT2FDQzRHZ3ViWFlOZlZGNHh6VGozVTFC?=
 =?utf-8?B?U2xXSUZ4d3Z0TDkxdnRQR0xxMFF2M2R5R2YreTdySTdCMFZCUUN0R0dFUXVs?=
 =?utf-8?B?ay85NXJLM0FYdVZ6a05nbDFEOG1iQzByQ2hmWjJvN1RoK003bU83ZGN5TUlS?=
 =?utf-8?B?SUJ4OW41V0hwU0dySXB2dEI2RWhoVm8rR3FuTm5NUWpBbXpzeVFlejA0TmxF?=
 =?utf-8?B?ODdEQU1UU2ZWSW55YXpXeEQ1THVnOEJCUXc0Q1E1cEdyeEQ4cUw1M2ZaMGhx?=
 =?utf-8?B?SnV2bkh4VlViY2hQenVGcDFWUDk5R1Y0SERjbm9DSjEvWlNIT0lER0Fzem45?=
 =?utf-8?B?QjFqTUpVQk5LcEUrYjZJSWdKV01GQXNWdkpzTE5iRElaQ1BmYW0rbVNlU0Jm?=
 =?utf-8?B?Mzc3ZFhWeG5hbW05MXlmbTVIVUU5VHQ2Wk9ja0pETTRHejRsQlltei9SWVd2?=
 =?utf-8?B?TnhGaGhxZlFTcUZwSEx1bXN1Y0tERVRRT3prWk1BRWZ4RHhvdkNuVUxINnBZ?=
 =?utf-8?B?SUVPcjQ5N0svMTNnK2p5Nnhkenk3VytidE8rQm5XZUxSdnlud0ZZNmYrelZy?=
 =?utf-8?B?MlliMEp3Wm0wRlB6S1pwaGdoODZlM2hUMFB3NlNSVFZ5eHBiNGJJTGo5YkFC?=
 =?utf-8?B?RUpyZ1ZRMk1EdThXcytCNi9nN3BmOUhGK20vMHdJNzRuZDhublJPd3RYY1lJ?=
 =?utf-8?B?a2JkSHhwQURYa3NSRExCWkV2Vk9jN2FRdWlXL2doa1FCWFYzNlhwYVQ1Wk5P?=
 =?utf-8?B?M1ViNTVDY0VMZDlWK1QwZXpyS2IxUmk1eDRYZE93dTJDSXZjUEV6QVlUbXNL?=
 =?utf-8?B?N0hOSWNiTk1wVlJRMlpNeGZaMU9zSldWL0psNllxU1lxYS9rMUZFYzRBS3ZM?=
 =?utf-8?B?OE14aDNmdXI1Mk13eTZFb1dyWExNZTNPenJ0L2pJcHdvVlNqazNvNmc3TmNz?=
 =?utf-8?B?NllMYldQeCtaZjBMWnpzaHdNc0c4K1VkOTN6UUdoM2xEQmNEL0pmcm5PRTBO?=
 =?utf-8?B?Si82ZUVJb2JDSnFSdXU2NDdRdjJ3ak9takVWTHo0aUtrOWE2VGt2YWtBQVFJ?=
 =?utf-8?B?dEkxNTZzTDNlUHRYSEZoc1hPMVdQL1MzTmtOT0kxR21pY0RXTjROcnF5SW9U?=
 =?utf-8?B?RURIQWhJdHR5K3Q4NkR4Y1VoaEdXQXpxV0hRR2dEVUwweU1aQ3BSZjNVUnVi?=
 =?utf-8?B?a0FDaWNaam5QTzI2czBkWE51VHVyMkNjelVOV3ZKVWhEV1RIRTBHZmJCdVNC?=
 =?utf-8?B?b1h0TUQ2UDQ3dElabW03SzZjT1pZYjRHZERhRkhoNDRKVmtEcUprMFdqTXVw?=
 =?utf-8?B?WWpCc1lQU1RMcjh5eVNTZ1dpTkNxTjZrOHk4YlFYQmE1bUx3VGhzTEZkNmpI?=
 =?utf-8?B?dFpGSWx0M2EzNUx1aEJ1b3Z0RkpsVldHTW95RFhTd2NzamZVVEZRL0tUaGRX?=
 =?utf-8?B?Y2FQN0l4SWdaZkk0bUtMVWZOUWpZZ0EzMkM3VkRyQ0FLN1FiWEpDcDBUYnBR?=
 =?utf-8?B?WUhaVFhrRTVVV2VGMzNlYkRMdEdaZDFET2VOL055RVVseEZ2eVVIU3FtcERK?=
 =?utf-8?B?eDl0SmlZN2ZNc1l1RjI2emg4UldSUHA1LzYrWGJpY3EreE51NGVocFo1eGdQ?=
 =?utf-8?B?UjJsdjV1VUZNWEpSc0Z5ano4NWRpQWZlTlplNlErQmR5dWNaMDFtUm9WbStx?=
 =?utf-8?B?TlJzNnhzUVRMdE9zcU4yU3puUTVMN0ljdmd2NVh4blcwK2t0ZksvMG14aGRu?=
 =?utf-8?B?ZFJiQUxJZkkzZDdCRFpqTjJxcDJ4QVhtTlRJMkdsenJmcXJLc2F0QWt6UjZy?=
 =?utf-8?B?T0FwS2NCdnV2K2k5VHZLY205djNpZjB2OE50ZGJyWEF3bHducHNBb2M2K0FX?=
 =?utf-8?B?YW0xQlQ1L1RxZ2lSK0xHdWJKYTM5dk1vTkpTYmtIL3A4d0VUODVJYlNPNG9C?=
 =?utf-8?B?UkI0KzU2SjhSMUlQRUxPVzNnWXJXZFh2OHBjbENOTFg5Q2pSSUhOVGJvQUhM?=
 =?utf-8?B?MXJ6NGM5akhJU3krQk9oRURoZmI1bkZFZXBNQjVvMitoanJUZENYVE1nWVE5?=
 =?utf-8?Q?zb5NcH9scASdFGl7BEZ4B3Q9Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81819caf-9c9f-437d-ab40-08dc5b0c6a9a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 16:20:06.8229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNfYRF33muU5W0SvO/Cin329hgR5GaJVCVQQBKZGQNy+vrhUfANuysgDVpMzY80CriX96ska4ROsq9O7brk7VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

On 3/25/2024 11:26 PM, Tom Lendacky wrote:
> The snp_init() in boot/compressed/sev.c is local to that file and is not
> called from outside of the file. Change the name so that it is not tied
> to the function definition in arch/x86/include/asm/sev.h. Move the renamed
> snp_init() and related functions up in the file to avoid having to add a
> forward declaration and make the function static, too.
> 
> This will allow the snp_init() function in arch/x86/kernel/sev.c to be
> changed without having to make the same change in boot/compressed/sev.c.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Seems no functional change. Just rename snp_init() & move functions up 
in the file.

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>


> ---
>   arch/x86/boot/compressed/sev.c | 162 ++++++++++++++++-----------------
>   1 file changed, 81 insertions(+), 81 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index ec71846d28c9..5ad0ff4664f1 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -413,6 +413,85 @@ void snp_check_features(void)
>   	}
>   }
>   
> +/* Search for Confidential Computing blob in the EFI config table. */
> +static struct cc_blob_sev_info *find_cc_blob_efi(struct boot_params *bp)
> +{
> +	unsigned long cfg_table_pa;
> +	unsigned int cfg_table_len;
> +	int ret;
> +
> +	ret = efi_get_conf_table(bp, &cfg_table_pa, &cfg_table_len);
> +	if (ret)
> +		return NULL;
> +
> +	return (struct cc_blob_sev_info *)efi_find_vendor_table(bp, cfg_table_pa,
> +								cfg_table_len,
> +								EFI_CC_BLOB_GUID);
> +}
> +
> +/*
> + * Initial set up of SNP relies on information provided by the
> + * Confidential Computing blob, which can be passed to the boot kernel
> + * by firmware/bootloader in the following ways:
> + *
> + * - via an entry in the EFI config table
> + * - via a setup_data structure, as defined by the Linux Boot Protocol
> + *
> + * Scan for the blob in that order.
> + */
> +static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
> +{
> +	struct cc_blob_sev_info *cc_info;
> +
> +	cc_info = find_cc_blob_efi(bp);
> +	if (cc_info)
> +		goto found_cc_info;
> +
> +	cc_info = find_cc_blob_setup_data(bp);
> +	if (!cc_info)
> +		return NULL;
> +
> +found_cc_info:
> +	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
> +		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> +
> +	return cc_info;
> +}
> +
> +/*
> + * Indicate SNP based on presence of SNP-specific CC blob. Subsequent checks
> + * will verify the SNP CPUID/MSR bits.
> + */
> +static bool early_snp_init(struct boot_params *bp)
> +{
> +	struct cc_blob_sev_info *cc_info;
> +
> +	if (!bp)
> +		return false;
> +
> +	cc_info = find_cc_blob(bp);
> +	if (!cc_info)
> +		return false;
> +
> +	/*
> +	 * If a SNP-specific Confidential Computing blob is present, then
> +	 * firmware/bootloader have indicated SNP support. Verifying this
> +	 * involves CPUID checks which will be more reliable if the SNP
> +	 * CPUID table is used. See comments over snp_setup_cpuid_table() for
> +	 * more details.
> +	 */
> +	setup_cpuid_table(cc_info);
> +
> +	/*
> +	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
> +	 * config table doesn't need to be searched again during early startup
> +	 * phase.
> +	 */
> +	bp->cc_blob_address = (u32)(unsigned long)cc_info;
> +
> +	return true;
> +}
> +
>   /*
>    * sev_check_cpu_support - Check for SEV support in the CPU capabilities
>    *
> @@ -463,7 +542,7 @@ void sev_enable(struct boot_params *bp)
>   		bp->cc_blob_address = 0;
>   
>   	/*
> -	 * Do an initial SEV capability check before snp_init() which
> +	 * Do an initial SEV capability check before early_snp_init() which
>   	 * loads the CPUID page and the same checks afterwards are done
>   	 * without the hypervisor and are trustworthy.
>   	 *
> @@ -478,7 +557,7 @@ void sev_enable(struct boot_params *bp)
>   	 * Setup/preliminary detection of SNP. This will be sanity-checked
>   	 * against CPUID/MSR values later.
>   	 */
> -	snp = snp_init(bp);
> +	snp = early_snp_init(bp);
>   
>   	/* Now repeat the checks with the SNP CPUID table. */
>   
> @@ -535,85 +614,6 @@ u64 sev_get_status(void)
>   	return m.q;
>   }
>   
> -/* Search for Confidential Computing blob in the EFI config table. */
> -static struct cc_blob_sev_info *find_cc_blob_efi(struct boot_params *bp)
> -{
> -	unsigned long cfg_table_pa;
> -	unsigned int cfg_table_len;
> -	int ret;
> -
> -	ret = efi_get_conf_table(bp, &cfg_table_pa, &cfg_table_len);
> -	if (ret)
> -		return NULL;
> -
> -	return (struct cc_blob_sev_info *)efi_find_vendor_table(bp, cfg_table_pa,
> -								cfg_table_len,
> -								EFI_CC_BLOB_GUID);
> -}
> -
> -/*
> - * Initial set up of SNP relies on information provided by the
> - * Confidential Computing blob, which can be passed to the boot kernel
> - * by firmware/bootloader in the following ways:
> - *
> - * - via an entry in the EFI config table
> - * - via a setup_data structure, as defined by the Linux Boot Protocol
> - *
> - * Scan for the blob in that order.
> - */
> -static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
> -{
> -	struct cc_blob_sev_info *cc_info;
> -
> -	cc_info = find_cc_blob_efi(bp);
> -	if (cc_info)
> -		goto found_cc_info;
> -
> -	cc_info = find_cc_blob_setup_data(bp);
> -	if (!cc_info)
> -		return NULL;
> -
> -found_cc_info:
> -	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
> -		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> -
> -	return cc_info;
> -}
> -
> -/*
> - * Indicate SNP based on presence of SNP-specific CC blob. Subsequent checks
> - * will verify the SNP CPUID/MSR bits.
> - */
> -bool snp_init(struct boot_params *bp)
> -{
> -	struct cc_blob_sev_info *cc_info;
> -
> -	if (!bp)
> -		return false;
> -
> -	cc_info = find_cc_blob(bp);
> -	if (!cc_info)
> -		return false;
> -
> -	/*
> -	 * If a SNP-specific Confidential Computing blob is present, then
> -	 * firmware/bootloader have indicated SNP support. Verifying this
> -	 * involves CPUID checks which will be more reliable if the SNP
> -	 * CPUID table is used. See comments over snp_setup_cpuid_table() for
> -	 * more details.
> -	 */
> -	setup_cpuid_table(cc_info);
> -
> -	/*
> -	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
> -	 * config table doesn't need to be searched again during early startup
> -	 * phase.
> -	 */
> -	bp->cc_blob_address = (u32)(unsigned long)cc_info;
> -
> -	return true;
> -}
> -
>   void sev_prep_identity_maps(unsigned long top_level_pgt)
>   {
>   	/*


