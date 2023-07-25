Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C257623C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGYUm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjGYUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C61BC8;
        Tue, 25 Jul 2023 13:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67ACF6187D;
        Tue, 25 Jul 2023 20:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D5FC433C7;
        Tue, 25 Jul 2023 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690317720;
        bh=O/gvRDbAo1+qfKzhqxHNd4QCmaOLg095hAsSaLBvB7A=;
        h=From:To:Cc:Subject:Date:From;
        b=U96/uUjVNsF5ZPDGSmjhAi26ndBRdrgmoQUvoxGViq/F45bF6m/0ghSMSUlD3rsyH
         SuIdyXiKVU3xtfMkbawyJa8Dc7JX2Z8BSukRNX0olo4fK01QMrP13nvgAQyqO6zWrY
         il9tCMbFbgVhzSawQ6AxivfEkOJYU7/f3RgXs7gomFRGoTOjBnMTUtKjY+GM6hAxxB
         qLfaHj1zxDlC5z7ghFeTZxLrVaxFbJpuBXH3AG2CYEu2JaK4hBQb91+UCT3sY+S+sw
         QLF98JAaL1/BD+kNNjXGNc1XKB9nTGw/t65+Rg6+MtGp744za8emZA6qMpelK7Gd40
         joGdvGkdGhBBA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        David Vernet <void@manifault.com>,
        Kees Cook <keescook@chromium.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] [v4] bpf: fix bpf_probe_read_kernel prototype mismatch
Date:   Tue, 25 Jul 2023 22:41:12 +0200
Message-Id: <20230725204149.3411961-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

bpf_probe_read_kernel() has a __weak definition in core.c and another
definition with an incompatible prototype in kernel/trace/bpf_trace.c,
when CONFIG_BPF_EVENTS is enabled.

Since the two are incompatible, there cannot be a shared declaration in
a header file, but the lack of a prototype causes a W=1 warning:

kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_read_kernel' [-Werror=missing-prototypes]

On 32-bit architectures, the local prototype

u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)

passes arguments in other registers as the one in bpf_trace.c

BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
            const void *, unsafe_ptr)

which uses 64-bit arguments in pairs of registers.

As both versions of the function are fairly simple and only really
differ in one line, just move them into a header file as an inline
function that does not add any overhead for the bpf_trace.c callers
and actually avoids a function call for the other one.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/ac25cb0f-b804-1649-3afb-1dc6138c2716@iogearbox.net/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--
v4: rewrite again to use a shared inline helper
v3: clarify changelog text further.
v2: rewrite completely to fix the mismatch.
---
 include/linux/bpf.h      | 12 ++++++++++++
 kernel/bpf/core.c        | 10 ++--------
 kernel/trace/bpf_trace.c | 11 -----------
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ceaa8c23287fc..abe75063630b8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2661,6 +2661,18 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
+static __always_inline int
+bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
+{
+	int ret = -EFAULT;
+
+	if (IS_ENABLED(CONFIG_BPF_EVENTS))
+		ret = copy_from_kernel_nofault(dst, unsafe_ptr, size);
+	if (unlikely(ret < 0))
+		memset(dst, 0, size);
+	return ret;
+}
+
 void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
 			  struct btf_mod_pair *used_btfs, u32 len);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dd70c58c9d3a3..9cdf53bfb8bd3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1634,12 +1634,6 @@ bool bpf_opcode_in_insntable(u8 code)
 }
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
-{
-	memset(dst, 0, size);
-	return -EFAULT;
-}
-
 /**
  *	___bpf_prog_run - run eBPF program on a given context
  *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
@@ -1930,8 +1924,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
 		CONT;							\
 	LDX_PROBE_MEM_##SIZEOP:						\
-		bpf_probe_read_kernel(&DST, sizeof(SIZE),		\
-				      (const void *)(long) (SRC + insn->off));	\
+		bpf_probe_read_kernel_common(&DST, sizeof(SIZE),	\
+			      (const void *)(long) (SRC + insn->off));	\
 		DST = *((SIZE *)&DST);					\
 		CONT;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c92eb8c6ff08d..83bde2475ae54 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -223,17 +223,6 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static __always_inline int
-bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
-{
-	int ret;
-
-	ret = copy_from_kernel_nofault(dst, unsafe_ptr, size);
-	if (unlikely(ret < 0))
-		memset(dst, 0, size);
-	return ret;
-}
-
 BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
 	   const void *, unsafe_ptr)
 {
-- 
2.39.2

