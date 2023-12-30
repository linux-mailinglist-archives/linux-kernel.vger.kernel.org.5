Return-Path: <linux-kernel+bounces-13438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB4F82069E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2CC1C2127E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106BA8F42;
	Sat, 30 Dec 2023 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf9kgC0O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA18BED;
	Sat, 30 Dec 2023 13:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A96C433C7;
	Sat, 30 Dec 2023 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703944324;
	bh=I8YWkNwCfpsTCQMjWVH+WYYNUuZhW8O5gv7Trb+2X3I=;
	h=From:To:Cc:Subject:Date:From;
	b=Tf9kgC0OzB3/DOGkdXeZio0IHJKL0+iT99ZhAUEHwPB0KSBkAJMOZVNxoqlbUbBpj
	 pTEX1c1KaFnopzGD2H0tB+fXdJmjc5uEYJYs/jSTF82EM1nhS+6zgUCHUwgxqpwFfU
	 yqwpEYfeyuBiMDa4Yii9+JuIxfxYDPXQMmVvJMmS2scOTTLsfO4u2jNcgYwjzsDRd9
	 tCjWpcW0pLEkeE4wrNRBUUPNTvE0Lf5bYxbUmYpKdEH4AZx1S3xDv3e98SKwYvBRi3
	 rrpkw78tGtd0QI3+59xcPYUAU4FDP9tCp+TQ/rfhR+yLYxsNhJxL1FgpPfFV1QUZSs
	 fBTqkkwz/hdOQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] kbuild: deb-pkg: move 'make headers' to build-arch
Date: Sat, 30 Dec 2023 22:51:56 +0900
Message-Id: <20231230135200.1058873-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Strictly speaking, 'make headers' should be a part of build-arch
instead of binary-arch.

'make headers' constructs read-to-copy UAPI headers in the kernel
directory.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb     | 1 -
 scripts/package/debian/rules | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index cc8c7a807fcc..842ee4b40528 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -155,7 +155,6 @@ install_libc_headers () {
 
 	rm -rf $pdir
 
-	$MAKE -f $srctree/Makefile headers
 	$MAKE -f $srctree/Makefile headers_install INSTALL_HDR_PATH=$pdir/usr
 
 	# move asm headers to /usr/include/<libc-machine>/asm to match the structure
diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index cb084e387469..a686c37d0d02 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -26,8 +26,8 @@ binary-arch: build-arch
 build: build-arch build-indep
 build-indep:
 build-arch:
-	$(MAKE) $(make-opts) \
-	olddefconfig all
+	$(MAKE) $(make-opts) olddefconfig
+	$(MAKE) $(make-opts) headers all
 
 .PHONY: clean
 clean:
-- 
2.40.1


