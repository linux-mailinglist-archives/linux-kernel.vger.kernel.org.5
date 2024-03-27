Return-Path: <linux-kernel+bounces-120338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1438988D602
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375181C24DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151CB17565;
	Wed, 27 Mar 2024 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="klBqQFEt"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2093.outbound.protection.outlook.com [40.107.114.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82F8D304;
	Wed, 27 Mar 2024 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518313; cv=fail; b=rl4Rw5oVBeIOEHc6Dp6t9d6aKChPI78HmJ8HCeQsjbulDTTFEOP68t8hIMk7s+/eaye/N8/YeBseUNm0aGihAR3ji1SZHTZLoBp+2oyB7hJBZqbldDsyMhwFwlD3JEXDQX/g6I0rhBexh9IUjV72sBPYMMxoQY4+QCG/cW3HqGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518313; c=relaxed/simple;
	bh=Iw/53vxBsRihWl84U0I7kJcmefneVhb9Keu1IUavv3A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j+oH9588qYiFrg5+MHBkuXx+P7tPtDgPNJM+2Pln84Haf/gP5F3Kyz2f+plnKAGZqyLj+0iKiQ0lW1clmp2rzzw3gC4SqkHU7yh8KDZg9kQbImEc8UzDCRsZ/wR/sJniaru7+btqDKq39AblNgQ0TqF4Bm3f96mzO6evnxzcv5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=klBqQFEt; arc=fail smtp.client-ip=40.107.114.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PntNfRmHlnEZ4kWOGb5AV3QKiGyyP+mz7SJSfEkQPxb4broKCoyJeFwwf9VZ1Wc83UOEh5DQBPExUQnZwVWVx7gYpDRoyR8zrqNVSkJbfGGEhIEFACo0zb5hP1GY8DmDrkitx13sJocb/+fRd8Dn0PygC+djsroC2hphi1tVc/34e2pDsJp7HJoNTgZIS4wuT+OEGZxRruEPLgXOHy52zHwXBlT+Rr6vimzYGPzkV8IQbNfFopb6PTuHYCwI//bWLLLLBlOeGgmXU+A5Xaad8xnQq5DpEd6uFNGJVhiq7zpfzTGFYijjfAW4hYrqgwb0CPh3389+aAvnh+yPUsf1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6g1k8vaWviVcenabrA4wGTHHxp/jKeST2qd+QA+Ps8=;
 b=QFe2pcoBYrOW77VHr1kfyaXD9Pce8MTUGQD5h307h0wDv06T8w+UmK7GnRhSm9uMwUGSYbxTg6PUB0pP8ly/bqhnE0WClp43hZRoCnukmata0rkOyq+EzHZ1HKdI2Lv9hII/7et0XI4ioyC65ZzhqfvN3f3CMVmeRiRI7x2IZgxkkh8Q1BVH99TOh8nnwKYh4SFoKv3QLUaDX4ZX1oQS2mHYG1xd/2detJC5u800yFPETWi0vhiPLFTI2nOY2a8NR7AWun6thVWraFlw41Fo7VBPlOGVEhZUYusKe/1a1ZDtAMCl3hKkZXBu8WvTBItIiYX7v6M4zDlqgfsFZbH0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6g1k8vaWviVcenabrA4wGTHHxp/jKeST2qd+QA+Ps8=;
 b=klBqQFEtIqAH8E3EmeXDDpERbPgk7qX5KRhezajtQqquNuOpNOnlFueHe3HsEkZCVGtZM4JDHvHOVezWiIaRsPCdxMpIqRA7NSuQQPVg9Ui6lgFZg6wauNhripe52Gn7FCgcQBURO1cFxgIptF0Cr719B9yZspQJinrloHYkkojCvnavgTpFx0yl0teo7DhcL+Avp/QBvlMIUylNPNI2H40CeyiV3ZW4NKD2Q92bVc+kRDNlrcfGiC5QquzlSgGXZ7YigXI3ug/kH44Y3bHs/Qb2kY8AAflg1gfhpt3O1XmCR4Ii3wejXyEtv2L3O0xk0HhJws48oVnN3oGr4/ZYMA==
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by OSZPR01MB9329.jpnprd01.prod.outlook.com
 (2603:1096:604:1d7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 05:45:08 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 05:45:08 +0000
From: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Cc: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Subject: [PATCH] usb-storage: Optimize scan delay more precisely
Date: Wed, 27 Mar 2024 14:51:30 +0900
Message-Id: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
X-Mailer: git-send-email 2.17.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0200.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::6) To TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYVPR01MB10781:EE_|OSZPR01MB9329:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V+Y8tbVRDXKvLFTdI3Md7n8pWxerRyvpm8G+kUzUdrvgTf3I8ts97gTgYdmz+6qdlARQZuHDW6LhY//GvZoXlqYljxQsbGB2QQ/Hep7lujlhTBL1J5782DHYhO6osmCb0Kb16JjUBcaeeyIttKFYwcZD2h+CPGYq2zFCrlLtnfeyiY/gBTSbO6wTM4CSoIwgbdWhIl5K1UaviJWsqPiYAcZ/TMhea5+MBE2Xhj6Q5hd5yVF8QNGIn7m++4gF3QJMYme6VsFQyucIZOuuLbR9xE8jS1fjxtXvnt7Eo2/ntveGAm/OmWn3coD8byrIewknS0zIexJkHhtLBoG7+H+sMMeeUZ6hN7w1c835SYZjxojDsOGeea+DwR98B2Fgt+ejx8R78fvBPlV1CTyd+D6GCB+f02nKD59VpEUDhnCvKT2LrCPJxlN9iS+XPIRtEJlLxhG/ZGslqmTPqzCw+2NP4jEQbEgZ4OkOrIli3qq4P+1JxJaVLJdvJB4e03P+wr+R5Pi7lZLJrNGFrhNJ92uXC7yRUVDCNNqVxnXfDYrtYwfDqeHORX5zg5xZpEV7hlp8gd9g2KgGrsNz7p57eqgIs8YQJyPph7vtchsLNRWvmLqiYG3fm3ZR7hYsgmPQa2zQ9b5GK5jIPAesYi54NN3p3Q43sspdzTWUoLEVpxpJSpaEnHtLnogusiJIG1d18BSXv7W3Isagcd2sYtd7Wcg5LmF21e3klLAFGdOBCe3oONY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dmkfGP4jcxxEW1hoFwbG6/iGJM2nliiN8qnmuJpPNI8MMd/DBnYy39+WK5lD?=
 =?us-ascii?Q?BPi4mhnQ8KVakEjHuStLyNNVNGZgimBnwKQuEgrdCgu2Iz3KWHtdjcFXTXQM?=
 =?us-ascii?Q?o36Wy4gX9SYbW47+BbQi14/CKOHwCHH75LNrFyulzu8c1D/I6CvVEk9tkdTg?=
 =?us-ascii?Q?vN57esqpoIZC5q1RIpkZBRswaCC+drSfs2ve+2kIpluq+4b9pDWECCEG8wQk?=
 =?us-ascii?Q?9Pxo7wL1Lz6D/5j/ABt+ypJqf41tLyhx0jLPa+5Tn6ClrjXJpNaxJ2/YIdDE?=
 =?us-ascii?Q?pfHrvpy3GDq+uJHD7/dfhWPM594kAibTm6UL1Hj9uKhOOrNrgVORSPDkx1F+?=
 =?us-ascii?Q?z5TqgpEHNThB21IsTp1QGH6/Oq3OeCrRuaLYh74F9MtkfogCAm3q754DDFwi?=
 =?us-ascii?Q?XWWdFiDX7e+DaaeQiqrViq/inMci2akwo2v0+AMAHW4jsUrTrtl15GCg7U8U?=
 =?us-ascii?Q?0Dj2LNXaBB6+Mdh+4LWgLClOBy14h801gyVpZbhpDERWrgd227VEZtDZ3y2c?=
 =?us-ascii?Q?7aGcTQ0mvxp1LLkBax0YAkzHOUPbucHsNZpF1bSavgtfQxrmLsg12Lu78QeC?=
 =?us-ascii?Q?P346Oktz+0z18sPmmexKgtgtzqKl6XZbQkM3BtcbycRlSKuXzUCKRcJU8auZ?=
 =?us-ascii?Q?e7flRo7A3XWtFwyR6a9SNcRf3r9yCRVm1EU1fZq+bo9/h7otSj/3mcOOmteT?=
 =?us-ascii?Q?ia1xfomiObfSXSlNQmw+utdNACQr97KtvY3ZFhnB9CoIDVSnzpdvIrfkkcku?=
 =?us-ascii?Q?qAeIEms9YCVG5sKKAY4RfMyfPCKwuzMSwxg/tSkTPg5PWfzZ25l/TkaXhRoa?=
 =?us-ascii?Q?YkS6YKMav6QiynC2yZAj4nnCQDLKuKV3yNv+GQsFPMiR7/yFzeT5qcwwMQox?=
 =?us-ascii?Q?dGJ+iestFT5i5G0yPvibq3DIM3ByEiAcx/KO7GLpak1l8yI5GP6Fxmzdf27z?=
 =?us-ascii?Q?PagjpEKin7W/jmz6x0F3rnRdSf7EwDIghns1BaZ/WM48y00pCTx+8JQ6jbhA?=
 =?us-ascii?Q?O870zlf3H3SxF36Gz2JQ59xFx/bkdmzvmwuuz5CRT1Wom+sGcnERJVGZ2lZ8?=
 =?us-ascii?Q?nAIgbfe2EmTGgsJ6/j4lubjPDSb4+k8/OOXY0ciJjL65gxgUTiEDCh2M73af?=
 =?us-ascii?Q?KsIXl3ozCBBBrNEmWu7ROClIr/jxFRXpigXCgytXMn7YcKL/roRzUXiKYn4k?=
 =?us-ascii?Q?+1C4/2SE1sc5hwXZoglILJ0eRxq6e8p6DcdohJKLzzLW2Q5r4WipS7cRD2II?=
 =?us-ascii?Q?cs+djvMeGOJFTAQQXCHctX7/TlB9uAeL4IkTGFf58bjo/jr395TKbkmoEhhS?=
 =?us-ascii?Q?/DKDwnCDEnrSxIpvVNlqgz7qMYYLmf4DkRc8YAH71Xr/x8na188elMhncDT2?=
 =?us-ascii?Q?d8KyIhb/EHKDuKlPIv4fb3NLP4s5xP/O1GLwjEn/p1ZgRFxAQ8BbE5r1tG0Y?=
 =?us-ascii?Q?15E1PQUAPw9WM6b0mYmiW56PUU8JxeCNJ1meeZtXLAUuYNAr9P9bfQ58iqfG?=
 =?us-ascii?Q?JuX4PnjjN9wkMW6gvGVfEK3u6z2ohVw6RBKil1+/iQ+l6KVjRHu+ReC+Z4m3?=
 =?us-ascii?Q?wiYRLsZIAX0Jin4Y1rTLBxYRJVuCCvOBjy/uXwxl?=
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741c1a02-6d5b-4a6f-5cc3-08dc4e210f5f
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10781.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 05:45:08.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCg9iFOTG0uyAHCwC5jP+vt/Hfd3s9GODfxkn7Mmfx6zuS6uAaD8xWuAsU0YnXaKbUwBcZgNMcVb2WogeZ8P3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9329

Current storage scan delay is reduced by the following old commit.

a4a47bc03fe5 ("Lower USB storage settling delay to something more reasonable")

It means that delay is at least 'one second', or zero with delay_use=0.
'one second' is still long delay especially for embedded system but
when delay_use is set to 0 (no delay), error still observed on some USB drives.

So delay_use should not be set to 0 but 'one second' is quite long.

This patch optimizes scan delay more precisely
to minimize delay time but not to have any problems on USB drives
by adding module parameter 'delay_scale' of delay-time divisor.
By default, delay time is 'one second' for backward compatibility.
For example, it seems to be good by changing delay_scale=100,
that is 100 millisecond delay.

Signed-off-by: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
---
 drivers/usb/storage/usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 90aa9c12ffac..f4a755e364da 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -70,6 +70,9 @@ MODULE_LICENSE("GPL");
 static unsigned int delay_use = 1;
 module_param(delay_use, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(delay_use, "seconds to delay before using a new device");
+static unsigned int delay_scale = MSEC_PER_SEC;
+module_param(delay_scale, uint, 0644);
+MODULE_PARM_DESC(delay_scale, "time scale of delay_use");
 
 static char quirks[128];
 module_param_string(quirks, quirks, sizeof(quirks), S_IRUGO | S_IWUSR);
@@ -1066,7 +1069,7 @@ int usb_stor_probe2(struct us_data *us)
 	if (delay_use > 0)
 		dev_dbg(dev, "waiting for device to settle before scanning\n");
 	queue_delayed_work(system_freezable_wq, &us->scan_dwork,
-			delay_use * HZ);
+			msecs_to_jiffies(delay_use * delay_scale));
 	return 0;
 
 	/* We come here if there are any problems */
-- 
2.17.1


