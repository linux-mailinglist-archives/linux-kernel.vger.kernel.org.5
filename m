Return-Path: <linux-kernel+bounces-144310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8CB8A446F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446EE28250F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFEE135A58;
	Sun, 14 Apr 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh9g1Xmr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA629B0;
	Sun, 14 Apr 2024 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713116525; cv=none; b=klugOpb4Hrtt6Bus1sdbOTIMNGd7bCx4hoElmc4FuH/zuMvb9QvMWQe15DU1mk+/+kTlxPtEJUrdPFVZ7QAfODpnqusg/04wdP/dCNr93CpqTXQUfy4/brThHh0F09fC/NzhD7C0VworznYU4qCm4DhQRyi8GFW9YOwmOPXhVPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713116525; c=relaxed/simple;
	bh=8FW+xrlIJHw4Gazro4tzpsbrzXitmG/UKSl2dusUcnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sEBzzyP0eCnbKTzsphkAT5khKZD6B41nJj50Kc/iM9Qp9Ez1yUl+PNOERq3FHZpPL2m7rLQ+lTPArjlmm6u5Hb7X9xh8KQ3nUN6am+14Ex2lulk+vnfIxStqEumYSRET2b+Xp6psV5yssbdN7/t6WNFt5Rv56NpsiFwvEquWahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh9g1Xmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790A9C072AA;
	Sun, 14 Apr 2024 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713116524;
	bh=8FW+xrlIJHw4Gazro4tzpsbrzXitmG/UKSl2dusUcnM=;
	h=From:To:Cc:Subject:Date:From;
	b=Oh9g1Xmr9/brFwe2Ey7SwaFfQuyI5pFhHnx/glRDIYnuDpG2reshHENaWrJz4cp8+
	 TsaJKekv74BEUxPDHmJ2ri9w8SQZKokuMvxf2y6/nXKdRm93OtMpKDju2OCMOpFMfh
	 r1uGBAxKjP7feV9SoN4drqmxD0uEVuJqg1E0NYXmyixyYTRC0f1qnwUgpB7niqL9Ub
	 jfo+PPQ+rLx/3Km4F8Xdv81gZtjKOZ21vseUoL5MvlDW6f492i9mn5dzyK6wH1rMQm
	 rewJvPGN/xeGOrVKdWescBSbci4Ubns8Teabo2T3QvnpPKrEJg+KxDLVJ0375ogV0P
	 QKFGmz95c3ywA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] kbuild: buildtar: add comments about inconsistent package generation
Date: Mon, 15 Apr 2024 02:41:39 +0900
Message-Id: <20240414174139.3001175-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scripts/package/buildtar checks some kernel packages, and copies the
first image found. This may potentially produce an inconsistent (and
possibly wrong) package.

For instance, the for-loop for arm64 checks Image.{bz2,gz,lz4,lzma,lzo},
and vmlinuz.efi, then copies the first image found, which might be a
stale image.

When CONFIG_EFI_ZBOOT is enabled in the pristine source tree,
'make ARCH=arm64 tar-pkg' will build and copy vmlinuz.efi. This is the
expected behavior.

If you build the kernel with CONFIG_EFI_ZBOOT, Image.gz will be created,
which will remain in the build directory unless you clean it. Even if
CONFIG_EFI_ZBOOT is turned on later, 'make ARCH=arm64 tar-pkg' will copy
stale Image.gz instead of the latest vmlinuz.efi, as Image.gz takes
precedence over vmlinuz.efi.

In summary, the code "[ -f ... ] && cp" does not consistently produce
the desired outcome.

The other package scripts are deterministic; scripts/package/mkdebian,
for example, chooses a copied kernel image based on CONFIG options.

I removed [ -f ... ] checks from x86, alpha, parisc, and the default
because they have a single kernel image to copy. If it is missing, it
should be an error.

I did not modify the code for mips, arm64, riscv. Instead, I left some
comments. Eventually, someone may fix the code, or at the very least,
it may discourage the copy-pasting of incorrect code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/buildtar | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index 72c91a1b832f..ed8d9b496305 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -53,18 +53,24 @@ cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
 #
 # Install arch-specific kernel image(s)
 #
+# Note:
+#   mips, arm64, and riscv copy the first image found. This may not produce
+#   the desired outcome because it may pick up a stale file remaining in the
+#   build tree.
+#
 case "${ARCH}" in
 	x86|i386|x86_64)
-		[ -f "${objtree}/arch/x86/boot/bzImage" ] && cp -v -- "${objtree}/arch/x86/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
+		cp -v -- "${objtree}/arch/x86/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
 		;;
 	alpha)
-		[ -f "${objtree}/arch/alpha/boot/vmlinux.gz" ] && cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
+		cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
 		;;
 	parisc*)
-		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
+		cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
 		[ -f "${objtree}/lifimage" ] && cp -v -- "${objtree}/lifimage" "${tmpdir}/boot/lifimage-${KERNELRELEASE}"
 		;;
 	mips)
+		# Please note the following code may copy a stale file.
 		if [ -f "${objtree}/arch/mips/boot/compressed/vmlinux.bin" ]; then
 			cp -v -- "${objtree}/arch/mips/boot/compressed/vmlinux.bin" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
 		elif [ -f "${objtree}/arch/mips/boot/compressed/vmlinux.ecoff" ]; then
@@ -86,6 +92,7 @@ case "${ARCH}" in
 		fi
 		;;
 	arm64)
+		# Please note the following code may copy a stale file.
 		for i in Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo vmlinuz.efi ; do
 			if [ -f "${objtree}/arch/arm64/boot/${i}" ] ; then
 				cp -v -- "${objtree}/arch/arm64/boot/${i}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
@@ -94,6 +101,7 @@ case "${ARCH}" in
 		done
 		;;
 	riscv)
+		# Please note the following code may copy a stale file.
 		for i in Image.bz2 Image.gz Image; do
 			if [ -f "${objtree}/arch/riscv/boot/${i}" ] ; then
 				cp -v -- "${objtree}/arch/riscv/boot/${i}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
@@ -102,7 +110,7 @@ case "${ARCH}" in
 		done
 		;;
 	*)
-		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
+		cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
 		echo "" >&2
 		echo '** ** **  WARNING  ** ** **' >&2
 		echo "" >&2
-- 
2.40.1


