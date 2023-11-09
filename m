Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358ED7E7584
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbjKJACn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjKJABz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B645C4EC4;
        Thu,  9 Nov 2023 16:00:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-280260db156so1276076a91.2;
        Thu, 09 Nov 2023 16:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574458; x=1700179258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VL5lFahygayw5UMi6X2ej0x4hwwXaVjpVtEOwOIuJ0=;
        b=MhvZQEh/BGG8l4eAag3n5BBmx2AC+35Qb+sllIKYUW/NjMiE2k1pZT758yErUjkTDv
         vn85WMTpGMPLWJl9RYFQS20e8tij23ZvTUFsWDUBS+o8q/xj81W7lUnh2kaz+KTSbnTL
         euXi8A9l2lTir8HWrpb8nzv4aCCajPBn23Sl/7cdhrlrW0yYUTatva6EhbNL9OtLOmFK
         qKjdJH+zPtHKBUZEQhrG59lyOl/2BZc1FuwDohRMMCWYQ2Eq5JwT5SlDrY0sWVLTxq3E
         1TKlEFhypikbZmem8LW/i0/T9TqL5DLCLTkSs8oRpXZ3ogV2qw5/QUVlNKGjdvDl/Z+s
         iHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574458; x=1700179258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4VL5lFahygayw5UMi6X2ej0x4hwwXaVjpVtEOwOIuJ0=;
        b=h/KaLOfTlBlfs7Rr7PrXjLc/dEwUf5s29651Xxu/3t6nIzO5KIMoLpP4Z492zk55n4
         I65WXFmOfZ6/SDFl6aweGFxvIa9XZBwSxLm1pFlFUj1FtNvPhfRH8f1uyBC8O+gHVWef
         0Wl/eD3Kn8mUWuXKPHWYEirEGtS4jz1ecJIaWVJrPecJEl2g7vdmvtv2XFSRM+Cn4anA
         uTEcq0hI+kXVP0iEZg8CUDc0gMjhpHyRCaJ6IsrSSGeeoVb8LucNt35O42JNeNexx+rp
         OPxdd8alq2K6DoXCRYwzMK0w+PG5JyDGEsrEHF7BYRFNO8GywXoRrhV5XNiWl1ltuWyh
         I8lA==
X-Gm-Message-State: AOJu0YyszSB9XfeOUEIigaPxgrT7Z96rF2wWP45LGimjWL9iwyvn/10I
        QyciQ5nIye8i/IXhqXaRM3VRR1KA9bo=
X-Google-Smtp-Source: AGHT+IHnhMPNvmJsVZfBFuBNeAlGWgo0DHbDXqrexM/KH8E8BrECGZkEjOFOWNgZ7wLNmYdTXNOgWA==
X-Received: by 2002:a17:90b:4f49:b0:27d:4b6e:b405 with SMTP id pj9-20020a17090b4f4900b0027d4b6eb405mr3562538pjb.33.1699574458144;
        Thu, 09 Nov 2023 16:00:58 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:57 -0800 (PST)
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
Subject: [PATCH 28/52] perf annotate-data: Parse 'lock' prefix from llvm-objdump
Date:   Thu,  9 Nov 2023 15:59:47 -0800
Message-ID: <20231110000012.3538610-29-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the performance reason, I prefer llvm-objdump over GNU's.  But I
found that llvm-objdump puts x86 lock prefix in a separate line like
below.

  ffffffff81000695: f0                    lock
  ffffffff81000696: ff 83 54 0b 00 00     incl    2900(%rbx)

This should be parsed properly, but I just changed to find the insn
with next offset for now.

This improves the statistics as it can process more instructions.

  Annotate data type stats:
  total 294, ok 144 (49.0%), bad 150 (51.0%)
  -----------------------------------------------------------
          30 : no_sym
          35 : no_mem_ops
          71 : no_var
           6 : no_typeinfo
           8 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3ac601d70f61..2f325a9cf33a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3664,8 +3664,17 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
 	notes = symbol__annotation(sym);
 
 	list_for_each_entry(dl, &notes->src->source, al.node) {
-		if (sym->start + dl->al.offset == ip)
+		if (sym->start + dl->al.offset == ip) {
+			/*
+			 * llvm-objdump places "lock" in a separate line and
+			 * in that case, we want to get the next line.
+			 */
+			if (!strcmp(dl->ins.name, "lock") && *dl->ops.raw == '\0') {
+				ip++;
+				continue;
+			}
 			return dl;
+		}
 	}
 	return NULL;
 }
@@ -3757,6 +3766,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		if (!op_loc->mem_ref)
 			continue;
 
+		/* Recalculate IP since it can be changed due to LOCK prefix */
+		ip = ms->sym->start + dl->al.offset;
+
 		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
 		if (mem_type)
 			istat->good++;
-- 
2.42.0.869.gea05f2083d-goog

