Return-Path: <linux-kernel+bounces-68547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A024857C20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549C31F22B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A578689;
	Fri, 16 Feb 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XOvfnGmD"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2100.outbound.protection.outlook.com [40.92.53.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE112E7E;
	Fri, 16 Feb 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084403; cv=fail; b=Uy46Gcno+7LjqpX6rDns6Y5B84pT6YmruK9uYjg9tWEVqzkJezIUKhM5hHav/2LO7eoHibCiUunSujINRdrHXSfLvlCcV2D0KP8A9lJSdG/rufqV3yHqWbpI9Ju8Ny4MZ28xUgUjhxjsYgVmfKlCQYyJKkLimvkjJxYJz9h2X/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084403; c=relaxed/simple;
	bh=g9h0OvYin4b69dg9YDl7w+M7iDyzAapndj6rMhOhRWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bscAAsM5YAgrtJnL5F8mSLROQrgMkb6ntJEk+i80VQJmVBw9bTqFDZwIuErTl08mXRidRjxBYXTf5MR4ST3IyKdx+W6FGJBCj7wYKh0xum1ORYHynm6AS4CFIupaLSZUICNGuXTv6nQ1zh4LVM85hEp8y/vnAzkA9zpYRz4G37A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XOvfnGmD; arc=fail smtp.client-ip=40.92.53.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaEXWWmPxI3pNYYwbh4YdgXoulFgq11Uq7zKrTT3nT6wjtLYhf6FfvnYB9ntNDG7vA7if5NnugbJT9yL112lQkW49YvGrWnCaKDV2E5n+XABD5n+Za/TwMnrStPK1c2XFJBX9WjOnS2viMsD+ydTRi/lDHy5i/3rcNF0MlgiOtptferTaz+uns0TJOOl9OGg0Z+NXIQBIzkET2omrYydrpPJTZ9P+55L7ATf2xtU0GFLo7nm8bXigW3cF/o+13JC/XUEFQIUAcxaUFPbCtkuVhoVtxXr1m9r7g6aqXHpBQBOJKPgG96K3C323CuQu83cJCfkliNwG7bLQE73uLvyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaPa4eSviFNFcsOe2bymgmoKnY/C86TkWZ6RURd7nHs=;
 b=WgMsuflNbRjawpSILhL+HslumR3OsoYFAEIYrV/lUNBlO8VlTNnbzN74bcfzeT0oKnhSThM8qYXeKuj7mLGr6oWk8E70QUNKKDMNW9/G2t/s5N/eZL+uoWYSLLYivBjP+K4kttokpuc4FAyK/NxOUWtWF2QqOcvAClsveARHPGQhX6oZOaBE8Qt3JEhzb0Yimhryyid0A+WyPYAlltrSqESAjxvTb1t5fysc6tdsKqR/oIIIK+471vKP9mgxMl1GukEyU0Dd1fbvFjV9Znk3nr15RmmGGJlCHi4TaMrFlktT2iCXWutIPn/vrEwO207oHkCOq2WievWWyAnwV3e7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaPa4eSviFNFcsOe2bymgmoKnY/C86TkWZ6RURd7nHs=;
 b=XOvfnGmDAJZ//0TBIyWkbuM1DOD//NL2W4XQd62ifNb0J6dqBHy0IX9WCWI9CZiu+gSCB3by9XS3OBHsbVnX+b1h9BnJAXdXNkQIMsMPuLpAvCVnYWU860MuH5uqM9r1geArwb50JnkYHkYn7R77mLNysiREAWxwYtYFxNDzVvgbKStmGPu5cE1s0Sg97krYfLsE4vbkb/7tjo8pRq50eN7UJarUk6vX4Z4b6ixufSiSSLAzWA43rkTvCMO6ySvO3ztwkCSIfl2K4FcFVMs4c/OgdHU3Ya+CV0mUle0x3yotDzZ/KDTYcH3hJImU/aoR7PiG/Vi0EspsdlIxgPwO7w==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB7599.apcprd06.prod.outlook.com (2603:1096:405:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 11:53:15 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 11:53:15 +0000
Message-ID:
 <SEZPR06MB695975016141241B1B904F70964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 19:53:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] dt-bindings: net: add hisilicon,hisi-femac
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 devicetree@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Salil Mehta <salil.mehta@huawei.com>, Yang Xiwen <forbidden405@foxmail.com>
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
 <20240216-net-v2-4-89bd4b7065c2@outlook.com>
 <170808424648.2323386.17364036307896639662.robh@kernel.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <170808424648.2323386.17364036307896639662.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [ggJC3P7CoGu4tj4FgcVVeLRt3IhP8o7HY9G9uODQ1zJE2eKA4hgwRHnkplZcltw6Tayr/tYorsc=]
