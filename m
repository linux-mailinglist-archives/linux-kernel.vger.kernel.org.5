Return-Path: <linux-kernel+bounces-70409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BF085975F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFAB281C20
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98906BB47;
	Sun, 18 Feb 2024 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TQzREw6v"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2100.outbound.protection.outlook.com [40.107.7.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A731A66;
	Sun, 18 Feb 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708265911; cv=fail; b=uFhXix8MmGX7Ij6aKx/MQJ3llsMwbxqt5nhPEyslZ4pmpKKR9lq1I0DWIzP774r58ITcJfgByyA9JRKKOVlZSnPNMoV6ji185C8aGVWpnZ+Qlm0O7SYkejJH6mGPwCJX81arAujMCUwAi6iwI4gyPA7tGbdwiJ8kboNk0R1aV0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708265911; c=relaxed/simple;
	bh=vjngFS314SyJC0oQX0ALCdxk91gdfSvnbZEBRXF6faE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Isw/FQTJaEf3dZz166/kEQwc7HFQiOfMqkKfLZ5p99t0ijVLkBkFGSamWrwhEzwcaaKfXYl/ejX3oK9s+F8UJSCsNZzwWuRdMaN0Fqu99fH/o2K3PjmOSUpfeNnl+hTcudQquZt0PI9hqcTAsimYlRA8NdBUVAu2rRGZxsnBEiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TQzREw6v; arc=fail smtp.client-ip=40.107.7.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxT4WDCuk2fPCec3B7GtBsV7h6MzCtOd+JWSanLdupxxrt5cQY3SNeDgXZAGMjxxpHV8Ov58zY2cRuoZCXDZ21aixhaOnevLnL14nmS5DlqPwTA9vAyNK1Geds9lAIxq/Tnyl7f64ZSmBgkOXfwN+SaWYnUnD2LzbEYRCZPmeyW1BKhawP1JNEDQ3sb9mCNKOfycL+/yj5XWMdx0OS9ntURhzJs4f2d2r6Gian3JFsqU+AsM9Fz7HG3UIg3QYvJKkw8bLcHHlb+D/kg3iGeWklLo26983fd3utrbRjZE5xj9K/1gNu0WKSYAZz2hPDrhH3z+iO5ppww9EBWU7RvxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYqytJX3ZHzUePq4vFTathQKUcMZ3wz8ccnz12V092o=;
 b=dqIWe9r7tcOauSQiySOnn3EBnaXRTy5JN2DY6fqnQSQQhlFSUGjexyT6k5EFxnXjARAjA2Cv/7FtLlofKnuyBvCYmD5TVXJNP+Vg0XBGtCE/BplASUdFB7o3JZjXRE+ZNCsLM6lgW53DH+LhD06oXnpVevz6FCBym8W9xyXWkk1yOpIT2UOtPp3j+DYxQWrrr4Iu1t2g3kGIPbijJOMzAhdq0VIYxWwbYBSKwVCa22CMWhli5jkHrFgYe3abOeyN1CfY2dAvSbjaKKsjk6XkWQA7yq+DJtZf5oOrpfIFn8ivzVl8oi5+mEi82SY3kiiWbhKWcX3J/FZ/S81fBhIQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYqytJX3ZHzUePq4vFTathQKUcMZ3wz8ccnz12V092o=;
 b=TQzREw6vq73stTaRKONGmqiQMPqq1e5zpBDxkqz5iV2Xyhbvfy//QKtkx4rTroIfJpDgTECBEUsKFoAInHiyMa3RXke25CkbLAEcu+bf+81TFnoJ9awvXZSeXQJA8DH+QYFrLBu9PPi7vB9nh9+2rUXbpimOekL7uY16CsHFnAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB9914.eurprd04.prod.outlook.com (2603:10a6:10:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 14:18:26 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 14:18:26 +0000
Message-ID: <c37af45e-def1-4a97-ae01-e00e5b22eb23@solid-run.com>
Date: Sun, 18 Feb 2024 15:18:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] arm64: dts: add description for solidrun am642 som
 and hummingboard evb
Content-Language: en-US
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Suman Anna <s-anna@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Andrew Davis <afd@ti.com>
References: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
 <8aa96c66-d054-4b33-8972-f9faf2e84482@ti.com>
