Return-Path: <linux-kernel+bounces-119234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F40188C5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69910305841
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7975413C808;
	Tue, 26 Mar 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4c4OA9v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEF313C680;
	Tue, 26 Mar 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464907; cv=none; b=X6t34KzFPiIXsLfq3+g8NIdYDN2+1eLinexjuqjiWVf7uUenMZWs2epfeOZfVNTc0kdIXMjfPyHM/J2PEJnFiObuaxMDKy6JFMEszEwF78+dALIYke5BT+ih6+KdRSPYSUPd2MGIzg7UWl2YmcfmcN2RDrP7Yu0+Zb1gL3drFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464907; c=relaxed/simple;
	bh=OkKUUc2EsY1HkFkCZesI8s/5V6S6mbVPGD3caXQZEEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Flh/Yx5l9cePtLa8I+LLtuZdYGjP0OVbclXAjzf0tRobw8sOA9Qm8BKVCNSMmINy7HIB33HOvM18QIZi0t7I6TYOljuEvVAsPxyXLQoBgy1UQvKMPzt+i7uE/10rV9UTbVHCJLWA2GJCG8L4YoFCQoNHMcZ3ksqgaSWRmmrJHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4c4OA9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1554C433F1;
	Tue, 26 Mar 2024 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464906;
	bh=OkKUUc2EsY1HkFkCZesI8s/5V6S6mbVPGD3caXQZEEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4c4OA9vcR5PmSMiLBFdXrYdA07QJFREj+2/8VH5bEIZuPBIYQ/RrTMz7phZMW+an
	 7HgH0OmQiw/L5py4Ye4IE14uqG7Thd9Efn5b/4dYol4ZZ0ll8JToJLghrRXGdTzeux
	 8OUPLvpTVgQbdJzdLHshP+lygO5KQ6aXCcfFlp7Kj0H9H0mZbzsEC32ORYF15mqEWk
	 uFrPB9f/TQVC6Mj2op5oh6IYtwy28Cz1WWtU+ACH/GnAShoI6NwD1c9hUi0qsE/kF1
	 /bhuglj3TsXSVO8iWKXL3n+cI0uy8YRzljUbT2aJqXmIEqJotCY/iBEe8+gS/EQkcC
	 3wREc95DfGWiw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [PATCH 11/12] [v4] kallsyms: rework symbol lookup return codes
Date: Tue, 26 Mar 2024 15:53:38 +0100
Message-Id: <20240326145348.3318887-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326144741.3094687-1-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 in some configurations produces a false positive
warning for kallsyms:

kernel/kallsyms.c: In function '__sprint_symbol.isra':
kernel/kallsyms.c:503:17: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
  503 |                 strcpy(buffer, name);
      |                 ^~~~~~~~~~~~~~~~~~~~

This originally showed up while building with -O3, but later started
happening in other configurations as well, depending on inlining
decisions. The underlying issue is that the local 'name' variable is
always initialized to the be the same as 'buffer' in the called functions
that fill the buffer, which gcc notices while inlining, though it could
see that the address check always skips the copy.

The calling conventions here are rather unusual, as all of the internal
lookup functions (bpf_address_lookup, ftrace_mod_address_lookup,
ftrace_func_address_lookup, module_address_lookup and
kallsyms_lookup_buildid) already use the provided buffer and either return
the address of that buffer to indicate success, or NULL for failure,
but the callers are written to also expect an arbitrary other buffer
to be returned.

Rework the calling conventions to return the length of the filled buffer
instead of its address, which is simpler and easier to follow as well
as avoiding the warning. Leave only the kallsyms_lookup() calling conventions
unchanged, since that is called from 16 different functions and
adapting this would be a much bigger change.

Link: https://lore.kernel.org/all/20200107214042.855757-1-arnd@arndb.de/
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v4: fix string length
v3: use strscpy() instead of strlcpy()
v2: complete rewrite after the first patch was rejected (in 2020). This
    is now one of only two warnings that are in the way of enabling
    -Wextra/-Wrestrict by default.
---
 include/linux/filter.h   | 14 +++++++-------
 include/linux/ftrace.h   |  6 +++---
 include/linux/module.h   | 14 +++++++-------
 kernel/bpf/core.c        |  7 +++----
 kernel/kallsyms.c        | 23 ++++++++++++-----------
 kernel/module/kallsyms.c | 26 +++++++++++++-------------
 kernel/trace/ftrace.c    | 13 +++++--------
 7 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index c99bc3df2d28..9d4a7c6f023e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1168,18 +1168,18 @@ static inline bool bpf_jit_kallsyms_enabled(void)
 	return false;
 }
 
