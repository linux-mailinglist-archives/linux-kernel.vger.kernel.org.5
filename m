Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637187B6DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbjJCP7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbjJCP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:59:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA3FF;
        Tue,  3 Oct 2023 08:59:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393BBP3D018834;
        Tue, 3 Oct 2023 15:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=GBSM88InbwDK3bTPT0KFlAm3hF10rrJO6ZNeblY1c44=;
 b=hUd9Sq/R6GdoJZE4qS3pOc5PSXhOITfsBR0/iWQz/HWZmBOTMm2Hnuur9xiko1teF06P
 NUqrn1SXjo6gf/O/DP6wAFjaO0b06OT6ffPZYDrzHtXVbfh6P5GtseRIwUzwOuR1B0dD
 bgk2YNlRT4TIKrGZRFJIEGCILZWQOwuB+OeYWrVyWoVR9WkpkvbgwOZVHw1mIVvzIWUl
 bLFA9eBoXS6+aby6PaQm4k2R4GQOljZ7QLxt5jr/2ikyZpOKx9yTKNadqU84LplxJIdN
 vhiYTkCi6aMEyT+kb3q2SXII8IUq0kBBu5py6PqMmH4ODR5GSGFR+u1Cnj5w/bAdBYp5 Bw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgbjj9fpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 15:59:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393FxWIT006952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 15:59:32 GMT
Received: from localhost (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 3 Oct
 2023 08:59:31 -0700
From:   Oza Pawandeep <quic_poza@quicinc.com>
To:     <sudeep.holla@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Oza Pawandeep <quic_poza@quicinc.com>
Subject: [PATCH v9] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
Date:   Tue, 3 Oct 2023 08:59:30 -0700
Message-ID: <20231003155930.2829763-1-quic_poza@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H-19d9mMQ3zuB0YjKgwOwadn3YU4-RQp
X-Proofpoint-ORIG-GUID: H-19d9mMQ3zuB0YjKgwOwadn3YU4-RQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=6 mlxscore=6 spamscore=6
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=123 adultscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: a36a7fecfe607 ("Add support for Low Power Idle(LPI) states")
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
---

Notes:
    Will/Catalin: Rafael has acked and he prefers to take it via arm64 tree

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 4d537d56eb84..6792a1f83f2a 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -9,6 +9,7 @@
 #ifndef _ASM_ACPI_H
 #define _ASM_ACPI_H
 
+#include <linux/cpuidle.h>
 #include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/psci.h>
@@ -44,6 +45,24 @@
 
 #define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrupt, \
 	trbe_interrupt) + sizeof(u16))
+/*
+ * Arm® Functional Fixed Hardware Specification Version 1.2.
+ * Table 2: Arm Architecture context loss flags
+ */
+#define CPUIDLE_CORE_CTXT		BIT(0) /* Core context Lost */
+
+static inline unsigned int arch_get_idle_state_flags(u32 arch_flags)
+{
+	if (arch_flags & CPUIDLE_CORE_CTXT)
+		return CPUIDLE_FLAG_TIMER_STOP;
+
+	return 0;
+}
+#define arch_get_idle_state_flags arch_get_idle_state_flags
+
+#define CPUIDLE_TRACE_CTXT		BIT(1) /* Trace context loss */
+#define CPUIDLE_GICR_CTXT		BIT(2) /* GICR */
+#define CPUIDLE_GICD_CTXT		BIT(3) /* GICD */
 
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index dc615ef6550a..3a34a8c425fe 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1217,8 +1217,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
 		state->exit_latency = lpi->wake_latency;
 		state->target_residency = lpi->min_residency;
-		if (lpi->arch_flags)
-			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+		state->flags |= arch_get_idle_state_flags(lpi->arch_flags);
 		if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
 			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
 		state->enter = acpi_idle_lpi_enter;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a73246c3c35e..afd94c9b8b8a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1480,6 +1480,15 @@ static inline int lpit_read_residency_count_address(u64 *address)
 }
 #endif
 
+#ifdef CONFIG_ACPI_PROCESSOR_IDLE
+#ifndef arch_get_idle_state_flags
+static inline unsigned int arch_get_idle_state_flags(u32 arch_flags)
+{
+	return 0;
+}
+#endif
+#endif /* CONFIG_ACPI_PROCESSOR_IDLE */
+
 #ifdef CONFIG_ACPI_PPTT
 int acpi_pptt_cpu_is_thread(unsigned int cpu);
 int find_acpi_cpu_topology(unsigned int cpu, int level);
-- 
2.25.1

