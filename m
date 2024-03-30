Return-Path: <linux-kernel+bounces-125659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4194892A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741D11F21FB7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8336C40858;
	Sat, 30 Mar 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odzuW5+u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77520224DA;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=a/sjNxlAFIW7Ou5DJBefuJMgUNDJWmOisYl6sSt8Z42gT02ETeWUhNN/owcIH0cunOcWrn1xXQpu6ikjtTt/ogEgNQgtYkifz+8I5jOqAsc0gdW6FO1XISUkf3yaZ1xlFJII4Y8xQszChq0l70sf9rVHSFbFzbQkIcC4aPgZDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=AVnxMaD8P3lGJwIeugtBUSpep/nX1zh+KPd+aSmXedU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QXCNmd3SbBjkWK0umrxmpZblmffqWFEzHw5HMGwimqE/uTV+qxC3ZsUZjTQBveNXtNSqksN5ncnE9avmGYjiNELuctuMfS/v4qNTR8ZMMo4dheCMxF0W9/MTsSkMhtMDwszWKuCLlIsAIIzNZCBHcKaDVTcVCxmrchwtz2g16eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odzuW5+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45DC7C43601;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792677;
	bh=AVnxMaD8P3lGJwIeugtBUSpep/nX1zh+KPd+aSmXedU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=odzuW5+u/B/jYnzavgkMaEERbZf1qIKGj60zuug5SPLmJS1ofIqgQgZ9v7N+Eh2pO
	 GwkMdXXATupfvRYwTPRR7iOlWSqbsmwDTcO8W1/fK40xmak4stFtBUEL+aqwnLrJ2J
	 gNfxhXQ8IwvK1+2RnYOtOCk6tdWIidIJvjcgf/vHmZXJXH+nfCptSnmwgBt8KwtMAP
	 Pqw5kc22Pmh0FHy74R0U+LFgDn41ebLXdwVaFeOrBLDswJrvs12dgcOhxF9Jz7mcRh
	 nsa806NfOm10v+TDYt2roJYQXbvCsP+4FNLhtnikD5fX0ZSPwpnkljYWWqndDmkvGY
	 zFSSJD3G+l0LA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F67ECD1290;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 30 Mar 2024 10:57:46 +0100
Subject: [PATCH 10/10] sparc64: Fix prototype warnings for vdso
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240330-sparc64-warnings-v1-10-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=2638;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=R3MJg/E/GhMxnu0wstTitJ5mJt9vPs+kNGIj3nVyBSg=;
 b=4VEx0rmCrYuq7fkcXCME2F2VaTvqyGizSK4moRhBlf1ov0rAPRrYYeczpL2dZngQSGnIn9AKOHKW
 VHWtcmrbCPy4hZGFW+ksDOU06O+Ax51RL6YmSQBF7KdC78OA3ryF
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org

From: Sam Ravnborg <sam@ravnborg.org>

Fix the following warnings:
arch/sparc/vdso/vclock_gettime.c:254:1: error: no previous prototype for ‘__vdso_clock_gettime’
arch/sparc/vdso/vclock_gettime.c:282:1: error: no previous prototype for ‘__vdso_clock_gettime_stick’
arch/sparc/vdso/vclock_gettime.c:307:1: error: no previous prototype for ‘__vdso_gettimeofday’
arch/sparc/vdso/vclock_gettime.c:343:1: error: no previous prototype for ‘__vdso_gettimeofday_stick’
arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: error: no previous prototype for ‘__vdso_clock_gettime’
arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: error: no previous prototype for ‘__vdso_clock_gettime_stick’
arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: error: no previous prototype for ‘__vdso_gettimeofday’
arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: error: no previous prototype for ‘__vdso_gettimeofday_stick’

The warnings were fixed by adding the proper prototypes to asm/vdso.h.
The better fix would be to convert sparc to be y2038 compliant so the
generic variant of vdso.h could be used.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/include/asm/vdso.h    | 10 ++++++++++
 arch/sparc/vdso/vclock_gettime.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/sparc/include/asm/vdso.h b/arch/sparc/include/asm/vdso.h
index 59e79d35cd73..af630cad185c 100644
--- a/arch/sparc/include/asm/vdso.h
+++ b/arch/sparc/include/asm/vdso.h
@@ -5,6 +5,16 @@
 #ifndef _ASM_SPARC_VDSO_H
 #define _ASM_SPARC_VDSO_H
 
+#include <linux/linkage.h>
+#include <linux/time.h>
+#include <linux/time_types.h>
+#include <linux/types.h>
+
+notrace int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
+notrace int __vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_timespec *ts);
+notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
+notrace int __vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct timezone *tz);
+
 struct vdso_image {
 	void *data;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index e794edde6755..a3f85d9cea52 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -19,6 +19,7 @@
 #include <asm/unistd.h>
 #include <asm/timex.h>
 #include <asm/clocksource.h>
+#include <asm/vdso.h>
 #include <asm/vvar.h>
 
 #ifdef	CONFIG_SPARC64

-- 
2.34.1



