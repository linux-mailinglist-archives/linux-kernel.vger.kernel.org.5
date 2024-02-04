Return-Path: <linux-kernel+bounces-51693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD60C848E4D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC2A282AAC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4659225CE;
	Sun,  4 Feb 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWjB/byy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1F225A6;
	Sun,  4 Feb 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056092; cv=none; b=PU951Lz59oEZbx67C2XTAP2sA3xv0NOAWn5oNx0JqkxS8BZyB9EusVPyarawFvZuqhEUDezr4BB+o/stSjxUiRJSe64rb1J8JINjpt5677RGu3UZBdZAFS5Qdwce270T3h256XbXvcd0W0L4uOHjj6oiUmZKDFdMtwTpK5z5iOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056092; c=relaxed/simple;
	bh=pSHUI2w7h8bkoO4Mjtuj8iQ85JUR3STYQqkV61hKGGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPYTrEi2zIdIncEm8jIJ2/HgLsGSupDqawCg2g9XUFQ66xKCSW7AeEcpd/HUm9fGpZvwduWahdAxiE//gl5AvEzQLsUlKqjIcR83VpB/7v2SGgrWVrSWTch5VTd954AtH7R+CAfFbHR6lnnTk6pFLoh/Tj1F6+XmGlxS2GeK4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWjB/byy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A48FC433F1;
	Sun,  4 Feb 2024 14:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707056091;
	bh=pSHUI2w7h8bkoO4Mjtuj8iQ85JUR3STYQqkV61hKGGU=;
	h=From:To:Cc:Subject:Date:From;
	b=oWjB/byy4c3xDo72g3YyJViqhZJB1KSAvC/VqPmZst73SHfcesepGhdPbu353rp+I
	 9iqhQvc6G5c6BX7yWdXK1oo1C7VH0oHPzKJrAAZv+HdkWcwwP6lv+h2+sCUE6VXZ29
	 NuzmPxC51WuoqZPN5T1VA6yHwIy04WT74KSUXEww5zwpMh9o+jpLDxdayfhdcc7SA5
	 C9FCj6rJa9nvpkA5SSopApjRy27JKAf1rSsxSwcdXykf4OkaNEs3bmICBvuoST0zkE
	 7vSIQ2h8XNZ98Pb3eKvPcFCFRIrr0rZYF6e/Afs8o1C6taLNGLCmlD4nUe0vmVwHbV
	 Btx0mHQhEO/MA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: merge CONFIG_MACH_TX49XX entries
Date: Sun,  4 Feb 2024 23:14:45 +0900
Message-Id: <20240204141446.65055-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'config MACH_TX49XX' entry exists in arch/mips/Kconfig with a
prompt and one select statement, also in arch/mips/txx9/Kconfig with
the other select statements.

Commit 8f8da9adebdf ("[MIPS] TXx9: Kconfig cleanup") added the second
entry to arch/mips/txx9/Kconfig.

There is no reason to split it in the two locations.

Merge them into the entry in arch/mips/txx9/Kconfig.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/Kconfig      | 4 ----
 arch/mips/txx9/Kconfig | 3 ++-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a70b4f959fb1..b7c62f8d612e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -881,10 +881,6 @@ config SNI_RM
 	  Technology and now in turn merged with Fujitsu.  Say Y here to
 	  support this machine type.
 
-config MACH_TX49XX
-	bool "Toshiba TX49 series based machines"
-	select WAR_TX49XX_ICACHE_INDEX_INV
-
 config MIKROTIK_RB532
 	bool "Mikrotik RB532 boards"
 	select CEVT_R4K
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 7335efa4d528..d633dba7406b 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config MACH_TX49XX
-	bool
+	bool "Toshiba TX49 series based machines"
 	select BOOT_ELF32
 	select MACH_TXX9
 	select CEVT_R4K
@@ -8,6 +8,7 @@ config MACH_TX49XX
 	select IRQ_MIPS_CPU
 	select SYS_HAS_CPU_TX49XX
 	select SYS_SUPPORTS_64BIT_KERNEL
+	select WAR_TX49XX_ICACHE_INDEX_INV
 
 config MACH_TXX9
 	bool
-- 
2.40.1


