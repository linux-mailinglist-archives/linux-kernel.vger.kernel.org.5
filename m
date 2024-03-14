Return-Path: <linux-kernel+bounces-102733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE7087B6AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973791F24D62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A86D8C07;
	Thu, 14 Mar 2024 03:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="eMVCyYxX"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6468BFB;
	Thu, 14 Mar 2024 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385461; cv=fail; b=Z5g1dATjYJJ7nXQgwsCF4NZVzWCSsaMNHiAJJBzVATFHNZBlqEqvV5Xlcn16yH0QAeJ4NhCLuFv6PC29FgGHcF2Yd3rOjQdjkJcL4OS/edVBA12uOI+bvos2WLagD2xBUy57iwwULKmdQZ/5oVzYdxxBfIc1Nw+Nt+d/65t9Vis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385461; c=relaxed/simple;
	bh=odVY6tn2fSMSmDe68cwMdIgCd+SLLqwAa0BGsP27MF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r20bHRe9H4z15PqRECoS0fPJZ58/tz9kXiKXTuRBYfQcck0nx0MUkazMb9WfCzkU0F2zRzDIEJt/x5RYUu68hlAXC6yp0m66p6NEKNE3WLt1NcW4NI4HakYqNC9QXIWqxINKUd09R6dkQbPO8TVcbrFq6pyWZhqgzZgIdw88KNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=eMVCyYxX; arc=fail smtp.client-ip=40.107.255.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve9KRKBv00vt47CWCZZBWW7t5tcdmczq+5fe9xDuCCQhrLdsTEEgvsfuz1P5sVDnClejnTV+yYMfwvUHFUoMqXiUGVnZpIXQutvELHoAPKRMysrw575VkH8i9Fu73PBEKhNycIOOUCbsboAAVRzL9ZiIJK5RDuiV9cnaVNaxoLIurpsgcvGBI4SBjJzXYTrF7Ig8VrvUEVVSvMv0DNN6HZiy+3u+cPrrh7s6tgHVCmrDhU5NhQ7n62PLzzqPnQV/LNagZLpYh7hS5Trt0GaEDnKRkSXNReE6/kk+Jw5DiAKsCQwys4a9h48K3HmtAOuoDkH+XqxyOhVA5/WJMNgelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmdSrnIhym/7uzdgNW/Waq/uHXJpRaKrD3lchFG93A8=;
 b=iBnBU6lNbW+2bbwt16IWOVzslQq9+NytjfoEb6+EAynCgI9mAX3CauHI76KAIkKalF3xGJZcegFAXUOfq1h4dihx/HUx0KwzQ6fkG6J09BK7UgsbndeVw5fFtA6yTlCNZ3qtvrBLi/2CXHiI+LCtQ7yTkQlaY+3V1veAKcatmGt9MYBjVN6+lV7SFogTVyaDx++d2iUXjAFV9MdAH9seMARkFaNu2O5gYTD+BI6VbYP9TVyvDn6HLw4kHhfZgriS5OY3y/ugzgYikXKLLuTb5+xAgzmYLOrE+XR5H73LbXG5L7H1mHil8evQxj9Rf3Pa+xlxMWpNBamCGoUFMUGs6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmdSrnIhym/7uzdgNW/Waq/uHXJpRaKrD3lchFG93A8=;
 b=eMVCyYxXZxggBoJgaotgiGW6MjnWZX7ZqCB2koXqzgYcDWgHk1zzZ02A+bknq6X3IiDpKa9tkK3GCy0cZEtc+SnYC0tMfBmWBvGBEB+LyhS6JXcAOgTp5+9Z+WG5Sp5ET3s09FwbaKlPDbB4PXyELAaLY3LDgYeKspYfXtu9aSEZLPsDXx5FUFMF9+bW4cdUviLByrP3yuWLF9u1ptWxnuY0sXtJtd2MOmcdIU5k1b8VPX+TgJaoC7JXfYcR/eRQE6zW4cWLgVnb7MGzf0bdF2JKaOOREQWLKQ4bfW8twQrz0imBfGbvvej+afyNfamp7uIT9xLYVUEmDz/uqYz1CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB7430.apcprd03.prod.outlook.com (2603:1096:820:cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 03:04:16 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 03:04:16 +0000
Message-ID: <3d2e488f-6191-4844-b5a7-2563898d4670@amlogic.com>
Date: Thu, 14 Mar 2024 11:04:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: add support for A4 based Amlogic BA400
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
 <CAFBinCAvT6-gfZQH--AVJAxiVM9bv5=agYzJ-u3NZUGFvp2vZA@mail.gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CAFBinCAvT6-gfZQH--AVJAxiVM9bv5=agYzJ-u3NZUGFvp2vZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d216171-a401-4b05-e8d9-08dc43d36f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Apr4vzcm17/9F5ck5S8xrSffP7gwa6KZdhbtNSr8ER2Ck1lnx95xFWKdqJO/6jvNHjArJh+JfjLrVw3hPw6F4n9jTWoSYWQQQSeKI7yQxgHE1wmCNbyXURZhPQbEDCsVu48ga4+wBjcfAwCGpJI8FLN49eYMmvKMSzzgRpPcsGN1IQzzm35vbVSLvP1J+ku/s2pOPTN3lKyO9TTCtwy9Xq0h22CJG6D/j5VeQF0fvjPO84iy/SaEoNJ8BlL75p82RvvktFJ9g1cuO4KBL75aqzrYj90O5yBz/nfTU850Wnj6+fIdE4o+/+/SpSxqwOkTP9zEyVjxyES1H/oo9nd4qpbhG/gc1LTX/10c6Mx2wNrbGQAQRqCMBOAVeL1OSOyrWoHV7hdyiTHUfLuk/DgYLxB1FjEj997zq5hS0ecNRVxuNLsptdeoTHj7UbbJaUDe3ahrjgzrZdu/IhDlirzfnJH3RX6+rL4iFaIqkk5RDbchQL+PPBagcXAId/aX0anRb707pDEWj07DJqO1tn35wCF77km8B8Dv5Z3644+qWTQMLiwuxB1WbAhbsTZNjDZ1I5RJFDq7VCk7zatD9xRZEDk6T+zmh19rSzOjyMe89qB+heLHPUGGr/4nNb7NEZsokw2hsJsQt9Jn5VBm0vlrBLWAwc7X9Nm/wwudf3rRFEc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU8zLzN2S0VINGk5NWp6c21VM1VlajhLY2dUdEhoU1Blc21xT000TXJ0VEhn?=
 =?utf-8?B?TUN4T3psQnVLZmJ5V054OEJYbGhodU5MUEx2VUVMSUI1bTQ0ZXhLZHJmTHhw?=
 =?utf-8?B?bE9pend3dzlrVlJ3bEFxL094b09NM1I2OW1WYUlWem96cmRoU0dXOVNDT01x?=
 =?utf-8?B?MUMxaFJkakxwaFZnUktFWTlIMGFuYUZ0TVlsQjZSSE04SWdkOXpCL2RYTlNP?=
 =?utf-8?B?eDExNGZiTTZiNnplUUNQOEFEdGp6QVY1djdEanE1V0hUWFd2aElxckxUTXdQ?=
 =?utf-8?B?S1FvbkhxQWVZbCtHMUNqMUtQbTNrUDBlZ0F4S2o4SUVBNmpoc0NKbHoyc0hZ?=
 =?utf-8?B?Z2IxVzdrVXdycEJWYzJyRzE1UjlGNjh0MjQxL1I5dUVUWE5kMWJwWFFWM1Iv?=
 =?utf-8?B?MGMzT01vQ0M4a1RMSDNaUnhtaTVOUlhkcXcwT0pkNUZQZVNsRDhsN0pwV2tE?=
 =?utf-8?B?U0tabiszY2N1WXRPbTMvTzhLVXNPYVZvb2ZRd0F4V1hsa3N6aEJyTVk5TUpp?=
 =?utf-8?B?VVVEdHZ4b3VOUGJ2WVAvTVVHUjNoNU5qQnRhdHJaNEFRSWV1aW90bE11Y2dl?=
 =?utf-8?B?Vkw0SXd2S1BycXpIUFpZVXh3azhJd1djWXo0UHVNanRVTVh6a25zMWYrRFVV?=
 =?utf-8?B?T1lxYklrRlVhc2NJRTdYR05veEFNQlhJL3Y3N0lkTERpZUZYRTdxMmdsZTc4?=
 =?utf-8?B?c3I4K0tUbzRYdXdmNjBTeDhWMHFvZ2ttOE5WOFBQb3dJclVjeGFaUVROTmJK?=
 =?utf-8?B?UXRRRlg2TjdDQ25wSmZ4R1o2RExkWGdzNWdFVU1uSW90UGtRUFRxalVEWHpL?=
 =?utf-8?B?M002MnA1enJCcUlvbm1iTWtrRnNuaE0xaE9qSWxnU2p5U3lNclNiSlg1ais4?=
 =?utf-8?B?VEJVeEkrRGxteWZ2cE9FUVFwWWxkdFMxRWpHdU1BWGxWL1kraVJHVHpIOVJy?=
 =?utf-8?B?QURBUHJjR0V4cWVKalpURFlaVzNvalgxRFd6RTNaSWpxbUJqL0xYTFdkQlht?=
 =?utf-8?B?L1ZBTDl6cU9YQ0gxOEdIVzc2WEs1RE1JeHVoSlVURzg0Y21uVXpkcUEzN0dP?=
 =?utf-8?B?MFd2TzZLZisvRlkzMmIyWnpLbmFNSjFET3F5U0tWdVk3ai93ZlhuNDJVOWpv?=
 =?utf-8?B?YWVHQ09ibXB4M2g2emc5YWtKcXlBVks3Yit5WGlLcEt6QkNkSEVVU3crOFF1?=
 =?utf-8?B?UDZTUlBUMGxReHVYaVlGV3FWcnNaUEpjcHJxZnBFWFA4am91RVl6c0FlUkZt?=
 =?utf-8?B?N2VYbC9zbGg0bnV6TUJKbno5YUtwWldzalJmclQwcFh4NEVORTFNR25XTHJN?=
 =?utf-8?B?ZUUzRXNkZnNrcGJlQjZRZjk4bTNqbERsVVZnR01DOC9seGxUMTNpM3k3dEpV?=
 =?utf-8?B?eWJhZ1RadldTSk8xR2J5L3c0ckhadkZsUS9qQVV4ZDNwWVIvQkJmQmIwRWtU?=
 =?utf-8?B?NGpCdUsyOFJDS1VjOXA3elFzTmVKRHZlUzBaaUo3cWhKT0hqSDJYT0MzTXpF?=
 =?utf-8?B?STBiN2xtOTJWdzZPRDVUMXhQYlRESmN1QlZYS2hCSDRzbW1pSXRCWmJremZX?=
 =?utf-8?B?UlV6VXlxWXNZTk9mTFo4bzhHUUR3SE9QT2hSK2xwREN5cGY1bUhYTjRnbmJ6?=
 =?utf-8?B?eWVWWnJqYXdrNk0xQ0JnWGV4TE5LZDFvMlU1UlZPeG1JWGJ6cXN0WHVQL0Qy?=
 =?utf-8?B?SFRubUxjZmo2b0NTSTFqbUFFT0xDSTBKNWd5cDhzU2ZPaTVHclZibUY5SUdD?=
 =?utf-8?B?YWMzN1NRTWpwdlFQSnhaT2pOL01pYlRZMERxY1dNN0ovdldYQTlkZGFETGRm?=
 =?utf-8?B?NDl4cU9YRlJmSkk2TmExd09WUlV5YkQ4NEdJYUY5aVFBRzVBTnI1RFNOVWhQ?=
 =?utf-8?B?c040RkZ1S2R3Q05qa052YitVVnExY2NPTHRiQ1A4anVhRWVHNDdTTllVMjJh?=
 =?utf-8?B?L3NmZ2VKcExQMjNqRC9STzFUc1BpVkp2Y0xvcVJoQjYxOG1hZnI1dkZwMEs3?=
 =?utf-8?B?a054NTlyL0RsWDhEYWVkZ1p5YmZHNDhjVDBoV1VQQUJUOUE1YU9xcWZPVU9q?=
 =?utf-8?B?OFVlbXJsYnZML0t4TFhxV2JBQVhKc25YVmlMWHN5L0lRZU53bjVZczkrUWVm?=
 =?utf-8?B?cVh3Y1Rwd0U0a2QrTGsxSHFBQVJNb2FLSWlyaFJCNW9GZDdmT3N6Y0RvbUlN?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d216171-a401-4b05-e8d9-08dc43d36f05
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 03:04:16.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jF8YoY7OzdgaSYkjpLYJ1lXS6P6ym7ARzPyqSdm6FE6caVA6vRjIFOhWwJq0Bl5x4LCPFEGfmmnUmpAZ4nNjEG0NPPT/ctuBWtwbUSaITMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7430

Hi Martin,
    Thanks for your review.

On 2024/3/13 01:29, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Mar 12, 2024 at 10:19 AM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> [...]
>> +               apb@fe000000 {
> Node names need to be generic - since this is a bug it needs to be:
>    bus@fe000000 {
> Or if you want to make it clear how this bus is called then you can use:
>    apb: bus@fe000000 {
> 
Will fix it.
> The same comment applies to the amlogic-a5.dtsi patch (4/4).
> And while here, I fully agree with Jerome: having a bit more details
> would be great so we can judge on whether a common .dtsi makes sense.
> For this it would be helpful to know how many IP blocks those two SoCs
> have in common and how many are different.
> 
They are mostly the same, but the follow-on series is unclear, and I 
would like to wait for the follow-on chips to come out before 
considering a merger with common dtsi file.
> 
> Best regards,
> Martin

