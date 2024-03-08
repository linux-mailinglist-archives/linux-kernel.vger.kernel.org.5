Return-Path: <linux-kernel+bounces-97666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E004876D49
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC80E1F225D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAD0364A1;
	Fri,  8 Mar 2024 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iGBZQQO8"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BD15AF;
	Fri,  8 Mar 2024 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937812; cv=fail; b=ZcqP+vDTZXlz7PzcOw4bhKD+dpoLfqP2uws1+QqwNe5eEZA87SoL0QRjQYzs9o9ciRJraBRknUjZS6vZ3TSAywsqjcOOO5qdLxN/HdYTi46nmVkoKPESpKafSobuWPrBfXzf3OFT7cjpydGzpF8DmgsiAWtL8wPj8D5yOqHnQI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937812; c=relaxed/simple;
	bh=eYnEri9ZzkN3eIEtFUlh7eKqW1Of/8un5Nt9JzkAx08=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OLp8j9Ll5VxMKFMdnRIk3fnVViEnqhzj4XiGoQHBamgaWUiY1SonLwVQI0sYY97Qt+3pqPAWiPKV8VjFv2cIE8F45KCXTpSAoEqFjmY1dgRFAiqPdcuCifEFQ00V9xLGTvNYh+owqjWvliNlmrs+pgOExujMmKQNw+3gHNDC3m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iGBZQQO8; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqh/TN2h37Ge2Wdj28hkkVg6UKCJg6KYvowKKmyDNGl5TC2qfijc70LbnFLVwqVQtfTgEFlTOQyvh8ok+izT6Zb+haRsRaH7BH7/xn81d1gbgmxf6LI8Qm7Yy2KHo+dUDXAdizoo89DriFZZjcC4ebX9k08HFRGXQmhUUo70vKz3JtNQgO2jIqHlrcRaLTWGUYZ7uMf7QdgwQT4L/0dvUkQbv066W1uH+9R+LfVlU5pDi3iQGB7zuBAHKl5sgVcVbX98TgajMOTxbkbn2s2evav6YKSsENDzIwCDNfxC4SyaUuNWkiVgvMGYQUxgH6JXiAxMO4M6jxxCmJLHN7e/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg2eFnAyMOYUwG6GAXviDvX4uw1U8417FBaM0k12hoU=;
 b=APTwcAuuUJo8oks4ndayqukf0EXsMdvLLyqoILpxk+wgoIPw+fOjHkmi8hfUZaXLIkiEHLL0F1wQkEe/SyEVh29mEnuBZq/DOh9COrsFlK20srbnXbjnuL6418Ne86LuruhfmBhHdEfO/+Sy+zlXMNxdubtecctrUee6tJhMfJUY4pD8a4corUepAmv1IOVKPq0FobzJ8Xpq33INGDXAzM0Gvq+7YrpVzUxlizoJ7fmUzxdUONEt/KkhXgfcJ7OzazcjH+3z7cdJy5ihm+woiea3l+5RJffCD82R9uG1au+ikw4z8Lpe2Prs7NJXoh1DkbBRQhDvfzQW9Z/Zxh2SZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg2eFnAyMOYUwG6GAXviDvX4uw1U8417FBaM0k12hoU=;
 b=iGBZQQO8MU2hnFMpE9tCKq4TC8fH0U53uzjty1uFVgNcpaYPoe35BOvDTflZKtSf7ptudTiwKpXhLdIy/a2go0mfbFnxH7F+YWsGcz47LBb62scboV9rkZdaFxV5akzeSvKaCX0hq/HS0ZIjzmn2wMTndepSS2LClWWi5k5EmA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 22:43:28 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::3278:b63e:55dc:d1a4]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::3278:b63e:55dc:d1a4%4]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 22:43:28 +0000