-const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
+int __bpf_address_lookup(unsigned long addr, unsigned long *size,
 				 unsigned long *off, char *sym);
 bool is_bpf_text_address(unsigned long addr);
 int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		    char *sym);
 struct bpf_prog *bpf_prog_ksym_find(unsigned long addr);
 
-static inline const char *
+static inline int
 bpf_address_lookup(unsigned long addr, unsigned long *size,
 		   unsigned long *off, char **modname, char *sym)
 {
-	const char *ret = __bpf_address_lookup(addr, size, off, sym);
+	int ret = __bpf_address_lookup(addr, size, off, sym);
 
 	if (ret && modname)
 		*modname = NULL;
@@ -1223,11 +1223,11 @@ static inline bool bpf_jit_kallsyms_enabled(void)
 	return false;
 }
 
-static inline const char *
+static inline int
 __bpf_address_lookup(unsigned long addr, unsigned long *size,
 		     unsigned long *off, char *sym)
 {
-	return NULL;
+	return 0;
 }
 
 static inline bool is_bpf_text_address(unsigned long addr)
@@ -1246,11 +1246,11 @@ static inline struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
 	return NULL;
 }
 
-static inline const char *
+static inline int
 bpf_address_lookup(unsigned long addr, unsigned long *size,
 		   unsigned long *off, char **modname, char *sym)
 {
-	return NULL;
+	return 0;
 }
 
 static inline void bpf_prog_kallsyms_add(struct bpf_prog *fp)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 54d53f345d14..56834a3fa9be 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -87,15 +87,15 @@ struct ftrace_direct_func;
 
 #if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_MODULES) && \
 	defined(CONFIG_DYNAMIC_FTRACE)
-const char *
+int
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 		   unsigned long *off, char **modname, char *sym);
 #else
