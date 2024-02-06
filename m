Return-Path: <linux-kernel+bounces-54742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD07F84B319
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF83C1C23DC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA681130E47;
	Tue,  6 Feb 2024 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNAk/p1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658012FF81;
	Tue,  6 Feb 2024 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217561; cv=none; b=aFvfGrrHIDiuprtLGP7Nv4ha/lz1TkLxdVxhFzL2sYzFeNQvHmXk+qG9GtQed4Vyl+eDnK8PRi2+a8NodyiZNFmTHyoT2iQY1Nczk0sYE+lJndn5075GhCMF0pBjmOHObNvadiMfBzu9ge2IvRZLhvzbcRyjmfIagv3w8Op8gtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217561; c=relaxed/simple;
	bh=cQILpcsc6/caTGhPuQvyIMhE5e7gEUIcuJuq7dS5DzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLYTYQYqMfBKZsz3gdhmpp9nnQY8JYPlMyyWI5eAGxC0aByAXmstW08eFMsMJ5w84+QBAIUVlJzXiLKxR7SmJGdwz1RrBiOXQ3HxFpu/J7fFB+vwuebZ7fzjQUUD0ry2RlHnQ/0hOm9T/Yy0WPbxk5yN1eJSW0pZbxsPgJXCPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNAk/p1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5329C43601;
	Tue,  6 Feb 2024 11:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217560;
	bh=cQILpcsc6/caTGhPuQvyIMhE5e7gEUIcuJuq7dS5DzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNAk/p1hqgs2qNxzkK+RBgTpAM/VFwbYgtnM1c9lb2Q0rHMldJ//ypQTGqDSsrpN7
	 LKIkesoHrymKbLwrTuySqv5SFslmDqjKFSxqAPjtj5yYwjb9+5OcPgASS+DzKrfUzz
	 IiVFuT035jqlqg/ODAxaQz0L9qJsWNkb5zISWh5XD5MCTy0PF8IKAyA0GirkYmKTZj
	 5Tr5aOmH+/n6sf2CfSH971A+AI8VKXVon6ulwAiCiCh0xw5ID4XBOeSMHdCdR9b0Rq
	 M/RGvSjW2/M6ZBybWKK9tYvmnM1BmqBHRcCKCc3sJt8uzO70UA02Dch37aIpTskk6b
	 NGBxluCDET6/g==
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
Subject: [PATCH 6/6] tools/rv: Fix curr_reactor uninitialized variable
Date: Tue,  6 Feb 2024 12:05:34 +0100
Message-ID: <3a35551149e5ee0cb0950035afcb8082c3b5d05b.1707217097.git.bristot@kernel.org>
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

clang is reporting:

$ make HOSTCC=clang CC=clang LLVM_IAS=1

clang -O -g -DVERSION=\"6.8.0-rc3\" -flto=auto -fexceptions
	-fstack-protector-strong -fasynchronous-unwind-tables
	-fstack-clash-protection  -Wall -Werror=format-security
	-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS
	$(pkg-config --cflags libtracefs)  -I include
	-c -o src/in_kernel.o src/in_kernel.c
[...]

src/in_kernel.c:227:6: warning: variable 'curr_reactor' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
  227 |         if (!end)
      |             ^~~~
src/in_kernel.c:242:9: note: uninitialized use occurs here
  242 |         return curr_reactor;
      |                ^~~~~~~~~~~~
src/in_kernel.c:227:2: note: remove the 'if' if its condition is always false
  227 |         if (!end)
      |         ^~~~~~~~~
  228 |                 goto out_free;
      |                 ~~~~~~~~~~~~~
src/in_kernel.c:221:6: warning: variable 'curr_reactor' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
  221 |         if (!start)
      |             ^~~~~~
src/in_kernel.c:242:9: note: uninitialized use occurs here
  242 |         return curr_reactor;
      |                ^~~~~~~~~~~~
src/in_kernel.c:221:2: note: remove the 'if' if its condition is always false
  221 |         if (!start)
      |         ^~~~~~~~~~~
  222 |                 goto out_free;
      |                 ~~~~~~~~~~~~~
src/in_kernel.c:215:20: note: initialize the variable 'curr_reactor' to silence this warning
  215 |         char *curr_reactor;
      |                           ^
      |                            = NULL
2 warnings generated.

Which is correct. Setting curr_reactor to NULL avoids the problem.

Cc: stable@vger.kernel.org
Fixes: 6d60f89691fc ("tools/rv: Add in-kernel monitor interface")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/verification/rv/src/in_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index ad28582bcf2b..f04479ecc96c 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -210,9 +210,9 @@ static char *ikm_read_reactor(char *monitor_name)
 static char *ikm_get_current_reactor(char *monitor_name)
 {
 	char *reactors = ikm_read_reactor(monitor_name);
+	char *curr_reactor = NULL;
 	char *start;
 	char *end;
-	char *curr_reactor;
 
 	if (!reactors)
 		return NULL;
-- 
2.43.0


