Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB3E7C6368
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376929AbjJLDvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344734AbjJLDvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:51:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D6CB7;
        Wed, 11 Oct 2023 20:51:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c735473d1aso4395815ad.1;
        Wed, 11 Oct 2023 20:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082677; x=1697687477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed07eY8Yy1Ov3wLjexONW1pCgxoZtQGuV9y71hqZcBM=;
        b=eaZQg1tL7TBIGDgwpNe8+dcw2HCPBAaznYJA1hsKS+cXUDd/Cdu8pe0k35EHS+z/GW
         OnYFYqNTcQl7lWg9UAAsQ1GDEmLM1vNXN5obwYli2LQ24mtF2ADZW3s5zfuDKNKHsLAw
         G1lwmAEYZbXkIC6ZSTpBLUxExgvt/ZQ9OaB6kvh5wiRBbp85SfT9nISq8BrI7YIpkvTX
         Pf2iJb3/dr3MicHRo6d0au9K1mlCQDmKZaPyXBDzxILIRUwXbCO3q6juVxWdWhbpL/i8
         isy6USE5TLx+ipQvdBUbZsxYi2yRVBUXtG2Z9RPjV/Unvi2w+qtG3IlHt4xVfPv8FJOD
         9GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082677; x=1697687477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ed07eY8Yy1Ov3wLjexONW1pCgxoZtQGuV9y71hqZcBM=;
        b=KGYO4m2wJQi85fbgDyhiIX+yTKjzXstzQlgGLb+mV/LGSW6fBOWuZga4/4w7Z25dWf
         6mIe812yQT230nLHBW+BbtHEWVkV1PK0kudaqisP3pYtXBqgNxDOmZ9tTbkQVK/lhxPa
         K0BXtdoe+olJVOF88I24s5Ocd9lXawtSdyDhtMLV/ct46mMhOSKI8fKgEOdrkDdnAtU2
         0YGi7XaOGbyF3d1Rm61giC6OOc3qx8XG+d+EmS/kqh63ncpox6kutHsQNPmfFxyiFd0J
         kpnrOsxZWve+YVaerXBjMr7mqgkLfo7aWh8txEwdDNb67LKNYl9xo9LGkwI/9913xYSz
         mEjA==
X-Gm-Message-State: AOJu0YwocfeyHMAMXN/Cm4z6zsLvsFSDZtnmJauprvgcgzUjxgp9/URc
        F2+QBo5RMG0vSoR+Slg7XsE=
X-Google-Smtp-Source: AGHT+IFmLdZC51KV1oFgo4VqJTLi7sLS0FScxil5PxiMM501u2XpxMgMw0RbKIQ7x+rJGvM/hyHHzQ==
X-Received: by 2002:a17:902:e9c5:b0:1c9:bcbe:f581 with SMTP id 5-20020a170902e9c500b001c9bcbef581mr6002537plk.50.1697082677020;
        Wed, 11 Oct 2023 20:51:17 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:16 -0700 (PDT)
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
Subject: [PATCH 02/48] perf annotate: Check if operand has multiple regs
Date:   Wed, 11 Oct 2023 20:50:25 -0700
Message-ID: <20231012035111.676789-3-namhyung@kernel.org>
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

It needs to check all possible information in an instruction.  Let's add
a field indicating if the operand has multiple registers.  I'll be used
to search type information like in an array access on x86 like:

  mov    0x10(%rax,%rbx,8), %rcx
             -------------
                 here

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 36 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 211636e65b03..605298410ed4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -85,6 +85,8 @@ struct arch {
 	struct		{
 		char comment_char;
 		char skip_functions_char;
+		char register_char;
+		char memory_ref_char;
 	} objdump;
 };
 
@@ -188,6 +190,8 @@ static struct arch architectures[] = {
 		.insn_suffix = "bwlq",
 		.objdump =  {
 			.comment_char = '#',
+			.register_char = '%',
+			.memory_ref_char = '(',
 		},
 	},
 	{
@@ -566,6 +570,34 @@ static struct ins_ops lock_ops = {
 	.scnprintf = lock__scnprintf,
 };
 
+/*
+ * Check if the operand has more than one registers like x86 SIB addressing:
+ *   0x1234(%rax, %rbx, 8)
+ *
+ * But it doesn't care segment selectors like %gs:0x5678(%rcx), so just check
+ * the input string after 'memory_ref_char' if exists.
+ */
+static bool check_multi_regs(struct arch *arch, const char *op)
+{
+	int count = 0;
+
+	if (arch->objdump.register_char == 0)
+		return false;
+
+	if (arch->objdump.memory_ref_char) {
+		op = strchr(op, arch->objdump.memory_ref_char);
+		if (op == NULL)
+			return false;
+	}
+
+	while ((op = strchr(op, arch->objdump.register_char)) != NULL) {
+		count++;
+		op++;
+	}
+
+	return count > 1;
+}
+
 static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms __maybe_unused)
 {
 	char *s = strchr(ops->raw, ','), *target, *comment, prev;
@@ -593,6 +625,8 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
 	if (ops->source.raw == NULL)
 		return -1;
 
+	ops->source.multi_regs = check_multi_regs(arch, ops->source.raw);
+
 	target = skip_spaces(++s);
 	comment = strchr(s, arch->objdump.comment_char);
 
@@ -613,6 +647,8 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
 	if (ops->target.raw == NULL)
 		goto out_free_source;
 
+	ops->target.multi_regs = check_multi_regs(arch, ops->target.raw);
+
 	if (comment == NULL)
 		return 0;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 9d8b4199e3bd..e33a55431bad 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -39,12 +39,14 @@ struct ins_operands {
 		s64	offset;
 		bool	offset_avail;
 		bool	outside;
+		bool	multi_regs;
 	} target;
 	union {
 		struct {
 			char	*raw;
 			char	*name;
 			u64	addr;
+			bool	multi_regs;
 		} source;
 		struct {
 			struct ins	    ins;
-- 
2.42.0.655.g421f12c284-goog

