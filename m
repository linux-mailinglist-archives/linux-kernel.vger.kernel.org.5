Return-Path: <linux-kernel+bounces-69823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6B4858EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888421C2124D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E6360DE7;
	Sat, 17 Feb 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KKXRGjpC"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2013.outbound.protection.outlook.com [40.92.107.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A955916B;
	Sat, 17 Feb 2024 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708168007; cv=fail; b=r2A9Qr3B6LfHPbilp7nQ2ZdoPBaRF3qQVKQ/q14ZJFE0iKkCR412vK5WZ7tjj3B2RDn+VvQJzvaAsEG+6ur0BGbhtaBbvSWiWpm38u0JU9NZ6f/Z0zY3ngJLhAaHishj9XJdc/LwmQF3gJeZKMSVQJD/XmVHl0Z5UO4qyiAq6lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708168007; c=relaxed/simple;
	bh=aAjfHWxwljUP6iRNioNuS8e6gs6zSTkbJpZCo8PI4AQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RhSjIwz2BP4TcQARPxkNvDLWLbMOxYl1SZzciAmCj20kPgWGDFb42Qlj03HVmewKbakrwmMVUZ8Z82kFV4fcBNMpPpNwMIK+ddaYn7fRWy+YutbA6D8heEu8Eu51VPhB0hnXdiGHQJ4ukzfmORVhxJbIQGOroEDk5Umjor/kxxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KKXRGjpC; arc=fail smtp.client-ip=40.92.107.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMcY0SCdj7u/x31DO6XfRYESYUfWBWitH5W6gUsfajQpbxun55Kybj48bRhaQ6X5dvwpSKaczXJyvq20TBx4AT36Sr5PrHWb5qQCF767FhIyjhMdw8XELf9I6dJs7PqU3hpp8UB29nykou++kcYVbK1AI/dWtbB4l6550Ok5scKD64XGSkVavurvgCNhzAQZb0CryQ1iUpO4SKhQIXVLokjewQ5btYBZGNUXFbvL/TY8cazmyBqkTaPCw0MOdwpkBy//egIsnnUf5PSmhJcbxfk8yyYWTv8siahrjSBW0uLWnb1kcWduN+Yu4t86iMlJiT2eO44w86mHGGulgWqnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYab6ynoNw18HunuR9m+XjiPPLA9mN8lmDgzr+oI+vc=;
 b=h5x+ZgnqNBreutZcFNbOyvVlXMztowzucUvKH02QUSqqZRxLitSPYKC322kNWVQEWCTUfoWFnbi8V26B4FHT1uMYqSVt7nbFNBR3q4tx92es67xsu1rmItUKWIo08lJTMu0drJ5abyp/kxLXIEBb+GMrGnDFNcmNMJsqAa5XYWc1niXTBMVSwlZJmWwju9S8tRi5UhJ8bUJvEGZ2m0sVDnxRgbwS//4AsyBCSjfEG8F7vIoXcX66uccS5IdfHsVH7KNGMwULl48qRQg5k+8AJ83q+KW6ZrnGgThT1K3Gn/ra/NlRbjwKJm/ZMlI9MkBc3uCiespPyXG1Zieee5X8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYab6ynoNw18HunuR9m+XjiPPLA9mN8lmDgzr+oI+vc=;
 b=KKXRGjpCkchbzfTxMUK+etVpQVaGtj8nNIryR6HfZQgsYEcg600TVVA0iIrb6HLq8PcEqzU++tsotnHoWg4guCjvpCQ4EV1td3/qhlqRzo4jz1VeOMKWu68CSj6z3RgYVuA8xlLZUnQVKHcDp71ZTMDJRMmkCVUvQptgz1XfvkcSt2r3jsIzl7NlE9VWC3N4Ve7NgIRzdkw8rFsCetKLLk9HqBkfScuC6WH3FEKiDayRLYmO9HGV+WvamlDqPNUyBO8yP4L+rGl8+ldk0n7sPhihgz2GIL34Vpc2cWJPjztP5FTXxorgX+tWVj95R+QbQIaRXB3RyeIKPJxyx/pvVA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by KL1PR0601MB4467.apcprd06.prod.outlook.com (2603:1096:820:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 11:06:39 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 11:06:39 +0000
Message-ID:
 <SEZPR06MB6959703F337B5A2540C56C4496532@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 17 Feb 2024 19:06:33 +0800
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
 [ss7Xg1dj6xPxdu4FNqnL/Ldj7nm2qEhBZS9tKiz8bJ7q/vFquJCWk/itnuX6pVEwwxWgLq90gD4=]
X-ClientProxiedBy: TYCP301CA0070.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::12) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <4c0f651a-280a-4cd2-bf40-ce45458d71bb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|KL1PR0601MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: ce662c16-89b5-46f9-6b2e-08dc2fa883a0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ssILq5sKD2EFXrz1iZkSCyTlONNlianEBbvgg9HvsxuNa97Xgcs9iTkmX95/ezPMXsMiCCdckbyG+lCYpi3J+a0CwqWT4aoVe5CpT4tIbyLj4zkuz9MToBrDHEOKxNT6Zu4aCa9Oq+mQK+5wGaQiXJfQLflwNk3DeKj7oYnxiKClX7y6R3cLObbUVMx+MXzVCkZag0ZXl1MqNmMiCcXAwF2yfuB6ftx3bwvDHZ32Lwm6Eb/ydk/Kgx4nBN25TrGp2LmXuQWnUr9+GfD1cCzMetGsgp1G38o1BiYG24etTHsmHlzlOTdK3764WnVMOUbQ/+YshxG5g2brlAcjE0+7MoKmvdUi/o1wjc5w93WRu0j9aBALLrTp6w31cPiZHVUGMCZPBCMNBT7FZXnPIb/kTS1IbH0h9Bph5jkUfvHZatRtaU3LRWLzd6rmzBpH6qOF8nyugh33cLm060Fh+C0j6geOJwkVPjPQOQH+vIE9+UQ3owdt//44eZoXwbkNSpuexdVhM9bAaSF6FFloNvmEOqmEq39mYpBUeO1KvFROlwMC7D0uX0l2u8QVOGdGUdb4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHVKS0lpajVvMnhaUk5wRUdmSUdYbklFN3VIQlJXOWRQVWlrTkg5S3d3T0Q0?=
 =?utf-8?B?NDBIQUEveE14Wm1NVkROTE9tU1l3SUttOE1CajV5VHpLSXR1ZHJiR3JRcEJy?=
 =?utf-8?B?c1Bpb2tQWW1EZG9Id3pFQVJqcXlXdW5reTlVOHAxdjBlMVZYUWM3ZHh1dmNF?=
 =?utf-8?B?R3lIR3A0bmZ1R1VUUVhHdUlDbkdzVVVFTWVMRmFUK2tMbmUyQ0NtdHhpbjRr?=
 =?utf-8?B?WXFZcUQ0VE43RTBoOFpJZFU0RlRHVmFTTWgycTVsOXVKeGZheHFsQmpDdEVZ?=
 =?utf-8?B?UDBhdUhsdmhkTUpwdm50YmZxSWNXOHJoRU5yem5xc3J6UzJtd3pFWEZKQnpx?=
 =?utf-8?B?TGd4Q2VKSWJlNWR6SzJZUk1xQi9LaVpOTkZqODlQakR4OHdlbHhZVis5WVRF?=
 =?utf-8?B?blRaa1ZsK1BBNU1iaFROalpPM3dha1cybzEyblkyejRqcE96UnFncEgxWjM2?=
 =?utf-8?B?UW8zSDZ1T1JScTR6amhWMmlNUVdEN1JVdUhSR3Z1OEVaeVhuekx2S0J1eC90?=
 =?utf-8?B?ckpKK1RERlBLT0UxU29NaFdXcjZhTlpEMGhEWGw2YmJZYWdobVpnVHVBbFcr?=
 =?utf-8?B?aHFPRzBsdms5WlB3alBKZ0NrcjFxK0c5QWN6eWZkejJDODNvc2ZRSy9uc0FK?=
 =?utf-8?B?Wmc0WTJwN1IwZ0M2SVNHUGpSaEdoQndPRG9STWZZRGhLMGorWlFza2VYYWY1?=
 =?utf-8?B?UEVsUzRPalR3VVJDV2Z3aHlXMG5LN0hWL0VKa280YjBCRUo1a1hOV3VSNDRY?=
 =?utf-8?B?cCswRm1QK0UzMmc4aTJ2ZHdCNGtrejBjMU50R2pLQkszUzY1T2IxZnhIaGE4?=
 =?utf-8?B?U0ZLUzJ6Yzl2VzRzbWR4UUVBWHVyYjVvM0grbHE5bXFHSVA5b2RsaVBxVlFQ?=
 =?utf-8?B?cnR3SGtNdExCNzFHVjFFUktjbldXTWJFd0dQb1ZpdEl1SkZTOGJqL0N1aDZH?=
 =?utf-8?B?VTJmbDM5UFRYV3gvS09DSnBrTzludjRZa08yYWNLWlVUV2FRZ2hpNkZCM0s3?=
 =?utf-8?B?dkROZFQrTnZYN2hRWENUSnhaam95a1FGVVpWaVNwS04xTnh6MDhvTVhMRTVQ?=
 =?utf-8?B?UWltNGFTR1pmeStZbWVoWThSa2RQbTR5dDQ2U1Z0K1ZxeWlCMUVYZ3dxeUQr?=
 =?utf-8?B?cTI4SzJsQk5wTjM0d0JYK1FrREhlMVBGTXBTcTFWVHZ3NFRnVkZXbGpHMjZy?=
 =?utf-8?B?dnRudkFuVm9VajVaME5Ec1BmdTVhK3MwcUtHYi80M2lTbDBGWDFWUVBQOXRH?=
 =?utf-8?B?Zk41c0JPOXpCYXN6dHIrNkFBNE54eDh0SFl6TVo1a3hrV1JhZVpMUWJSVGRo?=
 =?utf-8?B?aXlFWXQvQkozWmZRK3orT3Qxa0dRVW1JTzlrWDd4OVM0dlpYMFI3TWRwWmNz?=
 =?utf-8?B?TlNFTnQ5TGs4dkp3WUNobnZOYWFDZHJ5Qy92VU1iZ0YzOGplbDNmNWZxZ1hr?=
 =?utf-8?B?UzRWZW03NGsyZVltTG5KNldlanFwc0NUWkQ4aGp3cmQ5M2plYjdjdzB1ak9W?=
 =?utf-8?B?Y0FENHhwb2YwQUk2NCtqMkVyUVdEalJnbmdxdVpnMzdHWVBmNVNyaHBrMVYv?=
 =?utf-8?B?RDFZQ3BOd1JhK1d3d0ZBRlUwdHdWR1ZHNkFlVjdFWEFLNHJSOWl5WFlncmhk?=
 =?utf-8?B?R0V6WTBienpCQkt5bXlDR21mTUVQZ0hpc0wrdlFNTjRwcCtia1VXQjBuaVdU?=
 =?utf-8?B?MzAxeDZuZms0OE9aVGxNZU1XSmwvS1lOQ2cxSjF2WHVVUi9pQ3ZQUnBWNHU2?=
 =?utf-8?Q?hoinaf58fQWMCtxpf4nOAmDwBHudJRgQly1MYET?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce662c16-89b5-46f9-6b2e-08dc2fa883a0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 11:06:39.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4467

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
All except one email addresses are added by `b4 prep --auto-to-cc`. 
Anyway, i'll remove the email address that does not work in next version.
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


