Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A451E7992B5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbjIHXNL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 19:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344784AbjIHXNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:13:09 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0118E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 16:13:05 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388HqD5G030687
        for <linux-kernel@vger.kernel.org>; Fri, 8 Sep 2023 16:13:05 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t06jvvkdt-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 16:13:04 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 8 Sep 2023 16:13:01 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 01CBF24087ED5; Fri,  8 Sep 2023 16:12:48 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <ndesaulniers@google.com>, Song Liu <song@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        <kexec@lists.infradead.org>, <x86@kernel.org>,
        <llvm@lists.linux.dev>
Subject: [PATCH v2] x86/purgatory: Remove LTO flags
Date:   Fri, 8 Sep 2023 16:12:44 -0700
Message-ID: <20230908231244.1092614-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jg41T-4l24zQ1yAN3q4KewC_oaCjHY6p
X-Proofpoint-ORIG-GUID: jg41T-4l24zQ1yAN3q4KewC_oaCjHY6p
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
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Song Liu <song@kernel.org>

---
AFAICT, x86 is the only arch that supports LTO and purgatory.

Changes in v2:
1. Use CC_FLAGS_LTO instead of hardcode -flto. (Nick Desaulniers)
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index c2a29be35c01..08aa0f25f12a 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -19,6 +19,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 # optimization flags.
 KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
 
+# When LTO is enabled, llvm emits many text sections, which is not supported
+# by kexec. Remove -flto=* flags.
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
-- 
2.34.1

