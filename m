Return-Path: <linux-kernel+bounces-52170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C808494EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565B21F20FC0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5971011184;
	Mon,  5 Feb 2024 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CGNtXa/E"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2094.outbound.protection.outlook.com [40.92.103.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B810A2B;
	Mon,  5 Feb 2024 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119876; cv=fail; b=BsYDsNYoZ4cU9DzFjm+NssRtf5VTMioYkp2uRn3cwT+XRFErcn85kWl4p7R49C9+akyFoCD5hqXsC+N5K+pu0auXc0VK1t84+QwDrpMHNuN2I5rl2xGL2vXfQgMtaB7sq4tajNCYXsYiOtnKTvcqZr2zBmvH2sVVq6DdnFGHrJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119876; c=relaxed/simple;
	bh=xQ1ywWSWuWO4MHydMmPTJL4CEE9WVirYSHEgOwHtNxI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tmgsH3NBjdvSulcjzFeXu2VR6o4doQZfKfzcndQGuoZThl8q8i2Cibj5CH4F81hPr8v74GbK6ZCfUAiRLkxQaBo17Au9l4+hlGAR3mELcvbpMw7lI1MFvGWlvRDa693tTbjBUkkRlBfZnr8LNH5S6FhIf+Gopp2JVUDmh1op5Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CGNtXa/E; arc=fail smtp.client-ip=40.92.103.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuIDwXyhhGVcmRY79CW8kisHkQwkFsO2hBz6fKmouL7Q1/HWCy9NHQ9StITwskZnownmzT4h0b0oqDFpyAOezaDn8LXV7nZYOYw+U8jxuS5obiotEyo0jKSJt4D75eOR0jgsbaNj3hBScgBpyNcMacMu+Ho2eYNzM08Skvg2kRJjOB9CDPpByZYrD7GOTneCEjXatyUHDvgDdCdIuOaDXjXyVgP+V/EjShwKzxgRvrmKsJ0ojO94eV+3F9ZfIvGGmI1b0KAd73GGlpDDUcSRgMKhAs2qq7m2Cm6AWHG6jYAuQA9qbLAmWKfGip0XHse3QEvFmfdf84pfCwXLnRW2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C35Hy0xxuq0bWwI2Xy5ezxGeiUOKfMfjJ/K9TTdm+kI=;
 b=JRZys9aUYRi/TDRio0+fxcKU/Xl8vJf4ctMbqS/LzoMoMl+9N726WhdMt3hjzh3OSQIP92zuVAExXIqXACT9fcZ/byIv2Fp1SSp3H2C5ZmTnQhDNQ+IfN8S0wqXkKyZdTTnUpH0w1m405IT5oS7QEcv5wJxVh7q0dALxwOzsHbCnzOIk7egTkIU32yhUQLg526rT2Weehu5BjBn/nLa87PLdu8bzhS2Vdzp2P/aAOFy8r10sqJDieNTXVRljWQK6IlAHFh1yTrHcm53xr/IL27GcaGStFaU3ZwrXxt1vGd1E4AEuWL1F8oswhvKZCBBDOH5xd+qyHVk/9AB8cHdlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C35Hy0xxuq0bWwI2Xy5ezxGeiUOKfMfjJ/K9TTdm+kI=;
 b=CGNtXa/EDtx1Ut4Eib+VVpPS8GR514RqXRpIGn0B0tsUpbiHL658iIMkp/v0ULs823oNFHsxWx3bXpbvY1ew+hnzaHpulnCNeDEgupOpPWfJQcOXwdlwBaZ9v0tFMKMS6BK6sBFRmdQHGKFmzsa8XqZWyQbXWFs4TAaekL03FBJSCtJWP+LzNjXURwnbAP7kDnUoIqOI1uxWA4K6wDGGTZ/kOgvwG+sLD8XXnFvp8yjmHo52R7JEKyGga/H0IQ8WS4sXGUfSvtgvYVdnUNoRd4v4SeeiN2g3FQtVRmwbeq0+Cfnjn7HqV19T1wVgk4KRW4E4Wdh5O/+N2g+ZHES/qg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1210.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 07:57:46 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd%2]) with mapi id 15.20.7270.016; Mon, 5 Feb 2024
 07:57:46 +0000
Message-ID:
 <MA0P287MB282211AD3154AD3831F734BBFE472@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 5 Feb 2024 15:57:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] riscv: sophgo: add reset support for SG2042
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 chao.wei@sophgo.com, conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, p.zabel@pengutronix.de,
 robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com
