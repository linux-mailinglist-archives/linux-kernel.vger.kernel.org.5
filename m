Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7877F4231
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343666AbjKVJox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbjKVJoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:44:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD22BD50
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:44:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7A2C433CA;
        Wed, 22 Nov 2023 09:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700646255;
        bh=gCkTJXN9hgWCfubwLDLAmQpOXrRFEWNkqe7LcsfqPUI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=h210R7jLnqkzHFNW2i+bNC/uW8728czTflygATeqPHl26mTG4iNTO/3gkMXGYPXFf
         PH8vpoZOA7k8ZL9aFvlCjOOCziT6vy26FbZL1HE665xm4hvAUJvhE2zp6t9hzCfeqo
         t3IJNIHcA7tQBbVdWXAS2/RmKl+4V3XS5f8pVjvm5p17xaH9rKDG8KJPCnyHe4rKv0
         HxFWNWYXflOIzbRkGZ3oNzHRXJweodM+ntU8HkYYfwHN9YnMhlU/AiZ+ctbxSLTi3K
         3WwpCNuPtS29zMJyc0EWpf9s7RymWtpI9ltp4+horOAkwOTgBysp6m7F9DquRI7H+/
         0znHAiLzjXVdg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 22 Nov 2023 09:42:21 +0000
Subject: [PATCH v7 11/39] arm64/mm: Allocate PIE slots for EL0 guarded
 control stack
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-11-201c483bd775@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2936; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gCkTJXN9hgWCfubwLDLAmQpOXrRFEWNkqe7LcsfqPUI=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtTYM/8lHrpkfRDKsNrcv+HM4ftX0yZd2fNToL57XXlv5
 UOvmIi3nYzGLAyMXAyyYoosa59lrEoPl9g6/9H8VzCDWJlApjBwcQrARDYpsP937Bf6G8WaH8wS
 YTJz+hT7PkttgeLI1xVXNCfMl/p82eTBruI2duXO/qP+f9YFX1rxK9B2h3NLW5GFu63oJoVFOc7
 nV3j7lmhOOmrZMmGVgMOGJ4cce5+8qrfkvBvQJLSi70Sdr71Os2Jxf7PPrIgIzU8e9Wx3HhrOE3
 ysuznx3ozqD5f5a+2631l8OJr1ce1l7+Soja23YtudX1UYLvRvdFzOZWPi92LpBmcVmZ5psxr/6
 r3u15w538Em9ti7wptlYtEt+X7dAtEnsv4v5Hn4b9vTpHNKzlr3+ULlnBjm/GI4y7naUo9PZJX0
 9sqNSfN2StnU8k4oPOfcdSVw4iMT1+awP0b8OSEmRlssAQ==
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

Pages used for guarded control stacks need to be described to the hardware
using the Permission Indirection Extension, GCS is not supported without
PIE. In order to support copy on write for guarded stacks we allocate two
values, one for active GCSs and one for GCS pages marked as read only prior
to copy.

Since the actual effect is defined using PIE the specific bit pattern used
does not matter to the hardware but we choose two values which differ only
in PTE_WRITE in order to help share code with non-PIE cases.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/pgtable-prot.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index e9624f6326dd..297a645e8a0f 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -127,15 +127,23 @@ extern bool arm64_use_ng_mappings;
 /* 6:                                PTE_PXN | PTE_WRITE            */
 /* 7: PAGE_SHARED_EXEC               PTE_PXN | PTE_WRITE | PTE_USER */
 /* 8: PAGE_KERNEL_ROX      PTE_UXN                                  */
-/* 9:                      PTE_UXN |                       PTE_USER */
+/* 9: PAGE_GCS_RO          PTE_UXN |                       PTE_USER */
 /* a: PAGE_KERNEL_EXEC     PTE_UXN |           PTE_WRITE            */
-/* b:                      PTE_UXN |           PTE_WRITE | PTE_USER */
+/* b: PAGE_GCS             PTE_UXN |           PTE_WRITE | PTE_USER */
 /* c: PAGE_KERNEL_RO       PTE_UXN | PTE_PXN                        */
 /* d: PAGE_READONLY        PTE_UXN | PTE_PXN |             PTE_USER */
 /* e: PAGE_KERNEL          PTE_UXN | PTE_PXN | PTE_WRITE            */
 /* f: PAGE_SHARED          PTE_UXN | PTE_PXN | PTE_WRITE | PTE_USER */
 
+#define _PAGE_GCS	(_PAGE_DEFAULT | PTE_NG | PTE_UXN | PTE_WRITE | PTE_USER)
+#define _PAGE_GCS_RO	(_PAGE_DEFAULT | PTE_NG | PTE_UXN | PTE_USER)
+
+#define PAGE_GCS	__pgprot(_PAGE_GCS)
+#define PAGE_GCS_RO	__pgprot(_PAGE_GCS_RO)
+
 #define PIE_E0	( \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_GCS)  | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_R)   | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_X_O) | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX)  | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX) | \
@@ -143,6 +151,8 @@ extern bool arm64_use_ng_mappings;
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW))
 
 #define PIE_E1	( \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_NONE_O) | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_NONE_O) | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_NONE_O) | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_R)      | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RW)     | \

-- 
2.39.2

