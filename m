Return-Path: <linux-kernel+bounces-57041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94BE84D326
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82DD5B25F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392C81759;
	Wed,  7 Feb 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W5QNNRMn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D412881A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338864; cv=none; b=WlZBbkVqTweezQz7xot1k0J/N9YjN1wrHFVFOUPqzhPHZd6swFD6VzFQZWseiwA/k57B88M+8eNFRGk6j6QFaQ4EiNCeRbvU5nwe8Wt7qPmgJO95na8jFl4PCzA/dK9As5r8EUSTC2VdN7wL+kvPQ97U5TvwYE/zdh5Gz7sHrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338864; c=relaxed/simple;
	bh=jFwA/NtxsFOo56zJu2RwmcNH+793//zqH+c/RYV4s9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHgtU5tcg63+mpWnc+pVfhrY2ml3qmQO+d74vyTPl5B7hgJuSjoouTSIhPbKgpb24HciBMJElLeHHsPxscYG2P4AJh5RJmN5OpMiTcND8kZZcNSeZ1PnWp/EHUrAFW4BMrXO44jEoD+iemmPdMVkPdQ707m8E9k+PtAKlxXkM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W5QNNRMn reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 355D640E00B2;
	Wed,  7 Feb 2024 20:47:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TwaAdgGsXQBT; Wed,  7 Feb 2024 20:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707338854; bh=Z8aiuw1r4xLDfMnzkrPrgauAKJFimYCWgbGUomsVP9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=W5QNNRMnpaRZ920NcKrLqe+gSg/aP+qUkaCHHwnZaVWt/ME9g1IjlMe874wYH1gdM
	 f0Rvzpq6LOb4NCbVv0uogmm7YelQRbtoZABSSTlUHnR8sRkZniVsdk1dW9qA+keY1X
	 +gwzhXF+I3QzRVlJovdsaBotES5jR2ny9C7/C/Oh/Tk2uNQqZ5O0fT7/eyMdKwK9nY
	 q1gK6xRkb4kP4rdKq65KLWHletMUX4tmxEdCm4s7ZDiRDKJEnTNknvmtqK+QdlgbAG
	 7ihxs1okOYt1TYhmuIy6saDGzuvs8vtEmHYB8cUVH5vn68HOqthtzt72gIlGL4/a0F
	 lMkUNbgzt65NcUWD0xrz6lpDj9QFfbDEL/T/eCnzk7uPEdJO8UnS9t8MV2RLbkeS7v
	 jpcttvrQMVt0Utx8BZ2WDB101Axc3iwQo/91jH+dbIJugna2jSO0ImTDimRblH+nCQ
	 JXMXtjrjGVgg4SREtIptKe4srGgAFK+dDPykyhbla1wIdd4h0Va6BhJvYIQ1XUNP0/
	 1ih1rUfHXvj2s1pJGw9Av1zjXGxBwHCuBfB3ltYbavIPFGxP5TM8ncgwfjQLxS+Xwp
	 kS9bPFoDxs/lelqYionEjV56aB9YRFAcRroi5KEDQhc5Z485LyyZ9/w7ifkiZtigzP
	 Ipr7OAfOvAMbmJVyJzSQOAes=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2773540E0192;
	Wed,  7 Feb 2024 20:47:30 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: ccp - Have it depend on AMD_IOMMU
Date: Wed,  7 Feb 2024 21:47:21 +0100
Message-ID: <20240207204721.6189-1-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

sev-dev.c calls code in the AMD IOMMU now but that can't really work if
latter is not enabled in Kconfig:

  ld: vmlinux.o: in function `__sev_firmware_shutdown.isra.0':
  sev-dev.c:(.text+0x2501f0e): undefined reference to `amd_iommu_snp_disa=
ble'
  ld: vmlinux.o: in function `snp_rmptable_init':
  sev.c:(.init.text+0x26260): undefined reference to `amd_iommu_snp_en'
  make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
  make: *** [Makefile:240: __sub-make] Error 2

Fix those deps.

Fixes: f366a8dac1b8 ("iommu/amd: Clean up RMP entries for IOMMU pages dur=
ing SNP shutdown")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/crypto/ccp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/Kconfig b/drivers/crypto/ccp/Kconfig
index 32268e239bf1..f394e45e11ab 100644
--- a/drivers/crypto/ccp/Kconfig
+++ b/drivers/crypto/ccp/Kconfig
@@ -38,7 +38,7 @@ config CRYPTO_DEV_CCP_CRYPTO
 config CRYPTO_DEV_SP_PSP
 	bool "Platform Security Processor (PSP) device"
 	default y
-	depends on CRYPTO_DEV_CCP_DD && X86_64
+	depends on CRYPTO_DEV_CCP_DD && X86_64 && AMD_IOMMU
 	help
 	 Provide support for the AMD Platform Security Processor (PSP).
 	 The PSP is a dedicated processor that provides support for key
--=20
2.43.0


