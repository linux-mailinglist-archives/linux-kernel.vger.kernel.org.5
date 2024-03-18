Return-Path: <linux-kernel+bounces-105606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2465B87E145
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3686282620
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EB4125CA;
	Mon, 18 Mar 2024 00:43:33 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2450F9C8;
	Mon, 18 Mar 2024 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710722613; cv=none; b=DylPgiLphiWLbPE9bP/2RPIDWR1VKlWzabjnrP/l5KAgkbdPu0IArKGfTDZ99lz4Cbz2nWs4ntPkIdbiH/F/nuGEwpZ/tVrvdSQR48IDT4YtYr88GPmjyVHco2NQbtvpELhQZLjkeyo2Xzasnnu7A8FA+SzcRUaeTBRLEDv27NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710722613; c=relaxed/simple;
	bh=uJMCAo6oQPgb1Sif+u5CTBxzLZGo22rQRJdgKSMDosc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9XRc52O18vapDNtZL9AHL5FdcJR6FtPCbuxD6vYZ8tZ3xUzCGRTBHSQte86W0Q+YTGupmjPErmy8T0x1M5jVqVeuyLNliPbYK4exyf5JGQfcRODBFcWlcXNf63dYMtNnzOF7e+oSzGtET0WbwvxlAiwK0Fi5soSn0aVH9oygA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 7503E72C8F5;
	Mon, 18 Mar 2024 03:43:22 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 6649F36D015F;
	Mon, 18 Mar 2024 03:43:22 +0300 (MSK)
From: Vitaly Chikunov <vt@altlinux.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Wolneykien <manowar@altlinux.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH] crypto: ecrdsa - Fix module auto-load on add_key
Date: Mon, 18 Mar 2024 03:42:40 +0300
Message-ID: <20240318004241.2925876-1-vt@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add module alias with the algorithm cra_name similar to what we have for
RSA-related and other algorithms.

The kernel attempts to modprobe asymmetric algorithms using the names
"crypto-$cra_name" and "crypto-$cra_name-all." However, since these
aliases are currently missing, the modules are not loaded. For instance,
when using the `add_key` function, the hash algorithm is typically
loaded automatically, but the asymmetric algorithm is not.

Steps to test:

1. Cert is generated usings ima-evm-utils test suite with
   `gen-keys.sh`, example cert is provided below:

  $ base64 -d >test-gost2012_512-A.cer <<EOF
  MIIB/DCCAWagAwIBAgIUK8+whWevr3FFkSdU9GLDAM7ure8wDAYIKoUDBwEBAwMFADARMQ8wDQYD
  VQQDDAZDQSBLZXkwIBcNMjIwMjAxMjIwOTQxWhgPMjA4MjEyMDUyMjA5NDFaMBExDzANBgNVBAMM
  BkNBIEtleTCBoDAXBggqhQMHAQEBAjALBgkqhQMHAQIBAgEDgYQABIGALXNrTJGgeErBUOov3Cfo
  IrHF9fcj8UjzwGeKCkbCcINzVUbdPmCopeJRHDJEvQBX1CQUPtlwDv6ANjTTRoq5nCk9L5PPFP1H
  z73JIXHT0eRBDVoWy0cWDRz1mmQlCnN2HThMtEloaQI81nTlKZOcEYDtDpi5WODmjEeRNQJMdqCj
  UDBOMAwGA1UdEwQFMAMBAf8wHQYDVR0OBBYEFCwfOITMbE9VisW1i2TYeu1tAo5QMB8GA1UdIwQY
  MBaAFCwfOITMbE9VisW1i2TYeu1tAo5QMAwGCCqFAwcBAQMDBQADgYEAmBfJCMTdC0/NSjz4BBiQ
  qDIEjomO7FEHYlkX5NGulcF8FaJW2jeyyXXtbpnub1IQ8af1KFIpwoS2e93LaaofxpWlpQLlju6m
  KYLOcO4xK3Whwa2hBAz9YbpUSFjvxnkS2/jpH2MsOSXuUEeCruG/RkHHB3ACef9umG6HCNQuAPY=
  EOF

2. Optionally, trace module requests with: trace-cmd stream -e module &

3. Trigger add_key call for the cert:

  # keyctl padd asymmetric "" @u <test-gost2012_512-A.cer
  939910969
  # lsmod | head -3
  Module                  Size  Used by
  ecrdsa_generic         16384  0
  streebog_generic       28672  0

Repored-by: Paul Wolneykien <manowar@altlinux.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 crypto/ecrdsa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/ecrdsa.c b/crypto/ecrdsa.c
index f3c6b5e15e75..3811f3805b5d 100644
--- a/crypto/ecrdsa.c
+++ b/crypto/ecrdsa.c
@@ -294,4 +294,5 @@ module_exit(ecrdsa_mod_fini);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Vitaly Chikunov <vt@altlinux.org>");
 MODULE_DESCRIPTION("EC-RDSA generic algorithm");
+MODULE_ALIAS_CRYPTO("ecrdsa");
 MODULE_ALIAS_CRYPTO("ecrdsa-generic");
-- 
2.42.1


