Return-Path: <linux-kernel+bounces-144846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C28A4BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457F4B21A27
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E144086A;
	Mon, 15 Apr 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFBP8pBG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC8A40856;
	Mon, 15 Apr 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174027; cv=none; b=u3gU7zji3Xvkki/+klLCkLeBwNjH7QzyIb5QvC2FcyWr0+F919+vnTTXthvEJdFfA9TB81vrsjj2mMys/2W7xvO1ApvksA+bDGT0jSL1OXmExSUDmh3J2150t5pw4oYf2dqrE93Gq1XSdVLUtkdrTbt8tkAVG9ap5fpg5AJSOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174027; c=relaxed/simple;
	bh=KGMXVRe9D0M/sc/1ZnW83GzmCoySlNImlwaDcJDNcT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mhaf0P7jwlteKneSjwi1DnWANKc8aNajEW1jq6ixzPYPeSwrVFdgAKC9FDQKG70FKGSL/TRZ2KEu+x3FQdhXk5Ap9ZDCUIrFrSVfDhqUYytNHaLbqlwM8gp6awu6ILsH/1ljfWIwEO/+c10BOpOTEfkjxzc2wSxOcKVLHCW+pjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFBP8pBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADFBC113CC;
	Mon, 15 Apr 2024 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713174027;
	bh=KGMXVRe9D0M/sc/1ZnW83GzmCoySlNImlwaDcJDNcT8=;
	h=From:To:Cc:Subject:Date:From;
	b=SFBP8pBGxa6Ixu9taPD8K49/vtUW2x4KiqkUrloKZYoqS13nsTHgodJqgpg7yN1dT
	 4hWTesubaI6A2v2QDp2upO4zJdd9XiZQcNkXvJWnERWH4NihLIsJjidldtM6Lt5Bsr
	 M/YhPXbFcfsOiDwNGZhdqJyS8DmCgilq15yPh17qHIsVUHQFsK8iNj4kfKOz7yNKqo
	 yf4lfksxirH+AC1CzUU1IkhckoK5MJT0KAhX3s75st2L5A1Q7Tp9sM2DwxWqDQ/Wqo
	 7y0NeigNbu1yTreVz0frLMc/ai/uNI8Fv1mrF7E002t1ow3Ak2rkSoItGH9qCfVuGq
	 WQS3Ev98NUlhA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>
Subject: [PATCH for-next v2] tracing/kprobes: Add symbol counting check when module loads
Date: Mon, 15 Apr 2024 18:40:23 +0900
Message-Id: <171317402290.228024.13465974857683559752.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Check the number of probe target symbols in the target module when
the module is loaded. If the probe is not on the unique name symbols
in the module, it will be rejected at that point.

Note that the symbol which has a unique name in the target module,
it will be accepted even if there are same-name symbols in the
kernel or other modules,

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Updated from last October post, which was dropped by test failure:
    https://lore.kernel.org/linux-trace-kernel/169854904604.132316.12500381416261460174.stgit@devnote2/
 Changes in v2:
  - Fix to skip checking uniqueness if the target module is not loaded.
  - Fix register_module_trace_kprobe() to pass correct symbol name.
  - Fix to call __register_trace_kprobe() from module callback.
---
 kernel/trace/trace_kprobe.c |  125 ++++++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 44 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c68d4e830fbe..0113afe2662d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -670,6 +670,21 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	return ret;
 }
 
+static int validate_module_probe_symbol(const char *modname, const char *symbol);
+
+static int register_module_trace_kprobe(struct module *mod, struct trace_kprobe *tk)
+{
+	const char *p;
+	int ret = 0;
+
+	p = strchr(trace_kprobe_symbol(tk), ':');
+	if (p)
+		ret = validate_module_probe_symbol(module_name(mod), p + 1);
+	if (!ret)
+		ret = __register_trace_kprobe(tk);
+	return ret;
+}
+
 /* Module notifier call back, checking event on the module */
 static int trace_kprobe_module_callback(struct notifier_block *nb,
 				       unsigned long val, void *data)
@@ -688,7 +703,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 		if (trace_kprobe_within_module(tk, mod)) {
 			/* Don't need to check busy - this should have gone. */
 			__unregister_trace_kprobe(tk);
-			ret = __register_trace_kprobe(tk);
+			ret = register_module_trace_kprobe(mod, tk);
 			if (ret)
 				pr_warn("Failed to re-register probe %s on %s: %d\n",
 					trace_probe_name(&tk->tp),
@@ -729,17 +744,68 @@ static int count_mod_symbols(void *data, const char *name, unsigned long unused)
 	return 0;
 }
 
-static unsigned int number_of_same_symbols(char *func_name)
+static unsigned int number_of_same_symbols(const char *mod, const char *func_name)
 {
 	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
 
-	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
+	if (!mod)
+		kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
 
-	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
+	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
 
 	return ctx.count;
 }
 
+static int validate_module_probe_symbol(const char *modname, const char *symbol)
+{
+	unsigned int count = number_of_same_symbols(modname, symbol);
+
+	if (count > 1) {
+		/*
+		 * Users should use ADDR to remove the ambiguity of
+		 * using KSYM only.
+		 */
+		return -EADDRNOTAVAIL;
+	} else if (count == 0) {
+		/*
+		 * We can return ENOENT earlier than when register the
+		 * kprobe.
+		 */
+		return -ENOENT;
+	}
+	return 0;
+}
+
+static int validate_probe_symbol(char *symbol)
+{
+	struct module *mod = NULL;
+	char *modname = NULL, *p;
+	int ret = 0;
+
+	p = strchr(symbol, ':');
+	if (p) {
+		modname = symbol;
+		symbol = p + 1;
+		*p = '\0';
+		/* Return 0 (defer) if the module does not exist yet. */
+		rcu_read_lock_sched();
+		mod = find_module(modname);
+		if (mod && !try_module_get(mod))
+			mod = NULL;
+		rcu_read_unlock_sched();
+		if (!mod)
+			goto out;
+	}
+
+	ret = validate_module_probe_symbol(modname, symbol);
+out:
+	if (p)
+		*p = ':';
+	if (mod)
+		module_put(mod);
+	return ret;
+}
+
 static int trace_kprobe_entry_handler(struct kretprobe_instance *ri,
 				      struct pt_regs *regs);
 
@@ -863,6 +929,14 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
 			goto parse_error;
 		}
+		ret = validate_probe_symbol(symbol);
+		if (ret) {
+			if (ret == -EADDRNOTAVAIL)
+				trace_probe_log_err(0, NON_UNIQ_SYMBOL);
+			else
+				trace_probe_log_err(0, BAD_PROBE_ADDR);
+			goto parse_error;
+		}
 		if (is_return)
 			ctx.flags |= TPARG_FL_RETURN;
 		ret = kprobe_on_func_entry(NULL, symbol, offset);
@@ -875,31 +949,6 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		}
 	}
 
-	if (symbol && !strchr(symbol, ':')) {
-		unsigned int count;
-
-		count = number_of_same_symbols(symbol);
-		if (count > 1) {
-			/*
-			 * Users should use ADDR to remove the ambiguity of
-			 * using KSYM only.
-			 */
-			trace_probe_log_err(0, NON_UNIQ_SYMBOL);
-			ret = -EADDRNOTAVAIL;
-
-			goto error;
-		} else if (count == 0) {
-			/*
-			 * We can return ENOENT earlier than when register the
-			 * kprobe.
-			 */
-			trace_probe_log_err(0, BAD_PROBE_ADDR);
-			ret = -ENOENT;
-
-			goto error;
-		}
-	}
-
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
@@ -1817,21 +1866,9 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	char *event;
 
 	if (func) {
-		unsigned int count;
-
-		count = number_of_same_symbols(func);
-		if (count > 1)
-			/*
-			 * Users should use addr to remove the ambiguity of
-			 * using func only.
-			 */
-			return ERR_PTR(-EADDRNOTAVAIL);
-		else if (count == 0)
-			/*
-			 * We can return ENOENT earlier than when register the
-			 * kprobe.
-			 */
-			return ERR_PTR(-ENOENT);
+		ret = validate_probe_symbol(func);
+		if (ret)
+			return ERR_PTR(ret);
 	}
 
 	/*


