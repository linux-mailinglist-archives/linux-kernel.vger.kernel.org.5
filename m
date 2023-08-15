Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F55D77CB58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbjHOKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbjHOKwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:52:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E0910F0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gzCpQT+kQ4Ui7z/So29lrahaBSmvm7V9Es0WKbIQNCw=; b=N6jMBNqfhiVuYzSTQ2ODRc8jxz
        CfD0M2/Pv2M+2E4rZBl/R3GGqwxxBViNSskzd0uxNYw76Hjtw/qLym8Ot9WEsMrpIhxp7mBpdIxDh
        GGto6WeNzxEYjk0vvUkfF3CWCNgTTFwxBfteLNliWWuvATmHk0yjC6km7vCUw5uidXomXtVqNalG3
        wFX3+CynTT+s08Y9FDqEndXiG4yf9gZNId+QiPreWp3SBOhun25ZygjzeDweVHo8swmrjm5EzbUtw
        2v9pkfQGz3CxGut/SjRHN8RrMhkC6r4aX0QWEiRE5MFXxO8zuErrvPI12mGYsyjtoCNhcKVCjUb5Y
        JyQxPZ/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVref-007mSL-Uc; Tue, 15 Aug 2023 10:52:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0953C30020B;
        Tue, 15 Aug 2023 12:52:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD86E20307333; Tue, 15 Aug 2023 12:52:04 +0200 (CEST)
Date:   Tue, 15 Aug 2023 12:52:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dan.j.williams@intel.com
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: cleanup: Make no_free_ptr() __must_check
Message-ID: <20230815105204.GA927051@hirez.programming.kicks-ass.net>
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

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

I'm not particularly happy with the way the __must_check stuff works,
but I could not get a statement-expression to have __must_check
semantics.

 include/linux/cleanup.h | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 53f1a7a932b0..d2a2905c463e 100644
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
@@ -39,8 +63,12 @@
 
 #define __free(_name)	__cleanup(__free_##_name)
 
+static inline __must_check void * __no_free_ptr(void **pp)
+{ void *p = *pp; *pp = NULL; return p; }
+
 #define no_free_ptr(p) \
-	({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
+	(({ void * __maybe_unused ___t = (p); }), \
+	 ((typeof(p))__no_free_ptr((void **)&(p))))
 
 #define return_ptr(p)	return no_free_ptr(p)
 
