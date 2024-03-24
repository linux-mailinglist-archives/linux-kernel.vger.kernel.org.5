Return-Path: <linux-kernel+bounces-114110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041F18891F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D18FB39FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6457548FE;
	Sun, 24 Mar 2024 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElpfObrK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D41C1E7DF9;
	Sun, 24 Mar 2024 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321413; cv=none; b=YTgBzfJ6TPthUF1dUG+mWAbb8sAq2+70nvR9C+0NJT31WOyxSKWkTsg9AHxWcru/BY2AdolcMkoiS8bxf3zEUDvG7KyPbCCy2Re36b8yD0Lo1p3ZX31zgpCB3NPCuW+W9QIbfRX4C7V5SjnGsn0aoW69ZKMU0fUKRwjBTSpiZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321413; c=relaxed/simple;
	bh=SBJsl+c47cwJwfj08dBiX+yFg3l4n9qSHc84TASHw6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9M4/PBh+JsyKneV9psAJA5hjiBIduKKLVrENTm8q3Tkhp+Vk5p5r0wO1TpLs3ONf3Rn/DQUHTStRIkTk0YNhECRbBoMVll/kPoXBgwJdoH8TAG+AFua7PkEbh82vMIY8VMAMNnQLJy/d/rf7xArFbSQ6JW+jUlSNlKkY1+EL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElpfObrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DBBC433F1;
	Sun, 24 Mar 2024 23:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321412;
	bh=SBJsl+c47cwJwfj08dBiX+yFg3l4n9qSHc84TASHw6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElpfObrKYOM8DyqI+iyFMbiy4xlneOlJLFPrrfnw3HtRpBFca32bORgy8Tgv2Ulxy
	 aLTp5cQ/tz+HEb5sFxqu82WCsvytzCVBzD624tGsr0tnZdCPdHoLWPCNCPxJs7FXuW
	 edQQBYU1m3+xxCp4i5idpdFivku3+az3kYa/DCHsSFPSmSTe7jrI5kPzMl0x8dzAdc
	 IVz6VafvaxVdqeZUrE7+UMmvCRXgITPogpG0ZF14N32uY2fytulJa9R1YXPs0nr6k5
	 hISKjxdLINOrp52IMYpHHfA2z3Z/VZiNNRjis5jLwUh7l6awzxDk/suV+WkfsZV/5o
	 sMKhIhuBJO7uA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 136/638] bpftool: Silence build warning about calloc()
Date: Sun, 24 Mar 2024 18:52:53 -0400
Message-ID: <20240324230116.1348576-137-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 8443a149dd17f..f186f1cee465b 100644
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


