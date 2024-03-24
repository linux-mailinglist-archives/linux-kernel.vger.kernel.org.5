Return-Path: <linux-kernel+bounces-113634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA99888E30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E41F2F13B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241A91D697B;
	Sun, 24 Mar 2024 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx1I6V8S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690C81AC4;
	Sun, 24 Mar 2024 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320542; cv=none; b=puAM5w+h1GfqhkqaGWyhP5QA42EcAh5xJsd9Rj3HGAsD6eS18kL+Ke1j8kg0BYzPE8YhKhcAI3TLvDKgifehR91+dJBYF8ZaIJ8pLwu0s4N5G9/ctYRtSwQYIOP6xWhBQSBBejQlgiqyPk4oLao8mxRoY7LLb12Ddi0fe2OBUjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320542; c=relaxed/simple;
	bh=c/8ThzkfXePMKSUnih7WKsu2s/C2H5smRXIfTXnLdnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDTjPqOWV0LNId6hi4+gYSSRyFn8Hetc4320BjkBbC85ty3EgpnVYr5jJuP0BaPWaUQgrsxka/aJLtymjFzO+m2G7OGxH/4xk/QrYx3l0+opq8g/UBhOKhCuv3fuVk247A8DeIO18PC1hYWb3dRrGfW4yoN3TOsnsofhNdZOV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx1I6V8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00504C43394;
	Sun, 24 Mar 2024 22:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320540;
	bh=c/8ThzkfXePMKSUnih7WKsu2s/C2H5smRXIfTXnLdnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zx1I6V8SZhU5lPYPsb2DoXt0nt+lNVe68ymZwsD9ZkexNhxl248Uug2ovtvNQ3P/Q
	 1ElvFnqnxyXsbD84zYnq8+rXBjdDgM/iEfJLh9PO/8H5l9uyHtpMBqhzb52HpezHDn
	 LJFTJWNLYI31jygyMlp7SAOlVMpBzKLN03nXgOPmNKn/KMlSI71GkO2I3//60S7mQk
	 GC/ZqYiCIUxmbElYzV9W3fAQuJN4vTe2074huHKvKdrmC1iJ/+QlLU1JIER5foF85N
	 ou9RY20LzyXCEELeBMjpkSdBaE/0aKuRZydPni8K3HvmnxgGUOlsxYqJQt7eEj6zNv
	 7IMhIMSJZIpYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	Andi Kleen <ak@linux.intel.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 102/713] fs/select: rework stack allocation hack for clang
Date: Sun, 24 Mar 2024 18:37:08 -0400
Message-ID: <20240324224720.1345309-103-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit ddb9fd7a544088ed70eccbb9f85e9cc9952131c1 ]

A while ago, we changed the way that select() and poll() preallocate
a temporary buffer just under the size of the static warning limit of
1024 bytes, as clang was frequently going slightly above that limit.

The warnings have recently returned and I took another look. As it turns
out, clang is not actually inherently worse at reserving stack space,
it just happens to inline do_select() into core_sys_select(), while gcc
never inlines it.

Annotate do_select() to never be inlined and in turn remove the special
case for the allocation size. This should give the same behavior for
both clang and gcc all the time and once more avoids those warnings.

Fixes: ad312f95d41c ("fs/select: avoid clang stack usage warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20240216202352.2492798-1-arnd@kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/select.c          | 2 +-
 include/linux/poll.h | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 0ee55af1a55c2..d4d881d439dcd 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -476,7 +476,7 @@ static inline void wait_key_set(poll_table *wait, unsigned long in,
 		wait->_key |= POLLOUT_SET;
 }
 
-static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
+static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 {
 	ktime_t expire, *to = NULL;
 	struct poll_wqueues table;
diff --git a/include/linux/poll.h b/include/linux/poll.h
index a9e0e1c2d1f2f..d1ea4f3714a84 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -14,11 +14,7 @@
 
 /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
    additional memory. */
-#ifdef __clang__
-#define MAX_STACK_ALLOC 768
-#else
 #define MAX_STACK_ALLOC 832
-#endif
 #define FRONTEND_STACK_ALLOC	256
 #define SELECT_STACK_ALLOC	FRONTEND_STACK_ALLOC
 #define POLL_STACK_ALLOC	FRONTEND_STACK_ALLOC
-- 
2.43.0


