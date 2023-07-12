Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0A1750F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjGLRZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGLRZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:25:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82721991;
        Wed, 12 Jul 2023 10:25:18 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CHP7xV029959;
        Wed, 12 Jul 2023 17:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=1wPLzPc/1jIaBNBmXpH09hWBnpteM5sX8SPYyixygLI=;
 b=a4qyYejLLO/sZ+4NhI7185eu3vBqCZAIDMh/qBPd01mhF4hjBlyLyWmUyyOmHy845GCF
 8hjReFCl98FiwJwtbLo1Ps47XIlwqKDwyH+eo96zr4m4XJdrkRXntQ3v1Gr+b0CET/vj
 m1cpONI70Bg2C083CHWRpYHda1TJsgW4QMSKD+2Esdq0QSPUFYnTjW3YPs0XDkH6HovB
 fodGxIb9+PDoC5zC+EGtc+F5SoJafNzB5wvVFP/eHZm2GmhJduwUlBh+6ifWC064avHE
 2zFX89M7EIgH3rDoB1GWlTknGUGUlJ/f/x8QOIr/8RywL+HbM0XMsXxg5SxtnuiYPOJs WQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rseqpt706-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 17:25:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CHP6rv015992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 17:25:06 GMT
Received: from localhost (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 10:25:05 -0700
From:   Oza Pawandeep <quic_poza@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <jiles@qti.qualcomm.com>
CC:     Oza Pawandeep <quic_poza@quicinc.com>
Subject: [PATCH] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
Date:   Wed, 12 Jul 2023 10:24:58 -0700
Message-ID: <20230712172458.2507434-1-quic_poza@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kOT8OYHd8rloGTDw_RX9znpJ5YUDbzEl
X-Proofpoint-ORIG-GUID: kOT8OYHd8rloGTDw_RX9znpJ5YUDbzEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=242 clxscore=1011
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm® Functional Fixed Hardware Specification defines LPI states,
which provides an architectural context loss flags field
that can be used to describe the context that might be lost
when an LPI state is entered.

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

The patch fixes the evaluation of cpuidle arch_flags,
and moves only to broadcast timer if core context lost
is defined in ACPI LPI.

Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index bd68e1b7f29f..9c335968316c 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -42,6 +42,24 @@
 #define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
 	spe_interrupt) + sizeof(u16))
 
+/*
+ * Arm® Functional Fixed Hardware Specification Version 1.2.
+ * Table 2: Arm Architecture context loss flags
+ */
+#define CPUIDLE_CORE_CTXT		BIT(0) /* Core context Lost */
+
+#ifndef arch_acpi_lpi_timer_stopped
+static __always_inline bool arch_acpi_lpi_timer_stopped(u32 arch_flags)
+{
+  return arch_flags & CPUIDLE_CORE_CTXT;
+}
+#define arch_acpi_lpi_timer_stopped arch_acpi_lpi_timer_stopped
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
index 9718d07cc2a2..8ea1f2b3bf96 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1221,7 +1221,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
 		state->exit_latency = lpi->wake_latency;
 		state->target_residency = lpi->min_residency;
-		if (lpi->arch_flags)
+		if (arch_acpi_lpi_timer_stopped(lpi->arch_flags))
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 		if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
 			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d584f94409e1..b24f1cd1cebb 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1471,6 +1471,14 @@ static inline int lpit_read_residency_count_address(u64 *address)
 }
 #endif
 
+#ifndef arch_acpi_lpi_timer_stopped
+static __always_inline bool arch_acpi_lpi_timer_stopped(u32 arch_flags)
+{
+  return (arch_flags != 0);
+}
+#define arch_acpi_lpi_timer_stopped arch_acpi_lpi_timer_stopped
+#endif
+
 #ifdef CONFIG_ACPI_PPTT
 int acpi_pptt_cpu_is_thread(unsigned int cpu);
 int find_acpi_cpu_topology(unsigned int cpu, int level);
-- 
2.25.1

