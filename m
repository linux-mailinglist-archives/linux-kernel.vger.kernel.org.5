Return-Path: <linux-kernel+bounces-93467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A8287303C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7901C229A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFD05DF0A;
	Wed,  6 Mar 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JtjBCJZc"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1EC5CDD2;
	Wed,  6 Mar 2024 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712479; cv=none; b=Wql7b4b1qjL2iJVNX56HVWmqqR9NdHa1KwIyilLV/TFv9cCOYm/CBPCwyVoaxFiAXP1l1EzqFqxhkLl8s+1iSBgvSGvyBm24Fip9+RaK3ZUahb/bn24qp8Lz/B0hjaQ8VncpQWR+BVk7NETW5QdBRWBce31H6qsrY8ED4ShBgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712479; c=relaxed/simple;
	bh=OnX+53TXkbqIWk5yp7KeROTCIa9DDDGyw6vZPgwK6Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzqWToKGh7hZv8sR8RkjmaRsJ6zYPvUNT95U7jamNSL1aLRDQAcJdvfOA+tn8rvSdrZqZ3SBkDDSuozfqcOGFZ+HLflO+7WBcdnt+XCp2bEiN4qIvfBG5Vum6Kppl9s+sJg/iUOBuoVqBqEYGlgdPC8cDydO8ZaA1l8nWUP1PjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JtjBCJZc; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 887BF20002;
	Wed,  6 Mar 2024 08:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709712469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s52XVNKgkl9FtWVL4lxN6JUvQsPW5Z/X/q3oXZCSzZU=;
	b=JtjBCJZcIenSycZ2xsOS+pcqFtzQUMHZW6Zrb7qY08cFa9beWLaUTLnSk1DOnqBxg08F0K
	8WFHtjYb8AF1hyaeE3Y4PP5+WldH1h5ExetBfkXA4R4CZioaD7dzDAITsRtB+CZyAn2PZV
	5iMU04jZOqdciXTAZuKFiJHb3dUZ5DyoUnYUL//0XpaFLC3MG4t5mqxLziL+dJi9A4eLaa
	UaObKQLPkNq4mkFLlfw58NVgymkQxd2giGa3GJo2JRUJzdPVMKEZkZ7MLjYF/tYeCYCiMa
	lOoqH3fLFQ0ZPN2ePkbS5238Elnqhj0DuCkAS+o4HbKvVnTApEvbsTqEWhYfrQ==
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
Subject: [PATCH v6 3/5] lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
Date: Wed,  6 Mar 2024 09:07:19 +0100
Message-ID: <20240306080726.167338-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306080726.167338-1-herve.codina@bootlin.com>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

These helpers scatters or gathers a bitmap with the help of the mask
position bits parameter.

bitmap_scatter() does the following:
  src:  0000000001011010
                  ||||||
           +------+|||||
           |  +----+||||
           |  |+----+|||
           |  ||   +-+||
           |  ||   |  ||
  mask: ...v..vv...v..vv
        ...0..11...0..10
  dst:  0000001100000010

and bitmap_gather() performs this one:
   mask: ...v..vv...v..vv
   src:  0000001100000010
            ^  ^^   ^   0
            |  ||   |  10
            |  ||   > 010
            |  |+--> 1010
            |  +--> 11010
            +----> 011010
   dst:  0000000000011010

bitmap_gather() can the seen as the reverse bitmap_scatter() operation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/lkml/20230926052007.3917389-3-andriy.shevchenko@linux.intel.com/
Co-developed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/bitmap.h | 101 +++++++++++++++++++++++++++++++++++++++++
 lib/test_bitmap.c      |  42 +++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99451431e4d6..049ba20911c5 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -62,6 +62,8 @@ struct device;
  *  bitmap_shift_left(dst, src, n, nbits)       *dst = *src << n
  *  bitmap_cut(dst, src, first, n, nbits)       Cut n bits from first, copy rest
  *  bitmap_replace(dst, old, new, mask, nbits)  *dst = (*old & ~(*mask)) | (*new & *mask)
+ *  bitmap_scatter(dst, src, mask, nbits)	*dst = map(dense, sparse)(src)
+ *  bitmap_gather(dst, src, mask, nbits)	*dst = map(sparse, dense)(src)
  *  bitmap_remap(dst, src, old, new, nbits)     *dst = map(old, new)(src)
  *  bitmap_bitremap(oldbit, old, new, nbits)    newbit = map(old, new)(oldbit)
  *  bitmap_onto(dst, orig, relmap, nbits)       *dst = orig relative to relmap
@@ -487,6 +489,105 @@ static inline void bitmap_replace(unsigned long *dst,
 		__bitmap_replace(dst, old, new, mask, nbits);
 }
 
