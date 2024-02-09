Return-Path: <linux-kernel+bounces-59173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9F584F28A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9942D1C24368
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF769944;
	Fri,  9 Feb 2024 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="2ecyflnS"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2113.outbound.protection.outlook.com [40.107.20.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372D67A18;
	Fri,  9 Feb 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472061; cv=fail; b=ehNWXU0MTEFzxukRva26PWhATp1Wn1XRGSiGlJ/XCZPuZXkJG+WOC/q0yLxnoo/CgRtX2dwjE2EcNu7JFYZ1EgPZ6ftiOsFdJ3Sca8uDaiKU++nEdqjzWXVyKhfKwfJbK3EsbU8GLW09c2otREzReUJHJC8Wm2eW5cQ48eMwNS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472061; c=relaxed/simple;
	bh=vOhchZ/R3lpT5SLM2iqQwtRTw0jHWop3yJA4VK2aDG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s7XVWaNl+UHTqWhALkdPKYe2hCOw+ax8Pa4oOMRtclh9Wy6ZZWSR0s7bwupuJk1wbAoea9x4vGe7WzuKXQ3tmGlfyinENB2DlAlf7anis8wf+roUD8raBarA3eHsGHkm/RGBofBfgNtmEkSRWYQtleHZhP8/nICw1kRuZOEtP4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=2ecyflnS; arc=fail smtp.client-ip=40.107.20.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEc/Ej3iQQSzIstT0i+WHbUna4AaeWHW91cDXyRtoC25SI/Y96uTxvzx4BU0i6uVGv3uqvMdqSOUva1Y7tBRHXxZVfA1BF66V5ikd4+JeIp0X92l9kYLdbvSsOBztDn5KXXTcj4x2c3rx5MjCwJ5aWtBq6Rh9JPO05dA0larL9pXODHRAmOuqLz0xHes4svivEtYplpqa8hCACSV45yIlSfkP2/hiQ2y8xONAZ0KW7i7v7pto2OYjjk43a7hhQJahWkM+ImG6HczMwT5AHHQSR6A4Bk1kR8f0c0RKCO6oG15i2qRejUkux0oZ+XOiILBjrzBjtvbpo5x77UZK78Seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acJ8HZIWJZ+ezTcst3aQC8CI9IpO6/Z98Iu26Hb9/+Y=;
 b=giep1Jy088oKVgjQRah5kqcsVifZ55bj9ji8BH+H+OCPBduNwkpvTLQI1Qzo5xpdfDRH3SM2T7McYlGByMYkLmY8dxIPQaZ4qo8/AZuSc5QqFmKs3qb4eSzsEBCj6c2KKVupZgrQ8FhjzrkPsP0t3gH021W7OlNG3AMVkykHl2VkT8yIUZ0IoshWvFT5GZAdhDKJvBOlrCOIKxvQmhHx0CWpJ41RJz/GbozPLHedafyRn8EnlyRqA+LGGIKWkSiiN8AD9cNXbu78V6m4ZLldow7ISn5htLSmF46hdreN8aNPwjaM3lZ2cTw/CrQswtgueXAzrtxnYEgcHHSp7evPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acJ8HZIWJZ+ezTcst3aQC8CI9IpO6/Z98Iu26Hb9/+Y=;
 b=2ecyflnSgWmpK9HoBJ1RS1toYKsxWUVHg+0Nu2IqB7f+grB/Ht3LEx8Lb1hgpWGky/OA/SMfbeMCsbdiYL4oS/RYzFITkcwHHkxgc5I6sJHPbPsKLW269s8HUUFv5fzHa/1WrtWx9DTZoUnYYSsosif2fTjGLGAmj/qnHpLYf92JhF1CovBcu/1xSmNyhfWiJa2EyXZbHG8P/FCrgc0sR0cBezgLxVFqRYFgpi8ruxVyOJZ4CHyhyxQ4ZU5Ihg9W5qPVfQdlFaqBNZTkkqERa5kVp2ffI99clBhfP/EY6PjaxlXygJeBI69miXjT6fePhKM5eUD6HqUKFBSOHYyYvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by AM0PR06MB6578.eurprd06.prod.outlook.com (2603:10a6:208:199::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 09:47:34 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 09:47:33 +0000
From: niko.mauno@vaisala.com
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vesa.jaaskelainen@vaisala.com,
	geert@linux-m68k.org,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH v3 2/2] usb: core: Make default authorization mode configurable
Date: Fri,  9 Feb 2024 11:46:51 +0200
Message-Id: <20240209094651.5379-2-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209094651.5379-1-niko.mauno@vaisala.com>
References: <20240209094651.5379-1-niko.mauno@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0043.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::7)
 To AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|AM0PR06MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 11aba808-819b-4f8d-6bb6-08dc29542406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h9Lha8mAk9QIoXnebedRcVQF4VLptSFvsvdw9H0OcRWuYX486k9cEujkYz+1nc1gQI28Q30QCyirokzfmS4FxFMl5vN1gHSgrtxxw8jyGutfqaNh8hd7pGRirsik0kCZ8ICM4t4jTcj9LBux9w7fX255k+BCv83SZSXcI2WXHek0UGDJNp7hNX1HlL3o4vAvbCSHfeOkA675Ud9Dp0Rh3oyPXWZnuYFMgvKeSq3xsxTwAM80+0xq2GPk/q8ql5dKHmRoPIcitsgqQDasThhSPHEUF6VRm9uO4GnADYB+U5kPy7hJhQKh+96lNjHMykZ9vHrCgW7lYSrRK2JJU7JLPHqrkkEVwe0wZuENjaSoeepKNu/gX1dLHGuwfTnxQrCt7M+my1iSQyt3nMb8YRI6iUCe9eSzatQBzZO+l0BCOyoa3cxYjwgx5CIxtBIBoQe5We9//KuG9Xrk5XdI121P+f4TneW5X2r7VQ3qdp+PLGXkb6uYOb4dnrroACB5+WSenk7PjidH6yAmIpIOcwtNoBq7kOT0k0z0tEmBBo713HF7bRpvN/a0Q21XQVtTf3M5Np9JaS85LxUpE4gqNlrjWo3NwcWuRQQYpZmjpVNYnPKQVAEp30QcbyIU6B6m0D/9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(66946007)(6916009)(4326008)(66556008)(8936002)(8676002)(66476007)(2906002)(83380400001)(107886003)(26005)(1076003)(36756003)(38100700002)(86362001)(38350700005)(6666004)(316002)(41300700001)(2616005)(478600001)(6512007)(6506007)(6486002)(52116002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S932HNzDKiFPagAyChql44PWXwcvu0nzxp50S9oQycQsOvrUdcTSUUvnjB+6?=
 =?us-ascii?Q?Dt6aTZY6CatvNVf7OCxnqLibP6uppmRWhEs79FWdCzEF1KHe7KQyQXaV+avm?=
 =?us-ascii?Q?U4x3WLRlMiqQ4yhLcMBhLDwaU6GFV6IxW+mLj7Bp7picvha2cAu+gTUXSrBx?=
 =?us-ascii?Q?iSL4PxLAw8ZC8XlO85gSo4qFdQyDQHQm/VXIJm4jM3ZGj42SuzDgwAeuOvkh?=
 =?us-ascii?Q?Dy2KkOtLUF65n6mIDUHjGzmbluwkCagxRJdSMVAG/schXKS6TAJMs9leTLmu?=
 =?us-ascii?Q?kobtK6vycVvd/UsIdNr3PPIfIRf5nRrDHacerwqFAnlSu+THb3omw/mZCTdF?=
 =?us-ascii?Q?xCtBccSRikWPnKt8benV1UzYBSC9u6lI49av2q2qdw4nem+zfApALkGOAF9s?=
 =?us-ascii?Q?/G3Q+VQGDxtQQ7SVvsRjXfPTyHCVk4PsdZMcw/ZobGqfil+uhzzJJqUQfBo0?=
 =?us-ascii?Q?EA5W+ZELoThaf3xVOPJwnajvl7WXbMp1UY1c/zBchFrxoflAKap/hWplGS3I?=
 =?us-ascii?Q?uyq/mqnaFy59h7rjjMNFCaH2RktvUkhfEasNjkADxcFlUi5J61bcDtW7SznO?=
 =?us-ascii?Q?FlnVq9YaFHn4CdaD201DVQahkAEnA+5+fos0HsuC3FHXwQ0esCOdJY4xdrH6?=
 =?us-ascii?Q?Z59SHCcjlN5JFaDH+RQm31iHocmcKV28CBhz1yq1lCK9sGoO3G4D/T8498LR?=
 =?us-ascii?Q?/RmKRCBfDNH08NdsxFb90HxECCi824znSNUTZu/1T1H7+/vWZtwwcFmGxXFn?=
 =?us-ascii?Q?WMiQ31UD6nJ+4Ts0EY5vqUUkHTn13sV+Q2TnhJHquJV4breuse0MGM5dHb5w?=
 =?us-ascii?Q?S6KbuVDreRJi6J1PyPHf/X29OXJi9VjsqxoW03mjwQkyQKjidAey1oMPUd30?=
 =?us-ascii?Q?mxc8iHf+9dzyN177PIP4mPbu7oisQS/k0YE2IjP2CSanjOUep3fBRyZonb7A?=
 =?us-ascii?Q?INSKZf3MUaEY5nzwUt9yfp2XbFAh1mC0g5wne76YdgYpvQ+yHsF+BCtbtgto?=
 =?us-ascii?Q?oLmAD2DFl5WrBFM/jZ3lV58vAzi5w8O8N3dSrz49akgXoczv9R8HW/f7LM8H?=
 =?us-ascii?Q?nM3Xddq/91T8BOemvB2BXlOHurjdn4klQ0detEiDyHIVu8RFzH+HYN+wTr4z?=
 =?us-ascii?Q?9xP0Q07LXUA6ZSIDylH2DYlkIJk+92F3RU9NwFIonlx5MDeJWsV/HiVTkyz6?=
 =?us-ascii?Q?trNGZPsxvV6gCrcF8QO1vlkiDlXVeO8o/AKBlwhR1d9lorO4JeNweApZIfPS?=
 =?us-ascii?Q?C8OLyFfvcPc7/O0+YpJPUxJg+H56RtuIwRGeuySB0JzD/FufLITiXyv6O35e?=
 =?us-ascii?Q?LO5wEkFk2staR9jiHw3A8Y4vtcH0iSMuHcUw8Ja5+dwbwE7cxC9CYG6aOvG7?=
 =?us-ascii?Q?EtR1vYJ39SceUAN+sVJ3Y+JnLnXlF5EW+WdpsfXeZCKmWG3r3oZ6r0C0Gqee?=
 =?us-ascii?Q?MMcZT6JUhWrhDmAE/ppj8rLPINEa6Dg8XRFgf4GD4dzLMpwamUaHHguULlA/?=
 =?us-ascii?Q?rTgX3gvwy4oItMvURV3OJOR6JSCVHeLaEJlpHjB1TuZhUIzblFDxNRUy/AH3?=
 =?us-ascii?Q?xMSULdp5j7XLqalMvzQuAyE1hlR3V0GluVbvsTCgpVU5VOrgEkSqqX3cIQXS?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11aba808-819b-4f8d-6bb6-08dc29542406
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 09:47:33.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5tVmplTtPnK+vszcWTHMmbOsjWu549yFYanppZAxT0nfZNWFjWpLhSsQgoY46V7I1j7LGHpG0MtfnsO8gUvSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6578

