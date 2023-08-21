Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C227827C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjHULTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHULTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:19:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488591;
        Mon, 21 Aug 2023 04:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692616739; x=1724152739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TSJVDwv/g+tlTKwhFF3bM8Xc0o2Jvs5GHJ3YK6/JVDg=;
  b=evi3sEKvvU1PJgGRoJueo/YnahjPP7o987rSRY/zrqLeQAQS6h5mcfFw
   ljQ7ac/m5XTjQN+IDao6+cA84WeL9sfEMVMdD15wvdOVOkt/XqfPaZlBX
   c8zKw/vgSoPIT+9Wk5VQAKXv8cfmKG7J0LqZ/jxk35f/9sqtrPk4LkB7R
   SuZBu63GEPCFiccJF+RnfAnz8ehRA61kK27vnheIEa2zy7oR7il28bO8P
   1ZE8e5RiT9ah9+8KvpNiDnmiKVzsVJOjDrtIxWgM9diybYnuFGpeNTQss
   mgQO6tLmfx+yc6E9z5FRT89EhSHXfGgcOoPXId8W4uGs532w9GxwfTQfF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="437485619"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="437485619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 04:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="729389822"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="729389822"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 21 Aug 2023 04:18:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY2vl-00BQuX-0K;
        Mon, 21 Aug 2023 14:18:45 +0300
Date:   Mon, 21 Aug 2023 14:18:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     qat-linux@intel.com, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH] linux/container_of.h: Add memberof()
Message-ID: <ZONIFMSmLZMeFPOY@smile.fi.intel.com>
References: <ZN8v/2McQboR3dIu@smile.fi.intel.com>
 <20230820195222.279069-1-alx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820195222.279069-1-alx@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 09:52:22PM +0200, Alejandro Colomar wrote:
> On 2023-08-18 10:46, Andy Shevchenko wrote:
> > On Fri, Aug 18, 2023 at 01:28:42PM +0800, Herbert Xu wrote:
> >> On Thu, Aug 17, 2023 at 04:33:17PM +0200, Lucas Segarra Fernandez wrote:

...

> Many xxxof_{member,field}() macros make use of the same construction to
> refer to a member of a struct without needing a variable of the
> structure type.
> 
> memberof(T, m) simplifies all of those, avoids possible mistakes in
> repetition, adds a meaningful name to the construction, and improves
> readability by avoiding too many parentheses together.
> 
> It uses a compound literal, which should optimized out by the compiler.
> It's a bit simpler to read than the dereference of a casted null
> pointer, due to having less parentheses in the implementation.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
> Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
>  include/linux/container_of.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 713890c867be..5e762025c780 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -5,7 +5,9 @@
>  #include <linux/build_bug.h>
>  #include <linux/stddef.h>
>  
> -#define typeof_member(T, m)	typeof(((T*)0)->m)
> +
> +#define memberof(T, member)  ((T){}.member)

I'm not sure. This seems to me utilization of compound literal, while above
uses direct struct member pointer calculations.

> +#define typeof_member(T, m)  typeof(memberof(T, m))

-- 
With Best Regards,
Andy Shevchenko


