Return-Path: <linux-kernel+bounces-65132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FDA85486C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE6F1F29428
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88C1BC2A;
	Wed, 14 Feb 2024 11:32:21 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9155A1BC2C;
	Wed, 14 Feb 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910340; cv=none; b=Vk13WCSWaqzr21h1dtf8DjZ/yeQ56T4PgllhheYdqANic+2uFcO18oQn+uit4EmZ4nhaHxYMSkCqmCW9t532CYKUWJzHY7b0wTXoXGF4QcgIwsh5x9OFjMiDUQRmmduGVu0jhgAnbR9pEZ5VO686LPjIkPKmqXWminKzoojBcYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910340; c=relaxed/simple;
	bh=toWcMARzYilY+SoIGqBpKXvEhdozlZlMae/6ffMliPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bp20iIOHv4DJfRVDBeMzqQa0v40+AhbH1dj/5sKwRPdOnqceNbw1GsuduNGe5rNpcx9rEtQBmQJmSdM9nKA0TAsFhS/LileB966pBgb/oKnFMwYB/nJo37ZJzuHxyEOTVSGLerrnroFstvq4NFqg5PnANYhjmUKbJ96fAYlGrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TZbHn2Ylyz9xrsF;
	Wed, 14 Feb 2024 19:16:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 42C641405A2;
	Wed, 14 Feb 2024 19:32:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAn0Rl8pMxlwo99Ag--.51308S5;
	Wed, 14 Feb 2024 12:32:01 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Jonathan Corbet <corbet@lwn.net>,
	David Kaplan <david.kaplan@amd.com>,
	Larry Dewey <larry.dewey@amd.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	=?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Mike Christie <michael.christie@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Maninder Singh <maninder1.s@samsung.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH v1 3/5] sbm: call helpers and thunks
Date: Wed, 14 Feb 2024 12:30:33 +0100
Message-Id: <20240214113035.2117-4-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAn0Rl8pMxlwo99Ag--.51308S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4rXrW8ZrWxKr17XFyrZwb_yoWfWFyDpF
	18CFyDGFs8tFW2kr1Ska1vvr1ft3yUAr1UAF95J3s0y3yUtas5XFZ2kr4YyF9rAr48tFyf
	Xa1jqr1YgrnxArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JU7CzZUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

The sbm_exec() function allows to pass only a single void pointer to the
target function running in sandbox mode. Provide a set of macros which make
it easier to pass a wide variety of parameters from kernel mode to sandbox
mode, preserving C type safety.

To use this mechanism with a target function foo(), define the matching
call helper and thunk like this:

    /* This can go into a header file: */
    int foo(struct bar *data);
    SBM_DEFINE_CALL(foo, struct bar *, data);

    /* This should be defined together with foo(): */
    SBM_DEFINE_THUNK(foo, struct bar *, data);

The call helper, running in kernel mode, accepts the same set of parameters
as the target function. It saves them in a target-specific struct and calls
sbm_exec(), passing it a pointer to this struct. This pointer becomes the
data parameter of the matching thunk function, running in sandbox mode. The
thunk interprets the parameter as a pointer to the target-specific struct,
loads the saved arguments from this struct and calls the target function.

Define a shorthand macro SBM_DEFINE_FUNC() that can be used if the target
function, thunk and call helper are all used only in one file:

    static SBM_DEFINE_FUNC(foo, struct bar *, data)
    {
	/* do something with data */
	return 0;
    }

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 include/linux/sbm.h | 208 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/include/linux/sbm.h b/include/linux/sbm.h
index 9671b3c556c7..98fd27cd58d0 100644
--- a/include/linux/sbm.h
+++ b/include/linux/sbm.h
@@ -305,4 +305,212 @@ static inline int sbm_exec(struct sbm *sbm, sbm_func func, void *data)
 
 #endif /* CONFIG_SANDBOX_MODE */
 
