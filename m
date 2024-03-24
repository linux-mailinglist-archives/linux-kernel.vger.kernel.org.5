Return-Path: <linux-kernel+bounces-114769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0653C889290
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92784B32A97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0591B1AD7;
	Mon, 25 Mar 2024 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWNlEAtf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1570275539;
	Sun, 24 Mar 2024 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323367; cv=none; b=hW1yOlsBitEVeZROUjVQU8PGQPpAX1uuP8ppZ0Tvr6AhdfY+iV/SoD5WuEsKfXQczve34kGrXVCYtZnG4g2iUe5Av3GdDTVbzKskl/G51V2/rP58sn50XKURZjGbYyCU/wANrK2DXatq9WqpnRjCEX5YwBbGvEwoo2ytxeGxm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323367; c=relaxed/simple;
	bh=k1XW0VZOAX7UoYla65MdW/D5lsy04231QVTFmeLSsgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyxwFRsxsFwlSa1cZQVWz3B6J+V1hHjDeJgY6Ok++QyqXCRuhNERD6Atl1aZOzg37fOr8VghYyWSdxv+O68OYSKW9GhyAf3SS2xGWZJbRlGk7bXdsX3ocrwbvhfXY7fj54UZt6kh9utL3/c5skCFuq7iXH5RPBLdIsusmisZdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWNlEAtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03C7C433C7;
	Sun, 24 Mar 2024 23:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323366;
	bh=k1XW0VZOAX7UoYla65MdW/D5lsy04231QVTFmeLSsgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWNlEAtfzQTSJOYWcsutbx8++a7fdRdsKZLyo94ZeuHuwrDt1P0vgUQdmIAGgFsPh
	 47rSowQwsZcXh7DH7AzeCE+c3dw4Q4Lr5pC3zmZcKfSTFdcrIVV+PLoQYmr22bsD8N
	 8ocXvVGVSyhtmjPUYPoC3u1S89yKldBl3W6+eCGOmPOC8POZx9TtCRb04Rj847wjlg
	 TZjb4tRZi/O1E0A4QctNhQJs9qPW4WH2mpUL/S2o7EdJHBxq5drUuawt21pzzX13rJ
	 yuvP3JoWRJecgSrzMzwkugZZFCcuY0gOExdeggFC/JqQLOeQQHton+u/9Vowi3eFIC
	 Ye8OlBDh39zSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 066/317] bpftool: Silence build warning about calloc()
Date: Sun, 24 Mar 2024 19:30:46 -0400
Message-ID: <20240324233458.1352854-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index bdd4d3b12f6c0..afb28fcc66786 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2098,7 +2098,7 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 	int map_fd;
 
 	profile_perf_events = calloc(
-		sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
+		obj->rodata->num_cpu * obj->rodata->num_metric, sizeof(int));
 	if (!profile_perf_events) {
 		p_err("failed to allocate memory for perf_event array: %s",
 		      strerror(errno));
-- 
2.43.0


