Return-Path: <linux-kernel+bounces-86659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A88586C87F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5181C20E96
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389C7D062;
	Thu, 29 Feb 2024 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mOoBduo4"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2090.outbound.protection.outlook.com [40.92.53.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC1D7CF29;
	Thu, 29 Feb 2024 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207528; cv=fail; b=mdwKN5buAxXf59mfDhtMLe6t6UIcVazSCTEGQPTDDlSOUI2/YbOLMijSiC7H3kOTzi0K01WCGIKRFCPk9745AnrIl5hxQhpt2pn64oHkS9CKWN/tQfnk091gb+NaxOyTfRiRkEraijMquqSwJ9Xg3pZQuojGstpJo0bpJ6yttQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207528; c=relaxed/simple;
	bh=ZVNWUDac2T4xdsKzIde6ZFGJ36GYBuTszLkBnT6UtiA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UEKkg4y32NlV0yYxw4LpnhwSlSdmNtY5E2ohCnsznc+UBNqLPJJtvOEAsElMvlGNUM45beQB2IECBmMDdAc9zVtSWfg+0136GYPncDrFJRp3upN5HnMsELa8QnD6wZXKMRYS+0Apf6zxpNnCFPTAn8/tsgV8yK6dOKo+kpLABEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mOoBduo4; arc=fail smtp.client-ip=40.92.53.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvysMCnhWu93fAVdSbBPI7TE4rYeHe1Wk/y73W/ZCP34TDElS102q4yDLSza4Y1MN2ckhPRp51swKYXxvdWktqRIK0BSccb2jPTcqQ0IbFOS0bu9GcOvWFy3Xz+483tet3Pft5QsuqNiSCHF47Rm0EBkZYIkckmeswd8rjGFaOe1KR1XcqGfK1dYcooHNYhmCS0uknbqcWm6xHum3H0oEhpCMS0Be56qffMWTV0bdX3qD5CObK5/LzeO7eLRLyXnwvfCH60fbTiegoKQ5N95nVMPWKyJY9XQRd5CzZ7SqPt/SOmZa68ch6iVQq1M6w3fjjE2izAPenrTm+s7Ks3PRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PXPH6wLfc8+olI67/P2tQlj6vGxopXd7xlFHEzKT5o=;
 b=bzv4NwAqudNJ5wFsBD6a0nXh9ShC5chlBlOdSwTKrx4AAOjFWuvhjj9SMvieu1t9qWQGxmnBWEhelDhNOker2ekg2ZeQjN75S94Bn60cEqhvTTFpJ3UGvjgQzfONfIzMLgHkuYBtNCz0ncuC66RdgDOc2q5TZi+EZWYd0HL6ySF07mkKAdSd5pP/cxxSPdeaZJlUJMYwkEdrv1xaF7/j+Z35G++RrkWSlRw05mrKZaXwuzImjeJvBgWR0vjj+4Y1466gWShI5eP9OjNwJU/aNyRK5B5TFHX1BaogsDteeyLxqc9oY2UQvizlOhSg5zagepDgpF5zwF09UCR2UXqPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PXPH6wLfc8+olI67/P2tQlj6vGxopXd7xlFHEzKT5o=;
 b=mOoBduo4RqV0QBrzmdzpvEiDd4tZs1HQMMsFqs0rx1ithsm7RmVZabX6zqc/rSxhuJ2tZkEAZtEQ2v3h0Qvz3a7cL27allvd27TsL9W/46qSsEuEIyTYJrBsF7+LvQ0bB94EGkJGqMQs7mFPZTqDR/R24fIdC7Wd5m0jqxsgth/gYE5P6tkZII5LMlfQkYk5GwDoFccBFaSVy6WHBec7qn+X/tyLEg3QjRZFUTCLzD5crBcWBBt54HaeE9BllBw+KoZl5laWuh+kVNXgP/0qXJ/W9yhz5dakCUjtEGK4TztRj7M18Ny0lT+KmNsgYZJDxHY+648sAPBZuNdw5Xu93w==
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
 by TY0PR06MB5836.apcprd06.prod.outlook.com (2603:1096:400:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 11:52:03 +0000
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::1e13:cc11:3196:e0a6]) by PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::1e13:cc11:3196:e0a6%5]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 11:52:02 +0000
From: GuanBing Huang <albanhuang@outlook.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	albanhuang@tencent.com
Subject: [PATCH] serial: 8250_pnp: Support configurable reg shift property
Date: Thu, 29 Feb 2024 19:51:54 +0800
Message-ID:
 <PSAPR06MB49522EB50BDE08A5D9D0DACEC95F2@PSAPR06MB4952.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [Ll0BneyBssgM4Uxpt7eo5+4dP4M4x0S1]
X-ClientProxiedBy: SG2PR02CA0119.apcprd02.prod.outlook.com
 (2603:1096:4:92::35) To PSAPR06MB4952.apcprd06.prod.outlook.com
 (2603:1096:301:a3::11)
X-Microsoft-Original-Message-ID:
 <20240229115154.80311-1-albanhuang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4952:EE_|TY0PR06MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 91505cd2-3ea5-49f8-ba22-08dc391cd808
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kHoTdC+O0WDlav6JKFQGMQpWPepzqUEXsQkpypuW8dz2Xv8sgKbdoHaow/SIMZLX5+UYJ0qIEf0AxBLQcrLwen/sdyXzAEu+Wyl/sZfxChCfgRMPQcvf58VHp4tMllL0oFMk4w4/xpA2TN91u/qWSEKgkwmwP7KdOyr6kPQEm/DxSmRWiG5s7mGsxgsoxL/zz0mmq1HYBWP5sdTlr6z59SabUKYXX5iPMTNEGAoxRm3q2HkVPbRhk0PKxioiPXcj+MyFZMUtoBE1Jp48PB8Rz0ZQca0YQ8AD8c0PrY3adaITdhckprmRume/4BqvY6609TTl42dqpWHk0WHSwefHxjDsvdpPKcH/XmcooJ+Hv4+jaw9TeQk+1f95bvg15ldzH83KsrJuAvoZlGIH11v/sZv94zzhKNQ30b4fUunVcSMS9/Rgzuq5C60AbsTs9XWU68ve1WVNBHJcaojFBH7eXc3w7bZYlLBgJU4ja0+njxtuGTnGu9G2rvu6OwoD7WdEi+RzAxNumL1goGj/AgEjjGjqd4wKiatIYZ4gs0zR0iwUHp5Bm+BzEWmWwKbW7tZ4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FdKSY+oaEOlQT1iiA6QQTHAiOP+StXpKx3sQb4l/EDbW08OvLoQCnapoxiGM?=
 =?us-ascii?Q?K/vTnlwhF5aIrj/2ofzeXNnR57jcaCujvQKlb34+Y8eHdO1sqbHLhUc2CkPV?=
 =?us-ascii?Q?6IkYOls+EsrF7S5RNJ+mFyUn/HO3UYI+3bK3UabRVhnTTb7unpDtI9XpRf36?=
 =?us-ascii?Q?YLSapICsC83uJErHrptTFEbKBx++YBTM6OHmMxkuiKEvDPLK+d1qYt0RqFNM?=
 =?us-ascii?Q?mMEn4myJ0ohPAmxQXR1pVw6jmyaJ25t7kfYnlYkFp/Ijxsi1rxW1nz+S8GS+?=
 =?us-ascii?Q?+JilY8jG9dhceMVgdQ+rdJk/pBaJwjemEDA/Smdkh6XpWCoLTq9JFgafRKIj?=
 =?us-ascii?Q?+OetvN0Zx6FDiHDXbWcaRXpwrRsGlYNTMGf4i6P3Udre+4YAwGVwjYNoQED6?=
 =?us-ascii?Q?aaa1JGWnkVhFtj1efhaUW759ZRemtf5HwFaLgLejdfEAUrMJYV4f5EmX6EZ6?=
 =?us-ascii?Q?+5Y/NQi67ZbqrNw9IHbWFQhcRZHXdNqP9JzWEMGt68cScT18ouLbuhZJLFMn?=
 =?us-ascii?Q?/0Igghd2qLyMLX5rmB03iiCblYvTS9dwtGb9wLo7mTekZvRZEW60nNTdc/qB?=
 =?us-ascii?Q?l4qnHyV+Fl7XrX5NxQsouUm5hjWsGpAgBvqXt4nCC+CC+D1fm5SPmIJ9SCrh?=
 =?us-ascii?Q?ZxydQo88cIaF+9xKiDrJBVJI7AE8B2qfoFwsRU8xSiBuZq4uTiCrMo17dFsi?=
 =?us-ascii?Q?6TeWgZ+agJGJSoj/zG30eRpcVfw8vUh/kf0xzY9P+sDZsqUnqsIvW0gA3b6g?=
 =?us-ascii?Q?LPcpISNJitHnOyAJWvKOaZBOvuWgG4QQNuz5wbtnWkpThI8lsShSHizkvY9Y?=
 =?us-ascii?Q?qtjIS9M2xg8hfhmd9I9DpFpXOJEq+Uf5tv6+NPHqLK0CroSRfOdXTwgoU2wq?=
 =?us-ascii?Q?7M6Nar6p+4+FJKcu+/jRlhjK0QVJorQHOwzEXiEOGEVNSL6CghKfj/6Wilf8?=
 =?us-ascii?Q?IboXJDybv1zkNbasi75W6jSax2MfzGP6OirAWEM+E7wtOC8rb3kARceKe/Da?=
 =?us-ascii?Q?uT/mUVpHux8//L9wAX3QW1M6gaZgvnnrmatq6kJOScqLqfX0CMy7LpQjnVCA?=
 =?us-ascii?Q?7Juppq8AIAKc00XRQd/7/17p4Ds2uudvdwUi4rapI5aDJ6JDrIKzpPaJq9ek?=
 =?us-ascii?Q?Rszuwl0qiIqXwp2P/qwtVZtEXzQoAQhkL6+riU6SHcTAZkoFt3Qv9DSrZuaE?=
 =?us-ascii?Q?3buwAkFfI5prh6G8FJTC1cTKUak3YRSOUdWuzz8jWH2pT2HKdXQ2PI3xqeM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91505cd2-3ea5-49f8-ba22-08dc391cd808
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4952.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 11:52:02.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5836

From: albanhuang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

Signed-off-by: albanhuang <albanhuang@tencent.com>
Signed-off-by: tombinfan <tombinfan@tencent.com>
Signed-off-by: dylanlhdu <dylanlhdu@tencent.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 1974bbadc975..25b4e41e9745 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -473,6 +473,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 		uart.port.flags |= UPF_SHARE_IRQ;
 	uart.port.uartclk = 1843200;
 	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);
+	device_property_read_u8(&dev->dev, "reg-shift", &uart.port.regshift);
 	uart.port.dev = &dev->dev;
 
 	line = serial8250_register_8250_port(&uart);
-- 
2.17.1


