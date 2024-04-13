Return-Path: <linux-kernel+bounces-143529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3960D8A3A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54A31F23761
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F718059;
	Sat, 13 Apr 2024 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fXyK82n3"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2094.outbound.protection.outlook.com [40.92.103.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F319E17C6B;
	Sat, 13 Apr 2024 03:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712977331; cv=fail; b=AS732bIbinp2RBzTAme5ULAVXKKgT/LokWqPCWN3ZNZGp78kFvn0+n725cKmJICIcjo1j/iigvASlkiFS8XI8deW6jafE2fGpafnMW/C79FElm1x4XZUQwsed+G+LzrBZ5G9wq9V0a0SxvCrk4SyZNZ91thA93h3nHUzF4z7Rj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712977331; c=relaxed/simple;
	bh=eI3/cGQVs7cD0+cEk8GrEaUn/OHxY86iYBSv9/mljlg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XNGzaFyqoAjae76WxYD4ZcvANh1bPXYANAC4YSPUxT9MAKDQXWtI6OSD/yC5lioqxtfxCMVMYkOpesHb7Tgs6a+RnFrYGKjaNq9762xmtbzTm7DektIUkv4hGmfcsY78yqNz2c/XspDUjfIu4OXU4Y2WK1oHny9UmCpzmg8QBZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fXyK82n3; arc=fail smtp.client-ip=40.92.103.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ll9Smud7Oj+XdhPg7HJNxwvll6DEjzkhH1On9IuGNwYDaTEDiKMh4EvrySAGX6vupOV927W0jxImAFlA/mLwTl4Hrsd/xNo+vlHJJ8PAnHiwh2dyD22sNPlP5sQteCZ4cE+YolYStP94Z5GEVI++LDuVCY2Al7dnDdwnjjw+7Y1nd0RufYweFelS/MjrwVHpgndNKdeaETwrwa7u1ijmpmrB0Q+d2OBqcZsTHBEGackYCRcIXGM/OjHhj7OFUl4xq7MqK5RZEOlqy1WkZW9/FCK2ZVhnFBkQf48xjaXKZZ4Rof6nxxP86b5fBK768dkIbcv5Ue2LPXozaCgcD4Mg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMXcLgEhEt/s6IyuoMWXRDR4rg/L1N7i7CS14TddycY=;
 b=XNcgvANuzSk9sZz/x3fFEWAN844vWMiOgA4+ZIw6cTa9HZgZMhxBeIol4NlBkhm8Oep9tw9kXGKfPBzxtjoUzMpt1/3SlDu4eUWfwS4ue0VMMgJeCsq2DzKlplmFw46NvHadQxcUZSCevp4+olLRPLzyztQOCYODMbkvN68wb4kUNk4pRc9AaanZhuIdx5bvB1lKGj1MA99O9YHz1qVHAXachLOYIy59Y5AWbjY7ApPw5Zb4x5WtMstaFCgXqBPwWKh6jAGJLZXvbt//g1x3kU50+q6bocJCh7lM5X6b/YuhqFtg4LHr1tcNK8HbADq//L32uNdylZOYPoo+TLXcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMXcLgEhEt/s6IyuoMWXRDR4rg/L1N7i7CS14TddycY=;
 b=fXyK82n3/BQOKFObGBxIhL0gesI8JH9Ahv1PxQmyPhQKuZRBLkMw6Z1wdbWoow+t8kE9XG4Bob/ab1tNCZrAUbgVJ/AkgKIt74PmuG+9ex6T5dnIEX+0NmQBLFnUZT8YQIZou7AuAKWboa3fe9mlzuECenkfOdbOWfnYUVqEfGYvBIHO35X2eDbRbs2TQCZ3ebWCmwhhYM4TtbBqM3aFHWnq8JsdQpHm30YucDLXW9m/E7YC1mQHz2m5CFKGwsfuU3LTKR8wjY/KJE6mXK53EyoGT8U6FyU8++Y8zPQuGKjkqDw9pc5DAwPrX5CAeP+KUVrUJRpli/tI0aXj7LJESw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0125.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 03:02:04 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7409.046; Sat, 13 Apr 2024
 03:02:04 +0000
