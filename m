Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C900A7C637F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377140AbjJLDyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376920AbjJLDwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BE6D5D;
        Wed, 11 Oct 2023 20:51:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9d3a21f7aso4510215ad.2;
        Wed, 11 Oct 2023 20:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082706; x=1697687506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHRD9kCjTkWVMzvqCRV9itspmVJvTLZ+rMPWUUQpDy0=;
        b=XINusBF0gHNj2rSlBlEKNCJQL6v1m3lkiON5G2iLAPI0iPBX+YAT+RwHnqKlvdWoXN
         cs6CHDboOCn9YiPjzGbX2cdLyp8uA/lvtc0JDwJUmD4XCg1ZO/7nicyAmxpzgdlJmLfo
         wz7QyDGpanJRNZweugZfPasBV2QvEUxFX+oGSkwEOQ2vDDRevXHBf5KkIHvicmrXfZbh
         hQ6FpKlid2nmIeS/BobA7vgRio6qaKS6Y1iJRHLtLpAE1YvF5tynrQrEU5Q2tgsBr5ND
         lFPm4kx0jiUYcxJjg4nooCLgj2ZOl9aoX/Fg2rDdgdRZ5j6Z7ySsSgcbAI5uOXpJxlQv
         UG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082706; x=1697687506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tHRD9kCjTkWVMzvqCRV9itspmVJvTLZ+rMPWUUQpDy0=;
        b=O7rpZ+4Eu+XZ+DKI12f8VmwVyiDSx8REbRkvWB1IlBWMBA2O7wrJ+NnDVvrzJAA0po
         +edz6fuGQPPHJBfon0LI5K9cZTe2JwkeBdXIDsnS6NpCdrx5emNQy7Zb0i7HoKR6aPwD
         pUrxoBXILYuVt+h8BMDKWZjNS+aORN5aaO0MxOyw7xhd1okUhjdkRgkxhT1jh5DcP8hG
         KcIQqnVA8Iv2SvUQk9TCdlEPvCwGa0/ZHAGHGkRj/j38x8uDIJ0NER1SwoSCE3yRUE1y
         mii0dQTvCdU71r4iIXh7RBjQl5MzZ1fnD25Y85ChPIAJegzlAZAboIeRzQ/gKtsDqc5D
         ikAQ==
X-Gm-Message-State: AOJu0Yw5Fqe5ShbSwoFKUd0dbQecetngfXtjKfsCkpJ03NH2BC+3EZtB
        tiDtCtWhFhhKpHq8sOVpL4g=
X-Google-Smtp-Source: AGHT+IHYqRXVv5ofdwjZ4bLJK/vcIMyvy7EqEslLjOrb45XJPQdU7HOk/f994qTsqhY2zuxlM87Dng==
X-Received: by 2002:a17:902:e84a:b0:1c2:218c:3754 with SMTP id t10-20020a170902e84a00b001c2218c3754mr28229405plg.53.1697082706299;
        Wed, 11 Oct 2023 20:51:46 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:45 -0700 (PDT)
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
Subject: [PATCH 24/48] perf annotate-data: Parse 'lock' prefix from llvm-objdump
Date:   Wed, 11 Oct 2023 20:50:47 -0700
Message-ID: <20231012035111.676789-25-namhyung@kernel.org>
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
index 3f3cc7ae751f..190489df0fb7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3624,8 +3624,17 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip)
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
@@ -3717,6 +3726,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		if (!op_loc->mem_ref)
 			continue;
 
+		/* Recalculate IP since it can be changed due to LOCK prefix */
+		ip = ms->sym->start + dl->al.offset;
+
 		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
 		if (mem_type)
 			istat->good++;
-- 
2.42.0.655.g421f12c284-goog

