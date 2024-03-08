Return-Path: <linux-kernel+bounces-96621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D320875F02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604851C221C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BA351028;
	Fri,  8 Mar 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qsmycdyU"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2040.outbound.protection.outlook.com [40.92.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1994F61C;
	Fri,  8 Mar 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884966; cv=fail; b=lfATImPpc/ylDY0GLwg8QrWVZa6jYCiW0nHvoLwXvMcqLv68CdbRtFZ6R5me7vp9JhGcZ+lrtvbnJBkVXZ7/1OqD0ru80yVavs0v+2s6g/i96/ZNtvxJWfMILj/Wg3/OcqEzShM0FY8Oq1WE0bsKMx7QElAZi0Bb6TYCy8mlbes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884966; c=relaxed/simple;
	bh=2HvfiLV5ISamRG+AnuRpa3nSpzwkCqmWWrm06BBLFog=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L4I+J8o4iBoV3iXDqXpuYXO3DqR+JXHse//bMtqgLyCkx/yUYwB5fxPE7/bXpp8WfQCtsobwIZnJjxgXMURPvEwpD2MUGlYRc2MauzZVeZSvEnlMBePNDpkw91EWxEZHMR5ZRxb6IPtnWA47ueUQ9u1uKHei7E79pyoxYiibTzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qsmycdyU; arc=fail smtp.client-ip=40.92.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOeUMoTv9HwcQExfJV2QAI2W5zl+P88yzhIpeHmi9y4DljZ9aSCqB2qsJ9yMGMtH+jgi/tI1e3Vzmf9NJ9+hZyJc8BCMqM/LtVvaIpeErZpVxy+O7iTBRz340vxUix28snBHYheCha4//UnF0C/Ew01aJd+l+iOHrK3U1iD0/Qm+5Lup9AoCyQ9TPu1oOu/rSEWX3SWBYedPCahqTkGVSBBaFW5D/qT0NLN0tRwGHA3lCXnQSXCQgRXlULA6vP9rjWOq5PYTDPomEH3MNhNCJnGPkH8NcQ0SLhPN44kLgUp7WPICeq2avedJ03YEOQQ34OM7xZkiBl0puWJ5wJ/gjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mwvu3KLKI9ryt2JY7seMDpk1IGthoLOuXP8VqIZv5Zg=;
 b=Okex6xwVBlUhkiGueMhonr+K+L5nmsHz+T+OlWUoKvkCC8Ki6LAVGLJGu9m2hjUI6zXWFtldqgMfqQwCzwMfzYKVh7Qr7/wyn9R78Lpq/NrkuhTziFVqm5VmGXnvwq7TKDhvQhk6N2DujP1azr7zhxmyM4zuOyO3OzuiVYm/e7CkzUdODcja9DIWpYBSy9+Jg6tCb97klUvvM98f51CfVowBpnCBpYtLLD1doNLT0vLamMcYlVJPAJnngrqyvHHJiUbg78re/rr2UrFVU6ohtXtSku08K9LvIXK+6uAf4QvqthTu0NbLdCIRn6bxwew4kWTgMMscgcH/UBM63mo8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mwvu3KLKI9ryt2JY7seMDpk1IGthoLOuXP8VqIZv5Zg=;
 b=qsmycdyUm6P9CCBr/22kLamq/5n8Rx+XuUhOtW+McPzxoSPqOMsKPp0ybVVKAquego9443tKxwhhJhV0g7gPcVih7J7EYTown/U0gHAxXVwSlXpybK6vfRFSxwlWo6MUndwEkhZv5mvHxdcUbdZuyQR5PgmOM97zzXSJL/c5ygt/6Zl7PlQ3xN7uoBUOCiJHiBtsuhG87HRlvBqhqutV8pjWvJU5LhGXiV92rppcMhdK04kwDKKl8JPVRHTQ6sr3bCAFMdEoDqL+BxH8XbJvXCFy+VNE/3wGKYc8Ng1o+wTmQUpb52/iIPCPcikgI/Jrue+YqP7FB12E1rRGRBqoIA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB6983.apcprd06.prod.outlook.com (2603:1096:101:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 08:02:39 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 08:02:39 +0000
Message-ID:
 <SEZPR06MB695939C120C504830B04430A96272@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 8 Mar 2024 16:02:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 6/9] dt-bindings: net: hisi-femac: add binding
 for Hi3798MV200 FEMAC core
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
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
 <20240307-net-v9-6-6e0cf3e6584d@outlook.com>
 <272fcc64-a22c-4f19-8172-d1959276547e@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <272fcc64-a22c-4f19-8172-d1959276547e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [yP8a9Rl9ItoEk0ds8jqzONHYq4bQtVG/rcNgNfKjg1saqFhItxI/rqgmT4E4w7uI]
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <4d383bd7-ad65-41af-a5ca-fed4a418af89@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 96be0690-0ac8-467f-5aca-08dc3f461f7a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9itbjxHkgZG+ErRbsSnMyjYePaozDtfy3ZnktgeZmYJmZc7UwVzB4C6X6jFFIDyFFpQizWMsNq9gkfgWuKli9G3ARyYrjDhMKAjphBpBAfZ+S4wb15BB6k1ssHKlkx2n3JkdxGoAwvW35PlUB/HbS6BOxyFAzNqHpycavkOnjP9cZOraSTSnBJwl7ZY0jzIh+dyTW0ctyh9KwXLa2aCD5CZeb7V+qdg8ib43CcMvAhB5+NTXOF3dk0muDwOzAN5yUXxeXNsvVyLEVdbmPk7rjKXUxjFrBJhP+gNKvbA99Nx2Bw65Oo0pCz3pkXi0gcZ4V3WEDZupzHKBME/U9JfsA/Dtisv/mM9dL2m7uEX68C4vor8ndpSJ0qXoMjPcVd4COnC6AIj0gKXahlFatC1beujMS7LtSEzfl7IrPJLv8SyxgE9smMuDPsOW4DLRkWdlw1rUMwZ1aCq6k9ACzlNb2jgk/QOChm8N6M4MeXdZzp77V5wUeOFjKt1tbg3l7vdqfjw+39vZWvzGpBkMnb5QX0MPHpHxoeoJc/wYsJClJau8Uqx+XKW3udbfhViA5xbZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGN0V0x6TzZqd3ArQzEvbkQ3SklZZHVJR1pqS0xPb3hTdWpNbXl0TnR0SkFQ?=
 =?utf-8?B?SGZlTTJDSjZZd2hrYnZweEwwSjdDOHhJTUN3c1dWY0V1bXZBcTA5UzFEeTUy?=
 =?utf-8?B?M29VblZRUzFsNStER3FZVk1BeTJJV2N2dXZ6b3V4bm9LQ1VFYVZpTVE2NFk4?=
 =?utf-8?B?MkNrYXZ5RVFMOFJFcWJqQXBtSDIyRFVQdWVHa2FmcVk0V3k1OUJUcXFrTkd0?=
 =?utf-8?B?ZEtjUURQbk52YWRtN3NKSW9SajY0cXJUNlVsZHlDdXJRdUpaNUNNdFZtSDZa?=
 =?utf-8?B?a0dSa0RER3JZR0ZKUHdydFU5bWptZU82K2pyZm5NdmZjSktKbmFRMzRzTHRH?=
 =?utf-8?B?SGZtS3YzY0tDMWtGMnFwTlRrTGZxb1Rpd0d6eEsxUG5BYll5bWlSWS9CVnpu?=
 =?utf-8?B?MXJybitVMG5FaDNsdHdBbHltcUhaUHlOcU85VGJvQmJPZ2FCRFFzR3pzNWQ2?=
 =?utf-8?B?dnkxbVo2ZWxwVmZyU1crZmE2ZjNjeU5HYkZFeFlTa0h1T0N0UHhZNVZKdWVH?=
 =?utf-8?B?RTQ4akZvREVnS0NJMUlLbFBuejJxQkdwcE5WZzJmUEJmV05VK0kybXVvN05x?=
 =?utf-8?B?RkJuRHJZNTRxR0tsaDNlMVlyck4xL1JsMm9OSWg4UWNLZitBZVNPREF6bWlJ?=
 =?utf-8?B?cjhmTFZUNTdrU2loYUNRcWYya0hlbEhMSndQcVRjNVNVY2xtNkpwR1NHbSsr?=
 =?utf-8?B?dEM2djNaU0I3YW14TkZTMEhPWmQyc0dldmhrakNPOHlsVmc1MDl4RnM4dThK?=
 =?utf-8?B?UCtXZkt4M1Q3cVpjcER5OEt3U1VYZ3hLZGR1aThWUjRyb0ozV1NuNk5VaEkr?=
 =?utf-8?B?Vit0UjBQYWtoZTFmU3RzVVhUd1F0cGUzSG9kVnNVM0NvZDFFNlFqdDQ3T2NK?=
 =?utf-8?B?YXgxbzFteUQ1MVFudndLclFZWDNEbUhnNytPbU5pNnk2QjhOdzBEYWw0aVBP?=
 =?utf-8?B?czVJcGtTZHFpRVRZOVN2emwzYy9GdmFHb1FOSzBkOGtBM3dKUEs1aTBMUjlT?=
 =?utf-8?B?cEtXQkVmVzlJTGlUMlNvTFRyRUNqQU84eFZrcSt1L1NFelRaOW96U0dTMm9G?=
 =?utf-8?B?eEhxckxZWlFxdUJ1VWVxRTNGL21CNXhGaXp5cFYzTDk2elRFUkk5bU9kM2dM?=
 =?utf-8?B?MmQvdGhHNXlYY1hjTGlXb2NVQ1VQdzhianlVaURoQ1JVSW5UTWczN1A2WnpQ?=
 =?utf-8?B?RGwrZ2oxMzBDT2J2S0NBcmJzaXFvYWhPWHVGblpURnpQcnJVamt5TkQ2Q3Zn?=
 =?utf-8?B?UDVoTTRSeG1tYlJzajlDUHJDKzFJZ1phY2UvcEwyZTdFeGhSY05oV2lTRkJV?=
 =?utf-8?B?b1U2SVR0eElNWFlxck52M1pIK1V4Q3kybXlHbmdoSE4yTXdTQ3NtTGp6K1Za?=
 =?utf-8?B?K21IYytnVzVSQVMxZC90YXQ1d3dUMEMrV3J6dXl1UU95MnI2d3M1akNwWnB1?=
 =?utf-8?B?NUFValJBOFZCM0dtcWRhZFRiQWt2YmZNbFNRVzk4NGd4Y0tEV2NuSEEzdDZX?=
 =?utf-8?B?d3ZIejNiZ1ZQSGc1M3IyRFRHaldnbkowZlZaTXdyUk1WM1VnY0RGZTlPcU83?=
 =?utf-8?B?aDZXQkVkdXNoWjFvZktDa05LdnBOLzdhQU4zQlZ5aTMzVjYvUVdSVDFPNEFW?=
 =?utf-8?B?b1NWS3ZUQ3J6MVpjeC9NWGFYRE1DNlhRbTZhYXRCREN1d1RvdjhRcmt5Yngv?=
 =?utf-8?B?M3dWU2JEdnBKMVVkdkt5ZGsxU3psUGpYRnRkeWdkS0ExcUtGYVRxckwzR0Nv?=
 =?utf-8?Q?5x71uwsrgjeljf+66o=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96be0690-0ac8-467f-5aca-08dc3f461f7a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:02:39.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6983

On 3/8/2024 4:01 PM, Krzysztof Kozlowski wrote:
> On 07/03/2024 12:34, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> HiSilicon FEMAC core is also found on Hi3798MV200 SoC. Document it in
>> binding.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>
>> # Conflicts:
>> #	Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
> Drop
>
>> ---
>>   Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>> index 5cd2331668bc..4f8a07864eb4 100644
>> --- a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>> +++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
>> @@ -16,6 +16,7 @@ properties:
>>     compatible:
>>       enum:
>>         - hisilicon,hi3516cv300-femac
>> +      - hisilicon,hi3798mv200-femac
> As I asked two or three or four times: please express compatibility
> (oneOf, items). Your driver suggests that they are compatible. If they
> are not compatible, mention it in commit msg, but so far it suggests
> they are compatible.


They are compatible as far as i see.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


