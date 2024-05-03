Return-Path: <linux-kernel+bounces-167160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4438BA514
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A61B1F213D2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866312B72;
	Fri,  3 May 2024 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h3kh6pgF"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2107.outbound.protection.outlook.com [40.92.102.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B117C64;
	Fri,  3 May 2024 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700864; cv=fail; b=dDwhUi34sLby5s+dh0tTFUv2ylMFanYQnGNt8DgVkjtD723eG9DN7lBlwh6Zwea17p9KI724zzdHfWZwOBESj5Yk7AgAOAz5hTRBWOUqw5t0PscOS0qnCH76QwVqYaPLFIwQLuSwF4l1c5ZwFndYQVR1++5LBdA8e5o5KjE01Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700864; c=relaxed/simple;
	bh=kitP452pSO0+MYchVkPHkD9EZVl+mUu/4gqQrUXFPmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tqm7QzwSzu1BhW8692uhQcKE70ONU2+e1prTBSkkfmpi0G+GTpfY+cuNxSNfdRjuw8G/NzkDoOOW+4uB3nSatBHXDoQm/YupjUY9GqPkTAHiBFPAFN0SeTAv2gRo8TGc1stKKPQeW2I8mxHGbbFH5fYE/P93706wguwoVZlgIEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h3kh6pgF; arc=fail smtp.client-ip=40.92.102.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6mz8QAQkrEwcqoQ/n0MaCfcyZO5BP0TcUiLQ/rRd4gnFFuFtpST8twLAT2LPJJDebcdCcYJtmoB8B67+MW0jE9607RUBpA04WnNNn+4y8KOYYPKGu+W5y7W8T1F2/Q4pjqO/RnS+0+Wad00KJsu+vB1PE+uWPAnh3Q1hoZkDZlo7zRn2BrV27HIChCYc3yTj6/Rzv46+iWqKPk2mdcg30wLrC9bac8L0HVIZGV/vyAIaEe3GUHWrfy7L4qSWmrh6mNhk2wpcug1G6t9FCJ+lwT06OZCy3PI+XVmDP6jjsC/f6MpXV5ercSiqnka1AGxkKDHESu5FlbMlM3IQYT+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AC+bZicyWs+KrUWvKh6+Lzx8940Y6BwYuDWNfBetfe8=;
 b=hS8MFo4t+58DvWiwrw9Ep05oTb/LM46a/GSJgiqXGERVWR+3Z5dl/xZsCEE4fdZVmv/4DtjFsbDB8V90DFx0/2cT06r0I+mrRkm34BQdP5nKw84/RiO4xWRIuFy/kfTImhrH7bgiGN3Lmti24S3iktoyTWnSOAP71PG0tlY+iM/R6eDzPRjO8rvwfXjW4rkulpBGJ5seDLOBMEMcFD7FLnDlg9XhpN5tuG/kV8sTDfkkn1koXn1tQy+G0eDKTm15tyc0ZG0cQU7bOQxYHoTuUMkjp96ekez9dvrP2X1jpw+OplMyNWB1yoJuhmUnl07/XYr0uDOYmtHno95joAbS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC+bZicyWs+KrUWvKh6+Lzx8940Y6BwYuDWNfBetfe8=;
 b=h3kh6pgFf75aATEz3fxCuxb7Fqu4pcnSg/cLI1qO4NlH8ur/c1L+5dv0Mae+65lzSQA52OdnnriTNrgV0kzKqoPoqQW4d/S8cGSJwAB9z98YWsIpsm2oNiw1/v+Q0clM6uAJK7DJEk5uChoyCZdiF1tqSEHaZQxheHAhj+V5dH5Lpn7uf9ivA70b2KO6k31Iufh+4y9BhlxBsqkaKgS2xtII1JMjPmCkxH9aw5KZGWYtk/ycvlZu1euMS2qUv6ayNJJUjK7/WKHZqcJXx5qak1AgyYEo9UBHOIyOpFil7PREystf4EQYstrdJNg8tGwhROStyLNarh+pT1gAPIPKaA==
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:214::7)
 by PN0P287MB1526.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:186::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 01:47:36 +0000
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d]) by PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 01:47:36 +0000
Message-ID:
 <PN1P287MB2818F3818BEBE875C460F158FE1F2@PN1P287MB2818.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 3 May 2024 09:47:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] riscv: pwm: sophgo: add pwm support for CV1800
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, ukleinek@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlan@gentoo.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [A/ix3dZNnhf7b+ZX7GRrOih7r3pbBmvM]
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:214::7)
X-Microsoft-Original-Message-ID:
 <1d996046-c633-4c99-b473-9b71ccd65123@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN1P287MB2818:EE_|PN0P287MB1526:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e90403-a4d7-4809-131b-08dc6b1301c7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003;
