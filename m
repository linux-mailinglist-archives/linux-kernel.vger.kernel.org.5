Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0E57B46F6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjJAKlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjJAKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:41:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F314DC2
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 03:41:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c3c8adb27so2174764166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696156864; x=1696761664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hd3IQ5VOgFAiZIrz9J6WO1XKlWIuJJ+vlxIzopklsp0=;
        b=HNpBruBrP9JzlDTLT3jwlvp35+N8Hanf9xRtUPYV0DY7jeb30+Ii6INq6fnq7Tu0pa
         bVZVKozzwlsDso3MmC6zlr9Qrq38VutlS+0M7WxtPd4c3gMawP9p+1CVZeRRxbLfTIUS
         VFNX825AQgiPejHc+sVReYHjcL6sXWelR0QMdfZ9G6nnrMaKensCGktv73rMvwF+SyVe
         8l5NVP3lmmAQ/Rf5c57TdZquwVSsAYT7Trv2SXujbwhXE14YOSywCA6uRBTW3GCJAb2X
         XGIjYC+8Obf9gH2kixwVXt48pw33bN3RABMSJhdx0RW1qHkAa1CHKWWLywSVeF4Xon+H
         eAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696156864; x=1696761664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hd3IQ5VOgFAiZIrz9J6WO1XKlWIuJJ+vlxIzopklsp0=;
        b=YSBwT1jakYK+9DsakEYyGtwiTzdiH85351DUWMt5APPJBNo69VYefc0J6i32fsO2Vg
         VxWTLBOCcnYVUcWerV4OxeEJEUNtnCbwgBllrENhQbsrBoZxXcfGzhh/2q3Wl9FYb3ok
         53kYno8xq3KzKdxZEAXWDZ1/6ioHXvlk5Wkdp34mUFeFa6+VCg+qx2B2H94+aq5FXTOq
         mTuXvHSxAVJNW3/vy3xa+6rtjddAZUUzCYb+vSlVGPfA4p2M3lK6bYddicFANrL5O2Ph
         oBuw0cuGUsV1G70svI89Q5kSieOsJAEVuxqX3Gd3wl12dGCXP9Abc5dmIXfBbiYALvru
         R81w==
X-Gm-Message-State: AOJu0YyS3kNad1PbRDonyfY27vo3XphH176b+GUcQAIEnSSrPaNFc+1/
        FA3MJAPCWsZB+EowNZWd8qQETk/YFhlxwQ==
X-Google-Smtp-Source: AGHT+IG9JZc6TmvZHbVpgjX2iUva5UEpfEXoJsk9uCuk4m2g+BHUY+ApqFLeLJsTAyFlG09evitVDA==
X-Received: by 2002:a17:907:774f:b0:9ae:673a:88b9 with SMTP id kx15-20020a170907774f00b009ae673a88b9mr7550136ejc.22.1696156863846;
        Sun, 01 Oct 2023 03:41:03 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170906ca4e00b0099caf5bed64sm15333657ejb.57.2023.10.01.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 03:41:03 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/3] locking/generic: Add generic support for sync_try_cmpxchg and its fallback
Date:   Sun,  1 Oct 2023 12:39:09 +0200
Message-ID: <20231001104053.9644-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the generic sync_try_cmpxchg function from the
raw_ prefixed version, also adding explicit instrumentation.

The patch amends existing scripts to generate sync_try_cmpxchg
locking primitive and its raw_sync_try_cmpxchg fallback, while
leaving existing macros from try_cmpxchg family unchanged.

The target can define its own arch_sync_try_cmpxchg to override the
generic version of raw_sync_try_cmpxchg. This allows the target
to generate more optimal assembly than the generic version.

Additionally, the patch renames two scripts to better reflect
whet they really do.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Improve commit description.
---
 include/linux/atomic/atomic-arch-fallback.h | 15 +++++++++-
 include/linux/atomic/atomic-instrumented.h  | 10 ++++++-
 scripts/atomic/gen-atomic-fallback.sh       | 33 +++++++++++----------
 scripts/atomic/gen-atomic-instrumented.sh   |  3 +-
 4 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index b83ef19da13d..5e95faa959c4 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -428,6 +428,19 @@ extern void raw_cmpxchg128_relaxed_not_implemented(void);
 
 #define raw_sync_cmpxchg arch_sync_cmpxchg
 
