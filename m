Return-Path: <linux-kernel+bounces-77103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AA586013C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B039D1F215DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10EB1448F4;
	Thu, 22 Feb 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Qz5IDs0z"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2069.outbound.protection.outlook.com [40.92.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA761448CB;
	Thu, 22 Feb 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625737; cv=fail; b=AVGqaAyC2XnrLLgdfHCJlubxpIJyLG3P3PSUIBKSo4ayZLgs+ITKGpmMHiVZK7s1NnnSYYb9y8gNuqFDx9LJltAnvo/UxIQTX3K/tZQ9mYC9zdU2tzzHPtElK71eB+Q5d3WBWX+WXdRMFkfOTHdGxCmPoVhTWagy2lIuZ/VYDkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625737; c=relaxed/simple;
	bh=qybkxXc/zNovkeChxEZDLezSG7oTzyI4HkOQJ/PO0fo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NXg8uM0EMuuQwBunrhxNm6ZGmp4rvqWHALEPHM8N9npFwVpYpxZGIBvIemhc/kdsn6z8fW9m0Z25mQPwS+iDxGdx5CE4NKhuSlj3kyl1ZIZg5W9PoBotimdtxmt9rEV9agEaLdBElB28TNF1VE+k9n+jNyIM1PW2sByOyYWmqBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Qz5IDs0z; arc=fail smtp.client-ip=40.92.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pst8mm8Crt7ZXwE1wqN1XCtDiF7WNrrhKE3VzjI3xGPt8XhUqZ+c3hKviDFXJQ/uAY8TAaPhWCgn5H9bmZrjQSCMuPMo8zlQ0TddJou9QF2LByqU3mGKFwTIbkZANqcWSJp5BbCwhetlbv1V5yVwpsMJ6XcLnTwzDAGhT7Cq5lkbBtga/fzGTztvYz56y+ZeTfnAK+rQP17kZhaSH3TF00CKElUOz/DRsJnBLbHKOqsdjyUVKGJ5wzML0y2mHG6txrbKVCZ5dkYrEGkfWFex1FPcJPDvltXtQuB8y1sjWijezP5GLCYkBKzQsIEermiWZKCljtsstrFIv4rGorze0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Q8gnubOscRY5yozhCVy0MRZs6j4aABYQjLR3AesQ5k=;
 b=QTQluXBa3iV9g8+LP5IqxRM/ZerRHpqUcGjnE8jUJ4rxvvvBiKkDlEgLSHdBPbvin4IUS+00KwdzVsGglGECP/fO+vgKAfFrkqcOF/wXjyVJSfN1ksgSpXc1A9Gdd+E4oKpR5HDW8PbvIM83c+v+mNZKyHospNBm7F1W/IE81IXktYYQ/3ejfMxsqIQl2+zf8lTq+K5DfQH2Icc6RQzDjUW2l8gp3yVHIGhf8c/bmc07zwOWZOBYMyhhZrMkRT3OycIUpDneFH8wKwWvBGvbcjqL7F/E+uHOJlC2bUy6ltG3Tw8NVMFzSzVRtdPD0MRh2t5u8haiPRmidUu3xrvVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q8gnubOscRY5yozhCVy0MRZs6j4aABYQjLR3AesQ5k=;
 b=Qz5IDs0zLDBys9ZHBxLtO5/AhQZMH+Qp1+lWdSLF6/Fqc183GBe7AZskcc6U24SoZoOD/mWtsM5PJCPxbfEWpH1RHLL8K0bP8z46Aege7tSqxqvhz0SYlJ2jYw/qRIdbaBKCiM3oWOSu747j6wwgXUbmYnyY/OAFgbqaT/fWcUA4y2Lm5zQLwWVurJlKnA2VvGNe4ofoPIiW8/XmfE4b4jywe7YYq/Y55HL21C00oqeWDRXMb2Zu1DsUll0kbbS/Uc5t0L6q6WmRBMlFsPwzaFUzfq81pdAIlXuBRkNkzd15/S1nl2DIPf9m0nfcMT3XIxBx5Tf2OzW4Ixz6YlZTdA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by PUZPR06MB5722.apcprd06.prod.outlook.com (2603:1096:301:f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 18:15:31 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 18:15:31 +0000
Message-ID:
 <SEZPR06MB695934C69446B4878115B17796562@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 23 Feb 2024 02:15:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] dt-bindings: clock: histb-clock: split into two
 header files
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
 <20240222-clk-mv200-v3-3-f30795b50318@outlook.com>
 <5781c1a8-8097-49f6-b672-33a6bcf2ffaa@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <5781c1a8-8097-49f6-b672-33a6bcf2ffaa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [sY8TXztC5kYZFg4ndhcWDzGT2TT6nF8knjJjCplJSggxKKQbjhwnooHb7WsyV0bm3BxKc+X+fvk=]