From: Niko Mauno <niko.mauno@vaisala.com>

Make the default USB device authorization mode configurable at build
time. This is useful for systems that require a mode that is stricter
than the standard setting, as it avoids relying on the kernel command
line being properly set.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/usb/core/Kconfig | 28 ++++++++++++++++++++++++++++
 drivers/usb/core/hcd.c   |  2 +-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index 351ede4b5de2..0bf425889c10 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -116,3 +116,31 @@ config USB_AUTOSUSPEND_DELAY
 	  The default value Linux has always had is 2 seconds.  Change
 	  this value if you want a different delay and cannot modify
 	  the command line or module parameter.
+
+config USB_DEFAULT_AUTHORIZATION_MODE
+	int "Default authorization mode for USB devices"
+	range 0 2
+	default 1
+	depends on USB
+	help
+	  Select the default USB device authorization mode. Can be overridden
+	  with usbcore.authorized_default command line or module parameter.
+
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
+
+	  If the default value is too permissive but you are unsure which
+	  mode to use, say 2.
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 9aa5e6bf9b9d..d56597dc7d42 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -357,7 +357,7 @@ static const u8 ss_rh_config_descriptor[] = {
 #define USB_AUTHORIZE_ALL	1
 #define USB_AUTHORIZE_INTERNAL	2
 
-static int authorized_default = USB_AUTHORIZE_ALL;
+static int authorized_default = CONFIG_USB_DEFAULT_AUTHORIZATION_MODE;
 module_param(authorized_default, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(authorized_default,
 		"Default USB device authorization: 0 is not authorized, 1 is authorized (default), 2 is authorized for internal devices, -1 is authorized (same as 1)");
-- 
2.39.2


