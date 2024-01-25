Return-Path: <linux-kernel+bounces-38563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70283C1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4464628DB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB6376E1;
	Thu, 25 Jan 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Kb3G5uO8"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2022.outbound.protection.outlook.com [40.92.102.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248092CCAD;
	Thu, 25 Jan 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184477; cv=fail; b=LWHiTxuPrgDXwk/kEd1NBzPgMUOo6FmIuUbQhfyk9CTCq3vuMAWHlpeoQBTGEMlyZujilrSVlTnwyVCjexUtkGbUW5HohTiqX1PvIj+OEroxi5nt/gKaILgC23XC3RxET5x2LvgRVTAqDLaio1Jx73IxC/wZ0UWSXhlHJIqx4Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184477; c=relaxed/simple;
	bh=aTxSUanPL73dX2ZvXY2ZaAA9u2OiSG9VgEFwA24h8/c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mVAwItkUom3zRkidheJkqdE5RjD45k6LLs0j1BWnVFaVbqBnHaYYKN3D0PF+srEFjEwVOuKblRSOdpMJ6E4K3R0bOPM2Gq4Mu29jpRdFWrrdHHdEiTfbBJwqy0RhTkURW9Ec/YFXabdTAuNLczREuD3E1UDhnnsGkARETw4WaOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Kb3G5uO8; arc=fail smtp.client-ip=40.92.102.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9jVbdVITKYA9Pv1EIqEvsdpn38SMP/e2XlC2QSA2pNdFjHj3otvyBx7QBUq+BLyOvWuzTwW5IEQTn6+9qI+4BI/5Jq1c+4IH/1MW/MRmek43hOoeN7tK3DXVtJZVRMV33McZtNuzARjlg5ubymMe36/C7yILvAP+jt0Bz5KLI8reT7R6qXwCabEyrRULNPkyox2fqB5GTxPCCm7o2M6IheN2czW5Og28W5hgfswrM42spz5rUGzDUpBq1SjxxidRvdsjVHEoFxIWDcwAqHS9QbzOZMYWTKhO3l9vRUp+sdXRHlGDku/q1B2LvHfg8crvbm2imlj3jh0E0fKauTEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAJt3reeZAE7HCOMsHyi6NWHajuOmRchEC/Bx1v47Y0=;
 b=ZoAOHN4cH5IKYx78Qk+DNyD2YWeGqDhYh17LraF0N8Fhxha99KtOC3gaHQZnDVD+6cPtwt/peiowJuqn/E5sUpwyEp3YFhgFhp+Ad9v+lOu7ToHONzWeF6hkbGn0o2qUxo6TumjFLInHgGYTyTjmHFqJcF6oTGxSLAOzIYY0tsfk9pk/CZEFk1q+ozVYkm6lAlcqcLQtBBOQQp+SnriHjieG6MwnflwdDHq7xRTTAEVIV/uO/w4D1zYRVOwK8C6ugqoxheiDlFLr3EiOC+K6m3gDRnkWyYy1RbEmIGCSXlhPD52V2zFiuMBqyIbQJp6cO864HWjMuYLfx7jqmVwDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAJt3reeZAE7HCOMsHyi6NWHajuOmRchEC/Bx1v47Y0=;
 b=Kb3G5uO8cz46lSGHblio/HXF/V68odq9/cHzNB/50WFNEX0OI53cPTLo46Yb4ZbKSOWj7m9d/PR3f8Ay7tWu+WsxOho1GctLpLfozfVm50iJWj3rjQ0n14ketffitI5Rme1VSBoV+5prikVqB11IO+cI4Xrr73wg4LnVm195G3meiB9Sia7wnOYgYZz80sJmxv4GyN3SZYE9le4xyKmAk04CJFCPeTKeH/U9M3ST5+1fpya7CdPQ0UNeyBtc4xN0L/rA+iDTATzR0UfAJFtvzcv0lfMY4noXy/GK5CeSvoKub4wOfkVMC4DMv7hD9kj2rwcCHSzgKX4JoUvA4vyasQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB0714.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 12:07:48 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd%2]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 12:07:48 +0000
Message-ID:
 <MA0P287MB28226D07A5DC0200132358C4FE7A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 25 Jan 2024 20:07:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] reset: sophgo: add SG2042 reset generator driver
