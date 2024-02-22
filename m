Return-Path: <linux-kernel+bounces-77128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CEA86017D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E696CB23187
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47C314B82C;
	Thu, 22 Feb 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="odjf1Khg"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2069.outbound.protection.outlook.com [40.92.107.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064541586FD;
	Thu, 22 Feb 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625998; cv=fail; b=PXbOtr3vAGGabRQMGGRNzLvuGSV9KJRX3Mq7qAjMDgSw6q2kJbGYza6pfCF76VkqtmXevNlczmliyHXld6hVeWgrCGrOr7sNBjQYnKbNk6ta5jGUbnWTWqcTHFaenb0LmdAXUAV8KZ7AjTXsK0yQQEgiIx23g1qQpzLLjvSuAPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625998; c=relaxed/simple;
	bh=kq5uqpW8MF/05fdHTc8GNYEXu8zlhcr2OWw1ESAO5C4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EIfgXFq/epCmjvOzTBC+pTY0NOL9kt2vz5iQdXVqdhALEVWLVRT4dpDm94HaEKikaJMk2fnTgdB+Xb5PbATP9lzz5uRdEwBUp12mZy/QJYf8bTeRvcgMU4X6LEKrR/yUy0Zwsb7OIuQCBg28NVECmf2Q7MLo50DSXnA0rDtj34Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=odjf1Khg; arc=fail smtp.client-ip=40.92.107.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPvk/zXLk3iMY6W44j35z/V2c1nh5OHJXwfTV7+sMdcWvHP1hA2FXIH4jkGA65ZHtIbu3iXNm907XEsg4oq8iwNs8XZ2xZQK4iWCRwRpmMJjVOpBA1KEtC3ZTqNwvPT+xTqG9ak+pSYORrnvezy9Rb+U/nmIYauxO0PyDi05QJDAia6WhFTXbuWtOwy0h3kHm1z+jBjTYuusb/oFzeKYfrV02U1qnB5L+v2/aTJXmeqGT8xiJflD2YNWlO1kHAIf4TvqHr9daxA4+HAfMRiHTTBW1bQNIgD6FPm/akfo1ucKvhKzLnMbS9nd0YWhBCSu8vhm9UNbziYKJAq9amu74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Eb0I68UVQNAerS8SlfQtsWc48nnHSgN4JsUIFmHae0=;
 b=PrqVgBC60a9C5o6gbRa1X3qxLOzUZJuzLS1BjCPp6iPw/KZbXeGaPXvh4Tr31HK+p0lh97cFiLusjSTNYyNaokzGOUiMaq4aP5GjiU+seeJyFj0KlmQsVMFvKS7oswQumyw7vrjWWNiWeS12lhW24QvFamzW8NG3ZyRTmXew/APkwQevkL8lPcJ8XwVtEWQnJnSD9MaZ2uHxxJzpVhvcCnhMjIKywEJLPnvSM6VzZuXR4yiHz2BLZxh78d6iUDqfuETWl9zVVxqbr0Mfl+GxX8G5StWhMFR/Sms9Su+XyN5y/BPA3x2eTJEHEJVj+3UURlCggoRD878JGCHBvsLJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Eb0I68UVQNAerS8SlfQtsWc48nnHSgN4JsUIFmHae0=;
 b=odjf1Khg4RYWscAOih5X1ZqcdilU4K1iQ7siqDyQ3FKNTeHlL8IrUS5FEkiYTdwKXf49/801sOUqFDDeDm/0nCvKDowMCg8IdiJWScrV5ThMrYkT0qDwAmHa1L+XyBmbTs3fItddpYPkPLukQyyztO8/ks5/ADgVh5jxVDdiR+GP7JlqEHiA94HDV3y7bUmiPks5NlLPz/FDluxeDNZIu+Q0WtZ4YHeZjeIg6YABhPgjk7gNPsuO6dWV2h9ZG2ThOK3z7urYG1fanzM3FAvrrQd2RNz4EEyXA+4Vz/kYQjzu906iuJE8DqdC5YT0CPWfpquzRm+6sWGzmivjHv8aIg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by PUZPR06MB5722.apcprd06.prod.outlook.com (2603:1096:301:f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 18:19:51 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 18:19:51 +0000
Message-ID:
 <SEZPR06MB6959B0A21A1B601644E2836496562@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 23 Feb 2024 02:19:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/6] dt-bindings: net: hisilicon-femac-mdio:
 convert to YAML
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240222-net-v4-0-eea68f93f090@outlook.com>
 <20240222-net-v4-1-eea68f93f090@outlook.com>
 <e053448f-2b58-408a-af22-d7b464c52781@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <e053448f-2b58-408a-af22-d7b464c52781@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [8lhH0o0ZFxLprDJPcGN8Rc2ZlDLN2NpH0tqbIicPx250pBntF4yobCHungSW4cAhNiScqnvvnJ0=]
X-ClientProxiedBy: TYCP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::20) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <fe8bfa9f-9a22-4b5b-bbb4-5fa4f57ed2eb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|PUZPR06MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: ff767b34-573f-4826-b50f-08dc33d2dc4d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SqKlfdUpdClSkgDjAqWPfnU1jjvYu5ZQpsETlxLWKk78886arS7BK9UjricjnnlYbYSFHqvrEKbM+5jJdKb4gpsfF8uz03IJ/gUFsniB9m35v9+RkR3HYCXetlArhS61j/ttOsxmW2yo19Ad9502JjKECkon8zSThNBBae8PCHnrjF0RAxrAX3oOCGVxA48NWuFtqV7qqRcHgLD89n2R6jOqkct7b0Kmelbo1It/GZHWs0wAs8aSKrXluVTIgPIp2tC6ThdG2yo/sbQz1gMcOYzDhyGdWZJxihtek0P9c7Dk+kp5pGMD4CfKtsSFtr6NF2diS9dUcKHPaJv/4wG1PFL9ZYcjWAhFXkbXR7sCN0N1HIn9EZfVEfcqzEGL5WR62fhKMEFrqp6DhIA2hHxncTigd0gtEyk18qt1ifLjTjoGBO7eXFiFbvJpeABaPgW0M/s6MnbkFeqyOCpCfIRb/27QzbatIrVoUe9YrXA1x+9NWyqyofzLyWb6ILVuT7JyIBBBo2PHrI+QlwMPTYkP8vME73jDWlmrecG+2XtMBoUWMZ4wc1rBbxU5eolJoxMj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhELzJ6Y0pFS3NCdk5hVG5Yb3VDS1ZtTnFMakEvQkpDSmU1dVVmWWE5M1Yv?=
 =?utf-8?B?VWJ4a29OTmZuOXBick5vUU1pb24xTHRUR0NIVlVyZUdXL1B3b3lNMHBzbnoz?=
 =?utf-8?B?cEJMNzZZNmFqcS9KRE1ER3BMQm1iYVdJakNwb0xXMGpOSWg4ZkUralRMUkQ1?=
 =?utf-8?B?WkZlNmtLTTRYS3hyUXpLN25WUitIbUZHNUZZVUNEK2tiTnl1dXlKNnJvUzQv?=
 =?utf-8?B?eEtvVnU5S2FyQzV6RE5VOSsvWTMwcmtNVS9uM0VwNUVmeDBXa3FaWE9tZm5z?=
 =?utf-8?B?U0Q0c1VZa2ZiUENGUjhVZmUzaVdOU0d6enp6TmNNbFhrNTNaajZaYks1aDRX?=
 =?utf-8?B?cGFkNmpRQ09JbkZIOXBmQmVZWmZKYXJ0VzMrK1dPS1c4dDd5ektORThENVJw?=
 =?utf-8?B?clh1U2hZaStUQlROdDVic3BsbGh3ZUw1a2VIQXhISTEzTjFDZ3BkVHlVZEM3?=
 =?utf-8?B?UThub3p0U056U0hBNzgrS1Vyc2g3WHd1SFhDTkN5V1RlaTduWXJncmNZT0pR?=
 =?utf-8?B?cjhGRTRYK0Y5Y0FFREJMUVlKQ3hMVHp6WmJHNkNJUUVhc1NnbVBEUnVmSEht?=
 =?utf-8?B?VE1yWkV1SlM3K004VWoxc3VMZFhvNng2cDQ4K29wbWVVcjlvTkFNZEszVjZz?=
 =?utf-8?B?L0RxS2dhZ29JcTNXOEMyZHV6YVZic0k1RTNNOHQ0Z1B6ZkE4WWticlNoZDZ1?=
 =?utf-8?B?amV0MEErYWh5SDRvVXN0bHcwWVNsc1J4K1N5bDhsQkxRMlFYa3krUG5BaFMy?=
 =?utf-8?B?QUhnTUJrQVNLcjNZVXhQM1ZUbFd0NzhnZXE1UVNNM0JjR3Z4NzQxbnVQOWhk?=
 =?utf-8?B?czNEUE9GQSsxOENsRVUrd3BlUmJ2Qm1MREdGNklnOU9rNGRxcFN3bEhVWFZS?=
 =?utf-8?B?UHNzZDV3cFpXMzcyQVNVMkVkZUhwUnF0dHlPbEYyYXUrdTFxbjdMSnM4Q1hI?=
 =?utf-8?B?aDNESVhXcUNLV0dQVlJJQmNTcGVQSkhlUmRDZExVVlpmUkZ3MmhCSXNCYlg2?=
 =?utf-8?B?ZjlGNUtRTTZ2Uk1ldlAwQlVVL0VBTjJoTG1QeEpvN1JObE91enNhcVl5cDlo?=
 =?utf-8?B?TUdEcWlaQ1ZFRmNmbi82b3B5UG52Z2ZUU0xvY0ovY0tCRnU4MVpGOC9DZ1hE?=
 =?utf-8?B?aTNGTTBTeEN1WDgvSHg1dWV4NHUwZ3Q0cWZmOFJVV0lWRXMxTWhpMmtBSWw1?=
 =?utf-8?B?VTA0bC9ZQU5DbmlvblFuNDVIcmVvU3dYUkt2VWlBbEN4TzhScSs1bHhlZzBP?=
 =?utf-8?B?ZHdZaDlUVkxGVTNuUXpzN1RaSENLOG9zeHYwdytoaHBCUjdLd3RrR254Z3M1?=
 =?utf-8?B?MnRzeTdZanVBK3FiRGZ4WkJZKzhzL1BCOG00S0N6QjRsOFN5SDUzaUJpZ0Jh?=
 =?utf-8?B?MzJNV2JmSjFyTU9vQkRMNGpFTkhLTTFnOFpkYk5jR3VaNlVYTitOaWtqeFEr?=
 =?utf-8?B?cU0wbVFGemN1N1JNdnBLY3dwWE1DVkVpTG5lQUc0MTJjZGthSURicVNoUVJy?=
 =?utf-8?B?Q0pPOUFZeXRZQk5WMlNveDhWUlNOS3I2b21reEpGTzFRU0dsOHJOYkFXekU3?=
 =?utf-8?B?VEZONURpWGZBMllLUTlDclN4a1kyTi9BaDZnV01uV2hIWnZuOFRPVlA1YU1x?=
 =?utf-8?B?cnd4TDY1NDl6Ui9KMjJJcGxZdktDdlNJS3FlQUd1bzBEYnhUT1o5Q1NlUFZB?=
 =?utf-8?B?UnZOMVdjVGJNUUNUL2pNL1hrRGlwYXN4ZTNoRlJ3UHdsWU9ON093Yis2S2pu?=
 =?utf-8?Q?0HPioEv2tWZsUvWQEVuq6IUkQ7qYeoE/nSjqmHb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff767b34-573f-4826-b50f-08dc33d2dc4d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 18:19:51.3316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5722

On 2/23/2024 2:14 AM, Krzysztof Kozlowski wrote:
> On 22/02/2024 13:43, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> For some FEMAC cores, MDIO bus is integrated to the MAC controller. So
>> We don't have a dedicated MDIO bus clock.
> Hm, this means you miss compatibles for these different cores.


So you mean adding a new compatible like 
"hisilicon,hisi-femac-mdio-integrated" for these ones without dedicated 
clocks?


>
>> Also due to the PHY reset procedure, it's required to manage all clocks
>> and resets in the MAC controller driver. MAC controller clock can not be
>> shared with MDIO bus node in dts.
>>
>> Mark the clock optional to resolve this problem.
> I don't understand how making clock optional solves this problem. Clock
> is still there. Whether driver handles it, does not affect the binding.
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


