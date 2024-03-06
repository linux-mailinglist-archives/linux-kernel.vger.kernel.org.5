Return-Path: <linux-kernel+bounces-93854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC6F8735B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604201F222AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90CF7F7D3;
	Wed,  6 Mar 2024 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NboYcYnF"
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazolkn19010000.outbound.protection.outlook.com [52.103.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432905EE70;
	Wed,  6 Mar 2024 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709725362; cv=fail; b=axbMDulD0UnMQG1QiNJNN00lo8nomiP85tSrDAF9QKoTcY7AZ/QvPM0/MFxUQvSeG1BS6zzu+/ZFguskjrrTy978ZyAmtss9K5poog9lj7qliUJnn3p6qvxIb9S3cX/BwoR89oBlcQMZ2JFumUFxJWUlYA41X4ZpM4Wpd6WvfvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709725362; c=relaxed/simple;
	bh=UZ6XzhaqEvo4Sz735jzl+U2owzJRht4sX7quUtfmD7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NxZzlNLvhEKjUnbjaW5u0Nr1TUIbtOaP2OLmgI0LRh1J5CZ/eFzIsMA+XvVExPtJhEGhUrpAY1Hsg+5TnrE0n89STwPM5Dtus4qDvJdgPJhlRJ/B64h3DPUWY8Pw1hRnkY5Oww35W/IDe8U7G1927HP6ggJ5qtI/OY2w343YnfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NboYcYnF; arc=fail smtp.client-ip=52.103.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ivy9ZkrN2rpcESshyV6Yam1SgWboXC+LOY7jsyAsbY5IEh+LMPvNqjGW6S955Ri6wx7m+gC4X+NwObj601sz7ewDYtk9oJ97Eolrdq+D3mMDy8oVSd95jaIwLXojztXMvEC5MCbocTtvqLIGUfMhJGkdHD64715nCrC37b12OEfgCE4r11zoPQsb52rxsjXRCK5sdykbeP/tercR59emtUlNZhFIAzvqXgJhG6AJeYWtHexbt70UF7pOWXBKRARkM98IRIyr5jXvCf+FUT1rczwfRB2O7PdOB2TueBQgr+Tqzf19w1Qjpz8vgTjLy6U80c0iSfTMNrWMUoC35JKYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BItPXvOzfEkhY+Mw18wVWnJknPtnJ0UQAoGm2kIPYks=;
 b=DUhbFdoJkd2BbY5hq6wuoFYCpqY0zOn69KrSjssI62ZUWyDfz1wlEE1+0kGzAvIBWFf2aqhbllF+EIhpYq1KxAsKWMeeFgBSxe+767tV2e6xYBkLngv2p49IlLyeivastOK0FgVTUWznltGmsU0SnfZpBoMHy5x2NL/9J1iaCYSfOXeJnAG4mVZYB3JIDgCYf6RV1S+INiFdIqOSvJPMrIDjOJeCM+cwkb5vbDTItMdnYZe32xKcmO6dvLah3kiOeuwAWkcxigtL7LpsC8PN1i4RlC5twhrcdORpIBkfPogbTOc2eWKYXoKKDEtCfemvS/zX3DGs3RHBSq85jU6mAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BItPXvOzfEkhY+Mw18wVWnJknPtnJ0UQAoGm2kIPYks=;
 b=NboYcYnF0r7JznUfvWVDDZotOcU94I7YYbGvEbwN2Kf8Q1BzEJNE9eJ7tUCu00tpMFTWW5i9/WzkMa+G3xDuyZq8PLp3rVzEBqN+3YBgUPORM2v8iU6QGzZKP5ktfQj5xrXN0jN5Hw4Qn4EwnyipQTRbDvmI1vu/igncy2hxy2iFvmir0kJH2oQ7EjfTw+RfHqPQd/ekwyOK/ixZ1b0YKM6BTV0Dyh+DVVO7gdrqknB9mHJQ0UbNYe9Rkv7Ies2X3nDX7wQyJO68iRj2dbUstVtvy/Oi9U2ptz6qRODcW1nPJISfnI9SiTQpRecDBMM2ABSSyc0IaG91voGeji0Ygg==
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
 by SG2PR06MB5012.apcprd06.prod.outlook.com (2603:1096:4:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 11:42:36 +0000
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::1e13:cc11:3196:e0a6]) by PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::1e13:cc11:3196:e0a6%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 11:42:36 +0000
From: Guanbing Huang <albanhuang@outlook.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v2] serial: 8250_pnp: Support configurable reg shift property
Date: Wed,  6 Mar 2024 19:42:27 +0800
Message-ID:
 <PSAPR06MB4952ED7EAD4410B25258F42FC9212@PSAPR06MB4952.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2024030518-encrust-gutter-f507@gregkh>