+#ifdef arch_sync_try_cmpxchg
+#define raw_sync_try_cmpxchg arch_sync_try_cmpxchg
+#else
+#define raw_sync_try_cmpxchg(_ptr, _oldp, _new) \
+({ \
+	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
+	___r = raw_sync_cmpxchg((_ptr), ___o, (_new)); \
+	if (unlikely(___r != ___o)) \
+		*___op = ___r; \
+	likely(___r == ___o); \
+})
+#endif
+
 /**
  * raw_atomic_read() - atomic load with relaxed ordering
  * @v: pointer to atomic_t
@@ -4649,4 +4662,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 2fdd6702823fa842f9cea57a002e6e4476ae780c
+// eec048affea735b8464f58e6d96992101f8f85f1
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index d401b406ef7c..54d7bbe0aeaa 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -4998,6 +4998,14 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 	raw_try_cmpxchg128_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
 
+#define sync_try_cmpxchg(ptr, ...) \
+({ \
+	typeof(ptr) __ai_ptr = (ptr); \
+	kcsan_mb(); \
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
+	raw_sync_try_cmpxchg(__ai_ptr, __VA_ARGS__); \
+})
+
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 1568f875fef72097413caab8339120c065a39aa4
+// 2cc4bc990fef44d3836ec108f11b610f3f438184
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index a45154cefa48..f80d69cfeb1f 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -223,14 +223,15 @@ gen_xchg_fallbacks()
 
 gen_try_cmpxchg_fallback()
 {
+	local prefix="$1"; shift
 	local cmpxchg="$1"; shift;
-	local order="$1"; shift;
+	local suffix="$1"; shift;
 
 cat <<EOF
-#define raw_try_${cmpxchg}${order}(_ptr, _oldp, _new) \\
+#define raw_${prefix}try_${cmpxchg}${suffix}(_ptr, _oldp, _new) \\
 ({ \\
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \\
-	___r = raw_${cmpxchg}${order}((_ptr), ___o, (_new)); \\
+	___r = raw_${prefix}${cmpxchg}${suffix}((_ptr), ___o, (_new)); \\
 	if (unlikely(___r != ___o)) \\
 		*___op = ___r; \\
 	likely(___r == ___o); \\
@@ -259,11 +260,11 @@ gen_try_cmpxchg_order_fallback()
 	fi
 
 	printf "#else\n"
-	gen_try_cmpxchg_fallback "${cmpxchg}" "${order}"
+	gen_try_cmpxchg_fallback "" "${cmpxchg}" "${order}"
 	printf "#endif\n\n"
 }
 
-gen_try_cmpxchg_fallbacks()
+gen_try_cmpxchg_order_fallbacks()
 {
 	local cmpxchg="$1"; shift;
 
@@ -272,15 +273,17 @@ gen_try_cmpxchg_fallbacks()
 	done
 }
 
-gen_cmpxchg_local_fallbacks()
+gen_def_and_try_cmpxchg_fallback()
 {
+	local prefix="$1"; shift
 	local cmpxchg="$1"; shift
+	local suffix="$1"; shift
 
-	printf "#define raw_${cmpxchg} arch_${cmpxchg}\n\n"
-	printf "#ifdef arch_try_${cmpxchg}\n"
-	printf "#define raw_try_${cmpxchg} arch_try_${cmpxchg}\n"
+	printf "#define raw_${prefix}${cmpxchg}${suffix} arch_${prefix}${cmpxchg}${suffix}\n\n"
+	printf "#ifdef arch_${prefix}try_${cmpxchg}${suffix}\n"
+	printf "#define raw_${prefix}try_${cmpxchg}${suffix} arch_${prefix}try_${cmpxchg}${suffix}\n"
 	printf "#else\n"
-	gen_try_cmpxchg_fallback "${cmpxchg}" ""
+	gen_try_cmpxchg_fallback "${prefix}" "${cmpxchg}" "${suffix}"
 	printf "#endif\n\n"
 }
 
@@ -302,15 +305,15 @@ for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128"; do
 done
 
 for cmpxchg in "cmpxchg" "cmpxchg64" "cmpxchg128"; do
-	gen_try_cmpxchg_fallbacks "${cmpxchg}"
+	gen_try_cmpxchg_order_fallbacks "${cmpxchg}"
 done
 
-for cmpxchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local"; do
-	gen_cmpxchg_local_fallbacks "${cmpxchg}" ""
+for cmpxchg in "cmpxchg" "cmpxchg64" "cmpxchg128"; do
+	gen_def_and_try_cmpxchg_fallback "" "${cmpxchg}" "_local"
 done
 
-for cmpxchg in "sync_cmpxchg"; do
-	printf "#define raw_${cmpxchg} arch_${cmpxchg}\n\n"
+for cmpxchg in "cmpxchg"; do
+	gen_def_and_try_cmpxchg_fallback "sync_" "${cmpxchg}" ""
 done
 
 grep '^[a-z]' "$1" | while read name meta args; do
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 8f8f8e3b20f9..592f3ec89b5f 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -169,7 +169,8 @@ for xchg in "xchg" "cmpxchg" "cmpxchg64" "cmpxchg128" "try_cmpxchg" "try_cmpxchg
 	done
 done
 
-for xchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local" "sync_cmpxchg" "try_cmpxchg_local" "try_cmpxchg64_local" "try_cmpxchg128_local"; do
+for xchg in "cmpxchg_local" "cmpxchg64_local" "cmpxchg128_local" "sync_cmpxchg" \
+	    "try_cmpxchg_local" "try_cmpxchg64_local" "try_cmpxchg128_local" "sync_try_cmpxchg"; do
 	gen_xchg "${xchg}" ""
 	printf "\n"
 done
-- 
2.41.0

