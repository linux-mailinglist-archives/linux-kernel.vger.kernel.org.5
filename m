Return-Path: <linux-kernel+bounces-60922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 551DC850B05
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE392812FA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761CF5D475;
	Sun, 11 Feb 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aB2YFCzL"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01olkn2078.outbound.protection.outlook.com [40.92.112.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455401E860;
	Sun, 11 Feb 2024 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.112.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678315; cv=fail; b=nVSisIoL7oEeB31OiVvqXtGbnSN+vpd0aODlsJz4U1xPNDDgaAJIHzfYuJMe99Bci2L2oXJMWNpoV2niTTwkQRvuJVESJpnnH7XaHsFX0ipXIfHzThz/FqWXa2fQ8/KsPOCEFo42xB2FDNofBkcRjkvcGQItw9M46H7f13/4xL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678315; c=relaxed/simple;
	bh=tDV0hh1doTpKcZKeNL1IcJmfz89148qyoYZ7l3QGgbg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gSE7L4zPADRMAsBB3/E9Jdo+weezG7T4u5znCgT2ndKb0RZC67hq/ufqecN01KF1BKXhCny19rBVNxx65HlOBf8mQCMLH8b0WVnFc44ZhFSpWzZ7hP9ot2EVY+2ver7AU+ZHfZHT/ztVzmRTXGFxWi+/uMe4h4EXXH14X/UzC7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aB2YFCzL; arc=fail smtp.client-ip=40.92.112.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dz9i3leV09ToIoVdwuqaSwvAU6WMpPtGo7OsRaHcFyIG1GQLCFWyBTkfAjo8TlW6inCXQ9LV8wnIZHDnAYM1cYt1RmN+b/MkBOPes79CzT3acpraG+xAZU1wpekjkU7Nkj53/ajNHZ0TqT/b9j5tx8Nv2kiyf9bIwr0lN74I1I80birMSQODvrFtNoD3Dok/lD0BjLxF7rL6ervvY2qd1tj1pigtUBXVO7qcC41gIHzy1TdoxEjoFxE9YTFfg3tbEkarnmuFomyJ2WFZp9R9dVuRUQgbLeRReVANx1voh01zKODJEeuZ6BMOWHwtm8EDhIuqFzathlBs0IQIVE1plQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1J33dguXjjEfP8faYflNUYJmQ0+hIDlKLlS7EJTOJ4=;
 b=OTsEdD1ukEBrSEck01erfebMbn/NMuJiBzg3pqDm6VgGtRwUKT4W7j+FpUdrgDDO2tdJUIjohVIwC/HRYTBsa2ceji+loAB0urPeb1F3FsvNkIKDI3AY9JM5Lse7iiVXKzh+peJ0TJx4qDBJw7pQhCjajrxsGeA9immXy8W3K/YLTPIDLrrIRQ9AD7OArIlWZMzkYvs0dNSyPymdflzuOEMwf9fEue+EVkMvDuMp2gOUqj+B8+OY00QRVq33ntBJ2lF0f45Q7y8RdDqesrIiD/Sk8Zqd/8SfbIWCuCS23F7yAoIR7veUbFlv/WamZhVdOMPLLNXLnjqJ1IWz0+aSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1J33dguXjjEfP8faYflNUYJmQ0+hIDlKLlS7EJTOJ4=;
 b=aB2YFCzLZD4dTBx2T2l21QyONwJ0e10imrunrXhcvx6Bx4HqC2p3TndG4/zuRbnV+m0k2KCpXv0t64dc8Dpn9B9NkOAErwciK7s9AaSYaXGcLbp55cLhiTy6Kf77YNRj9rv/PrNgHiw62fVw9XceyTJiW668fKe5VfR5KYchRdVyuRUX8Dz24x63BLOg3KmG71ttLFTJ2QyZlZDzw9blQ/xDqktNpXg6oPa0xgbHWbI7Eb598aMaWJWCCw7r24Z3viUW5vhCgeyNl4kHqqNVJW7gg1VFqsNNh+Ra3Dj7ECyZlt+UzkCCqw2oHtp9c7NvjVqL0CEAd7hhhAcs7oEGPA==
Received: from CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:160::13)
 by LO3P123MB2970.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Sun, 11 Feb
 2024 19:05:09 +0000
Received: from CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM
 ([fe80::7c41:db74:a67f:86ff]) by CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM
 ([fe80::7c41:db74:a67f:86ff%4]) with mapi id 15.20.7270.036; Sun, 11 Feb 2024
 19:05:09 +0000