X-ClientProxiedBy: TYCPR01CA0207.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::8) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <065b8e28-9ca3-4666-9785-e51661a84248@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|PUZPR06MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef296b1-7ae0-48d0-f64d-08dc33d240e9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dNf9r79B5vKKZiwA0bRL4691QrpvbU638gwgNMf8TLYp+BGny8ie+KCakLC/RtHuiiSDsUEqzqx5f/KXGfpCr73EzrIJTsXFdlEkQC/VAdJsEygZcrDb556iCVn49w0kp9m7YsTfLKm5NW+lD1sXRExJOH89XNHXikZFZwi7FygL9PPZX7LG0K3JSk7duzKbiqk+VbCHkNY9Jp6T/3NEYRrnBy+BrSaRA3EovbxJvMzPrlJVLzDo9MOh8WwYz6UY3Vhl6sCfUqByKJoqFwOaksHCeM9kPew8W5S792UUVWWWTI0U9tNC/l6iITycvRQb+mipxDjUXxQCSG48V83FRxA0wmIMvqBeVUI6IxsQ9duZBEwJqPtXCVH6QGTOfFngBCYvTylSuAtNxFB2UJ7skNIzDdCRrjFklyKDY4t6fuUdh0fWEL9zMQYZt+24MukJghr/Zihj0dpjzIxRK1VEUxyvtdyeKFM3t4M0YBe8kOpngMzbZl+GJxzAnRsuliBl7pqvlX2Au9XtPWgIq7yqkhrikkrel9aMKSzRyIWnHeJ9QdUCRK5MNBXf4KRlsG0A
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0NvUnVDbVRUUkg0d002akRab1d3dUNVNXFoUDhodFlqZVVtcFZzcjQ0Z0I3?=
 =?utf-8?B?THR3MHJ1dVdSQzRNK2hndHVhWU5yVEdWdm5LcVpXSTBCKzVoOWNUNncvOFBV?=
 =?utf-8?B?bkhvUHQwTXlESXNIK0NvN1pKZ0QrR0VYeXVaWkxkTkFCOXZ5MWNHNWsvVFBn?=
 =?utf-8?B?RWRSRTNiRm5XdU1vYUY2bzlRaGdwd2MzOGJSeklRc05RZnlpWU9ZcGRzemJw?=
 =?utf-8?B?MlhZeEtEbnRVOUt6MHIyc2ZyZjI5K2pVOVp6YlUwQVpSZ0VJaU1JMHJvOGhl?=
 =?utf-8?B?VDB5ejlkU24yYUp1czlHOEVPeFlJR24ya2FvK2VkS2NRRi9hRTlsemQrUzdt?=
 =?utf-8?B?dFJYV2wyZzRzeERtVnBmT05jSzZNcHVjWWllZCt5VE9Cbnl4K3RFR1FXQU8r?=
 =?utf-8?B?NnY2STJGT1B1Z29PV2JuNFpzbW1hYk52bmFaTzJrSlkrZ0RFUENzYWo3Vity?=
 =?utf-8?B?UldFVU0yQVZaNGdFTDR2YTlOMEtsWHFXWG04YUM4RnV6cTI5OWlhMEVtQnlD?=
 =?utf-8?B?Y1MxcHVpU3lBSGVUTVFjVCtzckNKS01MSjAxRE9Ub2dMUjBVVDZDdnp2L3RC?=
 =?utf-8?B?RzNVdWVLTzljRDVKZWxVRjZNbm1ac3gvOE43MUQyeitHVHJ0cFZmMnNBdzB3?=
 =?utf-8?B?c21oRStxdW5DWlAzZlRkWmh6a3IxY2hVeVZrZ2V3OHM3U2RRS29GVmRWSmtD?=
 =?utf-8?B?Z296QUc2ZnJ0MXpYN09BeWo5d0IxektYdy9JQnpXa0tXSkIxbCtDWjV0bGs1?=
 =?utf-8?B?U3FiVHZkbVAzd1BMbFkyMDdLbmVGaWJ5QTh5bXBQbHg4bHd2NnhKcTVDZVNz?=
 =?utf-8?B?d2RxYzRPV0R2QWNYMXF6dnpHUkYvQUNhS0R1aHN1M2dVSFZJdSs0YXdmYld0?=
 =?utf-8?B?MW5ZTVkwRVh5d3htQUdjY1NYTGwyZDlQM0MzWFdtbzFWb0pvY2xzRnZXTy9Z?=
 =?utf-8?B?MkdCQ0szbHVNUGxkMDZlWm5yNEpWUElvcyttbkI0aE8wTnZBR3RPKzIxcU1S?=
 =?utf-8?B?RXUrMmE2WWR1VDZWU1d4WkwzWmxnS1ZzTU1tRE9TOS9WQm9EUURnNE9WbFZM?=
 =?utf-8?B?UTZYUGxZOVdYVUZzb1FtK095elAxdWRBSDIraEc3dU1WNCsxNkErK0hrSE5O?=
 =?utf-8?B?THk0elR2T1NNNlluYmR2aExYeGNBalpWQldYMnZlcU5NVzhTOXl2ZWxZRzA1?=
 =?utf-8?B?L09LOXh1NEN6aktKOW5oUWQ2a1RzMlNUNFJtRDJaODFXMENxMFNKNThHYzgv?=
 =?utf-8?B?UDc1YWU2RFBDWHBRWHlHd1VuQkxPNGFEejMvZFNKY1RnT3FNQVdpSXRvUk8x?=
 =?utf-8?B?QVY1SzhhYTFvdkU4Q21YdG51VEVqSHlnbEVCdGhzQ0VhN243b2ZsSFZPejZL?=
 =?utf-8?B?bjdGWTZ5ajhRTWZpNnByNUpkdm9jaGUxUmdjZkx0OVcvTzZ3azExODRhczJm?=
 =?utf-8?B?VGZXWjZONjdTTTJFQzZ3dnFRby9aVFZOWDMxYUxlYXB0VHlaR3QwUERNVlJh?=
 =?utf-8?B?cEFDNE9FcmlLUExHZkMvOWJVTGRXN3FYcHJQZWJkdEVMUHVKdUpUY3FrL3NF?=
 =?utf-8?B?Uno3aENPVEc3Uk1Jb3cxSmZ3YjRXZ1VPM25XcXJzRkF6L2lTb0E5NEQ3RURY?=
 =?utf-8?B?cCtpWXFSZTd6T2pDaE15QzJ2NlBqSnd6OExSNWRHRllFays2aVBHVmw4aUpq?=
 =?utf-8?B?WG9UTFhvR2c5SHRzTmptODQ2UG9QNEtaMGppWVdreTNVdTVXSU5rclYvcWM1?=
 =?utf-8?Q?ZJNYmW1oy0zPPTm5dQC2Br81dkteZe5DvVlugb4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef296b1-7ae0-48d0-f64d-08dc33d240e9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 18:15:30.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5722

On 2/23/2024 2:11 AM, Krzysztof Kozlowski wrote:
> On 21/02/2024 17:41, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> The CRG driver between different SoCs provides different clocks and
>> resets. We should not provide a generic header file across all HiSTB
>> SoCs, instead each CRG driver should provide its own.
>>
>> Split histb-clock.h into two files: hisilicon,hi3798cv200-crg.h and
>> hisilicon,hi3798cv200-sysctrl.h. This header file is for Hi3798CV200
>> only actually. For other HiSTB SoCs, some clock definitions are missing.
>>
>> Create a new histb-clock.h to include these two files for backward
>> compatibility only. Deprecate this file as well.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../dt-bindings/clock/hisilicon,hi3798cv200-crg.h  | 62 ++++++++++++++++++
>>   .../clock/hisilicon,hi3798cv200-sysctrl.h          | 17 +++++
>>   include/dt-bindings/clock/histb-clock.h            | 73 +++-------------------
>>   3 files changed, 87 insertions(+), 65 deletions(-)


Should I fix the #ifndef #define #endif stuffs here? i.e. s/DTS/DT_BINDING


> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


