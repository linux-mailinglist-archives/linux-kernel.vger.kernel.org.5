Return-Path: <linux-kernel+bounces-125468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2564892683
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC2928334F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02613E3E8;
	Fri, 29 Mar 2024 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBR77gh2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5800A13D627;
	Fri, 29 Mar 2024 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749496; cv=none; b=X6LfVRCU75/YtAtYBddyvjTvdtEyQ+zrPx+3u7QHPMSKxUWnuWDTsQRoo69sBx4brJt8OFturT+Y5+zLYHtDZRkS8PM1h77ZB4aFD4mL4MYcbgjhOfqtGo54x/UvjtRzEoBbJWHM4UGilR35qVYnc4624qh9NOKf81CYkf+H1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749496; c=relaxed/simple;
	bh=rkVKVjMaNjUrH31qNS/aO5PrwtqvodVUbLBgSz8X9v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXeImp3nkhAc8FQ9P2Tt2RlkBE0q5lVxLRLaTTTASN4L5T8QlmSjqKLwQeaybaduW7TVLphdIdh9adxonZF7W1LVobVK37JjHn43kcU+MxexU251kO7jN5eBFHv3qJwBwjTzDPmtTb3bZslAOHlvIPXXZtb/F9rOmTMB/XD0+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBR77gh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93692C433A6;
	Fri, 29 Mar 2024 21:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749496;
	bh=rkVKVjMaNjUrH31qNS/aO5PrwtqvodVUbLBgSz8X9v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBR77gh29YFRNWyFQ1f80qz7yX7LHAYtPntQZTFvY5UqwD2dIeHjTlk/2zO+1OfVK
	 3CNw/wXh3XRs3NELUBsKkORi1VkgeRL7KL95UGgQGJhjfK8VHywX8GOOU8fz54TGG7
	 9cm/ldM7fWIm3M9OeibZcBVtpg4usbeEeFxOiKFCqRCwGpn+SYTlB+yevt3mVpvI5H
	 KUiW/XVM/FeL69uFZmAi2f6T/XmhVMBqpnvAitJsp1zt9VrJiK9zzW8NquyNFVDS0I
	 rS7CwnFThd0UXHXpy/8QvjggjDi4dU7LYJag9aA1Qm8K7YWKyaRGrLk1+WPC20u+pc
	 0mr3Aw8qdNRqw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v2 4/5] perf annotate: Use libcapstone to disassemble
Date: Fri, 29 Mar 2024 14:58:11 -0700
Message-ID: <20240329215812.537846-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240329215812.537846-1-namhyung@kernel.org>
References: <20240329215812.537846-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now it can use the capstone library to disassemble the instructions.
Let's use that (if available) for perf annotate to speed up.  Currently
it only supports x86 architecture.  With this change I can see ~3x speed
up in data type profiling.

But note that capstone cannot give the source file and line number info.
For now, users should use the external objdump for that by specifying
the --objdump option explicitly.

Tested-by: Ian Rogers <irogers@google.com>
Cc: Changbin Du <changbin.du@huawei.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/disasm.c | 160 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 59ac37723990..cd2f7d67f423 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <ctype.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <inttypes.h>
 #include <libgen.h>
 #include <regex.h>
@@ -18,6 +19,7 @@
 #include "evsel.h"
 #include "map.h"
 #include "maps.h"
+#include "namespaces.h"
 #include "srcline.h"
 #include "symbol.h"
 
