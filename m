Return-Path: <linux-kernel+bounces-155013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4428AE45A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D830F282CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B3D1292CD;
	Tue, 23 Apr 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T26Hqxue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197F126F3F;
	Tue, 23 Apr 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872410; cv=none; b=XLqaMNg6763hEvJnDC9cZkIYEM53PpzWABVJW4YhzVp2HNANCVQI3OhPzvkHvRdbi+Dvmucf1h9A59MSFrB0gXezCj56J1XpR5zSWAH2LUJ2lzScYou9IkDiAa6aZWvU5IrWyHKIuA94skRwBk1tnPYuuh2T7tSnGgiB5JGSsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872410; c=relaxed/simple;
	bh=BUu7gSVq7EVIapepEGDTH6KVx8cTZeOA7YDgtQSfOKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSZAhio6OIZtfk1Lf0C3pqZfHRpuCN0AcxVzytkUk/DxSPEwZf2PHxmyczdDCxsJWSLFfp2gnfrFBD5th1DYohiqVZ2LPsVUAt4LJTJ38+zVk5QaaK22eCVF4efk40muBDlnH6lKLW0NuDg190R3zuNjWt6UPi0eTvVPDKhqlKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T26Hqxue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71015C2BD11;
	Tue, 23 Apr 2024 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872409;
	bh=BUu7gSVq7EVIapepEGDTH6KVx8cTZeOA7YDgtQSfOKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T26HqxueHe14iMiLW7WG7T5gxN+Xq/8/xLLcT/AXlWqmeWQ1UyAA7JPGgNwKN35wE
	 rNqde0e7V4wtLf+qjre3F8Pm9jq3x6y/58fHhpkLKSgtJfZURoZxDNzA0/rFNLKEea
	 BbB3H8Wzz7RFszcenVDDikZiUPeg7RYMxtLGlENjQt7y8M/SRUejX8iCk4BYjCwzlf
	 gncbl8fAIfhafIinkTjMLOVLOSwqMCITaSzfwoBT/1yah6NG92w7hZWAobLwxUYbKU
	 C4dBZk1o/rQOMSZGqXOCRqifk/hBZ1QxBO90aAofdqzla+UgFp+hQaIR7B6VwGLxjS
	 hyMmJ5GS4XiSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.8 05/18] powerpc/crypto/chacha-p10: Fix failure on non Power10
Date: Tue, 23 Apr 2024 07:01:01 -0400
Message-ID: <20240423110118.1652940-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 69630926011c1f7170a465b7b5c228deb66e9372 ]

The chacha-p10-crypto module provides optimised chacha routines for
Power10. It also selects CRYPTO_ARCH_HAVE_LIB_CHACHA which says it
provides chacha_crypt_arch() to generic code.

Notably the module needs to provide chacha_crypt_arch() regardless of
whether it is loaded on Power10 or an older CPU.

The implementation of chacha_crypt_arch() already has a fallback to
chacha_crypt_generic(), however the module as a whole fails to load on
pre-Power10, because of the use of module_cpu_feature_match().

This breaks for example loading wireguard:

  jostaberry-1:~ # modprobe -v wireguard
  insmod /lib/modules/6.8.0-lp155.8.g7e0e887-default/kernel/arch/powerpc/crypto/chacha-p10-crypto.ko.zst
  modprobe: ERROR: could not insert 'wireguard': No such device

Fix it by removing module_cpu_feature_match(), and instead check the
CPU feature manually. If the CPU feature is not found, the module
still loads successfully, but doesn't register the Power10 specific
algorithms. That allows chacha_crypt_generic() to remain available for
use, fixing the problem.

  [root@fedora ~]# modprobe -v wireguard
  insmod /lib/modules/6.8.0-00001-g786a790c4d79/kernel/net/ipv4/udp_tunnel.ko
  insmod /lib/modules/6.8.0-00001-g786a790c4d79/kernel/net/ipv6/ip6_udp_tunnel.ko
  insmod /lib/modules/6.8.0-00001-g786a790c4d79/kernel/lib/crypto/libchacha.ko
  insmod /lib/modules/6.8.0-00001-g786a790c4d79/kernel/arch/powerpc/crypto/chacha-p10-crypto.ko
  insmod /lib/modules/6.8.0-00001-g786a790c4d79/kernel/lib/crypto/libchacha20poly1305.ko
  insmod /lib/modules/6.8.0-00001-g786a790c4d79/kernel/drivers/net/wireguard/wireguard.ko
  [   18.910452][  T721] wireguard: allowedips self-tests: pass
  [   18.914999][  T721] wireguard: nonce counter self-tests: pass
  [   19.029066][  T721] wireguard: ratelimiter self-tests: pass
  [   19.029257][  T721] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
  [   19.029361][  T721] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.

Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/20240315122005.GG20665@kitsune.suse.cz/
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240328130200.3041687-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/crypto/chacha-p10-glue.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/crypto/chacha-p10-glue.c b/arch/powerpc/crypto/chacha-p10-glue.c
index 74fb86b0d2097..7c728755852e1 100644
--- a/arch/powerpc/crypto/chacha-p10-glue.c
+++ b/arch/powerpc/crypto/chacha-p10-glue.c
@@ -197,6 +197,9 @@ static struct skcipher_alg algs[] = {
 
 static int __init chacha_p10_init(void)
 {
+	if (!cpu_has_feature(CPU_FTR_ARCH_31))
+		return 0;
+
 	static_branch_enable(&have_p10);
 
 	return crypto_register_skciphers(algs, ARRAY_SIZE(algs));
@@ -204,10 +207,13 @@ static int __init chacha_p10_init(void)
 
 static void __exit chacha_p10_exit(void)
 {
+	if (!static_branch_likely(&have_p10))
+		return;
+
 	crypto_unregister_skciphers(algs, ARRAY_SIZE(algs));
 }
 
-module_cpu_feature_match(PPC_MODULE_FEATURE_P10, chacha_p10_init);
+module_init(chacha_p10_init);
 module_exit(chacha_p10_exit);
 
 MODULE_DESCRIPTION("ChaCha and XChaCha stream ciphers (P10 accelerated)");
-- 
2.43.0


