Return-Path: <linux-kernel+bounces-77131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2CF860186
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C771C2477F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFD954918;
	Thu, 22 Feb 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vLIompoQ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2099.outbound.protection.outlook.com [40.92.107.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4665491E;
	Thu, 22 Feb 2024 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626254; cv=fail; b=A5C/aWBVrAyqngDbksWXUkflnACF7u2PK6y8igO72ddxZqaFqmDVNnUkGixVa7V7mvWut+I3wgbNojlKorX2TCAs3bB/lkcRIfasp3XdOZYHY25CIusVkB22zhIXQCqX7zJCSJag1j+jcOGuYo8IWeBWCB1LLst+ppOzDFeKhuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626254; c=relaxed/simple;
	bh=tSsnxT+BpLyk+TBcNzbSUPnxJz8qBTlvI6ttYltok2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=meAR7AdPThDglyifjNUMTmnKuOIbL0LDrN8kK+uh41KxoqlVbVr+JTX/+KTSmrVICViekHDOYtriR0tTeLcjkftDvKoT4Wdz9yWXXd0/T6DfoXqwZ1aJvl3jCacbS00iR5U4BK8v1oiY4AUrv9394DyiHczIN522KAzkIY5uVuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vLIompoQ; arc=fail smtp.client-ip=40.92.107.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URKATWwZaHYOBIHBFGaRoj2k2WcqEmg3uS11qtOBE91JZh4HxhWy2xWEjc8LPJtjukxCYQKV0PaNkM0UXecBp5/nvcrEQlxafQwgQWfy6bKDX6fck6x1d6aC0eapajn6na7A6PB0m/3ehwFv7g7yMQaj23I8Ahoifa8z4OuQb997b/l3xWVp3JJyDaZWuCkyqnpac2VsrE38L20X7OBU3tMP/CAWxogzyXz7FHMaxwXS0VF26K9NWKJx+A5EdJW6pGuLBIzcN0sVJxjcUMZ1V0BXvmdQ+3lw4eiLWOSokgr/FnECPT/Td4v/UCFs0EF1Lo73fMmAu02CZwH2BhSl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbL2DM/txEReEw/sxHnD4AGupwDzYzfchNR7e0Vp/iQ=;
 b=QOD1u/HI2I5oh0xoN1wzGMYmnhwC+m11nQUVXrC2POdSlnBBK7W1IwEOQf9WfwmmJjxHO8uD8M0MnjizfTkHr9VaPmKFOTfX/hoOIvI/hryXyz7GpS4WRb70Ie+LC0h6U+5qKVUn08TNO33Omy4cc/m5Qn1tPKQ7lz+c/pHhpnta1gBQjuxv0Z8797NIaI9CAebQ/7X75BT8L2d0JjszEdPUGDxRarGiD14yujFeV8bkxQQCD1VxPM2hnrF2EWBzZxzRbqL6AqVf80wJI2c/ywE3o+aVgi0Y2BrSO4cyFzIJBE+dEFSICKYZTg1XC8P4j/YbER3ZmDFORqRODoIIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbL2DM/txEReEw/sxHnD4AGupwDzYzfchNR7e0Vp/iQ=;
 b=vLIompoQcv/M+F99OrsU83gQKpw0wt1fhdh7mcaqZw3RB5nB8hdEDGGY9P73rKaiN+3Z9cveUxzpF78UCym88NYaaxzYypXddWDL78z5KQcYURVw+2juzGp8r8pNhdDNS5jinElXKIzJcFApjLmlHfR8WvL560jVEK285x7yAWBhBShCz1S0h069iGDwRbEfurRxmm7inDbNcc5NfnOcEHRQI5UHyD7xTxB58/L+Gw7yu5nh8uv5APBW/ImjBDOEhUHGGehy0eozaaTc4caaSkCY+najJ1GWDtSD0zJe/QgnQiNCofOjuXdQc0TmrzmtmmEOA591UaHPtauej6tupg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by PUZPR06MB5722.apcprd06.prod.outlook.com (2603:1096:301:f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 18:24:08 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 18:24:07 +0000
Message-ID:
 <SEZPR06MB695992CA81884AE8FF5907AC96562@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 23 Feb 2024 02:24:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] ARM: dts: hisilicon: add missing compatibles to
 CRG node
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
 <20240222-clk-mv200-v3-2-f30795b50318@outlook.com>
 <2085057c-0000-4e0d-a633-c84e939313d6@linaro.org>
 <SEZPR06MB6959274FCF19F70B45589F4196562@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <367ca75b-26f1-49cb-a74a-1222195716ca@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <367ca75b-26f1-49cb-a74a-1222195716ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [u2OpvoSvkd7g+sL18ePrDSPqdRC9dUrzxQaPyzB7XdqzVdVv2ETePskGBPbr/3x/15yri+e3IJ4=]
X-ClientProxiedBy: TYWPR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::23) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <d939fe44-f18c-4ef2-9249-1a761a12f09d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|PUZPR06MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e2e38d-8acc-4b6c-ddca-08dc33d374f8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FV6AzZx2LDU+QLgQ36d80Xovf1Btz75GEEw6LCnoHr8w+MHHJOfGdZQl5358CdshzHaODbZMhCXelpTAxs0yZhxLQNMR7ALKkDFAU9pu1gb3XfeAn8MoqynJVe7mRj1RJ/9JNZsPp2fdcciyobsNFq6HIumXo1LaC8s5kn/MMGPgBPnh+4mNl6NesYb6CQvJk2VpnPJTU6/1RREPg1ROHqWw1DpzO0WEhB5FR4GYGgK7CkNZ79bVXX1c54FiAoVgwdcuox/7w1Cruy49cGhjSXK71zigG0ZS+3ptZcCSRGvqHcs4NShd25NokV65ZxDlc2DbCr58dR7cKH/q7t9oB10fOQZcbmTiOusksGbX1a+1V6jgNfgSpmltlMMD5CU0drEmKrdNsfuE2Vm/QISl6Vx0OptOCv/Uy+q39mJiZbV49GCHRuXaDzFyTdMj+Go3csprfAS2oUAu7h447f/MFRfBqDoffvVU/IWgP7/kaPhXFwaEKiO1v46wzPsHsiG5ZxmbQnAuJ5QXUaQviXDuEvVbrJy6JR0qf0XWeDoPWFL3ehLgcaGitjlxIfJra7Ls
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2o0U1dQL0Q1OU9KVWsxb1IrNWpjL2lpK215WTMzblpwV2dza2QwaXJ5VnJp?=
 =?utf-8?B?MkRudXF4Rnk1Q01yR2pVaUhXd0xodU84ajFWeTZ6U0xTVzBNTWtUcUNyeDRB?=
 =?utf-8?B?Rm1qaVBhZFNQdHNhSmhiL0t4eUpjcnU5VjAwR0JobERncjU2MitZbzdudVhh?=
 =?utf-8?B?VnFDaWdjU1A1OVNyOEVVMm5ITzNicVNhbGhDOEk3czQ4T1BBaU9HN3lsYW9G?=
 =?utf-8?B?MjBibTIyaEUyWEZnTHVOOERxZTR6Ri9XZi9FNlNCSDFSdFhxa2czV1VLbkp6?=
 =?utf-8?B?dW45Nk1jMjVNa2hDNWxLbEVzTVRhcjMzYVlBRzNXQmczQmVtM0NNNmVIb21o?=
 =?utf-8?B?RFE1ZTRqZFpjZ25iQXcvVGtQclNFT3BFRCtkTUhsY1M2WWk2UUJzS2lMUjgr?=
 =?utf-8?B?R002SUNsWDBia1IvZG05UG95KytNSjY5dmpvdHZVZUloMXRLeHNRRVcvYjJa?=
 =?utf-8?B?QTJPVGg4Z2VUMjNJWTdwa0hMM2NIZDN0UEh4ckU3bWU0WlVaN0VWUzNQTEZ3?=
 =?utf-8?B?cTZYTGVCaVd4RUFSRWdWeDFuWEpnemo0WGhTcFNyS1dpZ1JVMjl1alpVMXBH?=
 =?utf-8?B?YVpIcVN4VThNVWVMSFlTY3c5czZsZkVWL25RUHlhL0NkSEZXWmhydjFyaFhw?=
 =?utf-8?B?REN3RTlGVzVGUTBJaFYzNHZ6RkN6eS9EZlNzNW9XYXd4dFJnUVlHSm41c29K?=
 =?utf-8?B?WmNGRWRyYWU3QThJQ1VnQkJCdm9DQTg0MWFrRE42SVlYVUFzRXgvbzVjK2hI?=
 =?utf-8?B?ZUVqMk5uTWlqNzJreUVQWlNwbi96TmpyQy9kTnEzSTI2UFBjMlhVYjE1Vi9K?=
 =?utf-8?B?NTgybHFnVjVzSlV6bFVLb2t5V013RFRzSmRDd1luaXZDa1d0RU1iUjk1SldH?=
 =?utf-8?B?RG9CTHc0UWluTUNibytNSmhkVW90dnFIYmNnbFVYRjRVVkkxM3ZRaHg0Zjg5?=
 =?utf-8?B?ZUhUbncvckFkYS9ycjdXN2R0dVhSRCtKSUhkWWZHTkdHQkVPd0xRZkRyWm5V?=
 =?utf-8?B?dTlreEhWTGJ0YVN3dFdOSE9mbEgzSmxtMFhyWG43d1NXMklEcDlVK09xSCtM?=
 =?utf-8?B?Q3Q0bmFOUlZlcjRRM1NiYUlNOUZ6YmRteGsxWlV5ZkV1YzJOSzNXQUxDc2xt?=
 =?utf-8?B?SktoNHNYcnVwbDZ1K3VFRDBqdkQ5L3hUN01UbWdGYU9ZK1M3d1FYRVNDMVNt?=
 =?utf-8?B?QTFsaVpzcVFFaFlQeXNORmQyMkF1VGVlV290dDAvSXgvVmI0RXJEMXAzazJr?=
 =?utf-8?B?eVpFZkYwZDJ0RDRCdkNEYUF1UnV4VG5sREdmZmtYTzN1eVBReld1SXZmak9Y?=
 =?utf-8?B?TnM0L1BwZWNNNGxJUjd3RnZOR1A0d0tJa1ZJQkx1alR1akxVbk84VEtsVlNO?=
 =?utf-8?B?bzF2dEoxdDF1eWdHNkxWRUhBTW9FQjBmNWRuUURVdnF0K3VEbXVFNGk5WG5V?=
 =?utf-8?B?bEV2NWRPTFlRcVFySjJobEJ2Ui9YVXlLUjN2emVuTmhjcXlmQUoyZlNqcW5m?=
 =?utf-8?B?NTRqZkJQZWJSM1ljRjZlL2NWUFVCemNkbnNBTnVMT0V2NTdPMHdtT3A1RmRN?=
 =?utf-8?B?QkovcmQ4MjgzRXNEdGdCYUZGMktPKy9CSW9NSnBoSk5aem5mbTRrS044bVU5?=
 =?utf-8?B?Y2NMcmpzVHVPbCtFLzN2UWMyY1dLVEJXVHZSVUJQUERGMzRHOWFTcjVvUHhZ?=
 =?utf-8?B?VVBwdVJwK1h0UVM5QkdFL1NDWmEvMmVMdVBkOS9aQXdGVGpNR1JwREVOVzl1?=
 =?utf-8?Q?upT9Dl3I4fnpkIKvhTikZvW6zFTe4DogCjm7E8S?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e2e38d-8acc-4b6c-ddca-08dc33d374f8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 18:24:07.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5722

