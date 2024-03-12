Return-Path: <linux-kernel+bounces-100733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 403B9879C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA0F2827F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD033142911;
	Tue, 12 Mar 2024 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="pu+hlUW2"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2122.outbound.protection.outlook.com [40.107.105.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE814290A;
	Tue, 12 Mar 2024 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273436; cv=fail; b=bPjRHveFCq81F1wkHvpenWWxX3wJaXn4sII1NWsctEmSmp5P32tJ6re0rbxczmVDaK973Bj0nUOZX2pJGRl+7KXReK7/vuhX1muRFQlk9GzixAZ5Y70wOTDhKA1DmFq/aW/wdLQtTlR0wX6fD2JvYrC6yhrwVoLLRsG44zcYC54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273436; c=relaxed/simple;
	bh=1NG2DJiqfoqotaSv5axJYoDsbjvcheJh2uuHjvnK7NM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KkmBNpqptZcw158lP1EvCIrf+Oa6XytMlmdu/d+V+XpbYS5kbV2mfeLaYPZq2ZbREUqGG9eqmMKUxEO13bzv7yUaNAGdtkB20NVitYTSH7S2ptNZmmU8SJ1S3sWZc9z7mynmoAm7i2KhXn1zVEMY1GSJ3IrSyiO8VBeq5PHoe5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=pu+hlUW2; arc=fail smtp.client-ip=40.107.105.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHNTyxpt4wp8/b7cwLralM4oMNV4akwqcB/rlR7f8W7Q/vCHdrHdt+k0sLp40QfG1u8n1yqsDmfMML0lr78j4ZPB64YPIpD3nq0eeJ2o0zOXsIcleDTnSwxdrAR6FKZnxU1yd+PVdBF10ZVa9F8WEHORX7Q132aqPseL2URB8/FDBKjzCNh+wnPWuQUGW+QqywUGvRYQtUe0cpblbih1G8BkwiDPzjcf2jC66SgZMztElXFxlBboVvcEJ6dbvpTpyxYHSPmu1qNiEylGjUfcPCILxAsJtExTjBU4Lsq+squHjZmc6eLLKa8o5d1VW8vGjKV4sQ8NM+GsGUUyIk2WdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uupHXMX7yBAVTkWtI1qrsKmIT+VKcxDOD0jN2cZ20KM=;
 b=Z2GdtVms0sjpa37r60bJwdVkfHMzmX5KAN8wosuDIjNIgIpUhkpSjprOlCiwhQZsZ5Y1OhIT6R5DvEIShCt1ukrpFqtywrvsIUJ1d0yTnXOGQKOXvdvU8zJt1HDsKKNucxbPgbi2cx+UEInZt8BTZiG7I2SdeEGOFaTYvA41qtyEB43j4YVLbR8w48pDGjpNQJ07QltO5U2ZE1litZPRbdvFg3+OJFmehcBCC3w1PgmvfROdgWtyRMhUW2GMmG6kSBb2vBuTThcRed+q9FjIVFLiYOQGwm4/9+dB4YxBQDi6Hku8ur5/IM4Btv9wtAkoIFfGVEzIct62wrYmZgR5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uupHXMX7yBAVTkWtI1qrsKmIT+VKcxDOD0jN2cZ20KM=;
 b=pu+hlUW221M7mrJhnFJd9+0pwXm42AJBf2VJbbV9rtm3Z8r0j6NY8OOzE6ryZsS+aqn3iL1h50xRQaHEWZZLETCKckQiyWAfgjR/X0mzzOUxbyUKaIEHGwyrZrVcQGHFie6ezenjveE0o3rnThauWnY+rtcXz+QA5cpv9amOl0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB8601.eurprd04.prod.outlook.com (2603:10a6:20b:438::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 19:57:12 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 19:57:12 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH 0/2] arm64: dts: fsl-lx2162a-som: add description for rtc
Date: Tue, 12 Mar 2024 20:56:53 +0100
Message-Id: <20240312-lx2162-rtc-v1-0-1f4cd431b1cf@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIaz8GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0Mj3ZwKI0MzI92ikmTdRDOLJLPUpLTkJFNjJaCGgqLUtMwKsGHRsbW
 1ACFLEpxcAAAA
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM9PR04MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a68293-523a-4906-4fd4-08dc42ce9b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KN59ZLarAi4/Vb+vXQKjpUP6xWnMnwk1zHhtH0INA0UI/HwchCjBMChWRWPKCr4hK+jv+aOae13t6uPHNtCJREbVlw3FgK6wtyEPcku6hokKfRo57jB/DKwthXz2ZYvrIG4oVnvY9VilfYna7UJbdcjoLSWLlRYcbBk/gWeUp9tG+aezxJQMVcg8Qw5SgfY70lfUEgA3BXdPQBb/I208MqE4b0d/Cia8ll6Pkj6dGHZN1yX5NrWz9C7yBZSzWD1sbQdWO1xjkW+q1bPlolr5J4307MeoO/nS80qlp08LiaaksUuqjcT1y066jJOe0neVuNu/fw9fMY04SwP4YP8kRJX4Opi6Pufa7yc14riE/XK/RSEuxiEfkjq25JDtzSlXT217EOSm+9Eg+DdcGsKl92BcKJDEOtEv1IOkSDGDXKx6RUrsNynyp1zAzIPjNXuYZ7xwJSwLK+wRmT7vG1AHh0lxkxnY1jboAMpoG/8SZLfJyiw4yYd/i+hn2JE0kLP8xenkbiBZdAKp+dDPNE1lR/Za0e/OeWPISee4jQsawvCmA2hn5SsYDwu9sJ6GF8ObLqKhtnyPxwq8rV1kmJfowh+GsrynmOnwmuFQp1VL/uk18PBJ+YiXYb9Kr3ULCKPvAyxjboDJmnv7tuTd3YDoLFxBxxzlQMn8mx72bHE2m3U+0KUCqUeCYd5Ry5/Vff0MQe/MjA35/Iufj7jAJNEFpnQw7J6I/ToiGVWEM0CquIs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWViN1FjYkttcjFjNk51bDEvOTl5UjNaajUwem43aTFhaHJaVXpVQU5hcHVK?=
 =?utf-8?B?SWw4TllyazVqbWovdFpudmFhbkloS2p5eDI2SFRGSzNyNGFPKzFPNkFLcE1C?=
 =?utf-8?B?d0M5ODBPamFZU1hhdmlKRVczR1VUbG96b0xlQzBlaEtweFplUEpLTDhGZ2hW?=
 =?utf-8?B?NEVZL3JoQUduZDQvSmVFQ3NYcTJKTVlyK0N2Wkt3U1pPZjg4YUJWN2pMMVdz?=
 =?utf-8?B?ZFNNWDJRNGR3K3ZScXdsQUtJbjZWeFkrWDZLNW1rNXpZc2dVcmwwbUFFeWs1?=
 =?utf-8?B?ZnF2TzdQdnowQzVHZnZqL25jQm5ibXZsTlNtcFZmb0lQTnFHblY5MmJpR2NB?=
 =?utf-8?B?czJmQ0krWi92eEhLb1hpU0FDeVpvYlhONGZHeFZaWGlxa3lGbVhDQXdKMmVt?=
 =?utf-8?B?aUQrd0JFeWE2OEJERlA2UUNxQ1NjTmRYdHZNdDBFTHZobWk3Tm5LL2E0UnUx?=
 =?utf-8?B?V3M5S0U3UDZTdEplRUJucVBjcldiU0ZseldhVXhLTnRlMHlWUEl4NFhqMW1E?=
 =?utf-8?B?eU8vUjQwWWZVeEpOL256N1Nsa1lXQ2s3VXAwdWFqQWMwMXRxd3BzanpiOU15?=
 =?utf-8?B?T2NGK2QxTkxVaDJ4ZTV3SW1SdjJmWjd4UUlmZVhQKzRoL1pWcm5yMVQ5L0cx?=
 =?utf-8?B?b3o5ZUh3UWhJTUxzdDE1K0t3L2tsV0NjS3F6ZHJ6YzV1akNVMWtsK0U4cnBB?=
 =?utf-8?B?MmNtdUtHSmRvdnF4ZStaWllxYjZIZ3M2UFhtZ3g5VElIVWdObkdUWXZSV2Vm?=
 =?utf-8?B?K2loQ2lXTGJYQzVmdEJjMEpVZW9jc3cvcmZ1cjRRTndaUzkrNjFRVmxJaHFR?=
 =?utf-8?B?cEluOGYxT3BXeXJXTmV6VFhSbEtUekN5cTFWZmw1dlVzVWVwUW1MWms2T0Vq?=
 =?utf-8?B?bFZlR0RYbFNjelV6OUh4bzVsN25pMXdXb3VZU2VvUkVRWXpBU3lncEhsTUZF?=
 =?utf-8?B?dW1yTzk2aHB6ZlkwaXF2NWlMREtnd3ZLSzB5UGoxMUhDSy90TEtyZ0lIN014?=
 =?utf-8?B?VUFCSWxoNG9RZlAxajVHbUgzQjJEZTFmNW5VUzlKTkRWODVFemROWk0zMGtj?=
 =?utf-8?B?WXRDa3BTMGwrNlFuekh2cEhoTXZvMjE0L3dMQysvVjM4RTJNZkN3UWRtUHJ0?=
 =?utf-8?B?R2lxaGRmWHBHV3oyRk01Y2VRZHZmOE5Vc2NDT2ZmSEZ3N2JjOXpPS21WQVFR?=
 =?utf-8?B?VTBuNWs4UDRQb0JYU0gvdXlMOU1jVzZrdU42S1diRTU2aDBzTjhGd051NnB3?=
 =?utf-8?B?N2Rqb0hmNmhFYk14bUpraGw1aG4zcktYbitURFVxbzlQTW8vUHVJVG14TVhZ?=
 =?utf-8?B?Yy82Q2hOeDNPdjdCcm95UHJtQ3BlbXlwQnhHTWxuSWlYMTZGMm45Ymp3TmlJ?=
 =?utf-8?B?aXlOSGJMVmJIdFcyY2d2U1hobjZIMS9UVEVzbm9xWHFKSmZkb1JIbkxsZWRk?=
 =?utf-8?B?YU55RFlwRGlLZW1nMWNWaFZpb25UdVlUYTVpNjVQL0M5MUZKUGhqeVpvWk9H?=
 =?utf-8?B?a1dkSTdKWCt3VGFmN0ZzQ1N4YUJwd2o5cnIzWENic056WjZnbHU1aTVneEFq?=
 =?utf-8?B?c1hPeTQxQ1BaMktYMWQvL1M3QXdvZWtSYjBHR29UR3pmTGttblBVbmcyUWg1?=
 =?utf-8?B?VTM2YmFzY0UxaXpiREN5UnVENzRuM1pZNndZR3VCZmxMTlNhYmRkZ1l3QVpK?=
 =?utf-8?B?WHp1ZGovei9jZGtMbmZYOGVZcTFReVlTN04vaWxheTdpcEFtTUZCR1JNWGIw?=
 =?utf-8?B?aXlzamVKUCtXSE9CdlQ0SmZNMzJzd3VINHE3WUFPaUFpWndUaWVWdWZ6MG9K?=
 =?utf-8?B?ak1EcFdJQ1REL3cxdTExTXR6SkE4bTVzalRWMHg1akl3Z1F5eUJaM25qRmZi?=
 =?utf-8?B?dE5mN25OODFVd2kxWHJJWERtS2lYQ1lvMEthd20xZXYxMSs2TzdIeDlYY012?=
 =?utf-8?B?SHZuRTJBU3NSVUR6b00yWlM0ZHBhVnp2c1FWR3dUL2dyZzAyejJDNDZKY3VI?=
 =?utf-8?B?TGZTVzFnM0hpOTVVV3d6TCtPR3ZDejhyTXlya3B5SjlUMGtNVWdPS0RiYnNY?=
 =?utf-8?B?OHJNQU9MdU9BanEvZ3BBYVpsYTFXQ1ZlY0s4aTNta0h6M1BrdWpaOWV6MDJL?=
 =?utf-8?Q?kGtrFN55dDLK8eDILHQKGDC5z?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a68293-523a-4906-4fd4-08dc42ce9b87
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 19:57:12.1788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9hClH9+TYT7XroBy9Mn2td4ALPIRxsK80Mk1kohkkZVl13ySQMvgS/jBEQXGGV6FpjwRKGOLU0gSDGii37WTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8601

Add description for an on-som rtc that was missed in original submission
of device-tree.

Also update the clearfog reference carrier board aliases to include the
previously disabled i2c bus with this rtc.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Josua Mayer (2):
      arm64: dts: fsl-lx2162a-som: add description for rtc
      arm64: dts: fsl-lx2162a-clearfog: add alias for i2c bus iic6

 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts | 1 +
 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi  | 9 +++++++++
 2 files changed, 10 insertions(+)
---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240312-lx2162-rtc-a68b6ebfcb53

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


