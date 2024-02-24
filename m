Return-Path: <linux-kernel+bounces-79704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322786259E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64341F229DA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E7842051;
	Sat, 24 Feb 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cRKvV5DA"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2051.outbound.protection.outlook.com [40.92.53.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBC21B7E8;
	Sat, 24 Feb 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708784714; cv=fail; b=fBMrf/8BOqPK0ZjleswX9IOlnG9moRhM3Wma//CIYHF/LVULaWHFyybRHmBgutAi4aYAkFnbiQ5EM7qCq7CEUByZ4Z0Ae5lu8n0pv3FE3wZd+0taSU2H2kGGx00I+L3lcWJ8gS7lC75DuN68alDJ8N5OzGdwntkRM66jab8mHEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708784714; c=relaxed/simple;
	bh=hKmSto5gzz5vSykVEqxPINQylCV3Ax0e9MfU0qCVgHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pPL8O21eT4XZMjfEjYvd9mSID2PzZORRQqxhYRuZMXUnyLy5fKjkdI7KtteGkT6OY9I+mwA83NdOGf6t3/P+YWL2L1ud0GpYFkZ20bN9VYlyUEAwzTJHkTnbsvElQq+xIUQjdg2XPAJ4ikwArJYjHYPV4pIGmKKcNqjNXjbdMFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cRKvV5DA; arc=fail smtp.client-ip=40.92.53.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOH7vOKa90CkR2+xh1vaONbHso8/CO0eZvE86iGNWKlfM6Gqnl3sy5MH7JpfMCN4QJSQdXIZ7px3L3jfiR4UIpXHPhYw5ZEyCpJYtVPGaHoQwL54Anj3mLS8y68RXu9GSAVwMo9x6608fUWsh36UphAWZSeUiOCwYJmdamVn60zIoWWRn863ux5zSip+1cuCdr67hBg53GlT7lKS/g7gFn6Q0k0x/crh3zFwnzsT20tyQUknAny4v97hwnsaRAh7R1O+8aO+TfChSBtcZES6OIjvHOD8r2XE4NU97PflwpEdjrrsq3xU6F2iB6/SohbUTQjP1SrovTVf6e8fgnBUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD2TXALPo56+s0ML7xMWW0yjulhU6krJS0obHzyNXBQ=;
 b=OZKQpXKcBRFmkx/UahKtIaCF6NWcO5HVccl3DVjtq3IVjPwm9gM8xp3eOjvx0ptX6xXlW/0ko0gswHTQmFJbsRK1R7Yn0dLZyFfE6RWfRh0ASzAQBpghqIhE1R9KB8p5KKoQLsTtEIuSgjiWgC7Lw0C0XxdUXVbcZQQO7P5P+FAsUNuhbpd1s+l99dF5jsbn9XVkT57aGCROj1o2M65qbX7e+3kPkPHkdMyen45+ZMKvsLNrdOWH2FMhcR38FWFZFF8+xhe34g3aWeAZSe7YUqKve4fCWdGJyOJQ4bXscUqlfKC3ulQ/5rB5O96nik61c/48eidC0A+onVlEBQ/Nhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD2TXALPo56+s0ML7xMWW0yjulhU6krJS0obHzyNXBQ=;
 b=cRKvV5DAmDa9zTFbpG4MbywV5zXCvNbR+5g5l5bCPfXyZkXRCrTGIyDEwICYJttTK6nPOraymhrIsVXdCNLdQc/IMHBtqqSt/zoQPme802YfEcPWkHaLObgIMOnnjQ/D4fD0+Xz3EyF/STPLjvYh1rzSK2agSAlMoe1k/2hTRAXhb14uSXxCE0tG5Hzgrj3Foyl2mgttrdWThIVcOKQjbnuYY5wngCWh6XgUxeIwzy3+w6NITTnTSaQ095chF8b77AZZKSOQjfbKf+SAof3Bda7syDJuQExuKdy0aGgt3TVJ+U+/6ZUhhyY/ZWvYaQP0dNfgYadGYcz8jknDgWzcFg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB5869.apcprd06.prod.outlook.com (2603:1096:400:330::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Sat, 24 Feb
 2024 14:25:06 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 14:25:06 +0000
Message-ID:
 <SEZPR06MB69591E1D33137D0FE215941296542@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 24 Feb 2024 22:25:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] clk: hisilicon: add support for Hi3798MV200
