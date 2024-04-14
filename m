Return-Path: <linux-kernel+bounces-144143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B20E8A425D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CE7281831
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950B64597E;
	Sun, 14 Apr 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Q33rmCb0"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2132.outbound.protection.outlook.com [40.107.249.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53712D04E;
	Sun, 14 Apr 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713099523; cv=fail; b=GTyCTKj8csfbSZIFKayLHxlcMnivQpok6PVKjicUMRZ38LOnurV6V7UEgeO5NH6NZiTu5a1dwZ1H+SxnhDZcfpOdvvHO+hOU8VSdUOHQ8w7hbiUSD9IP2CGKN13sBbF/pl8yLxjhAWUlgkWsiCuUVUMC6nj8BrxVXGpcyHoO/C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713099523; c=relaxed/simple;
	bh=3QZ0UqO28sVMueRhjEWNx2NcHHk+ECYN0K5QVVjZtEk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lCHYrQxMJmz9ba3qFgQcrkQGEzf5U6sRHN/qNWppT8MLx1dmzXwMxU1SliBfCQ2HQH6xZRXhpEjZLq5G/V6qZC3ILP5pCm4ePtyNGBTukqo9MafU7M8S0UTEvOtSxIyYtpHYnZuhFJ2vd+cgOkI2DCxXFVvFE1OvzZiwm03UJ6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Q33rmCb0; arc=fail smtp.client-ip=40.107.249.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at5QXBIA6zANpBN9ynXu2wX9hNwQQ2VuiIjyDzU/fydd2dKRNVjeqlMV1nCFFzPDR2nPD3a3TOLFn8p4KPApVqULQzWVbcOmlHXYSi/LioQ2kcZp66w30YI4TvMX1zAVx4/M8ZjiYH+cHweRqNaD//Z2MvVBV5+iFTXxnrmOw+QK0QpVoS9DoBT4J3ZEg9tJr3OZBEKDmA8z0Y4vRTk7Yqku1IWd4AgzoAh/vEB5vtqAxzssa6/zDEVUcGGdrVgXImRPH29jOUQjWSO+byFG7KUALGRVgZuRFs2Fk4fwzViUYybWDpBu9FORg8ME4bh7vNl2QewMjntZQTKnH5GM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrkxxZZOdyMzSpH804xRaW3AZZ/+05WG4GJPck8JM8E=;
 b=lvc49djI2GlICOHkjGsE3guTJ2oF2OR/RjJ0p0HrBA5i4PcA381chwuZp5Vusxbg71x/HisoT1MevYFDwFdMflgCqPyx9iMotyj6lpQ+VCBqnd/xlFd1/3elI10qka5UItt3k/sNepIlJ76RBbhui4Aa4p9ocwHppfrsLGc/UbgaEOg2XFMt2fR/lUAuUVq5OuxHpRRnZIw/GSApebaS8FiJfNgU+IZbxhnVY3Pw6CP5QVNDI0zvNXO6H9/sB1j3Wi1nkcR8F9cFBPRXTeZRHPqoFwvRo3soSaouyTsG9JwfqOebpOR8HWAQ3Xn117GZCzAqiWLJZwqxlgDX16cgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrkxxZZOdyMzSpH804xRaW3AZZ/+05WG4GJPck8JM8E=;
 b=Q33rmCb0PPeceWfQqNLA7sl9/m4/CyPDOAKERY7KGt1zXw7+i3d/TebNyYVKHO7nE+xt/fNrQSXSk50JIb7Jay71Pw7PaiPzQD4QTVYaHaWosMNy/QN1pP+tMkr6YBOdVjL4q1ghIEYgxT1iSK3HEqieLBi1G+P8V4d3+fzYMjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Sun, 14 Apr
 2024 12:58:37 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 12:58:37 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 14 Apr 2024 14:58:32 +0200
Subject: [PATCH v3 1/4] dt-bindings: arm64: marvell: add solidrun cn9130
 som based boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-cn9130-som-v3-1-350a67d44e0a@solid-run.com>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