@@ -1341,6 +1343,158 @@ symbol__disassemble_bpf_image(struct symbol *sym,
 	return 0;
 }
 
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+#include <capstone/capstone.h>
+
+static int open_capstone_handle(struct annotate_args *args, bool is_64bit,
+				csh *handle)
+{
+	struct annotation_options *opt = args->options;
+	cs_mode mode = is_64bit ? CS_MODE_64 : CS_MODE_32;
+
+	/* TODO: support more architectures */
+	if (!arch__is(args->arch, "x86"))
+		return -1;
+
+	if (cs_open(CS_ARCH_X86, mode, handle) != CS_ERR_OK)
+		return -1;
+
+	if (!opt->disassembler_style ||
+	    !strcmp(opt->disassembler_style, "att"))
+		cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+
+	return 0;
+}
+
+struct find_file_offset_data {
+	u64 ip;
+	u64 offset;
+};
+
+/* This will be called for each PHDR in an ELF binary */
+static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
+{
+	struct find_file_offset_data *data = arg;
+
+	if (start <= data->ip && data->ip < start + len) {
+		data->offset = pgoff + data->ip - start;
+		return 1;
+	}
+	return 0;
+}
+
+static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
+					struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct map *map = args->ms.map;
+	struct dso *dso = map__dso(map);
+	struct nscookie nsc;
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	u64 len = end - start;
+	u64 offset;
+	int i, fd, count;
+	bool is_64bit = false;
+	bool needs_cs_close = false;
+	u8 *buf = NULL;
+	struct find_file_offset_data data = {
+		.ip = start,
+	};
+	csh handle;
+	cs_insn *insn;
+	char disasm_buf[512];
+	struct disasm_line *dl;
+
+	if (args->options->objdump_path)
+		return -1;
+
+	nsinfo__mountns_enter(dso->nsinfo, &nsc);
+	fd = open(filename, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
+	if (fd < 0)
+		return -1;
+
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
+			    &is_64bit) == 0)
+		goto err;
+
+	if (open_capstone_handle(args, is_64bit, &handle) < 0)
+		goto err;
+
+	needs_cs_close = true;
+
+	buf = malloc(len);
+	if (buf == NULL)
+		goto err;
+
+	count = pread(fd, buf, len, data.offset);
+	close(fd);
+	fd = -1;
+
+	if ((u64)count != len)
+		goto err;
+
+	/* add the function address and name */
+	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
+		  start, sym->name);
+
+	args->offset = -1;
+	args->line = disasm_buf;
+	args->line_nr = 0;
+	args->fileloc = NULL;
+	args->ms.sym = sym;
+
+	dl = disasm_line__new(args);
+	if (dl == NULL)
+		goto err;
+
+	annotation_line__add(&dl->al, &notes->src->source);
+
+	count = cs_disasm(handle, buf, len, start, len, &insn);
+	for (i = 0, offset = 0; i < count; i++) {
+		scnprintf(disasm_buf, sizeof(disasm_buf),
+			  "       %-7s %s",
+			  insn[i].mnemonic, insn[i].op_str);
+
+		args->offset = offset;
+		args->line = disasm_buf;
+
+		dl = disasm_line__new(args);
+		if (dl == NULL)
+			goto err;
+
+		annotation_line__add(&dl->al, &notes->src->source);
+
+		offset += insn[i].size;
+	}
+
+out:
+	if (needs_cs_close)
+		cs_close(&handle);
+	free(buf);
+	return count < 0 ? count : 0;
+
+err:
+	if (fd >= 0)
+		close(fd);
+	if (needs_cs_close) {
+		struct disasm_line *tmp;
+
+		/*
+		 * It probably failed in the middle of the above loop.
+		 * Release any resources it might add.
+		 */
+		list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
+			list_del(&dl->al.node);
+			free(dl);
+		}
+	}
+	count = -1;
+	goto out;
+}
+#endif
+
 /*
  * Possibly create a new version of line with tabs expanded. Returns the
  * existing or new line, storage is updated if a new line is allocated. If
@@ -1463,6 +1617,12 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		strcpy(symfs_filename, tmp);
 	}
 
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	err = symbol__disassemble_capstone(symfs_filename, sym, args);
+	if (err == 0)
+		goto out_remove_tmp;
+#endif
+
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
-- 
2.44.0.478.gd926399ef9-goog


