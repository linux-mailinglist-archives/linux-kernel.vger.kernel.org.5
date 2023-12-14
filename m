Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B56812744
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbjLNF5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjLNF5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:57:17 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24781D41
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:56:57 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE4nXMv016537;
        Thu, 14 Dec 2023 05:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4DZJYxEc4SZaDH8SYYalzXsdURynFs6mETQ32ZgpxKM=;
 b=NofoJehkG1v/7XaD8ddU4a9rDfQnzy2vmJvYbu4KLssINrMmUNK+dBwynu4IIDfR7jxe
 Z6dgfJBLj4deEfuoUGLDvSmE/ytgfcAN+UV605pid6wBflOtIeFsNkQ2k9KogspsQBVT
 1B8TczXry1rFjNEBlj0DAkGRpnVnB58yTfncgX3dy9ag/wtqUQKG6VC3YbMkTa4zWX1n
 7IdO51h04/dgXxvW/CNpOIIBvWJkzHQyeOleH2LbHf73oVBtSphRnpRLNjz5HTT4UyAI
 ZaUlJWtmX9csugzao7RpVO04trbjfNkcI+HQpldS+IC3sVpH2VW75r64rS6avBfNnM6g ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyu0ys81t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:45 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE5M76w005673;
        Thu, 14 Dec 2023 05:56:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyu0ys7xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:44 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDNcC4M014824;
        Thu, 14 Dec 2023 05:56:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kggr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BE5uOeY55116242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 05:56:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 020E52004E;
        Thu, 14 Dec 2023 05:56:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87ABE20043;
        Thu, 14 Dec 2023 05:56:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 05:56:23 +0000 (GMT)
Received: from nicholasmvm.. (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8575F606E7;
        Thu, 14 Dec 2023 16:56:19 +1100 (AEDT)
From:   Nicholas Miehlbradt <nicholas@linux.ibm.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     linux-mm@kvack.org, kasan-dev@googlegroups.com, iii@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Miehlbradt <nicholas@linux.ibm.com>
Subject: [PATCH 07/13] powerpc/kprobes: Unpoison instruction in kprobe struct
Date:   Thu, 14 Dec 2023 05:55:33 +0000
Message-Id: <20231214055539.9420-8-nicholas@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214055539.9420-1-nicholas@linux.ibm.com>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3Us5CtheJoZjlpslVofjgPDJzZ6Fl4Vu
X-Proofpoint-ORIG-GUID: rBBFY_dP7t41UbfjaY26lzdS7EmDxzzd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_02,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=711 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN does not unpoison the ainsn field of a kprobe struct correctly.
Manually unpoison it to prevent false positives.

Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index b20ee72e873a..1cbec54f2b6a 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -27,6 +27,7 @@
 #include <asm/sections.h>
 #include <asm/inst.h>
 #include <linux/uaccess.h>
+#include <linux/kmsan-checks.h>
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
@@ -179,6 +180,7 @@ int arch_prepare_kprobe(struct kprobe *p)
 
 	if (!ret) {
 		patch_instruction(p->ainsn.insn, insn);
+		kmsan_unpoison_memory(p->ainsn.insn, sizeof(kprobe_opcode_t));
 		p->opcode = ppc_inst_val(insn);
 	}
 
-- 
2.40.1

