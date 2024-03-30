Return-Path: <linux-kernel+bounces-125665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31375892A4F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03692834EB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F73B2BAF6;
	Sat, 30 Mar 2024 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn4M+4Db"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F728DDE;
	Sat, 30 Mar 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711793352; cv=none; b=j5dd72LR5+pkmQ4FO66qYBd1RyvgfK5K/dBrXTgW3yuPSm21i6Hksi2Zmf9jvNUKhTlcP2827ej2hEf5P+HpYBu6zvdrRZS3a0Km+kqF19cfHyUGbo4hycerhHSq2H0A7b8thajdWlz8R5T/ojRq2lKTCT35dSwKx4rNy5SI5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711793352; c=relaxed/simple;
	bh=oI4lkJis+9trNrJGcocfK9zISlvWwc/IPr4JzhrxI80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3D28MyDGR+IEUXgGQGu1Ud284bFFDCt4SkT2RrstVwpGA9i9fPwx/hoaBYrTfiYu4aBglDATzphP4OO0MUFthnpramvqXNnUz8+bCRmpGuQO/CwpX7Z8KXbnkMYRoakpjfphq/FZeESwEFmHTpjJJShPcLmBZCHY+N6Jd055zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn4M+4Db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16991C43390;
	Sat, 30 Mar 2024 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711793352;
	bh=oI4lkJis+9trNrJGcocfK9zISlvWwc/IPr4JzhrxI80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cn4M+4Db5NN2tMpD8FyWFy+bBrfungkJ7XPrgvPj3NViF7MzqPaXZ/weCIEa0BNGq
	 UC76mkLKJZC7pgJ9eQrt2/zEtZ5/mznQWBum0RgUXg/WLJpUK2iCVOTW3qejtPqmv1
	 SAnP3Qo25sXCAP3QueETDs1WJcsmK0dQBna5gnjNsDgaRLW27ufWPuvCbH9zx97mmY
	 TqLH0396qV31HG+KeyNYx9ZLrIoICyZqrFddjrxc5ap+7hPUCjvpDoed2UvXwo+fkV
	 uuB+Us2HsC/gOzVmDGydx2U/C2Uf2r6SHnVFO8rRJRZkihr5E8lh1v3ml6ADwZv8hO
	 1MAnoAqUe0cYQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] parisc: fix vdso Makefiles slightly
Date: Sat, 30 Mar 2024 19:08:49 +0900
Message-Id: <20240330100849.426874-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240330100849.426874-1-masahiroy@kernel.org>
References: <20240330100849.426874-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vdso32.lds and vdso64.lds are generated files. Prefix them with $(obj)/
instead of $(src)/.

They are generated as prerequisites of others. Add them to 'targets'
instead of 'extra-y'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/kernel/vdso32/Makefile | 4 ++--
 arch/parisc/kernel/vdso64/Makefile | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/vdso32/Makefile b/arch/parisc/kernel/vdso32/Makefile
index e45d46bf46a2..f15367f77d49 100644
--- a/arch/parisc/kernel/vdso32/Makefile
+++ b/arch/parisc/kernel/vdso32/Makefile
@@ -19,14 +19,14 @@ KBUILD_CFLAGS += -DBUILD_VDSO -DDISABLE_BRANCH_PROFILING
 VDSO_LIBGCC := $(shell $(CROSS32CC) -print-libgcc-file-name)
 
 obj-y += vdso32_wrapper.o
-extra-y += vdso32.lds
+targets += vdso32.lds
 CPPFLAGS_vdso32.lds += -P -C  #  -U$(ARCH)
 
 $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so FORCE
 
 # Force dependency (incbin is bad)
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so: $(src)/vdso32.lds $(obj-vdso32) $(VDSO_LIBGCC) FORCE
+$(obj)/vdso32.so: $(obj)/vdso32.lds $(obj-vdso32) $(VDSO_LIBGCC) FORCE
 	$(call if_changed,vdso32ld)
 
 # assembly rules for the .S files
diff --git a/arch/parisc/kernel/vdso64/Makefile b/arch/parisc/kernel/vdso64/Makefile
index f3d6045793f4..25eb9a95422c 100644
--- a/arch/parisc/kernel/vdso64/Makefile
+++ b/arch/parisc/kernel/vdso64/Makefile
@@ -19,14 +19,14 @@ KBUILD_CFLAGS += -DBUILD_VDSO -DDISABLE_BRANCH_PROFILING
 VDSO_LIBGCC := $(shell $(CC) -print-libgcc-file-name)
 
 obj-y += vdso64_wrapper.o
-extra-y += vdso64.lds
+targets += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
 
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so FORCE
 
 # Force dependency (incbin is bad)
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so: $(src)/vdso64.lds $(obj-vdso64) $(VDSO_LIBGCC) FORCE
+$(obj)/vdso64.so: $(obj)/vdso64.lds $(obj-vdso64) $(VDSO_LIBGCC) FORCE
 	$(call if_changed,vdso64ld)
 
 # assembly rules for the .S files
-- 
2.40.1