X-Microsoft-Antispam-Message-Info:
	YHDEYvIx8JYvHxyyWdIWrC9LMAiy/MWCm0PvrpCyJj6P5JkfoDVB69gdk0/VY6+hJj3ceL+eKTvD80pVCC3XbZ0UjC8C6VV0/FGudG3puv1K6JN60zFnDwDkvektE3NyjMzBqk+wnOo8ASqmSISaFKQOZFrE2WHHxFuoiSTCTxYfQWHHGoR6w4gwAfigtlX1KjkEf58kxsltscrPtuxxH9ovyN8i3sbU65jb5RpD0usEEmclQ/XfilDXQimBaJBCnnJNwvi9NIyTx5IS0OhKy/z4H1llpRPT6gcXWPBssPeJMq6Ma4QnY7muwKe/9qKI7xG/FvDJeCL+qP5EkIwCDLc4Xw0OBXR3pHvlnZLSs3AxfSsjBo7oU9kRx5olVDKUKTuX0sLt90Et+KVIeGH5y+Sw4qU/EDdwf26tDzjOez0jhTGq64BvnD3xi1CdPBLPHUM8QQUrEkHBfWj3Yvb3fL/y1xPNAjBU5tYdkTAX+VRtF3dL2BVPJWRzg1EpdbafabuaZ60WWc5FfW+sQ+VJRDuQD7eDHHmRIG/P041RMuRFuEEr6n5vxfGBgpoCaMNZD91iCmDDPjXPw7TeOUShI33D6gCkmaElfCRZVOBXXc4pNIDgMowUHom42YrlD9VGy4y1Ly4n1i2ehwH6EQYzJ5zqXhTXy8myP0upOx2QjPo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3Q0NExIdFlsdHdKbFVSOUdQckI1YkFjdWh3N2JqVDhLM2swUW5ianpyZ2Y0?=
 =?utf-8?B?SCs0OTJ3QlJoVnppYUkrVDFXRHV5eUdndTdodDUvcXcrSUZyZ2NncVJhZ1pt?=
 =?utf-8?B?c3VXRlltZWg0N040Z0VhUmIveEs3ZCtzUm1IK3o5S0MzcWM3dCtqSTBVbTRK?=
 =?utf-8?B?VlJkZCsxWW9iTUxqdFFhVU56cFdYOFptclJEblJ4MFp4MXBxWm1OdUlFUHdV?=
 =?utf-8?B?S0xCQnhrUlh6aVFTUkVUSEhOSWNEY0FJUGpoa1FkVk5TcGk0UHFyTGVyeERt?=
 =?utf-8?B?ZnZlZlMzNndwZkJVcFpEVkwrTnV2L2oxN1VKT1AzYzBLOUI2ejFNU2dMNmJk?=
 =?utf-8?B?dHE3SVJna2JNMmRDSVg3OCs3SWFLVDNSVVQybHIyK205dVd4YVBBaWdoVFJr?=
 =?utf-8?B?ZC93clFMWEkxaXg0b3JpdlZ2cXYybVowMFJXcmRqeXdVTGthQ1RyVDNVNnll?=
 =?utf-8?B?T3ZQZVliaUxHYlkvLzJMTFFMYnBDajRzbTFTNkkyakszQnFIanRKcXRXcGFi?=
 =?utf-8?B?RnNXNUVNRFRWK1FVTFBQUWZ2eG5lTFpOZGFzOGx4VWJBaTRyWmZzWFV4azA5?=
 =?utf-8?B?cnpCdVRleUt2RlhsSUQ0ZFl0TThBMjR0QXNTMUJsWEJCUU4zbmFaelo1eXkz?=
 =?utf-8?B?cUxBTWYweDc1RWtHMllyWjRQOVF0U09UOTh4aEh5ZFlzc1hxRTF5S1VWWmFM?=
 =?utf-8?B?bnhxb3M2dnpNdTNrWVg5WFNkK3VQR2Q2OU5lRG0ySEt6MFVLcEo5SzR2eHYv?=
 =?utf-8?B?SzgrNkw3SHNYYStuWjgzbFBDMUQ2RDg1TUF4aTVTMVBwSnBncnVEWUFacU1z?=
 =?utf-8?B?QlE5MCs3c0N2VnBuaVNZN1EyKzNSS2VVb0ZidzdRRTEwcVhrSTgzR2o1R3dK?=
 =?utf-8?B?bFVBSjJuUUkvVWhhdldhaGZxSThyNnZlM0FwcFQ4Ym10d2E4SHB1KyswemJ0?=
 =?utf-8?B?ZlBsQjR4eGdqOGx3WllLak1wL1dvOWtrTEoxSzFTRlBxZ2xaU0tnMTNudkti?=
 =?utf-8?B?aWwzc0pPRGVZV3htZWFlR2tTWHNERXRkSW0zWTJmbXZvT2VHOWJsM3BOYXJj?=
 =?utf-8?B?YThIZ2RMT2FreE4wSEJid3NXN0M0bjJsMEhyeUhaUVhld1hXTjVNc29FMFdD?=
 =?utf-8?B?MmNSSHZWNk1oSXM3UzZtL0t3TjVsVmNZTDV4YU1QTEtrNVphWTh2aW10T0Iv?=
 =?utf-8?B?UlVZa1gwS2h5alIwLzRYZ2ZCQmdBTzI1a3BCbzU3bTFwK3lxWWNJNkhiNi95?=
 =?utf-8?B?WVFLd2ZTNFpkcHZaVlBsV0FlYmVpNjRGUWdlSXdxZ3R5ei9qRDl3RW9qbTQr?=
 =?utf-8?B?TTdFRzBRemNzRmRsT2loaXdzdlhKM3pZYml4RWFQL016T2ZwU09YbWlCTFBO?=
 =?utf-8?B?akdjNG5scXp3T3JOczlOZUhndTVuVFhpUmtFVnlCNmxzcXQ1SU54SnZLMjlz?=
 =?utf-8?B?NHRoczJlMEdRcGxaZXlqRmw0QUFrUGpobllkRERjMEhPK0hxcTZncVpUSFl1?=
 =?utf-8?B?YkJQeXRzNGh5bDh4aXRqR3kvYlk2YWdvR0djaGRvY0MwZmJ4TjA3blBVWmY0?=
 =?utf-8?B?c00yNXR6SVhYQXZDUGJBQ3NXQUErbFdOWDNaanhaeFk3ZDdISEhVZFJVYXFt?=
 =?utf-8?B?YVFRdHdkamdtckJObHBDTjJCZkszTlVqUnJuN0xmdUNXTFRnTkExNUN5dGdL?=
 =?utf-8?Q?ZQkQbXTxjx4qU8jHAhN2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e90403-a4d7-4809-131b-08dc6b1301c7