References: <cover.1706577450.git.unicorn_wang@outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1706577450.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [e40KqZqvKLXw9A0bUsaDuiy/YxquFo+4]
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <eb3fa681-cf38-44b2-a65b-8be0c2691fb1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1210:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8de638-61fb-4dfd-0fd9-08dc262022bb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0/NnordNoQ5+Pb9Gq/vxj0Onbe9v/U/eEq7P+aQfdQw05ZYF7aKiOEGDlSBfQrTE7O5hNYIFf700aHg0CQeZucMhXjuBZJSpNGZN0eU4QAeU5bgZ6dl9fgsT/8NflAhDXMtcdF8TsCyr+hc5uxF2d4r7EH3Askw8yoQMVQ/qMBXXWY36YY6W7cQAtLouhkrfYtfJGmLIMdi7O2zx//8MJxbBTeK+PBtd2mM1Dd2wqEs9W6TmYaTNPU2/HhBM6MzMr7F0Qs8IH4DNH3iMGrCq6lRD2uoLfdmWi+B6LgXdjZfekZabjNCHHngzVxMSgj2tEvI6ZFU/wXZiBPHbMdo26dnH/oeebgePAESur5MReP7FdLsvXosW2Q/ub46CYcAkOfFIEfW+M8yBH1XcOX8TCnPjgxDpj+kEUGja4gZBqEltCPjTJpXgl0Knh6ak5ybzml3gCfvBLpZJPxDXVl6sbeLZbjy2VfJ45QhqLDTKuvUewqHhxOmYzsra5Rgu3pJuHX+C31hL026kZGKgdZ9hGZRUc+R0NwA6n+HlKcFavV9K8NV2/JGVZOqpMAwEncw5HLSoo2WUFRV+YzidlUW2yezojY/sStW8hutbxRmcC04=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm1IWDFMbWxQVS9JZ0tzdmJURytxV3FkVFYwL0EyS1JNRWlRK3dzYXg1dUVN?=
 =?utf-8?B?M3NicktrS2JIM0dEb21WQXVHZVB4bTNjR1dveVIxNVVVVWVicDlzaTZjU1li?=
 =?utf-8?B?cmtNZXJhVk9KZm5MU2R4a1JBdVExdXlnNk85YnY1eUxaclVFd1B0TVZFSFVI?=
 =?utf-8?B?dE5NYTd3ZDVIalM4WFZXb0d5UVl1N1EreW5CbGdjTnVQU0RGZU1WQ05SRC84?=
 =?utf-8?B?OWt3c3pjTW00amRmc3R3ZFNXZXJWOFpSWHk3MmpsWEc5UG54V1o0ZEZhanJh?=
 =?utf-8?B?eFJzaCt6dmdpYnAyaXYzOERNeGk4OVFvYk02TVlXc0NPdFN4ZVFCR1VNZlVP?=
 =?utf-8?B?MjlWWmtMdlBxR1NGLzgvcEUwenZ2anN4aDl0RER0MEVtaGViNnBOYldOMDUw?=
 =?utf-8?B?T1phTlFhUjNHV1RKUEFRODVUTUVkTWFGOUZ4eHZxUlhvRG5oVEZWS2NBaFFo?=
 =?utf-8?B?NnZXZUNlRnlZMzhaTFZvVDJlelhxaWJ6bytGb2h5Q0pVU1N2K2x0K1V1VHJl?=
 =?utf-8?B?c1MzTk83NnJ6U3ZtUUsyNlo0bUU0a1dUd0xUL1lpTlphYXdEb2hvWlllUmZm?=
 =?utf-8?B?c1pLcE5CRkE0M1NxdWtCclgyTnV6ZVY4b2NWdmlyd0dheVBnWWtHak5MQ1Vn?=
 =?utf-8?B?VEV1LzJzRExLcGtlaWxvZzZJOUtGby8vb3AyYVJoWHdyUDZQc1ZzTTF0NktD?=
 =?utf-8?B?TjJ3cG4zcXpVQStwSHlDeWxtRWNnZTlpRzBYK29JbmZzQ1FWRnpTVnRqRnVi?=
 =?utf-8?B?NXR0S0JsdDYyYlBrM2hEcE14N2EyZW1qK2FWV2ZqVGRxcDU0T1FiM2dDZURJ?=
 =?utf-8?B?dlpQbFc4aU5nRWl4MnVDNFhjZ2JjK3lTMHkxcGlydW5tc0lRUWxLVG4rUVZK?=
 =?utf-8?B?RHN2cXBhQ1drTFhhVkZLSzA1Q1FCZWtjWitvVHBodTdjVWkxdGpJSkowZ2pp?=
 =?utf-8?B?U21NVnVvMVNMaVZ1V2Z2Z0NsYTFtWnZScWdpS3dJbi94ejFkREd2L3ZmUlpw?=
 =?utf-8?B?cnlGRmRXMXJTT2NnUTVOQ0pQdDNQbk5vNnc2UVZpU0ZRRGszbW5Ya21NaUlU?=
 =?utf-8?B?aFMzeml6OVBpcHlrWVZZTlBFOUw4QllaK3VIRHkwRGNGaEFtVW8zNUlnQUhq?=
 =?utf-8?B?WFU5N05GaXorckdqdUNHRHJUSTlGRFRqQW5oN0FkQ0t6NjZJL3ZWcndkL2JI?=
 =?utf-8?B?UHpSNXZscUV3THZhOFJleTAvNzNJOWp0OU9GVlpYUE1xT25GV2tjQy9kUjcy?=
 =?utf-8?B?SW5VQ3BKSlVaM0NpTFBRWHlTNWx2KzYwMnRTUzROR3daS0FmV2J5bG9jZmJB?=
 =?utf-8?B?dEZpWmt2bkJXOG1ZYXBTQVhXd1VSdDJyYm9SWDRCdzRqZk5WT3BNUG5HSzB2?=
 =?utf-8?B?U3YvbWQvVnhXZCs2UFN0S2lRMlZVMCtDYStsV01Sa0hhOU1aSUlXR083R0Ew?=
 =?utf-8?B?WU9XR3E1azZuYTdHU00vdzBwSU11SHV2SlU2dlp5Rm9teDhHWXl1Zm5mOHBp?=
 =?utf-8?B?Nm90aGdxSXg0NWNZYkV6dGx2V0M4WUNRRS9sVmNOb2xvS3dvK3gzTWJBR2o4?=
 =?utf-8?B?bXJJZXVJeXY2SGtld09RaWpYYUxERG9NZHZRR0U5b2Z3L1BDMGRzb2ZHTEMr?=
 =?utf-8?Q?Qi3PlsVmNGIJxQDdn94VIpMldaQ8eSib+TCRMEa4I4o0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8de638-61fb-4dfd-0fd9-08dc262022bb
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 07:57:46.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1210

