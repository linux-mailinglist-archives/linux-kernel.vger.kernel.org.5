Return-Path: <linux-kernel+bounces-100165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C2B8792D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7291F212D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9042079DC3;
	Tue, 12 Mar 2024 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PnsnQ+TP"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2035.outbound.protection.outlook.com [40.92.53.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8974879B91;
	Tue, 12 Mar 2024 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242393; cv=fail; b=cEtbNgr145cXwZgkYxogAf32gbvzMBQ36OVLtw11z4l3Z1ItrWRcwjzKnk/Aj2pXNWnmEp+x3BoZzOlvEfIL3O1IL/ubNTa0Q/YK3+kfrxbwLTBK/MpGNBP8IIItmfoE5vUDenlxYP93y0QTvdUAxtRVfYxfHIokA0EH6JX1QLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242393; c=relaxed/simple;
	bh=ViWP+GzhJi5tp7n6538jc5mz76Bk80ZEBX9POYWiGCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qVcy6v8PJXZdYSYbAserOoVIMJFGhxvW6Uawh7B68ipTtTHDb7rr2gdXsPB1A1pc+4aphYEkjeLvxyG9GCFICY3vjTEJBUCIaxduc8Kwjxq12RBZlplkerKiKxRQkiHJFALVnCVRXPBXvBB47wp8znsBRNdRAFSZADH4KrQEufY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PnsnQ+TP; arc=fail smtp.client-ip=40.92.53.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsUPx3LsyP6hGjqGGDA1uuueJcDUkpFqVEnI2cFGLF68t6Pk4vJ772pxRUZ2GVdZO/bnEZeYBDd2jGV+OmxmDTNOTMuiZcDZYaqj/YZ6mF3E2rdmi2o23XB2j64bGm5p+j5fxG4bYmJaFbLU4mCGsXYBaBZSWq3N+LY9ReJwhmHtEV2I+35fEJJ1K+A0+nT2FR4PcpegwE7xKP2MRF3FLvAFDtG8fKmb80HnLwSPS6vHgUVaxnFHmefOU/iw9HWSbT++q/zAJMV4PnaFYaNNOuzIXANvmFF6fQPCmofy8S5JFvjMkBjhMFBxElVmtFNCT03gKY0XojdeQAe8sMHOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pd4H4LhF8d2P8bdCjIywxHrNhUxr2m2e88BQxFTsUO0=;
 b=F/rZrhYqEtb0QQF3YADQHxgJXBlqztWDpZk1l/CvIj1+qPDc9WyqESw7NyNthnZzvW/5LGeGcrN0j5urV2JRy1uQV8EFxGX1vFIS0rpuEwcK7HQ+uiQPf3m7xPTa7s2JZjzISqIJr5v5G2NANWnCO+4clht4pF2SvwRqMr7+DKGtT421Znb3ZmHbAouRLdZWDD1cHasM9nrqFxsc+eMjme7j3/tm48lSI1OFwyd3GxvnOd1xASrWfpVAjsJIS5WLZJeAgQUHJROSjsXm3jzlyQaa8q52tRNaz0PCOequdiDjYHB+51GQJ6pjQQXoOPZ0GtE2gQTcu3rMTRITV9Cn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd4H4LhF8d2P8bdCjIywxHrNhUxr2m2e88BQxFTsUO0=;
 b=PnsnQ+TPaepsCuUSdy3NW8S/c/OJxNiUdlgkClsYbLRGhIC1yuihBjO57YRk4GHTDXfWQGcSrwaqPnv+8uJ+Yn5dLQbSVSgMptyAatCbkWLelV+/hef/W3phSoJ5VyOkV7b7+/RgV+72P44U0phnq75lehILx7NNNyQUrWg6XXBTuTEGZacfowydEPujvsia/msQijCJjJo41HNR69Ou0UEno3YEjNyB0yV4U+6b8KWGC+hYYcEfyeXwxzZVeSvmzukpKLI8MvnKSMILbiISnUpQ+4MUW8yu8UYwnWTnUOAGNZYVBS/PRcSvXkTFYFKP5XyHHECfDaw0PAdGKcdslw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by PUZPR06MB6145.apcprd06.prod.outlook.com (2603:1096:301:11a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 11:19:46 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 11:19:46 +0000
Message-ID:
 <SEZPR06MB695952078B51C4549191F8AB962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 12 Mar 2024 19:19:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] arm64: dts: hi3798cv200: fix GICR size, add cache
 info, maintenance irq and GICH, GICV spaces
