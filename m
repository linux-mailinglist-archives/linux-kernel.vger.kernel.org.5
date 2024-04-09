Return-Path: <linux-kernel+bounces-136431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A885289D3FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDF91C21EA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210517E0FF;
	Tue,  9 Apr 2024 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Bn8KX+z7"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020002.outbound.protection.outlook.com [52.101.128.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB387CF17;
	Tue,  9 Apr 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650562; cv=fail; b=bxBukVA0YIzop7UR9sBHn1lJDju99pjwI3sSlosLo4nw+fOHhlod69id8woA8ll9d84Hy3jGSFge8SbuMDvh35y7jYChNIwLe0VAJjp5+dgISG9SkfzuFZghbLR3DNDH3sPEmmmb5jgtMhA8ANeaxfxtisr2IMol9v8QHYmp1j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650562; c=relaxed/simple;
	bh=hMkDl+UvqZuSqUYNjC8sq9hSeCgCSG+Nx/QWvXx6RDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eTVyp4W8OJ21ikeE9ki8Epxjgt+BTs27h3ZMGJF6qb3z+TyOMUGN2vJrtozNW8r1Mc4FVtnhLsxrcVHHOf9GnHLsXMZdV4U+txQ1zKt+RzosfX8WvS1nXLhOAXl1Vsk+OqeME1EpCHutItqO/0WjhZ2b/QBMxFS21nF9RDzXvvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Bn8KX+z7; arc=fail smtp.client-ip=52.101.128.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBXT2nMTK4Mw4qxsWOtPkL+wydpKyPb29w9udHqiWn5LHWO1LfZsYFl0bT3tGg282ab1aAgc+Cg5rDxB9hx0vMd5WnH+89O3HGhqG9/E0WGGckVcZE+mBwBY2Rs92f0W/hFJ/z/jilgtNWR3IkM+QE8MKBSJrTCfEwhPjB/RCYxzivK96oPB4rVX6+mbjGpFQsB2rt5tHGkex690oerkSwylfjmkylYajhPrZmSO6gwHDzeLD+kZPWq71fgkheIDHeOZHh3ic3XrxXZV3DtYdE5AAoonmbUQf2bMzLLVgldRi0vDC9sL6Rh+nC9eGqwqqWKrT2HNMt+CS7N56pHdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukNaMHR15lWIyUJBrhy5LsSuB4h5zjuaeaY3gONE7t4=;
 b=KIhXX6HijlaQjzUrwGF/6IBjE4cq3eaFNHp0WmW2pZYJbRKfc4S2WfGlz4Ce7FXFIKBM8LbjWdKN/t19Oivl/Zhz06V7Q8MeUIQppwe08Dfw1jmI92W+19lKSDgTaZRiX8o4VBJjp1mIr/koazL5JMyO5cCpnLzWntJGiL1GI2NCD/VZ/9pJhEo457O/fjsnBp6x1GXjNMYp7mQDPmc8N7+BOqARum3PHjSwqIpJjOmEp1hdiNhNemBhtNgEXnqEZPcVRED+bmub3MVuH687XD/lzfpSQe/U4sOdZD50zrdXfB75/v5f5kEpChgjUSJGukQUGRruwBdBaFZYhQ3OQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukNaMHR15lWIyUJBrhy5LsSuB4h5zjuaeaY3gONE7t4=;
 b=Bn8KX+z7Ir9dx06e56IjjvmBefYJnb0ngPpQCqkA+PMrMlsJTQvCq4wWesvXx9WRlHGYo4wug0iVXmjs8Mc1cZ2+G7RM1qeO/Wzst1Ewn4vie1ad4SYawm8sbOxRVUIKG23k+oIkw1cx2DqjN1bcQqknkInb+tLf9/NO+//ObkpkRPl4CsjuAApKcpO/3t8Cc+CS7bmnXoRfLXj++shLZSNBJSWJdzz4+uu4mB8aA1d3I6cyv7QYuONQg1h5NCSJb9jSKL1eDbT+eNTjVPFaW12a2U+ZGKGKAzIFO4HDQ5793v2EsqlJXOD9XkW0jj2+GhJLdwzywH5jYBhNWx7OyA==
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com (2603:1096:301:100::7)
 by SEZPR03MB8966.apcprd03.prod.outlook.com (2603:1096:101:248::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 08:15:56 +0000
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::ecbf:40a0:335e:cceb]) by PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::ecbf:40a0:335e:cceb%6]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 08:15:54 +0000
Message-ID: <f6de7d87-ee23-4b65-b0e5-cb5217ecc692@amlogic.com>
Date: Tue, 9 Apr 2024 16:15:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: meson: fix S4 power-controller node
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240408-fix-secpwr-s4-v1-1-01aa7ee72c52@amlogic.com>
 <CAFBinCD=xWuhoX9cWcKU3bSGcsDShKbxnMVTdyfD84AFZQn8aw@mail.gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CAFBinCD=xWuhoX9cWcKU3bSGcsDShKbxnMVTdyfD84AFZQn8aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PUZPR03MB6888.apcprd03.prod.outlook.com
 (2603:1096:301:100::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB6888:EE_|SEZPR03MB8966:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9iqHaLeJ03ZbkLZJD+fCZNAW/6aymQogerPRdbqJisEI64ycEDsODZFsWzNtX8qN0PvuBHQG4bPvnuBVaK18BBwkIwEndMbq1LE3ctIITeeqfTYhlvIIy8xAgo2oR2b/8DxptGKf76hBYMh848mvWvDooSSSYD1M1ALQZpBQE2lgjS6UN3Dz2VRsw3WcplUfLwE0dR/TrZaIYdqk0WHyc5HZm7U4AxiQzn5ysaNhS+zjXEwklsUdnMdH/1+wLyO1LrjK3clSEeSyvm8skAOn4oXpqAx8Mvxw3W+YqcnrJ342hzcQ3X4KR00aE7coYEydAlUq0FQAGxoP16KpOQV7sLfgG8Png+fcF9CcRsUMWGUQjTWtgcmZn7FtIfbO3fOGKw5JCtneUgMdXDJnA29iVu+oXwXW6MpGFCU0W0F8VVfN7mI5gBh/vGLYf9Ilf2w1cmk8QUXTqA5ZqrYMOlq3L815bKEjhW5zcAkbWmmcQjbITERL6L6yChVflZeMq2u+z8XYOWLF5gUZiEoo1Fi/dl2l3MVz7sGC2YbV4U13bHz7AQDFa61UTRtGF0Wur9hoSW6PEv/i6iYWQuGlOd2Gf1S2eY8XS/KC5Cwg+DKgMEPEEaRgpnaCN98KOMgeuPxXeN/9dmtabyeKYqgvX9Octg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVpTYm9FMDlGeG8rQ3MwOFE0Y2hYckxlY2F6VlZ2U0xYZnhqL3ViczlpVkZo?=
 =?utf-8?B?S3hGbEtZQkM5QkYrcHJ2MWVjNE8zWDhoMHNnM0tmTFVvcGRSUytWdG9PSEZG?=
 =?utf-8?B?Uk5RVkRRUmthb3N1MWgxbFVCcFZta1diSGQ3cDB4RkthYXlZTDNySHhVYS92?=
 =?utf-8?B?V3MxY3RxMzdzWkltc1pZei9zUW1aUnZRN0k3MlIwOCtFZzQvNlpvMXcrRWxV?=
 =?utf-8?B?Ymd2T3lwZWdXeFFuQjdPSCtWVUxobUxVQ2pOQ05EQ3pRK3pBd3VRWDlmRWp2?=
 =?utf-8?B?Y2VaOVlaNk0reVY3c3RadjRxTkIvazJxejZZUTNOb05VenBXQmxRbXdhaW1G?=
 =?utf-8?B?YzRYM3ArYVorajI3d2txalJqbkkrSmdKa3M5cWJjUU11RVB3ZXVzaXdJSGcz?=
 =?utf-8?B?N3kzNDd0Vkp6bjdaS2U4bzVoaWN5WGEwaDR0aVM0Z1A2NXBCV3BlV0ZlQmVx?=
 =?utf-8?B?eVNGMWFzSG9xYlNFNzlZQ09kVlI1NnJ1YllMYjlZTURmWjRXU1VoMHptNldt?=
 =?utf-8?B?azZlaWtkZmRqZlZhR1c0dlZ4bmFEYUE4RklzN0lCamM1UzV2ckFHVzkvR2pQ?=
 =?utf-8?B?WmxZaWVxa2J6VVIxdmJPL3ltYzRacVhYNmlYTjhDeDlXRDlMQXJmTURXNU0r?=
 =?utf-8?B?N2J5YTloMkxzVUNpZXlsRVp2OTNQak9LM3N5QTJOU0dJdUM3aUoycjRUcmJW?=
 =?utf-8?B?QUlwelJOZVJZVXNFQU1CWlIwVitXc0hKZzArZEgydUVTTnNnRDBZcW93andq?=
 =?utf-8?B?UDYvRGkzVnBXMjJuU0lhcE4ybnViN2lBTWtIQUxVUEpaNWFNM2VsZlJNaHl2?=
 =?utf-8?B?R0p4MjVSS0dka3pEODZ0MElBU1pXUDk3dTNhdFNtVmZTcUNKa0NSbFp6bm5h?=
 =?utf-8?B?Wkt4enkvYlE3dlVWaFY3ZW9tSHY0Q0IrejRNVlAxa2NGcTBoaUxvWitRd2Zk?=
 =?utf-8?B?QytvVlBuVHpnMndUVDJkWSs2R05SUXBsbXA5NDNYUlI4VzY2a0Z5dlVFYW1t?=
 =?utf-8?B?SzhxZzliajNaaHBVUHhBeEZ5U2wvQUJkbDE5eVFubHc2VTF5d1h4bzA3MEtV?=
 =?utf-8?B?SmpXTllVOWVuK05KOVY5c2IyOTY4Si9QaHI5bC93ZEJUbldybTE2N2RXMDI0?=
 =?utf-8?B?clp2dkl1V2pFS1VxWUEvVS91SU8zaklYYjBpbUI1U09GMFFTR0JMeDFJOWIz?=
 =?utf-8?B?dlVzVmlqTkpsamlFZ2RBYnpOV2FnUGc1SytGU2JXbzFVMGxleDNDQUN4TUdY?=
 =?utf-8?B?TXQvSXhRR1oxYy9YTmlvbXVXc2twYlpoTzFMT0hqK0loTE5VemlQR0lrZ2JP?=
 =?utf-8?B?Mlh6dWpZb2lFbWMvOXpiQVdsdnMvYjhvWTZxUWlNeEd6Kzd3eHgrQmdKMkxR?=
 =?utf-8?B?dVBoVXVkQ242WEZkZmRQSFdFclNmbTRGYkdiRlpkK2RZZmtDbjl4dG5kNVlB?=
 =?utf-8?B?RnFBM3M5MTlSM2phK0ROTVFJRFpGMU1mTmxqK3ZxaUdsb2ZNMHRvRlR3NEd2?=
 =?utf-8?B?Yk00S3B2SjR4ZzIxaDZJSkVaUFQrUmVma3FmS1p2MGJleEdFaU0zc1dCSWRo?=
 =?utf-8?B?U3dpYk8xN0piaU5ZbjF4aWl2NjhqK1YydnIxalM5cW8zVlMySkNOdG9UVGZE?=
 =?utf-8?B?RG5uWEVvZ3lVWnJGTWxvK3kwY09yYmhzRXgzTGp5ZGNOYkl5OWRpaUMwQUI3?=
 =?utf-8?B?L01tTWQrVkl4VDBKQlpzK2JsYVAwcXFZQlVWZDJhc3RFMGZKQ1hoVk1KQjR3?=
 =?utf-8?B?Q0RmWmdVcVM5bTVpVGE5NFR3ZzRSMFlTR0JGY0hlczJyTWMrak50NldiV1lv?=
 =?utf-8?B?S3REbldJMGk5d3BrVnpGNlFHWTFCK1VNOVF2a05EY0F0czFYUE9pTUZXeFAz?=
 =?utf-8?B?OW8waGxOYTNCSmdPOFVGczdsUDJVMFBkVG8xcDloZ0x4SVp6SXZiUlV4VjNI?=
 =?utf-8?B?OGdvSTQxejh5dkJHbm45KzVxYVZUMlVWa2pLUkxrV0ZQOU5ZWXo0WHJxeC9w?=
 =?utf-8?B?aldkZEhqY21HS1VsM3BCTHdkWERDYVk4NlhFekUzUi9pbEVXSFg0aUhBV1Fo?=
 =?utf-8?B?a05hNlN6SlpRUFBUU3JPcXRDRVpSanhRaTQ2Wkk3Vis4SGF1SFZrVEx1U1NU?=
 =?utf-8?B?K0J6ZkgyOW9tVmxWa3VaL25ZeE8rNmpqcmlURFhZa3NEcktUNEw4QnN4aGxG?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7976467-2651-400d-a69f-08dc586d46d6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 08:15:54.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJZblcbBkWSzQ+YOmXF+FlLensK2fG8Bcc02XVrakjylWi9D5s5mvRi3ubO6y8zb8GJi4Kw/WgNP9fPKRpC3sza3h1KRaO5tK95pCU2Xsgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8966

Hi Martin,
     Thanks for your review.

On 2024/4/9 01:27, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> On Mon, Apr 8, 2024 at 5:26 AM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>>
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> The power-controller module works well by adding its parent
>> node secure-monitor.
>>
> 
> Please add a Fixes tag here with the original commit where the
> incorrectly placed node was added.

Will add Fixes tag.

>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> index ce90b35686a2..24d00dce4969 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> @@ -65,10 +65,13 @@ xtal: xtal-clk {
>>                  #clock-cells = <0>;
>>          };
>>
>> -       pwrc: power-controller {
>> -               compatible = "amlogic,meson-s4-pwrc";
>> -               #power-domain-cells = <1>;
>> -               status = "okay";
>> +       sm: secure-monitor {
>> +               compatible = "amlogic,meson-gxbb-sm";
>> +
>> +               pwrc: power-controller {
>> +                       compatible = "amlogic,meson-s4-pwrc";
>> +                       #power-domain-cells = <1>;
>> +               };
> In Documentation/devicetree/bindings/firmware/amlogic,meson-gxbb-sm.yaml
> the hierarchy is:
> firmware {
>    secure-monitor {
>       power-controller {
>         ...
>       }
>    }
> }
> 
> Is this patch correct (and the documentation needs to be adapted) or
> is the documentation correct (and this patch has to be adapted)?

Will add firmware node to adapt documentation.

