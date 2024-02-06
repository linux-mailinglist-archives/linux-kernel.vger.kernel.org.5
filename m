Return-Path: <linux-kernel+bounces-54739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E2984B312
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFFC4B26702
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE02D12FB3C;
	Tue,  6 Feb 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWvy0TH6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22112FF76;
	Tue,  6 Feb 2024 11:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217552; cv=none; b=EPYKXp91RrvGyMwZY0DjL4rsaTh7X+FpZVveQz51rXe+93DWREGEmYTVsMJ1MmKqbd6c0kWOc9EXV02jCJzGlhEaB00YjgwCcLEM6RRRAsYM9KBR7R6opvn4C1aVN8zz4tM+xj9T2MbZWphYsOEKLChqh6aWIxoaO9FeNwW10wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217552; c=relaxed/simple;
	bh=HBpkihUOz+42qTZ8E70fvuC94UrnuMtLk3YD9XXg8zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MO7a6/9IFYc0qHhdKGvORfTX0NK1WESqqTYPa9iiZnHGNHIboaO2hlQGjRhv6vWa76mu7S7wvi6oExTEIIdhZ/FwRHGxrK3d8RXRcUGvEyjE9/5wgcV85e3G4BoSr9muufk7G7v48bKNm6ehS73yhE5qSe5+XGW+zxId2UNqneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWvy0TH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F89C433C7;
	Tue,  6 Feb 2024 11:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217551;
	bh=HBpkihUOz+42qTZ8E70fvuC94UrnuMtLk3YD9XXg8zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWvy0TH6y70WyLpUralBEy1uvKuZYhREElojJQhvCasstwIFVA6ZDTE3y2ZhvVnf3
	 Uvg/RBvyK7RRGTSI3dU1S5Mu9YS5yTRt7zy7P/kScj0CeSKOaduC4l+lQ2zqzzKBt7
	 EW5b10Br+lMZJ+yp9TDtxhlq64u+0ePeOWOxFfJq3k/LhKhvTaevgTzUKjdRb7nqCw
	 fN7JdlbEDUcQm89rxay+oxj7kyKk9IB4z5MdrVmyWu91xVk33aEnPKTbQKCwi1gVKc
	 mgyEPNSFKKjUJZg+AHkXW73VMoL9iuRGe+VOWkogskl4IOOLKKpLOp1RiEdwzccEZg
	 ToL6obNvwEUXg==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Donald Zickus <dzickus@redhat.com>,
	stable@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 3/6] tools/rtla: Fix clang warning about mount_point var size
Date: Tue,  6 Feb 2024 12:05:31 +0100
Message-ID: <1b46712e93a2f4153909514a36016959dcc4021c.1707217097.git.bristot@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707217097.git.bristot@kernel.org>
References: <cover.1707217097.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang is reporting this warning:

$ make HOSTCC=clang CC=clang LLVM_IAS=1
[...]
clang -O -g -DVERSION=\"6.8.0-rc3\" -flto=auto -fexceptions
	-fstack-protector-strong -fasynchronous-unwind-tables
	-fstack-clash-protection  -Wall -Werror=format-security
	-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS
	$(pkg-config --cflags libtracefs)    -c -o src/utils.o src/utils.c

src/utils.c:548:66: warning: 'fscanf' may overflow; destination buffer in argument 3 has size 1024, but the corresponding specifier may require size 1025 [-Wfortify-source]
  548 |         while (fscanf(fp, "%*s %" STR(MAX_PATH) "s %99s %*s %*d %*d\n", mount_point, type) == 2) {
      |                                                                         ^

Increase mount_point variable size to MAX_PATH+1 to avoid the overflow.

Cc: stable@vger.kernel.org
Fixes: a957cbc02531 ("rtla: Add -C cgroup support")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index c769d7b3842c..b998b24edf1e 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -536,7 +536,7 @@ int set_cpu_dma_latency(int32_t latency)
  */
 static const int find_mount(const char *fs, char *mp, int sizeof_mp)
 {
-	char mount_point[MAX_PATH];
+	char mount_point[MAX_PATH+1];
 	char type[100];
 	int found = 0;
 	FILE *fp;
-- 
2.43.0


