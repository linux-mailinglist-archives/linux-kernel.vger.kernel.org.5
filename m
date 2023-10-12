Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1E17C636F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377186AbjJLDwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377020AbjJLDvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:51:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC55DD;
        Wed, 11 Oct 2023 20:51:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso4540375ad.3;
        Wed, 11 Oct 2023 20:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082686; x=1697687486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgmQ5z7I08IIuyO3b0o16ThTHSJVHyVNZfchHy73NpU=;
        b=h19z0eyTr7Rt/xhpgrI30p/cM6kH7OXYgetaBmkePX0h6S619uXV3DI0rmcTbjmsN7
         xYARZiGsifMlzHBF5iHSY995LTWsSSXJQ0hETwkHTuIjb07XgSDz8ZVvbqJXme4+J0LM
         XW81FFzOObp+f/MjT7hzeJ1KpT8IiU1WabjddIN8GiCr/6Ps+Xd/kX2ziT2a1Aq2d05G
         +teAohyskn04ouASLS3mk1EdU9V2pUNW+OrS+LdDkU2HuU8dyyL1MsoZj0k6CNZO2rWo
         qQoX55CPd02PC+XujP6sjLT6tMYwqH3+4YOB2SPd46mNCAtE+TMeEjl87U8kyIYKvJ+M
         kDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082686; x=1697687486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XgmQ5z7I08IIuyO3b0o16ThTHSJVHyVNZfchHy73NpU=;
        b=nAI0xpFtn08ZiZnTxzc0NNEYb+2KAh/LSqtyELZOMDaFz1y4AeGaBQ6BKJAUyRg7m1
         B1fBehy9JjpkZlfca/tLi8UR39IXsjc+VMS9IDUYLkEKzhPBoUhNly7F/Ov/z357Tx3U
         JElBHWW6r3Jmr9Txr9BMdLHpc9BxRlgE3rDxeVh3DHVxOfg8tP0XgPhO9Jw3DD+dnCxo
         fqr01gBznN+akp7mrC2bXU6JKNuzNGhycGebWNtv+4WiPt5V5d+0Qxbsh8myzByeBW3t
         wJHBsyFUyffJfVSJ0ZtXeaPMI8aQ9O8cNeDROYh00Kem3IRyiEcXnPwqc0NuJ22lPj3c
         etxw==
X-Gm-Message-State: AOJu0YxllBa1cMV5Tmvr5443dbM4nAcOxUezBywgXhRieEig75bCdzyY
        F/5wvQD8DIOgQcCSMcR0Dhc=
X-Google-Smtp-Source: AGHT+IEfN/7o80IKkOr3BKCmUuBcSLZpDzoGm8qmkwAWmp5kUkK9Nl48yVkHeNZg0kQGELWC16EDeQ==
X-Received: by 2002:a17:902:b48c:b0:1c0:a5c9:e072 with SMTP id y12-20020a170902b48c00b001c0a5c9e072mr18396658plr.11.1697082686553;
        Wed, 11 Oct 2023 20:51:26 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:26 -0700 (PDT)
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
Subject: [PATCH 09/48] perf dwarf-regs: Add get_dwarf_regnum()
Date:   Wed, 11 Oct 2023 20:50:32 -0700
Message-ID: <20231012035111.676789-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
 tools/perf/util/dwarf-regs.c          | 33 +++++++++++++++++++++++
 tools/perf/util/include/dwarf-regs.h  | 11 ++++++++
 3 files changed, 82 insertions(+)

diff --git a/tools/perf/arch/x86/util/dwarf-regs.c b/tools/perf/arch/x86/util/dwarf-regs.c
index 530934805710..79835b897cae 100644
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
+		return -1;
+
+	for (i = 0; i < ARRAY_SIZE(x86_regidx_table); i++)
+		if (!strcmp(x86_regidx_table[i].name, name + 1))
+			return x86_regidx_table[i].idx;
+	return -1;
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 69cfaa5953bf..28d786c7df55 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -5,6 +5,8 @@
  * Written by: Masami Hiramatsu <mhiramat@kernel.org>
  */
 
+#include <stdlib.h>
+#include <string.h>
 #include <debug.h>
 #include <dwarf-regs.h>
 #include <elf.h>
@@ -68,3 +70,34 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine)
 	}
 	return NULL;
 }
+
+__weak int get_arch_regnum(const char *name __maybe_unused)
+{
+	return -1;
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
+		return -1;
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
index 7d99a084e82d..b515f694f55e 100644
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
@@ -10,6 +13,14 @@ const char *get_arch_regstr(unsigned int n);
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
 #endif
 
 #ifdef HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
-- 
2.42.0.655.g421f12c284-goog