X-MS-Exchange-CrossTenant-AuthSource: PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 01:47:36.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1526

Hi, Jingbao,

This patchset should also be sent to the linux-riscv mailinglist.

On 2024/5/1 16:32, Jingbao Qiu wrote:
> The Sophgo CV1800 chip provides a set of four independent
> PWM channel outputs.
> This series adds PWM controller support for Sophgo cv1800.
>
> Changes since v6:
> - add detailed Limitations
> - using BIT(n) instead BIT(0) << n
> - use 0 instead of disable macro
> - modify OE judgment criteria
> - add devm_regmap_init_mmio error message
> - delete unused variable
>
> v6: https://lore.kernel.org/all/20240406063413.3334639-1-qiujingbao.dlmu@gmail.com/
>
> Changes since v5:
> - delete the OE function because we plan to use the counter subsystem
>    instead of capture, so there is no need to reuse this code.
> - fix set polarity reverse error.
>
> v5: https://lore.kernel.org/all/20240314100131.323540-1-qiujingbao.dlmu@gmail.com/
>
> Changes since v4:
> - drop filename
> - fix macro
> - optimize cv1800_pwm_set_polarity()
> - optimize cv1800_pwm_set_oe()
> - add comment for cv1800_pwm_set_oe()
> - use ticks replace tem
> - fix duty_cycle larger than period_val
> - use devm_clk_rate_exclusive_get() replace
>    clk_rate_exclusive_get()
> - map linux polarity to register polarity
>
> v4: https://lore.kernel.org/all/20240304085933.1246964-1-qiujingbao.dlmu@gmail.com/
>
> datasheet Link: https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
> page 614
>
> Changes since v3:
> - use macro instead of npwm number
> - add support for polarity feature
> - add support for Output-Enable/OE feature
>
> v3: https://lore.kernel.org/all/20240223082014.109385-1-qiujingbao.dlmu@gmail.com/
>
> Changes since v2:
> - use 0x08 instead of macro
> - split if statements based on conditions
> - in order to round up, first calculate the
>    number of high-level cycles, then subtract
>    it from the PERIOD to obtain the number of HLPERIOD
> - use new pwmchip_alloc() API instead of old style
>
> v2: https://lore.kernel.org/all/20240212121729.1086718-1-qiujingbao.dlmu@gmail.com/
>
> Changes since v1:
> - drop full stop from subject
> - re-order maintainers and description
> - pass checkpatch.pl --strict
> - fix naming errors
> - add "Limitations" section
> - use a driver specific prefix for all defines
> - using bool instead u32 in cv1800_pwm_enable
> - check and set state->polarity
> - use mul_u64_u64_div_u64
> - use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
> - using macro definitions instead of shift operations
> - remove shift operation on 0
> - use priv replace cv_pwm
> - hardcode npwm
> - set atomic to true
> - remove MODULE_ALIAS
>
> v1: https://lore.kernel.org/all/20240207055856.672184-1-qiujingbao.dlmu@gmail.com/
>
> Jingbao Qiu (2):
>    dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
>    pwm: sophgo: add pwm support for Sophgo CV1800 SoC
>
>   .../bindings/pwm/sophgo,cv1800-pwm.yaml       |  45 +++
>   drivers/pwm/Kconfig                           |  10 +
>   drivers/pwm/Makefile                          |   1 +
>   drivers/pwm/pwm-cv1800.c                      | 293 ++++++++++++++++++
>   4 files changed, 349 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv1800-pwm.yaml
>   create mode 100644 drivers/pwm/pwm-cv1800.c
>
>
> base-commit: 32c44e1fa921aebf8a5ef9f778534a30aab39313

