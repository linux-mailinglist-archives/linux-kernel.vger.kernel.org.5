Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4977F39A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349736AbjHQJhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242661AbjHQJhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:37:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913DC10E9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692265028; x=1723801028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t3/SPQdJPP8CQBTiozltnkQKxqUKbLueTkLOM6UaZYs=;
  b=Mine5dRf5Qwzg8SDUka5KsQrlhUYMn9yXu9S/Xh6shuah5xp6Iw7N+nG
   /sXRBaC1jsm74ITGVhs4vxwIGGYHLlsrDLrIkXgUNBbsME708TBVx89dO
   e+RhLvBhcmQbHns2s6HZvr7GNaCX7t6EioSgN1phR9Z7nopj3IJ5cE6GF
   AD/Ov5j+STNCzkbu4QMJIOrwXYoV4DmMU2yUltaA3Du66qWRpda1ycS8Y
   U4Mjz9Ul8ZjSaAhF05VCDGfnpAmc7aAYv6LH/HRJHYatHohj6H8+Qy6EN
   uHGn2PY+IzjmJmZbrn149z/k8xPNp7JAKc+hKnxhbFlS4WiwH7pSlmKTD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362912186"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="362912186"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1065176433"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="1065176433"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2023 02:37:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZRB-005TSz-0d;
        Thu, 17 Aug 2023 12:37:05 +0300
Date:   Thu, 17 Aug 2023 12:37:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] bitmap: optimize bitmap_remap()
Message-ID: <ZN3qQPeFtdZQrLE4@smile.fi.intel.com>
References: <20230815235934.47782-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815235934.47782-1-yury.norov@gmail.com>
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

On Tue, Aug 15, 2023 at 04:59:34PM -0700, Yury Norov wrote:
> When 'new' map is empty, i.e. identity mapping, we can simply copy
> src to dst, which is significantly faster than setting bits one by
> one in a for-loop.

> While here, replace set_bit() with non-atomic __set_bit().

I believe this requires a separate change with additional words
why it's okay to drop atomicity.

...

>  	for_each_set_bit(oldbit, src, nbits) {
>  		int n = bitmap_pos_to_ord(old, oldbit, nbits);
>  
> +		bit = (n < 0) ? oldbit :	/* identity map */

Can't you also optimize this case?

Something like

  bitmap_xor(tmp, old, new) // maybe even better approach, dunno
  bitmap_empty(tmp) // can be replaced by find first bit

?

> +				find_nth_bit(new, nbits, n % w);
> +		__set_bit(bit, dst);
>  	}

-- 
With Best Regards,
Andy Shevchenko


