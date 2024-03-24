Return-Path: <linux-kernel+bounces-112970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA12888027
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8301F210E4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2D912A154;
	Sun, 24 Mar 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD2x00qI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F177129A9D;
	Sun, 24 Mar 2024 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319782; cv=none; b=pQwI4nFVO+Slz7b8+cIsVPTr+xSq0AsmHvIOu/WMA/5eqysD4O2Agu3D5lV/fh8N6W3OG4OlQ6My4l5bDMoK+rjJ47NsJ6nedeJ9fvbG3ERjzxXIlLPL6zOQwp/8UkGrSBbEfeP2BFYrsuNb58Bu5uoI3M23NdlBzjvttYdDbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319782; c=relaxed/simple;
	bh=YSBl1ZyTFCq6mOKswwz7IpYku0zQ+dj1+kqQKD82ROc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D22Q7gCkCWhdE39yGRXVFq+gjTet4oKZ+lpAwpeCuCjsXq0VY8pDN9UoGwTv+y4VEGm6rXfJ1vrrk1B7CGMik7IkxlOpPSDj48GOMXTlTYLYBYR+vbEmR9ZewtqC/GIz6Uvioxxmqp6BnJYaDzpI0G78ZjUDALKjjhfWevAone8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD2x00qI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51005C43394;
	Sun, 24 Mar 2024 22:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319782;
	bh=YSBl1ZyTFCq6mOKswwz7IpYku0zQ+dj1+kqQKD82ROc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YD2x00qI2Wa6poLYwq9HXMy/WnBy3O3ji6C0g7msux9P9Y88GS3F6HH8VwpZ7BT9H
	 RIhAguaANMpjzE6b4A4i3DPsli37npB/iQoLnGqW/iTdgDX8UokpO+gHJRaWCd6i4b
	 lIMVHaiTQCghCLb6AUqWxmjpSAOClYszx1oamhanDtyNQOgpNryQQo6QWbMyoAEnpP
	 EDCOt6Uq6LwoyqXFkkIqL2iSbrHKqEMr2N4UJmMCbUxiz40geu6F16KuhQGkZImv43
	 HBHk14ofbum3eQK6Fr1kL3AOIq62gIBPgRQG4Md2VK7l1J7FTBzCgJZVvYhYyPMoF0
	 GgXeRalQDQ6fA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 083/715] bpftool: Silence build warning about calloc()
Date: Sun, 24 Mar 2024 18:24:22 -0400
Message-ID: <20240324223455.1342824-84-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index feb8e305804fc..9cb42a3366c07 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2298,7 +2298,7 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 	int map_fd;
 
 	profile_perf_events = calloc(
-		sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
+		obj->rodata->num_cpu * obj->rodata->num_metric, sizeof(int));
 	if (!profile_perf_events) {
 		p_err("failed to allocate memory for perf_event array: %s",
 		      strerror(errno));
-- 
2.43.0


