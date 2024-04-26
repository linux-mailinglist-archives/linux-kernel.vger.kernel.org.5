Return-Path: <linux-kernel+bounces-159665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7BB8B31C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645CB2820E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D513C8FF;
	Fri, 26 Apr 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="Q2Au9oRS"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2040.outbound.protection.outlook.com [40.107.113.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9A13C836;
	Fri, 26 Apr 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118222; cv=fail; b=Yzg319Oh6fNr7IfOJJ9lBuVedhnSL+c+654oPM40NEugBWjR/7/1uafCbF/GAAPP/8e/Y9fGLgHetPYNueJ29NywLMRlw2eKhqfQg1oFNiEGOej8j42M+WalRzQsMPV+zf4FWbo1UwQ+eXhRTHbSsvIqcl8hG4U1Oz2aoxknxTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118222; c=relaxed/simple;
	bh=o6LgWa2y1HnsQA5yd+JUSeaV03ZQLlK/thFLMbFFS4w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RUvgU1hk2P1zG62YOrD8a3C2WAaFJKo5obwz8/lPNelfRY/J2RMihV/Q/pIZR/DXRloMn5Xq8hEzpY5vQRogu52pK5CG3SqCX6viLNrk53GF5y82JgKQS0CCNm69qnj/Ab+E6vpf77g4oK0XHz8SkZhujYAPkTY5QqQyc0/bReI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=Q2Au9oRS; arc=fail smtp.client-ip=40.107.113.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP+4LsTmnlskisHFFiWibgGUE4Hox3P2HuwnmGg9+AiJ7mt8T/YvIbH6iDLTKdcFnnWfI1QPjFv71A9dCo85XVpammX/5kfFrT3zj0DhBMPBojMu6rGoy0yG+wZ91RRvzfBGq31M+TpDycNLU2dnlo/via+c63eGkKw0QtGQLXFEV6bSobIihhmTwpFiIQVNXPdvjsQtYbaV3aWSKul0VoRVKFques65zGeAGml1tX8Nl8BWkPDNLh5w9mwRlQngAeRdzT7Ssi6SG+LTqJZmD6geJ/N/qf0b+xHDq7RrTQTY8LV7yKk1lHPqQZUqgFZgxg34xti5zfPHOl9sd7TMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20/4AfXMyYXSc5QyqccbGsJec3RXqadw1qrtxkA9Vi8=;
 b=lOL5D2/62MD7N3gYYgQuqpakBQuyo2cVB1FMKezwCg3mT8eZFOaT/A/D/3q8tmwqDa2QBFEmKc5VSlR37f9XfC8gR7HJiLBqcjH0kDQcOiPi3jxEh6HFYk5KScRn6Ymzac+RylOdic+W8THJkkvVMsuEHHHU3pUGqA7nKfU7zn4tsTtqkjaA1GdCt41RaqJbtquBrjnZhcuROeWYHcFfwKJN+0r0y7BkckjPdciZ7QN8sl1+d7BuhWPkPJPG0fkEIq4TZx9vRe7cv69SkmoZUo+bLHTIuJv57fw+gfJEqt/iV8xpFy5kWGezbsd1siEBQYLh0rQUfBPUHj+Qb+od9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20/4AfXMyYXSc5QyqccbGsJec3RXqadw1qrtxkA9Vi8=;
 b=Q2Au9oRSkIiunLUDj0zbRxMA9YwQvuOBvQTqv13w2/PhXiueOSZlQbdHtY3P7VKPjVvCPrChWYeBfe0oRqQ1Yyldl5T1D+kBX63VocsnobWwoaAYqEQnDE8QAxQQ+o1jjOOnPKGcRWK03inK5MnPUhwfGeTOrPGFPuIOsWfYH9KhNY4I3E1D32+c2pa/7MHYkxD4agu1LuU7utEs2nnRtG09SyUNNxzvBXM7T/J8kWbLDgkLC90wcWumWCKtFCXb/dtChd4rbVzGzwv5XU2Wy0QlKCr1ThIP+UlS2Em7LmGvn66TrRBk4I5i8/IL+XXH3KM9tdsLC9sOUphzpGf+PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by TYCPR01MB10246.jpnprd01.prod.outlook.com
 (2603:1096:400:1ef::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.48; Fri, 26 Apr
 2024 07:56:57 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::fe5b:1283:68a6:dacc]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::fe5b:1283:68a6:dacc%4]) with mapi id 15.20.7472.045; Fri, 26 Apr 2024
 07:56:57 +0000
