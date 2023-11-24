Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95DF7F78DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjKXQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjKXQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:25:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD519B0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:25:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B108DC433C7;
        Fri, 24 Nov 2023 16:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700843117;
        bh=sNxWc59AVKhPeJZmeRkb7xN4pWI6P4JlP9gJB/o0OSM=;
        h=From:To:Cc:Subject:Date:From;
        b=XVi7y69HmnwlyloyzHQUsTDv9W0HSEOZ6ERfashNw4l4+UQBHev712V+R0RdHcQly
         /vVLPAQf9bK0z3hiJisjGy17evZURsJnDXlXDK1oWLtuCcncpegXsRYnQxNRXNToJl
         oWGdn/CHP5dbJ4SAyEZ8YkI2LeuNXsHc8RVuqrfKZhYQuLMQcu03MdZMjPND8YpkwW
         UfZAnfWGXSJStLa+cjQBPijckKFXXaLpsTZ6GlHXZTE4qLn/vo5ahlmLGrESI+iXY5
         Yw6HX0CjF8jebNk2xQfhot6y4JKEwLxBIGFpqwN+OCt87PT1C7f66r3yFOhFgftAfH
         IJAz7q3l3mmlQ==
From:   guoren@kernel.org
To:     mark.rutland@arm.com, peterz@infradead.org, keescook@chromium.org,
        paulmck@kernel.org, ubizjak@gmail.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH] locking/atomic: Add acquire and release fence for atomic(64)_read(set)
Date:   Fri, 24 Nov 2023 11:25:08 -0500
Message-Id: <20231124162508.3331357-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The definitions of atomic(64)_read(set) are relax version, so
add acquire and release fence for them.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 include/linux/atomic/atomic-arch-fallback.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 18f5744dfb5d..9775900eeefd 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -460,7 +460,10 @@ raw_atomic_read_acquire(const atomic_t *v)
 #if defined(arch_atomic_read_acquire)
 	return arch_atomic_read_acquire(v);
 #elif defined(arch_atomic_read)
-	return arch_atomic_read(v);
+	int ret;
+	ret = arch_atomic_read(v);
+	__atomic_acquire_fence();
+	return ret;
 #else
 	int ret;
 
@@ -509,6 +512,7 @@ raw_atomic_set_release(atomic_t *v, int i)
 #if defined(arch_atomic_set_release)
 	arch_atomic_set_release(v, i);
 #elif defined(arch_atomic_set)
+	__atomic_release_fence();
 	arch_atomic_set(v, i);
 #else
 	if (__native_word(atomic_t)) {
@@ -2576,7 +2580,10 @@ raw_atomic64_read_acquire(const atomic64_t *v)
 #if defined(arch_atomic64_read_acquire)
 	return arch_atomic64_read_acquire(v);
 #elif defined(arch_atomic64_read)
-	return arch_atomic64_read(v);
+	s64 ret;
+	ret = arch_atomic64_read(v);
+	__atomic_acquire_fence();
+	return ret;
 #else
 	s64 ret;
 
@@ -2625,6 +2632,7 @@ raw_atomic64_set_release(atomic64_t *v, s64 i)
 #if defined(arch_atomic64_set_release)
 	arch_atomic64_set_release(v, i);
 #elif defined(arch_atomic64_set)
+	__atomic_release_fence();
 	arch_atomic64_set(v, i);
 #else
 	if (__native_word(atomic64_t)) {
@@ -4657,4 +4665,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
+// 3135f55051cf62b76664e528bf04337c44a14e72
-- 
2.36.1