X-ClientProxiedBy: PS2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:300:56::16) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <68eb0b4d-188d-4b5c-966c-712f1dfb24c0@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e35df0c-2192-45b3-c3f4-08dc2ee5da7f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lxptoj0SjoliluSrK2LVLceQtwyYcw296Qkn+GLF8tZ4ihqCscubw/Lhfve63vrmOaWOHfXRXjcKeaKFJO50EiYcBhfBhS34DSMzBlJP1GaG46ivnASLPrs6IF2hJHXjCKYR2cAE8CurPk8UeMGQ/OQTcUibXl4HTLUeF7RcSt/ey3E+5nGI5TSaiNyONAFZl9XC2RC3yItYv5Rq0ID79DdFdUZDBU1pJEcXBsuHLvFf99ydtVEvtjEFgLFxijqalbnJc9y3AN+/GUEosdBxTJ1SIJGwao6jxsvkNgW7MT2wN7Blt/XBP+dfEsHFBPsliphr4Tx0a6kKqNcw4vusyApNQtkAlUyJOvmSQ+N4KJ9yrT68DyHWvZxNa4Vcyt1w144bnDlzedrPcdrCp/aAmouB356ZNOFSb7/dapKw0F/Q/JTuxVS8EHU1XhJNNViBgXQD8VWHBRuJupG5V9tUu8/nyKoAkY4q6UdFOS74Xr78RnKzsBI52BZIKWBBKi2U6zw9ob8Q+P1D1XM9+t7/EmwPs08NbnfbDf0qRRsW2+/lbPQopfV3B5NVfZ6B9aF0hODB2c6tg2119qTfXfqbZQAiGTaj4iYvVmGSN3xc8X95W8b/qfWu677OC6uqPlqoBSH0zy+03xC3nXmgd0E75g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVMzQTVuZ3FNY2pmbnhUbStsM3Fkd1hmN3ZaVGllejZ0Ukw0TmhMaVdaTGkv?=
 =?utf-8?B?VHVSRnhkV01WY255eXc3ZFhkSnVoWG1lT3Z6cGZUK1NTc0VGcTExRUlnV0Nq?=
 =?utf-8?B?cjRYRVRqMkpqQzdYRCtqajRUWjN4bTREZG5XSDkwSDRtV0RZZkR3bDNrenVP?=
 =?utf-8?B?TzBzTGZtY1V2eDVCYWFSTkIrbno2S244TXRjbkpnSFQ1aHQ1UDlOcVhINWNO?=
 =?utf-8?B?OXFQSnAyS2ZacGZrQy9sV1FNQWE1VWlSOENuWmQ0aHg1TlZ3OGlqVVozbUlQ?=
 =?utf-8?B?cGxybjN1TCs2YWo1WmQrME9ScUxtSlNsSmZZVHh3RXNxTWdvWFRhbkRVQVU4?=
 =?utf-8?B?d05hQ1ZnNFhDU0g4R0djK0MyME16eFd3OGxzY09WUVpxNjdUaU9FeEJRMTEy?=
 =?utf-8?B?U1dvN3JjSmRzU1RpYXRPQUs3UGR0Z2NRS2hVbjVvUU5QWTA5RlpYdjRRamlX?=
 =?utf-8?B?eHVqaW1wNzN2djZFdy9QRm84Y0h4T0NWa3ZnTlJxU2t0T0FwZWF0TGxrOE9R?=
 =?utf-8?B?bDBzdWpLSHMrcGc5YnFtZk5PQzdPSDNNc2VXbWcxTlBpdlJOWk1PRExYOVow?=
 =?utf-8?B?bmhxRHhaU3JORE92dDVsRGswWHRweE8zR1d6T0xSZTNzVmsxQWcyeEpEWDky?=
 =?utf-8?B?QWNPNklYTThxM0I5aW81ZFNQWkVhbFh3c0ZrdlRBMkhzcFVBZW9ielRvdWFo?=
 =?utf-8?B?dFVsaEZkNklreXQ3Z1haNXQ5dEI3RGFHSnRLY0pkR1htWGxsS3VNUnVBZnF4?=
 =?utf-8?B?Vkg3QnMwYUF6NUNEcDF2dExSR3RFWGhMQ3ZKeHpFZmU4cEhQTjZkbm4xTjZZ?=
 =?utf-8?B?QTRITlM2MFBRZFZSODhGUHdXS2lNRVBjYjlFTUJSOVN6NXB0TnVxQ1VWMHp4?=
 =?utf-8?B?UHBZaWF5cWRZU3pqRDF5VFBVYlczODRtbTNVNWRBbHJ3bk9ZbG1BYncrVHZW?=
 =?utf-8?B?STdRUkFNRXRYODBOa1ZvbDh0YXdFWFhubHR3cDhOQTczWXJlQ0xYcmtjWDdi?=
 =?utf-8?B?YU1QQzV4LzE3Y0dycU5aRXdnYlJwcHkvOTJNbjE3TWVuQkdjNVREOEMvczF0?=
 =?utf-8?B?azV4Q0Z6bGFNZTJnVmpBZStXUldsSVJ0WTk2UEV2ZFNmN0g5Y1ArejFmR0NW?=
 =?utf-8?B?bTJvc3RYODVqMFVRM2V6Qm5Xd2Z1UWpibXRvaDVoT0NaWU15VzFsNUJlVlhu?=
 =?utf-8?B?cFhEbUg3TmVQRVZHRTlYcVF0eEJsNFVPMVNjUnB4UGVvR3ppZzZKSmVQM21y?=
 =?utf-8?B?LzcrUTlDc0hNZDByWmN0aDMyTDdIUU9jRndtc1Rra0J2OEozbFVJbDBTNFN2?=
 =?utf-8?B?SlpuaTl0aGxOajBKNEQxTm5VcVo5SUtMK3d4ZVF0aHNnMHFtMlZJb3lLVldp?=
 =?utf-8?B?Rlp0aDJWa29XTFY4RDMrVER4K2V2RkFJMXNESHg1aEFCWEZnaldSd2pVUXhX?=
 =?utf-8?B?TGRoOFpmaVlaK2RtcE1DM1Foc1Z0WndEZUdmOHZOeE82KzJ5aHVLRG5hTFFs?=
 =?utf-8?B?YWhHQ2pLRTZKa2czUEcrTE5sbG9ENnJDdWVOS3VJelg2eVNFQXJ0cEovaXd3?=
 =?utf-8?B?dXE3ejJuTW9DK2dLUjFnZktxTjByNDU2SFVyKy9NTFNzY1FIY0NxNWwyQlFw?=
 =?utf-8?B?a1IzdUdQQVJEYitDQ3Z4dmlZQTBUVTc1WEFaT0ZVL3NBcGhGS0xIQ2ZnSEJ1?=
 =?utf-8?B?TVNGSWlZS2tlSlpsd0E2Sm11Z1JSbHBzUkFhaElaRlpsTEs2dFpaTDJHS1Y4?=
 =?utf-8?Q?Is6Twcdf6Z+qJ/ZO82EKHYjijkjTkRl0mp3V9ll?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e35df0c-2192-45b3-c3f4-08dc2ee5da7f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 11:53:14.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7599

