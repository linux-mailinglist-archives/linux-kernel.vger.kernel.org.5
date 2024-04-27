Return-Path: <linux-kernel+bounces-161068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B18B46B0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066C51F22633
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00458A932;
	Sat, 27 Apr 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6F5Uhw+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A894A02;
	Sat, 27 Apr 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714229711; cv=none; b=pEB/si4ZlrwYTqHxIKLRGqknYcSOpLRByu+hHXw9K5wq3aIquftESvsQFqF+WkDRkdyP6kHOs0fTvHztQyr9X/mhynPU87/b/ZkZDH+hnJmlXihfz7UVh0lSt4iGJKuXTcNN3NCBFVn9EkXTLuregAWaQ6W2Ksem3nU7PvoYmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714229711; c=relaxed/simple;
	bh=wq89dRCvrNa0PsG19mCNdBlAe1+Vu/za2sDeBBPhDQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ak56RXL6OfJ9oxQbsVYfEyry8OL/+S4VIM2Pd/avO2hMmg6643mUfxU6sDdmba3sQkXo3sp9bbZQfuEz2BsAUn37zSHri6/E8L3nyDX36oz/61GDGL8aZtvZgqIxxatJjvsrEBnErNu0zak0qMziZc283S3NgYg0oYKxQw6wzDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6F5Uhw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743F7C2BD10;
	Sat, 27 Apr 2024 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714229709;
	bh=wq89dRCvrNa0PsG19mCNdBlAe1+Vu/za2sDeBBPhDQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6F5Uhw+aDtrz8kYD8o/47R0a+0biQRqaOwnHrKPW/HLzSr9LECH73uuO1Nh/ozVF
	 XIp8eD+9qXqKLLS570opS7PSZQU7ecEA7ROqFNr+4vbAis+4bcSyQGRoOh+UdPAd8t
	 2J6BVQfXU5WS/VUK2h0BLy2N2h+f2/U88uPm61jfXHxLuaHOAOveWZWrswDl9wHjLb
	 6k7I3IGIbQ7C01G4krSK7H8RkrrtEq6jVaVzeXjDE0Gm6AecPuoWdzSp9u37gAF0du
	 +OgY2BBQgw++LF9xTM/GNrtxqIZ56PFE18h4BQEAWaOC5nsvaFYbSshdAdE60XvPYq
	 LhTkzIRiDfffA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2 1/4] arch: use $(obj)/ instead of $(src)/ for preprocessed linker scripts
Date: Sat, 27 Apr 2024 23:54:59 +0900
Message-Id: <20240427145502.2804311-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240427145502.2804311-1-masahiroy@kernel.org>
References: <20240427145502.2804311-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are generated files. Prefix them with $(obj)/ instead of $(src)/.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Helge Deller <deller@gmx.de>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

(no changes since v1)

 arch/arm64/kernel/vdso32/Makefile  | 2 +-
 arch/csky/kernel/vdso/Makefile     | 2 +-
 arch/parisc/kernel/vdso32/Makefile | 2 +-
 arch/parisc/kernel/vdso64/Makefile | 2 +-
 arch/powerpc/kernel/vdso/Makefile  | 4 ++--
 arch/s390/kernel/vdso32/Makefile   | 2 +-
 arch/s390/kernel/vdso64/Makefile   | 2 +-
 arch/sh/kernel/vsyscall/Makefile   | 4 ++--
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index f5f80fdce0fe..cc4508c604b2 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -136,7 +136,7 @@ $(obj)/vdso32.so.dbg: $(obj)/vdso.so.raw $(obj)/$(munge) FORCE
 	$(call if_changed,vdsomunge)
 
 # Link rule for the .so file, .lds has to be first
-$(obj)/vdso.so.raw: $(src)/vdso.lds $(obj-vdso) FORCE
+$(obj)/vdso.so.raw: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold_and_vdso_check)
 
 # Compilation rules for the vDSO sources
diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
index ddf784a62c11..24a01c22293e 100644
--- a/arch/csky/kernel/vdso/Makefile
+++ b/arch/csky/kernel/vdso/Makefile
@@ -31,7 +31,7 @@ KCOV_INSTRUMENT := n
 $(obj)/vdso.o: $(obj)/vdso.so
 
 SYSCFLAGS_vdso.so.dbg = $(c_flags)
