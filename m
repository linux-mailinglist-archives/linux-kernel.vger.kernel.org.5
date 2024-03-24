Return-Path: <linux-kernel+bounces-115810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF1F889807
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14461C312CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5B7374707;
	Mon, 25 Mar 2024 03:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cvfg0FNf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830C14534E;
	Sun, 24 Mar 2024 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321995; cv=none; b=t2tqqTTTq9z2O3AtwTYhlC0wMP1yJ0L4UIjQNT2jyKnaC0gLkEmEfCmD/ZblkxGEuv/p36eYla5SRlMFKKRWFsYhlJAeyfJKTybh9MhUvySxMmgVukz6vM1P1LGK1n9ze5niuI2TM97fGHcUe4KyyloHPNJqeaOYB3TI5nx8UZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321995; c=relaxed/simple;
	bh=c/8ThzkfXePMKSUnih7WKsu2s/C2H5smRXIfTXnLdnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Du9e7vv4gmsyGdmBZUd2TZJeBzBlYCMPbDvWt9sMZRXFYTGGWCY3fu7EbW5Ww8VEXi0Qkufuf7i/pxObH15tmmp/NiMUJQmdkWTLJbrMN1opG8CqQ36xuN6t1FbQE7zVdmxE5+JOMVnRcdp7n1SeMNdjxxoAB7NySuEFe1ndxIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cvfg0FNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCB2C43394;
	Sun, 24 Mar 2024 23:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321994;
	bh=c/8ThzkfXePMKSUnih7WKsu2s/C2H5smRXIfTXnLdnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cvfg0FNfl+qKRvLQDwVj+hw+wjl4O4hLzxanav+ekWMH84oz4hHd98P3LUYHZ9TQo
	 dRLdScsejb0xMHbO/bDqu1VTIIvvVXASOUp5Foam8bsJ9DM9l7ORylf0bPw+Gsnz8C
	 yBuSK4l08UGUcKNkiXcyI7Zl7rLJmm3G57zcA2LJYLHiX1mGg9KWyuOZG/wSrym7TV
	 PduSKoeUDGFOBG/jnTKuhYOuJAc+tOovK0CB5pFvj+3CQCR3i/PuDjmNthaXZofYhs
	 N+NEq0er58IBUrNSLmlTMp9BHc28G6q0F6LDUJaMANz+yJefftm6JsJytO19KVjNbm
	 o9X4UBl8zYHzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	Andi Kleen <ak@linux.intel.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 066/451] fs/select: rework stack allocation hack for clang
Date: Sun, 24 Mar 2024 19:05:42 -0400
Message-ID: <20240324231207.1351418-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


