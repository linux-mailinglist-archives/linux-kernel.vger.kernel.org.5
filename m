Return-Path: <linux-kernel+bounces-161080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3278B46CE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD052826AF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1C34A02;
	Sat, 27 Apr 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DFSYnL4B"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2045.outbound.protection.outlook.com [40.92.91.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53E817;
	Sat, 27 Apr 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714230385; cv=fail; b=TqIi6mrZaSA177KGOeu72PSKfYKLC7yT0WRMcifGd8Yp69t4w7DeexcLjzVB8RZ0oBsLoSxE8Ih+P+So50N/fKzTPpg0biEal97Sjvgvm4ndK9h54tJH9h0lo/yVcf65T2QxyO8Lf7A3MCihnQlGcKb0pMxTLf4Zx5p6WtVe1v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714230385; c=relaxed/simple;
	bh=Bg/aayAHjh+58y3AIhu2Jxl0578idrchmIo8sc5GMbc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RFyNNnjwGoAN7l140VEJ6X2ShxR+5Ut6ZlQFQddoza2i6dzwk8O4Q4zFqqGkQ2pteRSn6eYge61t0ER/EFnu/lAKUgImPfARSnkVGly597C7ldDJ2xrPnjkcoqIKoBOdOq2mKU99lckF+VFQOETNO43n/T6/ceN8VYNa6/mLLnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DFSYnL4B; arc=fail smtp.client-ip=40.92.91.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWBYYdaMoKrl6e9kcc9iE7RpukS8Q/dkZbkw0orVffZLN1figR69l7qMtbIW6ParaLZFivXgEpL5dFXj2J+6dQyzSqQuznHofk3knI6am8Cua7l89ylhauIAb65t967YsuVumAvqPfA46fcVD+xn+XP0v8o+le/G3bW62C0vQRwabu2HTOMUKI3qi+gxu5WNNevNKe2oSGHyt6dlWdRYMTkQVCNvuqT3cnOIdkGrf5TRrNM9NL6vS/PcldkvJd0g4LLdtT0kliw2poayK/MWhhnRFo1vjIfdlkStBRaZfHX4UBZYB7cfsCOD+y+fyl3QVaasCL1nCuljPlyq6A5EPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6DodiOXLR/LP1sokdvP0euRCk5iA/Zyl+3XhZVz9ag=;
 b=XhgRyLTkMqcFF3XclJeMMNJoSM7AilHx4eyd2AfRFRvQlmxJ3ksN/7r2wFyY+d2ba67379qeFhV2KXx5sBfuhbdBi6HKqp+An/2FwTT1n6GgsWc0n8KEPP5rxxnoJiKgxyUWTyKMHwl9ad+0Go1ELgbnybKnggupk6BN+eXCiug/To1qvf/gfq3Y40U5bKGEq77LHeHzcmcUl5eHlK6GNZZCYQ8XH7Hv5q+xD91VXZTILWmb1eqm+stpnyxEdbQSAFFh6ge6P+TsS114iPP2IfygmypQCsP2NItcyL3tLxpN1dEkHj4o3X8fD7kP/RtORqYQ98gK+37T1ZqSq3q3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6DodiOXLR/LP1sokdvP0euRCk5iA/Zyl+3XhZVz9ag=;
 b=DFSYnL4BtQ+/oX6aa4EoCAEQkeTty5VH28Q2xjBD2BZ5UulR8l5hQzitO6vPNuCe7O9Y60v58RxzL+qdAVXDz04Og0H3g/F7E9egYwTw0ZpQgIIGYuvLQrr1No0n0XumsH9aAXG6Kg4gfAiTRVR+H9p7v0uSSpDUqOOORBFbGbiMjZzuao1sT1hfRwux1wHENELoFJGb1AqRiH0KBh+2BUPMv0otw9FYCuP1cyifMSgXmsx86TEVAw51GjHBEzDgIIwfqc7o5BOEkm3aYV2zdbJrgIw0OLWlfyoFrPPvyyD4HvGt+rfMgToAkOgPZ8zSSnj2IX+EzztEee3zWLu8Gg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB9PR02MB6780.eurprd02.prod.outlook.com (2603:10a6:10:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sat, 27 Apr
 2024 15:06:20 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7519.030; Sat, 27 Apr 2024
 15:06:13 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Input: ff-core - prefer struct_size over open coded arithmetic
Date: Sat, 27 Apr 2024 17:05:56 +0200
Message-ID:
 <AS8PR02MB72371E646714BAE2E51A6A378B152@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [IHjNrb9xaWlw7D6/bwybrFFh+NMkoZNi]
X-ClientProxiedBy: MA4P292CA0003.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::15) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240427150556.8440-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB9PR02MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c85e9c9-0fec-4849-64ef-08dc66cb942f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	vhhjigx7RfxPnm7B8V1ypjH6kHYXpWlPkar2CV1ZPi7z3MgFrLcrRXmeDXSh3twOHH/Urq+PLudppMlH4mxJafFVnUcPcrmyHYBGYAHTMqw2xF4V+FGK1A/lBNTElWRKL+menLXzJLhmrpUNECv+V/Hs2bFcDUoXjG1+rLzwn1MLqBctjTNzztT9Kw4BtnZQ4XXzepWrPg4qnZSiWWO+WCGDQ3pDX/GSUbqP8Jw2JH5YrrJGhHI7v24T9FDsPlGsZQqJiAljgHDTRAshpOjcCIKrBWEyyAVHd0Gs98Tb8GGmXJJ2jFEguhZLStUjLy4KHdGtUk+yi+YtADV6bgeVwzNwh1k7/aW3gX5twbdSiRGsCqPDwYCkpzOLfN8KMz7G1g+I8OOspMxJjmXFzUIh3WorSg0K/ghKLL3GETRRdoRadzu6ZUY36EzExxwGVoB07VUxtFhaP8dHUHWdpfB7GC58WXqYMBwEwvXorqqynPT3O8Iq3BiCJY/euy6lXFRQtLVo1dxpSq7mkvvPXLpWvXLtaVIMZ+mWhXNIuwOjaZDpDs/6i9C5bvzAtNo3cjS3uxhSffZa8B4gzGehxd4IQGl/DGjwB3UGHZQKKLz/8ivsi7NhgHaMICiPcFeII9KyLECrOxleqe5VLrWu6ZielvddtUy9OwKuZ5V3N7j7qK10dr7ZDW4QUyrBK01HfR1xZjMLSVvFfvygRDOM+aBEUg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XkOIhrISAXDsi/X5nKBXFHK2XRnEMei8O14ADKY+5fnL2gQ2LBXUSB0mPvnq?=
 =?us-ascii?Q?ooo3s6vfNtj636sidnYwfVCt4BzJqZditIdnGjYOiOQ7iTG9+/eCE4U5Vbq8?=
 =?us-ascii?Q?t8mq7LNwGDr4dOoj5CERMQhOhwUDkceDj6u5OuXrO4HIzC4jRyqACVoNXK4i?=
 =?us-ascii?Q?Fdz1QDrxOUGKD6YDCp5m1JVaVwlsOSC/u83jCuCpdQ3CdfL2Qm+YNCDEvSKq?=
 =?us-ascii?Q?+pk4J3U4YTqoV1B1Zc9XupefFwOKQwyKmHOdiWWzqnF0bb4826VXHSkmiMde?=
 =?us-ascii?Q?ZnvfUdXIRblgFWaZruqrEYmMuZswr27YixoXsHFsnDWeHV1mJ0dRcymHV+D5?=
 =?us-ascii?Q?txH4YrSuHQm7GyVzNn0TXJPZjWlxMCG7lHSWw13ioCGNxqZribxvmELk1x4/?=
 =?us-ascii?Q?ecv+de0EgZSoOIV1psbDkqfY4LAXqTvBLNzDltPkGGoOJWaKWNsJ9o0Gfpen?=
 =?us-ascii?Q?txCEsBPOBhxENIF/dsf5AjwUQtayJQf83el6z6XpBXRjzCHyt1TJPAPEP5ip?=
 =?us-ascii?Q?H1PTYvKHvrhXzvh/MPNV6dd9D0Ai1PG+VsuEXZVSbWIOJFdtllGM93jG646R?=
 =?us-ascii?Q?V7tN2rOGs4wpfeTr12SaNRLAEi4P8BQc88PycZ1/PgCkQ9pa6vGS6ZnfOlQW?=
 =?us-ascii?Q?YAoP/lPgC0uPbyvb5LnHTp5vJ4jNtWCutbOKV973hIpW6wp/AEKD/XiWlAug?=
 =?us-ascii?Q?BNha2xsC00H4tA1UycdElbvc7U8idePr1xFqz+ZESljSbX9/8WLdoM9suu5U?=
 =?us-ascii?Q?2D322lpCUfz9Gs9S/YpG/SEEZLqRHSF4lE5Rln0x3IQRHEOs+XEvTbcWGDmz?=
 =?us-ascii?Q?WDFKn7AnSWSYUWeKHIirq3McVWiXVTuTASv87lvuuaI+sgj+9ZzLxkalz9Hk?=
 =?us-ascii?Q?+vbd7vewcVw7g22GGPblFBRTkhB+dYP18xapnjwB0KUQJclxONLe+oB8j2mH?=
 =?us-ascii?Q?lG7NPQDMIIPTQ/REQl00zgnKxptcc5i5qmmr5n5zHiFClgxDFrSJCo4KD7h+?=
 =?us-ascii?Q?vWotDtEIvFX6CDbvuuW2tlJ+lcV7npoNN2ekOLVaqaVCr2Er7zhT7SoRN3fO?=
 =?us-ascii?Q?IwpIMljRWCmq+MUPVSN5ME5o1O6jRCG00ccDL5d9/FNwBAEso9APYu06FoGt?=
 =?us-ascii?Q?x6TZdUy8pDv4ZPtGSzg8WIwUxluZ4eWx3LRQ8v+qULt/bKgIslDIOX1PtLcd?=
 =?us-ascii?Q?7dQ2JdP2yWhn6x5QKHrXwNko4wGoQYu/Muev3gzYadncqqBPPsMhc9RlfyAv?=
 =?us-ascii?Q?90SnFRb6G1ECNB1/WBd2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c85e9c9-0fec-4849-64ef-08dc66cb942f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 15:06:13.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6780

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "ff" variable is a pointer to "struct ff_device" and this
structure ends in a flexible array:

