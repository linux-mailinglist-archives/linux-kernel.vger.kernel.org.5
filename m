Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D247D8093
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjJZKUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjJZKUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:20:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE1F10F7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:20:14 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QAHDpP031832;
        Thu, 26 Oct 2023 10:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DiCEX5Og/+yXwUsTbK472KIC3A2J41bJrvVasAbSg+s=;
 b=ojEs9DIZmnNhyCE6xfC2CxCG5vlXwzY1sCgYoupTt4tJY0v6RXIm7QK3EZWi0CO3CMTn
 8Uy7mIm6F012811wb6c9LrI77XkSxR2psMcdz5EAZVvdGnCEB4FL0CsjCghMY9Q0lf51
 h+1LZm0xWwwbPe1N0R9KWbo4TtrxGenOr6cKtaB5mndmWvqSdadPKsGy7yn5KmhsWbbB
 VEH8spyZ44jHouqQKhHngMO2cRPK+MokNYJxKhHH6Gbi1M9BwGT5qgMKN+cTC6CPEiKW
 Q2uxD4Tr7SczTcl65BkmhPhlzP4GsE4aSpq2tsiLsXA3sDaEky+f2eql57TuTSR1BGY4 VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3typ7q06jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:19:55 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QAIkkl008951;
        Thu, 26 Oct 2023 10:19:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3typ7q064r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:19:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q840mX023794;
        Thu, 26 Oct 2023 10:19:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvrytdmct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:19:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39QAJhjG16122484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 10:19:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D10A92007C;
        Thu, 26 Oct 2023 10:19:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2C6920063;
        Thu, 26 Oct 2023 10:19:41 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.109.198.113])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Oct 2023 10:19:41 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH v3 4/5] powerpc/smp: Avoid asym packing within thread_group of a core
Date:   Thu, 26 Oct 2023 15:48:39 +0530
Message-ID: <20231026101843.56784-5-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026101843.56784-1-srikar@linux.vnet.ibm.com>
References: <20231026101843.56784-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4RAUJFwh7INvrOeh5mqVattyZ1eMcM_7
X-Proofpoint-ORIG-GUID: hrrm3O27tuqrBXtr1ZgotdXLdV7pMc66
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_08,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PowerVM Hypervisor will schedule at a core granularity. However each big
core can have more than one thread_groups. For better utilization in
case of a shared processor, its preferable for the scheduler to pack to
the lowest core. However there is no benefit of moving a thread between
two thread groups of the same core.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 27770f7f1ae5..daede8c2abc1 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1763,6 +1763,19 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	set_sched_topology(powerpc_topology);
 }
 
+/*
+ * For asym packing, by default lower numbered CPU has higher priority.
+ * On shared processors, pack to lower numbered core. However avoid moving
+ * between thread_groups within the same core.
+ */
+int arch_asym_cpu_priority(int cpu)
+{
+	if (static_branch_unlikely(&splpar_asym_pack))
+		return -cpu / threads_per_core;
+
+	return -cpu;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 int __cpu_disable(void)
 {
-- 
2.31.1

