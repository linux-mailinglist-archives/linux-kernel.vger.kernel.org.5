Return-Path: <linux-kernel+bounces-11532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D081E7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3B128310B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F6C4F5F2;
	Tue, 26 Dec 2023 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9whyM/H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21984F216;
	Tue, 26 Dec 2023 13:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356D2C43391;
	Tue, 26 Dec 2023 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703598780;
	bh=GHEJTufmGu+U5ws6uli9pWrljzPPuOpjnKKiIXQ9OP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9whyM/HAPsMMSg1XN9ZxtCtIVJSCpjEhZks2t2pdHelgP0JVYZL44424b/PqLRlk
	 1mj56KFfHC5zKF6uCqgl5oG8JFqieAfs7TxhMVTsNgsfL8IdJ1TmpYHHTX7l0ljywv
	 eT70jgQ6XmRk1MXCYd8YsfAKa/acYi9t3NHmY6AMsaenIEfUKrq0E6R70FO7TJIEk1
	 yR5Mkd3EDLZMot6wH3HRIRQMrAK8yAXTY+mOc+qm7AFEcQDLUQ+D3m/hiwa0fjooZE
	 cjRcNfOtbpZkeX6UDNWUvrEfZmTqIg184pv/S1MV9u5sDx0DLvbSQMjtpeNbq8nKGf
	 aWzljeUwtPAFQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] kbuild: deb-pkg: set DEB_* variables if debian/rules is directly executed
Date: Tue, 26 Dec 2023 22:52:40 +0900
Message-Id: <20231226135243.1393780-3-masahiroy@kernel.org>
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

Since commit 491b146d4c13 ("kbuild: builddeb: Eliminate debian/arch
use"), direct execution of debian/rules results in the following error:

  dpkg-architecture: error: unknown option 'DEB_HOST_MULTIARCH'

The current code:

  dpkg-architecture -a$DEB_HOST_ARCH -qDEB_HOST_MULTIARCH

... does not look sensible because:

 - For this code to work correctly, DEB_HOST_ARCH must be pre-defined,
   which is true when the packages are built via dpkg-buildpackage.
   In this case, DEB_HOST_MULTIARCH is also likely defined, hence there
   is no need to query DEB_HOST_MULTIARCH in the first place.

 - If DEB_HOST_MULTIARCH is undefined, DEB_HOST_ARCH is likely undefined
   too. So, you cannot query DEB_HOST_MULTIARCH in this way. This is
   mostly the case where debian/rules is directly executed.

When debian/rules is directly executed, querying DEB_HOST_MUCHARCH is
not enough because we need to know DEB_{BUILD,HOST}_GNU_TYPE as well.

All DEB_* variables are defined when the package build is initiated by
dpkg-buildpackage, but otherwise, let's call dpkg-architecture to set
all DEB_* environment variables.

This implementation relies on dpkg commit 7c54fa2b232e
("dpkg-architecture: Add a --print-format option").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb     |  5 ++---
 scripts/package/debian/rules | 12 +++++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 2fe51e6919da..2eb4910f0ef3 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -171,9 +171,8 @@ install_libc_headers () {
 
 	# move asm headers to /usr/include/<libc-machine>/asm to match the structure
 	# used by Debian-based distros (to support multi-arch)
-	host_arch=$(dpkg-architecture -a$DEB_HOST_ARCH -qDEB_HOST_MULTIARCH)
-	mkdir $pdir/usr/include/$host_arch
-	mv $pdir/usr/include/asm $pdir/usr/include/$host_arch/
+	mkdir "$pdir/usr/include/${DEB_HOST_MULTIARCH}"
+	mv "$pdir/usr/include/asm" "$pdir/usr/include/${DEB_HOST_MULTIARCH}"
 }
 
 rm -f debian/files
diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 529b71b55efa..8f24a8e84bf2 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -30,5 +30,15 @@ build-arch:
 
 .PHONY: clean
 clean:
-	rm -rf debian/files debian/linux-*
+	rm -rf debian/files debian/linux-* debian/deb-env.vars
 	$(MAKE) -f $(srctree)/Makefile ARCH=$(ARCH) clean
+
+# If DEB_HOST_ARCH is empty, it is likely that debian/rules was executed
+# directly. Run 'dpkg-architecture --print-set --print-format=make' to
+# generate a makefile construct that exports all DEB_* variables.
+ifndef DEB_HOST_ARCH
+-include debian/deb-env.vars
+
+debian/deb-env.vars:
+	dpkg-architecture -a$$(cat debian/arch) --print-set --print-format=make > $@
+endif
-- 
2.40.1


