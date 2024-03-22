Return-Path: <linux-kernel+bounces-112095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6331D8875B9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623C61C22D63
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3871582D7C;
	Fri, 22 Mar 2024 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdJyC27u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2982C60;
	Fri, 22 Mar 2024 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711149648; cv=none; b=EQoXP+H8Xpz8i5qRekaOojQMA8FJ1oKJsVSrnTKlZVloRnwNq4BWdSchbJLlDmRXp+JNzSXnw1KT3mC2SGhh43lfVZEr/o6d0J2d0bRp4tbPdmknxP0gal/X/ko4YGH/FZjruhFFyq4dyvigJ6AARwj2uWxTgUfYmk+FHjBEmGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711149648; c=relaxed/simple;
	bh=ttK0PqXVtTYL2BSG5ihN+00vYtLt9HrubXRlzB0wTSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AGH/t5Mig+m2rM/w+FCR3hzVb/GDl8ggKgTbKVr+UG3KwkDOls046Ww3Fq9mROaeWnDryYEEMdYAOcedFnHDF6kj6X2FbNGCXyrQ1u9Mp08IXxBTajChrDKCXbclaS2u+pNMmRdz55rLdjSETN6Yx2Oh5tYrhK84Hwq8hC7PJpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdJyC27u; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711149647; x=1742685647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ttK0PqXVtTYL2BSG5ihN+00vYtLt9HrubXRlzB0wTSA=;
  b=MdJyC27uiXgXeJFB+ELNHB3JzNoVHK2cDnFHmAv7S1Y/ZZbjArirXbFE
   lYjY1PAEIMiZb1e4263z8bhq3nholMfuI7M6gaLoDLpSAeRq0M0+EKGVm
   yYwPlVssPdAGd8xxk4kCtUxC3LgYG3fiDBpjBOYw7T+YieTwCJ9QFyXIZ
   pQuxM7HHzytJoP9ZqPYMwAPHcHZNpvqas337TekXAj88eGT6+xiIuWMEH
   SHPVgMemZpHtFl8ybAj3HbUwYZX4Lvg7tEAIz2I2jjEerP430Dt8gPlMG
   2lO4+kC4O63+jt1gxuLqiinba5CkSMccAru9yLVVgPhO+0xRu5O0BN+lG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6408551"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="6408551"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 16:20:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="19749000"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa004.jf.intel.com with ESMTP; 22 Mar 2024 16:20:46 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	ebiggers@kernel.org,
	ardb@kernel.org,
	x86@kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v2 1/2] crypto: x86/aesni - Rearrange AES key size check
Date: Fri, 22 Mar 2024 16:04:58 -0700
Message-Id: <20240322230459.456606-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322230459.456606-1-chang.seok.bae@intel.com>
References: <20240311213232.128240-1-chang.seok.bae@intel.com>
 <20240322230459.456606-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aes_expandkey() already includes an AES key size check. If AES-NI is
unusable, invoke the function without the size check.

Also, use aes_check_keylen() instead of open code.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
V2 <- V1:
* Add as a new patch.
---
 arch/x86/crypto/aesni-intel_glue.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index b1d90c25975a..8b3b17b065ad 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -233,18 +233,16 @@ static int aes_set_key_common(struct crypto_aes_ctx *ctx,
 {
 	int err;
 
-	if (key_len != AES_KEYSIZE_128 && key_len != AES_KEYSIZE_192 &&
-	    key_len != AES_KEYSIZE_256)
-		return -EINVAL;
-
 	if (!crypto_simd_usable())
-		err = aes_expandkey(ctx, in_key, key_len);
-	else {
-		kernel_fpu_begin();
-		err = aesni_set_key(ctx, in_key, key_len);
-		kernel_fpu_end();
-	}
+		return aes_expandkey(ctx, in_key, key_len);
 
+	err = aes_check_keylen(key_len);
+	if (err)
+		return err;
+
+	kernel_fpu_begin();
+	err = aesni_set_key(ctx, in_key, key_len);
+	kernel_fpu_end();
 	return err;
 }
 
-- 
2.34.1


