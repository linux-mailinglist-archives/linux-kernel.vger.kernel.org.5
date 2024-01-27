Return-Path: <linux-kernel+bounces-41135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DACC83EC5B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6826B2249F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9881A1EB20;
	Sat, 27 Jan 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="WxibsUTF"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2113.outbound.protection.outlook.com [40.107.104.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57571E889;
	Sat, 27 Jan 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706348442; cv=fail; b=NMajPIAZdQ8NdUaPSa4qF8aN2y6N2RQlj29A7Ie34AbVG8cPhwifvggkjIllqPp+aHgxPsU6mjCm7q0LTEH7EEVgmo72kodOkwn1Fp5ZpxOzHQQK9dY+OnkhDKmfy5VGHCGY0Er2C/rrjPvqlkxC0sHoo+7RoV2QQu/mA1VoSM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706348442; c=relaxed/simple;
	bh=JCi2cu1PCGVDcniPkwq4G0vJ52DuIp0dg/QlhtLg164=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lFiIRkpUfBFKLAPFbDiV0t6x7kYJ4DOloBqgqNQfZXz1FnI7zuwhPup+P9xC3qj43VW4d9roizC6cu2btWc0ShxrCp+t2rycZZWrwbsN4lLW1mu9Q2v7zwC1FAGmpfAgjzHULk14jjGUdM8ccLRCNBB39S0fxdogSUFVfkKButc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=WxibsUTF; arc=fail smtp.client-ip=40.107.104.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVPytgLbQIyVk26Mh6RfcUxD/QSU7ta1GtUKO6KojHbc1jS1m0CnSIVBNvovT8ptWmjGf+ANjJCKl02VGuerB3PiZME1wzMiM1ufLkUmU7NyjmvuXMT/Mjc7pXscXWlnIZLV9kOGtlqiiLfYNfj9r8ITjB5uLVjDbssfkdtdap1SsWOzBt3tmNuzysC80EJpnSWhZei5t3TaUcbln7bj8wAT39hykFVzOD0wj3wrLzAZXuKE9vvx+52CqxJw9XrgOP3561rM1nyN/kZ/SpvyxUt5d5fpfXS05DXvfvXAYC0RP0wTUniw6Vuf4anliVYCm+ZEUSOw+SLHXnl7YzK3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqaLcWwRIWM7gGGbDzdJg33+UrTSaPhdXBHQV08uI8c=;
 b=OmNVCKosziLRS4z6etSpoghJ4HmE6ufWvRncw48rL2J+qkXcKwo8YQTn4sjqaxiypPxj+E3y35O0Soo39gVuUs8rLzmAs7/CtkzR+RCPPGlW4Icv1UIWBKAIPmBSs1XQ29OmF1oNFh5mHNyhQzxgbNLWGVmdjhhnDVWoI0VHM9Jg8ky43fzKFtg7UXW24Ag/8V3NPJqNYyXnedZgki2RVPy8DhZXQ8U3kd5RNLcr6OKc80OZg9VL17V5BoarAn4+b1Nr/VsoQn50WmEUnQn8SpyVFFsWhCiRMoywSmG795+Bz+l5SxzDD4jAmjPPPnCfO+ommkY5g9gWp/crpqXpQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqaLcWwRIWM7gGGbDzdJg33+UrTSaPhdXBHQV08uI8c=;
 b=WxibsUTF/lHuuijt7K9hDCuoqkT1KV6nIHAxjBw7Mcmfi9XSMHasGaLrmF4bxqesjR7luy0nx9MS+s+M1G6fwHjAIYzW7RDq16ZRS57dzQ0L/s4ecH0wHWrKIURgtTnFE1S5g3WHvINXgnbg8eakZQWEGecyLxaE408xqdHxxKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by PA6PR02MB10685.eurprd02.prod.outlook.com (2603:10a6:102:3ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Sat, 27 Jan
 2024 09:40:33 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::4c56:a71b:d42d:11ba]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::4c56:a71b:d42d:11ba%3]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 09:40:33 +0000
Message-ID: <536971eb-51f0-40e5-d025-7c4c1d683d49@axentia.se>
Date: Sat, 27 Jan 2024 10:40:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
To: Conor Dooley <conor@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240126115509.1459425-1-naresh.solanki@9elements.com>
 <20240126-cinnamon-flatware-e042b5773f17@spud>
 <CABqG17hzZf2mme0v7hALhpd6-N3ZHqxdH-AhFg5eF9sbLSC2gw@mail.gmail.com>
 <20240126-scale-serrated-33686467d91b@spud>
 <CABqG17jp6YRGyTmNitz-xDdyhWOPgfT_XpXxw-OJLnXQ777vAA@mail.gmail.com>
 <20240126-blaspheme-calculate-a4134dc1ed68@spud>
From: Peter Rosin <peda@axentia.se>
Content-Language: en-US
In-Reply-To: <20240126-blaspheme-calculate-a4134dc1ed68@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0095.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::13) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|PA6PR02MB10685:EE_
X-MS-Office365-Filtering-Correlation-Id: efda6bb6-b68d-41b6-ef6e-08dc1f1c01c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YKXwL8kpnDTa+TBqJcUiVZt2XhUoFOSVempYjCggLeRvE8v+BRVzckDKBDP0BRMVwAjREn2mQt40b+wmG1qgZ+6tdtESYZiXok+mIiHZKTNagy2QR+H4kA6qA29vQXPIT7OVNrmh3OSE08rnRpyA5vjCNzd9i2eGKRuawEiGXFx+JCVMOjga81JXk7RDsaFGlYEiVpfILJOZtx1etzoagGkqnHKtRp+TnrF5coyKg0wMqBGYC+Frw6EFBnoUPj1ZAl+Ku2Ggsr1ZiI9/qdTh8fdhe2Bcc7q5K/5QAuHIaVQi45tBu2re77iUTO9htZAB+rTZceTlYbIqYRFUcjf8HN2j0xPESsMjrZc83degqVYOynD+t/jSwIGtYugUVhsP3gLaude/amCG9UL47qcNt+MKPOIO7o+Sw+EiLqqD8FqVgR2y4IkA9WWdGFM7QxFq5vVYDmJ5loccThlo4kyEfCWYQq7LuMvNtZSTqkgHFS+spxZZ0viszrbUABOaQomTPapGk0wN2n070JWQqVvNhzMIFeCdFdlTPUlaxG9Z1f200gGzw2kx7ayG6CTvU4FXnCZBO7NztK0aexnAk+yp5J565oKUHf4he3VxUeCWUt3KU8Ho2CtwG35Woh7E/Nii3GSew8mO2d7I66LnhC8AlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39840400004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(41300700001)(38100700002)(6486002)(7416002)(5660300002)(2906002)(110136005)(66556008)(66946007)(54906003)(66476007)(316002)(6512007)(2616005)(6506007)(36756003)(26005)(31696002)(86362001)(8676002)(4326008)(8936002)(478600001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlFQNmd4TG5TR29MREVBd25mR0dGYnRPNlZVWWNEMDNFVmhMZ1J5dUxCR1h3?=
 =?utf-8?B?NHBHRXJCYlBMaW13V0tRaFo1YTBXZ3hXNWRMSUtKRCsrbUlhbldDQTQ3dXNS?=
 =?utf-8?B?U3AzcFBPS2RxaGp2dGhQSTl2V3crbnhxVFJoSVpyRXVBQTlKYmY2YlhtR1Z2?=
 =?utf-8?B?VUtJUFBvcEt5Ri9vUDN6TkFCVklOZmtCYWswUDJLenlaQTN5cHRxSUxrdWpp?=
 =?utf-8?B?ZjlBS0EwWDUyeFpZajFYeDRleE1TMVVwaWlOekl6aVZQYU1lQ2FQdGRwTWMv?=
 =?utf-8?B?SGtDN2pZcXJxQ29qbjhjZTNBcXFiUEVlRHZjOVRzS2RxMG90VVl0TEhNWk9o?=
 =?utf-8?B?UDRQSUwwNHB0SUZyY09sTHliRGZuUU5DKythMWk5aVh1WlNTK3ZrNjAzV2I4?=
 =?utf-8?B?YkhLL2hJUnNPSmwxM1JudEppRHVub05lTGtHY09TVEV4eGtIZjRYTWY2cFhT?=
 =?utf-8?B?WnNVRWxhNk1lTmJ4SE5GbXJDa0ZqRm9GNE9PdUliWGplZmxIeEFibVlZTUNB?=
 =?utf-8?B?R0VuYkluQ05HYnFvOEl0VkpRaGFLVEtCQW5rS2tYa0FqREJHZjZUY2ZOdWZ1?=
 =?utf-8?B?SlRvQ2pVVGFYYjA1VTV0UE5ZYkxHb3JBcUVQTW5CUWR4L2lpbTJUcDFQcFMx?=
 =?utf-8?B?WDY0WXFQNDJ6YVRPMlRwV2oxU3RJOUIxbjZFNDRXSjB3VFcwUWFlZ0xwZEdF?=
 =?utf-8?B?b01NVFQ4ZHU3amIydFQyR25Mb2hnMEtBRGg3ekdOdHRCZW0zMUtabWtQK0pw?=
 =?utf-8?B?L0kveGQ5YXAxeWtvK2dZajM4aThSVmNCVTVxYWVCckk3VFlLZVV3RnR5RUs4?=
 =?utf-8?B?ZWUxS1dVT3IwWnZNSnBweThKd3BoZWRYOFk1OWFId2tJQ3BVVWZNNkw4WHBp?=
 =?utf-8?B?djFITVlqRDl4ZUM3QVlibDhOb3BzRi9CY05FcVRpQURJRzhSMW96UXpNdG1N?=
 =?utf-8?B?MXhoTWdUK1Zoc2VxUTFYNkcyTzdLZTB1anBhWE9leDA0YVF1clhjeDRIcElk?=
 =?utf-8?B?YVVUQ09hRWV4QkY5ek9raFk2a200MHBTSFF5Y05wSTVRVm4xcVhlZkN0NDR3?=
 =?utf-8?B?bldnVFpSQjBXOTljcHZIVGxkWHRkRkltRnRtTVdaZnphYmFSNDN1ZUtOMDBH?=
 =?utf-8?B?aGxHempFd0pUNHBtZmMrM0RKVm8zMjlvS0xCbDVwSW44MThxUzZhaGpRRUhq?=
 =?utf-8?B?L1FzVm9hQ3p3bmtMWXVyWHM3Q0tDUEdUMkVBa3FJUkpWOU1lQnpESGMzTEVP?=
 =?utf-8?B?ZnFjeHBxaWk3U0ZjdmhRUzFNa213RFY0MXdXR2xpb3QxRXhmZUFUNTNtM3M4?=
 =?utf-8?B?N2QvTS9rSDF6Ry9pbHFyQmNYZ2dQemJtbVVXemxuR01JWWFBN3B0aU9nVG5T?=
 =?utf-8?B?U1FXV1ZQZThxM2FFN2VrNmtLRG1FclMzUzkwN1lYY0RDcDFnR2hvNUcxelpM?=
 =?utf-8?B?S1NiNlBqRFlGNlNNdFQzRXNBVkRvbzZxNWM0SjlEV2NPN2hmL1JUYmpYWXZy?=
 =?utf-8?B?VHVOeUdSeU5QaStyd0xhTWhkRU8xRGNkc1liVHBMVEJkR2xPaXZIcVNvSUha?=
 =?utf-8?B?bU1kK2tzUXpZNnd4TmFISzJvbWg2NUNWWk9IajRIcnRkUHFMR01lcU5rTkRX?=
 =?utf-8?B?aTNqejN1V2ROaFVtK1d6L1BLdWVTNk5lMjZnSnJaL2tyVWJreGRPZFFqdVRy?=
 =?utf-8?B?bmZkQUtkTmVUZHZGd2h0ZVNpd0FzNDhTLzk3WFVqUExOcEhFdnpvQzJxTmRC?=
 =?utf-8?B?UUVJRUhFc3Z1WXl5V0xZMEcySkNDb3JTVUNIdklTdlZMRklxV3Ircm04N25s?=
 =?utf-8?B?VkY0QmdDeGl5RlNLTEpUOXBrc2V5OTNRTW80a3dpL2l5UVpsSWsxWHVtbDE0?=
 =?utf-8?B?L2ZDVUVTZVFUM3NXZ2tTVCtDUzZ6YUZqeC94Z3BwN2Q3a2RFZVQrcHdkMExY?=
 =?utf-8?B?dHRDMSt4RytNcUwzazFRSWtQTEl3eU5LYWc3MlpUd3Z0ZHhueERNZTN3QzJZ?=
 =?utf-8?B?OFVia2JvUDYwdTh3aGd5dks0Nkxiclo1b1pIM0dpUUUzRDZkQUNVWUZOSklE?=
 =?utf-8?B?S1pLU1FhalZBWnhKdjY3VHFZNE9HODhkc1hJaVorZFZkS0xkZVRzY0lnVXlJ?=
 =?utf-8?Q?mz/SCAQjMw0YG+l9uwrw+MfQU?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: efda6bb6-b68d-41b6-ef6e-08dc1f1c01c5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 09:40:33.0247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lz2DjOBCbyQ5BrBraVJCpj4TWSUbO/28I3Hu87CYkJ7TBDTB3KzcZ3QRb19U1V6b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10685



2024-01-26 at 23:14, Conor Dooley wrote:
> On Fri, Jan 26, 2024 at 11:10:36PM +0530, Naresh Solanki wrote:

> I did look at what you have there and I think your dts is wrong.
> 
> The iio-hwmon binding says:
> | description: >
> |   Bindings for hardware monitoring devices connected to ADC controllers
> |   supporting the Industrial I/O bindings.
> | 
> |   io-channels:
> |     minItems: 1
> |     maxItems: 51 # Should be enough
> |     description: >
> |       List of phandles to ADC channels to read the monitoring values
> 
> And then you have:
> |	iio-hwmon {
> |		compatible = "iio-hwmon";
> |		// Voltage sensors top to down
> |		io-channels = <&p12v_vd 0>, <&p5v_aux_vd 0>, <&p5v_bmc_aux_vd 0>, <&p3v3_aux_vd 0>,
> |			<&p3v3_bmc_aux_vd 0>, <&p1v8_bmc_aux_vd 0>, <&adc1 4>, <&adc0 2>, <&adc1 0>,
> |			<&p2V5_aux_vd 0>, <&p3v3_rtc_vd 0>;
> |	};
> |
> |	p12v_vd: voltage_divider1 {
> |		compatible = "voltage-divider";
> |		io-channels = <&adc1 3>;
> |		#io-channel-cells = <1>;
> |
> |		/* Scale the system voltage by 1127/127 to fit the ADC range.
> |		 * Use small nominator to prevent integer overflow.
> |		 */
> |		output-ohms = <15>;
> |		full-ohms = <133>;
> |	};
> 
> A voltage divider is _not_ an ADC channel, so I don't know why you are
> treating it as one in the iio-hwmon entry. Can you explain this please?

This is the exact intent of the voltage divider (and the other bindings
handled by the iio-rescaler). The raw ADC reports the voltage at its input,
which is fine, but if there is an analog frontend in front of the ADC
such as a voltage divider the voltage at the ADC is not the interesting
property. You are likely to want the "real" voltage before the voltage
divider to better understand the value.

In this case it's much more interesting to see values such as 12.050V
which is presumably close to the nominal voltage (12V? guessing from
the node name) rather than some unscaled raw ADC voltage (in this
example it would be ~1.359V, which tells you rather little w/o rescaling
it first).

It's all in the description of the binding...

Cheers,
Peter