Message-ID:
 <MA0P287MB2822856646A116E713BCE716FE0B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Sat, 13 Apr 2024 11:01:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: sophgo: Use div64 for fpll rate calculation
To: Inochi Amaoto <inochiama@outlook.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <IA1PR20MB4953CB4FCCDE82AB25F6880EBB0B2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953CB4FCCDE82AB25F6880EBB0B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [2oKf9PP2sQW6ZR2T+9uvxRwUsdp2z0Qu]
X-ClientProxiedBy: TYCPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::15) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <ccd1cb70-a779-4065-9a3b-1ca62febde14@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0125:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd1d5ac-1754-46be-0ce7-08dc5b6618d4
X-MS-Exchange-SLBlob-MailProps:
	P1EfU6pZOd+ZDkBo6jAcVAy+QTb9tiEWMm5bHjFmdrD8ZE+bzWlkFd3fNKlyHL+0FkewdtPGeTtVWAfA9aAC2SuDwy4RufXjGnUYhwHHaD54Vbya6MDqsNtQEQJexe1yxLuAJ/pE9MzO42m9WstGHuwTkrTaObWmfcq6jT6scY2gF9XRBWIlLONqfcNyNYiMH1DpQrIrn0buBTrewpdLGbpUuqv6K//C/pgzBDN4d7sQoAZaxzbTthutOTvxBunnQCdPhPnSRkKcUEIGInbSgTTYMrCcHL0ixkDGath9K4RZDYx130xTpKA0qbe6WkZ8qGrUxx0alLxP1u29lJQnNV1lJPqzkIwAF2BNR3lGiI1SIppjOwT9V/yoZpN/38PNLFUttZdEO0yXKjLFWQ6O6flAF3Cf48+O64dNGbJCLNePywOzJAx5w3Efx1sH2RCUsdey01EEpka0hlVaPPsx0kuMGI1B0SgQ/BxYikxs5Ys+7YMcK8aAfTxLhvFCCVBbwrWhiCIcDYLuIxpGtpyTjpZcYOw1bYmG1KctlGz29cTSfC48SrcAbUZub5v6rGhmq4XitcId96mJHbCVyCRBfCze7jTiQdGx5U3tEOOlVv9+a2LElMyF9D11uExEYwidhIEWqdZX8g+MBAOs1/JeYJ/Z2R64dlCtmdEk6hqJB7BpWMaOebXdW0NkyaJmDoS+1JYY2sCihfeo1y/MxVKlw/sxfUlyqtLeBJyVUcVh/9e7ibiyVF5DEwt+fyexUGg+1zuw+JgPMLWbliLmXr/1JS1UW8od49SO1418GfKInuON5sM8BfgCSg==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o59+HQCaBkyQKUORIK5lT64x0dbGsLoAHa4xSz0/dDJkyWdWVTzV+hTC557gHMCZB2D7zaZkiMeFQBl1SenP50Qt6wMb4e5q1sO4ujvrqYKyhZRhMiRVVDBi+endf5Rha1E3rGHSbmaxSGF7fwrTXRp2qClIdgXhCtMtlb3dzBAUyQ1ngYy+FXcmV1EFJ4Z5H/CbxpEhDM62LYFL38Wcb/4Z0nOtrThpm6zeDxNHc8p/BclzIxILjLndEs+F+agLHSDsC3uGq3p9iB+AB5GQPsdPZJn54nUafBnR9VjeZTmR60+oOGKE4wdhOso7Bl+NotLMnyvSoHlhJq+H21YHMNPzUhAGDQLWoFgzRGhEFNYnDtPKdTvJ0jlPaHz5d+Tw0P8SS1ZFZZC7b206FII3kaU+xFy1WzE7xKoMZM6oih77MTRdL8u+uri4z561J33hMKuNbTpIzfcxcMwRKv/323Kjbq20gS8MGs2KuR7Cj3mgjJlbEqnhOXQinq+BoD59WSvxCOT8w07jqXxMAoCdC0BpoK56202Adms7xESsHjAAxswTjRidluAZzcDG0Jv/sgfAMYwo+1I49R8aHOLDZ5gwN2OFniMV/sqbVx3QAgxr28qcKv7brSQdzgMP/NPVrGKvlB0zSQ45RfjrOTnbIMPYWfhAr8TR26MhG8v5bYH8Bx7Wf0A7uJgPRcLlmrCC7+eASOaAhZREsufgLsDTKA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2JZOEI3emx6d01TbmdjNUZMV0tHWUFvUG5QUUVaTjlGcTl5SVQxTmhoaHVD?=
 =?utf-8?B?YXp2b3RQTFRhL0htaGdoWlF6c0thc2wyOGV4WFl3OWlmT1I3Z0NKK2trRGM4?=
 =?utf-8?B?d3NOZW10b2ppZ0c1Vkk4djM1dUV1ZFM5akNHSUJscnFsWVJaOGN5TFRna0JI?=
 =?utf-8?B?c20xN2NNWGtVNXhSQTM5ZURQbm5nOVlrN081cFplOEdSMFlvMjBHQ2NNQnd1?=
 =?utf-8?B?d3JBTEx1L1FSM0JJZkgzQjRaVkNpM0Rhd09xRlFieGZFR2JvYlFkSGhKeGov?=
 =?utf-8?B?cWp1OXYvdEVEaUNrYnVDWjA3dURSVlIzUGxXSUZUL2IxTkF3dGhKd0xLajR5?=
 =?utf-8?B?MTEwUmp0K0ZBVitGODdmR29VbFRVQXZWNTRRdW9zTkNreVdORGNzYTl5UGFC?=
 =?utf-8?B?WGZkb0l5QjRUL1BoUURab00rS3k1MmRVcGEzRitXYkgvT0tMZjJJOE5IR3Ew?=
 =?utf-8?B?b1l0MEJ5ejJSanZQbGRncnZrUjNCRDM0WkhSMFFZcnFFdWVGSVNBc0dqUWZh?=
 =?utf-8?B?ejdhRlBPOU9xREhLUTRSek54UTJtY0RFaW9aOG5uYTZ1aEdmU2RZZE5KVjQ2?=
 =?utf-8?B?L0VGVEFzaTFvcjVvOXQ2STFMd2tqaW4wTTEvR1ZBWDZQK0FLYkFDRWtZQVY1?=
 =?utf-8?B?N3FTUGQ4YlpzcXVESVZ5SGova0hXL3FmcDdMRGtIS2dXdUZ5Y2VDYmQzRUFQ?=
 =?utf-8?B?dEc5K2U3aCtGNzVTbjZCaUJDZ2wzV2hyeXFyNWExM092dEhmL05TR2R1K21C?=
 =?utf-8?B?cjBnWXNGZll2bnBwOS9paWQ0d1FISGVlWHNCb2R3cVRzRHdqY0xYTVFJVzMx?=
 =?utf-8?B?OGl4QnY1M3ArNUJEd3hZL2VUU1IrNEhTRm1VV0dhYzNZb3NSQm5kK3NtNG1z?=
 =?utf-8?B?Zm1wNGFzMktqaGlRa09EdVBXMEd0bnp5VU8zUzRQb2xCTHl6a2pDeExsaSsw?=
 =?utf-8?B?RXVsdzBKN016cDc1WjRzcW50NTh6dFJXWTN5N3l6U2w5Y1EzcEkxeFZaZ01R?=
 =?utf-8?B?NlN6ZGw5M2RwbE9TdUMyU2tXZFF1WkplWTdJV2xsNXBSSWJUNXkzYTkyMGdz?=
 =?utf-8?B?NFdyaUc3ME8vOHdJSFYzL09oMnc4WHE1ajZOL3VQY3ZuTmV5QTFlYXNvTnNI?=
 =?utf-8?B?N0toOTBOSmlRTkVRWDVXREdxV25SSllvbUY4WGhvTzYvY1pqcE1ocFVkcG9p?=
 =?utf-8?B?cEF0K3lYaHBKWm5GUFQrNXVwTkNuTUpxYkh1MHE2MzZySDZEYy9uVGI0dmM3?=
 =?utf-8?B?OTFQL1B6VHF0NkdjVmlMWnN1RkxUWWVXRnA2UENXRys2Mmw5Y3hvQk13cHNh?=
 =?utf-8?B?MWtJUkdWTXVQQVdLbGtIc1ZMOFJaMFVlakp5UFo1NVVpU1ZZam05VGU2UmEx?=
 =?utf-8?B?ZlRlbHJRc3Z2bUVzZEpTOWE5cXRETmR3U2lpakZwVmVUNGFxaEhiei9xOWQv?=
 =?utf-8?B?ek56cWc1T244WWJ2LzM4bGJQVDFsZjYyTlZ4dG9iVUlNR3FJVmpiQm1kUXNP?=
 =?utf-8?B?VCtKZzIzeVBDWUQxcE14MFhVSEJVREI2ZWtqRklucXM3MEZFelIvQi9BQlBr?=
 =?utf-8?B?WlZZeHdoNVMrNVd6NEltVkFRNXA4QmhMVkNwODdOQ0k0OWp4SHVhNGRUYXRL?=
 =?utf-8?B?bjJBSHpzcVBQTjFpbklxZk9wWTB1L3RSL2owOC8yNzkwMVpNa3U4ejU4M2h1?=
 =?utf-8?Q?lm9U/yHfwC8D6uQY52W3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd1d5ac-1754-46be-0ce7-08dc5b6618d4
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:02:04.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0125

