Return-Path: <linux-kernel+bounces-32708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC62835F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C10FB26443
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DFB3A1A5;
	Mon, 22 Jan 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U8J5KzZM"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B339AF1;
	Mon, 22 Jan 2024 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918207; cv=fail; b=IhQXGld3ofenD4K1OjOGUp4dD/NjVECVj7VOFe7cMGoJx2E6WDVWdE2Vr6f0swU+hVcNylza4sGD89yauwgT/+m5pbGzifei2yiursMlcgkO5s6Apfh5TTWP8+fFyVtv5ClnYfGWbATDRraykSxtrWhuJhJAFzOJE/Alb+1neIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918207; c=relaxed/simple;
	bh=DgnHhAeuPKomJe/QxCutrKX2JgpLhB5ayO5AKZqyuDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TQu1t7UKKGFw1da/nn2mRsJwlqEuhAg6RVMorKYVy5HR9Ez8ZBwLKzvGI6/Ex1GgdRA/LdGVrZT5OujXClKHPJwh+sBcMn2NJd6JAjgX2rvRJIIc0+okDX52WyKfssT8Y1QGCsRPR43eKjF08wr8yE3Idn0lMOa4vpjNsAO6Bp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U8J5KzZM; arc=fail smtp.client-ip=40.107.105.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWHosaNwSeYsQHDTmTKsbyD4WarXEWlPBOxcYEc5z0j/Hd2UUIL6HJwf422PKV6CE8YDub8PC1soWw+A9W4CDsviHHMHRvI1P2X5bmZ7LGWUYmUb07WGgJK2WYgV78n3hNXai5RA42szS671eM14xKkLOr+n2djvhvOTftnPouN2X59gli/F2fzcxzyn8c5xcvswyO46v78cQrhtFEM6eYhv7CrAH9VSiHphMeZ9rqWvK17z7uCM07twMNxIjWZp+v0Jo0IdztRiX9RiAJ7EyE19ZYlgF3fw2GxSuxH+79TsjyoJCBT8hDuBBsrUqcUOZsqCMJfuh9+6rR8Ydg7U7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKjv8fcNG8+3r+Wh9tWwIcRYr52KrKqUdeEwOIQ5VEM=;
 b=HcZ9Iu6+vR7c7RN5+Y1Isbc704Owt/u21zKafmxy1M0AUUZfZXM8qCLwNdEYDOlZgG/BqQcLDqNP6XGnHTsQilzDsszGwaCJeMPxDIu8iwbyrpcPJLCVxHn5O1fIHeo8Wy5sehCaiz+HD2x5iyBHpqoNWMM9ii5/ir0BgvED1ZgK/JLdNRmXNc/+/nCV1p19TZXgKHgfXPv/3xZbkHiBzvnB/iGqTeQIyUAsAhtlIMEa0F4sP79v4TqAzidqj82MCmk4UYMBEbrRZDoY59hfXk6U6yVznDVd2mr8+9OZKzCyTSxSFViCjgBFNW9XhTrHLrfQDvfIZemhPYjuPoP/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKjv8fcNG8+3r+Wh9tWwIcRYr52KrKqUdeEwOIQ5VEM=;
 b=U8J5KzZMH8PuCgr0kPDoSmLC0Za6iZv81ow+K2/kIm5w4UJwSWIz7GQVkrB7+XzYGin1qp624LSExyqBYHk71V0n5yAB0vUvDVQShutXsdSHEU0JOcyCd2zfbLkD5J8SjdnJmyaTustT3iKsM79wzYdIF05bSKahMQSq8jgfr98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by VE1PR04MB7486.eurprd04.prod.outlook.com (2603:10a6:800:1b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 10:10:01 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 10:10:01 +0000
Message-ID: <f45e02bb-1353-4c03-9a3d-294c3b78e8dd@oss.nxp.com>
Date: Mon, 22 Jan 2024 12:09:56 +0200
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
 <75a16ac3-39eb-4874-9100-d605b2cfadfc@oss.nxp.com>
 <20240121-statutory-endurance-6d03d7e734c9@spud>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20240121-statutory-endurance-6d03d7e734c9@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0212.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::33) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|VE1PR04MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2d2b3a-fe25-464d-792b-08dc1b324b75
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GGGx/SWf08E+Uv06Ahyn/ni4eLP6HlTh8DT5EnIMCQG49s8092/GdN68UQKXCR035C662d4IHNUU0yOi+QjxoxwsXb2yt65s3EaoCb4pynNDGKk3xTXNTzeDQTw7ZrRfNb8uqrCJ5O3Pum3Wy2Pn26B6UAg8g139eECrD13yYsfr2nd8npBrjCgMavvi2K42nbf/Cm6HBmzD31jkbLf8sg86ZISJjMxg2Z7MaH8dVuKAtSa5Et5XABLMnYozlIVO6MWgMzOQ2Ghj+2FNOnuljx6cf9j5tn7ArOeL7E+wMxd+5NfxnR44iR0QGE3SrYnGMZ4eESMeOEz6Gd2HLuF8h1Ag1nRehyHTuH5tlbmCk/watxKihaQIPzBpVNoiDyMsH9U+VYggHR4Rf7swjeRDr768UvFnX8iZ4BJE4d4lXbIIAPaJCByJvMirK4wotD+20WAJEsilSAF4L/Q/2XrF9XOflmZ2nyfsd1pWvF2JHyX6dqe05mawHcEqFY/20xnHUnxMNGlpOyO8Y4PIKwWSa48QXx4A1df0ATbMj4AR4MOQ0iSPu6PEo8zSrhbLR2kDYAtCecYYa2FBDhHbosvqBebnAmjsr4vPnjf6xpJNmcR0irEoxxrI6HBxOJd+G8BidIh0dSL++Ed9V8GOC6wIAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(26005)(6506007)(6512007)(6666004)(53546011)(83380400001)(5660300002)(7416002)(44832011)(6486002)(4326008)(2906002)(41300700001)(8936002)(8676002)(966005)(316002)(478600001)(6916009)(66946007)(66556008)(54906003)(66476007)(86362001)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWQ5SmdDV1p1eU90WWlnZnRQcEcxSzN4Mzk2dW1zNjJ3bGRVWHpOZEgwWng3?=
 =?utf-8?B?K0N4eU5nYnlNYllSUXdnR21IVThrTzdTK0lwcmlocXJRZTNZSmJCU1BSblln?=
 =?utf-8?B?K0dVYkYxTmVSVEpPS2lnSjRVR29ycGROZmQwUmJEWlZxQWtYT3VZaWUzVWxy?=
 =?utf-8?B?OWJPd3BSWjM1K2dsUkxSeDNkQWFGdmxqb1RQYVBFa1doOUwxbWhHdnV2TWxj?=
 =?utf-8?B?T1ZGdmxQNkV1alc2MGVjZ011Zk9DTFp2aFErUERYMjRlVlM5cHlwTWhKR2VD?=
 =?utf-8?B?TDEybzNwdVgyai81WGpQZUs4aTByck41azJrSWc1aHlhQ0FYMzJNSHBGeHpD?=
 =?utf-8?B?SXZFRlhyWUlnNGpEUHBoUW9aNjlHdWVieUNqaVRwdUVWNzI0TTlKKzlOWmVk?=
 =?utf-8?B?a0F1MGI5V0ZtK3RUbVRBKzl6cU9QeWZ0TGlkOWcrOVJNcE5qK1IrSU1SMzV4?=
 =?utf-8?B?bEVRYlV2dDlBRXQ3OVVkQTlqbkJmanlJRmYvZlNjdUgycnd0NThMZ1k2ZTYr?=
 =?utf-8?B?eWl4WGF4ZlQ3eTh2SHB6UndaT2ZidGhoczQwajNGOUN0Z3prSVR5R0ltS3BM?=
 =?utf-8?B?S2V6SWU3dlBWaDk3OXZKTGVLZXIrT3dyVXdLd3E1S2E4RTBYN2VuZWJqY2dy?=
 =?utf-8?B?SU81M1hla2liTVFDcmFBd1J0ZUYvUGRkOUNSb0pQSTNCRU93M3V3K3RoMlhX?=
 =?utf-8?B?VVVEYzh0MVFMMElmTzhOWXE5NjlTVDd5M1JkYkxVZ001VmpvY1JJNmkzSE5t?=
 =?utf-8?B?dVdQckh0Vi9WYUdnMkdvMFhpOWVUMjhIY2NDMnorTTB5WUdkeklpZmVjRTZX?=
 =?utf-8?B?cHhEMlBYajd0UXYxRTNPQmw0Tkg5bWRRWSs0SlBQcE1sVHlFRm9CdE52ck13?=
 =?utf-8?B?dUUvbDZscVdVVGJjcmtvOW1vMGY0MGlSU0hTWlRUZEFBT3JnRlhaYUR0VHBz?=
 =?utf-8?B?YmtUR1JqM1hCYmt2bnMyVndURHE4UkxDazV3Ykw4bVAzWnQ5OGY4a05YMDJU?=
 =?utf-8?B?R2xTTytpc3pFSUNZUTQrMHdBbjZnb21MYVpZeHJnV1FNREN0d2lBckhLZDhT?=
 =?utf-8?B?RXhsMHY5MnFsbE9WMUpWODN2WnNnVyt3SGR4bmhCTzJtYXE2alJIVjgySktw?=
 =?utf-8?B?a0VHeUNsWlBNWmxZV3BndHY5ZHkwWGxKc05ZbHJPa0lYTE80bzEvYXZRRHhp?=
 =?utf-8?B?YUVkOHZKL3JCSjZlMmo1Tk84VFRjekJtWFNHQVpGeUpqR25uSzl6ZXF1alg0?=
 =?utf-8?B?VHNYZXRGY2Z4cHVXdVNmT3hPOGZpVUV2dVdHVUt1RkpRTXpNakRSN1pyNVJN?=
 =?utf-8?B?WFJGck5xa2VCL3dsRUNCcnc3Y20zZ1pMZlRVMUlqNnJvTWNqYi96SXhoSk8v?=
 =?utf-8?B?MmQvSVlKUnArKzF3QzNPenpMVnpQYm15RThRRVFLT1RIQVVrdm9TeExFTVoy?=
 =?utf-8?B?d29SM0FCbU9MUlB3QVF5V0d4QnFvMXNCRTNNZmdtNU02dXlKdjhOaTZlZkhB?=
 =?utf-8?B?NEU1YnptVDJHRVRCRzB2N3VONVd1NU5FcmIyUG5YZmQrUmE2eW1BZjA3ZUVo?=
 =?utf-8?B?TnBpTjh0aVVyZjQrTEpiODF6aU4rOSs1VUN2VTJEYXIyUEJxOGU0RmVIWmtQ?=
 =?utf-8?B?YWc2d0VJZTFLZGs5aXVWUGpuaGpRSDJTalVrTTEweTVZd1JJWVBRd28rWk1H?=
 =?utf-8?B?L2hTOUQwS0VOVFN2bk96RndSRi93VjN5dVI2UTBWZkNmOU9GQktsSXpZdGk5?=
 =?utf-8?B?dWdldElLcVdqODJ3U2EyNVUvQVh1VmVDdUZZVnd6TjVZN3FzSEdFZ01Hd1Zv?=
 =?utf-8?B?NXVTVXVKaUdMQ3FNMklnTHZjZE1peGpGdkpkaFI3RHQ3aTdWOTFZY05uYkdD?=
 =?utf-8?B?ZENERUcrRFhZVjNoMHlqbFB0Zkh5aWVQamladUd4L3RPYjBkSkI0VkJidXVL?=
 =?utf-8?B?R0h2Z2lJUnJkTTV4RWk2aTJyZTBCZ2IvdWJvMWkydnZvWWdJZkJreGdQbitD?=
 =?utf-8?B?VmZ2QXFNYXFlWWVXVkFab3lNdmp5b0Q0RVd3NW14Q0puVExlaTlDVVo2dU1m?=
 =?utf-8?B?VGdrTWh1L3JTM2NXNjcwUWxjSFZyUHlybmM2S0cwVDlHTEE4bEMxenZ1Q0R6?=
 =?utf-8?B?cDJ0VDlNbStwaUhmMldvbWNDOE5rWXFxY1NLaldpUTZJYkw2cTZZMnp6RXpZ?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2d2b3a-fe25-464d-792b-08dc1b324b75
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 10:10:01.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aomZAklnT1UK3xLXiN2gHDX0gGIIXTXUt5BX+1UStiu+hHBNTx59lYoARcrbFz1Y1fLCvwB6ue+YLrhkXvuPFnkw9pogkgU3c+T2SUkUWYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7486

