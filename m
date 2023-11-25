Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B037F878C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 02:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjKYBaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 20:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKYBa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 20:30:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2838170B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 17:30:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C45C433C8;
        Sat, 25 Nov 2023 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700875834;
        bh=qeDXoLzmrhwSilEwE0NvbJIMDl1HECjBmJFRcsC+j+A=;
        h=From:To:Cc:Subject:Date:From;
        b=SVvJsJCUgMdCHfUpmu0Wv+yIpIRY59srm5xzTZhcSTP9UZnDKhhzkTl652feAlXi5
         rrAr9asBal/ggna0h57s03wGVny0RL8x42AcNIq4hX9AMGLGo/FyM5Y24u10WMVgXc
         2ahGcnYjibixl14t7smTacIkQpcbFysVVYtob4ozvtRVfg3sNbf7Q6wRTkKzhraE9R
         Z0xanuVnfo8B/5ZXImSuKskJgJ3c6NgYifIdwuV4RjDUpbe5FR6B+3iT1DdhR7nSqB
         fOmITXeQf3/PE9OzfFRheL1E4aczTPvmku0jgk0WBPKaUCXL8FZESUmDhMuCV60rdp
         fxxGYivjdVjVQ==
From:   guoren@kernel.org
To:     mark.rutland@arm.com, peterz@infradead.org, keescook@chromium.org,
        paulmck@kernel.org, ubizjak@gmail.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V2] locking/atomic: scripts: Increase template priority in order variants
Date:   Fri, 24 Nov 2023 20:30:25 -0500
Message-Id: <20231125013025.3620560-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The definitions of atomic(64)_read(set) are relax version, and using
them for acquire and release is incorrect. Besides, mapping
acquire/release/relaxed to Full ops is terrible and should be the last
choice. So, the final solution is to increase template priority.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
Changelog:
v2:
 - Use gen-atomic-fallback.sh instead of header modification
