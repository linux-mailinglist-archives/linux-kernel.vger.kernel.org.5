Return-Path: <linux-kernel+bounces-51682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1AD848E34
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2611C21F54
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276E3224E8;
	Sun,  4 Feb 2024 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPnFYiNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3622337;
	Sun,  4 Feb 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054594; cv=none; b=rOQ5Y9ChafoWFWjfglO2su2wOvfEbZS64IUEW+TWSSe4cIXKdXjc1PQnbl30XgkQsMBhy80GuWzKI5aIzsqua4dtEbJv6M/sWDGfp50UQkfV556nEMuOcGThRh+18r3L/gZdbaEZS07khiNsIRu+CW+EOVbQuppVkIxcKo2JJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054594; c=relaxed/simple;
	bh=PZFvkp+4a4vR109kECCnsi1EUbc9O9oigoCrIe9bzU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M8DhtPMN57BlLbWYMzcg1Ie+DAeLIIvLBDrKREwCtzkF2vn1Zl98BHL4KmYoySd4do1Cto/Gfs2y216rjzVgMds93RNH9VFSAaIGrJn4y9UMAxCgvBDz7W0e6qYwu+j563S1rdw2FQ5PxYYhE6TEd93hXzFkmk3FpaQEx5mFJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPnFYiNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A88C433F1;
	Sun,  4 Feb 2024 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707054593;
	bh=PZFvkp+4a4vR109kECCnsi1EUbc9O9oigoCrIe9bzU0=;
	h=From:To:Cc:Subject:Date:From;
	b=IPnFYiNQhJZO3IjixQos/KLuDQyQs398v1cXm5ZCrtFgSvl66h4XxCpMoACQdOuyM
	 e2H7bYUrstqSFdq3F9vVKajq+asnPaU2XfQXM3N833zVuonbr1i2ilr5NQAxuyIqN/
	 Dk040dfcpeYGkGu+tSTNFcPz7lGcO060Fdc466CBT1LHIrKsATIfziTK4JoVZxRSc/
	 5qslbpxU3gr1DHn4lFw9C0VZlkUKPJGiwyQenaiPoOauyJsZHVsSIZKfceyvpAb/h2
	 C6WzCKbbYzf46VT28AFc0RAkIDkbiy84MqHSj+wZqOkyqnxSS7BVp/96DnRk60w3pr
	 xO5kwH0UUzE6w==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Cc: YiFei Zhu <yifeifz2@illinois.edu>,
	Kees Cook <keescook@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] loongarch: select HAVE_ARCH_SECCOMP to use the common SECCOMP menu
Date: Sun,  4 Feb 2024 22:49:46 +0900
Message-Id: <20240204134946.62509-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LoongArch missed the refactoring made by commit 282a181b1a0d ("seccomp:
Move config option SECCOMP to arch/Kconfig") because LoongArch was not
mainlined at that time.

The 'depends on PROC_FS' statement is stale as described in that commit.
Select HAVE_ARCH_SECCOMP, and remove the duplicated config entry.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/loongarch/Kconfig | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 64e9a01c7f36..929f68926b34 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -100,6 +100,7 @@ config LOONGARCH
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KGDB if PERF_EVENTS
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
+	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
@@ -633,23 +634,6 @@ config RANDOMIZE_BASE_MAX_OFFSET
 
 	  This is limited by the size of the lower address memory, 256MB.
 
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	depends on PROC_FS
-	default y
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via /proc/<pid>/seccomp, it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y. Only embedded should say N here.
-
 endmenu
 
 config ARCH_SELECT_MEMORY_MODEL
-- 
2.40.1


