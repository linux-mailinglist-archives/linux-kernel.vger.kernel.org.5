Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A7E77FAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352649AbjHQPhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353249AbjHQPhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:37:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2142D6D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692286631; x=1723822631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3g9NYsPL+yeZ8JoAC5ihq7mnEDzWlgJBSNW9r1Fnobk=;
  b=O+v8Rprys1eM83HFIzLztxD+eOODcVMWGW26Vaf8i8EpIVneXqo4FWi7
   w3a3xyKdcgzk75yaQ8RN5Rv1P7mA9PWZnk83qTxj0sLDp3sv5yjopLmzc
   vLlS/eWtR0Id2wadOBUxoVjXcoKQaxzkSqeiafCy1o329qCy/CKBHginw
   j+AJG2S/bIer9iZnp5vqPVP0DwetyMxh5CpMspwueDSheYO6NTs2W7YbF
   ocY4XxPDAV5awXAwq/tw6gBTi/kJEs24cnTMlybEso4LgYM3NCeZCrPSH
   V6nhAuF/ElSlwK6jwqbtb05K9IBgk7u4jF5RV2+928zDxO6bmxE6IQWwH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="375627309"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="375627309"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:37:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065297207"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="1065297207"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2023 08:37:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWf3W-000CIe-0O;
        Thu, 17 Aug 2023 18:37:02 +0300
Date:   Thu, 17 Aug 2023 18:37:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] bitmap: optimize bitmap_remap()
Message-ID: <ZN4+nZwBu317dVjz@smile.fi.intel.com>
References: <20230815235934.47782-1-yury.norov@gmail.com>
 <ZN3qQPeFtdZQrLE4@smile.fi.intel.com>
 <ZN3qlCd+TcYiZg+s@smile.fi.intel.com>
 <ZN4tB7jkQrX/TKnh@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN4tB7jkQrX/TKnh@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 07:21:59AM -0700, Yury Norov wrote:
> On Thu, Aug 17, 2023 at 12:38:28PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 17, 2023 at 12:37:05PM +0300, Andy Shevchenko wrote:
> > > On Tue, Aug 15, 2023 at 04:59:34PM -0700, Yury Norov wrote:

...

> > > >  		int n = bitmap_pos_to_ord(old, oldbit, nbits);
> > > >  
> > > > +		bit = (n < 0) ? oldbit :	/* identity map */
> > > 
> > > Can't you also optimize this case?
> > > 
> > > Something like
> > > 
> > >   bitmap_xor(tmp, old, new) // maybe even better approach, dunno
> > 
> > >   bitmap_empty(tmp) // can be replaced by find first bit
> > 
> > Or reuse bitmap_weight()...
> 
> That way it wouldn't work,

Why not? AFAIU there are two cases when we may copy:
1) the new mapping is empty;
2) the old == new.

The other cases we need to remap.

The case 2) is easy with xor and weight.

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 24284caadbcc..917eea5219ac 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -958,7 +958,7 @@ EXPORT_SYMBOL(bitmap_parse);
  * gets mapped to (returns) @ord value 3 in this example, that means
  * that bit 7 is the 3rd (starting with 0th) set bit in @buf.
  *
- * The bit positions 0 through @bits are valid positions in @buf.
+ * The bit positions 0 through @nbits are valid positions in @buf.
  */
 static int bitmap_pos_to_ord(const unsigned long *buf, unsigned int pos, unsigned int nbits)
 {
@@ -1008,17 +1008,30 @@ void bitmap_remap(unsigned long *dst, const unsigned long *src,
 
 	if (dst == src)		/* following doesn't handle inplace remaps */
 		return;
-	bitmap_zero(dst, nbits);
+
+	bitmap_xor(dst, old, new, nbits);
+	if (bitmap_empty(dst, nbits))
+		goto identity_map;
 
 	w = bitmap_weight(new, nbits);
+	if (w == 0)
+		goto identity_map;
+
+	bitmap_zero(dst, nbits);
+
 	for_each_set_bit(oldbit, src, nbits) {
 		int n = bitmap_pos_to_ord(old, oldbit, nbits);
 
-		if (n < 0 || w == 0)
+		if (n < 0)
 			set_bit(oldbit, dst);	/* identity map */
 		else
 			set_bit(find_nth_bit(new, nbits, n % w), dst);
 	}
+
+	return;
+
+identity_map:
+	bitmap_copy(dst, src, nbits);
 }
 EXPORT_SYMBOL(bitmap_remap);

But this gives +89 bytes on x86_64... :-(

Inside the loop we can also break when n gets equal to w, but it seems
a special case (we don't need bitmap_weight_from() for that, do we?).

-- 
With Best Regards,
Andy Shevchenko


