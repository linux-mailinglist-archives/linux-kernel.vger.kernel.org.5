Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491EF7DD349
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346372AbjJaQw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346981AbjJaQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2093.outbound.protection.outlook.com [40.107.21.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB4109;
        Tue, 31 Oct 2023 09:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyS/DoXmFfJ8MjiBCYM0+zbqOnoXK07kgmukHETT0T5sP8V6vX5FPjjIB5omDOPrkBh1CR1mSs5fijegvm5cKx1tFAXGUdAE0XEdqxmiAuarBKMVG6bgEChRdYJe6qbPkMwhkb/G3oCQpQ06sJwJbIFWnVqAy8L08HrHaaoZaMBPli42U5HYlvnDE25S70fh71k1JxNiC1shBrDt4QzHyPyy2MQRx14dGs2WKW3CWZE3sxdGoPmO4EwnVwFEpv5tSmbE1bpEqxb3ZLyK8nU2lQsKSFGWVTz/MtWJU4fDUPl8M1RQ/JIdn/d1tSiyQBv0E+VxJwOD42Fwicd2InFDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2jU9hcJJvjycWI0LzJaha4TVcJ8lynqddYoHA2of7o=;
 b=VUJ/bw0AmTvAri5GldJw8DNdpmeFjC0g5qum6ajSlmX4jofVgAReWVxqp2Iaw+H6LO/WTTCGaIPabSIttFo2gL2NVXoxeZsMn28R2xtI25dR5USLOxP36n30AUtt/YuTS1deEBQCjbvZS8zNg/wnnCxC0MJxoqx0zk4jmoDBqOi0oUV8P8/BSo4Izi1gQogOO45XRFHx8iBCPjdH1FyivUVQOsMpMtzkk7UuJEAKsLX77mV0VwNEFyp4baWU5qpjjJ4Tr58AMBUHhDHwdxzVPWrAd8MAx72bXpgS6YzD+nVBOciDArBaCCL3MWthGicddkpy2yyYLzWqtARGmWXCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2jU9hcJJvjycWI0LzJaha4TVcJ8lynqddYoHA2of7o=;
 b=ABUXcuSyyAsmxmKGA1xrXOdYwRbDrA0yk28bg7Uqp/0yanStMMsIkYiVytsIbIRY5Mzrm0DDdV34rEGiuLfkzLVSqLXOShKJwsRpvvUjhnHCG6EuIUIyjLjSdtOh38Ib3sow0DgvsKGCQW2n1zrXvoTwUWK6b8vUoXnM5yZbPA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by AM9PR03MB7187.eurprd03.prod.outlook.com
 (2603:10a6:20b:26f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 16:49:38 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:37 +0000
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
Subject: [PATCH v3 01/11] MIPS: CPS: Add a couple of multi-cluster utility functions
Date:   Tue, 31 Oct 2023 17:49:17 +0100
Message-Id: <20231031164927.371663-2-aleksandar.rikalo@syrmia.com>
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
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3486:EE_|AM9PR03MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: a58be8d6-331a-4342-f1aa-08dbda315e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4phfKkbMAc0VRJF01Ltt6dBAjYVo9XtKG+G8O03AItSChvwLeV2aaJwv6FLnGxNoHSZ365reKeHS3rGsdmbNk/b1TgT6LcIi1+RyasXyjpjRLAr2bejMt/SNXQbkhMGGQf8T9+qwE4M0ZnwWLCNi58Mb4KY1+7L09Wttr1VDvtE37IpE4nYnJxOiriaQUSA/RJMNqhuOeygctLDRhPYfvOcLRvYdeN6DArsSsOpY8J/QEylvFiA/4iWKCPW3blfTQPYh1TG3YzDYfUJoQNUWtcdwjSOy+hiWLqp6LalBJCv08ukGEetjE7aEQScrddnl3idH12DPYpdjOJmVbqEeowNBFHD0aKGJR0dvBOhh7gKJ1Kqi6qE5/pGhR7pJKYVdtJqYQiBJmRdSuXkpBAwV9A8AjWvgEQV/fcalWL1u4iKhCKQlyhHWHHIeMu4c2T+216/IkyjOIbXVSiDXbxeJ4jwAg/c+gVjGXy1EftGk/4cPNc2SFpiRs/rTIoNlghMzqtVrK0ETssirhcL3bkfRDkRSq3+1J32OjP/wjKEtUdF5fwmOqSyzU9/k7I0cFYN8s1/GJ4dhdPg7Bh60GJDPeRq1PCp/pGOdlZFWy1p4WtOMqNsiqrPu01MYiLcOpwfC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(44832011)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(8936002)(7416002)(478600001)(2906002)(4326008)(5660300002)(8676002)(6486002)(26005)(52116002)(6512007)(6506007)(2616005)(83380400001)(36756003)(1076003)(38350700005)(38100700002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xEddZ16Vfy9XVW3TlGCbi8l5XRxRGMbFz6DqcFottOeBmIUZp5JF0sgpEfIf?=
 =?us-ascii?Q?QvZeE9rU8qqKIpwcdz0MHZovNpAsA7K81hCWz2zD4SY+V2rkIc/zdOI5Ero7?=
 =?us-ascii?Q?OGgE842PID7lP/pA96eQ9ViLHCAZC48kznaBvKKnAnI4h9MIVGhxl/vnNpVb?=
 =?us-ascii?Q?gwiWNH8IYsyF53nFxu+x6yCMM53xpDznlnoQ0Kj9xwTUhuV0NuXxZKY0Jiz3?=
 =?us-ascii?Q?Miyr07TKvJcVVYJINtJ6Ug/8Rtx5rZCs17z1RXUMtYCSR8+KvJCov/Zn7QWJ?=
 =?us-ascii?Q?9zh+3YRHzQigPOhCXCPpzNNi18Mx07/xMn/HydYmtCReQGck0oOsc4XKJ8nU?=
 =?us-ascii?Q?gP9LJmqBeTjk/HXrgkFlyye/PmnGbPo2YVwHURVF5lI4upA91z0H26dh+thW?=
 =?us-ascii?Q?1bc+FMPrQaEbtaYEqCdO7L2LCR+1B6Eiow+4opztkQhARh2hoMXyqI8zEaSo?=
 =?us-ascii?Q?fNRyht1v8KHieK/4eN0MF/nR/op7knD9UCrJ9z6Ya1L6UCORW6YdLq8so2XT?=
 =?us-ascii?Q?ZZFIOjcXRkFBytSmdrGuUdWButVShgK/J67uz7Jrovsgz91FNFAxhZIXAJ7j?=
 =?us-ascii?Q?xqiSGL2pH3CpsMjvtSzwX0Fr+MCrvf2v/XxRjV3nit+TOynQhG9jCJ1F4nsm?=
 =?us-ascii?Q?OCf0OcnKlNUU8naSUh2wRsz1ahD4shcagl8FX1uG3dFNtZ4BPV1KiC2Dnkva?=
 =?us-ascii?Q?C0FJtqetmYLuw7xmQ1FfprIeAKBGfmonxQ/GtSWI8I/RrFHboOm3Sd4+mCKs?=
 =?us-ascii?Q?+Hqsj2UY3XbYZsx4aiV9wqdGsNxElldnJW2pvUDmrNW+4vxNIKTFSAbblidc?=
 =?us-ascii?Q?iIeoBNQW4qLGIDtQLe3ApAxMqC0h6WRpozj4fhp3mLs6M7WE6AjhwMia+mCp?=
 =?us-ascii?Q?k8gZ8HNCpIKlaR2kGfsDTPr4mnepZuFFAUs9xcK4aJ4/GWJes+C1iX+Rucmk?=
 =?us-ascii?Q?IU37oxSbV+EvNSaCcag8Wl3zq+ucr4hNbwPuXUYZJ+hkOD19bs1kq571UwZ8?=
 =?us-ascii?Q?1vnTJCEQHW0Saamr5qLyQy4Tuk3Uu4G6cJ+zT7eStiHGfEl1XoIDy4gvcdPN?=
 =?us-ascii?Q?oXEJPvDWMA0nGgQ81IfcWXSxkZkgqrdkozbBQsd9TNeGtBMiTRDt9ItqgyQS?=
 =?us-ascii?Q?JATEw0s0uv5qIqWeeta8pfjoXYZPQFu5zxLCwSjbsXwbgkcgeUD8E/C23+zy?=
 =?us-ascii?Q?TfXcH4sBF/FJgHMDHnzHexhUoZu93e7Eq6OPJjcQZKDUds2RfWprhEVF795s?=
 =?us-ascii?Q?x8KdH0aMcwKyxyYEoE0ALOnRvZURi9H2LWUJjcrX6FSfdVgEKk6NH7uU13/9?=
 =?us-ascii?Q?akRpVlRzTil8qR0ho31FdfAjki1gC/oSOr1blHTgcOX7T1SA+xfhY8k2W0s0?=
 =?us-ascii?Q?HXdrorni9+tltCKLxVqw3LJmJ/oLqs6/SCC5J27iVL7/PFVd5igNInjTtBPe?=
 =?us-ascii?Q?dX+7t4Xpa2bi4ieJUH3tvKSszITdEH3vfYlxGpegPplHxul5KTCKJ57wGL0J?=
 =?us-ascii?Q?soed7SAPL58Z8sVW3dv1uW+Sh6pP0ZN7DOw+5+6a6K285N+1LX/kLAgvxzz2?=
 =?us-ascii?Q?+NPStoqa+lYQBQ44gYzl15XK2DGPngVosRBBOULCDATmvPYfCHJLYBQy6zqf?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58be8d6-331a-4342-f1aa-08dbda315e89
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:37.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYDvuTF9hLWFt69mvyz6pr+xy4s/nQbZjfQwoERftrpwdGr6arPMmJXXk4TVZC8NtU24bf9FjJ+VXFDYWK/BUgMDUIPmpafTuR5xIOMpbHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7187
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

This patch introduces a couple of utility functions which help later
patches with introducing support for multi-cluster systems.

 - mips_cps_multicluster_cpus() allows its caller to determine whether
   the system includes CPUs spread across multiple clusters. This is
   useful because in some cases behaviour can be more optimal taking
   this knowledge into account. The means by which we check this is
   dependent upon the way we probe CPUs & assign their numbers, so
   keeping this knowledge confined here in arch/mips/ seems appropriate.

 - mips_cps_first_online_in_cluster() allows its caller to determine
   whether it is running upon the first CPU online within its cluster.
   This information is useful in cases where some cluster-wide
   configuration may need to occur, but should not be repeated if
   another CPU in the cluster is already online. Similarly to the above
   this is determined based upon knowledge of CPU numbering so it makes
   sense to keep that knowledge in arch/mips/. The function is defined
   in mips-cm.c rather than in asm/mips-cps.h in order to allow us to
   use asm/cpu-info.h & linux/smp.h without encountering an include
   nightmare.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 arch/mips/include/asm/mips-cps.h | 38 ++++++++++++++++++++++++++++++++
 arch/mips/kernel/mips-cm.c       | 37 +++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/arch/mips/include/asm/mips-cps.h b/arch/mips/include/asm/mips-cps.h
index c077e8d100f5..fa71cf3a25d7 100644
--- a/arch/mips/include/asm/mips-cps.h
+++ b/arch/mips/include/asm/mips-cps.h
@@ -228,4 +228,42 @@ static inline unsigned int mips_cps_numvps(unsigned int cluster, unsigned int co
 	return FIELD_GET(CM_GCR_Cx_CONFIG_PVPE, cfg + 1);
 }
 
+/**
+ * mips_cps_multicluster_cpus() - Detect whether CPUs are in multiple clusters
+ *
+ * Determine whether the system includes CPUs in multiple clusters - ie.
+ * whether we can treat the system as single or multi-cluster as far as CPUs
+ * are concerned. Note that this is slightly different to simply checking
+ * whether multiple clusters are present - it is possible for there to be
+ * clusters which contain no CPUs, which this function will effectively ignore.
+ *
+ * Returns true if CPUs are spread across multiple clusters, else false.
+ */
+static inline bool mips_cps_multicluster_cpus(void)
+{
+	unsigned int first_cl, last_cl;
+
+	/*
+	 * CPUs are numbered sequentially by cluster - ie. CPUs 0..X will be in
+	 * cluster 0, CPUs X+1..Y in cluster 1, CPUs Y+1..Z in cluster 2 etc.
+	 *
+	 * Thus we can detect multiple clusters trivially by checking whether
+	 * the first & last CPUs belong to the same cluster.
+	 */
+	first_cl = cpu_cluster(&boot_cpu_data);
+	last_cl = cpu_cluster(&cpu_data[nr_cpu_ids - 1]);
+	return first_cl != last_cl;
+}
+
+/**
+ * mips_cps_first_online_in_cluster() - Detect if CPU is first online in cluster
+ *
+ * Determine whether the local CPU is the first to be brought online in its
+ * cluster - that is, whether there are any other online CPUs in the local
+ * cluster.
+ *
+ * Returns true if this CPU is first online, else false.
+ */
+extern unsigned int mips_cps_first_online_in_cluster(void);
+
 #endif /* __MIPS_ASM_MIPS_CPS_H__ */
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 3f00788b0871..2a59f0842a4a 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -518,3 +518,40 @@ void mips_cm_error_report(void)
 	/* reprime cause register */
 	write_gcr_error_cause(cm_error);
 }
+
+unsigned int mips_cps_first_online_in_cluster(void)
+{
+	unsigned int local_cl;
+	int i;
+
+	local_cl = cpu_cluster(&current_cpu_data);
+
+	/*
+	 * We rely upon knowledge that CPUs are numbered sequentially by
+	 * cluster - ie. CPUs 0..X will be in cluster 0, CPUs X+1..Y in cluster
+	 * 1, CPUs Y+1..Z in cluster 2 etc. This means that CPUs in the same
+	 * cluster will immediately precede or follow one another.
+	 *
+	 * First we scan backwards, until we find an online CPU in the cluster
+	 * or we move on to another cluster.
+	 */
+	for (i = smp_processor_id() - 1; i >= 0; i--) {
+		if (cpu_cluster(&cpu_data[i]) != local_cl)
+			break;
+		if (!cpu_online(i))
+			continue;
+		return false;
+	}
+
+	/* Then do the same for higher numbered CPUs */
+	for (i = smp_processor_id() + 1; i < nr_cpu_ids; i++) {
+		if (cpu_cluster(&cpu_data[i]) != local_cl)
+			break;
+		if (!cpu_online(i))
+			continue;
+		return false;
+	}
+
+	/* We found no online CPUs in the local cluster */
+	return true;
+}
-- 
2.25.1

