Return-Path: <linux-kernel+bounces-39380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2789283CFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F327B23168
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6738D12E48;
	Thu, 25 Jan 2024 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpv5uh+J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C1125BC;
	Thu, 25 Jan 2024 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223361; cv=none; b=ie3HLYEW667cxlzK7pidHEc63mYk60D+lKaRd78emZRQwEBhROLmBAcmoHJBOXJMoHTvyLVg7XugglthvVORcsi0ZGKcd+x/8ySddpm7B2/t6pELyvC698kEmPymkqoVoUlg9zlUCXejWtOtW3PcOYI99LwAHpxx9KMtQwTNnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223361; c=relaxed/simple;
	bh=OeMGm6ictAkQDCkGVdUzwK+Cgapce5TRIlo9wxuF41g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMBF8YqYxpYMvmUjNXweR0zA3zUpZ/2CUZNcSpsMvHkxfX6NHtgJmvYXDNmvFFGr4nAx+YipsY5/EB9SXtn9su8eIG3jamUuXTSbJdFnJeM3e2FfdV/pL5X3ugwrDz9Cu1xt5GgNY47HYWTldPIt67jHeiD/97na/HdIW+H41Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpv5uh+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE69C43609;
	Thu, 25 Jan 2024 22:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223361;
	bh=OeMGm6ictAkQDCkGVdUzwK+Cgapce5TRIlo9wxuF41g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kpv5uh+JaKS3dsIYEaOmLE6zuPcoqJZCzUOR0LcqlWetBaNU4dk0oP1G5EYCvNfMu
	 HK2fjgHkZ4kVYiWA6j9NiUoF2oAnxMn+EXjdoH4RmNAKDQDn73qGPDZUCHPjTsD8jA
	 9/EurJ1JaOZN9fAGqzWuKumbA8h7FDTV8alxHKC2rhbS7D935vRbLg8xWuTAfkCXFZ
	 DtUONHR5OqMNvsMjUOxh76tPchYqbqZCX2Lv1izn28ZFU5iDySvzA2HSHfsTXkTTO6
	 qY945HLLauZF7ypR2unDDObkAQaR9ZurNWVNw11qhhNz4Vu779ReQ3HWKPYxr/yQRh
	 Fb+jxDpiseoYw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Jan 2024 15:55:07 -0700
Subject: [PATCH 01/11] kbuild: Raise the minimum supported version of LLVM
 to 13.0.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-bump-min-llvm-ver-to-13-0-1-v1-1-f5ff9bda41c5@kernel.org>
References: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
In-Reply-To: <20240125-bump-min-llvm-ver-to-13-0-1-v1-0-f5ff9bda41c5@kernel.org>
To: akpm@linux-foundation.org, masahiroy@kernel.org
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4149; i=nathan@kernel.org;
 h=from:subject:message-id; bh=OeMGm6ictAkQDCkGVdUzwK+Cgapce5TRIlo9wxuF41g=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmbnv3dscousljfz6bPS2q2+dVop2NnpnFUs058dLck/
 eD3dvHgjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRV7MY/mcGZK8U13/GHde7
 R8vqj1Tp8oibSm7GXCf+yN7KM/qVeJSRYb+kHnfRUh51DW2GAtGLFk2ZT35asT341MCW2np76Y9
 XHAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When __builtin_mul_overflow() has arguments that differ in terms of
signedness and width, LLVM may generate a libcall to __muloti4 because
it performs the checks in terms of 65-bit multiplication. This issue
becomes harder to hit (but still possible) after LLVM 12.0.0, which
includes a special case for matching widths but different signs.

To gain access to this special case, which the kernel can take advantage
of when calls to __muloti4 appear, bump the minimum supported version of
LLVM for building the kernel to 13.0.1. 13.0.1 was chosen because there
is minimal impact to distribution support while allowing a few more
workarounds to be dropped in the kernel source than if 12.0.0 were
chosen. Looking at container images of up to date distribution versions:

  archlinux:latest              clang version 16.0.6
  debian:oldoldstable-slim      clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  debian:oldstable-slim         Debian clang version 11.0.1-2
  debian:stable-slim            Debian clang version 14.0.6
  debian:testing-slim           Debian clang version 16.0.6 (19)
  debian:unstable-slim          Debian clang version 16.0.6 (19)
  fedora:38                     clang version 16.0.6 (Fedora 16.0.6-3.fc38)
  fedora:latest                 clang version 17.0.6 (Fedora 17.0.6-1.fc39)
  fedora:rawhide                clang version 17.0.6 (Fedora 17.0.6-1.fc40)
  opensuse/leap:latest          clang version 15.0.7
  opensuse/tumbleweed:latest    clang version 17.0.6
  ubuntu:focal                  clang version 10.0.0-4ubuntu1
  ubuntu:latest                 Ubuntu clang version 14.0.0-1ubuntu1.1
  ubuntu:rolling                Ubuntu clang version 16.0.6 (15)
  ubuntu:devel                  Ubuntu clang version 17.0.6 (3)

The only distribution that gets left behind is Debian Bullseye, as the
default version is 11.0.1; other distributions either have a newer
version than 13.0.1 or one older than the current minimum of 11.0.0.
Debian has easy access to more recent LLVM versions through
apt.llvm.org, so this is not as much of a concern. There are also the
kernel.org LLVM toolchains, which should work with distributions with
glibc 2.28 and newer.

Another benefit of slimming up the number of supported versions of LLVM
for building the kernel is reducing the build capacity needed to support
a matrix that builds with each supported version, which allows a matrix
to reallocate the freed up build capacity towards something else, such
as more configuration combinations.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1975
Link: https://github.com/llvm/llvm-project/issues/38013
Link: https://github.com/llvm/llvm-project/commit/3203143f1356a4e4e3ada231156fc6da6e1a9f9d
Link: https://mirrors.edge.kernel.org/pub/tools/llvm/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Documentation/process/changes.rst | 2 +-
 scripts/min-tool-version.sh       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 50b3d1cb1115..d7306b8cad13 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -30,7 +30,7 @@ you probably needn't concern yourself with pcmciautils.
         Program        Minimal version       Command to check the version
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
-Clang/LLVM (optional)  11.0.0           clang --version
+Clang/LLVM (optional)  13.0.1           clang --version
 Rust (optional)        1.74.1           rustc --version
 bindgen (optional)     0.65.1           bindgen --version
 GNU make               3.82             make --version
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 9faa4d3d91e3..5d17022ee1f6 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -29,7 +29,7 @@ llvm)
 	elif [ "$SRCARCH" = loongarch ]; then
 		echo 18.0.0
 	else
-		echo 11.0.0
+		echo 13.0.1
 	fi
 	;;
 rustc)

-- 
2.43.0


