Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0982F77276D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjHGOSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjHGOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:18:05 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAF6A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:18:04 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377CWHPI007398;
        Mon, 7 Aug 2023 14:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : mime-version; s=pps0720;
 bh=6MNeYz1ppuSMyBO/xxpYuOhoZw378FPMT0CfDjCdKj4=;
 b=U4c7wmPsgXmA6ND6e6HSMWlg9AYleAYthtYaW7FaE+xpJgjyR4/oMn5jzcX3taBf80fb
 Rkh7g/U/btgEHrw8u9RwcfS10ckrPxFHyErWUpXXBXhIZf0ddIab1KOD8J3H5UT6d1Q2
 GkG3+POHmZZnSNOrXmXCi3EqqU8EGxELmNlkDbQtbSOzDugv1ruCw8WY3VuFBOyD687s
 3NndrHjNfG/yvZ6JJxwNTbl64F8cK8xhOXhdnv5KkXg5G7SNxXLcDwxOCZ4C9FEuOyyC
 Vj6nQcKNiy6vpzL/bxVVbpKuRqUFj4SjyxSt4qw7Or5nwYDbUE9Sb6SejZ2pHX5bWwmW XQ== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sajsa7f1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 14:17:33 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 45107803729;
        Mon,  7 Aug 2023 14:17:32 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id B2CF580D511;
        Mon,  7 Aug 2023 14:17:31 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id E149C302F47FB; Mon,  7 Aug 2023 09:17:30 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv: Use alternate source for socket to node data
Date:   Mon,  7 Aug 2023 09:17:30 -0500
Message-Id: <20230807141730.1117278-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
X-Proofpoint-GUID: yjgaQt5zp1J_-bKCOjA1JrLMCuBf0rsL
X-Proofpoint-ORIG-GUID: yjgaQt5zp1J_-bKCOjA1JrLMCuBf0rsL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nr_cpus is set to a smaller number than actually present, the
cpu_to_node() mapping information for unused CPUs is not available to
build_socket_tables().  This results in an incomplete table and will
later cause use of a -1 value for some array indexing, and eventual
kernel page faults.

Switch to using the __apicid_to_node array, which still contains all
the information mapping apicids to nodes, even for CPUs disabled with
a reduced nr_cpus setting.

Fixes: 8a50c5851927 ("x86/platform/uv: UV support for sub-NUMA clustering")
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

This is essentially version 2 of "[PATCH] x86/platform/uv: Abort UV
initialization when reduced nr_cpus requires it".  However, the title
was no longer accurate, aborting UV initialization is no longer needed.

Previous discussion can be found here:
https://lore.kernel.org/lkml/20230711202618.85562-1-steve.wahl@hpe.com/

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d9384d5b4b8e..35acc95c6dd5 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1571,7 +1571,7 @@ static void __init build_socket_tables(void)
 {
 	struct uv_gam_range_entry *gre = uv_gre_table;
 	int nums, numn, nump;
-	int cpu, i, lnid;
+	int i, lnid, apicid;
 	int minsock = _min_socket;
 	int maxsock = _max_socket;
 	int minpnode = _min_pnode;
@@ -1622,15 +1622,14 @@ static void __init build_socket_tables(void)
 
 	/* Set socket -> node values: */
 	lnid = NUMA_NO_NODE;
-	for_each_possible_cpu(cpu) {
-		int nid = cpu_to_node(cpu);
-		int apicid, sockid;
+	for (apicid = 0; apicid < ARRAY_SIZE(__apicid_to_node); apicid++) {
+		int nid = __apicid_to_node[apicid];
+		int sockid;
 
-		if (lnid == nid)
+		if ((nid == NUMA_NO_NODE) || (lnid == nid))
 			continue;
 		lnid = nid;
 
-		apicid = per_cpu(x86_cpu_to_apicid, cpu);
 		sockid = apicid >> uv_cpuid.socketid_shift;
 
 		if (_socket_to_node[sockid - minsock] == SOCK_EMPTY)
-- 
2.26.2

