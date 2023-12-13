Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E541280FC13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377853AbjLMANe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377751AbjLMAN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:13:26 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5EDBC;
        Tue, 12 Dec 2023 16:13:30 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7b7039d30acso365328039f.3;
        Tue, 12 Dec 2023 16:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426410; x=1703031210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yE8tDVZHn5Q5IZE7sgzYyBr3j80GHRhr26uqjreUGM=;
        b=AIXJgCZrV2whvpPckxYKmj5a7FxRulAE1yMGD1ynu8KZnXITmN269U5oa6s86wHeZk
         bXvWyeRRv/4o3Q1APWQt97qyY896g/dSM3wXhWGv38r6Hga4208CfC5Xf7cpUF8qruFK
         Ed7Cdp6g63QifG9DMcyCsrPntHsYt+WRon7gpIrgB9kUykYe91SIwFLzSuXJAavQ33AG
         NuofKgjHbxrW1Mxoinuv/qvqvmHHKWY6nAUrAokRGvPbpdUkkxS7ttwGvNY/QFXO9DJ6
         sAdorHLdeO1k4UO4uEts5NTVenCZo/Fc9LMjZdv+N1HF7G8GZzb9iyymEW8ttF/Vsof0
         BCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426410; x=1703031210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1yE8tDVZHn5Q5IZE7sgzYyBr3j80GHRhr26uqjreUGM=;
        b=G8Ty/AdkU4ZTDtQ6IngdiVRHCVr/OcGCqRqd5HHlD6DM/+v0DxRGAzDtLwtZR3xY/z
         hnVwHcK2o5BP4SxnQEJXqMc+6luP8obUxcKH9w2gnuk6U5mILpP1yT4S87pC/iMGbMQe
         +QllHGLA9WZA6MXHbXtZASlgb/oqXjHiT4OQrmoEAa75U5CHEjrdDdpxz8hKJKMOFcK3
         8lFnLGCb5grimgaLGszO2XLjnRHAu8cfc9cvu3Px4z1PwrXx+XwxjExXWqOXqqNHCOw/
         J+ZptovqUpaK1ENExSN4bxYps913Jo9qiItFfcxfuCeUotMFdbA33KCgcUjYiNMpnDBh
         gqAg==
X-Gm-Message-State: AOJu0YxHnH8yqIwKWhx5lJDiF0rM8hAk8IZnspY7LOh53G3Y3h7Y6TxW
        iH27W4Gahnjc3xtbS+tY7yA=
X-Google-Smtp-Source: AGHT+IHCOUHbghffD9nTh2liqpDCfNSN3Nu/R/yotPPFOFlBFCd5bu6rSoH70raZS37aoXS7kG/nSg==
X-Received: by 2002:a05:6e02:ef3:b0:35d:7ce5:3a55 with SMTP id j19-20020a056e020ef300b0035d7ce53a55mr7544753ilk.121.1702426409690;
        Tue, 12 Dec 2023 16:13:29 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:28 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 02/17] perf dwarf-regs: Add get_dwarf_regnum()
Date:   Tue, 12 Dec 2023 16:13:08 -0800
Message-ID: <20231213001323.718046-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213001323.718046-1-namhyung@kernel.org>
References: <20231213001323.718046-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_dwarf_regnum() returns a DWARF register number from a register
name string according to the psABI.  Also add two pseudo encodings of
DWARF_REG_PC which is a register that are used by PC-relative addressing
and DWARF_REG_FB which is a frame base register.  They need to be
handled in a special way.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/util/dwarf-regs.c | 38 +++++++++++++++++++++++++++
 tools/perf/util/dwarf-regs.c          | 34 ++++++++++++++++++++++++
 tools/perf/util/include/dwarf-regs.h  | 19 ++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/tools/perf/arch/x86/util/dwarf-regs.c b/tools/perf/arch/x86/util/dwarf-regs.c
index 530934805710..399c4a0a29d8 100644
--- a/tools/perf/arch/x86/util/dwarf-regs.c
+++ b/tools/perf/arch/x86/util/dwarf-regs.c
@@ -113,3 +113,41 @@ int regs_query_register_offset(const char *name)
 			return roff->offset;
 	return -EINVAL;
 }
