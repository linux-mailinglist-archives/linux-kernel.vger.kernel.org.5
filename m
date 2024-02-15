Return-Path: <linux-kernel+bounces-66419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAD4855C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07311C21E26
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832EF125B6;
	Thu, 15 Feb 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8QsKOXK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE0B67D;
	Thu, 15 Feb 2024 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985951; cv=none; b=scFJ6IA2rSFVXstrJY6Gse8NZy1XolZC6a0kLymwkagHGUMrdSAWeREiFNVIOOpSt0GCKyQ4owJIs1v1SYSR2XB6GukXtDUwr6EP/QL5uDa8E5dHz3YiklFtjTN6LhpVZNFj4N4gbUphhdcU/Kg1qHFJyqeEZfz69glzt8A9Vmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985951; c=relaxed/simple;
	bh=UGfF3lZh/KRtVtdUp6G6TZfp0sNrsZF0XSORI0xUMqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t/mRUZrrHF+pyq17F9j9WVDurhskwxTAgFPiUdXnmEVxM4Lm9lb3ddsJX301A9dSwrhOWLMvzp65P83dvV2YgNX+VaLAZCRm8ZQBrIYswJ4RFExOWBpwWm4FMZFl5LjiDrVyo8FlHv+JRDfbE6NER3W90Sn5AAeJaIlCiPJQN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8QsKOXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A71FC433F1;
	Thu, 15 Feb 2024 08:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707985951;
	bh=UGfF3lZh/KRtVtdUp6G6TZfp0sNrsZF0XSORI0xUMqc=;
	h=From:To:Cc:Subject:Date:From;
	b=i8QsKOXKyHAd6n28S9dhVqcePsxd7+GXhKkS0K6gYkoj6rN9LqZ0Rc0QgZiG1WZJu
	 EW3mQrItGu4KHyMPz12l9rhBTpYClYR4MN+UWhFyF1dTjO/Z/DieqmrTYwjY1F21id
	 tad+V68IP0d5n4lIQjhUELQMdh+lojWDIc/fUYYhfz5hshSl4mv8ruEG+ntj/ZDng5
	 8gUJqbVJBI77WMkSVfI9ims40OuBZUZ+VfhwskM2AkUgnfekCz2pnukWlZEp7kVUIG
	 6zElqNqeDA4KRJ+rVBGNOml2711HtD7oE0KnGfTja69xEjloD3YPq8j8nAD5LwmfeI
	 koCu3N2PTpowQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] kallsyms: ignore ARMv4 thunks along with others
Date: Thu, 15 Feb 2024 09:32:08 +0100
Message-Id: <20240215083225.3976252-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

lld is now able to build ARMv4 and ARMv4T kernels, which means it can
generate thunks for those (__ARMv4PILongThunk_*, __ARMv4PILongBXThunk_*)
that can interfere with kallsyms table generation since they do not get
ignore like the corresponding ARMv5+ ones are:

Inconsistent kallsyms data
Try "make KALLSYMS_EXTRA_PASS=1" as a workaround

Replace the hardcoded list of thunk symbols with a more general regex that
covers this one along with future symbols that follow the same pattern.

Fixes: 5eb6e280432d ("ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer")
Fixes: efe6e3068067 ("kallsyms: fix nonconverging kallsyms table with lld")
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use a regular expression instead of listing each one.
---
 scripts/mksysmap | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index 9ba1c9da0a40..57ff5656d566 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -48,17 +48,8 @@ ${NM} -n ${1} | sed >${2} -e "
 / __kvm_nvhe_\\$/d
 / __kvm_nvhe_\.L/d
 
-# arm64 lld
-/ __AArch64ADRPThunk_/d
-
-# arm lld
-/ __ARMV5PILongThunk_/d
-/ __ARMV7PILongThunk_/d
-/ __ThumbV7PILongThunk_/d
-
-# mips lld
-/ __LA25Thunk_/d
-/ __microLA25Thunk_/d
+# lld arm/aarch64/mips thunks
+/ __[[:alnum:]]*Thunk_/d
 
 # CFI type identifiers
 / __kcfi_typeid_/d
-- 
2.39.2


