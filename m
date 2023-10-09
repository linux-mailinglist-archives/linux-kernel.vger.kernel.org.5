Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA217BD2C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 07:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbjJIFST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 01:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345107AbjJIFSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 01:18:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E55AD8
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 22:18:12 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3995HMoV018659;
        Mon, 9 Oct 2023 05:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qBJsK+N7F7mpro8cbm0GVtYNPWHLhyhNfImup5Az/lk=;
 b=EZvYiHLZQnhc0IllO3zuQIVgIoO/No9IGFtUuBeD7bsSOW1gc+jSuhyCCz2TK2fHVXGv
 ld+e7bsGqrLGDTvfQriWyj8Pld37SMbLNCCfgehEdS1ltyUB3Yi2MM4UVFb7/JnTYocH
 Ao89G24n5rssOBccksZXpLlWnGPYTmHgw30KYsmQDwdphj7gzv8ppjQd6CEVoBGCwNgR
 OVhw2KABUXHmsJUO3ftYi6oUbebAn2QdhSGBFmX88dofp+ziFSs6QQxwsE7Y2H1N9KNW
 r1DjgT+F6NLpeIrtxwaEUnX6qj/FsRTwEerkh5+1sq47+qzDcy4ixdVnOZA1uRgoTjJ2 GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmb87r0b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 05:18:00 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3995HxvU019757;
        Mon, 9 Oct 2023 05:17:59 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmb87r0ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 05:17:59 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3994F4R9001239;
        Mon, 9 Oct 2023 05:17:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvjedf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 05:17:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3995HudZ42402142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Oct 2023 05:17:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B872620049;
        Mon,  9 Oct 2023 05:17:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A88920040;
        Mon,  9 Oct 2023 05:17:54 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.43.27.236])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Oct 2023 05:17:53 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] powerpc/paravirt: Improve vcpu_is_preempted
Date:   Mon,  9 Oct 2023 10:47:40 +0530
Message-ID: <20231009051740.17683-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: boGaKEVLWafjKpG1zLcL62MUCsKp1fS7
X-Proofpoint-GUID: t3uSOm2sLLjmjYRgAXcGrA3HRSvQu90Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_04,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PowerVM Hypervisor dispatches on a whole core basis. In a shared LPAR, a
CPU from a core that is preempted may have a larger latency. In
such a scenario, its preferable to choose a different CPU to run.

If one of the CPUs in the core is active, i.e neither CEDED nor
preempted, then consider this CPU as not preempted.

Also if any of the CPUs in the core has yielded but OS has not requested
CEDE or CONFER, then consider this CPU to be preempted.

Cc: Ajay Kaher <akaher@vmware.com>
Cc: Alexey Makhalov <amakhalov@vmware.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paravirt.h | 33 ++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
index e08513d73119..a980756f58df 100644
--- a/arch/powerpc/include/asm/paravirt.h
+++ b/arch/powerpc/include/asm/paravirt.h
@@ -121,9 +121,19 @@ static inline bool vcpu_is_preempted(int cpu)
 	if (!is_shared_processor())
 		return false;
 
+	if (!(yield_count_of(cpu) & 1))
+		return false;
+
+	/*
+	 * If CPU has yielded but OS has not requested idle then this CPU is
+	 * definitely preempted.
+	 */
+	if (!lppaca_of(cpu).idle)
+		return true;
+
 #ifdef CONFIG_PPC_SPLPAR
 	if (!is_kvm_guest()) {
-		int first_cpu;
+		int first_cpu, i;
 
 		/*
 		 * The result of vcpu_is_preempted() is used in a
@@ -149,11 +159,28 @@ static inline bool vcpu_is_preempted(int cpu)
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
+			if (!lppaca_of(i).idle)
+				return true;
+		}
 	}
 #endif
 
-	if (yield_count_of(cpu) & 1)
-		return true;
+	/*
+	 * None of the threads in this thread group are running but none of
+	 * them were preempted too. Hence assume the thread to be
+	 * non-preempted.
+	 */
 	return false;
 }
 
-- 
2.31.1

