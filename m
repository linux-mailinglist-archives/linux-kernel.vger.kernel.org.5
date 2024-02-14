Return-Path: <linux-kernel+bounces-65905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5AF85538F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D251F24948
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D96313DBA2;
	Wed, 14 Feb 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bAb38AmS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BA13DB93;
	Wed, 14 Feb 2024 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940684; cv=none; b=cvb55fey+6/3xCocpxfLbQ2sjy+uk22lAfwFtsvhn3MkPWR8tjscSNCX47dW5cMk58opnfDPuM6a1pDtJJsKakVpVHli4DqV5hK4Xsa2uLjuKcY7w1lqavoSSlZyNMjHizyvq769FGjZbeegAhxzG9Ov7xogbYm5D2NzE82DF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940684; c=relaxed/simple;
	bh=rTKv1TDsFzL+RzB4KD1Ng3M4meMkWcKDfmVZOO+HcO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyjDcdlvQB4tSNCtV17EnaDtx4QIuwzzSmpAeOLJv4HQf4/4At+kMded0D3li/foIivQwH56fHUj1KtnyVi0bMCUlijJ3me1esUTrMg0M87POOnsNTq1CfRGJUDr+3K+pMm3LGNruwgprZsg5QR82m5B5E3ZSojeS1xk10RO0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bAb38AmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBC6C433C7;
	Wed, 14 Feb 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bAb38AmS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1707940681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=usBdTDKhZdYOqvFmhLJXleA6TJU1AAI9ITba9p7Xy2A=;
	b=bAb38AmSl+1HLYBs2tbYWtbKGdv9rc3fEuKOzyVp0l7GFm/kfZx+r+PPndQPtqIXwI7cNI
	j61OF/Fd8BmYNgjSAkZSMMp4nf8hfN2aaib+LKY/lpjm0SOTTInPqsfck2j68ybarrZ0ft
	S8lroiEzKdWeQxtpE95tgCewvP2Y2Co=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a632d9c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Feb 2024 19:58:01 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Borislav Petkov <bp@alien8.de>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 1/2] x86/archrandom: WARN if RDRAND fails and don't retry
Date: Wed, 14 Feb 2024 20:56:47 +0100
Message-ID: <20240214195744.8332-2-Jason@zx2c4.com>
In-Reply-To: <20240214195744.8332-1-Jason@zx2c4.com>
References: <20240214195744.8332-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to both Intel [1] and AMD [2], RDRAND will never fail unless
the hardware is defective. The old advice to try 10 times is not
considered correct.

RDSEED is a different story. But with RDRAND never failing, WARN()ing
when it does seems like a reasonable thing to do, as it's probably
indicative of some deeper problem.

[1] https://lore.kernel.org/all/DM8PR11MB57503A2BB6F74618D64CC44AE74E2@DM8PR11MB5750.namprd11.prod.outlook.com/
[2] https://lore.kernel.org/all/20240209214530.GHZcac-vOym8k3IuJm@fat_crate.local/

Cc: Borislav Petkov <bp@alien8.de>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/include/asm/archrandom.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 02bae8e0758b..1cc01ecd5e75 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -13,22 +13,18 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 
-#define RDRAND_RETRY_LOOPS	10
-
 /* Unconditional execution of RDRAND and RDSEED */
 
 static inline bool __must_check rdrand_long(unsigned long *v)
 {
 	bool ok;
-	unsigned int retry = RDRAND_RETRY_LOOPS;
-	do {
-		asm volatile("rdrand %[out]"
-			     CC_SET(c)
-			     : CC_OUT(c) (ok), [out] "=r" (*v));
-		if (ok)
-			return true;
-	} while (--retry);
-	return false;
+	asm volatile("rdrand %[out]"
+		     CC_SET(c)
+		     : CC_OUT(c) (ok), [out] "=r" (*v));
+#ifndef KASLR_COMPRESSED_BOOT
+	WARN_ON(!ok);
+#endif
+	return ok;
 }
 
 static inline bool __must_check rdseed_long(unsigned long *v)
-- 
2.43.0


