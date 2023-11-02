Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F299F7DF9EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377137AbjKBSaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjKBSat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:30:49 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2112.outbound.protection.outlook.com [40.107.101.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ED3138
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUBYvBgAS+Ic3MHr+Nm2SIrd1XaqcYzS1Jgxz1ITx33AS5ykoVkarzTpwQUInML73GjMjG+dJqOlUzesMOXIIkbgp56qVyEGHn1S4dWdxdj8aRdOkjdb+ODR4pQJ9HY/A4NM6oG5/r7lT2HULsRAFybz4Tbi6EDxKpRWEWe8qFqwgUn+77jbKIOESF8pnNJJUQIgIBERsoaaY5F2lE6Tu/0pJZyGroLgjIS2WU9kvDkBM4BYshtJ83mvwAf89G3goQJFtRE9EzoHycozuMii6jlW94MxYXXZkhvDz+NVXFye1KccqtiUQGQIDSIz1bEaHWTnYDBiGYvK6MDY1+bZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j86HBBk+AJV1ILJuobgR1QuZRHXjygCYgQ1GeIjmwTk=;
 b=PelEa1/bk9oDrZnC23egxIf7V9a8Ewc3psmAHgd0xV3wmJIHpETxEBHylN/7Ki1qjBR/9zhHOXVo/7mrIA/7ZGlUqUIkZECdlXRmNRbHlGk/RYrDrWHjFXEzaxw/hCBNKjBqNScxZCV0EiAwcRw7jXZ1gDjsX+OTGFaA6kOg6h7gUsbxyBk8nv3II83rAcXfwD63p/njCLpAt4eOl8KdkVt0BQPzQqDKOx2cjVvImTxgHTnm16XKl7feGKfaEf9hAymrzxYHWfzGee1D6HMajIZf1bP5tzqOfcOLL6BAnBOeFo/x+fKtBR1603H+X1nKdVMf128xDWi3jfKsxRtcOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j86HBBk+AJV1ILJuobgR1QuZRHXjygCYgQ1GeIjmwTk=;
 b=Pulmg86qg+kX9ZRaM0ctChZE1TO3DhfeI6SfJbwYNzA7yHbw7GEuPvqKUtskdgo3gGnl7pmCvUJutpzL9C+ZMV2fIk6CbaBYJsftIf40v/FqZceEelv5nxdudfOVfK5qRS49G9fOMjHmA8Ff6+LxtrOODqgZQphSsoOqC57mWkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH7PR01MB7797.prod.exchangelabs.com (2603:10b6:510:1d8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Thu, 2 Nov 2023 18:30:37 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6933.024; Thu, 2 Nov 2023
 18:30:37 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64/arm: arm_pmuv3: perf: Don't truncate 64-bit registers
Date:   Thu,  2 Nov 2023 11:30:12 -0700
Message-Id: <20231102183012.1251410-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::21) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH7PR01MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: c69c8e38-f212-40c7-193e-08dbdbd1cef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zlFtvoegWpc4PfM7VKKjLRbsk283pOEEvyBzu8i5YzcBG9g9D9NEplmdvG60qfaJLnBXf0Ck0UOnJwpzld7Vxkg8++u6qyGSgw86T/h1Ac3mySsb/RObUQvey48gq9guK9Poe52yyGZotFuhZcZABrs0SjLoIYxvVwENMEXuITzCOGpXlgnar9iYLbxgrrq/ik6i79jpcif25UjkI/h9iuBDqumAGSeRdmW0CmI/bWVVXLqvorij99tg/H0oV8vMqgx+QLRdl/XDwpkWydE92pfQmK1xEsVhCWNHN29hWKY0yvhgCzc6PXHA2+0f6WBxCe7mNbRxgfkfBnULgwECSIkkRjiJA6jbUIwaQtrYYMD6xLKEKIxR/98fJZkSc1zikTNUb+NRYNN2slLMBJbKpDcGxPBzJp8/tRci78d51MJawO4dZ4eQtk4E3APuTK5sgUzClbBn003S4EhllIXgG7A+4WfFVMo7479avTE7PywjYZynssaVuCvsaA+YamqdRq7kjwqcvHIpysuVngy2umyNstNi2jRsZZYbHq3zCDnMTD1OletcscSO8l59w3J1zF0brnbnZsPp1D5HDuZHq4mR3l4aLXcjDeQyPql1WSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39850400004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(41300700001)(2906002)(5660300002)(7416002)(86362001)(38100700002)(2616005)(966005)(6512007)(66556008)(110136005)(66476007)(316002)(38350700005)(26005)(6666004)(66946007)(1076003)(83380400001)(52116002)(6486002)(6506007)(8936002)(478600001)(8676002)(4326008)(7049001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gU3Ql+b3l2rfrGt8maYrRrmPT6CcyjElN9Yf2R4w1k+G5kjbVHOLOGjoEOEZ?=
 =?us-ascii?Q?k/ZNeIOFq4bWmP8Y/BOd0QcxgLwVq/haaJzhTGbQCEQcvmfB9DxAiJmSq8oN?=
 =?us-ascii?Q?ZXtA9WDFxfjSSStxR6cI0xbp2pOeyu8u9iPxV0Gf7YRDjUXlrul6tmINRqrX?=
 =?us-ascii?Q?2sI1y6EHV98DjuhOZNxKFRHshKuGovdBl4h9Vqxyb9ryymmyi6PgeEc+t3TA?=
 =?us-ascii?Q?h5LsQK5HC2wDV+PsSUBxzEq2RXGfEkhXbSVVZlM/xKAGrr/tBZMq7DheFBor?=
 =?us-ascii?Q?LyudzTOxvjLKkO+nj6ILcLvUssEMdCoLh4SFdig3vEH5bAKuocrnFoJ5KGdc?=
 =?us-ascii?Q?XCf/bZqBu2mzpmq4s+DYoRIPuj+UqW4tqLX0zYvtihQtTGPWyyQux1Vcj665?=
 =?us-ascii?Q?NZt70B0NsWeF5nEWM9MUKTjf/4H0I2VYu3sH9xcrwgoNrpbnAa3L0b8PFTPN?=
 =?us-ascii?Q?hrecvJ4aKuIYSQ0rr0/FFUOz1UxPoSiXCDunEaMK2zAf68qaW6USfAfChx66?=
 =?us-ascii?Q?tqpDFsPaNt558SBwABKfD0AAaTdX7L+dBWprKX8NMc4xGTiPsVSpP5EexMyj?=
 =?us-ascii?Q?ekIpHa0h+vbthMO/ajWQUlE4MxM5qyW3wps6ANZjZ3iaRVngkMVTpkWWvzKN?=
 =?us-ascii?Q?IPRMVLDe8BwbONXR11czgL0OztoSIDCYO0owr35/mtImCrSkDeQAeyryQ0iM?=
 =?us-ascii?Q?wP5KO67JGjd4k8e07VLYgNtHdOFndmvtVPGBDi8B7Y5GxGtgAurO8dt+sgtx?=
 =?us-ascii?Q?mHdA/I4GCSp7eTBnaOvriP4o4bpBUEbkEyDFUP9dN2hi/A293wstUOiwAAO/?=
 =?us-ascii?Q?hPD+MX6Y7SSmIBjx3JdF7/XS2J+v49RrP53HcD2uxt2LOiBOhABqgmJbQU+z?=
 =?us-ascii?Q?qLanJNUkjwMHnXXDYjesPVmCQlCk6tCu9yogEv8t12YvX9rCw4scPoIZIsH4?=
 =?us-ascii?Q?mt/tJVyyw7l6wPMDjVPxIdviDZDiFVP7MnyqEcwJC0yir4BeTi6kqz+10zYv?=
 =?us-ascii?Q?dsCRcL+wV4Wf5YWGdQCiYPErmHH4sr1fhT/7iAqvVmENnM97V7delR/0X2A+?=
 =?us-ascii?Q?BqdEkOUaBVreCGZmKBY7Vfq7ZK75KDr2H4FvjJXo55/6BWkrMRKp4du7XLJB?=
 =?us-ascii?Q?6soaIm9SG4XjsiWvroh5YaL/IRORUPQQxA1hu2cTlr943F1Ko5CPPdIVe0nV?=
 =?us-ascii?Q?wCYaliK1WGxWKoVYrKM/a2Zom32GL1UVRZsKPmZiZEUHMU5dnDUnaMNxEumy?=
 =?us-ascii?Q?/WTcd3wvHZ4GNxZiFit4UPbJ4F43ib/s2WaeeK/EAa/Uzl0/FIyJ2Y6rtJAX?=
 =?us-ascii?Q?0TzLB2S5gEiTL+e/jSf9TtGAncqa5sIcSozwDC0DzpY+05XDNRiwDvjnnTzg?=
 =?us-ascii?Q?340/zVCdoehe4bLo64HLm6VBafaFMWfBGjvXQCa+yOQx4mLMNYAITYbNv57z?=
 =?us-ascii?Q?uwkxXLmzAJ76Nz144xv2ts+u5Ew5RP3APIvh+ZYzKWEJyVw7zkOTq6X7QQ3r?=
 =?us-ascii?Q?nNCZF7wn6xB2KjufZqMgGUeUsHyXfZM9oByA7J4JjiUkJgEEvVBmbLt04N6M?=
 =?us-ascii?Q?7J95kPoZkjZigubRy/VPo2p5Nalt6F8t6CwPQRIvaKpF8edHbT9PEI9sEibJ?=
 =?us-ascii?Q?VEHM7eaNKGThkHoicTq/kyU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69c8e38-f212-40c7-193e-08dbdbd1cef0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 18:30:37.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/jDuT5+qycl7kcrX9myJIgvVp1YWxftogW1mSg6EKd/7oxm98NQaj9XJ+MRYlz3OUcLSdCnamTwzva7aPQD4f5pNXYFJ48ujZhmzwBoYxsVjCH3l5d4UMiHc6IUvVJH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7797
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver used to truncate several 64-bit registers such as PMCEID[n]
registers used to describe whether architectural and microarchitectural
events in range 0x4000-0x401f exist. Due to discarding the bits, the
driver made the events invisible, even if they existed.

Moreover, PMCCFILTR and PMCR registers have additional bits in the upper
32 bits. This patch makes them available although they aren't currently
used. Finally, functions handling PMXEVCNTR and PMXEVTYPER registers are
removed as they not being used at all.

Fixes: df29ddf4f04b ("arm64: perf: Abstract system register accesses away")
Reported-by: Carl Worth <carl@os.amperecomputing.com>
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---

v2:

  * Took arm32 specific code from Marc Zyngier's review comment
    * Fixed a couple of typos in the commit message

    I have tested the patch on Arm64. However, what comes to Arm32 part, I have
    only compared the code with Arm32 specification and cross compiled it.

  * https://lore.kernel.org/all/20231027012243.111070-1-ilkka@os.amperecomputing.com/

v3:

  * Removed read/write_pmxevcntr() and read/write_pmxevtyper() as suggested
    by Mark Rutland
  * Changed handling of PMCCFILTR and PMCR to 64-bit on Aarch64. Aarch32 doesn't
    seem to use the upper 32 bits.
    

Tested the patch on Arm64. Arm32 version was only built and not tested on actual
hardware.

---

arch/arm/include/asm/arm_pmuv3.h   | 48 ++++++++++++++----------------
 arch/arm64/include/asm/arm_pmuv3.h | 25 ++++------------
 drivers/perf/arm_pmuv3.c           |  6 ++--
 3 files changed, 31 insertions(+), 48 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 72529f5e2bed..a41b503b7dcd 100644
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
 
@@ -150,21 +152,6 @@ static inline u64 read_pmccntr(void)
 	return read_sysreg(PMCCNTR);
 }
 
-static inline void write_pmxevcntr(u32 val)
-{
-	write_sysreg(val, PMXEVCNTR);
-}
-
-static inline u32 read_pmxevcntr(void)
-{
-	return read_sysreg(PMXEVCNTR);
-}
-
-static inline void write_pmxevtyper(u32 val)
-{
-	write_sysreg(val, PMXEVTYPER);
-}
-
 static inline void write_pmcntenset(u32 val)
 {
 	write_sysreg(val, PMCNTENSET);
@@ -205,16 +192,6 @@ static inline void write_pmuserenr(u32 val)
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
@@ -231,6 +208,7 @@ static inline void kvm_vcpu_pmu_resync_el0(void) {}
 
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
+#define ARMV8_PMU_DFR_VER_V3P1      0x4
 #define ARMV8_PMU_DFR_VER_V3P4      0x5
 #define ARMV8_PMU_DFR_VER_V3P5      0x6
 #define ARMV8_PMU_DFR_VER_IMP_DEF   0xF
@@ -251,4 +229,24 @@ static inline bool is_pmuv3p5(int pmuver)
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
index 18dc2fb3d7b7..c27404fa4418 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -46,12 +46,12 @@ static inline u32 read_pmuver(void)
 			ID_AA64DFR0_EL1_PMUVer_SHIFT);
 }
 
