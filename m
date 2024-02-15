Return-Path: <linux-kernel+bounces-67527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0E856CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944231F21D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B69137C57;
	Thu, 15 Feb 2024 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Hmq+H0X+"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2079.outbound.protection.outlook.com [40.92.49.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2E136641
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022463; cv=fail; b=a4SUxtpEn6xS6ESLywZQCVXT5aTtnJd5lS6h44qqQrQxqC2J8/zIotq2uQCbAJNJDjpW4h1ZB0AiWCvWsGOiU6qIEJcpF19gqKiv7pXeIbUvVsjWxNEuYDWze+vT8Ijk5hlNs4ZofYVViM/TDpRRtlrYKDvXSBi0//xoLW0nu+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022463; c=relaxed/simple;
	bh=f/+SbAIF15xOR+9slVz04mZB0WXHTWQOFocdcEJDnvo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RgKVoQ9PY47HFq6AXGPzwKCcieuJ8HEwjH04woW1eve7DqKuT73tJQ+6IusiELE0KzdXrFjrVCiUd39pFsSFkvtjKPLxXCMGzgMeMU6ZQuPs56HSLQzNfl0BpwHKPZRc/sg34hTqADAPGwHx2nF1x2xQAymFSoL5tgcGnEiKVAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Hmq+H0X+; arc=fail smtp.client-ip=40.92.49.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJMvMjqd2/ohZoEACnti4aGag+61ou2KGF/EwhgXXZbZsRzTcBJUCvJC1uuRFXmgNQjGvK7ryCcjUyNBxRvO4NYmH0EQFhsJ6a8LHAeyhlPF9HrjlPA8cneB/lj4uuOtVt+W0xJRAdYg2eWy41T93OIBosmHVNvoSPdrAGxEyYhn3TK1gUfqQ61DEnc5fJLE5iAc0ovL1Oc8P/OCUG64j/eucXgenUEQxvm3GY/kUNmm4++fPnFDbZfS7KUyA+vL1BloLo7JorivEd2zxZlsO6WufnEgtH2wWrnZJYcyTyQqgDWVVTX7TJTZ39+8GMJvVO9AdnQIt8pIkm42QKJ0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYW4I0don8z51CznFCHHe6TYcm1wKugg5YALpmmzYBI=;
 b=bZ5BClNP4mB/sobKLPEO2b65wkau1IiaTYwvSC6hi1dCYKWJO425dZvjOqtGu4ywjhdNqztpHb5+0iVUNTji4gDaah2qxT8S7RUjIUPFKxgon47tdNYsboCLJfVTk2bhxULU5uHO1Lj4GZavt+OSpbBdtwkOvl5DbX0E6xXiADW2322AF9HNumbwaOk5tgHiJwtUhk915WMZrQSIFDAd55+IdfwXGVI+4ooYH7IZPKrH7sL+gU2rp7TNSEpNEE0x4Ad+s7SgtYd77w0gNCFEFaqJO/yjoPWU+u7RQVmPwxbh0JwYtFip56TE8xj/t2/N3z/Dheu/VQHt6bMf8KeMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYW4I0don8z51CznFCHHe6TYcm1wKugg5YALpmmzYBI=;
 b=Hmq+H0X+cw+u2mBrQFZxnLBQPx2CWK1DDGnwLiZuV3+NNd7VZnQvlILQgwN4ylUdBlKISpXm21aO6yWqXDm3dIcFq1o7ZhfiOyW9Wbac3fF4pTGaDbJE0cWcDM20hDXT3x+WYubCVSnwAoPLHGFq+aXa48koPFUGHZcreWBp+BWa9gpKO9Y+ILP+C8EFLzOKtUljaxj2RCUEN/AMXxcBEnivhtIVBikg+XR5O8v6W3fIatxkxZVKgzJZ8VkoduGJJ37Que/k1BDqjbfhPwUS7JewhyC0x7UIzjQ5HCRZwa1F0lyclJngEFbpe8yf3F6p91baOcX7xorZpctHokP3HA==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV2PR03MB9548.eurprd03.prod.outlook.com (2603:10a6:150:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 18:40:58 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 18:40:58 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: Increase the number of bits to shift when recording extra timestamps
Date: Thu, 15 Feb 2024 18:39:55 +0000
Message-ID:
 <AM6PR03MB58481629F2F28CE007412139994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [n6tJOoOusIshE8sJ2Vr9yx60s3p7dhzo]
X-ClientProxiedBy: LNXP123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::33) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240215183955.32394-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV2PR03MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: 38063376-af7a-40da-8cf3-08dc2e55a63d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MYYb+XUcsI6NGGwiZQpbILR/QrTa1z7Uf9+PEVU/g3KMkwlxd+7ySnYh+cgnquol7AE1ZTwyO735Pqcf0A77AGZYJRco3Yx/kXPFlo81uSxn2Cc0+yBpfwkDwCC/BituJZUdD2JcjabOQLEt0CzL7RxvB8Ph1wu5cY0gXT0Xw9JD/mM2Z3zk3WTK9/5qoInAx6Iju4n6WljTKXej1hK6vwdcu0yIlUKibpqHQi8wmEKxTnQ5IX00M6OZsm7lwUdefJfCHwnHb8ecVmjQCXxfVctcmtgtphZsF/O0AbVm3M4uUMeL1IrjN27uCZFo3r8oMGCT7LgjepF5aT1xC49MBpRI3WqEABBphWYwXDjM0l6yzk4O0Pjjycdk4PbDPXKkJ+zNpq0jbOtEZxsF3f+iiR1i4n4bfujiKcMEvrUgPhL/6BNzXIVeQYIVBA6uvtlrrJNKHBFk3KijIxlbDEN4TkKx7eYPOQO+TTg5zQRDy1H+RBGl6+jINhZL9s2bja2vHNh9j27PGiswByhjSUed0SygTNjLrzcO7PjuX83ioe3UAEWP2axC1MyG76bOqoJW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pLEqswMD/ICnBQjxx3WYFJHb3Fiyu7WNJeAOmS6L4/ff0Pvrdmkk57J341Hs?=
 =?us-ascii?Q?BTccEIJ/2eGKzHdt5AEmpu+BIYcDlirfN+oWPhc4U/ukS/29Qh5txm3/5cPr?=
 =?us-ascii?Q?ebRj1pu0m6nXqEMU7LObTaJqzR/rvXdyCV/c1UbLXnZnwZy8z8vswvNuHp+J?=
 =?us-ascii?Q?Mz2IApF1kj5M2UpkZK7cobA2XKtEDZkWpo8PngKS+tqwPqZoydtBS6dj/PLW?=
 =?us-ascii?Q?jD6U6x1TlKpsOVOQoAffCa+EXskmIy/d/uhVARhzYVz2CEUFsEEzaiK2QhLX?=
 =?us-ascii?Q?48NGAafvDp2UtDYPDeLKOFwwfE2b9pGZFw3DjX+UFN5N+0VLD3ekTFKzNRbZ?=
 =?us-ascii?Q?LFuQOlL8RZhDt32qVODz+X1N7MTgjC4CpCULQYp8GaXTw1Yme13v5yTCnsF5?=
 =?us-ascii?Q?PZi3B5RrKm7umFX8lGPMqAxjHtZHGukGpBzVYCwXz81r9UDbJ7BbX8xiipK9?=
 =?us-ascii?Q?t110dAgu5khqfos9RPgwcwAez+UICIkdNd2N/CjLIkJw2EVTLH3/tZr6b8i6?=
 =?us-ascii?Q?WzwgldXsPALJv1Wk5GWKHklMPCU97tOmGT5jxQKfsJ27B4h38tu4VhPYlCRU?=
 =?us-ascii?Q?4HGt/LN6JaEcWh1m2Pa+92A6kKd86hmajaCd+1oS/FiDkduJ5aECvjIPkB7l?=
 =?us-ascii?Q?m5THTDW7ssSEBBUt0hXxobyieniWk2hweF88ue4Fm/iaTIP1azPAPqL7OZLy?=
 =?us-ascii?Q?30+5Q75i3SXgMLweRS9Oy9ZbM8ZbH13xd3AHdKMRHiyj56v3OpfIQ7236IwH?=
 =?us-ascii?Q?d+tZxXYhjVQ/VFhtT7EgOPWtygw15px6RWWr3EtRdg1WB3rHrbf4vmc705rX?=
 =?us-ascii?Q?w32wFSG4oscW+zCL0b3ibJbifj/x1ZwoBRGIAppBS/ZODnfU56w2Iykn4nKJ?=
 =?us-ascii?Q?dzR7tpzE21LH9vIpvxYrh1ipeXTumJxFniQ3gqoCZ+eNIGh3oyUVXLapCol+?=
 =?us-ascii?Q?ZiZnSKSxF5v2TD3DvWRqQ7r2XOuNDk6oOBcoVGH0J19TLWDYso5uMKVpCzy/?=
 =?us-ascii?Q?r76wDvb2VVOwkKJtJtKaVnNcW7HhBcrSeU0hnmoC+2sWRcoFhBQcUqpuiHQQ?=
 =?us-ascii?Q?1x1i82Kjn+TnBfRQ+5K6dK+gEyECw2E553v5d+aSvxm8+ZTC24ul5TFfbi3j?=
 =?us-ascii?Q?AE317nrUonKmi3ULnit+IzyloBuTw3h/4+pnjFLkllWshvz4dtsNJPi8UjhE?=
 =?us-ascii?Q?1QufIGGuFd8a97d1CKe4g2vriYNyAlJ3YFr4I1hXqt8TnROZiwn4dO7NgrkU?=
 =?us-ascii?Q?9LrvsfTREm7O+bchpDn7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38063376-af7a-40da-8cf3-08dc2e55a63d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 18:40:57.8922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9548