+/**
+ * bitmap_scatter - Scatter a bitmap according to the given mask
+ * @dst: scattered bitmap
+ * @src: gathered bitmap
+ * @mask: mask representing bits to assign to in the scattered bitmap
+ * @nbits: number of bits in each of these bitmaps
+ *
+ * Scatters bitmap with sequential bits according to the given @mask.
+ *
+ * Example:
+ * If @src bitmap = 0x005a, with @mask = 0x1313, @dst will be 0x0302.
+ *
+ * Or in binary form
+ * @src			@mask			@dst
+ * 0000000001011010	0001001100010011	0000001100000010
+ *
+ * (Bits 0, 1, 2, 3, 4, 5 are copied to the bits 0, 1, 4, 8, 9, 12)
+ *
+ * A more 'visual' description of the operation:
+ * src:  0000000001011010
+ *                 ||||||
+ *          +------+|||||
+ *          |  +----+||||
+ *          |  |+----+|||
+ *          |  ||   +-+||
+ *          |  ||   |  ||
+ * mask: ...v..vv...v..vv
+ *       ...0..11...0..10
+ * dst:  0000001100000010
+ *
+ * A relationship exists between bitmap_scatter() and bitmap_gather().
+ * bitmap_gather() can be seen as the 'reverse' bitmap_scatter() operation.
+ * See bitmap_scatter() for details related to this relationship.
+ */
+static inline void bitmap_scatter(unsigned long *dst, const unsigned long *src,
+				  const unsigned long *mask, unsigned int nbits)
+{
+	unsigned int n = 0;
+	unsigned int bit;
+
+	bitmap_zero(dst, nbits);
+
+	for_each_set_bit(bit, mask, nbits)
+		__assign_bit(bit, dst, test_bit(n++, src));
+}
+
+/**
+ * bitmap_gather - Gather a bitmap according to given mask
+ * @dst: gathered bitmap
+ * @src: scattered bitmap
+ * @mask: mask representing bits to extract from in the scattered bitmap
+ * @nbits: number of bits in each of these bitmaps
+ *
+ * Gathers bitmap with sparse bits according to the given @mask.
+ *
+ * Example:
+ * If @src bitmap = 0x0302, with @mask = 0x1313, @dst will be 0x001a.
+ *
+ * Or in binary form
+ * @src			@mask			@dst
+ * 0000001100000010	0001001100010011	0000000000011010
+ *
+ * (Bits 0, 1, 4, 8, 9, 12 are copied to the bits 0, 1, 2, 3, 4, 5)
+ *
+ * A more 'visual' description of the operation:
+ * mask: ...v..vv...v..vv
+ * src:  0000001100000010
+ *          ^  ^^   ^   0
+ *          |  ||   |  10
+ *          |  ||   > 010
+ *          |  |+--> 1010
+ *          |  +--> 11010
+ *          +----> 011010
+ * dst:  0000000000011010
+ *
+ * A relationship exists between bitmap_gather() and bitmap_scatter(). See
+ * bitmap_scatter() for the bitmap scatter detailed operations.
+ * Suppose scattered computed using bitmap_scatter(scattered, src, mask, n).
+ * The operation bitmap_gather(result, scattered, mask, n) leads to a result
+ * equal or equivalent to src.
+ *
+ * The result can be 'equivalent' because bitmap_scatter() and bitmap_gather()
+ * are not bijective.
+ * The result and src values are equivalent in that sense that a call to
+ * bitmap_scatter(res, src, mask, n) and a call to
+ * bitmap_scatter(res, result, mask, n) will lead to the same res value.
+ */
+static inline void bitmap_gather(unsigned long *dst, const unsigned long *src,
+				 const unsigned long *mask, unsigned int nbits)
+{
+	unsigned int n = 0;
+	unsigned int bit;
+
+	bitmap_zero(dst, nbits);
+
+	for_each_set_bit(bit, mask, nbits)
+		__assign_bit(n++, dst, test_bit(bit, src));
+}
+
 static inline void bitmap_next_set_region(unsigned long *bitmap,
 					  unsigned int *rs, unsigned int *re,
 					  unsigned int end)
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 65f22c2578b0..6b2b33579f56 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -380,6 +380,47 @@ static void __init test_replace(void)
 	expect_eq_bitmap(bmap, exp3_1_0, nbits);
 }
 
+static const unsigned long sg_mask[] __initconst = {
+	BITMAP_FROM_U64(0x000000000000035aULL),
+};
+
+static const unsigned long sg_src[] __initconst = {
+	BITMAP_FROM_U64(0x0000000000000667ULL),
+};
+
+static const unsigned long sg_gather_exp[] __initconst = {
+	BITMAP_FROM_U64(0x0000000000000029ULL),
+};
+
+static const unsigned long sg_scatter_exp[] __initconst = {
+	BITMAP_FROM_U64(0x000000000000021aULL),
+};
+
+static void __init test_bitmap_sg(void)
+{
+	unsigned int nbits = 64;
+	DECLARE_BITMAP(bmap_gather, 100);
+	DECLARE_BITMAP(bmap_scatter, 100);
+	DECLARE_BITMAP(bmap_tmp, 100);
+	DECLARE_BITMAP(bmap_res, 100);
+
+	/* Simple gather call */
+	bitmap_zero(bmap_gather, 100);
+	bitmap_gather(bmap_gather, sg_src, sg_mask, nbits);
+	expect_eq_bitmap(sg_gather_exp, bmap_gather, nbits);
+
+	/* Simple scatter call */
+	bitmap_zero(bmap_scatter, 100);
+	bitmap_scatter(bmap_scatter, sg_src, sg_mask, nbits);
+	expect_eq_bitmap(sg_scatter_exp, bmap_scatter, nbits);
+
+	/* Scatter/gather relationship */
+	bitmap_zero(bmap_tmp, 100);
+	bitmap_gather(bmap_tmp, bmap_scatter, sg_mask, nbits);
+	bitmap_scatter(bmap_res, bmap_tmp, sg_mask, nbits);
+	expect_eq_bitmap(bmap_scatter, bmap_res, nbits);
+}
+
 #define PARSE_TIME	0x1
 #define NO_LEN		0x2
 
@@ -1252,6 +1293,7 @@ static void __init selftest(void)
 	test_copy();
 	test_bitmap_region();
 	test_replace();
+	test_bitmap_sg();
 	test_bitmap_arr32();
 	test_bitmap_arr64();
 	test_bitmap_parse();
-- 
2.43.0