-$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
 SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
 	-Wl,--build-id=sha1 -Wl,--hash-style=both
diff --git a/arch/parisc/kernel/vdso32/Makefile b/arch/parisc/kernel/vdso32/Makefile
index e45d46bf46a2..60dc708a0f80 100644
--- a/arch/parisc/kernel/vdso32/Makefile
+++ b/arch/parisc/kernel/vdso32/Makefile
@@ -26,7 +26,7 @@ $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so FORCE
 
 # Force dependency (incbin is bad)
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so: $(src)/vdso32.lds $(obj-vdso32) $(VDSO_LIBGCC) FORCE
+$(obj)/vdso32.so: $(obj)/vdso32.lds $(obj-vdso32) $(VDSO_LIBGCC) FORCE
 	$(call if_changed,vdso32ld)
 
 # assembly rules for the .S files
diff --git a/arch/parisc/kernel/vdso64/Makefile b/arch/parisc/kernel/vdso64/Makefile
index f3d6045793f4..0982f3099ae2 100644
--- a/arch/parisc/kernel/vdso64/Makefile
+++ b/arch/parisc/kernel/vdso64/Makefile
@@ -26,7 +26,7 @@ $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so FORCE
 
 # Force dependency (incbin is bad)
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so: $(src)/vdso64.lds $(obj-vdso64) $(VDSO_LIBGCC) FORCE
+$(obj)/vdso64.so: $(obj)/vdso64.lds $(obj-vdso64) $(VDSO_LIBGCC) FORCE
 	$(call if_changed,vdso64ld)
 
 # assembly rules for the .S files
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 1b93655c2857..a14eab366993 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -74,9 +74,9 @@ targets += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o FORCE
+$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o FORCE
 	$(call if_changed,vdso32ld_and_check)
-$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o FORCE
 	$(call if_changed,vdso64ld_and_check)
 
 # assembly rules for the .S files
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index b12a274cbb47..70e9949c2612 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -44,7 +44,7 @@ $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
 quiet_cmd_vdso_and_check = VDSO    $@
       cmd_vdso_and_check = $(cmd_ld); $(cmd_vdso_check)
 
-$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) FORCE
+$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) FORCE
 	$(call if_changed,vdso_and_check)
 
 # strip rule for the .so file
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index ef9832726097..2b3617b6d162 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -50,7 +50,7 @@ quiet_cmd_vdso_and_check = VDSO    $@
       cmd_vdso_and_check = $(cmd_ld); $(cmd_vdso_check)
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) $(obj-cvdso64) FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj-cvdso64) FORCE
 	$(call if_changed,vdso_and_check)
 
 # strip rule for the .so file
diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
index 118744d349e2..cb4f0bb80c38 100644
--- a/arch/sh/kernel/vsyscall/Makefile
+++ b/arch/sh/kernel/vsyscall/Makefile
@@ -19,14 +19,14 @@ vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
 SYSCFLAGS_vsyscall-trapa.so	= $(vsyscall-flags)
 
 $(obj)/vsyscall-trapa.so: \
-$(obj)/vsyscall-%.so: $(src)/vsyscall.lds $(obj)/vsyscall-%.o FORCE
+$(obj)/vsyscall-%.so: $(obj)/vsyscall.lds $(obj)/vsyscall-%.o FORCE
 	$(call if_changed,syscall)
 
 # We also create a special relocatable object that should mirror the symbol
 # table and layout of the linked DSO.  With ld -R we can then refer to
 # these symbols in the kernel code rather than hand-coded addresses.
 SYSCFLAGS_vsyscall-dummy.o = -r
-$(obj)/vsyscall-dummy.o: $(src)/vsyscall.lds \
+$(obj)/vsyscall-dummy.o: $(obj)/vsyscall.lds \
 			$(obj)/vsyscall-trapa.o $(obj)/vsyscall-note.o FORCE
 	$(call if_changed,syscall)
 
-- 
2.40.1


