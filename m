Return-Path: <linux-kernel+bounces-115415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEEF889B73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0811F3661A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42CD2062F9;
	Mon, 25 Mar 2024 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKH+FQtE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075D142E9D;
	Sun, 24 Mar 2024 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320594; cv=none; b=t33ASXxezsxAhHC6zpNvAaoPxZk+Q+SskdQPiqJjlqxnGQVlWTOeFgSDtv1O4N3HYcOm0erOifpkC6uISFOOIjGM6pNNurtlC5wzQkn8033ynuIbBMGshnrWJoQdQt03mNzB0O79zSHGUKSnZXkOcK9RHIGhscIXDi9VOpw1Psg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320594; c=relaxed/simple;
	bh=L+q+T23+1lW4C5N0dC7461f4F21LtGdi1jiX4zsCkTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVsCndQ/b8GjjkIYe6WT9TwFCdRacY0viK6JHZgavKKyB6PUox4TZJVpMx9JvvHjke/HTO1YtCNsIMDI7WhubVN94EpYQee0JIVajQDFcWvnnt6poCx23RodeKMIURr/DzwSaAoOFxxzB+mA2ICv+nFPsYKPTZj8xLjQDMhTfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKH+FQtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16006C433C7;
	Sun, 24 Mar 2024 22:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320592;
	bh=L+q+T23+1lW4C5N0dC7461f4F21LtGdi1jiX4zsCkTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKH+FQtEXWvmk5Kq27yjiq0XAvxMHi+1VTb3gveiV/eyEhFhWoxqR5V5zk/6ialau
	 +XuZM4/fH4B3pCN4rjQizx+iXuUQSC21g0tJlcx+TEULpRkfcHNGL/MaKiVg5/KGn7
	 FISE4jtPPAdqsyMlhqteIaMvZg6eB0DXjwN6f8EG3FUwbQq9SSUIoLCST4FKvFHQTL
	 5iTkRTq7jeAg2ZCBKCzMsyr+51gB4ITpeWsb0gadHqst2H2AgepEHTxfwNR8+1qkkm
	 EH6s3mgJwAxcOMoJmhvlz8wvwTZ2ThxGT6Thr4wqdEp5YHsQRXx0K+QIJ+aj7P7Iwd
	 DIveLL4wG/qSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 154/713] bpftool: Silence build warning about calloc()
Date: Sun, 24 Mar 2024 18:38:00 -0400
Message-ID: <20240324224720.1345309-155-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 7ec4f5671e7a9..865bfa869a5b2 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2294,7 +2294,7 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 	int map_fd;
 
 	profile_perf_events = calloc(
-		sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
+		obj->rodata->num_cpu * obj->rodata->num_metric, sizeof(int));
 	if (!profile_perf_events) {
 		p_err("failed to allocate memory for perf_event array: %s",
 		      strerror(errno));
-- 
2.43.0