Content-Language: en-US
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [Bu/zXJ3Uaajk9qpUkZKcFgg5d0Zs91JnAvfX5w9RmSlInlMrhoRfh/b+pvA8nYNs]
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <97639ac1-ab7a-4c55-9245-1814fc0ed885@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|PUZPR06MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cfe8548-e4c9-46b5-0729-08dc4286529d
X-MS-Exchange-SLBlob-MailProps:
	f3ElpFvzDvYAMeNa7EA2e7b34de8LVcfJdQ1GT/QTwTTyOCrl1X3oKHldUSwSBnj7YFtU7Ez80nicOE7s2HbmXxJ9HHlkyBlND1hTM2nTTWy3ZFUENvkC6QzKCxLOiweMUGG4TZ29qqv5vKel5kGZBTmykJiDtnYPvVMJiBNFc4n1GrBdwDpv/xKFt5HonYuD/t8CH0gj3T/ec0RCGFkEV91elchvAlKHycGXIoaUbU3z8xxwPCx9CNVWeI/04Xxqvigt66WzNeQvAqlC/z/bsbJjWKDVENIuI4T0QP6Qgzb4398Q1z3FckkHMlaltS1OIRcLVXAiFafMsBR5tZbAgiBBxa3CJlibaMpxoVV0cwqWVVwLDC7MBLOxACGOJO9aqrrPnXig97cMutYXUSrKdgynPo+6CuaQCo8uZ6qxhwy/FuhVQWRp6O8vCWrNmi8ymrqF+dz25R1zMYrXLTMzATpUz4bKl9wcWqA13zoPSWCD51I1si4jwzeVTejgifB0xeOpSHZgi4CUvjfOCV1cdm3bSVz4ni48tYj40AKAXkQ4X2MXLiKzGEYxJhSvI+uIWAfQMywAu4gMedtwUn08lkIIBA16IsKEI1iGNRqt4UimtWIdmhKOhpqUUf1Rb+6VhRpsofyxBiIiob+ZIAc4pjYiRgjoEwp5XeYTu5EvsSDX2Ark3HP2JGmh2T9KXnHtjHC+PtVYTj7mmafjChH9ZZhfhJNFn7jL5PGpeteYZEZu+OSo6KC+tU4RSl0aze6snUUo/vkGGc3uzuk1bu3Q4w/LA4rUxE9ERXKYcSeWJmzv0Rq0qRbgSEpZYtXHzIefdvloKQFmoWuh9pA83y0ilQHhLWtSsYJ6rjTQesszluUUUgwhHk1Khk9nQag9LdP8vYU1h3upAY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P5zI4/P9x5o78y5St8FecdjMSbuDxVGZU0Z7caYJTO1n6gYzB5GG3o9+kzs/d0rY9k5B8JrjmtH8PpsxajhqJmQR+1VJI+XHwn8u0dlmYZl7u8SetN9gX3XA1pJSYmqJrBEJaRns+ROhOlpi1aqGQz4aBOwK89WsNX24G+yhPzhq4W1FOu+tf9q40n9XIEIGQ0gqvZY0+OU+IKpnyFWd53FdwLV0GEE7qjopgbnzalDx3E6i9buUwgcpqN0rQhgjMfL9SyfgqKi2M13ZDa/HKGZ/9qlJSC3BWScyMwFuB1L3DTbH3ZgEh9Ba8/3CWQbfNyacfLE523lQuBBAgoPd+M5DTs2S3mo5K1rlQyrK+i9X+BzNH2PlOrq/klFpfb1Rp1n4TMZUoFh1uN3SSuKESz8mkbuDqrjf8AiRtROaG80adFSr1A2ZikvmAkmNTxFGinzqDnLljwhE3v5LS+IIErMmKrSPNfgjYtBN34f5tynuplBu0nEno/i4/68pVQ/bSCGWNlMIK01XIlShFk1fp4gggw7wp/7abHNo7b34XfCe0h1+nynPoe4usoBfTKwep0V0mQxoKSN7lNLEGlRDz23W2pebImIjfqoBsVaWn9P3hat8CI4vKBiFgY9lj+MenKzBQtTHmvSe7HApsw3CXae43vUDfkaO7bDR44i4s60=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXVISGZWZmtNbW83UU0vU292K0VnWGE5cFNOMmUzcm1kSCt1VkhRbGVES2c2?=
 =?utf-8?B?UCtSTCtPa2NJanNQTFAvUDFHS2xUTVFwcGlHUGVmdkJaaEROc0pLaEZ2ZTU5?=
 =?utf-8?B?Um1JN3BqbU1KNEZxczU0UlJ1ZXB0TE4zWUJ2bXY5TTI4WkpkZGRaNnpUZlJl?=
 =?utf-8?B?eThIWFZwN0E0TDVwYW1uckkvL0ZwRlRBa2dHOTJac01VVERXWEc5cUR0R0lu?=
 =?utf-8?B?b2hWWVdDSHBGMGk1YnhyT3drOWZKRFBaaFE3Y0lZak9BTVlTQXJrdE95VWw5?=
 =?utf-8?B?RGJPVzAxa0tPQ0FHcjZBUk5hT1lKNG9jSm1LTkIxOGRRcFJOM0g1akFYUDBS?=
 =?utf-8?B?SGx3SUp2L2xNVHVicjlodHZZeVpXb0RoZElwVlQ3SzJ4MzJqNVp5aTFBNHFV?=
 =?utf-8?B?UVh2NFB4ZTZZNGU2Vi9NVHZBR2dmdDA3U1dpTU5ReUpDY0MzNmYvTXVTaXlO?=
 =?utf-8?B?Uk10QUV3UUg4SzhsMVNIZ3lSNFhWNFA2NDFHRW5IRCtzaE1WY2UvWmlhR3lL?=
 =?utf-8?B?Z2RpV0tva2JJQStCcEQyaU1DQzhKdk4zVjZiQ0k3WEdldGpnOUtSUSs5a3Uz?=
 =?utf-8?B?VDhXWTR6N29ObVBSajVJSkE3VFVLMnNqTEgxRVVhSlViSFJtVGpRT0FjRFlI?=
 =?utf-8?B?ZkZsUy9JbTY3TWFLbFZhOS9FSXRJc01ST084b3VmYk00N1lVSVRXTWJOcUY3?=
 =?utf-8?B?U0VlSlhCK2JjazZKVEZObUl0V01LRUxGN2Uvb0pCNlEvS1VHbTRRMmxhQ0ZR?=
 =?utf-8?B?cHhhS1E5NFhJRlVQbXJGWU8vVzZKZTVOckFJMHdWVEVTN2dCZy9ieHhpQ0xU?=
 =?utf-8?B?dE82eEZTR2R1bW5CUjNMWkNrUGVnZi9LRkRtTTNRR0x0QkpzYUNheWNLUDJs?=
 =?utf-8?B?emJEZkhpcXkvZ1JIc0Znc2NlSlBVNGFCWUZucEo0RHBXRklpOGVqQnNCdUM4?=
 =?utf-8?B?b2tkZVBVRnluSjVTaTBlaHR4d09XYTI1bzYxVDNlRDFNbm54d1pWdjltQUMy?=
 =?utf-8?B?OEJFVURyRnMxVmlGTjRWTDJIcGdlRngyS2NYU3dSRW9hU1BPUFNFVnIxQWlx?=
 =?utf-8?B?VVZlWEpBVXhaZFcvOXBNTEdwVkJXVHhMUTk4TFl3QnlyK3FpNlltUlpWYzdx?=
 =?utf-8?B?VUgyU3RjaWdKNENsTWo5TmtTaU16Q3lLUFZ6WExybFFRMU5KOEx1NVlmaExh?=
 =?utf-8?B?bVlrNEE5WExuczlyUmFnTDRVbm1sOGExRnZGdGxUSVNIcm5PRUlQYmZWMGxn?=
 =?utf-8?B?WklzSmQwcVRCMmhlbE5OMnhrTlpObUM3c3B4RG9taUVXSjBac24vdWZBWnpu?=
 =?utf-8?B?b29xNys4UVA0K3VCMkI2SDdHeDhZTkhiUzZEdGZCMWlYNi9xWC9Jb1BNZmQ3?=
 =?utf-8?B?SFVmWmNiMWhOU1E5N0Y3U3NwNUVnSGJ3bm1PTnREU3dIY2JXaW82d3JPMUZU?=
 =?utf-8?B?U3Zra3VGTXRmN1FNclhEZUNkZzd2TUR0M0drbEY1K1lCbHhIWUlXVUUzQmNp?=
 =?utf-8?B?SW1iS054NjFhOThTQm1ta1M4T3ZGcjIvdjVwdmx3R0hsS3VFN3RyU0dGYmRD?=
 =?utf-8?B?akZkeUtWS1NGQ01JMS9UWDR5azJnZkF2WHV0Kzl5ZGVVN2dQT0dJck1sRmJQ?=
 =?utf-8?B?d2JjYkdYejRhbVJYVkhKcW44UjR3ZHRIWHRvSHd5aTdGRUFHbmFsUkV1WHlG?=
 =?utf-8?B?WWJGUHYwdWpMcUhJOWlGMWhxalhFSjE2cWtsM0tLOGZMY0c4d201aXVEK0FL?=
 =?utf-8?Q?0TFn7eEOXXNjoyru4ipGd7saF1Gd1FPqZUYidqz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfe8548-e4c9-46b5-0729-08dc4286529d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 11:19:46.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6145

