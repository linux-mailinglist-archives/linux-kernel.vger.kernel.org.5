Return-Path: <linux-kernel+bounces-144147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87B38A4264
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07A1281809
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46BD5730A;
	Sun, 14 Apr 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KnoLZPR0"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2132.outbound.protection.outlook.com [40.107.249.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60D535B6;
	Sun, 14 Apr 2024 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713099531; cv=fail; b=ltHhL3webCYAL8cfrGWzvkNH63SJvt4MixVZGqMcFpX6fDbxu9X6Z81kp2TEW8cnQwIRyqstebdTxG13+xbAkj2uDVzsmMPYwuMVEvDzhm8gDzht5R1lA7/JrslSRnLCkOzpZRugWBHsbp/WvZyuo1XEBUSpZrpJ4CMPaj4phuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713099531; c=relaxed/simple;
	bh=+BJP095vXhyQ6i925LDaaKBhLcqzOnwuzr4NW5wb+mU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JC05OlmwV+LSz8O4n+WmqoLGewe2IrVfBI/RPfPmeBHnuADTIN1gehHMrs+rIDV4Q5Mz8fQj+e+lzE6IeP4ARmV8gYo5U+XuYeQlQk3hgYU5tWfusip8J6eTooGcagwOM2zi/i/+feE0nrzRVrrN1pyp840j3m5oN5a13d4557g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=KnoLZPR0; arc=fail smtp.client-ip=40.107.249.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOaFMNMHNqxALnP7aRGDQmKbROeSa/lBmLlhpgANig5vUAWJ+BqTzyI/+uQThEkDY6pBO+TWQjEuRkGIROofLDvwHZ8hYNanG7dh/DWe6sb/UxD7ZGWPB9ERMbFCYR0WySUZHqfl88etk6gQmoUJaMc7EVQLN2hvEhIjrTG6sz9h/WvqKAiBSZVCK9YXZVEhQZhvv6vGQFO/AP9X73RKFtUIggGIo6TaErReJiXtEQn92Zm2LhPuJ2LQLtm5ZWGIZoGl3/h4R9p3m5GCFNQYdMebgTl/jujMK52c9QgGJv54DZ70O0Q+mvdNnf7g90BYKCjPYpO5sXKMFHJ2bnTmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiVIvpFPy/3xeNoorbnFw3apwKw/mJ+WH9lzR/t45PM=;
 b=RuNQVUkUTOv8v2Qjvhe+7ZjxXRVWKQq4ykz4h3E7YtYst8K3HfjDiVrwdCe76hu0k+UipLjo1tKAq6fmhFWhhDqXno2s4RFfAVgMH7IAm/8iIbEDL/vCDoxl3qwm/8pwuonCE4fLFz6fOyd4t0hSR8O2GP8PLEnd0CReabXpemPTConthi6URQDsb2iUC3SGzF19voyiuLoQ2KgTHzlLVtfS1zAlqWIm4OJxITgtnQgFF2EepnWOs+VFNTXCUpRzKdKGu2js561npMlVBSjyTpda1RGC39P4J86mkQDiY6hps4hwIYtlo1Jef3XlxYIuobZn3rNpXcfQqjDGMtCWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiVIvpFPy/3xeNoorbnFw3apwKw/mJ+WH9lzR/t45PM=;
 b=KnoLZPR0OQIydfSSu+cmmYFk/2VUFbZMez3/mW4rUrQH4TGGBptWxGXoeNFNuTCGcmfywJ/OPMT0Jx0hwaVsqFgl2PBV4cujSEmnIa8ibWMJN0GaquiaXByY6bMobIJ5btRRGnfSr7TYdwowJOD2pnvWnv32U9i+Dq9odA1INhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Sun, 14 Apr
 2024 12:58:39 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 12:58:39 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 14 Apr 2024 14:58:35 +0200
