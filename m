Return-Path: <linux-kernel+bounces-5501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3CF818B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9BA1C246B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66B1CF8D;
	Tue, 19 Dec 2023 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNaXtJeq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD01D522;
	Tue, 19 Dec 2023 15:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2B4C433C8;
	Tue, 19 Dec 2023 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703000455;
	bh=CleS4Wyn8+tIT1wCL1GNRFUcnY3c+Rh3z0BVuoazyrg=;
	h=From:To:Cc:Subject:Date:From;
	b=FNaXtJeqqpXT0c/EUUZCqP9TZtPDztQ0nPuNRjXajW4W2sxnUWKDqo5jcqiU+9UZo
	 OTltfbPG4ewehZ2AVqV59eH2rXPN152gxLe51R9xEfdsbT3AnxjZVo3QQx0zTok/ux
	 zCdyI/LUKSXDijeGa7lmCW1VMJRnCvNgoS8cUS+/cJDYLh3PXZ2IKOfEkVQXdD9K22
	 CwwhejZ1bxprFs3uUApNaaGGFXqpZxYaKN2BDAyoOyTUcNaHYNbchS7bhPyYIuilDL
	 qRCo4deQOpwIYc6czweTxtNqOT2MSfpFlRDdxTuNfPkFl+jJ5DIQ+tOGhumMqHDSqT
	 ZkYR+6B90IE1g==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: deb-pkg: split debian/copyright
Date: Wed, 20 Dec 2023 00:40:49 +0900
Message-Id: <20231219154049.1095323-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy debian/copyright instead of generating it by the 'cat' command.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/debian/copyright | 16 ++++++++++++++++
 scripts/package/mkdebian         | 21 +--------------------
 2 files changed, 17 insertions(+), 20 deletions(-)
 create mode 100644 scripts/package/debian/copyright

diff --git a/scripts/package/debian/copyright b/scripts/package/debian/copyright
new file mode 100644
index 000000000000..388a204b0b2b
--- /dev/null
+++ b/scripts/package/debian/copyright
@@ -0,0 +1,16 @@
+This is a packaged upstream version of the Linux kernel.
+
+The sources may be found at most Linux archive sites, including:
+https://www.kernel.org/pub/linux/kernel
+
+Copyright: 1991 - 2018 Linus Torvalds and others.
+
+The git repository for mainline kernel development is at:
+git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; version 2 dated June, 1991.
+
+On Debian GNU/Linux systems, the complete text of the GNU General Public
+License version 2 can be found in `/usr/share/common-licenses/GPL-2'.
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index c1a36da85e84..91f0e09600b1 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -188,26 +188,6 @@ $sourcename ($packageversion) $distribution; urgency=low
  -- $maintainer  $(date -R)
 EOF
 
-# Generate copyright file
-cat <<EOF > debian/copyright
-This is a packaged upstream version of the Linux kernel.
-
-The sources may be found at most Linux archive sites, including:
-https://www.kernel.org/pub/linux/kernel
-
-Copyright: 1991 - 2018 Linus Torvalds and others.
-
-The git repository for mainline kernel development is at:
-git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; version 2 dated June, 1991.
-
-On Debian GNU/Linux systems, the complete text of the GNU General Public
-License version 2 can be found in \`/usr/share/common-licenses/GPL-2'.
-EOF
-
 # Generate a control file
 cat <<EOF > debian/control
 Source: $sourcename
@@ -268,6 +248,7 @@ ARCH := ${ARCH}
 KERNELRELEASE := ${KERNELRELEASE}
 EOF
 
+cp "${srctree}/scripts/package/debian/copyright" debian/
 cp "${srctree}/scripts/package/debian/rules" debian/
 
 exit 0
-- 
2.40.1


