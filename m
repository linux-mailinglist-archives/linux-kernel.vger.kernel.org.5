Return-Path: <linux-kernel+bounces-69813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 860CA858EDF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98737B214FB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F26059B60;
	Sat, 17 Feb 2024 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LzZ6laR2"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2068.outbound.protection.outlook.com [40.92.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D495495DB;
	Sat, 17 Feb 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708167514; cv=fail; b=jj/Ow9nKZaLdb0Mjz0e1mCpPTbIaF+dUVAVMiOs0YMHue+VIxHIL4DGIkHUBQdOdqRyUm1B6dHTGBwxyi1jTsbeakjxUx8CjvTarRrRifEo/ZtTw9nme4V45VuV/V5TpudkNixgFGQ80PRJq45HTxTqWHnn6BmlC9b12Lp+Qm5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708167514; c=relaxed/simple;
	bh=adhI1eKUZVFK18K4JsoLOEJdJjFkUGipX0PBNx2kZt0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PcDOFECvnYlGkUCTdCC3sxtFuXy7AtHtPvENxeEZbZbdvRYGCmNG7no9Lz1pLc9y8Lf8r3MUvSfPML2q4rEGS9rmtdKMorwQAUhOr+pkDqmLPRsj5oj0HX0fyHLaNADoD8l8dt2BmsPNRrcl8yF4/r6Nv1wnoPxzAmNTKqTqy6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LzZ6laR2; arc=fail smtp.client-ip=40.92.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGcSCw+4fpiu7wTQc4ISGPqNvxdOkzfG/lj/13wH2+8NZMYBtFtwi8wikp7gMI75F5+VP7+nriz2+4US4IPQ2NoJaUxfgOxSx0VQ61INvJzJxvac0n5hUlo0sHc4jIH9BVkpebJ+TRqvYpy5viv2hfZRmS2zYMBRtn9thot+B0F3FBEAqNJoPdccXJzJuRaklNRvrNPW1Y/tx6BpPPk5UxhcWHus8dJ75f6qIvAcafCVpsNOa3NFLMyr1GTdgpMBv5KVoQVpT7cXYuTNANdipuV23GoFKYTKvA2U1kr1OOBLgQC2Xz+vZkvOv8mUArkdeD4VAlETOOnthvONjtkD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRhWhf1t/P+TRsKl0EyjxaWayV4BDU95XM4l2juNSbQ=;
 b=lDB4XnZfOvPSiaRW9kpdIniIatPcK8cSO+gF4qXmloKN1ZEVud3zsKT76rir3tgtt+oNYn5Qa49RKzMhgg7umH8zldfKofcTeLa6FraiEKVXsPZZQ/ejK7+O6qvfPBT5zGED/52/h4v7dLuzaRvj4fCJC9gnj28LUzAJv4a6FwKokOFL4fgoFNn6cOJFn9M7xckHDjKkZ6OAs05GTw/oK44WDLEUBTR7qQxkc/1Y1ubQrJSsfO/Ye1t/XkpKrK1I29jBoPf9Uprf+AI+h3y5W3zuPoEZ0ltsvCv7GaIjNwhKOpREfGgfbQuBne+BZtsNgxZHwAbolkvJBpEvR6daYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRhWhf1t/P+TRsKl0EyjxaWayV4BDU95XM4l2juNSbQ=;
 b=LzZ6laR2kkJCKKiGNP9Vyu7IQdOH6M+enAztFkovj17tCIGV4UHe/MGNluIX3jCxWavCDFv3yQqbaf7M9cwgNoGhot/lFRwZg2zfFHpOW/35uocAYYI0dR8kIf2Dbwxfo9P87YzZzi5dd0gMH/+CO7ikaQA9EXZ4n2ozy/I931rFvHZDh2ddL+wbW/AkGx2kyrqLknlnfnUS4kOvQaYPvHaqNlkZECvsx7FoE4AEvO48jS9DBgNHBnZ3ruEOokrEKVi3nimK6EfZL5e/B9JreZb1cy+usfPZFWyXjs5/ZKnndk+3kZGULTpTvoUnRNd7kXbQqwgrzUwDTP1VF1Ouwg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB4015.apcprd06.prod.outlook.com (2603:1096:400:28::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Sat, 17 Feb
 2024 10:58:28 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 10:58:28 +0000
Message-ID:
 <SEZPR06MB69591291ACC9EC85CA0E8C6496532@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 17 Feb 2024 18:58:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] phy: hisi-inno-phy: add support for
 hi3798mv200-usb2-phy
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>,
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
 <dd1f1b28-4bde-4d40-8022-b57d201c70ee@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <dd1f1b28-4bde-4d40-8022-b57d201c70ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [O8jIdffX1Fo/kSHOwWA8FSrPF67BOdJ9e8y9Zytsw4gKxyElmDyOdtjSMSYa6aODZDD7EJQegNs=]