Subject: [PATCH v3 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-cn9130-som-v3-4-350a67d44e0a@solid-run.com>
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
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 118fa570-3330-4b86-3481-08dc5c829aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LflJbiVjE6ePK0q5SoNpVNJgRUvfgIQLxoUs+gWRt3sJhouFG5TRx+5vLPR7PzD4c46iSEBjLDtZTYzt+YkmnyBEZAlneNVyl3qh3hBCbhU7I23QBfj0YVD+JEJZGmsBt85qVU7A60YEy7HRyqB4XCM+13t8XT1Ga2XbIN47eP28vOW4OFCtNZXVB9dOVJM0iTQFLejnWWnP/TFp48h3cN8DYXRDwVvmrnsCQ1uAJG3zlRbUyK1+KefpbspfvSQaNjXMaTgmAFITg544/wgmuCY2gHMpWeEJ/aDthqJ++KRhDBTZg0qSaE0qAh4FAnJbW7vmFLAF9TsBph9mUhfP/x12Q0R7e7T70kTiwieCCVN9NHuEJ3qks8QO3vQf3oYUQ0m2iQi2sonimuen5B15n3qCd8UfIeQMEIaoPlJoLhdEGRnuGPWcOq3XaurmtffSwRfK9MkankwhmZx5W9BDB0BLSiD1J53rK8jRZ57PfDWHkexiPz9d9E4z/g6eeHZI1uBK/Z6yIgOVnL2BqWFGv0rVpKgXBySsPmlgLsibC9j2RygjEJIQ5EJ1v/cYFz62QdjzhoHvTaSeT2yCZWUhecE4JbPjp17UZd17vi7ObiR+TKF1ZiVmhLeTTK/lwGFr2zAhLGGdatPhekFAiqH9XuAv/47hsrFDk4pCEb5X2DF4l2x4iBu6ppshUwbThiFVhkncSjpfWqgnNdblpMk40xD9DXEufZkiJWqf71PYNko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDRKWW9JcnFJSjlLU1NLNUw5MEVaeFdMeXVsSy9oam9vZURPdHBVbmhPTWJh?=
 =?utf-8?B?T01kWVB3NVh5UVN2SlFtU2lhUWFuUEJvMk02eThrcW9rQlJYU2ZrRnBoWG1W?=
 =?utf-8?B?VEhSMlNxdTRWQityY0poY0MxV09HK01BRUV4bUx2cjJ6UXdaK3d1V0s0a1Jv?=
 =?utf-8?B?eWtyRzVoOWVDTUxWWTM3UVpxbGRScFVVWER0aFlvZi9rZFVRUDZWSDZ0Y0hI?=
 =?utf-8?B?QjRLTFlWWWRGS1g0WjJPdFBtRXFONCtGS1FSUitJMkIvK3B0T2RxenlieTdG?=
 =?utf-8?B?ZlhjMEh6eE1zNHMvZGVycXQxb0VLbnVtaENRaG1FV0pOckg3dE1uS0NGVXlR?=
 =?utf-8?B?dm5sekhCOWFoYVpiTHc5clRIV1plNklTek13ZEowUktjQWRuQ3prMk5wQnZZ?=
 =?utf-8?B?eFNBRW9hZThIb3lVNEZJMnhiNGtBNFRnWmozWU5qWTZoMFI0ekNSVm1PWUNO?=
 =?utf-8?B?bjJjV2RJNXFmNmJpRHgrcTlkNitNUjc3WTBUMGhML1BtZk90aXVXaWhrS2lo?=
 =?utf-8?B?UTY4bDBkRFNZQm5QeTQyUkJyQ1ozL1VsV0NtN0kyVWRqSXlkc21nTkVuTnNV?=
 =?utf-8?B?eDA1Z1FwRC9rU0FxQmpHOHdGcE5DWkVXblRXQjBrWnhHTGJHV0pyRTA4T0NC?=
 =?utf-8?B?enltd2NwM0VIVm9lL1NEWTRiNy9JSWJ4bmNCWlRxM21wclI0ekc2VXh0Y210?=
 =?utf-8?B?UHc5SEhvaldiTC9wSUtTWlA0RTNZRS9UZkE3dW1WNm5mRFFvaXNNWnE5cVFZ?=
 =?utf-8?B?MWVQbGxpZlkvNUlpa25VNHpoSjRoQUZEV25oMWZtRFFWTW5kVDBXZ2ROY2Vk?=
 =?utf-8?B?T3llSHl1MUViUEFYM1BadVZmR1dQWm5seHIwTHMxZE8zWm1OQ3h4azFReTYr?=
 =?utf-8?B?Tmc2c3laZFFuTGc5Qy8xVGhrWktxT2dxOVNlRFB3TlJqVk5rdVJhNUVDWU9W?=
 =?utf-8?B?cll3dnl1WnFlaVlaZWppTDRkWTBxd1dGUldQd2hsdXpHNHRkYUZXcTh2TWhG?=
 =?utf-8?B?TzB4dFNFTVFrSGZFZTY2cHlIc3NlMml2cGYyR2dLRzlhckhrUWE4dDZZY2xz?=
 =?utf-8?B?aURwQ1M2ZkJKZjdFV3lTTjhEdVBXWnZDTERUZmlMMHdSNWtyU0RhaThPbm4w?=
 =?utf-8?B?aE9GZmI1Z2FnTCtGZnNWVytwU2Q5ZDBybTJJK1kza1ZvUnpBRGtYMGlkMW1B?=
 =?utf-8?B?Umx1TU00eXYzQUFUQWpZQ0cwVGhKTnQ1ODIrcWlIK2pEcU80ZEUwai9Ud1ln?=
 =?utf-8?B?RmJTUXdJelpiaitKMXZzR3MyYkhPMVhudjBEQ2tLRzlrbUNvVkpiMWdXcEJF?=
 =?utf-8?B?MWovYTB3dXVrdlNneFpNbWtGSW9tVXlGcWtRQ3ZKbTVHNzY1dGpuc3MvVTNa?=
 =?utf-8?B?Z1RLOUIva0dGeUxvZm1Dand3VjJzU1FXQ2N5WTYrcWhIcVVIcjBnOVE4TUZv?=
 =?utf-8?B?SU1PSG5nNGY0UmVENmlMeDFkZ0J5VzFVTFlHMldMN0RJTkQ0KzhUVmltdHRW?=
 =?utf-8?B?MkkvU2ZxQU9ySndWSlRVdFlsR2ltRytLT0QrWmVaOHFJSEtHb2djMkZpRy9k?=
 =?utf-8?B?OVRsVGd5bEV0dVIwdFBqT2Rkc2w3ODZwQTJDZjJsLzNZMmdTU1J4cEZPb0lB?=
 =?utf-8?B?TXUxWldLWWRhdlY1dmJEMWR0NXZCRW93Q0VlSk82VzNCa0JiczBIc29lK1NL?=
 =?utf-8?B?Q1M0N0UvZTVvOUdXOTZFWVF2UFFEcEFaV0U3OFloME9mWEhBZ1N4ZUZneVNT?=
 =?utf-8?B?Z3gvMmVZd3JvK1YxYzJvaDhseE43Ti93QWRKZElDd2oyTkZkREZPby95ckVS?=
 =?utf-8?B?SW5LWmY0cHQxVitscnBFZWQ2akNnVUx5bHNnYW50N1ZUWU1kVElqWjZTK3F2?=
 =?utf-8?B?SHk4ekRCdExKZk11T0xTaVdaS2FWZDZWT1VFYy9XY25ERDlsZTB5eURKZWUz?=
 =?utf-8?B?TDk5SDdIWE9CcjUyQytaajVXWFluVGtGVXJ0TS93L1BTWUtXZGNnazVXaHd5?=
 =?utf-8?B?YzQrUFNzNHd5L09CQzFpSFdLUkNVaWVYbEY3K21JR0dEUWdyYTNwVkNPQ0Jq?=
 =?utf-8?B?OSt5dmI1YzRUaDBFT0N6a3hXTlQzT21zNTFNYnhBWk5uOHF2bHZzOTUySmxj?=
 =?utf-8?Q?GLoHKnnoifZaAtgSQB0+SUSJm?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118fa570-3330-4b86-3481-08dc5c829aa8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 12:58:39.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jnI7G9VqvceaQLRwsBonv/lHanf69vFquWdah0yf28W2TP3JFWN0i9I7lnJ3+B8ZUkkB72DetKD6tfflQQUDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645

Add description for the SolidRun CN9131 SolidWAN, based on CN9130 SoM
with an extra communication  processor on the carrier board.

This board differentiates itself from CN9130 Clearfog by providing
additional SoC native network interfaces and pci buses:
2x 10Gbps SFP+
4x 1Gbps RJ45
1x miniPCI-E
1x m.2 b-key with sata, usb-2.0 and usb-3.0
1x m.2 m-key with pcie and usb-2.0
1x m.2 b-key with pcie, usb-2.0, usb-3.0 and 2x sim slots
1x mpcie with pcie only
2x type-a usb-2.0/3.0

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 653 +++++++++++++++++++++
 2 files changed, 654 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 019f2251d696..16f9d7156d9f 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -30,3 +30,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9131-cf-solidwan.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
new file mode 100644
index 000000000000..ba7dd55abfb4
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
@@ -0,0 +1,653 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9130 Clearfog Base.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "cn9130.dtsi"
+#include "cn9130-sr-som.dtsi"
+
+/*
+ * Instantiate the external CP115
+ */
+
+#define CP11X_NAME		cp1
+#define CP11X_BASE		f4000000
+#define CP11X_PCIEx_MEM_BASE(iface) (0xe2000000 + (iface * 0x1000000))
+#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
+#define CP11X_PCIE0_BASE	f4600000
+#define CP11X_PCIE1_BASE	f4620000
+#define CP11X_PCIE2_BASE	f4640000
+
+#include "armada-cp115.dtsi"
+
+#undef CP11X_NAME
+#undef CP11X_BASE
+#undef CP11X_PCIEx_MEM_BASE
+#undef CP11X_PCIEx_MEM_SIZE
+#undef CP11X_PCIE0_BASE
+#undef CP11X_PCIE1_BASE
+#undef CP11X_PCIE2_BASE
+
+/ {
+	model = "SolidRun CN9131 SolidWAN";
+	compatible = "solidrun,cn9131-solidwan",
+		     "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	aliases {
+		ethernet0 = &cp1_eth1;
+		ethernet1 = &cp1_eth2;
+		ethernet2 = &cp0_eth1;
+		ethernet3 = &cp0_eth2;
+		ethernet4 = &cp0_eth0;
+		ethernet5 = &cp1_eth0;
+		gpio0 = &ap_gpio;
+		gpio1 = &cp0_gpio1;
+		gpio2 = &cp0_gpio2;
+		gpio3 = &cp1_gpio1;
+		gpio4 = &cp1_gpio2;
+		gpio5 = &expander0;
+		i2c0 = &cp0_i2c0;
+		i2c1 = &cp0_i2c1;
+		i2c2 = &cp1_i2c1;
+		mmc0 = &ap_sdhci0;
+		mmc1 = &cp0_sdhci0;
+		rtc0 = &cp0_rtc;
+		rtc1 = &carrier_rtc;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_led_pins &cp1_led_pins>;
+
+		/* for sfp-1 (J42) */
+		led-sfp1-activity {
+			label = "sfp1";
+			gpios = <&cp0_gpio1 7 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		/* for sfp-1 (J42) */
+		led-sfp1-link {
+			label = "sfp1";
+			gpios = <&cp0_gpio1 4 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+		};
+
+		/* (J28) */
+		led-sfp0-activity {
+			label = "sfp0";
+			gpios = <&cp1_gpio2 22 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		/* (J28) */
+		led-sfp0-link {
+			label = "sfp0";
+			gpios = <&cp1_gpio2 23 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+		};
+	};
+
+	/* Type-A port on J53 */
+	reg_usb_a_vbus0: regulator-usb-a-vbus0 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&cp0_reg_usb_a_vbus0_pins>;
+		pinctrl-names = "default";
+		regulator-name = "vbus0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-oc-protection-microamp = <1000000>;
+		gpio = <&cp0_gpio1 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_usb_a_vbus1: regulator-usb-a-vbus1 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&cp0_reg_usb_a_vbus1_pins>;
+		pinctrl-names = "default";
+		regulator-name = "vbus1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-oc-protection-microamp = <1000000>;
+		gpio = <&cp0_gpio1 28 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	sfp0: sfp-0 {
+		compatible = "sff,sfp";
+		pinctrl-0 = <&cp0_sfp0_pins>;
+		pinctrl-names = "default";
+		i2c-bus = <&cp0_i2c1>;
+		los-gpio = <&cp0_gpio2 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp0_gpio2 1 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp0_gpio1 31 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp1: sfp-1 {
+		compatible = "sff,sfp";
+		pinctrl-0 = <&cp1_sfp1_pins>;
+		pinctrl-names = "default";
+		i2c-bus = <&cp1_i2c1>;
+		los-gpio = <&cp1_gpio2 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp1_gpio2 18 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp1_gpio2 1 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp1_gpio2 17 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+/* SRDS #2 - SFP+ 10GE */
+&cp0_eth0 {
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+	phys = <&cp0_comphy2 0>;
+	sfp = <&sfp0>;
+	status = "okay";
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp0_eth1 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	/* Without mdio phy access rely on sgmii auto-negotiation. */
+	phys = <&cp0_comphy3 1>;
+	status = "okay";
+};
+
+/* SRDS #1 - SGMII */
+&cp0_eth2 {
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp0_phy1>;
+	phys = <&cp0_comphy1 2>;
+};
+
+&cp0_gpio1 {
+	pcie0-0-w-disable-hog {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "pcie0.0-w-disable";
+	};
+
+	/* J34 */
+	m2-full-card-power-off-hog {
+		gpio-hog;
+		gpios = <8 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+};
+
+&cp0_i2c0 {
+	/* assembly option */
+	fan-controller@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+	};
+
+	expander0: gpio@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+
+		usb-a-vbus0-ilimit-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "vbus0-ilimit";
+		};
+
+		/* duplicate connection, controlled by soc gpio */
+		usb-vbus0-enable-hog {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "vbus0-enable";
+		};
+
+		usb-a-vbus1-ilimit-hog {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "vbus1-ilimit";
+		};
+
+		/* duplicate connection, controlled by soc gpio */
+		usb-vbus1-enable-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "vbus1-enable";
+		};
+	};
+
+	carrier_eeprom: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <8>;
+	};
+
+	/* usb-hub@60 */
+
+	/* assembly option */
+	carrier_rtc: rtc@68 {
+		compatible = "st,m41t83";
+		reg = <0x68>;
+		pinctrl-0 = <&cp1_rtc_pins>;
+		pinctrl-names = "default";
+		interrupt-parent = <&cp1_gpio1>;
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&cp1_gpio1 13 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&cp0_i2c1 {
+	/*
+	 * Routed to SFP.
+	 * Limit to 100kHz for compatibility with SFP modules,
+	 * featuring AT24C01A/02/04 at addresses 0x50/0x51.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&cp0_mdio {
+	/*
+	 * SoM + Carrier each have a PHY at address 0.
+	 * Remove the SoM phy node, and skip adding the carrier node.
+	 * SGMII Auto-Negotation is enabled by bootloader for
+	 * autonomous operation without mdio control.
+	 */
+	/delete-node/ ethernet-phy@0;
+
+	/* U17016 */
+	cp0_phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+/* SRDS #0 - miniPCIe */
+&cp0_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy0 0>;
+	status = "okay";
+};
+
+/* SRDS #5 - M.2 B-Key (J34) */
+&cp0_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	pinctrl-0 = <&cp0_m2_0_shutdown_pins &cp0_mpcie_rfkill_pins>;
+	pinctrl-names = "default";
+
+	cp0_i2c1_pins: cp0-i2c1-pins {
+		marvell,pins = "mpp35", "mpp36";
+		marvell,function = "i2c1";
+	};
+
+	cp0_led_pins: cp0-led-pins {
+		marvell,pins = "mpp4", "mpp7";
+		marvell,function = "gpio";
+	};
+
+	cp0_m2_0_shutdown_pins: cp0-m2-0-shutdown-pins {
+		marvell,pins = "mpp8";
+		marvell,function = "gpio";
+	};
+
+	cp0_mmc0_pins: cp0-mmc0-pins {
+		marvell,pins = "mpp43", "mpp56", "mpp57", "mpp58",
+			       "mpp59", "mpp60", "mpp61";
+		marvell,function = "sdio";
+	};
+
+	cp0_mpcie_rfkill_pins: cp0-mpcie-rfkill-pins {
+		marvell,pins = "mpp6";
+		marvell,function = "gpio";
+	};
+
+	cp0_reg_usb_a_vbus0_pins: cp0-reg-usb-a-vbus0-pins {
+		marvell,pins = "mpp27";
+		marvell,function = "gpio";
+	};
+
+	cp0_reg_usb_a_vbus1_pins: cp0-reg-usb-a-vbus1-pins {
+		marvell,pins = "mpp28";
+		marvell,function = "gpio";
+	};
+
+	cp0_sfp0_pins: cp0-sfp0-pins {
+		marvell,pins = "mpp31", "mpp32", "mpp33", "mpp34";
+		marvell,function = "gpio";
+	};
+
+	cp0_spi1_cs1_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
+};
+
+/* microSD */
+&cp0_sdhci0 {
+	pinctrl-0 = <&cp0_mmc0_pins>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&cp0_spi1 {
+	/* add pin for chip-select 1 */
+	pinctrl-0 = <&cp0_spi1_pins &cp0_spi1_cs1_pins>;
+
+	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+/*
+ * USB-2.0 Host to USB-Hub
+ */
+&cp0_usb3_0 {
+	phys = <&cp0_utmi0>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/*
+ * SRDS #4 - USB 3.0 Host to USB-Hub
+ */
+&cp0_usb3_1 {
+	phys = <&cp0_comphy4 1>;
+	phy-names = "comphy";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+&cp0_utmi1 {
+	status = "disabled";
+};
+
+&cp1_ethernet {
+	status = "okay";
+};
+
+/* SRDS #4 - SFP+ 10GE */
+&cp1_eth0 {
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+	phys = <&cp1_comphy4 0>;
+	sfp = <&sfp1>;
+	status = "okay";
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp1_eth1 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp1_phy0>;
+	phys = <&cp0_comphy3 1>;
+	status = "okay";
+};
+
+/* SRDS #5 - SGMII 1GE */
+&cp1_eth2 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp1_phy1>;
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+};
+
+&cp1_gpio1 {
+	status = "okay";
+
+	/* J30 */
+	m2-full-card-power-off-hog-0 {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+
+	/* J44 */
+	m2-full-card-power-off-hog-1 {
+		gpio-hog;
+		gpios = <30 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+};
+
+&cp1_gpio2 {
+	status = "okay";
+};
+
+&cp1_i2c1 {
+	/*
+	 * Routed to SFP.
+	 * Limit to 100kHz for compatibility with SFP modules,
+	 * featuring AT24C01A/02/04 at addresses 0x50/0x51.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp1_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&cp1_mdio {
+	pinctrl-0 = <&cp1_mdio_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	cp1_phy0: ethernet-phy@0 {
+		reg = <0>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+
+	cp1_phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+/* SRDS #0 - M.2 (J30) */
+&cp1_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp1_comphy0 0>;
+	status = "okay";
+};
+
+&cp1_rtc {
+	status = "disabled";
+};
+
+/* SRDS #1 - SATA on M.2 (J44) */
+&cp1_sata0 {
+	phys = <&cp1_comphy1 0>;
+	status = "okay";
+
+	/* only port 0 is available */
+	/delete-node/ sata-port@1;
+};
+
+&cp1_syscon0 {
+	cp1_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+		pinctrl-0 = <&cp1_m2_1_shutdown_pins &cp1_m2_2_shutdown_pins>;
+		pinctrl-names = "default";
+
+		cp1_i2c1_pins: cp0-i2c1-pins {
+			marvell,pins = "mpp35", "mpp36";
+			marvell,function = "i2c1";
+		};
+
+		cp1_led_pins: cp1-led-pins {
+			marvell,pins = "mpp54", "mpp55";
+			marvell,function = "gpio";
+		};
+
+		cp1_m2_1_shutdown_pins: cp1-m2-1-shutdown-pins {
+			marvell,pins = "mpp29";
+			marvell,function = "gpio";
+		};
+
+		cp1_m2_2_shutdown_pins: cp1-m2-2-shutdown-pins {
+			marvell,pins = "mpp30";
+			marvell,function = "gpio";
+		};
+
+		cp1_mdio_pins: cp1-mdio-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "ge";
+		};
+
+		cp1_rtc_pins: cp1-rtc-pins {
+			marvell,pins = "mpp12", "mpp13";
+			marvell,function = "gpio";
+		};
+
+		cp1_sfp1_pins: cp1-sfp1-pins {
+			marvell,pins = "mpp33", "mpp34", "mpp49", "mpp50";
+			marvell,function = "gpio";
+		};
+	};
+};
+
+/*
+ * SRDS #2 - USB-3.0 Host to M.2 (J44)
+ * USB-2.0 Host to M.2 (J30)
+ */
+&cp1_usb3_0 {
+	phys = <&cp1_comphy2 0>, <&cp1_utmi0>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/*
+ * USB-2.0 Host to M.2 (J44)
+ */
+&cp1_usb3_1 {
+	phys = <&cp1_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp1_utmi {
+	status = "okay";
+};

-- 
2.35.3


