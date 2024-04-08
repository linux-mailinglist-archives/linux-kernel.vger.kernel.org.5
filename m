Return-Path: <linux-kernel+bounces-134758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1037D89B676
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C461C210D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805768827;
	Mon,  8 Apr 2024 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WzmjLvDs"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2028.outbound.protection.outlook.com [40.92.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B05244;
	Mon,  8 Apr 2024 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547408; cv=fail; b=FJNv9fBAQr1Xca0Q1kOyfKX4v0+EZSfQQkxKm/+E8lj/7iftZELgfF3ajpdfjtLP4vI3oXWewUnAq2PbaXOhcamTmOqjXGamJJGJ93OPZ9HMlVfQ6IWAFxeVT5E6FNKX1XMQk0IjJdUdbdpPGa9AjkYTu1PcsBKnNfjtoGXcero=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547408; c=relaxed/simple;
	bh=cMyIdOCMZt6YWmxQJIAjmCaHnJL37Mgtp+88RpCyhPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JcYBrVli8Ad1oCawbWOz/nUF5yHmbXUIEriyFunV/BDMu05UgS54dVXy6j/YTjh56GSXw0fcz9aW46hOHRt4tRZ62L+wTnhN7XvcH9ZYSB4mG7d1oBiAwjkMUg5kX7aRY6A5TlacQoJEfMQdpqfdshsK4iQrMtscu64ZOn02TaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WzmjLvDs; arc=fail smtp.client-ip=40.92.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0Zf0OVOEasabu4BZHk1ujSzsj0REVQcB2VV2ahoIX4ZNXU2eu/Y7dTGOSsICOa0LrXvbnUSuGspBrrSdXNE712swfq3oBvCxp5VJg0+4uhY2jjTV/GNPb28/DRKaZHu6wSvDcxEL+xvQbooM5efcn7+Aih3nHqiyDW4AMqhm3xR9gTvPQLQfSKk5ZBgF51hrF9xJLHtshhnezszQfubLb4FuXUhA9WvHR287aB2QPTTzu6EhmYC72xpGCR2GQn4gAPKuj9pDOruKo8Zww9Bdf70xqb6EDF3WjXLtqpy81WShuhowTO7IGVYpBgqO1cMEpjaACqQ8ltVY5iftGIrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQAkg9s38iV7LKj7Kma2OA4gmVrARWTRgWFnKRlnZQk=;
 b=ViozGUK6scX17uujFEGfK56JG8HXwQG4mzJoBX5XsZDmcZKT9rPRqOTKrHF8axy1qP4Oa06nX3VBtIlSL4ao/7BHSbn+q/N0E9reyAL3nUkBpgFaw5YsR7oGDZ8alia0wMUJLkT+Q13O/0Pk4QB/ARN2xF8G1PC4zIYiYJIv4tcDCtitj+PcRSo1yBw1m8MVnBWYCQAUG9hpb4cOaAkF2C5BFAlhb1xp5cydwVoJ6SBSL7pRHJwAPSIK/wBproHwwpqkV8KdLD5OCy/xG+nfF40gbP26C56wNffL9FnIU6KpnQuImItxhpBXHayC3j+MYQmm3UlNcBdufv3iBVXsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQAkg9s38iV7LKj7Kma2OA4gmVrARWTRgWFnKRlnZQk=;
 b=WzmjLvDsXV+Q00FSC2lkVRsnxZxU7SVGouezJD1xz/0TGl31iu6YlW0AXEsf+KcqTl2+jXlsLEtQCaSxetQ4GcebsFUTsci18cfZH4PMeI0toQ1EDZWw2uNL4tLJhzb7+NAxMqWX9uonJ4geGhMKpfwS0WgXT3pVQgVs1wJkIGXV34HghIp26hHJYU6hCm/OULoxsPF61ycVJn9u/pbrgCaaueLsiEGnjXvAGU/BHzzyBlTGHCyBtrbWfqIgthmbkeiW+njl14RI87+zWItipZ/ZsYuijPRuGicl62pDPimvw+LOogoP3N/9bPztn45k9XFz5lqPxCGll1RJ+z50sQ==
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
 by KL1PR06MB6041.apcprd06.prod.outlook.com (2603:1096:820:cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 03:36:40 +0000
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b]) by PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 03:36:40 +0000
From: Guanbing Huang <albanhuang@outlook.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	tony@atomide.com,
	john.ogness@linutronix.de,
	yangyicong@hisilicon.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v5 2/3] serial: port: Add support of PNP IRQ to __uart_read_properties()
Date: Mon,  8 Apr 2024 11:36:23 +0800
Message-ID:
 <PSAPR06MB4952C4112E75D882AC61CA5EC9002@PSAPR06MB4952.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1712472167.git.albanhuang@tencent.com>
