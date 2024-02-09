Return-Path: <linux-kernel+bounces-59460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3FB84F75B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9087B1F22B9E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154969DFF;
	Fri,  9 Feb 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="U/xEDka5"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2137.outbound.protection.outlook.com [40.107.247.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500969D34;
	Fri,  9 Feb 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489033; cv=fail; b=fiE8Y0O/ZptZ/4ZvGFR0bjR6ZBoGbWU+gvkHZiQRXYaFZMT0BuwhzzGlPCRqDISLRxVDz4vavwzLmM+mg1PwOQMVgcU4QIcqBunGt/TLL0Y8kPpzDaOW1mXF7KmuXunlWFPcfrBswKIqfGqaNck1kc3aZq5Fneg8X8a2DTaBvcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489033; c=relaxed/simple;
	bh=U2phM+abfp8+ubwzCaZiw6vNdkIDVJLH5OsBGMcwwrI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aWmQLoz+9Yu58NyBQmOWxDi4F4aioTzRkwiI0Na+kHpeOL1nNguk5jODLw8HnLQfUrEqICp9bAIhKdv8qxqbRRwKr3+e+wPqAhcocI9ju6tq3qd5ROYYydXdebhe14Vp6LSh8HnYavlDD0s44S8wkow9gjsH+Q5PK+7zZB+KtTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=U/xEDka5; arc=fail smtp.client-ip=40.107.247.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0PoBC5gFVScg5jwVmirrKGHf50owOk167ewxiMWjDQYVA6mY9AGG0no7sDcs79/iuNPq6mZLOY3QGrjxdEKbredoxa2mY+0xwQarrvc0xIP3VZ4PgFpN7PELu2YpZHxwUwChk7E8KlwlahrxnQZluvHjiVWzv//IeDlBx7NYHTHvQQeyzBkCYqnJKc5uNjj7T/bA36s+36MoVv9uK2VsPDeSsynQbo6EqizYR8cburE+ABhBaXXxgcEccGafYtdAmLHi2LbfHSJfRkQggzzNKgOKxJA4GzekWJEiSzbNXWaQVG/cPSyeKP//QJ8rEVlyx2acPtsYf7zAynVVVcE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfJVkj8byHgGgoRSZY/a/EQ+ehk+0NqskUsJfzop2vg=;
 b=CM6g71ndSLYqO1QEMF2XCsm5zyi+Hz6nm7GLMT+5oG9R6sBfOEfDsXyuKFhb7fZT938Okyr6ubcG7RB68FXtUDrLa4MLHJxJTUZTtuKZ79wlIiSPorEsIEaz1cW/yDhMyh7ct1QyQiLRKHEHRDhseUb506XOxf8m87s0AXb67T48t7BY+9gpYTTYOPRZSEs0t0p5c3N2qopY3Bv3f2x9x2pJqHUgK5f+tLH5iDsORk5QO4uUwmEyw46diRq5hCB/pjaeIlGWMg38Cm3BqKgDIjBNSC4m7W2XLXXdDmfsVlmuJlU9cXm5h6bGXW67nTjDKctk2z1MVP9FB7CHaERkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfJVkj8byHgGgoRSZY/a/EQ+ehk+0NqskUsJfzop2vg=;
 b=U/xEDka5As+T9VhtlQXyL+C+4aQ6oefvuQQpwxIKJbBMLLqS7If5oiS1IV9QGhW1it/GQg4xYiNSIgzz1JNfBXaYVqZmT8XXzNiLh05smp6eQXYR6egbzhptdLG9m6xHS3atG+QZf39PWCcBQnWy4kr/XIxJDInUBcFBGSumMYwuAW1jg0UWyGoZyPwjzkCJeGY23eLQuuSt9bM4D9DJLY0a3HtiRSgNdB6x8akzmRqFCfTqC/xGyARFxDbcIkcExHXGAjpLHBgJbG4sPt9zZgrmj7O5qSX0k8QrMKd0VJa2QI6Tdo8rk6GrR4o/leZN1YKi+djjrTQBspI0DtqlWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by DB9PR06MB7386.eurprd06.prod.outlook.com (2603:10a6:10:252::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 14:30:25 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 14:30:24 +0000
From: niko.mauno@vaisala.com
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vesa.jaaskelainen@vaisala.com,
	geert@linux-m68k.org,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH] usb: core: Kconfig: Improve USB authorization mode help
Date: Fri,  9 Feb 2024 16:29:51 +0200
Message-Id: <20240209142951.27195-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0117.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::22) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|DB9PR06MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2ba728-1159-4062-b979-08dc297ba700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7sIc96Fwm0sDiieXbZdCAg2jmaTTG/CCk+qdu5ebnt4HyJunTQ3s6hoSqbl7R6KiBeRWsyr6Tz6gzLm2QbozkfcksT1vrF49taoD7PvnlXMjqmiS7NAkF3Dh/lNK7YgT4ZCiE2BtbXcPq7fuMMbLPbdnqhvtmEx19wIasbfcMsKF4ZnftHunq/blG06eu98Rbhpf6C5I0bocpNTOKh2C0+50hcqlSIwsx1CeACwrq7G04e+zlAuH49UVQHICWutB6hOg7HVmdq8fibcsCypsIoRxLuKPFOYEYb5ACO7GZqqZzepp2cuwMiTfO8j8ioRx4MrytB83PGoN20JbIPcXjpQ/tcOFqnPnn0E22c2ZFHJLLgj5xFq1Mm/Rc1OTZTy9F7ASWFV4NXpipZPl5yZoWDu9kG2VoLDAZE8MTTS7IEsst15MPjrzA2Y91dzGxR7j8Dou9drun66ZDMPHlXHZnVpkTzisQjbyLFRnBBOPa/NJwdYy6TlAP6dCrTkoJKj3Es3gTgpSeSSWgvo5lUhK5To9PQafL4MrjpEt9nc1hhP0KvsakZo4XNpffnCLkEm/NeX+11ONhXJazMpbBFipG01HcsQGe/28TX5JxUj25Q5nq+bA9ZqseSHkUCRNIC2W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39850400004)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(6666004)(52116002)(2906002)(5660300002)(316002)(41300700001)(38350700005)(8676002)(66476007)(66946007)(478600001)(6506007)(6512007)(6486002)(9686003)(66556008)(4326008)(8936002)(6916009)(107886003)(2616005)(83380400001)(38100700002)(36756003)(86362001)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gyTmNr9hZs/OSSr1RXsFaVmiyAWeWPlmOkMihQfaHzzkmqTZ6e++HfyPKzCd?=
 =?us-ascii?Q?a+ajbNTNTr7WxP4ycvZGHJlNvYQ157JY0EuKCVgxpClJlWAIJnlwrN+t+CFS?=
 =?us-ascii?Q?a6/ftDOrekV7Zi5JLXkNXIGib2RmoWKrVuotGvVzoaK2bGZzLCi8hIHWyVvO?=
 =?us-ascii?Q?bn40neYgRPLpx4o/r/X6vzxBvtOGu5QC8yW/UN5t6Cb70lmNVsNT5SxI8ogF?=
 =?us-ascii?Q?QMSskyqrmLjHd+yJpteK5fzMwnx8HiVdAhqfMEV0MP8/skA43t5ns7Q7unbX?=
 =?us-ascii?Q?JAkeXtHu9sGwJErATaA7yg1Rkljv1A74ltfzVdw2XP4LJiS4QbCO5Iaa2pn7?=
 =?us-ascii?Q?XXtIlFF8A1bFo02Sxm0B/IP0Br3dm6duqd4vVvDZ3xiVb99aGWytibhuPZJV?=
 =?us-ascii?Q?JKFHQynDIzSMHrDFMpeqLHyRcPMfJVPIrY7+Xv5YDJPFi08ZPZUJZcZ2Aszl?=
 =?us-ascii?Q?XJIHumYTCl+cbNXRtJUwBl0Z5qvwnOLGY3lsR9fvSMPVLww6svSsnIl3aBYK?=
 =?us-ascii?Q?RTe1SWuXPyznhjYIvZFC8o0DZh7DA7N3vn/bJalHKJVw2JcXjaAaIc8gOLSR?=
 =?us-ascii?Q?ixsjAKRyOpx2E580/Q/bb5mZ0bKWzs80YHtaQlip3XPqyvdG5Go6x5ZQZMvI?=
 =?us-ascii?Q?3OStHjKnV9Wwa58Jwi9WgFZGZUbtEOEEZpEWjtVcFlYVK2FB+AwdaoVJrn3J?=
 =?us-ascii?Q?YLC0sXYLbd+n+++qfrPf+n8Ww2M9BTtZAQpkySW8xY8bOZ74LF0GMSCvQ+RV?=
 =?us-ascii?Q?wLxJd2xnCjhaR29osxAEzeyzOzvmJIzVcm3FP7ZK0GFVyQu4KF/PhtV34Dw6?=
 =?us-ascii?Q?7TXQ+7l8Y51TgkeRksk5jsr5vP+CgabMcOgcbW6XVA8fg+Tufs6P2BDSMF1m?=
 =?us-ascii?Q?YsC7/bazV2GQzXpXYUJvJ2ZzHT0VtPp18KXVAZHfW78I5OiYR5q4NGc9SdJO?=
 =?us-ascii?Q?uMJkiDiyYzNIhJSgJl4HzP1k/fbRgDQAzApTnLKQj/z8E3VB3Ux/+AnkE75w?=
 =?us-ascii?Q?3buE+Vq2Ym3zZyuYpebxlUCSfRO0fRKzntqePpkI4Ky0VoTC2ZDocTQUHB7Y?=
 =?us-ascii?Q?gxq4vlYoJDVOHJ24S2/gxq2bW6vEv9QSRvPGA4yd7Wxa5hB+NPwmwiRNv5iK?=
 =?us-ascii?Q?y52pOtXEcVSrS+hK+NHEu3aCzdYEcmVzCRhtexRcBoID8A4UKlPRsVJOJAcW?=
 =?us-ascii?Q?eFwcWUuSZO5lFO8XKfsqCkzR741egY0BrCeWhqHHMPRNEyVYWSx0kDaeLrbf?=
 =?us-ascii?Q?Me5NCnfd5GKgfgJP8xuLScWfv97OHhk7zn6+RDHlD6ApP2KC9F0WexKhd8hx?=
 =?us-ascii?Q?Ng/3e1ljebo9kir8+DMjs8KHVFHoCN5H/PSwE3aNWLCfFP5Wg7nBKzkGcqNM?=
 =?us-ascii?Q?sC6yjQi+kF4srhfqHI5MQF90rZM7Usa6f5+y3hyYD+dWms6otVHO1k7bTrq/?=
 =?us-ascii?Q?vfAo0IoOuxXzbE04n2waBvXhPCTX2OIx7UAPj+s2q23w/a9y+NvvBYziyA/u?=
 =?us-ascii?Q?CuhVL0NwgnssvRalCs2WcIfIJk8+7ZV/JYMiN98I0s7bWjip19qj5h1NSBqU?=
 =?us-ascii?Q?KJawtA6apgpxhHY2fVpWgv+UTe733uTNAH3mW6BlkDRbAXvYOShr9Wf6bRaG?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2ba728-1159-4062-b979-08dc297ba700
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 14:30:24.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V40cMP6LwAmjmKLj9AY6axx1E4lGnTekyFRh0/PTFzsd/ir+BDVctNt518AMeg2im4QDOcp8DNN3zYpyE6cgjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7386

