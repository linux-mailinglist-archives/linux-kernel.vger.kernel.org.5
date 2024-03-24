Return-Path: <linux-kernel+bounces-113825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A57D8886CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56720280CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B7A20013E;
	Sun, 24 Mar 2024 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRLttMB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A31E6F7B;
	Sun, 24 Mar 2024 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320862; cv=none; b=SkAt+AVOrM4GbbcFpMNwLg+yUznr2ijfY7hqoNIJR4r8FHyObeFlPBBH5TFNWxM8oZic9E3RxmuQQlpswiRax+b+oAIuwmtJY6qtWgwOG7d/xxrR+hOu6nlhgHyaC2EGtxN679C3JEsEHz0P3ioo+F2rlQwSVSk0CSrWcRJTMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320862; c=relaxed/simple;
	bh=DmHL2s2aNhW573x0aObu6nLA5eBAXAtj/L9r7KCQk1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xar2OA4OT796wrYIzoIIlCgsjHJZ8OXiaqvZwHD9VfJYjlibR2wGt7bUsbjVi8fnaqPUgimIuOQOLvoFoynh9S1GOL/deGD1bc/wYufNM7GNSn0pZWuwEJB/0EUMq3QzbTpfAt+7rrxo1mNCsoALaOAWNELsCmuvVkZdMYglqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRLttMB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E26C43394;
	Sun, 24 Mar 2024 22:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320862;
	bh=DmHL2s2aNhW573x0aObu6nLA5eBAXAtj/L9r7KCQk1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRLttMB3ZuqKkg63Fp7U2lgm2OQWF5iFeoP6byzWjn85fq6R3yGBLCgU1DAWC2FSd
	 ecMfApDOHgwYo4RZjt4Up66bg9+k7GrHTwYwjn8Kh94775g/83mJ22SuNI3BYolKaA
	 adxZhCBtpjCOoAqvotv6bljczDa70yoaFmUxvlfex4QrzAA7U3oBsb4V23QqvdgXEp
	 R4DI9O11J0UpM9QrrM8qQtwc9Jgez/x3poMW2O4EaKDKsEapFE8G+hlW16Z0IWfcCT
	 fVqlwPF8Dueqe/+GPef1KBjT1slr9XWfg+zODaerJ2wlZD0ol8kZyTDew7XfEDYYyP
	 FNLrHB0v4IxGQ==
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
Subject: [PATCH 6.7 426/713] perf bpf: Clean up the generated/copied vmlinux.h
Date: Sun, 24 Mar 2024 18:42:32 -0400
Message-ID: <20240324224720.1345309-427-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 058c9aecf6087..af22d539f31e2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1148,7 +1148,7 @@ bpf-skel:
 endif # CONFIG_PERF_BPF_SKEL
 
 bpf-skel-clean:
-	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
+	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
 
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
-- 
2.43.0


