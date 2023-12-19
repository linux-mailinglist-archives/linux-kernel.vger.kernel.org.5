Return-Path: <linux-kernel+bounces-5801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B6818FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AB72892B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428CF37D3B;
	Tue, 19 Dec 2023 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cbjnk3Od"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170337D11;
	Tue, 19 Dec 2023 18:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE844C433C9;
	Tue, 19 Dec 2023 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703010004;
	bh=AaFL2QfFHAQnWIfLNvEB+DuhYCBztejbdLjDhGWXvY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cbjnk3Od9pe0nhW2pQ5anOAp0pBEoTzfI6g55UqQsO2aS2U70MCYydnkIk1Rwv8rD
	 fypHHP3Stmizb7qeEn2IF7y2Vr6MIT77+ILqW1Em29qfgMqvwoKwTbBjehzVbgK9up
	 pLEg+b4xGwiir+nDHVeRXwdQXP25H1p/A0U9suwZpO7Vb+1x9/GRvgiWJ1Mya2rn9H
	 cN5BEF9Q6Bmfj3VM8qYxbyTFIjYI+ZOGb7NOfVUm8DdDw/CZ6Cy11Sn17kE4W8Jbos
	 XRuthpHzn150f9gxEBnhJKLobHfMgBUdlj6gHyPX7sCmJhUvSN38nx6XInZJ85Ih+M
	 uLWtezgbQvuvw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kbuild: deb-pkg: hard-code Build-Depends
Date: Wed, 20 Dec 2023 03:19:56 +0900
Message-Id: <20231219181957.1449958-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231219181957.1449958-1-masahiroy@kernel.org>
References: <20231219181957.1449958-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The condition to require libelf-dev:native is stale because objtool is
now enabled by CONFIG_OBJTOOL instead of CONFIG_UNWINDER_ORC. Not only
objtool but also resolve_btfids requires libelf-dev:native; therefore,
CONFIG_DEBUG_INFO_BTF should be checked as well.

Similarly, CONFIG_SYSTEM_TRUSTED_KEYRING is not the only case that
requires libssl-dev:native.

Perhaps, the following code would provide better coverage, but it is
hard to maintain (and may still be imperfect).

  if is_enabled CONFIG_OBJTOOL || is_enabled CONFIG_DEBUG_INFO_BTF; then
          build_depends="${build_depends}, libelf-dev:native"
  fi

  if is_enabled CONFIG_SYSTEM_TRUSTED_KEYRING ||
     is_enabled CONFIG_SYSTEM_REVOCATION_LIST ||
     is_enabled CONFIG_MODULE_SIG_FORMAT; then
          build_depends="${build_depends}, libssl-dev:native"
  fi

Let's hard-code the build dependency.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkdebian | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 91f0e09600b1..93a24712b9a1 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -176,8 +176,6 @@ else
 fi
 
 echo $debarch > debian/arch
-extra_build_depends=", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-dev:native)"
-extra_build_depends="$extra_build_depends, $(if_enabled_echo CONFIG_SYSTEM_TRUSTED_KEYRING libssl-dev:native)"
 
 # Generate a simple changelog template
 cat <<EOF > debian/changelog
@@ -195,7 +193,8 @@ Section: kernel
 Priority: optional
 Maintainer: $maintainer
 Rules-Requires-Root: no
-Build-Depends: bc, debhelper, rsync, kmod, cpio, bison, flex $extra_build_depends
+Build-Depends: debhelper
+Build-Depends-Arch: bc, bison, cpio, flex, kmod, libelf-dev:native, libssl-dev:native, rsync
 Homepage: https://www.kernel.org/
 
 Package: $packagename-$version
-- 
2.40.1


