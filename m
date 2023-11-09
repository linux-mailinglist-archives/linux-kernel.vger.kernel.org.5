Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661977E7588
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345720AbjKJADF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345545AbjKJACc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:02:32 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B645257;
        Thu,  9 Nov 2023 16:01:05 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so1108808a12.0;
        Thu, 09 Nov 2023 16:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574465; x=1700179265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjEl3q6T8aZ2C9UHCLhYA2cSxHBerxf7uY5QArHiSe8=;
        b=EfHKOtdIgzEaTPWORXYZsLBAYYYLAc6iYVEdnPbGHNHVituPjYOELHxNHPONiYmtTp
         glzEL5U9IPfCgn+2YSFu9JPPHlxbDjJ2EfSq9w3BUPSWC92hkNkAZLegTG/udKZMxgdy
         effHaJyRHTlc5YpeBF9jANXonykrAQR3oU7IHxaJzfQo72hneBFjt0fki0T3tgAKM/6k
         Uttwdq8XJSkRotp9BFGPXHBqGzZHwAu/dy349indyyKtg4rURZO6tuOc1RZdk1THrYKs
         JBkL+sa/rqsPv7k91u8d+x/xbPW3QjpPz+kv/MCkEeb/UI0OpIGXYX5oQI1iEAq7wIy3
         ZtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574465; x=1700179265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjEl3q6T8aZ2C9UHCLhYA2cSxHBerxf7uY5QArHiSe8=;
        b=LVz5Mp0AwoBxHcgW74EmPpkDLLoq3f++rMjeYJJbNwx4mXv/pSULEliSrJKAaBSeNX
         V24ywjukl7nPNHr11y95sOQ8UG0uxd5vlFmO6eJbF+waQ8fYXRY78Q7v4wo3SiTfN2Hi
         Vp45N9SSimhEsNw0B5EYD0Gqj+yNQJgW4lecLumUbYQf8dr31kv5yP91tWJs/8BhVp/9
         1e7bwbdi/lBHo1r0w7LVZZFi4G3O5B6okHF09l4DvxfBGO/EgBQMH7NKOwj1tDhLswhq
         I2HRgnyvoEgZTqjFkgk4j3cRV9Yjnh0xUlNxVCR2G06ePs9bGvNm6HhU0PxsJhs79jHF
         xxGw==
X-Gm-Message-State: AOJu0Yx29oQqymQkFE0ikp+iRGlA7AnuNU/lcqvkW7hUDMTcndobdk5+
        6vUFT30sVZK/9C8jpa3J+Dw=
X-Google-Smtp-Source: AGHT+IFe4ieLldc6KrSz5mKX86U9BuRX1+txGq4lZdQQfJRXwcmIPzy9i1H8w2j1Lv6jrfTUdQ9XxA==
X-Received: by 2002:a17:90b:4a91:b0:27d:1538:e324 with SMTP id lp17-20020a17090b4a9100b0027d1538e324mr3249850pjb.32.1699574465081;
        Thu, 09 Nov 2023 16:01:05 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:04 -0800 (PST)
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
Subject: [PATCH 32/52] perf dwarf-aux: Add die_find_variable_by_addr()
Date:   Thu,  9 Nov 2023 15:59:51 -0800
Message-ID: <20231110000012.3538610-33-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The die_find_variable_by_addr() is to find a variables in the given DIE
using given (PC-relative) address.  Global variables will have a
location expression with DW_OP_addr which has an address so can simply
compare it with the address.

  <1><143a7>: Abbrev Number: 2 (DW_TAG_variable)
      <143a8>   DW_AT_name        : loops_per_jiffy
      <143ac>   DW_AT_type        : <0x1cca>
      <143b0>   DW_AT_external    : 1
      <143b0>   DW_AT_decl_file   : 193
      <143b1>   DW_AT_decl_line   : 213
      <143b2>   DW_AT_location    : 9 byte block: 3 b0 46 41 82 ff ff ff ff
                                     (DW_OP_addr: ffffffff824146b0)

Note that the type-offset should be calculated from the base address of
the global variable.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 79 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h | 14 +++++++
 2 files changed, 93 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 4bdcd3dea28f..7aa5fee0da19 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1266,8 +1266,12 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
 struct find_var_data {
 	/* Target instruction address */
 	Dwarf_Addr pc;
+	/* Target memory address (for global data) */
+	Dwarf_Addr addr;
 	/* Target register */
 	unsigned reg;
+	/* Access offset, set for global data */
+	int offset;
 };
 
 /* Max number of registers DW_OP_regN supports */
@@ -1328,6 +1332,81 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
 	};
 	return die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
 }
+
+/* Only checks direct child DIEs in the given scope */
+static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
+{
+	struct find_var_data *data = arg;
+	int tag = dwarf_tag(die_mem);
+	ptrdiff_t off = 0;
+	Dwarf_Attribute attr;
+	Dwarf_Addr base, start, end;
+	Dwarf_Word size;
+	Dwarf_Die type_die;
+	Dwarf_Op *ops;
+	size_t nops;
+
+	if (tag != DW_TAG_variable)
+		return DIE_FIND_CB_SIBLING;
+
+	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
+		if (ops->atom != DW_OP_addr)
+			continue;
+
+		if (data->addr < ops->number)
+			continue;
+
+		if (data->addr == ops->number) {
+			/* Update offset relative to the start of the variable */
+			data->offset = 0;
+			return DIE_FIND_CB_END;
+		}
+
+		if (die_get_real_type(die_mem, &type_die) == NULL)
+			continue;
+
+		if (dwarf_aggregate_size(&type_die, &size) < 0)
+			continue;
+
+		if (data->addr >= ops->number + size)
+			continue;
+
+		/* Update offset relative to the start of the variable */
+		data->offset = data->addr - ops->number;
+		return DIE_FIND_CB_END;
+	}
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_find_variable_by_addr - Find variable located at given address
+ * @sc_die: a scope DIE
+ * @pc: the program address to find
+ * @addr: the data address to find
+ * @die_mem: a buffer to save the resulting DIE
+ * @offset: the offset in the resulting type
+ *
+ * Find the variable DIE located at the given address (in PC-relative mode).
+ * This is usually for global variables.
+ */
+Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
+				     Dwarf_Addr addr, Dwarf_Die *die_mem,
+				     int *offset)
+{
+	struct find_var_data data = {
+		.pc = pc,
+		.addr = addr,
+	};
+	Dwarf_Die *result;
+
+	result = die_find_child(sc_die, __die_find_var_addr_cb, &data, die_mem);
+	if (result)
+		*offset = data.offset;
+	return result;
+}
 #endif
 
 /*
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index f9763d3b7572..4e64caac6df8 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -144,6 +144,11 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
 				    Dwarf_Die *die_mem);
 
+/* Find a (global) variable located in the 'addr' */
+Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
+				     Dwarf_Addr addr, Dwarf_Die *die_mem,
+				     int *offset);
+
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
@@ -161,6 +166,15 @@ static inline Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die __maybe_unus
 	return NULL;
 }
 
+static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unused,
+						   Dwarf_Addr pc __maybe_unused,
+						   Dwarf_Addr addr __maybe_unused,
+						   Dwarf_Die *die_mem __maybe_unused,
+						   int *offset __maybe_unused)
+{
+	return NULL;
+}
+
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 #endif /* _DWARF_AUX_H */
-- 
2.42.0.869.gea05f2083d-goog

