Return-Path: <linux-kernel+bounces-11534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F2C81E7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BABB21FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD04F8B7;
	Tue, 26 Dec 2023 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6Ryscme"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270FC4F8A6;
	Tue, 26 Dec 2023 13:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B44C433CB;
	Tue, 26 Dec 2023 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703598783;
	bh=fSRgbph1yPaaUtk0eAjQa+ArlTVll7f5fkppZKDNpBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6RyscmeMEpXnOlMRmKtwyX7WOTR+p/iLVqxnGz2NW9MO6CnLueLYmiwj7XefRDiT
	 v1c+KjwFOBGsMkFAxXJIlyj6Y0bY5A6bg/IsXu5q6EpCqfuFo7UYHgVx/naEMxGBlt
	 oruY50rGDqPaglzXdzH1Aa0Uye7SirKLoqBWow9FvWHZMwujHjgpAV81Jflkul3pW/
	 rFdRIcVWX3pVi2eDCV1NhzH+dSc1/GjDEJvHcQP5S0I5WufY3fi9IeYdeX8jHivXIQ
	 6T3qHH7axfU3psgo8U09LX4QYvbNXqBrqjXlw2cNEKPB7vqjlJSaNSY0y59mp81Dho
	 KYO5nVEyuJ1KA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] kbuild: deb-pkg: remove unneeded '-f $srctree/Makefile' in debian/rules
Date: Tue, 26 Dec 2023 22:52:42 +0900
Message-Id: <20231226135243.1393780-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231226135243.1393780-1-masahiroy@kernel.org>
References: <20231226135243.1393780-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is unneeded because the Makefile in the output directory wraps
the top-level Makefile in the srctree.

Just run $(MAKE) irrespective of the build location.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/debian/rules | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 6b2333e3cf96..36d51f60f98d 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -3,8 +3,6 @@
 
 include debian/rules.vars
 
-srctree ?= .
-
 ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
     NUMJOBS = $(patsubst parallel=%,%,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
     MAKEFLAGS += -j$(NUMJOBS)
@@ -18,20 +16,20 @@ make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(r
 binary: binary-arch binary-indep
 binary-indep: build-indep
 binary-arch: build-arch
-	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
+	$(MAKE) $(make-opts) \
 	run-command KBUILD_RUN_COMMAND='+$${srctree}/scripts/package/builddeb'
 
 .PHONY: build build-indep build-arch
 build: build-arch build-indep
 build-indep:
 build-arch:
-	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
+	$(MAKE) $(make-opts) \
 	olddefconfig all
 
 .PHONY: clean
 clean:
 	rm -rf debian/files debian/linux-* debian/deb-env.vars
-	$(MAKE) -f $(srctree)/Makefile ARCH=$(ARCH) clean
+	$(MAKE) ARCH=$(ARCH) clean
 
 # If DEB_HOST_ARCH is empty, it is likely that debian/rules was executed
 # directly. Run 'dpkg-architecture --print-set --print-format=make' to
-- 
2.40.1


