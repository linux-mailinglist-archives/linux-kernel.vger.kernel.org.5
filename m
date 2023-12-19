Return-Path: <linux-kernel+bounces-5800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8467818FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60C1289372
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D885137D08;
	Tue, 19 Dec 2023 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYF1DQSO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23EF37D22;
	Tue, 19 Dec 2023 18:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177D0C433C8;
	Tue, 19 Dec 2023 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703010003;
	bh=aInprk0ngpVeNnqzMh3MIxqFI0iItoCxCcQKP9eY+0g=;
	h=From:To:Cc:Subject:Date:From;
	b=qYF1DQSOUwWbonEZuQnUedchL1AA/rl6qHM2alJs8EwfCOZZWCbd89Y/ZY94Bp+fF
	 UFk0cuWkuNhE6dXiikjazDtGwu7SV+flwC63uGVnlX25OI9qRt2D62SSgqo71dILjx
	 vby74RHSBwqsvMItLWyOZwvI9e0Pw23mG8W8hnGGYv4YvPtYh4cqycU9y/kLazRQZe
	 KFzYAnIiO9sHI1Zht7+kBno+E9F4QNfGe12UW8RD6yvV4wKkcGTnZto9mqkM9Cc2YS
	 XoDb2rPX0ZAC9+CoKmPcOvnFhiJmDEgSdR8dVen6l5iS6kIpNpwWDHORbXuPbecXt7
	 L32q1BN8wU5WA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: deb-pkg: do not query DEB_HOST_MULTIARCH
Date: Wed, 20 Dec 2023 03:19:55 +0900
Message-Id: <20231219181957.1449958-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 491b146d4c13 ("kbuild: builddeb: Eliminate debian/arch
use"), the direct execution of debian/rules fails with:

  dpkg-architecture: error: unknown option 'DEB_HOST_MULTIARCH'

I am not sure how important to support such a use case, but at least
the current code:

  dpkg-architecture -a$DEB_HOST_ARCH -qDEB_HOST_MULTIARCH

... looks weird because:

 - For this code to work correctly, DEB_HOST_ARCH must be defined.
   In this case, DEB_HOST_MULTIARCH is likely defined, so there is no
   need to query DEB_HOST_MULTIARCH in the first place. This is likely
   the case where the package build was initiated by dpkg-buildpackage.

 - If DEB_HOST_MULTIARCH is undefined, DEB_HOST_ARCH is likely undefined.
   So, you cannot query DEB_HOST_MULTIARCH in this way. This is mostly
   the case where debian/rules is directly executed.

If we want to run debian/rules directly, we can revert 491b146d4c13 or
add code to remember DEB_HOST_MULTIARCH, but I chose to remove the
useless code for now.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

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
-- 
2.40.1