Content-Language: en-US
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240224-clk-mv200-v5-0-79f586d6e1a2@outlook.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240224-clk-mv200-v5-0-79f586d6e1a2@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [ohyICwd+ZsQ4/3eZl3tyW1SbWdqWN93/jpUTXaIwlxPJ24tOJFnvHZuSdb9udVCEMQp0NDjREpY=]
X-ClientProxiedBy: TY1PR01CA0189.jpnprd01.prod.outlook.com (2603:1096:403::19)
 To SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <de81559a-35ab-496e-9fc2-5d55da0c8edf@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c352a8-7f01-492e-7165-08dc35446532
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uLeTZBl/kkM3xFYt5QiDXZRpBts7cY8R+ra30WCGcazGgt19+KOBeg2fyXO5tEJuukykK8G/t4B/XJ4KQq9ZjzRy81MHsAy6KSVN4p+GRevvGdSBNqjBUicWhrnzwuN3Pn0/p/A3z304SG3Vu7j88SpE9/964hGWcE6Z458R9gnWpqVKB1ruv6+xTTGVsm8vQi1rk4oHgR11aMyJKknlTcX39d5OLTYjW89anOwPvxZjezf3I8b7Lv7xDiQbpdNdEycYAcv7oZwAdqaKgfvQ7vl/LLwcZRC05QxkHZWpQbdMjygPO0hdW8Hb6RkoNt4/NxB1tn9PN+OjPz09N0yyixpous8cOEWSAttSg7CWFuDCC/ntKJGGpiA6OpclLBZ7JeO13wqmrcOL5b/2HAhOHiwc+knJssLYDyO5wERpBf4fWQ53ImGGpSlEFcGkoLmayYlpc6XZSdykvSw6Rqx3kXWQcqH3QVYxDnCQIlMs1dQBYRdz1Sk6R/hHaQyR4cyDYTBD/L7pGn73sl5Y8+IipvtrVLWyf26zsTPS1kYcTSM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkVuUmhlQzNkVXUrZ1N4bXQvMG5CVExYYmR5eldFUHJETDVreTRwc0JHemR6?=
 =?utf-8?B?OFh5K2swK2FqaUkrVzBtYnBXamRsdXJISUtndzJWbnNRL2FPcmFsV2h6dmJY?=
 =?utf-8?B?M3lhSm5ENGI5eHl0VjNWSFgwbTlPV2pzbDIxZG1ldkxjeGxodXVjdUIvU3pm?=
 =?utf-8?B?VEVobGIxb2RNZWEwaks4VkVpQ0FzRVBualZnNk1lRi9ZSmtac2R2dXAvNEtF?=
 =?utf-8?B?cHhCUERsMENmcjI5TUVSdVh0NGtTcWFBNDl4VmVGVmZ0ZGdHV3R5S3lMRGMz?=
 =?utf-8?B?dy9RRXJFRzZZRnNLMHBOdElFM1Q5OHpSU1pTTU42VytxR2tqZHkwTGwvanJs?=
 =?utf-8?B?TmVYOEdsMGZ6QVJ2a1NDakwwQm1yWGhjTVVFUXZlSitDQi9WdGloOURtblgz?=
 =?utf-8?B?U1V1WitBcWF4QVdUbVVPbXQyOXZEM3pGNDlJai9oUDBXaTJNWFFrZGdQVmRq?=
 =?utf-8?B?ZzBwVkVTM1RrMW5ITXlBUTdpUkc1NSt1TnJYREVwc2h5VXhwVFd1alNsaWlt?=
 =?utf-8?B?YTcxUy9URk1XK1c5dFI3L3NjeHZlZGFJVWYvZk9jYnlOTWsyZlNQaFQ2Nmgv?=
 =?utf-8?B?V0VrdFR3L3NtejJCNnhJbUpMNTdKaEdHc2JzUlMydVdtSnMza1c5RjFaUjV4?=
 =?utf-8?B?eWlZSzd1SFdPZG80cENVTloxeXRGbW1RTUtCSm5Pc2RnZGxxclBiNnpoNnpt?=
 =?utf-8?B?MlN4ZE9oNXllbk5HdksrcmlrWHB1SmtFTmNFbUV1TEtKK2FqWWhhcDVETk85?=
 =?utf-8?B?NjVnd2YwMDB3YVJwaEo0a2orUEEwT1lCbWtFRW1xQlpGZWtzR3lYQmZFdDV3?=
 =?utf-8?B?QmxWN1JCRHRRVDZwbWxEZUZXektUSXBBZm03T1pPTGw2WHZFUUxramZjYU1O?=
 =?utf-8?B?TXFHVXBpdm5hYzZhL25vbWxzQjdpajVHL3REMEdtRFYyRUszaGFVamVCM1FJ?=
 =?utf-8?B?bG5qYzJmVnBmTHlKd2JKcUsyRFVKb2I4TkRmNTBvd1ZiN2REOGhPbDFqTThZ?=
 =?utf-8?B?ZEpjNU5wNmw4R1F6OVNPcE9tRmpKclRCZVNGWnAzNnRCaU1nTEdUNHpxcGd0?=
 =?utf-8?B?aHF1dFNtUFVMdjFIZ0lGZnBiMFZLRmhqYXJTNXNoTWlzOWRlSytOK2p2WitQ?=
 =?utf-8?B?MEF5VmRhWFBpK2xwelVEREcrWmlkMHlYNXFyb000elJua0hHSzdKZ0p0NkQ1?=
 =?utf-8?B?VHZvQUtHeGptQzlmdE5YbytTa0pycWZ4dXc3WkoyNHpMOHRoZjFQKy9nVXBB?=
 =?utf-8?B?VkxTZVE3Ym83bHpwblgvS0hsdWQ3dGZ6Vlc4RXhNY09ndTNDOWxuQlM0TEZT?=
 =?utf-8?B?QVdzRDhybU5vcFI4QkppbTJ4UXB0bXZ5YXFjZW1qN2pJVTRjck1XY3hVSllT?=
 =?utf-8?B?dGIrczNqUTJ6OUM5ZG9oYXdlUGpnd3kxaU4rRE1QTUFFeUVzODhlYzd5V2Rl?=
 =?utf-8?B?MWJWWUU3K09yYThLQk5xSU5BN0t0YmRzWkFNOFowR1liUEdhSUFvejgyY2NY?=
 =?utf-8?B?R2NJOWhpMnlRZVBoNlBrMEcxWVJSOC9aZE9ubjRtV1pqdVUyM3QvcGFGL0NF?=
 =?utf-8?B?ZHRPMTNwWC9SL0FZZUVOMUcxK0U3ZjBFaHFablo1eDNwYmFzRDhNaENSWjFM?=
 =?utf-8?B?NzhUbVdvYXFuR244Yml5WVBtcCt6NEZMNFRiUnhxVmZUZmpPTlNyOG9hbzVh?=
 =?utf-8?B?dEhnN2h5eFdLOXZmbmhuNXhuRTJBNnEzNFlsZUcyVndjVW92eVhwNERGcXhj?=
 =?utf-8?Q?E5CXA+wcJ3ZGYiR35eOHx1Sm5HrBBv90LC8Zg5A?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c352a8-7f01-492e-7165-08dc35446532
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 14:25:05.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5869

