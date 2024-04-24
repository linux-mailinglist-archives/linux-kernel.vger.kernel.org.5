Return-Path: <linux-kernel+bounces-156090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B438AFDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D7A1C22F15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D0BE4F;
	Wed, 24 Apr 2024 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="AX2RcKR3"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11011009.outbound.protection.outlook.com [52.101.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394ABBE6C;
	Wed, 24 Apr 2024 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921952; cv=fail; b=szTSMPcdMGlL7rASke74cu9Ymzr0ANbPmAu3UwQSYWDAjre/Wv4/1tUR5SmhOicUNrGQmlFdsmUSVYku+1r2Bxdgs3tPyd0hpsW4w44d5Silogh2qsrv4NofSEZUHrTAcgXctgbcyWCRvD4KheSsjCIh4iA/VCz2Luso6C2gTQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921952; c=relaxed/simple;
	bh=arqsWWxt+48qzHgdBMKB4b661mmpKKS26piSE2nymMc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AHw4aypR+oAzAlw3aTMv/gkxTfIDZTLEcWsx39szksnhp7aaiLBV0Ie312oLfLlAn+YHkCsyASZROiv7Vtx/mZXx8Pk6MsBIf9Mkr9ALilEwQ//bRFKfbijtOXIlpY4A1NDTLVo+oFF5p6at/CmlDlYBrt55HpQb2saXIzoo4h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=AX2RcKR3; arc=fail smtp.client-ip=52.101.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6vmW8U4uoOs0txvBu2oAuGwmyVLpF9r8VC22ClJP5cFbKiX7Q6N87HJDDMvwZBVN07AnkseZ593aRvL69JB6/lbfBSu3zvCi3WK/V5tf2WM/QnmQMNa1TSmD3iVy4pYl9N6LnB4Jwpx3MEQvOk01nu6LYrYX7o7zjVFc0R6HN8fv1RblDYN20927AxCwlq/Z5+erl3FIMy2ReAYmBSP99IFfxyvlnCVZuqv06Enqv6aQyBT0zXYDrb85vD7yEQYS/p6XsxeCpVRixvZrkPoR81ftFnNOW+G2aw9lJ+mylScJ8ndPcrXIM6NIHiW4M95yipJOlomHl5n2oXl4eQjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgHKdiSh8JEccfKjdKbuoV+upcSy5j+J4+/q6x9popE=;
 b=amabBuwh5PtkWp5OhQ/8DfppwzcOPz3000JMDdhjSOM0Qh2CObmHAjuvzIIJMb/dvRcbg65xqfx7OQxSslYSd0sw+2jQVXb3Y2hK3PEZESlbvi7PuP+hzyL7RrI8KSvQM7Vsq9/NxEz/x/gxqUb9w9IMAxEIrkK/sNETC3rhhw2CFThOffdbgodBknXPWMN1WCEaEIKkXX7HoXaK9+PUxzyGz6D1pcRfjri915hhnpHNoYxDHEzS6BzLegETVdbn9j6v2hyaagrkx62/tBxLKzrCZtHtJZz7TzK8eTybj25Xt2Gd0d0GIg32XyzmLoUZS9yS1YKw45n24Dd/fFZvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgHKdiSh8JEccfKjdKbuoV+upcSy5j+J4+/q6x9popE=;
 b=AX2RcKR3zcyY0OSl5ib1U/RETM5MlIBktX8aVQva+of9xL6IQ0m5WkbwiPf9lSVmZExf22W3jTytxpX/veKNvrXfzUrxVLSlbRcYqsVsVebqe+V92eanzD04JUkEGEqVrq0pA6sdZAQyFrZWf6PIAWkKi3XyfHhvpmiboXyIzCTMmNrhwX/DSkGoN7dcKe3lPbAI85stnAXaRsnxC9J2tfhMzU1+UvZPDA9d1IZSTnRhyBxHKtjW3mUVRmCvc4gCM66bMdasMTT+MJEgjLW/O6C0fIkjOFj5EjliTgEYHWYKLN3W4lyzrrA1kYulhjADOj1vAGs1mkr33NAN7MnoRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by TY1PR01MB10657.jpnprd01.prod.outlook.com
 (2603:1096:400:321::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 01:25:45 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 01:25:45 +0000
From: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Cc: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Subject: [PATCH v4] usb-storage: Optimize scan delay more precisely
Date: Wed, 24 Apr 2024 10:31:34 +0900
Message-Id: <20240424013134.17307-1-Norihiko.Hama@alpsalpine.com>
X-Mailer: git-send-email 2.17.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::15) To TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYVPR01MB10781:EE_|TY1PR01MB10657:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f422a9-17e0-4a71-b001-08dc63fd770c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|376005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i/pbox18JiQ35ieIZJ++iW7aJOPRysnTCg+7kDgRbO+JOhinWA9DmMJEqvaO?=
 =?us-ascii?Q?89iB+TyARpv59AvrlSADN4XO4yTRPUPm1zsZfu7dwUN06CsUYh79rhV0i1Od?=
 =?us-ascii?Q?1GOIVJSHrPD42TZ4BJmJsqRJyVn6W4EHbjC48fWIT4qPkS1Y+7egUxYieuQH?=
 =?us-ascii?Q?r+O4TMppTFVD5o4EWT7p/1C4Rspk6RXZWOb7dEEMpmAz4iBhJDW6ylJ1vQQa?=
 =?us-ascii?Q?XNrzsznEmm7kEMFYB98H1eJQ3zEMHSVEjs6n8+TADh/9ZW/v2DczyB2MLuE5?=
 =?us-ascii?Q?jPLVyx92hLIJbvn2aJuByAV4CMdLhtnkdXBLBoayA9NzvN0iqKqAyrWhsLrU?=
 =?us-ascii?Q?yn//RDBPycSpxsxtEafCHV0IE7YdnVZGcdh9pLmKZQDAuJMqIKDSpSJA+OxT?=
 =?us-ascii?Q?SGUsli2TPekNHg08ma5dany26b6FQ8svan14BlFpC5qBoQrS5ue75C/mdkPi?=
 =?us-ascii?Q?yeKXADjxy1+RmhKEFIbdbEgMr7/yKxMGkaRPoZDvOa1wQv/SyXNdzUykrZq7?=
 =?us-ascii?Q?5Ls0hDlfzzc/AgCJMXga+JXDRbUpCJwNET7LjFVW1zEE/2RFuZtrme3GCCHY?=
 =?us-ascii?Q?c/iYQwwrXQMEt2fR2oKP2Kuw6ydFuXf9IqebLe8aULu5yjA2i8ErHqFGAXic?=
 =?us-ascii?Q?Cgv0H6glggwSEkbOPlX/43dTLRJo4BsGWFCMWbN4QdNriMMsmE4XFugoXIa1?=
 =?us-ascii?Q?bVM+Ngb1UghflZBzku0SbUDNBWDPFWTy0NZws45JRZvjDkwIWwM9mk+skqP5?=
 =?us-ascii?Q?rtxbCRan51GtBRYNlZctyvsvjiMy2JiKLNXH8HPXKbAWwqAsBw5uWdJFdYta?=
 =?us-ascii?Q?SYrBPTWgmm1/nVTXYwAtTGLw/TBYBVlUkmFNYScaXOmhKfrAJ0hZBnEuJEZ7?=
 =?us-ascii?Q?XQggbBO16E7mFtn4w6TK0gKQPZT4VjHJs1wISugYJUc5v9EdSQHuh1AgTFfb?=
 =?us-ascii?Q?ec6VIlksBO7sI6zFADqiwW1vFW9R2gdrLiixv9l74iFVSjQhaCw+as2DRfbh?=
 =?us-ascii?Q?adiHFl++D/gRFEJEW0azi9nSdnBEuvAlIaYFebDVBGCt/sNU0fS8O0s0lPh0?=
 =?us-ascii?Q?z1IJFB63Fsb/+WfnmMDaye/br6OodSy1C8YuFPLjuovFQrqN+Qz11B8JOjI6?=
 =?us-ascii?Q?wPzQrCs5wmQ8PzbBL/bXJ3p6uFSuyXkuH7tuE69HSwbvrnvxmWWzp3qpCK3J?=
 =?us-ascii?Q?oGCOAPaiI8EQq0suZHDwD2XpbN730kNedWFT30gV1NBmfU80fDx10rLvZL1i?=
 =?us-ascii?Q?sEYM20v0gaedz5lQ3FcIi7IfoAaaK2cxjHlp1O2Hb5jrS833cemg4aymkaGC?=
 =?us-ascii?Q?QYV2OfPR7MXTUPaABMYnsFFnRHKIB+JEKt3Na5kOrO3esA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BdLztK+H30dEtBWgmu2444nOEMDQngyaBk+6813hvAIFUfmsfIX3e7qkpq8v?=
 =?us-ascii?Q?ehMwUurgjsMsrDZ82kuYcSc5uroVFNufYMThqg3UZJ5xX+e8gaMlNpTNJeoz?=
 =?us-ascii?Q?5p2KvJyNtPrVvo1n9hZWnzAy4w1K9hXzlUp9nPk9KTFdo7M3cU8wZd6orCBo?=
 =?us-ascii?Q?WY0WnPFRjFn3lUzjbUkg4W74j5fJzstwldXSvkOzZFPSyrw8qLQXOdEuUU4Y?=
 =?us-ascii?Q?3cpMFsy8tQXuDAVrwINZaCI+Mry2iTz6lNLk56J21XXPZe9Jhm0yrw/ywvBN?=
 =?us-ascii?Q?AnHc3TTKao9AVser8hmGUHzEK8PdFgxnP9YZd6QTsy0Tj3M7zAJ2CCGFW4V3?=
 =?us-ascii?Q?QK6PaPXdHxCMdvZCLXdoHHzSIXiM6JgAZ6MHcPv5/AKCwiUnt5wA8q+XUCjO?=
 =?us-ascii?Q?bp09AR1zJxur4hL8TVNVlXLM1lntVM4vr3AfbtvFCYF8xcw2LGn8jC3X21oy?=
 =?us-ascii?Q?0quD0+RL9TGhJa7fQNcywUdH4zMjui7lUc06y/lpXJz/JKrzo9Yu/42qDTT5?=
 =?us-ascii?Q?pLkJzeE8ZDW0Bs/pXbCBX47L4puTeNQu2Dytq0wsk9reo4zT/9PSt4X91xxJ?=
 =?us-ascii?Q?XP9Mxm5dSZG9sY/yn4JAaXyAm/s1vkc0BrRnP8X0H11orVOo4peCOnx06p/S?=
 =?us-ascii?Q?3kvTXxGtyP/LIbC2O1viA0nbd8Zkrm8VNVcZ/xanNskKOSE/7JdgDQE2xl3q?=
 =?us-ascii?Q?xkQuBiIJ0U9isb1w66/KH5pcsx7UK5SFqJ428z6k+eRcgzQXaowxfBa29F8y?=
 =?us-ascii?Q?e+muZFjOjSXauS7GGRGc5Amqhji0t4CxY6PGvwZ0eQHbtYRSgnM0tOxGt/7t?=
 =?us-ascii?Q?lnVpp0qm486ke5b1ZBKb3ccVGBmbmdAAWtjj0T1exTIZi+I5eHho/l+ln24D?=
 =?us-ascii?Q?HWRZA7P/Hp4SARyhOWwujRqy3rs2ZeNE0iRIziibBGwQelOY6s6J03l0PkYP?=
 =?us-ascii?Q?j0hwxckjkDVfjkQhJNChcr8+YJCO0l4pdk9nFauGOTwcz0mQZQUFVGOG61LR?=
 =?us-ascii?Q?xOvgQf3y8jyUCjbVzsVPWy27GbDCzrgdrmwD/1DLJwDD+k1bpp1hs9UcKSyL?=
 =?us-ascii?Q?Q2tJyx4tkAbnGMFqEtpsQtx366PqXUph8mWMffpQmWAqqgqgL4YqeO7W/Lrk?=
 =?us-ascii?Q?Sh4+X+NFzQ9LX/6+zpKCXzB2ZAUoY+L+vJKdf0cuwRapkSfwbg8GKgZzoynC?=
 =?us-ascii?Q?RGz6Llupq8v4LcdzG7CY/YpH57jLqs+yGCMJz9bCGDINYxjgTsU6jhwzxgPs?=
 =?us-ascii?Q?KHmyMN2C1ozvdO0j7itPxfbDk+V208Le79slB2u0+B+4sbTwzo6oFfrOkhsC?=
 =?us-ascii?Q?iHMT3yhiAZB3Ms3kmEGZFANh+KEuLqtpo/vQfAXiIlExIb0nBd9OGGWz9sOL?=
 =?us-ascii?Q?JxvXUh2UYkO5cgtoyhSAK1ghq9jHCzKPI/Mj15Vux49TTpTo25VgbgM0dz6z?=
 =?us-ascii?Q?ABtnJ5KWhUI5O49adCi1SbEQRvF0eyRKuo/EE7GZg6ilyKcT6b28W6zP+RBB?=
 =?us-ascii?Q?nqvd6wUAD59f5eqXyEe38pnQXQf220NywZcQqb3Y1P64MDp8lkDivSw49sYt?=
 =?us-ascii?Q?qyBABgJjt6MNVr+i08XnCMO4URVKPY9Fb2afzqTa?=
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f422a9-17e0-4a71-b001-08dc63fd770c
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10781.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 01:25:45.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJb/fgy934wF0c+ug2EKTGGu1rsHkaX3kY7wGa6ymRkHen/aNh6lWOsfwPnOYazJwgkYma/QvtysQda2pZZEww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10657

Current storage scan delay is reduced by the following old commit.

a4a47bc03fe5 ("Lower USB storage settling delay to something more reasonable")

It means that delay is at least 'one second', or zero with delay_use=0.
'one second' is still long delay especially for embedded system but
when delay_use is set to 0 (no delay), still error observed on some USB drives.

So delay_use should not be set to 0 but 'one second' is quite long.
Especially for embedded system, it's important for end user
how quickly access to USB drive when it's connected.
That's why we have a chance to minimize such a constant long delay.

This patch optimizes scan delay more precisely
to minimize delay time but not to have any problems on USB drives
by extending module parameter 'delay_use' in milliseconds internally.
The parameter 'delay_use' is changed to be parsed as 3 decimal point value
if it has digit values with '.'.
It makes the range of value to 1 / 1000 in internal 32-bit value
but it's still enough to set the delay time.
By default, delay time is 'one second' for backward compatibility.

For example, it seems to be good by changing delay_use=0.1,
that is 100 millisecond delay without issues for most USB pen drives.

Signed-off-by: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
---
V3 -> V4: Separate parser functions from module parameter set/get
V2 -> V3: Change to use kstrtouint only for parsing decimal point
V1 -> V2: Extend existing module parameter 'delay_use' to support decimal points

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/usb/storage/usb.c                     | 120 +++++++++++++++++-
 2 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 561d0dd776c7..8248426524d5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6190,6 +6190,11 @@
 	usb-storage.delay_use=
 			[UMS] The delay in seconds before a new device is
 			scanned for Logical Units (default 1).
+			The delay can have up to 3 decimal places, giving a
+			resolution of one millisecond.
+			Example:
+				delay_use=2.567
+					2.567 second delay
 
 	usb-storage.quirks=
 			[UMS] A list of quirks entries to supplement or
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 90aa9c12ffac..c908cf2a8027 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -67,9 +67,121 @@ MODULE_AUTHOR("Matthew Dharm <mdharm-usb@one-eyed-alien.net>");
 MODULE_DESCRIPTION("USB Mass Storage driver for Linux");
 MODULE_LICENSE("GPL");
 
-static unsigned int delay_use = 1;
-module_param(delay_use, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(delay_use, "seconds to delay before using a new device");
+static unsigned int delay_use = 1 * MSEC_PER_SEC;
+
+/**
+ * str_to_fixed_point_uint - parse an unsigned fixed-point decimal integer
+ * @str: String to parse.
+ * @ndecimals: Number of decimal places in the fixed-point value.
+ * @val: Where to store the parsed value.
+ *
+ * Parse an unsigned fixed-point decimal value in @str, containing at
+ * most ndecimal digits to the right of the decimal point.
+ * Stores the parsed value in @val, scaled by 10^(@ndecimal).
+ *
+ * As with kstrtouint(), the string must be NUL-terminated and may
+ * include a single newline before the terminating NUL.  The first
+ * character may be a plus sign but not a minus sign.  The decimal
+ * point and fractional digits are optional.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static int str_to_fixed_point_uint(const char *str, int ndecimals,
+				   unsigned int *val)
+{
+	int n, n1, n2;
+	const char *p;
+	char *q;
+	char buf[16];
+
+	n = strlen(str);
+	if (n > 0 && str[n - 1] == '\n')
+		--n;
+
+	p = strnchr(str, n, '.');
+	if (p) {
+		n1 = p++ - str;
+		n2 = n - (n1 + 1);
+		if (n2 == 0 || n2 > ndecimals)
+			return -EINVAL;
+	} else {
+		n1 = n;
+		n2 = 0;
+	}
+	if (n1 == 0 || n1 + ndecimals > sizeof(buf) - 1)
+		return -EINVAL;
+
+	memcpy(buf, str, n1);
+	if (p)
+		memcpy(buf + n1, p, n2);
+	for (q = buf + n1 + n2; n2 < ndecimals; ++n2)
+		*q++ = '0';
+	*q = 0;
+
+	return kstrtouint(buf, 10, val);
+}
+
+/**
+ * fixed_point_uint_to_str - parse into fixed-point decimal integer string
+ * @val: Integer value to parse.
+ * @ndecimals: Number of decimal places in the fixed-point value.
+ * @str: Where to store the parsed string.
+ * @size: The size of buffer for @str.
+ *
+ * Stores the parsed @val scaled by 10^(@ndecimal) into @str.
+ * The string trailing fractional part '0' is trimmed.
+ *
+ * Returns the number of characters written into @str.
+ */
+static int fixed_point_uint_to_str(unsigned int val, int ndecimals,
+				   char *str, int size)
+{
+	unsigned int delay_ms = val;
+	unsigned int rem = do_div(delay_ms, int_pow(10, ndecimals));
+	int len;
+	char buf[16];
+
+	len = scnprintf(buf, sizeof(buf), "%d", delay_ms);
+	if (rem) {
+		char format[8];
+
+		snprintf(format, sizeof(format) - 1, ".%%0%dd", ndecimals);
+		len += scnprintf(buf + len, sizeof(buf) - len, format, rem);
+		while (buf[len - 1] == '0') {
+			buf[len - 1] = '\0';
+			if (--len <= 1)
+				break;
+		}
+	}
+	return scnprintf(str, size, "%s\n", buf);
+}
+
+static int delay_use_set(const char *s, const struct kernel_param *kp)
+{
+	unsigned int delay_ms;
+	int ret;
+
+	ret = str_to_fixed_point_uint(skip_spaces(s), 3, &delay_ms);
+	if (ret < 0)
+		return ret;
+
+	*((unsigned int *)kp->arg) = delay_ms;
+	return 0;
+}
+
+static int delay_use_get(char *s, const struct kernel_param *kp)
+{
+	unsigned int delay_ms = *((unsigned int *)kp->arg);
+
+	return fixed_point_uint_to_str(delay_ms, 3, s, PAGE_SIZE);
+}
+
+static const struct kernel_param_ops delay_use_ops = {
+	.set = delay_use_set,
+	.get = delay_use_get,
+};
+module_param_cb(delay_use, &delay_use_ops, &delay_use, 0644);
+MODULE_PARM_DESC(delay_use, "time to delay before using a new device");
 
 static char quirks[128];
 module_param_string(quirks, quirks, sizeof(quirks), S_IRUGO | S_IWUSR);
@@ -1066,7 +1178,7 @@ int usb_stor_probe2(struct us_data *us)
 	if (delay_use > 0)
 		dev_dbg(dev, "waiting for device to settle before scanning\n");
 	queue_delayed_work(system_freezable_wq, &us->scan_dwork,
-			delay_use * HZ);
+			msecs_to_jiffies(delay_use));
 	return 0;
 
 	/* We come here if there are any problems */
-- 
2.17.1