References: <cover.1712472167.git.albanhuang@tencent.com>
Content-Type: text/plain
X-TMN: [rzNVr0/+DzC9PN+ledG6BYbI7AXuQytv]
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
X-Microsoft-Original-Message-ID:
 <e6dc33e399f119e6430bca48223cb2127930939b.1712472167.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4952:EE_|KL1PR06MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: c692a7ec-a4be-4499-84ed-08dc577d1a2a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BYgK1D7upVtqU001q/Y46cCXxCAvL+uOBMpbbQD42VU9XktnBacxuwxWk0OH1RIjRZ7Goa1jl+CTHF0dU4dVZOdyk3QyWXee1nT36nNJmITwp7DfJQuHHLpQwMWC7Z1qOH0ztWxq/ApSzbREEIBJqqNNnsndqpXAwdT2839zNXqm5DhSFi6AKBukE0AtIgaZPRwNLQ0VnxS+vBnsL98+UJT+KcNfyr//SMdrW42e8a3EU2EWJ8k/4Sj6vaulJXDDKHvaP5kUBhArhLn2jDtsEXHCOIvYGARQEikr0NdeYNJ4P1z7a/C68POyd1KwaNcjIYu2//WvA1iPA449t1UopVihg1hGVQshy9s7bxAgAfI44+zGY+dy9Oqg2oO0Hwl0RDrQMAUhPZc/cNdU8KnZjM1/FYvZz4G3/UDwdhFr/lY+FiCxaEo00SIRiSG27MGfRzNdDnnm0o0J/Bi0oDhvXjPXOskT8iAsrwQAI79vMW7g+L5hT5agdkHpgES1QFdklWIlO5TWqS0+xMVaXPWlvSmpGR+upUAhjNLPFuMZmakLtAjyqK4f4yuuFVcizZ/r
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wu4ws5loZrUaqF8Frb9QwFkbX3LeghKniDMzPE3aEmKHpHrSWgFigF7mWpQT?=
 =?us-ascii?Q?mjY+6kw3NYpTw1/JEPXzt8tzssS0btXPK8Nd0G4BtMgDxAWExdppVJP34aX7?=
 =?us-ascii?Q?pC2I81Dz9GQz6g82zO80sRHMrK+eZf3bo1lRqS9ZhVmNJdCYoq0NtAJIsv1P?=
 =?us-ascii?Q?zrWdBgN7UimrVsJKNOirlvNsPQlKnQlhloWo0BZ8P240+F48zt8gRMiRNh0W?=
 =?us-ascii?Q?qD0R0pa7lfkLsDA2Ot2oKWRBSEW99Qjk5t97WCoPYIscBeaSBKdkma3d2Lai?=
 =?us-ascii?Q?ttuOlVIJ/VOVKn/MznkOZe7MmKF+Qiq9vopKXlr3/P9x02W6Q0i7peaUe1lk?=
 =?us-ascii?Q?SnEgOG9TFZHlDTqu1rms5W3brNwloDAY6HsPrLSeESJaB5KXNq2DVGawrged?=
 =?us-ascii?Q?OM/IFyHrUntECWYc6s0+V/2NZmK07ZzmqOpsXWFXCExGuQzsBCgR6oUEZDHL?=
 =?us-ascii?Q?+Cg8seCokfStoe7BqlBZSwVZLn98t6dD5reS9vfQ2Il4puVRqfn7b8ElA1VE?=
 =?us-ascii?Q?9VZI3MIX05ZBtGw4q3QBKZrWzLwoJ3UJs6OaZ33pvDDpuVj0ZnLxOsLySm0M?=
 =?us-ascii?Q?R0Vus+xc0WGJGR5qkqpmwRSrnKOOLOa9lDhXQyzhEqFk0RjaK4570vVXZOKs?=
 =?us-ascii?Q?5aHBI7cN6ehbi/7grWdOE+LKIOH5XoRjUKk9p5YspNNckiyAHabqK7RpLUdK?=
 =?us-ascii?Q?EcCtUt730FC9RVTdxuBdJbPwBvoFEnpucVrac8owN03y1BMr4nPOwNicVzNG?=
 =?us-ascii?Q?a+//zaZy/PgkApK1vyNJNaC5ODgsVgGXpCmW4WlZOqMIQA2IObHmR0DByIlb?=
 =?us-ascii?Q?82KPYH1dP1RriV+mBAbsi0p5Q0whHA6S4gB8i0HtICN9HKxchOATns874grR?=
 =?us-ascii?Q?MymuHkDcoLAr6Fru+P19Ei6lH6q5P+9lCYV4roTWh1nssSh3vOOKUziOaSF3?=
 =?us-ascii?Q?cn+azxHH76aWhaTUMJsnOa8UPyMXIJG/lrRTSGPfvJCBuDeYcFUL2NjhsAqo?=
 =?us-ascii?Q?YeMRh+rxMRchOzRD0z1EjJ4yMn3SHL67b2JqKSGHIa6mSxPG/nmhIHTXF2br?=
 =?us-ascii?Q?xmantMGJrBj92384HYUnE2wCRpyJPHzfzWX2pAKz+6PWjYsQfDAxy99QTZRE?=
 =?us-ascii?Q?nzbj6C1yQ3RX3887Ze0XgAKD2MCDIHq1v0OQMo/hfOpih6TLj+KYCaL3ip1p?=
 =?us-ascii?Q?TwX/Suob4bUcUOO80VKaXROZcdH9JGJfVqjUQqH61ZDBv3tqY6Q5Yxn5xC4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c692a7ec-a4be-4499-84ed-08dc577d1a2a
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4952.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 03:36:40.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6041

From: Guanbing Huang <albanhuang@tencent.com>

The function __uart_read_properties doesn't cover PNP devices, so add IRQ
processing for PNP devices in the branch.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
v4 -> v5: change "pnp" and "irq" in the commit message to uppercase, modify the subject
          to start with "serial: port:", modify the location of the header file pnp.h 

 drivers/tty/serial/serial_port.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 22b9eeb23e68..8504bae1d2c9 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pnp.h>
 #include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/spinlock.h>
@@ -221,7 +222,11 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
 
 	if (dev_is_platform(dev))
 		ret = platform_get_irq(to_platform_device(dev), 0);
-	else
+	else if (dev_is_pnp(dev)) {
+		ret = pnp_irq(to_pnp_dev(dev), 0);
+		if (ret < 0)
+			ret = -ENXIO;
+	} else
 		ret = fwnode_irq_get(dev_fwnode(dev), 0);
 	if (ret == -EPROBE_DEFER)
 		return ret;
-- 
2.17.1