On 2/24/2024 1:12 AM, Yang Xiwen via B4 Relay wrote:
> This SoC is similar to Hi3798CV200 with a few more clocks in CRG module.
>
> Note this driver is still ongoing, many clocks are not registered in the
> driver now. Feedback is welcomed, especially from HiSilicon people.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> Changes in v5:
> - sort compatibles alphabetically (Rob Herring)
> - squash patch 5&6 (Rob Herring)
> - Link to v4: https://lore.kernel.org/r/20240223-clk-mv200-v4-0-3e37e501d407@outlook.com
>
> Changes in v4:
> - dt-bindings: hisi-crg: add reg and #reset-cells to required, add reset-controller to required for cv200
> - dt-bindings: hisi-crg: do not add "simple-mfd" and "syscon" for hi3519 (Krzysztof Kozlowski)
> - dt-bindings: hi3798mv200: replace spaces with tabs (Krzysztof Kozlowski)
> - dt-bindings: s/DTS/DT_BINDINGS_CLOCK (Krzysztof Kozlowski)
> - Link to v3: https://lore.kernel.org/r/20240222-clk-mv200-v3-0-f30795b50318@outlook.com
>
> Changes in v3:
> - remove RFC (Krzysztof Kozlowski)
> - rearrange patches so dt-binding comes before drivers (Krzysztof Kozlowski)
> - dt-bindings: Remove lots of properties
> - dt-bindings: stop merging all hisi-clock bindings, only convert hisi-crg.txt for now.
> - dt-bindings: remove hisilicon,hisi-sdmmc-dll subnode (Rob Herring, Krzysztof Kozlowski)
> - split histb-clock.h into two files, deprecate this header file
> - fix all users (hi3798cv200.dtsi and hi3798cv200 CRG driver)
> - hi3798mv200-crg: add a few missing clocks
> - Link to v2: https://lore.kernel.org/r/20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com
>
> Changes in v2:
> - s/dt-binding/dt-bindings in commit logs: (Krzysztof Kozlowski)
> - fix bot error by adding "hisilicon,hisi-sdmmc-dll" to syscon.yaml (Rob Herring)
> - hi3798mv200-crg: assign fixed rate parents to some gates
> - hi3798mv200-crg: s/ETH/FEMAC, add GMAC ctrl clock
> - Link to v1: https://lore.kernel.org/r/20240216-clk-mv200-v1-0-a29ace29e636@outlook.com
>
> ---
> Yang Xiwen (6):
>        dt-bindings: clock: convert hisi-crg.txt to YAML
>        dt-bindings: clock: histb-clock: split into two header files
>        arm64: dts: hisilicon: fix include path
>        clk: hisilicon: fix include path for crg-hi3798cv200
>        dt-bindings: clock: hisilicon,hisi-crg: add Hi3798MV200 SoC
>        clk: hisilicon: add CRG driver for Hi3798MV200 SoC
>
>   .../devicetree/bindings/clock/hisi-crg.txt         |  50 ---
>   .../bindings/clock/hisilicon,hisi-crg.yaml         |  76 ++++
>   arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     |   3 +-
>   drivers/clk/hisilicon/Kconfig                      |   8 +
>   drivers/clk/hisilicon/Makefile                     |   1 +
>   drivers/clk/hisilicon/crg-hi3798cv200.c            |   3 +-
>   drivers/clk/hisilicon/crg-hi3798mv200.c            | 462 +++++++++++++++++++++
>   .../dt-bindings/clock/hisilicon,hi3798cv200-crg.h  |  62 +++
>   .../clock/hisilicon,hi3798cv200-sysctrl.h          |  17 +
>   .../dt-bindings/clock/hisilicon,hi3798mv200-crg.h  | 150 +++++++
>   .../clock/hisilicon,hi3798mv200-sysctrl.h          |  21 +
>   include/dt-bindings/clock/histb-clock.h            |  70 +---
>   12 files changed, 810 insertions(+), 113 deletions(-)
> ---
> base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
> change-id: 20240216-clk-mv200-cc8cae396ee0
>
> Best regards,


Please do not merge this series. Some critical clocks are found missing. 
dt-binding indexes needs update.

-- 
Regards,
Yang Xiwen