-static inline const char *
+static inline int
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 		   unsigned long *off, char **modname, char *sym)
 {
-	return NULL;
+	return 0;
 }
 #endif
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 1153b0d99a80..118c36366b35 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -922,11 +922,11 @@ int module_kallsyms_on_each_symbol(const char *modname,
  * least KSYM_NAME_LEN long: a pointer to namebuf is returned if
  * found, otherwise NULL.
  */
-const char *module_address_lookup(unsigned long addr,
-				  unsigned long *symbolsize,
-				  unsigned long *offset,
-				  char **modname, const unsigned char **modbuildid,
-				  char *namebuf);
+int module_address_lookup(unsigned long addr,
+			  unsigned long *symbolsize,
+			  unsigned long *offset,
+			  char **modname, const unsigned char **modbuildid,
+			  char *namebuf);
 int lookup_module_symbol_name(unsigned long addr, char *symname);
 int lookup_module_symbol_attrs(unsigned long addr,
 			       unsigned long *size,
@@ -955,14 +955,14 @@ static inline int module_kallsyms_on_each_symbol(const char *modname,
 }
 
 /* For kallsyms to ask for address resolution.  NULL means not found. */
-static inline const char *module_address_lookup(unsigned long addr,
+static inline int module_address_lookup(unsigned long addr,
 						unsigned long *symbolsize,
 						unsigned long *offset,
 						char **modname,
 						const unsigned char **modbuildid,
 						char *namebuf)
 {
-	return NULL;
+	return 0;
 }
 
 static inline int lookup_module_symbol_name(unsigned long addr, char *symname)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 696bc55de8e8..ffc232333643 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -735,11 +735,11 @@ static struct bpf_ksym *bpf_ksym_find(unsigned long addr)
 	return n ? container_of(n, struct bpf_ksym, tnode) : NULL;
 }
 
-const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
+int __bpf_address_lookup(unsigned long addr, unsigned long *size,
 				 unsigned long *off, char *sym)
 {
 	struct bpf_ksym *ksym;
-	char *ret = NULL;
+	int ret = 0;
 
 	rcu_read_lock();
 	ksym = bpf_ksym_find(addr);
@@ -747,9 +747,8 @@ const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
 		unsigned long symbol_start = ksym->start;
 		unsigned long symbol_end = ksym->end;
 
-		strncpy(sym, ksym->name, KSYM_NAME_LEN);
+		ret = strscpy(sym, ksym->name, KSYM_NAME_LEN);
 
-		ret = sym;
 		if (size)
 			*size = symbol_end - symbol_start;
 		if (off)
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 18edd57b5fe8..eeb0e249e0e2 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -394,12 +394,12 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
 	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
 }
 
-static const char *kallsyms_lookup_buildid(unsigned long addr,
+static int kallsyms_lookup_buildid(unsigned long addr,
 			unsigned long *symbolsize,
 			unsigned long *offset, char **modname,
 			const unsigned char **modbuildid, char *namebuf)
 {
-	const char *ret;
+	int ret;
 
 	namebuf[KSYM_NAME_LEN - 1] = 0;
 	namebuf[0] = 0;
@@ -416,7 +416,7 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 		if (modbuildid)
 			*modbuildid = NULL;
 
-		ret = namebuf;
+		ret = strlen(namebuf);
 		goto found;
 	}
 
@@ -448,8 +448,13 @@ const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *offset,
 			    char **modname, char *namebuf)
 {
-	return kallsyms_lookup_buildid(addr, symbolsize, offset, modname,
-				       NULL, namebuf);
+	int ret = kallsyms_lookup_buildid(addr, symbolsize, offset, modname,
+					  NULL, namebuf);
+
+	if (!ret)
+		return NULL;
+
+	return namebuf;
 }
 
 int lookup_symbol_name(unsigned long addr, char *symname)
@@ -484,19 +489,15 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 {
 	char *modname;
 	const unsigned char *buildid;
-	const char *name;
 	unsigned long offset, size;
 	int len;
 
 	address += symbol_offset;
-	name = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
+	len = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
 				       buffer);
-	if (!name)
+	if (!len)
 		return sprintf(buffer, "0x%lx", address - symbol_offset);
 
-	if (name != buffer)
-		strcpy(buffer, name);
-	len = strlen(buffer);
 	offset -= symbol_offset;
 
 	if (add_offset)
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index ef73ae7c8909..6e6619a5b2f1 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -321,14 +321,15 @@ void * __weak dereference_module_function_descriptor(struct module *mod,
  * For kallsyms to ask for address resolution.  NULL means not found.  Careful
  * not to lock to avoid deadlock on oopses, simply disable preemption.
  */
-const char *module_address_lookup(unsigned long addr,
-				  unsigned long *size,
-			    unsigned long *offset,
-			    char **modname,
-			    const unsigned char **modbuildid,
-			    char *namebuf)
+int module_address_lookup(unsigned long addr,
+			  unsigned long *size,
+			  unsigned long *offset,
+			  char **modname,
+			  const unsigned char **modbuildid,
+			  char *namebuf)
 {
-	const char *ret = NULL;
+	const char *sym;
+	int ret = 0;
 	struct module *mod;
 
 	preempt_disable();
@@ -344,13 +345,12 @@ const char *module_address_lookup(unsigned long addr,
 #endif
 		}
 
-		ret = find_kallsyms_symbol(mod, addr, size, offset);
-	}
-	/* Make a copy in here where it's safe */
-	if (ret) {
-		strncpy(namebuf, ret, KSYM_NAME_LEN - 1);
-		ret = namebuf;
+		sym = find_kallsyms_symbol(mod, addr, size, offset);
+
+		if (sym)
+			ret = strscpy(namebuf, sym, KSYM_NAME_LEN);
 	}
+
 	preempt_enable();
 
 	return ret;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698..b40f9bd29080 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6970,7 +6970,7 @@ allocate_ftrace_mod_map(struct module *mod,
 	return mod_map;
 }
 
-static const char *
+static int
 ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
 			   unsigned long addr, unsigned long *size,
 			   unsigned long *off, char *sym)
@@ -6991,21 +6991,18 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
 			*size = found_func->size;
 		if (off)
 			*off = addr - found_func->ip;
-		if (sym)
-			strscpy(sym, found_func->name, KSYM_NAME_LEN);
-
-		return found_func->name;
+		return strscpy(sym, found_func->name, KSYM_NAME_LEN);
 	}
 
-	return NULL;
+	return 0;
 }
 
-const char *
+int
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 		   unsigned long *off, char **modname, char *sym)
 {
 	struct ftrace_mod_map *mod_map;
-	const char *ret = NULL;
+	int ret;
 
 	/* mod_map is freed via call_rcu() */
 	preempt_disable();
-- 
2.39.2


