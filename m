Return-Path: <linux-kernel+bounces-20829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CC98285C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D31B21F67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5879B38F99;
	Tue,  9 Jan 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzw3zg6J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9638DFC;
	Tue,  9 Jan 2024 12:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B53C433C7;
	Tue,  9 Jan 2024 12:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704802073;
	bh=yYqdl2V/WrEu6szOfBy/qaZwIUQ0XEnoi+ITcWxYigI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rzw3zg6JH75t7XiuBwPmn0OJf24D9UAvjZC8JDmGcEL8BaHSamz0VfM5IXu3vo+A/
	 J+E9jdR5QV/nlNq+setc8BpW/3gYxYB8be0V9D1VTdkNa/8l+UQWYeEyAc9THl2CZr
	 SGSo+zAQ/+2vs8mwCJHY+IhVvxUNPuiv9m8pzZA+d/YteiGqQCg8QAfg2x5v1PnRq7
	 IGquQr/f6QIxxHX/wtgkEl+c/ikLOen0zDaZWVWeffh2ngCF0jPrkb8+s1Sk08qkND
	 7h6EhuPww6H6f/1n+GvkwUV+vRhp4Wf7vUHdV4jHjjm4zJEg3ZqDjrZl9WVLVBxg4r
	 Xl6Is/9SvBOfw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] kbuild: create a list of base and overlays for each DTB
Date: Tue,  9 Jan 2024 21:07:36 +0900
Message-Id: <20240109120738.346061-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240109120738.346061-1-masahiroy@kernel.org>
References: <20240109120738.346061-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some *.dtb files are assembled from a base DTB and overlays, but once
they are built, there is no way to propagate such information to
succeeding processes.

This commit introduces the generation of *.dtlst files, listing the
component *.dtb(o) files that construct the corresponding *.dtb.

This is analogous to *.mod, which lists component objects for each
module.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .gitignore             | 1 +
 Makefile               | 2 +-
 scripts/Makefile.build | 6 ++++++
 scripts/Makefile.lib   | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index c59dc60ba62e..912cb713ad74 100644
--- a/.gitignore
+++ b/.gitignore
@@ -21,6 +21,7 @@
 *.dtbo
 *.dtb.S
 *.dtbo.S
+*.dtlst
 *.dwo
 *.elf
 *.gcno
diff --git a/Makefile b/Makefile
index dae6825b8082..3521bdad6db7 100644
--- a/Makefile
+++ b/Makefile
@@ -1927,7 +1927,7 @@ clean: $(clean-dirs)
 		-o -name '*.ko.*' \
 		-o -name '*.dtb' -o -name '*.dtbo' \
 		-o -name '*.dtb.S' -o -name '*.dtbo.S' \
-		-o -name '*.dt.yaml' -o -name 'dtbs-list' \
+		-o -name '*.dt.yaml' -o -name '*.dtlst' -o -name 'dtbs-list' \
 		-o -name '*.dwo' -o -name '*.lst' \
 		-o -name '*.su' -o -name '*.mod' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index d23797dbca0f..e9fcf330ff39 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -252,6 +252,12 @@ cmd_mod = printf '%s\n' $(call real-search, $*.o, .o, -objs -y -m) | \
 $(obj)/%.mod: FORCE
 	$(call if_changed,mod)
 
+cmd_dt_list = printf '%s\n' $(call real-search, $*.dtb, .dtb, -dtbs) | \
+	$(AWK) '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
+
+$(obj)/%.dtlst: FORCE
+	$(call if_changed,dt_list)
+
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
 		     $(CONFIG_SHELL) $(srctree)/scripts/makelst $*.o \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b35d39022a30..0a492a4e4fbb 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -93,6 +93,8 @@ base-dtb-y := $(filter %.dtb, $(call real-search, $(multi-dtb-y), .dtb, -dtbs))
 
 always-y			+= $(dtb-y)
 
+always-y	+= $(patsubst %.dtb, %.dtlst, $(filter %.dtb, $(dtb-y)))
+
 # Add subdir path
 
 ifneq ($(obj),.)
-- 
2.40.1


