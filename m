Return-Path: <linux-kernel+bounces-153654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC08AD133
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD08282147
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E019B1534F7;
	Mon, 22 Apr 2024 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0UxBS1q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08614F10F;
	Mon, 22 Apr 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800810; cv=none; b=sj5VndCIJlgVuh/RSJagHDlvurlFlU5hCXYIZsKvhRjCw1/Bp+YH98h5qH1iW/ofTCyuELle01+hnoaxoZ424v1hq60RkkG1cKjgU6OpxUmhy823CzjuhPqrvNd1hViwU2IW7DTdc+MLL0fB7QH2Zp9lr4C8JS+6dMfyWIDqG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800810; c=relaxed/simple;
	bh=+qu0qv26kQloh1SQ/hJVXIzYgoo4nZLRiVKKumi1SoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eethvUWfdySX40W7mG2LHSsk7U5G1R8VAXpMIBYcUPrIWalSpUq6J02u5IzOwhS23D0XMrwa5Sh3Qs6Rps2PgdI+tXDhXASCxf5NnGP8Ka52NBF+fLSuWbbWvlJz6eaz36XZvKYUYsOzvP7o2bOGRw9Jg0/QmFk2nkYNwlMYly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0UxBS1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E3FC116B1;
	Mon, 22 Apr 2024 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713800809;
	bh=+qu0qv26kQloh1SQ/hJVXIzYgoo4nZLRiVKKumi1SoY=;
	h=From:To:Cc:Subject:Date:From;
	b=g0UxBS1qaHwN8y7ngvHwrhPBOsCmTU6fioNlK+hw9jVfVQpt+rcx8nS0fjjHjE3Vh
	 0rq/ccC+rBmacdExMk2wSgF+d1BY1ThbR0ggY3Cyb5PSrsIAkuzloZFKGkWp1qernA
	 XJhxbPiUZSZ5blhs8zdGVlMl9gtyOJ1sC6k8TYtmlSSuUsol5hcThN4Y1FOq0jmAMj
	 aTxehhrge949+rXFnFuSsOJOR0oIT+kI0f6gr+HPjlVGx9Fa14BJAqyfcFsCK2nSP2
	 NJ6pqvL6IxG2eZZiLnrTCbTeQDtqiJo1JxqwXFLZKWVyyXiEkwQR3L7ZzQH8rWVggs
	 oZOmcw9QQM/nw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: buildtar: remove warning for the default case
Date: Tue, 23 Apr 2024 00:46:10 +0900
Message-Id: <20240422154610.2864941-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given KBUILD_IMAGE properly set in arch/*/Makefile, the default case
should work in most scenarios. The only oddity is the naming of the
copy destination, vmlinux-kbuild-${KERNELRELEASE}. Let's rename it
to vmlinuz-${KERNELRELEASE} because the kernel is often compressed.
Remove the warning to avoid unnecessary patch submissions when the
default case suffices.

Remove the x86 case, which is now identical to the default.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/buildtar | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index ed8d9b496305..fe816f62a290 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -59,9 +59,6 @@ cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
 #   build tree.
 #
 case "${ARCH}" in
-	x86|i386|x86_64)
-		cp -v -- "${objtree}/arch/x86/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
-		;;
 	alpha)
 		cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
 		;;
@@ -110,13 +107,6 @@ case "${ARCH}" in
 		done
 		;;
 	*)
-		cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
-		echo "" >&2
-		echo '** ** **  WARNING  ** ** **' >&2
-		echo "" >&2
-		echo "Your architecture did not define any architecture-dependent files" >&2
-		echo "to be placed into the tarball. Please add those to ${0} ..." >&2
-		echo "" >&2
-		sleep 5
+		cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
 		;;
 esac
-- 
2.40.1