From: Niko Mauno <niko.mauno@vaisala.com>

Update the default USB device authorization mode help text so that the
meaning of the option and it's available values are described more
accurately.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/usb/core/Kconfig | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index f337aaea7604..4665df550d36 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -126,10 +126,21 @@ config USB_DEFAULT_AUTHORIZATION_MODE
 	  Select the default USB device authorization mode. Can be overridden
 	  with usbcore.authorized_default command line or module parameter.
 
-	  The available values have the following meanings:
-		0 is unauthorized for all devices
-		1 is authorized for all devices (default)
-		2 is authorized for internal devices
+	  This option allows you to choose whether USB devices that are
+	  connected to the system can be used by default, or if they are
+	  locked down.
+
+	  With value 0 all connected USB devices with the exception of root
+	  hub require user space authorization before they can be used.
+
+	  With value 1 (default) no user space authorization is required to
+	  use connected USB devices.
+
+	  With value 2 all connected USB devices with exception of internal
+	  USB devices require user space authorization before they can be
+	  used. Note that in this mode the differentiation between internal
+	  and external USB devices relies on ACPI, and on systems without
+	  ACPI selecting value 2 is analogous to selecting value 0.
 
 	  If the default value is too permissive but you are unsure which mode
 	  to use, say 2.
-- 
2.39.2


