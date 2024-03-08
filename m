Return-Path: <linux-kernel+bounces-97182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC1B876698
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D17F1F23B0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9340539C;
	Fri,  8 Mar 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X3H313rJ"
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazolkn19010001.outbound.protection.outlook.com [52.103.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587B15C0;
	Fri,  8 Mar 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909297; cv=fail; b=m7E37ZuFp3ak6b7E+6IDXB3hJfmppgPSkDGyzCm5+A927mKOc4W/47wW9lQhUAW0zADYeUoxkO+pPmQltfd3llSOVixkBzO2mugQhOt6DItt4NJ8/fG1ccG1sYGbAgtnyBfcB8Nob1OrkmZdWR60Enw5XIR2haPNQrJHQsRNkDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909297; c=relaxed/simple;
	bh=I/LVOABpBIhGpOJewgnOWAVS8WHnCUGSKQvAmwLurpY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lDb3ZDUXBVyZAKcVDTR8xjY0hqkfBBZZkKiaANbQbk/lPHybU7F2HIuInci/I/3dvcXSCbYcXmfoUq0D0YecAq0xAyazdzjKcgXsenwMbJVSctmjaTZIEoXW6n4aAdLL8MENhUPgGjrmkQr/0plpGjvAOxbJnZp3S8e0UrT9WXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X3H313rJ; arc=fail smtp.client-ip=52.103.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkAkY4Kr8nSeXHeR7fCw420Z5A7WHlEw9vZzcQbXkzK/cI+1D72NcHy4TjpxqF0h6fkixyJQ4eaRkpuwPpV7UXmReKRXljNjdsmxXFxp19oWZQMA2z3NbCinU1t7QnX9nlnJ8sb7pzhk3rIBFWMpUogJfik6Up9eSItjIXRAfE4eaAER+BC/TIYFc7BHu1EFBXe3Hi8Ms0tIpZtgsTZjkKK7uftypkTrblC+OAeGyCa7CyVFnoUHXR4yuLQJNaXveoBKHluvg+SeGbWTrRKlOU6dr/shKs1e2XxR63feVA1hPOPf+VqWR41NNIjomK9Gd9jn0wpxEU9F7zKW48lcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiT58Q4cET/MzgqeOywdikNJvyBwpjE0MrYdYLcfZMc=;
 b=NDG8SnKmriNd7UHciI5PtUo3SFN73lLkfrF8xs+96EljJmZZ3Pl9kCMlnzE1NKPna0AKR2CyuoTfWZqmjdOsJBqq3S1cMigcdKtlAMJpSRAvVH8dkkK89S9ZCE/t7LIj1bLgEu7PItAddvP/UqxxmojOSNLW6xruEH9f0qwrOppMgjF8w5nCfYSSJRkvzD+8tgKOsWlB3m5n+QfQzrMYTZIKnNlSAs0/EYVKGDRICJRcGr0lEcEoC5xFtv3BUfjsNMvrN60tzkx4JLfNXz0y6Zbfx39U/18ssrNQse18UacA2UimJZAqz9jLQ5K734C9m6VG9jkmqLzxAiXsh/Nukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiT58Q4cET/MzgqeOywdikNJvyBwpjE0MrYdYLcfZMc=;
 b=X3H313rJQIQSy+p/ytwtJp5m/ea5obbo/gx3BhaOgOko+LnzGf4Cy0bB74F5TzFFj2bEfsA0qtg+L5AXAjrjdEwSGM/DwhCMe+J4TWdc02fgYrgplXnDJRqQfKF5V6IohqO6ybS+aL0kFpMeaRzNSuHXgu6YZKwELgpmhZ8la+wJnIrDg2N/Z40l/ffd02hwl1j6zOSKn9W3zC+NiYBLLJW/rWI91zxK3+925uC38pJU/KQ7xipfG3wJ4J2nuRwU6+CHL42nPXy3diGKWf2iP0cIxSX15zvHk8Upo/V2CFG+0S38NG2kziKRY0jfZGYG9Q5XSzG5lerF/VrfpUMPgA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5590.apcprd06.prod.outlook.com (2603:1096:101:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 14:48:08 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 14:48:07 +0000
Message-ID:
 <SEZPR06MB6959494293D7F46397EEF6EE96272@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 8 Mar 2024 22:48:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/8] net: hisi-femac: add support for
 Hi3798MV200, remove unmaintained compatibles
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
References: <20240308-net-v10-0-3684df40897e@outlook.com>
 <16b79c94-2de7-43fc-8e43-75025120c523@linaro.org>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <16b79c94-2de7-43fc-8e43-75025120c523@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [E+g8kFus4NaLIX7dOxom38CGDkDygwrGKHRe/tbdz728KHZrGq4OD8TMlHbtdZIO]
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <e9a676d1-fdd7-4e7f-8ea3-4f9c267e3af8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5590:EE_
X-MS-Office365-Filtering-Correlation-Id: 548a660f-5af0-415d-d087-08dc3f7ec44c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ibC9qyiG0vC2TtZPvXQUSPjYAQ5aiBuYTKnD9NL/ifzNF3aZ8M/AcUIFaYrKUiM23OAEo57Nt/Cn+P7qWZibq9dgDkcb7bmOD+o/YFu1b8xhprKRTvXPPqaUOk3iKxarSngqWas3FfhXNx42Z8plL0OY5qRBCQ1ew7B6oIiQ5SOIEiCUL/cATXfkQLfS6OWCxBwdUCdBEVSYzav8T0QO4SAuUbLKEvsgUh03oPgvu3rUAopntbHdGDIWPbFzTsRpRDYNrAz/Ophohi+wvJlEUOcAkixOoobthVKLwLwe8C3j17qciXdWHf977dZKDmOFt/LGoXJcdHqL5MoNvUOudCXmxCnHzjeJnC1g7Po3eFeQiB6bnyqh09xbvb8sZvRrzunl8FvY6oT8SHbEzayqk/Nr3GSGOIU2B0HKZoSLIW/qR9QkgDNjhVkqoApxpF+R9dFZgxMPnLu24vbkmUOT6wbudwwOCYpft35gIFkBA3INo76uXVDg2eVDUf9yxeJsVjGL07hAmGO7lRZ4WG5/Mx6DNs3xUyIjIoasSnStAyaTT3TM18/Gjov6FbXKevPGIhpcvhsXKGm8bDkTuMo0wT8355yRN37oR10nL2NYaJE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2NpZDVZTndvUnB6WU1FT0o4bzBLbENrQzYrL3J0TmV6L0RlWmlHOEluRnhk?=
 =?utf-8?B?Mm1hK0U5SkRkVWtvUFhrTUtzNzdDRHpTY01BY1VZbjI2eXhnakMwYUJBSzdS?=
 =?utf-8?B?SFN3SUU5T0JrY3VqQ3Z6c2J4N1FlcDI5TjBVd2h6L3JtRHBnM0ZScThqTzN3?=
 =?utf-8?B?bFo2K3BNcVcrZkppejNuUkFEN0VFRG5lL3Bnc21hdndrWGdxQXQxWmJacTQ3?=
 =?utf-8?B?bjBmZ1ZoNEJwdm4zVG1ONTM4ZGZSMlA4M1hka0FpOThubS9CMk5QdnprRWE3?=
 =?utf-8?B?Qjg0dHNpKzhEdE9jK0RIN00yS3hGVGljd2FzVHJNWEtZNDMrR2txMnZVc0dV?=
 =?utf-8?B?UTlUY0RJV0hRMGVQd281TS9EYTlOT013aTZrQjFyaENFTk54SGxtcnhnbHZ1?=
 =?utf-8?B?enVMMUhVbDAzczZFSzFsdnF1S2tqZ1VaQng0TUtuYUw0REh0azJrL2tWdjdw?=
 =?utf-8?B?QnJySnBZSkhvcDlJOU1nU0ZjbmVEaEw1WXQyY20vV2NwNm9JZGhjNGJTU2po?=
 =?utf-8?B?NXJBRkQwYU9MZWY0OGJGV1NBb2JwbXdQUnpEMlMvR2tyTHBrakpiWWJ4SVNR?=
 =?utf-8?B?RHZKZ2g3QUVYVG5ZMUZiMnNVaUxUdTdQTXRHaEx0QW5jQzBFL29zaERLWVRO?=
 =?utf-8?B?TWROOGMwMzVySTZtQVpIQ0JJY2MvbjQ1V0g0ZUdTTXBzdmRzOEZzTmxtS0JC?=
 =?utf-8?B?MnNxTjRJRHlOZGJDVktCYWg2Wkt1dFczbDZxaUtEQjlZUDJLY3lVamp5ZHNJ?=
 =?utf-8?B?c1FSU01yZDZvYThkTzVKb0Y3a1FzbGc1QkIxSTR1NXJCNXpMUURId0g1YkR5?=
 =?utf-8?B?cU14WDRCNFJ2TUEyaElSbkxSeCs4UXdEMC9xSXgwR251aWRxZElUWm1xM0tZ?=
 =?utf-8?B?MWthYjBBbTRJSXBmb2FhWmIxNktMb2xrMkVGT0F4bHlCWXdUVzRIa2NCRTZn?=
 =?utf-8?B?QUFFaXdoSENmcHVwTHZSQWlMa1JTY2lMTUVqWXE4Y0tEaXAwREM0U2pEOTYr?=
 =?utf-8?B?UXFqS01Yc1VmYWppRTVVZzBEZ3RGbG9rZ1NpZFV6V08waXFWbW9LdHd0Q0xF?=
 =?utf-8?B?cEE4OCt5ajFCQThoSk9YVXVBOGNIWXkrcUFUWE5wUjhTcGM2ckw0SGoxNENm?=
 =?utf-8?B?M1RNZVlrd0d1NENsRGZCSVBiUytjOFN3ZVV2bFMxTCtwU3MrN1kzWjZTcld1?=
 =?utf-8?B?cnJ0YUxFWXVsR3dtb0Erb1FJNmV2czl0Wkx1V0NxRGhuN0lUNis0RWpqN3pD?=
 =?utf-8?B?RUFFL1NFbTBteUxlT2x3S0tZcXBrSkxoVitiV1p5R2ZKM05VQmVQSFY1cVNV?=
 =?utf-8?B?SzZzYW9wU0JaVGhFQmJWS1loSkpYUTdVSXBONldzaHRwQ3RQUmpITVBCUnVh?=
 =?utf-8?B?cExpeklvcXMzZ2FCaTRpNTFwbklZY01yampmQTFNQ0c5U3dESTRDM0R2R3pp?=
 =?utf-8?B?bERVd2hvWkR0cTFPUTdoZVZXTmFwRW9RZ3hHaTdHbkV4eDdrdmdxSG1TZE5i?=
 =?utf-8?B?RzFZeS9Sclc0ZnBUKzBuRTdwSElObmNoL0x3aE9FYXZZNDk4N0ttK0kxdWE2?=
 =?utf-8?B?US9iUWR3OEZPWm5XUEMrQ2lxOUVNMHdsQWhuNkpiZUEyQ1FDYlVYNlNVZmg0?=
 =?utf-8?B?cFdTZTdTbXorL2VCZE9qeG85OUtIQlZEWUJaMGtneEJIREl6aHFGYis4U1ll?=
 =?utf-8?B?eG93dWtldEpWa2luVzViZWJlN3pMMG5SbkRLY3orS0lQd1d1OUFsbUxLK1pu?=
 =?utf-8?Q?RslKM2bcUXX8n4Xhd+vCi2QbMfcXs6HyvAoiozJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548a660f-5af0-415d-d087-08dc3f7ec44c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:48:07.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5590

On 3/8/2024 10:43 PM, Krzysztof Kozlowski wrote:
> On 08/03/2024 09:39, Yang Xiwen via B4 Relay wrote:
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>> Changes in v10:
>> - binding: make hi3516cv300 the fallback compatible (Krzysztof Kozlowski)
>> - driver: drop mv200 match string (Krzysztof Kozlowski)
>> - commit msg: remove #conflicts
>> - Link to v9: https://lore.kernel.org/r/20240307-net-v9-0-6e0cf3e6584d@outlook.com
> You dropped one patch without explanation.


You are right. It's a stupid mistake. That's the key patch in this 
patchset. I think i was going to only remove the new compatible in that 
commit but somehow dropped the entire commit.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