Fix the mistake before, I thought printk only display 99999 seconds
at max, but actually printk can display larger number of seconds.

So increase the number of bits to shift when recording the extra
timestamp (44 bits), without affecting the precision, shift it right by
9 bits, discarding all bits that do not affect the microsecond part
(nanoseconds will not be shown).

Currently the maximum time that can be displayed is 9007199.254740s,
because

11111111111111111111111111111111111111111111 (44 bits) << 9
= 11111111111111111111111111111111111111111111000000000
= 9007199.254740

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 mm/kasan/common.c | 2 +-
 mm/kasan/report.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6ca63e8dda74..e7c9a4dc89f8 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -55,7 +55,7 @@ void kasan_set_track(struct kasan_track *track, depot_stack_handle_t stack)
 	u64 ts_nsec = local_clock();
 
 	track->cpu = cpu;
-	track->timestamp = ts_nsec >> 3;
+	track->timestamp = ts_nsec >> 9;
 #endif /* CONFIG_KASAN_EXTRA_INFO */
 	track->pid = current->pid;
 	track->stack = stack;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 7afa4feb03e1..b48c768acc84 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -267,7 +267,7 @@ static void print_track(struct kasan_track *track, const char *prefix)
 	u64 ts_nsec = track->timestamp;
 	unsigned long rem_usec;
 
-	ts_nsec <<= 3;
+	ts_nsec <<= 9;
 	rem_usec = do_div(ts_nsec, NSEC_PER_SEC) / 1000;
 
 	pr_err("%s by task %u on cpu %d at %lu.%06lus:\n",
-- 
2.39.2


