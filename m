Return-Path: <linux-kernel+bounces-86680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFCC86C8EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A28DB2690B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43637CF2C;
	Thu, 29 Feb 2024 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TN3uA1De"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883657CF17
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208784; cv=none; b=DB7rDOPWCoKcVZmuOTdIHpf/e41BsrT3ZL0LJ5FxqjUivv5T823NVr9aAIiW7/6BUyxj0XIOE3z1kMPIJt+nAWZWgzFdlZEXwc5dHrGMkOJ8dl3vEvMBnsIqVCQRA9nm1gBmfz9KtFQTG/cSslrS+FRKh3dbO0anwzGVCYzrz18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208784; c=relaxed/simple;
	bh=34IdpbAf+wjUKm2HzMwrxe5a3uRKgSciI+ZBBcTspqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIYoC3KdOA49NnWmiQiqO7aFDhAui+o8Scoe5pBd0Ge3ck71tG+iUlKiek2szIZXgSPb1t+wwCmwtipL1LL/c36wHOYM73YVlkMuNdGr6lqd1bj7jsOF4o2nIZbmvLrNsQGxiFykwTIDRxrkWBLl4W51MdsXI15puiQaTByqNU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TN3uA1De; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e162b1b71so104300f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709208781; x=1709813581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXXIgfsi20sfR9R1Bl8KEYowaEbmYUeJCudNzsi7ozU=;
        b=TN3uA1DekVqj8qF88dNT+PsZwkVQKq8EgfB70aUmhdxm3VJA38QiPANoyMcU/cwoAI
         mEYnwVN00jCALtwPSC9S6D07gmchdu8gCtGkYSFikY891YOVZhVkF0X9fkmv/23Cr5oz
         gIfe6vtQ384X2ScdV8vnMwuW7alEFgTPRkiKNeWc+j4Q82AX0Tsh/kse/cIwLz0mmmnM
         hZvOrTo160voOPrNWL79YMDCf4VqkPJf86d5/D3js2BbExUg+Nkw5UlPfttPNrMa1sKg
         sRW4u3xq6y9nyyLyDZGwjfxXQhBMSWc+rYqGnhu1qwdw+cVKK4v7cCZUEHrzmEOK5mO+
         FlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709208781; x=1709813581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXXIgfsi20sfR9R1Bl8KEYowaEbmYUeJCudNzsi7ozU=;
        b=nQHyZGJgJCBH+m70LZkiSo1oqZdZwpiDByMyChSL6ycF7Tw8JiGA+jtavsz+Kp3GQT
         7mEgiYzVl5Z9Jtlv/RHqPdB98knZfX58+XVHG+2U24QYyOEZBhak+WgqNKKvfvS+E367
         GACHDqubIEJvGPkVME07jmJQbC1OMfVY11WqKvCiko5xi5uv7CPFiK1PyH9WEazCN6wg
         eJWMlcijd3KKdDftbWmLjmscb0DUyv2DHnrG67p3sZS1hBT9CJKRwE/5mIa9oZQeYWU/
         OdKr3+VTWW6L6I1CVxhkaAMyNBdZjuXH3PvNi4F78qA6+F7ME2z05mGDZQGrid3he6bn
         uSMA==
X-Forwarded-Encrypted: i=1; AJvYcCWF6GYTFO965BikBolQYR8FRNp3kOM0/cTmx6TanAssfX4zc9GTUJ4qsrB+6BrMH/a5d3FGUE4RhL+bbw1R7b9xuNzIDq8Hdi815ci/
X-Gm-Message-State: AOJu0YxA729gL2gV8HcUizNI7u0nj6BAA29f0hq+3uQtmhoOqki4OPUK
	qoA8c8MoMj47UFP7sHwB787xwkazgbXV7i8Xxvt6G0wYes283fgugKYp5WEuIrE=
X-Google-Smtp-Source: AGHT+IFT0YxcYDi/LR7DsMQ2nyJ8fcVSxOS6c8osyWaid2ac8gnJzVJrwYje6jjFdkyZbXRi/WxigQ==
X-Received: by 2002:adf:f3c6:0:b0:33b:62c0:6181 with SMTP id g6-20020adff3c6000000b0033b62c06181mr1262715wrp.42.1709208780842;
        Thu, 29 Feb 2024 04:13:00 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id r3-20020adfca83000000b0033d2ae84fafsm1605970wrh.52.2024.02.29.04.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:13:00 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 2/2] riscv: Fix text patching when IPI are used
