Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3910A78CD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbjH2ULd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbjH2ULT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:11:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA12DB;
        Tue, 29 Aug 2023 13:11:16 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TJ0C4l015179;
        Tue, 29 Aug 2023 20:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=Awg9q4mOGZeep+5lIZ30sn8eUT3HNaXaCtE1ur1IFgY=;
 b=hxi5PQtEDhZSB++Ikc3o19/8NhayFCWRR9JfkHGLyQxRad2aKwqY74XSIj0RIkFPFVY/
 oxflJCKBGqtCAdpEj6CUULoWTlVGrB6E2LPiKk5WKNOWG8SFqz/M4sVdeHn1W4XpBSY1
 qc4PtndgaPh0QDLQZzpU8jMvwh410eVtenNIMgG8IP9P1RQb6jARjNSK7WPUP70FSOv1
 jNscds6l7iXmBe3XI3jlCVVidb8g9NZO0qQFC4R80Z0sc36S84XgkOUXzCdNSI8rsCBO
 qYVlKBUmprxXp3/abCyKk6K1EQviIK+gz2rJAbLQ0HXY+Xyw0id9yvg4fBzlCAw6o2rs aA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srybqbbge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 20:11:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TKB4FL018451
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 20:11:04 GMT
Received: from localhost (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 13:11:03 -0700
From:   Oza Pawandeep <quic_poza@quicinc.com>
To:     <sudeep.holla@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Oza Pawandeep <quic_poza@quicinc.com>
Subject: [PATCH v3] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
Date:   Tue, 29 Aug 2023 13:11:01 -0700
Message-ID: <20230829201101.3330337-1-quic_poza@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ndMI1TyhmIVb26SOKF71NF09wpflHLRV
X-Proofpoint-GUID: ndMI1TyhmIVb26SOKF71NF09wpflHLRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=14 malwarescore=0 phishscore=0
 clxscore=1011 mlxlogscore=78 lowpriorityscore=0 priorityscore=1501
 mlxscore=14 impostorscore=0 adultscore=0 suspectscore=0 spamscore=14
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm® Functional Fixed Hardware Specification defines LPI states,
which provide an architectural context loss flags field that can
be used to describe the context that might be lost when an LPI
state is entered.

- Core context Lost
        - General purpose registers.
        - Floating point and SIMD registers.
        - System registers, include the System register based
        - generic timer for the core.
        - Debug register in the core power domain.
        - PMU registers in the core power domain.
        - Trace register in the core power domain.
- Trace context loss
- GICR
- GICD

Qualcomm's custom CPUs preserves the architectural state,
including keeping the power domain for local timers active.
when core is power gated, the local timers are sufficient to
wake the core up without needing broadcast timer.

The patch fixes the evaluation of cpuidle arch_flags, and moves only to
broadcast timer if core context lost is defined in ACPI LPI.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index bd68e1b7f29f..0d455b02971e 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -9,6 +9,7 @@
 #ifndef _ASM_ACPI_H
 #define _ASM_ACPI_H
 
+#include <linux/cpuidle.h>
 #include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/psci.h>
@@ -42,6 +43,26 @@
 #define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
 	spe_interrupt) + sizeof(u16))
 
+/*
+ * Arm® Functional Fixed Hardware Specification Version 1.2.
+ * Table 2: Arm Architecture context loss flags
+ */
+#define CPUIDLE_CORE_CTXT		BIT(0) /* Core context Lost */
+
+#ifndef arch_update_idle_state_flags
+static __always_inline void _arch_update_idle_state_flags(u32 arch_flags,
+							unsigned int *sflags)
+{
+	if (arch_flags & CPUIDLE_CORE_CTXT)
+		*sflags |= CPUIDLE_FLAG_TIMER_STOP;
+}
+#define arch_update_idle_state_flags _arch_update_idle_state_flags
+#endif
+
+#define CPUIDLE_TRACE_CTXT		BIT(1) /* Trace context loss */
+#define CPUIDLE_GICR_CTXT		BIT(2) /* GICR */
+#define CPUIDLE_GICD_CTXT		BIT(3) /* GICD */
+
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
 pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9718d07cc2a2..420baec3465c 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1221,8 +1221,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
 		state->exit_latency = lpi->wake_latency;
 		state->target_residency = lpi->min_residency;
-		if (lpi->arch_flags)
-			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+		arch_update_idle_state_flags(lpi->arch_flags, &state->flags);
 		if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
 			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
 		state->enter = acpi_idle_lpi_enter;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d584f94409e1..d49488fdbc49 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1471,6 +1471,10 @@ static inline int lpit_read_residency_count_address(u64 *address)
 }
 #endif
 
+#ifndef arch_update_idle_state_flags
+#define arch_update_idle_state_flags	do {} while (0);
+#endif
+
 #ifdef CONFIG_ACPI_PPTT
 int acpi_pptt_cpu_is_thread(unsigned int cpu);
 int find_acpi_cpu_topology(unsigned int cpu, int level);
-- 
2.25.1

