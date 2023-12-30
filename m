Return-Path: <linux-kernel+bounces-13412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6078204E8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9761F21A57
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72598489;
	Sat, 30 Dec 2023 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvzCUTf3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92C79CD;
	Sat, 30 Dec 2023 12:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92641C433C8;
	Sat, 30 Dec 2023 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703937780;
	bh=I0sLm5lct4CIXbsmhr7A8MxTCEwFuAfK7d4Ctz+IHMM=;
	h=From:To:Cc:Subject:Date:From;
	b=kvzCUTf3XfgDgNEz5jz1kB7Hfcke9qy7ObQH7UfEIcYhNqRNwo+YTE3eVmNW5gx8d
	 m/Qh+jsFhxyTr1PLaxYtqFibAdEFOjymwZmqu1CK19kEbrd+Ev/LdEpbiI5PNYa4u6
	 4kXTo6053yjaQIhfZaCSf1xTo1KdZjCFJRZhtf6dF0TT+QDmmF6+Ie+UFSXeBkubs5
	 8HucjE4cuP6yUzqvyLXkNRnkLwY/872yoI8/iXvLL1tu5eufq1c/szA0BRoNPkZTpI
	 +TIyPX3swjkr50BctS/zZqMKvkJAhwNJs8Kifk8zmiPWaYs6En5XZppTBr3VA3YKgI
	 jytpPEt+b4o+Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: deb-pkg: do not search for 'scripts' directory under arch/
Date: Sat, 30 Dec 2023 21:02:52 +0900
Message-Id: <20231230120252.987732-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'scripts' directory was searched under arch/${SRCARCH} here to
copy arch/ia64/scripts, but commit cf8e8658100d ("arch: Remove Itanium
(IA-64) architecture") removed the IA-64 support.

There is another 'scripts' directory in arch/um, but this script is
never executed with SRCARCH=um because UML does not support the
linux-headers package.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/install-extmod-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
index 8a7051fad087..76e0765dfcd6 100755
--- a/scripts/package/install-extmod-build
+++ b/scripts/package/install-extmod-build
@@ -20,7 +20,7 @@ mkdir -p "${destdir}"
 	find "arch/${SRCARCH}" -maxdepth 1 -name 'Makefile*'
 	find include scripts -type f -o -type l
 	find "arch/${SRCARCH}" -name Kbuild.platforms -o -name Platform
-	find "arch/${SRCARCH}" -name include -o -name scripts -type d
+	find "arch/${SRCARCH}" -name include -type d
 ) | tar -c -f - -C "${srctree}" -T - | tar -xf - -C "${destdir}"
 
 {
-- 
2.40.1


