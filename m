Return-Path: <linux-kernel+bounces-120755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D645F88DC94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA891F29E27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF4823A4;
	Wed, 27 Mar 2024 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="G4mqGh37"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2043.outbound.protection.outlook.com [40.92.103.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF926297;
	Wed, 27 Mar 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539187; cv=fail; b=hiqyrgaM2mNToeKOpt1ctBlzRBBQQ/qbF+LIIO190WgGBM2/Hhzbc4prnMg58vD432cUFG1PK8uXUEoIwmyPx6huhijsfZTLD0qFWEyeDI7bwCf5h/lEj26mZFfYSp3frlypLrpKKXzEiO0kBXwUhiZOZccdfb/UEXDv04oWUNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539187; c=relaxed/simple;
	bh=KCPaNyuFL5xPureNifbJnBbuvqsPfvAAyz4M1PFdkLs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nBTCV/F9e5tIPPYQfls7bzxyXpORqtM4xACV96opcHL80aRf6ZaV7cGm20PxYQO/5/0dYkmgGcu479H7mw7l/m4gWhn/fLLKKMgqo4OjRBWXPoIGv1sXnl/UTv4b0eeNe4x8ggn6yAdwhFNHjbL0W3b87apRCEAQ/bGOVOZiVR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=G4mqGh37; arc=fail smtp.client-ip=40.92.103.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEkW3y1Zt8MsF58mhIwYZKPsiDAtU7GSSwouZ9NVp/30D8rWhGS6wQX2w3tuF1dqIxPng7Sy1sReAk/dko115eLjRhQUkm3xffk6/zJX3JlU6SQPqSxzQSps+6dU4y25mviHoz7KCXx23ReHmx7dbzC6htPBAYtEuFQ5eN+11qbIWZFaigsehL41qFPHOPvKRdmrDDrHWPBBGY3SieHG/XPATcmLcAhVkwGSWWuCwEbGuJb1Ynfqbt7W+WHUtIOx0Fuuuno9ICWj7wthC8l3KjW3j2QB+QeYcSr8jSg+rnohqWH2RoMVW6nl1nE6icq1WTpnLp20aZymjcDuQJJ6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omxSSt4fxGAvg/U+3um2sR/fqDpN2Ds0zBtASi5h8e4=;
 b=GlvZZrlk51DYaelyGJY7aaJgLcr9OSGQYe6Q7TwLPfZw35kGIdJkvnpNUAjPQSlill1ETM0Tu4NEJrt8b+lnqQRAJnAqum073iz1iqBoOZ4sDQm4pUr5Cfc7Mt3MxKgWVpCUPLO1AW8vOQRkuJ26jyAmdvsWDpzp6Mrl9OH8bkWEKMStr+l96phVC5A8G+lK5Lr9L4FrJAE0916oJyOqmGmVCjFvNqRrAeJ+4w9Zn+UQlKqPSW48sMkjq7X0FkkUKol9QT9Hb5p7PL6qZaXXvNkXz+2fNzVENDvpVCdIC+kdSvNPOGlMmKSmNRcGd+VYxD+dbVU6gzWgKhMOKhv2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omxSSt4fxGAvg/U+3um2sR/fqDpN2Ds0zBtASi5h8e4=;
 b=G4mqGh37UttyclQpF2At4cB9JuuXyohM79aYXs3ytwQfY9N+5C6b0Xcz53h48htxYPrJk5tbf7MeNi17OxNeEJRIodCheUiEqT6oIjkLuxswCFYQt6hCqPIG1rLxtBITuBpdf0C9eQklgmAvybV4WxTm1OGsolqc7bOjZHCNY1Aq16feoP3jdTFG4QA2l6ozSLzMSllw2MtuwLSmAKglXLgFCBV+lOoA2h+EWh6okRGeqd4R6uCkeXSWoMABENWBGT6W11bRnwEnSATv4M5zuMF71Bw2SkVj7TLEtjOPDFSp0UF9ra0LNNfFa1BRh9qbNwIy5lUbA9g/uQCGylX7/g==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0537.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 11:32:56 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%4]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 11:32:55 +0000