Message-ID: <e367a4ad-3431-4cf8-9c0c-1205e00b907c@amd.com>
Date: Fri, 8 Mar 2024 17:43:26 -0500
User-Agent: Mozilla Thunderbird
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: linux-next: build failure after merge of the edac tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: yazen.ghannam@amd.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240227134352.6deda860@canb.auug.org.au>
Content-Language: en-US
In-Reply-To: <20240227134352.6deda860@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::31) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f72c82-7a5d-4021-a91e-08dc3fc12c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3CdYaUrSg+2OM0roQDd0zGsjSTWtWG/i6JtRGA2wu2W+l17t339qBiNOsyM9iyfJ1gx83sUcIb+8EHF64mmm3LEXkm35cbHjR4VWFvXz1Kbr8h5kadMGfMbjdgqgZkh9e7XZYuKrH0is+LXIJ0WFnB413+6nxUBDbG96Wtxvl7+6Fj5IP2CrsQLqtco0RGgnkm6f3GXt1Kn7R4NaRoy3WBnQr9txkUD5lNL2mucvJd01kBxP6OUWCI3YcFKkJFECCcxP0TVJ4UjEjfGYDrzAigoye2DKSnqMNMmwNJGSLWtJYGwpNIosaKztOCE11ZSy9J+7r2Xx7ZNvu3MAEqe8k/XnvcljkhYld0a0uQ5bIeJuyYvIsT3NB9sXR11Roi1mPrRA8T777O8bhY1PaGeU14LMbjVT3OZvFXWUV8ovX76uYtP4ZjXRrlHwqcROyCDOkn5MRLeyKIceahnO1KdupuDgDr6Q1RUg+hJpJdWwEIPY5zfiGpJlFH6bJ83elM8vVzXA2/BFfD7lRxVfCbu4sEBUnSbTDDHFkXjQpkcBYJzZyalQdkFWXRWPbhWyWzjJgwgKXbi/is8BrrWK3RsTbeoEOW0E85yqIFtEKMAU3uma+fBsishBZcM+ZjXU5pO5QO2EGMq7Wt/AmxCiv70syadCGVmG4XEEKtsZ/rEAkBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWliRy9scDFpNll3amF3eUJLTmxpZmhRcXJMN2x4K24wZnFCTUZoeFhVY0VG?=
 =?utf-8?B?TGFOZG1kT3RJN1g1U1FrQ1FwR3VCQ1UvTjQ3cmcvb3VDOTNSTlhvOW91QmNY?=
 =?utf-8?B?cVZIZDMycjdCR0JTT0tVQUJuUWczMXo5MCtreFE2VkF2SFp2VnhtWEhBWEN0?=
 =?utf-8?B?ZDBwZ0NyQS9OSUFNVmxGM21UVEU4eGZGN1FVM1RTWlRnSTdYQUcyeFo1bDFQ?=
 =?utf-8?B?NGNENlNGK3UyNUYxeFVnYVVnUTkyaFBhMkNCMlhuRXJzQlFCVkxnNTE1L1Y1?=
 =?utf-8?B?VVNoOTNwRVhPRGQ0MW1GcDM2YUx2N2NudDNQa2szUDBFTS9EQTlZbkluZ2Ro?=
 =?utf-8?B?dU1EbW93aDdUT1liTHdOemVpYWdtd0trRnZVSDhHemRyMVNGZFA1cklMMVFi?=
 =?utf-8?B?VDBrQ0hrSzJRd3RIVGZoQ2Y2VENadHF5cU9IQkpNTEh4bHkxSkY2c3RFMjd4?=
 =?utf-8?B?SXlLNXNFck1ONXc5YVp3OUFzSStnbkpKQlVTYkVzYWt6Q3k4bGM5d1FzbWY2?=
 =?utf-8?B?U1NhYS9oMlJ5SFBzVitGU2VmSXFydkxKNW0vRWhZUm9HWmFhUjZDRWlFQWVw?=
 =?utf-8?B?NW91aTZkaDBaWWVQQ25GeERzRDhmeTkrcWk5aXZnRHhsbjN1Ry9DV0x6VHV3?=
 =?utf-8?B?QUpHeUgxTVVqcG5IY3VmbDQvaTZXcUN1S3RaeFN6VUJBNG91VEtMVkNIdUZq?=
 =?utf-8?B?ZlhPR1Fod2VYYzhjRjJ4YTJiZS9nTksxVWtwZ29EKzh3dTJ6UTJ5anVaekw0?=
 =?utf-8?B?UjNERzRPSW5lYjVxMEQ1UUIzSDByOEMvYTlubGRzR0ZtU1U5QWcyK0E1UVN0?=
 =?utf-8?B?ZnpCbGN2cldrQ0Q1MURLY0VMdEVLdzQ3aTlNMVJyLzQ1ZDlsd2dxTEJyMUQx?=
 =?utf-8?B?a2ZJMVlkN1BpdWNNT2JyblFjTkFybVo2K0swbWsxbGZlVVNWWXNPTTUrRk5T?=
 =?utf-8?B?UWtueHAraXNTbThjTlN6SWYxM1lQUFVBRHZ0QXNKb2xKZGJXWDYybFhkRjlu?=
 =?utf-8?B?eUpINVZRdlMxM3pySmlTWGM3bnNtZkNvU2xQL2tHbzV5ak85ZG0vNUdzMHFD?=
 =?utf-8?B?TW5vQmVsNXo2WWtwRDlJYlBvTXZzTmVLVi9kQTVTcVBlTVN0a2hkMmxncDQz?=
 =?utf-8?B?aUloaGVsRUt5RnJScnU0UWV0NkV5Uit6TEI3U3laRjZxemdtbmxNeFNhcmYz?=
 =?utf-8?B?N2dhWTd2M2VvZVcxN3RCNWk2S0c1UEV5NUFnNjQvNjR4em1pVktYS3I2L0FW?=
 =?utf-8?B?U3EvbHpFTkwyNFVNaXJldU52UXVnd3pCREd4STBzRjBVWGF6S2R2QVBCQlZn?=
 =?utf-8?B?dFRwS3JCcG92dVd5dTNxVFBSUCs5V1Z6cTFvT3hJQXg5eXpqTEx0bDduOHo1?=
 =?utf-8?B?dDR5N3ZIOWRtVWNIY0lTakl2SWMyZkRVT0lqeEx0MTNsVzA5Y0ppcXFPMjBm?=
 =?utf-8?B?Q1NsWVFCSnZFMkRSMTlCNVIwVUZFUk1YSjgxSHpkZk1HZ0lBVlh6TEVnT3Ar?=
 =?utf-8?B?TklKeitxb2c0WUNUcWFsVHhxL1Z1MDJjYUtNcllOWVNjUGlvcmxtdU9uS2NE?=
 =?utf-8?B?NW1BNWgrOTBMcVBWMldLbWJNd2xEcExUSmFVTW1zTGlJL0ZVUlAzcTZjZUpy?=
 =?utf-8?B?TkRGYnFEb1pyZHBDUTVTZHlPOFJxd2lTL1V6Z2d0MTNyWmh1YmRUUTZvajR2?=
 =?utf-8?B?V0VpNjdDTTdiTm1nb1lOZXp5ekx4enJqc096YmVoeUsyY2xaQ3U4WVJ4UG1R?=
 =?utf-8?B?MjBhaG1ReFQyY0xvYzhQdzlSV2wycmxFV3ZmdWovaFRuKzhmRWcwZzZKY2tB?=
 =?utf-8?B?eklRdjdXSWNJL3RkdjNlUW4xK1A1b1JvalJaZ1J3U2pZbnpRSDBIZ0p5cTd0?=
 =?utf-8?B?V1pUaG84YmxrYUxEVU93MUE2azFGOEkvVG9TMUJXek81ZGhmazlyMENiRGtn?=
 =?utf-8?B?Qjk5RUhnREg3NjlFY2k5M3hxa01zTDQ3VDllSFhTZlJUM2x6MnpVY0JHbXhy?=
 =?utf-8?B?VWtlNE5SbkFrd05rK0RJN0NraENWekI0a2xJNEtTeGhreTJTblc3dnVrc0h3?=
 =?utf-8?B?YmJRdUpJMkxsbCtYM1dibFVuUzBFOGJVWUpPMzRpOTc0T3ZER0hVdmNuTGQx?=
 =?utf-8?Q?qpWKlsl3iqKP07lkPjxenR6DX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f72c82-7a5d-4021-a91e-08dc3fc12c00
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 22:43:28.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bx4hbb86aoO+Tcs36iVgg3uq7Vg6chvf69kdGE3BAqlve8Uu0u6MQHGdObiuKuuuewbeADKV3EY0eBpv4X9TQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616

