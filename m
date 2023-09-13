Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA4F79E8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjIMNKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbjIMNKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:10:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7C71BC0;
        Wed, 13 Sep 2023 06:10:34 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:10:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694610632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZqxVEGK4kLTjqiI5TlNyUfCYKdpoexEMO8Nc7Yn7r0=;
        b=cyYNH51cp1BvNtdCFz3Wf+jYQdnWgivDrHM2k0RpU7JYtQ6PhDazZEL3NUL89qLOzWZpmh
        1KC+HSZ++TRdPL+hvQ2lMaj3pQYiZUs0NnOMOEwVfL2sQke0qESCUsMoXFa23ueG+oKdKl
        SqmWq210VCt/BvY2zSIEZchorDNrRdGQmdSIpceqRTa+Zl7vjp7o973yaWc6/f6sV1y5qG
        PvA8mOiIj0/zMf2YM3a/PTE9J0fqFuUNlSsJI+/3J9xk8P14szZVPdkZgfxZNU89qFdDYi
        3xuMMN2nkXzt4wqdG8MF70/7Fxopja6CvAcs4PlcXSxcab589hW0sipZrjHrfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694610632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZqxVEGK4kLTjqiI5TlNyUfCYKdpoexEMO8Nc7Yn7r0=;
        b=H9ijjwoTkmjyFdsN5ZlZslsZTdewoHwGCMfDFX70XOIItyoxpiswsYIh8wGBldaWotOprn
        nElCKRgXYVOxQICA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cleanup: Make no_free_ptr() __must_check
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230816103102.GF980931@hirez.programming.kicks-ass.net>
References: <20230816103102.GF980931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169461063154.27769.7093220616808262713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     85be6d842447067ce76047a14d4258c96fd33b7b
Gitweb:        https://git.kernel.org/tip/85be6d842447067ce76047a14d4258c96fd33b7b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 15 Aug 2023 12:52:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Sep 2023 14:59:54 +02:00

cleanup: Make no_free_ptr() __must_check

recent discussion brought about the realization that it makes sense for
no_free_ptr() to have __must_check semantics in order to avoid leaking
the resource.

Additionally, add a few comments to clarify why/how things work.

All credit to Linus on how to combine __must_check and the
stmt-expression.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20230816103102.GF980931@hirez.programming.kicks-ass.net
---
 include/linux/cleanup.h | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 53f1a7a..9f1a9c4 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -7,8 +7,9 @@
 /*
  * DEFINE_FREE(name, type, free):
  *	simple helper macro that defines the required wrapper for a __free()
- *	based cleanup function. @free is an expression using '_T' to access
- *	the variable.
+ *	based cleanup function. @free is an expression using '_T' to access the
+ *	variable. @free should typically include a NULL test before calling a
+ *	function, see the example below.
  *
  * __free(name):
  *	variable attribute to add a scoped based cleanup to the variable.
@@ -17,6 +18,9 @@
  *	like a non-atomic xchg(var, NULL), such that the cleanup function will
  *	be inhibited -- provided it sanely deals with a NULL value.
  *
+ *	NOTE: this has __must_check semantics so that it is harder to accidentally
+ *	leak the resource.
+ *
  * return_ptr(p):
  *	returns p while inhibiting the __free().
  *
@@ -24,6 +28,8 @@
  *
  * DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
  *
+ * void *alloc_obj(...)
+ * {
  *	struct obj *p __free(kfree) = kmalloc(...);
  *	if (!p)
  *		return NULL;
@@ -32,6 +38,24 @@
  *		return NULL;
  *
  *	return_ptr(p);
+ * }
+ *
+ * NOTE: the DEFINE_FREE()'s @free expression includes a NULL test even though
+ * kfree() is fine to be called with a NULL value. This is on purpose. This way
+ * the compiler sees the end of our alloc_obj() function as:
+ *
+ *	tmp = p;
+ *	p = NULL;
+ *	if (p)
+ *		kfree(p);
+ *	return tmp;
+ *
+ * And through the magic of value-propagation and dead-code-elimination, it
+ * eliminates the actual cleanup call and compiles into:
+ *
+ *	return p;
+ *
+ * Without the NULL test it turns into a mess and the compiler can't help us.
  */
 
 #define DEFINE_FREE(_name, _type, _free) \
@@ -39,8 +63,17 @@
 
 #define __free(_name)	__cleanup(__free_##_name)
 
+#define __get_and_null_ptr(p) \
+	({ __auto_type __ptr = &(p); \
+	   __auto_type __val = *__ptr; \
+	   *__ptr = NULL;  __val; })
+
+static inline __must_check
+const volatile void * __must_check_fn(const volatile void *val)
+{ return val; }
+
 #define no_free_ptr(p) \
-	({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
+	((typeof(p)) __must_check_fn(__get_and_null_ptr(p)))
 
 #define return_ptr(p)	return no_free_ptr(p)
 
