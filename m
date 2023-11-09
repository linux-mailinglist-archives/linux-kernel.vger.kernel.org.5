Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B7A7E7585
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345485AbjKJACs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345518AbjKJAB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715B44ED0;
        Thu,  9 Nov 2023 16:01:00 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27ddc1b1652so1292884a91.2;
        Thu, 09 Nov 2023 16:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574460; x=1700179260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ia7kvZ+eaGI+H0XOPg0NJ+OKOWxPEjxcavewxuznSI=;
        b=cSqhRC+vmPv8UmB4RieRSId0DnW33fNO73dC2vF1mGLP+Vpf+ohOmIe3cI515CBHVy
         oeMni24x48r0zjf41tpkmDhNfFotq26wh26xdmPIl/8MwvUn3XJsSfi63qYUs03QX+Gv
         PpX6dBz4CY8QiiLVr5EdSkyve+mEDSiwugwFINyfta9oDQVDQ8mfuZE3QWULu20iGj1M
         YtnsRDO1Vj4l8f8xLQSLGN/Qkz6xE8h3Y7Jf+zhp3Yt0vAW8Ol093VAwEc8bU3mgHGiF
         F6u2Qic+4ZD2EakCMZXyLhWQ2D6Ry9L9RURDJ/5eGaow9bJ+8dgzMFKY/Z0tsdn51vQa
         fSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574460; x=1700179260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ia7kvZ+eaGI+H0XOPg0NJ+OKOWxPEjxcavewxuznSI=;
        b=AfEmLYiivFHNcDFUTHWI57niLtYBWibTIBjS03mOspuyEsrby5WIQzozTQ+HbsRjyf
         0IBCatQ/WwLA1Gjj+OlZSEGYVsP2bcZ97UtSYDPErutubBxN0SiuBSl0/B9JUdDQsDGC
         bZd/zCRPsn8SrRor2W6TjZ7PgeECVUk+ydXab4D1Okp0yOIK+qpUsubG8STodmiSMupV
         lDK5/QxKzPhYkXk/W3VeHysglPStdSgLi78caU8QOpUNfEF0M0GmzLUqiAjfHFZqAoa6
         pAO8kCXRg00aYP8H7jNqLcHHADvopyesdEkwfbFv3fWqsxxhTVwBQlP59z7udhEBO73h
         Lk9Q==
X-Gm-Message-State: AOJu0Yznp1iWEHFQ6n+mHodTbj9RCBdbq48ENVoFKmuYUUaCetl1xa+l
        oLqvHaxG/iV9llURld3CnnI=
X-Google-Smtp-Source: AGHT+IHrw+WJOxhr/YA5r9qqGxD0I9fuPFs34KyYR7qggeWg/Bxckkc0iovWCk5JS6i26HbQum3Blg==
X-Received: by 2002:a17:90b:4c12:b0:280:3f33:64d8 with SMTP id na18-20020a17090b4c1200b002803f3364d8mr3606376pjb.21.1699574459747;
        Thu, 09 Nov 2023 16:00:59 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:59 -0800 (PST)
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
Subject: [PATCH 29/52] perf annotate-data: Handle macro fusion on x86
Date:   Thu,  9 Nov 2023 15:59:48 -0800
Message-ID: <20231110000012.3538610-30-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a sample was come from a conditional branch without a memory
operand, it could be due to a macro fusion with a previous instruction.
So it needs to check the memory operand in the previous one.

This improves the stat like below:

  Annotate data type stats:
  total 294, ok 147 (50.0%), bad 147 (50.0%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          71 : no_var
           6 : no_typeinfo
           8 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2f325a9cf33a..7d733bc85c9a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3750,6 +3750,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		return NULL;
 	}
 
+retry:
 	istat = annotate_data_stat(&ann_insn_stat, dl->ins.name);
 	if (istat == NULL) {
 		ann_data_stat.no_insn++;
@@ -3766,7 +3767,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		if (!op_loc->mem_ref)
 			continue;
 
-		/* Recalculate IP since it can be changed due to LOCK prefix */
+		/* Recalculate IP because of LOCK prefix or insn fusion */
 		ip = ms->sym->start + dl->al.offset;
 
 		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
@@ -3785,6 +3786,20 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		return mem_type;
 	}
 
+	/*
+	 * Some instructions can be fused and the actual memory access came
+	 * from the previous instruction.
+	 */
+	if (dl->al.offset > 0) {
+		struct disasm_line *prev_dl;
+
+		prev_dl = list_prev_entry(dl, al.node);
+		if (ins__is_fused(arch, prev_dl->ins.name, dl->ins.name)) {
+			dl = prev_dl;
+			goto retry;
+		}
+	}
+
 	ann_data_stat.no_mem_ops++;
 	istat->bad++;
 	return NULL;
-- 
2.42.0.869.gea05f2083d-goog