Just a minor suggestion to add soc name in email title to differ against 
other sophgo products. This can be handled in later patch if any.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

On 2024/4/13 8:53, Inochi Amaoto wrote:
> The CV1800 SoC needs to use 64-bit division for fpll rate
> calculation, which will cause problem on 32-bit system.
> Use div64 series function to avoid this problem.
>
> Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404122344.d5pb2N1I-lkp@intel.com/
> ---
>   drivers/clk/sophgo/clk-cv18xx-pll.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
> index c546dad1791c..65aba3b95cf7 100644
> --- a/drivers/clk/sophgo/clk-cv18xx-pll.c
> +++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
> @@ -6,6 +6,7 @@
>   #include <linux/clk-provider.h>
>   #include <linux/io.h>
>   #include <linux/limits.h>
> +#include <linux/math64.h>
>   #include <linux/spinlock.h>
>
>   #include "clk-cv18xx-pll.h"
> @@ -202,18 +203,18 @@ static unsigned long fpll_calc_rate(unsigned long parent_rate,
>   {
>   	u64 dividend = parent_rate * div_sel;
>   	u64 factor = ssc_syn_set * pre_div_sel * post_div_sel;
> +	u64 remainder;
>   	unsigned long rate;
>
>   	dividend <<= PLL_SYN_FACTOR_DOT_POS - 1;
> -	rate = dividend / factor;
> -	dividend %= factor;
> +	rate = div64_u64_rem(dividend, factor, &remainder);
>
>   	if (is_full_parent) {
> -		dividend <<= 1;
> +		remainder <<= 1;
>   		rate <<= 1;
>   	}
>
> -	rate += DIV64_U64_ROUND_CLOSEST(dividend, factor);
> +	rate += DIV64_U64_ROUND_CLOSEST(remainder, factor);
>
>   	return rate;
>   }
> --
> 2.44.0
>

