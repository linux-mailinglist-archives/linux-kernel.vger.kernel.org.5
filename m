Return-Path: <linux-kernel+bounces-63535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084FA8530D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9261C26A26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0874DA01;
	Tue, 13 Feb 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="NLmkG9rW"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2092.outbound.protection.outlook.com [40.107.249.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A608A4EB20;
	Tue, 13 Feb 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828355; cv=fail; b=a4SvPouk7fVgknMqlCC1jMV6kepTfJwlwJ5yPztIth0cJe8+UquJ+764umYpbO6pt+sfxT/j/gxPHjU7P3i87B9SD8RPmYjJbyMqeYu52+J9CnXZxyg9AdXjQj/G6xv/KgeXQYE4kNiRVeQp2bV/s7V9YwPztIgSf1AebX44lw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828355; c=relaxed/simple;
	bh=us+BUkNVcc5WAPRpDxMwjmjf8a/FF1kxb6OC5y4LrLE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=thcrBhSmAE0RqgOqUxBp1HTx2+PitNdQJaIo7N4JXsmCJE8tPqxqin5c0tmW1vsO7+xeu1LLHmJoTNPFw94MlnE6IngGGN85AT5m7d55FZUZ++pD2ssEYjfgOV8nPRzH9DZa2wnWGdWfuqZrsyTlZNEeQ9bTsIqInFp4IQEPdH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=NLmkG9rW; arc=fail smtp.client-ip=40.107.249.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPYQC4fPIwFFNWBvf37ZaWEmS8pmH87TWfJTiFd9UFWPjNwhVVicSXzOI1LE33TDd5EMsx7WwqxbEYfTeZ2turmpuJYWNDz/BXuWqOMa19mZ7kKrscWUb0zqFohtCLFWrRgq5I2DyBWMq97LJqLq4Wv/c7uC6Ve2aNzggXvrwpL79VrxMqpTBWLcNK6bECzCKb/Wysg+hn4B59I3UoyZ59oBeDGr3O1ASfezhUEq+oN74TT3eZECyQKQG4nkl26DCXdtBRcCsNFh9rVHtqia+J9beGr+3rwoEq/nQPmqhk+kfwg3uLcnEtSFI0iODhtPKCfjAlz/GVsLPUL24aRFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzJ8/X8FpytL3jJzosCG7gaTwOwA8zcEUgZ5mj7NTDw=;
 b=RA/BlCeR39MhapqyVeXfG7rNwMFk9K7dzsJs9hKtbI1cjMXYDdxSfOz7/U5axIFuTrQIVq7TYAhYWN8Y1t/NqRlmrALl1Ersu3rNfDaN7h+gGoG82xVc/faNd7haSyoLtCwIDbA5WIrV/iBny2q8dkQ7AwSI06PTxQsIQMeI1SSAvRWSPctJUvijo8jKXovmBogvhdoSsw1Gbb/hqbZ07p0x6OXXMAOHYYQfw8oKkb2xP1BmP9QFRae6gvpAKV6BTTnaZ0J21bJ8MzOCKReL0RUvpNNZr43GhFgorqqAGc+VyBeuRukAUPU3B53AW5igEtK1XjC0hx/OB4jboRF+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzJ8/X8FpytL3jJzosCG7gaTwOwA8zcEUgZ5mj7NTDw=;
 b=NLmkG9rWhbWx18IgQT19tFjhko8YG6P2GZvsD+45+3lMcO+guP438BR2ATHu0slSzw6gwty+2gTxvtYTgZdmg9k6/4/g2ffo5vUBSQ8iBxmIGB9MrwM19hYJWHKe7im1MTS+bawy4jggm9Uk5e80IL34+R6HP9L7RPSItsAmgWPLKygRHO0SSVdcxbsN/8VomJhPwf3O1R0MJ+YHCVVZRgKdM3y67c0Qtx8zMVyzEHHSdZ7Ura4Wg+VvVlagbhNjZ3aAoVucAZqdclW3VklJRfL2HKr6Tkhre514409/8IKBvtIidV1KgeOM0yfIfw/PsGrXelIW+RhMr2i9+PgN4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by AS8PR06MB8330.eurprd06.prod.outlook.com (2603:10a6:20b:441::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 12:45:46 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 12:45:46 +0000
From: niko.mauno@vaisala.com
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vesa.jaaskelainen@vaisala.com,
	geert@linux-m68k.org,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH v2] usb: core: Kconfig: Improve USB authorization mode help
Date: Tue, 13 Feb 2024 14:45:18 +0200
Message-Id: <20240213124518.20231-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B5B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:11) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|AS8PR06MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 454384b3-4b54-48e4-7375-08dc2c91b304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2NgihREqnRog3lFtDlKswvkccFwRHaTxygAMpsNY5Uy2DX/4CpVvIdvb62Iwh/RBT+gNUNWsn4PUNuDGp+zUcbf45uFupzE0/V6hZ9uiD3uBr3iRtHlvh/yVM5IalYxLiy5euROn6vIti8/fohVqWS1W+IZ8hVXUC/25hYZ4q/xy3/ygW64rgNLOCHZQaHprbjXFBFgsK6vpTNYokAHtpGp73X99AcotVmImsJ9YjlBkN9Xkq301ndepwFVK9SerlBIhNK0bpJPWtItwobqnOSAKrZTVmJUNlSF3jG9tJgaMBu9zU2fy79zAepT1CWhIB7j6/Uw0Ihc38TR+ub47W8Qi7bQjebNW1jF6Jb5RBnfXHPTXmVOsyeyxJOxDwnjF589jPZoWtOWpza1XLDLS6kYJ/0OR4cMs8K5bkw9qpN/GqD1soH1Vo/TPStdy1j/EYzGkwe2XOlyE/doTKKDb4OknjE0kVmX/65wmv35+lXLzmxQBPpjNoXV2XPwx3Fwvx5GuecdtvLsUjb/F17QGRPNAsbN2ho7vTG3NaLe65RifUpmVBNshWSX2Fpr3MBF40wgjGNeg+Pus0B1Kg/Fs+kGwiX7ZZVVxa/mMrSS+zVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(376002)(396003)(136003)(346002)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2906002)(5660300002)(26005)(9686003)(52116002)(6512007)(6506007)(107886003)(2616005)(36756003)(478600001)(38350700005)(6666004)(1076003)(38100700002)(86362001)(66476007)(6916009)(66556008)(4326008)(8936002)(316002)(83380400001)(8676002)(66946007)(966005)(6486002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z9v/U/bvvkTqi+Seqwqw99m1hrUtlUduz72G7g1UuoDVUH9Nv1ESPk1pBo3q?=
 =?us-ascii?Q?SMtuv/WeX3hIx5OBB+LboloIYsFcnql7VHnab63OUzxzRC1LUKNlH0PZxHm8?=
 =?us-ascii?Q?dUhnzESdkO+Phd9N2U+kbr5Te2+n4AtS8AXlRBbpD7ztYLYQ0Q3vUdbwOkGG?=
 =?us-ascii?Q?ttJReMfELMCOUAGKr0pI0UDqSrxK0oAAJ5cYL6UHsZ4nZoKv9Dquwn+ElQ72?=
 =?us-ascii?Q?w6POEuZJq7yx8gj9A44g7C2KOJkM5gR0zlxejIJJW5qEh6jsCf5AGbYAfKQ5?=
 =?us-ascii?Q?z8vd0esg9SeUKt8gfoDlfRuG8jIJ2cbZsA6I80YJA38+VTw1CXJCW1wTbWSZ?=
 =?us-ascii?Q?9b3o8+qUYcgmJ3YdZ/ddCJFTFoOlu06DMVPwhoGe2KAADp00ZLHcCg4xLSyj?=
 =?us-ascii?Q?D/sJ7btfyGss4q9dX23hUm8hw7ssIhTFChvswvAMBbxULJNeTuTlHJWii7qZ?=
 =?us-ascii?Q?i/thFy8Tlzd+z6eaONSzNeXriAJrHI6nm0GLOhZkpcVcOXTriDRnD3HVR+aJ?=
 =?us-ascii?Q?MgyfFBuV9CUE2yjW9Jueam+SRGe+s1Sw2w+Yxp0BBrjaZe3/MO+dT9SJFXO7?=
 =?us-ascii?Q?fzZi+5yC3OQdP3YgiiGSCT5kNzjVD3mbzzQYoqSghrEbQvV0oygP9d0ZtIAo?=
 =?us-ascii?Q?U9Kh70qPGaxrS69+kgkBpVJZW5mQ813Vt98IMaWOV8hvF7HaHCXH51RyvjO3?=
 =?us-ascii?Q?1uG5Ogf95/wa+q956K0lTDqTcucJxFBfYr/NsfNCP6G0g2vTgwIUCKwsuGvI?=
 =?us-ascii?Q?fux5+Pzjx8WkAx28U6vl9lNSJUUSaf3PN3515GbEJZs+r/ZktdbDxL4mG9MX?=
 =?us-ascii?Q?fcM3Plnql9AseqLxtn6zMe9nCHvCXyUuEttULR5CsSdp9IwwGvGER/pKhz0c?=
 =?us-ascii?Q?zshmQZKX9qgOtpqxRZnk1bsZjOvHzL98SbRtbnnutZhFYcjJBZrq0WY8XKjC?=
 =?us-ascii?Q?mFLruAOJsmHjk6GKDoytpyh0s0Vnp47DWxpy82N6L8rVqXw2c12XTnVGpkl+?=
 =?us-ascii?Q?0Fv9UbWaSmHTbhrTMCTO4yh+as0O32ZvDBAa01/0k9ZoZ0OseCvgRwJ7ErOX?=
 =?us-ascii?Q?SFv7ztItZ7/3mlzzPUoLDDTQe6NcW0inw26jooIkqO/aiudRyVpTX2Wq+pYv?=
 =?us-ascii?Q?ZuR7MTbCh3In2obySWyoTenKCqg5sJx6WfVhu2+fBWS0vfAnnk3D9EMeEmA4?=
 =?us-ascii?Q?m+EZDupJNSUF9Nu+QJn6cIG5OpyQF1FtKQgoqhAmEjmvwF9UiNW7sn0AuFB5?=
 =?us-ascii?Q?JdRlxIa0KVW48hR4Bj5g54FebqN9Ffcio5eDf/WWx1LnLWuRCGmm8R/WsPg6?=
 =?us-ascii?Q?rYbCaBCh+H4n4/72ns2O0RvuWBMMF6NHm7Dz2EGtxRikPGWXbSKq4PcNqEoB?=
 =?us-ascii?Q?AW927bNZwTSXfOMhfvC843nmDV3di3ZmXGVG9pG2io9JAo33nye5QbvXOPvf?=
 =?us-ascii?Q?u1LzYoJXfjopDkirEaH+xryMAgpzZwKLSD7mC/nOYL/nnd2JXbH0YZZlxX92?=
 =?us-ascii?Q?e2eKDg9j1qjUi9ITGksVCt1fCAtGro1TiyV4JV2Zua8yS0V+RQ/a6Ra3Lv5w?=
 =?us-ascii?Q?jRlBDNyYGfSyim5rpx+nB8zYoRQt9KeMfds7idJMGkGHFmtModfd2itPRSK+?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454384b3-4b54-48e4-7375-08dc2c91b304
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 12:45:46.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuLX7Px8F+hTE+ifJos/7Cxm6X1eLUDYQcqLqHo+P1d354wHI64P/Mef4/Wz1PtYjsWabLy9CTreDwTgoRESVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8330

From: Niko Mauno <niko.mauno@vaisala.com>

Update the default USB device authorization mode help text so that the
meaning of the option and it's available values are described more
accurately.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/linux-usb/CAMuHMdUy793gzDVR0jfNnx5TUdJ_2MKH5NPGSgHkytAhArtqmw@mail.gmail.com/
Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/usb/core/Kconfig | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index f337aaea7604..58e3ca7e4793 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -126,10 +126,20 @@ config USB_DEFAULT_AUTHORIZATION_MODE
 	  Select the default USB device authorization mode. Can be overridden
 	  with usbcore.authorized_default command line or module parameter.
 
-	  The available values have the following meanings:
-		0 is unauthorized for all devices
-		1 is authorized for all devices (default)
-		2 is authorized for internal devices
+	  This option allows you to choose whether USB devices that are
+	  connected to the system can be used by default, or if they are
+	  locked down.
 
-	  If the default value is too permissive but you are unsure which mode
-	  to use, say 2.
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
+	  If unsure, keep the default value.
-- 
2.39.2


