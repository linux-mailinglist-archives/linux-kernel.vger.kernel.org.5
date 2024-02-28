Return-Path: <linux-kernel+bounces-84862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E586ACC2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A18B22C29
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E07E12CD87;
	Wed, 28 Feb 2024 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="NNRrYkEK"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5C36B09;
	Wed, 28 Feb 2024 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118881; cv=fail; b=aFpotfIZOhRV3YRukiH9VrZLFY4oObhSXu5hiamA097xhX8Ra6WjrkWMi9RLfHNah2IOVQesMhFWZRyQM07XyYGGRuY95LrXixNg+EG8Dg7WVG4y6VtEP+O3fYePF8zMfpHOm6ngFSbHepRu22C0axGuGJk33atT2AR3RypEPGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118881; c=relaxed/simple;
	bh=pNokXVyJJnnmnmmKzi4xvfN2Ipfptnr0ZxkSqcVhKIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=teRVbk9Sqbz8Zw7XkM/7mQ0oreXSDgdyOpQ8Sni9aCXz1gEiMS4YoP9IhKnt+N0d4/urNxcH39iBN2e54C1/lq21Iyc0nwVp1HY8+SKHoxXD7jMYU2zl5yrtsi76R9PLbhvIan7JhGccsTImd3dPnJB0GeKSVlmTG0bBNEZNdKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=NNRrYkEK; arc=fail smtp.client-ip=40.107.20.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3oulay0O2R8hKN55XLsG2Ad4iW1GTPcvYFEEBBj58cp9bQgsB+sYxdxSXejac2G92R04c3kqHEdrD1mlE7THXfr2xmPAogQCLPWFnm6jwBwkaOcB8OM2SywXkuurSIGiMKZrCPrlkD8jpNPdEwzyUB9Iw3vAoEbYHuJSj5MXo9cUYHE6nG5u5gYABtjXichXVo90Eu5B4PSlj8BM8hGPypmb3u2BC1OHE6bQrx6pmtIXnuesIyRIxWDVHDOqzM5wi27PhFUAIRX5EjwZajdUqIZzGC5Dad+E0FxVQ0P7r0is5hrEe0DRt3uGJAFBgurlePJLQt+ev/2qQ6pI7N98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY473SOIl6+Kn7gMVDkXzQovKKBVLy/ogm6XktFSDZw=;
 b=PpFVC1kgqJ0jVyNuQR+DIHcO2ESXkXJmZt1+I+5HOkM23XDrqIWlCd/nhBwJqbDNL3AAe8tVuqPO2w/ZJClavblZu/ZwihmyXXlv+Dgp4Dd+01Vd2955y3X/TLOGwMGUTPfl+Fzh8J3nocFXiDpWAvKUjmJAOOyUsKQWOIdnUzkN+6GW3narTE6wzlyThMjBONChPb+RzGjS6KUupnLSuPyLGwxkImbHdzJZsL79j7cnW1KeZtqVCLzpDjJmlkVuUMPOU/oSbXXVEWrG0SrSlXHJGGKm3JCnUPWJ8yr+jnLMOgOivY/bZGqv3ilZ7OLwa5IFfzZQY1o5luE+8k2pdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY473SOIl6+Kn7gMVDkXzQovKKBVLy/ogm6XktFSDZw=;
 b=NNRrYkEKsHCmS0uljGah2+P/TDBvJB0nN4HhkMbWnJpPkiaeUX24+6n62cWzd//WOV/yzmHUnF8uEO4lW3VWSn/m3MZHLqwOHrSYiXUtvpW/OuZ6oanyg+WslZIn94YTqhS74m4nUZM+sytgLZjgzZtOpqfqGGQkXOqnlL2e9nXS1eaFys4Jkz7kJaeqMurv30MfiOuV8Fl6LMuOjqDdvUuldL1uZQCjqQAjoCA2ARXqUuHFyztf2qAWuzCUlxIatHO6Eej9+4gC/kUU0c4g3ntiZnBgBnq9g598RGWCU497a2pX7A9donDTMaXK+U3Y7Dykwfr/FCEJvVVyCnLWAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS1PR04MB9262.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 11:14:35 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 11:14:35 +0000
