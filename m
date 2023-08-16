Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA8A77DEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbjHPKbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243918AbjHPKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:31:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107F21BD4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=D34RT3Lur+N9/zCG68ltkoNZKq0tMJJ4VHitpo+qvt8=; b=rwFCyKhSkb1ggUhxZeHprZmc+G
        vwCyROAbsuqqmEnyLLMINDeKfppUN2vNsdA6TERV/UtvSBY5WSjL5cFyW6jPwpwWd89eJYhE3fIt9
        AjQ56Tuib+YFAr8RPqbeeE45IVvsRn5BBEcQ3PWn4RqWiEsPcvRtAG0JQBaGVVtnAtGiYkDUuRMbe
        xWmYQIAaet7XwaqdMZ8Fl/GdtxMAwW2e+LKbMcGNfThr914rjQ8l0RupICJ5f4gW6eGQRdLcNTAp0
        kg8cIxHmeNX4wxRPADjb8DggCRIDQa2UYt/tbEPmSOtZuaqUTqbmEj8lIuZl9/1VPy2gu2IiiOiJq
        F5oTx3UA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWDnq-00E6jY-Tf; Wed, 16 Aug 2023 10:31:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6EC18300137;
        Wed, 16 Aug 2023 12:31:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 580AB2C8679C6; Wed, 16 Aug 2023 12:31:02 +0200 (CEST)
Date:   Wed, 16 Aug 2023 12:31:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dan.j.williams@intel.com
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] cleanup: Make no_free_ptr() __must_check
Message-ID: <20230816103102.GF980931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


recent discussion brought about the realization that it makes sense for
no_free_ptr() to have __must_check semantics in order to avoid leaking
the resource.

Additionally, add a few comments to clarify why/how things work.

All credit to Linus on how to combine __must_check and the
statement expression.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cleanup.h |   39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

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
 
