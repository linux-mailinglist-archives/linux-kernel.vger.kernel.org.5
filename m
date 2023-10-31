Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524127DD339
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347009AbjJaQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346986AbjJaQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2093.outbound.protection.outlook.com [40.107.21.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3096BA2;
        Tue, 31 Oct 2023 09:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMbOBMvLyvdwi6U6WFzfa+FuMY+/FMKP4Bvrbj+Zp011P8oQGikYfgLEq7NUJeK0nIfybRM5X5rolVoOK1yjV2xfAWljiQOYeBMZDIj5T/D1+YLnwpJXy2APk2o7pyKJ3HRngMqFBmkEaZPQ1M8/L7HPpM+abuqhJCxBkjr3aeYtlLeTaTSVi6EfBd0+DKsAo8v4VYOxiSjsmkyjXrzoaVVDoQ6imISlWWqX9jefcPQIgsdsXgYCMztNLpKTgB6GVKkxzL3ycCsWWC88bYquFL19sfL5OWtCcuN9FPE9n3CThQQHdh4wCiNbant37SGeykVYLTSyfYST3i/675SHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J441UACOmM+plHFUNs2UCVgRdvQT0qPnSeGsc/Q08Aw=;
 b=GcSgjhfZLZ0tEYU7aAaGOB2hLBge2Yg5YT8kYm+LME1CWG5Revyhv40FiexfM94vbkyxDt2bfG2qFx4qI/32vfmoJQsUaXaHPXQb9NGTQi1Rzt+VVsrox+uj5/XGuGt5Sl0Qzdg+58VU8bOAChffda0jjoIpDkJ7ZHbLj8zLt72qm/EKaAjOpZ5XZWueSlR6TIfLsG3xs8nc3sieDxDJy5x5utQLHHlpRwflw4KyXc9O9PjeGHpNqPmlYHGpPfqkPozYpMIQBr70KD6g6z9DlhEdi3Zsyx1IicsiIEfQGTxFA9qElx9H7s07AdK+0xQ1JYH8osWl+GE5B2lwmwXsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J441UACOmM+plHFUNs2UCVgRdvQT0qPnSeGsc/Q08Aw=;
 b=SPshZl/9NE3/T5GO+y9KXv1mvt9XaiJYper0PtfUBeG/mm0y8iPc12c7870OaeO9u4glGiKtAV1UcGCLbQd21os4bDVci0xHtcFEzv+bwM1tBTLrLlN39eNV4h8dkpKKRL0jtiuKwRbQUgLsydo2PVn7EbsutNuIP5TRzTI1PLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by AM9PR03MB7187.eurprd03.prod.outlook.com
 (2603:10a6:20b:26f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 16:49:39 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:39 +0000
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
Subject: [PATCH v3 02/11] MIPS: GIC: Generate redirect block accessors
Date:   Tue, 31 Oct 2023 17:49:18 +0100
Message-Id: <20231031164927.371663-3-aleksandar.rikalo@syrmia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0065edd-c448-402f-204a-08dbda315f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DIEhVIb7q1m2HlymGmzOTNEKkHaWR21z3vaCE6Fni3kAuNiEzCfBiBW4k+BL081AWXWf86FwtgDol6kvVYaRlUu8i75OepjdqxH5069CkzK2fzOQ8SZEGUQUbX9+p3sgu4wnte1BvP42hQ+jnUUUw1fZM20G9fvnbwjKbHDtKlvu9PhrVd4uN/KmjhgGKsvONtXfZr+Ab2NaotxriYoXqvJMcGOxrGjRGcDeffI5rHPtMrY0af5FeulAn25igx/SIMngytTamjC5Ntp3KCUtcyfjJ2v0C2USoLK+UGWxZOp6yF8x1qJD54jpyW7tVF3TLPK+2URDTzV6MMdAubVTOV0GsVmaAVqjTmtp5BjbztqtRXHCkMnyyIHPMXrsHE/CQwyKnNFqo2fxXKaYAUpk8FeWDuPJ7ciD0dhLPtHmAzQjs+zLtprj4TMResKcsBXQhrEc4IuEJWpL8YJaHr6PyIvjcs1FnRpxP59OB9jqHillobM9eoIeq3XljWNYlAfEEmMvn2YuoPLny+FrgnifNfAFUrlJfxaQCIkWh1atmIJlFfwxtv+RrtPpiytBfbdssrGciylcolF0aD7wkG2ieZ/DFCoC8ZGJ/NFHy4JHtHpdYXtGsqHLl5lMrAj4sbS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(44832011)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(8936002)(7416002)(478600001)(2906002)(4326008)(5660300002)(8676002)(6486002)(26005)(52116002)(6512007)(6506007)(2616005)(83380400001)(36756003)(1076003)(38350700005)(38100700002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HUEFBIF9YntORipCHBEGVPEK5SOzz+i6b9tRG0g5VSQB4zvQXRcLD3PMUeYi?=
 =?us-ascii?Q?f5IaCcbUQq+ykLlsy1bzbVYHe2m3j13Ic5aDOFl59vj76IsyeKTBSKdubNtQ?=
 =?us-ascii?Q?nqnxaNUaBN/q6DrHGxUk34ejOEeansaa3s1CSOgkHke3DKt6OVFQGMM1ozqt?=
 =?us-ascii?Q?2dwCZoaXYehK9dR+U+AQ0X8Um2sV07GudDoJUh+Vh4EyLMImB64v6FnMlIwD?=
 =?us-ascii?Q?rNNlMLgQIJF7W58NcSzVcPeULL0Rnn42Daxn86fExMTudXd2YTELykq8PV4b?=
 =?us-ascii?Q?zFiVnOKBiO9orRQvN2vEGXTtd97chsMl0GcQKoxtp8rHW7aDARCzQZtNl/Hz?=
 =?us-ascii?Q?RogqpeUuOhW7LEZ7npLOrnFgfG83hYCHMflMMtoGxssP134yUxGsAV1HCQFd?=
 =?us-ascii?Q?GKwz6ZiewNm94H6nWVBF0h2Q1DGel3y/zSdpKbSs0UFiohF1qcuGItACZ9DQ?=
 =?us-ascii?Q?2Pd7xRKzfZuHJYHE2/qaAqMjRW8ZrQBD5S6FAaD2w229yjESbRPFuaGBDdVH?=
 =?us-ascii?Q?6QptYy7T973WCa4wN/0DQwtSA1H9Gur7PGb51Slo1NYi8vxDlFXkOs5YSmxs?=
 =?us-ascii?Q?rqUkB7EwftO0Nd6JZ1/qrO8IAzkuD2eDL7dW7JBthqETD5jtqjeCslBFGXNe?=
 =?us-ascii?Q?z/3fyRFp75Mt7+kU4tD7kgZTXqYuJHqoyizAxVih81C6ZvbhSSG4UTusPejU?=
 =?us-ascii?Q?EJRsB8iZa85hL2X3eepyDEfICYVlzNdD/4gxR6nQLkEqeoJoivC5pGlTYJsW?=
 =?us-ascii?Q?pO3ImAZAVQYz4+t8Xu499gzgQd52CtmHgsP5Tps5J4fDwZVCrpn5RJekb/L4?=
 =?us-ascii?Q?g38OpLrg12U9yZS+YwRKiNFGo4sE9DBYPQsIrjSNto8JE2euhoVc8f5GYpAj?=
 =?us-ascii?Q?humcroFTOL5R7ud3mo3FTcTKOuypl42LxODqan5eo8JFQhD5b+2UBoXazw+/?=
 =?us-ascii?Q?PZMnXMDCLNrhuKuauJ3PVpRsyu6P1GnOyRzIurShke/lFEH9pRqzyixRFGNJ?=
 =?us-ascii?Q?ax/fPC03d6qfotDBXbii782WJtJwlgqYsJeQ+SKC8EczyNBWxCGX3J8d+0nA?=
 =?us-ascii?Q?enOsk4gGqb0dJyQaiOCqGFD/2upNkEkh3IC5bx9557OsLN6flfGeBahmySPx?=
 =?us-ascii?Q?zVMQDxggkM7NsHOyT8Jx12erfkRIzUeoSmeeXmmJ19A9v2XEwzxh5QjO8SLu?=
 =?us-ascii?Q?dG/kkZPigvXsH88tQdPPrWoFiawHB1R5Yy9F223p4CNueUkakJar2vuDM3ZV?=
 =?us-ascii?Q?JK1FnyJ32/9qRHOz0Z5h2B50EV4ERCT90X80wiNQgTNzO7XcRpmpDxl+8yif?=
 =?us-ascii?Q?L8TthAJT6QOnKpkvtOZ+iE3kArSiti410O94HgQNv5kmta1H0clsJzQeya3x?=
 =?us-ascii?Q?iIqdwqEvB/pE2sNp33wR57epIat7vteSRirvRHEFezatUV0vgtWUlub6p619?=
 =?us-ascii?Q?SzDsHd5WugDRNs2dDRxqYlVxMidlWD5o7RdAofBq5foRXU34NxkXP0PQ7EsL?=
 =?us-ascii?Q?redOIVOwjQsN700JCz5v/YrDFLWCbDgVkubiovgfWMhc3ZFfF6mr/ZyzWyN/?=
 =?us-ascii?Q?l+V9VpfEIwhyykd5CkVK5oAXXUFaF7RhBEcT3jcAooWi1mYcbcORyNiblJI7?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0065edd-c448-402f-204a-08dbda315f9c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:39.6876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlkzTubqqotJ3KHI6k1jsgBLPlTc4Lofq4vOKfN9EAzscHv5MXTwXHxwHkqom+qJ5qL4GuoJFdtH4bRcRLip6KRxauaOIsjssLBv+4+NtyY=
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

With CM 3.5 the "core-other" register block evolves into the "redirect"
register block, which is capable of accessing not only the core local
registers of other cores but also the shared/global registers of other
clusters.

This patch generates accessor functions for shared/global registers
accessed via the redirect block, with "redir_" inserted after "gic_" in
their names. For example the accessor function:

  read_gic_config()

...accesses the GIC_CONFIG register of the GIC in the local cluster.
With this patch a new function:

  read_gic_redir_config()

...is added which accesses the GIC_CONFIG register of the GIC in
whichever cluster the GCR_CL_REDIRECT register is configured to access.

This mirrors the similar redirect block accessors already provided for
the CM & CPC.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 arch/mips/include/asm/mips-gic.h | 50 ++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/mips-gic.h b/arch/mips/include/asm/mips-gic.h
index 084cac1c5ea2..fd9da5e3beaa 100644
--- a/arch/mips/include/asm/mips-gic.h
+++ b/arch/mips/include/asm/mips-gic.h
@@ -28,11 +28,13 @@ extern void __iomem *mips_gic_base;
 
 /* For read-only shared registers */
 #define GIC_ACCESSOR_RO(sz, off, name)					\
-	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
+	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_SHARED_OFS + off, name)	\
+	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_REDIR_OFS + off, redir_##name)
 
 /* For read-write shared registers */
 #define GIC_ACCESSOR_RW(sz, off, name)					\
-	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
+	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_SHARED_OFS + off, name)	\
+	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_REDIR_OFS + off, redir_##name)
 
 /* For read-only local registers */
 #define GIC_VX_ACCESSOR_RO(sz, off, name)				\
@@ -45,7 +47,7 @@ extern void __iomem *mips_gic_base;
 	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_REDIR_OFS + off, vo_##name)
 
 /* For read-only shared per-interrupt registers */
-#define GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
+#define _GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
 static inline void __iomem *addr_gic_##name(unsigned int intr)		\
 {									\
 	return mips_gic_base + (off) + (intr * (stride));		\
@@ -58,8 +60,8 @@ static inline unsigned int read_gic_##name(unsigned int intr)		\
 }
 
 /* For read-write shared per-interrupt registers */
-#define GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)			\
-	GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
+#define _GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
+	_GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
 									\
 static inline void write_gic_##name(unsigned int intr,			\
 				    unsigned int val)			\
