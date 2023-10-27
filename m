Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999957D8CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 03:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345069AbjJ0BXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 21:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0BXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 21:23:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2098.outbound.protection.outlook.com [40.107.244.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0A31B4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 18:23:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/bVIQexgX/04qb36AFonteju23qc9iduO3xI34jqbsjujGz01oVyziosl7hTeJ4qiRUoTwc5iWoVWgaB7kNQRrPoAizIEFOZaXbrWrciB/WyhPm5xOwgDIlCHFL5SeM6Ls2alPJrdei+NMxedabvrQEIDBrqqCRECIOe90drtARH0NNh7ZEtVFQkrMvFEY2GNEcCuhYbDKXdKv+ka2iImt/cfr9yPD6+mAZsXy5pGo/BqRm/+r9rMnS6G83LStxs404uENiFhWz8efOXZAOD1c7TVt31RNOPFDvA/ENOxBEKJV/8DcoiMBhmdnZ4TJfjWKGNasMTfPc86jmisieGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3HeYLNsxEjgnDVfctMyPxYIzkdHA5mSuwdTpaJX3Dk=;
 b=gFORoS/Cit+2goNVwPpykhScYHSBvudjR5Wg1auSQw37NYM99Tq0UH9TDISnb7MJO1XuZrzEGdpra81cyEw58AuxjDcg1qM71aRCp+ekoV958gnLxsAUiM0ZHNE1LvvGQdz8R5z45TzvhSQaUF1DlHqBlOOfaF65NgHbCHra8zpdRJ4dV26JUNx6O988ZoKjpQ81fdwrM7vlZ0wxHJ2UMAoTnWN8ldDxN1ngI4xUwgTre6t/rAoqUGliDR7JHK1Ro2OREtrnpi5tapsJDRutEA0copcBkI9PeKQJK/KUeugcNYbhfK8z3kH1fN9aBUaPM2y864rOEoBFzK/QXZ8HlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3HeYLNsxEjgnDVfctMyPxYIzkdHA5mSuwdTpaJX3Dk=;
 b=YP6EWVEnsU2q62HyEEPk/7QqtfHfTMLxfTYqC1ftQv45hAmZOkooJnj53shQmebn3Nd6FeGhklJGEAD4r7/Kp/ZGc6rDaORfFIQrkogFOd3vkpyiemJMN5i/5TCghKzf/dJxJsApqv+6xTKIppNfd8AwmmmmPkU0R68S7I8snvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA1PR01MB6527.prod.exchangelabs.com (2603:10b6:806:187::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.19; Fri, 27 Oct 2023 01:23:00 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 01:23:00 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64/arm: perf: Don't discard upper 32 bits from PMCEID0/1 registers
Date:   Thu, 26 Oct 2023 18:22:43 -0700
Message-ID: <20231027012243.111070-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:610:74::33) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA1PR01MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 5707fc74-16a5-4dc0-dd5b-08dbd68b4248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQ8t8RIv/P+fzastk94T/pk6no3dHs/JDfP0I9OLl382JOxPm1H3KuxfbeA5DPkDlfJuLfnZtpq0s/uPtbnJkxwFR6OXwXABznzp36uFCmAq4kG4AUJZhYkvquCHP9th8r0+maaQpCH9hSoVrYXhSGzRDshZidOpUAAvwL8uM9Weugi5KsPPcebuintomqkE39Y553CHAfNSdhyd19xjQrF6V/qCK2uCcnn0VBn3akbWk7SUlXo8K4e5XJ21Lr5ZiPB6Piw/lzUEDom5Flve+tWUmqfjTgpuErJKnOgFoIYgm7J/5Xm6Mnik8yYtjMymbezrm4fOgu52t/CPRQhiUTclePCRcRt5dJf8636EA8OG+EuZka35c69LAD8dzscd2YtfmKSPGwsizoW9ILVx+KiU2I1a5z3mvrLRxH4UrJUyZG87HNlzmhJAz4SD0gPKltCqaqBG9oH+nV8dXtFTClmjLNmbfwtC+kzZcms2xOk8JgEzIF9CiVvuDEGlWV4037SJFca1X6gqcjphF+1FQSmZK+s2GGIn/q7z4cU3tf7XLJOjVSSGJmJpyIE/kw2wdbN6opMVjY3CeydCbxXZ7XNMvNv/0zSqkmj/3+1HgY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(366004)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(52116002)(6506007)(478600001)(966005)(2616005)(66556008)(66476007)(6512007)(110136005)(1076003)(6666004)(86362001)(6486002)(66946007)(316002)(26005)(38100700002)(8676002)(83380400001)(8936002)(4326008)(5660300002)(2906002)(41300700001)(38350700005)(7049001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2556IXvtoMiN7ShZDYjYd8BKGROXqbGFDZHn+2tsSEAL9YkXf7cYNB4iDvN?=
 =?us-ascii?Q?myntSqtiWbp/fYwdKoKUB7erZYh3gOQ+pg/nEcATp9rxcp2rXzZgC2Yw+l4P?=
 =?us-ascii?Q?u4Mn+FIkiFzl43LBHehzpwtaXPBzu7pxAJeCdCbh71qQwh3ajRveN+sEU/c1?=
 =?us-ascii?Q?3S6IjDQxA9gA3/7dLZ9ODZ2N6RPQf4Izrkc3I+eG8aObv79Zwx/NRk748EK4?=
 =?us-ascii?Q?uIWIqJn2I6rcPabdXJT0aYzxnDrTMCjdNfYcpsJz++VylUmVIpJSy+eWNRMR?=
 =?us-ascii?Q?tLtoX7wgUrbV4eCnvP7aq4PgU2VXIa/7kb5VaLJh7g/6mEqLDM+A0NtuWBBD?=
 =?us-ascii?Q?dQhGy0YBoX1qNRKQUq8udfiD5+SFBUNuZkZdd4Tc+1Rul4Kab2osUYVBW7zR?=
 =?us-ascii?Q?ocyiBog7PG7nCyowMT3MJb5tc0WGpEJPa2U71ee8GXE2Opn3z1rbnf5KuDd3?=
 =?us-ascii?Q?0AyOZ1eqog9wL6dZAz5a7ddDp5IGaR69QRNzZWQ0qd+ITOoHN2BV+hCFMQqd?=
 =?us-ascii?Q?An3b+Mr5BbqsyWefl0+TrQXXbn5aLM+Im+QGtOH19bMQU2/Yqzx2xTf9k+k4?=
 =?us-ascii?Q?jOHYCRoe76257LxPyVsCO9G6N7AE4CeRuEWE19YpazhOk8UFkfZlM3U18iYg?=
 =?us-ascii?Q?iWxy4AWaF71fLFZtxKS9ascSsMxrljrzgLAetOZ4UOhRawo0PrklucHG3Hr4?=
 =?us-ascii?Q?i3TXB5tD1gNB1NMWwOHvBOVgISej10ntKlFcRAA+GN+ZkQr038KKixKgnHn7?=
 =?us-ascii?Q?ZSO9DDXTQRj02AyWuzTtq+oPqTq0A/YcEBi8YwKkdDAX8oXKVDBthwoVHbIp?=
 =?us-ascii?Q?4v7mR5CgyvFoBbN1MaDAe+hZ5DxSo4MIVpcDejZ9a6YOTUO74ST7GaL/HqEh?=
 =?us-ascii?Q?YqdzAJIjxEE56iWvAeDCJbNRe9lPjKrAdOwsBkn4aLTpZ5tyfqjfrqSDh8/j?=
 =?us-ascii?Q?hjyOZrI1LTTS7fSQDEtDH4n66FN9AKJFoPtOQNQEShxXEDxorCNVgC2FeQRG?=
 =?us-ascii?Q?h1SUtdCBPqk0LJXITRvK7u27gHX3G7a1FXvNmbz5Tt9KRx8sBEe/DY9kxQOd?=
 =?us-ascii?Q?Vet4MqSLQQOZQdrGZYkNtaF/zTZGP5j87Y9VL/dwYpjOEYApsh/6lhhUWluW?=
 =?us-ascii?Q?48KxC3D5AraHOpSL1V0iWhXLFWrXWgOJ2wxCTNaS2H60l2fZwOTMD4EOZ6cp?=
 =?us-ascii?Q?Mnj+gOayBymnw68AGdj0oqeK124j1/5bIcDxti07vHnugfaLllQJ+jBKYrVl?=
 =?us-ascii?Q?Z58aF+dwRyhPZ2bKTFGxchB5dEto0YpHtobGDBre5LutXkaPHijZVeALolkg?=
 =?us-ascii?Q?AFZobCyu6XVO1rKflTql1ds8JySaIoy2E2nP3KxCe8wq803oWOdrNfKWyho0?=
 =?us-ascii?Q?nKwMwDyUxHiThX5VDTkDLCoKrf9UTlLUuYVjn4P7rYK2e6WCMW476cI2kYJt?=
 =?us-ascii?Q?8i1yPvy+ku3Aq9/F9zw7zJ//iQDOYvRjf5X/vmrjqipOtZhwrBLrMIEsM3yZ?=
 =?us-ascii?Q?8ox6PtNe6Aa0lBim43A4iVoOaP+5+QpSGa9WPdlnWgh2wyJLCNz5Pn8jIMWt?=
 =?us-ascii?Q?v9BQkYYQs9JO+I3IEFdASZ8eJ3fS+lXyvqcpoZWxhSgL9BRpc11NxOJ1ghh9?=
 =?us-ascii?Q?xlLUbPLoNfixu6j0Yf2hxTw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5707fc74-16a5-4dc0-dd5b-08dbd68b4248
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 01:23:00.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtnN2vNsu/HPSO0u6w34CW8kHD9IowUQ+397z0EGKlOAXYn/1xJuZAUs2yVLIdHoKTpss+vvemnEkBZl0oBFHzrjSFOKi5SCF0bOKUZwRlxnB+7x4btlVfvJ73H0H0oI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6527
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper 32 bits of PMCEID[n] registers are used to describe whether
architectural and microarchitectural events in range 0x4000-0x401f
exist. Due to discarding the bits, the driver made the events invisible,
even if they existed.

Fixes: df29ddf4f04b ("arm64: perf: Abstract system register accesses away")
Reported-by: Carl Worth <carl@os.amperecomputing.com>
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---

Changes since v1:

  * Took arm32 specific code from Marc Zyngier's review comment
  * Fixed a couple of typos in the commit message

I have tested the patch on Arm64. However, what comes to Arm32 part, I have
only compared the code with Arm32 specification and cross compiled it.

v1: https://lore.kernel.org/all/20231025200815.104017-1-ilkka@os.amperecomputing.com/

---

 arch/arm/include/asm/arm_pmuv3.h   | 33 +++++++++++++++++++++---------
 arch/arm64/include/asm/arm_pmuv3.h |  4 ++--
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 72529f5e2bed..90841cb7ce43 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -23,6 +23,8 @@
 #define PMUSERENR		__ACCESS_CP15(c9,  0, c14, 0)
 #define PMINTENSET		__ACCESS_CP15(c9,  0, c14, 1)
 #define PMINTENCLR		__ACCESS_CP15(c9,  0, c14, 2)
+#define PMCEID2			__ACCESS_CP15(c9,  0, c14, 4)
+#define PMCEID3			__ACCESS_CP15(c9,  0, c14, 5)
 #define PMMIR			__ACCESS_CP15(c9,  0, c14, 6)
 #define PMCCFILTR		__ACCESS_CP15(c14, 0, c15, 7)
 
@@ -205,16 +207,6 @@ static inline void write_pmuserenr(u32 val)
 	write_sysreg(val, PMUSERENR);
 }
 
-static inline u32 read_pmceid0(void)
-{
-	return read_sysreg(PMCEID0);
-}
-
-static inline u32 read_pmceid1(void)
-{
-	return read_sysreg(PMCEID1);
-}
-
 static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u32 clr) {}
 static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
