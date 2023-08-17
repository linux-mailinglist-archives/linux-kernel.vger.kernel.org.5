Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35F177F3C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349317AbjHQJpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349028AbjHQJp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:45:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF832D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692265526; x=1723801526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tONTTcjsxPEvLTsaDyGq82z/yOeG3FkPZEkL6zLsQ4E=;
  b=DvV4Aoe9ZRsOZ25uRevLNCCmCUtHVN7FGvRDgB9TbWRxG2KnkJ3/9tXL
   PhZaLhDaOD+zS2Ia8qQMWQOHtO6mZ9IbXtcR86WXFjWLpUaNejhGpR0gw
   G/ZD8CyLYlPPK6lPVEo2AU/57mKTDj17rDd3AmXxQPmuok/NLgy+1lWvi
   wMr4eLa6HEu1RLJSSybGkkrObIplp9EnBexdS2MPlV+SGyNuvwa0yb1xy
   kq4BgIvhdP6q5xCTitqjGaZv5rDq7Dq3DhbI1inn4iyR9sa6u94VkU54y
   seoC6X9CvhZ4q7i89s5OFQHSXV+w2o5jezWe3dSIQ8kCSn/seePzOkxBL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376501426"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="376501426"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="684374674"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="684374674"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2023 02:45:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZZD-005ksG-0r;
        Thu, 17 Aug 2023 12:45:23 +0300
Date:   Thu, 17 Aug 2023 12:45:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 3/8] bitmap: fix opencoded bitmap_allocate_region()
Message-ID: <ZN3sMzYHxQyvrKMJ@smile.fi.intel.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
 <20230815233628.45016-4-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815233628.45016-4-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:36:23PM -0700, Yury Norov wrote:
> bitmap_find_region() opencodes bitmap_allocate_region(). Fix it.

...

>  	for (pos = 0; (end = pos + BIT(order)) <= bits; pos = end) {
> -		if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
> -			continue;
> -		__reg_op(bitmap, pos, order, REG_OP_ALLOC);
> -		return pos;
> +		if (!bitmap_allocate_region(bitmap, pos, order))
> +			return pos;

You can also leave more code untouched, by replacing only first conditional
with

		if (bitmap_allocate_region(bitmap, pos, order))
			continue;
		return pos;

>  	}
>  	return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko


