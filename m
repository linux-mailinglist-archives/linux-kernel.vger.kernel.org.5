Return-Path: <linux-kernel+bounces-106328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0911A87EC74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684C0B21EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76A52F8F;
	Mon, 18 Mar 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t7TgZ7wI"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A2452F6C;
	Mon, 18 Mar 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776807; cv=fail; b=biaPXV9Nwk7msdeqJDaLz7NMhRIwUoCUTUahtWyMM9qyn2KzedHWshSrJqCz5UrM7fk/AtMO76Vl01vSXmax1Y/dIjGn+0eMIPAWOCoBm0WAZHg0G72ZLVJUXY3bsx3gIQlzd2PuNUyqsf+XOOG+pGuOlSl7SqqjzRBkn8v4/Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776807; c=relaxed/simple;
	bh=HaGb1peEIkH6r+bW2+Ik8GkBwj+BRJnwNiB2fB4W2vY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b0S90mQTadI4L53V7f/3MsWZ1RIk70VGsu7jxmcFQ/+WjGKEryCWLyiY1UZHKhVXV6ABkrnC1zk8+8NytQQrWJw6Hxt9hoBN+AzvSFe8SELZaIqF8SE6qXXq14H9A2DsqTyReOj/DDw+OLimGrp5+khJs74PUeHFV/AZqzAmd18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t7TgZ7wI; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWr3s45HQHL3KT/ALWC8HCLVgqp494nRBfSaMsZ6J5VHUNYPt3GA2WaoKXZu6PuQZL49oqXf2O+h8BQm068PSkPrX3gW9Mh+IZQV2Qsaly9PhpACmQWf4EyoOELs8KbPT7eFPDMl3/5Nxim3oPfrnBBqUqKRceWKD7XQCUVTq8DTBjOpMdYWIv0gHv7rh9UhrAfoH4WtRzLe1S9W+0gLOz9im7M10/sI907pXKwLGvEPKF0Ytlj/hT8ME4TcSxa1FzSIeIIsgRmNCjowK8mItZfoJpe77awXWIaz0lrpohvQH0Dy9cRvsWJv8wR+D4Vnbm+Swmn67Z5qHm7/o6Y+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHCVui+8oaQfFycyg+C8Tnu4AqxHD2npmo0hgpKikAI=;
 b=BzI6+DGlD8whWcIR8XA1uGIGePIgj1ABsiutaSsuO5da22n8PGCApiFIE/8hgZsHUJeTFAjT/8kkNGXREBtSRQfDJt8zN9V0XnnLneuS8iFe9aeTYgu4X28JU6LEVeTmoInDhjSaU+PAnw+H770dns1tv2a+idZVbCskHk9e5Wd1Gh8pmeDZmVfn9mOu0drITcoqte6CpbQEPOjmER2dnHpOrK6WweknV5bh72Vj2XtEGDubeew3XwNGs1ZD2aLuMjJBVZSXlmcEL9Ksc41R6aB9rXA4tFr9VCoFbCjnrWWI2gkDBLhHYCT6O21lwcQLYMgMV0GmIKLYjh2S8GA+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHCVui+8oaQfFycyg+C8Tnu4AqxHD2npmo0hgpKikAI=;
 b=t7TgZ7wIhSkkSExeDlxkrDn3vaA4SahgopgUHurjizTZF1a/YZtvg+eaowNhwA2paVBcYg59RlMSfYNgYeVGxLgaOtjBMPwJQ+YfAQWPnlIDXq5EJJIL3E51m24r7FkjUeKqvrcVAP/2RtwbuOXNE/NIjL9xEvy56AOrxAttW+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 15:46:42 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::3278:b63e:55dc:d1a4]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::3278:b63e:55dc:d1a4%4]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 15:46:42 +0000
Message-ID: <893141c6-41f8-415a-a1a3-d3e4267ec333@amd.com>
Date: Mon, 18 Mar 2024 11:46:39 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 avadhut.naik@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH 3/4] RAS: ATL: Add map_bits_valid to header
Content-Language: en-US
To: John Allen <john.allen@amd.com>, bp@alien8.de,
 linux-edac@vger.kernel.org, tony.luck@intel.com