@@ -231,6 +223,7 @@ static inline void kvm_vcpu_pmu_resync_el0(void) {}
 
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
+#define ARMV8_PMU_DFR_VER_V3P1      0x4
 #define ARMV8_PMU_DFR_VER_V3P4      0x5
 #define ARMV8_PMU_DFR_VER_V3P5      0x6
 #define ARMV8_PMU_DFR_VER_IMP_DEF   0xF
@@ -251,4 +244,24 @@ static inline bool is_pmuv3p5(int pmuver)
 	return pmuver >= ARMV8_PMU_DFR_VER_V3P5;
 }
 
+static inline u64 read_pmceid0(void)
+{
+	u64 val = read_sysreg(PMCEID0);
+
+	if (read_pmuver() >= ARMV8_PMU_DFR_VER_V3P1)
+		val |= (u64)read_sysreg(PMCEID2) << 32;
+
+	return val;
+}
+
+static inline u64 read_pmceid1(void)
+{
+	u64 val = read_sysreg(PMCEID1);
+
+	if (read_pmuver() >= ARMV8_PMU_DFR_VER_V3P1)
+		val |= (u64)read_sysreg(PMCEID3) << 32;
+
+	return val;
+}
+
 #endif
diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 18dc2fb3d7b7..3e92b7cb57a4 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -126,12 +126,12 @@ static inline void write_pmuserenr(u32 val)
 	write_sysreg(val, pmuserenr_el0);
 }
 
-static inline u32 read_pmceid0(void)
+static inline u64 read_pmceid0(void)
 {
 	return read_sysreg(pmceid0_el0);
 }
 
-static inline u32 read_pmceid1(void)
+static inline u64 read_pmceid1(void)
 {
 	return read_sysreg(pmceid1_el0);
 }
-- 
2.41.0