On 2/16/2024 7:50 PM, Rob Herring wrote:
> On Fri, 16 Feb 2024 18:02:03 +0800, Yang Xiwen wrote:
>> This binding gets rewritten. Compared to previous txt based binding doc,
>> the following changes are made according to the TRM:
>>
>> - No "hisi-femac-v1/2" binding anymore
>> - Remove unmaintained Hi3516 SoC, add Hi3798MV200
>> - add MDIO subnode
>> - add ahb bus clock, phy clock and reset
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../bindings/net/hisilicon,hisi-femac.yaml         | 117 +++++++++++++++++++++
>>   1 file changed, 117 insertions(+)
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/net/hisilicon,hisi-femac-mdio.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.example.dtb: ethernet@9c30000: mdio@1100: False schema does not allow {'compatible': ['hisilicon,hisi-femac-mdio'], 'reg': [[4352, 32]], '#address-cells': [[1]], '#size-cells': [[0]], 'status': ['okay'], 'ethernet-phy@1': {'reg': [[1]], '#phy-cells': [[0]]}}
> 	from schema $id: http://devicetree.org/schemas/net/hisilicon,hisi-femac.yaml#
> Documentation/devicetree/bindings/net/hisilicon,hisi-femac.example.dtb: /example-0/ethernet@9c30000/mdio@1100: failed to match any schema with compatible: ['hisilicon,hisi-femac-mdio']
Seems i forgot to rearrange these patches. Will fix in v3.
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240216-net-v2-4-89bd4b7065c2@outlook.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

-- 
Regards,
Yang Xiwen


