Return-Path: <linux-kernel+bounces-62117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C542851BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19D91C21A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9BE405F7;
	Mon, 12 Feb 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NaWZv98A"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2122.outbound.protection.outlook.com [40.107.14.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C23FB29;
	Mon, 12 Feb 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759508; cv=fail; b=J+4dFJ8bWXHQa82vaLh35r4aE0V4TIWQZgz3agwiJc65aCEcGh5tEEFt2uooS1Jnk4ZHINoO60bjTYQk5V2bLhr2x1pttfzWf+PixFOsiXhZs7BdvRNzhckRiPGD8Qd/59yz4qdkmCus5dEUAie27KmwKTrYxvI8mVPbq2wjmUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759508; c=relaxed/simple;
	bh=7hdmJy7tzYZ7f02IICkhfh7GG+QST5UPSkdJvLs5pK8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OSSiSm6NiEuYr8na/N2OprCLXfRmEK5iOtOrrwwcnkjlXXldF7vcXjTLnnQuexqajP4c/Pv/mYkccV6jaiEJ4kvJjP3Q2mFfkiRtQp9wrjxfPMQFymjligZTpNJ9BzqH3E6SpEEVKjYLPHCX1ZnzNzvv2fyGdzwjOYzriqRcDgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=NaWZv98A; arc=fail smtp.client-ip=40.107.14.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlzKQuxLa6Mf5uiTQ0DyVzfidlyvi0UVFosOHrUs9NXcPesxmDmhxedwZw0iVNuwmBC5vkkwRVVsP+ntLlnZGtk5Ee8z1CGzElmOtNkm42GKx1UVjTFezHevZYPUvCTklzVssad310jk8fokLziymkKPct/U3dqq/kVq/9OCfKmUxXNMiIRVKlngaYc31YnADO0S2T+bMEA85i4V1ZjDgNPlQqaIduWjLn7VXXqj6UUODGjcLn905+qb+QbQbOdvg4EagM+S9W974MKKov3N3BP8CBK5nGM+/hrcnLcp5Tcumw1HtJnb1qVCzgiaJiDllODbRl6tx9OlBoyLyL4oPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9Jyr5lvMsW/PDnX/iJIgv8Rk7hcQ2oITDvhDHbCycw=;
 b=I9y6Pp4Sn4xVFyVj1gCc7w2wghchYkETUgRX3jWRsTHjs9kS6M0HDqKg8zJgFv+j5ZToN3+rhpuT4fZ07XOqQx4TdTRZL6rb/7rQ9zGg9cr61qRDTXhJHJoCX4DMeXlJq2/EYML/TTy3g4KuHTCO+ZRRBiFDq7bZ3ytk5p/1jKlMN/ZXG8LbKDkDM9MBvgDwema6olnjuHtcccYoKz+cnoQ4g7NZrYkznfsAz1nW4cA0v6MbJFU28T1B2UQXdCbigZ0quhnGWG64YxJ+RHYKtgeRbHhq+wsLN9rCZNyn/tsPM8TNqUTLPapHK3VcXx557OGUk0v25Bd01KVYEhjvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9Jyr5lvMsW/PDnX/iJIgv8Rk7hcQ2oITDvhDHbCycw=;
 b=NaWZv98AiNeqwNeTXopypoVzq6ClTjFbe/RqVbabOSxeg6u8pUmJIe3wRU/pVJk7/6JW0PS327DfXfC+v5UtQ0CTdoXQOT1FxU+ck21SRLW3DydTT8WN5TdINbIzh5e6ZeII18SWvL7PRdHgh70IKBMYP24dnhy9iUBCrW5nUIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Mon, 12 Feb
 2024 17:38:19 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 17:38:19 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 12 Feb 2024 18:38:10 +0100
Subject: [PATCH v6 3/7] dt-bindings: iio: humidity: hdc20x0: add optional
 interrupts property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-add-am64-som-v6-3-b59edb2bc8c3@solid-run.com>
