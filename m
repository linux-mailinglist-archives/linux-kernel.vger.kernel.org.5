Return-Path: <linux-kernel+bounces-62118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6F5851BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379C328A3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED1A3F8DE;
	Mon, 12 Feb 2024 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="WRCid0Ig"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2122.outbound.protection.outlook.com [40.107.14.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BE3FB30;
	Mon, 12 Feb 2024 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759510; cv=fail; b=lrrxyUdb8zZtx4GZhHhzIO1/fxtKeAHZWBkkbl8LS4R0SXxQ8PZ28zyrJ+KLgT6XIzq0yq4nKg+TGP/iiueEYlSu0HkbwJpCdDUKfjGdXp6IcjLxaJAqoDIXpN4tyecCGEjuLC+48OmUh0FOQ88X6ZIc58l099oPokj+LFbJhuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759510; c=relaxed/simple;
	bh=IH/ystC1REz4FqsjWiJNymXfzFAK1bnClBgVjHUc/t0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k2oTlNjDMcq6IBQmMTZWBwP8MaLxYq2d0oVLgGkCZ0zZk3KWa9oBrb65U+LMpw8aBL4dcGpAjmOX5oLXX0NJY4FsajT0OMe0kMc6O/12e1nYml7a4fm36h5uXDjMpq01ElPabFuvMCbUDjqAaCN8US08KMidlojte5/guAHCgX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=WRCid0Ig; arc=fail smtp.client-ip=40.107.14.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko469qENXWFf/9ys73pf0dOrAavPA3yZ3OoH2JSxBMwjCR5ixO6qYh2+cioejgZ+odZac06DBCiT621dGLfSg6Y4MaCMm4w7Yj10X025hn4bN3Q9r8ja8NA/morDgn/fOgAj9JJPam2wrgo9bWzwZgzBdKtviymvx3MLxPfMuLwF5Rh1dEtE5xbcYRPnhZCCzOHIOUA7WjUXzfk5rHbsMKqU6uxgsGSQ3LuC62HYb7PqEXG/X3QdM5W9fML0xyNVLBDNY0AMpjuq+XLuyB6Qsxa2EQPw7u15UeJBFIHLTMcmYUUjZPjJuw78SClSbbks+nHLRYitPS0w+IlzLQZ/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSTAg3pXNs+pSA8Sup4jwt9X8bfv6C1rlfEygpHfR6s=;
 b=Z6eLAfybSNjoMlx4y7rno859B6QEJXEigZKlKvcGgpUooiaYy2t4w8VcrtQcNYSUSJD68WduLcpH6g2CPn5UwNQgcJ4dYguWwzT7ATCkHCMxdaNz6OheBDrHC9dA5L9Q9LP76pABtjhqbobgOsQvBR4+gAcUKv1oC4acMFT2Io7or92LRahLt53dLnY3XbZuOb9HdIMomPE1JymjxrqCk0UMabmefbvIU9oaHyzg3EMAIHgq22uSC06/r4OZ+SfZRga02NAOHlKz9nXzQtv4RVHI0sKq0kWP/WsZLTt8zxN+hEr4219EQe9sNhfNmk7O9ANzJ8BIhJn9py9o0ZHqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSTAg3pXNs+pSA8Sup4jwt9X8bfv6C1rlfEygpHfR6s=;
 b=WRCid0IggaNUOUeOVeWMjEfG5bvbV53FShfXCy8hxWvB6FdLqt/ukn0rN0yQS+ED1kD5B12+tPwua1/N34+M6VU5xBTrSubM3C2AU/Xt4SkVUo3r8QIJ4mimr0g0IKsU6DA2X3IVLXo2ecD0MvTrOSKRK5SWXieQjHWihdHXss8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Mon, 12 Feb
 2024 17:38:20 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 17:38:20 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 12 Feb 2024 18:38:11 +0100
Subject: [PATCH v6 4/7] dt-bindings: mtd: spi-nor: add optional interrupts
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-add-am64-som-v6-4-b59edb2bc8c3@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18db9227-0368-4427-0e98-08dc2bf16745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ty/ppsvlQKTAdohh/hWuPCZbXQhzevfK3Z0yZdoVBCR3VZc0b4J39RCKV44JM7SIoQXaMBUf5DOqOKuuYH/0oBlNor5uPldh5FqIRtA6aSYkaFvOFDzcahpC3tiQh4S5q5nQtVnH0MgyI6F81UgKGWVEyHcANXHNeLLrnxELYC8kqqHpFc+GqlbFFiAhMmQiIqQbVP9VAeROPOxLxCJHb8VbfGCZcU4Tx8qE+/ko4ktH6vaDUhzsCrNwECCjEYq4/0oGPVpUiZlAH0BV/BPLeiyq4C7CbK+ZRcFFutNd/H36UIErRmQYysIVf41dR783ZRPOmxpv0L/M12orsruhBgXDyPQ3zH1xQVMmBiE/cLMbxuG1BlN0F1iI3T2j65uXI/Cba+3rxlfm1TikqKyovJEDI9ndofwA0qaYvgi4OxiGeLs90Yiqu0D/ctkks8O1vMbeM/tDEd4QS2Bn7DzodVTYadhqwv3SzS//43kVEvRcRFVcLXsBu36np2AswRj8OrGnOtS7ln8BuMwB4Z+lyDAnVaCgEHgSrDd210zF0awHjGyvI+slJ0C1AnN3njlX/wAoHT95eQdXH5gjfMTwVzuCehRGMGK70vLVcG0gkPVlKR0vPaOc9+CmiNrcGP/Cidjd6ZSW4Gf0pXNQcW9tqg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39840400004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8936002)(7416002)(66946007)(4326008)(66476007)(8676002)(66556008)(5660300002)(4744005)(2906002)(41300700001)(26005)(2616005)(38350700005)(36756003)(107886003)(38100700002)(86362001)(110136005)(54906003)(52116002)(6512007)(6666004)(6506007)(316002)(921011)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUlPMldSUVNta3M4WGxKb0ttaXN3bG9QV1djTFJoVGFNdWtTQ0xBWmMzR3FM?=
 =?utf-8?B?c2FGd0V1SXBPNExhTVQxSXZZSmFqMmQ3WkxpYXZ0ZTlwY3hYZUg5WGVFWHZJ?=
 =?utf-8?B?dEVyQ1Jtak5NQk1UVHdoREtkelJ4SlVXdzk2MnA2bExaa2RaSnB1WlV6NWdj?=
 =?utf-8?B?QlBhblE0Zy9zVFBHR25nc2xFVDlUMUhnY0VsTmpWc1hUd1VNMGhLenhwWTZ5?=
 =?utf-8?B?SXQrbWV4M3Y2MzVqR2RZU3RnQkRwaXRRT1g3Y3p4bk5kQzIvQnhySnJCSjQ3?=
 =?utf-8?B?WTdxY2RrRUVWTkU1azA1Ui91S1kwUWtTU3ZvS1FuY3pXTFcvamp2UVd1L0k4?=
 =?utf-8?B?aEI0cjVIM05vYlNWMEZ5UyttWXBqSDZ4NmlwMWZzZ2ZaWGsyT0VEM1dOdVYr?=
 =?utf-8?B?MCtEaDNJUERvSlJmakJwcUdKc0g0Zlo5dU9xMUUrdWgyc1JqV2IrMXMzMDVB?=
 =?utf-8?B?c0pvSzArYlhWT3NJN2dnUllQc3YrMjhYU1pjdUdnNUJ4SE04bzEva0Q2QlAx?=
 =?utf-8?B?RWZKVlVjazFxK05RTzE1TnNLVGw2N2hHdFN3NlFPUm1yQUo5UWxpVTNjcFZJ?=
 =?utf-8?B?dnhZUkhOYlVPZTRmdEUvWjNsZWEzV0E3NzlmWUFZaC9DVGdFSkRtWEtZWUZ4?=
 =?utf-8?B?YWZPVisybUovTFpwLzFCdi9TN2ZxRHVQTHBrNEZXMFVOV2p5Q1ozZEFBTTl6?=
 =?utf-8?B?T2M2dCtDWGFLWFZxdGZwQVQwYVVtOEFnVitVU1BuN2t4RWJ6OEFqeVF4UVA0?=
 =?utf-8?B?ZklQbVFEYUFtL2lTNkpFd1lIVC9jMVBzaG10REtVNTA0M1dmSUpWcUVnL0p6?=
 =?utf-8?B?OUMrTHRscmtGZWFtOXc0Y2l6a29Tby9Dc0VOY1RGdXhtVGFxUHdQVlRPZGZS?=
 =?utf-8?B?UEc5K0s0dm5hSGZsUFZUK0dPakJkbCtReUhsdDVCcEluekZkTElLM3dnMzFq?=
 =?utf-8?B?S3VJcXVzL0FrdzBWZlZZOVlLVnBvYlR6VUpuY0hvR3g4NWtDc3RvME93OTlT?=
 =?utf-8?B?ZXh3dXVKWTRYYVlMa2J5a2NnMi9TajJ1MDZFQ2FQZ1BOdnY3VTNQWUNJeU54?=
 =?utf-8?B?aUt3cWZ4Ym13b2oyNkx5Q2RhVFBsSjVpKzV2Q3ZoRzE2WDQxWXpTNE5VZ1l3?=
 =?utf-8?B?Y1I2YWtMQXRDMURjZ2hGL3d6blh4dmdXcVVOQUtyUnlnM2VYR1pqeW5QeHZn?=
 =?utf-8?B?bjZzTVc3cjdScjVkK0F0MnZLTWI5WFRKNjJaYmozVUtycFdEa1FXZk41VlRW?=
 =?utf-8?B?VzhDQXJVWTFKYmdSVFdTYUdMM3plWDZsV3JxbHRqWHVScEJqMmdYcVJMOTJC?=
 =?utf-8?B?aFJUUTJ2cjEreUw1N25vMnRkSGN2T01RNXh4NDh3UHlZUjdoWUE3RW1qYzY0?=
 =?utf-8?B?OFBzQWRUeHIyN2xucW80MytzZk9yZW9LUnVHdnowbzF1UnNON1dVUmdpcDF3?=
 =?utf-8?B?QWZvNG5rc0w5QnArbVArVnVvQVZwU084UjlpOHdvSmlWTTI4UUpXR215Sk0z?=
 =?utf-8?B?elpzQ3orUitXeFU4Tk4rZVNLdUZtbTFCQTIrYnBsM01zcnJCYmFMdCtvWVpx?=
 =?utf-8?B?b0F4c2dETk81V1dabUVrM2pLVnc1RzRjcWM0ZTFNemNyMGZBbG85L0FEVUVH?=
 =?utf-8?B?eTZnRFB0MFAwL0FjcWJzUC90M3lKN1loZjJVSW04WGVLQmRST1gvb2tyUk8z?=
 =?utf-8?B?U0hoUkNMOXV0STRZOTBTOUZseHJZc0ZnS21TcVphUWNvRlA1SkVLbXFJNHBI?=
 =?utf-8?B?S1JWZWhUQUhHWC9sa1dlajVDaFkvb3RRbHFRQnE5OFRGMkRrY0lvZkhUT25C?=
 =?utf-8?B?ZGRERnVqZW9MU2M4N0FzbTFaN1Y4Ykp1Ulovc2JoRkxjTTk5Qjc2UklXSk51?=
 =?utf-8?B?SzJoZ0xYc3VsbU9hZmxOYnFvZko3ZERiRVU4Y21VZHR6b2lCbzNGSUNHclF6?=
 =?utf-8?B?MUFOTm9sRXRFNHlSNkZtWFgyZUJKQXJuejVuaDc2YWphT0hIZHp0Y1YxTnlk?=
 =?utf-8?B?T2FWTUFmMHR6V2drU2FjMVdHSUpSWlQ3M3VCTmRyVmFhNlJrNGtZK1pSWGcr?=
 =?utf-8?B?UitqZzRUZmxIb05ZandhdDBqaEFCUHROcit4c2lIdWFCdjZ0bTFTN3NIcE5Z?=
 =?utf-8?Q?ErH9qOyel+VM8jYCiuGOBU0ei?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18db9227-0368-4427-0e98-08dc2bf16745
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:38:20.0240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SO5Ik+gtFdUtT/9RfZ1biglLtwy2u3dmeQrxU1hwZP015sizBUarf4cS4rX/LDPe4xZHrKvaiSam++woLUkryA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

Some spi flash memories have an interrupt signal which can be used for
signalling on-chip events such as busy status or ecc errors to the host.

Add binding for "interrupts" property so that boards wiring this signal
may describe the connection.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 58f0cea160ef..6e3afb42926e 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -52,6 +52,9 @@ properties:
     minItems: 1
     maxItems: 2
 
+  interrupts:
+    maxItems: 1
+
   m25p,fast-read:
     type: boolean
     description:

-- 
2.35.3


