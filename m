Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035197825E4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjHUI4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjHUI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:56:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B799C0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692608189; x=1724144189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N6P1OsaM/PaATCx6vay4MoW6msTy/ySM5jQlXjFDMYI=;
  b=oDPC9U7A8gciL/24/VahOTkRa5dPQyHVer4q0h5UlG8NE2unQKFRLXF+
   bIrgz88o387UBwLTE3JiXBIZKpI1mxGcfiC/F6927S0IS0uBqpi8GxJCJ
   AOF6HDH0RpoKyIqwUixwnlc4OR3NWNFesGgdfYjMtswD6S3PfjkwpXftC
   KT7cNz2TCQzM9UqtMi/BzTiRdUQ8ftjYLWUhe/A9fVCpLNgpZ6WHHOfDb
   +mWVHd/X2UfdiAyV1VjtPlAfqSNgdQ8xLji4y2fATCtch+k3vny/a/Qk9
   AcuPBER5Bpjb+5hFuYs6SRdj1NTThb9R05lkhH5Luq4R3h7lN59c3bb/9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="353855980"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353855980"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="735785487"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="735785487"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 21 Aug 2023 01:56:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY0i2-006b1H-0d;
        Mon, 21 Aug 2023 11:56:26 +0300
Date:   Mon, 21 Aug 2023 11:56:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: optimize bitmap_remap()
Message-ID: <ZOMmuZuhdjA6mdIG@smile.fi.intel.com>
References: <20230815235934.47782-1-yury.norov@gmail.com>
 <ZN3qQPeFtdZQrLE4@smile.fi.intel.com>
 <ZN3qlCd+TcYiZg+s@smile.fi.intel.com>
 <ZN4tB7jkQrX/TKnh@yury-ThinkPad>
 <ZN4+nZwBu317dVjz@smile.fi.intel.com>
 <ZOAi9PB6+/p4orRN@yury-ThinkPad>
 <f32995aa-df23-bf51-adb7-f024b76a33aa@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f32995aa-df23-bf51-adb7-f024b76a33aa@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:48:38AM +0200, Rasmus Villemoes wrote:
> On 19/08/2023 04.03, Yury Norov wrote:
> > On Thu, Aug 17, 2023 at 06:37:01PM +0300, Andy Shevchenko wrote:
> 
> >> But this gives +89 bytes on x86_64... :-(
> > 
> > Who cares if it gives a boost of performance for regular users?
> 
> "Regular users" never ever hit bitmap_remap, it's simply too esoteric.
> It has all of _two_ users in the whole tree, one in some gpio driver,
> another only reached via a system call that nobody ever uses, and if
> they do, it's most likely some one-time-per-process thing. It's about as
> far from a hot path that you can come.
> 
> If it wasn't for that xilinx user, those bitmap_remap and bitmap_onto
> etc. should be moved to be private to the NUMA code.
> 
> Anyway, I think those +89 was for Andy's own counterproposal. I haven't
> built Yury's patch, but from a quick look, it should not add that much,
> if anything - it adds a test, call, early return, but OTOH it helps the
> compiler to combine the two set_bit (since only the first argument
> differs), and loses the lock prefix.
> 
> As for that latter point, I don't think a separate patch is worth it,
> just a comment in the commit log - we're already doing a bitmap_zero()
> on dst which certainly doesn't use any atomic ops, and in general all
> the bitmap_* functions expect the caller to handle locking.
> 
> So I don't mind Yury's patch, but I highly doubt it matters at all. The
> comment mentions an example, do we even have that put in test code?

Btw, I have locally a patch that adds bitmap_scatter()/bitmap_gather() and
switches Xilins to use it. Because that is what GPIO may use, see the code
below for the reference (there are no test cases yet), Comments are welcome
as usual!

From 6013cce33dc1e0381240b7955f50044b26dd7659 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 20 Oct 2022 00:05:15 +0300
Subject: [PATCH 1/1] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers

These helpers are optimized versions of the bitmap_remap() where one
of the bitmaps (source or destination) is of sequential bits.

See more in the kernel documentation of the helpers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitmap.h |  9 ++++++
 lib/bitmap.c           | 70 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1ef..d3c9fefde77c 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -60,6 +60,8 @@ struct device;
  *  bitmap_shift_left(dst, src, n, nbits)       *dst = *src << n
  *  bitmap_cut(dst, src, first, n, nbits)       Cut n bits from first, copy rest
  *  bitmap_replace(dst, old, new, mask, nbits)  *dst = (*old & ~(*mask)) | (*new & *mask)
+ *  bitmap_scatter(dst, src, mask, nbits)	*dst = map(dense, sparse)(src)
+ *  bitmap_gather(dst, src, mask, nbits)	*dst = map(sparse, dense)(src)
  *  bitmap_remap(dst, src, old, new, nbits)     *dst = map(old, new)(src)
  *  bitmap_bitremap(oldbit, old, new, nbits)    newbit = map(old, new)(oldbit)
  *  bitmap_onto(dst, orig, relmap, nbits)       *dst = orig relative to relmap
@@ -208,6 +210,12 @@ int bitmap_parselist(const char *buf, unsigned long *maskp,
 			int nmaskbits);
 int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
 			unsigned long *dst, int nbits);
+
+unsigned int bitmap_scatter(unsigned long *dst, const unsigned long *src,
+		const unsigned long *mask, unsigned int nbits);
+unsigned int bitmap_gather(unsigned long *dst, const unsigned long *src,
+		const unsigned long *mask, unsigned int nbits);
+
 void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new, unsigned int nbits);
 int bitmap_bitremap(int oldbit,
@@ -216,6 +224,7 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		const unsigned long *relmap, unsigned int bits);
 void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 		unsigned int sz, unsigned int nbits);
+
 int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order);
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
 int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 24284caadbcc..dd27f0a5d1ce 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -942,6 +942,76 @@ int bitmap_parse(const char *start, unsigned int buflen,
 }
 EXPORT_SYMBOL(bitmap_parse);
 
+/**
+ * bitmap_scatter - Scatter a bitmap according to the given mask
+ * @dst: scattered bitmap
+ * @src: gathered bitmap
+ * @mask: bits to assign to in the scattered bitmap
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
+ * Returns: the weight of the @mask.
+ */
+unsigned int bitmap_scatter(unsigned long *dst, const unsigned long *src,
+			    const unsigned long *mask, unsigned int nbits)
+{
+	unsigned int bit;
+	int n = 0;
+
+	bitmap_zero(dst, nbits);
+
+	for_each_set_bit(bit, mask, nbits)
+		__assign_bit(bit, dst, test_bit(n++, src));
+
+	return n;
+}
+EXPORT_SYMBOL(bitmap_scatter);
+
+/**
+ * bitmap_gather - Gather a bitmap according to given mask
+ * @dst: gathered bitmap
+ * @src: scattered bitmap
+ * @mask: bits to extract from in the scattered bitmap
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
+ * Returns: the weight of the @mask.
+ */
+unsigned int bitmap_gather(unsigned long *dst, const unsigned long *src,
+			   const unsigned long *mask, unsigned int nbits)
+{
+	unsigned int bit;
+	int n = 0;
+
+	bitmap_zero(dst, nbits);
+
+	for_each_set_bit(bit, mask, nbits)
+		__assign_bit(n++, dst, test_bit(bit, src));
+
+	return n;
+}
+EXPORT_SYMBOL(bitmap_gather);
+
 /**
  * bitmap_pos_to_ord - find ordinal of set bit at given position in bitmap
  *	@buf: pointer to a bitmap

-- 
With Best Regards,
Andy Shevchenko


