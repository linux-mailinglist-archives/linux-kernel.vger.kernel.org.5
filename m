Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF47E7566
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbjKJAAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjKJAAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:21 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4558E44A4;
        Thu,  9 Nov 2023 16:00:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso1210418a12.1;
        Thu, 09 Nov 2023 16:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574419; x=1700179219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s26PP4ZDsM0R9c6L05wqU22qp26lYxGgumYeBt3IcPk=;
        b=QhzGPgQMi46JFIGAL1E1foEvEniu8U/jJhiNMbehb60avWy5Zp5m3LVJZEuU1LlEAP
         aNyWvgBWZrgkfTLJcEGNy77G5kjxrd27AvpVdLLJtg3I7a92aOxVJJ39iN/UwGVoh9Jf
         Dw95Kjs0igsCCEErS0RhoX/T3N8ueeJHHt+D5HlKA7HEP7QxUl+7rZsWaXe4Dhd03lE9
         WwcGgmPR7qQoDG6zADMlbFl8JtYhubm4gjM7e0CFmCNIEq+msc6Ir1+pUwRfZ8dPROcK
         ekA9w9E6Unv0iR+DKOo40E4fQmQvwLmge81GRehjgpJZ44E0/4NSecIO3uxdgFmkv07X
         /uFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574419; x=1700179219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s26PP4ZDsM0R9c6L05wqU22qp26lYxGgumYeBt3IcPk=;
        b=WiVCTUl2zL6tAVOXoFO7YRh9lyeTFXsbR0NUBMQPzC7KAnF1Q4ZavhRz4FrgW2cbcF
         ZiOJLgdVSa68hJuzyxBzRazuj3M+auxVWEYWOO+cb542btSPD5qbDylx8FqteQPnamV+
         ml+7cVizO832OTk54pCRGl8M4sW7I6w/fjsEfm+09U0/KFLcAIv65ONE6v7o6JjbQOR3
         5ogZZPKZEgWF4jkQiOvDblV1bQSTRMNTdXSDLe7+aGyEXNLznlR8YJ0COKelLTUSVg20
         QWJ2jHy4Lr6P9g/hqxjp125rwSrj3G5Ws6IoTo7q+WhIZdTjf2Cp5sVwf/QuAG/ooVlQ
         oT3w==
X-Gm-Message-State: AOJu0YzWL84Wi4/9OCGpEMgCojfqZHpDz6hNTuo+/kb9fz0OO54oxFp4
        aBlPWL9ag8BUgyMSETYZllIU7ScP8Po=
X-Google-Smtp-Source: AGHT+IHHnB+o3wtlhsc5Pg6XZ5hiEHujvSdyi7qq+Tz5AvknsajtKxTo1tPTlLQ40kEzsUxhbvt8aw==
X-Received: by 2002:a17:90b:1bcc:b0:27d:7ebe:2e8 with SMTP id oa12-20020a17090b1bcc00b0027d7ebe02e8mr3543803pjb.9.1699574417184;
        Thu, 09 Nov 2023 16:00:17 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:16 -0800 (PST)
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
Subject: [PATCH 01/52] perf annotate: Pass "-l" option to objdump conditionally
Date:   Thu,  9 Nov 2023 15:59:20 -0800
Message-ID: <20231110000012.3538610-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "-l" option is to print line numbers in the objdump output.
perf annotate TUI only can show the line numbers later but it
causes big slow downs for the kernel binary.

Similarly, showing source code also takes a long time and it
already has an option to control it.

  $ time objdump ... -d -S -C vmlinux > /dev/null
  real	0m3.474s
  user	0m3.047s
  sys	0m0.428s

  $ time objdump ... -d -l -C vmlinux > /dev/null
  real	0m1.796s
  user	0m1.459s
  sys	0m0.338s

  $ time objdump ... -d -C vmlinux > /dev/null
  real	0m0.051s
  user	0m0.036s
  sys	0m0.016s

As it's not needed for data type profiling, let's make it conditional
so that it can skip the unnecessary work.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9b68b8e3791c..118195c787b9 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2144,12 +2144,13 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
-		 " -l -d %s %s %s %c%s%c %s%s -C \"$1\"",
+		 " %s -d %s %s %s %c%s%c %s%s -C \"$1\"",
 		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
+		 opts->show_linenr ? "-l" : "",
 		 opts->show_asm_raw ? "" : "--no-show-raw-insn",
 		 opts->annotate_src ? "-S" : "",
 		 opts->prefix ? "--prefix " : "",
-- 
2.42.0.869.gea05f2083d-goog

