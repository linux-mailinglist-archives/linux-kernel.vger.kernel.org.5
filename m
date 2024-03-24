Return-Path: <linux-kernel+bounces-114280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5580888990
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76711C28070
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C303116D30F;
	Sun, 24 Mar 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHP6LDqb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297820D5EA;
	Sun, 24 Mar 2024 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321651; cv=none; b=RwUAk3XFKsLFMHL8/EZ/se04+T0tX0qPAIal84hKFN4OzSzlBAN/7/VhLaHLZugZ1pfF9jfdIR/8b5a+YqoJ2R5KXT6XYMeyKPBqLEoAsQh2bIBSFOOZNCLJtZ1id70Xed3nkYDY05nHOpPPU3BaUTQJW7Q+tRzdj7DlumeO2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321651; c=relaxed/simple;
	bh=zAJBru5Y6lcMbpsk5V/l75jABud2pBNnY08/Lc4M4HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlQP89U+ClzEuWGzfTKG5EOuD2OdF87bf8P7i41X0Ije6DpUNOAZoacPnmHjCJUAWHGJ6TzhH09Zs0xUCX3lCSL3Y922ktAFP+gTPeJ7Sv3oEhfM+PlkqzFtx6lcd1zzDjY3lElFppCxD2tX3wHMh/SXeZF13KiBpfLs3nXEkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHP6LDqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2024EC43394;
	Sun, 24 Mar 2024 23:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321650;
	bh=zAJBru5Y6lcMbpsk5V/l75jABud2pBNnY08/Lc4M4HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHP6LDqbWO/UtACAC5GJ9oidG6OEV5pJF8us+3Eu8Yk75aWRereIwJ+rm7H6a9zGa
	 5J+PcqJu9C69efzJbrFPKDMxqVTIzKGdOHHXq3+fZiRaNSXDZNCkoGnWsMs7lpJQXl
	 IpokgXg9ovFoUUreloiUptKPbgZImzjMrcqV7VqaeUZaytTCHaaABlUTqnb64dsZuP
	 dznUI8WUHuxlMMiYwEgvfEmncNf7xHtTjLrsMl9+cZS7Qp3Vb3NWZNAi2H6xU/WX6q
	 NFoRtJPOi0dNZpf4yOrHJdZ3NpuQ5TggvTTdb+skosDZR3K1xxtrqUfVFDuP09IRME
	 ePqkrzQ7p9ivw==
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
Subject: [PATCH 6.6 379/638] perf bpf: Clean up the generated/copied vmlinux.h
Date: Sun, 24 Mar 2024 18:56:56 -0400
Message-ID: <20240324230116.1348576-380-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 86569f230e60d..b97224a8a65b9 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1127,7 +1127,7 @@ bpf-skel:
 endif # BUILD_BPF_SKEL
 
 bpf-skel-clean:
-	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
+	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
 
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
-- 
2.43.0


