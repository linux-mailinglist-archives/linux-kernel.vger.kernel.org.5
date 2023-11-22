Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5FC7F4200
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbjKVJnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbjKVJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:43:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A18198
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:43:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEF8C433AD;
        Wed, 22 Nov 2023 09:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700646202;
        bh=v46aUsbCUkfVZOkEZ7v0IxSRHU/syZrce+2sfpMy+L8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iIJ0MfSfGFe4BnLUwdW5xpDU2/xqYSBGq5Cj51zuM4YqUFdMnvqeDyfxsUIisnU6b
         wUw0U8Wv0OtRwL9eJwl7JUSwkLZOKIYuD0AugCVQlgzdKZYYavos+tMW7NTLsmFKcC
         fUTaeAlnathNNURAxXfaZCeWFV55cs7UylMWhaFfEfZ8KPnWdlZD6rgrcgdbSK7hJg
         WbfctrcjTBpV2PpOorXe++LBEsLPqSRTj7lS0IvdWzi2ge+pX7iP5nGGrqwFD3lC2V
         BENoY33CIdapQ9DEX5gbQnb9HvHmnMnFes7cCOy49y2tQGmmB3gDv/79PJIL2Tb+ak
         6A2RQiwxSADUA==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 22 Nov 2023 09:42:14 +0000
Subject: [PATCH v7 04/39] arm64: Document boot requirements for Guarded
 Control Stacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-4-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=broonie@kernel.org;
 h=from:subject:message-id; bh=v46aUsbCUkfVZOkEZ7v0IxSRHU/syZrce+2sfpMy+L8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXcz58KUrsysjlaWSzO1jYK55QY/WSRM85IGvg
 PxdQ5ZK0xyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3M+QAKCRAk1otyXVSH
 0B0qCACCvoOJm105lKv2ZPLjhkUmi7fDdR0EajV9UTvtTmDuiS9RoPv6qew3skKRJ2x99xSPM6Z
 MtWo+pWCObUZ/Em3l5ZBxXdf54PqlfguR3WeFcjJxgyWZFoYUbPGvfavfrfotOZEl8YyAR60lkT
 CE8NmFmf/pIXk4tmlokj6+AB4XXUAcDtuWo7w3VyW/4oC8t5jYKXNeusb7+/D03X7WNhzaqtsD8
 E7hAKjI9aCqrTPVhf4fOkVUbCxisy/HohyaibsbUO56DDwyDFqhYNMmUsjPSZSKQXDMaY7nzsiX
 E2K+UxJ8O8oozTh0n/yiPavYQ+94mTSwGH/LNau3iMTKY0f+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FEAT_GCS introduces a number of new system registers, we require that
access to these registers is not trapped when we identify that the feature
is detected.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/booting.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index b57776a68f15..de3679770c64 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -411,6 +411,28 @@ Before jumping into the kernel, the following conditions must be met:
 
     - HFGRWR_EL2.nPIRE0_EL1 (bit 57) must be initialised to 0b1.
 
+ - For features with Guarded Control Stacks (FEAT_GCS):
+
+  - If EL3 is present:
+
+    - SCR_EL3.GCSEn (bit 39) must be initialised to 0b1.
+
+ - If the kernel is entered at EL1 and EL2 is present:
+
+    - HFGITR_EL2.nGCSEPP (bit 59) must be initialised to 0b1.
+
+    - HFGITR_EL2.nGCSSTR_EL1 (bit 58) must be initialised to 0b1.
+
+    - HFGITR_EL2.nGCSPUSHM_EL1 (bit 57) must be initialised to 0b1.
+
+    - HFGRTR_EL2.nGCS_EL1 (bit 53) must be initialised to 0b1.
+
+    - HFGRTR_EL2.nGCS_EL0 (bit 52) must be initialised to 0b1.
+
+    - HFGWTR_EL2.nGCS_EL1 (bit 53) must be initialised to 0b1.
+
+    - HFGWTR_EL2.nGCS_EL0 (bit 52) must be initialised to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented

-- 
2.39.2