-static inline void write_pmcr(u32 val)
+static inline void write_pmcr(u64 val)
 {
 	write_sysreg(val, pmcr_el0);
 }
 
-static inline u32 read_pmcr(void)
+static inline u64 read_pmcr(void)
 {
 	return read_sysreg(pmcr_el0);
 }
@@ -71,21 +71,6 @@ static inline u64 read_pmccntr(void)
 	return read_sysreg(pmccntr_el0);
 }
 
-static inline void write_pmxevcntr(u32 val)
-{
-	write_sysreg(val, pmxevcntr_el0);
-}
-
-static inline u32 read_pmxevcntr(void)
-{
-	return read_sysreg(pmxevcntr_el0);
-}
-
-static inline void write_pmxevtyper(u32 val)
-{
-	write_sysreg(val, pmxevtyper_el0);
-}
-
 static inline void write_pmcntenset(u32 val)
 {
 	write_sysreg(val, pmcntenset_el0);
@@ -106,7 +91,7 @@ static inline void write_pmintenclr(u32 val)
 	write_sysreg(val, pmintenclr_el1);
 }
 
-static inline void write_pmccfiltr(u32 val)
+static inline void write_pmccfiltr(u64 val)
 {
 	write_sysreg(val, pmccfiltr_el0);
 }
@@ -126,12 +111,12 @@ static inline void write_pmuserenr(u32 val)
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
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 18b91b56af1d..6ca7be05229c 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -428,12 +428,12 @@ static inline bool armv8pmu_event_is_chained(struct perf_event *event)
 #define	ARMV8_IDX_TO_COUNTER(x)	\
 	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_PMU_COUNTER_MASK)
 
-static inline u32 armv8pmu_pmcr_read(void)
+static inline u64 armv8pmu_pmcr_read(void)
 {
 	return read_pmcr();
 }
 
-static inline void armv8pmu_pmcr_write(u32 val)
+static inline void armv8pmu_pmcr_write(u64 val)
 {
 	val &= ARMV8_PMU_PMCR_MASK;
 	isb();
@@ -957,7 +957,7 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 static void armv8pmu_reset(void *info)
 {
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
-	u32 pmcr;
+	u64 pmcr;
 
 	/* The counter and interrupt enable registers are unknown at reset. */
 	armv8pmu_disable_counter(U32_MAX);
-- 
2.40.1

