Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB37F90AE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKZBja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZBj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:39:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F9711D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 17:39:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD0CC433C8;
        Sun, 26 Nov 2023 01:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700962773;
        bh=Gzo6Hsh3Ci46CKtC3ZBKQ5dZrI4nYrnZIk9M/HBJe7E=;
        h=From:To:Cc:Subject:Date:From;
        b=PNv28jjvA4pEzsf+PvzuM/HHiy+omZA5pirgSl1AZlAOpLP2ODIoUdk+SFfUoebA0
         9VcgatdekVmD6Er34I2XBK0T4xHycvjGTDNqwgvJ1WeadkcSxwDxj0dXaCgYVku4uy
         FPnWe66KicALFh7WzHDoIl9Qzf6w1n/e/ck3HAsUAdAJxb96rJM9ae/XVC+jVAFgmc
         MlrkOtbqz1kyPK+ghkWqUuw36azbW51ChR1kg1gPZTarThA0SlnpOn2nOA4evK8Pub
         FpzuthpQIBhIN6E2UTm7R8+b3Lft5/MRqpr53i2cJlAMUPfjrILSEe/UC1PH77Cmhk
         9ZqL1wOdbs28Q==
From:   guoren@kernel.org
To:     mark.rutland@arm.com, peterz@infradead.org, keescook@chromium.org,
        paulmck@kernel.org, ubizjak@gmail.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V3] locking/atomic: scripts: Exclude arch_atomic(64)_read(set) mappings
Date:   Sat, 25 Nov 2023 20:39:21 -0500
Message-Id: <20231126013921.103133-1-guoren@kernel.org>
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
them for acquire and release is incorrect, so exclude these mappings.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
Changelog:
v3:
 - Minimize modification on atomic(64)_read(set)

v2:
 - Use gen-atomic-fallback.sh instead of header modification
---
 include/linux/atomic/atomic-arch-fallback.h | 10 +---------
 scripts/atomic/gen-atomic-fallback.sh       |  3 ++-
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 18f5744dfb5d..b83ef19da13d 100644
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
@@ -2575,8 +2571,6 @@ raw_atomic64_read_acquire(const atomic64_t *v)
 {
 #if defined(arch_atomic64_read_acquire)
 	return arch_atomic64_read_acquire(v);
-#elif defined(arch_atomic64_read)
-	return arch_atomic64_read(v);
 #else
 	s64 ret;
 
@@ -2624,8 +2618,6 @@ raw_atomic64_set_release(atomic64_t *v, s64 i)
 {
 #if defined(arch_atomic64_set_release)
 	arch_atomic64_set_release(v, i);
-#elif defined(arch_atomic64_set)
-	arch_atomic64_set(v, i);
 #else
 	if (__native_word(atomic64_t)) {
 		smp_store_release(&(v)->counter, i);
@@ -4657,4 +4649,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
+// 2fdd6702823fa842f9cea57a002e6e4476ae780c
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index c0c8a85d7c81..282a1d3c41d4 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -102,7 +102,8 @@ gen_proto_order_variant()
 	fi
 
 	# Allow ACQUIRE/RELEASE/RELAXED ops to be defined in terms of FULL ops
-	if [ ! -z "${order}" ]; then
+	# Exclude arch_atomic(64)_read(set) mappings because these are not FULL ops.
+	if [ ! -z "${order}" ] && [ "${name}" != "read" ] && [ "${name}" != "set" ]; then
 		printf "#elif defined(arch_${basename})\n"
 		printf "\t${retstmt}arch_${basename}(${args});\n"
 	fi
-- 
2.36.1

