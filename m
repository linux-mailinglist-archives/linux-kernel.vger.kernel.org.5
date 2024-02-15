Return-Path: <linux-kernel+bounces-67531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06039856CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B55288508
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C02137C57;
	Thu, 15 Feb 2024 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h6TaWYYL"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2079.outbound.protection.outlook.com [40.92.49.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7852595;
	Thu, 15 Feb 2024 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022685; cv=fail; b=o+lPUIbkufiEKmmZ3SrhuC11wxsiq976tVN1SUNhh6mMumALLquozdSEZI3WgVD8VZQBSs3shd0N6RBPhf4wmdLzUJTD6+ikXsMDxavdzNW1/M5o2m1/fC2OlThjdqkkE3Hem4WpzvN6DuoLz7tDsQUKOMdAKhkq7/Peu6khEJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022685; c=relaxed/simple;
	bh=DYY0+AcDewv43J3g/PC+3UGIIs8ql0WkoIKdpKSfWfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V8eelwn0gIO3j59/jYExwYroDcKRUlDcxvfoopOjtghOeO18JosdBVXbEOdfh/YAF3LMiJjl0UCMSDtOclfMq6tieIYpmsXB3MswQLjhxnbto6l+kUALDYZfPWY4TYAi1uKR42KDBozszGN2LQBO9o0+kpMNN+YPJZ+B54ofBAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h6TaWYYL; arc=fail smtp.client-ip=40.92.49.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMBqxm/2taV0fa/Jb1OJz+8Wo/jeAQGjLOcSeoHB/nQiCheczEnzoSZiJDtYXFKQXtVbb1FqoEqgJyDQyGMF1HgzgIyCGkmAjphu+TXWBXn+u6eRjHMZPEiAj4MRKgcdQRnKI1wm/DKivTRVxhN6GeNvtqcObDmVygdskSefTVF6rxPyU8PNoT65kvr0a31BQlHQolpzsYwZa5d20FiA2ubzeBg8BhO9IOZRgEX2cDDUFbxYmLiERfcoZIxQIXohgzfoo2lfb9O2f/6vyI+3qk9zVzi0O9/O+oxI0zNGxP7xFCHkWUugWbTssbtz2yVKTkzXA5WpGM2puE+OvmIO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WQnFK7iGX6Ikr5ADyyfNApbj2aVc5SoJtXog6qH1PI=;
 b=mLva+0Aby+4K+jubkg4T6IYQYc9697ZXLcFe1Et17Qo6bZn2CiiB1ugpuDQynNQQn13yygSd/3NG9pGIVrL/5zZIhdKMnAUMNIYLnYncRhR1DFGwqPMVuLrv3wL3HohjwXXXB6SqD3tdbtz76UvM0Mjoo9eOIQaHrUKpw89XhIbrzkCLawh8h6kFLKChTwUJt2anr8/mMuSPBw1mPH5xltGmymMkhPryzzvAQFiWaS/ujVgcaKeHXeBC1nVTsKn1KE5dUalVMN9Su3YCOYP02GAERX8Ge9B9mhvjKEYAEFX8iN3FNw2dW2+l+VWDYCDPOc4q8LHEn8RBPbW6JK61Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WQnFK7iGX6Ikr5ADyyfNApbj2aVc5SoJtXog6qH1PI=;
 b=h6TaWYYL8Jlfov1bbKsefiuWJYCQ2P9FEWFjjVvMcxDo5DKB0ur3X8T5/9tGp9elhGD5u7dBLCCjegcoLtIj+ri61lYNY+1ZU0g+YTq6WKLCNvpUknyQAVhVzCqsVJhbl8YN8j+j/rKQe1lc+KFFBPmPNvUdnTDz+IZPDKAU7wIZVaZS5wfd0np+QTHhjuwg5vqPkwy+IcgoYSIOxLTVYzt5KPp16L7OWuZocw+kT7qkAdlkDHgIZxZSS1yf71qpUD7lNRkLsMeKcX3uHX/o7caz8ORMLjdbJJVvFV1C/ezkt8sSus4gmkDLTauiJkLPiJjGSh/5eALbcdD9tNKCAQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV2PR03MB9548.eurprd03.prod.outlook.com (2603:10a6:150:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 18:44:40 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 18:44:40 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	corbet@lwn.net
Cc: kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: Add documentation for CONFIG_KASAN_EXTRA_INFO
Date: Thu, 15 Feb 2024 18:43:04 +0000
Message-ID:
 <AM6PR03MB58480786BBA03365CE454CDB994D2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QWaWzb8MH7tSszj9rgRVqXWQobk9go8o]
