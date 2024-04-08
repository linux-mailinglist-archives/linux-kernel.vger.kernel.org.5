Return-Path: <linux-kernel+bounces-135106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6E389BB3E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187781F220B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFFE3C484;
	Mon,  8 Apr 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dZZer8AZ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2055.outbound.protection.outlook.com [40.92.53.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75962E84F;
	Mon,  8 Apr 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567400; cv=fail; b=M6lg5ExS1OklrGQcFJbz2sItOlkzCUTFP80DN2USdNmveX0lLPHVoL26K8aicFwdu6Nq/LwNI3u2SMBzTth6MWnn/LFpb5OPzkSWwrctpOaILObz49D4FxcMXOz1Bh7AVyi3zg2x9VCeZQGC3edTBryshEnzqVv4JBYhYNkATdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567400; c=relaxed/simple;
	bh=xFBmjdM1oV3rkJLfiM+NyJ4Du4Ns/aVCjTyngWTIoi0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=geof+gCs0yTRwxkvg9+V26EX4zYLz1zijruv3f69IY9Ms6Zf2mQQLdFPC3cQT6n+L0MSoGAzuFowbiLmzJvRr23YyY0IMu+gBgNYuCEma5X05SFHhb09EJMY1w0521aLiJrufShY45inLxYNWFxqrQv5AU6kVhd3W0huzcz7xew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dZZer8AZ; arc=fail smtp.client-ip=40.92.53.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ3IbbyTkxP1cJ8lxe1lXMUwiEvXjAKzzm6ePKFyr8nHqiKE8DO7qSup29w2gnL6w3UEiiT0Fo2TgnjzSHpnU5O9RUeDTQan3LBFMkmPm+uKdK0ovTzb9KUlpkfxCosEBLyaHn4oMMobUceQlMiDFM8/1EalB9A7hkrKBz7U91xK/+yLv7VwlszIiYJF67JYFOVHtjA3MN4HJVyYfh8O2nBlhn4NZ/V5976lnP+63QYVOHbelOGPpH0wA9NMSBZaLAq1LwiK+qxSlh09UGIWlDUhb+vsT+WkL8CBjtY2lSMF+6AxmmYQBV3rAvGyLPf1Q27r2gfjZXd4tk+915pJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmZmlapQUrKRkLGlkMOyMugECznBqSCO2e4AA+yC6so=;
 b=l4MeDLP/O6qBKARvT0avcRWJgC1ZRo9oKWrJbhfTQtBFKf/bDQ8lrHR1RnYAqCYjoPp8E4LSzS3DrXRITOGkkVdvZcQSF949fla4oNAV8hNxrxs50niqEMuB9pCbNpwDwMkNMzF+aLWiSzdsxcfqZlnRSK/zrs60zlrcLlrqe7Msi+NSaHwi1UzfKj3Nnsi27+W0HZ2S/QXgzRLrd+c2X5pF2WehPXUnkLiOaWpdziUfUzAioWSgyN4FsPA7a60gvI9c1MmPd86tJ1Mv7BDtXf+Ml9L2fyFU8pDEutfGpUolSKg0qlfhjjSvD7LvWXIa+1jXD/rzI2uls2rW5lLWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmZmlapQUrKRkLGlkMOyMugECznBqSCO2e4AA+yC6so=;
 b=dZZer8AZueiXeGIl1GBY0c/HtB3gD20EIb+RPRl1Jaq6gVhiZBdLJXm1zTScg4P0vwbH1FeCKoAyaljjnMvbNGUo7lecT/ZBxdOWYtLPVV/WX6ncsTvDskH/8I11t0ESprchCe6g06OpSdmOpMwvp0DpEpit+iQFVFKLWca6TsbiOgoko3zNc0KqJtKOzhigPKFnN+OHR6HB4rvgUI+NhDBP7JwyKz0jarBihHFAUR0FYOaDD91nhGdetQz51lX3VchmewObFlBL8VPPAFgd89oWTOm8VoQMpoxvAKCWlntW2Lx0o+NBT8xRWKu1og4djr5qb2MHL3THvLCbiC1Ycg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB7164.apcprd06.prod.outlook.com (2603:1096:405:91::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 09:09:53 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 09:09:52 +0000
Message-ID:
 <SEZPR06MB69594D51286B7A4C00749E1C96002@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Mon, 8 Apr 2024 17:09:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] arm64: dts: hi3798cv200: fix GICR size, add cache
 info, maintenance irq and GICH, GICV spaces
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
 <171256140981.12523.5652563259173425537.b4-ty@linaro.org>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <171256140981.12523.5652563259173425537.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [3TKD/MkYj01KceV+HGDQa9KttFW4A0GUsLQxG152tOzeUy9voRFk6IdMoAqVDC33]
X-ClientProxiedBy: PU1PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:803:2a::30) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <ea79b8c9-aff1-4b3e-998c-48b24f6be45b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 541f44a5-ae35-465c-ca21-08dc57aba528
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQBdpaPwSVsSQj2v0MDiDiZlB79YOvSyZINnufS5zhffJRGtTFnj5kTYiigrd6SEe3F2be6j9VAphv8JYwS8ysDoPGkea9fv4D6t7XO7jZQITb+I80D+u1EegFTovRfEIcJoqTb98LfwyDRXOvNZbJxuUZi+bqAYiRxUcgePn7AuIC1CuQamBbUrugVrAkbG28PQpT8wZtZT1CYSqp07IAcPHVE6bsmRIuLSjYNu3zCDTW5oAormJ4Ssc5xjx9d1BUUaJbozk0pHNkQGHuClp/00fYTeVsg73u1I0ZwBJvk3GJMTwn3kJ0d0CdMrWmDmtGkq/n3/bc7JnKCAqm+iCY3oUpX7GVNCp74CFdcYcT8RCr0Yn3bd2RovuSEjBza0CNjTGg9A9iGrs8tyCpKpfiRVXa70EYLgv19oFkxE49QrP7aRFCpKCRr1jtxJPnDYylz7wk0K0VGAHUAQwnCipqv5xer+CMTV0AjaupbN8/wm2fzUE8bmDarqGvqem4h0FYEMLv9Uoi8DRWBBpNbOW0G2+/wVolwscTePwgWuvmirkS0VZeDFr2VlLdqx/6ovJ2iWvwQwIGjNo4xIbWo5vNQ5f3/QcmLz2EvxxzQT9hR1pJFw7Kt7wrkKy+kB3CQV6lz0qTZJVS9O3r2u46OkRjvxRqSWG/3yOIrdg18ZKkpDgD0g3hIYxH2BbDRG03833biSsNjJHmHb1mieZWHegNJ2zFExq+NnDvd5G9axYu/7+Q16rVZaDPCTeFekCP4atoWnhkQplMqE/aiVodhxXLxiCo/Mh68rhOuN/nGBPFTujWmean0yttC2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rkX6B7z8HKgViX5dfMzXnMmbJ2+wsXsB5jt4lTMrmq0KGeSiw9077EeUKSpbibNlGBuPwcf2qAP4nkNgVNKV/W7sizM0bhUHRHy0YaBmJTkukJR3RGg3Xt/842r1eF8Au07XwM7EZQTqOD7ISACMlxqEtEymB9gFryWpD0qGmdpi0vlenQHHc6NdfWvq0KuNlhrsCn2Gg6s7XmjwzwPA3mKkxIyWx1yXFcXPyk7wsvLmoTLF0MseSVwY/FLUQIS4/hN0xVr1S3H9JjtJiojw43Tlu7q2o+qHdSiGnbOCmTngYFrwzk3pH3alWUDhz3A6/tq+EztUvZNorv6QpQBZYQ1C2qxOeFjZrMjegCMw4hg/t2hnil6GF/wKqfXmjQ1GfkXOBGVNC5fSPEzG0XtVLkZv/sy580zuxZSG2kqTJuQzaRr4d6jv0I1SJ3ZeDbgDoPBjUA1DY3IYOjjnAU9d+U6oGm6gS0d3yiH2hE1/y8m+RVfdLfWVP3PQGbOMtlIGgC1HBmcaRrSIG91rApWB4MdjVZ5ppkQVRmHHjBsHEpQmKnfWgZguLPhzSLMdlU8HLNG5AyoSgK8pGGdwOUWmXFGot95S+fLOv59wGyslQn2IzZfLooqj7xGsYBbsEszergbQS2mL8oWYfbcyCuNrhNEgrlaKnCqQpTHowAXXckg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlpFV0c5R3JweDRmOWl2Nk5CT2s1VVk3cjNvMGZiYW5JcXlYYTl3NDM3RVBz?=
 =?utf-8?B?bnk2S1g1K1dlUWZSWTFlT1pkMEVyNTlkOVFReE1uL1d3YVZNeEdEdm9relF3?=
 =?utf-8?B?alVuM3FjMTlncDYrb0FEYmZYMDVKa3ZhUWROWlc2c1NKdjY2WSt4Tm5RN0xP?=
 =?utf-8?B?L0dqendtakNvUEkxZ1lITmVWaU5HV3oyVmZkSnZPdkl2djBpZisxSjA2QVNE?=
 =?utf-8?B?TGFiSjltbnBjTEh1djlRT3lqNE96Q3AxRkJnRzZMM2kva3Mxa0duRzJmMnJS?=
 =?utf-8?B?MitTMEVIbkNvOU52OGZBd2grQkRsOTI2SVVuMjVMbGkzRHY4eU9NckVkNlN6?=
 =?utf-8?B?M1pqQ0VIOEtxSHRsV0pXbndyaXc1dG5LZWhCcWtCS1NWSmxrdng3ZEhleTVC?=
 =?utf-8?B?Y2syTVBWVjcxQU9iT3lnMUNFMXB3R01MeU9uSGtBd3NVZmR4UnlvSzBLUm01?=
 =?utf-8?B?c2x3L21hdXR4eS85eDNpKytjbE5aZWpTR3VsTWJMaitFVnNhZFI0ZXNQa2dW?=
 =?utf-8?B?cXRZQVV5eFpVRFdBR1dOdTlFbW9NUUhLM1dQOTFnNWI1MWcrRVB3bnBsUGFy?=
 =?utf-8?B?OVdTaDFEeHFMR1JDZVNWSFBBbkNkdVErL2xuY2RUSDJPMWh3SjJIL0ZrRFNa?=
 =?utf-8?B?Slo0YnJINjh3WjB1a2ZaZGdhTDdEY1Q0dXhSejJ2aVR5TUxoRDFpNHlJd1da?=
 =?utf-8?B?OFllVGhzRURFVFdQNjQ1S2FDVjJlZDRYdlBXY2tLV04ySGJkQjl2R05xOU0y?=
 =?utf-8?B?c3JPd2lTWXc4VXRpSHVsa3g4VXFBNnRYNHRadHN6RjgyV2x1WGRJRWRxYW04?=
 =?utf-8?B?WUdOWjRka0NNTWZlOS90WndYTDFmeUZFaFFNUjdodmVXUlk4N0gwcDR5UHhT?=
 =?utf-8?B?TGtsSmp5VHA1TU9LSE9Td0d0MWQ4a3YrSjd2T0MyNytEMHR0bUdUdHNjVDJE?=
 =?utf-8?B?dkx0VVQ1NEE2VEZwMGtLN1hDNEV3eXIrSW1rVkNVbFpCRWc1WFpIR2t5UzI0?=
 =?utf-8?B?SWIxMisyOGg3T2I4aHdTbTRkVjgzWGpiNmFkOW1mYlBSNU9VOG5NS25uRGdw?=
 =?utf-8?B?UnhZdmNVczdkZVVnVGF1R3Z1ZVJFbU5wU1BwVllBVUtzeERXaWJlQlFwcEZa?=
 =?utf-8?B?dUMxRWVyWkkvOTlMeXovYi9XVlVHczdtbUVLZ1hlcWpzblNiTEtUSnlLeDBn?=
 =?utf-8?B?U1RlY1BTQjE3TUVnU0lyUFZSa2NpVFh2dWZpT1dzSFBNTWV0SzU4ZWlGaTZD?=
 =?utf-8?B?TDNGN2ZTYlBuUmFzelZTSnErT3N1eE11ZTdhOHlqdi9VSTdYcjdSSkp0Tlcx?=
 =?utf-8?B?dnFibkRodGxiOFRvR0V6UnhDTGhDb3Y0N3ZSUWxBM1hqTVdOeWVmWXQ3VWNK?=
 =?utf-8?B?TWJOeVlKMDVjVERTQzgyL25IMnlQQkk4NVNIVFZubUNnd0tGNHprS3phREpQ?=
 =?utf-8?B?NmtaaUgzUnk4bVZaN3o1SHFzSGJiNlVKdFk0WTZRV2xMNWFBblNUVnhpRFRO?=
 =?utf-8?B?Yis1cTNuNkRxZk56aTJpL0tnZjBJelpITHJ0MC9rU2NlVXM0VjVDaWhKeU02?=
 =?utf-8?B?bnlQdks2dDVjbloxZkJaclpMSWZVYUZIL2xvQWFzT1IzWi9veFpWcFZOa1ow?=
 =?utf-8?B?clNCckFkbmk4d2d5R2J0SzZOdTZBZjZYOHB3NlJzWHFVQ1EwUTdhT2d6N0NY?=
 =?utf-8?B?Y3M5T1dNRGlFTGEvNE9qaW5qd0tWZC91VjFTS1BYR3YxTTRCLzFEVkl6WHhs?=
 =?utf-8?Q?lz1iNUxE1ECMuiFMR6/BZ6UDwVT3fDH/mthBINY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541f44a5-ae35-465c-ca21-08dc57aba528
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 09:09:50.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7164

