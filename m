Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5BE7CE34A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjJRREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:04:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F3B0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:04:03 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IH01VA018269;
        Wed, 18 Oct 2023 17:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=le4XbWDTI/3ySca5l+S4fhtnIEuOdqaPU7w/wPHXPEk=;
 b=ZZTH15WBVbN9CtyDZyGCOzMnIBpiA8pwIv7ufQTD+xeRCCakWYw8wdnKlPizSWqIxpeE
 dkzBwdAV8Z2MhcDr0U3z7sjVbafIEAmveInXU8IcjkwXZ+VudhLvRoF+1zV9xftkkFzi
 6LxxBvVqae4SSLFwl/PDZyJExJ41XCx87e7OP+on7MZ+1gsmjoEM+5YVJlfrqLESDNNF
 7wjMZJ+SrrEXvKIhLbGmRmdDRrg7rkl2zHwe5QeIlf51KPO89c/mrukQmB/2P5PCaUp/
 Aa0jPkdq8UhNiWdQxw+gHKq0v8pex6PNCywL6q6l/m15UaFccYJSB7nOO/u/iqCuEcXi MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttkcgg8j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 17:03:43 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IH04KH018409;
        Wed, 18 Oct 2023 17:03:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttkcgg635-41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 17:03:42 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IFSdtd027177;
        Wed, 18 Oct 2023 16:38:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tkhvmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 16:38:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IGc83012583484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 16:38:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B861F20040;
        Wed, 18 Oct 2023 16:38:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F01FB20049;
        Wed, 18 Oct 2023 16:38:05 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.43.47.66])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 16:38:05 +0000 (GMT)
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
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] powerpc/smp: Cache CPU has Asymmetric SMP
Date:   Wed, 18 Oct 2023 22:07:41 +0530
Message-ID: <20231018163751.2423181-2-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6vLPCBCAxijA96s6UPL7XrT1zS9Gylz2
X-Proofpoint-ORIG-GUID: YZNut4nXH1nZZFaLtI_YCW8a6lgS7Dni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_15,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180138
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently cpu feature flag is checked whenever powerpc_smt_flags gets
called. This is an unnecessary overhead. CPU_FTR_ASYM_SMT is set based
on the processor and all processors will either have this set or will
have it unset.

Hence only check for the feature flag once and cache it to be used
subsequently. This commit will help avoid a branch in powerpc_smt_flags

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog:
v1->v2: Using static keys instead of a variable.
Using pr_info_once instead of printk

 arch/powerpc/kernel/smp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5826f5108a12..37c41297c9ce 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -988,18 +988,16 @@ static int __init init_thread_group_cache_map(int cpu, int cache_property)
 }
 
 static bool shared_caches;
+DEFINE_STATIC_KEY_FALSE(powerpc_asym_packing);
 
 #ifdef CONFIG_SCHED_SMT
 /* cpumask of CPUs with asymmetric SMT dependency */
 static int powerpc_smt_flags(void)
 {
-	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
+	if (static_branch_unlikely(&powerpc_asym_packing))
+		return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES | SD_ASYM_PACKING;
 
-	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
-		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
-		flags |= SD_ASYM_PACKING;
-	}
-	return flags;
+	return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
 }
 #endif
 
@@ -1686,6 +1684,11 @@ static void __init fixup_topology(void)
 {
 	int i;
 
+	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
+		pr_info_once("Enabling Asymmetric SMT scheduling\n");
+		static_branch_enable(&powerpc_asym_packing);
+	}
+
 #ifdef CONFIG_SCHED_SMT
 	if (has_big_cores) {
 		pr_info("Big cores detected but using small core scheduling\n");
-- 
2.31.1

