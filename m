Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8D79D78A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjILR34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjILR3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:29:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BA110D9;
        Tue, 12 Sep 2023 10:29:50 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CDnUUm002778;
        Tue, 12 Sep 2023 17:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=zd9e5Dj70FzmypSrLlmnrjpVFXyY6IVIDc43eaceI5M=;
 b=ShL6Y7KdldL8hDa8ICU+KwY0rjNZJy+GBZZh5WMjqRj37nEhoMgsQmyjj7Lvd0xhPn0t
 c/ItcFNpbbEXg0x1mcJ/DlF64xOcNhW9BewcKji97IW5kGPVtxLW4T+qInhtG6UBfTwy
 ldHLPSzm3RVGRGIpQ0dyMS1JAVm0zerOHB8d4AQ9rUqvw/J6xDuA+BLqkEKSdmcMw/S7
 AUd1UpJW0aE9wKNgfDOGkwYEHNPnuufxYV+g4gp4aDdwicLaKbujnCVuEqeaT84+Gi4x
 hQm6C+BATq2JooN7ghBFsW+ppY7Zppw5vvq03taypIqrMD1QOtLNBO4FhCs/0CoqypMd 9Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2pu4141t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 17:29:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CHTbhj032119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 17:29:37 GMT
Received: from localhost (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 10:29:37 -0700
From:   Oza Pawandeep <quic_poza@quicinc.com>
To:     <sudeep.holla@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Oza Pawandeep <quic_poza@quicinc.com>
Subject: [PATCH v5] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
Date:   Tue, 12 Sep 2023 10:29:33 -0700
Message-ID: <20230912172933.3561144-1-quic_poza@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GAMAY4Hrs4oy6eoiz21HVZMHI76JZFUS
X-Proofpoint-ORIG-GUID: GAMAY4Hrs4oy6eoiz21HVZMHI76JZFUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=35 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=27 lowpriorityscore=0 mlxscore=35
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=35 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120147
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
index 4d537d56eb84..a30b6e16628d 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -9,6 +9,7 @@
 #ifndef _ASM_ACPI_H
 #define _ASM_ACPI_H
 
+#include <linux/cpuidle.h>
 #include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/psci.h>
@@ -44,6 +45,25 @@
 
 #define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrupt, \
 	trbe_interrupt) + sizeof(u16))
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
 
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index dc615ef6550a..5c1d13eecdd1 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1217,8 +1217,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
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
index a73246c3c35e..f8c561a4215e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1480,6 +1480,10 @@ static inline int lpit_read_residency_count_address(u64 *address)
 }
 #endif
 
+#ifndef arch_update_idle_state_flags
+#define arch_update_idle_state_flags(af, sf)	do {} while (0)
+#endif
+
 #ifdef CONFIG_ACPI_PPTT
 int acpi_pptt_cpu_is_thread(unsigned int cpu);
 int find_acpi_cpu_topology(unsigned int cpu, int level);
-- 
2.25.1