From: Manuel Fombuena <fombuena@outlook.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>
Subject: [PATCH] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Sun, 11 Feb 2024 19:04:29 +0000
Message-ID:
 <CWLP123MB547355BA62AD835719F60865C5492@CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ldbW6JTgmcR5tyVfHtBjg9lwVJNPrjjWH6PQR4hkJfYCuYCm1Sxv0InKONi7se2d]
X-ClientProxiedBy: LO4P123CA0039.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::8) To CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:160::13)
X-Microsoft-Original-Message-ID: <20240211190429.84457-1-fombuena@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB5473:EE_|LO3P123MB2970:EE_
X-MS-Office365-Filtering-Correlation-Id: f25e253d-7115-4a14-f73a-08dc2b345d3d
X-MS-Exchange-SLBlob-MailProps:
	qdrM8TqeFBueY0MSiJltW/Lq6/+Wl4JHBXF+FgvlD1WIQayWEjFM00O92anCUUDkRVkZ4wyzhgsmJHHHjzmH1jvAoHIUUPtWo1PZ4psZN6BQrGRWye9DDhm/NdKcxVRpMKkvNS5cdgCOc6fqUDec1Pxv3TPQApP2nOr8YRN7PKNJzdADlaiwfVegu+QfvaymPoGAxCrf8gcqWXC+UQozThSx9kJ7NdmpcccFTMep+YieW5j8e/A3ZcK2CMgtS4hogGUIpmSnhrijqX6ZQeUN4dcVo1TnY+VhfD+28ln5z8rXbeJjDeTUmK8ffOW+tdFkoQ8XMr8h5AFp7kLEfLJzz1dk512v9aS4HpL+2GRAWSraIgEv34xElMS8dxGUZXdk8RRsNyUzWjpLbFV9BC4euCI+TRs7OWznJtjyy4zAkHTusWoPzddHQc8VbUf0+fB52K3EqZsKErk6SsZGrFM+PeWfbwpI5M8eYOElW428rYHEXRvKP4mgp9KFKOOD5JjuH9Ni8sEOn0jzMbIgwKUlMS3fqKuP+2TGLlvODhF50HD6i2e22G/lNvZNO3wNF14af5nw2zppIYCNG1ggDI0rrn+iyxjxgxqwhKvfvwO03yrRH4qK+cdqT+dW9FVMYODX5HWvHKznjgkzC59gfA/qtreNSoHmunQLfhQM/uNTdMbanq7HvWryn3LynN/X1USV9FDAVasNQj42sNmHv/6MWkiPhkrVqqu4IN66Ru6dIkzbPX5PZVXgwMyzaE5FswqvNQzkM8CnJdG/ejSrCsT3IGEwAqHW2MLs
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/qg0lgB33Ji6dZBpXUHTkDsSxK9xKKfCIlnGh6iFv4o4e8QGPUAW8bezubM9e221KxzyXGajJ9VUOkugH31X8bxWGCyu037WW/tIP1//Bq4EM3z/7dn2ltx+t/I83ImQRd3tNy7XeQxO0OpZ47bTekdipvP5r2ZsLRYZC+JUume2QY78mBwfu7V9xvTkkoxorv1etX4n5DP073+XjfNWb7ALIBHZ4aeCnGMZnSBVwnTWYPMQBiRWxl7lrI7gJYs2Ccilpf6dW2vJPpCXFLadAW/FWgc26iQ6oMU+F6WDhzNPl6nJR0uM9Qi2O6kMD/KmvPUeVj2XJQF8UI46CdpJISpxVBSwKd72ZsnKGhdVfGK63DQ+djESxjhsFSVyMqZVePX5VN+wYYu1uT0WIUkCJ6OVw6IKg23nBtrGd60Rf9IFcF3kY0y6M/exJ80UrGRSxEtvOz0XjHv+op0D56E+qCR3vgEk9BFbKuH1BzjFiIuZpy2zDe8iGocJ2TTTdpRHwdXTIPBoqwT9QqQrB3ZI5jJkHAnDNOwr2aP6nPH5/E8gfCiUAk8xHO2p0KiBnuNbC3eKPmNp+i8GBe2fE7sRXQ89hl9fq9zq5GOzcQ8zMBlmHDVpmj7PfKK3EjOcACYf046okctUyHxCBMPz/p3gYqHdKCPlll4hBBxFu50xaWA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gyfRLnlVGHXW6KReuz4+aAODjPgw9sPviy12qiR/X+84x9fVgG5j1RHL2ywG?=
 =?us-ascii?Q?OEkS3qUfJ9Bm0VjSchT+t8+8c1mNr/nGADR15DnALJ0QklhNuRfCdPux7Vh3?=
 =?us-ascii?Q?4R7ZL1z712cqUGvpKSckh5RgrvxCGuwy85yD4K7J5wDQJomu5gtQG8bDw9nc?=
 =?us-ascii?Q?Ul0PNSBS/Vh/4LmpM6gxAiVcs7/fCZb9xd6ZQc7pbGzPNlSr5gBbNgaeLVFu?=
 =?us-ascii?Q?vTRLTq29apOIJA5TbUMfJvNWC8JXLW98s+SQYCyQnmjXiSko6hBx2ViiN+Rf?=
 =?us-ascii?Q?+9KZ4YXFEkiCDkM3ppOylOo2ac1C/sOCeeYmyn6h+TtVvvVZXFQdxRT8Wr+W?=
 =?us-ascii?Q?hM9ecLpZm06CV8AjKSylbdrVKZpu4dGYzB2e3M/eMtQJXCgVw8RSMUIYpTKx?=
 =?us-ascii?Q?Ga5tP2qCnu8iMui72wHqSKMO0YJZwIiNyPxzQ7zSQBJeU4IY5/agAZ12w/av?=
 =?us-ascii?Q?vTRQ5la+jgTEcVQtYmH6jaIdMiXlfZ9U/xrrvW1iOo1H5Djk7TwXWS9Q/Lcd?=
 =?us-ascii?Q?xfxbGr4XJQKysv/EQmR0W97Ffv9udqBdrLFsgaOz4LQ3N6tBle+fAxSJFCy+?=
 =?us-ascii?Q?KHuiDhvDWsBdUuxD8QWVXMdlTQunoSWJd5VL+wYqn6nu9OEIu74khq8PLHas?=
 =?us-ascii?Q?4LXJNTPaEPeA860ZcfrIrpO6RE3RGmj3W+3beGhPYiaLATogo4U2HTWpmxqM?=
 =?us-ascii?Q?jR5Eje34nX2dGJ5xoc+CZCpRx1I1TwmC/6j4Hc3sCqnxkfor8jkp06R7w+tr?=
 =?us-ascii?Q?TsX5t0FM/GREtd5EGzDFyu+DN0Gdt+dMWiAaJ8OFJvaF9tpluJtPserhMML4?=
 =?us-ascii?Q?ZLnPcIKTG+gzOAc5PwhDlFc2ZP7lj5DMpCT4HBGTpzpDndk4vsl2L16j6irk?=
 =?us-ascii?Q?Qp1qRdkO3o8m+Elz+79StdfARO2zHWjzoW1H6UiY77NjulAcs0lSVLQd3BLB?=
 =?us-ascii?Q?Dnui5+GlewKXqrqaBHz21RiEEHqRZ/ivddGB8BDgEk2lL4t3G5gEfXDVf/bt?=
 =?us-ascii?Q?p/9E0J1UswVQHsEsN1kF2mx7MiGhCjxUCrB9bCILPfM4rsQ1YqRyhRTiml8R?=
 =?us-ascii?Q?rWFsrvLIZ8vVkn6Un9j3gioBgXO2nz1z5fwdUALUwHautrbCPq5EWe8n5Dno?=
 =?us-ascii?Q?MUUjo69N+L529p58Wyq99jsS05HNLcWT7XXJVfHcaW3bxj0Ne9xPxDNqKt49?=
 =?us-ascii?Q?/zxMGrVVvswxbmIc8vDICFFkeoMst5GMAyDCIWK9x5Mie0sCwGy09AFx6ct/?=
 =?us-ascii?Q?KSNBPlxkcsEIEdfGgJdV89PnmjAY3btymtxj3LnVXgsSArQO7jvHN/lvDoK1?=
 =?us-ascii?Q?2SU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25e253d-7115-4a14-f73a-08dc2b345d3d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 19:05:09.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2970

Add support for the pointing stick (Accupoint) and 2 mouse buttons.

Present on some Toshiba/dynabook Portege X30 and X40 laptops.

It should close https://bugzilla.kernel.org/show_bug.cgi?id=205817

Signed-off-by: Manuel Fombuena <fombuena@outlook.com>
---
 drivers/hid/hid-multitouch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index fd5b0637dad6..3e91e4d6ba6f 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2151,6 +2151,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
 
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_SYNAPTICS, 0xcddc) },
+
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xce08) },
-- 
2.43.0