Date: Thu, 29 Feb 2024 13:10:56 +0100
Message-Id: <20240229121056.203419-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229121056.203419-1-alexghiti@rivosinc.com>
References: <20240229121056.203419-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now, we use stop_machine() to patch the text and when we use IPIs for
remote icache flushes (which is emitted in patch_text_nosync()), the system
hangs.

So instead, make sure every CPU executes the stop_machine() patching
function and emit a local icache flush there.

Co-developed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/ftrace.c     | 44 ++++++++++++++++++++++++++++++----
 arch/riscv/kernel/patch.c      | 16 +++++++++----
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
index e88b52d39eac..9f5d6e14c405 100644
--- a/arch/riscv/include/asm/patch.h
+++ b/arch/riscv/include/asm/patch.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_RISCV_PATCH_H
 #define _ASM_RISCV_PATCH_H
 
+int patch_insn_write(void *addr, const void *insn, size_t len);
 int patch_text_nosync(void *addr, const void *insns, size_t len);
 int patch_text_set_nosync(void *addr, u8 c, size_t len);
 int patch_text(void *addr, u32 *insns, int ninsns);
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index f5aa24d9e1c1..4f4987a6d83d 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -8,6 +8,7 @@
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
 #include <linux/memory.h>
+#include <linux/stop_machine.h>
 #include <asm/cacheflush.h>
 #include <asm/patch.h>
 
@@ -75,8 +76,7 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 		make_call_t0(hook_pos, target, call);
 
 	/* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
-	if (patch_text_nosync
-	    ((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
+	if (patch_insn_write((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -88,7 +88,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	make_call_t0(rec->ip, addr, call);
 
-	if (patch_text_nosync((void *)rec->ip, call, MCOUNT_INSN_SIZE))
+	if (patch_insn_write((void *)rec->ip, call, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -99,7 +99,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 {
 	unsigned int nops[2] = {NOP4, NOP4};
 
-	if (patch_text_nosync((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
+	if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -134,6 +134,42 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 
 	return ret;
 }
+
+struct ftrace_modify_param {
+	int command;
+	atomic_t cpu_count;
+};
+
+static int __ftrace_modify_code(void *data)
+{
+	struct ftrace_modify_param *param = data;
+
+	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
+		ftrace_modify_all_code(param->command);
+		/*
+		 * Make sure the patching store is effective *before* we
+		 * increment the counter which releases all waiting CPUs
+		 * by using the release variant of atomic increment. The
+		 * release pairs with the call to local_flush_icache_all()
+		 * on the waiting CPU.
+		 */
+		atomic_inc_return_release(&param->cpu_count);
+	} else {
+		while (atomic_read(&param->cpu_count) <= num_online_cpus())
+			cpu_relax();
+	}
+
+	local_flush_icache_all();
+
+	return 0;
+}
+
+void arch_ftrace_update_code(int command)
+{
+	struct ftrace_modify_param param = { command, ATOMIC_INIT(0) };
+
+	stop_machine(__ftrace_modify_code, &param, cpu_online_mask);
+}
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 0b5c16dfe3f4..9a1bce1adf5a 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -188,7 +188,7 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
 }
 NOKPROBE_SYMBOL(patch_text_set_nosync);
 
-static int patch_insn_write(void *addr, const void *insn, size_t len)
+int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	size_t patched = 0;
 	size_t size;
@@ -232,15 +232,23 @@ static int patch_text_cb(void *data)
 	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
 		for (i = 0; ret == 0 && i < patch->ninsns; i++) {
 			len = GET_INSN_LENGTH(patch->insns[i]);
-			ret = patch_text_nosync(patch->addr + i * len,
-						&patch->insns[i], len);
+			ret = patch_insn_write(patch->addr + i * len, &patch->insns[i], len);
 		}
-		atomic_inc(&patch->cpu_count);
+		/*
+		 * Make sure the patching store is effective *before* we
+		 * increment the counter which releases all waiting CPUs
+		 * by using the release variant of atomic increment. The
+		 * release pairs with the call to local_flush_icache_all()
+		 * on the waiting CPU.
+		 */
+		atomic_inc_return_release(&patch->cpu_count);
 	} else {
 		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
 			cpu_relax();
 	}
 
+	local_flush_icache_all();
+
 	return ret;
 }
 NOKPROBE_SYMBOL(patch_text_cb);
-- 
2.39.2


