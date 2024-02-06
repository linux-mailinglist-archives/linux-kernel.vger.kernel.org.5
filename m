Return-Path: <linux-kernel+bounces-54740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CE084B314
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089D91F24897
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DC8130AE2;
	Tue,  6 Feb 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGTxcVLx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A26130AD3;
	Tue,  6 Feb 2024 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217555; cv=none; b=imfEcmbWovZkCAyHb88spnYbHFt4PoWi+Z0FOf8y0NfdNuc/ZLf0g42yCdXydzZOhiquRuHzvZtQ/OX9Mj3l4WOJhS2eODuuqnkfvzBxqnh9NT+E8SIUT2bW9RCqzXL3imBQeDiVqoG20s9bEO4msKViBCzmvEuFDfCX30tja10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217555; c=relaxed/simple;
	bh=rDmpciVOtng6F7rfQEs1JlIM6VsqeY8XNBiItpt3u0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOaut82lchQs/3UPZS4znraoxV/7XrqqXhEiqYXqQyETEFmF3fN1YwpSijDBg4/Iqn5CV6hUtpjFk3S5P9vKnZDGpe65uDqHfsFdl+2i1V8zte6DsGoogQCEvcx8PyXAt6H/ASguN5CBMthxXxHLGfc3HXMSzZtGW6NSH6qjxfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGTxcVLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4DBC433B1;
	Tue,  6 Feb 2024 11:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217554;
	bh=rDmpciVOtng6F7rfQEs1JlIM6VsqeY8XNBiItpt3u0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGTxcVLx1FDdDingKcw57Mv7aaoCD1DBkey/KBRNxqwFqI5QwnsMNNwYez38KWT1R
	 iGjKkGNQUJNL/0H0PC5LaijC5i3ai+UsENlOe8KWHw3JKg96rieo1KNV+6wAJWqXcF
	 sQiHZXTr3horKlqnshJ8Eb+X/NizW/Do2rH7G1xpRsBK02xDSiA6tjSJgE5cb9G8Ib
	 9bd/jHhQOfvZl7cfBoq676uY8FKex0PjODw/MRHbfbkk9qTirD+f2FWGtWD7vdQcVa
	 Lajc++Ir9dNnkvvN2q2vaYB/14qDS7BWOaB98fKvT67NgER85qbQr7xq2jWSyIJyn/
	 7IyhHwftf8hOQ==
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
Subject: [PATCH 4/6] tools/rtla: Remove unused sched_getattr() function
Date: Tue,  6 Feb 2024 12:05:32 +0100
Message-ID: <eaed7ba122c4ae88ce71277c824ef41cbf789385.1707217097.git.bristot@kernel.org>
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

Clang is reporting:

$ make HOSTCC=clang CC=clang LLVM_IAS=1
[...]
clang -O -g -DVERSION=\"6.8.0-rc3\" -flto=auto -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection  -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS $(pkg-config --cflags libtracefs)    -c -o src/utils.o src/utils.c
src/utils.c:241:19: warning: unused function 'sched_getattr' [-Wunused-function]
  241 | static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
      |                   ^~~~~~~~~~~~~
1 warning generated.

Which is correct, so remove the unused function.

Cc: stable@vger.kernel.org
Fixes: b1696371d865 ("rtla: Helper functions for rtla")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/utils.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index b998b24edf1e..5fcd6495ff05 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -238,12 +238,6 @@ static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
 	return syscall(__NR_sched_setattr, pid, attr, flags);
 }
 
-static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
-				unsigned int size, unsigned int flags)
-{
-	return syscall(__NR_sched_getattr, pid, attr, size, flags);
-}
-
 int __set_sched_attr(int pid, struct sched_attr *attr)
 {
 	int flags = 0;
-- 
2.43.0


