Return-Path: <linux-kernel+bounces-93794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932287352C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9313AB29C92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2838860DDA;
	Wed,  6 Mar 2024 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob1wDC6T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1760BA1;
	Wed,  6 Mar 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721797; cv=none; b=Xsf3webqzz4YK45BIHZe9HC4GDq9RKC0zj42MtnS8vWRsziSIUG6RYa/LTncMqS4PuOlauv/YmaUuxdgKBzpBcaPB7zyLJ4gaRm1cYJhM++JUXtcHFPVt+pwcn3xzFPkZ1P0LsuuPkaAGL6vXTJJVv3n5yZZtFwMFErGHU6+akk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721797; c=relaxed/simple;
	bh=qPc3Rze+xdFVIDt8rY61AlQ9GWmq0n15nKjNocAbfY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KY1MD6FmdoeSCw6lYPlRsgfkcuQi8rnE+rD2CJ4UNA8IC0xmc7+++ERPJ9ac2+//Q9DV26GP+yQsS+ROq486eqxqhlwPKTwCkzmtwVae5VeF1YIk4060OE8u9PSXo4Q+S0dOvr3mEgm/BXhVSKIMiTVU63JBJevi/6lLSSWTjsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob1wDC6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7F0C43394;
	Wed,  6 Mar 2024 10:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709721796;
	bh=qPc3Rze+xdFVIDt8rY61AlQ9GWmq0n15nKjNocAbfY0=;
	h=From:To:Cc:Subject:Date:From;
	b=ob1wDC6TqX8niGkM2eQeaSpFizoDM/FaBMz/mvcNOK3unqNNkDrL9l5RvRw7Iz19T
	 09a6oA9+gNa2+04BlWmERnTOHG4EoYo2TZpwve6xaRG647CQ7zRvJgGBU7J0wH7jho
	 eLgQOl3LpYejyauzDw8sTGSEdQj89Wa7POXDHc7YtSxBu5R6fZJv8XwNH2P2HqrjMM
	 nvE9jv+VOu/EYq1yTIuly7fqmb4vbcgFyhgSNUfedS2bnSdZWFyheL2z3TlHMx84OF
	 6PKCu0XxS8uKVMfmVE7b+/6lJjy0h4GaDTM8KkkuUY3siOsO3Ci7fRDM2znWlh/Udx
	 X2xNYN9C/McXQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kbuild: unexport abs_srctree and abs_objtree
Date: Wed,  6 Mar 2024 19:42:22 +0900
Message-Id: <20240306104222.308473-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 25b146c5b8ce ("kbuild: allow Kbuild to start from any directory")
exported abs_srctree and abs_objtree to avoid recomputation after the
sub-make. However, this approach turned out to be fragile.

Commit 5fa94ceb793e ("kbuild: set correct abs_srctree and abs_objtree
for package builds") moved them above "ifneq ($(sub_make_done),1)",
eliminating the need for exporting them.

These are only needed in the top Makefile. If an absolute path is
required in sub-directories, you can use $(abspath ) or $(realpath )
as needed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                 | 4 ++--
 rust/Makefile            | 4 ++--
 scripts/Makefile.package | 2 +-
 tools/lib/bpf/Makefile   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index d84c0fb215fd..d9274e7c75f0 100644
--- a/Makefile
+++ b/Makefile
@@ -39,8 +39,8 @@ __all:
 # prepare rule.
 
 this-makefile := $(lastword $(MAKEFILE_LIST))
-export abs_srctree := $(realpath $(dir $(this-makefile)))
-export abs_objtree := $(CURDIR)
+abs_srctree := $(realpath $(dir $(this-makefile)))
+abs_objtree := $(CURDIR)
 
 ifneq ($(sub_make_done),1)
 
diff --git a/rust/Makefile b/rust/Makefile
index 9d2a16cc91cb..ae691b71d9fc 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -100,7 +100,7 @@ rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
 		-e 's:rust-logo-[0-9a-f]+\.svg:logo.svg:g' \
 		-e 's:favicon-[0-9a-f]+\.svg:logo.svg:g' \
 		-e 's:<link rel="alternate icon" type="image/png" href="[/.]+/static\.files/favicon-(16x16|32x32)-[0-9a-f]+\.png">::g' \
-		-e 's:<a href="srctree/([^"]+)">:<a href="$(abs_srctree)/\1">:g'
+		-e 's:<a href="srctree/([^"]+)">:<a href="$(realpath $(srctree))/\1">:g'
 	$(Q)for f in $(rustdoc_output)/static.files/rustdoc-*.css; do \
 		echo ".logo-container > img { object-fit: contain; }" >> $$f; done
 
@@ -413,7 +413,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 rust-analyzer:
 	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
 		--cfgs='core=$(core-cfgs)' --cfgs='alloc=$(alloc-cfgs)' \
-		$(abs_srctree) $(abs_objtree) \
+		$(realpath $(srctree)) $(realpath $(objtree)) \
 		$(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
 		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
 
diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index a81dfb1f5181..38653f3e8108 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -135,7 +135,7 @@ snap-pkg:
 	mkdir $(objtree)/snap
 	$(MAKE) clean
 	sed "s@KERNELRELEASE@$(KERNELRELEASE)@; \
-		s@SRCTREE@$(abs_srctree)@" \
+		s@SRCTREE@$(realpath $(srctree))@" \
 		$(srctree)/scripts/package/snapcraft.template > \
 		$(objtree)/snap/snapcraft.yaml
 	cd $(objtree)/snap && \
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 4be7144e4803..2cf892774346 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -2,7 +2,7 @@
 # Most of this file is copied from tools/lib/traceevent/Makefile
 
 RM ?= rm
-srctree = $(abs_srctree)
+srctree := $(realpath $(srctree))
 
 VERSION_SCRIPT := libbpf.map
 LIBBPF_VERSION := $(shell \
-- 
2.40.1