@@ -68,22 +70,30 @@ static inline void write_gic_##name(unsigned int intr,			\
 	__raw_writel(val, addr_gic_##name(intr));			\
 }
 
+#define GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
+	_GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
+	_GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off, stride, redir_##name)
+
+#define GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)			\
+	_GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
+	_GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off, stride, redir_##name)
+
 /* For read-only local per-interrupt registers */
 #define GIC_VX_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
-	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
+	_GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
 				 stride, vl_##name)			\
-	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
+	_GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
 				 stride, vo_##name)
 
 /* For read-write local per-interrupt registers */
 #define GIC_VX_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
-	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
+	_GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
 				 stride, vl_##name)			\
-	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
+	_GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
 				 stride, vo_##name)
 
 /* For read-only shared bit-per-interrupt registers */
-#define GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
+#define _GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
 static inline void __iomem *addr_gic_##name(void)			\
 {									\
 	return mips_gic_base + (off);					\
@@ -106,8 +116,8 @@ static inline unsigned int read_gic_##name(unsigned int intr)		\
 }
 
 /* For read-write shared bit-per-interrupt registers */
-#define GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
-	GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
+#define _GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
+	_GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
 									\
 static inline void write_gic_##name(unsigned int intr)			\
 {									\
@@ -146,6 +156,14 @@ static inline void change_gic_##name(unsigned int intr,			\
 	}								\
 }
 
+#define GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
+	_GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
+	_GIC_ACCESSOR_RO_INTR_BIT(MIPS_GIC_REDIR_OFS + off, redir_##name)
+
+#define GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
+	_GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
+	_GIC_ACCESSOR_RW_INTR_BIT(MIPS_GIC_REDIR_OFS + off, redir_##name)
+
 /* For read-only local bit-per-interrupt registers */
 #define GIC_VX_ACCESSOR_RO_INTR_BIT(sz, off, name)			\
 	GIC_ACCESSOR_RO_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
@@ -155,10 +173,10 @@ static inline void change_gic_##name(unsigned int intr,			\
 
 /* For read-write local bit-per-interrupt registers */
 #define GIC_VX_ACCESSOR_RW_INTR_BIT(sz, off, name)			\
-	GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
-				 vl_##name)				\
-	GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_REDIR_OFS + off,		\
-				 vo_##name)
+	_GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
+				  vl_##name)				\
+	_GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_REDIR_OFS + off,		\
+				  vo_##name)
 
 /* GIC_SH_CONFIG - Information about the GIC configuration */
 GIC_ACCESSOR_RW(32, 0x000, config)
-- 
2.25.1