References: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
In-Reply-To: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Eugene Zaikonnikov <ez@norophonic.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 linux-mtd@lists.infradead.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: fede1b32-5137-43b3-d09b-08dc2bf166d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GEk55DRonMQjlyeTcLjUMh+3GeTnFiSuBHQP3VCIfx3uDjL2BFw1rrTiGF7OUllXpGHP+fhP3BMGnvuc8kBpq0cVBFbQHjeQmAD6O4xgVDyXayXoF5ZpZS4xSW4iUBvjU4t+9ECac9x/xl6/KyF34L3NPrl27sWIgO1h7rGTSLj7p/UgD+/4n/pY25aFdtEqtGUVlPHgWF54ESBCxK80YUZnYO5LtmUjhG7ID3I96zvRAgBDzYPQ9ZHNy9LdBFmdnGXbXy23seoYu5QN6kArGzxJnDYtFiqQc4PjmH2Auj3i2vsK6nyddhboQZbhRKj4o8RuwnRlWoT3i2ApXw30y52onxz8gBu67C+FzGySNGXDSstC70TIm2p0xMljY1Vvz8ob7+1XQcqoaFUUrXTktraMaCC41hXOJoj9GmadSP2ZkP6oggoTORq7UH94T5Yb8djgy+9maztP/2s3i+Yx8IBit5KX/u9jEzTfo29GDOwiLmDVpxi+ZBhsPzhMc8oTI2rAIieXPDtoIEnTywxAAlhIfTp+dhwRWnD6LVyEuWEO18GxX44/+IhgX5keDyCPcZph/P+pxDGni2n4vkoaUO+PP/l8YMtiTxycDQXup9gbMpP2AbJG+v2NdXjMC8mtEclduaeSNorczaSbpZfa7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39840400004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8936002)(7416002)(66946007)(4326008)(66476007)(8676002)(66556008)(5660300002)(4744005)(2906002)(41300700001)(26005)(2616005)(38350700005)(36756003)(107886003)(38100700002)(86362001)(110136005)(54906003)(52116002)(6512007)(6666004)(6506007)(316002)(921011)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1dmTnVoWnRWL3N0Szk3OTBOTDdDOU5iMFliOWZETkhUSW9FaEh0ZU5peDF0?=
 =?utf-8?B?aGp0emNmVEl1a2RPU1pUSFYyWjZBdmJnanRGTUllUm9EOE80SHN3U25Ja1Ir?=
 =?utf-8?B?UkFBVnJmL3doMW53NWtKQzE3dHduQ0Z6dVFOVXAxZlFSTVJONnpUTFg2NGJS?=
 =?utf-8?B?Wlp1Wmo5OWc0ZEU5SlhTQXFkYWkxbmtQU0tGc1FCQXF1Y1ExRWd5R0pJVVk1?=
 =?utf-8?B?bG5tUXdreXZINHZVcmxEUFZ4NHJnVmNMT3IvUzhyZE4yZzlOR3NyV3RLR0xD?=
 =?utf-8?B?dzgxbTV4MTlTUTJpdWt3K1hGVG9iUkZaaDg3OVBTcVZscTRBbjkxTXg2S1Rr?=
 =?utf-8?B?Wi81M3AvMHF0c3ZYR0I3YzlIV1dBUG93UEtiQjlnSUkzaWhRM1FEMVlJellN?=
 =?utf-8?B?SldsckFpcDBubG8wSDQxWjNiZDBXVEJRUkNidUdrTm9xS0dad0pqdk9aMzJO?=
 =?utf-8?B?TndiaXhIY0ZvanE1eXFtbk55blV2QkNwRk9NaTZ2ZCtNKzZmck1WMTZiOGhX?=
 =?utf-8?B?TnQzSFhhaXFaM0NZV2NoZEsyVFJPc2g1QjVqWUUzU290K3NqanQyWmo4cE03?=
 =?utf-8?B?ckpqRHlOMTRyQUJOOVQraEk4LzMyVGZmMUhrRFhQOHlEbWp5eitZRE8wMmI3?=
 =?utf-8?B?amZNRHQ3S2tXS0I2b2dRbTV4UVAvNjJsVjdCc2pTQThhaUkyWWwxR3IzR3NS?=
 =?utf-8?B?dkI0VEpONUxHOTFyTzkzNjRTSWRxZFlUUzJEL3NIZks4UytCWlo0S281N3A5?=
 =?utf-8?B?ZXdwUUl3U1haYU9lZk5CR3hnUUczdUJkL0VoMk9OS0JGNUc0dlp1Vk05MFhT?=
 =?utf-8?B?RnJMUVVZdUE2V0dYVGdpYzlKRC81VDRkQVAwZzh5MnRiOHVJRjdjZll4U0tZ?=
 =?utf-8?B?QURQNm54QmpvRFdmTW40a0owL2ZtbmEzbk9OeG51cXNsSzFUY0FCbkR6T3ZN?=
 =?utf-8?B?Uk03SGtFeEltcUl4YjF4azBrYkdVSHFBN1lwd0o2T2FGb3NZTC9jSU5CeVV4?=
 =?utf-8?B?Tnczdi9za2g5TzQ1Rm0rZ2VoVTRiZ0FoRGUxRzdDZ0dpdWJIeWRoaHhacGwz?=
 =?utf-8?B?RjVLQ2hlWEZzUjJ5cXhUTGhjTW9EL3VxVzRxdW9OUFpPYmdLMHJBcVJjNmRa?=
 =?utf-8?B?Tjh5NFVXU1N1WnZ6UlVpMTZUYjVsT0hzZ1BGOWJCdlBOWjJDT2VlN0J6aWhw?=
 =?utf-8?B?RzU0UmtQZ2pxNTZ3WHZXRU1lVDJRd0FOcG5CeWhaVjRFM1JwcWdhUmhzYTZ2?=
 =?utf-8?B?V3VrS1FHZmllSXJIUTJnNjVYY1lDSGZSS1Z3eWxtNWc3eG5hZWFBOEhIWmNP?=
 =?utf-8?B?dTh2VlZzaGYrYThCdGxOUjMxVnFQUXZRR2IrazI3R3RNOG11ZlZQN1VBeTA0?=
 =?utf-8?B?UFJ5aHpWbHBNTDJzQ2VzUFd5UFNKVEpCMjBVNFJ4Z0djeTRPemdZMkpQQkls?=
 =?utf-8?B?c1N3bE0wQXJHSnJzVXFlQXllTVNhb0I1M2JEZFRrYk9Da1dDaERabkY3ckRk?=
 =?utf-8?B?QUVVaDZSNzFhK25SeXUvb0FtQTNjN016U1pJWTl1VmVGYXdkMTV1Nm5lVG92?=
 =?utf-8?B?eks0Zk9wNmNVZGsyRFpHeG5qN1hsL1ozRUhRVXZ0WjVhZDB3NEJaMWFFRGhX?=
 =?utf-8?B?ZVBTa3pRelRNRUxnQ0tKbjF6OXpKOEtyNXJ4bzE4TWdORk9qN0JNelEzUDVO?=
 =?utf-8?B?SXJQd1ZaQytQVFJSc3ptYTh0enRTbVE4aWVGWkxvck9icGxHc00wRFpyUVAz?=
 =?utf-8?B?K0M2MmdmY3djcEFiVnhGekY4MTRZaE9MY0p2UWFyOTFEeGJibTZ2bTRhWTFC?=
 =?utf-8?B?QWhkNHNFS2QyUEVHbi9FYnNpKzhMM1NFZzJWVjJVektIUml3SFRIYklZdGtZ?=
 =?utf-8?B?Z0VqODNHRUV2bUJsM1ZZQmo3ZTZwWTk2elpGT2IvdzYyTVpRWWVWanJEOW94?=
 =?utf-8?B?U1hoN2MzeFlHMXZwTXNTcmhpTzNGRVpaZnJTeEt4Z1JLNWRiUk5HYjF6cS8v?=
 =?utf-8?B?VEwwRmxLRHlFT1I0bW1MMkVkeThybmhrZnR6a3F1azhMM2RNVnErbkllZVJQ?=
 =?utf-8?B?M3kvb3F3SHAzQk5nK1lTc1dXT0JqcnJNYWxpRkRIblppQ2I5UFpQbWZ0VTh2?=
 =?utf-8?Q?5JsdJgzZCqFigKCfFhiFULqeU?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fede1b32-5137-43b3-d09b-08dc2bf166d0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:38:19.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjsRFMn+6jaF9+6+592HuUuECx8978dvaLgAmrAimMWTrQj3PTWhvEsBWTjuL6IBFEzWPKVdsdpp0i0fwJjbhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

HDC2010 and HDC2080 humidity sensors both have an interrupt / data-ready
signal which can be used for signaling to the host.

Add binding for "interrupts" property so that boards wiring this signal
may describe the connection.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
index 79e75a8675cb..e3eca8917517 100644
--- a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
@@ -27,6 +27,9 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.35.3


