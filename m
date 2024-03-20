Return-Path: <linux-kernel+bounces-108585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B7F880C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB80128572E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5353FE35;
	Wed, 20 Mar 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="pv1QCk6L"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE233FB3C;
	Wed, 20 Mar 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921506; cv=fail; b=Rb0phlYlMnWRSnPtD+TqJ/u2NObS/2KjJcgut6ehtwFN3c+orTjPDqRcE62hTgF6eWCr83WxCn+McXxmi3XpEvNdOqBzI3niKPicyFggmJu4d33ZosZ7KBdTRguJEd1DvYIdRO1loq9WCgiS+VgaquHPUAQmOO9suwiEPNLeo5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921506; c=relaxed/simple;
	bh=lA7G8GeH3hF2mn3NqOewcppznWGrwH1CDzlUIw3l16w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qJyStS7yR/1hhADP6uIZgCDIJplQaLFnZTFiAE8fV1YIO6gRFvk66m0lSuLdsecrCQhQ/z8yjUHe5u8z29ehXiyO8U7UO03DowxnfV9d8i+gmk9zDc7goBsC3qBX7EToSYRswsi5k5n95PhbJovOPA+X1ioptd9ck06gBJ1e71A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=pv1QCk6L; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwQtmSCZnk96X9zD7m7tgU/ozysu6rI6fvalkCQmj4mtmPkCV1XYx6NaBcvQqnfrhGtyrhVhPCbZHcwxR6NPtuHob/FYESD4m/R464Jnd0Oc+K5vJlq1zrOM+YWrv3opoxJj1bRBu4y2oI3E9T1vembFGGd51byIfYXUuAj5SCLAC5QcmCgaIT53llM24phPZtWiGQKJfRqUBkQm+7bGMgqv+5dfEsjBX+cXToYnmw139oz/YBJANw1aOmz0L+xToz5SwcN1ZRbFjUUa6nJCgJ/WlG3EffGx8ZUQ/RCd2lZSsDP/WCA/+hE8RvuqzVKSepVjC4Ekwj+UdnhMpnH1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGi3+vk18Zep1ahuxciQtqKsydgtgm635r+qTfxkvkI=;
 b=Prb1HDpFi/8LcvQe8v3nVuKaoOV9BnoDhjilFK3cuXBnetqeFlDvZJ6kVo9/uRQPV09AqHHrC9e0k3NlZ87BKP8UDY/Vkt7MxS+UjZelrWTgl8x2W3Jpy8qHmbnC0D9nHQMsC3xYXP28XvPGS1tTzBqKioV90fJe+gLf5QR0HchZkynHVdT/MqAA2MogE9v5X7iFfV3TWQUXks/YEMMGxs6KQFy/q4o97x+WQU+ZR62wR+cSvHnV1ZYxOLHXYU+lUf11CB775BtZVAQAnCYZeKYq/Ibcyr4FWzxQMGDxyi3Zh+xzOe/PdbEJT+d/NK6Tuk1tvbnaqv1As0VhXB/r4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGi3+vk18Zep1ahuxciQtqKsydgtgm635r+qTfxkvkI=;
 b=pv1QCk6LhCcVEQ9kQ/fx5uPRe4gOj/svvwb7YvDxLErh01UcLj2HMoQrKQBNw7jMvTXeDe2tl9KMKejhu2XsYc7XFYHrnHg8Ccp6Vg+M+r8LshVe6ex7GiO8gOG81ANEo4p7SN1hd+7IP91wKTbjzdJZUXE2Qs+JYzYer44X25Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 07:58:16 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 07:58:12 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Wed, 20 Mar 2024 08:58:07 +0100
Subject: [PATCH v8 2/4] Input: touch-overlay - Add touchscreen overlay
 handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-feature-ts_virtobj_patch-v8-2-cab6e7dcb1f6@wolfvision.net>
