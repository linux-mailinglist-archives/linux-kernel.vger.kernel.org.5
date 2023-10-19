Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1847CF392
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbjJSJIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjJSJIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:08:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E233C130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:08:42 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J97LwE022930;
        Thu, 19 Oct 2023 09:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=vITxwlikyd1B1+znsz44ksMrkkMu4f1v+onZxkIiH8E=;
 b=EKZkllQo1PgxYfvTKLB/aGBaLcIpomLU2KhF9BxEs2U1xBGauqxR1tTg7MQZnq2Ul+j/
 RJ2BL348jNtWVxrBbKzuP7+2qqGWrJUYsWCbYK/YTdUl3r/MuIOwRzq2VPL+wyploQZr
 4Lq4cCaOha7VLylY90XMt0D8DwRTwiSHFnb96X8HtYzVH+BA1ot9HWjepxqGidyCwLMv
 Ko5whvOrM+XAf9Oy0+9en5Nhxb1hiNes2MZEu39ftQ6J47xJz59tPO4yZzUedAIBuBDM
 Ku6d1Sz0iNvtN3+zLA1Yyqb0z7gJvasPwLINRkrYFLApMFcLitVs0Eud+C1779E5j6aP oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu1hyr1mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 09:08:29 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39J97neU025024;
        Thu, 19 Oct 2023 09:08:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu1hyr1j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 09:08:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39J7ZK6U012900;
        Thu, 19 Oct 2023 09:03:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5pyqwbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 09:03:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39J93N8H49086814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 09:03:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD3E620040;
        Thu, 19 Oct 2023 09:03:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6982F2004E;
        Thu, 19 Oct 2023 09:03:21 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.109.198.63])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Oct 2023 09:03:21 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] powerpc/paravirt: Improve vcpu_is_preempted
Date:   Thu, 19 Oct 2023 14:33:16 +0530
Message-ID: <20231019090316.89179-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iaohS6XfxCVVZda8A5DK116KwPzthPd-
X-Proofpoint-GUID: PU1URsnSvNapXPgNhzlHEWhgMMFyNW3d
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_06,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PowerVM Hypervisor dispatches on a whole core basis. In a shared LPAR, a
CPU from a core that is CEDED or preempted may have a larger latency. In
such a scenario, its preferable to choose a different CPU to run.

If one of the CPUs in the core is active, i.e neither CEDED nor
preempted, then consider this CPU as not preempted.

Also if any of the CPUs in the core has yielded but OS has not requested
CEDE or CONFER, then consider this CPU to be preempted.

Correct detection of preempted CPUs is important for detecting idle
CPUs/cores in task scheduler.

Tested-by: Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog:
v2 (http://lkml.kernel.org/r/20231018155838.2332822-1-srikar@linux.vnet.ibm.com) -> v3:
Resolved comments from Michael Ellerman

v1 (http://lkml.kernel.org/r/20231009051740.17683-1-srikar@linux.vnet.ibm.com) -> v2:
Handle lppaca_of(cpu) in !PPC_SPLPAR case.
1. Fixed some compilation issues reported by kernelbot
	a. https://lore.kernel.org/oe-kbuild-all/202310102341.K0sgoqQL-lkp@intel.com/
	b.  https://lore.kernel.org/oe-kbuild-all/202310091636.lElmJkYV-lkp@intel.com/
2. Resolved comments from Shrikanth

 arch/powerpc/include/asm/paravirt.h | 42 ++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
index e08513d73119..0372b0093f72 100644
--- a/arch/powerpc/include/asm/paravirt.h
+++ b/arch/powerpc/include/asm/paravirt.h
@@ -71,6 +71,11 @@ static inline void yield_to_any(void)
 {
 	plpar_hcall_norets_notrace(H_CONFER, -1, 0);
 }
+
+static inline bool is_vcpu_idle(int vcpu)
+{
+	return lppaca_of(vcpu).idle;
+}
 #else
 static inline bool is_shared_processor(void)
 {
@@ -100,6 +105,10 @@ static inline void prod_cpu(int cpu)
 	___bad_prod_cpu(); /* This would be a bug */
 }
 
+static inline bool is_vcpu_idle(int vcpu)
+{
+	return false;
+}
 #endif
 
 #define vcpu_is_preempted vcpu_is_preempted
@@ -121,9 +130,19 @@ static inline bool vcpu_is_preempted(int cpu)
 	if (!is_shared_processor())
 		return false;
 
+	if (!(yield_count_of(cpu) & 1))
+		return false;
+
+	/*
+	 * If CPU has yielded to Hypervisor but OS has not requested idle
+	 * then this CPU is definitely preempted.
+	 */
+	if (!is_vcpu_idle(cpu))
+		return true;
+
 #ifdef CONFIG_PPC_SPLPAR
 	if (!is_kvm_guest()) {
-		int first_cpu;
+		int first_cpu, i;
 
 		/*
 		 * The result of vcpu_is_preempted() is used in a
@@ -149,11 +168,28 @@ static inline bool vcpu_is_preempted(int cpu)
 		 */
 		if (cpu_first_thread_sibling(cpu) == first_cpu)
 			return false;
+
+		/*
+		 * If any of the threads of this core is not preempted or
+		 * ceded, then consider this CPU to be non-preempted
+		 */
+		first_cpu = cpu_first_thread_sibling(cpu);
+		for (i = first_cpu; i < first_cpu + threads_per_core; i++) {
+			if (i == cpu)
+				continue;
+			if (!(yield_count_of(i) & 1))
+				return false;
+			if (!is_vcpu_idle(i))
+				return true;
+		}
 	}
 #endif
 
-	if (yield_count_of(cpu) & 1)
-		return true;
+	/*
+	 * None of the threads in this core are running but none of
+	 * them were preempted too. Hence assume the thread to be
+	 * non-preempted.
+	 */
 	return false;
 }
 

base-commit: eddc90ea2af5933249ea1a78119f2c8ef8d07156
-- 
2.31.1

