Return-Path: <linux-kernel+bounces-99717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC271878C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D011F2232E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32B31877;
	Tue, 12 Mar 2024 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DFRcVO+g"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2045.outbound.protection.outlook.com [40.92.53.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B47E2;
	Tue, 12 Mar 2024 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206142; cv=fail; b=PJiWLDPXLbSCvm1ZBttS6zzrGv8EqDNP5VdtZk2E9wt6jz0G3qCNxQR5KrojZZ1/WVCZbpJ7cSgLQQHyRR7MfaZCnBlR/g7GiwqVUE9H1Mmw6lev95qsCmJH+CCKvKwbCJKYEYhcmDPoM3XYiLcFCPYO87rNgYJfVsq6vU3ur3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206142; c=relaxed/simple;
	bh=fd7k9TjNJCJhhpNL9wkqKgv6c/uOcjmzwS/YsoWKXio=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rGXdI6NLWzNuFATdlzWmIwtELngxs6Bk4uJtE6dnuJglAWX/5KUo46Xwo/dABXYRC5z9yayBJATp6M3SDOct+Ym2YoNoTTTQ7HB2qQilIEM1YOiM65Yrj7zaEm3FGgdpLn8gb4Z6VmfkSHvDNB+WSPUd22wj5iRTt/olM7eta1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DFRcVO+g; arc=fail smtp.client-ip=40.92.53.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uvl6+86+4QbwWj/sSkFrIUMRL/2ttYn3+VaMVm3DUepADq0fSNvHHwyX2dj6JAfGhN0+YCcw15eHqE8sSyeLh7l5YB8svDcUKqrX/R+dF4bCfJF8yzBzCosxVGGXOZfEBB593x6/+UgsvNTQlkqQtjrixp18E63tWizHUZ5gzl3RgDpCAapiCD+MbA/DMwWF9ja0ouaFX2hzEshPwVi25J8DJAGsaCxZB++xd31dwGLSuGmbVWXRxDEMCKHk5uuLBQYtZ/Sqs4mr0F+2vEcoJGJbya2qwIVb/Sf5Fm+h27pSdo4OAFEtRBpDrZZ8xCA/j0OvQhIB5GGIByysohLKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEaAndPjWooISCA+EDHZF3Avu/VMiEfgjOy+V3yf4Wk=;
 b=EtWA3UEwtNE4GMzwIATXg0iMB/o8B//zdH/+620fkyhmcnFtFAhjcT5fQH9xDJmLoIkdiK8DkKbgOu5o8Q3yp6UeisZy7pdQLs6o0czx0AUkPiCMI3cl7l0mLqOHYpuunZVcOpq+KgT91NZ/19uxbR2dhGqAkLwowAI6FpHUwQd/FmLttp8V/XpqFoiPom7QbvGETQL4pNyhWPwZHsCiJR27P6Vwpo+o8s+dAnbBhmFyclPUv1YiJ4X+vBtm4XXYF2zZjuINsbAfd2kxMKDSFHivh5fSeNRFBRZ7HLS45YGON01fyc5KC4X8pndZxFJ0Uhs1Pn5n+ODnqMxKnlQbbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEaAndPjWooISCA+EDHZF3Avu/VMiEfgjOy+V3yf4Wk=;
 b=DFRcVO+gVQzihPgfCWfMqR+mOBcedF6gzU1pkw4Xk12XpoqCx/DsiK0XEi6+sH408ciUddfCkdavuUn5yCstXdrdHDDtibYPPGbI/+UpUaJQ0IkKOH6ATyomPfhGVSqQf5Rj1LZZ832gvICykOT34kU5VlTmzdpQlWnuHOzpOyZwyCw/FBNqOAmRTHxiGZky5+0qS8VUFTa1tWkz/1pItTtjgv0d9JNJ74D2KAkn032Q5La3CHOhe9wYJMSaTNjSikckm5DvH7KwnMPRomSGoH6rw++H39oHwrCPz4wCfXxU0H2hKTCxxRh8p+rEBA6Jzy33OToxs3ORTEIh8H58zQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB6950.apcprd06.prod.outlook.com (2603:1096:101:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 01:15:34 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 01:15:33 +0000
Message-ID:
 <SEZPR06MB69592620693B63B0891CDDB6962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 12 Mar 2024 09:15:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 4/9] dt-bindings: net: convert hisi-femac.txt
 to YAML
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
 <20240309-net-v11-4-eb99b76e4a21@outlook.com>
 <SEZPR06MB6959090F2C45C3E5D6B3F9F496262@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <20240311090341.32509303@kernel.org>
 <SEZPR06MB69596EB6D2097DB14FF5C9C6962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <20240311180853.5e3a6a41@kernel.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240311180853.5e3a6a41@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [TFCyelN60FsF2s3IaaGeCJnOCwp1q9X6n05ZHlAgGdcqT2N+K6zPQPavW8I+KQOt]
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <c814f874-06db-4aae-8150-41a1b32b552d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: e145b318-6579-46d9-3d55-08dc4231ea1a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3MU31Az9eyAYRriqoKJu07O68l36Q/pswlhmKvP+FTbSVY9rIjew7m6sfHkSm+t21CjH9/cEzxJ0FYhU4qisavOSKRll1nrKdw4sMZqrSc0vzl1gN4LANbzjfFSNltQa36gMtrMxxjyDZEBdycO9vC1LMxXQQx16/MQ6GQY7C46Z0Bd2aKXzkswokiD9nwGiXJqED9FV4fhWi7e0TrOtwp6yss8MxP9IQwWpyDmMS93MWS84IQbsPMpBnrLzDXwrZqjEdj/Qf8XyxW6PslBHKL6zsv2Cvxzc5tjWyFDOpFbPyI9+3yhAArZwVborvm4oZ7D4gDPAwpiI78XV6oTzF5kpYvrnLO8ZOaX0oMlE8ZFb9CwZeQANkDNeRA3sIeJwSZZPdNKZAEjW1UH9VkwS0DbLMQ6LhqgU11S8VidCpKyvkLdWF599/bUoidT+iNYN6JEjjnBOo2rrxtqATEt6VvLkFspORIoB1+bT/G0jvZEKGpn1aEz6m/3PEl10R+R638qb46qRY6DNvVM/sVrWVLwhsIHQfMjb1F3YxhAB9WjgDX8QX29fEs8Ku881Nj4d
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elRrWHJDU1c0cUMvTUhPVEZRcDlmNUsrcHpBTXNnbVgzTWw4aW9PQUJmNTNo?=
 =?utf-8?B?bjdLU0xKelBRWVh3Q0M3a0JDT2J6SURYUU5TSGVNQjE2ZkQrYXBVQkZnWlZz?=
 =?utf-8?B?RElxbncrZEtOemZ1SVNBU2ZWQW9YTC9TV2pYalZ3a0ZUN1BjbStYY3JHM0pM?=
 =?utf-8?B?UmdSemFhWUxZWW1NVlF1MEJUbEdFdTdHejJpejVKcFZqT05xajZnY2RwTVRN?=
 =?utf-8?B?d2NUZ3AwSVhpRzdBWnlUTm96cWY2S0xiM1R3dTc0L00wVWoyYlJxUWFqRWNZ?=
 =?utf-8?B?eVFSeExoTTBMOFJuQS9Zb3ZuK2pleHVVc2tYUVRxTFVuT0tnd3I1NjF4TUwr?=
 =?utf-8?B?b2J6Z0N3OXRiQ05ERjVJUnZ4bmdYRE9memFGY0tPQnZJdEtYeEg0Tjg2ZEM5?=
 =?utf-8?B?QkZCS2NqVTljaVIybXR1QXRvMEcveHFXc2U3QmR0bXVLOHdGeWZ4MlhNZGFl?=
 =?utf-8?B?aXgrRTdDSHJrLy9rWmNiRDhZcnpSZFNWVUxhazYraDMzNFJINzdsR0M3WGRt?=
 =?utf-8?B?NUtzMVcrRDJBTnQ4eENlckdha2k2b3gycTdTQ2tnd1hkZGxxODdVTlUrQkdU?=
 =?utf-8?B?VVIzMjdXazl5SlpFc1dCek9SODZkd1hKUHJHK1ZEcXVhM2pTN04vUjF6dWd0?=
 =?utf-8?B?TlBHWE9SNER1VG1sWlR5K0hlQTk4aDQ5Y1owakJVbWJEZlM3K1grKzBkVTA1?=
 =?utf-8?B?anYrbWNPTnFDTThmTElKMmVSYkV0Tm81VVFwNS9NMlM0RXp3d2s3ZHdndU50?=
 =?utf-8?B?RDBWYkp5ZlA1d0kvL3ZKa3lKL0c0T1F6TVNBYmtRSHF6Yno3YUhBSVpqUWVZ?=
 =?utf-8?B?NG1TWmlUbmZJeFF1cFJqa1lzeXNZSFdWZUZDa2t1eVJWODBZWmpKNDBlT1ZS?=
 =?utf-8?B?RDZnTDJHTzNYY2NCbVdnMTJUOWNtekhBT0NVQUdwamZDSlgvQTNlai96ZnpK?=
 =?utf-8?B?YnlpTnBkbHBjZXZBRVlRc2pkS3BsdEM2QjJ3d2tlK1RmdWE1Z2Y3N2s3RVNs?=
 =?utf-8?B?aWtLY1pER2F1aEh2QVpwRm80cm5DekNpN1NCOURnMWlPTFJLMjI5aVJITy82?=
 =?utf-8?B?eVlLQkM4RzBQbTdpSmQ1UU5zVDhwUFgya0NlLyt6ZXd6RjdiTGVPWStoZ2Qv?=
 =?utf-8?B?d3FtZGVOTFZUWHFlOGhxbzkvNWl5NGczVDdyb2wvQk1CajhmekVwYnBVWCtD?=
 =?utf-8?B?aVNKRDVVN3Z1RE1TS3ZpZVMxcmF6bUQvVVpKYXhZbXhwMmMwN1lYQjA4cnhY?=
 =?utf-8?B?S09jd2hzUzRjbE1BQ2xIcVB1UzZrSXhOc1dvZ2k2M3FsMkQ5RjlKZmd3VVpB?=
 =?utf-8?B?YmE3Rlo0dUplVXJjK01GVFpQTENsREFWT0tYQzRGU291SnFLVStaN3MzRHU1?=
 =?utf-8?B?K3Y3NkRQaGk5RHBoOGUvcmIwb1lXMnJlcWNXUitnMkN4V3FzWnRRRWs0aXFM?=
 =?utf-8?B?VmZSSXFaRVpjKzFNMXh3eGRPczJnUlllS2VtN2xMdjJ4T1NUZFhVWnlMQzZP?=
 =?utf-8?B?ZDlKcElLSHRTMGFBc3p6ZUE1UEpwTlkwcEJqSmF6blAwMFFsd0I1TW41ZHla?=
 =?utf-8?B?dEd6eXF0bjZML0RRMWdCQnIwOWQzMTFYSm53djUveXJXUWVsSU1lVGRKWkVG?=
 =?utf-8?B?N0dxbnYvbTBSMSttRWNGM1ZwV2ZCalZGN1VGRjBGSmtSb3doYmM5clZWVldz?=
 =?utf-8?B?YmxhczdLTUM5ZjlRMlkrc28zb21jYkozY1ZaS204RkdKWit4b1JlNEN0MUF3?=
 =?utf-8?Q?8l5SvHBt3UWwanLVyBxdy0/6TnFsiB+s/fvX4w6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e145b318-6579-46d9-3d55-08dc4231ea1a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 01:15:33.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6950

On 3/12/2024 9:08 AM, Jakub Kicinski wrote:
> On Tue, 12 Mar 2024 08:49:21 +0800 Yang Xiwen wrote:
>>>> Still not very correct here. In downstream the core can also have an
>>>> external PHY. The internal phy is also optional. So maybe this clock
>>>> should be optional.
>>> You are responding to yourself 4 min after posting?
>>> What is the purpose of your comments?
>> Just to remind others or myself this can be improved. But i think it's
>> ready to be applied. There won't be similar design in mainline soon i think.
> It's a fairly uncommon thing to do, normally such notes should either
> be comments in the code or notes in the commit message.


Yeah. Maybe i can try to improve this in the next 6 weeks. But without 
the hardware to test, i can hardly say my implementation is correct or not.


>
> In any case - the merge window for v6.9 has started, we won't be able
> to merge these changes for the next 2 weeks :(


It's sad to wait for another 6 weeks till v6.10. But i'm okay with it, 
since i still have a lot of other patches pending to be applied for 
Hi3798MV200 SoC.



-- 
Regards,
Yang Xiwen


