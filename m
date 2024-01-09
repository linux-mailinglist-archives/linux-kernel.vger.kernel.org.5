Return-Path: <linux-kernel+bounces-20830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113538285CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2066F1C23F39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C64238FBE;
	Tue,  9 Jan 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbvvzB/W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472038FA6;
	Tue,  9 Jan 2024 12:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F25DC43394;
	Tue,  9 Jan 2024 12:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704802075;
	bh=MZbzN22IX64OiGkpAjMsQ5NKuAEc1kV5o4lDIUMEQFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbvvzB/WipWO1m+9QDyIUGPgsBhQaQ1OsuX1m2GRu7ZM0lKndEJKtlkRqgMAUWXzt
	 TJzYLXMvrCV/MlTEnRvN7LZgbirbseq2QPuZLdVdI8QaxYiZMlL32KYZMT9+RA8dwC
	 y3DBkqM7g21tzJd9wKKt6XYksspHLVzZm7FFPAh8jsLAMwGr6i+MHyT0Il4TI1ILj4
	 1S3xvWz50/z0zMl40PZYZoneUu81Zld07pTddyhS3fNtMw4y3DNm5m3nzVSkPac0VD
	 xpwpPWUH05jChaK+RHn8VVB6JQiVF2gA44R5RhtsAm560gWml85FxDyhjngRMC//nF
	 mrABK+fq+yCaw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] kbuild: allow 'make dtbs_install' to install primitive DTBs
Date: Tue,  9 Jan 2024 21:07:37 +0900
Message-Id: <20240109120738.346061-5-masahiroy@kernel.org>
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

Commit 15d16d6dadf6 ("kbuild: Add generic rule to apply fdtoverlay")
introduced the -dtbs syntax to apply overlays during the build process.

However, scripts/Makefile.dtbinst is not aware of the -dtbs syntax,
so 'make dtbs_install' installs the files directly added to dtb-y.
(Presumably, it was intentional.)

For example, consider this case:

    foo1-dtbs := foo_base.dtb foo_overlay1.dtbo
    foo2-dtbs := foo_base.dtb foo_overlay2.dtbo
    dtb-y := foo1.dtb foo2.dtb

'make dtbs_install' only installs foo1.dtb and foo2.dtb. It is suitable
when the boot image supports a single hardware configuration, or when
the boot loader in use does not support applying overlays.

However, when creating a boot image with multiple board supports, it
wastes storage space, as foo1.dtb and foo2.dtb have foo_base.dtb in
common.

From a space perspective, a more optimal solution is to install
foo_base.dtb, foo_overlay1.dtbo, and foo_overlay2.dtbo, then assemble
the final dtb (either foo1.dtb or foo2.dtb) on the boot loader.

This commit adds a new flag, INSTALL_DTBS_PRIMITIVE.

With INSTALL_DTBS_PRIMITIVE=1, 'make dtbs_install' will install primitive
files (such as foo_base.dtb, foo_overlay1.dtbo, and foo_overlay2.dtbo in
this case).

Without INSTALL_DTBS_PRIMITIVE, the current behavior is maintained
(foo1.dtb and foo2.dtb will be installed in this case).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/kbuild.rst | 6 ++++++
 scripts/Makefile.dtbinst        | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 9c8d1d046ea5..d803ca5afc07 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -249,6 +249,12 @@ INSTALL_DTBS_PATH specifies where to install device tree blobs for
 relocations required by build roots.  This is not defined in the
 makefile but the argument can be passed to make if needed.
 
+INSTALL_DTBS_PRIMITIVE
+----------------------
+INSTALL_DTBS_PRIMITIVE, if defined, will cause the dtbs_install target to
+install the base dtb and overlay dtbo files instead of assembled dtb files
+constructed by overlay application.
+
 KBUILD_ABS_SRCTREE
 --------------------------------------------------
 Kbuild uses a relative path to point to the tree when possible. For instance,
diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 67956f6496a5..14111a86987a 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -22,7 +22,13 @@ quiet_cmd_dtb_install = INSTALL $@
 $(dst)/%: $(obj)/%
 	$(call cmd,dtb_install)
 
-dtbs := $(patsubst $(obj)/%,%,$(call read-file, $(obj)/dtbs-list))
+dtbs := $(call read-file, $(obj)/dtbs-list)
+
+ifdef INSTALL_DTBS_PRIMITIVE
+dtbs := $(foreach f, $(dtbs), $(if $(filter %.dtb,$(f)),$(call read-file, $(patsubst %.dtb,%.dtlst,$(f))),$(f)))
+endif
+
+dtbs := $(patsubst $(obj)/%,%,$(dtbs))
 
 ifdef CONFIG_ARCH_WANT_FLAT_DTB_INSTALL
 
-- 
2.40.1


