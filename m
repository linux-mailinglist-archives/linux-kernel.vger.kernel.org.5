Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD7B7E756D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345546AbjKJAAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345470AbjKJAAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:38 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860FB46A0;
        Thu,  9 Nov 2023 16:00:27 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so1188714a12.1;
        Thu, 09 Nov 2023 16:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574427; x=1700179227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzNWsgJvVG83qkttBUZAr2wiEePWD6gXUY5o4BwenZA=;
        b=mBStWFfdtzHeDoEpJSikIejM6kx1p3v/0EnIKnUojEekQns4UA7+ZZevb5bbIKZ3uq
         ypofpOtLlV12mlP7lYZNC+VRu5BglnHEOiAV4jj4j3tSYNyBieP6vJ0iVC4OcI/uMlhU
         zD07gTRAzApk6Iap+/yrEgj5vwv1GPXDQffXJuWs/QMgh8eGQbX+CCFUYRuNec4NBScp
         koCNjWvy1jRkIYTZAzLaMOIlbRFsSLPtrnRHOVjFlvsHzcMeeJFWZKe/vSQy2g4zKAAE
         ObS4Dg2dFwMHz84drQ6XcOadQ4k1pCDBU7dSUtZn1IQ3GSvz6wCQGFAQ4tuUzT13Tepw
         aOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574427; x=1700179227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UzNWsgJvVG83qkttBUZAr2wiEePWD6gXUY5o4BwenZA=;
        b=w6FA0TSfELayeMJSF0uajYujf6fXhSfyrheqYANVNkaVgMeA+9oxwwEjswAHl6hbez
         hsC4EeUKly0uO9DT1z6A3B843t56OGOpgUXuzwOSxrQ6OCzFSscKz/9QtF6BfYmN7lBz
         f92yUeYHtKmhV0TD1h+nwwat5RJiQtuYRrC2XOJoWdYN0RBnWf3wx7uZUZcrLtGJR8HI
         SN9AHKcGTSjJ49nEog08gnNKP5ZBRZ13ZvLA4rFm6rgX6ASe6mWVSHFxpNL5znWw2AJl
         hlnJgnoN1qeHPhG7EhRLFU/QSLtwEwML5KtMJkEqFddFTwo/GBoeNSjqLikGSdnkfMa/
         lB6g==
X-Gm-Message-State: AOJu0YzLcgIduxSZehmpVY8wpKzVAsW5+v8Up5OXLubOqtOY0oecmIYC
        HkQs94CHNS1PNS+fhAjaHaA=
X-Google-Smtp-Source: AGHT+IH2aDlDHclMvlGvih/W2kJW293m1dOuZdnt+k6rsCs/9CfN1lwITe+WXWC7SyG4MIPXLfwjuw==
X-Received: by 2002:a17:90b:3b83:b0:280:52a3:711e with SMTP id pc3-20020a17090b3b8300b0028052a3711emr3317822pjb.47.1699574426927;
        Thu, 09 Nov 2023 16:00:26 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:26 -0800 (PST)
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
Subject: [PATCH 07/52] perf dwarf-aux: Add die_find_variable_by_reg() helper
Date:   Thu,  9 Nov 2023 15:59:26 -0800
Message-ID: <20231110000012.3538610-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The die_find_variable_by_reg() will search for a variable or a parameter
sub-DIE in the given scope DIE where the location matches to the given
register.

For the simpliest and most common case, memory access usually happens
with a base register and an offset to the field so the register would
hold a pointer in a variable or function parameter.  Then we can find
one if it has a location expression at the (instruction) address.  So
this function only handles such a simple case for now.

In this case, the expression would have a DW_OP_regN operation where
N < 32.  If the register index (N) is greater than or equal to 32,
DW_OP_regx operation with an operand which saves the value for the N
would be used.  It would reject expressions with more operations.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 67 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h | 12 +++++++
 2 files changed, 79 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 10aa32334d6f..652e6e7368a2 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1245,6 +1245,73 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
 out:
 	return ret;
 }
+
+/* Interval parameters for __die_find_var_reg_cb() */
+struct find_var_data {
+	/* Target instruction address */
+	Dwarf_Addr pc;
+	/* Target register */
+	unsigned reg;
+};
+
+/* Max number of registers DW_OP_regN supports */
+#define DWARF_OP_DIRECT_REGS  32
+
+/* Only checks direct child DIEs in the given scope. */
+static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
+{
+	struct find_var_data *data = arg;
+	int tag = dwarf_tag(die_mem);
+	ptrdiff_t off = 0;
+	Dwarf_Attribute attr;
+	Dwarf_Addr base, start, end;
+	Dwarf_Op *ops;
+	size_t nops;
+
+	if (tag != DW_TAG_variable && tag != DW_TAG_formal_parameter)
+		return DIE_FIND_CB_SIBLING;
+
+	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
+		/* Assuming the location list is sorted by address */
+		if (end < data->pc)
+			continue;
+		if (start > data->pc)
+			break;
+
+		/* Only match with a simple case */
+		if (data->reg < DWARF_OP_DIRECT_REGS) {
+			if (ops->atom == (DW_OP_reg0 + data->reg) && nops == 1)
+				return DIE_FIND_CB_END;
+		} else {
+			if (ops->atom == DW_OP_regx && ops->number == data->reg &&
+			    nops == 1)
+				return DIE_FIND_CB_END;
+		}
+	}
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_find_variable_by_reg - Find a variable saved in a register
+ * @sc_die: a scope DIE
+ * @pc: the program address to find
+ * @reg: the register number to find
+ * @die_mem: a buffer to save the resulting DIE
+ *
+ * Find the variable DIE accessed by the given register.
+ */
+Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
+				    Dwarf_Die *die_mem)
+{
+	struct find_var_data data = {
+		.pc = pc,
+		.reg = reg,
+	};
+	return die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
+}
 #endif
 
 /*
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index f9d765f80fb0..b6f430730bd1 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -137,6 +137,10 @@ int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes);
 /* Get byte offset range of given variable DIE */
 int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
+/* Find a variable saved in the 'reg' at given address */
+Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
+				    Dwarf_Die *die_mem);
+
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
@@ -146,6 +150,14 @@ static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
 	return -ENOTSUP;
 }
 
+static inline Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die __maybe_unused,
+						  Dwarf_Addr pc __maybe_unused,
+						  int reg __maybe_unused,
+						  Dwarf_Die *die_mem __maybe_unused)
+{
+	return NULL;
+}
+
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 #endif /* _DWARF_AUX_H */
-- 
2.42.0.869.gea05f2083d-goog