References: <20240314163527.63321-1-john.allen@amd.com>
 <20240314163527.63321-4-john.allen@amd.com>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240314163527.63321-4-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:408:94::15) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecf0c62-8448-4851-cc06-08dc47629bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8/1GVxLiJN2HUTT/u3vHtVwp/9ZCqH4KS7tDv3wFQSo04KUsDDqrEdmdifWbzmhZIHfPwlEgNThO064c8TSf0n68MUeIV8HZdqzq8tVx77YgDTF2hLsTl/iSBhPPEbaGU5//CClPX7zwpJM8eR6rsN+EM7VbHwrEtqoPdjHNlFItFyVxC5rkGkiwgxI7sQ+s46pMXNduZ/sxs6fhebp0+Jmpqzqm+bABb0HKm3Cpp2qIA+BWXgBmtnjTVHRZ071JBhGg9bH/6HrAvKxIWvPDy/0ptOBBVFFnKWesZ4iOxzPWbgLgwdBq7mZyngDbJ9jEqiuTbXAQOKlNYDn7NUIp4EuXl6jRTdm3mpewCmiEpzTqmdr4oZUXnqML/G4EUFmSPlQqaRDRN4lVi/sb2LmUCVsdH1s0mU/xP7cggg237+wXBqwvvx3nqU8iPNP5XpRHJz59k/M5cACU384gRfiguEsUEbOIoOA+3SbTHePtf7K4XVywF280JE0dAW6lRsoTa75TDPwUwaZlDb7fRCnWUrCwdo+sWR9/qflX13DjH+kxM842mgw//odWb9nFQkFQJM22/PKx2xFs7Ye8iEM6Tx6lOBMfmkXW7AEkInzmw7fNpG274kUBPIWDdY12D7c3275Yk+MFaKMYyc71v2jZXeWRMAedSg7vmuY0E36B1E8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXhmTExWWE5UZmpXd3dxemdMTWo1d3oxWG9LWlZlTXZhc1Y4TjJrK3lhQVpC?=
 =?utf-8?B?R0JjZDNPRDMxWE1qTG5SR3NJMHpwdno1cmU3SUw3UGYzMWdmeGJ3VlhqbzMr?=
 =?utf-8?B?c3JMdnJnNlR6eFR0UEN0MkU1VFJJSWFyZFNHL0pRZGdRT1VjL0VRT0Q1UjhV?=
 =?utf-8?B?bms2cU50SEJ5UVgyYkJEd3NFWmN4Q3dZNHJydTVkQVkrSDlzb2ZtT0JUWkJ2?=
 =?utf-8?B?cFpsM2FMTU5hSGVSemR6dHdlWm10TmVtQ092UlpCVFdaVnlnRmZIVzVTeWhk?=
 =?utf-8?B?eUlsRDlFbENMVTRqdmRSVGdXd2djUVRVOVM3VHcyZEl1MnJ6cmNpblkxK3Vs?=
 =?utf-8?B?WGY5U0FTdmtBL3B5VXloTnlVNWlrNE1mM0J5TmlkTnhrMXBxUk00M016MEhv?=
 =?utf-8?B?NWMydzB1SEw5bTlRUU5JblMxNjNpbENybU0xelJDcjl1UDFYdTg5dDU2VEsr?=
 =?utf-8?B?YjlIK3RPY2dQcmtvYjJnUG1iOWlldzJRdXRNWno0KzNZYmU1cnVtdlZzTmZ3?=
 =?utf-8?B?VUZBeUhOYjBDdm9zQ0RtbG5MZkE1Qmo3dGxIZXJvdTBjVUlqR2o0YVU2ZGhu?=
 =?utf-8?B?ZWNiUU1lUTNRd3krUm5qQkxzd2RZRzY3Um84T3FXV1U4Mkx6WlJFeFV2SnlJ?=
 =?utf-8?B?bWVoSUZBZXV4RzFLbVFsZEZadEdNNGhmWDdteUFSVU0vVmZZUzM3YTMxdHBU?=
 =?utf-8?B?TUpHSmFBZGJvWmdjcDZOWUNPeUdLSGhQcW5GOEQxTFRtSk5tNjFDVW9PamN1?=
 =?utf-8?B?LzJVM2oxTzhyWG02M2NyMXFvWXIvTC9xRGFBVXZuNkYwZ2FJNys1ZVNDRGJh?=
 =?utf-8?B?eWJ3VHp4alc4eDZpMDdncnh5eGczL1BRWGtkY0NQcnpPL0hUSjFwRmh3ZlJi?=
 =?utf-8?B?eHltUEc3Q1BTY2dTRHZUamJpWlNUb3lMSmpQakoyb2sxL0VOV3l6cWhRS0p3?=
 =?utf-8?B?bVFWR2NOckUyWFhjOGwxRlVrZ0lITnJyMzdVQ1RPVkdveW9aQ0dEL1FtTTZs?=
 =?utf-8?B?QTdLU21VODQvVTNuVGN4MG9nQnNBSUhHRzg4UlJpWkQ1YU9TODV4dFRRaGJn?=
 =?utf-8?B?ZlJWeGw2U09sNmMwdTY3RTNBaTJDTjhOazA4dVc1V0dZeG9RTHRjV3NrbUJa?=
 =?utf-8?B?NmhHNUZ5eHNrdWxaUXltbmtzRFBUMmlaRGIxRjBGYlA2SnhxamlDbXRadFh2?=
 =?utf-8?B?eUQydFgvN1dEZlRreFRwVHNNRXpTU05tTU0wSnhKbldZTHA5REY3Mjl0WTJN?=
 =?utf-8?B?RHY5K0ZUNU9nQ05Sdy95bjMwYVY5VXc2dVVpK2JuWjBPT0FYalRRTGFvSVJJ?=
 =?utf-8?B?MGpxVEp3Vlp1czdidWZCcGNWTEFmWVZjWFBPY0NQRUcwcDlBc0RNaHpJU0Ix?=
 =?utf-8?B?YVVTOW50a25lOFFzbFJhdXgwZ0RueDFxeENHNXdWMVhwT05sY0dTNnFWcEtZ?=
 =?utf-8?B?T01NQWRDUVh6aFp4ZG5taGQyaFVZTFNMdHR2azJWODJ6NUViSjBCN3lKdHox?=
 =?utf-8?B?dDNheHNCM3F0dC8veG94djdKMFV1TlY3d2hBaVVHVXR6NDJZcHFjdGFJNnhK?=
 =?utf-8?B?bEZQaU1ZR1k2dE9zajdBUnd2enFCNC8vZ2tnSDJQcHBRV3RLb0g2MXpSK1Rm?=
 =?utf-8?B?Myt2N0xKalVjTEZjdEI1c3huSjB3RDJJcytoS1luSHdwTjV2NXJZdHBkUzN6?=
 =?utf-8?B?cWNyNDZYa1p6NmdCajJMUEN2SDJHSFRQTThCTGxTZmE2NEJvL1ovQlhBMkZ4?=
 =?utf-8?B?YlBWRVFVaFlJRjVKbUJ6aEtmY1V3ajRHb1V5eUNCaE9iaVUvZVdubkk1dEov?=
 =?utf-8?B?bzVJR0lHQXlLRzkzZDhST0FmVVNsL2R3MGVpL0JqckYzK294QTdjazI4NEFv?=
 =?utf-8?B?RC8rc2xmSFhIOHVQdTZWT2FBQldvUGlFZ3FNeW9Oak4wK2YxUzJuVjVGSXFI?=
 =?utf-8?B?S1BzMEt6eWFFVkF3ZlFQRWVVYVVwR2dsZzN0N0oxdVE5dWovZzl0c1IyeHFW?=
 =?utf-8?B?MkR2N3Bta3cvdTRKdXpjek5TdGNhL1hTSUhNNlI5TlI2R2xyY3JvYTdtb3Fr?=
 =?utf-8?B?c0tmaEZiaG1lK0NwbXhjNjBEVGxTRFlTRTdObjhaMmowMkhpdG9SdEd2dm9H?=
 =?utf-8?Q?xMJJjpx7HEBmmzSiP/WBH0X49?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecf0c62-8448-4851-cc06-08dc47629bbe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 15:46:42.6481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vImc4rj12zOm+JJ6hSOpXTk1vUkKfEW+tWdJTbKwPphNYalte1zs1DgiMaxXIRtTiYuAuNfkuGrIYn26/6kMOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578

