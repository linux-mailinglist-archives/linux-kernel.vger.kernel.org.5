Return-Path: <linux-kernel+bounces-129201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53FA8966DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627D61F26621
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921BA6D1AE;
	Wed,  3 Apr 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="S88lasBD"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2106.outbound.protection.outlook.com [40.92.52.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5B67C43;
	Wed,  3 Apr 2024 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130111; cv=fail; b=upZ/VYGhMocSAqkLWaLtBSobNDl9m9HcZmhsq0TCd5Y3Pblb6HtH9ohMoFmXLHzxlzobZJx2mlIntNo13WDomfiAkLGadGMtNqK40JUR5xNOXIgDh2kWwVyenmT1FqL1aG3FVFHkpPO1+Qcb9L6g7BUP4VLsrrxgw1ZAqnKQHz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130111; c=relaxed/simple;
	bh=BPijApgv0DO3dC5Tw68krrcSTmUS5oVyqjVyHbg/H88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K7GRJpiX1KKRgtJkM46Y3ZOxVwon4AGHoJqbY5bMf7i4LR71Vlkw+mT7RNSTR26r7y1L/vAvenDOeVTvh/Fv2RA+XTIoriuTxSwwoH3xJtm49aY8JwvFgOPJsXX1orFEm2EsCoqMSSJNyjQN0jSUMa4Xco22SVwmkOhhcK8tPE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=S88lasBD; arc=fail smtp.client-ip=40.92.52.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMUKwp4IQeAFgFs4RAw2WT7kD1QDQBi0uHb+2PsaRX6P7qb48rLjXeafF4APkR7B2hHBY+0plw/GBCqtKF4s5xU0237uEjisKghWgXmyMzykzUt6MxmtBOt2VevfYtxUrfQhJdwoSEXajHyfWcbLuPDTWDUmVJVJnRTxeoMRB9YDt/5pJj5uFj4Z3C7K5UEWOxhQbCaFSpCDMt/SXgLCaXuI9J5bwXwK1CeJrB3na2fBx5tsJrWplne4EId+qZnQwcKwvBpv96CxCAjHBCxpmP2+3tMZV/FQayaLdQ5CVjytob8I69NCEcmO2OIDrSDhmSfuGNn5DtV7SdVyIxHczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDMKCZs7jwo0WmkpqK3Rx7uGKvy5/neIxL7zsaHYLZU=;
 b=kET/jGb/Y60J+4jcUiQ0TdrBwQYIGJKypnFsayiLwaJpbmN29wSUjyrRxj+puSYMoTIIbdGJFlbGQCHS1ejHmcJDO56Oy0znbQ4C33MMc9PKjCsPh+po1ulLTE7oYC788T/GtFGQWpOzMuXMOQ5WWwxSHmj5ejhEf2Btm9TLuDIOkkKOa6WKfe08+Va+O8dUlMfn4+1EjJZgh7Mb1ux7iRpGnEByYovAU3LVRzf/McBydBn4BF+shVlW0ht6bFUNcySZyizgj8U3nyXghPYX8gI2pYhifPWhrozcCsjQLypA8eSEsQYpg06HkIkfkStoyz4u9JS6XHyqHhD74U+QLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDMKCZs7jwo0WmkpqK3Rx7uGKvy5/neIxL7zsaHYLZU=;
 b=S88lasBDaVD9/msRMEBVD8G2pyiQUhHwkizo9TNeiQGmhisZ1IUfVoF7UbB0eugg2pcdOiO7WeZGCFmfRw0g3Cgcwzz9Q9HfLldng7MacG6s8fCKzprW9HOOQpvDzp71cdPY6rqO0btQW4yU0gDw5qjVkCVDuoHG2+tXNigjTtd38Kz2zbrUzhunBtR++7T8Xu/q1OuQ9FC5qyIQN8wNmDTYvCt3mz5lvh/pwGJX0BYFt5nkd10Xqb00trrWTs+PbVU7Y0GseQP2CEl9UBvbqgUes4p0AId0vMkWZZ0OjUAjjKaOzGQCcI0ucG8R7v9LcX93D2ySEp9zwVYt4CiE/g==
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
 by TYZPR06MB7169.apcprd06.prod.outlook.com (2603:1096:405:b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Wed, 3 Apr
 2024 07:41:44 +0000
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b]) by PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 07:41:44 +0000
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
Subject: [PATCH v4 2/3] serial: 8250_port: Add support of pnp irq to __uart_read_properties()
Date: Wed,  3 Apr 2024 15:41:29 +0800
Message-ID:
 <PSAPR06MB4952D98B1204C8591989DB25C93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240403074130.93811-1-albanhuang@outlook.com>