To: Philipp Zabel <p.zabel@pengutronix.de>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com
References: <cover.1706161530.git.unicorn_wang@outlook.com>
 <34650036ea5f1c500da54c67c3a67b91c4419399.1706161530.git.unicorn_wang@outlook.com>
 <bf30a97b4c39e5c606583783058ea12520c1146b.camel@pengutronix.de>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <bf30a97b4c39e5c606583783058ea12520c1146b.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [LuvVD9ZtLSWSLaotXcME2xH2c0qrxrmE]
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <bacc7ff9-4d8b-48c9-9f97-0f92fe491595@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB0714:EE_
X-MS-Office365-Filtering-Correlation-Id: eadf1b71-e15d-4a7a-904a-08dc1d9e3f55
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gmtzmgpjUqD5H9U0c2GWO3FQS7AM6iFhPtRHiZ+ycZ2IvrsciHq5ivREfNdfE1MDdxmD4CY/OfF+bo9GRX7lqrD5XdTlMA/V8J85rPGA2m9G0LUl+/0SW802M0/SXJNaj8M81v66i4MFz3SYIihDS1r0qUj2xrNQCG6cobczQO7pGxiQLxilDKz1aczca5GfSIvS9zgZGKn8x8/Pc9zWp9bs6FGFHLT/yoM40ib8R0OMUEbXYfpQHBublIxRb+wQDOY3/z26brnH250ajcmb15IX6YISrKwMj5Q1IDuyHO10WC0uPLyXNfnnL1kgRasFpgwvlDFxRamMDktO2XRHQpH2kqo+dzOYYM4uMfYV6p+/AFYA8ecKWzAhHqZJlHyU3dvGPsO/idL/Viic47ikhmmvYM47zMbSgXFyAicAFkzMI89Je70yIXqYs9AmJj8ZV0brA+JxBne3K2/yX57/4cIRX5Ym/XF8uC6btfgjG1MN8OcwpPq4VzSMKqjimfXweStjFWL5rWJJnL8oTXSGw+c2FkCNaIGD5PPMGwOXpbKvAJqUHoxcEq49P2UaIl4B
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0dkQjVMbkFNc1E2aE5qY1dFK25yWk9IK3dBeVBHQi9WbWd6dHhvV2toRVBy?=
 =?utf-8?B?RlFNL0ZMU2FXU1BMUklUeDk0Vm1CWDU5N09HU2RoeUdtcU0zWmdCNWJyU3RE?=
 =?utf-8?B?Q1JBZHg0TzhWQkRWUURjVjFoV29xdnhET0owdHRIYmdKN3NEdlVOYmNlT1Az?=
 =?utf-8?B?SDc0MEF0bkFNdlY5TUN5cnRLVStJeHVEdnVTMG5WSVJwY29JcmtoenI5TVF1?=
 =?utf-8?B?cW8yVHhRQm1VVmF3ZmhFR1Q2Rkh6eDV3SDVGQ1U4RU9xNWdiaTJRaUZVa0JC?=
 =?utf-8?B?TER4YlYyYk1FUWR2QVlHT3JFdUlDUjBkdnJvL0hrdyt1UG9ZRXNmR012MzQ4?=
 =?utf-8?B?SE1hVzBvVlVjYk1KOSt4RW1YNGNTS1grZzZFOUF0dVUxV2tnODFWL2hZRVBT?=
 =?utf-8?B?eWR1OG0rYzd3U2xLelhBM1I2RWMvRkpTa2hDRUw2cHZkcDFra0YxMGhVbE9q?=
 =?utf-8?B?ck9VUUh6V0pzUEdlblNZUElHcElvMGk0T2FTUzBjSkg1OTlTVktVcC96cmtV?=
 =?utf-8?B?dndtMThHc29Lc2hUSFFHMS85dENLRWpwSkQzWTk3QWhiQUpTQW51bEV5bFZD?=
 =?utf-8?B?Mi9HdFQrMUlxWmxDT0RVL3ZoSGM5SGFXdjZhU2lGVEFlT3NCREJMNkpWVjdv?=
 =?utf-8?B?Qlc0Si9BNmZrMnBqY2I4dXB4b0pnRGU1NlJlQUh4RVp1OWdRSzZnVk53dGxG?=
 =?utf-8?B?R1BMTDBWc3VraEVXcTQ5L2lvWGc1K2pPdmhIcnNJb2NqRk1BaWV1MjhzK2p1?=
 =?utf-8?B?VE0xQWQ2M05ybEZFeFhYOElLOFc0SjNKOVVrd1Vac2pIcUw0eDJkOUV3ajU1?=
 =?utf-8?B?cmpnYzIva0JITDdKcmhTSm14ckltczNzQjlKZ2Z4KzM3V0FHdGkvMXByZGJp?=
 =?utf-8?B?ZG1TMTJyTzlDSXNXRXlEN2V4SlJlaVl0Ym16VElRMTcrdnI4ZGp3RERVa1J3?=
 =?utf-8?B?cDZ1b2ZZQ2R1aGI4R0FEb3g4SmZhaFZJdDZjT29JTGVNYjhFZWZybmp2cWZD?=
 =?utf-8?B?Qnl3SXdianROempsZUdHdUJBSytVWmtkM1J2Qnl0ai9HcmRadmhqN0F4NUNa?=
 =?utf-8?B?UktoYjZNZFdjN2pPbEdydVZwY05Uc3lQcG0rRWN0QXRtdVRWZEJ1eFRGbHE1?=
 =?utf-8?B?clhnQzlEeWxmaSsydjhMdUVvVVJlRDYxaDljTUtveVBPUkc3Mmw2SnY2b3Ns?=
 =?utf-8?B?UmZpVTlOSEc4RDBqb2hZR1VTM0habzRneGl6aEdXK3FzWlZraUJaMHZXdHpp?=
 =?utf-8?B?WEJYVzlHYnRMdGxIUnZtRjJrS01DbTMzZmVUSEpZYnZtd3JMcEprdE9meFlL?=
 =?utf-8?B?ODRjK2I0bk15cHRjL0w4YUZ1UzN0VXpRNzg1eGd0eXhkY3BYQWg2WHhhL2NT?=
 =?utf-8?B?SFF6NitlejJEWVZiNzZxZTlCUkVuQ0ttMVpEekU5akJTdmRwTE4rcGdrVkYv?=
 =?utf-8?B?TXpYbFRIb0FvTy9pRmJzTGRVRWxGRjFyMHJFV1g0WEVlTzRHVkZvc2w0UXdL?=
 =?utf-8?B?L0pCQVhYREFheldYKzV2T0d0bHVKbWN6OFlISENqekh3MFFtOXhHWXhyOW1v?=
 =?utf-8?B?blhNcjFHNU9yUERoY0N2WUVsSHZRdmJXLzFOTVNyTjg5OFNPbkJMZkNWRnJ6?=
 =?utf-8?Q?oK2F0wP4z8d+vNRBRDvSZjQ0uuGbnABryJVfxhOiZ8jo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadf1b71-e15d-4a7a-904a-08dc1d9e3f55
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:07:48.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0714


