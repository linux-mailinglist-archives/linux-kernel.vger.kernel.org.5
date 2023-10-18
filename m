Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF07CE349
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjJRRDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJRRDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:03:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46C113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:03:40 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IGgL44031052;
        Wed, 18 Oct 2023 17:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5lOs/7Jps0YORZtWu8xrTtlXjTjEEjJbj4zrTSB55bo=;
 b=Y+N04GRWdMAJ/35ApIR+WtINnVjCDYajHUOdgDBmjtF8qx9wydQqmPiJaC4pjCUclzqq
 Gd67+H2bxBjXxnbHX0crpiZd7lYBYoxTkpk789HxbE7QsBcTOTEP/6zuQTAm8FttZlPn
 yE8uCsZpQUNCeUJUOnTJDUkBi6FNZs+9atuiQ6sz/Rl20GNZFR5vt5MivcTProQTuKha
 yyFoeg1p+V3ep4ff52CxnpGdwiPqMfceeIZZs/pMUtAoYJ2oYNtAkzq07CcDxB/2t4eA
 AaqauaV+6qiHdHNiFff4WUJdgaf8+kAkd5vyZ6v3sOhSxoHt6CU7k108B5/7JKie5Gjp mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttk470w7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 17:03:16 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IGh7t3001044;
        Wed, 18 Oct 2023 17:03:16 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttk470v74-27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 17:03:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IG2BCq027385;
        Wed, 18 Oct 2023 16:38:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5asjav3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 16:38:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IGcCtl25559318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 16:38:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F8002004B;
        Wed, 18 Oct 2023 16:38:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9C6D20049;
        Wed, 18 Oct 2023 16:38:09 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.43.47.66])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 16:38:09 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] powerpc/smp: Enable Asym packing for cores on shared processor
Date:   Wed, 18 Oct 2023 22:07:42 +0530
Message-ID: <20231018163751.2423181-3-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BcExjZMSDBzge-EgCUOOIGtaL9bdkVcU
X-Proofpoint-GUID: wu7AyA6M__Aom8r4Or2DHk3yYqWque_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_15,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are shared processor LPARs, underlying Hypervisor can have more
virtual cores to handle than actual physical cores.

Starting with Power 9, a core has 2 nearly independent thread groups.
On a shared processors LPARs, it helps to pack threads to lesser number
of cores so that the overall system performance and utilization
improves. PowerVM schedules at a core level. Hence packing to fewer
cores helps.

For example: Lets says there are two 8-core Shared LPARs that are
actually sharing a 8 Core shared physical pool, each running 8 threads
each. Then Consolidating 8 threads to 4 cores on each LPAR would help
them to perform better. This is because each of the LPAR will get
100% time to run applications and there will no switching required by
the Hypervisor.

To achieve this, enable SD_ASYM_PACKING flag at CACHE, MC and DIE level.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog:
v1->v2: Using static key instead of a variable.

 arch/powerpc/kernel/smp.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 37c41297c9ce..498c2d51fc20 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1009,9 +1009,20 @@ static int powerpc_smt_flags(void)
  */
 static int powerpc_shared_cache_flags(void)
 {
+	if (static_branch_unlikely(&powerpc_asym_packing))
+		return SD_SHARE_PKG_RESOURCES | SD_ASYM_PACKING;
+
 	return SD_SHARE_PKG_RESOURCES;
 }
 
+static int powerpc_shared_proc_flags(void)
+{
+	if (static_branch_unlikely(&powerpc_asym_packing))
+		return SD_ASYM_PACKING;
+
+	return 0;
+}
+
 /*
  * We can't just pass cpu_l2_cache_mask() directly because
  * returns a non-const pointer and the compiler barfs on that.
@@ -1048,8 +1059,8 @@ static struct sched_domain_topology_level powerpc_topology[] = {
 	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
 #endif
 	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
-	{ cpu_mc_mask, SD_INIT_NAME(MC) },
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_mc_mask, powerpc_shared_proc_flags, SD_INIT_NAME(MC) },
+	{ cpu_cpu_mask, powerpc_shared_proc_flags, SD_INIT_NAME(DIE) },
 	{ NULL, },
 };
 
@@ -1687,6 +1698,8 @@ static void __init fixup_topology(void)
 	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
 		pr_info_once("Enabling Asymmetric SMT scheduling\n");
 		static_branch_enable(&powerpc_asym_packing);
+	} else if (is_shared_processor() && has_big_cores) {
+		static_branch_enable(&powerpc_asym_packing);
 	}
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.31.1