On 1/21/24 15:32, Conor Dooley wrote:
> On Fri, Jan 19, 2024 at 11:25:57PM +0200, Ghennadi Procopciuc wrote:
>> On 1/19/24 18:14, Conor Dooley wrote:
>>> On Fri, Jan 19, 2024 at 04:11:37PM +0000, Conor Dooley wrote:
>>>> On Fri, Jan 19, 2024 at 03:02:28PM +0200, Ghennadi Procopciuc (OSS) wrote:
>>>>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>>>
>>>>> Add the SCMI clock IDs for the uSDHC controller present on
>>>>> S32G SoCs.
>>>>>
>>>>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>>>> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>>> ---
>>>>>  include/dt-bindings/clock/s32g-scmi-clock.h | 14 ++++++++++++++
>>>>>  1 file changed, 14 insertions(+)
>>>>>  create mode 100644 include/dt-bindings/clock/s32g-scmi-clock.h
>>>>>
>>>>> diff --git a/include/dt-bindings/clock/s32g-scmi-clock.h b/include/dt-bindings/clock/s32g-scmi-clock.h
>>>>> new file mode 100644
>>>>> index 000000000000..739f98a924c3
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/clock/s32g-scmi-clock.h
>>>>> @@ -0,0 +1,14 @@
>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
>>>>> +/*
>>>>> + * Copyright 2020-2024 NXP
>>>>> + */
>>>>> +#ifndef _DT_BINDINGS_SCMI_CLK_S32G_H
>>>>> +#define _DT_BINDINGS_SCMI_CLK_S32G_H
>>>>> +
>>>>> +/* uSDHC */
>>>>> +#define S32G_SCMI_CLK_USDHC_AHB		31
>>>>> +#define S32G_SCMI_CLK_USDHC_MODULE	32
>>>>> +#define S32G_SCMI_CLK_USDHC_CORE	33
>>>>> +#define S32G_SCMI_CLK_USDHC_MOD32K	34
>>>>
>>>> Why do these numbers not start at 0?
>>>
>>> Ah, because these are the SCMI IDs directly. If these are numbers that
>>> are in the TRM, just use the numbers directly - there's no need to
>>> create bindings for that.
>>>
>>
>> Hi Conor,
>>
>> I appreciate you taking the time to review the proposed changes. I
>> wanted to clarify that the IDs mentioned in the header are SCMI IDs
>> exported by the TF-A and are utilized by the second patch of this
>> series. These IDs are for the uSDHC controller to control its clocks. As
>> other SoCs use this model, I have included all the necessary IDs in a
>> dedicated header file:
>> - rk3588s     (arch/arm64/boot/dts/rockchip/rk3588s.dtsi:97 [0])
>> - stm32mp157c (arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts:73 [1])
>> - stm32mp131  (arch/arm/boot/dts/st/stm32mp131.dtsi:1372 [2])
>>
>> Should I remove the header and use raw numbers in the uSDHC node?
> 
> IMO, yes. There's no abstraction/binding being created here if they're
> the SCMI IDs.
> 
> Thanks,
> conor.

Thank you for letting me know. I will make sure to include this change
in the second version of the patchset.

>> For
>> example:
>>> +		usdhc0: mmc@402f0000 {
>>> +			compatible = "nxp,s32g2-usdhc";
>>> +			reg = <0x402f0000 0x1000>;
>>> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&clks 32>,
>>> +				 <&clks 31>,
>>> +				 <&clks 33>;
>>> +			clock-names = "ipg", "ahb", "per";
>>> +			bus-width = <8>;
>>> +			status = "disabled";
>>> +		};
>>
>> [0]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#n97
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts#n73
>> [2]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/st/stm32mp131.dtsi#n1372
>>
>> -- 
>> Regards,
>> Ghennadi
>>

-- 
Regards,
Ghennadi


