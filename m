Return-Path: <linux-kernel+bounces-55073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8882E84B747
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61BB1C258F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D57133413;
	Tue,  6 Feb 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="Jx8FC6Jk"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2132.outbound.protection.outlook.com [40.107.13.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0331F1332A8;
	Tue,  6 Feb 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227995; cv=fail; b=BpwPD+cXFButVm+WDSRioWtyMTsm0MVa6ttJnRkduBW+ayECmCdSuhycdZCfmzkA0PihHlaPSaNzBD6lA5n0lMbEDYtaCP96X9XtQFb0y1WCb9HUOduAEsCOWomrs0WIhPWlZmBQ3rEvci7cHHi6wCX0ut84ge01mSrQtrBzXeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227995; c=relaxed/simple;
	bh=P+pRhh18QK3BNTzJ/6eD6eokmpO/XHx3bEHFgHsEn2w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tJdcNsz/+kMndrn+QOAWWDV4KcKCOroZuViROgxNgRZ3Aj6tIdIsnycNLNJuKFbaQq4meOSyjQ6Rz9ylPsDfFgHvTk8RJ68Al8OOTFhnVeZsoL5qCQ5WUopRdlOYIeIDPAp70H6zoRCWH5XZvIeqDNY+Z15NIBM0+7ev0bGsBVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=Jx8FC6Jk; arc=fail smtp.client-ip=40.107.13.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ai1oQbRX/VUnXKscfA8HPVrbKz0oQX9ONK+dM8cRy3XIq23NsW3yH+KQXh1HAFLaTACpxDW7aGBj1O7Z8MzFGeIAi9ZUUl48XBr7FEAMWAOntJ/IyeJ2aYiO2f3UWa4Mm4xQhnvLisddRcziWuUaLgb04zOJZGCTaajMLHAu0DG+pqb/XgpSZostvW+Yrhe+tArYnDvjb9nkzRzy4QbVkFWZ2RldmgOjipzkRo9A6k0RXwBd/ze/K+PplQlCpz1htpMsRfotVNC6EOtkV3RqwbsIzi9GBfM8XfTLvpjXPTpDnrJ4PCR6gT3jQ0aqw6e0q8WkXWyrXBR9yjntTU6mqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDxIaRZ7Ensmyd7vx7fG5DcGCLnp9dflFDxzCOd3Nlc=;
 b=IXOoGo1yqHDuZgo0WdZbdeBKlhPSeym8kPZCKFv0kjGuiq2uo1+Y1dZ1aW2MJwUOkvCS0VHP7Yv5Nd11CTD1Lnn8/8+qEP/Fv2o7ig4PP8NA1eE1Dj1qBcwXQqoF61cbSZmbd/6Rwl7KaEHmS9PdqmlibHgF4L46SHkyqBCOtVWHxm8M8JpxePJ+eGPxsDRMqBUqaASNHgfXpAGvAzCv9QYPaYM1rpIoljRaXIhTNwbpxc+6e5l58Mp54xJ1rIxVgRsOk1HT4uG3t3/ADgEzHEJ6SIH5jechv1YEX/RSO7Nx/zUyNywZSjaItyZZKxKVYi3lQzi1C+IbqGZnWZlGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDxIaRZ7Ensmyd7vx7fG5DcGCLnp9dflFDxzCOd3Nlc=;
 b=Jx8FC6JkYRa8ra8kIbmIClfexR8orpjw82L6KssHDkS8VqHrmGcHP///VnlBBtFF0QA7bvi/gNcqYDPoubj0C8IVjUEGW1GbbINH/Qtbyub+jecmXsZPChxENLOM8mxJTV+4SGfCZsnVKwlyqWi63I0P/wZXl4OAlK0Ud2WVCi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB6330.eurprd08.prod.outlook.com (2603:10a6:10:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:59:41 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:59:40 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Tue, 06 Feb 2024 14:59:34 +0100
Subject: [PATCH v3 6/7] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-onboard_xvf3500-v3-6-f85b04116688@wolfvision.net>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
In-Reply-To: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707227975; l=2060;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=P+pRhh18QK3BNTzJ/6eD6eokmpO/XHx3bEHFgHsEn2w=;
 b=ej2hYt/TrY9j5jwk/mH8mw4C8NG2n/tCPflsCLQ193/BHGdQ+bkVaIgOlHNJDCDjK85QAlK/b
 2q+YBthLcnZDPA6pjNY9UHc/fsSqsqeIAKE+vGIUbmknl2n/X+HUp0j
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: FR5P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::8) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: f886cddf-ba2b-4d68-46dc-08dc271bdd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SKMxH5UXokjvUDkdNHDtAKVkAvzbbaiEfLJ3I0qEPhUWYSRbMpmTkUxYZFjph1JqWZDM93dqMalzQn2FCysv0vPokNZ43+x9p7bk0lKwtw0xTwcuLUq1nA2YfVHjGs2/g0/jEYRLfbRYrAA83qWWh3CayHLn6RrzNg+c9Xf+qUsGo/T18CV2582KS+3VCrpsHUkVFN9aHeYx09jZm9BEIjesYsK4oZXkuWVExzta+8zDBiZMiXMLsYTOk2HA0n8rx9OGyb8vmr8MTbj0UsTCwTM567P+wpiIQL+LGzYZiDpogrlQYDRO5d2KZd1oBU2Ftc57DgaDbzLeY8yHr7r2TkH4wFk9tzvFV8nC9QqGF01MJZT2MNqiomCAfBD9H/nmyxT9vCgTKr/bkUl1cPceU4WaC/rTPAcK7F0T3WIweScUXHvEl/XYjRaturZyaTLDHRk9CMOrjK9m5It9NdDbNKgZK7qBDTbPqhD8/YlIqHeM38AJxwEeJANM4ldRzGkN/kVH11t+jGAGIf5lNZCUPLTZof7GEtl1FIS8uVEM+O55fPPdKiCcejEAWKDLfdtgQmRrWFxNfNnfDX1S5UmQwuLP0qXAKZ5eif/NxQuTKRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(44832011)(26005)(2616005)(6486002)(966005)(107886003)(86362001)(6506007)(6666004)(478600001)(6512007)(52116002)(36756003)(316002)(38350700005)(41300700001)(66946007)(66556008)(66476007)(110136005)(8676002)(4326008)(2906002)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2duemxUTUZnOHlqcU5HRmNFQVU3dk4ySWZRRDFRK0NzY2tNWGtoK1EwQUY5?=
 =?utf-8?B?UFhZTUVTM1JCcUZPdnUySnlXVUZFL1pHY1JnbmJab0NIclZTRTc1bHhvOFlG?=
 =?utf-8?B?SHZFWEhWazhGMUdQTDExZVpMR3A3U2J1YUc2U2svN0ZNWCtDYUE2aWtqZTRH?=
 =?utf-8?B?cnFVbDRCQnFENHBtYVF2bnRscG4vclRRQ05iaklrZUxrVjhsMkZONFFaL295?=
 =?utf-8?B?d25rMHlxVVM4QjJId3VmNFJ2SHgyWnBFMjRJeW1NWUVjc29icEtQcnR6K1k2?=
 =?utf-8?B?WkVCRU84R2xsQnBUNDYvZHpMYVE3MXk4YTkwUkQxZUdmYm4wMUR6NlY4TGZl?=
 =?utf-8?B?ckxuREhKcG5VSjZmY1UvaWk2bmpkVXNqbElHYzZUYW95UzVWZWhSUjVzYUlu?=
 =?utf-8?B?UVhsVmNEUHg2eE5maWZuQWZheDU3Mzl3S1ZOb2pIeWJvZDVLRWwrelFYODlC?=
 =?utf-8?B?TENhY25JUmJYNDVMeDFHeklCM3VnN1FLaUhvNHUyOHNJc2RrTUdKRDlyV1g2?=
 =?utf-8?B?bDFkc2RQSkZVWW03ZVBSczIrbXQxbk1SQ2MvNFpKZFFuY1dXeVA5NmIxeCtD?=
 =?utf-8?B?U0RpWWNNbjMvOHVEeXJFQXNDdHYxWW5GL25OOUZGS2U5YUxZTW11QVZUejZq?=
 =?utf-8?B?bXk4cC8yNk45ZWVUeWZmWDZaNW41dWd5Yi9LbklzK2tKbjRXZXlnNWora0t4?=
 =?utf-8?B?c0xnM2dPUVBOelZYdTNIK0ZwNXE5TEtya2dXLzFBcEh6VUVFdnIxQUNxQUhh?=
 =?utf-8?B?Q2FISHlSMVhNM3l0MTBYNStQcnNrSFluMmFBVGFMejZIQjBsYlkzdS9hZGpx?=
 =?utf-8?B?VXcvL0JzL3lpTkZYK2krdnh6SExiWEFFdUkvR2k1bjE3V2x4N3o0cmltYkll?=
 =?utf-8?B?dWdvMklITy9XLyt0WXRkNjMzTlNKaCtoZXRxZ2dKVXR3RWlEYWh6VnBIME9n?=
 =?utf-8?B?alQ0d2JzZTdhMXQ2VmV4bUljSmpOY0c4aDZ3ZXgyMGhGVWtzNjhubzRJU1BQ?=
 =?utf-8?B?TTc2V3VjNGN0M3MvYzNkWFhtTGFVa0pIOGxnTXphSmdLWVc5YVZNbWhqcU5k?=
 =?utf-8?B?eUlQdmlBdGdiS0pIb0FJRzMyZ015NmVVQ3NkbEplVFN3WVBCTXV5V29vMmNu?=
 =?utf-8?B?QUJzVHIyREV6TVlWd3ZYR293U3NvVTVSRG1nRXZ6R0hPdFBQeVFGQ1p6ZUMv?=
 =?utf-8?B?NUVuWDhUcmY3eEdlYUh4dytqZHREQ1F2Zy9uT3ZnRUtrZ0MzOElOeTZXRHRs?=
 =?utf-8?B?NFpjTXhtNFVTcTdFc1VPRUhsR05Jb21iQ1RraGlrbHJFeGZPSFNPampvem1k?=
 =?utf-8?B?SkszN3loQUNsMmhHcWpvcEtuQnYzZGp4b1N4VTVHMkQ0TlkxeG5DVmc4K09M?=
 =?utf-8?B?U2s4TkFjWkN2ZENzc1g2Mlk2cDV2M3pLNXFVdXNGeStWYUpPWTlEZmFHRWRY?=
 =?utf-8?B?VVhQYlozY09mdkV2akpORnlpR2h1MUZPbWxZWFhNSFZTTlpxMU0wamV2aGww?=
 =?utf-8?B?bllTVS9YVjhQbU55VmpjVFR3WUJ0TUVEV3JDeEFaTDdScXprSUJuMEtKZTgw?=
 =?utf-8?B?V1RYeGNjNWl3T3M5SW1rekVpdDhvK1RGa1VrMVVRUjRJODZ4YVFLTFUwekZU?=
 =?utf-8?B?NklwQ3NoNnJJTU5zcmJsL2J0WERGeEpSMGIrallOekQ4Zld6NGd4cEVPc0tT?=
 =?utf-8?B?VnJPWmpVNWJ0VXZINzNDSGpVbjFOeHVTRGhmbEFKeVVzTTJaZ3NMMTR0ZGJV?=
 =?utf-8?B?SmY1VHloVG5IWTNva1lTMmdIYVdBc1lxRFBYUDk2cU1vaVNaYStmZ0kyeHVx?=
 =?utf-8?B?ZGt1YStDdmFNWHVRVzgwQVl3QXNoZWFocnBlNk54dXdYUkM0OUIxc2R6cFNm?=
 =?utf-8?B?aHg1TWJQYU4vbE5SdWJaVTJ4V1pWenJVUjIyb2Rlbk5aZmRNVzVqUUs5dlNK?=
 =?utf-8?B?RXhmbXZsTnAyS3lyMHFTc2MzTXBGODVSM0sxMkRPV2hYVXBCK0d5YU9EV0RK?=
 =?utf-8?B?WEVkdlVoT0N3aE5qRVRjZzduQWhYNytuNHlIWXZHSUdtZ3VsMjVnT2RJV1dn?=
 =?utf-8?B?aThmc2VUdHBJbGxpQ2s5eVozUmVGb1B6Umpyck1WeENucVNPYysybXViR0d0?=
 =?utf-8?B?d1lsV3BUK0FwZ3FNUmdXUytNQnkrQ0ZvNDRZQmRYb3dXazNZbVRPTkdJamdx?=
 =?utf-8?Q?H4MEW9iPvoBC+PAAFD4RfWs=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f886cddf-ba2b-4d68-46dc-08dc271bdd2b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:59:40.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRyvfFGYE9cjyfWIdPP33O7VvfyAib0WNh/rl0cOIS2r0DglusWqVi4BL0eFAv6cTlR3NirsnLhGjwFJeSELbXcISBHxhEv6HJOJbXQL254=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6330

The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
multicore controller for voice processing.

Add new bindings to define the device properties.

[1] https://www.xmos.com/xvf3500/

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../devicetree/bindings/sound/xmos,xvf3500.yaml    | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
new file mode 100644
index 000000000000..3e77bb9d5eb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/xmos,xvf3500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: XMOS XVF3500 VocalFusion Voice Processor
+
+maintainers:
+  - Javier Carrasco <javier.carrasco@wolfvision.net>
+
+description:
+  The XMOS XVF3500 VocalFusion Voice Processor is a low-latency, 32-bit
+  multicore controller for voice processing.
+  https://www.xmos.com/xvf3500/
+
+allOf:
+  - $ref: /schemas/usb/usb-device.yaml#
+
+properties:
+  compatible:
+    const: usb20b1,0013
+
+  reg: true
+
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Regulator for the 1V0 supply.
+
+  vdd2-supply:
+    description:
+      Regulator for the 3V3 supply.
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vdd-supply
+  - vdd2-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        voice_processor: voice-processor@1 {
+            compatible = "usb20b1,0013";
+            reg = <1>;
+            reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&vcc1v0>;
+            vdd2-supply = <&vcc3v3>;
+        };
+    };
+
+...

-- 
2.40.1


