Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81D97C638D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377079AbjJLDzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376943AbjJLDyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:54:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59182102;
        Wed, 11 Oct 2023 20:52:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9e06f058bso1579565ad.0;
        Wed, 11 Oct 2023 20:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082732; x=1697687532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0XefwurqynPVw7eemK2Zs/wgP6X8os3y1RMazTGeGI=;
        b=BoI8o5xN9VsXtWcWdlTCly88YOJwKx5MoWWX9JLNyY/rgyCtaOvqwA4E1h3pWytRyG
         PLsNaKgygG17Ny362mLzHrLLW6/gN/LlL8nOvwgmQZCa8FDqOaTETor4Uwjwcl94YbZR
         4fli/hQ7OZJMC/a8qVA4Npd9DzKoEHiuYFhou3COfrshF3vgacnpPg7CtzLURjFszTFB
         ogaYaeCg7NS7CyQkV1s+ITUgim4KdHFJsQ9eKAeUVqObNDgCZlZz8xrtW3R27QaoTtyM
         IOqV3C/IBsAZ5l4q1ii3ydika/VlaI0XDEOSvMxcMy/o4WqCl7k6houguQCr33ohnz0u
         6qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082732; x=1697687532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x0XefwurqynPVw7eemK2Zs/wgP6X8os3y1RMazTGeGI=;
        b=kFGPn/QMzD23LYDjtLPFKVpy8GPIQEZD+OKJEP+4wpNql3WT/fR07G0bqsGoFPsL3S
         K/iib9JdiB3KvVpvR1iUVRG/CDKC2oc+/TmEiKhdrwh/rddPQFibUQH8SpBTourTc5if
         UaL+JoiF8TRr32ZrQJsIXH/XQO61feinqhFHXBqQgRgGw6+ZwmayqMbADWSwZT0R4ZIH
         sq/nOxflHBQx0InwrfVH7KMWb+19XeAAhHr3eydnj5M8HmPqfbK2fqzmfbC2xUjBAvFn
         tG0x8MNgs2nA0R86qLOpL+Nu8ylJTVVlvicL5bQFcJB8ww7BnTnglw1CWUQYf4BF+/oU
         CdNQ==
X-Gm-Message-State: AOJu0YwPwv6j9U82ZfGdPY2DadjY7smemMVybRH2Xpi61CZy6LrQ1402
        KZQ2xGnCpuPb7UodNlDSrdk=
X-Google-Smtp-Source: AGHT+IERx4ookeIMjvNYjVl3alziknMVM+QRrVZ0bG/brZrYaUm+RaglJ/C+XXX3ThSTtCks+N2cRw==
X-Received: by 2002:a17:902:e852:b0:1c5:59dc:6e93 with SMTP id t18-20020a170902e85200b001c559dc6e93mr34504123plg.3.1697082732334;
        Wed, 11 Oct 2023 20:52:12 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:12 -0700 (PDT)
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
Subject: [PATCH 44/48] perf annotate: Parse x86 segment register location
Date:   Wed, 11 Oct 2023 20:51:07 -0700
Message-ID: <20231012035111.676789-45-namhyung@kernel.org>
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

Add a segment field in the struct annotated_insn_loc and save it for the
segment based addressing like %gs:0x28.  For simplicity it now handles
%gs register only.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 21 +++++++++++++++++++--
 tools/perf/util/annotate.h | 13 +++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d82bfb3b519d..7a097f64a28a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3513,6 +3513,12 @@ static int extract_reg_offset(struct arch *arch, const char *str,
 	 * %gs:0x18(%rbx).  In that case it should skip the part.
 	 */
 	if (*str == arch->objdump.register_char) {
+		if (arch__is(arch, "x86")) {
+			/* FIXME: Handle other segment registers */
+			if (!strncmp(str, "%gs:", 4))
+				op_loc->segment = INSN_SEG_X86_GS;
+		}
+
 		while (*str && !isdigit(*str) &&
 		       *str != arch->objdump.memory_ref_char)
 			str++;
@@ -3609,8 +3615,19 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 			op_loc->multi_regs = multi_regs;
 			extract_reg_offset(arch, insn_str, op_loc);
 		} else {
-			char *s = strdup(insn_str);
+			char *s;
+
+			if (arch__is(arch, "x86")) {
+				/* FIXME: Handle other segment registers */
+				if (!strncmp(insn_str, "%gs:", 4)) {
+					op_loc->segment = INSN_SEG_X86_GS;
+					op_loc->offset = strtol(insn_str + 4,
+								NULL, 0);
+					continue;
+				}
+			}
 
+			s = strdup(insn_str);
 			if (s) {
 				op_loc->reg1 = get_dwarf_regnum(s, 0);
 				free(s);
@@ -3826,7 +3843,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 			.op = op_loc,
 		};
 
-		if (!op_loc->mem_ref)
+		if (!op_loc->mem_ref && op_loc->segment == INSN_SEG_NONE)
 			continue;
 
 		/* Recalculate IP because of LOCK prefix or insn fusion */
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0786528770e1..076b5338ade1 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -444,6 +444,7 @@ int annotate_check_args(struct annotation_options *args);
  * @reg1: First register in the operand
  * @reg2: Second register in the operand
  * @offset: Memory access offset in the operand
+ * @segment: Segment selector register
  * @mem_ref: Whether the operand accesses memory
  * @multi_regs: Whether the second register is used
  */
@@ -451,6 +452,7 @@ struct annotated_op_loc {
 	int reg1;
 	int reg2;
 	int offset;
+	u8 segment;
 	bool mem_ref;
 	bool multi_regs;
 };
@@ -462,6 +464,17 @@ enum annotated_insn_ops {
 	INSN_OP_MAX,
 };
 
+enum annotated_x86_segment {
+	INSN_SEG_NONE = 0,
+
+	INSN_SEG_X86_CS,
+	INSN_SEG_X86_DS,
+	INSN_SEG_X86_ES,
+	INSN_SEG_X86_FS,
+	INSN_SEG_X86_GS,
+	INSN_SEG_X86_SS,
+};
+
 /**
  * struct annotated_insn_loc - Location info of instruction
  * @ops: Array of location info for source and target operands
-- 
2.42.0.655.g421f12c284-goog