---
 include/linux/atomic/atomic-arch-fallback.h | 118 +-------------------
 scripts/atomic/gen-atomic-fallback.sh       |   2 +-
 2 files changed, 2 insertions(+), 118 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 18f5744dfb5d..d3c176123216 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -459,8 +459,6 @@ raw_atomic_read_acquire(const atomic_t *v)
 {
 #if defined(arch_atomic_read_acquire)
 	return arch_atomic_read_acquire(v);
-#elif defined(arch_atomic_read)
-	return arch_atomic_read(v);
 #else
 	int ret;
 
@@ -508,8 +506,6 @@ raw_atomic_set_release(atomic_t *v, int i)
 {
 #if defined(arch_atomic_set_release)
 	arch_atomic_set_release(v, i);
-#elif defined(arch_atomic_set)
-	arch_atomic_set(v, i);
 #else
 	if (__native_word(atomic_t)) {
 		smp_store_release(&(v)->counter, i);
@@ -1031,8 +1027,6 @@ raw_atomic_inc_return_acquire(atomic_t *v)
 	int ret = arch_atomic_inc_return_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic_inc_return)
-	return arch_atomic_inc_return(v);
 #else
 	return raw_atomic_add_return_acquire(1, v);
 #endif
@@ -1056,8 +1050,6 @@ raw_atomic_inc_return_release(atomic_t *v)
 #elif defined(arch_atomic_inc_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_inc_return_relaxed(v);
-#elif defined(arch_atomic_inc_return)
-	return arch_atomic_inc_return(v);
 #else
 	return raw_atomic_add_return_release(1, v);
 #endif
@@ -1078,8 +1070,6 @@ raw_atomic_inc_return_relaxed(atomic_t *v)
 {
 #if defined(arch_atomic_inc_return_relaxed)
 	return arch_atomic_inc_return_relaxed(v);
-#elif defined(arch_atomic_inc_return)
-	return arch_atomic_inc_return(v);
 #else
 	return raw_atomic_add_return_relaxed(1, v);
 #endif
@@ -1130,8 +1120,6 @@ raw_atomic_fetch_inc_acquire(atomic_t *v)
 	int ret = arch_atomic_fetch_inc_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic_fetch_inc)
-	return arch_atomic_fetch_inc(v);
 #else
 	return raw_atomic_fetch_add_acquire(1, v);
 #endif
@@ -1155,8 +1143,6 @@ raw_atomic_fetch_inc_release(atomic_t *v)
 #elif defined(arch_atomic_fetch_inc_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_fetch_inc_relaxed(v);
-#elif defined(arch_atomic_fetch_inc)
-	return arch_atomic_fetch_inc(v);
 #else
 	return raw_atomic_fetch_add_release(1, v);
 #endif
@@ -1177,8 +1163,6 @@ raw_atomic_fetch_inc_relaxed(atomic_t *v)
 {
 #if defined(arch_atomic_fetch_inc_relaxed)
 	return arch_atomic_fetch_inc_relaxed(v);
-#elif defined(arch_atomic_fetch_inc)
-	return arch_atomic_fetch_inc(v);
 #else
 	return raw_atomic_fetch_add_relaxed(1, v);
 #endif
@@ -1249,8 +1233,6 @@ raw_atomic_dec_return_acquire(atomic_t *v)
 	int ret = arch_atomic_dec_return_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic_dec_return)
-	return arch_atomic_dec_return(v);
 #else
 	return raw_atomic_sub_return_acquire(1, v);
 #endif
@@ -1274,8 +1256,6 @@ raw_atomic_dec_return_release(atomic_t *v)
 #elif defined(arch_atomic_dec_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_dec_return_relaxed(v);
-#elif defined(arch_atomic_dec_return)
-	return arch_atomic_dec_return(v);
 #else
 	return raw_atomic_sub_return_release(1, v);
 #endif
@@ -1296,8 +1276,6 @@ raw_atomic_dec_return_relaxed(atomic_t *v)
 {
 #if defined(arch_atomic_dec_return_relaxed)
 	return arch_atomic_dec_return_relaxed(v);
-#elif defined(arch_atomic_dec_return)
-	return arch_atomic_dec_return(v);
 #else
 	return raw_atomic_sub_return_relaxed(1, v);
 #endif
@@ -1348,8 +1326,6 @@ raw_atomic_fetch_dec_acquire(atomic_t *v)
 	int ret = arch_atomic_fetch_dec_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic_fetch_dec)
-	return arch_atomic_fetch_dec(v);
 #else
 	return raw_atomic_fetch_sub_acquire(1, v);
 #endif
@@ -1373,8 +1349,6 @@ raw_atomic_fetch_dec_release(atomic_t *v)
 #elif defined(arch_atomic_fetch_dec_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_fetch_dec_relaxed(v);
-#elif defined(arch_atomic_fetch_dec)
-	return arch_atomic_fetch_dec(v);
 #else
 	return raw_atomic_fetch_sub_release(1, v);
 #endif
@@ -1395,8 +1369,6 @@ raw_atomic_fetch_dec_relaxed(atomic_t *v)
 {
 #if defined(arch_atomic_fetch_dec_relaxed)
 	return arch_atomic_fetch_dec_relaxed(v);
-#elif defined(arch_atomic_fetch_dec)
-	return arch_atomic_fetch_dec(v);
 #else
 	return raw_atomic_fetch_sub_relaxed(1, v);
 #endif
@@ -1590,8 +1562,6 @@ raw_atomic_fetch_andnot_acquire(int i, atomic_t *v)
 	int ret = arch_atomic_fetch_andnot_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic_fetch_andnot)
-	return arch_atomic_fetch_andnot(i, v);
 #else
 	return raw_atomic_fetch_and_acquire(~i, v);
 #endif
@@ -1616,8 +1586,6 @@ raw_atomic_fetch_andnot_release(int i, atomic_t *v)
 #elif defined(arch_atomic_fetch_andnot_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_fetch_andnot_relaxed(i, v);
-#elif defined(arch_atomic_fetch_andnot)
-	return arch_atomic_fetch_andnot(i, v);
 #else
 	return raw_atomic_fetch_and_release(~i, v);
 #endif
@@ -1639,8 +1607,6 @@ raw_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
 #if defined(arch_atomic_fetch_andnot_relaxed)
 	return arch_atomic_fetch_andnot_relaxed(i, v);
-#elif defined(arch_atomic_fetch_andnot)
-	return arch_atomic_fetch_andnot(i, v);
 #else
 	return raw_atomic_fetch_and_relaxed(~i, v);
 #endif
@@ -1933,8 +1899,6 @@ raw_atomic_xchg_acquire(atomic_t *v, int new)
 	int ret = arch_atomic_xchg_relaxed(v, new);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic_xchg)
-	return arch_atomic_xchg(v, new);
 #else
 	return raw_xchg_acquire(&v->counter, new);
 #endif
@@ -1959,8 +1923,6 @@ raw_atomic_xchg_release(atomic_t *v, int new)
 #elif defined(arch_atomic_xchg_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_xchg_relaxed(v, new);
-#elif defined(arch_atomic_xchg)
-	return arch_atomic_xchg(v, new);
 #else
 	return raw_xchg_release(&v->counter, new);
 #endif
@@ -1982,8 +1944,6 @@ raw_atomic_xchg_relaxed(atomic_t *v, int new)
 {
 #if defined(arch_atomic_xchg_relaxed)
 	return arch_atomic_xchg_relaxed(v, new);
-#elif defined(arch_atomic_xchg)
-	return arch_atomic_xchg(v, new);
 #else
 	return raw_xchg_relaxed(&v->counter, new);
 #endif
@@ -2038,8 +1998,6 @@ raw_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 	int ret = arch_atomic_cmpxchg_relaxed(v, old, new);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic_cmpxchg)
-	return arch_atomic_cmpxchg(v, old, new);
 #else
 	return raw_cmpxchg_acquire(&v->counter, old, new);
 #endif
@@ -2065,8 +2023,6 @@ raw_atomic_cmpxchg_release(atomic_t *v, int old, int new)
 #elif defined(arch_atomic_cmpxchg_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_cmpxchg_relaxed(v, old, new);
-#elif defined(arch_atomic_cmpxchg)
-	return arch_atomic_cmpxchg(v, old, new);
 #else
 	return raw_cmpxchg_release(&v->counter, old, new);
 #endif
@@ -2089,8 +2045,6 @@ raw_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
 #if defined(arch_atomic_cmpxchg_relaxed)
 	return arch_atomic_cmpxchg_relaxed(v, old, new);
-#elif defined(arch_atomic_cmpxchg)
-	return arch_atomic_cmpxchg(v, old, new);
 #else
 	return raw_cmpxchg_relaxed(&v->counter, old, new);
 #endif
@@ -2151,8 +2105,6 @@ raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 	bool ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic_try_cmpxchg)
-	return arch_atomic_try_cmpxchg(v, old, new);
 #else
 	int r, o = *old;
 	r = raw_atomic_cmpxchg_acquire(v, o, new);