References: <20240320-feature-ts_virtobj_patch-v8-0-cab6e7dcb1f6@wolfvision.net>
In-Reply-To: <20240320-feature-ts_virtobj_patch-v8-0-cab6e7dcb1f6@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Jeff LaBundy <jeff@labundy.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710921491; l=10518;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=lA7G8GeH3hF2mn3NqOewcppznWGrwH1CDzlUIw3l16w=;
 b=XHkak1I2jaQ7pHbnnB3WJBKclinwvIn8WFC7pmr1/2k6YuevyDwPH9XcfN3FuWgw093/H20mT
 p4jRBTgPptACph6dy1H6vPTXEfMjS2HbOqsxGRouT82v6IsTFwwhcis
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0286.eurprd07.prod.outlook.com
 (2603:10a6:800:130::14) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8ab68c-9d30-4a1e-d583-08dc48b37d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UErVTFgYPDd/A9Y9AyIBlCmNlLUyVBlf0RB8pQbarNOogPzS8lYFYeNslYCIkHQY0jkkYEq3D3pSzABTDsqZ40yEcbhrFi7dZObjx2UkYbdeS5dzq+3+lTxo36W+9iZpRjfwJPHzv55jSwBsbEO7g3s5tfduAQYZN0c+MjgAaBUKNlnf2R3SPIVelG8ICEcyMowj9MwrjeXfokJIZrnL8L8OVNazGLNKDHFFJUr4zMgYvR/IaPw6/29eW15cKcjSghuTs9s+yNYGF7A7OzRX8pEV/AGP0cTJp81rptxa2euDaqZfebrOslsEG/LjNlqHWU526ORWPBAyUync/cTbP4QYms82aAFb4/daLWDNwgUiHq/p+LYFP0yD945joO1ol5w+j4KvU85L5fzwx6FBBSInQIIP8npCLgWeQfqxUjNFmqUqY4jA+x8eVr9HR965WwIbsW7IqSnCG9yS1rYceRbocNkIe42udXP77/TG0g2ZCmvhX5+5KDY3I4ZsRB5EQETM5eVsdzHchW6rlVQcw5bc71GOidvO45aO1Q6y1RHtt/ag73IIx6jmvniZaJ4IGFf2S5C5csBQ2YV+Wqmz2QucPVFy2GVZ+2WVlCo3+wQw3n1pmgZ/8QWjKkyuWYGUIBDedLWc5XcwVUBNmNedmJH3LBz4EdVdxtpddK+lJ1++Mak6hbXT8NRNXpBfsXzBhImVdv0WgoUhG/Axoif6OZLgzHpIamDxesNShBDkivM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODZ3aExpYmMyN3N1bWhraWp5NFdRdXo4YlJCYm91WHhJY3E4cjY1K2NwOExr?=
 =?utf-8?B?WU1yeEoyVDd0WmwyZEUvTmUrV0oxd0RZcTlQYTB3VVRFbVFod0JkY00rRnRn?=
 =?utf-8?B?L2ZCSjh6enRLOWxBV09GZTdSMG5yOS84eFNtcE1kcHh4QjdCSW81dXM0Vmk3?=
 =?utf-8?B?UDV6ODFKYWlXOTAxZ0lvVHFyQStkejd4S05WN1U0V0V5OWttUG16aE5xVllm?=
 =?utf-8?B?L3JrR2twbmhGREJURDdnalpyVFNQZEx5SUVLbEFJd2hJTll5bzg5c2dUN3pO?=
 =?utf-8?B?MnNqNDVFbFRRandYenBuN2FhVm8rYW5rWjZCSWhpb2lWQ0pBVDdRUnRwMDVN?=
 =?utf-8?B?TngzRWpobk0wZlZyTCtLc2RPdnFSVnQ4K242ZmFKdGF6dmdCYURIUCtYVWJD?=
 =?utf-8?B?MENKT0lCdXRJY0Nsc1lKcFF6NXAxMVpFd25ndXdVVkNMM05RaEVOSEt3TWpR?=
 =?utf-8?B?Q3Y0bHlrY1lsUCs1QlU5K1BFWmJiUHlxelV5SEQ4Yms2U1ROYWlMM2R1QTVj?=
 =?utf-8?B?dVBHYkN3ODBhMVBycVdNU0dDRTUra1FrZlprb2ZhMWJBc24wZ01seENOZWNC?=
 =?utf-8?B?T3dIR0VITmJHY1U0a3ZCT2UrQzF6OTRMN2RYdXdGM3J3UWYvY0ZZRy93cGtU?=
 =?utf-8?B?aDc5SElxb2h6VjlYOG1WMmR3YnJoeGE1VlRxUkxXdS9XZHdmQlhMOFFZTk1D?=
 =?utf-8?B?NnpRa3cwOURrcTlWNG1JVUlsb25QQnQxdUlUMlE5NjdteHdMdHh3YnBNdFB1?=
 =?utf-8?B?THNkRDN4a2MwVldlR2lzSW5Db3N2d1F4ZjNjQ1R5Yk4rTUxjbW5WS1RWaVdP?=
 =?utf-8?B?K0NHZVNiVzRXZGdQcW53YTkvb0MrS2VMcE44ZFBRMWFWcVIxbG9tcHE5dUh3?=
 =?utf-8?B?d2dGdU91anRsSTJua0NQREo3ZGdVTGkycXQyNkhtVG5wVS9CSUZYMWNLTDZz?=
 =?utf-8?B?cGRPOGNhamxxVVRocFZWU3JCYm5ER0xOYTg0ek9iNW4wemJmWmxGUWtWazBK?=
 =?utf-8?B?ME5zTHI2Q0hCY2RnNFZKWHhNSDhBeVpPTjZMWklQUGpjK0RWVkdPRGdJUUYx?=
 =?utf-8?B?UWpUQllkdHhKeHd5QXZvb0ptV1FxeEJ3Y3NuM0VqczBVU0NUaHovSkVOWFJv?=
 =?utf-8?B?eFYyd2FzVTNqcENXRFhycHFWeWdOQVA1Nk12MEZNTzNqKzlOVFFLdWdCd3B4?=
 =?utf-8?B?MXJHWjRWYnJ3MERmMFVOQklOeGtIUHNrUDJ5a3JhYldQeWpBNUQ4RWRSRTZO?=
 =?utf-8?B?SGQ0cDV6STA0NU5GMmZYSEtjYWZBME9tZVJ5TEFPaDN6ZlhmbmJTSVhBNE1V?=
 =?utf-8?B?S2l4OFdOYUVsV3pDUCtVblZXZmNpbGd6djV1RTBTRzJUdGlyNGNxK0JjbDVp?=
 =?utf-8?B?YXFnVjV0MTBnZTFxWGR0Wmo4Ymk0UlFJS3hLajlvV3ljeHFLbWErTHd1dVRn?=
 =?utf-8?B?SG02SlFuajlhTzRBcDVBRUNyYXR2UkNWeVg4UkJwRVNqU1NFSXMwWmt2Nm5y?=
 =?utf-8?B?STFRUWpOWC9rMm04K2dTWXdCSDJ2L2VRR04xR1lsd0tacXhuRjhhNzJ1bWdP?=
 =?utf-8?B?cHFvTlRUUDhZVGNvendmYURwUGU4T09mNkFDWHozUGZCUUx6cXJiNFZTMnBN?=
 =?utf-8?B?OXFzemdFOUVoMU45VnJQc3ZyOUNWdlQraGFvL1plZERzZDlLMXBpMGFNeTE4?=
 =?utf-8?B?V3d5MXVuOHg1TDhvc2hqOGppdUFNQkZ5R1lGWC9lcjNHQnFVUWd4TGdaeEll?=
 =?utf-8?B?NkJndnZUTVhrd2xFclBtbjlpV25LVnJLczBFZUg3SCt1RTNEQnppejVRSDN3?=
 =?utf-8?B?TkRyT29GNlU0RGNLOFhhNzJVSXhMb2IxRUhTZDM1WWtxZ21YY0Z1ZnNyenly?=
 =?utf-8?B?anJzT3NNREpVQ1doUTNtaU1Rdzl5dHlVTXMra0VjcTNDcFFHb3Z6ZVRCeE5T?=
 =?utf-8?B?YUVRRDVNcUNtMzVBMk45d3lwMlozN2c2YlpQWHhod29Hd3hRSm5WalRYYUJp?=
 =?utf-8?B?eWcwT0dPZklUZEZQQm52Szc1QUl3MzFXOWhPeVlHVVNIejMvYy9JQUJuQ3hG?=
 =?utf-8?B?N0lSSmNYeWNpUTJTVWVHNVl3MFBML2VUSmMrYnJPTjNBajl3NXRvblFaNXph?=
 =?utf-8?B?ZWFmOVdKWEczdlhiZndQS1BoejBjODRpVnFxaldtWkZ4VEZLRzZVN0wrdHZZ?=
 =?utf-8?Q?Az9LM62GZvej+Ys1DRau594=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8ab68c-9d30-4a1e-d583-08dc48b37d6b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:58:12.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xy0AymZumTHsWgKVY0MTAU42lPX5R+4RFTZ7YLjuFLqiPrWccRFyHnVN1UGnJnZf4+nL5vLuoDYEuVbDZE1gDYSsXxSwsX1DiqEJNpYlW30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