On 2/26/2024 9:43 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the edac tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/ras/amd/atl/umc.c: In function 'get_die_id':
> drivers/ras/amd/atl/umc.c:318:44: error: implicit declaration of function 'amd_get_nodes_per_socket' [-Werror=implicit-function-declaration]
>    318 |         return topology_die_id(err->cpu) % amd_get_nodes_per_socket();
>        |                                            ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>    3f3174996be6 ("RAS: Introduce AMD Address Translation Library")
> 
> interacting with commit
> 
>    c749ce393b8f ("x86/cpu: Use common topology code for AMD")
> 
> from the tip tree.
> 
> I applied the following merge resolution patch.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 27 Feb 2024 13:22:56 +1100
> Subject: [PATCH] fix up for "RAS: Introduce AMD Address Translation Library"
> 
> interacting with "x86/cpu: Use common topology code for AMD"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   drivers/ras/amd/atl/umc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index 08c6dbd44c62..65a0ab651ee2 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -315,7 +315,7 @@ static u8 get_die_id(struct atl_err *err)
>   	 * For CPUs, this is the AMD Node ID modulo the number
>   	 * of AMD Nodes per socket.
>   	 */
> -	return topology_die_id(err->cpu) % amd_get_nodes_per_socket();
> +	return topology_die_id(err->cpu) % topology_amd_nodes_per_pkg();

"topology_die_id -> topology_amd_node_id" is also needed.

Does this need to be fixed up in the RAS tree?

Thanks,
Yazen