On 2/23/2024 2:18 AM, Krzysztof Kozlowski wrote:
> On 22/02/2024 19:13, Yang Xiwen wrote:
>> On 2/23/2024 2:08 AM, Krzysztof Kozlowski wrote:
>>> On 21/02/2024 17:41, Yang Xiwen via B4 Relay wrote:
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> Add "syscon" and "simple-mfd" compatibles to CRG node due to recent
>>>> binding changes.
>>> Why? You claimed you added them in the bindings because DTS has them. In
>>> DTS you claim reason is: binding has them.
>>>
>>> That's confusing.
>>
>> Because the old txt based binding claimed there should not be a "syscon"
>> and "simple-mfd".
>>
>>
>> But it exists in hi3798cv200.dtsi. And i think it does no harm to be
>> there. So should i do it in two commits?
> hi3798cv200 is not hi3519, is it? You are adding simple-mfd to one SoC
> because some other has it? I don't see reason to do that. Er, why?


I think it's the careless HiSilicon people who simply forgot to add it. 
CRG core on these SoCs are very similar. They only provided a bunch of 
clocks and resets. Some register offsets in them are even the same 
across SoCs. So I'll say all CRG devices are "syscon" and "simple-mfd".


In fact, i do have TRM for Hi3519 so i can prove what i said is true.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