Some touch devices provide mechanical overlays with different objects
like buttons or clipped touchscreen surfaces.

In order to support these objects, add a series of helper functions
to the input subsystem to transform them into overlay objects via
device tree nodes.

These overlay objects consume the raw touch events and report the
expected input events depending on the object properties.

Note that the current implementation allows for multiple definitions
of touchscreen areas (regions that report touch events), but only the
first one will be used for the touchscreen device that the consumers
typically provide.
Should the need for multiple touchscreen areas arise, additional
touchscreen devices would be required at the consumer side.
There is no limitation in the number of touch areas defined as buttons.

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 MAINTAINERS                         |   7 +
 drivers/input/Makefile              |   2 +-
 drivers/input/touch-overlay.c       | 250 ++++++++++++++++++++++++++++++++++++
 include/linux/input/touch-overlay.h |  22 ++++
 4 files changed, 280 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1339918df52a..94426c470a2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22338,6 +22338,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/toshiba-wmi.c
 
+TOUCH OVERLAY
+M:	Javier Carrasco <javier.carrasco@wolfvision.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touch-overlay.c
+F:	include/linux/input/touch-overlay.h
+
 TPM DEVICE DRIVER
 M:	Peter Huewe <peterhuewe@gmx.de>
 M:	Jarkko Sakkinen <jarkko@kernel.org>
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index c78753274921..393e9f4d00dc 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -7,7 +7,7 @@
 
 obj-$(CONFIG_INPUT)		+= input-core.o
 input-core-y := input.o input-compat.o input-mt.o input-poller.o ff-core.o
