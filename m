Return-Path: <linux-kernel+bounces-61075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7290E850CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978451C21252
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823A4BE6E;
	Mon, 12 Feb 2024 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="d6e9FAYj"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F385B747F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706534; cv=none; b=apjWj3RpqXZ2VjkjBcMvVofWcpGHjIxYTn00Mmd8sXMqlsD+13oAeOdCutoHZh7o4Lbt9iXh8SB6hn6bYmuJdQ/OF1xhsUnyl8P1J6iT65md6mPESyI7QMKQC0UeKkujXXUliPfxX2kHFTvQe5rESdGmP/Bwp54/nVsbVoWTlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706534; c=relaxed/simple;
	bh=7b51flB5NoWMAjsCNRFa3fvRfjAAoQvzjuCZ5CXigcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGxLsZoqQprgymTqV0pTHGuo8GvqC4XVE0VwnQfzee0w7l0Uaee3k8P4TPKr7yKCedNEPzmD3OpP5/okpQSwIobQgmdA9zuCE8e0ijtDlyudVn994+sB0VOdmKRe6/y+sO6MV77YCWjwmae9cO3yMd83AvMxq5iUZ4EYeiF1Ess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=d6e9FAYj; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-785d5e6c87cso46968685a.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707706532; x=1708311332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3jsL0pNyfGhwaczyVRVtmiz/UJ7sxnmY3C1nRyOzZg=;
        b=d6e9FAYj70r6vTzZCrdhlUuY6UyjH6pzaAbExIMCgaMLRCT+odisfpv2YZQ423K8lF
         X04tg6VB+4+ccMOYOQn/idjcJagiwONzKpi0qpQjEbNgFtbhnhY9u2urs+WdYA0POuUS
         T9K/hLU9erlZTfTw+D9cgzPtBuBDBbAg2J+37tuPss9RbZ1o0o6YehYP8PxQwJNS04uh
         TifzPUc4awNFXT/8dSpbpHZLWcGMzi4lzcHV6H1MPGIHtHvKx6u+MqSZPmaebby0xlrb
         /qu3IJtmhRc+o638Or/VClSSSRcsCVLXo/f3MkvwMeP16ix5soE9nTtCQUEAOEc4klPl
         YbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707706532; x=1708311332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3jsL0pNyfGhwaczyVRVtmiz/UJ7sxnmY3C1nRyOzZg=;
        b=ke9NhIpd+2xqgvm133PA4JisPDFubFSuBP+RsYK5Y/R3KOnMbKCU/WHEluxtOTmIF3
         n/Y3APMBetrBgt8VRStBS8L2UYxt/bB1Anon4JanoBllUrxyZjAJvAoW2kiickJeoGmh
         W9wffhZNn5iGn9caG22wxip/WR+PzuTsHZvfD+zAkXwmIr1fLb2Ym4+mwbzKx1ONB15T
         o4voUw6mzBlgKcYOCxGrDlr3TUdTMPBlyxJWjfgAqNuvG8WdkyIAOKIG0S+Vy0N7iqLK
         wyig4VBijkiQUzwS4q4UryW8raOp3Xc6gXV9cpKL01NMDLFzcj1KTAo6P3xYsNXxQ2GC
         yFtg==
X-Gm-Message-State: AOJu0YzJdNv2IkKhuEHuNwycer9aUIn6MInqJ2QgntYp5nTDif02gRMg
	Cwp10KVWNL0oQkTUIIJp3rfwYkdw3FTBwSVriuii802irtcQpc3PVYfj5vH1jvI=
X-Google-Smtp-Source: AGHT+IFJ/32sYPLw6KUWw7AmSfnLopVclPa2F2gsTA8+qbyJLtPgqsEkwvhed221ymOVdWewDwFSuA==
X-Received: by 2002:ae9:e905:0:b0:785:cb7c:8554 with SMTP id x5-20020ae9e905000000b00785cb7c8554mr5700867qkf.14.1707706531837;
        Sun, 11 Feb 2024 18:55:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWy6qXPXNq8zE7X4aCqdUsGkzZSwcuXpP36Aqhia9FpyMYlSA46fzz3fov1YRllNfE3l79P88bKmGeSWd+kTI+Bsjos0Hy63ENvtL9y4gwO8qWroxFx2r63uA7nX8YAmOUoULqR8j1rZ9/GKNNLLoqSM22Fxp4u5cvUscnfQytng3hHRougX121AExZPirXPuRcnFvb3QyZVPOBI1Wlvt4AwcFcltkbtfd46crhuW1wpeiDCtayROslVQJRF68X9aZUTc6/tizcK4QUVA==
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001d9af77893esm4906443plb.58.2024.02.11.18.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:55:31 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/7] riscv: jump_label: Batch icache maintenance
Date: Sun, 11 Feb 2024 18:55:12 -0800
Message-ID: <20240212025529.1971876-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212025529.1971876-1-samuel.holland@sifive.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to the batched version of the jump label update functions so
instruction cache maintenance is deferred until the end of the update.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/jump_label.h |  2 ++
 arch/riscv/include/asm/patch.h      |  1 +
 arch/riscv/kernel/jump_label.c      | 16 ++++++++++++----
 arch/riscv/kernel/patch.c           |  2 +-
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
index 4a35d787c019..6290b26f4a14 100644
--- a/arch/riscv/include/asm/jump_label.h
+++ b/arch/riscv/include/asm/jump_label.h
@@ -12,6 +12,8 @@
 #include <linux/types.h>
 #include <asm/asm.h>
 
+#define HAVE_JUMP_LABEL_BATCH
+
 #define JUMP_LABEL_NOP_SIZE 4
 
 static __always_inline bool arch_static_branch(struct static_key * const key,
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
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index e6694759dbd0..11ad789c60c6 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -9,13 +9,14 @@
 #include <linux/memory.h>
 #include <linux/mutex.h>
 #include <asm/bug.h>
+#include <asm/cacheflush.h>
 #include <asm/patch.h>
 
 #define RISCV_INSN_NOP 0x00000013U
 #define RISCV_INSN_JAL 0x0000006fU
 
-void arch_jump_label_transform(struct jump_entry *entry,
-			       enum jump_label_type type)
+bool arch_jump_label_transform_queue(struct jump_entry *entry,
+				     enum jump_label_type type)
 {
 	void *addr = (void *)jump_entry_code(entry);
 	u32 insn;
@@ -24,7 +25,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
 		long offset = jump_entry_target(entry) - jump_entry_code(entry);
 
 		if (WARN_ON(offset & 1 || offset < -524288 || offset >= 524288))
-			return;
+			return true;
 
 		insn = RISCV_INSN_JAL |
 			(((u32)offset & GENMASK(19, 12)) << (12 - 12)) |
@@ -36,6 +37,13 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	}
 
 	mutex_lock(&text_mutex);
-	patch_text_nosync(addr, &insn, sizeof(insn));
+	patch_insn_write(addr, &insn, sizeof(insn));
 	mutex_unlock(&text_mutex);
+
+	return true;
+}
+
+void arch_jump_label_transform_apply(void)
+{
+	flush_icache_all();
 }
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 37e87fdcf6a0..bccd9ed04a05 100644
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
-- 
2.43.0


