Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C025D799285
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjIHWyp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 18:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245740AbjIHWym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:54:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841C81FEA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 15:54:38 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388HqfuY028230
        for <linux-kernel@vger.kernel.org>; Fri, 8 Sep 2023 15:54:38 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3syppcp2mn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 15:54:38 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 8 Sep 2023 15:54:36 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 40DF92408515F; Fri,  8 Sep 2023 15:54:18 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <songliubraving@fb.com>, Song Liu <song@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        <kexec@lists.infradead.org>, <x86@kernel.org>
Subject: [PATCH] x86/purgatory: Remove LTO flags
Date:   Fri, 8 Sep 2023 15:53:53 -0700
Message-ID: <20230908225353.984169-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hEXI--7UtuQUn9CkHMhBYi18M808MIAR
X-Proofpoint-ORIG-GUID: hEXI--7UtuQUn9CkHMhBYi18M808MIAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_18,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With LTO enabled, ld.lld generates multiple .text sections for
purgatory.ro:

$ readelf -S purgatory.ro  | grep " .text"
  [ 1] .text             PROGBITS         0000000000000000  00000040
  [ 7] .text.purgatory   PROGBITS         0000000000000000  000020e0
  [ 9] .text.warn        PROGBITS         0000000000000000  000021c0
  [13] .text.sha256_upda PROGBITS         0000000000000000  000022f0
  [15] .text.sha224_upda PROGBITS         0000000000000000  00002be0
  [17] .text.sha256_fina PROGBITS         0000000000000000  00002bf0
  [19] .text.sha224_fina PROGBITS         0000000000000000  00002cc0

This cause WARNING from kexec_purgatory_setup_sechdrs():

WARNING: CPU: 26 PID: 110894 at kernel/kexec_file.c:919
kexec_load_purgatory+0x37f/0x390

Fix this by disabling LTO for purgatory.

Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sections")
Cc: Ricardo Ribalda <ribalda@chromium.org>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
Signed-off-by: Song Liu <song@kernel.org>

---
AFAICT, x86 is the only arch that supports LTO and purgatory.
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index c2a29be35c01..9c0bff4992ea 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -19,6 +19,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 # optimization flags.
 KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
 
+# When LTO is enabled, llvm emits many text sections, which is not supported
+# by kexec. Remove -flto=* flags.
+KBUILD_CFLAGS := $(filter-out -flto=%,$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
-- 
2.34.1

