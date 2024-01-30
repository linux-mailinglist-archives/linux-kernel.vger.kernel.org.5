Return-Path: <linux-kernel+bounces-43773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C78418BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9552849AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45F1364B1;
	Tue, 30 Jan 2024 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eGcDTNnE"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2047.outbound.protection.outlook.com [40.92.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D474636135
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580236; cv=fail; b=uE7cH84Wa42Ut97MQ63LEzPpBvarRcrypjncQYSljklpXeplUSiIJuJ+P/N3LduBGveGdMr/Oa2W0GsuEgoEwxj5rUIC6aYu41Wf7p2l/oQ3kOj5BhRAbTJlo8t/EfQBDmD3tdZC3lbWg7VUu2Uhu6SFs2ukXxGHS92oia6P61I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580236; c=relaxed/simple;
	bh=2d9yZc9jVQnASft++YhVR/VBdqPTnK+3dXdmCRx049Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qGTBSLq1giDeRF1oBwH6aKIE6aD+xFZ6Zx1GPfglIBRBy1v2iFuxtTev+JBmflcwAHZYqjofC6hX9Cc9IV/A9bsGw4u3HcFtXT2u67hRHafH23xEUgtnWhUAh1JA8K9CDVsF2T5zE+NViuadfkAY/nVnu/JVmMnSAF9k9GmbNGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eGcDTNnE; arc=fail smtp.client-ip=40.92.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KR342nWCGFm9rztKgpW1fZPx8llD98xKQX1Kk0DNK5U+HgYLtg/2RVSsoD1Q+xLcZ/vkeWux1GkALguUHNjYp6caWA5w+113OiuNnC+/ijpblZ5qobn/4H/0iawXBdbefNZ7qAVsyIMJcPnMbCcX5Rbf7DJ7Zz058H4gs0iXPyrIXErRAAZYg6bTGmqhuZvFt70S+rHuDO9hh0A9vgmV8Wob9Ve1KdaFN+7hMU49mJ78ZrlnZKPNzKhWDq6+2Rvkm18eVGc+A4O/C46IrRckcgd48z9GZnAxO7cx1zlZmxcrbeA9qhM0gMDg4iK43Q8vSINb4RDOmYl/ts4CcDzyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p84nPNepMAkehopK6D4QGDgTw+RsF8fP+0qg2naV93E=;
 b=UIVUqS4PhYTJ87uZ2+Ym31fkIkeJBqfVqv8U2Cew96/uG+9eTSBetFIAxHVJOthKjMsklTjgWJKlIP/UclbjPYMrxdKrwemVJM2emJhLRVqgEaAwQWX63i2KV+iz9qUQFzcHKKWf9EMAja9Qw2abUumX1HyG44OQj0WbNQDt0tYKD1a3Sm6YKIJFiLz7SC9eOUXqbZ9B6s0yOYtjxNa3A8nCQOzAFEHywX+p1cotSdqWxLvmvzRGdHW5yym5HWQBSiFbLuyIbUiXvsAaqtaepwq4iNdzTuE1znP+vApTiYVtwIQNiElwIGlSE3lmeBiyeG1EzoUE51ZJwDOYHCx9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p84nPNepMAkehopK6D4QGDgTw+RsF8fP+0qg2naV93E=;
 b=eGcDTNnEHZAMaWsgOssriTWti7g+kGr8obkAH3LCPGtZ4Ko+WjReVWyefr/s9J4RAiWbyAGu2nY5/octgtR9j8hPe05EB6WERJbrv+W7e8mmpuu4RGejRYcRpWG5D22qt2Rp8e1qVG+AI7BdDRLYxRwuv0qjWuo7RORSCIymvyuQPG+yuXIkTr6OOtG2lkn43j8Nqnbph1OeKpDCbVdSCsjjOOrN/eMViDtj8xQOJD5d0QuxEPqCcvTAknNHi8Oe8JhnRhhYt4AI0/wMKgZZOkEHf7cb//ddVg8VAqgnrxfS9FB1+aFJfCsPDXXkDnXKddpqr04wc4yoQaAK3NiWxQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1174.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:182::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 02:03:50 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd%2]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 02:03:50 +0000
Message-ID:
 <MA0P287MB282258D1CA8D04F8FECBC040FE7D2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 30 Jan 2024 10:03:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: Setup proper info for SOPHGO vendor
 support
