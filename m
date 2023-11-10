Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA17E75A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345650AbjKJAE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345554AbjKJAEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:04:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8405B99;
        Thu,  9 Nov 2023 16:01:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2809a824bbbso1302896a91.3;
        Thu, 09 Nov 2023 16:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574494; x=1700179294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXd2Gsh6T356KjpJSN7Pi3N8Wc0Rm5WPOLB0ueGaGFA=;
        b=YlL3bMM93qLidLsBGM9xZ7Gl2aG5EZli0f7ZjdONZ3362LkvH+xpXJEcMJPFhVTz50
         abkA6UdzEiHJVAac0h1yhQOP7P7w/LDnxA9066+k4McwAqA2+ziyBjzOvygoF9Je5Ht9
         A2NvW7IdwHO3UwNM2yiHlhbgO+4oGhSyWQAlQckY+s+qQiGdSQTCvAJHcm4sDnOD01iY
         Ge7cDY9I1DRAeNHBdFoVoLWo9eJvky5x1fKkl75RsRHwOE2LWVvQYHC3rvqdifiXa27+
         gtLsmLOBAqMWqgbb581OVklB5xR21uFXYrqUbfzVvPsOPe4ysjPrO17NansrJu3D6Yj8
         hdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574494; x=1700179294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GXd2Gsh6T356KjpJSN7Pi3N8Wc0Rm5WPOLB0ueGaGFA=;
        b=wxi3+EFBLGUyWgzy9bGvdJNZ0B53Ze1NxqDxea0Vf7NmmnzA5nF0Aik1ayNW76em3T
         gTjftDBmzvwVXiP9k2adUbuBUyrulhk2wUNuGg4MMkIq80pU8mDe2J5RYZFeQswcSytP
         pseFwinWt6y2PNTdVfQhgnmwHW518K3/c2+rCxtSdYSXstTFuOJvND0SXb61wHCESdl6
         lgGM7u5XwCz+nKuxxkDOrS0oSCpnnIymhlClutLsGpzxdpR2mBuPVzepZ/zm57zd0LQk
         +azkCcWcgxwu4xsMcv2XdOzpu8LCzZTSdPMZdXBuRuxA0KC2Uc5zHAMUMOKHeMsqWRxc
         0ncw==
X-Gm-Message-State: AOJu0YwMhMD5kNQuIX4fvFQ70uaHh+OrVyalBzjW1mBIIZOYY3i0uOpi
        wbLV/UNdKf1w3VR/OyljJ5Y=
X-Google-Smtp-Source: AGHT+IHCCKiw5gXzT7bthEv3cSdjsP6iZ/RhhMp1hvxUIIiQ7dl1wHdTO3VhP0wYW0daBJiAzpFENw==
X-Received: by 2002:a17:90b:1809:b0:280:8c99:1801 with SMTP id lw9-20020a17090b180900b002808c991801mr3205423pjb.16.1699574494509;
        Thu, 09 Nov 2023 16:01:34 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:34 -0800 (PST)
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
Subject: [PATCH 51/52] perf annotate-data: Add stack canary type
Date:   Thu,  9 Nov 2023 16:00:10 -0800
Message-ID: <20231110000012.3538610-52-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the stack protector is enabled, compiler would generate code to
check stack overflow with a special value called 'stack carary' at
runtime.  On x86_64, GCC hard-codes the stack canary as %gs:40.

While there's a definition of fixed_percpu_data in asm/processor.h,
it seems that the header is not included everywhere and many places
it cannot find the type info.  As it's in the well-known location (at
%gs:40), let's add a pseudo stack canary type to handle it specially.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.h |  1 +
 tools/perf/util/annotate.c      | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 0bfef29fa52c..e293980eb11b 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -77,6 +77,7 @@ struct annotated_data_type {
 
 extern struct annotated_data_type unknown_type;
 extern struct annotated_data_type stackop_type;
+extern struct annotated_data_type canary_type;
 
 /**
  * struct data_loc_info - Data location information
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9b72eae2400c..e183c53531fe 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -113,6 +113,13 @@ struct annotated_data_type stackop_type = {
 	},
 };
 
+struct annotated_data_type canary_type = {
+	.self = {
+		.type_name = (char *)"(stack canary)",
+		.children = LIST_HEAD_INIT(canary_type.self.children),
+	},
+};
+
 static int arch__grow_instructions(struct arch *arch)
 {
 	struct ins *new_instructions;
@@ -3768,6 +3775,17 @@ static bool is_stack_operation(struct arch *arch, struct disasm_line *dl)
 	return false;
 }
 
+static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
+{
+	/* On x86_64, %gs:40 is used for stack canary */
+	if (arch__is(arch, "x86")) {
+		if (loc->segment == INSN_SEG_X86_GS && loc->offset == 40)
+			return true;
+	}
+
+	return false;
+}
+
 u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 			struct disasm_line *dl)
 {
@@ -3937,6 +3955,12 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		}
 
 		mem_type = find_data_type(&dloc);
+
+		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
+			mem_type = &canary_type;
+			dloc.type_offset = 0;
+		}
+
 		if (mem_type)
 			istat->good++;
 		else
-- 
2.42.0.869.gea05f2083d-goog

