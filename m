Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87AA794248
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbjIFRwr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 13:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbjIFRwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:52:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E2CE4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 10:52:41 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 386GxCMV007734
        for <linux-kernel@vger.kernel.org>; Wed, 6 Sep 2023 10:52:40 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3sxstaash3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 10:52:40 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 6 Sep 2023 10:52:39 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 66BC623E85654; Wed,  6 Sep 2023 10:52:26 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@meta.com>, Song Liu <song@kernel.org>,
        Kees Cook <keescook@chromium.org>, <x86@kernel.org>
Subject: [PATCH] x86/vmlinux: Fix linker fill bytes for ld.lld
Date:   Wed, 6 Sep 2023 10:52:15 -0700
Message-ID: <20230906175215.2236033-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0bIaxbM7o7q42S8old35Wi37dmrx9HD8
X-Proofpoint-ORIG-GUID: 0bIaxbM7o7q42S8old35Wi37dmrx9HD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With ":text =0xcccc", ld.lld fills unused text area with 0xcccc0000.
Example objdump -D output:

ffffffff82b04203:       00 00                   add    %al,(%rax)
ffffffff82b04205:       cc                      int3
ffffffff82b04206:       cc                      int3
ffffffff82b04207:       00 00                   add    %al,(%rax)
ffffffff82b04209:       cc                      int3
ffffffff82b0420a:       cc                      int3

Replace it with ":text =0xcccccccc", so we get the following instead:

ffffffff82b04203:       cc                      int3
ffffffff82b04204:       cc                      int3
ffffffff82b04205:       cc                      int3
ffffffff82b04206:       cc                      int3
ffffffff82b04207:       cc                      int3
ffffffff82b04208:       cc                      int3

gcc/ld doesn't seem to have the same issue. The generated code stays the
same for gcc/ld.

Cc: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 83d41c2601d7..41d56fb9bf92 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -156,7 +156,7 @@ SECTIONS
 		ALIGN_ENTRY_TEXT_END
 		*(.gnu.warning)
 
-	} :text =0xcccc
+	} :text =0xcccccccc
 
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
-- 
2.34.1