From: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Cc: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Subject: [PATCH v5] usb-storage: Optimize scan delay more precisely
Date: Fri, 26 Apr 2024 17:02:31 +0900
Message-Id: <20240426080231.3062-1-Norihiko.Hama@alpsalpine.com>
X-Mailer: git-send-email 2.17.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0240.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::16) To TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYVPR01MB10781:EE_|TYCPR01MB10246:EE_
X-MS-Office365-Filtering-Correlation-Id: d478ef31-0e50-403b-611f-08dc65c671fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mdqqsgxgv5NAQr4YFj7eZGBCqFKvHoUFdbkCkocmWcZt+74dDdpULP/3RiES?=
 =?us-ascii?Q?EUSZhmg83uEfkQZzQwHcMjxrG6zQwTOYFNNhf1gRD3bmIDSrPQ2+aCkOTXRz?=
 =?us-ascii?Q?fDdLTiZliqdHBxAe+4Sbu+E8nPoSjowkwdmjz2lbgI60IRjUrI3qPDRE3cLc?=
 =?us-ascii?Q?CvR8dX+DXmxQsa/6iRv0ZeSmrKHPigFr9He2H+liB+LSWdIOynK0W/1t/P0S?=
 =?us-ascii?Q?zrTVZgVYmOxaFBJCUCM1WtWK47pXr6W5A/H8JJqWHeV4SpLeD7LZcE9FmFRn?=
 =?us-ascii?Q?i9QZ6HGcKHPBko9xAQL2ppmgZ1l36qbznT9MzdB5xwKee/gP1X/AbOFzV47b?=
 =?us-ascii?Q?FJyuAH6tbDu3rSnXqllF34Y9zbQtmfsk242pRHA85+4sLgMWF0PqH0f0kspf?=
 =?us-ascii?Q?JeZb81Tq/h047Naew5I7zEadXwOsxMFePFKpRl3y6KuLFrrAXq6aod8TQMP5?=
 =?us-ascii?Q?gA8HyEcCQ18X8yvLYSB9EkLubNRcPKUk6iHhWzd46SjKm/FyAtRlMFjXaxy3?=
 =?us-ascii?Q?DjQqE+VE8cCfIQUi3JFrWrld1kOEABUoKP98LgRFMePfq0Lewki10JuqLDjf?=
 =?us-ascii?Q?3GixcBJ0ng71XKMUHP+OAFVmipRuVQHAHhXheM56YOG3bV/FiWHYRBy6o9QT?=
 =?us-ascii?Q?snvg0e6IGicmr6iKfoRuE78G6SCU9obAe8KJS/fBW77IPj1Zae+DQTlNreoP?=
 =?us-ascii?Q?rZGHAWHsNEUcuY16CscqPhuGIllEurKnu+WnFMrdYvq+8qh68P5KOyrYq5aL?=
 =?us-ascii?Q?n/14SayJvWE4LZkh+hUu6eOmnzL1vpIIXBOwcJIRKrAoUe3tSk3v7OLHTgRF?=
 =?us-ascii?Q?FbXADLg3CAEpobTSxO85j5lGLem4Yuc+Eky5UCc8A6XEADcC1FKZJEeGOREV?=
 =?us-ascii?Q?XijyGc5f1txGLNXNqTwbeODceiKDrGuM0id3tHg/5hp2kS7CbmVbl7WttQ2g?=
 =?us-ascii?Q?YTjnnig+1Ka1A7pkZ6UWncYLqHiTO/zAqXJeOY0/oUZMymthe6JWg4/enYeO?=
 =?us-ascii?Q?XOZVpVddUkeMAQ2BWYogLcH86H3kbhbc8anVpLToh5zoBrQsq7sICSsNoL+Y?=
 =?us-ascii?Q?/G1gerYrD+6QhwwCZp636RxVdegO88TRVWUbzQux4rYwBlb0fLCRTmfLCfta?=
 =?us-ascii?Q?k4rhXYqNCxemYrPJXl4BvOvgUCA46nvwvuS+qvaaNzLka7xpfZPdBWKBxYu4?=
 =?us-ascii?Q?mMvuy0rFKfWOdzm1G4OsyrQtSEGE8EwUTYvQz52SQCPlebXvAMHKlIDAmoPl?=
 =?us-ascii?Q?u0eQBG2576PJWPCf4m7wPJXQ2LRt7/uwX4Pz0JCedJaBxvrE+p9nj5wAEy/6?=
 =?us-ascii?Q?UGbiNAm/+0evH+0LiX0IN4S51bBKUWpcjgPUqAGMhnWXyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wNKo7GKE29mNgcu0TWfVzHg8OIsqr5NjU/arW7hX/pN1ZcsSqGjZuJ/ERFbq?=
 =?us-ascii?Q?/P97GT9FFEvnyZKRizFkWPkA4bKyGgCj/X35gcfLrmSbXnrpB4c4d9ZTz3xp?=
 =?us-ascii?Q?FZ+l0cNXzQEwt1y6xCRmk5RweVAJXs3eBNYQrqKLYGdnkX+NKnS2DaJtssUg?=
 =?us-ascii?Q?F6NfR5qjinZJRy1/xdxjhC+bpzJIUxEvmxfkI/CtVrAcIt39KP2rdHuihnjI?=
 =?us-ascii?Q?l+JnLWQZ7n56hxUmKN2WnMBa+birZQLlVGpuN24XAK1mtK6vVTyu1p/rAX22?=
 =?us-ascii?Q?968yMmbqd3ZHSZDzoYqVpI6+1pHCTB75tygOfKIF8GWsrg7CGpwzWiNSpUl3?=
 =?us-ascii?Q?8X2bdld6z/wM/Zw/JOzVGFKVtqbTVXXW0JmwrVRDeorUUIw2KLF7ZCbZw4wD?=
 =?us-ascii?Q?+VmFUeXtdisVakasNe7b/f7X2rMXJzM/Wr3PogVeFHbrz+taWl+rzpZaCnFm?=
 =?us-ascii?Q?OFdNsd71Fwf7CkBZVkI7EdSFfLOOFZT0bz+xVplXfg98+7KwMqrg0L6KXzW2?=
 =?us-ascii?Q?JZ2hSZROk87ipyGCwUqPgZGGTzkN0xe99mVYcL3kBafxaANsDgVVd5NOPTNG?=
 =?us-ascii?Q?CeNk6iqe85zTMt9pwcP/dDlJT6B0q59xr4d30i6mJEEGfKG+a5Y7YVxB70lC?=
 =?us-ascii?Q?yHHVl4khAakwJV5JZJZ1jHQ9mUZvVSRoviFou1du7tLLPp4okayt1BQH6iIW?=
 =?us-ascii?Q?OEUhoEZuxbI9gvaAidcDRI2D1Y2Yei3Nle+w/w5oEn7YpVq0k4utbgIxuuEL?=
 =?us-ascii?Q?72eUHbxOeCwaMmvJkAJ0ZfV8W9R+hKOYELr5R6UeDq3xnIxAM/mzqf+qJmxK?=
 =?us-ascii?Q?3JkdqnGYkyWcwq10YD5R3skEODcSTxIAQf3EiwBH6aTMalsWzGXyRsm59B3I?=
 =?us-ascii?Q?gA77LKIxCkmRK53qDx04zlODixyIkopAo+tkmrtNbA2LODMiRgaLSZS6S88H?=
 =?us-ascii?Q?6u+9SlmLioZxmG8D1thcX7sabGiAliJDp2oVnUSiBbd17+0ciZ9booYRiSnf?=
 =?us-ascii?Q?DtXalJyOO4M6wUOhNCVMtcNx6QWNCvOhJ/6MY19Tj4kpikHdgA5FdsHTWUsT?=
 =?us-ascii?Q?pR+/9Lznn8DxsQJFuMGYRyvTIDIKg/5LmD6QQNXIqGIMSK3cfNRocOuiHbiA?=
 =?us-ascii?Q?qieyC9IRWGbVItnyigA9qdc0Gdjh22i4sYhu1eO8vOWrvhXH7f4+ueJZp4Pv?=
 =?us-ascii?Q?XAEVu9aaCMg56ndlwN9lsg30VtgUT6WFdDN2gEz6Ha3HdiZRD+f2A4gh91+7?=
 =?us-ascii?Q?XBUmrsgUsU2Oi4iJL0CZviL/OCWkwM18SPNmOKWpIYiPpGcmqnGYZgW9SebZ?=
 =?us-ascii?Q?WApqAiSCG0vAjZRCxiRWawawSPaDRA50/EfkDHqqgDsYnTfPS9uKN0VN31NS?=
 =?us-ascii?Q?9T+2vVXnmIUELJwnDz5HXSljIOb28eclOfdHCdpRF/qsTC8hkFOTquxVtDaQ?=
 =?us-ascii?Q?CpzDOEZXoEvdt2DMtsF0EkkBiAeuGCGL+ggIAIuST4KL5NuwNOI8sYLsYkHA?=
 =?us-ascii?Q?CKwHC8ahv2dHo7m2htbZqa5vNia/ndctFg7Ds6Zb4gkTHADrWJd02dXvkWcS?=
 =?us-ascii?Q?DfZJDLDKfpaKoBMgMoiHH0c9xKcXQVtg+mX1mboS?=
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d478ef31-0e50-403b-611f-08dc65c671fc
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10781.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 07:56:57.1203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtbsMYEek5H8i+E7nIRfOcFeSMA9Pz+FyTdeunA2XTXgjByA+PH3iOwG3WATAnEuBFap4aDTVofYNDdOc+ARSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10246

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
V4 -> V5: Simplify parser/formatter code and fix documentaion
V3 -> V4: Separate parser functions from module parameter set/get
V2 -> V3: Change to use kstrtouint only for parsing decimal point
V1 -> V2: Extend existing module parameter 'delay_use' to support decimal points

 .../admin-guide/kernel-parameters.txt         |   3 +
 drivers/usb/storage/usb.c                     | 118 +++++++++++++++++-
 2 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 561d0dd776c7..1b22983b9a4e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6190,6 +6190,9 @@
 	usb-storage.delay_use=
 			[UMS] The delay in seconds before a new device is
 			scanned for Logical Units (default 1).