Message-ID:
 <MA0P287MB2822B846CE45D0A97D120725FE342@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 27 Mar 2024 19:32:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/5] dt-bindings: clock: sophgo: add RP gate clocks
 for SG2042
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 chao.wei@sophgo.com, conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
Cc: Rob Herring <robh@kernel.org>
References: <cover.1711527932.git.unicorn_wang@outlook.com>
 <78ddd5b127860e110f4c782de90025153cdba083.1711527932.git.unicorn_wang@outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <78ddd5b127860e110f4c782de90025153cdba083.1711527932.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [gTcJ01a75L3cEXj3+8z1EK6911RMuA1T]
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <179fdd3c-a14e-41af-b9af-05bb7b42232e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0537:EE_
X-MS-Office365-Filtering-Correlation-Id: 652a7bfe-7cf7-48d3-b279-08dc4e51a576
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5xoukYaQ+76rmitZx5xRZEtyvZxlRXRRndxjmvmsupIPva9Jenz223Yo8fLQLUmerl2TboUI8U+azR4MEr7SeJwPmmyHNcKAiIZjZP9mxOZ2RsG+OnVuw2AqyPU1EZRuxGWYo53CUjDYB9JIGxTw02eOf08Ad+UaAkcDvDmCg2bezeBsoDEX2l+QMTkPOnTyDci5NcsVpwMB0pvc9OhIOIyN0DYz0mo7+LNwwWyC3GHHzUHIHdqBpTe9b1PPiLJaRJtwfddlIStyz1ARb4zr3A9SVx7NPS6G29e6hmwO5QnnNcX1CpdwmPzJmAOf5bAssY/JJIw0hNgJmA9B4YA1d+j1B7RKkMA8opCWsPfxQRtS98mrkaqRSRS1f+ftTXRnycWBSbF+5QvAlfxKyai3er79S1owaWV+aBXEyWfvUEBgqP79ByDAo4xbLELa65nze1A0kutCxgQy1OPjqtwgqUyzmnG+slPC8xW10kkNEOxvcq5kMRrC2iRD2XyjF1ERkTRLtcv6zppHb37chTybxEVWvlMeBX7jAzwi7YZb9GD2bNREffP1U3ZzglWbmBYOAtBC+6GWgiKQ3xiC6CIMwPTrTfRsia3g3dw9MKxQ/zZTLVgcbg1CDgcykRqwY8Pn58np1x3My5ioBQj/6YLeobyIlbrQxcGb76uJIe4EVDM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnl2dElSTzl6dCtrOWh4YkZoSVFJUFRSOU9XQ3AvdjNZM0xxZHdLeGJaOVlt?=
 =?utf-8?B?TUtmamhPRENmTndjTjZpS05PV3hTQUJuTUpHVUVYeVpyMXphRUtkMHBNUGxD?=
 =?utf-8?B?dDM1Z1l0d1l5VXBqWThwRmtTN3BRSjlvd28rUVhWd0hxL0Y2MzRMWElmN0Vv?=
 =?utf-8?B?MldRM0tBK1BlaWNCUWpxY2NBamZnT3hMZUhXcjVTdVRTblV1ZFJTSy95SWVn?=
 =?utf-8?B?MU16UDNPS0RWcHVqNm1RVUJHd0k2S1FNVytySGIxU0Vad0ZadzN6Nkp0d1dV?=
 =?utf-8?B?M3hDbDZEWkg5TVd0c0VHV082Z3RVQ05wa3lnZFlIQU5rV3hyYU41RExDZ0l5?=
 =?utf-8?B?b0Zvd3p6RlBNMHoySXVFbFJJSFVjRmhGbkJKbEVCam8zWGZ1UnlZSmRnaC9k?=
 =?utf-8?B?K2xTSnJnc3ZCQ08xaEtYY2EvcTM4bGVFb3ZqOEdPNVpWVFRocW5pUkdnamFa?=
 =?utf-8?B?OXBYeWtnU3I3MGtsUHl5UUZnckpGcmZyZHRZbmk3RTU5eDR5MDVWMW1lNVRU?=
 =?utf-8?B?NFlEVS9FWFVSR1FudnROVlFZMUNzYlZ2NzdkMVk3TGRQbnM1cFgxOUdIUnYr?=
 =?utf-8?B?S3BRdkR3Y0g1UDVCd1lYWlN1Zi9jc0dJRjBqcWsxcStna2I5TnY5bE5pL1FG?=
 =?utf-8?B?RERTckRUL0hPUWdkcEpIckRibW50bCtrcHVIeGlMcFBCSUQzSVVwd21ZSE9G?=
 =?utf-8?B?eVpuVTI2ZHF3dzRJc3U0cVU3Uy8rNWZ0SktGYWtWaHBKSTY0SHgrakFjWWVp?=
 =?utf-8?B?Q3psMnBHTkxVcTNTelhBSnB0ME53cEV1ZmZhYmdiOTV6WnhjdDduc3laZEZG?=
 =?utf-8?B?WEJXNzk2Z1VOSVdtUkxpTitjNnYrZ2J2NktpYUxFTWVyMHR0Y3JkdjQrT0Mv?=
 =?utf-8?B?T3FxNjZNTkhMeTF0eE93dEttVmhKZTFmR3NiYTZRSjVxelhzQW1MbkpIQXdn?=
 =?utf-8?B?RjdMZ05mY0QvQzQ4ME01dTlDdStvVVBOTmh6YlJGUVNsa2REbGJiVFdJWDJz?=
 =?utf-8?B?N1MraUJvTzhGdVFPU0RlMjFtYU1NME8vWDdkSkw3cXBzNzZFYmQzUXA2S08v?=
 =?utf-8?B?eUZ3aEZLTW5FalVRTVFTaFYyNTF3dlNaLzRWbmhUNEFiTzRuTmg1RCtDUTND?=
 =?utf-8?B?TUF3a3lMbWw0ZVRqaDVBTldzdnUxU2tINkVLT1B2VVNLL3RNSE0zZnpvd2VM?=
 =?utf-8?B?RGNiNE0rakJmS0QvWitxT2RrQUR1WGViS0dwcXZQbzZseE5FOGttWVRQUDMz?=
 =?utf-8?B?Z2NGUXNnVm9TZ0xManltYWJCV2hPTG5NenNMUWpzclNOK01yQ0tuMEZneFJq?=
 =?utf-8?B?U2pTcTBXb1lGVFlkOFhaMlkwUDRrSHFuNnU4U29BTUJGRHBxS1NvV0tlQWsr?=
 =?utf-8?B?aUowV2lSZVNsSmxSczNydTRCam5sbXR3WVlIKzA1a0phRTQrVW54d2hSM1k1?=
 =?utf-8?B?dnp3KzBtd1dUQ2IyeGdMd3I0TGU4YWE1emhESnZaWkszRmZWRjc5WXRPc2Ft?=
 =?utf-8?B?L0xNa2FoL1RzVVh1ZGRDaThpSklBd045bXZja1FYaXVsWnVLNVkxbEUxSUhj?=
 =?utf-8?B?NGN3Rk5sWUtDeGVVOWc0Ty9OWW9hQmZWR2FmbUJwSU5mUGdRZ2VEWktLZmNv?=
 =?utf-8?B?TUZGS2p0KzNoRzlUM2dkN1BPZ3hYQnd3dzR5VXZXUmx6MDdwK0NiZTZJOUNu?=
 =?utf-8?Q?CRxxTw5wI8om4VtCvROt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652a7bfe-7cf7-48d3-b279-08dc4e51a576
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 11:32:55.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0537

