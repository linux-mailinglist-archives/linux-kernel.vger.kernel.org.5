Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705EB7DD374
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376278AbjJaQxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346564AbjJaQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2111.outbound.protection.outlook.com [40.107.21.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61818D66;
        Tue, 31 Oct 2023 09:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eeq4Us+7gLBAUUS54Yeh1SgmxfEOj6Rv7miU0TIfM5affryinP69Lcq7oQhOfGNfsvYWe838IbPqY3+ddYXlgVtV0JjXQShjFQpeQMlWRrPHHcbKh0P7WgrUL2gL/wUE/4jgie3CLb+VYjTV1k25t4ZkiqcVvnmFFomY5xclZTp1KTXqoHbHwKUPlpM4Cp4EqGeCiyvPJ50qh0Ba7fNlEpo1Q2Myw3iHL1KABI1GK5ITSd5bSEgaohICt+wtW3VOH88kVOmVbQOAw+nCMvqEnECSShyUvbUcaYEMXP04LGjSFqBLyBodi6n/+TAKNEV6v0pxJNyrDf9l4BfR46vnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycEafZF00N9zzFb7QKUWXvaaWImNBOBHoDnUbB3BRsg=;
 b=WB/mgxmHZth4KYS3wO2K1AzT21tSRUxitEDHAPAB6d4KHdwyn0ICf7bpqBoaux+F6q0sVOp3KdHK7KeurMgubhxWdEQ1aZ7Gnen3hO8jlyPVZ89kglH9NQzPAihsSk942SSh5ZcC2aIESPvHF3Vrbq6yGvWWAsaUQN+360Acoq8Ec2Xv/0/Xy1tJa9Uyp7Y+fjY3EFvsMHVOtSXJoqmlEncQvs/XD8t8ectknmFzjoJD1AeLpaybehX3njxpRYfbBNkkvq7D+KlFdVFJcgbM4mCUqcxhVBXbWIUb9rVAXxlrM7RGy6GBkVfUK0tODQ9eCdd/6HYPEWdFMGwAGjPxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycEafZF00N9zzFb7QKUWXvaaWImNBOBHoDnUbB3BRsg=;
 b=Xc6VUORD0AdzUVHtEGLZDC3/pyB69+lj/UJ5ztmsnRCOmpK0VDO9XhPyLDHAGVoQ+dd1cmnF2/vznSt1Tsh/9XaN1XuY62AsFEzTlB6gS+olNwbt0D5WOpdZj72byxQigCdg2SVO0aRieK2sCAIdzoTQoQpE8Ot54ywCtytncOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by DB4PR03MB8706.eurprd03.prod.outlook.com
 (2603:10a6:10:382::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 16:49:49 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:49 +0000
From:   Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Aleksandar Rikalo <arikalo@gmail.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v3 07/11] clocksource: mips-gic-timer: Always use cluster 0 counter as clocksource
Date:   Tue, 31 Oct 2023 17:49:23 +0100
Message-Id: <20231031164927.371663-8-aleksandar.rikalo@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031164927.371663-1-aleksandar.rikalo@syrmia.com>
References: <20231031164927.371663-1-aleksandar.rikalo@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::18) To VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3486:EE_|DB4PR03MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa1f8e2-7f7e-4f8f-7a3e-08dbda316569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4QtzvVOt1LA31hNatq6wES4WXW2Pw0dXurtziAsYa+NspcK0fhQvFFqW1x3nk6ZuMgjKia3s9m24rPZOepH5J/Z9ih6nLwfee5FiHHO95uxxMreJanzMzuz+KmwIfcd3cqa3wUpmPtt3B+SaXHtNwAl5R2NHUx/8VUpTmxGdlSK6v/GK9y0ADD2RQZF21Czu9DjMCD5MjAPHgJEsBiQ0zhxNZzogTQNb/0olkQKqV8/TgwH40n3Ec28ufknuOE+j9vtBfzfizPL5X37jFc/5JRl+LHtCDsOMr6BlMjUnC3yHwTPRcixlLHDfN/iZ2bW4SusMSDtsg+6Y8byQ2WOBKdR8YdQ8wd/S6tCx1g01plZMtxaKQHiRHxfRz9NyOwkazlt/alJpqc4/heDLyyX6dpSCfXaX5m38HPaEXUu9glDnfcQN0bvsbDUhQUU0aoMlgFEgHL31H0RhqnRGwVa4Fo9P0zwCp7J3G7cupJzEPN01MZCSNiUeYTYvKv0+mv5vHWj1tCrtP18RUwJKidB90LEvMGwaSOMdWi28Ug/h7ozSZi/ESbCYEUMrJi7NnbahXQqSxNxqSGKDcyqEI4/aIQgrwjXtvgJKr0M7r5sP1XCJ0lDZR5J6G6QzlUeLcaZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39830400003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(2616005)(1076003)(26005)(6666004)(478600001)(4326008)(6506007)(83380400001)(44832011)(6486002)(7416002)(2906002)(41300700001)(66556008)(66946007)(66476007)(8936002)(8676002)(52116002)(6916009)(5660300002)(54906003)(316002)(36756003)(38100700002)(86362001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IXrbR42uKgIc3XGKfxA22l1XukV5C88Q6vMxEuPSkcUcXMFURySTrBiR82Dj?=
 =?us-ascii?Q?we6AqJd+vtEqTy+9hVyXegcJlKdFE7OrxEhJPr3LuucbRd+OioMm8n8CX2t5?=
 =?us-ascii?Q?aKmHOZ9o0r9dD7jqrpvoO/Pa2+QaFOpWxad2jDs7gxVod2BNmO+dAhmR10Ho?=
 =?us-ascii?Q?HRGnMBUScfWPCi9uOnY2ur2zuIyigAJtg1mE6qg2/WRrgIB8RcgaGOtjSWP5?=
 =?us-ascii?Q?b11tJJr2gmNQke2X1EqJ6lyBniIXmYcvzYVfUQsMYSwvA9xHa2ML++Iv5IPv?=
 =?us-ascii?Q?Gf0k9vrnXZbPjXopmcLuP3qMjkvYc8MAp/NBuu+xAspBjABM0jxCXlysxs/p?=
 =?us-ascii?Q?rgauFnrgacl6XHWcGzuvn/yArMmS7TU8eaafBxTjI/0OJr5H0GhlqOWDItcW?=
 =?us-ascii?Q?WJ8nlnNKWnLLLC1+SMcIRmHdKRkeMCtYiATs/JlQg+wUaGyuhX85N2DPECxg?=
 =?us-ascii?Q?/dq3SfbblUhnbKYRKzrkx/FuysILgeP+sBpqlN8TikOLk/XepK+m+9iAZrlZ?=
 =?us-ascii?Q?+cP+tIi8D1F1XBF+CCkmFdswK0B49HtGuOXrjB13L792cKyrxnwF1Ooa3rOw?=
 =?us-ascii?Q?k9hHeJBh9G3QLZMg6fVMd7iJhT8uDaDUpV6UTGthvPcac8LMNpVSBZs4DaTM?=
 =?us-ascii?Q?yD50GrYh0Tl8yAZfHi5geg/ieu6wAk/oaCtRTlfkbcboPgr6P17iYlWrITzj?=
 =?us-ascii?Q?fqCUVJOSEH5fVsps17POLS8iieHDMggH73bhPD2zVuf2hISahgF3Covue6Zl?=
 =?us-ascii?Q?tNxSv6lz12X0P6OnEzvJEw1GwFS6wmLjjsXJxsnXlNnBCs+tF+SaZPgJeyl2?=
 =?us-ascii?Q?DWkMs2uOPOGSOeYtK26uzkn9OTRGd7zsXgW1Y2KTifMpKbOFatDtftm6GJGc?=
 =?us-ascii?Q?EgqRwsFqdut1yv6pRe8pH6ODiZ0oZ5F2PngYL2iSXpK/5expolO9QPBuDdE7?=
 =?us-ascii?Q?9ffM0Qr/Es18u3KrvSEpI5zAtXMRR2V7HPfmkSmxoOFQ0tve2HSl9cFNMBwo?=
 =?us-ascii?Q?IB5ri9QcbjatV9AeGfiiLlDqG/TC8XzSPiXSZPCGZZRrBLKyg6V6dY/2097b?=
 =?us-ascii?Q?VvBdGhFUczc1d21K379ODLZRTg0+ZCzR4XXgglmmRQOK/PBiuEzBjPqO5bES?=
 =?us-ascii?Q?WMkCksS5e3sl4o6XynRkwvFyb+u7ytrrIAV6gFJzFkiTd05sB4igSwkzxGQM?=
 =?us-ascii?Q?5Uf9gp7kpkfTNj6dGIZts9Gr3QS64i43Kr1zPDZF87d7ERek+1VQeMu2P3h9?=
 =?us-ascii?Q?iROE/GZyTXM5V/N0wdlERpM844gKt6y3mez62C8ktFB9Oac2jssonJofTnKx?=
 =?us-ascii?Q?ix+n0m+/sIlmA1OwKQXQSnBUlgnHqFEgGq2QIzmgaklB3SjRvu1AU4mvwh9A?=
 =?us-ascii?Q?yR+IFPoM8bb7trUbFZnFZbsY3WKB4lxBnga4rjc+8okQUEMQtgMsAwyqNIoT?=
 =?us-ascii?Q?zG690f7OagkJUMycCpf0eqGQ2n7SkNodnPgDJzDc1buJoZsQDh3MPnCU0jlE?=
 =?us-ascii?Q?zkOuVDk9gaj3LPz66xUG7T+hCikpaBbqA6PiGqZBTQa53hj44mtxFvqgAj5g?=
 =?us-ascii?Q?2i5AbDznPA6/pqYhse7fzH3uwYL1VrnXdiczEQAc827dRlyQIehTl5k4E9Dh?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa1f8e2-7f7e-4f8f-7a3e-08dbda316569
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:49.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBuu64R/0pkIKwawouG/XaYppsMzw/yw6wS7Z7zTtnMr1WnpvOaoXTK2noPcw67UklIHz5VEDMteRvRd8/6NJss+I0nwf4IAuWNqfvfp5oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB8706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

In a multi-cluster MIPS system we have multiple GICs - one in each
cluster - each of which has its own independent counter. The counters in
each GIC are not synchronised in any way, so they can drift relative to
one another through the lifetime of the system. This is problematic for
a clocksource which ought to be global.

Avoid problems by always accessing cluster 0's counter, using
cross-cluster register access. This adds overhead so we only do so on
systems where we actually have CPUs present in multiple clusters.
For now, be extra conservative and don't use gic counter for vdso or
sched_clock in this case.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 drivers/clocksource/mips-gic-timer.c | 39 +++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index b3ae38f36720..ebf308916fb1 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -165,6 +165,37 @@ static u64 gic_hpt_read(struct clocksource *cs)
 	return gic_read_count();
 }
 