+			The delay can have up to 3 decimal places, giving a
+			resolution of one millisecond.
+			Example: delay_use=2.567
 
 	usb-storage.quirks=
 			[UMS] A list of quirks entries to supplement or
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 90aa9c12ffac..72dfe7ba3e4e 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -67,9 +67,119 @@ MODULE_AUTHOR("Matthew Dharm <mdharm-usb@one-eyed-alien.net>");
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
+		if (n2 > ndecimals)
+			return -EINVAL;
+	} else {
+		n1 = n;
+		n2 = 0;
+	}
+	if (n1 + n2 == 0 || n1 + ndecimals > sizeof(buf) - 1)
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
+ * fixed_point_uint_to_str - format a fixed-point decimal value into a string
+ * @val: The integer value to format, scaled by 10^(@ndecimals).
+ * @ndecimals: Number of decimal places in the fixed-point value.
+ * @str: Where to store the formatted string.
+ * @size: The size of buffer for @str.
+ *
+ * Format a fixed-point decimal value in @val scaled by 10^(@ndecimals)
+ * into a string in @str where to store the formatted string.
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
+		while (buf[--len] == '0')
+			buf[len] = '\0';
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
@@ -1066,7 +1176,7 @@ int usb_stor_probe2(struct us_data *us)
 	if (delay_use > 0)
 		dev_dbg(dev, "waiting for device to settle before scanning\n");
 	queue_delayed_work(system_freezable_wq, &us->scan_dwork,
-			delay_use * HZ);
+			msecs_to_jiffies(delay_use));
 	return 0;
 
 	/* We come here if there are any problems */
-- 
2.17.1