In-Reply-To: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR5P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::18) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc9e2d3-2f18-434e-0a08-08dc5c8299dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BuD9GtQUm4UZ5eweSDSwwTtUwon6F2QFqxgKU67rzrJIoOu5v+9g2DjO4PniZqeOTmRk3MTnVgBOzPXWTV2S9UgyxtndiwoSmf5WWXVnGwaNmFmPvNQsyjL0gogPSPva0lUxAKTNz/8PYmGc1HtRpox5LyS0FoEPqry5elQ0BUoZ1gkj5NJQ/9LfT6nzd+pFEC0ulXf3hDYTHt/pAGDJkxOWnrrXhQVC7NJLxX3SlMeO9KRM7Bk40vyf8bAlAaSAcycxoWgiKptE5mLTa+NoUYletvoqf9U1L99mkj0ItNhmiK+UUP5JLMQauJt9Il7qAbPGQXv9k4n0HCY7bF7V7/zN1yC2cqL34O79mfEGmMEBB+jOUiLMvhMZFgxV1R/CJEABn2WFn0wjzphRKZOFnUS3jTjAHZRmYNoq1zjpt0W+4S0BSFVjkJhk8SZ/QnkAp/bQaty19cdYRno6QACZtbHvOlFbeL51PBcdl4MdttElB9AnMzlWOSc6+j0b8f545lioX2z+IlqI8HQ+LWFgaxPztnt8BTwBd4gatHY0+ypd2kjf8ljqN9Pf1F7qYshtDdrJ/32HglLdv4zX5RSPwY4Wo5hYR+Y/yyBivo5smZ45CWqt0m8x/UtAlEf8Qcf2ZqYJ9K4+S0JOZUdyr0hoBVsCdfYtoP8DrikEnnoo7PxGrs+2/Emjl6QY2yq3lJM//xoUNAHp/9+m+7RzyuheFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnhWcTJ4bnRmY0E0Sm9MNkUwbDJtbTFSK1RYaFlSTjRjK3RoY2NJYlBIS0R3?=
 =?utf-8?B?NkhNZy9ZU3U5dkFDbElUV3k5VS80ZnUvbW5pVGFJaWtWYndpbDhnY0h6NFJ4?=
 =?utf-8?B?RVFsODdYaURyOWk0RmF6elNBbVZzYWdJOTRva016T1RjZmpIUW9GVVZrcjN5?=
 =?utf-8?B?eFhvcHpYTm5ER3NWampidGJZTEY0QVFmejlwZjdRenZOT3hyMnJVNTBBZ0tw?=
 =?utf-8?B?eUR1eVRhOHhNOTZhS3JoVEZPbml2Y0VjYXVWdy9HM0xib0FnR1RjblZWS3Z6?=
 =?utf-8?B?Z3dEeTRNdDMra2psdVAwY0Njd21NekY5bStNSWNiNTg1bi91TFNlL3hPek0z?=
 =?utf-8?B?Qkp3ZVVGSGxPdUViamJST1pWYUhwUnhrcUVjWnhsVHZDeisrWGpCaVoza0l5?=
 =?utf-8?B?UUYrU3MvaVY2UkVVUm5IMVErMGRDMTF6OUl3WWprQVF2Wnd5Uk91UlpoNmk0?=
 =?utf-8?B?UllxRUJRdExsMU10OUQxU3NPdVRKYkRVQXFxSEJ6WENWd2t5VURNOTVQaWhs?=
 =?utf-8?B?NTNVSnhJY3I2djBIaEc3L05GT2MvRWgweGlsNFRSSWJ0dGZnL0NyU3BlZHFB?=
 =?utf-8?B?aHczR2hla2lNaFNVVktWOURoR2RXMEdFOUdLRVdSMXlKVmFvaHl4VW9tMjBZ?=
 =?utf-8?B?UmY2alNtRzB3MVYxVDdmM0t6WDhCSndUeE1KRHFtWm4vQThGeFFNZHk0QmNK?=
 =?utf-8?B?b09FLzA4V2hHTTN6RTRKY0tHeXI5UkFUK3dDTHV6WkFTcGZqWSswY0k3QzhS?=
 =?utf-8?B?L3Nqd3ZtMC85UElhUTBWMzlWNjB1WmovQXNqRWZ0WVFoSG9oK05Yd0pVcG1z?=
 =?utf-8?B?UXUvZmxLK2hFVWZYQ0pVTDZ6NTNza1lUdG01bUExWG9IWGFwNTdlclFYR0Mr?=
 =?utf-8?B?NDZXcllrOTlqVW5NcXRIdTZyVzlLQXFYWCtZeHhHTEQvcWN2TGlPYmZ1cVd3?=
 =?utf-8?B?N09WUndnbUc2V1MwR0FxVytxcUhCY0NiaEJqNDRUSDlaZDdMc1lkSC9qRkwr?=
 =?utf-8?B?L1cxcnZJekdvQnJqNnVlRmYybmhwekFSWGFBVU0vc1IrNG4wTDM2WVovTjEw?=
 =?utf-8?B?RlpqenNKU1drQ2M0WUd1d3B6aHNSSjlwUUVxWGFPNUQ1Ym8yaEFLSEplZWJy?=
 =?utf-8?B?ZmtKZFh0eFVnNXQvK1dYR3h6K1ZydkloVGNHZVNBKzhFT1h1N09NaHNvbGd4?=
 =?utf-8?B?QzBuT0pnWCs1OC9aQXlaTEdZQmFZQytPYzgzYlo1c2NPeWF5cFozVzZndFFl?=
 =?utf-8?B?RTA2a29FU2pCM25SQVFRMDhOemZFSEIveGxOcTBaeWh2aFQraFEwN1ZkQjJM?=
 =?utf-8?B?Ung3Q0N5dWI4MUVGTk5TaElpZnExczRhTFA5bGNuSXdMRDIwOUs1WGh3dkxL?=
 =?utf-8?B?NkFoQnMzdmVFa3J2MUF0UXB4VXRxZmgxa3kwWUFpZ2ZzNGtqSmVEQzFrUlRw?=
 =?utf-8?B?eDhkRWN2dkx6c0lBZ2JNNG9ITS82Zzk5R24xbzEvaFRpNHFhTmVUMnhMdFZV?=
 =?utf-8?B?UitVRlFBeEJwSmVIT2ZNV0plN0VnOWZOWXBXTzlMTnQvcWtqUFJDNFFIS0c4?=
 =?utf-8?B?ZmxraTRRTFE2VmhlZEVuZWZMcHJ6Vkw5RDEzdmhIa1YwNWN0Y2hyblBha0lu?=
 =?utf-8?B?ZUMrUWpuenFsWFhNeFVoUUFPOWtIZmRlSkhkQUNidW4rbHY3bmM2empuU2VW?=
 =?utf-8?B?MHYwOWVBRkRTSXg3VHY2d1c3eC9KdVE2Q05KQktLQ3RZRXBvbVRpUVhUS1Qv?=
 =?utf-8?B?T0xPQnVSTGxHa3BRUWg2SW5GdHl4SnBJM1h0cjRWenRzZE5kQnB6VmVIT3FG?=
 =?utf-8?B?bTR2eXpwVER3NEFlSXIwc1B2Y0gxSFo3dTdhTTZHQXFTbmJJRTRpMFl2M3Z6?=
 =?utf-8?B?QS9hMFVzS0Q5UXFaUklud2lQRkErOExVcTBGNnZoVHl0S2Y1RC9KZmtGRm56?=
 =?utf-8?B?b1MrS2xmbWZuQkh4em1JOTJvYjc0Ui83WGdDYXdzdUNkZ0VsLzcrWHEvZnZ2?=
 =?utf-8?B?amRXZXI5MTNmdlg3dDR6MmMzSVJXc1dRejhMditHeHJGNk5hRWtyM1lqK3ox?=
 =?utf-8?B?T2hGUXpCU2w2cURub3FrLzFobkF0TkpNQ3EzMURYaUJ5Z2RWOUJtWW9UN0ZZ?=
 =?utf-8?Q?oruS2Xx0a3joWDmRPRn0Z2Vdu?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc9e2d3-2f18-434e-0a08-08dc5c8299dd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 12:58:37.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kk4RpoWyI6Vqud8U7wfpAN7KxVci7OTn9eBt88uU4DfzbcBrhwVPoqYub0KS+P8Rce6l8Y1B573IiAwHoMNahQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645

