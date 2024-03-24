Return-Path: <linux-kernel+bounces-113283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E5888316
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E7B286C81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2213CC6F;
	Sun, 24 Mar 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS/FMnyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37E13CC4F;
	Sun, 24 Mar 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320084; cv=none; b=H96ZYyxp9t6vJ2OR3CuVF5z7juqZSJEKJXbbLvPex5m4j8SgAYb+fFnxWbH6in5xWJHYHOHZqsbvdmooaQG61jdWUe6482MsThQcI1sY2jY83vb7xiazZByvwzB/71ESC67A3m7ln0P0nJ/9pzggVOt18b0P9rHRFhI854M91Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320084; c=relaxed/simple;
	bh=Y1cVgr2blchwClVyVWRsQSGFE/EQmsjAViufLUR7hy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+CNuIGG9PXZGvRl7yhnGv7jdOBCoB+OvVssigRZcnEPRjWBu2HDXu2Ku0zSiKcgw1Az0V3t7zYFViVR+ASDGety+j9cXXZCsYyOF4/+d7SdxTYIRIGVchPN0hIJ9TzyybfFUyjDDZE6ezGkMYy/e46b0iCg8f8gGorEKN1VeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS/FMnyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74CAC433F1;
	Sun, 24 Mar 2024 22:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320084;
	bh=Y1cVgr2blchwClVyVWRsQSGFE/EQmsjAViufLUR7hy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IS/FMnyyXqlKTOWx80VMkDHs0umfA8mv+cKZgIRKolmys2GDgsurfs7e9oCk4Hw1z
	 qN8vquuK8fEKcjS3uqHGJvEsrSrbaijwLGNuRLR6XLZdGOhQzX+DZ8HzhQXC8Rx9Ul
	 /on49AiUe2QKc2YyG6xCpLjxin7bZzpFqQel/LEZ0285HXQOR1r4QDbCT9lRA4tZMD
	 2y9cE7gBjkr4TLVnmc1KsdK+xoGa91LAwW54WWWewIKpdP7GtkPbaNxIYLewiPCkLx
	 KoHg/xDGF207duMrDm+lGLRPyMv1wYHI9L62aLf7ws+43LtQw36A+BIOBTUCJnVOop
	 QEbzHEPTzn9uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	James Clark <james.clark@arm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yang Jihong <yangjihong1@huawei.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 392/715] perf bpf: Clean up the generated/copied vmlinux.h
Date: Sun, 24 Mar 2024 18:29:31 -0400
Message-ID: <20240324223455.1342824-393-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@kernel.org>

[ Upstream commit ffd856537b95dd65facb4e0c78ca1cb92c2048ff ]

When building perf with BPF skels we either copy the minimalistic
tools/perf/util/bpf_skel/vmlinux/vmlinux.h or use bpftool to generate a
vmlinux from BTF, storing the result in $(SKEL_OUT)/vmlinux.h.

We need to remove that when doing a 'make -C tools/perf clean', fix it.

Fixes: b7a2d774c9c5a9a3 ("perf build: Add ability to build with a generated vmlinux.h")
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: James Clark <james.clark@arm.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Yang Jihong <yangjihong1@huawei.com>
Cc: bpf@vger.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/Zbz89KK5wHfZ82jv@x1
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f8774a9b1377a..116db7874412d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1167,7 +1167,7 @@ bpf-skel:
 endif # CONFIG_PERF_BPF_SKEL
 
 bpf-skel-clean:
-	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
+	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
 
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
-- 
2.43.0