On 2/19/2024 11:05 PM, Yang Xiwen via B4 Relay wrote:
> The patchset fixes some warnings reported by the kernel during boot.
>
> The cache size info is from Processor_Datasheet_v2XX.pdf [1], Section
> 2.2.1 Master Processor.
>
> The cache line size and the set-associative info are from Cortex-A53
> Documentation [2].
>
>  From the doc, it can be concluded that L1 i-cache is 4-way assoc, L1
> d-cache is 2-way assoc and L2 cache is 16-way assoc. Calculate the dts
> props accordingly.
>
> Also, to use KVM's VGIC code, GICH, GICV registers spaces and maintenance
> IRQ are added to the dts with verification.
>
> [1]: https://github.com/96boards/documentation/blob/master/enterprise/poplar/hardware-docs/Processor_Datasheet_v2XX.pdf
> [2]: https://developer.arm.com/documentation/ddi0500/j/Level-1-Memory-System
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> Changes in v3:
> - send patches to stable (Andrew Lunn)
> - rewrite the commit logs more formally (Andrew Lunn)
> - rename l2-cache0 to l2-cache (Krzysztof Kozlowski)
> - Link to v2: https://lore.kernel.org/r/20240218-cache-v2-0-1fd919e2bd3e@outlook.com
>
> Changes in v2:
> - arm64: dts: hi3798cv200: add GICH, GICV register spces and
>    maintainance IRQ.
> - Link to v1: https://lore.kernel.org/r/20240218-cache-v1-0-2c0a8a4472e7@outlook.com
>
> ---
> Yang Xiwen (3):
>        arm64: dts: hi3798cv200: fix the size of GICR
>        arm64: dts: hi3798cv200: add GICH, GICV register space and irq
>        arm64: dts: hi3798cv200: add cache info
>
>   arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 43 +++++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)
> ---
> base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
> change-id: 20240218-cache-11c8bf7566c2
>
> Best regards,

May someone apply this patchset to their tree so that it can land in 
stable at the end? This is a fix, not adding new functionalities. It's 
been 2 weeks already.

-- 
Regards,
Yang Xiwen