X-ClientProxiedBy: LO4P123CA0277.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::12) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240215184304.33039-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV2PR03MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: 0483777d-6dbf-4172-53d9-08dc2e562ac0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qKTfpCsur8tEnwmDr4uqAxWSfBXw2lNDdfD4vnUwgQ7WH9Grn2oHUV5802aiaJZXWTe1vWQDnOxqQ1ZWz8KidmXGjF2Pt599h8XyqWB5bUwBrDGwuCTV+gkGsGU5b53NyGszE7WVpjfcfjNK0we/1mNRcRI5u7XW3v+2CSZmGQcuubBy9VLuCnFzR41fEJIvRTSJpWAdtU40pQQ2iJcTPopcOmIH3EelDN28ZQgJ/e1vGeKNakF9B7f88/vUGaSGC1xmgsJVu0XvRqcVgF//Wp04BPOakeqVPCfL5B7x7DP+BxlsZ818Ys0zHlBD+hPJgRD3r7B9ElaVx2cbrkM49J7yroUMJOaJuR9GBFD6ehNeGd6A/aKYvKrcsANtMmGwDveQV7xOSVS/Cjl/FcoQr1fzNM2TBzO+jbIYsQu9EFEySR4qNKfelRaH/oue5L8UpLNDwR8ePESK3wegyr3kK3p3oVb3HPHe2iVDHnXzuZvmgob3iioFMlzfAhBzjIJN6MT98tLvehzERGRyb/LIUrC16eTRRepedchM7xSbs4pcNamuBBS4yHrMnnjAyvws
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EyevmFmA+P0L6hwGgLQojtNqLwnZR6hgIf4gfw0NF4NnpiwZbPzs5TQxae4w?=
 =?us-ascii?Q?JHWHBhqtycc+K/in1B0ZeYZFsqcsq2sL3dYcICtB844UyW1HEbBgHBTL8V1X?=
 =?us-ascii?Q?lc8M7C7yck7T4vdz341SsuQQznqMXrDNe8eKoRUX+CjcyzHe0uUiOS4k51wS?=
 =?us-ascii?Q?wl/LpLZgqlvEDTyWce16LSatGJW3LkxQteF4/lFahnqlF0zA7ds9FUsTcUx7?=
 =?us-ascii?Q?qxfXrclhgjyMUiqnaJ+0to7UsIjnm+rA9HQcd1rTvUJ67pI5xyw5UsKuqV/J?=
 =?us-ascii?Q?lIkgADDgUWsJ9Dgd4k4EeOEMTdY2mBcItlGUIWbcJ4DGtTOWQrUSQ1Gm2Fa2?=
 =?us-ascii?Q?0d+2oggMmLo+O0koW/31n3r97nhwSd/F8patLaM9FF1z7r2LnGnt8h4G2+Yw?=
 =?us-ascii?Q?QMM7ud8XC0z9sfYBMvNlWjDelIxUand5BQpmahyXH0Hkck1Jl+3A/Lu9Nl1D?=
 =?us-ascii?Q?XqAPfSgtyaKCppA4+QKwTpCSfjmN77FZGTz86NItU6DdEXWNI3iB3+ukpcA6?=
 =?us-ascii?Q?tlM/YyIlXX4slx0i2t+7K3d7bJHu4Z+4oaDp2sYhcgskS6+rxIAX/2o1EY/u?=
 =?us-ascii?Q?x1LRncxQZmUwyGqcz/gUfaJfhb5WAMjMvvspoAQmbtFRh1LIGsvsVWM7vM5T?=
 =?us-ascii?Q?8N3RERYpyo1YJfKIe4iuA/divxcIBuuDNz00ZB8FUsm2JjVNuNe3c8oXXNi2?=
 =?us-ascii?Q?qCfojzi9gnOLD1YZWvEjye54EN/DOYW8raREJrkWN4bcp/8Jx2ALikrbPf2O?=
 =?us-ascii?Q?WDthEdZ5ELWviVhiZ81whe/DfpVj/WeGq7qtr3GjkdGR88yE2l6I24bkKW6O?=
 =?us-ascii?Q?NJnJ4tpRlkEUJPbANlbkMAdQqW84G6SzcjyKB87gjEKbzhCBBkYOpb2xKwWW?=
 =?us-ascii?Q?7FNhcvHde5eaaTyJbJN3rlUVMkAuiZuqb+r1JDIjjiopviggKiWWIIVQ4OH6?=
 =?us-ascii?Q?cZC9aHqSxshxo9OwMDx5ye3g0u3CGnVQuzNWUjFmxzBIdFpYP2KfxcGWMvy1?=
 =?us-ascii?Q?xPUTbYc3CQ5T+Rn2qf4TUMUonCohA/3eyuHPLXy/1R3e53gKsLDs/fvV60+a?=
 =?us-ascii?Q?tW8LP8cBKys3dcZrmuobDbFTyKxfZlvUuPQLkd8S1YNF3ELQreESiE7Z1Egr?=
 =?us-ascii?Q?uXor9gXaBKjHfXrfhsznYp5a8G8nZ2A3IpFTReCm3A8BKBH3E176VmgMRhNg?=
 =?us-ascii?Q?BmOEu5f5Q2TwekNyqCWmHbl3wTP+HlSy6lHvTJUvo8uCvWJPwKUAqD9QzOCj?=
 =?us-ascii?Q?jXJ2MPbAS//Ob3E4Jh5o?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0483777d-6dbf-4172-53d9-08dc2e562ac0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 18:44:40.2897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9548

This patch adds CONFIG_KASAN_EXTRA_INFO introduction information to
KASAN documentation.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 Documentation/dev-tools/kasan.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index a5a6dbe9029f..3dc48b08cf71 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -277,6 +277,27 @@ traces point to places in code that interacted with the object but that are not
 directly present in the bad access stack trace. Currently, this includes
 call_rcu() and workqueue queuing.
 
+CONFIG_KASAN_EXTRA_INFO
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Enabling CONFIG_KASAN_EXTRA_INFO allows KASAN to record and report more
+information, the extra information currently supported is the CPU number and
+timestamp at allocation and free. More information can help find the cause of
+the bug and correlate the error with other system events, at the cost of using
+extra memory to record more information (more cost details in the help text of
+CONFIG_KASAN_EXTRA_INFO).
+
+Here is the report with CONFIG_KASAN_EXTRA_INFO enabled (only the
+different parts are shown)::
+
+    ==================================================================
+    ...
+    Allocated by task 134 on cpu 5 at 229.133855s:
+    ...
+    Freed by task 136 on cpu 3 at 230.199335s:
+    ...
+    ==================================================================
+
 Implementation details
 ----------------------
 
-- 
2.39.2