To: Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Chao Wei <chao.wei@sophgo.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [3PwVAqA8P2jHBiTE0g9mYY/B3hw1YClc]
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <a3412341-a446-4ad3-8fb7-587c2fe4faf7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1174:EE_
X-MS-Office365-Filtering-Correlation-Id: ee90f503-8256-4109-4af8-08dc2137b29b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iAAt3WuRhSUxhjBtMy1+XA3IwD7841K+7jm3vS9htn77vc0pNxj2jBgakPTwfb6tw4ARNzxUmVGPDhr1xxRGbOnOWyIC/lOX+VQF1NXOfh2Lx4mBJGD6tK+oxOsBZuVttHLRCBbMxgh9dhb9XZ3lWgQHARWX2gYDdxpQeLgwbQabt09Vd/vMQgc1jiu46YakrnQ6Q5QVs/7HRwIpSf9qAVzDl3vzKTDJ09h1lAtU2NTXJudy7YzIuO3uXp2uJpzy1poFoTagJ4NZh5sPgsgUjHYwsNSwM786u/IxVuEZZXLnWmGAB2gN15ayWZRhpQ8wV/uVcKB4CjDJML7UkbhLKBJSRy+fKJmuTjN4Kxmo9QH/TajsAs5PGia2CKULr4nKAJB0cP+xuEhB0alTvYZ+OSHw/7TySCBPMiMuBBuif5fO1Ai3wHnh2ZTeakQUoQMUfIJn6fu5mwiud/GTOH04CXtZtQ41YsnO0xEeNbCNRf/thI2NGZNVL+9VHnwqxjWsRg9BZ7NDISnaPP89BnbpQwe4r1lsIxrZkJC33gegXOWlJAzmZV70NpG9lDozfpv0JM1PxYFUbBKSCNZbg8D8R8dHT+8gmAaKUS/rN7Bjb+E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2tGT2x0WS83ejBvVkJyb2NjNmUzS2lnTEJEZlJMMGtJcUpzbU5IeXZpQmN2?=
 =?utf-8?B?RG5oK3pGSlNEL1FuaXlVV096NlRLQkNCWk9OdHVLTEtKS3M4dEc1TmN4cmZB?=
 =?utf-8?B?ZDcyYTV4bkt1M2pCck5yWDlEYzdFYldTU01nLzdqOHA0dm9XZ0p6Rko4a1I4?=
 =?utf-8?B?dXZhRDVQU21FRHZrY2xxNHIwbm1pQWlIbnFyQ3JoZnc4VlNFZnBoOEYxdDRQ?=
 =?utf-8?B?b1BPMHpZQ0kzRzRmZ2xzVUw2MDFVd0ZWdTBXMTVtejJ1aWpKeWw0T1haa2dv?=
 =?utf-8?B?UGZoWFpRTFk4MkFtWVAyV2p5bUJXSkJ5cStzVWlwbHpiWXNpTGNWVkgyb0xD?=
 =?utf-8?B?MlhHbzN0K1FMWkVkeG92eDlpN1l3aXlMQzZ4dEJsM292MHg2MXVYU3RUNnBz?=
 =?utf-8?B?YWNISHE4VmZ6NUhHM3lveXFSSnJSR3BPN0hvL04vbTBWdGN4aUN6NWZqZTZi?=
 =?utf-8?B?QmFSWGZacUlqd3FrTzVsNGpZYnJKTk12R25rYnV6T1JnZDhhQWpwaTVRcFJj?=
 =?utf-8?B?U1NUVFJyRHFxdXV2VWJxM3p5aTB0dm9pMU9hNXNrVXVFRXlMRUozQ0RuUVI1?=
 =?utf-8?B?Wm44TTR1MGNLeG1pdzNvSVpNUkR5RkxVNHFDV3M5bnovN3RQbXBwcW5XMDV0?=
 =?utf-8?B?L1BtVGNiWWJDNm9DWUh6KytvSEFpTkM4VncxNVdXTXQ0K1VlVzgrOWluRXhm?=
 =?utf-8?B?WXdNZUw2Vjd3MXAybHk2Tloxc1dNbW55RXpYTVZ1alpZQm9QeGlkS0lwcmFZ?=
 =?utf-8?B?MnB5NHVMWXhVMXBsb05ZVnJYVlFiMTV5bUhwTWw1QmZIK2UyWHdRTjZTUThx?=
 =?utf-8?B?MnlDNUJXY1RWMll5Nk9wSVYxMHFxZ3JPNWpEcmYwVXdWdmlMcXF0NFk3QTlQ?=
 =?utf-8?B?QXJlQVhGRDNlY056dWk2WUQxc3pKQmdOSmJiZW9SQWJhNVFIZTkwbUZrVzdq?=
 =?utf-8?B?eUt4VUkrWTFHZFVoTlg2QTQzQlRQZ3ZBYS9sMWk2enZMWVlVYm5MbnRSOHkw?=
 =?utf-8?B?YkRvZXArUlFGeUU5ZkJaNE5IYVFPT3BCeUJBbmxkeHpqSnd2RXQvekc1TW5U?=
 =?utf-8?B?cFNCRGpPcGRIeHplV3VqelJ5dHdPSXBaNHFDS0lCMTJrZnJCTWV1RXR4aE1Q?=
 =?utf-8?B?MDl2UXFhQTdialZIRkdjSEVLMFlsaWd1RzhoOS9RNmxiaEdYK2x5TTFiRFFX?=
 =?utf-8?B?UXkvVXl5Ty9QQ3ZRTm5TbDA1ZlR4WjI1K2tObjVNQXRRME1IRm9QVTUwQzBG?=
 =?utf-8?B?YzZTMmVqaVRNL29VWU1OZE9pUmMxUE5tSkNXRFZlejZaZ1ozaDNBY3lwdndC?=
 =?utf-8?B?WXRvUGt2YW8zYTcxT3NGcnVSOGs2OWdiUkxPS3NkcEROK24xbk9Wa2lmZm5o?=
 =?utf-8?B?V0VNQVVrbUNnNDUvek96RHBaaS9ZSU5FN1phbzVOSHdtUkRuR0FxU3NYM0cv?=
 =?utf-8?B?dXgyTkRsWlJHc1k0ZTNYMHVINDRrTHVjQmJxTUNhZWRDZDZtUUNXWkVBTzFj?=
 =?utf-8?B?SW0yYWQ4S1VWT0hmNnJ1RUpXTFVvVkpZWlFIV2VaSnQzQjBXMDE2ajUyNC8v?=
 =?utf-8?B?V3UvVGsxUlhLc1RKL0phMTZFVWlucnNSOHFjYU1UZCsxblF5REF4dGRPd1o5?=
 =?utf-8?Q?xrbeSZ1zKNuI27gFghJTq7lhi1O/A6oKVhHIDhL8e5Sc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee90f503-8256-4109-4af8-08dc2137b29b
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 02:03:49.8427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1174


