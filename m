Return-Path: <linux-kernel+bounces-116634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEF388A163
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D161F3B20A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09DD17B508;
	Mon, 25 Mar 2024 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="J64S9Jqh"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2097.outbound.protection.outlook.com [40.107.7.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AD16D9A2;
	Mon, 25 Mar 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358126; cv=fail; b=PrQPru/KZchDfn7VkKDrE9UFrYCTbzxXX2GohQn1L5tec/ksoFvp/BiimyMLPzeMuboUc3wz+ucFpkKZXoJXRTJQHdUr6aCBPDOPyzqa7nAlrenGNOqLZt8c7dsxXpvp/O2ziQSCDMFkT/UlV2HFQbp8Nd6ZRxoI7lhWvs5yp7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358126; c=relaxed/simple;
	bh=FvrRDlR7ETfEYRhJuYA3303pTVqkQjZcs8skxesYqJw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CHRk6lB/g5l3thRMxOHHzJgyXXTgmzoS47A4IMbb8VC22LxiuhFsJGguCRePTv6jZ7aSyMpRMkrVvuP9uqiH91XJX5jHzNkFo+6ZrqIOodgHjAqtWSWDm3Ji6r+yH6mE2H41Zl0jD8M1iX2MeJFPgynbdl2OnR6ZeHBNmPWfb+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=J64S9Jqh; arc=fail smtp.client-ip=40.107.7.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b25lKJhy4UPG01KyMl7NELXGCzH03FPXeVzVuR2SCcKxtOZeSmGt7yyF4dt3nOSFNfM3Zz5qrn1c+QKvcI7r2QDqN0TvSj1kGB7rzdNw0FgBNwLOpq1rdr2IGXhbFeaSm1sseUmSH+xtE2VJmJNcaufFTM/TEu7FZK65WsLxi2Gcn6Ls/w8qlNe6aZHgOLudWXRbS8GQgLOv1TzxxqkF24gdYqxotga4PgT8lLKZ7oysCQExO84AOw2tdnkNvY1RGZqqysXRbIZu3zxKFKxKipETMLOBGymp4yqCzOPbw3SmJQg+PxJ1yT12iZeedvbnCUitWN6W+xDfpQeVGYQ1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEzPzBWBQN7yOWI2TBuONb5Ay8ayoHuXaetscJSoGXU=;
 b=JJL3/pSbwT2+WjGt6Ap2v28QjxCVDUvfqhHbaX3abkhCUII0xABx73s5P6N4q7ogjndbILIk2tiOWiA+h0DtJYuAQd9IGpwjdJa09pJZmpvA0q4vMxoAE6kokSrZ3TxHhcOy09jPw7RGXGInMpFqpDUS5jQfwGkbVEyIHQ12Hbas2ZAloSTdaCC5V7Izk46dmWJRgSUxYYyEbcrI6q6XiwCzimEBkcvA1H8SEtW4JSRkdJ9/cXEsMK69v8AxOiYOFf8tDOqyRtlEQhi8otXIQ6GZWHRboKzET0ke7ryzJu3VGdMbVxJt3r6tSLH+DN5xoEGUWngTtc3yLJbekBBMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEzPzBWBQN7yOWI2TBuONb5Ay8ayoHuXaetscJSoGXU=;
 b=J64S9JqhkDaAeVANVXxYqW/jIDXTKzZRhieXhAgx/4RzrImPQQbqg6niGotfwzqfA0OMP9bR/0+7GI2ydIcaDy/OYZiff4ZUfqmUrzgdlXpe3vv57wFDGNDVb+OU8EnZoXjZsNlURdAXuMLtn0KoP6RGRyOA/5IQSVQAoXh3DBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS2PR08MB8951.eurprd08.prod.outlook.com (2603:10a6:20b:5fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 09:15:19 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 09:15:19 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 25 Mar 2024 10:15:15 +0100
Subject: [PATCH v8 5/8] ARM: multi_v7_defconfig: update ONBOARD_USB_HUB to
 ONBOAD_USB_DEV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-onboard_xvf3500-v8-5-29e3f9222922@wolfvision.net>
References: <20240325-onboard_xvf3500-v8-0-29e3f9222922@wolfvision.net>
In-Reply-To: <20240325-onboard_xvf3500-v8-0-29e3f9222922@wolfvision.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Helen Koike <helen.koike@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Russell King <linux@armlinux.org.uk>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711358115; l=903;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=FvrRDlR7ETfEYRhJuYA3303pTVqkQjZcs8skxesYqJw=;
 b=RxwNhdNpqe26vFkB7EYVLpBKu4o6QUo/gY2O7bGXiSVxUHx8BYY92DBJ/ilj2n8s2gJqvv6tS
 uR20PROew2gD/LokHmtwYL2Av81J/pETN/e+TeDXhiTnIeHutSQOTgr
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR08CA0223.eurprd08.prod.outlook.com
 (2603:10a6:802:15::32) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS2PR08MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 8095cd2e-a911-453f-4f09-08dc4cac1748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SDp630mu4Y4UWc911shtqSgbibuC0qwtUpRZ0hW1H3Eis+wqkkEXG977S1S+lsh0HPvH2mxQn3Rw3jzUg2D2jQi97HESYiKLvY+Eh/UW/1LEHoyGWcFleYmvSJudmfRJHhoT75V/csJXZdYVjDppiySmfks0dSfoE5o9bSR5OiTN/p2OOARhBKATkF5cMkT9BZb8sJsXYYLitL/bY90G8gdeVPglvo2HTa99yLfWI4KjVHrKk2nv9hdKFslQ2gxNKPHQdbsuetPANAlG8W2B7GFCGZu8QVzuxKUM/5DeDn3974NSOxQsl2YuHRIa/MCFNpLDtEj5sAFjVRa1LLQmneX6/lrB7BdT0A+6TUwqAszl9oZpcqpK5yk/STH+gSZNVkoDR6/817/+HhmiN/xYWwgT81O/WZcgxTEt0iZey6UXH5oDNH48rxk+zB+CZUPptYsfSwSbQOzsAi0huBmYRpFIUYAUeLjuoz/XlzJD6kyZLzQ/gtxve9vrbNjKm8DhpuZDpazeKWV6NEhUJUD+Pl5MvgXDp8tXqafc7p3k8uCp8iBC5aFP4N18+7z8lYoMF3eZbsJOHxaRLjVao+3ijIDY+WfOFKu97kikyh1RK39feJVXEYzU7VO/CQa6y56nzHYFlaYEGEVS2KWVIkujDcLvkAQ4KM5Qxy8gTp+/v9xRzlFBdsMUMNvIPlUdGvzRgtdO+HvUdTzF6LMJAQXvJTZJs2xBJyye4ptQ8UkoQVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(1800799015)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0FLZEJEUFBZTDgvT2orWmV6SWV4ZVRIbi9uWm40bkUzUDJLY0FNek15ck1k?=
 =?utf-8?B?SEQ1Yy9NWEoraG90SVM1OHJsSU1xejBCY3JabkNReFhZR1U0UC91dFk0Qjg2?=
 =?utf-8?B?U2hVSUh1eTBMUjZ3WEJmWmhva1lFWW9jbkZ2U050VzVpZnBod0F0STlwejFS?=
 =?utf-8?B?bXZEazlGUWdGSE1HamdlUndTWjMwUzV6OGVLMkN2aVpBYVZvUTI2d0hTREsy?=
 =?utf-8?B?bzhIbDl3M3V6Z3c5K0IwREplYVR5RXdBUmcxNHM5ODFDRFlwK1Z3bWhsd1gw?=
 =?utf-8?B?SWJONGJWd1hrQXkyUENETXNNU2pYOHA2eWwybENqZWIyU0FJQmZWNk9rUTJ1?=
 =?utf-8?B?Wmt5Y09vMFZ0ZFhaVXVLUW84M1hERGFJM2Y0Y2RVZ2k4R0JleCtjRU53c3Q5?=
 =?utf-8?B?K2JacjlqeVpQUFoxcnRQZytITG5vak5MNzBvbjlrRHhEVzhuK2NLL2NkbGJX?=
 =?utf-8?B?VXkxS1pDT0dJTDFKT1hGUzRpenA1MFpCa0RrcFNEbDdpUHBRRFZMeUxtVTB0?=
 =?utf-8?B?NGJNeGh6RTB1ZFZiQnNtUlRubWlBR0FRQU9pZVEyanYrVmpSZCtLUndQejJp?=
 =?utf-8?B?REIvVkVGZWF4NXNCOHJ4SEwyWTBZa1RuTzZuRUpQK1BTQURSTlV0dVRRTDRh?=
 =?utf-8?B?cnFLcFZXcE4xVmx4OXc5QjJmVWIrV0t3R1ZvRzlKTUxlSEpwRW5HWFRiR3Rn?=
 =?utf-8?B?emFRNThMWjVYWGwvZ3pZOVYvbUYyY0R1NHpqSWUrU21MN25WaXczdWRlakFQ?=
 =?utf-8?B?TlVEM0JoSTI3YUxSRnk4QnkxRUxjV2xHQjFSazNHelB5cVNENnFORmQweDZk?=
 =?utf-8?B?VU1RUmxOd0UyVHV5TnBDay9OZnlwdjF1bVZ3ZGZpVVQwSGh3S0RsdDdwSXZj?=
 =?utf-8?B?THdaaTFjYjdQR3hrRGxFZ05QL2xRNmF2azg4WHBBd1YraXBic241cTc3d21r?=
 =?utf-8?B?TnlObEVkT0ZOV0xjdy9mZHlaZE44Wkg4Wm5LZmpLQTgzWUNpY3dYNWxuS3NT?=
 =?utf-8?B?TWlHMjEwZU1lWENYSGl4b2NEUTlselh1anM2Lzd5a2gvNWc1VXdkbVdRYWRI?=
 =?utf-8?B?RVAyUityZk5qS3hnREFtckZ4N2pNbnpKdTdYOFpmc3pBRlRXNVNmOFpmZzdQ?=
 =?utf-8?B?VUgrd0VrMlY3cnM2VUpockFjRXBENEVScklwNzBlTzR4N0ZMeXBsWkpDZU11?=
 =?utf-8?B?OXpDR1E4eGU1YU1rMS9ER0FhSCtOVjdKbUEzaHdKRWQvZ1VpTkxvZkk4Sjl0?=
 =?utf-8?B?aHh4QmZGcVFLMFBvbTlkNXl5M2ZEMXpQOHdMQkdkSmtKRmFHUkdHOWgveU9t?=
 =?utf-8?B?SHM3emlVYXdIRWEwTHRQL1p0RXYxbFYrMTlpMFF5SmVOT05SdEFXVDE5RTBy?=
 =?utf-8?B?SXhoSHh5ak1wSUlwanlmR1g3YlJ2M0xZZWJtYllCTnlKaXJiSzEyR1ZSa01j?=
 =?utf-8?B?c3RaekdTS1hpdTRCY0dVMm01U1BhTWw3cWJWUkJBTUIwTGZmc2FxMFpHdnNK?=
 =?utf-8?B?Z2VjYWxlUlRDNGpzbEhwbmdtSFRkSlNmZlMxdTJuZWNpaTIwWElla2k1Yzgz?=
 =?utf-8?B?djB3L2NzU0xVRUdCbGNrNFo2Tk1EcUJjSXZOZDVqbCswTTg2QnU5WG5DK0xR?=
 =?utf-8?B?TEdGTkJtNHlONHBlcUFMSWx5ZXNPYXZ6SW00UlRmV0h2elBBYXVzZ1BaZVZx?=
 =?utf-8?B?VklXSDA1UWN5cSt2Z2h5QVlORlV6TXJLVVdBeXBuUzc2ZTh6aUJUeTFUanBP?=
 =?utf-8?B?dTRpQUNDYlZFMlEvaUEzMFRlNTYrNytGcFNVOWhqeE1LeW54dW1OWDA4dTBq?=
 =?utf-8?B?ejhNc2dnZUpmbDhRNytPalk4ZlhJNHVZK2ErQlVjTmhOcUo5LzEybTNHTmNN?=
 =?utf-8?B?ZEhLU2RpRXh0UnEvY0xvZUtBT0FxektEeDMyNURjb0NXL0szbmtoblM3ekY5?=
 =?utf-8?B?LzkvNFl4U2VCZmZsblhpcVVNQXFWc0RySXgzcXV6Y0IyS25oR3QxSU0vWWNu?=
 =?utf-8?B?T0ZqbEtaMU1JNDcyQUZwOWN0MWQrTHVNK0pybDNiN0VaMHNqUDNIRG9NSXNJ?=
 =?utf-8?B?UzhxSzlhWkZ5S2tmRHAzZFo2QXpmcEZZam12YWpqMmFueVBjRUNqell1VURj?=
 =?utf-8?B?NG10d3JvVnlsQXROTDVIVWpsM3VPbHNvbmp5eiswSVdnRGNRSDdRcHhPSDdx?=
 =?utf-8?Q?tkE6TjuhAsECi0Hkm1awYKI=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8095cd2e-a911-453f-4f09-08dc4cac1748
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 09:15:18.9495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkajYQPqZUs7PfQZ8NKEaktQjgfBncUV5ExFgaam0QyaBtkSINKXRMEGiHQXrjvtZjbEjxXm8XfxigA2BFqo/5V6LTWCBqlz15FKJ2810u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8951

The onboard_usb_hub driver has been updated to support non-hub devices,
which has led to some renaming. Update to the new name accordingly.

Update to the new name (ONBOARD_USB_DEV) accordingly.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b2955dcb5a53..86bf057ac366 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -885,7 +885,7 @@ CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_ISP1760=y
 CONFIG_USB_HSIC_USB3503=y
-CONFIG_USB_ONBOARD_HUB=m
+CONFIG_USB_ONBOARD_DEV=m
 CONFIG_AB8500_USB=y
 CONFIG_KEYSTONE_USB_PHY=m
 CONFIG_NOP_USB_XCEIV=y

-- 
2.40.1