Message-ID: <a420ad50-e24c-486c-b929-ba178e8c560a@theobroma-systems.com>
Date: Wed, 28 Feb 2024 12:14:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: add RK3588-Q7 (Tiger) SoM
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240227164659.705271-1-heiko@sntech.de>
 <20240227164659.705271-4-heiko@sntech.de>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240227164659.705271-4-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0024.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::11) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS1PR04MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: b8460767-994b-47d7-7aac-08dc384e7215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uA+i6+/OtJia5XE9jAFHU77rko/4/hdU1ALW4gKZw6yGY4G+nEM/NMvgAur+R9XEQhZ24520+G46Bu7rx/+5LYfxI9HsOrpcJ8uD2IZsUpQiLAZt+0GAGePTsKvE7Dq8ZnmS50pn+XP7ExmA+tissP4hkC/YS3K/jziWE1rKJziuJ/INrVGIarhfuMXhtRnxCdm2kQAvUQCgt4+11h/WEehuG6XULP0S0Y/6et/Gb6wbjAr8bZpSBLIWgSeiRtAJPiJwD4jhX9RE2K4pTqNjIAJZFgNqkndPeUc6fXbNGCxwPPqsjYpssrcTUIQJ2jb76grrG1MEEJRmDE4K8Oaw/PWf7vVREKNjWus5uroNY67UhezVk19fYFtUSl9IQlGUVFozM7HzE1kzVdllTUw0jCOvDYnZlMT5VhzX/NKMyGoIs2tDlhSxn905kW6jS8yOyC1j7+Ctv7i89OAmjqoRIs0qOeGJh62BnjDj4D8oo7uAy046PYmHLhdVVfoGA8AD/fGgmDCmFAQFpYJ6+LFv8nyIDMQc8Y0BsT03c8B+/KZB0nuI63MpXuZsyMgUrTzqiPoJlyy2dKdxsZZLYc17UISpRbawgCR3gwBb+0/mStGHYoECSP4R85sC8VEFRXxtzZhyDJY4+d95ZxJAaPQtOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YncxTEErU1hDV2RWbm1BMnR4emdDSFdxMnRwRktsd2F2dm9IVUZwM3g3MkdC?=
 =?utf-8?B?ZkNodHRuNW5FN0phYXdxZy9FYlhsNDRZWXpuSkRpOVVmcXlxdG4yeDlZenpq?=
 =?utf-8?B?TWtqeWZmR3g2dlJ1ZU03Vzk3Z1hzbm82R3FqdFFjdWlYMTRLdXQwaGIyQkdZ?=
 =?utf-8?B?OXpRa3dYNTBWcXRMS3lJK1dtZDR3M08rWUlsc2dtSDI0cnZlN1pOd2Voc2Ru?=
 =?utf-8?B?TUVzaEdjNTRtaml4WTgrVm9uK1U4dGwremZ2S0cyVGhjODB2MXBMM3g4SXd3?=
 =?utf-8?B?M05GS09BVUxJdWJqV05qeXE4N1FVYTFJcjg4QmNMbVpuZ1ZWdlBZSmJDWGMw?=
 =?utf-8?B?VWp5OWZaS09HemRiSTFoZUpXQ1N3cHRZbGFqYVB4eHBOR1FPSmVhTDVsZ3JK?=
 =?utf-8?B?WFk5QzB0TlFXZGRJK3IvL0RoMHQzUUN6NmhPOHdlRkF4T3pKeDBWeXUyUzlV?=
 =?utf-8?B?N0dkK1lpdGE4ZVpjNkJjb2RIdkVkK2d3eWliMFpkVnFsdGxZYVJGblpLS0hq?=
 =?utf-8?B?cHltdWk5NnE5SUt4MzZWVDg0djkwMEh4YVlkcXFOaVhVTEU4ZXpaRE44emFE?=
 =?utf-8?B?OG5STWF6MUtMWVEwUkFFY1lvdFkvNjZjdDlUSWpuZUJ4ZHRGZjc1a1VmeFUy?=
 =?utf-8?B?bXlONzNqd1hsUVhBeUk3b0RWdHg5T3lHN3ZaNWdFSjMvTXc5L1hUWW43OUZP?=
 =?utf-8?B?N21aR2R1bGhoRlgrUCs3bzdnK0pGR1F0OUROMjA3dHRaZWdwSHNxNVdQaG5G?=
 =?utf-8?B?dmlsU3lXSUJDN1dlcTVBRVJWemVWYTRjNzF5Nm1UOEJnSGJHRzlnZXVPaGdV?=
 =?utf-8?B?NFpvaWlEZGkyZlpFcG82U3RFVnY2TktQS0VPRGF0UGVYbFM4T0o5SEJxVGtD?=
 =?utf-8?B?dTdyNXVzSWRnUUQ1ZDJxMFE5T3Q4eWE0cmlNUndsd3BoSEpRNjJQbFNtZ0dy?=
 =?utf-8?B?RXVoMU9JQnRCTmhuS1lrbE9Tc01iOGdvVjcvMU9uWWYvVzIybS9PaGhzK0R3?=
 =?utf-8?B?ZndUWXBNUDkrT0Z4RHMvcXBGNk1sYmd0Q3kvZm5TY09KUkVDcVJUQjZyRUJR?=
 =?utf-8?B?RkhSK2EvQzNsaTBuajI1ckNNaW9lQWw5WFpSeE1LTEt2YlpRUjNYb05nak9u?=
 =?utf-8?B?NnYxQ3JpTEU5QmVKVjJlRTBCTUs3d1NqcmFkODZTOXN1RWl5SjNkQ0F6TlBR?=
 =?utf-8?B?OC9xS2VYUVpYK1FTaUFERk5Gd0VDZ3ErdWRnWXUrazdtdEpEWnhualJCekZt?=
 =?utf-8?B?cnAwRDU1QXRhRDRyNk9aV20yTkwvQzR5ZUUxa2RaQTV3cWVCRnJ3Tml3K3FO?=
 =?utf-8?B?NnRlenM0d0Q5WGM5eTd4ZTFnb04yNGU0a0FQTy9sYTRYR2FBeU9JNDEwZFVC?=
 =?utf-8?B?dVFOV2UrUjJnTFRjL0NDeCtIaG44akJJU1hRQlBDUG03Rk5aK3lFcEU5djg1?=
 =?utf-8?B?bW5JQkw2eE1jUXpYaGMzaVc2N2hxU0twTSt6bHJ6eS9LdlFXMFp2UmZkNW8y?=
 =?utf-8?B?QXo4RG1GRXJGdGg3NHFVcVVqWEVFWXZSeGVNTTg3NGRiK09PT0hvUHF4dTZi?=
 =?utf-8?B?VXdhZTF2Z2MyM0lVaitoekttdzlZSHVjUWJtdmtCY2pveXRRK3Ayb1liT3lz?=
 =?utf-8?B?cCtQczlWOFZIL09BYWhlYUhrK1pQYnN1ZldtdVRpSHJ5QUdMelg0RnhuVUF3?=
 =?utf-8?B?STZMTkIybVJWNlFhc0wxSlhTK2N4UVNaaGp6VGRmUUhkTWdWTmFVRXYxTEFJ?=
 =?utf-8?B?bk9VZmFkMTBJQ2xRVzV5b1ZMVTF5M2d0bEw2MmdjeVUyS2tqTnBoN2p3TzJX?=
 =?utf-8?B?L0xTNjhmNmExbENUNGFkaWIxNXhtZk8rbWNnemR3Y1pnR2prQlZvdWkwNG0x?=
 =?utf-8?B?czBsM1RPcTRNcko3T3BoeXE5NWl1WFdpRWc3bDZZZ3lJMjlobFRoSmlpRlJs?=
 =?utf-8?B?bWhrZ3VxOUV2UE5jNDBYcmdaZ01KbWcxVVJUNGEwbENqTlJOcTEzZ0s5aWph?=
 =?utf-8?B?UTJJaFhjdy9FMTNnb09udHY5djBuNzBaM0YvMkhnbHgxaGs4VDUxTlJ3UWxk?=
 =?utf-8?B?cU83YVhwUHE1b2dsRWlwZWxMYVA1SitBZnhOOU1TeGhla3hiNHdlQlRhYlFm?=
 =?utf-8?B?WFpFVUhxZEJFbUlqTUxPb1RselkreEJBUitRZHU5WE1ScmliRUIxRFVBNWF4?=
 =?utf-8?B?cEFPOUpnT1FNYko0eExMQTZhQWZNQkx2S3dvMXhRc0p2eDhqdmsxQVBtZG5o?=
 =?utf-8?B?aGxHSnJ1d25IQUN5YThXMldqL3FBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8460767-994b-47d7-7aac-08dc384e7215
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:14:35.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8pksymQP/qZl+Qxd7aH5vDVYMtGwepJ3dZAZaqaoilEy2E77kHHZMwyqBqzB+ql9VtxSHuRKJG+7q9WvJsdHCjg6wk6M/tY380vnmB+Q7ZmfQ8zMsixvuwITooab9Op
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9262

Hi Heiko,

On 2/27/24 17:46, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The RK3588-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
> connector) system-on-module from Theobroma Systems, featuring the
> Rockchip RK3588.
> 
> It provides the following feature set:
>   * up to 16GB LPDDR4x
>   * on-module eMMC
>   * SD card (on a baseboard) via edge connector
>   * Gigabit Ethernet with on-module GbE PHY
>   * HDMI/eDP
>   * MIPI-DSI
>   * 4x MIPI-CSI (3x on FPC connectors, 1x over Q7)
>   * HDMI input over FPC connector
>   * CAN
>   * USB
>     - 1x USB 3.0 dual-role (direct connection)
>     - 2x USB 3.0 host + 1x USB 2.0 host
>   * PCIe
>     - 1x PCIe 2.1 Gen3, 4 lanes
>     - 2xSATA / 2x PCIe 2.1 Gen1, 2 lanes
>   * on-module ATtiny816 companion controller, implementing:
>     - low-power RTC functionality (ISL1208 emulation)
>     - fan controller (AMC6821 emulation)
>   * on-module Secure Element with Global Platform 2.2.1 compliant
>     JavaCard environment
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin

