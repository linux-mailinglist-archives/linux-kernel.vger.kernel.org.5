Return-Path: <linux-kernel+bounces-131734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBBF898B3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDC01F22394
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CF26E615;
	Thu,  4 Apr 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="UW7DAeKo"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2108.outbound.protection.outlook.com [40.107.20.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B612AAC0;
	Thu,  4 Apr 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244917; cv=fail; b=Ou4MD2Pp6v1uI5ooLVzRstcnW/BoLXf97xSaBkTixh6XiwDSlSwdES13AODMnJQS/bPy3uTTR4SBqTgEnnZj22LTxg1x+VVgnm6O6k0wc/nlidMKOr/CPaoNwKY4neSvvkauH5EphBPFyQSbEbDLasvDboufxPsdLqVD05VpkUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244917; c=relaxed/simple;
	bh=40fllLjP/jj11ZbrFgnli60xB+0ogC6Drbue0p4jfF4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Wh7ZL5hEWfTHlRpmJUE1qTyY64piqUB9fXh2W83AyasSR6iCNl3vJTs73IdQbLhlGAkSoKHEKW8MiqMquvATxyaltw5ISlgh1a/z/ZXMBuzx/DPtfelJhhgg7bEJfdHvz+QVoDgF518yjn6PEmsz5jCnW5jKrrjfjtGTHkJE8CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=UW7DAeKo; arc=fail smtp.client-ip=40.107.20.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaS3g8nTUbX3+rH+GPCN/KCikae03OOIOJwFVms/MmBGrNcN8y5UBeoV0+zh1ElgqGfyPpFgroMTvN4T1PDW7GIlKyySrwhOkcMPNhhbhvfzwiaoarTPru0Y1Vqa7yM7QTUe3Sp1HRRNXJ9nNASx0Bl+sqJUG1+otO6SDoykXxX8Lw00ss0bN+Wz2rQQztcYU6J87xet+eH0u2Buh80HHImHeSnqnchvdPfiz5Bc22EG5UYIcMQj/Z6jq424UDvb0D9UxR60CbNWs0j/NzE5KbwUQep6pX0D2p0yVUsOql+Ud+M8R8DSSWND0/F+WGmq5XRzs9na/fa9fGdkenQcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkM7OTFo3/zM72pcWaz+iDhykOSWkkY2jzb1T04SQ6Q=;
 b=UMVO9JHuH2gzXFmolls2yYFsOnnuSeKdofc6KQZBBbopauahUtloGjHD71a+fm6AGIJeSpJOI/HxV8NBqn+OuBsV2ullQBwsiJZGCSN7u8gc7UWoEs3Sa6yGk19uixLZPBocTAEK/K3MGnIKiW+GGMHGfInpeVwaLy3/zJkxv5Gv4gAZ1V+NUPe0jbHJJ9/30VZkI0awE3/Sja6FV/BxcBUnRtxwd8VPg3VDntxL+xJronapIo6j0ywCmKCj5Ub+elsgnUqW3C+PbD/LLDm1j9d2fjjcy2cBqKxcWzR6UmF80uHE+ZjwbfUrwtQhgBb6zS0dTibY/4RCKfmGL9DvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkM7OTFo3/zM72pcWaz+iDhykOSWkkY2jzb1T04SQ6Q=;
 b=UW7DAeKoOMk8oDVhpjvuMXgI+65dlcH0XQGU4mH/AmjZz3OLZV5xYBLQ5HxBPTy6lGBBn3TvPt7qr9FJlHOdOBhfnHP/nEyyfBf0KvMp+bo2/EH2ULJ5NQq3s81C9b54zcg0r52UfWTogvSqWH1FSHy9zFGHLes7cOfRnjRgfqA=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB7871.eurprd04.prod.outlook.com (2603:10a6:102:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.27; Thu, 4 Apr
 2024 15:35:10 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 15:35:10 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Apr 2024 17:35:06 +0200
Subject: [PATCH v2 2/3] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-cn9130-som-v2-2-3af2229c7d2d@solid-run.com>
References: <20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com>
In-Reply-To: <20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::19) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PA4PR04MB7871:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Gg1IgQqYgr4bd1/btHOZ/VAFk5z1eTbziSui23g3gd4j91Akbyc8o5ncRvif8dtPUg3s7j2Bsnn5z0W7EylfIYrvfuKkDbL0NtDYAkWnf+wQSqCtGgiu1K2YcKNUd2EI0l5VBPX+Pfn7pXkowxqp0vNmvZjMVMLZ9FSacyVVyLOZd/aVSvV3qDQ56+nUzeapFa0efhwN5ig6lbk3Se1RukYCfN0wdBMmt68CFegF9JqyLIN4lfYnajvPRI2wgu8awCk4e8tWEAz3936tqHTPbHRulb6LkUC9NCdFTO6rQkZUrDK5ea7686j4yF0V2xt+SyufjQEIbBDj8z+RuEvXphEA0rKM1RIZ8IWz50N3PCBlCzKethMGb2XgZiME9YVJWSSa2xWwWSUnCun9MbvY7cb9Fw4Pk1fApwODbOjZbRzHIEPZcJkyG/XCFwO0N/qqcMb3HY+ajGz0xWXP8xvuFY/Mq5idnSDdPA8kR0/gHb25IDHFh3UFhvDK+xYrgmyWZeQ06k2/DCr/WVOsllBDxNuaL6VjYQQ8HhnuNcinnIZZFgkdAofzbJSCKDnbSQt58RX/gCgz9a01Nrw2QHZFMevYp+VD+SODEYeolqfZSjRlzHxZPXeAGmRVeRrRAV7PtyE3XzgH4TpDoEkrhsOBePfrZlV5rW3mwvY8fTZKDCttqiDZGE64AQCVsaafB7LQZFdCPaPG9XOb03quaY1CGs0+etvscQH9Mtp/DXNkP0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHpNaENNQm5SVFVDcHVYRm1ZcUl4QjdHTEszcS9KS1FndEJlN0NLMmRxM01P?=
 =?utf-8?B?Z2RYeGxYb0kzM3ZaZmJjSTBhcko2QjlZRmdhTVl3dFJ2ZkNtQWlSV3c4WW9k?=
 =?utf-8?B?VUQ4MXoyYzZ5TTRLR0NlREgxZjh4QkFCVUZ6aHptU3QyRXdPVzgxWDNWemdl?=
 =?utf-8?B?M0h1VmVWYWZDalBXREt1OWxzVk5PeGNOU0ptZWVMUUtQWElwUjdCeFpERTVV?=
 =?utf-8?B?Q0svaWNhOFFwZm8vQWRKcmRiOXNJYm85bis4SHMzL2N2UGx6SGluQ3NLNVdF?=
 =?utf-8?B?ajl4ZXV5RWZGNUFuN1ZrZmh3VHVWSmMzb1pwYXZwVW80MzJ0VndrcDlScDdm?=
 =?utf-8?B?V3QycHFoQ3Z3MFhocnF6L3VManE2Y3BiaG43V2cwUUs4MEQ2SjZSbXRwSUxn?=
 =?utf-8?B?MVBoWWY0dE11a1V0eWpxSTZ3aWsxWU41aHBmeTlUTXBXMFBsd2w1SmNOdzVt?=
 =?utf-8?B?a2UvdVR6QjNYTWIvM3plcDA2b09mbVpqeDN4V2p5RjZubk1tM0VFcXNGazI2?=
 =?utf-8?B?cVhUSFM1bi9kQUVUSzJGRG5Tc0tqZzBGK2w0eFA4RGd0NllBQkk0ejNZdjgx?=
 =?utf-8?B?cncwNVFXS1N3SjZwTlJ3T0R0UmVka2dYVzNOTDloS0NHdVNtbWJWcDNXTm92?=
 =?utf-8?B?bllodFh0UHdKcnpvNVUrS0NuNlVXa240bTBCTUZUMnJFKzRUbUkrbUJBR01X?=
 =?utf-8?B?b0srM05XM2tkVk8yOVpScXloVlpsRmd5MHFWTzNqYXJuUEFab1lHSFNnT3gw?=
 =?utf-8?B?WW1IUmtac1ZuK1FTOEFMVWd1UUdKdWpPM0VUeHpZL0t2QUQwdTNoZENaK29L?=
 =?utf-8?B?eEZSUkxJdHFPVVFNWnIzZDdoZUtPTW9KZG1MTk1FejVVN2J0M1g1V1d6ZWNv?=
 =?utf-8?B?RmVvcUdtQjB2K2owdnZTMmozOUpvV2hWdlRxNFd4bWE0U0ZjajJGMHRWNWl2?=
 =?utf-8?B?UjduWG52S1A0SmkvTFNreWYwQm9hTFoxWFN2K3Q0RWNNalJHT0xWeUVrdVJj?=
 =?utf-8?B?Z3JwNGc3NEw5U01DdzZNTEhtYllRU2VOLzFTY0xJRllpa285WXhIVnU4cUZn?=
 =?utf-8?B?VDZjOWwzSXJpN3k4VGNSVW5MdFNXbXVKWGpjSUJWOG5WVjJGaHE0dkJEdlZN?=
 =?utf-8?B?QlY4UDYxTjVzcVRSZkZGRklGQXRnWi9IUUlBYzh6UXFScDVObFdkTkpGblpq?=
 =?utf-8?B?YzRuZGxaU01oN2JVYlVmS3BkL3g4RzVlV01ueTFEQ2FZUmdjeER3bEprd1h3?=
 =?utf-8?B?NXlyR29CM1hSOVNGZ0txVllnRG5tR1RpNnB6aElGY0xzRUV5MmQyUGZKZUg4?=
 =?utf-8?B?TVFMazR5K1lvbkZQRkpqcFQzSUxsRVBzd3FyRkRPemhKbHlOSVFkRnp2R0l5?=
 =?utf-8?B?UEc3dUExTDFDSFo4Sk83aDZrVUJBVkpmc2lyQzRyeit5RlBkWjBIZExDU1VY?=
 =?utf-8?B?K0l1V0lUQldlNnFUZGFzQi8wRERRUUJ1N3BUWmJ4a3F1VDBYQmV2cGZ4Q2Zy?=
 =?utf-8?B?YnFVL0dYdUdwUlZyVzVycEVnbk5XTm1oRjFoUUs2MnM1bFVLbkJ6aCtJejBr?=
 =?utf-8?B?ZkpoTHJBRWlyNW42YUF4WDFWTWM2ZWJ4T1diQ2dYZnQzeVROUks4NlVDUlhQ?=
 =?utf-8?B?VGhrRkhVRFB1c3JHVStvZ0puTzBFWUVhMDNqRkFwQUJxbHZJR0R3ZXV0eGxT?=
 =?utf-8?B?WFQzNmswSi93L3gydVRuY0JINi9yaTZzOHRCcTMrMUJ2NldReGI0a0dTTUxQ?=
 =?utf-8?B?YVdsb2F6SWtzcUxSUE1OSmZYZTNKTXRod3ZjdWdhKy9QUDU5YTQ0ZUJ5Zkxa?=
 =?utf-8?B?ODJyNDRxNXJPVDZqUEZjTmFPZ1p6bmFUUFloNTY5STVaZ054NzlxSGNteHBR?=
 =?utf-8?B?NXBDVkdGM2JrTzNoN01RWHRGQlV4YU9MM0xjdktPdjJCS2d6Z1ZUMHFLRUh5?=
 =?utf-8?B?cW9Sb0trL1Racld2M3N0Sm94ZnE1VlJnL2pmVlVsR24vSVU2N2tETU5TMjJy?=
 =?utf-8?B?TDBNdXowREI4bzUrcFpKd3IwaWpMc05zTXZuQzhKTm5CM2ZVajRtRTUzR1lV?=
 =?utf-8?B?TjBmVEJvU3J0aWxGWUdMNFFkaE1NdklvRmVBK1dhUE1LbkFFWCt2eXJRUWdN?=
 =?utf-8?Q?u5ekdUPLzam3DsSTGb3j5Itsk?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04d53c4-335d-453d-772b-08dc54bcd014
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:35:10.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItBzapmBeQZRL4h7vdywt3OaxqcY06q39kFE3wIs3PDT/PYoyjA6LL6mgtWUjJZfHFO37wKnsHYt2S/9uRPtYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7871

Add bindings for the SolidRun CN9132 COM-Express Type 7 evaluation board.
The CEX is based on CN9130 SoC and includes two southbridges.

Because CN9132 and 9131 are just names for different designs around the
same SoC, there no soc compatibles beside marvell,cn9130 are needed.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 74d935ea279c..538d91be8857 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -92,4 +92,12 @@ properties:
           - const: solidrun,cn9130-sr-som
           - const: marvell,cn9130
 
+      - description:
+          SolidRun CN9132 COM-Express Type 7 based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9132-clearfog
+          - const: solidrun,cn9132-sr-cex7
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