From: Josua Mayer <josua@solid-run.com>
In-Reply-To: <8aa96c66-d054-4b33-8972-f9faf2e84482@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB9914:EE_
X-MS-Office365-Filtering-Correlation-Id: e8da22c3-bba1-4aff-f4f7-08dc308c78dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2E2JqsmHOf2pvmKLO8OQq0OA9x0gKrlDlVRC79/pUnyUFQ9LIrL4ebqnuPlpBlbyAj4WZkENf6dxtuCDfCLZGgJzUGtiU+IGMw32o7u1/mKYjL7EdYTT0GQ5IL8lSqD0UWZj+6sxFFCbj0PE+IQ1B9S7O3Rd22iEep7ylc215dSiN16ZxVi0m9foenttfmtVxedztHb46p2WAqpcnHbvyJ0MF7YT1o52Ah/sqy+AvyaD3dzJbtzwRr8nfZf5DSKCcATaTBF3WLdl0fssGGRtTv2MhhH4Y2ZGBYgKhHplIXmhDrRK29XyxDBl5XNX46JOUXf2zrwjP5lCXQWPyAjMobCeukz/r2YVmu1T1cvrFL6JfAVJMQWVhzDNs9X63YuCjY92QIpHFhk0iPZQdXtcTwdvyqm0UtPSwC8RIEjjSrx6onIyyqH5pTPwwR5kk/K2ANgHvmeZHgaGQAT+DRJhB0tAcEYKkoqzocdJNDHpCmC+p+uWkX+UcUs31R9Q3m+vfFi30V3fKr/1VWBZU3CjlPC6f5hXAs+ecJ+E3xy7bIeVOgFup6sC2+zpHfqHdi3z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(6512007)(6486002)(31686004)(41300700001)(7416002)(4326008)(8936002)(8676002)(5660300002)(66556008)(2906002)(53546011)(6506007)(316002)(6666004)(110136005)(66946007)(66476007)(54906003)(83380400001)(2616005)(86362001)(31696002)(36756003)(26005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkJFYnVhM0kvc2N1WWFac2V4blhWOEVCcWx5dGRjb0o2eUxPSXl0WnhYa1lT?=
 =?utf-8?B?cnJNQytWTTFjVlRJdFo0eXBEOFFleWZqdXpiWlU1NG1ockoyYUdwMFdvZFA1?=
 =?utf-8?B?akd2cUZrZ3llM0wzdktDNGhIZWEwMmdRZGpmNEhJQ0dpcVZVWWRSNURMOUZq?=
 =?utf-8?B?T1NWaStDYmJnNVlaK05BYWltK005MjkvQVdFYmtoY2pUeEtBemRaS2dHMUhD?=
 =?utf-8?B?bEpJQmhCa0NqazZLYWZHckx1VlNzUUE3L24rUmo0eVJsejYxcmdQSjFOcjlo?=
 =?utf-8?B?aThUQnY0Q3VuUzdmR2lnMW1yMnhqOENraFNwUVBFR0RWVnEzbTBzL0pjczBt?=
 =?utf-8?B?UGFVVEo1bGI3Ymp6dHJ0U2RNVVhIaEJiRWFrT3ZIeEMvbStIeTBDNjd5cTFK?=
 =?utf-8?B?T1NCY1JSMyt1UEhpSEY3ZWlQa2RqTHQza1UyQXFqejAzbUE0Y09POERIYURL?=
 =?utf-8?B?NTgwbE83dDBPNjRTTTFjbEEyZ1hrL2ltZitEeGRXNVVaTHljbEVYN2hXY1Ru?=
 =?utf-8?B?UUY3cEFHajN3MTNYblVucVpDOHlVV1l4TUtuNUczQnNPSWtuTFc0SzBDUGJS?=
 =?utf-8?B?MHp6RTdtSjF5YS9wUDNJR0dWYVNzMWFnamlIb2JoczU5UTRwQ0s4UWhUaTA1?=
 =?utf-8?B?WTBPZTl6cDJOcFkyU3gwWFBtTVRvV1g4Zk9kdXBOOUlna2ZmL0syUUpKdlRK?=
 =?utf-8?B?NHVPbW00MGhBaWh4eU5NR05ESW16UDBXalNBNnBZZVNOVTZBcnpHZ0NPM2dv?=
 =?utf-8?B?eWN3MzJnejg2S281R3hGZ2cxU21scFR3d3hWY2xjNm45MXNCMFZNYk1oMDg3?=
 =?utf-8?B?dzFGN0hjY2J4SHZVQ0Q1NmdjOUtsZ25BZThmemJlRTdCUmROS0xLNEgvM3k0?=
 =?utf-8?B?dDY2Q3R1T3NXaVhHWjh1SUJFYyswQWN6WXhPNkFLdEphWFMwQUlFeHA2Smo3?=
 =?utf-8?B?VWQ1Y09TZDI4dk55ZWNSejNiM0JPVHpDTlI0OFFTaU93RDFPQ3ZhOW43KzV6?=
 =?utf-8?B?WC82cDlCUkhOcUV3cWwvelBab2FMeWd0OVU3eDY2dGptYk1xcEJORG9rVWRH?=
 =?utf-8?B?clFTQjdUN2I5VVAvWUs0alZiT3lGTm5oZ2JmdkhRa0liVk9XaFNvTGZqMFVP?=
 =?utf-8?B?QjVvS2lpQUVCYTZqOE9yd2dKNkNkNjdSamxiY2Q4UWdUa1k2S0Rxcy9uZlZV?=
 =?utf-8?B?YkRaelB1Y2laQUNDbmFEdFBxYWNNTEdNcVkyNFl6OFpoK252aU5BNnZMdVFp?=
 =?utf-8?B?cWJtZXI2OWl0NDBRYXNPbE1mUGZDVGI2WDNwbnJlZVB6OE5oazBseHNDNlRn?=
 =?utf-8?B?cDR1cWlRdHAxWmwvY3Z0NXlHYUtZOWVKeTJHOUFJd01mR3F2Tm9nRTVpMUVU?=
 =?utf-8?B?d0I0c1F3ci84enRodDJ6aENOL0pnR2FoUEJhVkVQL0F4clFhV2NQenIrY250?=
 =?utf-8?B?ZHVvT1dtZ0xGcGFHQUNxNloyL3lxbUZuSGd0K0RHNkkwU1loQWtiUTAxYmxT?=
 =?utf-8?B?T1FZejRRdDQrM0liTnZWK2pFUTZWQW9nOEJYMFlXKzdtVW1sUHhwaU8wNHVm?=
 =?utf-8?B?NDZsOWRNOWQ4eVpnaTRMN21kV2toZjhKQW1uYzBoTVN3SGlmTGEyQXpJc3Vh?=
 =?utf-8?B?amtRYTl4UGhIY1l6ck9zangwa3hGZzFJTXZ5YkU2ODJRcVJvaWVSUVVGUmRG?=
 =?utf-8?B?eDFkVUZMTms4VzZmTHMxTVk0TU4yZkN1QUxCMjZmUGxSZk0rbkJiMVJmMjVW?=
 =?utf-8?B?RkNPMkxBWXZtZ3krTUt6MVUvdTZBM1p0NUFDdUlGUnVQUjRHNzdiQWhCeHR6?=
 =?utf-8?B?TC84VGJCL2wvSFY1M1VKcVpBNE1mQzhkazJISU8zMDJ6UFp4OUFJdTJMbGpa?=
 =?utf-8?B?eTF1TVBUWW1rR2V4TkNrbEkyT3pDUWdtWVdZN0djQ1RjU1k2c1o4WDZCUmpX?=
 =?utf-8?B?eUJQbjdzblFNQlhMMWk3Wk1PMXlFeG5EcGxoWFBFZGgyZ3JXVXRZSWl3eHhH?=
 =?utf-8?B?Qm96ZWJPaWtmSDRxZHV4U3h5RHFTWm5aOGhXcUZxT2g5RnZHYlVVUHBzUzBy?=
 =?utf-8?B?VXZXbXc2RmF4SnJiellBQjAxWnRoOFc0VmZnR3ZYVEl1MGIzUE5CVUYwVUJZ?=
 =?utf-8?Q?Tb/f9no7omsyuyP/juX+dLfQM?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8da22c3-bba1-4aff-f4f7-08dc308c78dc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 14:18:26.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AqkbLPXEn0yNNSiSCqwYJeZ4gYbRUG66aea15jObhIpr3nUWv9xl1vDPHs4roAKjiBDjQrUiY3kIj+qDT01jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9914

Am 13.02.24 um 07:12 schrieb Vignesh Raghavendra:
> Hi
>
> [...]
>
> On 11/02/24 20:37, Josua Mayer wrote:
>> ---
>> Josua Mayer (4):
>>        dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-T
>
>>        dt-bindings: rtc: abx80x: convert to yaml
>>        dt-bindings: iio: humidity: hdc20x0: add optional interrupts property
>>        dt-bindings: mtd: spi-nor: add optional interrupts property
> 2/5 needs to go via RTC subsystem tree. Could you split it out into its
> own series when you respin
Only rtc, or should I split out the other two as well?
>
> Rest will go via TI K3 arch tree.
>
>
>>        arm64: dts: add description for solidrun am642 som and evaluation board
>>        arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3
>>
>> Suman Anna (1):
>>        arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
>>
>>   Documentation/devicetree/bindings/arm/ti/k3.yaml   |   7 +
>>   .../devicetree/bindings/rtc/abracon,abx80x.txt     |  31 --
>>   .../devicetree/bindings/rtc/abracon,abx80x.yaml    |  79 +++
>>   arch/arm64/boot/dts/ti/Makefile                    |   7 +
>>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  24 +
>>   .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso  |  45 ++
>>   .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso  |  44 ++
>>   arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 292 ++++++++++
>>   arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 594 +++++++++++++++++++++
>>   9 files changed, 1092 insertions(+), 31 deletions(-)
>> ---
>> base-commit: 798d1ee1675be84d5c7eb639480aab33f2c8791e
>> change-id: 20240101-add-am64-som-51a1ca47edf3
>>
>> Sincerely,