X-ClientProxiedBy: TYAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:15::16) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <127a5044-e002-4c4b-b866-af1bc2c05c3d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB4015:EE_
X-MS-Office365-Filtering-Correlation-Id: 0239faae-0310-413b-8eca-08dc2fa75f37
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8OsBRSuiQF5BP75zaJR+2uRioFXiYgIHDY85Tk8DM0pqdOXETxL+sU2dsDaUi75lAbjtHq8+cEQXaf7rGnhQov9EXznEXcER32G8lKRicclxb30sDfCec3l2e7uE2mgQxYrhl7Vw/SYnNs6qlPrMFdoSZJvWnCa0jfJZR8qspW0d9gUwVfw/fLl1pUvIkLZJDc3R3VQW3QHpS/bcLkthbn03Cq0fY/LvINrhEwDiYg7i+EtE7TSu5FVgFOHXO48O9jmeVja2dw8z1WdYLK5hLq/NTmvGNIHg6t16W0Rin9bZS/fcnCXlQimr2BH8pnkN9zD6tD9HrteCknGFF520JY7VXqtK9cn2Sucrab/BUV1dxqnM+xUmN0SoAtYBp6/XXr9LOkqXaCgCmSrvXtHLq0C/MATXnXAinPZlUgOiVb7kYXaKqvShN+bpXXE+XDD0V1sfJGIVy03Q0woLZAqkhv+D/5E8RO6/EgJ/ofA1EVGaz/nQ4yJCc5W8jwqzt72VvLO4/dXXAbM4xIxQyZon3J9LphwBRLa164geIPD/NY8ny4sjF30GAeIWe+BA3wpT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a00zRDBxeHR1aFBTRSthaFF5OXpYdWZwVEtLaHE2Vk9IbGwwWmlhY2o5aGRt?=
 =?utf-8?B?MmM1NHlGWWpFSkNodEVNcWxoWEl5VFVVL1M1QjE5eFJhWWhjMFhqYnBQT1Bl?=
 =?utf-8?B?U3VTQkJ6aWliRDZaeFhGZ2M4RDFuRnFtd3FaNFFXYkFGcHpXYTEwSUd3STdT?=
 =?utf-8?B?TVk0R2JLalljQ0RNZHh5dWRNcGY2N3Rkei9uc3RqYVFhZVBBS01zZFNqdzVk?=
 =?utf-8?B?Q2l1TFgxT3dxbFh3TkVkRk9YQStUZW9qV1Y4MDRJL0R6eG40d1doM2dFTm9r?=
 =?utf-8?B?d1F6QzRnNkZhdk56V2tLM2pieW9jVGNENlBKOHFqYXRhcTNIaTF4eEhaTUQw?=
 =?utf-8?B?VnRlVTU5cEwxTkJNd1RGVWgrQ201QVQrRlVhS3NQWWNFMFRMWktjVVpRSVdF?=
 =?utf-8?B?TDlBMWJIcWtNSnE4LzZ5WlVoR2piclpXRUg3cDMzVmsxYUhEWnVVVGpPVVZH?=
 =?utf-8?B?c1g3SXk2K1dKdTV5Mmw3Zk1UV0JrSzlycDBqaW1HakE1ZmN0MGk2UWF5cERw?=
 =?utf-8?B?Um1SVTZlSk95cEQxeWNuWmtUcjh3YSt6eVFrVEFXT3BjTHlGTEpJQnpIMXdT?=
 =?utf-8?B?dHQwS2pLNUhuTXlnU05BNUtnWGtUNlZPUWcrTkZzemRXWXltN3lYTkdZME01?=
 =?utf-8?B?UUUrYmg2eEEzalExcU53S1Z2bEVpUFJHSTdaUUV2RVZaS0pHS1F4RzZySzJL?=
 =?utf-8?B?UlcvamE4OUhYQzFESzFudThtOVg4cVF0bzdKbTlHdVMxUEJ2U0x1enh6Qk1W?=
 =?utf-8?B?ZFNBTElFdnpGakJzeDgzYlpJeTBqd0ViN1p4Nm5Mb0lSc0xPdkRhOUJrOXJJ?=
 =?utf-8?B?SElVbnZpYTU4YkFScHVZOWJyZHJ2OWl4eUpaaVlhcGcwdEM0V0RjK1pEQ0pM?=
 =?utf-8?B?UkJSME5Jb3dOdk9mOWV0MmEwRUZpR0J1OVNsN290eUIzejQxdWJHT0M2M1R5?=
 =?utf-8?B?ZlhWQitDNjJCczhsa1RTTmJwU1lyd1dOYTRaL2hvdHpSekF1L3p5aC8zckNJ?=
 =?utf-8?B?SEtrYnZ0Z1RrZTJJbEs5MVZxR2ZIVVg1RHVOd1hQd3llTktRSWxtdUxzdFdn?=
 =?utf-8?B?SWRvVkxUMHhNdDR2TTlQLzhVVml2dk1wRmppclY0Z2h6T3dhcDZsYTRnTG9m?=
 =?utf-8?B?bWs5emphN3JsMDI0aURla2FjRjhEL0VuQnBqWjU5aHRzdlNiVm5tVEMxWFE1?=
 =?utf-8?B?NXhidmpHbGVDRmxOcFoxK2JFY3BMRFlWeGpYR0FTSFJ4cWtka0w0cUhpc0Vo?=
 =?utf-8?B?OHMyMU5BMjI0REc1aSs2azRISEo3S0p3ZXRSV2JtQkJrVi9TbEJmUy9kRmNr?=
 =?utf-8?B?WEJmY2IyUWpVRWd4cHdnenJ0NmJNc2NyT09ESXFzNHNOczV6NTVpcVVZbUNG?=
 =?utf-8?B?aGdlU0UxdDhDaXF0NVNYQVRFQkFFM256R3E5Vmk0OHNRVE83YWg4T2Q1L1Zx?=
 =?utf-8?B?NWdoOEhPSlg1UVVEUFFKVEw2SWJZaTg2bXFyZHBQM0krYkwvTzFJZG9NNGIx?=
 =?utf-8?B?UTF5cU9kTzBWeHNOVzFXR29GTlJhZFBNOTBYYktKN2M5bFJiZ3g2Wmt5V0lF?=
 =?utf-8?B?WE51WE1UU0JDMHA3L2NjYXlWS0R3bEVtYW96NWhQekZzTFNOeDJERlRYQ3Fq?=
 =?utf-8?B?RVl6Rnl6bHAvbDArNnNaMU9SVzg2TmVSKytkWk1SL1F1UkdXS0VkcDM2Tmdh?=
 =?utf-8?B?dGczY3BoR0JLR0pVTHgzWU9aS3pnWnd5SnVPUGw4NUUzeVZRcG5HQis5a1hq?=
 =?utf-8?Q?9zfHwFhaN9ad8oIT8yKOZCed8fPaqrNF4eLk6VD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0239faae-0310-413b-8eca-08dc2fa75f37
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 10:58:28.4738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4015

On 2/17/2024 6:18 PM, Krzysztof Kozlowski wrote:
> On 16/02/2024 16:21, Yang Xiwen via B4 Relay wrote:
>> This should be considered a dirty hack. The proper solution would be
>> extracting write_reg logic to a separate regmap driver. Leaving only
>> "write BIT(2) to address 0x6" to the PHY driver.
>>
>> The initial commit is already doing things wrong. The following patches
>> adding hi3798mv100 support is also very confusing. The name of the
>> enumeration "PHY_TYPE_x" is very misleading as if it's the phy which is
>> different across SoCs. But actually it's the bus (i.e. how to write to a
>> given address) which is different, not the PHY.
> I have many bounces from your emails. Please do not Cc unrelated,
> non-working hisilicon emails.
I can't recall why Tian is Cced here. Will remove next time.
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


