Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD807BC936
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 19:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344117AbjJGRFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 13:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344098AbjJGRFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 13:05:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE623B9;
        Sat,  7 Oct 2023 10:04:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CA5C433C8;
        Sat,  7 Oct 2023 17:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696698299;
        bh=7PA8scmHfu5nyFOhItoPibMephbX/u9X82eA3NzQP1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWnn0sOt6WygtD1hvtwiVIqmKHBDxYUleCmm8Su8hd/lnUJvGVbe6sHfuJl7ZjjA8
         pZ96QAL2xYi7Egbrrdjvt0EvwffMJKtblV8mUCndaQJ2RZJAoTQibExZrVfXJykOnj
         aWSpG0WDrEdYgYLSX33jj/riVgkH8hz3+x/rwrSdyQsPVmBDpQ12ADSFv3EiQADHaY
         J8cCrKBe64utnoCGPbxGVmreLogcNc4NqaPkbm5XwX4Abes0XcwIAeQBco/YFqve0Q
         0kNqxSJHhRmkr4BW2uaIYynAZfKuDg+aL1DvDsjChq5pL746vpys8wjaVLH/1nrUI5
         f9e2VYHEtY3FA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/5] modpost: define TO_NATIVE() using bswap_* functions
Date:   Sun,  8 Oct 2023 02:04:46 +0900
Message-Id: <20231007170448.505487-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231007170448.505487-1-masahiroy@kernel.org>
References: <20231007170448.505487-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current TO_NATIVE() has some limitations:

 1) You cannot cast the argument.

 2) You cannot pass a variable marked as 'const'.

 3) Passing an array is a bug, but it is not detected.

Impelement TO_NATIVE() using bswap_*() functions. These are GNU
extensions. If we face portability issues, we can port the code from
include/uapi/linux/swab.h.

With this change, get_rel_type_and_sym() can be simplified by casting
the arguments directly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 13 ++++---------
 scripts/mod/modpost.h | 25 ++++++++++++-------------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2f3b0fe6f68d..99476a9695c5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1410,15 +1410,10 @@ static void get_rel_type_and_sym(struct elf_info *elf, uint64_t r_info,
 		return;
 	}
 
-	if (is_64bit) {
-		Elf64_Xword r_info64 = r_info;
-
-		r_info = TO_NATIVE(r_info64);
-	} else {
-		Elf32_Word r_info32 = r_info;
-
-		r_info = TO_NATIVE(r_info32);
-	}
+	if (is_64bit)
+		r_info = TO_NATIVE((Elf64_Xword)r_info);
+	else
+		r_info = TO_NATIVE((Elf32_Word)r_info);
 
 	*r_type = ELF_R_TYPE(r_info);
 	*r_sym = ELF_R_SYM(r_info);
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 6413f26fcb6b..1392afec118c 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <byteswap.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -51,21 +52,19 @@
 #define ELF_R_TYPE  ELF64_R_TYPE
 #endif
 
+#define bswap(x) \
+({ \
+	_Static_assert(sizeof(x) == 1 || sizeof(x) == 2 || \
+		       sizeof(x) == 4 || sizeof(x) == 8, "bug"); \
+	(typeof(x))(sizeof(x) == 2 ? bswap_16(x) : \
+		    sizeof(x) == 4 ? bswap_32(x) : \
+		    sizeof(x) == 8 ? bswap_64(x) : \
+		    x); \
+})
+
 #if KERNEL_ELFDATA != HOST_ELFDATA
 
-static inline void __endian(const void *src, void *dest, unsigned int size)
-{
-	unsigned int i;
-	for (i = 0; i < size; i++)
-		((unsigned char*)dest)[i] = ((unsigned char*)src)[size - i-1];
-}
-
-#define TO_NATIVE(x)						\
-({								\
-	typeof(x) __x;						\
-	__endian(&(x), &(__x), sizeof(__x));			\
-	__x;							\
-})
+#define TO_NATIVE(x) (bswap(x))
 
 #else /* endianness matches */
 
-- 
2.39.2

