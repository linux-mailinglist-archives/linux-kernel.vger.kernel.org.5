Return-Path: <linux-kernel+bounces-114961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7887B888C34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB25298238
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDAC2DE244;
	Mon, 25 Mar 2024 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN4ROJxG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679A131185;
	Sun, 24 Mar 2024 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323682; cv=none; b=uXyT6ys7N8FPmqRO/OrHGB4DwLfZ/Fcw4PbBOOyS0emszGEj5wzygnKJ73AWyujMn9ldodse1Hf+U4yPqzTxgT3bwUiq4VaV6dU/6b6fwaM2LhGTUpWjtvgRqZGFQWZxMcC+ul6MvrlS3FKOjI8zxjqao6mcSslybajJxrOb7lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323682; c=relaxed/simple;
	bh=3W3lrsoiKgSnvKawyn3EkiTNZnvZyA3ktpieySWGVB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsULYoXOtQmJsZbaLHE57GstOhvsG3cvg+gKXyZqH8w3+zFh/TJ1ViWqnprBRZzG/uRweLD4YLJR+zybEyaVSIRx0SPcUcRJCuc2SXGHZYXM5Y1me4WWpdhqlPIcUXsC51R2+t4bgxVj14aAZqk/IFk7KFexlsdhRIrbhANa0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN4ROJxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71252C433A6;
	Sun, 24 Mar 2024 23:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323681;
	bh=3W3lrsoiKgSnvKawyn3EkiTNZnvZyA3ktpieySWGVB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SN4ROJxGPw6f4yvyik0ZJSXGu9KlCT/5C4c0BFmdSd+yIkeRjgsEE5tW1btkFFppP
	 h6xIh+txxbE6HVLEnQlNtsMg8qu2CoQdNINsM8ru1olUmPnQ9nfRHK49huTqi0JveL
	 BQX1F1CCHIAKHoSh82mo3KoZcluc4qrASe5w+UqJbbsUPHafXiNaBVFF3/620Q0J17
	 8gWHXKlTcOXjLAtQRSwwdDarIKghnjutVqhAkvkFiEpjLMhjNWXQej9sogtc378ezV
	 5JQ6h0yDZzmbUd68FyTxHCvBN1pZN68zIa+I2Q+YKKakVWf6ZQ1yjuj5rQW0L5n+Kl
	 NuzteogEJu7qQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 053/238] bpftool: Silence build warning about calloc()
Date: Sun, 24 Mar 2024 19:37:21 -0400
Message-ID: <20240324234027.1354210-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index d2bcce627b320..d07996e7952f3 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1946,7 +1946,7 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 	int map_fd;
 
 	profile_perf_events = calloc(
-		sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
+		obj->rodata->num_cpu * obj->rodata->num_metric, sizeof(int));
 	if (!profile_perf_events) {
 		p_err("failed to allocate memory for perf_event array: %s",
 		      strerror(errno));
-- 
2.43.0