+/**
+ * __SBM_MAP() - Convert parameters to comma-separated expressions.
+ * @m: Macro used to convert each pair.
+ * @e: Expansion if no arguments are given.
+ */
+#define __SBM_MAP(m, e, ...) \
+	CONCATENATE(__SBM_MAP, COUNT_ARGS(__VA_ARGS__))(m, e, ##__VA_ARGS__)
+#define __SBM_MAP0(m, e)             e
+#define __SBM_MAP2(m, e, t, a)       m(t, a)
+#define __SBM_MAP4(m, e, t, a, ...)  m(t, a), __SBM_MAP2(m, e, __VA_ARGS__)
+#define __SBM_MAP6(m, e, t, a, ...)  m(t, a), __SBM_MAP4(m, e, __VA_ARGS__)
+#define __SBM_MAP8(m, e, t, a, ...)  m(t, a), __SBM_MAP6(m, e, __VA_ARGS__)
+#define __SBM_MAP10(m, e, t, a, ...) m(t, a), __SBM_MAP8(m, e, __VA_ARGS__)
+#define __SBM_MAP12(m, e, t, a, ...) m(t, a), __SBM_MAP10(m, e, __VA_ARGS__)
+
+/**
+ * __SBM_MEMBERS() - Convert parameters to struct declaration body.
+ *
+ * This macro is similar to __SBM_MAP(), but the declarations are delimited by
+ * semicolons, not commas.
+ */
+#define __SBM_MEMBERS(...) \
+	CONCATENATE(__SBM_MEMBERS, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
+#define __SBM_MEMBERS0()
+#define __SBM_MEMBERS2(t, a)       t a;
+#define __SBM_MEMBERS4(t, a, ...)  t a; __SBM_MEMBERS2(__VA_ARGS__)
+#define __SBM_MEMBERS6(t, a, ...)  t a; __SBM_MEMBERS4(__VA_ARGS__)
+#define __SBM_MEMBERS8(t, a, ...)  t a; __SBM_MEMBERS6(__VA_ARGS__)
+#define __SBM_MEMBERS10(t, a, ...) t a; __SBM_MEMBERS8(__VA_ARGS__)
+#define __SBM_MEMBERS12(t, a, ...) t a; __SBM_MEMBERS10(__VA_ARGS__)
+
+/************************* Target function **************************/
+
+/**
+ * __SBM_DECL() - Map a parameter to a declaration.
+ * @type: Parameter type.
+ * @id:   Parameter identifier.
+ *
+ * Use this macro with __SBM_MAP() to get variable or function parameter
+ * declarations.
+ */
+#define __SBM_DECL(type, id)   type id
+
+/**
+ * __SBM_DECLARE_FUNC() - Declare a target function.
+ * @f:   Target function name.
+ * @...: Parameters as type-identifier pairs.
+ *
+ * Target function parameters are specified as type-identifier pairs, somewhat
+ * similar to SYSCALL_DEFINEn(). The function name @f is followed by up to 6
+ * type and identifier pairs, one for each parameter. The number of parameters
+ * is determined automatically.
+ *
+ * For example, if your target function is declared like this:
+ *
+ * .. code-block:: c
+ *   static int foo(struct bar *baz);
+ *
+ * it would be declared with __SBM_DECLARE_FUNC() like this:
+ *
+ * .. code-block:: c
+ *   static __SBM_DECLARE_FUNC(foo, struct bar *, baz);
+ *
+ */
+#define __SBM_DECLARE_FUNC(f, ...) \
+	int f(__SBM_MAP(__SBM_DECL, void, ##__VA_ARGS__))
+
+/*************************** Call helper ****************************/
+
+/**
+ * __SBM_CALL() - Call helper function identifier.
+ * @f: Target function name.
+ */
+#define __SBM_CALL(f)	__sbm_call_##f
+
+/**
+ * __SBM_VAR() - Map a parameter to its identifier.
+ * @type: Parameter type (unused).
+ * @id:   Parameter identifier.
+ *
+ * Use this macro with __SBM_MAP() to get only the identifier from each
+ * type-identifier pair.
+ */
+#define __SBM_VAR(type, id)    id
+
+/**
+ * __SBM_OPT_ARG() - Define an optional macro argument.
+ * @...: Optional parameters.
+ *
+ * Expand to a comma followed by all macro parameters, but if the parameter
+ * list is empty, expand to nothing (not even the comma).
+ */
+#define __SBM_OPT_ARG(...)	__SBM_OPT_ARG_1(__VA_ARGS__)
+#define __SBM_OPT_ARG_1(...)	, ##__VA_ARGS__
+
+/**
+ * SBM_DEFINE_CALL() - Define a call helper.
+ * @f:   Target function name.
+ * @...: Parameters as type-identifier pairs.
+ *
+ * Declare an argument-passing struct and define the corresponding call
+ * helper. The call helper stores its arguments in an automatic variable of
+ * the corresponding type and calls sbm_exec().
+ *
+ * The call helper is an inline function, so it is OK to use this macro in
+ * header files.
+ *
+ * Target function parameters are specified as type-identifier pairs, see
+ * __SBM_DECLARE_FUNC().
+ */
+#define SBM_DEFINE_CALL(f, ...) \
+	int __SBM_THUNK(f)(void *__p);					\
+	struct __SBM_ARG(f) {						\
+		__SBM_MEMBERS(__VA_ARGS__)				\
+	};								\
+	static inline int __SBM_CALL(f)(				\
+		struct sbm *__sbm					\
+		__SBM_OPT_ARG(__SBM_MAP(__SBM_DECL, , ##__VA_ARGS__)))	\
+	{								\
+		struct __SBM_ARG(f) __args = {				\
+			__SBM_MAP(__SBM_VAR, , ##__VA_ARGS__)		\
+		};							\
+		return sbm_exec(__sbm, __SBM_THUNK(f), &__args);	\
+	}
+
+/************************** Thunk function **************************/
+
+/**
+ * __SBM_ARG() - Struct tag for target function arguments.
+ * @f: Target function name.
+ */
+#define __SBM_ARG(f)	__sbm_arg_##f
+
+/**
+ * __SBM_DEREF() - Map a parameter to a struct __SBM_ARG() field.
+ * @type: Parameter type (unused).
+ * @id:   Parameter identifier.
+ *
+ * Use this macro with __SBM_MAP() to dereference a struct __SBM_ARG()
+ * pointer.
+ */
+#define __SBM_DEREF(type, id)  __arg->id
+
+/**
+ * __SBM_THUNK() - Thunk function identifier.
+ * @f: Target function name.
+ *
+ * Use this macro to generate the thunk function identifier for a given target
+ * function.
+ */
+#define __SBM_THUNK(f)	__sbm_thunk_##f
+
+/**
+ * SBM_DEFINE_THUNK() - Define a thunk function.
+ * @f:   Target function name.
+ * @...: Parameters as type-identifier pairs.
+ *
+ * The thunk function casts its parameter back to the argument-passing struct
+ * and calls the target function @f with parameters stored there by the call
+ * helper.
+ *
+ * Target function parameters are specified as type-identifier pairs, see
+ * __SBM_DECLARE_FUNC().
+ */
+#define SBM_DEFINE_THUNK(f, ...) \
+	int __SBM_THUNK(f)(void *__p)					\
+	{								\
+		struct __SBM_ARG(f) *__arg __maybe_unused = __p;	\
+		return (f)(__SBM_MAP(__SBM_DEREF, , ##__VA_ARGS__));	\
+	}
+
+/**************************** Shorthands ****************************/
+
+/**
+ * SBM_DEFINE_FUNC() - Define target function, thunk and call helper.
+ * @f:   Target function name.
+ * @...: Parameters as type-identifier pairs.
+ *
+ * Declare or define a target function and also the corresponding
+ * thunk and call helper. Use this shorthand to avoid repeating the
+ * target function signature.
+ *
+ * The target function is declared twice. The first declaration allows to
+ * precede the macro with storage-class specifiers. The second declaration
+ * allows to follow the macro with the function body. You can also put a
+ * semicolon after the macro to make it only a declaration.
+ *
+ * Target function parameters are specified as type-identifier pairs, see
+ * __SBM_DECLARE_FUNC().
+ */
+#define SBM_DEFINE_FUNC(f, ...) \
+	__SBM_DECLARE_FUNC(f, ##__VA_ARGS__);		\
+	static SBM_DEFINE_CALL(f, ##__VA_ARGS__)	\
+	static SBM_DEFINE_THUNK(f, ##__VA_ARGS__)	\
+	__SBM_DECLARE_FUNC(f, ##__VA_ARGS__)
+
+/**
+ * sbm_call() - Call a function in sandbox mode.
+ * @sbm:    SBM instance.
+ * @func:   Function to be called.
+ * @...:    Target function arguments.
+ *
+ * Call a function using a call helper which was previously defined with
+ * SBM_DEFINE_FUNC().
+ */
+#define sbm_call(sbm, func, ...) \
+	__SBM_CALL(func)(sbm, ##__VA_ARGS__)
+
 #endif /* __LINUX_SBM_H */
-- 
2.34.1