hi, Stephen,

I updated the address in the example of this bindings as per your input 
from 
https://lore.kernel.org/linux-riscv/066c6fa4b537561ae6b20388a5497d9e.sboyd@kernel.org/.

I checked the 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-next 
and seems you have not picked the 3 bindings patches, so please use v12 
when you pick them.

Thanks, Chen

On 2024/3/27 16:30, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Add bindings for the gate clocks of RP subsystem for Sophgo SG2042.
>
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/clock/sophgo,sg2042-rpgate.yaml  | 43 ++++++++++++++
>   .../dt-bindings/clock/sophgo,sg2042-rpgate.h  | 58 +++++++++++++++++++
>   2 files changed, 101 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
>   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h
>
> diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
> new file mode 100644
> index 000000000000..9a58038b3182
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sophgo,sg2042-rpgate.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 Gate Clock Generator for RP(riscv processors) subsystem
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-rpgate
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Gate clock for RP subsystem
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/sophgo,sg2042-rpgate.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@20000000 {
> +      compatible = "sophgo,sg2042-rpgate";
> +      reg = <0x20000000 0x10000>;
> +      clocks = <&clkgen 85>;
> +      #clock-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/sophgo,sg2042-rpgate.h b/include/dt-bindings/clock/sophgo,sg2042-rpgate.h
> new file mode 100644
> index 000000000000..8b4522d5f559
> --- /dev/null
> +++ b/include/dt-bindings/clock/sophgo,sg2042-rpgate.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +/*
> + * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +#ifndef __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__
> +#define __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__
> +
> +#define GATE_CLK_RXU0			0
> +#define GATE_CLK_RXU1			1
> +#define GATE_CLK_RXU2			2
> +#define GATE_CLK_RXU3			3
> +#define GATE_CLK_RXU4			4
> +#define GATE_CLK_RXU5			5
> +#define GATE_CLK_RXU6			6
> +#define GATE_CLK_RXU7			7
> +#define GATE_CLK_RXU8			8
> +#define GATE_CLK_RXU9			9
> +#define GATE_CLK_RXU10			10
> +#define GATE_CLK_RXU11			11
> +#define GATE_CLK_RXU12			12
> +#define GATE_CLK_RXU13			13
> +#define GATE_CLK_RXU14			14
> +#define GATE_CLK_RXU15			15
> +#define GATE_CLK_RXU16			16
> +#define GATE_CLK_RXU17			17
> +#define GATE_CLK_RXU18			18
> +#define GATE_CLK_RXU19			19
> +#define GATE_CLK_RXU20			20
> +#define GATE_CLK_RXU21			21
> +#define GATE_CLK_RXU22			22
> +#define GATE_CLK_RXU23			23
> +#define GATE_CLK_RXU24			24
> +#define GATE_CLK_RXU25			25
> +#define GATE_CLK_RXU26			26
> +#define GATE_CLK_RXU27			27
> +#define GATE_CLK_RXU28			28
> +#define GATE_CLK_RXU29			29
> +#define GATE_CLK_RXU30			30
> +#define GATE_CLK_RXU31			31
> +#define GATE_CLK_MP0			32
> +#define GATE_CLK_MP1			33
> +#define GATE_CLK_MP2			34
> +#define GATE_CLK_MP3			35
> +#define GATE_CLK_MP4			36
> +#define GATE_CLK_MP5			37
> +#define GATE_CLK_MP6			38
> +#define GATE_CLK_MP7			39
> +#define GATE_CLK_MP8			40
> +#define GATE_CLK_MP9			41
> +#define GATE_CLK_MP10			42
> +#define GATE_CLK_MP11			43
> +#define GATE_CLK_MP12			44
> +#define GATE_CLK_MP13			45
> +#define GATE_CLK_MP14			46
> +#define GATE_CLK_MP15			47
> +
> +#endif /* __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__ */

