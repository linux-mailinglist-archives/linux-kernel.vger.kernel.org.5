Return-Path: <linux-kernel+bounces-167360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ADE8BA86E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311151C2180F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F98914F9CF;
	Fri,  3 May 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExymHTvj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0C14F9DA;
	Fri,  3 May 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723947; cv=none; b=J9jwaLS36I1uskhQBdPjEf2iBIPvSvOzmgZ+nGPHg7CQk+iYq79HZEg4avm0Y9bw49TvcHh6ZGVABDS+hu9DiuHopQ+rDd8TC/ERurKtGLQs/6xxI+h6GFuLH4Lml6oQVVNijujg19MXxOijzpSFcGj56tVrhqVA2xUSOriFtVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723947; c=relaxed/simple;
	bh=hBY4yzirR+6peUPSmr/L6JeuzaTkaL7zjOUip5Zgez4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PeJqu6Ie8+qJOqcWlO4LBEX6VeCVaSyFjYTMq3xePvAZ7SKMDu1ap6N4q8gGfQP9vmlWuCG0fOIqg+XCpa3pNt06RcldjQJv91yo30ozzVOaxvYHWBSXSVR2gn5vdppu0delDXzMp7nIpO/rpaWvPcSj9n5J7HzPRsjLWvB5f50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExymHTvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BAFC116B1;
	Fri,  3 May 2024 08:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723947;
	bh=hBY4yzirR+6peUPSmr/L6JeuzaTkaL7zjOUip5Zgez4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExymHTvjQ8CJTlsT8pDeCTWElcNO1CBiAhG8iTFM8EjWM6V3mNOwq4K8zwFxF0dFL
	 h5CyAuZBkoghIoiOSwJFHGF18cHqnb3UC0wa3iTSoWvZZfpJEqj0Kx9oeUA0oY9BI1
	 zTU9KigRv+wKyeY96tPbQJ7aADviH3+ucfKceizCwUm5BZeHZzJKFgcWDqDf+j/lB1
	 JJvXNzbaFYqRqhPa4Jq1RCg4Kpu8pXwib1KAwgidJKh9lfKW67jC5Bz3r+s25YGng/
	 l1wB14nREqmnpqOmLiQVXdfJsWZjGnnvSaBZX6LPD+Y+gYf3bQpX03v4wsXXmg5Hbj
	 PeOEnSXAuLfQw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] alpha: jensen, t2 - make __EXTERN_INLINE same as for the rest
Date: Fri,  3 May 2024 10:11:19 +0200
Message-Id: <20240503081125.67990-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
References: <20240503081125.67990-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

We want io.h primitives (readb(), etc.) to be extern inline.
However, that requires the backing out-of-line implementation
somewhere, preferably kept in sync with the inline ones.

The way it's done is __EXTERN_INLINE macro that defaults to
extern inline, but can be overridden in compilation unit where
the out-of-line instance will be.

That works, but it's brittle - we *must* make sure that asm/io.h
is the very first include in such compilation units.  There'd
been a bunch of bugs of that sort in the past.

Another issue is the choice of overriding definition for
__EXTERN_INLINE; it must be either 'inline' or empty.  Either
will do for compilation purposes - inline void foo(...) {...}
(without extern or static) is going to generate out-of-line
instance.  The difference is that 'definition without a
prototype' heuristics trigger on
void foo(void)
{
	...
}
but not on
inline void foo(void)
{
	...
}

Most of the overrides go for 'inline'; in two cases (sys_jensen
and core_t2) __EXTERN_INLINE is defined as empty.  Without
-Wmissing-prototypes it didn't matter, but now that we have
that thing always on...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/core_t2.c    | 2 +-
 arch/alpha/kernel/sys_jensen.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/core_t2.c b/arch/alpha/kernel/core_t2.c
index 98d5b6ff8a76..3d72d90624f1 100644
--- a/arch/alpha/kernel/core_t2.c
+++ b/arch/alpha/kernel/core_t2.c
@@ -10,7 +10,7 @@
  * Code common to all T2 core logic chips.
  */
 
-#define __EXTERN_INLINE
+#define __EXTERN_INLINE inline
 #include <asm/io.h>
 #include <asm/core_t2.h>
 #undef __EXTERN_INLINE
diff --git a/arch/alpha/kernel/sys_jensen.c b/arch/alpha/kernel/sys_jensen.c
index 5c9c88428124..a1bb1c4a7e93 100644
--- a/arch/alpha/kernel/sys_jensen.c
+++ b/arch/alpha/kernel/sys_jensen.c
@@ -7,7 +7,7 @@
  *
  * Code supporting the Jensen.
  */
-#define __EXTERN_INLINE
+#define __EXTERN_INLINE inline
 #include <asm/io.h>
 #include <asm/jensen.h>
 #undef  __EXTERN_INLINE
-- 
2.39.2


