Return-Path: <linux-kernel+bounces-11530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C953081E7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF451F22074
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7933C4EB5E;
	Tue, 26 Dec 2023 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyKhjWua"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B004EB42;
	Tue, 26 Dec 2023 13:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005C9C433C7;
	Tue, 26 Dec 2023 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703598777;
	bh=AQY7dmprZJmESi+61/lhMwT1uO26gspqlrGm0b7sd2s=;
	h=From:To:Cc:Subject:Date:From;
	b=nyKhjWua2/XlcnQVnS4Osre4jpkurB2edDocb5nMDx/FaT1Fly7efvMGfHw1+FdHo
	 n9630IsYXcWl6KXaUngiBDlgOOlKRRjFILzeYM6+QSVSSvkp9b0S/8LdWpD0OJ34ss
	 9RlApq4B+HNswz1S4fx31VY9L6ZB8vkftf8LbanXwjYi0uvX5UHQ3o/v10ua/BaWqC
	 NejKrVi/5Dz9tf8S2w9lqcIMhtGgfgErYUkCz5LOS03M2haCm28BJTl63ipDO6y91G
	 W4MNo+9flDX7OL4N+soUKWzqIFCML2P3JtT5wwV6mkPC91RVdjYTX+MzmqKq2HiZ09
	 Kva6jwhM37W3A==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] kbuild: deb-pkg: factor out common Make options in debian/rules
Date: Tue, 26 Dec 2023 22:52:38 +0900
Message-Id: <20231226135243.1393780-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This avoid code duplication between binary-arch and built-arch.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/debian/rules | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 3dafa9496c63..26bc6239e200 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -10,20 +10,20 @@ ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
     MAKEFLAGS += -j$(NUMJOBS)
 endif
 
+make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE)
+
 .PHONY: binary binary-indep binary-arch
 binary: binary-arch binary-indep
 binary-indep: build-indep
 binary-arch: build-arch
-	$(MAKE) -f $(srctree)/Makefile ARCH=$(ARCH) \
-	KERNELRELEASE=$(KERNELRELEASE) \
+	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
 	run-command KBUILD_RUN_COMMAND=+$(srctree)/scripts/package/builddeb
 
 .PHONY: build build-indep build-arch
 build: build-arch build-indep
 build-indep:
 build-arch:
-	$(MAKE) -f $(srctree)/Makefile ARCH=$(ARCH) \
-	KERNELRELEASE=$(KERNELRELEASE) \
+	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
 	$(shell $(srctree)/scripts/package/deb-build-option) \
 	olddefconfig all
 
-- 
2.40.1