ping ~~~

On 2024/1/30 9:49, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> This series adds reset controller support for Sophgo SG2042 using
> reset-simple driver.
>
> Thanks,
> Chen
>
> ---
>
> Changes in v3:
>    This patch series is based on v6.8-rc2, which has included the missed patch I
>    mentioned in v2.
>    - As suggested by Philipp, drop the Kconfig for SG2042, just add a default
>      y if ARCH_SOPHGO to RESET_SIMPLE.

hello,  Philipp,

Can you please have a look of this, I have fixed the issue you raised in 
last version, any question please feel free let me know.

Thanks,

Chen


>
> Changes in v2:
>    This patch series is based on v6.8-rc1. You can simply review or test the
>    patches at the link [3].
>    - fixed some minor formatting issues.
>    Note that if you need to pass dtb check, you need to apply a patch. This
>    patch is missing in v6.8-rc1. For details, please see [2].
>
> Changes in v1:
>    The patch series is based on v6.7. You can simply review or test the
>    patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/cover.1704790558.git.unicorn_wang@outlook.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/MA0P287MB28228572C526C5099A8BDA2DFE7B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM/T/#u [2]
> Link: https://lore.kernel.org/linux-riscv/cover.1706161530.git.unicorn_wang@outlook.com/ [3]
>
> ---
>
> Chen Wang (4):
>    dt-bindings: reset: sophgo: support SG2042
>    reset: simple: add support for Sophgo SG2042
>    riscv: dts: add reset generator for Sophgo SG2042 SoC
>    riscv: dts: add resets property for uart node
>
>   .../bindings/reset/sophgo,sg2042-reset.yaml   | 35 ++++++++
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  9 ++
>   drivers/reset/Kconfig                         |  3 +-
>   drivers/reset/reset-simple.c                  |  2 +
>   .../dt-bindings/reset/sophgo,sg2042-reset.h   | 87 +++++++++++++++++++
>   5 files changed, 135 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
>   create mode 100644 include/dt-bindings/reset/sophgo,sg2042-reset.h
>
>
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3

