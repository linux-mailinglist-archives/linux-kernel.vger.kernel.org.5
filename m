Return-Path: <linux-kernel+bounces-141728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29B8A22A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B821F283988
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E324D135;
	Thu, 11 Apr 2024 23:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MbC/XBCL"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E510487BE;
	Thu, 11 Apr 2024 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879560; cv=none; b=bO6sYfink+WXFBWao/4xf8Jthq2eH9MC0NDD3PcwfNH3yhZARu8UgBiPlifxnFMLc/YuJ3oWsGALcen6mnOA0KJkBB6RBaeVdyC7bSY54U3xlsaLOwoYUFHTqnyKr8XwDoio73V5qLCygx4udpqWnH7U6uqrzGtfQKRH5CnsIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879560; c=relaxed/simple;
	bh=igqiBoT9oOC7/5UOi4xVEVveH1WybSGI8pA91Wn0hto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1N8p59nS7ynh3x29GcuGoCeIpzwheftHm4bl5ye0/KYe5i5wAgqVQLuUSFb9auSWXa+fHNtPHbmJi/5oTO/vXeTW8OYhD6yIKXeVo7M1/aWJPV5EO+e8QPSB5rZCSfTXWllLWFSK7TuddBFHgBslxYK1VVgqaUkF8hLzpAbdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MbC/XBCL; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712879559; x=1744415559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mtc9r2f7czZp3fCdnpNtJVrBS0On253euj+fC9lQLNA=;
  b=MbC/XBCLGsiwi+EonyHnHTS+O/kOafCs+ott5pYEGmh/tjufe2hetAOU
   mcpYJ4Q5H2MYWS34L4kMGyhlv45DMqtPHawkxJ0P5yHZ2lWzzJbuGFl0B
   INBIXPkIERGVgQtIlHYNC/G5UdSZhWePLsAGJDJ/RDJ28QCkf7g7zwb4P
   0=;
X-IronPort-AV: E=Sophos;i="6.07,194,1708387200"; 
   d="scan'208";a="625962786"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:52:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:21716]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.244:2525] with esmtp (Farcaster)
 id 54fd211d-c7f9-4311-8906-0b68a417a83a; Thu, 11 Apr 2024 23:52:36 +0000 (UTC)
X-Farcaster-Flow-ID: 54fd211d-c7f9-4311-8906-0b68a417a83a
Received: from EX19D046UWA001.ant.amazon.com (10.13.139.112) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 23:52:33 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D046UWA001.ant.amazon.com (10.13.139.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 23:52:33 +0000
Received: from dev-dsk-hailmo-2b-4e49cd2f.us-west-2.amazon.com (172.16.42.153)
 by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 11 Apr 2024 23:52:33 +0000
Received: by dev-dsk-hailmo-2b-4e49cd2f.us-west-2.amazon.com (Postfix, from userid 13307802)
	id AD61941829; Thu, 11 Apr 2024 23:52:33 +0000 (UTC)
From: Hailey Mothershead <hailmo@amazon.com>
To: <herbert@gondor.apana.org.au>
CC: <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <hailmo@amazon.com>
Subject: [PATCH 2/2] crypto: aead,cipher - zeroize key buffer after use
Date: Thu, 11 Apr 2024 23:51:57 +0000
Message-ID: <20240411235157.19801-2-hailmo@amazon.com>
In-Reply-To: <20240411235157.19801-1-hailmo@amazon.com>
References: <20240411235157.19801-1-hailmo@amazon.com>
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
 crypto/aead.c   | 2 +-
 crypto/cipher.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/aead.c b/crypto/aead.c
index 16991095270d..2592d5375de5 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -36,7 +36,7 @@ static int setkey_unaligned(struct crypto_aead *tfm, const u8 *key,
 	memcpy(alignbuffer, key, keylen);
 	ret = crypto_aead_alg(tfm)->setkey(tfm, alignbuffer, keylen);
 	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kfree_sensitive(buffer);
 	return ret;
 }
 
diff --git a/crypto/cipher.c b/crypto/cipher.c
index b47141ed4a9f..efb87fa417e7 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -35,7 +35,7 @@ static int setkey_unaligned(struct crypto_cipher *tfm, const u8 *key,
 	memcpy(alignbuffer, key, keylen);
 	ret = cia->cia_setkey(crypto_cipher_tfm(tfm), alignbuffer, keylen);
 	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kfree_sensitive(buffer);
 	return ret;
 
 }
-- 
2.40.1