References: <2024030518-encrust-gutter-f507@gregkh>
Content-Type: text/plain
X-TMN: [/LBBpEzWebFjYSYF8RnyZEKQB47Dp0xz]
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
X-Microsoft-Original-Message-ID:
 <20240306114227.78924-1-albanhuang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4952:EE_|SG2PR06MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f6d9cb-1357-4849-437c-08dc3dd284d3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VdbCCszulPVYB0idHNKveKksC27pM/whwuv8OnFLkY7TtZNsPc2KNAS+tJYD0J4gPeU3maxBa8EnfH/IOOXLkAHe6zfXalMHkQRkcgn79XitQT8Qx6oWY+zdrW04ItXE6ubGFoRXNco5Nz2FpyUEFHDmu6ZnvbET1bMTbhd2SKaFJFtN1qBb2ErPb+I1MKQyPcRjLTU0lfsj6BxGfBbTJc3RUIgvfqkyzpJ3/ilokFiv55uay790Cslxi/i1oyt85zMrFeMaRvd+6pHeUg9CLlamvdCY9k3p6M5Q3OXMxiEnC7m5DWe65kOeFpchk4g+ZaXA/UK5urfNicoCKISbMYhm9ufWPrqaG0OW4cmeOl+lR0oPxW9amrGdF3HBxpnT8JgHh1yHk87ZtNBFOkLMH8BlJMHD9yeK6EQzT0N+Cpfx+ie3/0l8rKi5O09M+z/onGR4/kG/YBC0gl8wZpdP6Aygux4EFnKAbbvBeD6EBbaGjgzZY0XyRRI+Iu33N6UfavD6L5pjHe5DpcQM+mgUONw23QoCYhJINRH28LetD5Eisk+0keXkoVY+zeEGorZR
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yIrIoNhkX/U5dEIqa2WD58yMVhfOoEpy/d05Nw4rR6dgApLskilr5nKmdb0b?=
 =?us-ascii?Q?4LgO9Ks+8MPHjh5dBz55Y498Uyp9KTm+geUE1AiNFIJL8y4alwqMed4qYF6j?=
 =?us-ascii?Q?aslInNMBdFKEP2YdH0P0CzWFwN/jdtk+UKOCcukdB/eo7aEsIM7wP1bTocvK?=
 =?us-ascii?Q?cg5Zs6FNtxNQEm+c1It/1NYO4u1a2BLnZdJlBJ6wKn7oJdbn70zde57pP6L4?=
 =?us-ascii?Q?FjziuYElFD8JVwPnY3Pw4w6E8EeZsFyahhHrXwXAr23hdaWrMl+dBq+CWIg1?=
 =?us-ascii?Q?Xzc7Z2eioTW3Q6YiVEuwFluxsmtCWwTWDbb3trCvIcNDOgbO7yEckSnfVo2L?=
 =?us-ascii?Q?iAt55P17G1EhmJNKa3H1Ls8mf1LPeQQsnt2iBNHpqZyTCIgTG4+KHQMUFrkB?=
 =?us-ascii?Q?xKBqv83XsK07Kg7d2hcLGad2/Gh1U/nGMNLKFsj5FS+GB0neckNCKkFN3HOm?=
 =?us-ascii?Q?UoaexKtANb8adWtljAlHWEJ7kK+sxSgukDLcu8v4by8gdd83IbcmUCJWdy0T?=
 =?us-ascii?Q?P5XyYiQ5Pw+dFWTNXSbrwOzKIXBSN+l7AUBnq+F0DnWw5jp9g0LJrN/Wl22a?=
 =?us-ascii?Q?tUTyYU59eNVDUCd5tRqaLP7bK04s/vHU0ToP8saTdj3IdLamgYeHbaip5uzu?=
 =?us-ascii?Q?HgDO6K3IEkY6VUdbgO3wS7ApRH1/jhnbF90xMSxToVmVVgDmVkckfZWDuucP?=
 =?us-ascii?Q?DCPRrWufWq2uYEXeXo90ui//aUv+pKHegpmTuDtEQuVp2nhzfRMXnQG7g+w4?=
 =?us-ascii?Q?HbOz881WkWTjR5oCQMXOCXKZzw8aLfBiSDgMcvhvBVepr4pjjzth9zKRfgKw?=
 =?us-ascii?Q?vXpjEdQi56w85YpncjJl12NzaVjvB74B84e27bH9oV9eX6tEsGKQ1yG5/veC?=
 =?us-ascii?Q?Q7cn6X9/fOyeymXinlY+s5IhsiTMIyIaGSAvXYA+nnmyPspFenLnYXZS/PJG?=
 =?us-ascii?Q?rNDaE1GkF7lkQQhMJo0x/oNmoN6OWbtrB2dDSGCL0BCuaN0IVPWtZCSwbjH/?=
 =?us-ascii?Q?Px9R6jb2l0ywVjug9CuzYyXg2XDtzWwXtoIAVTqLA0vM3lsfwF5NywXszb4G?=
 =?us-ascii?Q?peWmOxSGOyFH5kiJDvPMNDgF7xuI2XQ06LsClTFV72AQ3gekC+5Q647ZzXKB?=
 =?us-ascii?Q?IeVNnliRTt4OSP7TmB6Yyqg57Nrb+ETrJgmuaZchx15AjaPj8BPwVy2Ne4Ks?=
 =?us-ascii?Q?jZA2Vq6uchnr8bOJCpRtRZT7IU4938JAt0BWygQNxqaR12fN6MFQHCPDj28?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f6d9cb-1357-4849-437c-08dc3dd284d3
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4952.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 11:42:36.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5012

From: Guanbing Huang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Signed-off-by: Bing Fan <tombinfan@tencent.com>
Signed-off-by: Linheng Du <dylanlhdu@tencent.com>
---
v2: change the names after "Signed off by" to the real names

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


