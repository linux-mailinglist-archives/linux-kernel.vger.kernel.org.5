Return-Path: <linux-kernel+bounces-141727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D78A22A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0029CB220CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648174C629;
	Thu, 11 Apr 2024 23:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g2IQ/siG"
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5C47A48;
	Thu, 11 Apr 2024 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879559; cv=none; b=iXNkU6whZqwvETC8TrIdSQ7VutJmIQplUh6NaFyp0s8qJmEnbsGfw4PsHp3cix54C8305HizT8qfDdGfxnGQ8xH/gsesPKkrym0d/lAEzDv5Urtnf+hE/1c2okD1O+1F+IhWo8oTwYL3diHkG8fWlfjRxDJu5ATlGyV/8prbUGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879559; c=relaxed/simple;
	bh=tgpYEE6LUepn+5geXe7MWga6OcWkQHTaKntZy3YoMzI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ciS7vJRYTWB5yZ6U3PWgfVVvpFAdaGvIt8opQ5v/Ja50aK+uxIommDRufPBR3hGxipgoexI1tbHreSXRigmW/FPx4BZ+iGRBFkIgGRmeyiJ7Z8cTgvX4AdAAg0H0hVLiVt8eGyAj1C489GskKfv48c6oiTRQQ/8cMIJrj+n9mFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=g2IQ/siG; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712879559; x=1744415559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lB3haLy2Df6RpkVbSyqVIyO9vLkYGW4NzjkWWLDQawQ=;
  b=g2IQ/siGRi2iAaWD0IwSeLE5sG6FiJ4qg64dwGNyeP0kJ0rdqiORy/ZH
   2dPMJ0kgHGNKYijk5wYuej+rwY2qJA8lkN/9vry8ee486r6lXV1Sf6zPS
   MYrJmyQRgAVv0tSrJwlmKvKL3G7d5utfn8EHWXihoywEO0XQ65XhaCpJM
   c=;
X-IronPort-AV: E=Sophos;i="6.07,194,1708387200"; 
   d="scan'208";a="718520978"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:52:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:38767]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.244:2525] with esmtp (Farcaster)
 id d8c349d6-737f-45da-a243-e0955767f67f; Thu, 11 Apr 2024 23:52:37 +0000 (UTC)
X-Farcaster-Flow-ID: d8c349d6-737f-45da-a243-e0955767f67f
Received: from EX19D046UWA003.ant.amazon.com (10.13.139.18) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 23:52:33 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D046UWA003.ant.amazon.com (10.13.139.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 23:52:33 +0000
Received: from dev-dsk-hailmo-2b-4e49cd2f.us-west-2.amazon.com (172.16.42.153)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 11 Apr 2024 23:52:32 +0000
Received: by dev-dsk-hailmo-2b-4e49cd2f.us-west-2.amazon.com (Postfix, from userid 13307802)
	id A5E5F41829; Thu, 11 Apr 2024 23:52:32 +0000 (UTC)
From: Hailey Mothershead <hailmo@amazon.com>
To: <herbert@gondor.apana.org.au>
CC: <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <hailmo@amazon.com>
Subject: [PATCH 1/2] crypto: ecdh - zeroize crpytographic keys after use
Date: Thu, 11 Apr 2024 23:51:56 +0000
Message-ID: <20240411235157.19801-1-hailmo@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Fips 140-3 specifies that Sensitive Security Parameters (SSPs) must be
zeroized after use and that overwriting these variables with a new SSP
is not sufficient for zeroization. So explicitly zeroize the private key
before it is overwritten in ecdh_set_secret.

It also requires that variables used in the creation of SSPs
be zeroized once they are no longer in use. Zeroize the public key as it
is used in the creation of the shared secret.

Signed-off-by: Hailey Mothershead <hailmo@amazon.com>
---
 crypto/ecdh.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index 80afee3234fb..71599cadf0bc 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -33,6 +33,8 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	    params.key_size > sizeof(u64) * ctx->ndigits)
 		return -EINVAL;
 
+	memset(ctx->private_key, 0, sizeof(ctx->private_key));
+
 	if (!params.key || !params.key_size)
 		return ecc_gen_privkey(ctx->curve_id, ctx->ndigits,
 				       ctx->private_key);
@@ -111,7 +113,7 @@ static int ecdh_compute_value(struct kpp_request *req)
 free_all:
 	kfree_sensitive(shared_secret);
 free_pubkey:
-	kfree(public_key);
+	kfree_sensitive(public_key);
 	return ret;
 }
 
-- 
2.40.1