@@ -2183,8 +2135,6 @@ raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 #elif defined(arch_atomic_try_cmpxchg_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
-#elif defined(arch_atomic_try_cmpxchg)
-	return arch_atomic_try_cmpxchg(v, old, new);
 #else
 	int r, o = *old;
 	r = raw_atomic_cmpxchg_release(v, o, new);
@@ -2212,8 +2162,6 @@ raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 #if defined(arch_atomic_try_cmpxchg_relaxed)
 	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
-#elif defined(arch_atomic_try_cmpxchg)
-	return arch_atomic_try_cmpxchg(v, old, new);
 #else
 	int r, o = *old;
 	r = raw_atomic_cmpxchg_relaxed(v, o, new);
@@ -2331,8 +2279,6 @@ raw_atomic_add_negative_acquire(int i, atomic_t *v)
 	bool ret = arch_atomic_add_negative_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic_add_negative)
-	return arch_atomic_add_negative(i, v);
 #else
 	return raw_atomic_add_return_acquire(i, v) < 0;
 #endif
@@ -2357,8 +2303,6 @@ raw_atomic_add_negative_release(int i, atomic_t *v)
 #elif defined(arch_atomic_add_negative_relaxed)
 	__atomic_release_fence();
 	return arch_atomic_add_negative_relaxed(i, v);
-#elif defined(arch_atomic_add_negative)
-	return arch_atomic_add_negative(i, v);
 #else
 	return raw_atomic_add_return_release(i, v) < 0;
 #endif
@@ -2380,8 +2324,6 @@ raw_atomic_add_negative_relaxed(int i, atomic_t *v)
 {
 #if defined(arch_atomic_add_negative_relaxed)
 	return arch_atomic_add_negative_relaxed(i, v);
-#elif defined(arch_atomic_add_negative)
-	return arch_atomic_add_negative(i, v);
 #else
 	return raw_atomic_add_return_relaxed(i, v) < 0;
 #endif
@@ -2575,8 +2517,6 @@ raw_atomic64_read_acquire(const atomic64_t *v)
 {
 #if defined(arch_atomic64_read_acquire)
 	return arch_atomic64_read_acquire(v);
-#elif defined(arch_atomic64_read)
-	return arch_atomic64_read(v);
 #else
 	s64 ret;
 
@@ -2624,8 +2564,6 @@ raw_atomic64_set_release(atomic64_t *v, s64 i)
 {
 #if defined(arch_atomic64_set_release)
 	arch_atomic64_set_release(v, i);
-#elif defined(arch_atomic64_set)
-	arch_atomic64_set(v, i);
 #else
 	if (__native_word(atomic64_t)) {
 		smp_store_release(&(v)->counter, i);
@@ -3147,8 +3085,6 @@ raw_atomic64_inc_return_acquire(atomic64_t *v)
 	s64 ret = arch_atomic64_inc_return_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic64_inc_return)
-	return arch_atomic64_inc_return(v);
 #else
 	return raw_atomic64_add_return_acquire(1, v);
 #endif
@@ -3172,8 +3108,6 @@ raw_atomic64_inc_return_release(atomic64_t *v)
 #elif defined(arch_atomic64_inc_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_inc_return_relaxed(v);
-#elif defined(arch_atomic64_inc_return)
-	return arch_atomic64_inc_return(v);
 #else
 	return raw_atomic64_add_return_release(1, v);
 #endif
@@ -3194,8 +3128,6 @@ raw_atomic64_inc_return_relaxed(atomic64_t *v)
 {
 #if defined(arch_atomic64_inc_return_relaxed)
 	return arch_atomic64_inc_return_relaxed(v);
-#elif defined(arch_atomic64_inc_return)
-	return arch_atomic64_inc_return(v);
 #else
 	return raw_atomic64_add_return_relaxed(1, v);
 #endif
@@ -3246,8 +3178,6 @@ raw_atomic64_fetch_inc_acquire(atomic64_t *v)
 	s64 ret = arch_atomic64_fetch_inc_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic64_fetch_inc)
-	return arch_atomic64_fetch_inc(v);
 #else
 	return raw_atomic64_fetch_add_acquire(1, v);
 #endif
@@ -3271,8 +3201,6 @@ raw_atomic64_fetch_inc_release(atomic64_t *v)
 #elif defined(arch_atomic64_fetch_inc_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_fetch_inc_relaxed(v);
-#elif defined(arch_atomic64_fetch_inc)
-	return arch_atomic64_fetch_inc(v);
 #else
 	return raw_atomic64_fetch_add_release(1, v);
 #endif
@@ -3293,8 +3221,6 @@ raw_atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
 #if defined(arch_atomic64_fetch_inc_relaxed)
 	return arch_atomic64_fetch_inc_relaxed(v);
-#elif defined(arch_atomic64_fetch_inc)
-	return arch_atomic64_fetch_inc(v);
 #else
 	return raw_atomic64_fetch_add_relaxed(1, v);
 #endif
@@ -3365,8 +3291,6 @@ raw_atomic64_dec_return_acquire(atomic64_t *v)
 	s64 ret = arch_atomic64_dec_return_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic64_dec_return)
-	return arch_atomic64_dec_return(v);
 #else
 	return raw_atomic64_sub_return_acquire(1, v);
 #endif
@@ -3390,8 +3314,6 @@ raw_atomic64_dec_return_release(atomic64_t *v)
 #elif defined(arch_atomic64_dec_return_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_dec_return_relaxed(v);
-#elif defined(arch_atomic64_dec_return)
-	return arch_atomic64_dec_return(v);
 #else
 	return raw_atomic64_sub_return_release(1, v);
 #endif
@@ -3412,8 +3334,6 @@ raw_atomic64_dec_return_relaxed(atomic64_t *v)
 {
 #if defined(arch_atomic64_dec_return_relaxed)
 	return arch_atomic64_dec_return_relaxed(v);
-#elif defined(arch_atomic64_dec_return)
-	return arch_atomic64_dec_return(v);
 #else
 	return raw_atomic64_sub_return_relaxed(1, v);
 #endif
@@ -3464,8 +3384,6 @@ raw_atomic64_fetch_dec_acquire(atomic64_t *v)
 	s64 ret = arch_atomic64_fetch_dec_relaxed(v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic64_fetch_dec)
-	return arch_atomic64_fetch_dec(v);
 #else
 	return raw_atomic64_fetch_sub_acquire(1, v);
 #endif
@@ -3489,8 +3407,6 @@ raw_atomic64_fetch_dec_release(atomic64_t *v)
 #elif defined(arch_atomic64_fetch_dec_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_fetch_dec_relaxed(v);
-#elif defined(arch_atomic64_fetch_dec)
-	return arch_atomic64_fetch_dec(v);
 #else
 	return raw_atomic64_fetch_sub_release(1, v);
 #endif
@@ -3511,8 +3427,6 @@ raw_atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
 #if defined(arch_atomic64_fetch_dec_relaxed)
 	return arch_atomic64_fetch_dec_relaxed(v);
-#elif defined(arch_atomic64_fetch_dec)
-	return arch_atomic64_fetch_dec(v);
 #else
 	return raw_atomic64_fetch_sub_relaxed(1, v);
 #endif
@@ -3706,8 +3620,6 @@ raw_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 	s64 ret = arch_atomic64_fetch_andnot_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic64_fetch_andnot)
-	return arch_atomic64_fetch_andnot(i, v);
 #else
 	return raw_atomic64_fetch_and_acquire(~i, v);
 #endif
@@ -3732,8 +3644,6 @@ raw_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 #elif defined(arch_atomic64_fetch_andnot_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_fetch_andnot_relaxed(i, v);
-#elif defined(arch_atomic64_fetch_andnot)
-	return arch_atomic64_fetch_andnot(i, v);
 #else
 	return raw_atomic64_fetch_and_release(~i, v);
 #endif
@@ -3755,8 +3665,6 @@ raw_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
 #if defined(arch_atomic64_fetch_andnot_relaxed)
 	return arch_atomic64_fetch_andnot_relaxed(i, v);
-#elif defined(arch_atomic64_fetch_andnot)
-	return arch_atomic64_fetch_andnot(i, v);
 #else
 	return raw_atomic64_fetch_and_relaxed(~i, v);
 #endif
@@ -4049,8 +3957,6 @@ raw_atomic64_xchg_acquire(atomic64_t *v, s64 new)
 	s64 ret = arch_atomic64_xchg_relaxed(v, new);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic64_xchg)
-	return arch_atomic64_xchg(v, new);
 #else
 	return raw_xchg_acquire(&v->counter, new);
 #endif
@@ -4075,8 +3981,6 @@ raw_atomic64_xchg_release(atomic64_t *v, s64 new)
 #elif defined(arch_atomic64_xchg_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_xchg_relaxed(v, new);
-#elif defined(arch_atomic64_xchg)
-	return arch_atomic64_xchg(v, new);
 #else
 	return raw_xchg_release(&v->counter, new);
 #endif
@@ -4098,8 +4002,6 @@ raw_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
 {
 #if defined(arch_atomic64_xchg_relaxed)
 	return arch_atomic64_xchg_relaxed(v, new);
-#elif defined(arch_atomic64_xchg)
-	return arch_atomic64_xchg(v, new);
 #else
 	return raw_xchg_relaxed(&v->counter, new);
 #endif
@@ -4154,8 +4056,6 @@ raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 	s64 ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic64_cmpxchg)
-	return arch_atomic64_cmpxchg(v, old, new);
 #else
 	return raw_cmpxchg_acquire(&v->counter, old, new);
 #endif
@@ -4181,8 +4081,6 @@ raw_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 #elif defined(arch_atomic64_cmpxchg_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_cmpxchg_relaxed(v, old, new);
-#elif defined(arch_atomic64_cmpxchg)
-	return arch_atomic64_cmpxchg(v, old, new);
 #else
 	return raw_cmpxchg_release(&v->counter, old, new);
 #endif
@@ -4205,8 +4103,6 @@ raw_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
 #if defined(arch_atomic64_cmpxchg_relaxed)
 	return arch_atomic64_cmpxchg_relaxed(v, old, new);
-#elif defined(arch_atomic64_cmpxchg)
-	return arch_atomic64_cmpxchg(v, old, new);
 #else
 	return raw_cmpxchg_relaxed(&v->counter, old, new);
 #endif
@@ -4267,8 +4163,6 @@ raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 	bool ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic64_try_cmpxchg)
-	return arch_atomic64_try_cmpxchg(v, old, new);
 #else
 	s64 r, o = *old;
 	r = raw_atomic64_cmpxchg_acquire(v, o, new);