On 2024/1/30 9:40, Inochi Amaoto wrote:
> Add git tree that maintaines sophgo vendor code.
> Also replace Chao Wei with myself, since he does not have enough time.
> Since sophgo vendor code is maintained, remove itself from
> `RISC-V MISC SOC`
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Acked-by: Chao Wei <chao.wei@sophgo.com>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen

> ---
>   MAINTAINERS | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39219b144c23..125debc7d755 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18848,6 +18848,7 @@ F:	Documentation/devicetree/bindings/riscv/
>   F:	arch/riscv/boot/dts/
>   X:	arch/riscv/boot/dts/allwinner/
>   X:	arch/riscv/boot/dts/renesas/
> +X:	arch/riscv/boot/dts/sophgo/
>
>   RISC-V PMU DRIVERS
>   M:	Atish Patra <atishp@atishpatra.org>
> @@ -20446,12 +20447,13 @@ F:	drivers/char/sonypi.c
>   F:	drivers/platform/x86/sony-laptop.c
>   F:	include/linux/sony-laptop.h
>
> -SOPHGO DEVICETREES
> -M:	Chao Wei <chao.wei@sophgo.com>
> +SOPHGO DEVICETREES and DRIVERS
>   M:	Chen Wang <unicorn_wang@outlook.com>
> +M:	Inochi Amaoto <inochiama@outlook.com>
> +T:	git https://github.com/sophgo/linux.git
>   S:	Maintained
> -F:	arch/riscv/boot/dts/sophgo/
> -F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
> +N:	sophgo
> +K:	sophgo
>
>   SOUND
>   M:	Jaroslav Kysela <perex@perex.cz>
> --
> 2.43.0
>