On 3/14/24 12:35, John Allen wrote:
> Make map_bits_valid available in the AMD ATL internal header as the
> function can be used in other parts of the library.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>   drivers/ras/amd/atl/dehash.c   | 2 +-
>   drivers/ras/amd/atl/internal.h | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
> index 4ea46262c4f5..a20cf615b83a 100644
> --- a/drivers/ras/amd/atl/dehash.c
> +++ b/drivers/ras/amd/atl/dehash.c
> @@ -19,7 +19,7 @@
>    * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
>    * respective interleaving is disabled.
>    */
> -static inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
> +inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
>   				  u8 num_intlv_dies, u8 num_intlv_sockets)
>   {
>   	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> index 05b870fcb24e..4681449321de 100644
> --- a/drivers/ras/amd/atl/internal.h
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -239,6 +239,9 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
>   u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
>   u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
>   
> +inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
> +			   u8 num_intlv_dies, u8 num_intlv_sockets);
> +
>   /*
>    * Make a gap in @data that is @num_bits long starting at @bit_num.
>    * e.g. data		= 11111111'b

Ultimately, the maps should be validated as soon as they are gathered. I
figured we would do that later. But that would wipe out this change.
And, after looking at dehash.c again, map_bits_valid() isn't used in too
many places right now.

So I think validate_address_map() from the following patch should be
done for all modes first. That way we don't need to add and then remove
this function from the header.

Thanks,
Yazen