Add bindings for SolidRun boards based on CN9130 SoM.

Three boards are added in total:
- Clearfog Base
- Clearfog Pro
- SolidWAN
The Clearfog boards are identical to the older Armada 388 based boards,
upgraded with a new SoM and SoC.
However the feature set and performance characteristics are different,
therefore compatible strings from armada 388 versions are not included.

SolidWAN uses the same SoM adding a southbridge on the carrier.

Since 2019 there are bindings in-tree for two boards based on cn9130 and
9131. These are extremely verbose by listing cn9132, cn9131, cn9130,
ap807-quad, ap807 for the SoC alone.
CN9130 SoC combines an application processor (ap807) and a
communication processor (cp115) in a single package.

The communication processor (short CP) is also available separately as a
southbridge. It only functions in combination with the CN9130 SoC.
Complete systems adding one or two southbridges are by convention called
CN9131 and CN9132 respectively.
Despite different naming all systems are built around the same SoC.
Therefore marvell,cn9131 and marvell,cn9132 can be omitted. The number
of CPs is part of a board's BoM and can be reflected in the board
compatible string instead.

Existing bindings also describe cn9130 as a specialisation of
ap807-quad. Usually board-level compatibles stop at the SoC without
going into silicon versions or individual dies.
There is no programming model at this layer, and in particular not for
parts of an SoC. Therefore the ap compatibles can also be omitted.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 16d2e132d3d1..74d935ea279c 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -82,4 +82,14 @@ properties:
           - const: marvell,armada-ap807-quad
           - const: marvell,armada-ap807
 
+      - description:
+          SolidRun CN9130 SoM based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9130-clearfog-base
+              - solidrun,cn9130-clearfog-pro
+              - solidrun,cn9131-solidwan
+          - const: solidrun,cn9130-sr-som
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


