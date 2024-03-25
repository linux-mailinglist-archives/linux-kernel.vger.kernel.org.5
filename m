Return-Path: <linux-kernel+bounces-116640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C488A168
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684482C6435
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292BE17B50B;
	Mon, 25 Mar 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="Bxi5csD5"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2097.outbound.protection.outlook.com [40.107.7.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76F16D9BC;
	Mon, 25 Mar 2024 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358135; cv=fail; b=k70VdUb5XfmehcG/Vuq3gO+5jOREZ7hGtGHwsVFbZM/MWgmSD6Ff5AIBpCD/awPR2iG9hzFzJi8llezwknOvGfM3LgkbTJ8TzSsqsLfq3Y5iT7HZs0C6hgJV3K+wflU6tzkjn6ZbS0Rzvr3c1jVUnZ60AiM9mFyLQNn3sPb+nj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358135; c=relaxed/simple;
	bh=IE9kvbCxjDJZUKyAPvd2M7VztQ3BeoQfk1EkdN9+02w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NpGEbecF2djhwrxuYSJPKp2ZdfcLZH+sMthFRXpLSexBvfQeebyAuerZ+Q7YhpgM97n0Lk/Z6BX/+BCFjmWOiUGORmQp/NPayJKgwnVnzZ9z+ZmE75aoldq3b8LVpYZQotSeln+KpKH0c5wKG2Hsp0V4PUv61YJY2r8arkWML2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=Bxi5csD5; arc=fail smtp.client-ip=40.107.7.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHGqENIEPCKGa3oOBJq8I159UH0tn4chPa1unZTzZmn0CJgU2dxe9+rO+cTjaQBaNy9tW9i4LoLVni5avjjU35r0sMOLnvNVr8StbGlVJElayB8n83HYZM+fniCLJNKJEEC6nTwNYRNG9EAYtwx+50F1A9HYDPY9TdDI27iHS/7oBqCr4TqE0ks/APgMBdhT/4VV/VrhPVzMqcHYYl0KGB6WeQbBdZVIi9hsrLEUpzUKh41GkjY19pHh9kxYma9wP4zi9fqdVrywgx5eNo70q3vUXW/tLL9kp+UnrDJ8yGGkaokTsv0gwToGaZnkfEXDX7rVgCPD+WlD0H5cv31egg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTd2zttCEL0Jatn+kk0p2qRQSLKvb7r2vr5LhJCe1Wo=;
 b=kZEe2wXRrnn1Wi3UAKf9wDxx2fB+SJ7pIMbQCT83Xa4KpGv6E0kBpiaxp+F2f4OliJ88RH1bhsBL4q4Co0pJQKyU85tCS4bZ4jNSsPc4Pd6LqRzaMAgj50fzQUccNRCWn3NkdVkmvd4FfzUV7P6iSqzdpBwgtPicfVKY4gtcuWfV4jUYYD4KCJ9gwJN6dMRSHHJw201UcBDcvKmSHdSR/r/4vJ4IJjVPNCMVNAiACWIsd4TuNinJ/MOFqcczZ5qzSY4Pl3OpCg+r7jP6N0FKhMmcxj9/ke2qOtrzUcWjHTXbuXIwe2ZaI+Sz5WHnErdIt06nSKJHROHky88lDinKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTd2zttCEL0Jatn+kk0p2qRQSLKvb7r2vr5LhJCe1Wo=;
 b=Bxi5csD5gICRhU60pST7Rje7aOT+lhf3NDscbWJjT2QLfe14I4E+afkG7xLFOl7xqA/gLjy6qaoE+Ngm1F9WCL+v/Su8FHcahFRdtVFeJJw3iytG3d6GPi3ob8FXuQJY1E7LVR9PVIxIDcdBuLe0hvBkWRBehHbrTjhG0kIdAmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS2PR08MB8951.eurprd08.prod.outlook.com (2603:10a6:20b:5fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 09:15:20 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 09:15:20 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 25 Mar 2024 10:15:18 +0100
Subject: [PATCH v8 8/8] usb: misc: onboard_dev: add support for XMOS
 XVF3500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-onboard_xvf3500-v8-8-29e3f9222922@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711358115; l=2728;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=IE9kvbCxjDJZUKyAPvd2M7VztQ3BeoQfk1EkdN9+02w=;
 b=7RpOVXt3P6R9KhkeBMxUd6AYp2ICertt9EITgGiRMh8+c+NuImwGX7xf3Gi8ubMrQXbGm0G/0
 n2IBQiR3o36BpX7jUGRKVvmQq279qkSTY8Iyzl2lSIJYB5kG7rXjIL+
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
X-MS-Office365-Filtering-Correlation-Id: c68fb944-e692-4551-86b0-08dc4cac182e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KvuBymSB+IutrvjS8f9ARjhLHODPq01QXFnPjj07SCDwxJUrXHoSEjSgVfnWbDn9TETMOcKK3NG2DaKLtohlTu+m3c/GJj6dMzOibkWfa5WZE5UehJc+8zYRstPCJiPyd5jHfxyr6FR8OSQ/ld7s8rjyzmSolCGWtGRyBdDbrtrTa2PeZxm4l4YEXrdYuufGK6dyYblFOUTGtGZyvZ9G/FSnCxZjNpU1i9q6avI72sNmCepdkz0bkRWywij7mYwzUlsFtMIh3gYOThnEzqk+21SnStXtoYRAe86VkKo2wBGl9aPmKXfc+pzwDCmFoK3rMwYZ8QvN6uMP2HOxxkdW5QQtunecuQfkvPwBYoPyWT+BBAweAEquI2ShvNzYEwvOxoloCQSdkm1YhtdTGJN/9FyiZc1EjKstDagJZny9kAoGmB/eB4k0YesftBqNqMBqYTWQxcBjWdnmfQC0G8EHJGDiwXb+cFbDEQ7Z0l8DyHO/cfe4zQ2h3yg/4rfDRsEXJJFOlKj2CbBq/1rxN1ZXnEHluAFkuW4SML7H6Qxz+5BobMXvFD+c/L2XQCLGY5W/dfw4i0qcdp2K4X11Kz227VGwuB0r4K8meosDUOLe07ed/w/F2A1P/GBM3rYxvEqKvJgONVHLFom8S/N4FGhennQy2lof5eM1Qxghum91G1HbDd4w3Yrcf57CnmbZlorz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(1800799015)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGJkWmVrbTRaYzZaam9weXIwTGRsTmJqS0F1NnF0emdDa2oybHhwaXRNWTgy?=
 =?utf-8?B?eThYRS81QkEwOG5vLzIyeER2NmhqM0NnNGNLYWZVdjN1aE9tT2JuZmwrdkJo?=
 =?utf-8?B?bGRoQzA3MGRVQ3VXakExS1Q5Q1JIeDUvT1NCRU91Q1I0eXMyT0VVVFM2SzFu?=
 =?utf-8?B?SElWU3ZDaHlzeWZPcGc1RzJVZVZnLy96ZWI4NkVYMmlVUjU1K2ZTenAzci8x?=
 =?utf-8?B?L3lWdGxHdzFONHA5cEQwYlF2TUUrZ05FVVBoZGRKeWdwQ0JTZ1JiV2w3SGxC?=
 =?utf-8?B?UkIxd1lLdVhUM0VhTHo1MDkrV0Z4MFk0V1J2SFdNMkRpd1c5STZNNUZuRWpI?=
 =?utf-8?B?TUdoT3V0eXJmTzBaLzlkV05oTzNSSHc0S2trOUp1bHBhaFRWSzVDVVErSUEr?=
 =?utf-8?B?enhEUjFFcVB1RGlkOUF2NklGWGVpdlpnRTd6Z3c2c3UzZkptNmhjL1ZkdkRV?=
 =?utf-8?B?ZnNVc2xjUWh2V2d5NFA1Q21ZZlFCYjYzaVg5ZVgxUmxNQXNkK1RPTzd5d21p?=
 =?utf-8?B?c3cvL3NoTC82cW1VeW9NUzhpRTZSYVNFSUdUc1ZjaThaaERXQXJwNGphTkRS?=
 =?utf-8?B?c1hXY1lzcFYzejI2TFY4VTQ5SjB3L05sRld1SXlLNmNYQ05mUzE3ZDgvb2sw?=
 =?utf-8?B?akNvZW5Ga3oyaDRhbjBZQU51UVpSYzhpQkVoK240bVNYV1NWVnd3VkU2ZWx3?=
 =?utf-8?B?MnA3eU9nNWp5YjJ1SG1mYTYyMFhncWNBL3ovVXNnRjBvdk13NGhNcUxSQzNm?=
 =?utf-8?B?MGx5OHNXdlBFVkd1bmNxK2NlUDBzdzgvNzd6TlM3TTVzU0dldERwL2laM1Z4?=
 =?utf-8?B?YUs4NHhVQWdNcXhldkhsM3RScTBYcXZnK1FwTTIyOG0vTWJUTzMwOUVDNUVT?=
 =?utf-8?B?MS9FUDlMN1lmaWpWQWIvb3psdzNZWDlrT3A5T2pwMzMybXl2N1hoeXBQR2R2?=
 =?utf-8?B?UUE3NzA0b2FXTDI5N2VZK0tNK0NCcG41dm5OMUtTTmJqNmY3US9oczMrZmc1?=
 =?utf-8?B?L2RFMkI3NFVyd3l0SGxib2d5U0toN3BveGQyWENNbkN0MUJvZ3pWbVJ5MU1n?=
 =?utf-8?B?TndQeHpDZWNpSVg5dG5pKzkzbDVtS0pFYVhHVnE5RktWT3JrODllekViOU14?=
 =?utf-8?B?QzdzKzlEeWFDa0tWSUltMlJDdVBhRm8wckJXaS82dnpYK3FBSWIvSmFqWTlZ?=
 =?utf-8?B?d2NOZjFjSDB2KzFUOFNYbGEzSkZsb2UrMFNDWHQwWDN4WVZ2cEhVdFBXU25s?=
 =?utf-8?B?QXVkNXdvT2plbEhGV0VxSnJZU1lVOExwY3cxK05mRTQ3eFhWSzVocDJJL0gw?=
 =?utf-8?B?R3M3dDcrTmJGV2N2VmQwQk9ydTVZVVZ0MzJoTG5jZG9JdnM2aHpDZkZWY0Jw?=
 =?utf-8?B?ZmlCZWh1cXhSZWxrR2xpZWZTcDRCRjRaRFp6UDN0dlF2RmR2YURTWmZ0RU10?=
 =?utf-8?B?VVhiQzhxNG92aDROS3RNQ1ZTUnA2VGlLQkZqcGJTTjRITFpFUmRTem9uRkhQ?=
 =?utf-8?B?eURRck5mNllDaTIvYUNGREowSnNVemhXNGxvbnY4UGJTNFp6c1lEYXNnZGgw?=
 =?utf-8?B?cFgwWGVGNDN0L2NWdjdpU1lsSjhiS0RydittaldyaDZZclQzM2djczRzSTEy?=
 =?utf-8?B?MnNydUpXWlZiU3JaR01qNURuLzVYUUN3ZUU1N0dtSktReGtJQ1JSQXhmdVdZ?=
 =?utf-8?B?RUw3NFFWa0JTT0ZqeG4rWkx5MHR6UzgyMXJUOHR2MUhFVjd3dWR6N3RvNUla?=
 =?utf-8?B?MHhPYUd4SlJ1YmdaQnptLzdscUJMT20xNGdxbUdBMjZBV0ROUWx4aG5GT1Jw?=
 =?utf-8?B?OUU1V0tmNXArTGxQNnJSNEh3elRwMHljTkg2VTJPemNHQkt0VEQvcW9WNE9w?=
 =?utf-8?B?djl0ejFjWEMySzZqSFRoNjZjWUlOTkNyMFlZaVpNejFNcE1QT1U1KzlnWDZI?=
 =?utf-8?B?cjJSaXIvd3R2a1luOENpV1lscnpKVUVyRS9ZNVlMYjVaaDJOYk1IVlczY3do?=
 =?utf-8?B?RXFXOGluZWw2T0tXUTkrOEMwQzlKRlAxbjN4S1NMSlpkUTREWGw2alVVS1V6?=
 =?utf-8?B?UElEcVd5TG5pY2R5dnRJcGQzR2tCcVBWQXFtVU1lSHpma21uc2tVcDU1WWFS?=
 =?utf-8?B?R0lFaGZKcE52VWhBemYzcUhOaFZtQ0ZZMlhYOG1Xa0IydE5kYll0VHprbGw2?=
 =?utf-8?Q?hAPwoPin+ME7IHfw0p558Sw=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c68fb944-e692-4551-86b0-08dc4cac182e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 09:15:20.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ouh+v3vbk7n4IQWok4yttzmt9xW41joWtPt0wThHMMA7ZwXtNlTgvi0RPDt/wK8AneaFQ0Ec6SHrvjuesF52Nphtw2YKyXBzlE8yoCOmu5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8951

The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
multicore controller for voice processing.

This device requires a specific power sequence, which consists of
enabling the regulators that control the 3V3 and 1V0 device supplies,
and a reset de-assertion after a delay of at least 100ns.

Once in normal operation, the XVF3500 registers itself as a USB device,
and it does not require any device-specific operations in the driver.

[1] https://www.xmos.com/xvf3500/

Acked-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/misc/onboard_usb_dev.c | 2 ++
 drivers/usb/misc/onboard_usb_dev.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index f72f47edd87e..648ea933bdad 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -407,6 +407,7 @@ static struct platform_driver onboard_dev_driver = {
 #define VENDOR_ID_REALTEK	0x0bda
 #define VENDOR_ID_TI		0x0451
 #define VENDOR_ID_VIA		0x2109
+#define VENDOR_ID_XMOS		0x20B1
 
 /*
  * Returns the onboard_dev platform device that is associated with the USB
@@ -501,6 +502,7 @@ static const struct usb_device_id onboard_dev_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 HUB */
 	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_XMOS, 0x0013) }, /* XMOS XVF3500 Voice Processor */
 	{}
 };
 MODULE_DEVICE_TABLE(usb, onboard_dev_id_table);
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index b6fd73f960bc..fbba549c0f47 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -85,6 +85,13 @@ static const struct onboard_dev_pdata vialab_vl817_data = {
 	.is_hub = true,
 };
 
+static const struct onboard_dev_pdata xmos_xvf3500_data = {
+	.reset_us = 1,
+	.num_supplies = 2,
+	.supply_names = { "vdd", "vddio" },
+	.is_hub = false,
+};
+
 static const struct of_device_id onboard_dev_match[] = {
 	{ .compatible = "usb424,2412", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
@@ -108,6 +115,7 @@ static const struct of_device_id onboard_dev_match[] = {
 	{ .compatible = "usbbda,5414", .data = &realtek_rts5411_data, },
 	{ .compatible = "usb2109,817", .data = &vialab_vl817_data, },
 	{ .compatible = "usb2109,2817", .data = &vialab_vl817_data, },
+	{ .compatible = "usb20b1,0013", .data = &xmos_xvf3500_data, },
 	{}
 };
 

-- 
2.40.1


