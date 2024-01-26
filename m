Return-Path: <linux-kernel+bounces-40231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C183DCE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F152B27438
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0F01CF92;
	Fri, 26 Jan 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Rill8wMv"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514E1CAA1;
	Fri, 26 Jan 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281111; cv=fail; b=TF2+Hijte4/ipWhRWGp3DVLKSpkvFLnBdSvl++Iiud/u469xRSdYC+wQ21d2XVG2fjVN9C4bYRh1cq3OnqtwVOxvpv+/W/hEvu6pHRLpO0ThVuWGxNsFO9asqBqjeElmpmGcpRXTqHBVkyCpFE8CK0cDXjvqmztO8naoqCBpJ3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281111; c=relaxed/simple;
	bh=IVMh64niZEfl6QXJoAoM3XsM/a5UZlHwxq+4aWfqMFY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HVyWLl0Cn15pHsvDbGwBrG6MTT531Ruxkkp/LWpBrw43uEdjglR9DQzy9T5+WyA5kr6hEmO+xgOgHjgQnuzacq1bL6N5KnD1mThDiL8Ud50bJZC2UJjxyly6ol65QoEG0SpaSApuGmE6h+JIqOzG5yvfr8sG0myuVnEOYa02gg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=Rill8wMv; arc=fail smtp.client-ip=40.107.241.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHzMR8xZ6ImyJp6xouzA4y3BKoJaKhjwpE0z8/5b0Q5l1WZHv6Nm7AFlXoabh+yozMVtdnmKnY+1IQJfTIT+OS5v65tiT7Vg5I+B9SSH8aGJ59xlB1VzD2vJdHKeDWJcQa8+WPLVr/729MsLBUahHfAcVSOetrcb87la+rktudstd7FPvgStjrxd58sh8HszB8yhMStlvrbHGxpG25iHP9BXYO3VrXvb9mSuqW67aj7VceZKcBmifFQr/qw6aJw4DC3KjHtwpaadVm++LRMD5U7gAg2QTkl26ga+FXIK27ztZHIDAWiL6IrE7bClBO/wCozNUalXkuZG/JKvjk9EpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqixvfKtPECeF4ubPvftK4PmEI+HUmvDEI7Qd1Vr3LE=;
 b=UxWZIDFG9a0KCghlIGz6vNVysmxB7fgLj/dZaRtC1+wH+8lUhNwhelD3vKL6aJ3+DwzEepJT1OBCdCOQPOUmThK4HP0cmhbSrqWMqXc7wvBCyNCHcbMWw3vGwU14e5pb/diLphL3oCENsdQuKROWN4u+4dx/IqQUZjkObqrYy8AmobEhxLU8DSQZFAwc51/mpzLBBSuUdoRs8TCbF9ft45Iv3gQRdW2ynR8eZMDB9qDweE4VQ+TgBEKur6oexRT8ZUWfTB1h7iW9QL8xX+BCEaHQbXvd8fNjCzNKV6zQ8TS/O56AVX2D+2YLkcDSGlGQYF0dXoARrW5lpPs7/KN36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqixvfKtPECeF4ubPvftK4PmEI+HUmvDEI7Qd1Vr3LE=;
 b=Rill8wMvaZ4Pnbs2qaMciC+HnYOHRlrMXV5C0zyUTaDqKIet7+ZDY7kFzx01kaGBzczjRItpykuGY+yqZcjJG7aX5DW1093k2n6ZxLe/MV8K+WhoUoGWhtW5KijgXKZ1Kyeq+kpUJc8CxxUYy7lozLVSySTvsHy6gAdWQj+tL+WNvwiifbTrh9jMrczTtLVXDCW7GGjjWwjXoMcrDqhp9/HVxv+O9jYvJZV/bytylG7REd5ItxLhIrzuKVBKWXFh+AuTmG1LejDs4Bs8mvU7QXRsy9/az02Gbmg20Gy7fRI6HGn67bfeaR7x9t9k4eeT0VfItNd32e2UsW/jcpJ9AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com (2603:10a6:208:178::19)
 by GVXPR04MB9735.eurprd04.prod.outlook.com (2603:10a6:150:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 14:58:24 +0000
Received: from AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f]) by AM0PR04MB6371.eurprd04.prod.outlook.com
 ([fe80::e130:6c40:23e5:9a8f%5]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 14:58:23 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Fri, 26 Jan 2024 15:55:10 +0100
Subject: [PATCH v4 1/6] dt-bindings: serial: Add binding for rs485 receiver
 enable GPIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dev-rx-enable-v4-1-45aaf4d96328@theobroma-systems.com>
References: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
In-Reply-To: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 quentin.schulz@theobroma-systems.com, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To AM0PR04MB6371.eurprd04.prod.outlook.com
 (2603:10a6:208:178::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6371:EE_|GVXPR04MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: 5923ba1e-4249-4cc7-4cab-08dc1e7f3e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y0OhAVbVw4M0f/CqwzO0jAenuzpHrtw0g39ky9Y/J3tN8gyMNNaCortaHPIfsGDIUlpKSk/VxwIdXwCLA/AtIVIF8Ik371jWMlx818JES8eLOHt1Psf3oB7DgO4QSAyQ584pNZR0JQjW6gjRi0lQcFl5VZXZvKGPRRIMEHblZ1Eed2JTZ/WRgwlb4bPIjcHh9bfBpDlJHbUG0uw8fPmbvnfnB0bRpk/ylp9PayScTgpZ+kKNoPk+mybfdp+S8k1fcmstZLoFtH5E3sIDSXzIbrzoe5MxeShHXWjBepG/QoggfQGc7TYV1bvKuAJrbI+oBXXuFE/LKQn0z/sX/oVrx+ZuQApcl4FzrjDpYEX643Q0z1Rrl7QBpiqZje3Mwv/9bzv4IberwQsrQtxsKvOKiSrvekoSE0G/WUqMLwewBz+NaAuI23WMoRo1ZJq5EM/a8Uriz5j6+eAxlKaaGMLL8WgIfESkWmm6yIEIqkLiaoLejIsLcSRlQwvGCvF/4JsqNtIo9sYk6GU1iGVx4mkyP02eNYZzQD36konvNbe9KThdtqriVMQXRvWu8yXsJXxz13F8DmIAHWPGbLnSUfctlA6BOs3SJvnQ4atZnUJDszXZYLy1Wwzb4tUWPrgTYPjs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39850400004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(54906003)(66556008)(86362001)(478600001)(38100700002)(6486002)(6506007)(36756003)(38350700005)(41300700001)(52116002)(4326008)(8676002)(8936002)(26005)(2616005)(316002)(5660300002)(66946007)(6512007)(6666004)(7416002)(2906002)(44832011)(107886003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXBUcndHVVlFdk9pcmdaQ1FJNFhlS2ZEdEhLWmZZOUtYSVdHU1lYYnZhYzBD?=
 =?utf-8?B?VXlFK0tOQmNJZlNFYTUyQkdPNlBqbU1yZWR2Uld0VzhsY3hvUEw4RzROeFJy?=
 =?utf-8?B?a1QrSzgxK1ZodnM2SGJlTFpCNk5sbDlCaGtzK1hMYVBjRmZzZHltK09VTHQv?=
 =?utf-8?B?a1NPY1kyQ1JvdGJxTnZyaXg3eGRmRWl1bHBXYnZqMGlVcXZscVNaMm9CbDQ0?=
 =?utf-8?B?cnAwdFY3QmlyTkdSaVdZOHpmajBXR1Q5RGNzMGxUV0VTbmZUMisvT0FIZEdp?=
 =?utf-8?B?Z3k4REcweGhIcDRlWW5mVlVNeDQ2R3pLTFJDYWZxdW9BNG5CNGJjdEpmOHM2?=
 =?utf-8?B?NC90ZUthQW43ZlE5YSthZHR0TG1qTEdubGxvOU4zcUt0TnAxS1dNM29lN0Js?=
 =?utf-8?B?RURNRkdvREFxZGhseEdZTmFGZFN6NXBoZE9pWllHbXBtV3BnQUJ4N0g5eFRa?=
 =?utf-8?B?cHJORnpHalJWT2JsWGRHaDNMajhEcDU1K0RSb0FGQzFqeUNaalYxbXJXUENI?=
 =?utf-8?B?QkR6YlU1QXZhOGhtSkdJU3lWYXRIejJocWkzVkh6SnUwZ0hxNTRTYk1Ca3Js?=
 =?utf-8?B?aHdKdnFnWTR1b25sbEpvSkdWR0NoTVdFcm52SUdKdUZTZEtQV2FMVVRoWkRK?=
 =?utf-8?B?Yi9TRGhYRk9vUG9SZHpDMnBrbm91MFZyNUhKY3Avb1JNYzdaa01NaUo4UWlY?=
 =?utf-8?B?dFRBRXBLOXpYYm84aXNrQVdlMEhpMUF0Szk5bmw2TFB6STM3aHdHTThwMmVz?=
 =?utf-8?B?ZWlUNnJhdmhDYVRmci95amFDZCtyS0U3L1lMZHE4SXZ4ZXNXU0E2OUZqRTIw?=
 =?utf-8?B?eGdiQ0ZKT1NhVjBTM1dYeG9kWlltMWlXSXFxYm1idFNtejlsajZCZCsvekN0?=
 =?utf-8?B?dGR1S29ZWXNDYXA0Zm5TOXJmcEtYYzNsN3FpNzhrODgwWUl3Ym83MU5UcC9Y?=
 =?utf-8?B?aXlJMjNVNURxZ1RvNzBsTXRsVUdwTFA3UUMwZHdiaFJXVUU4YUFqSm9WVjBV?=
 =?utf-8?B?L3BLRkgwc1AyYlRmellXOUZSa3N5a3p1WDZJUkZwMW90Q1AxMXdHeVBwYVhK?=
 =?utf-8?B?S0wxdWpiZUxJa0VHQkZUcXM4b2wveWh5aWY3TnFQeW1rajRsY0tHcHBmMHk2?=
 =?utf-8?B?RVRNUlpqdjByWWliMXRqN1g2Zmg5OW5uS2Rtazczbk5uTFNvQU5MbnA2cXRq?=
 =?utf-8?B?V1AvRFkxVm5KMnlZSERZemNqUmZBZXl0ZkRza0tGdUdqY1NBTFhvbFRLakFx?=
 =?utf-8?B?N2ErUlZ6eThRM2w4dFRJaFFhNXZ0Qm52SGFtKzZETUNWWC9rNHdrWW9ZV1RX?=
 =?utf-8?B?T3dwWG9XelMvRFBVdVZYQlNoTHVPdDhIZHlPTC9kWHVSaHV3N0lSRWREdXg1?=
 =?utf-8?B?am1tcHlxckYxU0lqT1czUHk5WFFqUkxDWVltRFFyUTFaSXFvTmYvN1BCMXdF?=
 =?utf-8?B?dmw5VFRObDJjV3Avc0o4SCtmeEw1eUphOThxeHBPMERuNHhRYnN4M3NMOWxY?=
 =?utf-8?B?ZTlXdmhuSEZaV0xqT0dvUEdRZ3pZc1VBVjE0ZkQwdWJCS3JFTlQ5WlhGeG55?=
 =?utf-8?B?K29Ta0dUYkNJNGxIVGJZSklYVGZ6dHRLSVY2aXllQis5WEttcjl3bzgyYlln?=
 =?utf-8?B?N3Z6WVB3VWN2OHYxemtaMzlpTnE1WExzK2dIMFlLditjWFZTRzhqdit5OGZV?=
 =?utf-8?B?ZlIxaWRtMWtwM2ovTzAvY3ppV3RQUmxycU43Sk1XSTUxUEsrQmJyWDZyRnZ6?=
 =?utf-8?B?UjE2WGd3dXpIRndRMzFCZjBZbXRWbXN4VkdpZk1HWE1pWWZ0UGVseGtYRFBM?=
 =?utf-8?B?a1gyWVBCeGplRzVJQk5sdWpDYXhMY3AvNWlZVS9hdWFPZlJEaGhSTTRpbk5h?=
 =?utf-8?B?RXhKQ21mSGxOeWdCTE13c2FyOE1qUW0vZGZ5L3djNElPSGtDUWV6OUpCbk03?=
 =?utf-8?B?NEdjdzZoSk9JdmNkNUlHV2IvdVBwMXBwNUxhN2pBOE9Xd2ZON2NVdXNmKzgz?=
 =?utf-8?B?ZE5Cdjh5UXVzS2NhR3Nrc0VQaGE1YTFtWmp6ZGtycTZBQzFoSzZaN1Y4cVpX?=
 =?utf-8?B?bjZlanMwQ3ZiQ3l6OWNMRk9jazliK05LNnRFbVpKSmVoSld0M1QwNTBKbnVp?=
 =?utf-8?B?bkg3dUdBcldWTEhjRkFXM2NDL2VGdmdjMG9TWEpBcWVBbTVaRW9nQ1lvNHdq?=
 =?utf-8?Q?gn5nM8j0OP0EvKSIF8iXV3U=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5923ba1e-4249-4cc7-4cab-08dc1e7f3e35
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:58:23.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtYJWfx04FOf3TEvhnBYZEjIT4c/UxRa0S+DO694UlqdBHgmQ4xSbRvGhrDytSFnKWVZ0C9n9r2KuzhnZXcFsLgXDcmqCWDWdg+iZMPFPqMFq2cXm6uIXN+9fugqwFkm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9735

From: Heiko Stuebner <heiko.stuebner@cherry.de>

RS485 has two signals to control transmissions "driver enable" (DE) and
"receiver enable" (RE). DE is already handled via the uarts RTS signal
while the RE signal on most implementations doesn't get handled
separately at all.

As there still will be cases where this is needed though add a gpio
property for declaring this signal pin.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 9418fd66a8e9..b64577036b5c 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -51,6 +51,10 @@ properties:
     description: enables the receiving of data even while sending data.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  rs485-rx-enable-gpios:
+    description: GPIO to handle a separate RS485 receive enable signal
+    maxItems: 1
+
   rs485-term-gpios:
     description: GPIO pin to enable RS485 bus termination.
     maxItems: 1

-- 
2.34.1


