Return-Path: <linux-kernel+bounces-44604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE78424E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D87C1C23F46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FE967E97;
	Tue, 30 Jan 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="X8Kpp2Ly"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870986A326;
	Tue, 30 Jan 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617630; cv=fail; b=RNohvfITD4JQiFHm1KGGU6SG1udce/5M9gi+dr35BhsIKjkyDJ58VK0x2JWwpt5TP7FWispQgFAHgV7gKSjlAp/PeVqVd4K7/HHIhEy3G9Szjd7wfIbg5ZV1JT9QfQ7FCr3hDfsaKUl8fXOA0o8YYHJlvohgLAfYkscR6iq1+do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617630; c=relaxed/simple;
	bh=0GBSewE+2kn4ZI1v4gqNSQ9nyjspiDDb7b5zMcvaAzM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CwObuCdA47GPHscMN+GnZom1g8PFqYxBLhHIHDHZPJQVZdRDY5oRuOpnAJmP079qIJ3PHdoXktbi8VaNkiwtDHfyVFhG+DlyghzMy4yshNKksIs1CulOedIGuJuWX34gFntMY5V0VNE4V14/WNumeS7x5QGzCJot2ml1WGAGjNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=X8Kpp2Ly; arc=fail smtp.client-ip=40.107.6.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+TfhC3VA3aWhPJ49HZRDeFvr6z7U8z0eaXqn0NTT2GkQ5MOr2H/BzkUU8/V5RC54171LXxIiRklst0zewadSnvKxsNJb0fjrgY20sSlr+2gU9zysPgIFMnO07oyDFfCl/JKa+7GZ2ZpJBpgTGCfNKPV65qVs59ujZyBNZrp4lMLYn8+bdA4xpvtc4/9D0+KtI6ZCkJm34IZGycBDRXTaceaGGBHC3hdX3MuF1YVI+1V7hxRefjKlgF4R4aPenjUdw4pInEEu3sXKd8WaRsPAiwN9gtee2oAe7sq+LmkeiBpA8LO/AbPX7IbgrMZo5DftPYl+YD3PfHxtDa72sCa7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5HwfcjVBf/qqAafYXjZB43w9Q+jUQlbP+yjZANTrek=;
 b=lAVoQgKjJZT2q9i6Q6C//4Iha/XHrrVQZvw78ioPlaZY9r467YNidzgJM16sFTSbo0RrOkEYkl2EA8ycOAzdJbNxq66wv7RFs2eDvRodjGJvq+n5W7UkcOOMznODv0mP2gXmNfzxaZnAdtBN0DWWe0kQvuhpRLan/xsj167UKMs8+3e5aNQ7REq/p8h4BOX0CSnCk/wlzamejWp7bGhTRTuZIJ0fK4D0XM9wmHZo7p84wXvIJ5FK+6XepQJGy65fTQF5hq2dJGs+NZ+bp1Y+AY0PRWRQivi2sdFF+s8BK/jDWtOqpKzMVXmxzbKu/p46ji7uApysl01vWRWU6nZqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5HwfcjVBf/qqAafYXjZB43w9Q+jUQlbP+yjZANTrek=;
 b=X8Kpp2Lyxy4Ydsi92/DoDJ0mosypQ1NlFzNXHmsNxsAYrjv54Dwd/hfu34Sc1JBWz2hDzb4DoWiBaG8msLaouFUDyV7gK7zpFcZA8d9cSTDjsIKXFttjAj4tOQDKQgkKV6lioRAS1pTSmWxQzYwtZn6gl6SYAh5duj2xmu6NvKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB9954.eurprd08.prod.outlook.com (2603:10a6:20b:638::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 12:27:04 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 12:27:04 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Tue, 30 Jan 2024 13:26:56 +0100
Subject: [PATCH 1/2] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-onboard_xvf3500-v1-1-51b5398406cb@wolfvision.net>
References: <20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net>
In-Reply-To: <20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706617622; l=1810;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=0GBSewE+2kn4ZI1v4gqNSQ9nyjspiDDb7b5zMcvaAzM=;
 b=4pQJuLpCwuX5Zj+XNPfOLe17/ktwpW59rd81d217p5kU/tZBjuTGcUTKmHIMyW6BgXcWaoFyl
 xUEJBo/4ZG8CNPxJ3FdJ5VbAG2ZGecPfV1ycXw2/o+RP6LNRqQvvMC1
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VE1PR03CA0017.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::29) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB9954:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ef4492-b831-4d0a-0a21-08dc218ec425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	07D59UPa9QyrUG+M677ISUqu0gtKtFMyIfnWFgcWLD+Qt1F52SGeoyzTzQrVIMqINrDzGfKTz/bX9F4RrLp9dYkFgWW1qz83Q2GkzmFmHQT03Cj2YfnYGA5w6xgh8T33AXKgemhzwBGpVqsVvqAJqrCXFZ41nDzGFy2UJ7+U5K/xIeG+visdugYtVVqYXCci7boG36hd5GmIIOXpZRwodZIddh+cwItb530ww8UqjFlgVNP9NzWEjaRSyCDdkshCl/hjyA2F/dQqnVFSs8Sb97my7JJTVwyBJt+/HmmjUTf1ZFf8ZqL/8glpw5mbf+K+9xcMzxoQSqZCT1ViEP138WV7b1oy+IlGaTrI0968XhEgVoN0dZOhQ7fpe/6elHvEo/EIaY6IIsQrrXqg3fZz4nIzf8R9ExPExYMrqHFIryh29j0E4489es4gy61rVAWX1rYjGkxCPS0TJNwsdhC6slRbLgKFv2dMWgZpWwEupNXOjbfLn0B/rw1uEmU6aHddWJcp2L/6+EcRD9ewucci+1woGB1tuPEeXgxH/SISLpZzaR0hgA7FskKUhB7dXMP3ak9MB43Kx6n35pMAYsWqmPuEDaDPw3YhN9JFrgOR3qDl/cd/PA7fiCSe57wfZ2dCVEg3Ex/ByMWHjEPUyi41Dg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(7416002)(38100700002)(5660300002)(2906002)(41300700001)(44832011)(38350700005)(36756003)(316002)(86362001)(6486002)(478600001)(966005)(107886003)(6512007)(6506007)(2616005)(6666004)(4326008)(8676002)(8936002)(66556008)(66946007)(110136005)(52116002)(66476007)(2013699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWpPOEV6dGdacFduTS9ySEdDNWtQTEdLQ1pXM3Z5OUVCeGlNNm5IcGtGSWho?=
 =?utf-8?B?bW9pK2dMY1gyVXBqZ1orZVFoOGc1bHZIUU1DNkkxWS9pS21QSEFzeVFmalVx?=
 =?utf-8?B?NjE5WXl4ZXNXZkxGOGphU2U1RFU2VHJCbHI5amF6N0hFb0ZsQVJtZ1pKMjUw?=
 =?utf-8?B?TzQ3QzdnS0ZxSFRQSW9ya2hqd2JqL1YvbGN4N1RkeXdaUFE0dzBkWDVNNEtm?=
 =?utf-8?B?cmN1anVQVWt1NVpuUjVGV05OS1czZmFHMEFGaGxCMVVvSkl6ZnAvV0JVRXdp?=
 =?utf-8?B?Z0k1eDBpOW13RHR6MU56SWpvaVhPV2FybFlUOTJ0a0JMR2pOYjM5YXN4Vytr?=
 =?utf-8?B?RERkSm1CQWVWaXVUNE9pOFJCOUFsaTYvdmlhQTJFSE5NVG9xSEdaY3F2aXFT?=
 =?utf-8?B?ejdzNlFXK01DczhjNURyK3RPeGpUZkJjd2UwcDhSMnNiRFRsM0d1eFRlZVZs?=
 =?utf-8?B?bmgyU2I2dmxtSzl0YVNRWjdMYUZiR044UXJ4NVBhcEV1dFNtbndlWWdxalhT?=
 =?utf-8?B?MHpWZ1hBRGZndEVqTUozNU5tTTdwVUxsYm0xM0x2azVKcitQRTJnVlJUV1J4?=
 =?utf-8?B?d0RDUGMwcjB4M3YwemYrbnBTL21KM01wZW5HUnR1S0xrQmdHYVp3ODM1RmVm?=
 =?utf-8?B?TGtWRDEveUIwcTkwa2lEaFJhSDNsbkVsK0FraFVaU2FxSW9JNHA3bWUwS1dD?=
 =?utf-8?B?RVhPSDlwODladXN2U0NPWWgzSzFNZnVnR004MlNTMDRaR0hRME1IY2hMMXYy?=
 =?utf-8?B?YTd4U1hpUmRYWDh4dWc2TnRWSlRtdTc0cE9ETmlvS25ML0MwMHdhM1JjZjFv?=
 =?utf-8?B?VlRKWE9hVFpDSVhqSlB5U0NoVEpJSkhXSURDRDdMeXZ2Z0VscGhhR2V0blp0?=
 =?utf-8?B?b0dybm9lREtsdzlnUHcxaWNlQzZycWQ0YXZkd2JzblVqL3UveWVnYkVzUVVo?=
 =?utf-8?B?VUh3OTFXamZLUWlPcXRna0tXem5UUGZBdEhMdlJhNEU2R3pCaWQ4a0NJcTFs?=
 =?utf-8?B?eGhYdHVhNU1FZUNyVStLSFE1ZE5VRi9LdTlQZnB1eGdpQTNuMG1ReGd1aGRn?=
 =?utf-8?B?YVBuWW9QcXlYWFQxaDRrckhLc2svM3U3ME5HRTdRY3p0Q3VRbXc1aEFtQSsy?=
 =?utf-8?B?dEZFaFFZVHdxWCtyOUp4WlYrYnFzamtxMHNENTdsUHZzQVFBYk4xNkZabXM2?=
 =?utf-8?B?cTZjVmVCdzVqb0FKZkgrcDVvQ1B6VUdhRmFZZzcwL2JxNGNiK2ttZ0EzZ1dK?=
 =?utf-8?B?SzJqMmlCQnlrYTRxSEFtL0p6K0RzalZOL0RKaE1TZzdUbnA4cENvYXlHNHVi?=
 =?utf-8?B?K1JPWkxKdkgvQnpIRXZwR09MN0gwalY5c2ZTYk1OU29weTdTUm42OG5jZlhu?=
 =?utf-8?B?aGdNSzZabklrUGo2dmltMHdkL1ErNUxIUjZnTjlMOVhDVmtwbVh2NGV0czU0?=
 =?utf-8?B?dVJhNUcxV3djY3hKemNVMDQ3U1pETmVQZEdPMzIyblZ0TmR0Z1ppU2pkdWJN?=
 =?utf-8?B?Qmp1T0pTcWF5N2ZwaE0zZndON1AzMFJHdzZrVWQzVVJyTUZSMkRMUXdmR05Y?=
 =?utf-8?B?Z3A1MmVwS1JJSCszNWx5dDZzdllIY3ZOOHp4MlZYVmFoblZlZVVsaVpmZkxl?=
 =?utf-8?B?aG9qbjlpWC90bVBINlYvc2oxWi9acE5tdnEzS09oUy8vRjJDT3VlQXVYVHU0?=
 =?utf-8?B?WFhQTDBiZWw4QmRGbkF2UkZQMVZmVkg4TFU4cyt3MklBMGFUVWtHR0FkLzNv?=
 =?utf-8?B?KzVmVU5IL0M5SWRhSVFPQVVnSnVQb0lIWWV0aUI1OUQycjczVEJseHJ5d2ht?=
 =?utf-8?B?ekt2UnVEZE10UjAzTUEyM09URDgxbWRYekZsTEl5ODNidEtSQ2VQcWxtMk5w?=
 =?utf-8?B?ZHIyYVJ5eEFrYmZrVDM2cmdmeDVFd0NYaXgxem54eFlkMVhMREVLQkNoWlpD?=
 =?utf-8?B?cFRQSU1JbHR2am5UOVhNTGdObVZCRXNvb2hSMnl4TUZkY0QvaHlCc1doM2lu?=
 =?utf-8?B?dXNIVzA3N1pXVElzSlQrWUFCQkV4cW1kTk0yYjZrTWkvcUN0bGsvdUI2SnJq?=
 =?utf-8?B?Tm1YTkZPT3pqcDlTK2hOa1ArOGN1dGlVOXRiclFVWjVhRDM2cDJFZmI3VkxB?=
 =?utf-8?B?S083MHliUzVwWVUxUVhScmJGNkdJTkErQUNtdy9XTnIwUXpwUjF5NnFacisx?=
 =?utf-8?Q?uuh3na2EYeIw/IY6sjN78ao=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ef4492-b831-4d0a-0a21-08dc218ec425
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:27:04.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7O7itT3I72AhWAC8wxd9+FHMUM5whXzLXpexu7T0RMVIwndf88+1ey8erqwNFI4D1nlb8cx57jf+DqSiwK4g7g6uoPFI7r6NbH1j9MGHx8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9954

The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
multicore controller for voice processing.

Add new bindings to define the device properties.

[1] https://www.xmos.com/xvf3500/

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../devicetree/bindings/sound/xmos,xvf3500.yaml    | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
new file mode 100644
index 000000000000..d7d5bda23b1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
@@ -0,0 +1,51 @@
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
+properties:
+  compatible:
+    const: usb20b1,0013
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
+    xvf3500 {
+      compatible = "usb20b1,0013";
+      reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+      vdd-supply = <&vcc1v0>;
+      vdd2-supply = <&vcc3v3>;
+    };
+
+...

-- 
2.39.2


