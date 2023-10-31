Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3B7DD36F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376287AbjJaQxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346620AbjJaQwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2111.outbound.protection.outlook.com [40.107.21.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB71D7A;
        Tue, 31 Oct 2023 09:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN3mjdpy1jj2JsLNaO7Chj6xHRbWraMb4I/SBTVFF7JSfV3tfAK0X9n/OHEEt3CJvCZcvH1F8knQW/4o/2zjoqAimezPt5Utl0tdwzynNNP1krlNuWNIi+LRhpWpQFjQfOrTnrD8a00bZfXjQSFJZFj/aadPNPSv9S8miuwBOBkwJwk0S+ul8yLuA/NkcFZWiiUvfz8BPnXCiZhnjo2gTLs8fnNH/3MYLxP5lnuWI6qJhILdD/0BO6CoT9lW+MmIgtaBnnMlGkAYXutlbI2pgKZD0syT/gkk3glznVsYvdkcNZa48V+m0HeYg6ZPdhS/Vn3/YsqNS/fKSyk3LcCwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iz1LL4xwR1qY+CI3VRAXbhSeafq8ULEMhuPza2lb/BY=;
 b=OfLJiE8p5xZy7giJg7NkMqu9JlUU+CW+VwVFr5b4IXYOL5KrVVn4oe5cfyuVxhaDspA4vxX+rIiJbvzPfdbA4zFo59Ul61bfDmdQaZM+MSEWCQ25aNGPtRFM7FVWUOVJ5PctHarCcmoHr/FJcybyEzn4N4o7EdgeyAhgxLNFa8jAu6Yx/YttKRbGgLVoqmuvB0eoPd5ddgmETZLVKvXxQV0WokY9GysE0XPSUdVGIAbS2CHH1HxXm61/W2E1JdEUBPCfvXjx1vFLEoaaSQEBnwtilqV1f2C2dpGmHkLDBn2Y58HeTCzF+BMn3PNYTdBSrZI8SDAZCRkn/hk2r1Nqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iz1LL4xwR1qY+CI3VRAXbhSeafq8ULEMhuPza2lb/BY=;
 b=KPPbPEz/06axtAnDSocWpf9QJTTGRWAHQ/UgSMHydIju0bneRWXJnYWWh+YnrthNfb4RHv6wLmkBoTIpX6CIxk90IuxaKZgmZa3zg3TwkSea5rxVkEI5X4egYPQ7AW7lTNI5mv2Sv+eeh+Z9MYTGw4gNfHAD+wcDgOXrJvSRY/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by DB4PR03MB8706.eurprd03.prod.outlook.com
 (2603:10a6:10:382::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 16:49:51 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:51 +0000
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
Subject: [PATCH v3 08/11] clocksource: mips-gic-timer: Enable counter when CPUs start
Date:   Tue, 31 Oct 2023 17:49:24 +0100
Message-Id: <20231031164927.371663-9-aleksandar.rikalo@syrmia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9249120b-70be-44dd-94a4-08dbda316687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ff9Xids/O+qs00O8/MN5BaksOcwD8KU7oKUe2I9DWmoh1F61u+fs/JU0zB9ggQQJcL4icfSGEo0MBE4Sr9izGGmA9Byr/AqwXItTzJh2rhF0/fURYxmcNUK6itW35xXqAJTTheThhBYfawRXvjGUczVaQ9MosxW8OCmb3arbFG3hHWkQl8gzNo+/EHYV2cajVR378p7F9xh7abzYh3HT6U810xaoj8QO5HnTRh0vZz5EKaOu3jPvCS+5oOjARFyqA2+sCq0gOKKi8MGAxD/E3F2tsqC744Oy1olXcVz4aypzkvNwNdfkKlKPNqeRmEih3bwwMewqMK6wMyAEGVOFVnExvtrkeVc3cjYxEAp4zJwZWlOs84/v/lAkUnNfHqD16TyfYbhWsqavmAu5uCKGA4ZYmzBmHMITqdxgQqN26JfMvU13UFsHIPP4i1b7JEdyQb2UNCkUY5fvFTwroItqgAwh/VCfQ7vvCQeSJu0xwfK4W1HucAFl+/WAK83M6LZO9Ob5RR6c2oDVRaSu1zVu3WNUkZ8w0Z7Mjq10WSvRK+rpcmKg/Y/tz46zE8YtTnmLH806nbeXhlaZ9WKYTBQrzoeAuLeSsIi2X0vbPywru31gNmnREU6RT0lcPQJ8XN7j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39830400003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(2616005)(1076003)(26005)(6666004)(478600001)(4326008)(6506007)(83380400001)(44832011)(6486002)(7416002)(2906002)(41300700001)(66556008)(66946007)(66476007)(8936002)(8676002)(52116002)(6916009)(5660300002)(54906003)(316002)(36756003)(38100700002)(86362001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AP4HNrQMni7j3Rcag9IgZ8nI+rsB72kkqP0VY1Ay0uzulvXNoFp9LkMfDgoM?=
 =?us-ascii?Q?aaMKBIkyE/M45sQExzr4tzPb08AxTOzBsk48ZkP9CuxHKCKmkPeVe7PvdBAd?=
 =?us-ascii?Q?hF8E2WLKu6EkaR4PopGq7yFI7GgApk3zwze84w4ThHFUfYW9B+yTwvBf99q0?=
 =?us-ascii?Q?MnTaVjmY4p9xsReCFTFpQuoEUIa/oMtGERluUtaAjDfzLR1jAFWRVexLotEZ?=
 =?us-ascii?Q?tBWekbpWNgnGmIUPfh2lmWuhgbHeCN/BHvaGNsPKJRKO9SYBJPuB34LEbbaz?=
 =?us-ascii?Q?+8SedqOGUHMuKiYLtZpx0afPIwPOXdBQbfa6+Xhf2CPxiPrann60XbVFrphB?=
 =?us-ascii?Q?k/Zu4eO77nf0ZC/z1HrJe2bhKfmEbY3t4x4ejrWBmraOTbQwNiKB11FLP4Kv?=
 =?us-ascii?Q?VzAVi7k0IPk/+0erl/BVzwtAACoTpwuX627Tv+acVMqiK2EbDs21MeZVxvI5?=
 =?us-ascii?Q?iKq9WOGsz+MC7H71aT1gd4hFINLTsbCii7SPZIq9AJG3afE3xXt1BKFLdBQJ?=
 =?us-ascii?Q?Y8urr9AjLkJynd8HwoJtXQJzL+ml/tD+taOCnwgyxjV96fAkvOa859ObBMXA?=
 =?us-ascii?Q?dSD7t9gDzlgh9n61nDyoaGTGACIH5nRHQH7IgFV8T/aHbheGexdDaqG12qpJ?=
 =?us-ascii?Q?WXZle/QNNNZ3iu+XuhqkWRLGOaFzEWzvlxAbFukVPT7CZAdO7Fcdqig90Is3?=
 =?us-ascii?Q?tAN8hfChttwmczqD3DVki1tFhtJVrHUnpDi3V1AlQxt4CB+eo3v8oSy4j26s?=
 =?us-ascii?Q?OXWTmxjmOj3mrUM0NunCxd3ZryXJ81ZGkY8YYeARnz+G6i6wB1TouavUvNrl?=
 =?us-ascii?Q?51cqR2ucQlMvdgcINwYZMaZmNaKSeF7mDPeUnvLESF6/KWEGHtiagBumYEP0?=
 =?us-ascii?Q?qKBj9PrQB34pSRZe957SV7zO4Czdi+J0ndy17MXTVgoZveXPGVFyoODzB6I/?=
 =?us-ascii?Q?O7byCG+3OYIR5P0u+leI25Lg2ZbOpCDq2YiR5iqSqQkeAueO5SLehMAKKU7L?=
 =?us-ascii?Q?uEJbIQtdqJ1VIUc3FvtPp6FAkz4umE85TweQ101zGoVzmqGwA3osy1obzYkL?=
 =?us-ascii?Q?vLmPoBqpXZwPWWk/rBmdqzmeKg+iEMNkUa/Mo8G+gbqXWC+PU2as7eBO+kRx?=
 =?us-ascii?Q?erREIByWTBqIpYj2IpeTsfUkZi2WzB+e0mk4bmcr+SPrGRGEkuWEcjdiXTXf?=
 =?us-ascii?Q?/uKMvqkE031PWhUrXVEKZXWJW89aKvL42ESfqeQUfCpEdGI3RV0VUHZ1VdWk?=
 =?us-ascii?Q?B+YiJAYhrkE1KkfEulqoR26vEBp202eIYkqCkeWcaiYGTz2agpv8IOR4pGGs?=
 =?us-ascii?Q?4Jyct3UjOYaMnxf3iu2sx/kbfUTj+XRgmtRuXmZOiad61oIGQsrglx4KgKaT?=
 =?us-ascii?Q?Zolu6JtLmaumItF2zPIkKQ2EXoq/rg0BxB4hPWCENhLcbPsbTuseJ5S8w2TP?=
 =?us-ascii?Q?cBYRD/m3xmP6tlv0Qhmdrgqd1LfA8WawLhiL8pR54wNSsToBFRyK0aJ6mU4I?=
 =?us-ascii?Q?og9MSKvf7X5JGn1Y3QGN592XPiQPT31wQRRU0qB94GUx/CdZohiEDnnFbEJL?=
 =?us-ascii?Q?O2YSm52IhLE1I3/mXlqm8lix+h0I1rr0zkOZFq19A83LtBmCMcy5urAeK0Xg?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9249120b-70be-44dd-94a4-08dbda316687
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:51.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxwSUaRS2OkLiZnGwalwvQlJpBlKKXTkwTqyk1IaCAbI20eRX/FmNNtjy458wFlwrKmZi6hKk4CEcl9C+h7IpsXKeH1KbbHoNo09WUraji4=
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

In multi-cluster MIPS I6500 systems we have a GIC in each cluster, each
with its own counter. When a cluster powers up the counter will be
stopped, with the COUNTSTOP bit set in the GIC_CONFIG register.

In single cluster systems it has been fine for us to clear COUNTSTOP
once in gic_clocksource_of_init() in order to start the counter, since
with only one cluster we know that we won't be resetting that cluster's
GIC at any point (ignoring suspend/resume cycles which would need to
handle clearing COUNTSTOP in the resume path). Once we support
multi-cluster systems this will only have started the counter in the
boot cluster, and any CPUs in other clusters will find their counter
stopped which will break the GIC clock_event_device.

Resolve this by having CPUs clear the COUNTSTOP bit when they come
online, using the existing gic_starting_cpu() CPU hotplug callback. This
will allow CPUs in secondary clusters to ensure that the cluster's GIC
counter is running as expected.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 drivers/clocksource/mips-gic-timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index ebf308916fb1..4d7659c119e1 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -114,6 +114,9 @@ static void gic_update_frequency(void *data)
 
 static int gic_starting_cpu(unsigned int cpu)
 {
+	/* Ensure the GIC counter is running */
+	clear_gic_config(GIC_CONFIG_COUNTSTOP);
+
 	gic_clockevent_cpu_init(cpu, this_cpu_ptr(&gic_clockevent_device));
 	return 0;
 }
@@ -284,9 +287,6 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 			pr_warn("Unable to register clock notifier\n");
 	}
 
-	/* And finally start the counter */
-	clear_gic_config(GIC_CONFIG_COUNTSTOP);
-
 	/*
 	 * It's safe to use the MIPS GIC timer as a sched clock source only if
 	 * its ticks are stable, which is true on either the platforms with
-- 
2.25.1

