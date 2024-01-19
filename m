Return-Path: <linux-kernel+bounces-31568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ADA833036
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708CD2827EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9895811B;
	Fri, 19 Jan 2024 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MhYGUKvN"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E82758103;
	Fri, 19 Jan 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699568; cv=fail; b=Z4pmx7WmaKgeABm5ZRtSsSIGFVV6UBTjgGCpCJnqSLoDYd+VkB9hxV5UGaYdcnsG1Ny1ho0AOnH+nsU7xkYlCcu4sqXThS1qNCdKlhzlA7Y4yT/yQ4uDqMKZIW4zW7emqzqh6beilfCCU10zoK04eHO0qZ6x1qepoYR7c2uJNQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699568; c=relaxed/simple;
	bh=ZvPWRkXPfzIc8PW38ggh3qvYe4o/Cw7ZTHMqCaBL8G8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RHUOHuhTpWoQWmmPOaFFc0C9O5ZlivUFXBVxBATDAbcAeJv6+OBXKLwzJ5PknpYeBxK7BPZuhwXvlTbqqMS5EqXMgQHXf/nXNBTmRKkE6i9eJxmG9kRnNAgzl5g2GIhX7X1AoeRNxhbtfKnyI3+5L84P8Y0poJ33gdKzBkFSqYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MhYGUKvN; arc=fail smtp.client-ip=40.107.6.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqeNCwzGFxild3mB/sPnQVXAT37efw54D1N0ce16iUMXy3G2EYxAj1JP3UyXiqbsblkmqgr/cfNVOX6lQUa/EYNovloqEC5Ii0Cok/ccjdOGZquPdtiC+VKuXyAwmCpdR7q30GNrQKh1t1wDoagawCSMHiWvIKzmT7VyoEKhipU86KYIpyWTk1BL/m2UY195somvq8i5inwIkPtKqZ7CspnegCW8DvR//vAEqK0dUDFbELgFM7/7EhcK3qXl2JUmHy3G3UDtlwZUTIMYYvtfxp2aJ5XBnsMDc/oHOe11ke4bYRcPR+86ukF0ARvAdV9hQ91ThxtXc9prhiyMYVGspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTVzQOmgu9eofBYP4HucgboMGdRPYHUxRw+tApAozRI=;
 b=dQdrSBLHDGCCpB1T36iBZBFv0XFyri+mAJpvLwSdarC03/h/5SV2AcLrmLYyflqQRwgc4Vl9ksQKo5Q1cURAHURN3wpq3Ufi+X7INDJwJTjnkOvNk1skeLvtuueXy19EmvAVnd5AjBs+id4TuyoovUw57JLbfRQreIly7WTckZpU4UqFnGuqsPQJPUfe0lNlQKe3EgNnN5ziTq3Ir2Tdw+3fv1yA2tRTphGOl694A9eEOYOYFYM7mJMicn1vcyC1v+yUKxk9OM70nMCoKWxwwuOMglEQH9765uE+hdmlknfQsjPz2q5/kuw2mBrmvfWcT80iMTAq85s0UD73euRzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTVzQOmgu9eofBYP4HucgboMGdRPYHUxRw+tApAozRI=;
 b=MhYGUKvN9I7MubqS6nf6UB1W+/Bo98PQ+M+hpDL+lyllYUTSBsQx4C+SCHfYMz1Ixp6vVTTL/Jl88QFZmN/I9siTEYRibSA9YbvXufWh0RMXjjgMD1Tr8vAKzXJvnnnzN4FY8zwj3tcG172mVu76Ile3iAKP8BZ7TVUgXivizVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 21:26:02 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::9398:2b64:8350:3ace]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::9398:2b64:8350:3ace%7]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 21:26:02 +0000
Message-ID: <75a16ac3-39eb-4874-9100-d605b2cfadfc@oss.nxp.com>
Date: Fri, 19 Jan 2024 23:25:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clock: s32g: add uSDHC clock IDs
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Chester Lin <chester62515@gmail.com>, Andreas Farber <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, NXP S32 Linux Team <s32@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Ghennadi Procopciuc
 <ghennadi.procopciuc@nxp.com>, Ciprian Costea <ciprianmarian.costea@nxp.com>