On 2024/1/25 18:43, Philipp Zabel wrote:
> On Do, 2024-01-25 at 14:11 +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Reuse reset-simple driver for the Sophgo SG2042 reset generator.
> Subject prefix should be "reset: simple: "
Ok.
>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   drivers/reset/Kconfig        |  1 +
>>   drivers/reset/reset-simple.c |  2 ++
>>   drivers/reset/sophgo/Kconfig | 10 ++++++++++
>>   3 files changed, 13 insertions(+)
>>   create mode 100644 drivers/reset/sophgo/Kconfig
>>
> [...]
>> diff --git a/drivers/reset/sophgo/Kconfig b/drivers/reset/sophgo/Kconfig
>> new file mode 100644
>> index 000000000000..9ad96e49e1dd
>> --- /dev/null
>> +++ b/drivers/reset/sophgo/Kconfig
>> @@ -0,0 +1,10 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config RESET_SOPHGO_SG2042
>> +	bool "Sophgo SG2042 Reset Driver"
>> +	depends on ARCH_SOPHGO || COMPILE_TEST
>> +	select RESET_SIMPLE
>> +	default ARCH_SOPHGO
>> +	help
>> +	  This enables the reset controller driver for the Sophgo SG2042 SoC.
>> +
> Drop the Kconfig, just add a default y if ARCH_SOPHGO to RESET_SIMPLE.

hi，Philipp,

The purpose of my adding Kconfig is to consider that other socs under 
sophgo may not use RESET_SIMPLE. I'm worried that the coverage is too 
large when default y if ARCH_SOPHGO? What do you think?

Thanks,

Chen

>
> regards
> Philipp

