Return-Path: <linux-kernel+bounces-115852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA100889847
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946A929F415
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB80B37C915;
	Mon, 25 Mar 2024 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdSMPKz1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779B535AC;
	Sun, 24 Mar 2024 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322029; cv=none; b=jz4cd3Y5/vLhcncTH53s28COI3A9wZCGyjhzi+JLsVdnv0qUHytwx4ZoJhfN2rnXJHh9nLMVzostb8yHceKzq8nHxgahF6QsFu75kvQd1bhS301JbxzWG1W9kjSAK1a2RFAR6ldCYrcPDjW+OmG+oyAEe4lL3TAG7frSJC6a9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322029; c=relaxed/simple;
	bh=uq/8y/d2mm1LK4gZZU9rrLc3HRKyMlwRIrSKlVi9Lr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuPl6o0PEiyo1HRZDbm1IW2iOEnYEDz0zJZ1G8WtXH9RYTUv/Hzp8qWgj8bGWav10RKk1gGObFbC10Hz168B+LCStGHf0P31psl/nzzLArbcgHqAvMCjh7gftjWg8N38MoR/HerOK7ktH8d7EzBm4SnP1AJh5PNiATgLfdWso3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdSMPKz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9815CC43390;
	Sun, 24 Mar 2024 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322028;
	bh=uq/8y/d2mm1LK4gZZU9rrLc3HRKyMlwRIrSKlVi9Lr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdSMPKz17jVKo+SF1cWfpUxFS+NbvAXyEulrUmLpS+nubpbQ7oPWws6a/UgRFEcak
	 kZHPU5z4MO/WlQbd5cDjylRis4dFFUKaNQ6VUNPiTViEn+y36baVrcLc+s26DiLd7i
	 lu+8696blUtPk8tfK5y2kQ4rL3lWaoogevRk54ZyTwk7ruCwT/e9zraRlbE4uX6XNl
	 ciGfT94KCzqBdLuYLXgooDLgNHpHITeB1cjZKKM76M57o7GpkajVLysejps+/wpc6U
	 eLj7w9kgEQri64guxJZ483USA2zId2iFn1SU4Fa4ZFxw0FCQQBYyob6qQSXzuLBrOU
	 I5JhggFbDqVXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 100/451] bpftool: Silence build warning about calloc()
Date: Sun, 24 Mar 2024 19:06:16 -0400
Message-ID: <20240324231207.1351418-101-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit f5f30386c78105cba520e443a6a9ee945ec1d066 ]

There exists the following warning when building bpftool:

  CC      prog.o
prog.c: In function ‘profile_open_perf_events’:
prog.c:2301:24: warning: ‘calloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
 2301 |                 sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
      |                        ^~~
prog.c:2301:24: note: earlier argument should specify number of elements, later size of each element

Tested with the latest upstream GCC which contains a new warning option
-Wcalloc-transposed-args. The first argument to calloc is documented to
be number of elements in array, while the second argument is size of each
element, just switch the first and second arguments of calloc() to silence
the build warning, compile tested only.

Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Link: https://lore.kernel.org/bpf/20240116061920.31172-1-yangtiezhu@loongson.cn
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 41c02b6f6f043..7e0b846e17eef 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2200,7 +2200,7 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 	int map_fd;
 
 	profile_perf_events = calloc(
-		sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
+		obj->rodata->num_cpu * obj->rodata->num_metric, sizeof(int));
 	if (!profile_perf_events) {
 		p_err("failed to allocate memory for perf_event array: %s",
 		      strerror(errno));
-- 
2.43.0