References: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
 <20240119130231.2854146-2-ghennadi.procopciuc@oss.nxp.com>
 <20240119-magnetic-racing-0adf8e5fbd4a@spud>
 <20240119-cattle-antarctic-432fa8e1c0ef@spud>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20240119-cattle-antarctic-432fa8e1c0ef@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0018.eurprd08.prod.outlook.com
 (2603:10a6:803:104::31) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb02495-8211-4f96-0fb2-08dc19353c96
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Sz+8DExcY2oIS7styWt7/zHrV48xxcAwjp/X9r3VCC8BmrLL9cc13yqr30fMmf9nz9hVaTaIMvdmAAzLJAU4Z4kJvapd95XGeSYqQYtAiENopjcyuKXd6KY6IgTi687dmaZbB1QEtSx1Rd/1oU+uK4VsQBV7L+iIsBhfvEKnXpNLI7b1c8x2QgpMelzJau2/Tc3FOnbPt6coAvy1P0zax5H/Ln2axyF0byIw6hA4jtNvRKIG9kqyk7RWQzmXRy+p2v5ZxmPq4jNMRAp4ymxJ+MPK7yMYP2s3Ji1/Wuroq56mOlLXAyKskmEvVyZEYBwaHQ0BRmFwyydroZcq6ScfXY41Oqoq2scarfnnILeZr708cvsD3k5B8NUokjbBNV0cnjAqqhR3QLOPo8mMLPHWaLgo6f78+8Int7rjlIN/b8kS4bYtOTC8he9WkiQ5O5KHpR53iUNTYc7CM+pt8o1EWL/6Zc7R4y0yptW8XQM25nVVLwR1L/KN7cKl4NXPzF99WhLkyEC2KmSznfHpx4E05mWGv/tJkAliSsAoysYNVNnlWntpSVcFHDmYcRx+gUfqqOUnIUgDQ5VqZvC3AGfBXxpZDIb2xCrFwUWTDv8EuuFZMMSLExaLCeJWWLyb1ANijIPdIW06YWbgdj3j2uARaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6916009)(478600001)(2906002)(38100700002)(31696002)(7416002)(41300700001)(86362001)(6666004)(53546011)(54906003)(316002)(66556008)(66946007)(66476007)(6512007)(6506007)(8676002)(6486002)(4326008)(5660300002)(8936002)(966005)(83380400001)(26005)(44832011)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3Q4TVc4WjNpWGk4VlN5ZERkSUMvL013aGR0SC9yaktyMTM4Q3lmMnFiL0tj?=
 =?utf-8?B?QkZNWXZ0NXYzRC9HbG5lQ2lGY09DZVhoRXNIeUZDMU1uQjltMFRISmhLcmx4?=
 =?utf-8?B?TFlKbHlqUHVsU2JWOHR4R3pLMythUWZzaGlGOFJ3K3hkUytkWUF5dGloV1k0?=
 =?utf-8?B?RmZ5Lytkc2ZZb0pQV0RjdkFNYzdWY1JZK0luTUJkOStzd3V1WnpNZlBoUHp5?=
 =?utf-8?B?U1pybzdpSTYzd2JWR0FvNWxENjhmMGJwVDV6S1FmbTloakNnR1B2ZWVlVDR5?=
 =?utf-8?B?TVZEUkxnSWRaRENVbnoyMmZjdktCWTJYa1BIMGpkTE12K05mRXoxQUNZWFNF?=
 =?utf-8?B?bE13Wm1sTDhNU3FPTS8vSTE0UE9HM29aQ0RDTXBUb0JpRVl2UEpyenJ6NXhQ?=
 =?utf-8?B?dVV5ZkFJK3VKeno1c280QU9VZnBqQjVOTndnNTE3V0tPM3R6RVJpYlhoaHZn?=
 =?utf-8?B?cmhqUzJmVTdCcHNsWjlxTmNOL3p6OEZ1Ry94SkxEUjY2SjNoUGtEcWh1OUds?=
 =?utf-8?B?WnVuRW9ja3lPZzROdThMY09Dejd4YUV3by9ubStPNCsvY2N0d0VsaXFXQVFK?=
 =?utf-8?B?MUN3cXdNTDJVbGlKcG9QdzZlQU5EZHFSTEpQRnAwTXJwQis1YTdmcWJKRTli?=
 =?utf-8?B?SFJlV3hsWnlnaHVvYVhCNHRpaVB6bjl2RnVwOVNzaDRtV24zanhtVUxvNnlF?=
 =?utf-8?B?MEI2d0FTS2RvdXNFejk0RGF6bjdUV3BuSjArdnVLRkJKV0dsNTVTeElzMVg1?=
 =?utf-8?B?YmVYRGJMMW1UKzRZZDNCTUg5SVpFSWc5SFFoSDdwQU1tcWdnSmFnVkNlbWVH?=
 =?utf-8?B?WVdZL0Z3RlRTcGdNbE00Q3N6MjNTd2h6S3Qvb3JVNW40SVFVVFU4V1p5REJy?=
 =?utf-8?B?WVVac1FMWGE0VmhTNGhndkFxbzFuK2xoNlU5d1lMM21ETmNTdXRJdWs4VFp5?=
 =?utf-8?B?YUUwOFc2MmdqcHRQTnlOOEgxZkNWU3ZVdjRYdjgrbHpDM0E0Rkd2WGJkWkNQ?=
 =?utf-8?B?dkliTGloT2tJQWVDV1ZoRUM4UEpXejUrUE1PZVdxWDhhV0RkaHZjM2I5eFFr?=
 =?utf-8?B?YXBQaHZhL21tUUdwYnFWeTZrZFZ6c2dCOXFKWHNITG5qTHE2L1F3V0ZMbVpZ?=
 =?utf-8?B?SzNPMCt1bCtZNmVkNDVBaFAvOVBSb2l6ODdEQzh0UUU5cThhTG9qd3JyRW9r?=
 =?utf-8?B?ZjNsMG1MT3NTYU9ZOVY4eXZ6VitYWkJZOHUrcjZwaGxEZE5DL1VpUkFFcjMy?=
 =?utf-8?B?Tkp2MW91amdQME5XSVIzNHBHaEthdjJvQ1ZJemd2REdBZW5Lc1BKcnJqbjFy?=
 =?utf-8?B?UWxEZlp3YWhHcTI2Qno4RWkyN1Z0MEk0UFpYUmFBN3pYNWV3OXZxcWc5UFd0?=
 =?utf-8?B?OWRad2hVcVJ3WVBwWkdzTXdaSmd0M2tQK1lWRGROQ1AyU1FvL3Rub0JTcVM1?=
 =?utf-8?B?SDVyeDMwYlFDL2RLNXBIT0JWbUllZXV1R3lMM2NIUTJ4TVpEaDdZd2dRdFJs?=
 =?utf-8?B?T0xTOEVnU1RuT2g4cU5iVzdUYnZvS01UTFk0VVJPVnpPRyt3OWhjaGllWmZL?=
 =?utf-8?B?RkVIVDN6aEg1Y1JOZ0dxSEoxVXJ4M2NFT1FFZ1RZRHIrWjVMOWNuZmRLTHNp?=
 =?utf-8?B?R1RYdldNMnlQbHFZLzc1UjNaZGdqTHlpWGR5aTFGYmZDbklJZkFjQjdIVmNW?=
 =?utf-8?B?b3ZpUXhaY0k2KzRKcHFrd1BEenluT0cwS28wWlNsZGhGK3JiZEg3ZlNEKzBW?=
 =?utf-8?B?VW1TT0prdVhLcERFblpiOEVGbHUrcHpZenRrRWpwcGhCaFowMUlsZHdrdGxK?=
 =?utf-8?B?Q2EvWVhKUzN6WU9JMWtqNGU2cS9DQ3kzTFRmeVVyaTIxWG1FcEdzaW1BTVhr?=
 =?utf-8?B?S3ZuS2RxQXVnMHVlbmRiZEtlZVRzY0pGVXU2TWFtQXMxZE5BeDhjb0tRMnhB?=
 =?utf-8?B?bDYzZTRzWE11U3dPVDVHbUtYWWo4c013eE5CUFBidW8rOXB3TFZ3RXpJeHJU?=
 =?utf-8?B?Kzd4K3FjNXpSMUhsZ3B0Z2FPWVUwNDZaaFFnOXoyNjVXMkppZHk1Y09Oa1Va?=
 =?utf-8?B?M09qTVZvS1pPNUtRajlhQ0tucTRhUmdWL0lVWmhGZkludDE0RXpsWDhVZkJ2?=
 =?utf-8?B?WCtLZmNadmRxa2l4SnFycXFoUUhXWUdpMjEwY0lVVktiWXh0V1doY1hMQnht?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb02495-8211-4f96-0fb2-08dc19353c96
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 21:26:02.5074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaTzr9kzT25iaQvKN4HAevLZs4Pem5Zcy/iI7YHYdzjid9aUmd1WtH2Eugc2Bl67LMZYS+ghR5jyhA8ScGMlzxN33/2Ot2mhW8G9N/Ox7EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195

