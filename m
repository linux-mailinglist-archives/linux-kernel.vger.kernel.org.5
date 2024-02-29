Return-Path: <linux-kernel+bounces-86624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B638E86C7F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF5F2858FB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5467B3F6;
	Thu, 29 Feb 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2iUH+Fk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6A5645B;
	Thu, 29 Feb 2024 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205771; cv=none; b=rRIUpi3bQi2rNNPTXfCg9pXowPijF3ls3hQbyY3khoiQg5z1iLsKNTd4T+qKUB9Yo88oNpUMuGqqq0e7K+2FBGyO6uhnhzLXfXDisbZrvT2XQ+H9yMP6dWjvEOZ/f+WdF1nE/tkAXOmFjH6MXnNtKjDyWGa9rZOOjYURyFS/TnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205771; c=relaxed/simple;
	bh=+uuNbdv0lJbIvrDlmMr2gaI2mL9O4H2xUXrrYNBtcrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iomR2dB9+YxB2X5TSXQqZM5yT6/B+orGeZgqgQueZFlpyOOkBfhzXUmHRhvogK0ZNBR/Rnn24JqJbb1rmeOGnm9r8cm9eIqUySv1yNAEEQnzrip8tx3xEs12l2Ct9rOADx5BkuV78FA5+eFkN6iVjBhH/BxMlFcB3zUM69mVtEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2iUH+Fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C68AC433C7;
	Thu, 29 Feb 2024 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709205771;
	bh=+uuNbdv0lJbIvrDlmMr2gaI2mL9O4H2xUXrrYNBtcrg=;
	h=From:To:Cc:Subject:Date:From;
	b=X2iUH+Fk6aUrIE/zool+oaGs39saCKlIpbnrWIbUXX7r2XzjSqpoHdc8obAmJnILk
	 lJJ+8G+TNHhgmpKJfDP7hxhEiWsW7V6tppMfEvlQYFt71hu2UTppk6zKuQ90e8SCaI
	 mV8BX9vFpY3Z+mGAhUS8GOBJWOGpmwELxc+VcxVWwqeijrQBj5SlGuF/BpVBltbVR7
	 d/mQ1nH2uef2p1xy2KWOlew3zae5TwymaaqJM5XV2U4Xz8ABwyYcAAbhIiWbAR3dvc
	 e72Yktvf3uc2v7PY+rsTLc0c7hisx78AnTEM0c77j0eJ8sK8h5wT60ru1CradJtQsD
	 ccPMmLQ+d56xg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fprobe: Fix to allocate entry_data_size buffer with rethook instances
Date: Thu, 29 Feb 2024 20:22:47 +0900
Message-Id: <170920576727.107552.638161246679734051.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix to allocate fprobe::entry_data_size buffer with rethook instances.
If fprobe doesn't allocate entry_data_size buffer for each rethook instance,
fprobe entry handler can cause a buffer overrun when storing entry data in
entry handler.

Reported-by: Jiri Olsa <olsajiri@gmail.com>
Fixes: 4bbd93455659 ("kprobes: kretprobe scalability improvement")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 6cd2a4e3afb8..9ff018245840 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -189,9 +189,6 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 {
 	int size;
 
-	if (num <= 0)
-		return -EINVAL;
-
 	if (!fp->exit_handler) {
 		fp->rethook = NULL;
 		return 0;
@@ -199,15 +196,16 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 
 	/* Initialize rethook if needed */
 	if (fp->nr_maxactive)
-		size = fp->nr_maxactive;
+		num = fp->nr_maxactive;
 	else
-		size = num * num_possible_cpus() * 2;
-	if (size <= 0)
+		num *= num_possible_cpus() * 2;
+	if (num <= 0)
 		return -EINVAL;
 
+	size = sizeof(struct fprobe_rethook_node) + fp->entry_data_size;
+
 	/* Initialize rethook */
-	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler,
-				sizeof(struct fprobe_rethook_node), size);
+	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler, size, num);
 	if (IS_ERR(fp->rethook))
 		return PTR_ERR(fp->rethook);
 