References: <20240403074130.93811-1-albanhuang@outlook.com>
Content-Type: text/plain
X-TMN: [/vrdZxwQ//6HFPpMIpoYVwpdmi+cyBiV]
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To PSAPR06MB4952.apcprd06.prod.outlook.com
 (2603:1096:301:a3::11)
X-Microsoft-Original-Message-ID:
 <20240403074130.93811-3-albanhuang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4952:EE_|TYZPR06MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0317fa-8bf5-4bfc-8e5f-08dc53b18203
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XP37VQkSxDNDGSOueyR+DNbvPh4tIyjaQ5Hoe8D9JwzE4CrqBOpz3xX4EvS34V80JBm1xfxvI8yJfUQVkBNlmQRZCt1CjAt61Hvp+DLWjrRB2Ws/Z5dzSq+qT0bgOFuZKN91pW7k1WfJa3OCv4F/5i3Gypj8QpcJrxF/6QdwLOB/VihnwKk7Vt04vB0N1fGuAhDcl+PY94waOY0IhZJ6a1efePzlsVwRizfezwmKB4wDEfpJynWZhmWjNo52JlyXbA67blXBWRbZXuP0owX4/HiY/2AYHfArydxusA+huG6/fNx61dF6Corvx2T+j9ZGunsSmUiStbvFPDXwF0tZzasRsUW+jY5WsoNybwonZPfr0s15nY2rTbz0cKUgAaY+lNNupLRbbfpH02XbwozKqZ8qaP2h1rSf3nF/4sVtpNsLDC9X/dXbBLBwKI6MFH7kWrAZDcfpq6FD3Prwlc7Fm1Cn+SaK35oPn0BG4vMRhUHwwX6FNFO/Pvh0PRd9LAD5i2E5xY8x6bSshRsGlelZ0DtOMqfEEjpbPcaDRkZf5zgIRsWVUqFiWdpve9bjzDc7
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oCv6nNaNAkDF+zgr44q1J2hm1eyf3sc+xJC+eNzA03PEh7eFDjNeJ0iIRG/S?=
 =?us-ascii?Q?5U82xafrBmeym01gpJQDvw+seA9VOq7VYrQlJvkIRYfdgQ2riVCF2BCQAaR/?=
 =?us-ascii?Q?7+DupgJ8JSzHg6Ol6V4hY4yHdfiakOxAP4ZkJfk+vq4Ojg5qPjGeJmaiCNo1?=
 =?us-ascii?Q?dKx2i3q0+6DjiRmQQCtrSfrX+76S3+AQk4ymrq7vbmJ/5r0Bm0Y4HuOUNBVi?=
 =?us-ascii?Q?SbMf6BmRfXiaMywPs/kbMMFrjsGnW0ySNJCZFDDv3GpjGuJFf7VUiY0x3InB?=
 =?us-ascii?Q?iQgQZNpnzMTWHMddTWU+zLuh+XxdqrR5aHIgwiFiF2EYOBTJA5sEQCME/5cJ?=
 =?us-ascii?Q?cXGO9bQ/WHuRDy85V7vSs0x2RTwcYckwW/C67GRaZNhXMhIXzwpRZd8P/4bN?=
 =?us-ascii?Q?z33OsZzFeY7xCXgTfHBybpOM8ImBnDm0dG7uT19zUqKu1ZdD4XHjZEnsbIYv?=
 =?us-ascii?Q?SCmop7oRvSEStfnZUCWGVj/+kvs5hrUSUTJwJeO6wByCC0/8Y+LPiCkzKnl/?=
 =?us-ascii?Q?ZLjpn3c5bbmO5CQLRAGzggplIfT8pbtja2wYjkAkSZH8C5L0C8iqIfdfRVpC?=
 =?us-ascii?Q?D4v517aWrBYHHT6QltckRLZ3pH1JbXxFpGGBrCLR0nRNA/wfbLDiWmU4svKa?=
 =?us-ascii?Q?QimTt1M/BDHyQm16azQzuWvybKiRWZOaHYX0nnbHMMF52vUoTWO2Y9P3Goub?=
 =?us-ascii?Q?XR/sP5uyO1eHV0OIvEUdOimnF7LHmg7PXBF1VMtymEKada+HP4IFjx36NcZI?=
 =?us-ascii?Q?o10Y8E4GvszQ9a1CyFjQTyeklFKqYVytKOub9k0E4a99WslhLaQoDuBgfNEM?=
 =?us-ascii?Q?HWG0fwItrqZD7BeiMcdqaMYb58iKYowOORvCDmzoq8ZWdJw47UOU11tbpiym?=
 =?us-ascii?Q?2Xt72L6ZuoM3L/fZ64RY/O4N+4j2rzb8eEdupNAUDvjThK9wyIHfbV5OsuEi?=
 =?us-ascii?Q?lkCyudQeig9zT00gNy9q5Q924XLENaSxHmz0yoHIgnRUbMjhqkf3U7P8bpWL?=
 =?us-ascii?Q?hg5w/K1HlLa4+uwYYsiayjJdJDYN3G9Z23OmKhljJL+w4qYxEkpyLx0HTJJL?=
 =?us-ascii?Q?pJVdz/uRkcwLyBI6cOfpIi8xuAWTmZHiLkdgTX4lZ/TTiE4yaS9/EFT3hVTy?=
 =?us-ascii?Q?xs0vG1sr3tncTMCkZo4/Bz0YP8tqOAdSqjIQuvgbUh9yU37bdh/SplVvvyJL?=
 =?us-ascii?Q?xPRYLJfIrBf+aEW6/3tWFo3tfU4GJpBz7PdLFsBHkLZ0G9P3eMV2pH5BPKg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0317fa-8bf5-4bfc-8e5f-08dc53b18203
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4952.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 07:41:43.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7169

From: Guanbing Huang <albanhuang@tencent.com>

The function __uart_read_properties doesn't cover pnp devices, so add irq
processing for pnp devices in the branch.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
 drivers/tty/serial/serial_port.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 22b9eeb23e68..6ed072d61b88 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -14,6 +14,7 @@
 #include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/spinlock.h>
+#include <linux/pnp.h>
 
 #include "serial_base.h"
 
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