On 1/19/24 18:14, Conor Dooley wrote:
> On Fri, Jan 19, 2024 at 04:11:37PM +0000, Conor Dooley wrote:
>> On Fri, Jan 19, 2024 at 03:02:28PM +0200, Ghennadi Procopciuc (OSS) wrote:
>>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>
>>> Add the SCMI clock IDs for the uSDHC controller present on
>>> S32G SoCs.
>>>
>>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>> ---
>>>  include/dt-bindings/clock/s32g-scmi-clock.h | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>  create mode 100644 include/dt-bindings/clock/s32g-scmi-clock.h
>>>
>>> diff --git a/include/dt-bindings/clock/s32g-scmi-clock.h b/include/dt-bindings/clock/s32g-scmi-clock.h
>>> new file mode 100644
>>> index 000000000000..739f98a924c3
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/s32g-scmi-clock.h
>>> @@ -0,0 +1,14 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
>>> +/*
>>> + * Copyright 2020-2024 NXP
>>> + */
>>> +#ifndef _DT_BINDINGS_SCMI_CLK_S32G_H
>>> +#define _DT_BINDINGS_SCMI_CLK_S32G_H
>>> +
>>> +/* uSDHC */
>>> +#define S32G_SCMI_CLK_USDHC_AHB		31
>>> +#define S32G_SCMI_CLK_USDHC_MODULE	32
>>> +#define S32G_SCMI_CLK_USDHC_CORE	33
>>> +#define S32G_SCMI_CLK_USDHC_MOD32K	34
>>
>> Why do these numbers not start at 0?
> 
> Ah, because these are the SCMI IDs directly. If these are numbers that
> are in the TRM, just use the numbers directly - there's no need to
> create bindings for that.
> 

Hi Conor,

I appreciate you taking the time to review the proposed changes. I
wanted to clarify that the IDs mentioned in the header are SCMI IDs
exported by the TF-A and are utilized by the second patch of this
series. These IDs are for the uSDHC controller to control its clocks. As
other SoCs use this model, I have included all the necessary IDs in a
dedicated header file:
- rk3588s     (arch/arm64/boot/dts/rockchip/rk3588s.dtsi:97 [0])
- stm32mp157c (arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts:73 [1])
- stm32mp131  (arch/arm/boot/dts/st/stm32mp131.dtsi:1372 [2])

Should I remove the header and use raw numbers in the uSDHC node? For
example:
> +		usdhc0: mmc@402f0000 {
> +			compatible = "nxp,s32g2-usdhc";
> +			reg = <0x402f0000 0x1000>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 32>,
> +				 <&clks 31>,
> +				 <&clks 33>;
> +			clock-names = "ipg", "ahb", "per";
> +			bus-width = <8>;
> +			status = "disabled";
> +		};

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#n97
[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts#n73
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/st/stm32mp131.dtsi#n1372

-- 
Regards,
Ghennadi


