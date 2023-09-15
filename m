Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F1D7A1776
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjIOHaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjIOHaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:30:10 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A354F1724
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694762998;
  x=1726298998;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=ZtQJD7Nx7MRDe9gv5VcJ0bJ+FN+0txe0L0UuBp9Hx9U=;
  b=mNAug2cJoD8yAgtTgaQu1OxFfQYSn1HgocrqO7Je9uekG9jmyjP3l/GS
   U884HDcbY5daRcUNQ79eZSOQwXEAoC28EeenGNR1EVnzEriR4NgtPQWJN
   SXS+bGScbxiY+5xiHQYOA6SSHIFvS41ho2U2NpH9IReuxRasYPNDNBn5r
   +NCc9IICKe+pCSWJxo5dsP6Zw4QIQqkYdLPhuXV0lOB5ZzDlYvcWCEsEh
   mskNnUaqhgdkc9VJz7sAyMlK6FPzsID7Au/Vniz7GTZ0Hy0eTr6iXOXhK
   7GqiYYywu719Bt+xde/e6RSJ8BKtHXK/11K73dRk2Fn9tUKiK4i9RhHpF
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 15 Sep 2023 09:29:52 +0200
Subject: [PATCH v2] x86: Fix build of UML with KASAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230915-uml-kasan-v2-1-ef3f3ff4f144@axis.com>
X-B4-Tracking: v=1; b=H4sIAO8HBGUC/22Nyw6CMBBFf4XM2jGlgAFX/odhMfQhE7U1HSUYw
 r9bWLs8J/exgLjETuBcLJDcxMIxZNCHAsxI4eaQbWbQSlfqpDr8PB94J6GAuuq0tbWp2qaFnB9
 IHA6Jghm3ho9Rb/qVnOd5v7j2mUeWd0zf/XEqN/tvfCqxxMaTaW2tOlv7C80sRxOf0K/r+gOhX
 iW1uAAAAA==
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        <linux-um@lists.infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        <kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building UML with KASAN fails since commit 69d4c0d32186 ("entry, kasan,
x86: Disallow overriding mem*() functions") with the following errors:

 $ tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
 ...
 ld: mm/kasan/shadow.o: in function `memset':
 shadow.c:(.text+0x40): multiple definition of `memset';
 arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
 ld: mm/kasan/shadow.o: in function `memmove':
 shadow.c:(.text+0x90): multiple definition of `memmove';
 arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
 ld: mm/kasan/shadow.o: in function `memcpy':
 shadow.c:(.text+0x110): multiple definition of `memcpy';
 arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here

UML does not use GENERIC_ENTRY and is still supposed to be allowed to
override the mem*() functions, so use weak aliases in that case.

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
Changes in v2:
- Use CONFIG_UML instead of CONFIG_GENERIC_ENTRY.
- Link to v1: https://lore.kernel.org/r/20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com
---
 arch/x86/lib/memcpy_64.S  | 4 ++++
 arch/x86/lib/memmove_64.S | 4 ++++
 arch/x86/lib/memset_64.S  | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 8f95fb267caa..47b004851cf3 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -40,7 +40,11 @@ SYM_TYPED_FUNC_START(__memcpy)
 SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
+#ifdef CONFIG_UML
+SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+#else
 SYM_FUNC_ALIAS(memcpy, __memcpy)
+#endif
 EXPORT_SYMBOL(memcpy)
 
 SYM_FUNC_START_LOCAL(memcpy_orig)
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 0559b206fb11..e3a76d38c278 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -212,5 +212,9 @@ SYM_FUNC_START(__memmove)
 SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 
+#ifdef CONFIG_UML
+SYM_FUNC_ALIAS_WEAK(memmove, __memmove)
+#else
 SYM_FUNC_ALIAS(memmove, __memmove)
+#endif
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 7c59a704c458..6d1c247c821c 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -40,7 +40,11 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
+#ifdef CONFIG_UML
+SYM_FUNC_ALIAS_WEAK(memset, __memset)
+#else
 SYM_FUNC_ALIAS(memset, __memset)
+#endif
 EXPORT_SYMBOL(memset)
 
 SYM_FUNC_START_LOCAL(memset_orig)

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230609-uml-kasan-2392dd4c3858

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