On 4/8/2024 3:31 PM, Krzysztof Kozlowski wrote:
> On Mon, 19 Feb 2024 23:05:25 +0800, Yang Xiwen wrote:
>> The patchset fixes some warnings reported by the kernel during boot.
>>
>> The cache size info is from Processor_Datasheet_v2XX.pdf [1], Section
>> 2.2.1 Master Processor.
>>
>> The cache line size and the set-associative info are from Cortex-A53
>> Documentation [2].
>>
>> [...]
> It's rc3 and almost one month after last ping/talk, so apparently these got
> lost. I'll take them, but let me know if this should go via different tree.


Thanks a lot. From my experience, i think this should go via HiSilicon's 
tree first(which stalls now), then go to SOC tree 
(git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git), finally in 
torvald's tree. This was the case for some qcom dts changes about 1yr ago.


>
>
> Applied, thanks!
>
> [1/3] arm64: dts: hi3798cv200: fix the size of GICR
>        https://git.kernel.org/krzk/linux-dt/c/428a575dc9038846ad259466d5ba109858c0a023
> [2/3] arm64: dts: hi3798cv200: add GICH, GICV register space and irq
>        https://git.kernel.org/krzk/linux-dt/c/f00a6b9644a5668e25ad9ca5aff53b6de4b0aaf6
> [3/3] arm64: dts: hi3798cv200: add cache info
>        https://git.kernel.org/krzk/linux-dt/c/c7a3ad884d1dc1302dcc3295baa18917180b8bec
>
> Best regards,


-- 
Regards,
Yang Xiwen