+static u64 gic_hpt_read_multicluster(struct clocksource *cs)
+{
+	unsigned int hi, hi2, lo;
+	u64 count;
+
+	mips_cm_lock_other(0, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
+
+	if (mips_cm_is64) {
+		count = read_gic_redir_counter();
+		goto out;
+	}
+
+	hi = read_gic_redir_counter_32h();
+	while (true) {
+		lo = read_gic_redir_counter_32l();
+
+		/* If hi didn't change then lo didn't wrap & we're done */
+		hi2 = read_gic_redir_counter_32h();
+		if (hi2 == hi)
+			break;
+
+		/* Otherwise, repeat with the latest hi value */
+		hi = hi2;
+	}
+
+	count = (((u64)hi) << 32) + lo;
+out:
+	mips_cm_unlock_other();
+	return count;
+}
+
 static struct clocksource gic_clocksource = {
 	.name			= "GIC",
 	.read			= gic_hpt_read,
@@ -199,6 +230,11 @@ static int __init __gic_clocksource_init(void)
 	/* Calculate a somewhat reasonable rating value. */
 	gic_clocksource.rating = 200 + gic_frequency / 10000000;
 
+	if (mips_cps_multicluster_cpus()) {
+		gic_clocksource.read = &gic_hpt_read_multicluster;
+		gic_clocksource.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
+	}
+
 	ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
 	if (ret < 0)
 		pr_warn("Unable to register clocksource\n");
@@ -257,7 +293,8 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 	 * stable CPU frequency or on the platforms with CM3 and CPU frequency
 	 * change performed by the CPC core clocks divider.
 	 */
-	if (mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) {
+	if ((mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) &&
+	     !mips_cps_multicluster_cpus()) {
 		sched_clock_register(mips_cm_is64 ?
 				     gic_read_count_64 : gic_read_count_2x32,
 				     64, gic_frequency);
-- 
2.25.1