struct ff_device {
	[...]
	struct file *effect_owners[] __counted_by(max_effects);
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count * size" in
the kzalloc() function.

The struct_size() helper returns SIZE_MAX on overflow. So, refactor
the comparison to take advantage of this.

This way, the code is more readable and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Hi,

The Coccinelle script used to detect this code pattern is the following:

virtual report

@rule1@
type t1;
type t2;
identifier i0;
identifier i1;
identifier i2;
identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
position p1;
@@

i0 = sizeof(t1) + sizeof(t2) * i1;
..
i2 = ALLOC@p1(..., i0, ...);

@script:python depends on report@
p1 << rule1.p1;
@@

msg = "WARNING: verify allocation on line %s" % (p1[0].line)
coccilib.report.print_report(p1[0],msg)

Regards,
Erick
---
 drivers/input/ff-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 16231fe080b0..609a5f01761b 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -9,8 +9,10 @@
 /* #define DEBUG */
 
 #include <linux/input.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 
@@ -315,9 +317,8 @@ int input_ff_create(struct input_dev *dev, unsigned int max_effects)
 		return -EINVAL;
 	}
 
-	ff_dev_size = sizeof(struct ff_device) +
-				max_effects * sizeof(struct file *);
-	if (ff_dev_size < max_effects) /* overflow */
+	ff_dev_size = struct_size(ff, effect_owners, max_effects);
+	if (ff_dev_size == SIZE_MAX) /* overflow */
 		return -EINVAL;
 
 	ff = kzalloc(ff_dev_size, GFP_KERNEL);
-- 
2.25.1