@@ -4299,8 +4193,6 @@ raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 #elif defined(arch_atomic64_try_cmpxchg_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
-#elif defined(arch_atomic64_try_cmpxchg)
-	return arch_atomic64_try_cmpxchg(v, old, new);
 #else
 	s64 r, o = *old;
 	r = raw_atomic64_cmpxchg_release(v, o, new);
@@ -4328,8 +4220,6 @@ raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 #if defined(arch_atomic64_try_cmpxchg_relaxed)
 	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
-#elif defined(arch_atomic64_try_cmpxchg)
-	return arch_atomic64_try_cmpxchg(v, old, new);
 #else
 	s64 r, o = *old;
 	r = raw_atomic64_cmpxchg_relaxed(v, o, new);
@@ -4447,8 +4337,6 @@ raw_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
 	bool ret = arch_atomic64_add_negative_relaxed(i, v);
 	__atomic_acquire_fence();
 	return ret;
-#elif defined(arch_atomic64_add_negative)
-	return arch_atomic64_add_negative(i, v);
 #else
 	return raw_atomic64_add_return_acquire(i, v) < 0;
 #endif
@@ -4473,8 +4361,6 @@ raw_atomic64_add_negative_release(s64 i, atomic64_t *v)
 #elif defined(arch_atomic64_add_negative_relaxed)
 	__atomic_release_fence();
 	return arch_atomic64_add_negative_relaxed(i, v);
-#elif defined(arch_atomic64_add_negative)
-	return arch_atomic64_add_negative(i, v);
 #else
 	return raw_atomic64_add_return_release(i, v) < 0;
 #endif
@@ -4496,8 +4382,6 @@ raw_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
 {
 #if defined(arch_atomic64_add_negative_relaxed)
 	return arch_atomic64_add_negative_relaxed(i, v);
-#elif defined(arch_atomic64_add_negative)
-	return arch_atomic64_add_negative(i, v);
 #else
 	return raw_atomic64_add_return_relaxed(i, v) < 0;
 #endif
@@ -4657,4 +4541,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
+// 9cae73fa68c7c3b6b36a4ec7ee88c81edaa1cb1f
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index c0c8a85d7c81..d313c4bf91c4 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -102,7 +102,7 @@ gen_proto_order_variant()
 	fi
 
 	# Allow ACQUIRE/RELEASE/RELAXED ops to be defined in terms of FULL ops
-	if [ ! -z "${order}" ]; then
+	if [ ! -z "${order}" ] && [ -z "${template}" ]; then
 		printf "#elif defined(arch_${basename})\n"
 		printf "\t${retstmt}arch_${basename}(${args});\n"
 	fi
-- 
2.36.1