-input-core-y += touchscreen.o
+input-core-y += touchscreen.o touch-overlay.o
 
 obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
 obj-$(CONFIG_INPUT_SPARSEKMAP)	+= sparse-keymap.o
diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
new file mode 100644
index 000000000000..42b6ad753a00
--- /dev/null
+++ b/drivers/input/touch-overlay.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Helper functions for overlay objects on touchscreens
+ *
+ *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touch-overlay.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/property.h>
+
+struct touch_overlay_segment {
+	struct list_head list;
+	u32 x_origin;
+	u32 y_origin;
+	u32 x_size;
+	u32 y_size;
+	u32 key;
+	bool pressed;
+	int slot;
+};
+
+static int touch_overlay_get_segment(struct fwnode_handle *segment_node,
+				     struct touch_overlay_segment *segment,
+				     struct input_dev *input)
+{
+	int error;
+
+	error = fwnode_property_read_u32(segment_node, "x-origin",
+					 &segment->x_origin);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "y-origin",
+					 &segment->y_origin);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "x-size",
+					 &segment->x_size);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "y-size",
+					 &segment->y_size);
+	if (error)
+		return error;
+
+	error = fwnode_property_read_u32(segment_node, "linux,code",
+					 &segment->key);
+	if (!error)
+		input_set_capability(input, EV_KEY, segment->key);
+	else if (error != -EINVAL)
+		return error;
+
+	return 0;
+}
+
+/**
+ * touch_overlay_map - map overlay objects from the device tree and set
+ * key capabilities if buttons are defined.
+ * @list: pointer to the list that will hold the segments
+ * @input: pointer to the already allocated input_dev
+ *
+ * Returns 0 on success and error number otherwise.
+ *
+ * If buttons are defined, key capabilities are set accordingly.
+ */
+int touch_overlay_map(struct list_head *list, struct input_dev *input)
+{
+	struct fwnode_handle *overlay, *fw_segment;
+	struct device *dev = input->dev.parent;
+	struct touch_overlay_segment *segment;
+	int error;
+
+	overlay = device_get_named_child_node(dev, "touch-overlay");
+	if (!overlay)
+		return 0;
+
+	fwnode_for_each_child_node(overlay, fw_segment) {
+		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
+		if (!segment) {
+			error = -ENOMEM;
+			fwnode_handle_put(overlay);
+			break;
+		}
+		error = touch_overlay_get_segment(fw_segment, segment, input);
+		if (error) {
+			fwnode_handle_put(overlay);
+			break;
+		}
+		list_add_tail(&segment->list, list);
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(touch_overlay_map);
+
+/**
+ * touch_overlay_get_touchscreen_abs - get abs size from the touchscreen area.
+ * @list: pointer to the list that holds the segments
+ * @x: horizontal abs
+ * @y: vertical abs
+ */
+void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (!segment->key) {
+			*x = segment->x_size - 1;
+			*y = segment->y_size - 1;
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL(touch_overlay_get_touchscreen_abs);
+
+static bool touch_overlay_segment_event(struct touch_overlay_segment *seg,
+					u32 x, u32 y)
+{
+	if (!seg)
+		return false;
+
+	if (x >= seg->x_origin && x < (seg->x_origin + seg->x_size) &&
+	    y >= seg->y_origin && y < (seg->y_origin + seg->y_size))
+		return true;
+
+	return false;
+}
+
+/**
+ * touch_overlay_mapped_touchscreen - check if a touchscreen area is mapped
+ * @list: pointer to the list that holds the segments
+ *
+ * Returns true if a touchscreen area is mapped or false otherwise.
+ */
+bool touch_overlay_mapped_touchscreen(struct list_head *list)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (!segment->key)
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(touch_overlay_mapped_touchscreen);
+
+static bool touch_overlay_event_on_ts(struct list_head *list, u32 *x, u32 *y)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+	bool valid_touch = true;
+
+	if (!x || !y)
+		return false;
+
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (segment->key)
+			continue;
+
+		if (touch_overlay_segment_event(segment, *x, *y)) {
+			*x -= segment->x_origin;
+			*y -= segment->y_origin;
+			return true;
+		}
+		/* ignore touch events outside the defined area */
+		valid_touch = false;
+	}
+
+	return valid_touch;
+}
+
+static bool touch_overlay_button_event(struct input_dev *input,
+				       struct touch_overlay_segment *segment,
+				       const u32 *x, const u32 *y, u32 slot)
+{
+	bool contact = x && y;
+
+	if (!contact && segment->pressed && segment->slot == slot) {
+		segment->pressed = false;
+		input_report_key(input, segment->key, false);
+		input_sync(input);
+		return true;
+	} else if (contact && touch_overlay_segment_event(segment, *x, *y)) {
+		segment->pressed = true;
+		segment->slot = slot;
+		input_report_key(input, segment->key, true);
+		input_sync(input);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * touch_overlay_process_event - process input events according to the overlay
+ * mapping. This function acts as a filter to release the calling driver from
+ * the events that are either related to overlay buttons or out of the overlay
+ * touchscreen area, if defined.
+ * @list: pointer to the list that holds the segments
+ * @input: pointer to the input device associated to the event
+ * @x: pointer to the x coordinate (NULL if not available - no contact)
+ * @y: pointer to the y coordinate (NULL if not available - no contact)
+ * @slot: slot associated to the event
+ *
+ * Returns true if the event was processed (reported for valid key events
+ * and dropped for events outside the overlay touchscreen area) or false
+ * if the event must be processed by the caller. In that case this function
+ * shifts the (x,y) coordinates to the overlay touchscreen axis if required.
+ */
+bool touch_overlay_process_event(struct list_head *list,
+				 struct input_dev *input,
+				 u32 *x, u32 *y, u32 slot)
+{
+	struct touch_overlay_segment *segment;
+	struct list_head *ptr;
+
+	/*
+	 * buttons must be prioritized over overlay touchscreens to account for
+	 * overlappings e.g. a button inside the touchscreen area.
+	 */
+	list_for_each(ptr, list) {
+		segment = list_entry(ptr, struct touch_overlay_segment, list);
+		if (segment->key &&
+		    touch_overlay_button_event(input, segment, x, y, slot)) {
+			return true;
+		}
+	}
+
+	/*
+	 * valid touch events on the overlay touchscreen are left for the client
+	 * to be processed/reported according to its (possibly) unique features.
+	 */
+	return !touch_overlay_event_on_ts(list, x, y);
+}
+EXPORT_SYMBOL(touch_overlay_process_event);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Helper functions for overlay objects on touch devices");
diff --git a/include/linux/input/touch-overlay.h b/include/linux/input/touch-overlay.h
new file mode 100644
index 000000000000..cef05c46000d
--- /dev/null
+++ b/include/linux/input/touch-overlay.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
+ */
+
+#ifndef _TOUCH_OVERLAY
+#define _TOUCH_OVERLAY
+
+#include <linux/types.h>
+
+struct input_dev;
+
+int touch_overlay_map(struct list_head *list, struct input_dev *input);
+
+void touch_overlay_get_touchscreen_abs(struct list_head *list, u16 *x, u16 *y);
+
+bool touch_overlay_mapped_touchscreen(struct list_head *list);
+
+bool touch_overlay_process_event(struct list_head *list, struct input_dev *input,
+				 u32 *x, u32 *y, u32 slot);
+
+#endif

-- 
2.40.1


