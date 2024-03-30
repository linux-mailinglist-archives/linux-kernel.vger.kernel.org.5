Return-Path: <linux-kernel+bounces-125800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D289892C3C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE4F28292C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58A43FB2C;
	Sat, 30 Mar 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JRrs9m6Y"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2099.outbound.protection.outlook.com [40.92.75.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EDB3B782;
	Sat, 30 Mar 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711821371; cv=fail; b=qh0pGbaPbEJAy8XDs0/knr6XpnsAOBvoJEgBIyfvUHdBT5c4FinUnnFYy7V11PjtjlNVlEkWOPWxCZ05JAUYgbbdrFgrPjhOOORrOZgwuugluqidrpUSTz+i7agsxZ7Jtv2aYqr7wHeY43O2ZTW8BEe5rSptKXYqUpG/abrtKbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711821371; c=relaxed/simple;
	bh=DQ8Ku3GvEqBANNbcoqxnO9C+PP45jr++TRQFI7UB8t4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OQqfjh6UfFvYAja2Xc21RmyQfOY7BIqxYknOZqigckNMYWDFEHtIGzuZ4oNUKJ2iWDGOHFVzC8GwqXoP97rGk/q9o86TdKI6xO6LlQQEnY0I6+01xGYEbYLyPvfvqAt4oecRGCQpxO+zcLjglPkRv3vNmJMLY+xJ3JvZqMLUqbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JRrs9m6Y; arc=fail smtp.client-ip=40.92.75.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/YrDR0dZqeh3YVDRAwPuRN8Z236ANxxzN+EI7gFYQN70alXpSBQonUhqtmtz56MAuv9bdrhePDXeeFsxvIiMPe0EzU4tZ3N/67FQxRo+bVxOQIDPGR4HKdWaeOschz03ASarWtFDCcvLm+iJG7RaxXO2KaXSMRPcjOXsDaRNtUk5Ob74XMnPiHTP/OpNqpuo7INiBg7U8Au8F4e49M2rSmzxF0W5xbLOSBsrcGxjREt66g0fQdaECMzM3aZFlTxlZxRQBM9NLy9FkofXsnF4VqPWheON5RCy//9H5dgfgqtj8zI1OD5oYrk2VjxPF31x5vVSb1nAWlqpOWEKzQGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JPYul6UFtV/uydQyRywj+NOEJaZoeTfkGCi/cPvmmA=;
 b=UV09dPhwLqYpCYYofhd0w97S6Gf3ztfXeKA28XX1vDPirZtm9u2bCr4PSo/9YvTluy71jf5u1m/pDNAD7oetA3Ay3ZFfeJ93JQD0zt4aIN+cgrB8ez6kUEenh3Xm9g3t8aAXKRCQKd47Z4fhglJz27/sRBFeBafAhuFdGgFNEx3r0FetXAygzSLMme+rgPTYgFERO8FX/fpjjRfFgh8beXuziXWleELyb247hvMUp0ZfeB5Fkr5/Ov6zNtC1iCVDhSQkK0s8qm7xDdy3ilGb1JwlpBpBL6O0q60zM/f2wiHP6HTYlVR6WabRV2evrx/v/FQ4Ff58RpcuLCP2E3m8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JPYul6UFtV/uydQyRywj+NOEJaZoeTfkGCi/cPvmmA=;
 b=JRrs9m6YPkp6zOWL2UP5f/MamNeLpahmewfpYJ/yrLS1cfssuGm8ifLScpkiMiUjoxSM8aHC/qyCBmiXXhbvmGL5Zzid0fZTsiJmdJ9+yAAIaGe/RaiPeqFD4p2TVMtbyLqszg/YUZNMDLWvH2bgFBB7UPkDMyr0gSrvnL6e0zwC0o8E4RATd8g0Px0dHmy2uukBpNA6JuEDiTQI70/Jfb/c9B2+9zGgS7Cze49dXOElQzOE/AhIT930hsN/r/aZzY+L+p5Lns7fV8biX0ZjY5jzAmIF2wcBxMOsv2Rxwz3gBToas13UyR/3McxdCHGWYO3RbLSH6MiOu80IxNNRRQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PAWPR02MB9808.eurprd02.prod.outlook.com (2603:10a6:102:2ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.42; Sat, 30 Mar
 2024 17:56:07 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.042; Sat, 30 Mar 2024
 17:56:06 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: maps: sa1100-flash: Prefer struct_size over open coded arithmetic
Date: Sat, 30 Mar 2024 18:55:35 +0100
Message-ID:
 <AS8PR02MB7237AC633B0D1D2EBD3C40E98B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [T+ZyUfahhoB55AR6bYEJtt19jsRTdR4E]
X-ClientProxiedBy: MA2P292CA0017.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::20)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240330175535.15295-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PAWPR02MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb94aeb-dc60-48f9-a86c-08dc50e2a80d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eSMvfRbAqPG5Nvow6NiLM7YQLWMKJrHb4ERXtV9go7MRQfSkf/PVG9Jo63J2insti/J0CcdqgHo3ABm2SWm97cAzI4uGjCM3b4CbJyOvI5OKg2G1OWyjoI6slGrFVBxgq5WNKu8QbCU6a/8RbTZYNNisEck64TBdm3QJnGZQE8N7bGx9hFPANsq6y+wG1ZFOxDzjyOOoo3SGcu1jtI0Re/6lQVqgVvHstOsdgjQXWHIGlHH294RQnqw9/FTRKR8excgT80BPEs9uGlSAwATuh32+OdHbMRWnEHQI7VPtiiy3gAATWaPUA96rH65kMDEjh7BQTGsgoNL6GqbXaMlBF6iWS3vB+qE/ngsaPw73/q9TNbmfz4V28z1FMfPU+eH13+ggCIfOgfhRJhSKZohJWjpzoYHGbFWjX7h/lShm+sT8uDOLJ7b1/YgKmL1UvESufb2lK/+ZdYNisQMWZi5GelHrMmR8Ind0tCmQVrVJ0OxhcpTny25/rfHwr78JlLVoDFQMDRHiIuFgXMIDZGchxWJTakmRrYDOw0NuLnfJXW2xpYeNy/5yrHG3io7I+HmAx7bm5ymcknOOu0+y9F/WPJWNI9+24LMoBkf8iAPeh0yzlJEvqc67g1h/eXsTmjgZNxY24Snzs7wGijzhkqJSXSjZzknbC72IO6GcE4IUgp7J+K7Prknkkpl0L6zpMi4a
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4KIttPLzxZLzjc2xWZCqvnNPdkSpSsxiv/YCi/v192y9H0eoyBqsvktoPZKD?=
 =?us-ascii?Q?sRfDQjoJ3wj3aIYcRUSTrYlHs1ewupB9MaUkQZu7I/tltC+ll6XbDmUcATyy?=
 =?us-ascii?Q?sRKghjg7TIt+PvyapWHI3pUJ+Axrc+E6kgUo4Sj8UAhKSyv/yntd3boVy9PG?=
 =?us-ascii?Q?nXgXd6vPAdx+xQQKQIUsTmd1uY1+VG1B//Z6Kat0vF0JyeBWZeMMMtMQ4qoB?=
 =?us-ascii?Q?U2inxLYBuZ3kcWCS4fz7az8wXgr237fBagG+OfgMR3EyvzAaTxY78pSJ8kvL?=
 =?us-ascii?Q?1xo5GPLRx5bTVQ1FM4tUArsTYzH5snrgw6G8NO4EAYpZnpokqvL/kWzo3mGY?=
 =?us-ascii?Q?7un6jnrB3lbzThw4XdR6MStLxmzPZp0BvJORESGW3QLvM64pelWvzahWEoCx?=
 =?us-ascii?Q?3RXyQQlIUg2YJX7aq9b7H0yQniIJjtrc94msVWSaj3k1InTgFfZ5VKF6tZxw?=
 =?us-ascii?Q?XmJDUJubjxHcXqqeVi4dltw4yEV/USPxYYeEtv0fhxOg4Gjlz72NYLU2Jil9?=
 =?us-ascii?Q?Z5BXAlab2ke3IGLdk2renvFKiJv0fRockoL1ctoDGkjQ0bbEGqiYuN/W1F1M?=
 =?us-ascii?Q?YAI61OLEqGGZDMot6Ojy9gjhD1PfHpMi80dEIBkpMwmSn8btiYCCiiCFKmay?=
 =?us-ascii?Q?jAhjeJ75l1wMmjUp9CwV8A+8KfYgmIkKib0Gc4IrzRs3+4L6+9M2DSpU7R+p?=
 =?us-ascii?Q?6xB0N1MhhMi16YG+LLnEHSReBHhMe2VzrRpUEIGLluNAROvh2pIdbxMtJiQZ?=
 =?us-ascii?Q?Ih0+lz41+ujgztHQNo9MB4vnKoholdWxjhlyWDgmq/LCYPww0EVxwuWEkBVL?=
 =?us-ascii?Q?34vknIECXUBYNVH4BLzJFGe4M/sfcs2NKc6AI5o6vLap5mfdzz64UUUW7Mz/?=
 =?us-ascii?Q?Q/hOGEDZIgQByj6o6S0gOnRI5UNwnBZVBUj0sUI8PHaQ7kduScqP93W86FmQ?=
 =?us-ascii?Q?iOTNSpztL167d+uYA64tAJIoS53qaQJnPbQOt9CTJ6eHEg6+2AxdvOXVrhBa?=
 =?us-ascii?Q?36v4tpVz5IJAHlahVParElhM0CqBJ8S0G/bbQtNlABacuLDVyLF4pgx4z4Xz?=
 =?us-ascii?Q?0PjPugqtCoIKcUzU7zBjj+4p3+uLUWDajXqL1nx1ZNhPXpBOYyhD6fUevtYd?=
 =?us-ascii?Q?4cCDZxyzFm3twMQL/AeN7FU/5dRDAOzMB4XaKhNvocclKH0yo5medp8JhEMI?=
 =?us-ascii?Q?61Muwe15Ys707gpqmTKHDDluk8JY2VC1DjDYp6DiwrlGvZ0nZrQzTbKEUKtL?=
 =?us-ascii?Q?eMLIpqXW0DYhFOBd2LW2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb94aeb-dc60-48f9-a86c-08dc50e2a80d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 17:56:01.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9808

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "info" variable is a pointer to "struct sa_info" and this
structure ends in a flexible array:

struct sa_info {
	[...]
	struct sa_subdev_info	subdev[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + size * count" in
the kzalloc() function.

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
 drivers/mtd/maps/sa1100-flash.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
index d4ce2376d33f..ac8a0a19a021 100644
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -153,7 +153,7 @@ static struct sa_info *sa1100_setup_mtd(struct platform_device *pdev,
 					struct flash_platform_data *plat)
 {
 	struct sa_info *info;
-	int nr, size, i, ret = 0;
+	int nr, i, ret = 0;
 
 	/*
 	 * Count number of devices.
@@ -167,12 +167,10 @@ static struct sa_info *sa1100_setup_mtd(struct platform_device *pdev,
 		goto out;
 	}
 
-	size = sizeof(struct sa_info) + sizeof(struct sa_subdev_info) * nr;
-
 	/*
 	 * Allocate the map_info structs in one go.
 	 */
-	info = kzalloc(size, GFP_KERNEL);
+	info = kzalloc(struct_size(info, subdev, nr), GFP_KERNEL);
 	if (!info) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.25.1


