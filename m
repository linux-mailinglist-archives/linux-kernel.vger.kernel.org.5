Return-Path: <linux-kernel+bounces-6556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC6819A50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997BDB22A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794D61C6B1;
	Wed, 20 Dec 2023 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbYXuQdg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B701C6B8;
	Wed, 20 Dec 2023 08:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3802C433C8;
	Wed, 20 Dec 2023 08:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703060322;
	bh=h4av3AEKbsCjlzEe0jMEyyWsPDvGxt8dr0ELgdzdvy0=;
	h=From:To:Cc:Subject:Date:From;
	b=IbYXuQdgXi/SNUFxx4/PGxaDyb7q1iZ9mlKNVc9XmMqqcJOUkLaZdWNKK4QQhDC/P
	 L4hp90/GlylOcKBii/m6lytMVQU8pP16N2zEnNe0n3VlBN/s2gm/qMIi1i3mDYBbr/
	 7yZh3vPJIQNSvebqGR5y1KlOwD2K9Kix3VJx+QhlSGJB1OZB/uiQDVBgvx8MsNs0c2
	 oGTGPJiW48+BhusjLqSELBDpzAWkr6nGQ22lTavQw1oziINdEBdIrafL8hN9g8Drej
	 AuMi1Lhx0PSomWx4hkxNwkMGYeivDWwPVMjP3yInKsaYtQpVElimPb2JXb8Qk1dXsJ
	 nbgAGGKsmws5g==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix build ID symlinks to installed VDSO files
Date: Wed, 20 Dec 2023 17:18:33 +0900
Message-Id: <20231220081833.1551600-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 56769ba4b297 ("kbuild: unify vdso_install rules") accidentally
dropped the '.debug' suffix from the build ID symlinks.

Fixes: 56769ba4b297 ("kbuild: unify vdso_install rules")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.vdsoinst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.vdsoinst b/scripts/Makefile.vdsoinst
index 1022d9fdd976..c477d17b0aa5 100644
--- a/scripts/Makefile.vdsoinst
+++ b/scripts/Makefile.vdsoinst
@@ -22,7 +22,7 @@ $$(dest): $$(src) FORCE
 
 # Some architectures create .build-id symlinks
 ifneq ($(filter arm sparc x86, $(SRCARCH)),)
-link := $(install-dir)/.build-id/$$(shell $(READELF) -n $$(src) | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p')
+link := $(install-dir)/.build-id/$$(shell $(READELF) -n $$(src) | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p').debug
 
 __default: $$(link)
 $$(link): $$(dest) FORCE
-- 
2.40.1


