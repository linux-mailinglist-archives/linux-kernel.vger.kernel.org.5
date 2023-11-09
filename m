Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE87E7571
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345611AbjKJABG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345533AbjKJAAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:49 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CC2479A;
        Thu,  9 Nov 2023 16:00:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2802e5ae23bso1362833a91.2;
        Thu, 09 Nov 2023 16:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574432; x=1700179232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsFJzlGzUeWGTriQqSvj7eYER8wcSmZ2Yq/gVw4ZyQA=;
        b=nCXC+dv8dUNB9LBnBeq8kVF9FgkAbVha+Qg+rqDaEgNdQOny9wcoACAntOSWxJUmJI
         YMYOPzBIoP46dLZhdOexDXocR9TmnBcE1YhqT6kh6OpVPDdB2VBMAcDl+RD6vQFRi4rZ
         w19pxt0ktM4/lwXVVjClJxFCkSJNxjl/vIaWRcR6jXGg4OH7GU3wmJ7e5jiZv7Jf8Fj0
         H4uWlLVQNMCfZhO1do7df3fLQCfS8oX91lbZRTRYCrswMwkl4wHprn8tBdSo16iavOP7
         wprLXtBWJRCuVP4EVdlepmVIozqe7kW4r2+VqUzdENjgJbEkGXx/SELkobJXl0cuX/HB
         3+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574432; x=1700179232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JsFJzlGzUeWGTriQqSvj7eYER8wcSmZ2Yq/gVw4ZyQA=;
        b=DFYao75r2FGK60kT3aAq9kEK4JneoKUmJ/UR79hF1JaB5CzHAS1UgOE8RfuyliDzXO
         slcYb7BTJcMf0z1RcZ3mfmqN3BxBZxKaGypx5mYCBbqygbjDmp+Xkegg5pHjNdp/vai2
         BscsXQvIMZK+qmhYoyQA6M1TM2+EByHuMoQy7gpZSHFN+EkwY/0yk0CXIxx1C8L2UoEU
         wXP25ii5CZMlOCpTzQ9qbam8loUKQn+PytClPfu8gGlKm6GqFFRcbBRURUx4udFNDfmy
         11yV4+Y0TzXw+AsEBWgsTNDEsct1G5ZT0EZW4THQ81mIAiVUd1wvbCE9bqg69eCjetho
         ZlXg==
X-Gm-Message-State: AOJu0YwnYFkfigwJuth6lNR3SdmqxmxcIEjVF6XtOjT78ojY6PurhugU
        9EnspjLfD02LLOGy9bmtfRc=
X-Google-Smtp-Source: AGHT+IFirRse62PG8X2PJJ1HHbgaFZizcHsEsgMZ5W8b42eEn1+qWYNVjSPs2XtCCV39UNCtWrdQDg==
X-Received: by 2002:a17:90b:4c10:b0:280:c0:9d3f with SMTP id na16-20020a17090b4c1000b0028000c09d3fmr3410142pjb.34.1699574432339;
        Thu, 09 Nov 2023 16:00:32 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:32 -0800 (PST)
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 11/52] perf dwarf-regs: Add get_dwarf_regnum()
Date:   Thu,  9 Nov 2023 15:59:30 -0800
Message-ID: <20231110000012.3538610-12-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.42.0.869.gea05f2083d-goog

