Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F48F75F902
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGXN4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjGXNz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A943410D5;
        Mon, 24 Jul 2023 06:54:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 465F36120E;
        Mon, 24 Jul 2023 13:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106DAC433C7;
        Mon, 24 Jul 2023 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690206890;
        bh=a1wN85+Gd+JyogSZr/tth24jJCm/lVJ1Lu6mj4sOmj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fORFCHjHk3LSeiuui1EjwFUzRLCKW9kuEOSTQv/rFt/wPGuoITwdSuGwvpWB/83fL
         bDqYICdWA9L3DJ12lI7lxiZPSJn6obSnVttFW8HUMIzZy4h2KqWWsw0ca2Bj85m2Ae
         riU4253RvBy3TeJwNdWc/5oIm9TsUmE8xi+WV6ckohCag0AiWHzsMpiq3Q8t5Us3Kp
         gZ4FJW9uSfWUFkXkrvp15kqNPFrsH3DFAM1ulBNBG8OsS37O4d70j+nKDgJMfKw+8v
         U7v26WXDoYs/1vOOHgTSH6/x/op/hX7upfxriZ4Ac6ztRxGwfxPZzZ3sLiHPNUXiz0
         4Z2YAFNh4K54Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: [PATCH 2/2] [v2] kallsyms: rework symbol lookup return codes
Date:   Mon, 24 Jul 2023 15:53:02 +0200
Message-Id: <20230724135327.1173309-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724135327.1173309-1-arnd@kernel.org>
References: <20230724135327.1173309-1-arnd@kernel.org>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
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
index f69114083ec71..10f2b1acb138b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1130,17 +1130,17 @@ static inline bool bpf_jit_kallsyms_enabled(void)
 	return false;
 }
 
-const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
+int __bpf_address_lookup(unsigned long addr, unsigned long *size,
 				 unsigned long *off, char *sym);
 bool is_bpf_text_address(unsigned long addr);
 int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		    char *sym);
 
-static inline const char *
+static inline int
 bpf_address_lookup(unsigned long addr, unsigned long *size,
 		   unsigned long *off, char **modname, char *sym)
 {
-	const char *ret = __bpf_address_lookup(addr, size, off, sym);
+	int ret = __bpf_address_lookup(addr, size, off, sym);
 
 	if (ret && modname)
 		*modname = NULL;
@@ -1184,11 +1184,11 @@ static inline bool bpf_jit_kallsyms_enabled(void)
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
@@ -1202,11 +1202,11 @@ static inline int bpf_get_kallsym(unsigned int symnum, unsigned long *value,
 	return -ERANGE;
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
index ce156c7704ee5..50c7ca7125caa 100644
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
index a98e188cf37b8..76e6104d41ba5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -920,11 +920,11 @@ int module_kallsyms_on_each_symbol(const char *modname,
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
@@ -953,14 +953,14 @@ static inline int module_kallsyms_on_each_symbol(const char *modname,
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
index ea371f790f47c..da0590e5c87e1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -688,11 +688,11 @@ static struct bpf_ksym *bpf_ksym_find(unsigned long addr)
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
@@ -700,9 +700,8 @@ const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
 		unsigned long symbol_start = ksym->start;
 		unsigned long symbol_end = ksym->end;
 
-		strncpy(sym, ksym->name, KSYM_NAME_LEN);
+		ret = strlcpy(sym, ksym->name, KSYM_NAME_LEN);
 
-		ret = sym;
 		if (size)
 			*size = symbol_end - symbol_start;
 		if (off)
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 016d997131d43..cd216ebb14cc3 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -399,12 +399,12 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
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
@@ -421,7 +421,7 @@ static const char *kallsyms_lookup_buildid(unsigned long addr,
 		if (modbuildid)
 			*modbuildid = NULL;
 
-		ret = namebuf;
+		ret = strlen(namebuf);
 		goto found;
 	}
 
@@ -453,8 +453,13 @@ const char *kallsyms_lookup(unsigned long addr,
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
@@ -489,19 +494,15 @@ static int __sprint_symbol(char *buffer, unsigned long address,
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
index ef73ae7c89094..d6a74a5e1604f 100644
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
+			ret = strlcpy(namebuf, sym, KSYM_NAME_LEN - 1);
 	}
+
 	preempt_enable();
 
 	return ret;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 05c0024815bf9..bc0eed24a5873 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6965,7 +6965,7 @@ allocate_ftrace_mod_map(struct module *mod,
 	return mod_map;
 }
 
-static const char *
+static int
 ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
 			   unsigned long addr, unsigned long *size,
 			   unsigned long *off, char *sym)
@@ -6986,21 +6986,18 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
 			*size = found_func->size;
 		if (off)
 			*off = addr - found_func->ip;
-		if (sym)
-			strscpy(sym, found_func->name, KSYM_NAME_LEN);
-
-		return found_func->name;
+		return strlcpy(sym, found_func->name, KSYM_NAME_LEN);
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

