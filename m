Return-Path: <linux-kernel+bounces-145970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A85B8A5DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C61B21371
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91413157A7D;
	Mon, 15 Apr 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S/BLFsi2"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179C154C11;
	Mon, 15 Apr 2024 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713219564; cv=none; b=p1N1sx0pUTmgYec9tJ0Isl/x06GdJDv1RVzuMxsKtHe5EbOS7mdCxffcjXCvRbnzVsHDw2Zk83QT9nC+msosd2fd2R0D8LRWlsEkWw/dbZmRFmJcppfvLL2CbGDsV2Nrl2osCKdMUZc8mQL4dVcgAXaYwA9SEU+2i+49hxlH2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713219564; c=relaxed/simple;
	bh=PNvp7gmlHIY1h3LCNlaBN5CUutf9dFC3Ice5JZ8QJeI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uHQECMvdKw/4eciJyztfMbj9hcdtTZhTqMIVR59wXvDBUfrufdCZgPPfMa/M38lVYiqnWUSsmlYO+px58mrCFft9+MIsFJFCjGIP1AJioq81LqjJw6toy3aVWRWjrbRv5VB07va+6sB9RaXB2holrXlkKlAVPWiUfou8qSVGmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=S/BLFsi2; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713219564; x=1744755564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o5xHlLkxJsRm7EFmKP4Jmd4YBjmBD9lf5st0GZDp2Z4=;
  b=S/BLFsi218wJezY5vJs+bxpyR/uE8pE+PKod4JemzgEmgk5TX99gLB92
   jxFalcdpXxETBXAU23MibDDa2Pn5ZDNg4y9+oJUW+VPJsVE3A5c+5fz3W
   nU2BaIWjoNShJ4HPsjklnj+p7Ct8oC9MliQx+ZJea11JL9vt353lJa6m3
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,204,1708387200"; 
   d="scan'208";a="647808149"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:19:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:12664]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.207:2525] with esmtp (Farcaster)
 id 66a8cb9e-2e2e-4cd7-8cf1-e3f8e5cba40e; Mon, 15 Apr 2024 22:19:21 +0000 (UTC)
X-Farcaster-Flow-ID: 66a8cb9e-2e2e-4cd7-8cf1-e3f8e5cba40e
Received: from EX19D046UWB003.ant.amazon.com (10.13.139.174) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:19:21 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D046UWB003.ant.amazon.com (10.13.139.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 22:19:20 +0000
Received: from dev-dsk-hailmo-2b-4e49cd2f.us-west-2.amazon.com (172.16.42.153)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 15 Apr 2024 22:19:20 +0000
Received: by dev-dsk-hailmo-2b-4e49cd2f.us-west-2.amazon.com (Postfix, from userid 13307802)
	id 561894151A; Mon, 15 Apr 2024 22:19:20 +0000 (UTC)
From: Hailey Mothershead <hailmo@amazon.com>
To: <herbert@gondor.apana.org.au>
CC: <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <hailmo@amazon.com>
Subject: [PATCH v2 2/2] crypto: aead,cipher - zeroize key buffer after use
Date: Mon, 15 Apr 2024 22:19:15 +0000
Message-ID: <20240415221915.20701-1-hailmo@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

I.G 9.7.B for FIPS 140-3 specifies that variables temporarily holding
cryptographic information should be zeroized once they are no longer
needed. Accomplish this by using kfree_sensitive for buffers that
previously held the private key.

Signed-off-by: Hailey Mothershead <hailmo@amazon.com>
---
 crypto/aead.c   | 3 +--
 crypto/cipher.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/crypto/aead.c b/crypto/aead.c
index 16991095270d..c4ece86c45bc 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -35,8 +35,7 @@ static int setkey_unaligned(struct crypto_aead *tfm, const u8 *key,
 	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	memcpy(alignbuffer, key, keylen);
 	ret = crypto_aead_alg(tfm)->setkey(tfm, alignbuffer, keylen);
-	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kfree_sensitive(buffer);
 	return ret;
 }
 
diff --git a/crypto/cipher.c b/crypto/cipher.c
index b47141ed4a9f..395f0c2fbb9f 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -34,8 +34,7 @@ static int setkey_unaligned(struct crypto_cipher *tfm, const u8 *key,
 	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	memcpy(alignbuffer, key, keylen);
 	ret = cia->cia_setkey(crypto_cipher_tfm(tfm), alignbuffer, keylen);
-	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kfree_sensitive(buffer);
 	return ret;
 
 }
-- 
2.40.1

memsets removed and first patch in series dropped.