+
+struct dwarf_regs_idx {
+	const char *name;
+	int idx;
+};
+
+static const struct dwarf_regs_idx x86_regidx_table[] = {
+	{ "rax", 0 }, { "eax", 0 }, { "ax", 0 }, { "al", 0 },
+	{ "rdx", 1 }, { "edx", 1 }, { "dx", 1 }, { "dl", 1 },
+	{ "rcx", 2 }, { "ecx", 2 }, { "cx", 2 }, { "cl", 2 },
+	{ "rbx", 3 }, { "edx", 3 }, { "bx", 3 }, { "bl", 3 },
+	{ "rsi", 4 }, { "esi", 4 }, { "si", 4 }, { "sil", 4 },
+	{ "rdi", 5 }, { "edi", 5 }, { "di", 5 }, { "dil", 5 },
+	{ "rbp", 6 }, { "ebp", 6 }, { "bp", 6 }, { "bpl", 6 },
+	{ "rsp", 7 }, { "esp", 7 }, { "sp", 7 }, { "spl", 7 },
+	{ "r8", 8 }, { "r8d", 8 }, { "r8w", 8 }, { "r8b", 8 },
+	{ "r9", 9 }, { "r9d", 9 }, { "r9w", 9 }, { "r9b", 9 },
+	{ "r10", 10 }, { "r10d", 10 }, { "r10w", 10 }, { "r10b", 10 },
+	{ "r11", 11 }, { "r11d", 11 }, { "r11w", 11 }, { "r11b", 11 },
+	{ "r12", 12 }, { "r12d", 12 }, { "r12w", 12 }, { "r12b", 12 },
+	{ "r13", 13 }, { "r13d", 13 }, { "r13w", 13 }, { "r13b", 13 },
+	{ "r14", 14 }, { "r14d", 14 }, { "r14w", 14 }, { "r14b", 14 },
+	{ "r15", 15 }, { "r15d", 15 }, { "r15w", 15 }, { "r15b", 15 },
+	{ "rip", DWARF_REG_PC },
+};
+
+int get_arch_regnum(const char *name)
+{
+	unsigned int i;
+
+	if (*name != '%')
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(x86_regidx_table); i++)
+		if (!strcmp(x86_regidx_table[i].name, name + 1))
+			return x86_regidx_table[i].idx;
+	return -ENOENT;
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 69cfaa5953bf..5b7f86c0063f 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -5,9 +5,12 @@
  * Written by: Masami Hiramatsu <mhiramat@kernel.org>
  */
 
+#include <stdlib.h>
+#include <string.h>
 #include <debug.h>
 #include <dwarf-regs.h>
 #include <elf.h>
+#include <errno.h>
 #include <linux/kernel.h>
 
 #ifndef EM_AARCH64
@@ -68,3 +71,34 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine)
 	}
 	return NULL;
 }
+
+__weak int get_arch_regnum(const char *name __maybe_unused)
+{
+	return -ENOTSUP;
+}
+
+/* Return DWARF register number from architecture register name */
+int get_dwarf_regnum(const char *name, unsigned int machine)
+{
+	char *regname = strdup(name);
+	int reg = -1;
+	char *p;
+
+	if (regname == NULL)
+		return -EINVAL;
+
+	/* For convenience, remove trailing characters */
+	p = strpbrk(regname, " ,)");
+	if (p)
+		*p = '\0';
+
+	switch (machine) {
+	case EM_NONE:	/* Generic arch - use host arch */
+		reg = get_arch_regnum(regname);
+		break;
+	default:
+		pr_err("ELF MACHINE %x is not supported.\n", machine);
+	}
+	free(regname);
+	return reg;
+}
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 7d99a084e82d..01fb25a1150a 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -2,6 +2,9 @@
 #ifndef _PERF_DWARF_REGS_H_
 #define _PERF_DWARF_REGS_H_
 
+#define DWARF_REG_PC  0xd3af9c /* random number */
+#define DWARF_REG_FB  0xd3affb /* random number */
+
 #ifdef HAVE_DWARF_SUPPORT
 const char *get_arch_regstr(unsigned int n);
 /*
@@ -10,6 +13,22 @@ const char *get_arch_regstr(unsigned int n);
  * machine: ELF machine signature (EM_*)
  */
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine);
+
+int get_arch_regnum(const char *name);
+/*
+ * get_dwarf_regnum - Returns DWARF regnum from register name
+ * name: architecture register name
+ * machine: ELF machine signature (EM_*)
+ */
+int get_dwarf_regnum(const char *name, unsigned int machine);
+
+#else /* HAVE_DWARF_SUPPORT */
+
+static inline int get_dwarf_regnum(const char *name __maybe_unused,
+				   unsigned int machine __maybe_unused)
+{
+	return -1;
+}
 #endif
 
 #ifdef HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
-- 
2.43.0.472.g3155946c3a-goog

