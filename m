Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB07ADAFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjIYPJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjIYPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:09:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F48111
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:09:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-533e7d127d4so3585256a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695654557; x=1696259357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gB08Ho8BZBS4gNXp9UyrPweCd6yMpg+uFk8UMY2sYh4=;
        b=A4WBrqqqU0ojpOt4OQtqu3HwIXmzqpm5h8TJ4YfyU7YKXn6ehs83LVxh3eFs9bWVe0
         qoSSelhPDp8gNSrNhKnYfzzO6yQBESJ8P6eGdVdu39kWUbVeRaYgYmsW2pnE/hcCaaKE
         AuLG/IFGfPD70k67qcQc6UUmKW9sz+sBKEGm01N21w662GKui5IEQtwTh8b49XejncLG
         IHJot95x9IYbLrpSAQzux6P443I6558xVyJHmReB3UyZMu3in6aE1iSMZuO0NJv50K2P
         1VTj/xcoJ7N8Y87S9YPmj9JDGN6MLkVfLaiDJaUZxNFBiIDzkfwehTUcxTtO8lhFZSNV
         2vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654557; x=1696259357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gB08Ho8BZBS4gNXp9UyrPweCd6yMpg+uFk8UMY2sYh4=;
        b=HAXcxGDmWDOmIzZCFBe0+aXvXVBsooG7r0e47hSPXZmT6Bq0j2uiiaJXb4XpE/uv3p
         gfbCfHz/nIR41W0Mjl/nTABiwJEGfN5d5LDmhbb/0RyGzpilE4bg97uFx3MzzLFAA109
         8/Nl29jjdq2H7BuCeGkIL/BUcrGMvvasXrbcc+vIWJ0/95duw+SUvr34Fn4YK3WhMeZT
         FLVoyniWolJSKIutizKGFoHfIGs7LsM/GguxxxZ4SPfcter6MHkiHqReRPWYATgY0fVI
         q3lb0hnnJJGnNoqUqHOZRYCPRNxDSmdjuyXt9f/Hw4/ksob7xDowkegIqjKg6+CEdRyQ
         NAMQ==
X-Gm-Message-State: AOJu0YzbWTF2mEIV27NwHBWuphcOtU8M8bxCfWInQmPc3kC1h/F26TYF
        kULPGpMM59ot7r262NSaz+njqhNSnf533g==
X-Google-Smtp-Source: AGHT+IEpLQc8Xn0MS0O1TUIjsq4R7z8zDmXPxLQGX4HJxi5FsOWhYI+R0L14heMWUAxpi5TYHE/dNg==
X-Received: by 2002:a17:906:7699:b0:9ad:a660:95b2 with SMTP id o25-20020a170906769900b009ada66095b2mr5512126ejm.11.1695654556767;
        Mon, 25 Sep 2023 08:09:16 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id i13-20020a1709061ccd00b00989828a42e8sm6442191ejh.154.2023.09.25.08.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:09:16 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RESEND PATCH 1/2] locking/generic: Add generic support for sync_try_cmpxchg and its fallback
Date:   Mon, 25 Sep 2023 17:08:23 +0200
Message-ID: <20230925150905.54842-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the generic sync_try_cmpxchg function from the
raw_ prefixed version, also adding explicit instrumentation.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
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

