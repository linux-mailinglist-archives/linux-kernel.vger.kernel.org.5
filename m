Return-Path: <linux-kernel+bounces-162552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AE58B5D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F13281D52
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970B1824A6;
	Mon, 29 Apr 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Atfc3Nfz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516A846B;
	Mon, 29 Apr 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403292; cv=none; b=E2sGar/NSnEwTu8MWKjRC86oT+imuSPBWvJJ9WJ3kFDn6EypvQLZHcsQ9yQytPXzGZw2qHYkPd6EGDHOasRNruzaWbTnBRFhiPd0MUsE/Nsl/8wo1rz/jiZ7hNYbMvaqVmcJOvUhCClX5rClzVKZJC/8uq9q5UTihZ9nGx0S9oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403292; c=relaxed/simple;
	bh=U0cAz+c9sTGbDIN3OBVNFjWl2jR+Tx695VgOjeNXMmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S362oP1ZB8GVMVRocTJCGe/FyOwVw8nj0QKKxJ5M+1smAER7cy8q2m3syxen08+26MvkAMxHqUrKu5B45jlop2lysF/1Nc3/DZV4LJE3MmPEzHRgJOdisfJaC4Vzw01PFS1r4Bb7CqoL/krZjrI8A8Mg+onib9enPxYE4Sv2cz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Atfc3Nfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26533C113CD;
	Mon, 29 Apr 2024 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714403292;
	bh=U0cAz+c9sTGbDIN3OBVNFjWl2jR+Tx695VgOjeNXMmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Atfc3NfzTJ0OgbfSIei9mdm6zGOQ0nWCB3W3v7O49/nIzWMtgDe6S+rNhQcsULzI+
	 hsNWHp0/7gKUOwqBW55Qg8tTl8Ueu7xCCD2o8FX/AU5N29e0J1uEp6DDjhVRYbJs3Z
	 EdQH94mjgh4c45zOtLcN9UH6zzvGC3s9DTGeusD9P16wyERTHdZ/nfxmhEikYg/e55
	 bPier0zvkjSbn5Y+Ysef1f/1zjuA6D3gtncGaTpz1waZ4VXEm5aqg89qL8UigToxGC
	 IrR/DqsXI0f+b7xc6pCIdEvGTWzDfTA/xccF3Hz+GKWs1jTlQHxjqm9g74Oyz+FSLT
	 NaS2CeOdGvP2g==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH] kbuild: simplify generic vdso installation code
Date: Tue, 30 Apr 2024 00:07:54 +0900
Message-Id: <20240429150754.3178262-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 4b0bf9a01270 ("riscv: compat_vdso: install compat_vdso.so.dbg
to /lib/modules/*/vdso/") applied, all debug VDSO files are installed in
$(MODLIB)/vdso/.

Simplify the installation rule.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.vdsoinst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.vdsoinst b/scripts/Makefile.vdsoinst
index c477d17b0aa5..bf72880c50d0 100644
--- a/scripts/Makefile.vdsoinst
+++ b/scripts/Makefile.vdsoinst
@@ -13,16 +13,15 @@ install-dir := $(MODLIB)/vdso
 
 define gen_install_rules
 
-src := $$(firstword $$(subst :,$(space),$(1)))
-dest := $(install-dir)/$$(or $$(word 2,$$(subst :,$(space),$(1))),$$(patsubst %.dbg,%,$$(notdir $(1))))
+dest := $(install-dir)/$$(patsubst %.dbg,%,$$(notdir $(1)))
 
 __default: $$(dest)
-$$(dest): $$(src) FORCE
+$$(dest): $(1) FORCE
 	$$(call cmd,install)
 
 # Some architectures create .build-id symlinks
 ifneq ($(filter arm sparc x86, $(SRCARCH)),)
-link := $(install-dir)/.build-id/$$(shell $(READELF) -n $$(src) | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p').debug
+link := $(install-dir)/.build-id/$$(shell $(READELF) -n $(1) | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p').debug
 
 __default: $$(link)
 $$(link): $$(dest) FORCE
-- 
2.40.1


