Return-Path: <linux-kernel+bounces-61172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4338850E55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108672818D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212217C72;
	Mon, 12 Feb 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dTj0L8CU"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF14FC16;
	Mon, 12 Feb 2024 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724636; cv=none; b=C2YoAALDKFOeza073flVq09NfNaxXZ+fQIveStQE2bjLypjmVIfna+3vrGQTqfaAYXYmuhmEGoFAyWRhIvFblk7pekG7P6uOgK5wQvH48rn+FtMMiDlH7jfoOU8BoNWj99kPeJ6T2ZwT3oPZ1UrvpUh/aj5NbcMATLZNl1nW5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724636; c=relaxed/simple;
	bh=o3GCbQ0HDcwCxhsdiMaIWoSqnIsvjGA8R22JTLCknSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zg4tTCacd8lAQxX15M+Lh/219jPN9amJGJRgUDhXKrPsFENivOz/j8u6qxrbGSPgXlFYZSA5DLk8fueAZuJDcb2CB5+l3/6ZpcpUCGViUDsv2tJzTKLmnidr1N7wtPd7feBMNhgus+su4UCxM+/fveOlP+AP110931fcJbghfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dTj0L8CU; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 89FA640013;
	Mon, 12 Feb 2024 07:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707724631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dO1lu7mTt2Z5I540dnIACd6uZE/pOpssk6saKJ+PaEA=;
	b=dTj0L8CUPn2xJHC/hWxnBaRNxEwVgoRfzQnMxFRgwd/yOia4U4+FtVuXb3r4d21WVoWnwJ
	s4oHRXy4yAcxKfXMeD+GT7Vt7wdJIxB2kBQQbYDaMBijGqh6gNPOBq0zsFLYMVkQwUB20u
	seFbF09SmNRgT3KZtBvZcj3u081a4q7Q87NINExrU+4R5iftejtlX6nGn2Hczdij/MQGN8
	1BYkC8dY6UpyNf/q6q+c1Z36Q69Fg7FuP29o0nkmqlg/ibfIuqCm0Hhh8yofq8A7oaKvgz
	T2i/gNrfa7sLBmuA0sC5vysK6GKgtYC8kVP7W57/I8XYXyoRt8JVnA36/pBazQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [RESEND PATCH v3 4/6] bitmap: Introduce bitmap_off()
Date: Mon, 12 Feb 2024 08:56:39 +0100
Message-ID: <20240212075646.19114-12-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212075646.19114-1-herve.codina@bootlin.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The bitmap_onto() function translates one bitmap relative to another but
no function are present to perform the reverse translation.

Introduce bitmap_off() to fill this hole.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/bitmap.h |  3 +++
 lib/bitmap.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99451431e4d6..5ecfcbbc91f4 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -65,6 +65,7 @@ struct device;
  *  bitmap_remap(dst, src, old, new, nbits)     *dst = map(old, new)(src)
  *  bitmap_bitremap(oldbit, old, new, nbits)    newbit = map(old, new)(oldbit)
  *  bitmap_onto(dst, orig, relmap, nbits)       *dst = orig relative to relmap
+ *  bitmap_off(dst, orig, relmap, nbits)        *dst = bitmap_onto() reverse operation
  *  bitmap_fold(dst, orig, sz, nbits)           dst bits = orig bits mod sz
  *  bitmap_parse(buf, buflen, dst, nbits)       Parse bitmap dst from kernel buf
  *  bitmap_parse_user(ubuf, ulen, dst, nbits)   Parse bitmap dst from user buf
@@ -208,6 +209,8 @@ int bitmap_bitremap(int oldbit,
 		const unsigned long *old, const unsigned long *new, int bits);
 void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		const unsigned long *relmap, unsigned int bits);
+void bitmap_off(unsigned long *dst, const unsigned long *orig,
+		const unsigned long *relmap, unsigned int bits);
 void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 		unsigned int sz, unsigned int nbits);
 
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 2feccb5047dc..71343967335e 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -682,6 +682,48 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 }
 EXPORT_SYMBOL(bitmap_onto);
 
+/**
+ * bitmap_off - revert operation done by bitmap_onto()
+ *     @dst: resulting translated bitmap
+ *     @orig: original untranslated bitmap
+ *     @relmap: bitmap relative to which translated
+ *     @bits: number of bits in each of these bitmaps
+ *
+ * Suppose onto computed using bitmap_onto(onto, src, relmap, n)
+ * The operation bitmap_off(result, onto, relmap, n) leads to a
+ * result equal or equivalent to src.
+ *
+ * The result can be 'equivalent' because bitmap_onto() and
+ * bitmap_off() are not bijective.
+ * The result and src values are equivalent in that sense that a
+ * call to bitmap_onto(onto, src, relmap, n) and a call to
+ * bitmap_onto(onto, result, relmap, n) will lead to the same onto
+ * value.
+ *
+ * If either of @orig or @relmap is empty (no set bits), then @dst
+ * will be returned empty.
+ *
+ * All bits in @dst not set by the above rule are cleared.
+ */
+void bitmap_off(unsigned long *dst, const unsigned long *orig,
+		const unsigned long *relmap, unsigned int bits)
+{
+	unsigned int n, m;      /* same meaning as in above comment */
+
+	if (dst == orig)        /* following doesn't handle inplace mappings */
+		return;
+	bitmap_zero(dst, bits);
+
+	m = 0;
+	for_each_set_bit(n, relmap, bits) {
+		/* m == bitmap_pos_to_ord(relmap, n, bits) */
+		if (test_bit(n, orig))
+			set_bit(m, dst);
+		m++;
+	}
+}
+EXPORT_SYMBOL(bitmap_off);
+
 #ifdef CONFIG_NUMA
 /**
  * bitmap_fold - fold larger bitmap into smaller, modulo specified size
-- 
2.43.0


