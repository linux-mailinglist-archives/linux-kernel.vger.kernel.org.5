Return-Path: <linux-kernel+bounces-103211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7287BC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370651F22A55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A616F523;
	Thu, 14 Mar 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R/ZU5BAW"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9D6CDB5;
	Thu, 14 Mar 2024 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417623; cv=none; b=oo9JxvghrOIAwDYqnP1l0HTCE18UCrGdhpVZEv17JBE5vx/Iongrx2JksTYsn0QptBKIgtH6Tc/eX+cMeKQismORfJDfmdNE64UMjN+iWxhvNqZbx/V/SAdG/Nm7Enu1c8fNGUqjn+RKocYAeULRph0AdUPeh5UswlK1MlS9tTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417623; c=relaxed/simple;
	bh=mF21mtWqoaOvj0ypQIOaecxYeKTl2y+0oCdrHl3pJgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IsVOTAkDQRK310bwWKN3BmJvmGDl02J6yUgSAF4unEklIcyjJSfwUroCweMSFVhOlqHMZRF15G3ABS0I2xmDQfyjSfwa62CqxENwVJXtrWbA3ZRrd3JpAyvdpip9s/IhGwfcX8PUHFnECTqYLkJPAt665+Tw8g59QGyYlEJWk9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R/ZU5BAW; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 1A509E0007;
	Thu, 14 Mar 2024 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710417610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yyLJCgFRChWuZscG9LuS8NIbqJIpH/szkPqJqvCZcRM=;
	b=R/ZU5BAWSmRUxuVQx8tr4Z/pWp641mvxwbQeRl3rIeNRQ6HMpp9ntHsx0TYdBjCouWtCFH
	svVQ1ehoO83drWWliinBripc0GeRFLtrNtwrvC7ZCFdwtgsPw4UKuoPWwESPH1KLYwmU5L
	vGJJpX2gO1aQCJXHGiTcKufvpMyscR0Im/q49OKABeMDbtlbjGE1yIeSlnZITafJrV7hT7
	BO66dG2vyczJ8r0c/j6Y+aRDaKl+pK4paiszTyllZScMz0hJe8lrB5Kwr+M12O+2TnbYDU
	IxoYShCRxpDS659o3ull5nc+Da9ZIIQxYSF+GkO1XPoZBL9mqz6zguwOrCh0DA==
From: Herve Codina <herve.codina@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2] lib/bitmap: Fix bitmap_scatter() and bitmap_gather() kernel doc
Date: Thu, 14 Mar 2024 13:00:06 +0100
Message-ID: <20240314120006.458580-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The make htmldoc command failed with the following error
  ... include/linux/bitmap.h:524: ERROR: Unexpected indentation.
  ... include/linux/bitmap.h:524: CRITICAL: Unexpected section title or transition.

Move the visual representation to a literal block.

Fixes: de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-kernel/20240312153059.3ffde1b7@canb.auug.org.au/
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---

Changes v1 -> v2
  Add Fixes, Reported-by and Closes tags

 include/linux/bitmap.h | 44 ++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index fb3a9c93ac86..aa4096126553 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -522,17 +522,18 @@ static inline void bitmap_replace(unsigned long *dst,
  *
  * (Bits 0, 1, 2, 3, 4, 5 are copied to the bits 0, 1, 4, 8, 9, 12)
  *
- * A more 'visual' description of the operation:
- * src:  0000000001011010
- *                 ||||||
- *          +------+|||||
- *          |  +----+||||
- *          |  |+----+|||
- *          |  ||   +-+||
- *          |  ||   |  ||
- * mask: ...v..vv...v..vv
- *       ...0..11...0..10
- * dst:  0000001100000010
+ * A more 'visual' description of the operation::
+ *
+ *	src:  0000000001011010
+ *	                ||||||
+ *	         +------+|||||
+ *	         |  +----+||||
+ *	         |  |+----+|||
+ *	         |  ||   +-+||
+ *	         |  ||   |  ||
+ *	mask: ...v..vv...v..vv
+ *	      ...0..11...0..10
+ *	dst:  0000001100000010
  *
  * A relationship exists between bitmap_scatter() and bitmap_gather().
  * bitmap_gather() can be seen as the 'reverse' bitmap_scatter() operation.
@@ -568,16 +569,17 @@ static inline void bitmap_scatter(unsigned long *dst, const unsigned long *src,
  *
  * (Bits 0, 1, 4, 8, 9, 12 are copied to the bits 0, 1, 2, 3, 4, 5)
  *
- * A more 'visual' description of the operation:
- * mask: ...v..vv...v..vv
- * src:  0000001100000010
- *          ^  ^^   ^   0
- *          |  ||   |  10
- *          |  ||   > 010
- *          |  |+--> 1010
- *          |  +--> 11010
- *          +----> 011010
- * dst:  0000000000011010
+ * A more 'visual' description of the operation::
+ *
+ *	mask: ...v..vv...v..vv
+ *	src:  0000001100000010
+ *	         ^  ^^   ^   0
+ *	         |  ||   |  10
+ *	         |  ||   > 010
+ *	         |  |+--> 1010
+ *	         |  +--> 11010
+ *	         +----> 011010
+ *	dst:  0000000000011010
  *
  * A relationship exists between bitmap_gather() and bitmap_scatter(). See
  * bitmap_scatter() for the bitmap scatter detailed operations.
-- 
2.44.0


